/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_village.gsc
******************************************/

main() {
  maps\mp\mp_village_precache::main();
  maps\createart\mp_village_art::main();
  maps\mp\mp_village_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_village");
  maps\mp\_compass::setupminimap("compass_map_mp_village");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "mountains", 0.25, 0.9, 2);
}