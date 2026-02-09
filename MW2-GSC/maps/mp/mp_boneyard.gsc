/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_boneyard.gsc
********************************************************/

main() {
  maps\mp\mp_boneyard_precache::main();

  maps\mp\mp_boneyard_fx::main();
  maps\createart\mp_boneyard_art::main();
  maps\mp\mp_boneyard_precache::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_boneyard");
  setDvar("compassmaxrange", "1700");

  ambientPlay("ambient_mp_desert");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.19);
  setDvar("r_lightGridContrast", .4);

  if(level.ps3)
    setDvar("sm_sunShadowScale", "0.7"); // ps3 optimization
}