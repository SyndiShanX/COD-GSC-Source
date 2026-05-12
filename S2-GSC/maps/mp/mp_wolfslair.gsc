/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_wolfslair.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_wolfslair_precache::func_F9();
  maps\createart\mp_wolfslair_art::func_F9();
  maps\mp\mp_wolfslair_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_wolfslair_lighting::func_F9();
  maps\mp\mp_wolfslair_aud::func_F9();
  maps\mp\_water::func_D5();
  maps\mp\_compass::func_8A2F("compass_map_mp_wolfslair");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_wolfslair_killstreak";
  level.var_5A6B = "mp_wolfslair_killstreak";
  level.crafting_table = "glidebomb_hatchdoors_light_low";
  level.var_47CD = "mp_wolfslair_glide1";
  level.var_47CE = "mp_wolfslair_glide2";
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
  level.var_7C62 = 6500;
  func_877E();
  func_854F();
  setDvar("5800", 3);
  fixturretangles();
}

fixturretangles() {
  var_00 = getEntArray("misc_turret", "classname");
  foreach(var_02 in var_00) {
    if(var_02 method_85A4() < 66) {
      var_02 method_8150(40);
      var_02 method_8151(53);
    }
  }
}

func_854F() {
  setDvar("3100", 3);
  setDvar("3220", 0.5);
}

func_877E() {
  level.var_14F4 = [];
  level.var_14F4[0] = (280, 280, 743);
  level.var_14F4[1] = (27, 1201, 712);
}