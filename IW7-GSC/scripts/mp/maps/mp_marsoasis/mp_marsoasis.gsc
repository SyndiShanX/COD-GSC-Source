/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_marsoasis\mp_marsoasis.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_marsoasis\mp_marsoasis_precache::main();
  scripts\mp\maps\mp_marsoasis\gen\mp_marsoasis_art::main();
  scripts\mp\maps\mp_marsoasis\mp_marsoasis_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_marsoasis");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 1024);
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
  var_00 = getent("player128x128x128", "targetname");
  var_01 = spawn("script_model", (1320, 2152, 736));
  var_01.angles = (330, 55, 2.5);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("player128x128x128", "targetname");
  var_03 = spawn("script_model", (64, 876, 812));
  var_03.angles = (0, 0, 0);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("player512x512x8", "targetname");
  var_05 = spawn("script_model", (-1217, -1721, 176));
  var_05.angles = (82.1, 186.7, -3.5);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("player64x64x128", "targetname");
  var_07 = spawn("script_model", (1800, 288, 984));
  var_07.angles = (0, 0, 0);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("player64x64x256", "targetname");
  var_09 = spawn("script_model", (-396, -2598, 658));
  var_09.angles = (20, 50, -1.3);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = getent("player128x128x256", "targetname");
  var_0B = spawn("script_model", (-364, -1934, 674));
  var_0B.angles = (2.1, 40, -24);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("player64x64x128", "targetname");
  var_0D = spawn("script_model", (-348, -1952, 731));
  var_0D.angles = (2.1, 40, -24);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = getent("player128x128x256", "targetname");
  var_0F = spawn("script_model", (-444, -1977, 674));
  var_0F.angles = (2, 20, -15.8);
  var_0F clonebrushmodeltoscriptmodel(var_0E);
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

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}