/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_vip\sp_jup_vip_makarov_reveal.gsc
***********************************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_4b7698942d6f679a;
#using script_51f0a664afd44022;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\dialogue_wheel;
#using scripts\sp\friendlyfire;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace sp_jup_vip_makarov_reveal;

function function_9c86059b5ab248a9() {}

function function_8607f97cb7f96343() {
  level.player modifybasefov(80, 1, 0.1, 0.1);
  level.player scripts\sp\player::player_movement_state("cqb");
  thread function_a533d8921f706b7e();
  spawn_allies();
  level thread function_c6aecb595687f644();
  set_start_location("reach_vip", [level.player, level.ally1, level.ally2]);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_92223cfdf808190e();
  thread function_e39d8a96b86719ce(0);
  level.ally1 scripts\anim\shared::forceuseweapon(level.var_c63685a4fe1d55fa, "primary");
  level.ally2 scripts\anim\shared::forceuseweapon(level.var_c63685a4fe1d55fa, "primary");
  animnode = getStruct("scene_first_doorway_reach_mak", "targetname");
  animnode thread scene::play(level.ally2, "shot_040_door_01_ally_02_idle");
  flag_set("flag_descend_ally2_fully_detached");
  animnode = getStruct("scene_first_doorway_reach_mak", "targetname");
  animnode thread scene::play(level.ally1, "shot_030_door_01_ally_01_idle");
  flag_set("flag_descend_ally1_fully_detached");
  flag_set("flag_reach_vip_open_door_2");
  flag_set("flag_end_descend");
  flag_wait("flag_open_door_2");
  var_9cce3514d979f535 = getStruct("scene_first_doorway_reach_mak", "targetname");
  allies = [level.ally1, level.ally2];
  var_9cce3514d979f535 thread function_57ac36ea7abb5af4(undefined, allies, ["shot_090_door_01_door_02_ally_01_breach"]);
  var_9cce3514d979f535 thread function_7e63b12a83899b7e();
  flag_wait_any("flag_level_g_riot_l_pair_01_damaged", "flag_level_g_riot_l_pair_02_damaged", "flag_level_g_riot_l_pair_03_damaged", "flag_level_g_riot_l_pair_04_damaged", "flag_level_g_riot_l_pair_05_damaged");
  var_33fb3f54e3157316 = 0;

  if(isDefined(level.var_622d18e0498316ce)) {
    foreach(guy in level.var_622d18e0498316ce) {
      if(!utility::is_dead_or_dying(guy)) {
        var_33fb3f54e3157316++;
      }
    }
  }

  if(var_33fb3f54e3157316 > 0) {
    var_9cce3514d979f535 scene::stop();
    level.ally1 enable_ai_color();
    level.ally2 enable_ai_color();
    level.ally1.ignoreall = 0;
    level.ally2.ignoreall = 0;
    function_52b5aaee35540c0b(1);
  }
}

function function_7e63b12a83899b7e() {
  self waittill("scene_complete");
  waitframe();
  function_52b5aaee35540c0b(1);
}

function function_9eb46bb7aa26855c() {
  reachvip_cell_01_prisoner_01 = spawn_targetname("reachvip_cell_01_prisoner_01", 1);
  reachvip_cell_01_prisoner_02 = spawn_targetname("reachvip_cell_01_prisoner_02", 1);
  reachvip_cell_01_prisoner_03 = spawn_targetname("reachvip_cell_01_prisoner_03", 1);
  reachvip_cell_01_prisoner_04 = spawn_targetname("reachvip_cell_01_prisoner_04", 1);
  reachvip_cell_01_prisoner_05 = spawn_targetname("reachvip_cell_01_prisoner_05", 1);
  waitframe();
  reachvip_cell_01_prisoner_01 function_84972f5da4b3994b(0);
  reachvip_cell_01_prisoner_02 function_84972f5da4b3994b(1);
  reachvip_cell_01_prisoner_03 function_84972f5da4b3994b(2);
  reachvip_cell_01_prisoner_04 function_84972f5da4b3994b(3);
  reachvip_cell_01_prisoner_05 function_84972f5da4b3994b(4);

  if(isplatformxb3() || isplatformps4()) {
    reachvip_cell_01_prisoner_01 dontcastshadows();
    reachvip_cell_01_prisoner_02 dontcastshadows();
    reachvip_cell_01_prisoner_03 dontcastshadows();
    reachvip_cell_01_prisoner_04 dontcastshadows();
    reachvip_cell_01_prisoner_05 dontcastshadows();
  }

  var_45db350f8858209a = [reachvip_cell_01_prisoner_01];
  var_112b953f384d9fb7 = ["shot_010_cell01_prisoner01"];
  var_33d30a1a870ec56c = getStruct("vip_0740_reach_makarov_bedlam_cell_01_prisoner_01", "targetname");
  var_33d30a1a870ec56c thread scene::play(var_45db350f8858209a, var_112b953f384d9fb7);
  var_45db340f88581e67 = [reachvip_cell_01_prisoner_02];
  var_112b963f384da1ea = ["shot_020_cell01_prisoner02"];
  var_33d30d1a870ecc05 = getStruct("vip_0740_reach_makarov_bedlam_cell_01_prisoner_02", "targetname");
  var_33d30d1a870ecc05 thread scene::play(var_45db340f88581e67, var_112b963f384da1ea);
  var_45db330f88581c34 = [reachvip_cell_01_prisoner_03];
  var_112b973f384da41d = ["shot_030_cell01_prisoner03"];
  var_33d30c1a870ec9d2 = getStruct("vip_0740_reach_makarov_bedlam_cell_01_prisoner_03", "targetname");
  var_33d30c1a870ec9d2 thread scene::play(var_45db330f88581c34, var_112b973f384da41d);
  var_45db320f88581a01 = [reachvip_cell_01_prisoner_04];
  var_112b903f384d94b8 = ["shot_010_prisoner_01_idle"];
  var_33d3071a870ebed3 = getStruct("vip_0740_reach_makarov_bedlam_cell_01_prisoner_04", "targetname");
  var_33d3071a870ebed3 thread scene::play(var_45db320f88581a01, var_112b903f384d94b8);
  var_45db310f885817ce = [reachvip_cell_01_prisoner_05];
  var_112b913f384d96eb = ["shot_030_prisoner_02_idle"];
  var_33d3061a870ebca0 = getStruct("vip_0740_reach_makarov_bedlam_cell_01_prisoner_05", "targetname");
  var_33d3061a870ebca0 thread scene::play(var_45db310f885817ce, var_112b913f384d96eb);
  reachvip_cell_01_prisoner_01 thread function_672fd16c1e8480a4();
  reachvip_cell_01_prisoner_02 thread function_672fd16c1e8480a4();
  reachvip_cell_01_prisoner_03 thread function_672fd16c1e8480a4();
  reachvip_cell_01_prisoner_04 thread function_672fd16c1e8480a4();
  reachvip_cell_01_prisoner_05 thread function_672fd16c1e8480a4();
  reachvip_cell_01_prisoner_01 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_01_prisoner_02 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_01_prisoner_03 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_01_prisoner_04 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_01_prisoner_05 utility::add_damage_function(&function_d799ec6e01836246);
  wait 0.75;
  reachvip_cell_02_prisoner_01 = spawn_targetname("reachvip_cell_02_prisoner_01", 1);
  reachvip_cell_02_prisoner_02 = spawn_targetname("reachvip_cell_02_prisoner_02", 1);
  reachvip_cell_02_prisoner_03 = spawn_targetname("reachvip_cell_02_prisoner_03", 1);
  reachvip_cell_02_prisoner_04 = spawn_targetname("reachvip_cell_02_prisoner_04", 1);
  reachvip_cell_02_prisoner_05 = spawn_targetname("reachvip_cell_02_prisoner_05", 1);
  waitframe();
  reachvip_cell_02_prisoner_01 function_84972f5da4b3994b(5);
  reachvip_cell_02_prisoner_02 function_84972f5da4b3994b(6);
  reachvip_cell_02_prisoner_03 function_84972f5da4b3994b(7);
  reachvip_cell_02_prisoner_04 function_84972f5da4b3994b(8);
  reachvip_cell_02_prisoner_05 function_84972f5da4b3994b(9);

  if(isplatformxb3() || isplatformps4()) {
    reachvip_cell_02_prisoner_01 dontcastshadows();
    reachvip_cell_02_prisoner_02 dontcastshadows();
    reachvip_cell_02_prisoner_03 dontcastshadows();
    reachvip_cell_02_prisoner_04 dontcastshadows();
    reachvip_cell_02_prisoner_05 dontcastshadows();
  }

  var_45db300f8858159b = [reachvip_cell_02_prisoner_01];
  var_112b923f384d991e = ["shot_010_prisoner_01_idle"];
  var_33d3091a870ec339 = getStruct("vip_0740_reach_makarov_bedlam_cell_02_prisoner_01", "targetname");
  var_33d3091a870ec339 thread scene::play(var_45db300f8858159b, var_112b923f384d991e);
  var_45db2f0f88581368 = [reachvip_cell_02_prisoner_02];
  var_112b933f384d9b51 = ["shot_050_cell02_prisoner02"];
  var_33d3081a870ec106 = getStruct("vip_0740_reach_makarov_bedlam_cell_02_prisoner_02", "targetname");
  var_33d3081a870ec106 thread scene::play(var_45db2f0f88581368, var_112b933f384d9b51);
  wait 0.5;
  var_45db2e0f88581135 = [reachvip_cell_02_prisoner_03];
  var_112b8c3f384d8bec = ["shot_040_cell02_prisoner01"];
  var_33d3131a870ed937 = getStruct("vip_0740_reach_makarov_bedlam_cell_02_prisoner_03", "targetname");
  var_33d3131a870ed937 thread scene::play(var_45db2e0f88581135, var_112b8c3f384d8bec);
  var_45db2d0f88580f02 = [reachvip_cell_02_prisoner_04];
  var_112b8d3f384d8e1f = ["shot_010_prisoner_01_idle"];
  var_33d3121a870ed704 = getStruct("vip_0740_reach_makarov_bedlam_cell_02_prisoner_04", "targetname");
  var_33d3121a870ed704 thread scene::play(var_45db2d0f88580f02, var_112b8d3f384d8e1f);
  var_f9365b28d9cfd5de = [reachvip_cell_02_prisoner_05];
  var_1078c108d2b5d5e5 = ["shot_030_prisoner_02_idle"];
  var_7e49457057c0954 = getStruct("vip_0740_reach_makarov_bedlam_cell_02_prisoner_05", "targetname");
  var_7e49457057c0954 thread scene::play(var_f9365b28d9cfd5de, var_1078c108d2b5d5e5);
  reachvip_cell_02_prisoner_01 thread function_672fd16c1e8480a4();
  reachvip_cell_02_prisoner_02 thread function_672fd16c1e8480a4();
  reachvip_cell_02_prisoner_03 thread function_672fd16c1e8480a4();
  reachvip_cell_02_prisoner_04 thread function_672fd16c1e8480a4();
  reachvip_cell_02_prisoner_05 thread function_672fd16c1e8480a4();
  reachvip_cell_02_prisoner_01 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_02_prisoner_02 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_02_prisoner_03 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_02_prisoner_04 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_02_prisoner_05 utility::add_damage_function(&function_d799ec6e01836246);
  wait 0.75;
  reachvip_cell_03_prisoner_01 = spawn_targetname("reachvip_cell_03_prisoner_01", 1);
  reachvip_cell_03_prisoner_02 = spawn_targetname("reachvip_cell_03_prisoner_02", 1);
  reachvip_cell_03_prisoner_03 = spawn_targetname("reachvip_cell_03_prisoner_03", 1);
  reachvip_cell_03_prisoner_04 = spawn_targetname("reachvip_cell_03_prisoner_04", 1);
  reachvip_cell_03_prisoner_05 = spawn_targetname("reachvip_cell_03_prisoner_05", 1);
  waitframe();
  reachvip_cell_03_prisoner_01 function_84972f5da4b3994b(10);
  reachvip_cell_03_prisoner_02 function_84972f5da4b3994b(11);
  reachvip_cell_03_prisoner_03 function_84972f5da4b3994b(12);
  reachvip_cell_03_prisoner_04 function_84972f5da4b3994b(13);
  reachvip_cell_03_prisoner_05 function_84972f5da4b3994b(0);

  if(isplatformxb3() || isplatformps4()) {
    reachvip_cell_03_prisoner_01 dontcastshadows();
    reachvip_cell_03_prisoner_02 dontcastshadows();
    reachvip_cell_03_prisoner_03 dontcastshadows();
    reachvip_cell_03_prisoner_04 dontcastshadows();
    reachvip_cell_03_prisoner_05 dontcastshadows();
  }

  var_f9365c28d9cfd811 = [reachvip_cell_03_prisoner_01];
  var_1078c008d2b5d3b2 = ["shot_060_prisoner_05"];
  var_7e49557057c0b87 = getStruct("vip_0740_reach_makarov_bedlam_cell_03_prisoner_01", "targetname");
  var_7e49557057c0b87 thread scene::play(var_f9365c28d9cfd811, var_1078c008d2b5d3b2);
  var_f9365928d9cfd178 = [reachvip_cell_03_prisoner_02];
  var_1078bf08d2b5d17f = ["shot_070_cell03_prisoner02"];
  var_7e49657057c0dba = getStruct("vip_0740_reach_makarov_bedlam_cell_03_prisoner_02", "targetname");
  var_7e49657057c0dba thread scene::play(var_f9365928d9cfd178, var_1078bf08d2b5d17f);
  var_f9365a28d9cfd3ab = [reachvip_cell_03_prisoner_03];
  var_1078be08d2b5cf4c = ["shot_060_cell03_prisoner01"];
  var_7e49757057c0fed = getStruct("vip_0740_reach_makarov_bedlam_cell_03_prisoner_03", "targetname");
  var_7e49757057c0fed thread scene::play(var_f9365a28d9cfd3ab, var_1078be08d2b5cf4c);
  wait 0.35;
  var_f9365f28d9cfdeaa = [reachvip_cell_03_prisoner_04];
  var_1078bd08d2b5cd19 = ["shot_010_prisoner_01_idle"];
  var_7e49057057c0088 = getStruct("vip_0740_reach_makarov_bedlam_cell_03_prisoner_04", "targetname");
  var_7e49057057c0088 thread scene::play(var_f9365f28d9cfdeaa, var_1078bd08d2b5cd19);
  wait 0.35;
  var_f9366028d9cfe0dd = [reachvip_cell_03_prisoner_05];
  var_1078bc08d2b5cae6 = ["shot_030_prisoner_02_idle"];
  var_7e49157057c02bb = getStruct("vip_0740_reach_makarov_bedlam_cell_03_prisoner_05", "targetname");
  var_7e49157057c02bb thread scene::play(var_f9366028d9cfe0dd, var_1078bc08d2b5cae6);
  reachvip_cell_03_prisoner_01 thread function_672fd16c1e8480a4();
  reachvip_cell_03_prisoner_02 thread function_672fd16c1e8480a4();
  reachvip_cell_03_prisoner_03 thread function_672fd16c1e8480a4();
  reachvip_cell_03_prisoner_04 thread function_672fd16c1e8480a4();
  reachvip_cell_03_prisoner_05 thread function_672fd16c1e8480a4();
  reachvip_cell_03_prisoner_01 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_03_prisoner_02 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_03_prisoner_03 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_03_prisoner_04 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_cell_03_prisoner_05 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_bg_cell_03_prisoner_01 = spawn_targetname("reachvip_bg_cell_03_prisoner_01", 1);
  reachvip_bg_cell_03_prisoner_02 = spawn_targetname("reachvip_bg_cell_03_prisoner_02", 1);
  reachvip_bg_cell_03_prisoner_03 = spawn_targetname("reachvip_bg_cell_03_prisoner_03", 1);
  reachvip_bg_cell_03_prisoner_04 = spawn_targetname("reachvip_bg_cell_03_prisoner_04", 1);
  waitframe();
  reachvip_bg_cell_03_prisoner_01 function_84972f5da4b3994b(6);
  reachvip_bg_cell_03_prisoner_02 function_84972f5da4b3994b(7);
  reachvip_bg_cell_03_prisoner_03 function_84972f5da4b3994b(8);
  reachvip_bg_cell_03_prisoner_04 function_84972f5da4b3994b(9);

  if(isplatformxb3() || isplatformps4()) {
    reachvip_bg_cell_03_prisoner_01 dontcastshadows();
    reachvip_bg_cell_03_prisoner_02 dontcastshadows();
    reachvip_bg_cell_03_prisoner_03 dontcastshadows();
    reachvip_bg_cell_03_prisoner_04 dontcastshadows();
  }

  var_f931d328d9cab4ef = [reachvip_bg_cell_03_prisoner_01];
  var_107d4508d2baee08 = ["shot_060_prisoner_05"];
  var_7f20857058b1cf5 = getStruct("vip_0740_reach_makarov_bedlam_bg_cell_03_prisoner_01", "targetname");
  var_7f20857058b1cf5 thread scene::play(var_f931d328d9cab4ef, var_107d4508d2baee08);
  wait 0.5;
  var_f931d228d9cab2bc = [reachvip_bg_cell_03_prisoner_02];
  var_107d4608d2baf03b = ["shot_010_prisoner_01_idle"];
  var_7f20757058b1ac2 = getStruct("vip_0740_reach_makarov_bedlam_bg_cell_03_prisoner_02", "targetname");
  var_7f20757058b1ac2 thread scene::play(var_f931d228d9cab2bc, var_107d4608d2baf03b);
  var_f931d128d9cab089 = [reachvip_bg_cell_03_prisoner_03];
  var_107d4b08d2bafb3a = ["shot_050_prisoner_03"];
  var_7f20257058b0fc3 = getStruct("vip_0740_reach_makarov_bedlam_bg_cell_03_prisoner_03", "targetname");
  var_7f20257058b0fc3 thread scene::play(var_f931d128d9cab089, var_107d4b08d2bafb3a);
  wait 0.5;
  var_f931d028d9caae56 = [reachvip_bg_cell_03_prisoner_04];
  var_107d4c08d2bafd6d = ["shot_010_prisoner_01_idle"];
  var_7f20157058b0d90 = getStruct("vip_0740_reach_makarov_bedlam_bg_cell_03_prisoner_04", "targetname");
  var_7f20157058b0d90 thread scene::play(var_f931d028d9caae56, var_107d4c08d2bafd6d);
  reachvip_bg_cell_03_prisoner_01 thread function_672fd16c1e8480a4();
  reachvip_bg_cell_03_prisoner_02 thread function_672fd16c1e8480a4();
  reachvip_bg_cell_03_prisoner_03 thread function_672fd16c1e8480a4();
  reachvip_bg_cell_03_prisoner_04 thread function_672fd16c1e8480a4();
  reachvip_bg_cell_03_prisoner_01 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_bg_cell_03_prisoner_02 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_bg_cell_03_prisoner_03 utility::add_damage_function(&function_d799ec6e01836246);
  reachvip_bg_cell_03_prisoner_04 utility::add_damage_function(&function_d799ec6e01836246);
  var_b8790434d82eaf2c = [reachvip_cell_01_prisoner_01, reachvip_cell_01_prisoner_02, reachvip_cell_01_prisoner_03, reachvip_cell_01_prisoner_04, reachvip_cell_01_prisoner_05];
  var_70c343d2de1d7baf = [var_33d30a1a870ec56c, var_33d30d1a870ecc05, var_33d30c1a870ec9d2, var_33d3071a870ebed3, var_33d3061a870ebca0];
  var_9d5f636c7cb2c555 = [reachvip_cell_02_prisoner_01, reachvip_cell_02_prisoner_02, reachvip_cell_02_prisoner_03, reachvip_cell_02_prisoner_04, reachvip_cell_02_prisoner_05];
  var_92cdf8a0556107e0 = [var_33d3091a870ec339, var_33d3081a870ec106, var_33d3131a870ed937, var_33d3121a870ed704, var_7e49457057c0954];
  var_12b4c0dbcfc566ee = [reachvip_cell_03_prisoner_01, reachvip_cell_03_prisoner_02, reachvip_cell_03_prisoner_03, reachvip_cell_03_prisoner_04, reachvip_cell_03_prisoner_05];
  var_44adb1bd7d27a439 = [var_7e49557057c0b87, var_7e49657057c0dba, var_7e49757057c0fed, var_7e49057057c0088, var_7e49157057c02bb];
  var_956ccbe037ab28e9 = [reachvip_bg_cell_03_prisoner_01, reachvip_bg_cell_03_prisoner_02, reachvip_bg_cell_03_prisoner_03, reachvip_bg_cell_03_prisoner_04];
  var_e76b612d7ec46064 = [var_7f20857058b1cf5, var_7f20757058b1ac2, var_7f20257058b0fc3, var_7f20157058b0d90];
  thread function_d3fc0c68dd9f1bd3(var_70c343d2de1d7baf, var_b8790434d82eaf2c);
  thread function_d3fc0c68dd9f1bd3(var_92cdf8a0556107e0, var_9d5f636c7cb2c555);
  thread function_d3fc0c68dd9f1bd3(var_44adb1bd7d27a439, var_12b4c0dbcfc566ee);
  thread function_d3fc0c68dd9f1bd3(var_e76b612d7ec46064, var_956ccbe037ab28e9);
  thread function_ace6e2038327db35(var_70c343d2de1d7baf, var_b8790434d82eaf2c);
  thread function_ace6e2038327db35(var_92cdf8a0556107e0, var_9d5f636c7cb2c555);
  thread function_ace6e2038327db35(var_44adb1bd7d27a439, var_12b4c0dbcfc566ee);
  thread function_ace6e2038327db35(var_e76b612d7ec46064, var_956ccbe037ab28e9);
}

function function_ace6e2038327db35(animnodes, guys) {
  while(!flag("flag_obj_reach_makarov_complete")) {
    level.player waittill("grenade_fire", grenade, weapon);

    if(isDefined(grenade)) {
      level.player thread function_e04998f30599575d(grenade, animnodes, guys);
    }

    waitframe();
  }
}

function function_e04998f30599575d(grenade, animnodes, guys) {
  self endon("death");
  ret = grenade waittill_any_timeout_no_endon_death(8, "death", "missile_stuck");

  if(ret == "missile_stuck" && isDefined(grenade)) {
    guy_index = 0;
    var_b77f3ea922835176 = 0;

    foreach(guy in guys) {
      if(!is_dead_or_dying(guy)) {
        var_b77f3ea922835176++;
        var_c41213d3dde06933 = distance(grenade.origin, guy.origin);

        if(var_c41213d3dde06933 < 70) {
          thread function_7fa2997ddb2cdeb5(guy, 0, guy_index, animnodes, grenade);
        } else if(var_c41213d3dde06933 < 200) {
          react_offset = randomfloatrange(0.25, 0.75);

          if(var_b77f3ea922835176 > 2) {
            react_offset = randomfloatrange(0.75, 1.25);
          }

          thread function_7fa2997ddb2cdeb5(guy, 0, guy_index, animnodes);
        }
      }

      guy_index++;
    }

    return;
  }
}

function function_d3fc0c68dd9f1bd3(animnodes, guys) {
  index = 0;

  foreach(guy in guys) {
    if(isDefined(guy) && !is_dead_or_dying(guy)) {
      guy thread namespace_9c93a5b828db4a4b::function_1308ec055ee61e28("flag_obj_reach_makarov_complete");
      guy addaieventlistener("damage");
      guy addaieventlistener("suppression");
      guy addaieventlistener("bulletwhizby");
      guy addaieventlistener("explosion");
      guy addaieventlistener("grenade danger");
      guy addaieventlistener("projectile_impact");
      guy addaieventlistener("gunshot_impact");
      guy thread function_be73c51f6bd773ac(guys, index, animnodes);
    }

    index++;
  }
}

function function_be73c51f6bd773ac(guys, index, animnodes) {
  self endon("death");

  while(true) {
    self waittill("ai_events", events);

    foreach(event in events) {
      if(isDefined(event.entity) && event.entity == level.player || isDefined(event.entity) && isDefined(event.type) && event.type == "grenade danger" && event.entity.model == "projectile_grenade_smoke_v0" || isDefined(event.entity) && isDefined(event.type) && event.type == "grenade danger" && event.entity.model == "projectile_grenade_semtex_v0_sp") {
        if(distance(event.origin, self.origin) < 200) {
          guy_index = 0;
          var_b77f3ea922835176 = 0;

          foreach(guy in guys) {
            if(!is_dead_or_dying(guy)) {
              var_b77f3ea922835176++;
              react_offset = randomfloatrange(0.25, 0.75);

              if(var_b77f3ea922835176 > 2) {
                react_offset = randomfloatrange(0.75, 1.25);
              }

              thread function_7fa2997ddb2cdeb5(guy, react_offset, guy_index, animnodes);
            }

            guy_index++;
          }

          return;
        }
      }
    }

    waitframe();
  }
}

function function_7fa2997ddb2cdeb5(guy, react_offset, index, animnodes, var_1a5bc526adb58158) {
  guy endon("death");
  wait react_offset;
  animnodes[index] scene::stop();
  waitframe();
  guy function_b661b022700ba72f("script", 1);

  if(isDefined(var_1a5bc526adb58158)) {
    function_60daa23100a2b874(var_1a5bc526adb58158, guy);
  } else {
    waitframe();
    guy function_d5cda8a759cc36bc("flee");
    waitframe();

    if(guy.targetname != "reachvip_cell_01_prisoner_03" && guy.targetname != "reachvip_cell_03_prisoner_02") {
      guy function_d5cda8a759cc36bc("cower");
    }

    guy.deathfunction = &function_ce450b9957138bd5;
  }

  guy.friend_kill_points = -1200;
}

function function_50ae3b3657340b79() {
  wait 7;
  var_64deafcbf8d940bd = getEnt("level_g_path_blocker_r", "targetname");
  var_64deafcbf8d940bd disconnectPaths();
}

function function_81f318b2b7b1de75() {}

function function_34c0d201362a5fc4() {
  flag_wait("flag_hallway_guys_2_reached_cover");
  self.fixednode = 0;
}

function function_a0f7ede78b7609e9() {
  while(!flag("flag_hallway_guys_dead")) {
    numalive = 0;

    foreach(guy in level.hallway_guys) {
      if(!is_dead_or_dying(guy)) {
        numalive++;
      }
    }

    if(numalive == 0) {
      flag_set("flag_hallway_guys_dead");
    }

    waitframe();
  }
}

function function_69b757cb0b52a307() {
  flag_wait("flag_hallway_squad_out_of_gate");
  wait 1;

  while(!flag("flag_hallway_guys_dead")) {
    foreach(guy in level.hallway_guys) {
      if(!is_dead_or_dying(guy)) {
        level.ally1 aim_at(guy getEye(), 0, undefined, 0.25);
        level.ally1 link_aim_to(guy, "tag_eye", (0, 0, 0));
        level.ally1 shoot(10, guy getEye());
        waitframe();
        level.ally1 shoot(10, guy getEye());
        waitframe();
        level.ally1 shoot(10, guy getEye());
        waitframe();
        level.ally1 shoot(10, guy getEye());
        waitframe();
        level.ally1 shoot(10, guy getEye());

        if(isDefined(level.ally1.aim_target)) {
          level.ally1.aim_target unlink();
          level.ally1 stop_aiming();
        }

        waitframe();
      }

      wait 0.5;
    }

    waitframe();
  }
}

function function_eee9888228de1750() {
  while(!flag("flag_hallway_guys_2_dead")) {
    numalive = 0;

    foreach(guy in level.hallway_guys) {
      if(!is_dead_or_dying(guy)) {
        numalive++;
      }
    }

    if(numalive == 0) {
      flag_set("flag_hallway_guys_2_dead");
    }

    waitframe();
  }
}

function function_b623a467228270e() {
  flag_wait("flag_hallway_guys_2_reached_end");
  wait 3;
  flag_wait("flag_hallway_guys_dead");

  while(!flag("flag_hallway_guys_2_dead")) {
    foreach(guy in level.var_bc7eb85b0c681cf3) {
      if(!is_dead_or_dying(guy)) {
        level.ally2 aim_at(guy getEye(), 0, undefined, 0.25);
        level.ally2 link_aim_to(guy, "tag_eye", (0, 0, 0));
        level.ally2 shoot(10, guy getEye());
        waitframe();
        level.ally2 shoot(10, guy getEye());
        waitframe();
        level.ally2 shoot(10, guy getEye());
        waitframe();
        level.ally2 shoot(10, guy getEye());
        waitframe();
        level.ally2 shoot(10, guy getEye());

        if(isDefined(level.ally2.aim_target)) {
          level.ally2.aim_target unlink();
          level.ally2 stop_aiming();
        }

        waitframe();
      }

      wait 0.5;
    }

    waitframe();
  }
}

function function_1c892ae0bde7060e() {
  flag_wait_all("flag_stairs_guy_1_dead", "flag_stairs_guy_2_dead");
  wait 1;

  if(nvg_player::is_nvg_on()) {
    utility::display_hint("nvg_hint", 60, 0, level.player, "night_vision_off");
  }
}

function function_8bd8b8228e5bcef2() {
  wait 1;

  while(!is_dead_or_dying(self) && !utility::flag("flag_stairs_guys_stop_megafire")) {
    rand_wait = randomfloatrange(0.8, 2.5);
    rand_shots = randomintrange(4, 7);
    wait rand_wait;

    for(i = 0; i < rand_shots; i++) {
      if(!is_dead_or_dying(self)) {
        self shoot(0.5, level.player);
      }

      wait 0.08;
    }
  }
}

function function_4ed0c87d948afc54() {
  var_9cce3514d979f535 = getStruct("scene_first_doorway_reach_mak", "targetname");
  allies = [level.ally1, level.ally2];
  flag_wait("flag_end_descend");
  namespace_9c93a5b828db4a4b::function_e4f5a41bcb8bcb9d();
  var_814b8e26aaccb9b8 = getEnt("vip_reach_vip_halldoor_00", "targetname");
  var_e28f104436c3205d = getStruct("vip_reach_vip_halldoor_00_dest", "targetname");
  var_d6280c4c5ef26bf5 = var_e28f104436c3205d.origin;
  var_814b8e26aaccb9b8 moveTo(var_d6280c4c5ef26bf5, 3, 1, 1);
  thread function_50ae3b3657340b79();
  thread function_9eb46bb7aa26855c();
  thread function_29e86fbae3c53da5();
  thread function_1c892ae0bde7060e();
  flag_set("vip_fov_reachvip_start");
  thread namespace_165c742e346e899e::function_7d9c34fea7abba03();

  if(!isDefined(level.ally1)) {
    spawn_allies();
    struct1 = getStruct("ally1_ascender_teleport", "targetname");
    struct2 = getStruct("ally2_ascender_teleport", "targetname");
    level.ally1 teleport_ent(struct1);
    level.ally2 teleport_ent(struct2);
    waitframe();
  } else {
    level.ally1 enable_ai_color();
    level.ally2 enable_ai_color();
  }

  level.ally1.pushable = 0;
  level.ally2.pushable = 0;
  level thread function_2d1e7989f5d6b19f();
  setsaveddvar(@ "hash_e25973f21baa3bad", 0);
  flag_wait("flag_open_door_2");
  activate_trigger_with_targetname("trig_allies_to_first_path_node");
  flag_set_delayed("flag_reach_vip_door_2_opened", 1);
  flag_wait("flag_open_door_3");
  wait 2;
  var_fce0a7d5ecd9ce78 = getStruct("ally_poi_struct_array", "targetname");
  waitframe();
  flag_wait("flag_player_approach_dungeon_choke");
  stairs_guy_1 = getEnt("stairs_guy_1", "targetname");
  stairs_guy_2 = getEnt("stairs_guy_2", "targetname");
  stairs_guy_1 = spawn_targetname("stairs_guy_1");
  stairs_guy_2 = spawn_targetname("stairs_guy_2");
  stairs_guy_1.health = 50;
  stairs_guy_2.health = 50;
  stairs_guy_1 set_grenadeammo(0);
  stairs_guy_2 set_grenadeammo(0);
  stairs_guy_1 thread function_8bd8b8228e5bcef2();
  stairs_guy_2 thread function_8bd8b8228e5bcef2();
  flag_set_delayed("flag_stairs_guys_stop_megafire", 3);
  wait 1;

  if(!is_dead_or_dying(stairs_guy_2)) {
    level.ally1 aim_at(stairs_guy_2 getEye(), 0, undefined, 0.25);
    level.ally1 link_aim_to(stairs_guy_2, "tag_eye", (0, 0, 0));
    level.ally1 shoot(10, stairs_guy_2 getEye());
    waitframe();
    level.ally1 shoot(10, stairs_guy_2 getEye());
    waitframe();
    level.ally1 shoot(10, stairs_guy_2 getEye());
    waitframe();
    level.ally1 shoot(10, stairs_guy_2 getEye());
    waitframe();
    level.ally1 shoot(10, stairs_guy_2 getEye());

    if(isDefined(level.ally1.aim_target)) {
      level.ally1.aim_target unlink();
      level.ally1 stop_aiming();
    }

    waitframe();
  }

  if(!is_dead_or_dying(stairs_guy_1)) {
    wait 0.25;
    level.ally2 aim_at(stairs_guy_1 getEye(), 0, undefined, 0.25);
    level.ally2 link_aim_to(stairs_guy_1, "tag_eye", (0, 0, 0));
    waitframe();
    level.ally2 shoot(10, stairs_guy_1 getEye());
    waitframe();
    level.ally2 shoot(10, stairs_guy_1 getEye());
    waitframe();
    level.ally2 shoot(10, stairs_guy_1 getEye());
    waitframe();
    level.ally2 shoot(10, stairs_guy_1 getEye());
    waitframe();
    level.ally2 shoot(10, stairs_guy_1 getEye());

    if(isDefined(level.ally2.aim_target)) {
      level.ally2.aim_target unlink();
      level.ally2 stop_aiming();
    }

    waitframe();
  }

  flag_wait_all("flag_stairs_guy_1_dead", "flag_stairs_guy_2_dead");
  wait 1;
  activate_trigger_with_targetname("stair_guys_are_dead");
  flag_wait("flag_player_see_gate");
  flag_wait("flag_player_opened_cellblock_door");
  flag_set("flag_show_mak_reveal_breach_prompt");
  flag_set("flag_makarov_pcap");
}

function function_a5c6b755b3e3c079() {
  set_goalRadius(32);
  thread utility::demeanor_override("cqb");
  goal = getStruct(self.target, "targetname");
  self setgoalpos(goal.origin);
  flag_wait("flag_player_approach_dungeon_choke");
  wait 5;
  newgoal = getStruct(goal.target, "targetname");
  scripts\sp\spawner::go_to_node(newgoal);
}

function function_50e68fbce0e7f935() {
  flag_set("flag_show_mak_reveal_breach_prompt");
  flag_set("vip_fov_reachvip_start");
  flag_set("vip_fov_reachvip_panop_interior");
  flag_set("flag_makarov_pcap");
  function_64f815da552ce8c6();
  clearmusicstate();
  setmusicstate("mx_vip_reach_vip");
}

function function_29e86fbae3c53da5() {
  function_64f815da552ce8c6();
  flag_wait("flag_open_door_2");
  flag_wait("flag_player_approach_dungeon_choke");
  wait 1;

  if(distance(level.ally1.origin, level.player.origin) < 300) {
    level.ally1 say("dx_sp_jvip_desc_koa1_contact");
  }

  flag_wait_all("flag_stairs_guy_1_dead", "flag_stairs_guy_2_dead");
  wait 0.5;
  level.ally1 say("dx_sp_jvip_reac_koa1_clear");
  flag_wait("flag_player_enter_makarov_area");
  thread function_d231f69b5b4e7df3();
  level.ally1 say("dx_sp_jvip_reac_koa1_alphamovingonsubleve", 0, 0, 0, 1.5);
  flag_wait("flag_reachvip_readybreach");
}

function function_2d1e7989f5d6b19f() {
  level.ally1 set_movement_speed(130);
  level.ally2 set_movement_speed(130);
  var_814b9026aaccbe1e = getEnt("vip_reach_vip_halldoor_02", "targetname");
  var_7426e80706c3b433 = getEnt("vip_reach_vip_halldoor_02_col", "targetname");
  var_814b9126aaccc051 = getEnt("vip_reach_vip_halldoor_03", "targetname");
  flag_wait("flag_reach_vip_open_door_2");
  thread function_8615872379b95ba0();
  level.ally1 say("dx_sp_jvip_reac_koa1_alpha1tobravo1open55");
  function_64f815da552ce8c6();
  level.player.vo_handler thread say("dx_sp_jvip_reac_kob1_check");
  level.player thread say("dx_sp_jvip_reac_koa2_alphamovingtosubleve", 0, 0, 0, 2);
  thread flag_set_delayed("flag_reach_vip_door_1_opened", 0.75);
  flag_set("flag_reach_vip_door_2_open");
  flag_wait("flag_descend_ally1_fully_detached");
  flag_wait("flag_descend_ally2_fully_detached");
  thread flag_set_delayed("flag_open_door_2", 0.75);
  var_4d5a4c07a5d3ec3f = getStruct("vip_reach_vip_halldoor_02_dest", "targetname");
  var_885b011974ac6c17 = var_4d5a4c07a5d3ec3f.origin;

  if(isDefined(var_7426e80706c3b433)) {
    var_7426e80706c3b433 linkTo(var_814b9026aaccbe1e, "tag_origin");
  }

  var_814b9026aaccbe1e moveTo(var_885b011974ac6c17, 2.5, 1, 1);
  hallway_nav_blocker = getEnt("hallway_nav_blocker", "targetname");
  createnavobstaclebyent(hallway_nav_blocker);
  hallway_nav_blocker_2 = getEnt("hallway_nav_blocker_2", "targetname");
  createnavobstaclebyent(hallway_nav_blocker_2);
  var_7843952984b9f74c = getStruct("vip_reach_vip_halldoor_03_dest", "targetname");
  var_a06ec1072220869a = var_7843952984b9f74c.origin;
  var_814b9126aaccc051 moveTo(var_a06ec1072220869a, 2.5, 1, 1);
  waitframe();
  flag_set("vip_fov_reachvip_panop_interior");
  reachvip_dungeondoor_left = getEnt("reachvip_dungeondoor_left", "targetname");
  reachvip_dungeondoor_left rotateby((0, 90, 0), 1, 0.05, 0.05);
  reachvip_dungeondoor_right = getEnt("reachvip_dungeondoor_right", "targetname");
  reachvip_dungeondoor_right rotateby((0, -90, 0), 1, 0.05, 0.05);
  var_3b7724235cb062fb = getEnt("panopticon_doors_clip", "targetname");
  var_3b7724235cb062fb notsolid();
  var_3b7724235cb062fb connectpaths();
  level.ally1.ignoreall = 0;
  level.ally2.ignoreall = 0;
  flag_set("flag_reach_vip_door_3_open");
  delaythread(10, &namespace_9c93a5b828db4a4b::function_f46be527a8306552, "flag_moveallys", undefined, 1, 2);
  flag_wait("flag_moveallys");
  activate_trigger_with_targetname("hallway_guys_are_dead");
  flag_wait("flag_moveallys_airlock");
  activate_trigger_with_targetname("allies_to_airlockroom");
  level.ally1.ignoresuppression = 1;
  level.ally2.ignoresuppression = 1;
  flag_wait("flag_player_approach_dungeon_choke");
  hallway_nav_blocker delete();
  hallway_nav_blocker_2 delete();
  flag_wait_all("flag_stairs_guy_1_dead", "flag_stairs_guy_2_dead");
  wait 1;
  activate_trigger_with_targetname("stair_guys_are_dead");
  thread function_7256e1f529c8173c();
  flag_set_delayed("flag_reach_vip_door_3_opened", 1.5);
  flag_wait("flag_player_enter_makarov_area");
  level.ally1.ignoresuppression = 0;
  level.ally2.ignoresuppression = 0;
  flag_wait("flag_player_see_gate");
}

function function_7256e1f529c8173c() {
  flag_wait("flag_ally_reach_breach_door");
  delaythread(8, &namespace_9c93a5b828db4a4b::function_f46be527a8306552, "flag_obj_reach_makarov_complete", undefined, 1, 2);
}

function function_8615872379b95ba0() {
  wait 0.5;
  setmusicstate("mx_vip_reach_vip");
}

function function_8194719af564364f() {}

function function_765dbc792acc92ad() {
  level.player modifybasefov(55, 1, 0.1, 0.1);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_acdd340de8aeefc();
  thread function_e39d8a96b86719ce(0);
  spawn_allies();
  level thread function_a533d8921f706b7e();
  level thread function_c6aecb595687f644();
  level.ally1 scripts\anim\shared::forceuseweapon(level.var_c63685a4fe1d55fa, "primary");
  level.ally2 scripts\anim\shared::forceuseweapon(level.var_c63685a4fe1d55fa, "primary");
  set_start_location("makarov_reveal", [level.player, level.ally2, level.ally1]);
}

function function_f2298edf19618d3() {
  vip_reachvip_makcelldoor = getEnt("vip_reachvip_makcelldoor", "targetname");

  if(isDefined(vip_reachvip_makcelldoor)) {
    vip_reachvip_makcelldoor hide();
  }
}

function function_9b1450f5c5644b5a() {
  blocker = getEnt("makarov_reveal_door_blocker", "targetname");
  waitframe();
  flag_wait("flag_makarov_pcap_complete");
  blocker delete();
}

function function_4473dc8032381786() {
  thread function_323a235a52df766f();
  thread function_9b1450f5c5644b5a();
  level.ally1 set_movement_speed(90);
  level.ally2 set_movement_speed(90);
  flag_wait("flag_makarov_pcap");
  activate_trigger_with_targetname("trigger_reach_makarov_reveal");
  interact_struct = getStruct("reach_vip_pcap_interact", "targetname");
  interact_struct create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_VIP/INTERACT_BREACH", 360, 500, 40);
  shot_array1 = ["shot_010"];
  shot_array2 = ["shot_020", "shot_030", "shot_040", "shot_050", "shot_060", "shot_070", "shot_080", "shot_090", "shot_100"];
  var_5f34b51f7cb0df88 = ["shot_110"];
  var_5f34bc1f7cb0eeed = ["shot_120"];
  var_5f34bb1f7cb0ecba = ["shot_130", "shot_140"];
  var_5f34ba1f7cb0ea87 = ["shot_150", "shot_160"];
  animnode = getStruct("scene_vip_0800_reach_makarov_reveal", "targetname");
  character_array = [level.ally1, level.ally2, level.player];
  interact_struct waittill("trigger");
  thread function_40bee596e36ccfaa();
  level.player val::set("makarov_reveal", "allow_movement", 0);
  thread delete_live_grenades();
  level.player function_5ee68a5b461ab5b8(1);
  namespace_9c3faffc064160e8::function_7b2743af8410b08e();
  function_52b5aaee35540c0b(0);
  flag_set("flag_obj_reach_makarov_complete");
  level.ally1 set_force_color("c");
  level.ally2 set_force_color("y");
  activate_trigger_with_targetname("post_makarov_reveal_pos");
  level.player player::focusdisable();
  function_1ae8f046dee579e0(1);

  if(!isDefined(level.makarov)) {
    function_dc2aa213aa5830aa(getStruct("makarov_start_cell", "targetname"));
    level.makarov set_force_color("r");
    level.makarov.weapon = nullweapon();
  }

  waitframe();
  level.player val::set("makarov_reveal", "allow_movement", 1);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  battlechatter_off("axis");
  animnode thread function_57ac36ea7abb5af4(undefined, character_array, shot_array1);
  thread namespace_165c742e346e899e::function_7bc3d7f287b24070();
  var_ba48df5d0f8881cb = animnode scene::get_entity("plr_3P");
  var_ba48df5d0f8881cb setModel("body_c_jup_sp_villain_nolan_urban");
  var_ba48df5d0f8881cb detach(var_ba48df5d0f8881cb.headmodel);
  var_ba48df5d0f8881cb.headmodel = "c_jup_head_hero_nolan_urban";
  var_ba48df5d0f8881cb attach(var_ba48df5d0f8881cb.headmodel);
  var_ba48df5d0f8881cb.name = "";
  var_7529f1cbe0cf9400 = make_weapon("jup_jp02_ar_bromeo805_vip");
  var_ba48df5d0f8881cb scripts\anim\shared::forceuseweapon(var_7529f1cbe0cf9400, "primary");
  flag_set("flag_makarov_pcap_start");
  var_b3116874a755bacb = spawnStruct();
  var_b3116874a755bacb.weapon = level.player getcurrentweapon();
  var_b3116874a755bacb.clip = level.player getweaponammoclip(var_b3116874a755bacb.weapon);
  var_b3116874a755bacb.stock = level.player getammocount(var_b3116874a755bacb.weapon) - var_b3116874a755bacb.clip;
  character_array = [level.ally1, level.ally2, level.player, level.makarov];
  animnode waittill("scene_complete");
  thread function_f2298edf19618d3();
  level.makarov setModel("body_c_jup_sp_villain_makarov_prisoner");
  level.makarov detach(level.makarov.headmodel);
  level.makarov.headmodel = "c_jup_head_hero_makarov";
  level.makarov attach(level.makarov.headmodel);
  animnode thread function_57ac36ea7abb5af4(undefined, character_array, shot_array2);
  level.player hideviewmodel();
  animnode function_fa61598a89e9df5b(character_array, shot_array2, var_5f34b51f7cb0df88);
  wait 0.1;
  reachvip_dungeondoor = getEnt("vip_reachvip_dungeondoor", "targetname");
  reachvip_dungeondoor hide();
  thread function_6502e648d37cf222();
  animnode waittill("scene_complete");
  level.makarov setModel("body_c_jup_sp_villain_makarov_vip");
  level.makarov detach(level.makarov.headmodel);
  level.makarov.headmodel = "c_jup_head_hero_makarov";
  level.makarov attach(level.makarov.headmodel);
  animnode thread function_57ac36ea7abb5af4(undefined, character_array, var_5f34b51f7cb0df88);
  level.ally1 visiblenotsolid();
  level.ally2 visiblenotsolid();
  level.makarov visiblenotsolid();
  animnode function_fa61598a89e9df5b(character_array, var_5f34b51f7cb0df88, var_5f34bc1f7cb0eeed);
  animnode waittill("scene_complete");
  level.var_84e2c18fc540208 = make_weapon("jup_cp24_pi_glima21_sp");
  level.makarov scripts\anim\shared::forceuseweapon(level.var_84e2c18fc540208, "primary");
  animnode thread function_57ac36ea7abb5af4(undefined, character_array, var_5f34bc1f7cb0eeed);
  animnode function_fa61598a89e9df5b(character_array, var_5f34bc1f7cb0eeed, var_5f34bb1f7cb0ecba);
  animnode waittill("scene_complete");
  var_ba48df5d0f8881cb = animnode scene::get_entity("plr_3P");
  var_ba48df5d0f8881cb setModel("body_c_jup_sp_villain_nolan_urban");
  var_ba48df5d0f8881cb detach(var_ba48df5d0f8881cb.headmodel);
  var_ba48df5d0f8881cb.headmodel = "c_jup_head_hero_nolan_urban_unmasked";
  var_ba48df5d0f8881cb attach(var_ba48df5d0f8881cb.headmodel);
  var_ba48df5d0f8881cb.name = "";
  animnode thread function_57ac36ea7abb5af4(undefined, character_array, var_5f34bb1f7cb0ecba);
  animnode function_fa61598a89e9df5b(character_array, var_5f34bb1f7cb0ecba, var_5f34ba1f7cb0ea87);
  wait 7;
  level.ally1 detach(level.ally1.headmodel);
  level.ally1.headmodel = "c_jup_head_hero_ivan_urban_unmasked";
  level.ally1 attach(level.ally1.headmodel);
  wait 4.5;
  level.makarov detach(level.makarov.headmodel);
  level.makarov.headmodel = "c_jup_head_hero_makarov_comm";
  level.makarov attach(level.makarov.headmodel);
  animnode waittill("scene_complete");
  animnode thread function_57ac36ea7abb5af4(undefined, character_array, var_5f34ba1f7cb0ea87);
  waitframe();
  flag_wait("makarov_reveal_final_shot_start");
  level.player.var_336db6c8b15ad3df = 1;
  function_d37eb02511329ad6(level.player);
  level.player val::set("vip_makarov_reveal", "crouch", 0);
  level.player val::set("vip_makarov_reveal", "prone", 0);
  level.player function_5ee68a5b461ab5b8(0);

  if(isplatformps4() || isplatformxb3()) {
    foreach(weapon in level.player.primaryweapons) {
      iscurrentprimary = level.player.currentprimaryweapon == weapon;
      newweapon = undefined;

      if(weapon.basename == "jup_jp02_sm_scharlie3_vip") {
        newweapon = make_weapon("jup_jp02_sm_scharlie3_vip_nolaser");
      } else if(weapon.basename == "jup_jp02_ar_bromeo805_vip") {
        newweapon = make_weapon("jup_jp02_ar_bromeo805_vip_nolaser");
      }

      if(isDefined(newweapon)) {
        level.player takeweapon(weapon);
        level.player giveweapon(newweapon, 0, 0, -1, 1, 0);

        if(iscurrentprimary) {
          level.player switchtoweaponimmediate(newweapon);
        }
      }
    }
  } else {
    level.player takeweapon(var_b3116874a755bacb.weapon);
    level.player giveweapon(var_b3116874a755bacb.weapon, 0, 0, -1, 0);
    level.player setweaponammostock(var_b3116874a755bacb.weapon, var_b3116874a755bacb.stock);
    level.player setweaponammoclip(var_b3116874a755bacb.weapon, var_b3116874a755bacb.clip);
  }

  animnode waittill("scene_complete");
  level.player unlink();
  animnode scene::pre_stream(character_array, var_5f34ba1f7cb0ea87, 0);
  wait 0.2;
  var_ba48df5d0f8881cb delete();
  setsaveddvar(@ "hash_bc13d3a46e2c2877", 0.005);
  setsaveddvar(@ "hash_7844b5d74dd8b9fc", 0.05);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
  flag_set("flag_makarov_pcap_complete");
  level.player val::set("vip_makarov_reveal", "crouch", 1);
  level.player val::set("vip_makarov_reveal", "prone", 1);
  level.ally1 visiblesolid();
  level.ally2 visiblesolid();
  level.makarov visiblesolid();
  battlechatter_on("axis");
  thread autosave_by_name("makarov_reveal_complete");
  thread namespace_165c742e346e899e::function_638ed32cb658b936();
  level.player player::focusenable();
  function_1ae8f046dee579e0(0);
}

function function_be45f89d20273e29() {
  level.player endon("death");
  wait 3;
  level.player.var_336db6c8b15ad3df = 0;
}

function function_fa61598a89e9df5b(entities, var_d725f45863f9633d, var_e333b450f0f54dbd) {
  level.var_6422c1faf363b6fb = var_e333b450f0f54dbd;
  level.var_b753b3179330db76 = self;
  level.var_a38ce3f5c69d504 = entities;
  level.var_98e63cfbc550c981 = var_d725f45863f9633d[var_d725f45863f9633d.size - 1];

  if(var_d725f45863f9633d.size > 1) {
    scene::add_scene_func(self, &function_11e839112e852c15, level.var_98e63cfbc550c981);
    return;
  }

  thread function_11e839112e852c15();
}

function function_11e839112e852c15() {
  animnode = level.var_b753b3179330db76;
  shotduration = animnode scene::function_d9be975d8d1c9db3(level.var_98e63cfbc550c981, 1);
  waittime = max(0, shotduration - 2);
  wait waittime;
  level.var_b753b3179330db76 scene::pre_stream(level.var_a38ce3f5c69d504, level.var_6422c1faf363b6fb, 2.1);
}

function function_323a235a52df766f() {
  flag_wait("flag_obj_reach_makarov_complete");
  level.player say("dx_sp_jvip_mkrv_noln_breacherup", 0, 0, 0, 3.5);
}

function function_d231f69b5b4e7df3() {
  wait 1.5;
  stopmusicstate("mx_vip_reach_vip");
}

function function_40bee596e36ccfaa() {
  wait 0.2;
  setmusicstate("mx_vip_riot");
}

function function_fd527fd6fc6a6bcf() {
  flag_set("flag_makarov_pcap_complete");
  flag_set("flag_makarov_pcap_start");
  clearmusicstate();
  setmusicstate("mx_vip_reach_makarov");

  if(isDefined(level.ally1)) {
    level.ally1 detach(level.ally1.headmodel);
    level.ally1.headmodel = "c_jup_head_hero_ivan_urban_unmasked";
    level.ally1 attach(level.ally1.headmodel);
  }
}

function function_9aff01568e45d70c() {}

function riot_start() {
  level.player modifybasefov(65, 1, 0.1, 0.1);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_ea6731f91b1378e6();
  thread function_e39d8a96b86719ce(0);
  spawn_allies();
  level thread function_c6aecb595687f644();
  set_start_location("riot", [level.player, level.ally1, level.ally2]);
  function_dc2aa213aa5830aa(getStruct("makarov_start_cell", "targetname"));
  level.var_84e2c18fc540208 = make_weapon("jup_cp24_pi_glima21_sp");
  level.makarov scripts\anim\shared::forceuseweapon(level.var_84e2c18fc540208, "primary");
  level.makarov.sidearm = nullweapon();
  activate_trigger_with_targetname("post_makarov_reveal_pos");
  trigger_wait_targetname("post_makarov_reveal_pos");
}

function riot_main() {
  flag_wait("flag_makarov_pcap_complete");
  flag_set("flag_makarov_released");
  level.makarov.name = "Makarov";
  level.makarov.callsign = "Czar-9-0";
  level.makarov function_4ca9518dc8bef142("all", 0);
  level.ally2 function_4ca9518dc8bef142("all", 0);
  thread function_c7d685dd30c237ad();
  level thread function_4e0c80e0d902ccb9();
  level thread function_831bea399085ab38();
  thread function_29889d6983bdb310();
  level.player scripts\sp\player::player_movement_state("cqb");
  riot_allies = [level.ally1, level.ally2, level.makarov];
  waitframe();

  foreach(ally in riot_allies) {
    ally thread function_a04a08fd74082cd0();
  }

  thread riot_execute_prisoners();
  flag_wait("flag_riot_start_takedown_anim");
  level.player.var_336db6c8b15ad3df = 0;
  thread function_98e61d50b3de5278();
  flag_wait("flag_riot_armory_approach");
  var_b7269dba0601e59 = getnode("makarov_no_peek_cover", "targetname");
  var_b7269dba0601e59 function_e7ec030a6ad3e5f8(0);
  flag_wait("flag_riot_armory_enter");
  level.var_68f797e5ce857dd6 = array_spawn_targetname("riot_locker_guy", 1);

  foreach(guy in level.var_68f797e5ce857dd6) {
    guy thread function_9a73c7ddda51a558();
  }

  thread function_80a6bcf2ef2c7f9b();
  setsaveddvar(@ "hash_c02d8d95ebc4e0f2", 1);
  trigger_wait_targetname("riot_locker_exit");
  level.makarov function_4ca9518dc8bef142("all", 1);
  level.ally2 function_4ca9518dc8bef142("all", 1);
  flag_set("flag_locker_exit");
}

function function_da753a8b4cc3cdb6() {
  flag_set("flag_cellriot_halldoor_01");
  flag_set("vip_stop_alarms");
  flag_set("flag_cellriot_door07_open");
  level.var_32ca3ecb27ab3277 = make_weapon("iw9_ar_akilo74_sp");
  level.makarov scripts\anim\shared::forceuseweapon(level.var_32ca3ecb27ab3277, "primary");
  level.makarov.sidearm = nullweapon();
  clearmusicstate();
  setmusicstate("mx_vip_reach_makarov");
}

function function_29889d6983bdb310() {
  flag_wait_all("flag_pre_takedown_save", "flag_riot_execute_prisoners");
  thread autosave_by_name("makarov_execution_start");
  flag_wait("flag_riot_armory_enter");
  thread autosave_by_name("armory_room_ready");
  flag_wait("flag_player_within_elevator");
  thread autosave_by_name("elevator_dialogue_tree");
}

function function_80a6bcf2ef2c7f9b() {
  flag_wait_all("flag_rusher_guard_dead", "flag_riot_armory_advance");

  if(!flag("flag_riot_guard_crossed_corridor")) {
    var_1f3bfb6a9b1f1e0c = spawn_targetname("riot_corridor_extra_rusher_guard", 1);
    var_1f3bfb6a9b1f1e0c thread function_ec09164d24771c5b();
    flag_set("flag_riot_extra_rusher_guard_spawned");
  }
}

function function_ec09164d24771c5b() {
  self endon("death");
  demeanor_override("cqb");
  set_movement_speed(115);
  set_grenadeammo(0);
  self.var_c833409fb72d15fb = 1;
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  set_attackeraccuracy(0.4);
  set_ignoreme(1);
  thread function_27c07c6c396e05f0();
}

function riot_execute_prisoners() {
  flag_wait("flag_riot_execute_prisoners");
  thread namespace_165c742e346e899e::function_b6b7b6bbc985eb26();
  array_spawn_function_targetname("riot_makarov_execution_guard", &function_e381d3c4e2133514);
  level.guards = array_spawn_targetname("riot_makarov_execution_guard", 1);
  wait 0.5;
  thread namespace_165c742e346e899e::function_4441d36febd657ca();
  level.guards[0] say("dx_sp_jvip_corr_vipg_intrudershalt");
  prisoners = array_spawn_targetname("riot_elevator_prisoners", 1);

  foreach(prisoner in prisoners) {
    prisoner kill();
  }
}

function function_9a73c7ddda51a558() {
  self endon("death");
  demeanor_override("cqb");
  set_grenadeammo(0);
  set_fixednode_true();
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  set_attackeraccuracy(0.4);
  self.dontsyncmelee = 1;
  flag_wait("flag_riot_armory_advance");
  time = randomfloatrange(3, 6);
  wait time;
  set_fixednode_false();
  volname = "vol_" + self.script_noteworthy;
  vol = getEnt(volname, "targetname");
  self setgoalvolumeauto(vol);
  set_goalRadius(32);
  flag_wait("flag_locker_ai_move_to_open_area");
  self cleargoalvolume();

  if(self.script_noteworthy == "right_corridor_area" && flag("flag_makarov_takedown_right")) {
    thread player_seek_enable();
    return;
  }

  vol = getEnt("vol_open_locker_area", "targetname");
  self setgoalvolumeauto(vol);
  flag_wait("flag_locker_ai_cleanup");
  self cleargoalvolume();
  thread player_seek_enable();
}

function function_c7d685dd30c237ad() {
  if(flag("flag_reach_vip_door_3_open")) {
    reachvip_dungeondoor_left = getEnt("reachvip_dungeondoor_left", "targetname");
    reachvip_dungeondoor_left rotateby((0, -90, 0), 1, 0.05, 0.05);
    reachvip_dungeondoor_right = getEnt("reachvip_dungeondoor_right", "targetname");
    reachvip_dungeondoor_right rotateby((0, 90, 0), 1, 0.05, 0.05);
    var_3b7724235cb062fb = getEnt("panopticon_doors_clip", "targetname");
    var_3b7724235cb062fb solid();
    var_3b7724235cb062fb disconnectPaths();
  }

  var_10b1628188a6260 = getEnt("pcap_makarov_reveal_black_lighting_wall", "targetname");
  var_10b1628188a6260 notsolid();
  var_10b1628188a6260 connectpaths();
  var_10b1628188a6260 hide();
  var_5977cd2102a967c2 = getEnt("pcap_makarov_reveal_shadow_box", "targetname");
  var_5977cd2102a967c2 notsolid();
  var_5977cd2102a967c2 connectpaths();
}

function function_98e61d50b3de5278() {
  var_c45d4e2d487f492b = getStruct("vip_0900_hallway_takedown", "targetname");
  var_feb7c772cad2a42e = getStruct("vip_0900_hallway_takedown", "targetname");
  level.makarov thread function_1ac1250dcf5c6fbf();
  level.ally2 thread function_1ac1250dcf5c6fbf();
  var_c45d4e2d487f492b thread function_1a393877e189e360();
  var_feb7c772cad2a42e thread function_14812e18f4928c43();
  var_cc879b6a81998a34 = ["flag_riot_breach_allies_in_pos_1", "flag_riot_breach_allies_in_pos_2"];
  utility::function_7a252abaaa15fcd7(var_cc879b6a81998a34);
  var_c45d4e2d487f492b scene::stop();
  var_feb7c772cad2a42e scene::stop();
  activate_trigger_with_targetname("riot_ivan_catchup");
  animnode = getStruct("vip_0900_hallway_takedown", "targetname");
  animnode thread scene::play(level.ally2, "shot_020");
  actors = [level.makarov, level.guards[0], level.guards[1], level.guards[2]];
  animnode scene::play(actors, "shot_010");
  reachvip_fake_hallway_door = getStruct("reachvip_fake_hallway_door", "script_noteworthy");
  reachvip_fake_hallway_door function_ec55b3dd58f10e7b();
  wait 1.5;
  function_6c2ff9270216c32a();
  wait 5;

  foreach(guard in level.guards) {
    if(isalive(guard)) {
      guard gun_remove();
    }
  }

  animnode thread scene::play([level.guards[0], level.guards[1], level.guards[2]], "guard_death");
  level.var_32ca3ecb27ab3277 = make_weapon("iw9_ar_akilo74_sp");
  level.makarov scripts\anim\shared::forceuseweapon(level.var_32ca3ecb27ab3277, "primary");
  flag_set("follow_makarov_objective_complete");
  level.makarov set_force_color("r");
  level.ally2 set_force_color("y");
  activate_trigger_with_targetname("riot_ally_colors_post_makarov_execution");
  level.makarov.gunposeoverride = "gun_down";
  flag_wait_or_timeout("flag_riot_armory_approach", 2);
  thread namespace_165c742e346e899e::function_5761cd4381c219c1();
  thread function_f857980f0d4aaa8();
}

function function_1ac1250dcf5c6fbf() {
  self waittill("riot_breach_allies_in_pos");
  waitframe();

  if(self == level.makarov) {
    flag_name = "flag_riot_breach_allies_in_pos_1";
    utility::flag_set(flag_name);
    return;
  }

  if(self == level.ally2) {
    flag_name = "flag_riot_breach_allies_in_pos_2";
    utility::flag_set(flag_name);
  }
}

function function_1a393877e189e360() {
  flag_wait("flag_makarov_at_door_node");
  thread scene::play(level.makarov, ["makarov_enter", "makarov_idle"]);
}

function function_14812e18f4928c43() {
  flag_wait("flag_ally2_at_door_node");
  thread namespace_165c742e346e899e::function_478c8399563b08ec();
  thread scene::play(level.ally2, ["ally_enter", "ally_idle"]);
}

function function_f857980f0d4aaa8() {
  var_c6826b6f0d145a33 = getEnt("riot_elevator_door", "targetname");
  var_6eadeb5c143a9895 = var_c6826b6f0d145a33.origin;
  var_c6826b6f0d145a33 moveTo(var_c6826b6f0d145a33.origin + (0, 0, 76), 2);
  var_c75a41cde8ee39f2 = getStruct("smoke_grenade_pos", "targetname");
  magicgrenade("smoke_sp_vip_armory", var_c75a41cde8ee39f2.origin, var_c75a41cde8ee39f2.origin + (-250, 0, 20), 0.1, 0);
  wait 1;
  var_1f2ffb92adf905f3 = array_spawn_targetname("riot_corridor_rusher_guard", 1);
  thread namespace_165c742e346e899e::function_18c3a854972ebfc1(var_1f2ffb92adf905f3);

  foreach(var_d423b307fd94ad32 in var_1f2ffb92adf905f3) {
    var_d423b307fd94ad32 thread function_afa83aef669dbd74();
  }

  flag_set("flag_riot_guards_arrive");
  wait 2;
  thread namespace_165c742e346e899e::function_9531e438a3fc1f06();
  var_c6826b6f0d145a33 moveTo(var_6eadeb5c143a9895, 2);
}

function function_e381d3c4e2133514() {
  self endon("death");
  guard_weapon = make_weapon("iw9_ar_akilo74_sp");
  scripts\anim\shared::forceuseweapon(guard_weapon, "primary");
  demeanor_override("cqb");
  set_ignoreall(1);
  set_ignoreme(1);
  self setgoalpos(self.origin, 16);
  magic_bullet_shield(1);
  self actoraimassistoff();
  self visiblenotsolid();
  context_melee_allow(0);
  set_battlechatter(0);
}

function function_afa83aef669dbd74() {
  self endon("death");
  demeanor_override("cqb");
  set_movement_speed(115);
  set_grenadeammo(0);
  self.var_c833409fb72d15fb = 1;
  set_fixednode_true();
  set_attackeraccuracy(0.25);
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.dontsyncmelee = 1;
  thread function_f4790e017f5690b1();
  wait 4;
  set_fixednode_false();
  vol = getEnt("vol_riot_corridor", "targetname");
  self setgoalvolumeauto(vol);
  flag_wait_any("flag_makarov_takedown_left", "flag_makarov_takedown_right");

  if(!isDefined(level.var_dc6c173f183e394)) {
    level.var_dc6c173f183e394 = 1;
    set_attackeraccuracy(0.4);
    self cleargoalvolume();
    thread function_27c07c6c396e05f0();
    return;
  }

  time = randomfloatrange(2, 4);
  wait time;
  set_attackeraccuracy(0.4);
  self cleargoalvolume();
  thread player_seek_enable();
}

function function_27c07c6c396e05f0() {
  self endon("death");
  flag_set("flag_riot_guard_crossed_corridor");
  var_bcb9bf6f7a7c4de9 = getStruct("stay_back_start", "targetname");
  set_goalRadius(32);
  self setgoalpos(var_bcb9bf6f7a7c4de9.origin);
  var_f94ab649a7ca9358 = getStruct("corridor_look_at_guard_crossing", "targetname");

  while(true) {
    if(function_e7c30095a6cdc3ef(var_f94ab649a7ca9358.origin, getdvarint(@ "cg_fov"), 1)) {
      break;
    }

    waitframe();
  }

  self.accuracy = 0.2;
  set_attackeraccuracy(1);
  var_39def9eaf7d80b8 = getnode("stay_back_pos", "targetname");
  set_goalRadius(32);
  self setgoalnode(var_39def9eaf7d80b8);
  wait 2;
  set_ignoreme(0);
}

function function_f4790e017f5690b1() {
  self endon("death");

  while(!flag("flag_riot_armory_advance")) {
    self getenemyinfo(level.player);
    self getenemyinfo(level.ally1);
    wait 1;
  }
}

function function_4e0c80e0d902ccb9() {
  level endon("flag_player_within_elevator");
  level.ally1 set_force_color("c");
  level.ally2 set_force_color("y");
  level.makarov set_force_color("r");
  trigger_wait_targetname("riot_ally_colors_post_makarov_execution");
  level.ally1 setavoidanceradius(8);
  level.ally2 setavoidanceradius(8);
  level.makarov setavoidanceradius(8);
  flag_wait("flag_riot_armory_approach");
  activate_trigger_with_targetname("riot_ivan_corridor_advance");
  thread function_4b8ba0b798d0612b();
  flag_wait("flag_riot_armory_advance");
  var_aa73b99a4cf6161c = getEnt("locker_room_door_clip", "targetname");
  var_aa73b99a4cf6161c notsolid();
  var_aa73b99a4cf6161c connectpaths();
  var_da7e70e22c9f55d = get_living_ai_array("riot_locker_guy", "targetname");

  if(var_da7e70e22c9f55d.size < 3) {
    var_1e2b1a76a23cd141 = array_spawn_targetname("riot_extra_locker_guy", 1);
    var_da7e70e22c9f55d = array_combine(var_da7e70e22c9f55d, var_1e2b1a76a23cd141);

    foreach(guy in var_1e2b1a76a23cd141) {
      guy thread function_9a73c7ddda51a558();
    }
  }

  thread function_984968bbcd1020f7();
  flag_wait_either("flag_makarov_takedown_left", "flag_makarov_takedown_right");
  activate_trigger_with_targetname("riot_ivan_armory_advance");
  function_4d3ad1d021710127(var_da7e70e22c9f55d, 3);
  flag_set("flag_locker_ai_move_to_open_area");
  function_4d3ad1d021710127(var_da7e70e22c9f55d, 1);
  flag_set("flag_locker_ai_cleanup");

  if(!flag("flag_locker_exit")) {
    activate_trigger_with_targetname("trigger_allies_to_locker");
  }

  flag_wait("flag_guards_dead");
  var_1e2b1a76a23cd141 = get_living_ai_array("riot_extra_locker_guy", "targetname");

  if(var_1e2b1a76a23cd141.size > 0) {
    flag_wait("flag_extra_guards_dead");
  }

  var_e95d7f8405f0456b = get_living_ai_array("riot_locker_makarov_fodder_left", "targetname");
  var_e06cccb8a3410634 = get_living_ai_array("riot_locker_makarov_fodder_right", "targetname");

  if(var_e95d7f8405f0456b.size > 0) {
    flag_wait("flag_makarov_fodder_left_guy_dead");
  } else if(var_e06cccb8a3410634.size > 0) {
    flag_wait("flag_makarov_fodder_right_guy_dead");
  }

  var_1f3bfb6a9b1f1e0c = get_living_ai_array("riot_corridor_extra_rusher_guard", "targetname");

  if(var_1f3bfb6a9b1f1e0c.size > 0) {
    flag_wait_or_timeout("flag_extra_rusher_guard_dead", 10);
  } else {
    flag_wait_or_timeout("flag_rusher_guard_dead", 10);
  }

  flag_set("flag_riot_all_guards_dead");
  activate_trigger_with_targetname("trigger_allies_outside_of_showers_pos");
  var_93e1906139337c3d = getEnt("riot_locker_exit", "targetname");

  if(isDefined(var_93e1906139337c3d)) {
    trigger_wait_targetname("riot_locker_exit");
  }

  level.makarov set_goalRadius(32);
  wait 2;
  level.makarov waittill("goal");
  level.makarov set_goalRadius(2048);
  wait 1;

  if(!flag("flag_player_within_elevator")) {
    animnode = spawn("script_origin", level.makarov.origin);
    idlenode = getnode("makarov_idle_node", "targetname");
    animnode.angles = idlenode.angles;
    animnode animation::anim_single_solo(level.makarov, "exposed_enter");

    for(i = 1; !flag("flag_player_within_elevator"); i = 1) {
      animnode notify("stop_loop");
      level.makarov stopanimScripted();
      animnode animation::anim_single_solo(level.makarov, "exposed_idle" + i);
      animnode thread animation::anim_loop_solo(level.makarov, "exposed_idle");
      wait randomfloatrange(1, 1.5);
      i++;

      if(i == 11) {}
    }
  }
}

function function_4b8ba0b798d0612b() {
  flag_wait("flag_rusher_guard_dead");

  if(!flag("flag_riot_armory_advance")) {
    triggervolume = getEnt("trigger_ally2_to_armory", "targetname");

    if(isDefined(triggervolume)) {
      activate_trigger_with_targetname("trigger_ally2_to_armory");
    }
  }
}

function function_984968bbcd1020f7() {
  flag_wait_either("flag_makarov_takedown_left", "flag_makarov_takedown_right");

  if(flag("flag_makarov_takedown_left")) {
    var_d62b3abee229e585 = spawn_targetname("riot_locker_makarov_fodder_left", 1);
    var_d62b3abee229e585 thread function_9a73c7ddda51a558();
    trigger_volume = "trigger_makarov_to_locker_left";
    activate_trigger_with_targetname("trigger_ally2_to_armory_left");
  } else if(flag("flag_makarov_takedown_right")) {
    var_d62b3abee229e585 = spawn_targetname("riot_locker_makarov_fodder_right", 1);
    var_d62b3abee229e585 thread function_9a73c7ddda51a558();
    teleportlocation = getnode("teleport_makarov_right", "targetname");
    trigger_volume = "trigger_makarov_to_locker_right";
    activate_trigger_with_targetname("trigger_ally2_to_armory_right");
    level.makarov teleport_ai(teleportlocation);
  }

  activate_trigger_with_targetname(trigger_volume);
}

function function_831bea399085ab38() {
  level endon("flag_player_within_elevator");
  flag_wait("flag_makarov_released");
  wait 1;
  level.makarov say("dx_sp_jvip_corr_maka_ivanitrusttheexfilpl");
  level.ally1 say("dx_sp_jvip_corr_ivan_yescommanderweheadup");
  flag_set("flag_pre_takedown_save");
  level.makarov say("dx_sp_jvip_corr_maka_goodsimpleisbestunti");
  flag_wait("flag_riot_guards_arrive");
  wait 1;
  level.ally1 say("dx_sp_jvip_corr_ivan_contactletsgo");
  thread function_94e34ab813cc4731();
  flag_wait("flag_riot_armory_enter");
  wait 2;
  thread function_2ee3c2af5db11305();
  thread function_3100ceaf1c231fb7();
  flag_wait("flag_riot_armory_advance");
  thread function_aff9d51a3649add();
  flag_wait_all("flag_riot_all_guards_dead", "flag_rusher_guard_dead");

  if(flag("flag_riot_extra_rusher_guard_spawned")) {
    flag_wait("flag_extra_rusher_guard_dead");
  }

  wait 1.5;
  level.ally1 say("dx_sp_jvip_reac_koa1_clear");
  wait 0.5;
  level.player.vo_handler say("dx_sp_jvip_coex_noln_alpha21tocharlieactu");
  level.player.vo_handler say("dx_sp_jvip_coex_chr2_rogerstandingby");
  var_93e1906139337c3d = getEnt("riot_locker_exit", "targetname");

  if(isDefined(var_93e1906139337c3d)) {
    trigger_wait_targetname("riot_locker_exit");
  }

  wait 10;
  level.ally1 say("dx_sp_jvip_elev_ivan_getonthisdoor21");
  wait 8;
  var_2b24f197194cc728 = ["dx_sp_jvip_elev_ivan_quickly", "dx_sp_jvip_elev_ivan_guardsareontheirwayl", "dx_sp_jvip_elev_ivan_moveitdrei"];

  for(i = 2; !flag("flag_player_within_elevator"); i = 2) {
    level.ally1 say(var_2b24f197194cc728[i - 2]);
    time = randomfloatrange(8, 10);
    wait time;
    i++;

    if(i == 5) {}
  }
}

function function_3100ceaf1c231fb7() {
  level endon("flag_riot_armory_advance");
  wait 7;

  while(!flag("flag_riot_armory_advance")) {
    guards = array_removedead_or_dying(level.var_68f797e5ce857dd6);

    if(isarray(guards) && guards.size > 0) {
      guards[0] say("dx_sp_jvip_coga_vipg_intrudersinthearmory");
    }

    time = randomfloatrange(7, 9);
    wait time;
  }
}

function function_aff9d51a3649add() {
  level endon("flag_locker_exit");
  wait 2;

  while(!flag("flag_locker_exit")) {
    guards = array_removedead_or_dying(level.var_68f797e5ce857dd6);

    if(isarray(guards) && guards.size > 0) {
      guards[0] say("dx_sp_jvip_cogl_vipg_intrudersinthelocker");
    }

    time = randomfloatrange(4, 6);
    wait time;
  }
}

function function_94e34ab813cc4731() {
  level endon("flag_riot_armory_enter");
  wait 13;
  i = 1;

  while(!flag("flag_riot_armory_advance")) {
    if(i == 1) {
      level.ally1 say("dx_sp_jvip_corr_ivan_nolanweneedtogettoth");
    } else {
      level.makarov say("dx_sp_jvip_corr_maka_gettotheelevator");
    }

    time = randomfloatrange(8, 10);
    wait time;
    i *= -1;
  }
}

function function_2ee3c2af5db11305() {
  level endon("flag_riot_armory_advance");
  var_2b24f197194cc728 = ["dx_sp_jvip_corr_maka_andreigearupandletsm", "dx_sp_jvip_corr_maka_grabwhatyouneedquick", "dx_sp_jvip_corr_maka_takewhatyouwantthegu"];

  for(i = 0; !flag("flag_riot_armory_advance"); i = 0) {
    level.makarov say(var_2b24f197194cc728[i]);
    time = randomfloatrange(8, 10);
    wait time;
    i++;

    if(i == 3) {}
  }
}

function function_a04a08fd74082cd0() {
  demeanor_override("cqb");
  set_grenadeammo(0);
  set_battlechatter(0);
  self.accuracy = 0.2;
  self.ignoreall = 0;
  self.disablegrenaderesponse = 1;
  self.pushable = 1;
  set_movement_speed(90);
  set_dontmelee(1);
  trigger_wait_targetname("riot_upstairs_approach");
  set_movement_speed(115);
  trigger_wait_targetname("riot_ally_colors_post_makarov_execution");
  self enableavoidance(1, 1);
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  flag_wait("flag_locker_exit");
  set_dontmelee(0);
}

function function_6c2ff9270216c32a() {
  var_381ffc1fa65566bf = getEnt("elevator_hallway_door_clip_closed", "targetname");
  var_381ffc1fa65566bf notsolid();
  var_381ffc1fa65566bf connectpaths();
  door = getEnt("elevator_hallway_door", "targetname");
  door delete();
}

function elevator_start() {
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_e8bf4798eff66542();
  thread function_e39d8a96b86719ce(0);
  thread namespace_165c742e346e899e::function_6e6ec37968927aa8();
  spawn_allies();
  level thread function_c6aecb595687f644();
  set_start_location("elevator", [level.player, level.ally1, level.ally2]);
  function_dc2aa213aa5830aa(getStruct("makarov_elevator_start", "targetname"));
}

function elevator_main() {
  level.makarov.gunposeoverride = undefined;
  level.ally1.pushable = 1;
  level.ally2.pushable = 1;
  level.makarov.pushable = 1;
  level thread elevator_interact();
  setsaveddvar(@ "hash_c02d8d95ebc4e0f2", 0.55);
  flag_wait("cine_elevator_actual_teleport");
}

function function_ba71f4c16efdae8e() {
  clearmusicstate();
}

function elevator_interact() {
  level.player setclientomnvar("ui_show_objectives", 1);
  button_org = utility::getStruct("riot_elevator_interact", "targetname");
  button_org cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_VIP/INTERACT_ENTER_ELEVATOR");
  button_org waittill("trigger");
  level.player val::set("elevator_cine", "allow_movement", 0);
  level.player function_5ee68a5b461ab5b8(1);
  namespace_9c3faffc064160e8::function_7b2743af8410b08e();
  thread function_7cdb1c36640834bf();
  thread namespace_165c742e346e899e::function_61a814032658221b();
  level.player setclientomnvar("ui_show_objectives", 0);
  thread elevator_pcap();
  var_9325985c850ce307 = get_living_ai_array("riot_corridor_rusher_guard", "targetname");
  var_da7e70e22c9f55d = get_living_ai_array("riot_locker_guy", "targetname");
  var_d9306d15766b500 = array_combine(var_9325985c850ce307, var_da7e70e22c9f55d);
  array_kill(var_d9306d15766b500);
  flag_set("flag_player_within_elevator");
  flag_set("flag_obj_escape_cells_complete");
  flag_wait("cine_elevator_end");
  thread player_speed_default(0.5);
  level.player val::set("elevator_cine", "allow_movement", 1);
  level.player function_5ee68a5b461ab5b8(0);
}

function function_7cdb1c36640834bf() {
  stopmusicstate("mx_vip_riot");
}

function function_29650ae8f8e7e71e(animnode) {
  animnode scene::function_8207074e79f22926(animnode, "elevator_up_1", "Player");
  animnode scene::function_8207074e79f22926(animnode, "elevator_stop", "Player");
  animnode scene::function_8207074e79f22926(animnode, "elevator_up_2", "Player");
  animnode scene::function_8207074e79f22926(animnode, "elevator_default", "Makarov");
  animnode waittill("elevator_up_1");
  var_f7b7c2569fb8c5ab = animnode scene::get_entity("elevator_geo");
  var_f7b7c2569fb8c5ab setscriptablepartstate("elevator_buttons", "button_up");
  animnode waittill("elevator_stop");
  var_f7b7c2569fb8c5ab setscriptablepartstate("elevator_buttons", "button_stop");
  animnode waittill("elevator_up_2");
  var_f7b7c2569fb8c5ab setscriptablepartstate("elevator_buttons", "button_up");
  animnode waittill("elevator_default");
  var_f7b7c2569fb8c5ab setscriptablepartstate("elevator_buttons", "button_on");
}

function elevator_pcap() {
  animnode = getStruct("scene_vip_elevator_pcap", "targetname");
  actors = [level.makarov, level.ally1, level.ally2, level.player];
  utility::flag_set("cine_elevator_start");
  level.player player::focusdisable();
  utility::function_1ae8f046dee579e0(1);
  thread scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting::function_b43da6f1b78f953b();
  utility::flag_wait("flag_player_within_elevator");
  utility::flag_set("cine_elevator_start");
  var_c6826b6f0d145a33 = getEnt("riot_elevator_door", "targetname");
  var_c6826b6f0d145a33 hide();
  elevator = getEnt("pcap_elevator", "targetname");
  elevator hide();
  thread function_29650ae8f8e7e71e(animnode);
  level.makarov clearimpactmarks();
  level.ally1 clearimpactmarks();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  battlechatter_off("axis");
  animnode scene::play(actors, "pcap_intro");
  thread transient_load_array(["sp_jup_vip_rooftop_tr", "sp_jup_vip_infil_vista_tr", "sp_jup_vip_maintenance_tr", "sp_jup_vip_tower_tr"]);
  animnode thread scene::play(actors, "pcap_idle");
  var_1b8b2ec73f492162 = [ &"sp_jup_vip/dialog_elevator_option1", &"sp_jup_vip/dialog_elevator_option2", &"sp_jup_vip/dialog_elevator_option3"];
  var_5c76167572fce9c1 = ["The guards.", "The prisoners.", "Neither."];

  switch (function_945718bb107da39e(var_5c76167572fce9c1, var_1b8b2ec73f492162, 9, 0)) {
    case 1:
      flag_set("flag_aud_makarov_answered");
      animnode scene::play(actors, "pcap_answer1");
      break;
    case 2:
      flag_set("flag_aud_makarov_answered");
      animnode scene::play(actors, "pcap_answer2");
      break;
    case 3:
      flag_set("flag_aud_makarov_answered");
      animnode scene::play(actors, "pcap_answer3");
      break;
    default:
      flag_set("flag_aud_makarov_answered");
      animnode scene::play(actors, "pcap_answer3");
      break;
  }

  flag_set("flag_aud_elevator_fake_battle_amb_pt2");
  animnode scene::play(actors, "pcap_response");
  battlechatter_on("axis");
  animnode scene::play(actors, "pcap_exit");
  flag_wait("cine_elevator_end");
  level.player player::focusenable();
  utility::function_1ae8f046dee579e0(0);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
}

function function_945718bb107da39e(var_5c76167572fce9c1, var_71522087bc2056d3, timeout, var_120e91c43eab8002) {
  if(!isDefined(var_120e91c43eab8002)) {
    var_120e91c43eab8002 = 1;
  }

  if(!isDefined(timeout)) {
    timeout = 0;
  }

  var_8c791b0ce2679fba = scripts\sp\dialogue_wheel::function_d92b8b076e34f82b(var_71522087bc2056d3, int(timeout));

  if(!isDefined(var_5c76167572fce9c1)) {
    return var_8c791b0ce2679fba;
  }

  return var_8c791b0ce2679fba;
}