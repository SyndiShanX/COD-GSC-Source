/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_afghan\mp_afghan.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_afghan\mp_afghan_precache::main();
  scripts\mp\maps\mp_afghan\gen\mp_afghan_art::main();
  scripts\mp\maps\mp_afghan\mp_afghan_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_afghan");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("sm_sunSampleSizeNear", 1.2);
  setDvar("r_drawsun", 0);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_tessellationFactor", 40);
  setDvar("r_tessellationCutoffFalloff", 256);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_CDA4("mp_afghan_screen");
  level._id_C7B3 = getEntArray("outofbounds", "targetname");
  thread scripts\mp\animation_suite::animationsuite();
  level.movedspawnpoints[16]["origin"] = (4207, 2328, 7);
  level.movedspawnpoints[391]["origin"] = (4207, 2328, 7);
  level.movedspawnpoints[362]["origin"] = (4496, 317, 117);
  level.movedspawnpoints[118]["origin"] = (51.3, 3077.3, 10);
  level.noalternatespawnpoints[118] = 1;
  thread spawn_oob_trigger();
  thread fix_collision();
  thread fix_broshot();
}

_id_CDA4(var_0) {
  wait 30;
  playcinematicforalllooping(var_0);
}

spawn_oob_trigger() {
  wait 0.05;
  var_0 = spawn("trigger_radius", (-674, 2090, -102), 0, 150, 140);
  var_0.targetname = "outofbounds";
  var_0 hide();
  var_1 = spawn("trigger_radius", (1704, 4299, 180), 0, 200, 50);
  var_1.targetname = "outofbounds";
  var_1 hide();
  level._id_C7B3[level._id_C7B3.size] = var_0;
  level._id_C7B3[level._id_C7B3.size] = var_1;
}

fix_collision() {
  var_0 = getEnt("player32x32x8", "targetname");
  var_1 = spawn("script_model", (1772, 188.5, 415));
  var_1.angles = (0, 0, -70);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player64x64x256", "targetname");
  var_3 = spawn("script_model", (500, 1852, 136));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("player64x64x256", "targetname");
  var_5 = spawn("script_model", (500, 1852, 392));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("player64x64x256", "targetname");
  var_7 = spawn("script_model", (700, 1852, 136));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("player64x64x256", "targetname");
  var_9 = spawn("script_model", (700, 1852, 392));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("player128x128x128", "targetname");
  var_11 = spawn("script_model", (1040, 3952, 78));
  var_11.angles = (0, 30, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("player256x256x256", "targetname");
  var_13 = spawn("script_model", (5056, 2912, 80));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("clip128x128x256", "targetname");
  var_15 = spawn("script_model", (2960, 2172, 144));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("player64x64x64", "targetname");
  var_17 = spawn("script_model", (-234, 1664, 186));
  var_17.angles = (322, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("clip128x128x256", "targetname");
  var_19 = spawn("script_model", (3790, 1760, 192));
  var_19.angles = (26, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
}

fix_broshot() {
  var_0 = getEnt("character_loc_broshot_e", "targetname");
  var_1 = var_0.origin;
  var_0.origin = (var_1[0], var_1[1], 242);
}