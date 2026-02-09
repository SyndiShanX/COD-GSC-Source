/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_crash_tropical.gsc
********************************************************/

main() {
  maps\mp\mp_crash_tropical_fx::main();
  maps\createfx\mp_crash_tropical_fx::main();
  maps\mp\mp_crash_tropical_precache::main();
  maps\createart\mp_crash_tropical_art::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_crash_dlc");
  setDvar("compassmaxrange", "1600");

  AmbientPlay("ambient_mp_favela");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "2.117");
  setDvar("r_diffusecolorscale", "1.35");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.10);
  setDvar("r_lightGridContrast", 1);
}