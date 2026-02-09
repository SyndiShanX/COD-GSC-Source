/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_estate.gsc
********************************************************/

main() {
  maps\mp\mp_estate_precache::main();
  maps\createart\mp_estate_art::main();
  maps\mp\mp_estate_fx::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_estate");

  ambientPlay("ambient_mp_estate");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_specularcolorscale", "1.17");
  setDvar("compassmaxrange", "3500");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.3);
  setDvar("r_lightGridContrast", 0);

  if(level.ps3)
    setDvar("sm_sunShadowScale", "0.5"); // ps3 optimization
  else
    setDvar("sm_sunShadowScale", "0.7"); // optimization
}