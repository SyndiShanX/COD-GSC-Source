/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_nova\mp_nova.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_nova\mp_nova_precache::main();
  scripts\mp\maps\mp_nova\gen\mp_nova_art::main();
  scripts\mp\maps\mp_nova\mp_nova_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_nova");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 4);
  setdvar("r_umbraaccurateocclusionthreshold", 450);
  setdvar("r_tessellation", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
}

fix_collision() {
  var_00 = getent("player32x32x128", "targetname");
  var_01 = spawn("script_model", (996, -1276, 430.5));
  var_01.angles = (0, 0, 0);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("player32x32x128", "targetname");
  var_03 = spawn("script_model", (996, -1276, 302.5));
  var_03.angles = (0, 0, 0);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("player32x32x128", "targetname");
  var_05 = spawn("script_model", (1193, -1908, 550));
  var_05.angles = (49, 90, -90);
  var_05 clonebrushmodeltoscriptmodel(var_04);
}