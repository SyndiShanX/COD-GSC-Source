/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_checkpoint.gsc
********************************************************/

main() {
  maps\mp\mp_checkpoint_precache::main();
  maps\createart\mp_checkpoint_art::main();
  maps\mp\mp_checkpoint_fx::main();
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_checkpoint");

  // raise up planes to avoid them flying through buildings
  level.airstrikeHeightScale = 1.5;

  ambientPlay("ambient_mp_urban");

  game["attackers"] = "axis";
  game["defenders"] = "allies";

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.27);
  setDvar("r_lightGridContrast", 1);

  setDvar("r_specularcolorscale", "2");

  setDvar("compassmaxrange", "1600");
}