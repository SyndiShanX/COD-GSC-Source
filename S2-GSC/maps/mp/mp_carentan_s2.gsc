/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_carentan_s2.gsc
*********************************************/

func_00F9() {
  lib_04A0::func_F9();
  lib_0408::func_F9();
  lib_049F::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_carentan_s2_lighting::func_F9();
  maps\mp\mp_carentan_s2_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_carentan_s2");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_carentan_s2_killstreak";
  level.var_5A6B = "mp_carentan_s2_killstreak";
  level.var_47CD = "mp_carentan_s2_glide1";
  level.var_47CE = "mp_carentan_s2_glide2";
  level.crafting_table = "glidebomb_hatchdoors_light_bright";
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
  level.var_7C62 = 6000;
}