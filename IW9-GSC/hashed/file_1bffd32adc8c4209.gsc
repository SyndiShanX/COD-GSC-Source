/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1bffd32adc8c4209.gsc
***********************************************/

main() {
  _id_5D1502BFC047C4A5::main();
  _id_36FE9627AFC2A62A::main();
  _id_53B63BA29111545A::main();
  _id_7FF5279EF2A93CF0::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_9CFE515677727128();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_crossing");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("dvar_2448528570EF56F7", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "mexico";
  thread _id_B385569E197AE59B();
}

_id_B385569E197AE59B() {
  scripts\engine\utility::flag_wait("rockable_cars_init");

  foreach(car in level.rockablecars.cars) {
    if(car getscriptableparthasstate("Window_Blast", "hide")) {
      car setscriptablepartstate("Window_Blast", "hide");
      continue;
    }

    car setscriptablepartstate("Window_Blast", "destroyed");
  }
}

_id_515C6E62CA9E615B() {
  level waittill("infil_setup_complete");
  _id_E4D2304F5DB539E1 = getEntArray("static_infil_van", "targetname");

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    foreach(van in _id_E4D2304F5DB539E1) {
      if(isDefined(van))
        van hide();
    }
  }
}