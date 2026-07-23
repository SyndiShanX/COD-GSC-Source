/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_quarry.gsc
********************************************************/

main() {
  maps\mp\mp_quarry_precache::main();
  maps\mp\mp_quarry_fx::main();
  maps\createart\mp_quarry_art::main();
  maps\mp\_load::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_quarry");
  setDvar("compassmaxrange", "2800");

  ambientPlay("ambient_mp_desert");
  VisionSetNaked("mp_quarry");

  level.airstrikeHeightScale = 2;

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.22);
  setDvar("r_lightGridContrast", .67);
}