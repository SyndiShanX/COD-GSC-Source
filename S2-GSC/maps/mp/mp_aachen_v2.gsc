/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_aachen_v2.gsc
*********************************************/

func_00F9() {
  lib_049A::func_F9();
  lib_0402::func_F9();
  lib_0499::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_aachen_v2_lighting::func_F9();
  maps\mp\mp_aachen_v2_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_aachen_v2");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_611["intro_explosion"] = loadfx("vfx/scorestreaks/mortar_scorestreak_exp_01");
  level.var_5A7C = "mp_aachen_v2_killstreak";
  level.var_5A6B = "mp_aachen_v2_killstreak";
  level.var_47CD = "mp_aachen_v2_glide1";
  level.var_47CE = "mp_aachen_v2_glide2";
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
  thread func_542C();
  level thread maps\mp\_utility::func_5246();
  func_854F();
  func_877E();
}

func_542C() {
  level endon("game_ended");
  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
    return;
  }

  if(isDefined(game["status"]) && game["status"] != "normal") {
    return;
  }

  if(!isDefined(level.var_984D) || !level.var_984D || level.var_3FDC == "infect") {
    return;
  }

  level waittill("matchStartTimer");
  var_00 = common_scripts\utility::func_46B5("intro_bomb_loc", "targetname");
  level.var_811 = 1;
  thread maps\mp\killstreaks\_airstrike::func_B9A(-1, "airstrike", undefined, "allies", var_00.var_116, var_00.var_1D[1]);
  level waittill("carpetBombingEnded");
  level.var_811 = undefined;
}

func_854F() {
  setDvar("3100", 4);
}

func_877E() {
  level.var_14F4 = [];
  level.var_14F4[0] = (2060, 1475, 292);
  level.var_14F4[1] = (1750, 1475, 292);
  level.var_14F4[2] = (2103, 652, 319);
  level.var_14F4[3] = (1835, 652, 319);
  level.var_14F4[4] = (1723, -965, 368);
  level.var_14F4[5] = (1927, -955, 312);
  level.var_14F4[6] = (-790, 35, 371);
  level.var_14F4[7] = (-329, -402, 785);
}