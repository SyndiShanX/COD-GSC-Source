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
  maps\_vehicle::build_template(var_3, var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_cobra_helicopter", "vehicle_cobra_helicopter");
  maps\_vehicle::build_deathmodel("vehicle_cobra_helicopter_low");
  maps\_vehicle::build_deathmodel("vehicle_cobra_helicopter_fly");
  maps\_vehicle::build_deathmodel("vehicle_cobra_helicopter_fly_low");
  maps\_vehicle::build_drive(%bh_rotors, undefined, 0, 3.0);
  var_4 = [];
  var_4["vehicle_cobra_helicopter"] = "explosions/large_vehicle_explosion";
  var_4["vehicle_cobra_helicopter_low"] = "explosions/large_vehicle_explosion";
  var_4["vehicle_cobra_helicopter_fly"] = "explosions/large_vehicle_explosion";
  var_4["vehicle_cobra_helicopter_fly_low"] = "explosions/large_vehicle_explosion";
  maps\_vehicle::build_deathfx("explosions/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::build_deathfx("explosions/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L", "tail_rotor_jnt", "hind_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::build_deathfx("explosions/aerial_explosion", "tag_engine_right", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::build_deathfx("explosions/aerial_explosion", "tag_deathfx", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::build_deathfx(var_4[var_0], undefined, "hind_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_mainturret();
  var_5 = randomfloatrange(0, 1);
  var_6 = maps\_vehicle::get_light_model(var_0, var_2);
  maps\_vehicle::build_light(var_6, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_5);
  maps\_vehicle::build_light(var_6, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_5);
  maps\_vehicle::build_light(var_6, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_5);
  maps\_vehicle::build_light(var_6, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_white_blink", "running", var_5);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {
  self.script_badplace = 0;
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0].sittag = "tag_pilot";
  var_0[1].sittag = "tag_gunner";
  var_0[0].bhasgunwhileriding = 0;
  var_0[1].bhasgunwhileriding = 0;
  var_0[0].idle[0] = % helicopter_pilot1_idle;
  var_0[0].idle[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0].idle[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0].idle[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0].idleoccurrence[0] = 500;
  var_0[0].idleoccurrence[1] = 100;
  var_0[0].idleoccurrence[2] = 100;
  var_0[0].idleoccurrence[3] = 100;
  var_0[1].idle[0] = % helicopter_pilot2_idle;
  var_0[1].idle[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[1].idle[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[1].idle[3] = % helicopter_pilot2_twitch_radio;
  var_0[1].idleoccurrence[0] = 450;
  var_0[1].idleoccurrence[1] = 100;
  var_0[1].idleoccurrence[2] = 100;
  var_0[1].idleoccurrence[3] = 100;
  return var_0;
}