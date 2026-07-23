/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18783.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("blackhawk", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_blackhawk_hero_hamburg");
  maps\_vehicle::build_drive(%bh_rotors, undefined, 0);
  var_3 = [];
  var_3["vehicle_blackhawk_hero_hamburg"] = "explosions/large_vehicle_explosion";
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_engine_left", "blackhawk_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "elevator_jnt", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L", "elevator_jnt", "blackhawk_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_engine_right", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_deathfx", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::build_deathfx(var_3[var_0], undefined, "blackhawk_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_rocket_deathfx("explosions/aerial_explosion_heli_large", "tag_deathfx", "blackhawk_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");

  if(var_0 == "vehicle_blackhawk_hero_hamburg" && level.script == "hamburg") {
    maps\_vehicle::build_rumble("chopper_ride_rumble", 0.15, 4.5, 600, 1, 1);
  }
  maps\_vehicle::build_aianims(::setanims, vehicle_scripts\_littlebird::set_vehicle_anims);
  maps\_vehicle::build_unload_groups(vehicle_scripts\_littlebird::unload_groups);
  maps\_vehicle::build_bulletshield(1);
  var_4 = randomfloatrange(0, 1);
  var_5 = maps\_vehicle::get_light_model(var_0, var_2);
  maps\_vehicle::build_light(var_5, "cockpit_blue_cargo01", "tag_light_cargo01", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_5, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.0);
  maps\_vehicle::build_light(var_5, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::build_light(var_5, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_red", "tag_engine_left", "fire/heli_engine_exhaust", "exhaust", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_red", "tag_engine_left", "fire/heli_engine_exhaust", "exhaust", var_4);
}

setanims() {
  var_0 = vehicle_scripts\_littlebird::setanims();
  var_0[5].sittag = "tag_body";
  var_0[5].sittag = "tag_detach_left_offset";
  return var_0;
}

init_local() {
  self.script_badplace = 0;
  maps\_vehicle::lights_on("running");
  maps\_vehicle::lights_on("interior");
  maps\_vehicle::lights_on("exhaust");
  thread maps\_vehicle::littlebird_landing();
}