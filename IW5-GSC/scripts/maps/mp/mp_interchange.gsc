/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_interchange.gsc
**********************************************/

main() {
  maps\mp\mp_interchange_precache::main();
  maps\createart\mp_interchange_art::main();
  maps\mp\mp_interchange_fx::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_interchange");
  maps\mp\_compass::setupminimap("compass_map_mp_interchange");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "parkinglot", 0.2, 0.9, 2);
}