/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_park.gsc
***************************************/

main() {
  maps\mp\mp_park_precache::main();
  maps\createart\mp_park_art::main();
  maps\mp\mp_park_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_park");
  maps\mp\_compass::setupminimap("compass_map_mp_park");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("sm_sunShadowScale", "0.8");
  game["attackers"] = "allies";
  game["defenders"] = "axis";

  if(level.gametype == "oic" || level.gametype == "gun" || level.gametype == "infect") {
    var_0 = getEntArray("misc_turret", "classname");

    foreach(var_2 in var_0) {}
    var_2 delete();
  }

  thread maps\mp\_utility::killtrigger((1750, -302, 122), 40, 15);
  thread maps\mp\_utility::killtrigger((1858, -350, 174), 60, 15);
  thread maps\mp\_utility::killtrigger((1806, -326, 160), 60, 15);
  thread maps\mp\_utility::killtrigger((1738, -358, 122), 40, 15);
  audio_settings();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "mountains", 0.25, 0.9, 2);
}