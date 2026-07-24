/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_dome_dusk\mp_dome_dusk.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_dome_dusk\mp_dome_dusk_precache::main();
  scripts\mp\maps\mp_dome_dusk\gen\mp_dome_dusk_art::main();
  scripts\mp\maps\mp_dome_dusk\mp_dome_dusk_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_dome_dusk");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_sdfShadowPenumbra", 0.2);
  setDvar("r_umbraMinObjectContribution", 3);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread setup_vista_driving_cars();
  thread patchablecollision();
  level.removedspawnpoints = [];
  level.removedspawnpoints[202] = 1;
}

patchablecollision() {
  var_0 = spawn("script_model", (1760, -368, -128));
  var_0.angles = (0, 0, 180);
  var_0 setModel("mp_desert_uplink_col_01");
  var_1 = spawn("script_model", (1776, -832, -128));
  var_1.angles = (0, 0, 180);
  var_1 setModel("mp_desert_uplink_col_01");
  var_2 = getEnt("player32x32x8", "targetname");
  var_3 = spawn("script_model", (1184, 124, 324));
  var_3.angles = (0, 0, -70);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (896, 124, 324));
  var_4.angles = (0, 0, -70);
  var_4 clonebrushmodeltoscriptmodel(var_2);
  var_5 = getEnt("player256x256x256", "targetname");
  var_6 = spawn("script_model", (1120, -1872, 600));
  var_6.angles = (15, 0, 0);
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_5 = getEnt("clip512x512x8", "targetname");
  var_6 = spawn("script_model", (32, -2448, 480));
  var_6.angles = (0, 117, 90);
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_7 = spawn("script_model", (275, -2448, 480));
  var_7.angles = (0, -117, 90);
  var_7 clonebrushmodeltoscriptmodel(var_5);
  var_8 = spawn("script_model", (-200, -1992, 480));
  var_8.angles = (0, 117, 90);
  var_8 clonebrushmodeltoscriptmodel(var_5);
  var_9 = getEnt("player512x512x8", "targetname");
  var_10 = spawn("script_model", (-200, -1992, 992));
  var_10.angles = (0, 117, 90);
  var_10 clonebrushmodeltoscriptmodel(var_9);
  var_11 = spawn("script_model", (275, -2448, 992));
  var_11.angles = (0, -117, 90);
  var_11 clonebrushmodeltoscriptmodel(var_9);
  var_12 = spawn("script_model", (32, -2448, 992));
  var_12.angles = (0, 117, 90);
  var_12 clonebrushmodeltoscriptmodel(var_9);
  var_13 = getEnt("clip64x64x256", "targetname");
  var_14 = spawn("script_model", (152, -2588, 224));
  var_14.angles = (0, 45, 0);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getEnt("player256x256x8", "targetname");
  var_16 = spawn("script_model", (1923, -1664, 126.5));
  var_16.angles = (275, 0, 0);
  var_16 clonebrushmodeltoscriptmodel(var_15);
  var_17 = getEnt("clip64x64x256", "targetname");
  var_18 = spawn("script_model", (-415, -1528, 32));
  var_18.angles = (5, 26.3, 6);
  var_18 clonebrushmodeltoscriptmodel(var_17);
}

setup_vista_driving_cars() {
  var_0 = getEntArray("vista_car", "targetname");

  foreach(var_2 in var_0) {
    thread vista_car_drive(var_2);
  }
}

vista_car_drive(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = 0.002;

  for(;;) {
    var_3 = abs(distance(var_0.origin, var_1.origin) * var_2);
    var_0 moveTo(var_1.origin, var_3, 0, 0);
    var_0 rotateTo(var_1.angles, var_3, 0, 0);
    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    wait(var_3);
  }
}