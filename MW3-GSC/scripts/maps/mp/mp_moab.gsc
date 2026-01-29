/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_moab.gsc
***************************************/

main() {
  maps\mp\mp_moab_precache::main();
  maps\createart\mp_moab_art::main();
  maps\mp\mp_moab_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_moab");
  maps\mp\_compass::setupminimap("compass_map_mp_moab");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_diffuseColorScale", 1.36);
  setdvar("r_specularColorScale", 2.94);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level thread moab_wheel();
  audio_settings();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "mountains", 0.25, 0.9, 2);
}

moab_wheel() {
  var_0 = getent("wheel_model", "targetname");
  var_1 = getEntArray("animated_model", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3 in var_1) {
    if(var_3.model == "generic_prop_raven") {
      var_0 linkto(var_3, "J_prop_1");
      break;
    }
  }
}