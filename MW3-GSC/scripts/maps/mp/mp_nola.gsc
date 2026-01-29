/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_nola.gsc
***************************************/

main() {
  maps\mp\mp_nola_precache::main();
  maps\createart\mp_nola_art::main();
  maps\mp\mp_nola_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_nola");
  maps\mp\_compass::setupminimap("compass_map_mp_nola");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_diffuseColorScale", 1.1);
  thread maps\mp\mp_nola_scriptlights::main();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
  sunshadow_optimization();
  level thread hovercraft_fan_blades();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "city", 0.15, 0.9, 2);
}

sunshadow_optimization() {
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.5");
  } else {
    setdvar("sm_sunShadowScale", "0.75");
  }
}

hovercraft_fan_blades() {
  level endon("game_ended");
  var_0 = getEntArray("hovercraft_fan_blade_parent", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {}
    var_5 linkto(var_2);

    var_2 childthread rotate_forever();
  }
}

rotate_forever() {
  var_0 = 8.0;

  for(;;) {
    self rotatepitch(360, var_0, 0, 0);
    wait(var_0 - 0.1);
  }
}