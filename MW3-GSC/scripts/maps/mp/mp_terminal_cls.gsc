/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_terminal_cls.gsc
***********************************************/

main() {
  maps\mp\mp_terminal_cls_precache::main();
  maps\createart\mp_terminal_cls_art::main();
  maps\mp\mp_terminal_cls_fx::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_airport_dlc");
  maps\mp\_compass::setupminimap("compass_map_mp_terminal_cls");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "city", 0.2, 0.9, 2);
}