/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_c130.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");

main(model, type, classname) {
  build_template("c130", model, type, classname);
  build_localinit(::init_local);

  build_deathmodel("vehicle_ac130_low");

  build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(999, 500, 1500);
  build_team("allies");
  build_mainturret();

  build_light(classname, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", 0.0);
  build_light(classname, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", 0.05);
  build_light(classname, "tail_red", "tag_light_tail", "fx/misc/aircraft_light_white_blink", "running", 0.05);
  build_light(classname, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_red_blink", "running", 1.0);
}

init_local() {
  maps\_vehicle::vehicle_lights_on("running");
  self hidepart("tag_25mm");
  self hidepart("tag_40mm");
  self hidepart("tag_105mm");
}

#using_animtree("vehicles");
set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 1; i++) {
    positions[i] = spawnStruct();
  }

  return positions;
}