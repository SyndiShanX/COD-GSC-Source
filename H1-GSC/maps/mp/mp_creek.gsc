/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_creek.gsc
********************************/

main() {
  maps\mp\mp_creek_precache::main();
  maps\mp\mp_creek_fx::main();
  maps\createart\mp_creek_art::main();
  maps\mp\_load::main();
  maps\mp\_water::init();
  maps\mp\_compass::setupminimap("compass_map_mp_creek");
  game["allies"] = "sas";
  game["axis"] = "russian";
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "woodland";
  game["axis_soldiertype"] = "woodland";
}