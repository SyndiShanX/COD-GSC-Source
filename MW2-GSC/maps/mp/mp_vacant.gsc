/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_vacant.gsc
********************************************************/

main() {
  maps\mp\mp_vacant_precache::main();
  maps\mp\mp_vacant_fx::main();
  maps\createart\mp_vacant_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_vacant_dlc");

  AmbientPlay("ambient_mp_vacant");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "1");
  setDvar("compassmaxrange", "1500");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.0);
  setDvar("r_lightGridContrast", 1);
}