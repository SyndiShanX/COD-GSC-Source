/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_subbase.gsc
********************************************************/

main() {
  maps\mp\mp_subbase_precache::main();
  maps\createart\mp_subbase_art::main();
  maps\mp\mp_subbase_fx::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_subbase");

  ambientPlay("ambient_mp_snow");

  game["defenders"] = "axis";
  game["attackers"] = "allies";

  setDvar("r_specularcolorscale", "2.9");
  setDvar("compassmaxrange", "2500");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 2);
  //setDvar( "r_lightGridContrast", 0 );
}