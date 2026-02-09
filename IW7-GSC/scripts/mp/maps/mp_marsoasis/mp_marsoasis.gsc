/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_marsoasis\mp_marsoasis.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_marsoasis\mp_marsoasis_precache::main();
  scripts\mp\maps\mp_marsoasis\gen\mp_marsoasis_art::main();
  scripts\mp\maps\mp_marsoasis\mp_marsoasis_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_marsoasis");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 1024);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread func_CDA4("mp_marsoasis_casino");
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
  level.modifiedspawnpoints["-896 -2936 476"]["mp_front_spawn_allies"]["no_alternates"] = 1;
}

fix_collision() {
  var_0 = getent("player128x128x128", "targetname");
  var_1 = spawn("script_model", (1320, 2152, 736));
  var_1.angles = (330, 55, 2.5);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("player128x128x128", "targetname");
  var_3 = spawn("script_model", (64, 876, 812));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player512x512x8", "targetname");
  var_5 = spawn("script_model", (-1217, -1721, 176));
  var_5.angles = (82.1, 186.7, -3.5);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("player64x64x128", "targetname");
  var_7 = spawn("script_model", (1800, 288, 984));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player64x64x256", "targetname");
  var_9 = spawn("script_model", (-396, -2598, 658));
  var_9.angles = (20, 50, -1.3);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("player128x128x256", "targetname");
  var_11 = spawn("script_model", (-364, -1934, 674));
  var_11.angles = (2.1, 40, -24);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player64x64x128", "targetname");
  var_13 = spawn("script_model", (-348, -1952, 731));
  var_13.angles = (2.1, 40, -24);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player128x128x256", "targetname");
  var_15 = spawn("script_model", (-444, -1977, 674));
  var_15.angles = (2, 20, -15.8);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_10 = getent("player32x32x128", "targetname");
  var_11 = spawn("script_model", (1440, -352, 616));
  var_11.angles = (0, 330, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player32x32x32", "targetname");
  var_13 = spawn("script_model", (1440, -352, 744));
  var_13.angles = (0, 330, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player64x64x8", "targetname");
  var_15 = spawn("script_model", (-384, 2316, 698));
  var_15.angles = (284, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("player64x64x8", "targetname");
  var_17 = spawn("script_model", (-384, 2380, 698));
  var_17.angles = (284, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("player32x32x32", "targetname");
  var_19 = spawn("script_model", (-16, 2584, 524));
  var_19.angles = (0, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_18 = getent("player128x128x8", "targetname");
  var_19 = spawn("script_model", (-936, -3144, 496));
  var_19.angles = (270, 355, -85);
  var_19 clonebrushmodeltoscriptmodel(var_18);
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}