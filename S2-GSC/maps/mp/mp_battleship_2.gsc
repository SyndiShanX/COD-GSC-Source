/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_battleship_2.gsc
*********************************************/

func_00F9() {
  lib_049C::func_F9();
  lib_0404::func_F9();
  lib_049B::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_battleship_2_lighting::func_F9();
  maps\mp\mp_battleship_2_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_battleship_2");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_battleship_2_killstreak";
  level.var_5A6B = "mp_battleship_2_killstreak";
  level.var_47CD = "mp_battleship_2_glide1";
  level.var_47CE = "mp_battleship_2_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  level.var_7C62 = 8000;
  thread func_89F9();
  thread func_6483();
  thread func_6477();
  thread func_648D();
  thread func_9201();
  thread func_71B0();
  thread func_0E99();
  setDvar("5260", 1);
  setDvar("5800", 3);
  setDvar("1512", "1");
  setDvar("3220", "20");
  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B82();
  }
}

func_6B82() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", var_00);
    if(isDefined(var_00)) {
      var_00 thread func_9B93();
    }
  }
}

func_9B93() {
  self endon("death");
  var_00 = getent("death_trigger", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  while(isDefined(self)) {
    if(self istouching(var_00)) {
      self delete();
    }

    wait 0.05;
  }
}

func_0E99() {
  var_00 = getent("scavanger_yacht", "targetname");
  var_01 = getent("scavanger_ketch", "targetname");
  var_02 = getent("sunken_front", "targetname");
  var_03 = getent("sunken_back", "targetname");
  var_00 thread func_AA88();
  var_01 thread func_AA88();
  var_02 thread func_AA88();
  var_03 thread func_AA88();
  thread func_29B8(var_02, var_03, var_00, var_01);
  var_00 method_8278("bsh_yacht_scavanger_anim");
  var_01 method_8278("bsh_ketch_scavanger_anim");
  var_02 method_8278("bsh_destroyer_front_sunken_anim");
  var_03 method_8278("bsh_destroyer_back_sunken_anim");
}

func_8B09(param_00) {
  param_00.var_1D = (-1, 0, -12);
  param_00 thread func_AA88();
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("damaged_ship_parent"), param_00, "TAG_ORIGIN");
}

func_084E(param_00) {
  var_01 = 360;
  var_02 = 30000;
  param_00 func_AA88();
  wait 0.05;
  while(isDefined(param_00)) {
    param_00.var_99D9 movex(var_02, var_01, 4, 4);
    wait(var_01);
    param_00.var_99D9 movex(var_02 * -1, var_01, 4, 4);
    wait(var_01);
  }
}

func_2B69(param_00) {
  var_01 = 360;
  var_02 = 30000;
  param_00 thread func_AA88();
  wait 0.05;
  while(isDefined(param_00)) {
    param_00.var_99D9 movex(var_02 * -1, var_01, 4, 4);
    wait(var_01);
    param_00.var_99D9 movex(var_02, var_01, 4, 4);
    wait(var_01);
  }
}

func_6DDC(param_00) {
  var_01 = 30;
  var_02 = 1000;
  param_00 thread func_AA88();
  wait(randomfloat(5));
  var_03 = randomint(2) * 2 - 1;
  while(isDefined(param_00)) {
    param_00.var_99D9 movex(var_02 * var_03, var_01, 3, 3);
    wait(var_01);
    param_00.var_99D9 movex(var_02 * var_03 * -1, var_01, 3, 3);
    wait(var_01);
  }
}

func_6477() {
  var_00 = getent("cliffs_01", "targetname");
  var_00 thread func_AA88();
  var_00 method_8278("bsh_vista_cliff_01_anim");
}

func_648D() {
  var_00 = getent("skydome", "targetname");
  var_00 func_AA88();
}

func_9201() {
  var_00 = 0.5;
  var_01 = 2;
  var_02 = getent("explosion_loc", "targetname");
  var_02 func_AA88();
  wait(3);
  var_03 = 0;
  for(;;) {
    var_04 = randomintrange(1, 4);
    for(var_05 = randomintrange(0, 24); var_05 == var_03; var_05 = randomintrange(0, 24)) {}

    var_03 = var_05;
    var_06 = "mp_bat_vista_moving_water_explosion_" + var_04;
    var_07 = "explosion_loc_" + var_05;
    playFXOnTag(common_scripts\utility::func_44F5(var_06), var_02, var_07);
    wait(randomfloatrange(var_00, var_01));
  }
}

func_71B0() {
  wait 0.05;
  var_00 = getent("explosion_loc", "targetname");
  playFXOnTag(common_scripts\utility::func_44F5("fx_sunflare_mp_battleship_01"), var_00, "sunflare_loc");
}

func_6483() {
  var_00 = getent("ocean", "targetname");
  var_00 thread func_AA88();
}

func_89F9() {
  level.var_A983 = 8;
  level.var_99D8 = 2.5;
  level.var_99D9 = common_scripts\utility::func_8FFC();
  level.var_99D9.var_1D = (0, 0, 0);
  level.var_99D9.var_116 = (0, 0, 2032);
  wait(0.2);
  level.var_99D9.var_1D = (0, 0, -0.5 * level.var_99D8);
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_vista_fog"), level.var_99D9, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_vista_lct_transport"), level.var_99D9, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_vista_arkansas"), level.var_99D9, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_vista_attack_transport"), level.var_99D9, "tag_origin");
  while(isDefined(self)) {
    var_00 = function_021F("bship_gravity_tilt_scrp", "targetname");
    level.var_99D9 rotateto((0, 0, level.var_99D8), level.var_A983, level.var_A983 / 2, level.var_A983 / 2);
    lib_0378::func_8D74("if_the_boat_is_a_rockin_dont_come_a_knockin", "interior");
    activateclientexploder(20);
    foreach(var_02 in var_00) {
      var_02 setscriptablepartstate("tiltstates", "tilt1");
    }

    wait(level.var_A983);
    level.var_99D9 rotateto((0, 0, -1 * level.var_99D8), level.var_A983, level.var_A983 / 2, level.var_A983 / 2);
    lib_0378::func_8D74("if_the_boat_is_a_rockin_dont_come_a_knockin", "interior");
    activateclientexploder(10);
    foreach(var_02 in var_00) {
      var_02 setscriptablepartstate("tiltstates", "tilt2");
    }

    wait(level.var_A983);
  }
}

func_AA88() {
  self linkto(level.var_99D9, "tag_origin");
}

func_29B8(param_00, param_01, param_02, param_03) {
  wait(2);
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_vista_burning_ship_large"), param_00, "TAG_FX_sunken1_smoke_01", -90);
  wait 0.05;
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_med_vista"), param_00, "TAG_FX_sunken1_smoke_04", -10);
  wait 0.05;
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_med_vista"), param_01, "TAG_FX_sunken1_smoke_07", -10);
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken1_splashes_1");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken1_splashes_2");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken1_splashes_3");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken1_splashes_4");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken1_splashes_5");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken1_splashes_6");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken1_splashes_7");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken1_splashes_8");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken1_splashes_9");
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_lrg_vista"), param_01, "TAG_FX_sunken2_smoke_01", -30);
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_med_vista"), param_01, "TAG_FX_sunken2_smoke_02", -10);
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken2_splashes_1");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken2_splashes_2");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken2_splashes_3");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken2_splashes_4");
  wait 0.05;
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_lrg_vista"), param_00, "TAG_FX_sunken3_smoke_03", -30);
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_med_vista"), param_00, "TAG_FX_sunken3_smoke_01", -10);
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_med_vista"), param_00, "TAG_FX_sunken3_smoke_05", -10);
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken3_splashes_1");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken3_splashes_2");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken3_splashes_3");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken3_splashes_4");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken3_splashes_5");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_00, "TAG_FX_sunken3_splashes_6");
  wait 0.05;
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_lrg_vista"), param_01, "TAG_FX_sunken4_smoke_03", -30);
  maps\mp\_utility::func_74A3(common_scripts\utility::func_44F5("mp_bat_boat_smk_med_vista"), param_01, "TAG_FX_sunken4_smoke_04", -10);
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken4_splashes_1");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken4_splashes_2");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken4_splashes_3");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("mp_bat_sunken_ship_splashes"), param_01, "TAG_FX_sunken4_splashes_4");
}