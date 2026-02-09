/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_estate_tropical.gsc
********************************************************/

main() {
  maps\mp\_load::main();

  maps\mp\mp_estate_tropical_fx::main();
  maps\mp\mp_estate_tropical_precache::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_estate_tropical");

  maps\createart\mp_estate_tropical_art::main();

  ambientPlay("ambient_mp_estate");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_specularcolorscale", "3");
  setDvar("r_diffusecolorscale", "1.5");
  setDvar("sm_sunsamplesizenear", "0.38");

  setDvar("compassmaxrange", "3500");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.3);
  setDvar("r_lightGridContrast", 0);
}