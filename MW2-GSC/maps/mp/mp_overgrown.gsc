/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_overgrown.gsc
********************************************************/

main() {
  maps\mp\mp_overgrown_precache::main();
  maps\mp\mp_overgrown_fx::main();
  maps\createart\mp_overgrown_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_overgrown_dlc");

  AmbientPlay("ambient_mp_overgrown");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "1");
  setDvar("compassmaxrange", "2200");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.0);
  setDvar("r_lightGridContrast", 1);
}