/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23473.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  if(var_2 == "script_vehicle_cobra_helicopter_so") {
    var_3 = "cobra_so";
  } else {
    var_3 = "cobra";
  }
  maps\_vehicle::_id_2AC2(var_3, var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_cobra_helicopter", "vehicle_cobra_helicopter");
  maps\_vehicle::_id_2ABE("vehicle_cobra_helicopter_low");
  maps\_vehicle::_id_2ABE("vehicle_cobra_helicopter_fly");
  maps\_vehicle::_id_2ABE("vehicle_cobra_helicopter_fly_low");
  maps\_vehicle::_id_2AC1(%bh_rotors, undefined, 0, 3.0);
  var_4 = [];
  var_4["vehicle_cobra_helicopter"] = "explosions/large_vehicle_explosion";
  var_4["vehicle_cobra_helicopter_low"] = "explosions/large_vehicle_explosion";
  var_4["vehicle_cobra_helicopter_fly"] = "explosions/large_vehicle_explosion";
  var_4["vehicle_cobra_helicopter_fly_low"] = "explosions/large_vehicle_explosion";
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::_id_2A02("fire/fire_smoke_trail_L", "tail_rotor_jnt", "hind_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_engine_right", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_deathfx", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::_id_2A02(var_4[var_0], undefined, "hind_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");
  maps\_vehicle::_id_2AC7();
  var_5 = randomfloatrange(0, 1);
  var_6 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_6, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_5);
  maps\_vehicle::_id_2AAD(var_6, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_5);
  maps\_vehicle::_id_2AAD(var_6, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_5);
  maps\_vehicle::_id_2AAD(var_6, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_white_blink", "running", var_5);
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
}

_id_2B1D() {
  self._id_2941 = 0;
}

_id_3A9C(var_0) {
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0]._id_24F2 = "tag_pilot";
  var_0[1]._id_24F2 = "tag_gunner";
  var_0[0]._id_24F4 = 0;
  var_0[1]._id_24F4 = 0;
  var_0[0]._id_0F59[0] = % helicopter_pilot1_idle;
  var_0[0]._id_0F59[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0]._id_0F59[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0]._id_0F59[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0]._id_254D[0] = 500;
  var_0[0]._id_254D[1] = 100;
  var_0[0]._id_254D[2] = 100;
  var_0[0]._id_254D[3] = 100;
  var_0[1]._id_0F59[0] = % helicopter_pilot2_idle;
  var_0[1]._id_0F59[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[1]._id_0F59[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[1]._id_0F59[3] = % helicopter_pilot2_twitch_radio;
  var_0[1]._id_254D[0] = 450;
  var_0[1]._id_254D[1] = 100;
  var_0[1]._id_254D[2] = 100;
  var_0[1]._id_254D[3] = 100;
  return var_0;
}