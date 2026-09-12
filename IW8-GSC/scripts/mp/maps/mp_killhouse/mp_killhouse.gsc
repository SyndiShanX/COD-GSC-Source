/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_killhouse\mp_killhouse.gsc
*********************************************************/

function main() {
  scripts\mp\maps\mp_killhouse\mp_killhouse_precache::main();
  scripts\mp\maps\mp_killhouse\gen\mp_killhouse_art::main();
  scripts\mp\maps\mp_killhouse\mp_killhouse_fx::main();
  scripts\mp\maps\mp_killhouse\mp_killhouse_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_killhouse", "codcaster_compass_map_mp_killhouse");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_vertexDeformCutOffDist", 5000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread scripts\mp\animation_suite::animationsuite();
  thread ref_12d9b();
  scripts\cp_mp\utility\game_utility::ref_12b3b();
}

function ref_12d9b() {
  var_0 = getEnt("fanAnimatedPivot", "targetname");
  var_1 = getEnt("drillPivot", "script_noteworthy");

  if(isDefined(var_0)) {
    var_0 linkTo(var_1);
  }

  var_2 = getEntArray(var_0.target, "targetname");

  foreach(var_4 in var_2) {
    var_4 linkTo(var_0);
  }
}