/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_cargoship.gsc
********************************/

main() {
  maps\mp\mp_cargoship_precache::main();
  maps\mp\mp_cargoship_fx::main();
  maps\createart\mp_cargoship_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_cargoship");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "woodland";
  game["axis_soldiertype"] = "woodland";
  thread animated_cranes();
  thread animated_boats_precache();
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_tonemapHighlightRange", 0);
  setdvar("compassmaxrange", "2100");
  misc_rotate_fans();
  maps\mp\_fx_trigger::main();

  if(level.gametype == "dom") {
    level.domborderfx["friendly"]["_a"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["friendly"]["_b"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["friendly"]["_c"] = "vfx\unique\vfx_marker_dom_med";
    level.domborderfx["enemy"]["_a"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["enemy"]["_b"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["enemy"]["_c"] = "vfx\unique\vfx_marker_dom_red_med";
    level.domborderfx["neutral"]["_a"] = "vfx\unique\vfx_marker_dom_w_mid";
    level.domborderfx["neutral"]["_b"] = "vfx\unique\vfx_marker_dom_w_mid";
    level.domborderfx["neutral"]["_c"] = "vfx\unique\vfx_marker_dom_w_mid";
  }

  maps\mp\gametypes\_teams::setfactiontableoverride("marines", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_marines_night");
  maps\mp\gametypes\_teams::setfactiontableoverride("opfor", maps\mp\gametypes\_teams::getteamheadiconcol(), "h1_headicon_opfor_night");
  level.killconfirmeddogtagenemy = "h1_dogtag_enemy_animated_night";
  level.killconfirmeddogtagfriend = "h1_dogtag_friend_animated_night";
  level.bombsquadmodelc4 = "weapon_c4_bombsquad_mw1_night";
  level.bombsquadmodelclaymore = "weapon_claymore_bombsquad_mw1_night";
  level.oldschoolfxtype = "unlit";
}

misc_rotate_fans() {
  precachempanim("rotate_Z_L");
  common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate_custom", "targetname"), ::fan_blade_rotate_custom);
  common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate", "targetname"), ::fan_blade_rotate);
}

fan_blade_rotate_custom() {
  self scriptmodelplayanimdeltamotion("rotate_Z_L");
}

fan_blade_rotate() {
  var_0 = 600;

  for (;;) {
    self rotatevelocity((0, 150, 0), var_0);
    wait(var_0);
  }
}

animated_cranes() {
  precachempanim("h1_mp_crane_idle_1");
  precachempanim("h1_mp_crane_idle_2");
  var_0 = getent("crane1", "targetname");
  var_1 = getent("crane2", "targetname");
  var_0 scriptmodelplayanimdeltamotion("h1_mp_crane_idle_1");
  var_1 scriptmodelplayanimdeltamotion("h1_mp_crane_idle_2");
}

animated_boats_precache() {
  precachempanim("h1_mp_lifeboat_idle_1");
  precachempanim("h1_mp_lifeboat_idle_2");
  precachempanim("h1_mp_lifeboat_idle_3");
  var_0 = getentarray("animated_boat", "targetname");
  common_scripts\utility::array_thread(var_0, ::animated_boats);
}

#using_animtree("animated_props_dlc");

animated_boats() {
  var_0 = [];
  var_1 = [];
  var_0[0] = "h1_mp_lifeboat_idle_1";
  var_1[0] = % h1_mp_lifeboat_idle_1;
  var_0[1] = "h1_mp_lifeboat_idle_2";
  var_1[1] = % h1_mp_lifeboat_idle_2;
  var_0[2] = "h1_mp_lifeboat_idle_3";
  var_1[2] = % h1_mp_lifeboat_idle_3;

  for (;;) {
    var_2 = randomint(3);
    self scriptmodelplayanimdeltamotion(var_0[var_2]);
    wait(getanimlength(var_1[var_2]));
  }
}