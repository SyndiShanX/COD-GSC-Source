/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_canon_farm.gsc
*********************************************/

func_00F9() {
  lib_049E::func_F9();
  lib_0406::func_F9();
  lib_049D::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_canon_farm_lighting::func_F9();
  maps\mp\mp_canon_farm_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_canon_farm");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_canon_farm_killstreak";
  level.var_5A6B = "mp_canon_farm_killstreak";
  level.var_47CD = "mp_canon_farm_glide1";
  level.var_47CE = "mp_canon_farm_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
}

func_7EEB() {
  var_00 = getent("windmill", "targetname");
  var_00 rotatepitch(7200, 1800);
}