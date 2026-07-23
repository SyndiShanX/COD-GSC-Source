/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_derail.gsc
********************************************************/

#include maps\mp\_utility;

main() {
  maps\mp\mp_derail_precache::main();
  maps\mp\mp_derail_fx::main();
  maps\createart\mp_derail_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_derail");

  ambientPlay("ambient_mp_snow");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "2.3");
  setDvar("compassmaxrange", "4000");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1);
  setDvar("r_lightGridContrast", .4);

  thread killTrigger((2077, -91, 0), 75, 20);
}