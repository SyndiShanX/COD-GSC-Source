/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_forest_01.gsc
*********************************************/

func_00F9() {
  setdvarifuninitialized("loadscreen_poses", 0);
  lib_04A6::func_F9();
  lib_040E::func_F9();
  lib_04A5::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_forest_01_lighting::func_F9();
  maps\mp\mp_forest_01_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_forest_01");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_611["intro_explosion"] = loadfx("vfx/scorestreaks/mortar_scorestreak_exp_01");
  level.var_7C62 = 5500;
  level.var_5A7C = "mp_forest_01_killstreak";
  level.var_5A6B = "mp_forest_01_killstreak";
  level.var_47CD = "mp_forest_01_glide1";
  level.var_47CE = "mp_forest_01_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.4;
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
  thread func_542C();
  setDvar("5637", 1);
  setup_ctf_flag_offsets();
}

setup_ctf_flag_offsets() {
  level.axis_ctf_flag_offset = (0, -6, 23);
}

func_0EA3() {
  var_00 = getent("wheel", "targetname");
  var_00.var_99DA = 60;
  var_00.var_18A = -15;
  level.var_AA10 = var_00;
  for(;;) {
    var_00 rotatevelocity((level.var_AA10.var_18A, 0, 0), level.var_AA10.var_99DA);
    wait(level.var_AA10.var_99DA);
  }
}

func_542C() {
  level endon("game_ended");
  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
    return;
  }

  if(isDefined(game["status"]) && game["status"] != "normal") {
    return;
  }

  if(!isDefined(level.var_984D) || !level.var_984D) {
    return;
  }

  level waittill("matchStartTimer");
  var_00 = func_1E43("allies");
  var_01 = func_1E43("axis");
  var_02 = common_scripts\utility::func_46B7("intro_axis_zone", "targetname");
  var_03 = common_scripts\utility::func_46B7("intro_allies_zone", "targetname");
  activateclientexploder(10);
  if(!isDefined(var_02) || !isDefined(var_03) || var_02.size < 2 || var_03.size < 2) {
    return;
  }

  var_04 = 9;
  while(var_04 > 0) {
    var_05 = [];
    var_06 = randomfloatrange(min(var_03[0].var_116[0], var_03[1].var_116[0]), max(var_03[0].var_116[0], var_03[1].var_116[1]));
    var_07 = randomfloatrange(min(var_03[0].var_116[1], var_03[1].var_116[1]), max(var_03[0].var_116[1], var_03[1].var_116[1]));
    var_08 = (var_06, var_07, 0);
    var_05[var_05.size] = var_08;
    var_09 = randomfloatrange(min(var_02[0].var_116[0], var_02[1].var_116[0]), max(var_02[0].var_116[0], var_02[1].var_116[1]));
    var_0A = randomfloatrange(min(var_02[0].var_116[1], var_02[1].var_116[1]), max(var_02[0].var_116[1], var_02[1].var_116[1]));
    var_0B = (var_09, var_0A, 0);
    var_05[var_05.size] = var_0B;
    foreach(var_0D in var_05) {
      var_0D = var_0D + (0, 0, 1000);
      var_0E = bulletTrace(var_0D, var_0D - (0, 0, 1500), 0, 1);
      playFX(common_scripts\utility::func_44F5("intro_explosion"), var_0E["position"]);
      maps\mp\_audio::func_8DA0("ks_mstrike_exp", var_0D);
      thread func_3E30(var_00, var_01);
    }

    var_10 = randomfloatrange(0.25, 1);
    var_04 = var_04 - var_10;
    wait(var_10);
  }
}

func_1E43(param_00) {
  var_01 = lib_050D::func_46A0(param_00);
  var_02 = (0, 0, 0);
  foreach(var_04 in var_01) {
    var_02 = var_02 + var_04.var_116;
  }

  var_06 = var_02 / var_01.size;
  return var_06;
}

func_3E30(param_00, param_01) {
  func_3E31(param_00);
  func_3E31(param_01);
}

func_3E31(param_00) {
  var_01 = (randomint(500), randomint(500), 0);
  var_02 = 0.05 + randomfloat(0.1);
  function_01BB("artillery_rumble", param_00 + var_01);
  earthquake(var_02, 1, param_00 + var_01, 2000);
}