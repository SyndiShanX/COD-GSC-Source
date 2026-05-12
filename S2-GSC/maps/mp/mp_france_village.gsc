/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_france_village.gsc
*********************************************/

func_00F9() {
  lib_04A8::func_F9();
  lib_0410::func_F9();
  lib_04A7::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_france_village_lighting::func_F9();
  maps\mp\mp_france_village_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_france_village");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_france_village_killstreak";
  level.var_5A6B = "mp_france_village_killstreak";
  level.var_47CD = "mp_france_village_glide1";
  level.var_47CE = "mp_france_village_glide2";
  level.crafting_table = "glidebomb_hatchdoors_light_low";
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
  setDvar("5800", 3);
  func_877E();
  level thread francevillagedisconnectnodes();
}

func_877E() {
  level.var_14F4 = [];
  level.var_14F4[0] = (4654, 1707, 228);
}

francevillagedisconnectnodes() {
  var_00 = getnodesinradiussorted((5921.5, 1233.1, 165.656), 256, 0)[0];
  var_01 = getnodesinradiussorted((5805.3, 1224, 194.2), 256, 0)[0];
  var_02 = getnodesinradiussorted((5724.3, 1225, 194.2), 256, 0)[0];
  var_03 = getnodesinradiussorted((5724, 1148, 193), 256, 0)[0];
  disconnectnodepair(var_00, var_01, 1);
  disconnectnodepair(var_00, var_02, 1);
  disconnectnodepair(var_00, var_03, 1);
}