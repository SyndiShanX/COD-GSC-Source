/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_broadcast.gsc
********************************/

main() {
  maps\mp\mp_broadcast_fx::main();
  maps\createart\mp_broadcast_art::main();
  maps\mp\mp_broadcast_precache::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_broadcast");
  game["allies"] = "marines";
  game["axis"] = "opfor";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "desert";
  game["axis_soldiertype"] = "desert";
  setdvar("r_specularcolorscale", "1");
  setdvar("r_diffusecolorscale", "5");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("compassmaxrange", "1600");
  thread misc_rotate_ceilingfans();
  thread misc_rotate_wallfans();

  if(level.gametype == "dom") {
    level.domborderfx["friendly"]["_c"] = "vfx\unique\vfx_marker_dom_broadcastc";
    level.domborderfx["enemy"]["_c"] = "vfx\unique\vfx_marker_dom_red_broadcastc";
    level.domborderfx["neutral"]["_c"] = "vfx\unique\vfx_marker_dom_white_broadcastc";
  }
}

misc_rotate_wallfans() {
  common_scripts\utility::array_thread(getentarray("me_fanwall_spin", "targetname"), ::fanwall_rotate_custom);
}

fanwall_rotate_custom() {
  var_0 = 1000;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((var_0, 0, 0), var_1);
    wait(var_1);
  }
}

misc_rotate_ceilingfans() {
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin", "targetname"), ::ceilingfan_rotate_custom);
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin_slow", "targetname"), ::ceilingfan_rotate_slow_custom);
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin_med", "targetname"), ::ceilingfan_rotate_med_custom);
}

ceilingfan_rotate_custom() {
  var_0 = 600;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}

ceilingfan_rotate_slow_custom() {
  var_0 = 50;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}

ceilingfan_rotate_med_custom() {
  var_0 = 150;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}