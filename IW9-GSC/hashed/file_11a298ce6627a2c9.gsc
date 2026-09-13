/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_11a298ce6627a2c9.gsc
***********************************************/

main() {
  _id_0D5DC0819A999532::main();
  _id_4E226FA64A15B01A::main();
  _id_496FCBAD2999BAB0::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_toujane2");
  setDvar("r_umbraMinObjectContribution", 8);
  thread scripts\mp\animation_suite::animationsuite();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.modifiedspawnpoints["789 -1807"]["mp_koth_spawn"]["removeradius"] = 64;
}