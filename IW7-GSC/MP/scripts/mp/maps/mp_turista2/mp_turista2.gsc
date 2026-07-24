/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_turista2\mp_turista2.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_turista2\mp_turista2_precache::main();
  scripts\mp\maps\mp_turista2\gen\mp_turista2_art::main();
  scripts\mp\maps\mp_turista2\mp_turista2_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_marsoasis");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 1024);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_CDA4("mp_marsoasis_casino");
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
  level.modifiedspawnpoints["-896 -2936 476"]["mp_front_spawn_allies"]["no_alternates"] = 1;
}

fix_collision() {
  var_0 = getEnt("player128x128x128", "targetname");
  var_1 = spawn("script_model", (1320, 2152, 736));
  var_1.angles = (330, 55, 2.5);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player128x128x128", "targetname");
  var_3 = spawn("script_model", (64, 876, 812));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("player512x512x8", "targetname");
  var_5 = spawn("script_model", (-1217, -1721, 176));
  var_5.angles = (82.1, 186.7, -3.5);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("player64x64x128", "targetname");
  var_7 = spawn("script_model", (1800, 288, 984));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("player64x64x256", "targetname");
  var_9 = spawn("script_model", (-396, -2598, 658));
  var_9.angles = (20, 50, -1.3);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("player128x128x256", "targetname");
  var_11 = spawn("script_model", (-364, -1934, 674));
  var_11.angles = (2.1, 40, -24);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("player64x64x128", "targetname");
  var_13 = spawn("script_model", (-348, -1952, 731));
  var_13.angles = (2.1, 40, -24);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("player128x128x256", "targetname");
  var_15 = spawn("script_model", (-444, -1977, 674));
  var_15.angles = (2, 20, -15.8);
  var_15 clonebrushmodeltoscriptmodel(var_14);
}

_id_CDA4(var_0) {
  wait 30;
  playcinematicforalllooping(var_0);
}