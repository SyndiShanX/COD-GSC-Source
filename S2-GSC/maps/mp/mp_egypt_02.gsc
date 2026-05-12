/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_egypt_02.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_egypt_02_precache::func_F9();
  maps\createart\mp_egypt_02_art::func_F9();
  maps\mp\mp_egypt_02_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_egypt_02_lighting::func_F9();
  maps\mp\mp_egypt_02_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_egypt_02");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_7C62 = 7250;
  level.var_6C5F = "mp_egypt_02_osp";
  level.var_6C5E = "mp_egypt_02_osp";
  level.var_3445 = "mp_egypt_02_drone";
  level.var_343A = "mp_egypt_02_drone";
  level.var_A853 = "mp_egypt_02_warbird";
  level.var_A852 = "mp_egypt_02_warbird";
  level.var_5A7C = "mp_egypt_02_killstreak";
  level.var_5A6B = "mp_egypt_02_killstreak";
  level.var_47CD = "mp_egypt_02_glide1";
  level.var_47CE = "mp_egypt_02_glide2";
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
  performance_tweaks();
}

performance_tweaks() {
  if(level.var_1D4 && getDvar("2695") != "true") {
    setDvar("4341", 0);
  }
}