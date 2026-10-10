/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_cbb0697de4c5728.gsc
************************************************/

#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_e2785bb1da360f91;

function function_3b59b4d385a202e6() {
  level.var_fb690b0442393f26 = [];
  level.var_7546f688873b4ce4 = [];
  level.var_15f270e2898482be = [];
  level.var_d83ca3f3bdf5b3d4 = [];
  level.var_a3d1147a42b2fd91 = [];
  level.var_8507c1fda79a21e3 = [];
  level.var_1c6c766b95b77e8a = [];
  level._effect["youveBeenNaughty_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_naughty_limb");
  level._effect["youveBeenNaughty_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_naughty_torso");
  level._effect["youveBeenNaughty_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_naughty_head");
  level._effect["youveBeenNice_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nice_limb");
  level._effect["youveBeenNice_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nice_torso");
  level._effect["youveBeenNice_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nice_head");
  level._effect["vDay_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_vday_limb");
  level._effect["vDay_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_vday_torso");
  level._effect["vDay_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_vday_head");
  level._effect["bCell_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_limb");
  level._effect["bCell_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_torso");
  level._effect["bCell_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_head");
  level._effect["bCell_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_nogore_limb");
  level._effect["bCell_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_nogore_torso");
  level._effect["bCell_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_bcell_nogore_head");
  level._effect["paddy_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_paddy_limb");
  level._effect["paddy_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_paddy_torso");
  level._effect["paddy_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_paddy_head");
  level._effect["easter_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_limb");
  level._effect["easter_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_torso");
  level._effect["easter_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_head");
  level._effect["easter_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_nogore_limb");
  level._effect["easter_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_nogore_torso");
  level._effect["easter_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_easter_nogore_head");
  level._effect["scifi_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_limb");
  level._effect["scifi_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_torso");
  level._effect["scifi_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_head");
  level._effect["scifi_origin"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi_death_mesh");
  level._effect["scifi2_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_limb");
  level._effect["scifi2_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_torso");
  level._effect["scifi2_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_head");
  level._effect["scifi2_origin"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi2_death_mesh");
  level._effect["scifi3_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_limb");
  level._effect["scifi3_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_torso");
  level._effect["scifi3_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_head");
  level._effect["scifi3_origin"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_scifi3_death_mesh");
  level._effect["420_death"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_fatal_weed_sh");
  level._effect["hitscan"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hitscan_fatal");
  level._effect["thor"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_thor_fatal");
  level._effect["thor_chest"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_thor_fatal_chest");
  level._effect["golden_gun_limb"] = loadfx("vfx/jup/weapon/_mtx/s1/impact/terminus_goldengun/vfx_imp_mtx_s1_terminus_goldengun_limb");
  level._effect["golden_gun_torso"] = loadfx("vfx/jup/weapon/_mtx/s1/impact/terminus_goldengun/vfx_imp_mtx_s1_terminus_goldengun_torso");
  level._effect["golden_gun_head"] = loadfx("vfx/jup/weapon/_mtx/s1/impact/terminus_goldengun/vfx_imp_mtx_s1_terminus_goldengun_head");
  level._effect["golden_gun_origin"] = loadfx("vfx/jup/weapon/_mtx/s1/impact/terminus_goldengun/vfx_imp_mtx_s1_terminus_goldengun_death_mesh");
  level._effect["soulEater_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_souleater_limb");
  level._effect["soulEater_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_souleater_torso");
  level._effect["soulEater_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_souleater_head");
  level._effect["soulEater_death"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_soul_fatal");
  level._effect["crash_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_crash_limb");
  level._effect["crash_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_crash_torso");
  level._effect["crash_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_crash_head");
  level._effect["cthulhu_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_limb");
  level._effect["cthulhu_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_torso");
  level._effect["cthulhu_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_head");
  level._effect["cthulhu_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_nogore_limb");
  level._effect["cthulhu_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_nogore_torso");
  level._effect["cthulhu_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_cthulhu_nogore_head");
  level._effect["akihabara_fatal"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_akihabara_fatal");
  level._effect["hlander_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_limb");
  level._effect["hlander_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_torso");
  level._effect["hlander_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_head");
  level._effect["hlander_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_nogore_limb");
  level._effect["hlander_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_nogore_torso");
  level._effect["hlander_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hlander_nogore_head");
  level._effect["nicki_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nicki_limb");
  level._effect["nicki_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nicki_torso");
  level._effect["nicki_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_nicki_head");
  level._effect["ice_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_limb");
  level._effect["ice_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_torso");
  level._effect["ice_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_head");
  level._effect["ice_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_limb_nogore");
  level._effect["ice_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_ice_torso_nogore");
  level._effect["tomb_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_limb");
  level._effect["tomb_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_torso");
  level._effect["tomb_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_head");
  level._effect["tomb_limb_nogore"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_limb_nogore");
  level._effect["tomb_torso_nogore"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_torso_nogore");
  level._effect["tomb_head_nogore"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_head_nogore");
  level._effect["tomb_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_limb");
  level._effect["tomb_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_torso");
  level._effect["tomb_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/lara/vfx_fatal_mtx_lara_head");
  level._effect["hips_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hips_limb");
  level._effect["hips_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hips_torso");
  level._effect["hips_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hips_head");
  level._effect["hops_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hops_limb");
  level._effect["hops_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hops_torso");
  level._effect["hops_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_hops_head");
  level._effect["maze_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_limb");
  level._effect["maze_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_torso");
  level._effect["maze_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_head");
  level._effect["maze_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_nogore_limb");
  level._effect["maze_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_nogore_torso");
  level._effect["maze_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_maze_nogore_head");
  level._effect["aluc_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_aluc_limb");
  level._effect["aluc_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_aluc_torso");
  level._effect["aluc_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_aluc_head");
  level._effect["aluc_nogore_limb"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_aluc_nogore_limb");
  level._effect["aluc_nogore_torso"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_aluc_nogore_torso");
  level._effect["aluc_nogore_head"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_aluc_nogore_head");
  level._effect["lilith"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_lilith_fatal");

  if(getdvarint(@ "mgl", 0) != 0) {
    level._effect["sbandit_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_flesh_ftl_bdt");
    level._effect["spider_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_death_mtx_alpha50_spider");
    level._effect["sbandit_limb"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_sbandit_limb");
    level._effect["sbandit_torso"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_sbandit_torso");
    level._effect["sbandit_head"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_sbandit_head");
  }

  function_503e263494654df9("naughtyDeath", &function_35f65f87520b27c7, &function_36f3c1f20204b13);
  function_503e263494654df9("niceDeath", &function_44af174fb8b3375a, &function_777c1f2e7f15d92e);
  function_503e263494654df9("vDay", &function_322b81ee84a7c335, &function_337b80f7ff25b0c9);
  function_503e263494654df9("pShock", &function_876682da843d662f, &function_f7bca22a37224d8b);
  function_503e263494654df9("bCell", &function_88d1b8b5885326c9, &function_1a406edd298ed8ad);
  function_503e263494654df9("paddy", &function_be4d915ec8789015, &function_583f9260e6221231);
  function_503e263494654df9("shredder", &function_d16a994853c4015e, &function_1b5dfb950d2e6dd2);
  function_503e263494654df9("sbandit", &function_7b6c0e34238a0cfa, &function_436125459cf039e);
  function_503e263494654df9("spider", &function_385859850a87f6, &function_103d412a4079b9a);
  function_503e263494654df9("electricAnime", &function_2068876afa7ffdc2, &function_f3274abe8bbcac04);
  function_503e263494654df9("easter", &function_d82f09c700769a23, &function_f98648e1dc6e63cf);
  function_503e263494654df9("scifi", &function_10c37a77a215e653, &function_52506c3cfde54aa7);
  function_503e263494654df9("scifi2", &function_a5719d2611ccb58b, &function_38f459f70ea411a7);
  function_503e263494654df9("scifi3", &function_be8fb6c49c81dcf6, &function_2d04b4ad2bc66462);
  function_503e263494654df9("420", &function_6b4eebd31e8d283d, &function_fd4087de9db4cdf1);
  function_503e263494654df9("hitscan", &function_3b499b70dcadea7, &function_a02b4e369b2cbcb3);
  function_503e263494654df9("thor", &function_dcf8ef2cc3ba7666, &function_3e92a8e47dbf91aa);
  function_503e263494654df9("kd", &function_f78733b19768dd1c, &function_bdcfc88e185572c8);
  function_503e263494654df9("cdl", &function_cd4c63d7f51297ac, &function_1ebe98051052c08);
  function_503e263494654df9("soulEater", &function_41e8cf00b189fe93, &function_362790d530cb554f);
  function_503e263494654df9("crash", &function_2a39a3e5a451239e, &function_ff45d70ef7fd700a);
  function_503e263494654df9("akihabara", &function_f2ab411194e3af0b, &function_a93d4e4d31895d77);
  function_503e263494654df9("magma", &function_fa73d41da55ed368, &function_836e832ef348cb0c);
  function_503e263494654df9("cthulhu", &function_3530b11955a74bae, &function_f6820874f2f4b7fa);
  function_503e263494654df9("hlander", &function_66bd08d233abc229, &function_487ad6a4de40bcf5);
  function_503e263494654df9("bnoir", &function_662ae8585ca5045d, &function_ae90d417fbdba2a9);
  function_503e263494654df9("goldengun", &function_8dcf23df7efcf5f8, &function_ce2c35cf68d5b3fc);
  function_503e263494654df9("nicki", &function_43765ffd912971f9, &function_98c6559ade501e3d);
  function_503e263494654df9("ice", &function_ee0e6a0498bd296e, &function_e6385720c367c132);
  function_503e263494654df9("tRaider", &function_95718cbeef3bf8f6, &function_bd496cb5c609ebef);
  function_503e263494654df9("hips", &function_a99f0b5c0c8e8b17, &function_cdad06c807f2982b);
  function_503e263494654df9("hops", &function_d72d58ec436494d, &function_c05b05634b8bf729);
  function_503e263494654df9("blunt", &function_4ab089a2b892c67e, &function_8e8a14ae1d93c4ea);
  function_503e263494654df9("maze", &function_5bae09460a05979c, &function_54ed38d3b5ac6140);
  function_503e263494654df9("ufoSm", &function_e4f3eb6b0541db27, &function_2d04b4ad2bc66462);
  function_503e263494654df9("ufoLg", &function_2d38adc3714f681e, &function_487ad6a4de40bcf5);
  function_503e263494654df9("witch", &function_fdfd1ff9442e5b36, &function_5ba1ecaf98dccff2);
  function_503e263494654df9("zombie", &function_ed6185a61a4b5327, &function_24b135168cc16df3);
  function_503e263494654df9("aluc", &function_48468b042519f4a2, &function_d88414c7e331856);
  function_503e263494654df9("paranormal", &function_f5897571e9a0f0eb, &function_5e575cb31776c32f);
  function_ca61bb01d1162121("soulEaterMelee", &function_4152e1b61e2352f9, &function_362790d530cb554f);
  function_ca61bb01d1162121("noirMelee", &function_c9c1ad43d1b4fe7, &function_ae90d417fbdba2a9);
  function_ca61bb01d1162121("iceMelee", &function_5f01695270795a6a, &function_e6385720c367c132);
  function_ca61bb01d1162121("tRaiderMelee", &function_c96315d7dde42c2, &function_bd496cb5c609ebef);
  function_cdb30168aa4ba6d3("lilith", &function_25a452bd132fb8bd, &function_5e562c7c6cd5fbe9);
  function_bd000d3682d66959("soulEaterEquip", &function_36ee14b7476fd18c, &function_362790d530cb554f);
  function_bd000d3682d66959("electricAnimeEquip", &function_1b44231f13746622, &function_f3274abe8bbcac04);
  function_bd000d3682d66959("iceEquip", &function_e1a241f0a168ea25, &function_e6385720c367c132);
  function_a180a5874c8cbe0b("flameSkullCharm", &function_2627a7eaeb3541e5, &function_d0003cb59ba90631);
  function_a180a5874c8cbe0b("crystamSkullCharm", &function_1d7a9b121434df64, &function_9dba84e77ba81e68);
  function_a180a5874c8cbe0b("starlightCharm", &function_763547f85193043, &function_9e037532d806bfaf);
  function_a180a5874c8cbe0b("soulEaterCharm", &function_244de2be6dd725f3, &function_7ac629d7829da1df);
  function_a180a5874c8cbe0b("crowFootCharm", &function_f8fc0821696182c, &function_163fccf48f86ac68);
  function_a180a5874c8cbe0b("pumpkinLanternCharm", &function_1c12797023d624e5, &function_3e50a64bbd61b969);
  function_a180a5874c8cbe0b("weedCreatureCharm", &function_ce28357936d127f1, &function_67b827411821d1b1);
  function_a180a5874c8cbe0b("doomChainsaw", &function_55d5c766b382551e, &function_7f84cac49ac044c0);
  function_7d893cf076538f0d("reactive_kill_streak_2stage", &function_7e8329133ea16786);
  function_7d893cf076538f0d("reactive_match_kills_2stage", &function_882b5ea6e5345b31);
  function_7d893cf076538f0d("reactive_soul_collect_1stage", &function_d05f99b2455baa0a);
  function_7d893cf076538f0d("reactive_movement", &function_40c8094dda4e218f);
  function_7d893cf076538f0d("reactive_downgradable_kill_streak_3stage", &function_777eed4426971f45);
  function_7d893cf076538f0d("reactive_enchantment", &function_7ec064f982949e9);
  function_7d893cf076538f0d("reactive_kill_progressive_3stage", &function_62ed368dc4b74588);
  function_144b37d5935ee55e("reactive_kill");
  function_144b37d5935ee55e("reactive_soul_collect");
  function_a92b5d21a4b45b0();

  if(issharedfuncdefined("aggregator", "registerOnPlayerSpawnCallback")) {
    [[getsharedfunc("aggregator", "registerOnPlayerSpawnCallback")]](&function_c72573fb42d0cdbc);
  }

  thread function_96be6291f27c1e20();
}

function function_503e263494654df9(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_fb690b0442393f26[sname]), "multiple DeathFxFuncs init'd with the same name: <" + sname + ">");
  level.var_fb690b0442393f26[sname] = fxfuncs;
}

function function_ca61bb01d1162121(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_7546f688873b4ce4[sname]), "multiple DeathFxFuncs init'd with the same name: <" + sname + ">");
  level.var_7546f688873b4ce4[sname] = fxfuncs;
}

function function_cdb30168aa4ba6d3(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_15f270e2898482be[sname]), "multiple DeathFxFuncs init'd with the same name: <" + sname + ">");
  level.var_15f270e2898482be[sname] = fxfuncs;
}

function function_bd000d3682d66959(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_d83ca3f3bdf5b3d4[sname]), "multiple DeathFxFuncs init'd with the same name: <" + sname + ">");
  level.var_d83ca3f3bdf5b3d4[sname] = fxfuncs;
}

function function_a180a5874c8cbe0b(sname, var_76db26f25e7dbac7, var_ba46ec67c5caf4a2) {
  var_7bdc9702e6500422 = spawnStruct();
  var_7bdc9702e6500422.var_d7d02abbc34dd7d2 = var_76db26f25e7dbac7;
  var_7bdc9702e6500422.var_ba46ec67c5caf4a2 = var_ba46ec67c5caf4a2;

  function_7e5803a5e15369eb(sname);

  level.var_a3d1147a42b2fd91[sname] = var_7bdc9702e6500422;
}

function function_7d893cf076538f0d(sname, var_ba46ec67c5caf4a2) {
  var_7bdc9702e6500422 = spawnStruct();
  var_7bdc9702e6500422.var_ba46ec67c5caf4a2 = var_ba46ec67c5caf4a2;

  function_7e5803a5e15369eb(sname);

  level.var_8507c1fda79a21e3[sname] = var_7bdc9702e6500422;
}

function function_144b37d5935ee55e(sname, var_ba46ec67c5caf4a2) {
  var_7bdc9702e6500422 = spawnStruct();

  function_7e5803a5e15369eb(sname);

  level.var_1c6c766b95b77e8a[sname] = var_7bdc9702e6500422;
}

function function_7e5803a5e15369eb(sname) {
  assertex(!isDefined(level.var_a3d1147a42b2fd91[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
  assertex(!isDefined(level.var_8507c1fda79a21e3[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
  assertex(!isDefined(level.var_1c6c766b95b77e8a[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
}

function function_a92b5d21a4b45b0() {
  level.var_40e77024dc6bae59 = [];

  if(!isDefined(level.mapname)) {
    level.mapname = getDvar(@ "g_mapname");
  }

  if(issubstr(level.mapname, "frontend")) {
    level.var_40e77024dc6bae59["match_kill_thresholds_2stage"] = [2, 4];
    level.var_40e77024dc6bae59["kill_streak_thresholds_2stage"] = [2, 4];
    level.var_40e77024dc6bae59["kill_streak_thresholds_souleater"] = 1;
    return;
  }

  level.var_40e77024dc6bae59["match_kill_thresholds_2stage"] = function_b7c399cd6018f474();
  level.var_40e77024dc6bae59["kill_streak_thresholds_2stage"] = function_15b4833097caf079();
  level.var_40e77024dc6bae59["kill_streak_thresholds_souleater"] = function_68b32b8d783a8ca2();
  level.var_40e77024dc6bae59["downgradable_kill_streak_thresholds_3stage"] = function_d4e38ad2ae67fd38();
}

function function_c72573fb42d0cdbc() {
  function_48acda7f56f30aab();
  function_1f5695ce1654709d();
}

function function_48acda7f56f30aab() {
  if(function_2947be89ddf09115()) {
    return;
  }

  function_35c927994920a75("match_kills", 0);
  function_35c927994920a75("kill_streak", 0);
  function_35c927994920a75("kill_cycle_counter_bananas", 0);
  function_35c927994920a75("downgradable_kill_streak", 0);
  function_35c927994920a75("reactive_kills", 0);
  function_35c927994920a75("souls_collected_count", 0);
  function_35c927994920a75("movement_state", "neutral");
  function_35c927994920a75("vfx_scriptable_disablers", []);
  function_35c927994920a75("enchanted_weapons", []);
  function_35c927994920a75("last_reactive_kill_time", -99999);
  function_35c927994920a75("last_reticle_kill_time", -99999);
  function_35c927994920a75("soul_ents_in_flight", []);
  function_35c927994920a75("is_throwing_grenade", 0);

  foreach(scriptableid, var_7bdc9702e6500422 in level.var_a3d1147a42b2fd91) {
    function_5b5e6de151e0fecd(scriptableid, "neutral");
  }

  foreach(scriptableid, var_7bdc9702e6500422 in level.var_8507c1fda79a21e3) {
    function_4fa6004e1f4bd807(scriptableid, "neutral");
  }

  foreach(var_7bdc9702e6500422 in level.var_1c6c766b95b77e8a) {
    function_68444e56728a13a6(scriptableid);
  }

  thread mtx_manageoffhands();
}

function function_2947be89ddf09115() {
  return isDefined(self.var_e7a9752e4f4c7d97);
}

function function_b7c399cd6018f474() {
  if(isDefined(level.mtxkillthresholdstage1) && level.mtxkillthresholdstage1 > 0) {
    if(isDefined(level.mtxkillthresholdstage2) && level.mtxkillthresholdstage2 > 0) {
      return [level.mtxkillthresholdstage1, level.mtxkillthresholdstage2];
    }
  }

  return [10, 20];
}

function function_15b4833097caf079() {
  return [2, 5];
}

function function_68b32b8d783a8ca2() {
  return 3;
}

function function_d4e38ad2ae67fd38() {
  return [2, 5, 8];
}

function function_287113bfbe3cbd0c() {
  return [1, 2, 3];
}

function function_b939bc4f3a6d4fdc(weapon) {
  function_a71517a0b579ed46(weapon);
  function_79e98e41624be7fc();
  function_e6c5c00872a14e28();
  function_81837d4d838c9fe4();
}

function function_7c62c6c14aba289b() {
  function_48acda7f56f30aab();
  function_e6c5c00872a14e28();
  function_6c9a431ebf770006();
}

function function_eceb462b367e4b04(deathdata) {
  if(isDefined(deathdata.attacker) && isPlayer(deathdata.attacker)) {
    deathdata.attacker function_5c55ca428dd7b66b(self, deathdata.objweapon, deathdata.meansofdeath);
  }

  function_af1adc73dffafd19(deathdata.objweapon, deathdata.meansofdeath);
}

function function_1dd3a521ea9ecf27(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref) {
  return function_a952714a4c2f5c6f(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref);
}

function function_bbee2e46ab15a720(attacker, objweapon, meansofdeath, hitloc, inflictor) {
  if(isDefined(attacker) && isPlayer(attacker)) {
    attacker function_5c55ca428dd7b66b(self, objweapon, meansofdeath);
  }

  return function_a952714a4c2f5c6f(attacker, objweapon, meansofdeath, hitloc, inflictor);
}

function function_d7c5900c7d5bb0db(deathdata) {
  if(isDefined(deathdata.attacker) && isPlayer(deathdata.attacker)) {
    deathdata.attacker function_5c55ca428dd7b66b(self, deathdata.objweapon, deathdata.meansofdeath);
  }

  return function_a952714a4c2f5c6f(deathdata.attacker, deathdata.objweapon, deathdata.meansofdeath, deathdata.hitloc);
}

function function_943511ab1f39db66() {
  self endon("death_or_disconnect");
  self endon("shockStick_haywireApplied");
  function_d7fa97d4f0f98c1("vfx_disabled_for_haywire");
  self waittill("haywire_cleared");
  wait 1;
  function_bf1775a0a246bdf8("vfx_disabled_for_haywire");
}

function function_606fa08e3aac10d9() {
  function_d7fa97d4f0f98c1("vfx_disabled_for_jugg");
}

function function_cb5051bfab85d56a() {
  function_bf1775a0a246bdf8("vfx_disabled_for_jugg");
}

function function_112e56b7dbe18137() {
  function_d7fa97d4f0f98c1("vfx_disabled_for_hiding");
}

function function_33637806fc5ac024() {
  function_bf1775a0a246bdf8("vfx_disabled_for_hiding");
}

function function_92d9b05be48fe03e(entity) {
  return isDefined(entity) && isDefined(entity.model) && entity.model == "military_shooting_target_armor_01_assembly";
}

function function_8114951a631bd6a6() {
  return function_d05f99b2455baa0a();
}

function function_150370c11a6c880(objweapon) {
  return function_36ee14b7476fd18c(objweapon);
}

function private function_a952714a4c2f5c6f(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref) {
  if(meansofdeath == "MOD_SUICIDE") {
    return 0;
  }

  if(isbulletdeath(meansofdeath) || iscrushdeath(meansofdeath)) {
    return function_36d11b76451cdde1(level.var_fb690b0442393f26, attacker, objweapon, hitloc);
  } else if(ismeleedeath(meansofdeath)) {
    return function_36d11b76451cdde1(level.var_7546f688873b4ce4, attacker, objweapon, hitloc);
  } else if(isexecutiondeath(meansofdeath) && isDefined(executionref)) {
    objweapon = spawnStruct();
    objweapon.executionref = executionref;
    return function_36d11b76451cdde1(level.var_15f270e2898482be, attacker, objweapon, hitloc);
  } else if(isequipmentdeath(meansofdeath)) {
    if(function_8542d26e5ac6c50c(inflictor)) {
      return function_ce7272acb57aac2a(self.body);
    }

    return function_36d11b76451cdde1(level.var_d83ca3f3bdf5b3d4, attacker, objweapon, hitloc);
  }

  return 0;
}

function private ismeleedeath(meansofdeath) {
  return meansofdeath == "MOD_MELEE";
}

function private isexecutiondeath(meansofdeath) {
  return meansofdeath == "MOD_EXECUTION";
}

function private isbulletdeath(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

function private isequipmentdeath(meansofdeath) {
  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_GRENADE_SPLASH";
}

function private iscrushdeath(meansofdeath) {
  return meansofdeath == "MOD_CRUSH";
}

function private function_36d11b76451cdde1(var_4f9e2cc6f3c3696a, attacker, objweapon, hitloc) {
  foreach(var_78d10f1cffcb27f6 in var_4f9e2cc6f3c3696a) {
    if([[var_78d10f1cffcb27f6.conditions]](objweapon)) {
      corpsedeleted = self[[var_78d10f1cffcb27f6.deatheffect]](self.body, attacker, hitloc);
      assertex(isDefined(corpsedeleted), "All fxFuncs.deathEffect must return true if body deleted, false if not");
      return corpsedeleted;
    }
  }

  return 0;
}

function private function_5c55ca428dd7b66b(victim, weapon, meansofdeath) {
  if(!isenemykill(victim, meansofdeath)) {
    return;
  }

  self.var_e7a9752e4f4c7d97["match_kills"]++;
  self.var_e7a9752e4f4c7d97["kill_streak"]++;
  self.var_e7a9752e4f4c7d97["downgradable_kill_streak"]++;
  function_ba3a5a6cdabc71f0("reactive_kill_streak_2stage");
  function_ba3a5a6cdabc71f0("reactive_match_kills_2stage");
  function_ba3a5a6cdabc71f0("reactive_downgradable_kill_streak_3stage");
  thread function_b4ebf862900a4d38();

  if(isDefined(weapon)) {
    if(function_1b1244617e1e02e9(weapon, meansofdeath)) {
      thread function_bb48ea90ef425e51();
    }

    if(function_ab36993386930071(weapon)) {
      thread function_1ade8d50b72171d2();
    }
  }
}

function private function_af1adc73dffafd19(objweapon, meansofdeath) {
  function_d4e4935b9938f870();
  function_ba3a5a6cdabc71f0("reactive_kill_streak_2stage");
  function_ba3a5a6cdabc71f0("reactive_downgradable_kill_streak_3stage");
  function_45f7158271bbf93();
  function_db40ec5717136688();
}

function private isenemykill(victim, meansofdeath) {
  if(!isDefined(meansofdeath) || "meansOfDeath" == "MOD_SUICIDE") {
    return false;
  }

  if(!isDefined(victim) || victim == self) {
    return false;
  }

  return true;
}

function private mtx_manageoffhands() {
  self notify("mtx_manageOffhands");
  self endon("mtx_manageOffhands");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("weapon_switch_started");

    if(self isthrowinggrenade()) {
      self.var_e7a9752e4f4c7d97["is_throwing_grenade"] = 1;
      function_45f7158271bbf93();
      self waittill("offhand_end");
      self.var_e7a9752e4f4c7d97["is_throwing_grenade"] = 0;
      function_79e98e41624be7fc();
    }
  }
}

function private function_d7fa97d4f0f98c1(disabler) {
  if(!isDefined(self.var_e7a9752e4f4c7d97)) {
    return;
  }

  if(!array_contains(self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"], disabler)) {
    self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"] = array_add(self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"], disabler);
  }

  function_45f7158271bbf93();
  function_98b9a56ebaec7205();
}

function private function_bf1775a0a246bdf8(disabler) {
  if(!isDefined(self.var_e7a9752e4f4c7d97)) {
    return;
  }

  if(array_contains(self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"], disabler)) {
    self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"] = array_remove(self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"], disabler);
  }

  function_79e98e41624be7fc();
  function_1f5695ce1654709d();
}

function private function_79e98e41624be7fc() {
  var_50af9aeeffb058ed = 0;

  if(isDefined(self.currentweapon) && function_6505b038fb96bb28()) {
    foreach(var_7bdc9702e6500422 in level.var_a3d1147a42b2fd91) {
      if([[var_7bdc9702e6500422.var_d7d02abbc34dd7d2]](self.currentweapon)) {
        thread function_dfc52c6f1ae59baf(scriptableid, var_7bdc9702e6500422, self.currentweapon);
        var_50af9aeeffb058ed = 1;
        break;
      }
    }
  }

  if(!var_50af9aeeffb058ed) {
    function_45f7158271bbf93();
  }
}

function private function_dfc52c6f1ae59baf(scriptableid, var_7bdc9702e6500422, weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  state = [[var_7bdc9702e6500422.var_ba46ec67c5caf4a2]](weapon);

  if(self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"][scriptableid] != state) {
    self setscriptablepartstate("mtxVfxCharm", state);
    self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"][scriptableid] = state;
  }
}

function private function_45f7158271bbf93() {
  foreach(scriptablestate in self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"]) {
    if(scriptablestate != "neutral") {
      self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"][scriptableid] = "neutral";
    }
  }

  self setscriptablepartstate("mtxVfxCharm", "neutral");
}

function private function_6505b038fb96bb28() {
  if(self.var_e7a9752e4f4c7d97["is_throwing_grenade"] || istrue(self.ishaywire)) {
    return false;
  }

  return true;
}

function private function_1f5695ce1654709d() {
  foreach(var_7bdc9702e6500422 in level.var_8507c1fda79a21e3) {
    function_ba3a5a6cdabc71f0(scriptableid);
  }
}

function private function_ba3a5a6cdabc71f0(scriptableid) {
  if(function_6429a0d0c36d7ea()) {
    var_7bdc9702e6500422 = level.var_8507c1fda79a21e3[scriptableid];

    if(function_c8cda6bd2f765d41(scriptableid, var_7bdc9702e6500422)) {
      function_a134ba0b1c11a0e9(scriptableid, var_7bdc9702e6500422);
    }
  }
}

function private function_6c9a431ebf770006() {
  foreach(var_7bdc9702e6500422 in level.var_8507c1fda79a21e3) {
    function_6dd7d4f0881173bb(scriptableid);
  }
}

function private function_6dd7d4f0881173bb(scriptableid) {
  var_7bdc9702e6500422 = level.var_8507c1fda79a21e3[scriptableid];
  function_a134ba0b1c11a0e9(scriptableid, var_7bdc9702e6500422);
}

function private function_a134ba0b1c11a0e9(scriptableid, var_7bdc9702e6500422) {
  state = [[var_7bdc9702e6500422.var_ba46ec67c5caf4a2]]();

  if(!self getscriptableparthasstate(scriptableid, state)) {
    println("<dev string:x54>" + state + "<dev string:x7b>" + scriptableid);
    return;
  }

  self setscriptablepartstate(scriptableid, state);
  self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"][scriptableid] = state;
}

function private function_98b9a56ebaec7205() {
  foreach(scriptableid, scriptablestate in self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"]) {
    if(scriptablestate != "neutral") {
      self setscriptablepartstate(scriptableid, "neutral");
      self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"][scriptableid] = "neutral";
    }
  }
}

function private function_6429a0d0c36d7ea() {
  if(self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function private function_c8cda6bd2f765d41(scriptableid, var_7bdc9702e6500422) {
  state = [[var_7bdc9702e6500422.var_ba46ec67c5caf4a2]]();
  return state != self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"][scriptableid];
}

function private function_a2ff3959a0b6827e(scriptableid) {
  if(function_5bcad624c23d5c6f()) {
    state = self.var_e7a9752e4f4c7d97["mtx_scriptable_toggle_ids"][scriptableid];

    if(state == "toggle0") {
      newstate = "toggle1";
    } else {
      newstate = "toggle0";
    }

    self setscriptablepartstate(scriptableid, newstate);
    self.var_e7a9752e4f4c7d97["mtx_scriptable_toggle_ids"][scriptableid] = newstate;
  }
}

function private function_5bcad624c23d5c6f() {
  if(self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function function_bb839bb513295f10(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(!isDefined(weapon.basename) || !isDefined(weapon.variantid)) {
    return false;
  }

  if(weapon.basename == "iw9_me_sword01_mp" && weapon.variantid == 2) {
    return true;
  }

  return false;
}

function private function_2627a7eaeb3541e5(weapon) {
  return weapon hasattachment("cos_iw9_156");
}

function private function_d0003cb59ba90631(weapon) {
  return "flameSkullActive";
}

function private function_1d7a9b121434df64(weapon) {
  return weapon hasattachment("cos_iw9_445");
}

function private function_763547f85193043(weapon) {
  return weapon hasattachment("cos_iw9_465");
}

function private function_244de2be6dd725f3(weapon) {
  return weapon hasattachment("cos_iw9_446");
}

function private function_f8fc0821696182c(weapon) {
  return weapon hasattachment("cos_iw9_501");
}

function private function_1c12797023d624e5(weapon) {
  return weapon hasattachment("cos_iw9_500");
}

function private function_ce28357936d127f1(weapon) {
  return weapon hasattachment("cos_iw9_526");
}

function function_55d5c766b382551e(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "rec_pickaxe" && weapon.receivervarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_9dba84e77ba81e68(weapon) {
  return "crystalSkullActive";
}

function private function_9e037532d806bfaf(weapon) {
  return "starlightActive";
}

function private function_7ac629d7829da1df(weapon) {
  return "soulEaterActive";
}

function private function_163fccf48f86ac68(weapon) {
  return "crowFootActive";
}

function private function_3e50a64bbd61b969(weapon) {
  return "pumpkinLanternActive";
}

function private function_67b827411821d1b1(weapon) {
  return "weedCreatureActive";
}

function private function_7f84cac49ac044c0(weapon) {
  return "doomChainsawActive";
}

function private function_882b5ea6e5345b31() {
  stage1killthreshold = level.var_40e77024dc6bae59["match_kill_thresholds_2stage"][0];
  stage2killthreshold = level.var_40e77024dc6bae59["match_kill_thresholds_2stage"][1];
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["match_kills"] >= stage2killthreshold) {
    state = "stage2";
  } else if(self.var_e7a9752e4f4c7d97["match_kills"] >= stage1killthreshold) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_a0c0a5bf060c7bf2");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x96>";
        break;
      case 1:
        state = "<dev string:x9e>";
        break;
      case 2:
        state = "<dev string:xa5>";
        break;
      default:
        assertmsg("<dev string:xac>");
        break;
    }
  }

  return state;
}

function private function_7e8329133ea16786() {
  stage1killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_2stage"][0];
  stage2killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_2stage"][1];
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage2killthreshold) {
    state = "stage2";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage1killthreshold) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_e5d7c5b83ec14d85");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x96>";
        break;
      case 1:
        state = "<dev string:x9e>";
        break;
      case 2:
        state = "<dev string:xa5>";
        break;
      default:
        assertmsg("<dev string:xac>");
        break;
    }
  }

  return state;
}

function private function_62ed368dc4b74588() {
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["kill_streak"] >= 3) {
    state = "stage3";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= 2) {
    state = "stage2";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= 1) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_dca6459901f0f758");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x96>";
        break;
      case 1:
        state = "<dev string:x9e>";
        break;
      case 2:
        state = "<dev string:xa5>";
        break;
      case 3:
        state = "<dev string:xd0>";
        break;
      default:
        assertmsg("<dev string:xd7>");
        break;
    }
  }

  return state;
}

function private function_777eed4426971f45() {
  return function_ad8d1b9c1ea44000("reactive_downgradable_kill_streak_3stage", "stage1", "stage1_dec", "stage2", "stage2_dec", "stage3", @ "hash_e001a97b368816c9");
}

function private function_ad8d1b9c1ea44000(part, stage1, stage1_dec, stage2, stage2_dec, stage3, debugdvar) {
  stage1killthreshold = level.var_40e77024dc6bae59["downgradable_kill_streak_thresholds_3stage"][0];
  stage2killthreshold = level.var_40e77024dc6bae59["downgradable_kill_streak_thresholds_3stage"][1];
  stage3killthreshold = level.var_40e77024dc6bae59["downgradable_kill_streak_thresholds_3stage"][2];
  var_31ab0ca66477a686 = getdvarint(@ "hash_19443de5a3697190", -1);
  var_6ea0f438ba552065 = getdvarint(@ "hash_7b707b9e08a2a8fd", -1);
  var_141b73584fb989b0 = getdvarint(@ "hash_e225d9e8775ceae", -1);

  if(var_31ab0ca66477a686 >= 0) {
    stage1killthreshold = var_31ab0ca66477a686;
  }

  if(var_6ea0f438ba552065 >= 0) {
    stage2killthreshold = var_6ea0f438ba552065;
  }

  if(var_141b73584fb989b0 >= 0) {
    stage3killthreshold = var_141b73584fb989b0;
  }

  curstate = self getscriptablepartstate(part, 0);
  state = undefined;

  if(self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] >= stage3killthreshold) {
    state = stage3;
  } else if(self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] >= stage2killthreshold) {
    if(curstate == stage3 || curstate == stage2_dec) {
      state = stage2_dec;
    } else {
      state = stage2;
    }
  } else if(self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] >= stage1killthreshold) {
    if(curstate == stage3 || curstate == stage2 || curstate == stage2_dec || curstate == stage1_dec) {
      state = stage1_dec;
    } else {
      state = stage1;
    }
  } else {
    state = "neutral";
  }

  debugstates = getdvarint(debugdvar);

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x96>";
        break;
      case 1:
        state = stage1;
        break;
      case 2:
        state = stage2;
        break;
      case 3:
        state = stage3;
        break;
      default:
        assertmsg("<dev string:xd7>");
        break;
    }
  }

  thread mtx_monitorreactivekillstreak3stagedecay();
  return state;
}

function private mtx_monitorreactivekillstreak3stagedecay() {
  self notify("mtx_monitorReactiveKillstreak3StageDecay");
  self endon("death_or_disconnect");
  self endon("mtx_monitorReactiveKillstreak3StageDecay");
  decaytime = getdvarfloat(@ "hash_17bc5fdc392ba0b3", 20000) / 1000;

  while(true) {
    wait decaytime;

    debugstates = -1;
    debugstates = getdvarint(@ "hash_e001a97b368816c9");

    if(debugstates >= 0) {
      self notify("<dev string:xfe>");
    }

    self.var_e7a9752e4f4c7d97["downgradable_kill_streak"]--;

    if(self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] < 0) {
      self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] = 0;
    }

    thread function_ba3a5a6cdabc71f0("reactive_downgradable_kill_streak_3stage");
  }
}

function private function_d05f99b2455baa0a() {
  stage1killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_souleater"];
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["souls_collected_count"] >= stage1killthreshold) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_cf86c6012f506ac8");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x96>";
        break;
      case 1:
        state = "<dev string:x9e>";
        break;
      default:
        assertmsg("<dev string:x127>");
        break;
    }
  }

  return state;
}

function private function_40c8094dda4e218f() {
  debugstates = getdvarint(@ "hash_beff73861be066d");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        return "<dev string:x96>";
      case 1:
        return "<dev string:x9e>";
      default:
        assertmsg("<dev string:x148>" + debugstates + "<dev string:x165>");
        break;
    }
  }

  return self.var_e7a9752e4f4c7d97["movement_state"];
}

function private getweaponname(weapon) {
  if(isDefined(weapon)) {
    return weapon.basename;
  }

  return "NONE";
}

function private function_7ec064f982949e9() {
  debugstates = getdvarint(@ "hash_8d73f9a1e40b4f01");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        return "<dev string:x96>";
      case 1:
        return "<dev string:x9e>";
      default:
        assertmsg("<dev string:x196>" + debugstates + "<dev string:x165>");
        break;
    }
  }

  weaponname = getweaponname(self.currentweapon);
  weaponstate = self.var_e7a9752e4f4c7d97["enchanted_weapons"][weaponname];

  if(isDefined(weaponstate) && weaponstate == 1) {
    return "stage1";
  }

  return "neutral";
}

function private ismovementoperator() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(self.operatorcustomization.skinref + "" == "370") {
      return true;
    }
  }

  return false;
}

function private ismovementweapon(weapon) {
  if(isDefined(weapon) && weapon.basename == "iw9_sm_aviktor_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 25);
  }

  return false;
}

function private function_81837d4d838c9fe4() {
  if(function_ee73ce9f8e9e7938(self.currentweapon)) {
    thread function_dd5e7e7d9dcdc45(self.currentweapon);
    return;
  }

  function_30f8126cb8555725();
}

function private function_ee73ce9f8e9e7938(weapon) {
  bypass = getdvarint(@ "hash_d5bfe694a8598141");

  if(bypass == 1) {
    return true;
  }

  if(isDefined(weapon) && weapon.basename == "iw9_sn_india_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 14);
  }

  return false;
}

function private function_dd5e7e7d9dcdc45(weapon) {
  self notify("inspect_update_thread");
  self endon("death_or_disconnect");
  self endon("inspect_update_thread");
  weaponname = weapon.basename;
  function_ba3a5a6cdabc71f0("reactive_enchantment");

  while(true) {
    self waittill("weapon_inspect");
    function_670fe78573af87eb(weaponname);
    function_ba3a5a6cdabc71f0("reactive_enchantment");
  }
}

function private function_1279657a7f30ae15(state) {
  if(!function_ee73ce9f8e9e7938(self.currentweapon) || !isDefined(self.var_e7a9752e4f4c7d97["enchanted_weapons"])) {
    return;
  }

  if(state != 0 && state != 1) {
    assertmsg("Enchantment state set to <" + state + ">, valid values are 0 or 1 ints");
  }

  self.var_e7a9752e4f4c7d97["enchanted_weapons"][getweaponname(self.currentweapon)] = state;
  function_6d5278c2d03fa5df();
}

function private function_670fe78573af87eb(weaponname) {
  currentstate = function_7ec064f982949e9();

  if(currentstate == "neutral") {
    function_1279657a7f30ae15(1);
    return;
  }

  function_1279657a7f30ae15(0);
}

function private function_30f8126cb8555725() {
  self notify("inspect_update_thread");
}

function private function_e6c5c00872a14e28() {
  if(ismovementoperator() || ismovementweapon(self.currentweapon)) {
    thread function_e6a59e9b581f1af6();
    return;
  }

  function_d9c8739eb93ab7d9();
}

function private function_e6a59e9b581f1af6() {
  self notify("movement_update_thread");
  self endon("death_or_disconnect");
  self endon("movement_update_thread");
  currentstate = self.var_e7a9752e4f4c7d97["movement_state"];
  var_8224573f9ab4d7a8 = 0;

  while(true) {
    movement = self getnormalizedmovement();
    movement = abs(movement[0]) + abs(movement[1]);

    if(movement > 0.7 && !self playerads() > 0 && self getstance() == "stand") {
      var_8224573f9ab4d7a8 = 1;
    } else {
      var_8224573f9ab4d7a8 = 0;
    }

    if(self issprinting() || !self isonground() || self isdiving() || self issprintsliding() || var_8224573f9ab4d7a8) {
      targetstate = "neutral";
      delaytime = 0;
    } else {
      targetstate = "stage1";
      delaytime = 0;
    }

    if(currentstate != targetstate) {
      childthread function_7ae9c5df682996ef(targetstate, delaytime);
      currentstate = targetstate;
    }

    wait 0.1;
  }
}

function private function_7ae9c5df682996ef(state, delaytime) {
  self notify("newMovementState");
  self endon("newMovementState");
  wait delaytime;
  self.var_e7a9752e4f4c7d97["movement_state"] = state;
  function_ba3a5a6cdabc71f0("reactive_movement");
}

function private function_d9c8739eb93ab7d9() {
  self notify("movement_update_thread");
}

function private function_b4ebf862900a4d38() {
  self notify("updating_reactive_kills");
  self endon("death_or_disconnect");
  self endon("updating_reactive_kills");

  if(!isDefined(self getscriptablepartstate("reactive_kill", 1))) {
    println("<dev string:x1b6>");
    return;
  }

  while(true) {
    time = gettime();
    timesincelastkill = time - self.var_e7a9752e4f4c7d97["last_reactive_kill_time"];

    if(timesincelastkill >= 600) {
      if(self.var_e7a9752e4f4c7d97["match_kills"] > self.var_e7a9752e4f4c7d97["reactive_kills"]) {
        function_a2ff3959a0b6827e("reactive_kill");
        self.var_e7a9752e4f4c7d97["last_reactive_kill_time"] = time;
        self.var_e7a9752e4f4c7d97["reactive_kills"]++;
      } else {
        return;
      }

      waittime = 0.6;
    } else {
      waittime = (600 - timesincelastkill) / 1000;
    }

    wait waittime;
  }
}

function private function_a71517a0b579ed46(weapon) {
  if(function_b376b213145194d3(weapon)) {
    thread function_e56763dbb208985c(weapon);
  }

  if(function_70d9fde7ab8fe4f4(weapon)) {
    thread function_3d36736882540029(weapon);
    return;
  }

  function_bcdeea59d1c8c709();
}

function private function_ab36993386930071(weapon) {
  if(function_a124f473c9b83542(weapon)) {
    return true;
  }

  if(function_74ee609c2cece3b0(weapon)) {
    return true;
  }

  if(function_390c36ec2deddabe(weapon)) {
    return true;
  }

  if(function_44c07b3e8b2b9666(weapon)) {
    return true;
  }

  if(function_73c5c19fbd622826(weapon)) {
    return true;
  }

  return false;
}

function private function_70d9fde7ab8fe4f4(weapon) {
  bypass = getdvarint(@ "hash_d5b99091b7c0443e");

  if(bypass == 1) {
    return true;
  }

  return false;
}

function private function_1ade8d50b72171d2() {
  self setclientomnvar("ui_reticle_mtx_action2", self.var_e7a9752e4f4c7d97["match_kills"]);
  self.var_e7a9752e4f4c7d97["last_reticle_kill_time"] = gettime();
}

function private function_b92e7556d13a2d52() {
  self setclientomnvar("ui_reticle_mtx_action2", self.var_e7a9752e4f4c7d97["souls_collected_count"]);
}

function private function_6d5278c2d03fa5df() {
  self setclientomnvar("ui_reticle_mtx_inspect", self.var_e7a9752e4f4c7d97["enchanted_weapons"][getweaponname(self.currentweapon)]);
}

function private function_511d0cb4a6fe51d2() {
  self setclientomnvar("ui_reticle_mtx_focus", self.var_e7a9752e4f4c7d97["mtx_focus"]);
}

function private function_3d36736882540029(weapon) {
  self notify("mtx_focus_thread");
  self endon("death_or_disconnect");
  self endon("mtx_focus_thread");
  self endon("weapon_change");
  function_35c927994920a75("mtx_focus", 0);
  focusstate = 0;

  while(true) {
    if(isDefined(self.focus) && focusstate != self.focus) {
      focusstate = self.focus;
      self.var_e7a9752e4f4c7d97["mtx_focus"] = focusstate;
      function_511d0cb4a6fe51d2();
    }

    waitframe();
  }
}

function private function_bcdeea59d1c8c709() {
  self notify("mtx_focus_thread");
}

function private function_e56763dbb208985c(weapon) {
  function_35c927994920a75("hearts_broken", 0);
  function_35c927994920a75("hearts_broken_incrementing", 0);

  if(function_f2626cc5d4205f(weapon)) {
    self setclientomnvar("ui_reticle_mtx_action2", self.var_e7a9752e4f4c7d97["hearts_broken"]);
    return;
  }

  self setclientomnvar("ui_reticle_mtx_action2", -1);
}

function private function_bb48ea90ef425e51() {
  self endon("death_or_disconnect");
  self.var_e7a9752e4f4c7d97["hearts_broken"]++;

  if(self.var_e7a9752e4f4c7d97["hearts_broken_incrementing"]) {
    return;
  }

  self.var_e7a9752e4f4c7d97["hearts_broken_incrementing"] = 1;
  wait 0.1;

  while(true) {
    currentcount = self getclientomnvar("ui_reticle_mtx_action2");

    if(currentcount >= self.var_e7a9752e4f4c7d97["hearts_broken"]) {
      self.var_e7a9752e4f4c7d97["hearts_broken_incrementing"] = 0;
      return;
    }

    self setclientomnvar("ui_reticle_mtx_action2", currentcount + 1);
    wait 0.57;
  }
}

function private function_db40ec5717136688() {
  if(isDefined(self.var_e7a9752e4f4c7d97) && isDefined(self.var_e7a9752e4f4c7d97["hearts_broken"])) {
    self.var_e7a9752e4f4c7d97["hearts_broken"] = 0;
    self.var_e7a9752e4f4c7d97["hearts_broken_incrementing"] = 0;
  }
}

function private function_b376b213145194d3(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "hybrid03" && weapon.scopevarindex == 4;
}

function private function_a124f473c9b83542(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 27;
}

function private function_74ee609c2cece3b0(weapon) {
  if(isDefined(weapon.scope)) {
    if(gettime() - self.var_e7a9752e4f4c7d97["last_reticle_kill_time"] > 1770) {
      if(weapon.scope == "reflex07_tall" && weapon.scopevarindex == 18) {
        return true;
      }

      if(weapon.scope == "fourx02" && weapon.scopevarindex == 11) {
        return true;
      }
    }
  }

  return false;
}

function private function_390c36ec2deddabe(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 31;
}

function private function_73c5c19fbd622826(weapon) {
  if(gettime() - self.var_e7a9752e4f4c7d97["last_reticle_kill_time"] > 1000) {
    return (isDefined(weapon.scope) && weapon.scope == "vzscope_mromeo" && weapon.scopevarindex == 2);
  }
}

function private function_44c07b3e8b2b9666(weapon) {
  if(isDefined(weapon.scope) && weapon.scope == "fourx02" && weapon.scopevarindex == 15) {
    if(gettime() - self.var_e7a9752e4f4c7d97["last_reticle_kill_time"] > 2000 && function_488022f64344d044(self.var_e7a9752e4f4c7d97["kill_cycle_counter_bananas"], 2)) {
      function_6c5f91d778849d7c("kill_cycle_counter_bananas");
      return true;
    } else {
      function_f5e12ee66df3a2c2("kill_cycle_counter_bananas");
    }
  }

  return false;
}

function private function_78edd771b80bb678(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "bar_ar_longhvy_scope_p52" && weapon.scopevarindex == 1;
}

function private function_69ddd69e3aa4e4c9(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "fourx04" && weapon.scopevarindex == 13;
}

function private function_ea45a0c788f3200c(weapon) {
  return false;
}

function private function_f2626cc5d4205f(weapon) {
  return isDefined(weapon.modifier) && weapon.modifier == "ammo_9s" && weapon.modifiervarindex == 2;
}

function private function_1b1244617e1e02e9(weapon, meansofdeath) {
  return function_b376b213145194d3(weapon) && function_f2626cc5d4205f(weapon) && isDefined(meansofdeath) && meansofdeath != "MOD_MELEE";
}

function private function_35f65f87520b27c7(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 2;
}

function private function_44af174fb8b3375a(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_50b" && objweapon.modifiervarindex == 1;
}

function private function_322b81ee84a7c335(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_bolt_gas" && objweapon.modifiervarindex == 1;
}

function private function_2d38adc3714f681e(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_lg_mp";
}

function private function_e4f3eb6b0541db27(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_mp";
}

function private function_876682da843d662f(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 3) {
      return true;
    }

    if(objweapon.modifier == "ammo_762s_hv" && objweapon.modifiervarindex == 1) {
      return true;
    }
  }

  return false;
}

function private function_88d1b8b5885326c9(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 5;
}

function private function_be4d915ec8789015(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_338nm_hv" && objweapon.modifiervarindex == 1;
}

function private function_d82f09c700769a23(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_9p" && objweapon.modifiervarindex == 7) {
      return true;
    }

    if(objweapon.modifier == "ammo_5x28" && objweapon.modifiervarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_10c37a77a215e653(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_4x30" && objweapon.modifiervarindex == 2) {
      return true;
    }

    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 13) {
      return true;
    }
  }

  return false;
}

function private function_a5719d2611ccb58b(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_45acp" && objweapon.modifiervarindex == 5) {
      return true;
    }

    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 19) {
      return true;
    }
  }

  return false;
}

function private function_be8fb6c49c81dcf6(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_50b" && objweapon.modifiervarindex == 3) {
      return true;
    }

    if(objweapon.modifier == "ammo_5x28" && objweapon.modifiervarindex == 4) {
      return true;
    }
  }

  return false;
}

function private function_d16a994853c4015e(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n_p43" && objweapon.modifiervarindex == 7) {
      return true;
    }

    if(objweapon.modifier == "ammo_12g" && objweapon.modifiervarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_7b6c0e34238a0cfa(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 6;
}

function private function_385859850a87f6(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_50b_hv" && objweapon.modifiervarindex == 3;
}

function private function_2068876afa7ffdc2(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_277f" && objweapon.modifiervarindex == 1) {
      return true;
    }

    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 12) {
      return true;
    }
  }

  return false;
}

function private function_6b4eebd31e8d283d(objweapon) {
  return isDefined(objweapon.modifier) && objweapon.modifier == "ammo_12g" && objweapon.modifiervarindex == 3;
}

function private function_3b499b70dcadea7(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_277f_cp" && objweapon.modifiervarindex == 1) {
      return true;
    }

    if(objweapon.modifier == "ammo_408c" && objweapon.modifiervarindex == 1) {
      return true;
    }
  }

  return false;
}

function private function_dcf8ef2cc3ba7666(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 11) {
      return true;
    }

    if(objweapon.modifier == "ammo_50b_he" && objweapon.modifiervarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_f78733b19768dd1c(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_408c" && objweapon.modifiervarindex == 3) {
      return true;
    }

    if(objweapon.modifier == "ammo_545s" && objweapon.modifiervarindex == 3) {
      return true;
    }
  }

  return false;
}

function private function_cd4c63d7f51297ac(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 15) {
      return true;
    }

    if(objweapon.modifier == "ammo_300nm_hv" && objweapon.modifiervarindex == 4) {
      return true;
    }
  }

  return false;
}

function private function_41e8cf00b189fe93(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if((objweapon.modifier == "ammo_556n_hv" || objweapon.modifier == "ammo_556n_hv_p43") && objweapon.modifiervarindex == 8) {
      return true;
    }

    if(objweapon.modifier == "ammo_9p" && objweapon.modifiervarindex == 10) {
      return true;
    }
  }

  return false;
}

function private function_c9c1ad43d1b4fe7(objweapon) {
  if(isDefined(objweapon.receiver)) {
    if(objweapon.receiver == "iw9_me_sword01" && objweapon.receivervarindex == 4) {
      return true;
    }
  }

  return false;
}

function private function_2a39a3e5a451239e(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_45acp" && objweapon.modifiervarindex == 3) {
      return true;
    }

    if(objweapon.modifier == "ammo_300wm_hv" && objweapon.modifiervarindex == 4) {
      return true;
    }
  }

  return false;
}

function private function_f2ab411194e3af0b(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 17) {
      return true;
    }

    if(objweapon.modifier == "ammo_12g" && objweapon.modifiervarindex == 5) {
      return true;
    }
  }

  return false;
}

function private function_fa73d41da55ed368(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_blk_ap_p43" && objweapon.modifiervarindex == 1) {
      return true;
    }

    if(objweapon.modifier == "ammo_50p" && objweapon.modifiervarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_3530b11955a74bae(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_408c_he" && objweapon.modifiervarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_66bd08d233abc229(objweapon) {
  if(isDefined(objweapon.basename) && (objweapon.basename == "super_laser_charge_mp" || objweapon.basename == "high_jump_mp")) {
    return true;
  }

  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 22) {
      return true;
    }

    if(objweapon.modifier == "ammo_556n_p43" && objweapon.modifiervarindex == 24) {
      return true;
    }

    if(objweapon.modifier == "ammo_5x28" && objweapon.modifiervarindex == 3) {
      return true;
    }
  }

  return false;
}

function private function_662ae8585ca5045d(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_408c_he" && objweapon.modifiervarindex == 3) {
      return true;
    }

    if(objweapon.modifier == "ammo_blk" && objweapon.modifiervarindex == 4) {
      return true;
    }
  }

  return false;
}

function private function_8dcf23df7efcf5f8(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "jup_pi_goldengun_mp";
}

function private function_43765ffd912971f9(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_12g" && objweapon.modifiervarindex == 11) {
      return true;
    }

    if(objweapon.modifier == "ammo_277f" && objweapon.modifiervarindex == 4) {
      return true;
    }
  }

  return false;
}

function private function_ee0e6a0498bd296e(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 29) {
      return true;
    }

    if(objweapon.modifier == "ammo_762n" && objweapon.modifiervarindex == 10) {
      return true;
    }
  }

  return false;
}

function private function_95718cbeef3bf8f6(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_45acp" && objweapon.modifiervarindex == 11) {
      return true;
    }

    if(objweapon.modifier == "ammo_9p" && objweapon.modifiervarindex == 18) {
      return true;
    }
  }

  return false;
}

function private function_a99f0b5c0c8e8b17(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_545s" && objweapon.modifiervarindex == 6) {
      return true;
    }
  }

  return false;
}

function private function_d72d58ec436494d(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_9p" && objweapon.modifiervarindex == 16) {
      return true;
    }
  }

  return false;
}

function private function_4ab089a2b892c67e(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_45acp" && objweapon.modifiervarindex == 12) {
      return true;
    }

    if(objweapon.modifier == "ammo_300wm" && objweapon.modifiervarindex == 6) {
      return true;
    }
  }

  return false;
}

function private function_5bae09460a05979c(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_9s_fr" && objweapon.modifiervarindex == 1) {
      return true;
    }

    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 34) {
      return true;
    }
  }

  return false;
}

function private function_fdfd1ff9442e5b36(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_300wm" && objweapon.modifiervarindex == 5) {
      return true;
    }

    if(objweapon.modifier == "ammo_50p" && objweapon.modifiervarindex == 4) {
      return true;
    }
  }

  return false;
}

function private function_ed6185a61a4b5327(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_545s" && objweapon.modifiervarindex == 5) {
      return true;
    }

    if(objweapon.modifier == "ammo_762s_hv" && objweapon.modifiervarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_25a452bd132fb8bd(fakeweapon) {
  if(fakeweapon.executionref == "execution_061") {
    return true;
  }

  return false;
}

function private function_48468b042519f4a2(objweapon) {
  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_50p_fr" && (objweapon.modifiervarindex == 1 || objweapon.modifiervarindex == 2)) {
      return true;
    }
  }

  return false;
}

function private function_f5897571e9a0f0eb(objweapon) {
  return false;
}

function private function_4152e1b61e2352f9(objweapon) {
  if(isDefined(objweapon.receiver)) {
    if(objweapon.receiver == "iw9_me_knife" && (objweapon.receivervarindex == 39 || objweapon.receivervarindex == 40)) {
      return true;
    }
  }

  return false;
}

function private function_5f01695270795a6a(objweapon) {
  if(isDefined(objweapon.receiver)) {
    if(objweapon.receiver == "iw9_me_knife" && (objweapon.receivervarindex == 33 || objweapon.receivervarindex == 45)) {
      return true;
    }
  }

  return false;
}

function private function_c96315d7dde42c2(objweapon) {
  if(isDefined(objweapon.receiver)) {
    if(objweapon.receiver == "rec_pickaxe" && objweapon.receivervarindex == 1) {
      return true;
    }
  }

  return false;
}

function private function_36ee14b7476fd18c(objweapon) {
  return objweapon.basename == "throwingknife_mp" && isDefined(objweapon.variantid) && objweapon.variantid == 1;
}

function private function_e1a241f0a168ea25(objweapon) {
  return objweapon.basename == "throwingknife_mp" && isDefined(objweapon.variantid) && objweapon.variantid == 2;
}

function private function_1b44231f13746622(objweapon) {
  if(isDefined(objweapon.basename)) {
    switch (objweapon.basename) {
      case #"hash_c7a00ceeee2cd52":
      case #"hash_9702698078eb7241":
      case #"hash_b10f0ebdc1fb569b":
      case #"hash_d8fc49c2b6acc257":
        return true;
      default:
        break;
    }
  }

  return false;
}

function private function_36f3c1f20204b13(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "youveBeenNaughty_limb", "youveBeenNaughty_torso", "youveBeenNaughty_head");
  return true;
}

function private function_777c1f2e7f15d92e(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "youveBeenNice_limb", "youveBeenNice_torso", "youveBeenNice_head");
  return true;
}

function private function_337b80f7ff25b0c9(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "vDay_limb", "vDay_torso", "vDay_head");
  return true;
}

function private function_1a406edd298ed8ad(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "bCell_limb", "bCell_torso", "bCell_head");
  } else {
    function_687ba52e53e097ac(corpstable, "bCell_nogore_limb", "bCell_nogore_torso", "bCell_nogore_head");
  }

  return true;
}

function private function_f7bca22a37224d8b(corpstable, attacker, hitloc) {
  function_dfcee2ebe02a6ae7(corpstable, "purple_shock");
  return false;
}

function private function_583f9260e6221231(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "paddy_limb", "paddy_torso", "paddy_head");
  return true;
}

function private function_1b5dfb950d2e6dd2(corpstable, attacker, hitloc) {
  function_dfcee2ebe02a6ae7(corpstable, "shredder");
  return false;
}

function private function_436125459cf039e(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "sbandit_limb", "sbandit_torso", "sbandit_head");
  function_988bd2fed09e41c("j_spineupper", "sbandit_fatal");
  delete_corpse(corpstable);
  return true;
}

function private function_103d412a4079b9a(corpstable, attacker, hitloc) {
  function_988bd2fed09e41c("j_spineupper", "spider_fatal");
  delete_corpse(corpstable);
  return true;
}

function private function_f98648e1dc6e63cf(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "easter_limb", "easter_torso", "easter_head");
  } else {
    function_687ba52e53e097ac(corpstable, "easter_nogore_limb", "easter_nogore_torso", "easter_nogore_head");
  }

  return true;
}

function private function_f3274abe8bbcac04(corpstable, attacker, hitloc) {
  function_dfcee2ebe02a6ae7(corpstable, "electricAnime");
  return false;
}

function private function_52506c3cfde54aa7(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "scifi_limb", "scifi_torso", "scifi_head");
  function_988bd2fed09e41c("tag_origin", "scifi_origin");
  return true;
}

function private function_38f459f70ea411a7(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "scifi2_limb", "scifi2_torso", "scifi2_head");
  function_988bd2fed09e41c("tag_origin", "scifi2_origin");
  return true;
}

function private function_2d04b4ad2bc66462(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "scifi3_limb", "scifi3_torso", "scifi3_head");
  function_988bd2fed09e41c("tag_origin", "scifi3_origin");
  return true;
}

function private function_fd4087de9db4cdf1(corpstable, attacker, hitloc) {
  function_988bd2fed09e41c("j_spineupper", "420_death");
  return false;
}

function private function_a02b4e369b2cbcb3(corpstable, attacker, hitloc) {
  function_988bd2fed09e41c("j_spineupper", "hitscan");
  return false;
}

function private function_5ba1ecaf98dccff2(corpstable, attacker, hitloc) {
  delete_corpse(corpstable);
  return true;
}

function private function_24b135168cc16df3(corpstable, attacker, hitloc) {
  if(hitloc == "head" || hitloc == "helmet") {
    delete_corpse(corpstable);
    return true;
  }

  return false;
}

function private function_3e92a8e47dbf91aa(corpstable, attacker, hitloc) {
  function_988bd2fed09e41c("tag_origin", "thor");
  function_988bd2fed09e41c("j_spineupper", "thor_chest");
  delete_corpse(corpstable);
  return true;
}

function private function_bdcfc88e185572c8(corpstable, attacker, hitloc) {
  function_dfcee2ebe02a6ae7(corpstable, "kd");
  return false;
}

function private function_1ebe98051052c08(corpstable, attacker, hitloc) {
  function_dfcee2ebe02a6ae7(corpstable, "cdl");
  return false;
}

function private function_362790d530cb554f(corpstable, attacker, hitloc) {
  deletebody = 0;
  function_687ba52e53e097ac(corpstable, "soulEater_limb", "soulEater_torso", "soulEater_head", undefined, deletebody);
  function_988bd2fed09e41c("tag_origin", "soulEater_death");
  attacker thread function_694e1b7805093c52(corpstable);
  return deletebody;
}

function private function_ff45d70ef7fd700a(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "crash_limb", "crash_torso", "crash_head");
  return true;
}

function private function_a93d4e4d31895d77(corpstable, attacker, hitloc) {
  function_988bd2fed09e41c("tag_origin", "akihabara_fatal");
  delete_corpse(corpstable);
  return true;
}

function private function_836e832ef348cb0c(corpstable, attacker, hitloc) {
  if(corpstable isscriptable()) {
    corpstable setscriptablepartstate("burning", "flareup", 0);
  }

  return false;
}

function private function_f6820874f2f4b7fa(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "cthulhu_limb", "cthulhu_torso", "cthulhu_head");
  } else {
    function_687ba52e53e097ac(corpstable, "cthulhu_nogore_limb", "cthulhu_nogore_torso", "cthulhu_nogore_head");
  }

  return true;
}

function private function_487ad6a4de40bcf5(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "hlander_limb", "hlander_torso", "hlander_head");
  } else {
    function_687ba52e53e097ac(corpstable, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head");
  }

  return true;
}

function private function_ae90d417fbdba2a9(corpstable, attacker, hitloc) {
  if(hitloc == "head") {
    function_dfcee2ebe02a6ae7(corpstable, "bnoir_head");
  } else {
    function_dfcee2ebe02a6ae7(corpstable, "bnoir");
  }

  return false;
}

function private function_ce2c35cf68d5b3fc(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "golden_gun_limb", "golden_gun_torso", "golden_gun_head");
  function_988bd2fed09e41c("tag_origin", "golden_gun_origin");
  return true;
}

function private function_98c6559ade501e3d(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "nicki_limb", "nicki_torso", "nicki_head");
  return true;
}

function private function_e6385720c367c132(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "ice_limb", "ice_torso", "ice_head");
  } else {
    function_687ba52e53e097ac(corpstable, "ice_nogore_limb", "ice_nogore_torso", "ice_head");
  }

  return true;
}

function private function_bd496cb5c609ebef(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "tomb_limb", "tomb_torso", "tomb_head");
  } else {
    function_687ba52e53e097ac(corpstable, "tomb_limb_nogore", "tomb_torso_nogore", "tomb_head_nogore");
  }

  return true;
}

function private function_cdad06c807f2982b(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "hips_limb", "hips_torso", "hips_head");
  return true;
}

function private function_c05b05634b8bf729(corpstable, attacker, hitloc) {
  function_687ba52e53e097ac(corpstable, "hops_limb", "hops_torso", "hops_head");
  return true;
}

function private function_8e8a14ae1d93c4ea(corpstable, attacker, hitloc) {
  function_dfcee2ebe02a6ae7(corpstable, "blunt");
  return false;
}

function private function_54ed38d3b5ac6140(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "maze_limb", "maze_torso", "maze_head");
  } else {
    function_687ba52e53e097ac(corpstable, "maze_nogore_limb", "maze_nogore_torso", "maze_nogore_head");
  }

  return true;
}

function private function_5e562c7c6cd5fbe9(corpstable, attacker, hitloc) {
  function_988bd2fed09e41c("j_spine4", "lilith");
  delete_corpse(corpstable);
  return true;
}

function private function_d88414c7e331856(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "aluc_limb", "aluc_torso", "aluc_head");
  } else {
    function_687ba52e53e097ac(corpstable, "aluc_nogore_limb", "aluc_nogore_torso", "aluc_nogore_head");
  }

  return true;
}

function private function_5e575cb31776c32f(corpstable, attacker, hitloc) {
  return false;
}

function private function_8542d26e5ac6c50c(inflictor) {
  if(isinflictorstucktoplayer(inflictor, self, "equip_bunkerbuster")) {
    return true;
  }

  return false;
}

function private function_ce7272acb57aac2a(corpstable) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "hlander_limb", "hlander_torso", "hlander_head");
    return 1;
  }

  return 0;
}

function private function_694e1b7805093c52(corpstable) {
  soulent = spawn("script_model", corpstable.origin + (0, 0, 40));
  soulent setModel("vfx_scriptable_souleater");
  soulent function_fca5bdbe24070d20("soulEater", self.team);
  self.var_e7a9752e4f4c7d97["soul_ents_in_flight"] = array_add(self.var_e7a9752e4f4c7d97["soul_ents_in_flight"], soulent);
  success = function_f9ffc273b1f19a07(soulent);

  if(istrue(success)) {
    thread function_54eaad56eecc69e2();
  } else {
    function_671264d7659ab6ab(soulent);
  }

  if(isDefined(soulent)) {
    if(isDefined(self) && isDefined(self.var_e7a9752e4f4c7d97)) {
      self.var_e7a9752e4f4c7d97["soul_ents_in_flight"] = array_remove(self.var_e7a9752e4f4c7d97["soul_ents_in_flight"], soulent);
    }

    soulent delete();
  }
}

function private function_c30cfdffd08468e1() {
  self notify("stop_soulweapon_swap_logic");
  self endon("stop_soulweapon_swap_logic");
  self endon("death_or_disconnet");
  level endon("game_ended");

  while(true) {
    self waittill("weapon_switch_started", weapon);

    if(!function_41e8cf00b189fe93(weapon)) {
      self notify("stop_soul_suck");
    }
  }
}

function private function_f9ffc273b1f19a07(soulent) {
  self endon("death_or_disconnet");
  level endon("game_ended");
  var_27b0c9ac22b57a8a = gettime();
  movetime = function_2a5698d5505f5108(soulent);
  hovertime = function_e7680a7e93beee63(soulent, var_27b0c9ac22b57a8a, movetime);
  destinationtime = var_27b0c9ac22b57a8a + movetime + hovertime;
  soulent.destinationtime = destinationtime;
  soulent setscriptablepartstate("soulEater", "hover");
  soulent moveTo(soulent.origin + (0, 0, 15), 0.7);
  wait hovertime / 1000;
  soulent setscriptablepartstate("soulEater", "suck");
  var_9f854e807c5cd5ac = gettime();
  zoffsetmax = undefined;
  yoffsetmax = undefined;
  zoffset = undefined;
  yoffset = undefined;
  baseorigin = soulent.origin;
  thread function_1dec486d84b0373(soulent, movetime);

  while(true) {
    if(!isDefined(self)) {
      return false;
    }

    timepassed = gettime() - var_9f854e807c5cd5ac;
    remainingtime = movetime - timepassed;
    timefraction = min(1, (timepassed + level.frameduration) / movetime);
    timeslice = level.frameduration * timefraction;

    if(remainingtime > timeslice) {
      movefraction = timeslice / remainingtime;
    } else {
      movefraction = 1;
    }

    if(remainingtime <= 0) {
      break;
    }

    var_f16cf0133810cf98 = factor_value(5, 0, self playerads());
    f = anglesToForward(self getplayerangles()) * 20;
    u = anglestoup(self getplayerangles()) * -9;
    r = anglestoright(self getplayerangles()) * var_f16cf0133810cf98;
    targetorigin = self getEye() + f + u + r;
    vectotarget = targetorigin - baseorigin;
    dirtotarget = vectorNormalize(vectotarget);
    dist = length(vectotarget);

    if(!isDefined(zoffsetmax)) {
      zoffsetmax = function_f9bc9077b9e35705(dist);
      yoffsetmax = randomfloatrange(-1.5, 1.5) * zoffsetmax;
    }

    zoffset = function_aeac529c62ced2c0(movetime, timepassed + level.frameduration, zoffsetmax);
    yoffset = function_aeac529c62ced2c0(movetime, timepassed + level.frameduration, yoffsetmax);
    dirr = rotatevector(dirtotarget, (0, 90, 0));
    yoffset = dirr * yoffset;
    zoffset = (0, 0, zoffset);
    offset = dist * movefraction * dirtotarget;
    baseorigin += offset;
    soulent.origin = baseorigin + zoffset + yoffset;
    waitframe();
  }

  return true;
}

function private function_2a5698d5505f5108(soulent) {
  dist = length(soulent.origin - self.origin);
  factor = normalize_value(300, 2000, dist);
  return factor_value(0.4, 1, factor) * 1000;
}

function private function_e7680a7e93beee63(soulent, var_27b0c9ac22b57a8a, movetime) {
  self.var_e7a9752e4f4c7d97["soul_ents_in_flight"] = array_removeundefined(self.var_e7a9752e4f4c7d97["soul_ents_in_flight"]);
  var_8b7e3d529e9eec0c = 700;

  if(self.var_e7a9752e4f4c7d97["soul_ents_in_flight"][0] == soulent) {
    return var_8b7e3d529e9eec0c;
  }

  var_2394d10885bad3ee = self.var_e7a9752e4f4c7d97["soul_ents_in_flight"][self.var_e7a9752e4f4c7d97["soul_ents_in_flight"].size - 2].destinationtime - var_27b0c9ac22b57a8a;
  var_b2caae9952cee2f5 = var_2394d10885bad3ee + 300;
  var_6957fe7344a1b0bc = var_b2caae9952cee2f5 - movetime * 1000;
  return max(var_8b7e3d529e9eec0c, var_6957fe7344a1b0bc);
}

function function_f9bc9077b9e35705(var_9c81708edcfd5d10) {
  factor = normalize_value(300, 1000, var_9c81708edcfd5d10);
  return factor_value(7, 25, factor);
}

function function_aeac529c62ced2c0(movetime, timepassed, offsetmax) {
  if(timepassed > movetime) {
    return 1;
  }

  halfmovetime = movetime * 0.5;

  if(timepassed > halfmovetime) {
    frac = (timepassed - halfmovetime) / halfmovetime;
  } else {
    frac = timepassed / halfmovetime;
    frac = 1 - frac;
  }

  frac *= frac;
  frac = 1 - frac;
  return frac * offsetmax;
}

function private function_54eaad56eecc69e2() {
  self endon("death_or_disconnet");
  level endon("game_ended");
  function_a2ff3959a0b6827e("reactive_soul_collect");
  self.var_e7a9752e4f4c7d97["souls_collected_count"]++;

  if(isDefined(self.currentweapon) && function_78edd771b80bb678(self.currentweapon)) {
    function_b92e7556d13a2d52();
  }

  wait 0.3;
  function_ba3a5a6cdabc71f0("reactive_soul_collect_1stage");
}

function private function_671264d7659ab6ab(soulent) {
  soulent setscriptablepartstate("soulEater", "vanish");
}

function private unlinkequipment(corpstable) {
  linkedchildren = corpstable getlinkedchildren();

  foreach(child in linkedchildren) {
    if(istrue(child.iscrossbowbolt)) {
      child scripts\cp_mp\crossbow::boltunlink();
      child notify("unlinkBolt");
    }

    if(isDefined(child.equipmentref)) {
      switch (child.equipmentref) {
        case #"hash_8df9cfc147eb2d86":
        case #"hash_9ba0a6ff6081954e":
        case #"hash_de4641ddbc44a7ba":
        case #"hash_e156752cb79526e8":
        case #"hash_f0907f858c134cb4":
          child unlink();
          break;
        default:
          break;
      }
    }
  }
}

function private function_1dec486d84b0373(ent, movetime) {
  self endon("death_or_disconnet");
  level endon("game_ended");
  delay_time = (movetime - 300) / 1000;
  wait delay_time;

  if(getomnvar("ui_firing_range_has_started") == 1) {
    self playSound("iw9_weap_mtx_souleater_absorb");
    return;
  }

  if(isDefined(self.team)) {
    self playsoundtoteam("iw9_weap_mtx_souleater_absorb", self.team, undefined, self);
    return;
  }

  self playsoundtoplayer("iw9_weap_mtx_souleater_absorb", self);
}

function private function_687ba52e53e097ac(corpstable, limbfx, torsofx, headfx, sfx, deletebody) {
  if(!isDefined(deletebody)) {
    deletebody = 1;
  }

  function_988bd2fed09e41c("j_shoulder_ri", limbfx);
  function_988bd2fed09e41c("j_shoulder_le", limbfx);
  function_988bd2fed09e41c("j_elbow_ri", limbfx);
  function_988bd2fed09e41c("j_elbow_le", limbfx);
  function_988bd2fed09e41c("j_hip_ri", limbfx);
  function_988bd2fed09e41c("j_hip_le", limbfx);
  function_988bd2fed09e41c("j_knee_ri", limbfx);
  function_988bd2fed09e41c("j_knee_le", limbfx);
  function_988bd2fed09e41c("j_spineupper", torsofx);
  function_988bd2fed09e41c("j_head", headfx);

  if(isDefined(sfx)) {
    self playSound(sfx);
  }

  if(istrue(deletebody)) {
    delete_corpse(corpstable);
  }
}

function private function_dfcee2ebe02a6ae7(corpstable, state) {
  if(corpstable isscriptable()) {
    corpstable setscriptablepartstate("mtxDeath", state, 0);
  }
}

function private delete_corpse(corpstable) {
  if(!isDefined(corpstable)) {
    return;
  }

  unlinkequipment(corpstable);

  if(isDefined(corpstable.targetname) && corpstable.targetname == "player_corpse") {
    corpstable hide();
    return;
  }

  if(isagent(self)) {
    thread function_faa96c1d7a25fc9c(corpstable);
  }
}

function private function_faa96c1d7a25fc9c(corpsetable) {
  waitframe();

  if(isDefined(corpsetable)) {
    corpsetable delete();
  }
}

function private function_988bd2fed09e41c(tag, fx) {
  if(self tagexists(tag)) {
    org = self gettagorigin(tag);
    ang = self gettagangles(tag);
    playFX(level._effect[fx], org, anglesToForward(ang), anglestoup(ang));
  }
}

function private function_5b5e6de151e0fecd(name, value) {
  function_3bd8d57c42967dfc();

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"])) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"] = [];
  }

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"][name])) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_ids"][name] = value;
  }
}

function private function_4fa6004e1f4bd807(name, value) {
  function_3bd8d57c42967dfc();

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"])) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"] = [];
  }

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"][name])) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"][name] = value;
  }
}

function private function_68444e56728a13a6(name, value) {
  function_3bd8d57c42967dfc();

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"])) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_toggle_ids"] = [];
  }

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_scriptable_generic_ids"][name])) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_toggle_ids"][name] = "toggle0";
  }
}

function private function_35c927994920a75(name, value) {
  function_3bd8d57c42967dfc();

  if(!isDefined(self.var_e7a9752e4f4c7d97[name])) {
    self.var_e7a9752e4f4c7d97[name] = value;
  }
}

function private function_3bd8d57c42967dfc() {
  if(!isDefined(self.var_e7a9752e4f4c7d97)) {
    self.var_e7a9752e4f4c7d97 = [];
  }
}

function private function_d4e4935b9938f870() {
  self.var_e7a9752e4f4c7d97["is_throwing_grenade"] = 0;
  self.var_e7a9752e4f4c7d97["kill_streak"] = 0;
  self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] = 0;
  self.var_e7a9752e4f4c7d97["reactive_kills"] = self.var_e7a9752e4f4c7d97["match_kills"];
  self.var_e7a9752e4f4c7d97["vfx_scriptable_disablers"] = [];
  self.var_e7a9752e4f4c7d97["souls_collected_count"] = 0;
}

function private function_488022f64344d044(currentkills, targetkills) {
  if(currentkills >= targetkills) {
    return true;
  }

  return false;
}

function private function_f5e12ee66df3a2c2(ref) {
  self.var_e7a9752e4f4c7d97[ref]++;
}

function private function_6c5f91d778849d7c(ref) {
  self.var_e7a9752e4f4c7d97[ref] = 0;
}

function private function_96be6291f27c1e20() {
  setDvar(@ "hash_a0c0a5bf060c7bf2", -1);
  setDvar(@ "hash_e5d7c5b83ec14d85", -1);
  setDvar(@ "hash_cf86c6012f506ac8", -1);
  setDvar(@ "hash_dca6459901f0f758", -1);
  setDvar(@ "hash_beff73861be066d", -1);
  setDvar(@ "hash_4db0d2c2cd85d418", -1);
  setDvar(@ "hash_2391c05a8700227f", -1);
  setDvar(@ "hash_e001a97b368816c9", -1);
  setDvar(@ "hash_8d73f9a1e40b4f01", -1);
  setDvar(@ "hash_2ebdafd7eec10a70", -1);
  setDvar(@ "hash_d5bfe694a8598141", -1);
  setDvar(@ "hash_d5b99091b7c0443e", -1);
  var_bce73f6463c9b237 = -1;
  var_b43d15be227caed0 = -1;
  var_94c3e91284196d06 = -1;
  var_4283931c53ed41b0 = -1;
  movementstate = -1;
  var_683e84a7ba8a976f = -1;
  var_40631789cc951deb = -1;

  while(true) {
    var_bce73f6463c9b237 = function_50ea8811ea838718("<dev string:x1eb>", @ "hash_a0c0a5bf060c7bf2", var_bce73f6463c9b237);
    var_b43d15be227caed0 = function_50ea8811ea838718("<dev string:x207>", @ "hash_e5d7c5b83ec14d85", var_b43d15be227caed0);
    var_94c3e91284196d06 = function_50ea8811ea838718("<dev string:x223>", @ "hash_dca6459901f0f758", var_94c3e91284196d06);
    var_4283931c53ed41b0 = function_50ea8811ea838718("<dev string:x244>", @ "hash_cf86c6012f506ac8", var_4283931c53ed41b0);
    movementstate = function_50ea8811ea838718("<dev string:x261>", @ "hash_beff73861be066d", movementstate);
    var_683e84a7ba8a976f = function_50ea8811ea838718("<dev string:x273>", @ "hash_e001a97b368816c9", var_683e84a7ba8a976f);
    var_40631789cc951deb = function_50ea8811ea838718("<dev string:x29c>", @ "hash_8d73f9a1e40b4f01", var_40631789cc951deb);
    function_4c07717228f2249b("<dev string:x2b1>", @ "hash_4db0d2c2cd85d418");
    function_4c07717228f2249b("<dev string:x2bf>", @ "hash_2391c05a8700227f");
    waitframe();
  }
}

function private function_50ea8811ea838718(key, dvar, var_61a9be095f4f77ea) {
  if(getdvarint(dvar) != var_61a9be095f4f77ea) {
    foreach(player in level.players) {
      player function_ba3a5a6cdabc71f0(key);
    }
  }

  return getdvarint(dvar);
}

function private function_4c07717228f2249b(key, dvar) {
  if(getdvarint(dvar) > -1) {
    foreach(player in level.players) {
      player function_a2ff3959a0b6827e(key);
    }
  }

  setDvar(dvar, -1);
}

# /