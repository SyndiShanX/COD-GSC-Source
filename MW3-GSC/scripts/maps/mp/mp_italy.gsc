/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_italy.gsc
****************************************/

main() {
  maps\mp\mp_italy_precache::main();
  maps\createart\mp_italy_art::main();
  maps\mp\mp_italy_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_italy");
  maps\mp\_compass::setupminimap("compass_map_mp_italy");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
}