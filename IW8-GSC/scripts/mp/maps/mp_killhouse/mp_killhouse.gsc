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
  setDvar("PKKMTTRQO", 8);
  setDvar("LTMPKRLLNM", 5000);
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
  var0 = getEnt("fanAnimatedPivot", "targetname");
  var1 = getEnt("drillPivot", "script_noteworthy");

  if(isDefined(var0)) {
    var0 linkTo(var1);
  }

  var2 = getEntArray(var0.target, "targetname");

  foreach(var4 in var2) {
    var4 linkTo(var0);
  }
}