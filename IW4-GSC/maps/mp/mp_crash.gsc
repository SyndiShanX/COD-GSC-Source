/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_crash.gsc
********************************************************/

main() {
  maps\mp\mp_crash_precache::main();
  maps\mp\mp_crash_fx::main();
  maps\createart\mp_crash_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_crash_dlc");

  AmbientPlay("ambient_mp_crash");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "1");
  setDvar("compassmaxrange", "1600");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.10);
  setDvar("r_lightGridContrast", 1);
}