// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// ------------------- W A R N I N G: A U T O - G E N E R A T E D   C O D E !! -------------------//
// PLEASE DO NOT HAND-EDIT THIS FILE. IT HAS BEEN AUTO-GENERATED WITH THE FOLLOWING COMMAND:
//
// util/topgen.py -t hw/top_earlgrey/data/top_earlgrey.hjson \
//                -o hw/top_earlgrey/ \
//                --rnd_cnst_seed 4881560218908238235


package top_earlgrey_rnd_cnst_pkg;

  ////////////////////////////////////////////
  // otp_ctrl
  ////////////////////////////////////////////
  // Compile-time random bits for initial LFSR seed
  parameter otp_ctrl_pkg::lfsr_seed_t RndCnstOtpCtrlLfsrSeed = {
    40'h54_A6FD3CC6
  };

  // Compile-time random permutation for LFSR output
  parameter otp_ctrl_pkg::lfsr_perm_t RndCnstOtpCtrlLfsrPerm = {
    240'h6843_A62898A5_3141E719_791E0D33_4F712758_2E07D104_56D58636_48580402
  };

  // Compile-time random permutation for scrambling key/nonce register reset value
  parameter otp_ctrl_pkg::scrmbl_key_init_t RndCnstOtpCtrlScrmblKeyInit = {
    256'h29AD3B68_1D319EBC_11251CCB_490123EA_7A66AA52_A30C531B_482A951C_94E4C0B0
  };

  ////////////////////////////////////////////
  // lc_ctrl
  ////////////////////////////////////////////
  // Compile-time random bits for lc state group diversification value
  parameter lc_ctrl_pkg::lc_keymgr_div_t RndCnstLcCtrlLcKeymgrDivInvalid = {
    128'h9872BB00_6BE02115_9CB7BEFA_53F764B7
  };

  // Compile-time random bits for lc state group diversification value
  parameter lc_ctrl_pkg::lc_keymgr_div_t RndCnstLcCtrlLcKeymgrDivTestDevRma = {
    128'h9D46DFF2_A1872B40_BFD52F7C_D63C7907
  };

  // Compile-time random bits for lc state group diversification value
  parameter lc_ctrl_pkg::lc_keymgr_div_t RndCnstLcCtrlLcKeymgrDivProduction = {
    128'h6E2EB8DA_CEFBED3B_7DA4B03D_06E01445
  };

  // Compile-time random bits used for invalid tokens in the token mux
  parameter lc_ctrl_pkg::lc_token_mux_t RndCnstLcCtrlInvalidTokens = {
    256'h21FF2CDC_BC18C7F5_55BA67DD_803A84F5_7ABD4DF4_A4356949_B5E6CE6D_E922CEE9,
    256'h85D0AC39_922BA925_41AEF785_CA0A2E16_B4A05E64_35A23451_60FB417E_FB26D64C,
    256'hD1D9BA62_36155278_875E1F9C_FDED1CE5_D21D7E8E_15AC6A2C_B01194B9_725F474D,
    256'h948CB7BE_D9913A9E_42002072_4C52FE42_B2C910F6_BF8309BE_C0D96987_2AF1F3DD
  };

  ////////////////////////////////////////////
  // alert_handler
  ////////////////////////////////////////////
  // Compile-time random bits for initial LFSR seed
  parameter alert_pkg::lfsr_seed_t RndCnstAlertHandlerLfsrSeed = {
    32'h31339044
  };

  // Compile-time random permutation for LFSR output
  parameter alert_pkg::lfsr_perm_t RndCnstAlertHandlerLfsrPerm = {
    160'hC4DF2F2D_BA30064B_C599DFD3_6A878E44_29D29D42
  };

  ////////////////////////////////////////////
  // sram_ctrl_ret_aon
  ////////////////////////////////////////////
  // Compile-time random reset value for SRAM scrambling key.
  parameter otp_ctrl_pkg::sram_key_t RndCnstSramCtrlRetAonSramKey = {
    128'h8A73E709_581B1320_EC47A3BC_D9C78D34
  };

  // Compile-time random reset value for SRAM scrambling nonce.
  parameter otp_ctrl_pkg::sram_nonce_t RndCnstSramCtrlRetAonSramNonce = {
    128'hB5B13865_AA34C97C_F0E74F2F_E4A28D1F
  };

  // Compile-time random bits for initial LFSR seed
  parameter sram_ctrl_pkg::lfsr_seed_t RndCnstSramCtrlRetAonLfsrSeed = {
    32'h05C01C07
  };

  // Compile-time random permutation for LFSR output
  parameter sram_ctrl_pkg::lfsr_perm_t RndCnstSramCtrlRetAonLfsrPerm = {
    160'h26862725_F1F291BC_7DA6874F_CBCE4C28_036AAF34
  };

  ////////////////////////////////////////////
  // flash_ctrl
  ////////////////////////////////////////////
  // Compile-time random bits for default address key
  parameter flash_ctrl_pkg::flash_key_t RndCnstFlashCtrlAddrKey = {
    128'h8E20EA42_4AEB5CFA_5F80621A_DB10471B
  };

  // Compile-time random bits for default data key
  parameter flash_ctrl_pkg::flash_key_t RndCnstFlashCtrlDataKey = {
    128'hED630592_09A7A17C_2FDDDD4B_17AE7792
  };

  // Compile-time random bits for default seeds
  parameter flash_ctrl_pkg::all_seeds_t RndCnstFlashCtrlAllSeeds = {
    256'h654D3DB5_362B0F89_5C5A679D_501E6CB7_0F11ECFF_0164FD35_0526FA1B_E84B746A,
    256'hB99B6B97_E9220325_5A5DD7F2_C2741446_8F9E8E01_2F01D5CE_B455EFC0_4F5CAD14
  };

  // Compile-time random bits for initial LFSR seed
  parameter flash_ctrl_pkg::lfsr_seed_t RndCnstFlashCtrlLfsrSeed = {
    32'h9EF419BD
  };

  // Compile-time random permutation for LFSR output
  parameter flash_ctrl_pkg::lfsr_perm_t RndCnstFlashCtrlLfsrPerm = {
    160'hDD24C558_D747E279_E1A37F41_A092BE4A_E05CF04E
  };

  ////////////////////////////////////////////
  // aes
  ////////////////////////////////////////////
  // Default seed of the PRNG used for register clearing.
  parameter aes_pkg::clearing_lfsr_seed_t RndCnstAesClearingLfsrSeed = {
    64'hDF0F0B33_040DEDE3
  };

  // Permutation applied to the LFSR of the PRNG used for clearing.
  parameter aes_pkg::clearing_lfsr_perm_t RndCnstAesClearingLfsrPerm = {
    128'h32CB698B_69E0E31F_A51D5D03_63D486A8,
    256'h42012F97_C5DD4E8F_28DC8ECE_B87576E2_7FA136DA_723ED0F2_45C0BDE0_915999B0
  };

  // Permutation applied to the clearing PRNG output for clearing the second share of registers.
  parameter aes_pkg::clearing_lfsr_perm_t RndCnstAesClearingSharePerm = {
    128'hD20190B8_B6D4E59B_08724449_A3DEDA00,
    256'h5483A617_CD1C4613_C3F5BE9A_538ADC15_7CD6AC8F_338EA3C5_ED970ADA_DDBE78B3
  };

  // Default seed of the PRNG used for masking.
  parameter aes_pkg::masking_lfsr_seed_t RndCnstAesMaskingLfsrSeed = {
    160'h5E9F61B1_D0575C0B_E8253666_67E6B497_E236B055
  };

  // Permutation applied to the concatenated LFSRs of the PRNG used for masking.
  parameter aes_pkg::masking_lfsr_perm_t RndCnstAesMaskingLfsrPerm = {
    256'h2F5F3987_3C9E9289_718B844E_7C2C9304_1F5D5A66_0B474322_99947948_5119646E,
    256'h052E2B4D_8E6F2911_4A6D3555_9690672A_282D627D_7F549F0C_335C8013_3768268C,
    256'h613B8569_50251C63_36408330_23865388_78744F06_31764656_16189870_32455E34,
    256'h070F9B97_655B426A_3D1E129D_03440015_179A028F_753F1B0D_4C246072_090A1A59,
    256'h388A5808_527A6B77_1D4B7B10_3A273E49_8D9C2073_4182216C_9514910E_7E018157
  };

  ////////////////////////////////////////////
  // kmac
  ////////////////////////////////////////////
  // Compile-time random data for LFSR default seed
  parameter kmac_pkg::lfsr_seed_t RndCnstKmacLfsrSeed = {
    32'h1AB53A4C,
    256'hAB06C7D1_C7BD700F_5A65380B_6E10959F_AEDD1280_496BE17A_DB96B3F0_DA566E13,
    256'hC64EA771_1F59488D_7EF08C31_20616CDA_535AD08B_566E4C96_C8FC8284_49DDDFAB,
    256'h65E573AE_612B2D25_8E51A6E2_7A3DCCBF_D5357F0D_01AF3BCB_1FA3E78B_76160673
  };

  // Compile-time random permutation for LFSR output
  parameter kmac_pkg::lfsr_perm_t RndCnstKmacLfsrPerm = {
    64'h4AD2A0D0_C6294274,
    256'hDAC63D31_702894B7_09FB2E29_45CBF780_1A7399A9_3A633630_04304E78_59D5B4C8,
    256'h89673112_39079852_6B11B509_1140D0B4_5E91F29E_9EE24879_B37C1958_584AB596,
    256'hB0658F4F_6FC0EC39_202EA368_AA6B8168_49E36409_D192E06C_940456CF_5E053054,
    256'hE429C099_91F17EF0_56FAE900_D249005A_626069A4_063A8C21_05E8A8DF_8221D8C1,
    256'hA56549DC_35A78C2C_E7B31C33_1C951843_8402E7C1_CF6329E6_A65ABA38_0490E386,
    256'hE5D32D61_C3C08E24_94C2D99B_6B26D8A8_DF57CAF6_09CA961D_5A615C8A_2AA2C211,
    256'h5EA216D6_D27F18B2_B82C074E_E118727B_2CA7B8A3_9D303C34_9918C491_DEC3B4D0,
    256'hB55F109B_91A9BE50_C6B02C49_2716D671_E20740AD_81520AA4_B1960686_53EA0101,
    256'hE46A057B_7538AE4F_B8FAADAA_5F46FDA6_666F32EC_02AF7085_2C7B2096_238AA486,
    256'h060678A1_BC1940D6_B32A70A5_C4C0A7E5_93FC2A50_96917946_BE4B351F_134F09EB,
    256'h008504C6_64DC4DAE_2F84A483_3554A80E_9567E853_2CA68F4C_49DA8D97_42373D1E,
    256'hAC48B164_6C381D47_DC5597D8_36B62F4E_DFD08939_A0CCD1B4_6EAD9A5C_509CC554,
    256'hD480D2B9_25A8DEAC_96ECD89D_6142A35B_A2A7956C_44D6B539_A77B094E_97B040C6,
    256'h517CEB0B_B6FEA4D1_18FE625D_9ED34462_A26E21F5_884C86F5_BE520AD6_63EA1741,
    256'hEF69D504_16130000_438AF1E6_F1DA41A0_9474F97D_69477484_1C4D4928_6A366908,
    256'hE9C68C70_93946711_EF794E44_B966C9F9_6834EE16_DCB85C2E_6692FA5F_DD60B696,
    256'h80201230_D736D862_F53457AD_B3A1DE14_57B5D012_053167AC_980F5216_441C1323,
    256'h6950CF25_979B5526_2F94461F_1D545485_511982CB_43755584_C652AC90_9F20F096,
    256'h821D40C9_208FAA03_F6C5C780_A8C4CD49_7EAA28F0_483B64FC_704B2A19_8B41EA5F,
    256'h489899DB_6C2DF726_7D925E22_E8B7ADD6_C9829D83_02072C17_6A92F9A9_583721A8,
    256'h74377408_D170F250_E8F5B818_3BD5D289_E5BFEA69_0523315C_56131B1C_E2DAEC0F,
    256'h59197569_C23AD2C1_A18A736B_A43C326D_92837A0E_47DB8935_416BE044_96464C6D,
    256'hE680810A_03C039D2_B390E766_9C638932_B619B8CB_90164C7F_D1854145_7DA671D8,
    256'hF54BA618_6C5677DE_F6F5C18B_A728C042_B2510A68_4FBAD5B2_5D3AABC8_630CE9AF,
    256'hAC14B4CE_5FB0CA06_A126CF10_99A95D45_F1A4FC43_572856EC_8527FC7E_BF916051,
    256'h16808D25_79C0529C_401880BC_9AD73634_36701653_FA8B5641_F02E97B1_42492EA5,
    256'hA1233331_56712FB3_0429BD1A_7B656AA6_EB445A5C_1D2F20CC_8A1ACB25_8DF21F87,
    256'hA6853FBB_830BC6AE_88EBC88B_184FAFD7_5D9C4507_048996B6_8EC21E66_44CB18CB,
    256'h0FA283E9_E8F72900_8AAD1C60_18C0BD08_AC91B822_1F6EA104_0C11BBDF_999691A2,
    256'h1D16D0F8_449A3BD4_A09E6C73_8C070864_206CE154_CAC5F23B_3CD93C05_CC7F87F1,
    256'h76474147_983501C3_99204160_A1E2C3F5_7779CC9B_22D70350_9721BB68_83A9A02E
  };

  // Compile-time random permutation for forwarding LFSR state
  parameter kmac_pkg::lfsr_fwd_perm_t RndCnstKmacLfsrFwdPerm = {
    160'hBE8FEE2A_A8DD8927_95C18F4C_99C06CCE_280F89AB
  };

  // Compile-time random permutation for LFSR Message output
  parameter kmac_pkg::msg_perm_t RndCnstKmacMsgPerm = {
    128'h75A17C86_B2B45EA0_B0569B81_D797BFF7,
    256'h6E031929_71C9B37A_B0EFA232_F8001E64_5C2ED656_9D44188C_9A24DCFC_D321FEC4
  };

  ////////////////////////////////////////////
  // otbn
  ////////////////////////////////////////////
  // Default seed of the PRNG used for URND.
  parameter otbn_pkg::urnd_prng_seed_t RndCnstOtbnUrndPrngSeed = {
    256'h10412112_FF4F40D4_A0678A33_56D66C6C_3D48480F_5316D29E_9D86CADE_4215D0ED
  };

  // Compile-time random reset value for IMem/DMem scrambling key.
  parameter otp_ctrl_pkg::otbn_key_t RndCnstOtbnOtbnKey = {
    128'hE6C939A5_0FBF7354_F2D5AF22_7F42525F
  };

  // Compile-time random reset value for IMem/DMem scrambling nonce.
  parameter otp_ctrl_pkg::otbn_nonce_t RndCnstOtbnOtbnNonce = {
    64'h11999B24_CFAC7CFA
  };

  ////////////////////////////////////////////
  // keymgr
  ////////////////////////////////////////////
  // Compile-time random bits for initial LFSR seed
  parameter keymgr_pkg::lfsr_seed_t RndCnstKeymgrLfsrSeed = {
    64'h91BC9A99_7F866251
  };

  // Compile-time random permutation for LFSR output
  parameter keymgr_pkg::lfsr_perm_t RndCnstKeymgrLfsrPerm = {
    128'h1EDD11AA_5A7281A0_9EC6252B_74048860,
    256'h3A2793B3_0418A157_8FF40D6F_75707CF4_D9B3E27D_061BF8EA_E9B92DCD_B55B3F0E
  };

  // Compile-time random permutation for entropy used in share overriding
  parameter keymgr_pkg::rand_perm_t RndCnstKeymgrRandPerm = {
    160'hBA341539_92A8165E_913CB1E9_ECBE0D88_CC2DCFF8
  };

  // Compile-time random bits for revision seed
  parameter keymgr_pkg::seed_t RndCnstKeymgrRevisionSeed = {
    256'h4B2C3731_37FA0DD9_01E41352_84653755_F50C1548_CA2E2ECD_1D2C52A3_5214BA8D
  };

  // Compile-time random bits for creator identity seed
  parameter keymgr_pkg::seed_t RndCnstKeymgrCreatorIdentitySeed = {
    256'hF6060A4A_D7D1012A_C1DF42C8_68592027_2FEBC72C_BD6C2F82_F820E670_A369A1FB
  };

  // Compile-time random bits for owner intermediate identity seed
  parameter keymgr_pkg::seed_t RndCnstKeymgrOwnerIntIdentitySeed = {
    256'h323038A1_7DF72991_A1F65445_44548FFB_066FD698_A6EEE20D_6CC24324_F7D43DD9
  };

  // Compile-time random bits for owner identity seed
  parameter keymgr_pkg::seed_t RndCnstKeymgrOwnerIdentitySeed = {
    256'h15E8CBE4_D1D62F14_96B6BA63_C60710D3_D7DBADAA_FAB158BC_E619683F_2DB95E17
  };

  // Compile-time random bits for software generation seed
  parameter keymgr_pkg::seed_t RndCnstKeymgrSoftOutputSeed = {
    256'h02BD2802_21995E31_5A3B2A6C_255F0E0C_0B3DDDCC_6650F25A_C153F98E_8F01E593
  };

  // Compile-time random bits for hardware generation seed
  parameter keymgr_pkg::seed_t RndCnstKeymgrHardOutputSeed = {
    256'hCEED9871_B8826237_8E80CECB_96A9AAD3_3D75B71D_CFAD19BD_99D5FFE4_FE220F4B
  };

  // Compile-time random bits for generation seed when aes destination selected
  parameter keymgr_pkg::seed_t RndCnstKeymgrAesSeed = {
    256'h2439FB09_1839C8C4_D520652D_F0B10915_E77E10DA_B8343EEF_048D26DD_851BE21F
  };

  // Compile-time random bits for generation seed when kmac destination selected
  parameter keymgr_pkg::seed_t RndCnstKeymgrKmacSeed = {
    256'h8769A54A_75EFD1FE_6F36A0CD_92AD4EC5_B5E0CCB7_00DF2CF6_07DA6AF4_3165EEC2
  };

  // Compile-time random bits for generation seed when otbn destination selected
  parameter keymgr_pkg::seed_t RndCnstKeymgrOtbnSeed = {
    256'hEF1C5E72_D7A59426_213C2860_7150D6D8_B8A06515_29C66523_8C7C3579_4AEBA215
  };

  // Compile-time random bits for generation seed when no CDI is selected
  parameter keymgr_pkg::seed_t RndCnstKeymgrCdi = {
    256'hDA3C1663_A7CCB4F4_FDE201E3_FB5E8609_6CADE14D_03A5F9F3_2732D03C_75FD5667
  };

  // Compile-time random bits for generation seed when no destination selected
  parameter keymgr_pkg::seed_t RndCnstKeymgrNoneSeed = {
    256'h5F569C42_5B49ABF7_70DF29AE_69264E3B_6572706D_251259B0_161FC7CB_B559D2FF
  };

  ////////////////////////////////////////////
  // csrng
  ////////////////////////////////////////////
  // Compile-time random bits for csrng state group diversification value
  parameter csrng_pkg::cs_keymgr_div_t RndCnstCsrngCsKeymgrDivNonProduction = {
    128'h9C82AEDF_1F49A9E3_4D7F215E_9AE2ACF5,
    256'h636B28F0_6F2FBFD4_78BC341B_70AE80C1_6C39AEE8_20E1656D_BC7326EB_3585B8AA
  };

  // Compile-time random bits for csrng state group diversification value
  parameter csrng_pkg::cs_keymgr_div_t RndCnstCsrngCsKeymgrDivProduction = {
    128'hFFCA5669_6282A5B5_2C7BA005_7C34237D,
    256'h7F048C1B_BB9BBAFA_79BA4258_4FE1305F_E5FCE79B_C086EAFC_6C8DA10E_80F067BF
  };

  ////////////////////////////////////////////
  // sram_ctrl_main
  ////////////////////////////////////////////
  // Compile-time random reset value for SRAM scrambling key.
  parameter otp_ctrl_pkg::sram_key_t RndCnstSramCtrlMainSramKey = {
    128'hE71752D7_F8339AE5_B43472FE_07628B8C
  };

  // Compile-time random reset value for SRAM scrambling nonce.
  parameter otp_ctrl_pkg::sram_nonce_t RndCnstSramCtrlMainSramNonce = {
    128'h9DCB522A_E009B420_B77E908D_8B4AA63C
  };

  // Compile-time random bits for initial LFSR seed
  parameter sram_ctrl_pkg::lfsr_seed_t RndCnstSramCtrlMainLfsrSeed = {
    32'hC5A58C9C
  };

  // Compile-time random permutation for LFSR output
  parameter sram_ctrl_pkg::lfsr_perm_t RndCnstSramCtrlMainLfsrPerm = {
    160'hD7FC6402_8DD88334_8FB0C5ED_1CB1D551_F8F59492
  };

  ////////////////////////////////////////////
  // rom_ctrl
  ////////////////////////////////////////////
  // Fixed nonce used for address / data scrambling
  parameter bit [63:0] RndCnstRomCtrlScrNonce = {
    64'h9BF1887B_AD1066FB
  };

  // Randomised constant used as a scrambling key for ROM data
  parameter bit [127:0] RndCnstRomCtrlScrKey = {
    128'h6F346A5B_07F00B2D_0292BDD7_6F684AF6
  };

  ////////////////////////////////////////////
  // rv_core_ibex
  ////////////////////////////////////////////
  // Default seed of the PRNG used for random instructions.
  parameter ibex_pkg::lfsr_seed_t RndCnstRvCoreIbexLfsrSeed = {
    32'hA9E6D213
  };

  // Permutation applied to the LFSR of the PRNG used for random instructions.
  parameter ibex_pkg::lfsr_perm_t RndCnstRvCoreIbexLfsrPerm = {
    160'h61A11C0D_2BBEB9FD_BAA70954_F9FA4D40_09DB5059
  };

  // Default icache scrambling key
  parameter logic [ibex_pkg::SCRAMBLE_KEY_W-1:0] RndCnstRvCoreIbexIbexKeyDefault = {
    128'hE5BC16A1_0D5AC301_89C436B5_52ECCE2D
  };

  // Default icache scrambling nonce
  parameter logic [ibex_pkg::SCRAMBLE_NONCE_W-1:0] RndCnstRvCoreIbexIbexNonceDefault = {
    64'h6AC12A96_7CD37683
  };

endpackage : top_earlgrey_rnd_cnst_pkg
