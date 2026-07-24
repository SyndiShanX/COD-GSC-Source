/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_marsoasis\mp_marsoasis.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_marsoasis\mp_marsoasis_precache::main();
  scripts\mp\maps\mp_marsoasis\gen\mp_marsoasis_art::main();
  scripts\mp\maps\mp_marsoasis\mp_marsoasis_fx::main();
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
}

_id_CDA4(var_0) {
  wait 30;
  playcinematicforalllooping(var_0);
}