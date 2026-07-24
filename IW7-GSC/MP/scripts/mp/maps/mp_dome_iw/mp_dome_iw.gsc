/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_dome_iw\mp_dome_iw.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_dome_iw\mp_dome_iw_precache::main();
  scripts\mp\maps\mp_dome_iw\gen\mp_dome_iw_art::main();
  scripts\mp\maps\mp_dome_iw\mp_dome_iw_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_dome_iw");
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
}

setup_vista_driving_cars() {
  var_0 = getEntArray("vista_car", "targetname");

  foreach(var_2 in var_0)
  thread vista_car_drive(var_2);
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