/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_monte_cassino_v2.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_monte_cassino_v2_precache::func_F9();
  maps\createart\mp_monte_cassino_v2_art::func_F9();
  maps\mp\mp_monte_cassino_v2_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_monte_cassino_v2_lighting::func_F9();
  maps\mp\mp_monte_cassino_v2_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_monte_cassino_v2");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_monte_cassino_v2_osp";
  level.var_6C5E = "mp_monte_cassino_v2_osp";
  level.var_3445 = "mp_monte_cassino_v2_drone";
  level.var_343A = "mp_monte_cassino_v2_drone";
  level.var_A853 = "mp_monte_cassino_v2_warbird";
  level.var_A852 = "mp_monte_cassino_v2_warbird";
  level.var_5A7C = "mp_monte_cassino_v2_killstreak";
  level.var_5A6B = "mp_monte_cassino_v2_killstreak";
  level.var_47CD = "mp_monte_cassino_v2_glide1";
  level.var_47CE = "mp_monte_cassino_v2_glide2";
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
  if(isDefined(level.var_122)) {
    setDvar("r_ssrMaxQuality", 1);
  }

  thread performance_stuff();
}

performance_stuff() {
  setDvar("634", 0);
}