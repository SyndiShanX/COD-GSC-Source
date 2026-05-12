/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_dunkirk.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_dunkirk_precache::func_F9();
  maps\createart\mp_dunkirk_art::func_F9();
  maps\mp\mp_dunkirk_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_dunkirk_lighting::func_F9();
  maps\mp\mp_dunkirk_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_dunkirk");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_dunkirk_osp";
  level.var_6C5E = "mp_dunkirk_osp";
  level.var_3445 = "mp_dunkirk_drone";
  level.var_343A = "mp_dunkirk_drone";
  level.var_A853 = "mp_dunkirk_warbird";
  level.var_A852 = "mp_dunkirk_warbird";
  level.var_5A7C = "mp_dunkirk_killstreak";
  level.var_5A6B = "mp_dunkirk_killstreak";
  level.var_47CD = "mp_dunkirk_glide1";
  level.var_47CE = "mp_dunkirk_glide2";
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
  level thread func_6B82();
}

func_6B82() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    wait(0.2);
    if(isDefined(var_00)) {}
  }
}