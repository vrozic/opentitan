# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

import logging as log
import random
import secrets
import sys


class fault_injection():


    def __init__(self):
        self.Sbox = [
        0xc, 0x5, 0x6, 0xb,
        0x9, 0x0, 0xa, 0xd,
        0x3, 0xe, 0xf, 0x8,
        0x4, 0x7, 0x1, 0x2
        ]
        self.Sbox_inv = [self.Sbox.index(x) for x in range(16)]
        seed = secrets.randbits(64)
        random.seed(seed)

    def padded_hex(self, c, length):
        """Convert integer to a hexadecimal string with leading zeros."""
        payload = hex(c)[2:]
        padding = '0' * (length - len(payload))
        return '0x' + padding + payload

    def ecc_encode(self, data_i):
        data_int = data_i
        bit32 = bin(int('0x2606BD25', 16) & data_int).count('1') % 2
        bit33 = bin(int('0xDEBA8050', 16) & data_int).count('1') % 2
        bit34 = bin(int('0x413D89AA', 16) & data_int).count('1') % 2
        bit35 = bin(int('0x31234ED1', 16) & data_int).count('1') % 2
        bit36 = bin(int('0xC2C1323B', 16) & data_int).count('1') % 2
        bit37 = bin(int('0x2DCC624C', 16) & data_int).count('1') % 2
        bit38 = bin(int('0x98505586', 16) & data_int).count('1') % 2
        syndrome = bit32 | (bit33 << 1) | (bit34 << 2) | (bit35 << 3) | \
            (bit36 << 4) | (bit37 << 5) | (bit38 << 6)
        data_o = (syndrome << 32) | data_int
        return data_o

    def ecc_verify(self, data_i):
        data_word = data_i % (1 << 32)
        data_expected = self.ecc_encode(data_word)
        return data_i == data_expected

    def check_random_word(self, N):
        correct = 0
        for _ in range(N):
            random_number = self.padded_hex(random.getrandbits(39), 10)
            if self.ecc_verify(random_number):
                correct += 1
        return correct

    def s_box_layer(self, word, direction = 'ENCODE'):
        word_out = (word >> 36) << 36
        for i in range(9):
            mask = 15 << (i * 4)
            s_in = (word & mask) >> (i * 4)
            if direction == 'ENCODE':
                s_out = self.Sbox[s_in]
            else:
                s_out = self.Sbox_inv[s_in]
            word_out |= s_out << (i * 4)
        return word_out

    def flip_vector(self, word):
        temp = word
        word_out = 0
        for _ in range(39):
            bit = temp % 2
            temp >>= 1
            word_out <<= 1
            word_out ^= bit
        return word_out

    def perm_layer(self, word, direction = 'ENCODE'):
        word_out = word & (1 << 38)
        for i in range(19):
            if direction == 'ENCODE':
                bit = (word >> (i * 2)) % 2
                bit <<= i
                word_out |= bit
                bit = (word >> (i * 2 + 1)) % 2
                bit <<= i + 19
                word_out |= bit
            else:
                bit = (word >> i) % 2
                bit <<= i * 2
                word_out |= bit
                bit = (word >> (i + 19)) % 2
                bit <<= i * 2 + 1
                word_out |= bit
        return(word_out)

    def snp(self, data_i, direction = 'ENCODE'):
        state = data_i
        for _ in range(2):
            if direction == 'ENCODE':
                state = self.s_box_layer(state)
                state = self.flip_vector(state)
                state = self.perm_layer(state)
            else:
                state = self.perm_layer(state, 'DECODE')
                state = self.flip_vector(state)
                state = self.s_box_layer(state, 'DECODE')
        return state

    def check_1b_flip(self, bit_position, N):
        correct = 0
        for i in range(N):
            data_word = random.getrandbits(32)
            encoded_word = self.ecc_encode(data_word)
            key = random.getrandbits(39)
            ciphertext = key ^ encoded_word
            storred_word = self.snp(ciphertext)
            corrupted_word = storred_word ^ (1 << bit_position)
            decrypted_word = self.snp(corrupted_word, 'DECODE') ^ key
            if self.ecc_verify(decrypted_word):
                correct += 1
        return correct

    def check_flips(self, N):
        hits = []
        for i in range(39):
            print(i)
            hits_per_position = self.check_1b_flip(i, N)
            hits.append(hits_per_position)
        return hits

    def check_random_flip(self, N):
        correct = 0
        for i in range(N):
            data_word = random.getrandbits(32)
            encoded_word = self.ecc_encode(data_word)
            key = random.getrandbits(39)
            ciphertext = key ^ encoded_word
            storred_word = self.snp(ciphertext)
            fault = random.getrandbits(39)
            corrupted_word = storred_word ^ fault
            decrypted_word = self.snp(corrupted_word, 'DECODE') ^ key
            if self.ecc_verify(decrypted_word):
                correct += 1
        return correct

    def find_patterns(self, bit_position, N):
        patterns = []
        for i in range(N):
            data_word = random.getrandbits(32)
            encoded_word = self.ecc_encode(data_word)
            key = random.getrandbits(39)
            ciphertext = key ^ encoded_word
            storred_word = self.snp(ciphertext)
            corrupted_word = storred_word ^ (1 << bit_position)
            decrypted_word = self.snp(corrupted_word, 'DECODE') ^ key
            if self.ecc_verify(decrypted_word):
                decoded_word = decrypted_word % (1 << 32)
                pattern = data_word ^ decoded_word
                patterns.append(pattern)
        return set(patterns)


# ----------------------------------------------------------------------
# Create one instance, and export its methods as module-level functions.
# The functions share state across all uses.

_inst = fault_injection()
padded_hex = _inst.padded_hex
ecc_encode = _inst.ecc_encode
ecc_verify = _inst.ecc_verify
check_random_word = _inst.check_random_word
s_box_layer = _inst.s_box_layer
flip_vector = _inst.flip_vector
perm_layer = _inst.perm_layer
snp = _inst.snp
check_1b_flip = _inst.check_1b_flip
check_flips = _inst.check_flips
check_random_flip = _inst.check_random_flip
find_patterns = _inst.find_patterns
