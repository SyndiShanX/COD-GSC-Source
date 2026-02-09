/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_storm.gsc
********************************************************/

main() {
  maps\mp\mp_storm_precache::main();
  maps\mp\mp_storm_fx::main();
  maps\createart\mp_storm_art::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_storm");

  ambientPlay("ambient_mp_storm");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_specularcolorscale", "1.5");
  setDvar("compassmaxrange", "2300");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.3);
  //setDvar( "r_lightGridContrast", .5 );
}