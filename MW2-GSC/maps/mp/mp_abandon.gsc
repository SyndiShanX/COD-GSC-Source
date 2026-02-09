/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\mp\mp_abandon.gsc
********************************************************/

main() {
  maps\mp\mp_abandon_precache::main();
  maps\createart\mp_abandon_art::main();
  maps\mp\mp_abandon_fx::main();

  maps\mp\_destructible_dlc2::main(); // call before _load
  maps\mp\_destructible_dlc::main(); // call before _load
  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_abandon");

  ambientPlay("ambient_mp_abandon");

  setDvar("r_specularcolorscale", "2.5");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.452);
  setDvar("r_lightGridContrast", 0);

  setDvar("compassmaxrange", "1800");

  game["attackers"] = "allies";
  game["defenders"] = "axis";
}