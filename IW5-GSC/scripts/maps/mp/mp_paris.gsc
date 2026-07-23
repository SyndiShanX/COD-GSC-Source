/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_paris.gsc
****************************************/

main() {
  maps\mp\mp_paris_precache::main();
  maps\createart\mp_paris_art::main();
  maps\mp\mp_paris_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_paris");
  maps\mp\_compass::setupminimap("compass_map_mp_paris");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
  thread maps\mp\_utility::killtrigger((1720, 552, 288), 100, 20);
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "city", 0.15, 0.9, 2);
}