/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_gibraltar_02.gsc
*********************************************/

func_00F9() {
  lib_04AA::func_F9();
  lib_0412::func_F9();
  lib_04A9::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_gibraltar_02_lighting::func_F9();
  maps\mp\mp_gibraltar_02_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_gibraltar_02");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_gibraltar_02_killstreak";
  level.var_5A6B = "mp_gibraltar_02_killstreak";
  level.var_47CD = "mp_gibraltar_02_glide1";
  level.var_47CE = "mp_gibraltar_02_glide2";
  level.crafting_table = "glidebomb_hatchdoors_light_bright";
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
  setDvar("4712", "2");
  level.var_7C62 = 6500;
  func_877E();
  setup_demolition_site_origins();
  var_00 = function_032F();
  for(var_01 = 0; var_01 < var_00; var_01++) {
    deleteglass(var_01);
  }

  removevistaplanecollision();
}

func_877E() {
  level.var_14F4 = [];
  level.var_14F4[0] = (1006, 1436, 392);
  level.var_14F4[1] = (625, 1734, 489);
  level.var_14F4[2] = (1093, -1466, 191);
}

setup_demolition_site_origins() {
  level.demolition_site_origins = [];
  level.demolition_site_origins[0] = (-1062, -600.5, 157.367);
  level.demolition_site_angles = [];
  level.demolition_site_angles[0] = (1.8, 24, 0);
  level.demolition_site_mod = [];
  level.demolition_site_mod[0] = "bombzone_b";
}

removevistaplanecollision() {
  var_00 = function_021F();
  foreach(var_02 in var_00) {
    if(var_02.var_116[0] == 0 && var_02.var_116[1] == 0 && var_02.var_116[2] == 0) {
      var_02 method_80B1();
    }
  }
}