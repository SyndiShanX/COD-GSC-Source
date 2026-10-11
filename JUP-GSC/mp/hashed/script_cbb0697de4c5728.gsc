/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_cbb0697de4c5728.gsc
************************************************/

#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\utility\perk_shared;
#namespace namespace_e2785bb1da360f91;

function function_3b59b4d385a202e6() {
  level.var_fb690b0442393f26 = [];
  level.var_f075b3a145f1c730 = [];
  level.var_7546f688873b4ce4 = [];
  level.var_6dd6ceac39b4f8f3 = [];
  level.var_15f270e2898482be = [];
  level.var_d83ca3f3bdf5b3d4 = [];
  level.var_a3d1147a42b2fd91 = [];
  level.var_88c1332fb32e977c = [];
  level.var_e65f4101fd50a0e1 = [];
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
  level._effect["bcell6_limb"] = loadfx("vfx/iw9/core/operators/reactive/bcell6/vfx_mtx_fatal_explode_limb_bcell6");
  level._effect["bcell6_torso"] = loadfx("vfx/iw9/core/operators/reactive/bcell6/vfx_mtx_fatal_explode_torso_bcell6");
  level._effect["bcell6_head"] = loadfx("vfx/iw9/core/operators/reactive/bcell6/vfx_mtx_fatal_explode_head_bcell6");
  level._effect["lilith"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_lilith_fatal");
  level._effect["inarius"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_inarius_fatal");
  level._effect["witch"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/witch_s6/vfx_imp_witch_fatal.vfx");
  level._effect["zombie"] = loadfx("vfx/iw9/core/weapons/impacts/mtx/zombie_s6/vfx_imp_zombie_fatal.vfx");
  level._effect["boys_super_str"] = loadfx("vfx/jup/weapon/_mtx/s1/death/all_purpose_dismemberment/vfx_death_mtx_s1_super_str_01.vfx");

  if(getdvarint(@ "hash_771e48f03b5eb348", 0) == 0) {
    level._effect["40k"] = loadfx("vfx/jup/weapon/_mtx/s2/impact/40k/vfx_imp_mtx_s2_40k_flesh_fatal.vfx");
  } else {
    level._effect["40k"] = loadfx("vfx/jup/weapon/_mtx/s2/death/warhammer40k/vfx_death_mtx_s2_40k_torso_01_nogib.vfx");
  }

  level._effect["blackcell"] = loadfx("vfx/jup/weapon/_mtx/s3/impact/blackcell/vfx_imp_mtx_s3_blackcell_flesh_fatal.vfx");
  level._effect["underworld"] = loadfx("vfx/jup/weapon/_mtx/s6/impact/underworld/vfx_imp_mtx_s6_underworld_flesh_fatal.vfx");
  level._effect["wonton"] = loadfx("vfx/jup/weapon/_mtx/s4/impact/dough_wonton/vfx_imp_mtx_s4_dough_wonton_melee_flesh_fatal.vfx");
  level._effect["mandu"] = loadfx("vfx/jup/weapon/_mtx/s4/impact/dough_mandu/vfx_imp_mtx_s4_dough_mandu_melee_flesh_fatal.vfx");
  level._effect["blackcell_s5"] = loadfx("vfx/jup/weapon/_mtx/s5/impact/blackcell/vfx_imp_mtx_s5_blackcell_melee_flesh_fatal.vfx");
  level._effect["gilman"] = loadfx("vfx/jup/weapon/_mtx/s5/impact/entagled/vfx_imp_mtx_s5_entagled_flesh_fatal.vfx");
  level._effect["shapechanger"] = loadfx("vfx/jup/weapon/_mtx/s5/impact/shapechanger/vfx_imp_mtx_s5_shapechanger_melee_flesh_fatal.vfx");
  level._effect["tonfa"] = loadfx("vfx/jup/weapon/_mtx/s2/impact/tonfa/vfx_imp_mtx_s2_tonfa_flesh_fatal.vfx");
  level._effect["bikeMelee"] = loadfx("vfx/jup/weapon/_mtx/s2/impact/michonne/vfx_imp_mtx_s2_michonne_flesh_fatal.vfx");
  level._effect["vinyl"] = loadfx("vfx/jup/weapon/_mtx/s5/impact/vinyl/vfx_imp_mtx_s5_vinyl_flesh_fatal.vfx");
  level._effect["vinyl_heavy"] = loadfx("vfx/jup/weapon/_mtx/s5/impact/vinyl/vfx_imp_mtx_s5_vinyl_flesh_fatal_melee.vfx");
  level._effect["pineapple"] = loadfx("vfx/jup/equipment/_mtx/s3/vfx_equip_thermo_pineapple_flesh_fatal.vfx");
  level._effect["voxel"] = loadfx("vfx/jup/weapon/_mtx/s1/impact/arcade/vfx_imp_mtx_s1_arcade_flesh_fatal.vfx");
  level._effect["oreZincMelee"] = loadfx("vfx/jup/weapon/_mtx/s6/impact/orezinc/vfx_imp_mtx_s6_orezinc_melee_flesh_fatal.vfx");
  level._effect["mahou_limb"] = loadfx("vfx/jup/weapon/_mtx/s6/death/echoendo_mahou/vfx_death_mtx_s6_mahou_exp_limb");
  level._effect["mahou_torso"] = loadfx("vfx/jup/weapon/_mtx/s6/death/echoendo_mahou/vfx_death_mtx_s6_mahou_exp_torso");
  level._effect["mahou_head"] = loadfx("vfx/jup/weapon/_mtx/s6/death/echoendo_mahou/vfx_death_mtx_s6_mahou_exp_head");
  level._effect["mahou_origin"] = loadfx("vfx/jup/weapon/_mtx/s6/death/echoendo_mahou/vfx_death_mtx_s6_mahou_exp_mesh");

  if(getdvarint(@ "mgl", 0) != 0) {
    level._effect["sbandit_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_flesh_ftl_bdt");
    level._effect["spider_fatal"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_death_mtx_alpha50_spider");
    level._effect["sbandit_limb"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_sbandit_limb");
    level._effect["sbandit_torso"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_sbandit_torso");
    level._effect["sbandit_head"] = loadfx("vfx/mgl/iw9/core/weapons/impacts/mtx/vfx_imp_mtx_sbandit_head");
  }

  function_308f735a299221e3(#"naughtydeath", &function_36f3c1f20204b13);
  function_308f735a299221e3(#"nicedeath", &function_777c1f2e7f15d92e);
  function_308f735a299221e3(#"vday", &function_337b80f7ff25b0c9);
  function_308f735a299221e3(#"pshock", &function_f7bca22a37224d8b);
  function_308f735a299221e3(#"bcell", &function_1a406edd298ed8ad);
  function_308f735a299221e3(#"paddy", &function_583f9260e6221231);
  function_308f735a299221e3(#"shredder", &function_1b5dfb950d2e6dd2);
  function_308f735a299221e3(#"sbandit", &function_436125459cf039e);
  function_308f735a299221e3(#"spider", &function_103d412a4079b9a);
  function_308f735a299221e3(#"hash_7f02ad5bac60414e", &function_731555c8bf961fae);
  function_308f735a299221e3(#"electricAnime", &function_f3274abe8bbcac04);
  function_308f735a299221e3(#"easter", &function_f98648e1dc6e63cf);
  function_308f735a299221e3(#"scifi", &function_52506c3cfde54aa7);
  function_308f735a299221e3(#"scifi2", &function_38f459f70ea411a7);
  function_308f735a299221e3(#"scifi3", &function_2d04b4ad2bc66462);
  function_308f735a299221e3(#"420", &function_fd4087de9db4cdf1);
  function_308f735a299221e3(#"hitscan", &function_a02b4e369b2cbcb3);
  function_308f735a299221e3(#"thor", &function_3e92a8e47dbf91aa);
  function_308f735a299221e3(#"kd", &function_bdcfc88e185572c8);
  function_308f735a299221e3(#"cdl", &function_1ebe98051052c08);
  function_308f735a299221e3(#"soulEater", &function_362790d530cb554f);
  function_308f735a299221e3(#"crash", &function_ff45d70ef7fd700a);
  function_308f735a299221e3(#"akihabara", &function_a93d4e4d31895d77);
  function_308f735a299221e3(#"magma", &function_836e832ef348cb0c);
  function_308f735a299221e3(#"cthulhu", &function_f6820874f2f4b7fa);
  function_308f735a299221e3(#"hlander", &function_487ad6a4de40bcf5);
  function_308f735a299221e3(#"bnoir", &function_ae90d417fbdba2a9);
  function_308f735a299221e3(#"nicki", &function_98c6559ade501e3d);
  function_308f735a299221e3(#"ice", &function_e6385720c367c132);
  function_308f735a299221e3(#"traider", &function_bd496cb5c609ebef);
  function_308f735a299221e3(#"hips", &function_cdad06c807f2982b);
  function_308f735a299221e3(#"hops", &function_c05b05634b8bf729);
  function_308f735a299221e3(#"blunt", &function_8e8a14ae1d93c4ea);
  function_308f735a299221e3(#"maze", &function_54ed38d3b5ac6140);
  function_308f735a299221e3(#"witch", &function_5ba1ecaf98dccff2);
  function_308f735a299221e3(#"zombie", &function_24b135168cc16df3);
  function_308f735a299221e3(#"zombiegun", &function_487ad6a4de40bcf5);
  function_308f735a299221e3(#"skeletor", &function_37d7885e81477f70);
  function_308f735a299221e3(#"bcell6", &function_88e7906b3427ca1);
  function_308f735a299221e3(#"inarius", &function_7ea50d23ae130cca);
  function_308f735a299221e3(#"lilith", &function_5e562c7c6cd5fbe9);
  function_308f735a299221e3(#"souleatermelee", &function_362790d530cb554f);
  function_308f735a299221e3(#"noirmelee", &function_ae90d417fbdba2a9);
  function_308f735a299221e3(#"icemelee", &function_e6385720c367c132);
  function_308f735a299221e3(#"traidermelee", &function_bd496cb5c609ebef);
  function_308f735a299221e3(#"souleaterequip", &function_362790d530cb554f);
  function_308f735a299221e3(#"iceequip", &function_e6385720c367c132);
  function_308f735a299221e3(#"40kMelee", &function_89a27655bbfbea5c);
  function_308f735a299221e3(#"underworldMelee", &function_fbca442210cadac5);
  function_308f735a299221e3(#"wontonMelee", &function_3575102fb05d4cfa);
  function_308f735a299221e3(#"manduMelee", &function_4ae2990535a30b9a);
  function_308f735a299221e3(#"blackcell_s5Melee", &function_6beb2bbbd9f7dc4f);
  function_308f735a299221e3(#"gilmanMelee", &function_b9809bbfc4cd08d7);
  function_308f735a299221e3(#"shapechangerMelee", &function_afaa1dd651d2194e);
  function_308f735a299221e3(#"bikeMelee", &function_a8091d16050e65c6);
  function_308f735a299221e3(#"pineapple", &function_d839e436b16f3db1);
  function_308f735a299221e3(#"tonfa", &function_a956d3177808f0cf);
  function_308f735a299221e3(#"vinyl", &function_ba43403ce60b1473);
  function_308f735a299221e3(#"voxel", &function_57e218ee6860ff4b);
  function_308f735a299221e3(#"oreZincMelee", &function_b18cdac40499535b);
  function_503e263494654df9("ufoSm", &function_e4f3eb6b0541db27, &function_487ad6a4de40bcf5);
  function_503e263494654df9("ufoLg", &function_2d38adc3714f681e, &function_487ad6a4de40bcf5);
  function_503e263494654df9("goldengun", &function_8dcf23df7efcf5f8, &function_ce2c35cf68d5b3fc);
  function_503e263494654df9("dna_nuke", &function_619788896abeee17, &function_dd7bd8ee508f606b);
  function_503e263494654df9("mahou", &function_8a2f3038f9212159, &function_e8aa098e64325e7d);
  function_503e263494654df9("hlander", &function_66bd08d233abc229, &function_487ad6a4de40bcf5);

  if(utility::callsharedfunc("game", "isBRStyleGameType")) {
    function_503e263494654df9("ww_dg2", &isdg2death, &function_2c8b06094bd3a868);
    function_503e263494654df9("ww_raygun", &israygundeath, &function_b0dff649bba1366f);
  }

  function_680b25ab00303a62("40kMeleeTakedown", &function_105e3a3402ae1039, &function_35ab6565907ce11d);
  function_680b25ab00303a62("underworldMeleeTakedown", &function_1006db730ae1210, &function_fbca442210cadac5);
  function_680b25ab00303a62("wontonMeleeTakedown", &function_2d09bb57cc70eed7, &function_3575102fb05d4cfa);
  function_680b25ab00303a62("manduMeleeTakedown", &function_36bd043b036e71bf, &function_4ae2990535a30b9a);
  function_680b25ab00303a62("blackcell_s5MeleeTakedown", &function_fce8fef00f721732, &function_6beb2bbbd9f7dc4f);
  function_680b25ab00303a62("gilmanMeleeTakedown", &function_74118f94fccd1e1a, &function_b9809bbfc4cd08d7);
  function_680b25ab00303a62("shapechangerMeleeTakedown", &function_bf2a377f5ab0611b, &function_afaa1dd651d2194e);
  function_ca61bb01d1162121("ubSawMelee", &function_3942ea0f6182ae35, &function_5c6dcf2e2d198cc1);
  function_cdb30168aa4ba6d3("lilithEx", &function_987daded215df4da, &function_5b42e2feab7a3aae);
  function_bd000d3682d66959("electricAnimeEquip", &function_1b44231f13746622, &function_f3274abe8bbcac04);
  function_a180a5874c8cbe0b("flameSkullCharm", &function_2627a7eaeb3541e5, &function_d0003cb59ba90631);
  function_a180a5874c8cbe0b("crystamSkullCharm", &function_1d7a9b121434df64, &function_9dba84e77ba81e68);
  function_a180a5874c8cbe0b("starlightCharm", &function_763547f85193043, &function_9e037532d806bfaf);
  function_a180a5874c8cbe0b("soulEaterCharm", &function_244de2be6dd725f3, &function_7ac629d7829da1df);
  function_a180a5874c8cbe0b("crowFootCharm", &function_f8fc0821696182c, &function_163fccf48f86ac68);
  function_a180a5874c8cbe0b("pumpkinLanternCharm", &function_1c12797023d624e5, &function_3e50a64bbd61b969);
  function_a180a5874c8cbe0b("weedCreatureCharm", &function_ce28357936d127f1, &function_67b827411821d1b1);
  function_a180a5874c8cbe0b("doomChainsaw", &isdoomchainsaw, &function_7f84cac49ac044c0);
  function_a180a5874c8cbe0b("chainsword", &ischainsword, &function_c4e6dc7009af3d67);
  function_a180a5874c8cbe0b("toothFairy", &function_bbf72e8bc3d1dfb2, &function_5132f333e5bbe24);
  function_a180a5874c8cbe0b("wonton_swhiskey", &function_a672596fca729e59, &function_aab1efb0d73d2f65);
  function_f585a90baef927bb("reactive_kill_streak_2stage", &function_7e8329133ea16786);
  function_f585a90baef927bb("reactive_kill_streak_3stage", &function_cf3fbbc7a8984419);
  function_f585a90baef927bb("reactive_kill_streak_4stage", &function_7e0b66f7fa28c728);
  function_f585a90baef927bb("reactive_match_kills_2stage", &function_882b5ea6e5345b31);
  function_f585a90baef927bb("reactive_soul_collect_1stage", &function_d05f99b2455baa0a);
  function_f585a90baef927bb("reactive_movement", &function_40c8094dda4e218f);
  function_f585a90baef927bb("reactive_enchantment", &function_7ec064f982949e9);
  function_f585a90baef927bb("reactive_kill_weapon_3stage", &function_3537cbd88e7ec6a8);
  function_f585a90baef927bb("reactive_downgradable_kill_streak_3stage", &function_777eed4426971f45);
  function_f585a90baef927bb("reactive_kill_cycle_3stage", &function_2c2b9e7001e5ad6b);
  function_f585a90baef927bb("reactive_spawn", &function_67002f2a3879a23b);
  function_f585a90baef927bb("reactive_black_cell_reveal", &function_a5eea442f31613f0);
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
  assertex(!isDefined(level.var_fb690b0442393f26[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
  level.var_fb690b0442393f26[sname] = fxfuncs;
}

function function_308f735a299221e3(var_c3730d8bae621a97, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_f075b3a145f1c730[var_c3730d8bae621a97]), "<dev string:x57>" + getxhashsourcename(var_c3730d8bae621a97) + "<dev string:x52>");
  level.var_f075b3a145f1c730[var_c3730d8bae621a97] = fxfuncs;
}

function function_ca61bb01d1162121(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_7546f688873b4ce4[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
  level.var_7546f688873b4ce4[sname] = fxfuncs;
}

function function_680b25ab00303a62(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_6dd6ceac39b4f8f3[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
  level.var_6dd6ceac39b4f8f3[sname] = fxfuncs;
}

function function_cdb30168aa4ba6d3(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_15f270e2898482be[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
  level.var_15f270e2898482be[sname] = fxfuncs;
}

function function_bd000d3682d66959(sname, conditionfunc, var_7b85d041fe0490b6) {
  fxfuncs = spawnStruct();
  fxfuncs.conditions = conditionfunc;
  fxfuncs.deatheffect = var_7b85d041fe0490b6;
  assertex(!isDefined(level.var_d83ca3f3bdf5b3d4[sname]), "<dev string:x1c>" + sname + "<dev string:x52>");
  level.var_d83ca3f3bdf5b3d4[sname] = fxfuncs;
}

function function_a180a5874c8cbe0b(sname, var_76db26f25e7dbac7, var_ba46ec67c5caf4a2) {
  var_7bdc9702e6500422 = spawnStruct();
  var_7bdc9702e6500422.var_d7d02abbc34dd7d2 = var_76db26f25e7dbac7;
  var_7bdc9702e6500422.var_ba46ec67c5caf4a2 = var_ba46ec67c5caf4a2;

  function_7e5803a5e15369eb(sname);

  level.var_a3d1147a42b2fd91[sname] = var_7bdc9702e6500422;
}

function function_f585a90baef927bb(sname, var_ba46ec67c5caf4a2) {
  var_7bdc9702e6500422 = spawnStruct();
  var_7bdc9702e6500422.var_ba46ec67c5caf4a2 = var_ba46ec67c5caf4a2;

  function_7e5803a5e15369eb(sname);

  level.var_e65f4101fd50a0e1[sname] = var_7bdc9702e6500422;
}

function function_144b37d5935ee55e(sname, var_ba46ec67c5caf4a2) {
  var_7bdc9702e6500422 = spawnStruct();

  function_7e5803a5e15369eb(sname);

  level.var_1c6c766b95b77e8a[sname] = var_7bdc9702e6500422;
}

function function_7e5803a5e15369eb(sname) {
  assertex(!isDefined(level.var_a3d1147a42b2fd91[sname]), "<dev string:x8d>" + sname + "<dev string:x52>");
  assertex(!isDefined(level.var_e65f4101fd50a0e1[sname]), "<dev string:x8d>" + sname + "<dev string:x52>");
  assertex(!isDefined(level.var_1c6c766b95b77e8a[sname]), "<dev string:x8d>" + sname + "<dev string:x52>");
}

function function_a92b5d21a4b45b0() {
  level.var_40e77024dc6bae59 = [];

  if(!isDefined(level.mapname)) {
    level.mapname = getDvar(@ "g_mapname");
  }

  if(issubstr(level.mapname, "frontend")) {
    level.var_40e77024dc6bae59["match_kill_thresholds_2stage"] = [2, 4];
    level.var_40e77024dc6bae59["kill_streak_thresholds_2stage"] = [2, 4];
    level.var_40e77024dc6bae59["kill_streak_thresholds_3stage"] = function_d4e38ad2ae67fd38();
    level.var_40e77024dc6bae59["kill_streak_thresholds_4stage"] = function_787f4c85c6096a43();
    level.var_40e77024dc6bae59["kill_streak_thresholds_souleater"] = 1;
    return;
  }

  level.var_40e77024dc6bae59["match_kill_thresholds_2stage"] = function_b7c399cd6018f474();
  level.var_40e77024dc6bae59["kill_streak_thresholds_2stage"] = function_15b4833097caf079();
  level.var_40e77024dc6bae59["kill_streak_thresholds_3stage"] = function_d4e38ad2ae67fd38();
  level.var_40e77024dc6bae59["kill_streak_thresholds_4stage"] = function_787f4c85c6096a43();
  level.var_40e77024dc6bae59["kill_streak_thresholds_souleater"] = function_68b32b8d783a8ca2();
  level.var_40e77024dc6bae59["downgradable_kill_streak_thresholds_3stage"] = function_287113bfbe3cbd0c();
}

function function_c72573fb42d0cdbc() {
  function_48acda7f56f30aab();
  function_dcc407f619256c57();
  function_84690613abc67792();
  thread function_594d892a4842d30c();
}

function function_48acda7f56f30aab() {
  if(!function_2947be89ddf09115()) {
    function_35c927994920a75("match_kills", 0);
    function_35c927994920a75("kill_streak", 0);
    function_35c927994920a75("reactive_kills", 0);
    function_35c927994920a75("souls_collected_count", 0);
    function_35c927994920a75("ghost_radar_active", 0);
    function_35c927994920a75("ghost_finder_sucking", 0);
    function_35c927994920a75("downgradable_kill_streak", 0);
    function_35c927994920a75("kill_streak_weapon", []);
    function_35c927994920a75("movement_state", "neutral");
    function_35c927994920a75("all_scriptable_disablers", []);
    function_35c927994920a75("direct_scriptable_disablers", []);
    function_35c927994920a75("enchanted_weapons", []);
    function_35c927994920a75("soul_ents_in_flight", []);
    function_35c927994920a75("last_reactive_kill_time", -99999);
    function_35c927994920a75("last_reticle_kill_time", -99999);
    function_5b5e6de151e0fecd("neutral");
    function_6b2d1cc6bc7c8a90("neutral");

    foreach(scriptableid, var_7bdc9702e6500422 in level.var_e65f4101fd50a0e1) {
      function_4f0c5acd6343c0dd(scriptableid, "neutral");
    }

    foreach(scriptableid, var_7bdc9702e6500422 in level.var_1c6c766b95b77e8a) {
      function_68444e56728a13a6(scriptableid);
    }
  }

  if(isPlayer(self)) {
    thread function_bda6a04efd965c2f();
    thread function_b11087d46d884b84();
  }
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

function function_d4e38ad2ae67fd38() {
  return [1, 2, 3];
}

function function_787f4c85c6096a43() {
  return [2, 5, 7, 9];
}

function function_68b32b8d783a8ca2() {
  return 3;
}

function function_d0bec2a752eed0d4() {
  return [2, 5, 8];
}

function function_287113bfbe3cbd0c() {
  return [1, 2, 3];
}

function function_b939bc4f3a6d4fdc(weapon) {
  function_a71517a0b579ed46(weapon);
  function_cd88d52e8776b964(weapon);
  function_45f7158271bbf93();
  function_962fd936fb4491fa();
  function_b66fa33d64ba4010("reactive_kill_weapon_3stage");
  function_e6c5c00872a14e28();
  thread function_ff3fb5a24cfee6d();
}

function function_ff3fb5a24cfee6d() {
  self endon("death_or_disconnect");
  self endon("weapon_change");
  waitframe();
  function_79e98e41624be7fc();
  function_81837d4d838c9fe4();
}

function function_7c62c6c14aba289b() {
  function_48acda7f56f30aab();
  function_e6c5c00872a14e28();
  function_6631789b2a3abe3c();
}

function function_eceb462b367e4b04(deathdata) {
  if(isDefined(deathdata.attacker) && isPlayer(deathdata.attacker)) {
    deathdata.attacker function_5c55ca428dd7b66b(self, deathdata.objweapon, deathdata.meansofdeath, deathdata.direction_vec);
  }

  function_af1adc73dffafd19(deathdata.objweapon, deathdata.meansofdeath);
}

function function_1dd3a521ea9ecf27(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags) {
  return function_a952714a4c2f5c6f(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags);
}

function function_bbee2e46ab15a720(attacker, objweapon, meansofdeath, hitloc, inflictor) {
  if(isDefined(attacker) && isPlayer(attacker)) {
    attacker function_5c55ca428dd7b66b(self, objweapon, meansofdeath, undefined);
  }

  return function_a952714a4c2f5c6f(attacker, objweapon, meansofdeath, hitloc, inflictor);
}

function function_d7c5900c7d5bb0db(deathdata) {
  if(isDefined(deathdata.attacker) && isPlayer(deathdata.attacker)) {
    deathdata.attacker function_5c55ca428dd7b66b(self, deathdata.objweapon, deathdata.meansofdeath, undefined);
  }

  return function_a952714a4c2f5c6f(deathdata.attacker, deathdata.objweapon, deathdata.meansofdeath, deathdata.hitloc, deathdata.inflictor, deathdata.executionref, deathdata.damageflags);
}

function function_943511ab1f39db66() {
  self endon("death_or_disconnect");
  self endon("shockStick_haywireApplied");
  function_8f640a97343569f5("vfx_disabled_for_haywire");
  self waittill("haywire_cleared");
  wait 1;
  function_35f7e3fe1d9653bc("vfx_disabled_for_haywire");
}

function function_606fa08e3aac10d9() {
  function_8f640a97343569f5("vfx_disabled_for_jugg");
}

function function_cb5051bfab85d56a() {
  function_35f7e3fe1d9653bc("vfx_disabled_for_jugg");
}

function function_112e56b7dbe18137() {
  function_8f640a97343569f5("vfx_disabled_for_hiding");
}

function function_33637806fc5ac024() {
  function_35f7e3fe1d9653bc("vfx_disabled_for_hiding");
}

function function_92d9b05be48fe03e(entity) {
  return isDefined(entity) && isDefined(entity.model) && entity.model == "military_shooting_target_armor_01_assembly";
}

function function_8114951a631bd6a6() {
  return function_d05f99b2455baa0a();
}

function function_150370c11a6c880(objweapon) {
  deathfxname = function_c8f576b523885369(objweapon);

  if(isDefined(deathfxname)) {
    return (function_c8f576b523885369(objweapon) == #"souleaterequip");
  }

  return false;
}

function function_82d174d4613d34a(meansofdeath, objweapon) {
  if(getdvarint(@ "hash_2bb4e0ec793e3a4c", 1) && isbulletdeath(meansofdeath) && isDefined(objweapon) && function_e514ed60e2c9f9fc(objweapon) && function_f5897571e9a0f0eb(objweapon)) {
    return true;
  }

  return false;
}

function function_e514ed60e2c9f9fc(weapon) {
  if(!isDefined(weapon)) {
    return 0;
  }

  return function_b397fc136a6c84ea(weapon);
}

function function_d8804135c49fd481(objweapon) {
  deathfxname = function_c8f576b523885369(objweapon);

  if(isDefined(deathfxname)) {
    return (function_c8f576b523885369(objweapon) == #"zombiegun");
  }

  return false;
}

function function_b5f3de7931212cf5(idamage, victim) {
  if(getdvarint(@ "hash_f8094d20d531b0b5", 1)) {
    if(isDefined(victim)) {
      if(istrue(victim.zombie)) {
        idamage *= getdvarint(@ "hash_5c741bd119d504fe", 1);
      } else if(istrue(self.issmallufo)) {
        idamage *= getdvarint(@ "hash_5b0de654fa5013ba", 1);
      } else if(isDefined(victim.targetname) && victim.targetname == "veh9_ufo_lg") {
        idamage *= getdvarint(@ "hash_335d3b6aa7c7ac96", 1);
      } else if(isDefined(victim.targetname) && victim.targetname == "saba_orb") {
        idamage *= getdvarint(@ "hash_bbf4ac6f9293a467", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_mummy_minion") {
        idamage *= getdvarint(@ "hash_74b01cccd2b6aaf6", 1);
      } else if(isDefined(victim.agent_type) && (victim.agent_type == "actor_enemy_mp_ar_tier3_affected_ru" || victim.agent_type == "actor_enemy_mp_jugg_affected_ru")) {
        idamage *= getdvarint(@ "hash_4d810bff1f4993c4", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_swampmonster") {
        idamage *= getdvarint(@ "hash_6267ea49aa81a4d2", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_butcher") {
        idamage *= getdvarint(@ "hash_b85e4b9bc8f55a8d", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_mummy") {
        idamage *= getdvarint(@ "hash_ecffb3b94bcd65bd", 1);
      }
    }

    return idamage;
  }

  return idamage;
}

function function_6cebd056176c1511() {
  function_a2ff3959a0b6827e("reactive_soul_collect");
}

function function_4bed606f84dc5def() {
  if(self.var_e7a9752e4f4c7d97["ghost_radar_active"] && !self.var_e7a9752e4f4c7d97["ghost_finder_sucking"]) {
    self setscriptablepartstate("mtxVfxGunscreen", "ghostFinderActiveImmediate");
    self.var_e7a9752e4f4c7d97["ghost_finder_sucking"] = 1;
  }
}

function function_89f97780fe2db098() {
  if(self.var_e7a9752e4f4c7d97["ghost_finder_sucking"]) {
    self setscriptablepartstate("mtxVfxGunscreen", "neutral");
    self.var_e7a9752e4f4c7d97["ghost_finder_sucking"] = 0;
  }
}

function function_ab1746bef02556ab() {
  if(self.var_e7a9752e4f4c7d97["ghost_radar_active"]) {
    self setscriptablepartstate("mtxVfxGunscreenOneshot", "ghostFinderAbsorbed");
  }
}

function private function_a952714a4c2f5c6f(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags) {
  if(meansofdeath == "MOD_SUICIDE") {
    return 0;
  }

  if(!function_e4982c1d691edffb(self)) {
    return 0;
  }

  blueprintdeathfx = function_c8f576b523885369(objweapon);

  if(!isDefined(blueprintdeathfx) && getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
    blueprintdeathfx = #"voxel";
  }

  if(isDefined(blueprintdeathfx)) {
    assertex(isDefined(level.var_f075b3a145f1c730[blueprintdeathfx]), "<dev string:xc6>" + getxhashsourcename(blueprintdeathfx) + "<dev string:xd3>");
  }

  if(isbulletdeath(meansofdeath) || iscrushdeath(meansofdeath)) {
    if(isDefined(blueprintdeathfx)) {
      bodydeleted = function_ea0ddc7ede7c87b7(level.var_f075b3a145f1c730, attacker, blueprintdeathfx, hitloc, damageflags);
    } else {
      bodydeleted = function_36d11b76451cdde1(level.var_fb690b0442393f26, attacker, objweapon, hitloc, damageflags);
    }

    return bodydeleted;
  } else if(ismeleedeath(meansofdeath)) {
    if(isDefined(blueprintdeathfx)) {
      return function_ea0ddc7ede7c87b7(level.var_f075b3a145f1c730, attacker, blueprintdeathfx, hitloc, damageflags);
    } else {
      return function_36d11b76451cdde1(level.var_7546f688873b4ce4, attacker, objweapon, hitloc, damageflags);
    }
  } else if(function_620cdf363f71a732(meansofdeath)) {
    return function_36d11b76451cdde1(level.var_6dd6ceac39b4f8f3, attacker, objweapon, hitloc, damageflags);
  } else if(isexecutiondeath(meansofdeath) && isDefined(executionref)) {
    objweapon = spawnStruct();
    objweapon.executionref = executionref;
    return function_36d11b76451cdde1(level.var_15f270e2898482be, attacker, objweapon, hitloc, damageflags);
  } else if(isequipmentdeath(meansofdeath)) {
    if(function_8542d26e5ac6c50c(inflictor)) {
      return function_ce7272acb57aac2a(self.body);
    }

    if(isDefined(blueprintdeathfx)) {
      if(blueprintdeathfx == #"blackcell_s5Melee") {
        return 0;
      } else if(blueprintdeathfx == #"gilmanMelee") {
        return 0;
      }

      return function_ea0ddc7ede7c87b7(level.var_f075b3a145f1c730, attacker, blueprintdeathfx, hitloc, damageflags);
    } else {
      return function_36d11b76451cdde1(level.var_d83ca3f3bdf5b3d4, attacker, objweapon, hitloc, damageflags);
    }
  } else if(isDefined(level.gametype) && level.gametype == "gold_gun") {
    bodydeleted = function_36d11b76451cdde1(level.var_fb690b0442393f26, attacker, objweapon, hitloc, damageflags);
    return bodydeleted;
  } else if(isprojectiledeath(meansofdeath) || iselementaldeath(meansofdeath)) {
    return function_36d11b76451cdde1(level.var_fb690b0442393f26, attacker, objweapon, hitloc, damageflags);
  } else if(meansofdeath == "MOD_EXPLOSIVE" && issubstr(objweapon.basename, "dna_nuke")) {
    bodydeleted = function_36d11b76451cdde1(level.var_fb690b0442393f26, attacker, objweapon, hitloc, damageflags);
    return bodydeleted;
  }

  return 0;
}

function private function_e4982c1d691edffb(ai) {
  if(isDefined(ai)) {
    if(isDefined(ai.aicategory)) {
      if(ai.aicategory == "elite" || ai.aicategory == "boss") {
        return false;
      }
    }

    if(istrue(ai.var_a0a21e4139ad1af4)) {
      return false;
    }
  }

  return true;
}

function private ismeleedeath(meansofdeath) {
  return meansofdeath == "MOD_MELEE";
}

function private function_620cdf363f71a732(meansofdeath) {
  return meansofdeath == "MOD_MELEE_TAKEDOWN";
}

function private isexecutiondeath(meansofdeath) {
  return meansofdeath == "MOD_EXECUTION";
}

function private isbulletdeath(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

function private isequipmentdeath(meansofdeath) {
  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_FIRE";
}

function private iscrushdeath(meansofdeath) {
  return meansofdeath == "MOD_CRUSH";
}

function private isprojectiledeath(meansofdeath) {
  return meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH";
}

function private iselementaldeath(meansofdeath) {
  return meansofdeath == "MOD_ELEMENTAL_FIRE" || meansofdeath == "MOD_ELEMENTAL_ELEC" || meansofdeath == "MOD_ELEMENTAL_COLD" || meansofdeath == "MOD_ELEMENTAL_TOXIC" || meansofdeath == "MOD_ELEMENTAL_DARK" || meansofdeath == "MOD_ELEMENTAL_LIGHT";
}

function private function_36d11b76451cdde1(var_4f9e2cc6f3c3696a, attacker, objweapon, hitloc, damageflags) {
  foreach(var_78d10f1cffcb27f6 in var_4f9e2cc6f3c3696a) {
    if([[var_78d10f1cffcb27f6.conditions]](objweapon) && isDefined(var_78d10f1cffcb27f6.deatheffect)) {
      corpsedeleted = self[[var_78d10f1cffcb27f6.deatheffect]](self.body, attacker, hitloc, damageflags);
      assertex(isDefined(corpsedeleted), "<dev string:x101>");
      return corpsedeleted;
    }
  }

  return 0;
}

function private function_ea0ddc7ede7c87b7(var_3872de29b941832d, attacker, blueprintdeathfx, hitloc, damageflags) {
  if(getdvarint(@ "hash_3ca45ff52d92728a", 1) == 0) {
    if(blueprintdeathfx == #"40kMelee") {
      return 0;
    }
  }

  if(isDefined(var_3872de29b941832d[blueprintdeathfx]) && isDefined(var_3872de29b941832d[blueprintdeathfx].deatheffect)) {
    corpsedeleted = self[[var_3872de29b941832d[blueprintdeathfx].deatheffect]](self.body, attacker, hitloc, damageflags);
    assertex(isDefined(corpsedeleted), "<dev string:x14b>");
    return corpsedeleted;
  }

  return 0;
}

function private function_c8f576b523885369(objweapon) {
  if(isDefined(objweapon.modifierblueprint) && isDefined(objweapon.modifierblueprint.deathfxname) && objweapon.modifierblueprint.deathfxname != "") {
    return objweapon.modifierblueprint.deathfxname;
  }

  if(isDefined(objweapon.receiverblueprint) && isDefined(objweapon.receiverblueprint.deathfxname) && objweapon.receiverblueprint.deathfxname != "") {
    return objweapon.receiverblueprint.deathfxname;
  }

  return undefined;
}

function private function_36f6592c7bcc5bcb(player, var_254ce4e343d1f7de, vpoint) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player setclientomnvar("ui_tombstone_x", int(vpoint[0]));
  player setclientomnvar("ui_tombstone_y", int(vpoint[1]));
  player setclientomnvar("ui_tombstone_z", int(vpoint[2]));
  player setclientomnvar("ui_tombstone_target", var_254ce4e343d1f7de);
  player setclientomnvar("ui_tombstone_notify", gettime());
}

function private function_586e9ade3bfcdd51(weaponblueprint) {
  if(weaponblueprint.lootid == 80459 || weaponblueprint.lootid == 80466 || weaponblueprint.lootid == 73855 || weaponblueprint.lootid == 73856 || weaponblueprint.lootid == 73660 || weaponblueprint.lootid == 73854 || weaponblueprint.lootid == 80880 || weaponblueprint.lootid == 80459 || weaponblueprint.lootid == 81283) {
    return 1;
  }

  return 0;
}

function private function_5c55ca428dd7b66b(victim, weapon, meansofdeath, damagedirection) {
  if(!isenemykill(victim, meansofdeath)) {
    return;
  }

  self.var_e7a9752e4f4c7d97["match_kills"]++;
  self.var_e7a9752e4f4c7d97["kill_streak"]++;
  setkillstreakweapon(weapon);
  self.var_e7a9752e4f4c7d97["downgradable_kill_streak"]++;
  function_b66fa33d64ba4010("reactive_kill_streak_2stage");
  function_b66fa33d64ba4010("reactive_kill_streak_3stage");
  function_b66fa33d64ba4010("reactive_kill_streak_4stage");
  function_b66fa33d64ba4010("reactive_kill_weapon_3stage");
  function_b66fa33d64ba4010("reactive_match_kills_2stage");
  function_b66fa33d64ba4010("reactive_downgradable_kill_streak_3stage");
  function_b66fa33d64ba4010("reactive_kill_cycle_3stage");
  function_b66fa33d64ba4010("reactive_black_cell_reveal");
  thread function_b4ebf862900a4d38();

  if(isDefined(weapon)) {
    var_3029a9976599486c = function_1b1244617e1e02e9(weapon, meansofdeath);

    if(istrue(var_3029a9976599486c)) {
      thread function_bb48ea90ef425e51();
    }

    if(function_ab36993386930071(weapon)) {
      thread function_1ade8d50b72171d2();
    }
  }

  if(getdvarint(@ "hash_69baacf228c08181", 0) == 1 && meansofdeath == "MOD_MELEE" && scripts\mp\utility\perk_shared::function_56ad1b98a0613f8a("specialty_super_strength")) {
    victim function_988bd2fed09e41c("j_spinelower", "boys_super_str");
  }

  if(!isDefined(damagedirection)) {
    damagedirection = anglesToForward(self.angles);
  }

  if(isDefined(weapon.weaponblueprint) && isDefined(weapon.weaponblueprint.lootid) && weapon.weaponblueprint.lootid == 69511) {
    victim.body startragdollfromimpact("head", (damagedirection[0], damagedirection[1] * 5000, damagedirection[2] * 12000));
  }

  if(getdvarint(@ "hash_821d10a9424fb41", 0) && self isdismembermentenabledforplayer()) {
    var_a68f010b99701a04 = isbulletdeath(meansofdeath) && isDefined(weapon) && isDefined(weapon.weaponblueprint) && isDefined(weapon.weaponblueprint.lootid) && function_586e9ade3bfcdd51(weapon.weaponblueprint);

    if(var_a68f010b99701a04) {
      point = victim.origin;
      var_254ce4e343d1f7de = victim getentitynumber();
      function_36f6592c7bcc5bcb(self, var_254ce4e343d1f7de, point);
    }
  }
}

function private function_af1adc73dffafd19(objweapon, meansofdeath) {
  function_d4e4935b9938f870();
  function_b66fa33d64ba4010("reactive_kill_streak_2stage");
  function_b66fa33d64ba4010("reactive_kill_streak_3stage");
  function_b66fa33d64ba4010("reactive_kill_streak_4stage");
  function_b66fa33d64ba4010("reactive_kill_weapon_3stage");
  function_b66fa33d64ba4010("reactive_downgradable_kill_streak_3stage");
  function_45f7158271bbf93();
  function_db40ec5717136688();
}

function private setkillstreakweapon(weapon) {
  sweap = function_4ae6f551ac0a40e3(weapon);

  if(sweap == "none") {
    return;
  }

  if(!isDefined(self.var_e7a9752e4f4c7d97["kill_streak_weapon"][sweap])) {
    if(self.var_e7a9752e4f4c7d97["kill_streak_weapon"].size > 8) {
      self.var_e7a9752e4f4c7d97["kill_streak_weapon"] = function_b9aa30537ac8a046(self.var_e7a9752e4f4c7d97["kill_streak_weapon"]);
    }

    self.var_e7a9752e4f4c7d97["kill_streak_weapon"][sweap] = 0;
  }

  self.var_e7a9752e4f4c7d97["kill_streak_weapon"][sweap]++;
}

function private getkillstreakweapon(weapon) {
  sweap = function_4ae6f551ac0a40e3(weapon);

  if(sweap == "none") {
    return 0;
  }

  if(!isDefined(self.var_e7a9752e4f4c7d97["kill_streak_weapon"][sweap])) {
    return 0;
  }

  return self.var_e7a9752e4f4c7d97["kill_streak_weapon"][sweap];
}

function private function_4ae6f551ac0a40e3(weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.basename)) {
    return "none";
  }

  if(isDefined(weapon.variantid)) {
    sweap = weapon.basename + weapon.variantid;
  } else {
    sweap = weapon.basename;
  }

  return sweap;
}

function private function_b9aa30537ac8a046(array) {
  newarray = [];
  unequippedskipped = 0;
  primaries = self getweaponslistprimaries();
  var_c72294b150863b65 = [];

  foreach(weapon in primaries) {
    var_c72294b150863b65[var_c72294b150863b65.size] = function_4ae6f551ac0a40e3(weapon);
  }

  var_c72294b150863b65 = array_remove_duplicates(var_c72294b150863b65);

  foreach(key, value in array) {
    if(unequippedskipped < 3) {
      if(!array_contains(var_c72294b150863b65, key)) {
        unequippedskipped++;
        continue;
      }
    }

    newarray[key] = value;
  }

  return newarray;
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

function private function_bda6a04efd965c2f() {
  self notify("mtx_manageOffhands");
  self endon("mtx_manageOffhands");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("weapon_switch_started");

    if(self isthrowinggrenade()) {
      function_4aca6cef166cb640("vfx_disabled_for_offhand");
      self waittill("offhand_end");
      function_fa5517de80899543("vfx_disabled_for_offhand");
    }
  }
}

function private function_b11087d46d884b84() {
  self notify("mtx_manageMovementDisable");
  self endon("mtx_manageMovementDisable");
  self endon("death_or_disconnect");

  while(true) {
    while(!self isswimsprinting() && !self isskydiving() && !self isparachuting()) {
      waitframe();
    }

    function_4aca6cef166cb640("vfx_disabled_for_movement");

    while(self isswimsprinting() || self isskydiving() || self isparachuting()) {
      waitframe();
    }

    function_fa5517de80899543("vfx_disabled_for_movement");
  }
}

function private function_4aca6cef166cb640(disabler) {
  if(!isDefined(self.var_e7a9752e4f4c7d97)) {
    return;
  }

  if(!array_contains(self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"], disabler)) {
    self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"] = array_add(self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"], disabler);
  }

  function_45f7158271bbf93();
  function_962fd936fb4491fa();
}

function private function_fa5517de80899543(disabler) {
  if(!isDefined(self.var_e7a9752e4f4c7d97)) {
    return;
  }

  if(array_contains(self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"], disabler)) {
    self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"] = array_remove(self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"], disabler);
  }

  function_79e98e41624be7fc();
  function_3b6459451c628249();
}

function private function_8f640a97343569f5(disabler) {
  if(!isDefined(self.var_e7a9752e4f4c7d97)) {
    return;
  }

  if(!array_contains(self.var_e7a9752e4f4c7d97["all_scriptable_disablers"], disabler)) {
    self.var_e7a9752e4f4c7d97["all_scriptable_disablers"] = array_add(self.var_e7a9752e4f4c7d97["all_scriptable_disablers"], disabler);
  }

  function_45f7158271bbf93();
  function_139c51ccb8268123();
}

function private function_35f7e3fe1d9653bc(disabler) {
  if(!isDefined(self.var_e7a9752e4f4c7d97)) {
    return;
  }

  if(array_contains(self.var_e7a9752e4f4c7d97["all_scriptable_disablers"], disabler)) {
    self.var_e7a9752e4f4c7d97["all_scriptable_disablers"] = array_remove(self.var_e7a9752e4f4c7d97["all_scriptable_disablers"], disabler);
  }

  function_79e98e41624be7fc();
  function_dcc407f619256c57();
}

function private function_79e98e41624be7fc() {
  var_50af9aeeffb058ed = 0;

  if(isDefined(self.currentweapon) && function_6505b038fb96bb28()) {
    foreach(scriptableid, var_7bdc9702e6500422 in level.var_a3d1147a42b2fd91) {
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

  if(self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_state"] != state) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_state"] = state;
    self setscriptablepartstate("mtxVfxCharm", state);
  }
}

function private function_45f7158271bbf93() {
  if(self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_state"] != "neutral") {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_state"] = "neutral";
    self setscriptablepartstate("mtxVfxCharm", "neutral");
  }
}

function private function_6505b038fb96bb28() {
  if(self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"].size > 0 || self.var_e7a9752e4f4c7d97["all_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function private function_3b6459451c628249() {
  var_3ae6d038de81445a = 0;

  if(isDefined(self.currentweapon) && function_8c5d76d279b0a609()) {
    foreach(scriptableid, var_7bdc9702e6500422 in level.var_88c1332fb32e977c) {
      if([[var_7bdc9702e6500422.var_bcf25cec488d34e3]](self.currentweapon)) {
        thread function_198343d05a7a5ee0(scriptableid, var_7bdc9702e6500422, self.currentweapon);
        var_3ae6d038de81445a = 1;
        break;
      }
    }
  }

  if(!var_3ae6d038de81445a) {
    function_962fd936fb4491fa();
  }
}

function private function_198343d05a7a5ee0(scriptableid, var_7bdc9702e6500422, weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  state = [[var_7bdc9702e6500422.var_ba46ec67c5caf4a2]](weapon);

  if(self.var_e7a9752e4f4c7d97["mtx_scriptable_gunscreen_state"] != state) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_gunscreen_state"] = state;
    self setscriptablepartstate("mtxVfxGunscreen", state);
  }
}

function private function_962fd936fb4491fa() {
  if(self.var_e7a9752e4f4c7d97["mtx_scriptable_gunscreen_state"] != "neutral") {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_gunscreen_state"] = "neutral";
    self setscriptablepartstate("mtxVfxGunscreen", "neutral");
  }
}

function private function_8c5d76d279b0a609() {
  if(self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"].size > 0 || self.var_e7a9752e4f4c7d97["all_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function private function_dcc407f619256c57() {
  foreach(scriptableid, var_7bdc9702e6500422 in level.var_e65f4101fd50a0e1) {
    function_b66fa33d64ba4010(scriptableid);
  }
}

function private function_b66fa33d64ba4010(scriptableid) {
  if(function_3cae60827c9f8ab0()) {
    var_7bdc9702e6500422 = level.var_e65f4101fd50a0e1[scriptableid];

    if(function_46219d0188ef7627(scriptableid, var_7bdc9702e6500422)) {
      function_d5d7cbe514c9e39f(scriptableid, var_7bdc9702e6500422);
    }
  }
}

function private function_6631789b2a3abe3c() {
  foreach(scriptableid, var_7bdc9702e6500422 in level.var_e65f4101fd50a0e1) {
    function_588861cc60e51291(scriptableid);
  }
}

function private function_588861cc60e51291(scriptableid) {
  var_7bdc9702e6500422 = level.var_e65f4101fd50a0e1[scriptableid];
  function_d5d7cbe514c9e39f(scriptableid, var_7bdc9702e6500422);
}

function private function_d5d7cbe514c9e39f(scriptableid, var_7bdc9702e6500422) {
  if(!self isscriptable()) {
    return;
  }

  state = [[var_7bdc9702e6500422.var_ba46ec67c5caf4a2]]();

  if(!self getscriptableparthasstate(scriptableid, state)) {
    println("<dev string:x195>" + state + "<dev string:x1bf>" + scriptableid);
    return;
  }

  self setscriptablepartstate(scriptableid, state);
  self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"][scriptableid] = state;
}

function private function_139c51ccb8268123() {
  foreach(scriptableid, scriptablestate in self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"]) {
    if(scriptablestate != "neutral") {
      self setscriptablepartstate(scriptableid, "neutral");
      self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"][scriptableid] = "neutral";
    }
  }
}

function private function_3cae60827c9f8ab0() {
  if(self.var_e7a9752e4f4c7d97["all_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function private function_46219d0188ef7627(scriptableid, var_7bdc9702e6500422) {
  state = [[var_7bdc9702e6500422.var_ba46ec67c5caf4a2]]();
  return state != self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"][scriptableid];
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
  if(self.var_e7a9752e4f4c7d97["all_scriptable_disablers"].size > 0) {
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

function isdoomchainsaw(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "rec_pickaxe" && weapon.receivervarindex == 2) {
      return true;
    }
  }

  return false;
}

function ischainsword(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "jup_jp23_me_swhiskey_rec" && (weapon.receivervarindex == 1 || weapon.receivervarindex == 4)) {
      return true;
    }
  }

  return false;
}

function function_bbf72e8bc3d1dfb2(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "jup_evictor_rec" && weapon.receivervarindex == 3) {
      return true;
    }
  }

  return false;
}

function function_a672596fca729e59(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "jup_jp23_me_swhiskey_rec" && weapon.receivervarindex == 6) {
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

function private function_c4e6dc7009af3d67(weapon) {
  return "ChainSwordActive";
}

function private function_5132f333e5bbe24(weapon) {
  return "ToothFairyActive";
}

function private function_aab1efb0d73d2f65(weapon) {
  return "WontonSwhiskeyActive";
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
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      case 2:
        state = "<dev string:x1f2>";
        break;
      default:
        assertmsg("<dev string:x1fc>");
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
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      case 2:
        state = "<dev string:x1f2>";
        break;
      default:
        assertmsg("<dev string:x1fc>");
        break;
    }
  }

  return state;
}

function private function_cf3fbbc7a8984419() {
  stage1killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_3stage"][0];
  stage2killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_3stage"][1];
  stage3killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_3stage"][2];
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage3killthreshold) {
    state = "stage3";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage2killthreshold) {
    state = "stage2";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage1killthreshold) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_cefbf3b030b375ab");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      case 2:
        state = "<dev string:x1f2>";
        break;
      case 3:
        state = "<dev string:x223>";
        break;
      default:
        assertmsg("<dev string:x22d>");
        break;
    }
  }

  return state;
}

function private function_7e0b66f7fa28c728() {
  stage1killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_4stage"][0];
  stage2killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_4stage"][1];
  stage3killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_4stage"][2];
  stage4killthreshold = level.var_40e77024dc6bae59["kill_streak_thresholds_4stage"][3];
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage4killthreshold) {
    state = "stage4";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage3killthreshold) {
    state = "stage3";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage2killthreshold) {
    state = "stage2";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= stage1killthreshold) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_eac0e1ad1567fd42");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      case 2:
        state = "<dev string:x1f2>";
        break;
      case 3:
        state = "<dev string:x223>";
        break;
      case 4:
        state = "<dev string:x257>";
        break;
      default:
        assertmsg("<dev string:x261>");
        break;
    }
  }

  return state;
}

function private function_3537cbd88e7ec6a8() {
  state = "neutral";
  weaponkillstreak = getkillstreakweapon(self.currentweapon);

  if(weaponkillstreak >= 3) {
    state = "stage3";
  } else if(weaponkillstreak >= 2) {
    state = "stage2";
  } else if(weaponkillstreak >= 1) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_6b3c6361f0f5fdb");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      case 2:
        state = "<dev string:x1f2>";
        break;
      case 3:
        state = "<dev string:x223>";
        break;
      default:
        assertmsg("<dev string:x22d>");
        break;
    }
  }

  return state;
}

function private function_2c2b9e7001e5ad6b() {
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["match_kills"] == 0 || self.var_e7a9752e4f4c7d97["match_kills"] % 3 == 1) {
    state = "stage1";
  } else if(self.var_e7a9752e4f4c7d97["match_kills"] % 3 == 2) {
    state = "stage2";
  } else if(self.var_e7a9752e4f4c7d97["match_kills"] % 3 == 0) {
    state = "stage3";
  }

  debugstates = getdvarint(@ "hash_51dcebb527f3dd9b");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      case 2:
        state = "<dev string:x1f2>";
        break;
      case 3:
        state = "<dev string:x223>";
        break;
      default:
        assertmsg("<dev string:x22d>");
        break;
    }
  }

  return state;
}

function private function_67002f2a3879a23b() {
  if(istrue(self.var_f36ff06e54d96267)) {
    state = "stage1";
  } else {
    state = "neutral";
  }

  debugstates = getdvarint(@ "hash_399fdd0fb6b02227");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      default:
        assertmsg("<dev string:x28e>");
        break;
    }
  }

  return state;
}

function private function_594d892a4842d30c() {
  self endon("death_or_disconnect");

  if(!(isDefined(game["flags"]) && istrue(game["flags"]["prematch_done"]))) {
    level waittill("prematch_done");
  }

  self.var_f36ff06e54d96267 = 0;
  function_b66fa33d64ba4010("reactive_spawn");
  waitframe();
  self.var_f36ff06e54d96267 = 1;
  function_b66fa33d64ba4010("reactive_spawn");
}

function private function_a5eea442f31613f0() {
  state = "neutral";

  if(self.var_e7a9752e4f4c7d97["kill_streak"] >= 5) {
    state = "stage2";
  } else if(self.var_e7a9752e4f4c7d97["kill_streak"] >= 2) {
    state = "stage1";
  }

  debugstates = getdvarint(@ "hash_b4302b21a46ef2a");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      case 2:
        state = "<dev string:x1f2>";
        break;
      default:
        assertmsg("<dev string:x1fc>");
        break;
    }
  }

  return state;
}

function private function_777eed4426971f45() {
  return function_ad8d1b9c1ea44000("reactive_downgradable_kill_streak_3stage", "stage1", "stage1_dec", "stage2", "stage2_dec", "stage3", @ "hash_e001a97b368816c9");
}

function private function_ad8d1b9c1ea44000(part, stage1, stage1_dec, stage2, stage2_dec, stage3, debugdvar) {
  if(!isDefined(level.var_40e77024dc6bae59["downgradable_kill_streak_thresholds_3stage"])) {
    return "neutral";
  }

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
        state = "<dev string:x1dd>";
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
        assertmsg("<dev string:x22d>");
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
      self notify("<dev string:x2a8>");
    }

    self.var_e7a9752e4f4c7d97["downgradable_kill_streak"]--;

    if(self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] < 0) {
      self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] = 0;
    }

    thread function_b66fa33d64ba4010("reactive_downgradable_kill_streak_3stage");
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
        state = "<dev string:x1dd>";
        break;
      case 1:
        state = "<dev string:x1e8>";
        break;
      default:
        assertmsg("<dev string:x2d4>");
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
        return "<dev string:x1dd>";
      case 1:
        return "<dev string:x1e8>";
      default:
        assertmsg("<dev string:x2f8>" + debugstates + "<dev string:x318>");
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
        return "<dev string:x1dd>";
      case 1:
        return "<dev string:x1e8>";
      default:
        assertmsg("<dev string:x34c>" + debugstates + "<dev string:x318>");
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

function private isiooperator() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(isxhashasset(self.operatorcustomization.skinref)) {
      return (self.operatorcustomization.skinref == % "io_western_a");
    } else {
      return (self.operatorcustomization.skinref == "io_western_a");
    }
  }

  return false;
}

function private isfalloperator() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(isxhashasset(self.operatorcustomization.skinref)) {
      return (self.operatorcustomization.skinref == % "jup_mp_fall_skin");
    } else {
      return (self.operatorcustomization.skinref == "jup_mp_fall_skin");
    }
  }

  return false;
}

function private function_b1b2ec3ef6492022() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(isxhashasset(self.operatorcustomization.skinref)) {
      return (self.operatorcustomization.skinref == % "jup_mp_ratcliff_10_skin");
    } else {
      return (self.operatorcustomization.skinref == "jup_mp_ratcliff_10_skin");
    }
  }

  return false;
}

function private ismovementoperator() {
  if(isiooperator() || isfalloperator() || function_b1b2ec3ef6492022()) {
    return true;
  }

  return false;
}

function private ismovementweapon(weapon) {
  if(isDefined(weapon) && weapon.basename == "iw9_sm_aviktor_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 25);
  }

  if(isDefined(weapon) && weapon.basename == "jup_jp23_me_shotel_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 8);
  }

  if(isDefined(weapon) && weapon.basename == "jup_jp25_sm_talpham_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 19);
  }

  if(isDefined(weapon) && weapon.basename == "jup_jp36_sn_boscar_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 13);
  }

  if(isDefined(weapon) && weapon.basename == "jup_jp12_pi_mike93_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 13);
  }

  if(isDefined(weapon) && weapon.basename == "iw9_lm_slima_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 18);
  }

  if(isDefined(weapon) && weapon.basename == "jup_jp34_ar_balpha27_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 14);
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
  function_b66fa33d64ba4010("reactive_enchantment");

  while(true) {
    self waittill("weapon_inspect");
    function_670fe78573af87eb(weaponname);
    function_b66fa33d64ba4010("reactive_enchantment");
  }
}

function private function_1279657a7f30ae15(state) {
  if(!function_ee73ce9f8e9e7938(self.currentweapon) || !isDefined(self.var_e7a9752e4f4c7d97["enchanted_weapons"])) {
    return;
  }

  if(state != 0 && state != 1) {
    assertmsg("<dev string:x36f>" + state + "<dev string:x38d>");
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
  isfalloperator = isfalloperator();

  while(true) {
    movement = self getnormalizedmovement();
    movement = abs(movement[0]) + abs(movement[1]);

    if(movement > 0.7 && !self playerads() > 0 && (self getstance() == "stand" || isfalloperator)) {
      var_8224573f9ab4d7a8 = 1;
    } else {
      var_8224573f9ab4d7a8 = 0;
    }

    if(self issprinting() || !self isonground() || self isdiving() || self issprintsliding() || var_8224573f9ab4d7a8 || isfalloperator && self isshooting()) {
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
  function_b66fa33d64ba4010("reactive_movement");
}

function private function_d9c8739eb93ab7d9() {
  self notify("movement_update_thread");
}

function private function_b4ebf862900a4d38() {
  self notify("updating_reactive_kills");
  self endon("death_or_disconnect");
  self endon("updating_reactive_kills");

  if(!isDefined(self getscriptablepartstate("reactive_kill", 1))) {
    println("<dev string:x3b0>");
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

function private function_2c487c81b676e308(weapon) {
  return false;
}

function private function_cd88d52e8776b964(weapon) {
  if(function_43821739cb53d078(weapon)) {
    thread function_d565e18b86416a77(weapon);
    return;
  }

  function_4866e2b578c128d7();
}

function private function_d565e18b86416a77(weapon) {
  self notify("doom_gunscreen_thread");
  self endon("death_or_disconnect");
  self endon("doom_gunscreen_thread");
  self endon("weapon_change");

  if(!isDefined(self.var_e7a9752e4f4c7d97["gunscreen_doom_hide"])) {
    self.var_e7a9752e4f4c7d97["gunscreen_doom_hide"] = 0;
  }

  while(true) {
    if(self issprinting() || self isswimsprinting() || self issprintsliding() || self isdiving()) {
      if(!self.var_e7a9752e4f4c7d97["gunscreen_doom_hide"]) {
        self.var_e7a9752e4f4c7d97["gunscreen_doom_hide"] = 1;
        self setclientomnvar("ui_doomscreen_hide", 1);
      }
    } else if(self.var_e7a9752e4f4c7d97["gunscreen_doom_hide"]) {
      self.var_e7a9752e4f4c7d97["gunscreen_doom_hide"] = 0;
      self setclientomnvar("ui_doomscreen_hide", 0);
    }

    waitframe();
  }
}

function private function_4866e2b578c128d7() {
  self notify("doom_gunscreen_thread");
  self.var_e7a9752e4f4c7d97["gunscreen_doom_hide"] = 0;
  self setclientomnvar("ui_doomscreen_hide", 0);
}

function private function_b397fc136a6c84ea(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_029")) {
    return true;
  }

  return false;
}

function private function_43821739cb53d078(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_028")) {
    return true;
  }

  return false;
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
  if(!isDefined(weapon)) {
    return false;
  }

  if(istrue(function_a124f473c9b83542(weapon))) {
    return true;
  }

  if(istrue(function_74ee609c2cece3b0(weapon))) {
    return true;
  }

  if(istrue(function_390c36ec2deddabe(weapon))) {
    return true;
  }

  if(istrue(function_73c5c19fbd622826(weapon))) {
    return true;
  }

  if(istrue(function_3df504bc71efd9e8(weapon))) {
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

function private function_3df504bc71efd9e8(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 44;
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

function private function_7fd832ad7580949a(weapon) {
  if(isDefined(weapon.scope)) {
    if(weapon.scope == "holotherm" && weapon.scopevarindex == 22) {
      return true;
    }

    if(weapon.scope == "fourxtherm01" && weapon.scopevarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_f2626cc5d4205f(weapon) {
  return isDefined(weapon.modifier) && weapon.modifier == "ammo_9s" && weapon.modifiervarindex == 2;
}

function private function_1b1244617e1e02e9(weapon, meansofdeath) {
  return function_b376b213145194d3(weapon) && function_f2626cc5d4205f(weapon) && isDefined(meansofdeath) && meansofdeath != "MOD_MELEE";
}

function private function_2d38adc3714f681e(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_lg_mp";
}

function private function_e4f3eb6b0541db27(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_mp";
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

function private function_3942ea0f6182ae35(objweapon) {
  return isDefined(objweapon) && objweapon hasattachment("jup_ub_saw_01");
}

function private function_105e3a3402ae1039(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && (objweapon.variantid == 1 || objweapon.variantid == 2);
}

function private function_1006db730ae1210(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_spear_mp" && objweapon.variantid == 4;
}

function private function_2d09bb57cc70eed7(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 6;
}

function private function_36bd043b036e71bf(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "iw9_me_pickaxe" && objweapon.variantid == 3;
}

function private function_fce8fef00f721732(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 10;
}

function private function_74118f94fccd1e1a(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_spear" && objweapon.variantid == 1;
}

function private function_bf2a377f5ab0611b(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 9;
}

function private function_987daded215df4da(fakeweapon) {
  if(fakeweapon.executionref == "execution_061") {
    return true;
  }

  return false;
}

function private function_f5897571e9a0f0eb(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_029")) {
    return true;
  }

  return false;
}

function private function_1f371614807624c3(objweapon) {
  if(function_d8804135c49fd481(objweapon)) {
    return true;
  }

  return false;
}

function private function_8dcf23df7efcf5f8(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "jup_pi_goldengun_mp";
}

function private function_8a2f3038f9212159(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp17_sn_hsierra_mp" && objweapon.variantid == 16;
}

function private function_619788896abeee17(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "dna_nuke_mp";
}

function private isdg2death(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "jup_ar_dg2_mp";
}

function private israygundeath(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "jup_pi_raygun_mp";
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

function private function_36f3c1f20204b13(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "youveBeenNaughty_limb", "youveBeenNaughty_torso", "youveBeenNaughty_head");
  return true;
}

function private function_777c1f2e7f15d92e(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "youveBeenNice_limb", "youveBeenNice_torso", "youveBeenNice_head");
  return true;
}

function private function_337b80f7ff25b0c9(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "vDay_limb", "vDay_torso", "vDay_head");
  return true;
}

function private function_1a406edd298ed8ad(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "bCell_limb", "bCell_torso", "bCell_head");
  } else {
    function_687ba52e53e097ac(corpstable, "bCell_nogore_limb", "bCell_nogore_torso", "bCell_nogore_head");
  }

  return true;
}

function private function_f7bca22a37224d8b(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "purple_shock");
  return false;
}

function private function_583f9260e6221231(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "paddy_limb", "paddy_torso", "paddy_head");
  return true;
}

function private function_1b5dfb950d2e6dd2(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "shredder");
  return false;
}

function private function_436125459cf039e(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "sbandit_limb", "sbandit_torso", "sbandit_head");
  function_988bd2fed09e41c("j_spineupper", "sbandit_fatal");
  delete_corpse(corpstable);
  return true;
}

function private function_103d412a4079b9a(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("j_spineupper", "spider_fatal");
  delete_corpse(corpstable);
  return true;
}

function private function_731555c8bf961fae(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("tag_sync", "arcstorm_fatal");
  return true;
}

function private function_f98648e1dc6e63cf(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "easter_limb", "easter_torso", "easter_head");
  } else {
    function_687ba52e53e097ac(corpstable, "easter_nogore_limb", "easter_nogore_torso", "easter_nogore_head");
  }

  return true;
}

function private function_f3274abe8bbcac04(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "electricAnime");
  return false;
}

function private function_52506c3cfde54aa7(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "scifi_limb", "scifi_torso", "scifi_head");
  function_988bd2fed09e41c("tag_origin", "scifi_origin");
  return true;
}

function private function_38f459f70ea411a7(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "scifi2_limb", "scifi2_torso", "scifi2_head");
  function_988bd2fed09e41c("tag_origin", "scifi2_origin");
  return true;
}

function private function_2d04b4ad2bc66462(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "scifi3_limb", "scifi3_torso", "scifi3_head");
  function_988bd2fed09e41c("tag_origin", "scifi3_origin");
  return true;
}

function private function_fd4087de9db4cdf1(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("j_spineupper", "420_death");
  return false;
}

function private function_a02b4e369b2cbcb3(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("j_spineupper", "hitscan");
  return false;
}

function private function_5ba1ecaf98dccff2(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("j_spine4", "witch");
  delete_corpse(corpstable);
  return true;
}

function private function_24b135168cc16df3(corpstable, attacker, hitloc, damageflags) {
  if(hitloc == "head" || hitloc == "helmet") {
    function_988bd2fed09e41c("j_spine4", "zombie");
    delete_corpse(corpstable);
    return true;
  }

  return false;
}

function private function_3e92a8e47dbf91aa(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("tag_origin", "thor");
  function_988bd2fed09e41c("j_spineupper", "thor_chest");
  delete_corpse(corpstable);
  return true;
}

function private function_bdcfc88e185572c8(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "kd");
  return false;
}

function private function_1ebe98051052c08(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "cdl");
  return false;
}

function private function_362790d530cb554f(corpstable, attacker, hitloc, damageflags) {
  deletebody = 0;
  function_687ba52e53e097ac(corpstable, "soulEater_limb", "soulEater_torso", "soulEater_head", undefined, deletebody);
  function_988bd2fed09e41c("tag_origin", "soulEater_death");
  attacker thread function_694e1b7805093c52(corpstable);
  return deletebody;
}

function private function_ff45d70ef7fd700a(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "crash_limb", "crash_torso", "crash_head");
  return true;
}

function private function_a93d4e4d31895d77(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("tag_origin", "akihabara_fatal");
  delete_corpse(corpstable);
  return true;
}

function private function_836e832ef348cb0c(corpstable, attacker, hitloc, damageflags) {
  if(corpstable isscriptable()) {
    corpstable setscriptablepartstate("burning", "flareup", 0);
  }

  return false;
}

function private function_f6820874f2f4b7fa(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "cthulhu_limb", "cthulhu_torso", "cthulhu_head");
  } else {
    function_687ba52e53e097ac(corpstable, "cthulhu_nogore_limb", "cthulhu_nogore_torso", "cthulhu_nogore_head");
  }

  return true;
}

function private function_487ad6a4de40bcf5(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "hlander_limb", "hlander_torso", "hlander_head");
  } else {
    function_687ba52e53e097ac(corpstable, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head");
  }

  return true;
}

function private function_ae90d417fbdba2a9(corpstable, attacker, hitloc, damageflags) {
  if(hitloc == "head") {
    function_dfcee2ebe02a6ae7(corpstable, "bnoir_head");
  } else {
    function_dfcee2ebe02a6ae7(corpstable, "bnoir");
  }

  return false;
}

function private function_89a27655bbfbea5c(corpstable, attacker, hitloc, damageflags) {
  if(getdvarint(@ "hash_3ca45ff52d92728a", 1) == 0) {
    return false;
  }

  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["40k"], corpstable, tag);
  return false;
}

function private function_fbca442210cadac5(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["underworld"], corpstable, tag);
  return false;
}

function private function_3575102fb05d4cfa(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["wonton"], corpstable, tag);
  return false;
}

function private function_4ae2990535a30b9a(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["mandu"], corpstable, tag);
  return false;
}

function private function_6beb2bbbd9f7dc4f(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "blackcell_s5Melee");
  return false;
}

function private function_b9809bbfc4cd08d7(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "gilmanMelee");
  return false;
}

function private function_afaa1dd651d2194e(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["shapechanger"], corpstable, tag);
  return false;
}

function private function_a956d3177808f0cf(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["tonfa"], corpstable, tag);
  return false;
}

function private function_ba43403ce60b1473(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);

  if(isheavymeleedamage(damageflags)) {
    playFXOnTag(level._effect["vinyl_heavy"], corpstable, tag);
  } else {
    playFXOnTag(level._effect["vinyl"], corpstable, tag);
  }

  return false;
}

function private function_35ab6565907ce11d(corpstable, attacker, hitloc, damageflags) {
  if(getdvarint(@ "hash_3ca45ff52d92728a", 1) == 0) {
    return false;
  }

  function_dfcee2ebe02a6ae7(corpstable, "40kMelee");
  return false;
}

function private function_220dd55ea8144bd4(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "underworldMelee");
  return false;
}

function private function_74515e82b8b147bb(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "wontonMelee");
  return false;
}

function private function_a76e910322cfb55b(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "manduMelee");
  return false;
}

function private function_4a986bf4a82cbf46(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "blackcell_s5Melee");
  return false;
}

function private function_8c42a2a804458f17(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "gilmanMelee");
  return false;
}

function private function_10c892a14f7d3d9f(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "shapechangerMelee");
  return false;
}

function private function_5c6dcf2e2d198cc1(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "ubSawMelee");
  return false;
}

function private function_a8091d16050e65c6(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["bikeMelee"], corpstable, tag);
  return false;
}

function private function_b18cdac40499535b(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["oreZincMelee"], corpstable, tag);
  return true;
}

function private function_d839e436b16f3db1(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["pineapple"], corpstable, tag);
  return false;
}

function private function_ce2c35cf68d5b3fc(corpstable, attacker, hitloc, damageflags) {
  deletedbody = 0;

  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "golden_gun_limb", "golden_gun_torso", "golden_gun_head");
    deletedbody = 1;
  }

  function_988bd2fed09e41c("tag_origin", "golden_gun_origin");
  return deletedbody;
}

function private function_e8aa098e64325e7d(corpstable, attacker, hitloc, damageflags) {
  deletedbody = 0;

  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "mahou_limb", "mahou_torso", "mahou_head");
    deletedbody = 1;
  }

  function_988bd2fed09e41c("tag_origin", "mahou_origin");
  return deletedbody;
}

function private function_dd7bd8ee508f606b(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["dna_nuke"], corpstable, tag);
  return false;
}

function private function_98c6559ade501e3d(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "nicki_limb", "nicki_torso", "nicki_head");
  return true;
}

function private function_e6385720c367c132(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "ice_limb", "ice_torso", "ice_head");
  } else {
    function_687ba52e53e097ac(corpstable, "ice_nogore_limb", "ice_nogore_torso", "ice_head");
  }

  return true;
}

function private function_bd496cb5c609ebef(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "tomb_limb", "tomb_torso", "tomb_head");
  } else {
    function_687ba52e53e097ac(corpstable, "tomb_limb_nogore", "tomb_torso_nogore", "tomb_head_nogore");
  }

  return true;
}

function private function_cdad06c807f2982b(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "hips_limb", "hips_torso", "hips_head");
  return true;
}

function private function_c05b05634b8bf729(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "hops_limb", "hops_torso", "hops_head");
  return true;
}

function private function_8e8a14ae1d93c4ea(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "blunt");
  return false;
}

function private function_54ed38d3b5ac6140(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "maze_limb", "maze_torso", "maze_head");
  } else {
    function_687ba52e53e097ac(corpstable, "maze_nogore_limb", "maze_nogore_torso", "maze_nogore_head");
  }

  return true;
}

function private function_5e562c7c6cd5fbe9(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("j_spinelower", "lilith");
  delete_corpse(corpstable);
  return true;
}

function private function_5b42e2feab7a3aae(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("j_spine4", "lilith");
  delete_corpse(corpstable);
  return true;
}

function private function_5e575cb31776c32f(corpstable, attacker, hitloc, damageflags) {
  return false;
}

function private function_37d7885e81477f70(corpstable, attacker, hitloc, damageflags) {
  function_dfcee2ebe02a6ae7(corpstable, "skeletor");
  return false;
}

function private function_88e7906b3427ca1(corpstable, attacker, hitloc, damageflags) {
  function_687ba52e53e097ac(corpstable, "bcell6_limb", "bcell6_torso", "bcell6_head");
  return false;
}

function private function_7ea50d23ae130cca(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("j_spine4", "inarius");
  delete_corpse(corpstable);
  return true;
}

function private function_2c8b06094bd3a868(corpstable, attacker, hitloc, damageflags) {
  function_988bd2fed09e41c("tag_origin", "thor");
  function_988bd2fed09e41c("j_spineupper", "thor_chest");
  return false;
}

function private function_b0dff649bba1366f(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_687ba52e53e097ac(corpstable, "hlander_limb", "hlander_torso", "hlander_head");
  } else {
    function_687ba52e53e097ac(corpstable, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head");
  }

  return true;
}

function private function_57e218ee6860ff4b(corpstable, attacker, hitloc, damageflags) {
  tag = function_b988e2ae750e4e14(hitloc);
  playFXOnTag(level._effect["voxel"], corpstable, tag);
  return true;
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
  waittillframeend();

  if(self.var_e7a9752e4f4c7d97["ghost_finder_sucking"]) {
    return;
  }

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

    if(function_c8f576b523885369(weapon) != #"soulEater") {
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
  function_b66fa33d64ba4010("reactive_soul_collect_1stage");
}

function private function_671264d7659ab6ab(soulent) {
  soulent setscriptablepartstate("soulEater", "vanish");
}

function private unlinkequipment(corpstable) {
  linkedchildren = corpstable getlinkedchildren();

  foreach(child in linkedchildren) {
    if(istrue(child.iscrossbowbolt)) {
      child scripts\cp_mp\crossbow::boltunlink();
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

function private function_84690613abc67792(params) {
  if(getdvarint(@ "hash_cde633441920a939", 0) == 1) {
    return;
  }

  if(issharedfuncdefined("game_utility", "isInfectedGametype")) {
    if([[getsharedfunc("game_utility", "isInfectedGametype")]]()) {
      return;
    }
  }

  if(callsharedfunc("escort", "isZombie") || callsharedfunc("zxp", "isZombieRoyaleZombie")) {
    return;
  }

  if(isDefined(self.var_e17e62e3bfc6c2e9)) {
    function_709ab519033049c0(self.var_e17e62e3bfc6c2e9, self.var_8b7ea4e4e8023f40, self.var_eb72409611f0b75e);
  }

  if(!isDefined(self.operatorcustomization) || !is_equal(self.operatorcustomization.execution, "jup_mp_execution_thyme_01") && !is_equal(self.operatorcustomization.execution, "jup_mp_execution_thyme_sage_01")) {
    return;
  }

  thread function_beaa7f2baba2ba41();
  thread function_9cd3304c60f28813();
}

function function_beaa7f2baba2ba41() {
  var_7f302bfe42f35d6e = utility::function_6a11999c562cf4ab("customization", "getOperatorCustomization");

  if(!isDefined(var_7f302bfe42f35d6e)) {
    return;
  }

  if(isDefined(self.var_e17e62e3bfc6c2e9)) {
    return;
  }

  self.var_e17e62e3bfc6c2e9 = self[[var_7f302bfe42f35d6e]]();
  self.var_8b7ea4e4e8023f40 = self getcustomizationviewmodel();
  self.var_eb72409611f0b75e = self function_efed183e552b0625();
}

function function_709ab519033049c0(models, vm, reactive) {
  var_6283af671ce0aeae = utility::function_6a11999c562cf4ab("customization", "setCharacterModels");

  if(!isDefined(var_6283af671ce0aeae)) {
    return;
  }

  self setcustomization(models[0], models[1]);
  self[[var_6283af671ce0aeae]](models[0], models[1], vm);

  if(isDefined(self.operatorcustomization)) {
    self.operatorcustomization.reactiveoperator = reactive;
  }

  if(isDefined(reactive)) {
    self function_602b3de054f2a81(reactive);
  } else {
    self function_ecdccfda4326de02();
  }

  if(getdvarint(@ "hash_4753586a2ac8718f", 0) == 1 && issharedfuncdefined("game", "adjustVoxelHead")) {
    headsize = self getclientomnvar("ui_voxel_head_size");
    self.operatorcustomization.head = models[1];
    self[[getsharedfunc("game", "adjustVoxelHead")]](1);

    if(headsize == 2) {
      self[[getsharedfunc("game", "adjustVoxelHead")]]();
      return;
    }

    if(headsize == 3) {
      self[[getsharedfunc("game", "adjustVoxelHead")]]();
      self[[getsharedfunc("game", "adjustVoxelHead")]]();
    }
  }
}

function function_5def13197a8e3048() {
  self endon("mtx_mimic_got_a_kill");

  while(true) {
    if(!self isinexecutionattack()) {
      self notify("mtx_mimic_execution_cancelled");
      return;
    }

    waitframe();
  }
}

function function_19d3759c00aca7ec(customization) {
  self endon("mtx_mimic_execution_cancelled");

  while(true) {
    self waittill("got_a_kill", victim, sweapon, meansofdeath);

    if(meansofdeath != "MOD_EXECUTION" || !isPlayer(victim) && !isbot(victim)) {
      continue;
    }

    vm = victim getcustomizationviewmodel();
    reactive = victim function_efed183e552b0625();
    function_709ab519033049c0(customization, vm, reactive);
    self notify("mtx_mimic_got_a_kill");
    return;
  }
}

function function_9cd3304c60f28813() {
  self endon("death");
  self endon("disconnect");
  var_7f302bfe42f35d6e = utility::function_6a11999c562cf4ab("customization", "getOperatorCustomization");

  if(!isDefined(var_7f302bfe42f35d6e)) {
    return;
  }

  while(true) {
    self waittill("execution_begin", victim);

    if(!isDefined(victim) || !isPlayer(victim) && !isbot(victim)) {
      continue;
    }

    if(issubstr(self.suit, "juggernaut")) {
      continue;
    }

    executionref = self.executionref;

    if(!isDefined(executionref) && isDefined(self.operatorcustomization)) {
      executionref = self.operatorcustomization.execution;
    }

    if(!is_equal(executionref, "jup_mp_execution_thyme_01") && !is_equal(self.operatorcustomization.execution, "jup_mp_execution_thyme_sage_01")) {
      continue;
    }

    customization = victim[[var_7f302bfe42f35d6e]]();
    self loadcustomization(customization[0], customization[1], 1);
    childthread function_5def13197a8e3048();
    childthread function_19d3759c00aca7ec(customization);
    waittill_any_2("mtx_mimic_execution_cancelled", "mtx_mimic_got_a_kill");
  }
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
  if(corpstable isscriptable() && corpstable getscriptablehaspart("mtxDeath") && corpstable getscriptableparthasstate("mtxDeath", state)) {
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

function private function_b988e2ae750e4e14(hitloc) {
  tag = "j_spinelower";

  if(hitloc == "head" || hitloc == "helmet" || hitloc == "neck") {
    tag = "j_head";
  } else if(hitloc == "right_arm_upper" || hitloc == "right_arm_lower" || hitloc == "right_hand") {
    tag = "j_shoulder_ri";
  } else if(hitloc == "left_arm_upper" || hitloc == "left_arm_lower" || hitloc == "left_hand") {
    tag = "j_shoulder_le";
  } else if(hitloc == "right_leg_upper" || hitloc == "right_leg_lower" || hitloc == "right_foot") {
    tag = "j_hip_ri";
  } else if(hitloc == "left_leg_upper" || hitloc == "left_leg_lower" || hitloc == "left_foot") {
    tag = "j_hip_le";
  }

  return tag;
}

function private isheavymeleedamage(damageflags) {
  return isDefined(damageflags) && damageflags & 131072;
}

function private function_5b5e6de151e0fecd(value) {
  self.var_e7a9752e4f4c7d97["mtx_scriptable_charm_state"] = value;
}

function private function_6b2d1cc6bc7c8a90(value) {
  self.var_e7a9752e4f4c7d97["mtx_scriptable_gunscreen_state"] = value;
}

function private function_4f0c5acd6343c0dd(name, value) {
  function_3bd8d57c42967dfc();

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"])) {
    self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"] = [];
  }

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"][name])) {
    self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"][name] = value;
  }
}

function private function_68444e56728a13a6(name, value) {
  function_3bd8d57c42967dfc();

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"])) {
    self.var_e7a9752e4f4c7d97["mtx_scriptable_toggle_ids"] = [];
  }

  if(!isDefined(self.var_e7a9752e4f4c7d97["mtx_SCRIPTABLE_REACTIVE_IDs"][name])) {
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
  self.var_e7a9752e4f4c7d97["kill_streak"] = 0;
  self.var_e7a9752e4f4c7d97["downgradable_kill_streak"] = 0;
  self.var_e7a9752e4f4c7d97["reactive_kills"] = self.var_e7a9752e4f4c7d97["match_kills"];
  self.var_e7a9752e4f4c7d97["kill_streak_weapon"] = [];
  self.var_e7a9752e4f4c7d97["all_scriptable_disablers"] = [];
  self.var_e7a9752e4f4c7d97["direct_scriptable_disablers"] = [];
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
  setDvar(@ "hash_cefbf3b030b375ab", -1);
  setDvar(@ "hash_eac0e1ad1567fd42", -1);
  setDvar(@ "hash_cf86c6012f506ac8", -1);
  setDvar(@ "hash_6b3c6361f0f5fdb", -1);
  setDvar(@ "hash_beff73861be066d", -1);
  setDvar(@ "hash_4db0d2c2cd85d418", -1);
  setDvar(@ "hash_2391c05a8700227f", -1);
  setDvar(@ "hash_e001a97b368816c9", -1);
  setDvar(@ "hash_8d73f9a1e40b4f01", -1);
  setDvar(@ "hash_2ebdafd7eec10a70", -1);
  setDvar(@ "hash_51dcebb527f3dd9b", -1);
  setDvar(@ "hash_399fdd0fb6b02227", -1);
  setDvar(@ "hash_b4302b21a46ef2a", -1);
  setDvar(@ "hash_d5bfe694a8598141", -1);
  setDvar(@ "hash_d5b99091b7c0443e", -1);
  var_bce73f6463c9b237 = -1;
  var_b43d15be227caed0 = -1;
  var_5c924f19086ad2e3 = -1;
  var_fab3643361e55a8e = -1;
  var_94c3e91284196d06 = -1;
  var_4283931c53ed41b0 = -1;
  movementstate = -1;
  var_683e84a7ba8a976f = -1;
  var_40631789cc951deb = -1;
  var_36d0fb1b95bf8135 = -1;
  spawnstate = -1;
  var_52b89f19e61f25a2 = -1;

  while(true) {
    var_bce73f6463c9b237 = function_1399ca755d810c38("<dev string:x3e8>", @ "hash_a0c0a5bf060c7bf2", var_bce73f6463c9b237);
    var_b43d15be227caed0 = function_1399ca755d810c38("<dev string:x407>", @ "hash_e5d7c5b83ec14d85", var_b43d15be227caed0);
    var_5c924f19086ad2e3 = function_1399ca755d810c38("<dev string:x426>", @ "hash_cefbf3b030b375ab", var_5c924f19086ad2e3);
    var_fab3643361e55a8e = function_1399ca755d810c38("<dev string:x445>", @ "hash_eac0e1ad1567fd42", var_fab3643361e55a8e);
    var_94c3e91284196d06 = function_1399ca755d810c38("<dev string:x464>", @ "hash_6b3c6361f0f5fdb", var_94c3e91284196d06);
    var_4283931c53ed41b0 = function_1399ca755d810c38("<dev string:x483>", @ "hash_cf86c6012f506ac8", var_4283931c53ed41b0);
    movementstate = function_1399ca755d810c38("<dev string:x4a3>", @ "hash_beff73861be066d", movementstate);
    var_40631789cc951deb = function_1399ca755d810c38("<dev string:x4b8>", @ "hash_8d73f9a1e40b4f01", var_40631789cc951deb);
    var_683e84a7ba8a976f = function_1399ca755d810c38("<dev string:x4d0>", @ "hash_e001a97b368816c9", var_683e84a7ba8a976f);
    var_36d0fb1b95bf8135 = function_1399ca755d810c38("<dev string:x4fc>", @ "hash_51dcebb527f3dd9b", var_36d0fb1b95bf8135);
    spawnstate = function_1399ca755d810c38("<dev string:x51a>", @ "hash_399fdd0fb6b02227", spawnstate);
    var_52b89f19e61f25a2 = function_1399ca755d810c38("<dev string:x52c>", @ "hash_b4302b21a46ef2a", var_52b89f19e61f25a2);
    function_4c07717228f2249b("<dev string:x54a>", @ "hash_4db0d2c2cd85d418");
    function_4c07717228f2249b("<dev string:x55b>", @ "hash_2391c05a8700227f");
    waitframe();
  }
}

function private function_1399ca755d810c38(key, dvar, var_61a9be095f4f77ea) {
  if(getdvarint(dvar) != var_61a9be095f4f77ea) {
    foreach(player in level.players) {
      player function_b66fa33d64ba4010(key);
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

function private function_1b411dfeddec6105(corpstable, hitloc) {
  if(hitloc == "head" && isdismembermentenabled()) {
    function_dfcee2ebe02a6ae7(corpstable, "halloweenHeadpop");
  }
}

function private function_88b034261873044() {
  if(getdvarint(@ "mgl", 0) != 0) {
    level._effect["vfx_mgl_sbandit_inspect_anim.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_ch01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_ch01.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_02.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_ch02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_ch02.vfx");
    level._effect["vfx_mgl_sbandit_inspect_anim_ch03"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_mgl_sbandit_inspect_anim_ch03.vfx");
    level._effect["vfx_mgl_sbandit_reload_anim_01.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_sbandit_reload_anim_01.vfx");
    level._effect["vfx_mgl_sbandit_reload_anim_02.vfx"] = loadfx("vfx/mgl/iw9/core/weapons/animations/reload/vfx_mgl_sbandit_reload_anim_02.vfx");
    level._effect["vfx_inspect_mtx_alpha50_spider_01"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_alpha50_spider_01.vfx");
    level._effect["vfx_inspect_mtx_alpha50_spider_02"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_alpha50_spider_02.vfx");
    level._effect["vfx_inspect_mtx_alpha50_spider_03"] = loadfx("vfx/mgl/iw9/core/weapons/animations/inspect/vfx_inspect_mtx_alpha50_spider_03.vfx");
  }
}