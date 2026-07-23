/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_dome.gsc
***************************************/

main() {
  maps\mp\mp_dome_precache::main();
  maps\createart\mp_dome_art::main();
  maps\mp\mp_dome_fx::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_dome");
  maps\mp\_compass::setupminimap("compass_map_mp_dome");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
  thread maps\mp\_utility::killtrigger((0, 263, -223), 24, 10);
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "quarry", 0.15, 0.9, 2);
}