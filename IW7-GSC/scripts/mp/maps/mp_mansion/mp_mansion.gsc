/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_mansion\mp_mansion.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_mansion\mp_mansion_precache::main();
  scripts\mp\maps\mp_mansion\gen\mp_mansion_art::main();
  scripts\mp\maps\mp_mansion\mp_mansion_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_mansion");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 4);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  createnavobstaclebybounds((-2201, 1073, -8), (20, 20, 20), (0, 0, 0));
  thread fix_collision();
  thread spawn_oob_trigger();
}

fix_collision() {
  var_0 = getEnt("clip64x64x128", "targetname");
  var_1 = spawn("script_model", (736, -208, 280));
  var_1.angles = (0, 180, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip512x512x8", "targetname");
  var_3 = spawn("script_model", (328, 1784, -256));
  var_3.angles = (0, 270, -75);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (16, 2096, -256));
  var_4.angles = (0, 360, -75);
  var_4 clonebrushmodeltoscriptmodel(var_2);
  var_5 = spawn("script_model", (-948, -1164, 508));
  var_5.angles = (360, 262, 95);
  var_5 clonebrushmodeltoscriptmodel(var_2);
  var_6 = getEnt("player64x64x64", "targetname");
  var_7 = spawn("script_model", (1808, 920, -40));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = spawn("script_model", (1880, 848, -40));
  var_8.angles = (0, 0, 0);
  var_8 clonebrushmodeltoscriptmodel(var_6);
  var_9 = spawn("script_model", (220, 1404, 8));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_6);
  var_10 = getEnt("player32x32x32", "targetname");
  var_11 = spawn("script_model", (832, 1683, 154));
  var_11.angles = (0, 0, 6);
  var_11 clonebrushmodeltoscriptmodel(var_10);
}

spawn_oob_trigger() {
  wait 1;
  var_0 = spawn("trigger_radius", (710, 1550, 275), 0, 100, 10);
  var_0 hide();
  level._id_C7B3[level._id_C7B3.size] = var_0;
}