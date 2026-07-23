/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_brecourt.gsc
********************************************************/

main() {
  maps\mp\mp_brecourt_precache::main();
  maps\mp\mp_brecourt_fx::main();
  maps\createart\mp_brecourt_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_brecourt");

  ambientPlay("ambient_mp_rural");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_specularcolorscale", "1");

  setDvar("compassmaxrange", "4000");

  setDvar("sm_sunShadowScale", 0.5);

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.11);
  setDvar("r_lightGridContrast", .29);
}