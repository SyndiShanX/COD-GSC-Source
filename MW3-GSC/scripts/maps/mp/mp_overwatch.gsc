/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_overwatch.gsc
********************************************/

main() {
  maps\mp\mp_overwatch_precache::main();
  maps\createart\mp_overwatch_art::main();
  maps\mp\mp_overwatch_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_overwatch");
  maps\mp\_compass::setupminimap("compass_map_mp_overwatch");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.6");
  } else {
    setdvar("sm_sunShadowScale", "0.8");

  }
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "city", 0.15, 0.9, 2);
}