# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
"""Generating random variables by using a cryptographically strong PRNG.

A class for generating random numbers and permutations.
This class is based on a cryptographically secure PRNG fitting into DRG3
requirements of BSI's AIS-31.
This class guarentees forward and backward secrecy (PRNG output cannot be
computed from any previous or future outpus) as well as enhanced backward
secrecy (previous PRNG outputs cannot be computed from a compromised
internal state).
The PRNG consists of the 256-bit internal state, a one-way state-update
function and a one-way output functions.
One-way functions are implemented using Matyas-Meyer-Oseas compression
function with AES-128 as the building block.
"""

import logging as log
import sys
from Crypto.Cipher import AES
from math import ceil as _ceil
from math import log as _log


class drg3():

    blocklen = 128
    keylen = 128
    seedlen = 256  # blocklen + keylen
    ctr_len = 128  # blocklen
    security_strength = 128
    min_length = 128  # security_strength
    outlen = 128 // 8

    # Maximal number of requests before reseed is required
    RESEED_MAX = 2 ** 48

    def __init__(self):
        """Initialize an instance.

        Default state value is 0.
        """

        # A 128 bit PRNG output
        self.returned_bits = []

        # CTR_DRBG Internal state as defined in NIST SP 800-90A, page 50
        # The state consists of:
        #     - The value V of 128 bits
        #     - The value Key of 128 bits
        #     -Reseed counter
        # Administrative information such as security_strength and
        # prediction_resistance_flag are missing in this implementation
        # because they are not used by the application.
        self.V = 0
        self.Key = 0
        self.reseed_counter = 1

        self.CTR_DRBG_Update(0, 0)

    def CTR_DRBG_Update(self, provided_data_0, provided_data_1):
        """The update function

        CTR_DRBG_Update process
        Described in NIST SP 800-90A, page 51
        For convenience, input provided_data is devided in two 128 bit chunks.
        """
        cipher = AES.new(self.Key.to_bytes(16, 'big'), AES.MODE_ECB)

        # Steps 1 and 2
        # Loop in step 2 consists of only 2 iterations, it is unrolled here
        # Note ctr_len = blocklen = 128, Therefore we don't go through steps
        # 2.1.1. and 2.1.2
        pt0 = self.V + 1
        pt1 = self.V + 2
        ct0 = cipher.encrypt(pt0.to_bytes(16, 'big'))
        ct1 = cipher.encrypt(pt1.to_bytes(16, 'big'))

        # Steps 3, 4, 5, 6 and 7
        self.Key = int.from_bytes(ct0, 'big') ^ provided_data_0
        self.V = int.from_bytes(ct1, 'big') ^ provided_data_1
        del (cipher)

    def CTR_DRBG_Generate(self):
        """CTR_DRBG_Generate

        CTR_DRBG_Generate process as defined in NIST SP 800-90A, page 55
        Section 10.2.1.5.1
        requested_number_of_bits is fixed to 128.
        additional_input is not provided.
        Output status is not provided. In case of a failure, the function will
        error out.
        """

        # Step 1
        if self.reseed_counter > self.RESEED_MAX:
            log.error("Reseed required")
            sys.exit(1)

        # Step 2 is not executed because additional_input = 0

        # Because requested_number_of_bits = blocklen = 128, the loop in Step 4
        # has exactly one iteration.
        # Because ctr_len = blocklen, steps 4.1.1 and 4.1.2 are not executed

        # Step 4.1
        self.V += 1
        # Steps 4.2 and 4.3
        cipher = AES.new(self.Key.to_bytes(16, 'big'), AES.MODE_ECB)
        pt = self.V
        ct = cipher.encrypt(pt.to_bytes(16, 'big'))
        del (cipher)

        # Step 5
        self.returned_bits = list(ct)

        # Step 6 additional_input = 0
        self.CTR_DRBG_Update(0, 0)

        # Step 7
        self.reseed_counter += 1

    def BCC(self, K, input_block):
        assert len(K) == 16, "Key length should be 16 bytes"
        assert len(input_block) % 16 == 0, "Input Block should be a multiple of 16 bytes"

        n = len(input_block) // self.outlen

        # Initialize the chaining value with 0s
        chaining_value = bytearray(16)
        cipher = AES.new(K, AES.MODE_ECB)
        block = bytearray(16)

        for i in range(n):
            block = bytearray(chaining_value[j] ^ input_block[16 * i + j] for j in range(16))
            chaining_value = cipher.encrypt(block)

        del (cipher)
        return chaining_value

    def Block_Cipher_df(self, input_string):
        # Length of the input_string in bytes. Should be always 16.
        L_int = 16
        L = L_int.to_bytes(4, 'big')
        # Number of bytes to return. Should be always 32.
        N_int = 32
        N = N_int.to_bytes(4, 'big')

        # String S needs to be padded to a lenght that is a multiple of 16
        padding = bytearray(8)
        padding[0] = 0x80
        S = L + N + input_string + padding

        # Step 8 of Block_Cipher_df Process
        K = bytearray(i for i in range(16))

        # Step 9 of Block_Cipher_df Process contains a while loop.
        # This loop is executed exactly twice in our use case. so it is unrolled here.

        i0 = 0
        IV0 = i0.to_bytes(4, 'big') + bytearray(12)
        i1 = 1
        IV1 = i1.to_bytes(4, 'big') + bytearray(12)

        temp0 = self.BCC(K, IV0 + S)
        temp1 = self.BCC(K, IV1 + S)

        # Step 10
        K = temp0
        # Step 11
        X = temp1

        cipher = AES.new(K, AES.MODE_ECB)
        X = cipher.encrypt(X)
        temp0 = X
        temp1 = cipher.encrypt(X)

        requested_bits = temp0 + temp1
        del (cipher)

        return requested_bits

    def CTR_DRBG_Instantiate(self, entropy_input):
        """ CTR_DRBG_Instantiate

        CTR_DRBG Instantiate process, described in NIST SP 800-90A, page 53
        Section 10.2.1.3.2 Instantiation When a Derivation Function is used
        entropy_input 128 bits
        Nonce is not provided because our application requires the same random
        numbers when DRBG is instantiated with the same entropy input. This is
        where this implementation deviates from CTR_DRBG specification. We can
        comply to the specification if we switch to using 256-bit entropy input
        because in that case nonce wouldn't be required.
        Optianal security_strength parameter is not provided.
        """

        # Steps 1 and 2. Nonce and personalization strings are empty
        seed_material = self.Block_Cipher_df(entropy_input)
        # Step 3
        self.Key = 0
        # Step 4
        self.V = 0
        # Step 5
        L = int.from_bytes(seed_material[0:16], 'big')
        R = int.from_bytes(seed_material[16:32], 'big')
        self.CTR_DRBG_Update(L, R)
        # Step 6
        self.reseed_counter = 1

    def reseed(self, seed):
        """Re-seed PRNG

        Instantiate CTR_DRBG with a 128-bit entropy_input.
        Empty returned_bits list in case that it contains residual numbers
        from previous instantiation.
        """
        entropy_input = seed.to_bytes(16, 'big')
        self.CTR_DRBG_Instantiate(entropy_input)
        self.returned_bits = []

    def fetchbyte(self):
        """Fetches the next byte from the returned_bits.

        Used by getrandbits().
        If the returned_bits are consumed, requests fresh 128 bits from CTR_DRBG
        """

        if not self.returned_bits:
            self.CTR_DRBG_Generate()

        return self.returned_bits.pop(0)

    def getrandbits(self, n_bits):
        """Fetches n_bits next bits from a PRNG.

        """

        bitsleft = n_bits
        R = 0
        while (bitsleft > 0):
            random_byte = int(self.fetchbyte())
            if (bitsleft > 8):
                R = (R << 8) | random_byte
                bitsleft = bitsleft - 8
            else:
                random_byte >>= 8 - bitsleft
                R = (R << bitsleft) | random_byte
                bitsleft = 0
        assert R >= 0
        return (R)

    def randbelow(self, n):
        """Generates a random integer smaller than n.

        Uses getrandbits() to generate enough random bits. Repeats until the
        resulting number is smaller than n. The probability of this is more
        than 50% in each loop iteration.
        The amount of consumed randomness is not fixed.
        """
        length_bits = _ceil(_log(n, 2))
        R = self.getrandbits(length_bits)
        while R >= n:
            R = self.getrandbits(length_bits)
        return (R)

    def shuffle(self, x):
        """Shuffles a list x.

        Uses the Fisher-Yates algorithm.
        Each possible permutation of x is generated with equal probability.
        """

        length_list = len(x)
        for i in reversed(range(length_list)):
            j = self.randbelow(i + 1)
            x[i], x[j] = x[j], x[i]

    def choice(self, x):
        """Randomly chooses an element from a list x.

        Uses randbelow() to select an integer smaller than len(x) and returns
        the corresponding element.
        """

        i = self.randbelow(len(x))
        return (x[i])


# ----------------------------------------------------------------------
# Create one instance, and export its methods as module-level functions.
# The functions share state across all uses.

_inst = drg3()
reseed = _inst.reseed
BCC = _inst.BCC
fetchbyte = _inst.fetchbyte
getrandbits = _inst.getrandbits
randbelow = _inst.randbelow
shuffle = _inst.shuffle
choice = _inst.choice
