/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18783.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("blackhawk", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_blackhawk_hero_hamburg");
  maps\_vehicle::_id_2AC1(%bh_rotors, undefined, 0);
  var_3 = [];
  var_3["vehicle_blackhawk_hero_hamburg"] = "explosions/large_vehicle_explosion";
  maps\_vehicle::_id_2A02("explosions/helicopter_explosion_secondary_small", "tag_engine_left", "blackhawk_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::_id_2A02("explosions/helicopter_explosion_secondary_small", "elevator_jnt", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::_id_2A02("fire/fire_smoke_trail_L", "elevator_jnt", "blackhawk_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::_id_2A02("explosions/helicopter_explosion_secondary_small", "tag_engine_right", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::_id_2A02("explosions/helicopter_explosion_secondary_small", "tag_deathfx", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::_id_2A02(var_3[var_0], undefined, "blackhawk_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::_id_2A04("explosions/aerial_explosion_heli_large", "tag_deathfx", "blackhawk_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");

  if(var_0 == "vehicle_blackhawk_hero_hamburg" && level.script == "hamburg") {
    maps\_vehicle::_id_29F5("chopper_ride_rumble", 0.15, 4.5, 600, 1, 1);
  }
  maps\_vehicle::_id_2ACA(::_id_3A9D, vehicle_scripts\_littlebird::_id_3A9C);
  maps\_vehicle::_id_2ACD(vehicle_scripts\_littlebird::_id_3E58);
  maps\_vehicle::_id_2AC8(1);
  var_4 = randomfloatrange(0, 1);
  var_5 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_5, "cockpit_blue_cargo01", "tag_light_cargo01", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::_id_2AAD(var_5, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.0);
  maps\_vehicle::_id_2AAD(var_5, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_red", "tag_engine_left", "fire/heli_engine_exhaust", "exhaust", var_4);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_red", "tag_engine_left", "fire/heli_engine_exhaust", "exhaust", var_4);
}

_id_3A9D() {
  var_0 = vehicle_scripts\_littlebird::_id_3A9D();
  var_0[5]._id_24F2 = "tag_body";
  var_0[5]._id_24F2 = "tag_detach_left_offset";
  return var_0;
}

_id_2B1D() {
  self._id_2941 = 0;
  maps\_vehicle::_id_2AB3("running");
  maps\_vehicle::_id_2AB3("interior");
  maps\_vehicle::_id_2AB3("exhaust");
  thread maps\_vehicle::_id_2A89();
}