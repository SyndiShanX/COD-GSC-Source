/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_showdown.gsc
********************************/

main() {
  maps\mp\mp_showdown_precache::main();
  maps\mp\mp_showdown_fx::main();
  maps\createart\mp_showdown_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_showdown");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "desert";
  game["axis_soldiertype"] = "desert";
  setdvar("compassmaxrange", "2000");
}