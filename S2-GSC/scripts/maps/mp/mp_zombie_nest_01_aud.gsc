/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_01_aud.gsc
*****************************************************/

main() {
  _id_7BBA();
  _id_526E();
}

_id_7BBA() {
  _id_0378::_id_8DC7("player_connect_map", ::_id_7248);
  _id_0378::_id_8DC7("player_spawned", ::_id_7330);
  _id_0378::_id_8DC7("wave_begin", ::_id_A979);
  _id_0378::_id_8DC7("wave_end", ::_id_A97A);
  _id_0378::_id_8DC7("enter_last_stand", ::_id_37B4);
  _id_0378::_id_8DC7("revive", ::_id_7E51);
  _id_0378::_id_8DC7("death", ::_id_2A83);
  _id_0378::_id_8DC7("end_respawn", ::_id_36A1);
  _id_0378::_id_8DC7("end_joined_spectators", ::_id_3689);
  _id_0378::_id_8DC7("play_blimp_dialog", ::_id_70C5);
  _id_0378::_id_8DC7("play_pa_dialog", ::_id_716C);
  _id_0378::_id_8DC7("stop_pa_dialog", ::_id_93DE);
  _id_0378::_id_8DC7("play_pa_music", ::_id_716E);
  _id_0378::_id_8DC7("gas_valve_state", ::_id_3FE4);
  _id_0378::_id_8DC7("zone1Earthquake", ::_id_AC91);
  _id_0378::_id_8DC7("zmb_pap_button", ::_id_AB03);
  _id_0378::_id_8DC7("zmb_pap_begin", ::_id_AB02);
  _id_0378::_id_8DC7("zmb_pap_fuse", ::_id_AB09);
  _id_0378::_id_8DC7("zmb_pap_cage_up_1", ::_id_AB04);
  _id_0378::_id_8DC7("zmb_pap_cage_up_2", ::_id_AB05);
  _id_0378::_id_8DC7("zmb_pap_cage_up_3", ::_id_AB06);
  _id_0378::_id_8DC7("zmb_pap_cage_up_4", ::_id_AB07);
  _id_0378::_id_8DC7("zmb_pap_end", ::_id_AB08);
  _id_0378::_id_8DC7("catacombs_scare", ::_id_2034);
  _id_0378::_id_8DC7("generator_power_switch_state", ::_id_401C);
  _id_0378::_id_8DC7("window_jumpscare", ::_id_AA38);
  _id_0378::_id_8DC7("sewage_jumpscare", ::_id_8A75);
  _id_0378::_id_8DC7("fall_jumpscare", ::_id_3A11);
  _id_0378::_id_8DC7("fol_tube_jumpscare_rattle", ::_id_3DB6);
  _id_0378::_id_8DC7("fol_tube_jumpscare_execute", ::_id_3DB5);
  _id_0378::_id_8DC7("fol_tube_jumpscare_door_fall", ::_id_3DB4);
  _id_0378::_id_8DC7("well_explosion_ignite", ::_id_AA02);
  _id_0378::_id_8DC7("well_explosion", ::_id_AA01);
  _id_0378::_id_8DC7("well_zombies_group_scream", ::_id_AA03);
  _id_0378::_id_8DC7("aud_saw_blade_sound", ::_id_806F);
  _id_0378::_id_8DC7("aud_saw_blade_end", ::_id_8071);
  _id_0378::_id_8DC7("aud_start_electricity", ::_id_9CA9);
  _id_0378::_id_8DC7("aud_stop_electricity", ::_id_9CA8);
  _id_0378::_id_8DC7("aud_enigma_switch_activate", ::_id_3787);
  _id_0378::_id_8DC7("aud_start_enigma_timer", ::_id_3788);
  _id_0378::_id_8DC7("aud_fuse_timer_start", ::_id_3F24);
  _id_0378::_id_8DC7("aud_fuse_timer_stop", ::_id_3F25);
  _id_0378::_id_8DC7("aud_hc_enigma_use", ::_id_4BCF);
  _id_0378::_id_8DC7("aud_saltmine_door_powered", ::_id_8034);
  _id_0378::_id_8DC7("aud_cart_lights_off", ::_id_201E);
  _id_0378::_id_8DC7("aud_start_pneumo_tube", ::_id_1304);
  _id_0378::_id_8DC7("aud_compartment_door_open", ::_id_255F);
  _id_0378::_id_8DC7("aud_compartment_door_close", ::_id_255E);
  _id_0378::_id_8DC7("aud_start_claw_button_press", ::_id_12E4);
  _id_0378::_id_8DC7("comm_room_claw_trapdoor_start_open", ::_id_253B);
  _id_0378::_id_8DC7("comm_room_claw_trapdoor_slider", ::_id_2539);
  _id_0378::_id_8DC7("comm_room_claw_trapdoor_closing", ::_id_2537);
  _id_0378::_id_8DC7("comm_room_claw_trapdoor_closed", ::_id_2536);
  _id_0378::_id_8DC7("comm_room_claw_trapdoor_stall", ::_id_253A);
  _id_0378::_id_8DC7("comm_room_claw_trapdoor_end_open", ::_id_2538);
  _id_0378::_id_8DC7("shard_room_claw_stuck_impact", ::_id_8AD0);
  _id_0378::_id_8DC7("circuit_map_reveal_machine_lights", ::_id_22F6);
  _id_0378::_id_8DC7("circuit_set_fuse_color_switch", ::_id_22F8);
  _id_0378::_id_8DC7("fuse_color_switch_door_open", ::_id_3F20);
  _id_0378::_id_8DC7("fuse_color_switch_door_close", ::_id_3F1F);
  _id_0378::_id_8DC7("voice_of_god_update_tumbler", ::_id_A609);
  _id_0378::_id_8DC7("voice_of_god_start", ::_id_A606);
  _id_0378::_id_8DC7("voice_of_god_fail", ::_id_A603);
  _id_0378::_id_8DC7("aud_right_hand_of_god_ready", ::_id_7E8B);
  _id_0378::_id_8DC7("aud_activate_right_hand_of_god", ::_id_089C);
  _id_0378::_id_8DC7("aud_activate_left_hand_of_god", ::_id_0897);
  _id_0378::_id_8DC7("aud_activate_workbench", ::_id_08A5);
  _id_0378::_id_8DC7("fireman_intro_scream", ::_id_3BF8);
  _id_0378::_id_8DC7("aud_zombie_soul_absorb", ::_id_ABF7);
  _id_0378::_id_8DC7("zombie_soul_suck", ::_id_ABF8);
  _id_0378::_id_8DC7("zombie_soul_suck_threshold", ::_id_ABF9);
  _id_0378::_id_8DC7("blimp_start", ::_id_17A2);
  _id_0378::_id_8DC7("blimp_charge", ::_id_179D);
  _id_0378::_id_8DC7("blimp_projectile", ::_id_17A0);
  _id_0378::_id_8DC7("blimp_hit_plr", ::_id_179F);
  _id_0378::_id_8DC7("blimp_turret_explode", ::_id_17A3);
  _id_0378::_id_8DC7("blimp_battery_land", ::_id_179B);
  _id_0378::_id_8DC7("blimp_projectile_impact", ::_id_17A1);
  _id_0378::_id_8DC7("aud_battery_retract", ::_id_1633);
  _id_0378::_id_8DC7("aud_claw_connection_forge", ::_id_11F6);
  _id_0378::_id_8DC7("aud_start_med_forge", ::_id_1302);
  _id_0378::_id_8DC7("aud_start_rnd_forge", ::_id_1305);
  _id_0378::_id_8DC7("aud_tower_alarm", ::_id_9AC8);
  _id_0378::_id_8DC7("aud_tower_alarm_stop", ::_id_9AC9);
  _id_0378::_id_8DC7("aud_tower_machine_dmg_state", ::_id_9B3B);
  _id_0378::_id_8DC7("aud_tower_machine_destroyed", ::_id_9B3A);
  _id_0378::_id_8DC7("aud_tower_machine_crash", ::_id_9B38);
  _id_0378::_id_8DC7("aud_tower_machine_use", ::_id_9B3E);
  _id_0378::_id_8DC7("aud_tower_machine_move_strt", ::_id_9B3D);
  _id_0378::_id_8DC7("aud_tower_machine_move_stop", ::_id_9B3C);
  _id_0378::_id_8DC7("aud_tower_machine_zombie_hit", ::_id_9B3F);
  _id_0378::_id_8DC7("aud_tower_shockwave", ::_id_9B4D);
  _id_0378::_id_8DC7("aud_tower_strike", ::_id_9B4F);
  _id_0378::_id_8DC7("aud_spinning_top_shot", ::_id_12D7);
  _id_0378::_id_8DC7("aud_spinning_top_fall", ::_id_12D4);
  _id_0378::_id_8DC7("aud_spinning_top_place", ::_id_12D5);
  _id_0378::_id_8DC7("aud_spinning_top_turn", ::_id_12D8);
  _id_0378::_id_8DC7("aud_spinning_top_drawer_open", ::_id_12D3);
  _id_0378::_id_8DC7("aud_spinning_top_record_obtained", ::_id_12D6);
  _id_0378::_id_8DC7("aud_wonder_weapon_elec_coil_charge", ::_id_134F);
  _id_0378::_id_8DC7("aud_switch_damaged", ::_id_9549);
  _id_0378::_id_8DC7("aud_waterwheel", ::_id_A96F);
  _id_0378::_id_8DC7("aud_break_statue", ::_id_1BAB);
  _id_0378::_id_8DC7("aud_trap_elec_start", ::_id_9CA7);
  _id_0378::_id_8DC7("aud_trap_betty_explo", ::_id_9C98);
  _id_0378::_id_8DC7("aud_trap_betty_triggered", ::_id_9C99);
  _id_0378::_id_8DC7("aud_trap_spikes", ::_id_9CC8);
  _id_0378::_id_8DC7("aud_weathervane_rotate", ::_id_A9FB);
  _id_0378::_id_8DC7("aud_uberschnelle_place_altar", ::_id_9FE7);
  _id_0378::_id_8DC7("aud_battery_electrocute", ::_id_1632);
  _id_0378::_id_8DC7("dark_wings_start", ::_id_2A32);
  _id_0378::_id_8DC7("dark_wings_update", ::_id_2A34);
  _id_0378::_id_8DC7("dark_wings_stop", ::_id_2A33);
  _id_0378::_id_8DC7("aud_claw_move_start", ::_id_232A);
  _id_0378::_id_8DC7("aud_claw_move_stop", ::_id_232B);
  _id_0378::_id_8DC7("aud_bunker_lights", ::_id_1D98);
  _id_0378::_id_8DC7("aud_start_hilt_sphere_sound", ::_id_9226);
  _id_0378::_id_8DC7("aud_shoot_chandelier", ::_id_8B10);
  _id_0378::_id_8DC7("aud_hilt_destroy", ::_id_4D73);
  _id_0378::_id_8DC7("aud_pickup_raven_sword", ::_id_6FC3);
  _id_0378::_id_8DC7("aud_open_raven_door", ::_id_6BF4);
  _id_0378::_id_8DC7("aud_nuke_explo", ::_id_6854);
  _id_0378::_id_8DC7("aud_revived_klaus_speak", ::_id_7E55);
  _id_0378::_id_8DC7("blow_open_uber_concealment_door", ::_id_1806);
  _id_0378::_id_8DC7("aud_fireman_fire_emitters", ::_id_3BF3);
  _id_0378::_id_8DC7("brute_intro_begin", ::_id_1CC1);
  _id_0378::_id_8DC7("brute_intro_end", ::_id_1CC2);
}

_id_526E() {
  _id_5196();
  _id_0367::_id_8E3E("nst01");
  _id_A604();
  thread _id_80DF();
  thread _id_80E0();
  thread _id_80E1();
}

_id_5196() {
  var_0 = "conv_lightningtower";
  var_1 = [];
  var_1["primary"]["mari"] = ["lightningtower", 1.0];
  var_1["primary"]["jeff"] = ["lightningtower", 1.0];
  var_1["primary"]["oliv"] = ["lightningtower", 1.0];
  var_1["primary"]["dros"] = ["lightningtower", 1.0];
  var_1["secondary"]["dros"] = ["lightningtower_reply", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_hiltroomentrance";
  var_1 = [];
  var_1["primary"]["jeff"] = ["hiltroomentrance_both", 1.0];
  var_1["primary"]["dros"] = ["hiltroomentrance_both", 1.0];
  var_1["primary"]["mari"] = ["hiltroomentrance_both", 1.0];
  var_1["primary"]["oliv"] = ["hiltroomentrance_both", 1.0];
  var_1["secondary"]["jeff"] = ["hiltroomentrance_both", 1.0];
  var_1["secondary"]["dros"] = ["hiltroomentrance_both", 1.0];
  var_1["secondary"]["mari"] = ["hiltroomentrance_both", 1.0];
  var_1["secondary"]["oliv"] = ["hiltroomentrance_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_hiltlook";
  var_1 = [];
  var_1["primary"]["jeff"] = ["hiltlook_both", 1.0];
  var_1["primary"]["dros"] = ["hiltlook_both", 1.0];
  var_1["primary"]["mari"] = ["hiltlook_both", 1.0];
  var_1["primary"]["oliv"] = ["hiltlook_both", 1.0];
  var_1["secondary"]["jeff"] = ["hiltlook_both", 1.0];
  var_1["secondary"]["dros"] = ["hiltlook_both", 1.0];
  var_1["secondary"]["mari"] = ["hiltlook_both", 1.0];
  var_1["secondary"]["oliv"] = ["hiltlook_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_hiltshoot";
  var_1 = [];
  var_1["primary"]["jeff"] = ["hiltshoot1", 1.0];
  var_1["primary"]["dros"] = ["hiltshoot1", 1.0];
  var_1["primary"]["mari"] = ["hiltshoot1", 1.0];
  var_1["primary"]["oliv"] = ["hiltshoot1", 1.0];
  var_1["secondary"]["dros"] = ["hiltshoot1_reply", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_righthandaltarfinish";
  var_1 = [];
  var_1["primary"]["jeff"] = ["righthandaltarfinish_both", 1.0];
  var_1["primary"]["dros"] = ["righthandaltarfinish_both", 1.0];
  var_1["primary"]["mari"] = ["righthandaltarfinish_both", 1.0];
  var_1["primary"]["oliv"] = ["righthandaltarfinish_both", 1.0];
  var_1["secondary"]["jeff"] = ["righthandaltarfinish_both", 1.0];
  var_1["secondary"]["dros"] = ["righthandaltarfinish_both", 1.0];
  var_1["secondary"]["mari"] = ["righthandaltarfinish_both", 1.0];
  var_1["secondary"]["oliv"] = ["righthandaltarfinish_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_righthandaltarclue";
  var_1 = [];
  var_1["primary"]["jeff"] = ["righthandaltarclue_both", 1.0];
  var_1["primary"]["dros"] = ["righthandaltarclue_both", 1.0];
  var_1["primary"]["mari"] = ["righthandaltarclue_both", 1.0];
  var_1["primary"]["oliv"] = ["righthandaltarclue_both", 1.0];
  var_1["secondary"]["jeff"] = ["righthandaltarclue_both", 1.0];
  var_1["secondary"]["dros"] = ["righthandaltarclue_both", 1.0];
  var_1["secondary"]["mari"] = ["righthandaltarclue_both", 1.0];
  var_1["secondary"]["oliv"] = ["righthandaltarclue_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_zepreaction";
  var_1 = [];
  var_1["primary"]["jeff"] = ["zepreaction_both", 1.0];
  var_1["primary"]["dros"] = ["zepreaction_both", 1.0];
  var_1["primary"]["mari"] = ["zepreaction_both", 1.0];
  var_1["primary"]["oliv"] = ["zepreaction_both", 1.0];
  var_1["secondary"]["jeff"] = ["zepreaction_both", 1.0];
  var_1["secondary"]["dros"] = ["zepreaction_both", 1.0];
  var_1["secondary"]["mari"] = ["zepreaction_both", 1.0];
  var_1["secondary"]["oliv"] = ["zepreaction_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_wavedifficultyclue";
  var_1 = [];
  var_1["primary"]["jeff"] = ["wavedifficultyclue_both", 1.0];
  var_1["primary"]["dros"] = ["wavedifficultyclue_both", 1.0];
  var_1["primary"]["mari"] = ["wavedifficultyclue_both", 1.0];
  var_1["primary"]["oliv"] = ["wavedifficultyclue_both", 1.0];
  var_1["secondary"]["jeff"] = ["wavedifficultyclue_both", 1.0];
  var_1["secondary"]["dros"] = ["wavedifficultyclue_both", 1.0];
  var_1["secondary"]["mari"] = ["wavedifficultyclue_both", 1.0];
  var_1["secondary"]["oliv"] = ["wavedifficultyclue_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_juicerintro";
  var_1 = [];
  var_1["primary"]["dros"] = ["juicerintro_both", 1.0];
  var_1["primary"]["mari"] = ["juicerintro_both", 1.0];
  var_1["primary"]["oliv"] = ["juicerintro_both", 1.0];
  var_1["secondary"]["jeff"] = ["juicerintro_both", 1.0];
  var_1["secondary"]["dros"] = ["juicerintro_both", 1.0];
  var_1["secondary"]["mari"] = ["juicerintro_both", 1.0];
  var_1["secondary"]["oliv"] = ["juicerintro_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_klausroom";
  var_1 = [];
  var_1["primary"]["jeff"] = ["klausroom_both", 1.0];
  var_1["primary"]["dros"] = ["klausroom_both", 1.0];
  var_1["primary"]["mari"] = ["klausroom_both", 1.0];
  var_1["primary"]["oliv"] = ["klausroom_both", 1.0];
  var_1["secondary"]["jeff"] = ["klausroom_both", 1.0];
  var_1["secondary"]["dros"] = ["klausroom_both", 1.0];
  var_1["secondary"]["mari"] = ["klausroom_both", 1.0];
  var_1["secondary"]["oliv"] = ["klausroom_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_hiltrecovered";
  var_1 = [];
  var_1["primary"]["jeff"] = ["hiltrecovered_both", 1.0];
  var_1["primary"]["dros"] = ["hiltrecovered_both", 1.0];
  var_1["primary"]["mari"] = ["hiltrecovered_both", 1.0];
  var_1["primary"]["oliv"] = ["hiltrecovered_both", 1.0];
  var_1["secondary"]["jeff"] = ["hiltrecovered_both", 1.0];
  var_1["secondary"]["dros"] = ["hiltrecovered_both", 1.0];
  var_1["secondary"]["mari"] = ["hiltrecovered_both", 1.0];
  var_1["secondary"]["oliv"] = ["hiltrecovered_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
  var_0 = "conv_hiltroomcollapse";
  var_1 = [];
  var_1["primary"]["jeff"] = ["hiltroomcollapse", 1.0];
  var_1["primary"]["mari"] = ["hiltroomcollapse", 1.0];
  var_1["primary"]["oliv"] = ["hiltroomcollapse_both", 1.0];
  var_1["primary"]["dros"] = ["hiltroomcollapse_both", 1.0];
  var_1["secondary"]["dros"] = ["hiltroomcollapse_both", 1.0];
  var_1["secondary"]["oliv"] = ["hiltroomcollapse_both", 1.0];
  _id_0367::_id_8E38(var_0, var_1);
}

_id_8DEC() {
  var_0 = self;
  wait 0.5;
  var_1 = (3389, 2001, 1176);
  var_2 = (-2035, 2586, 1235);
  var_3 = (610, 1350, 1237);
  var_4 = (1196, 1198, 1237);
  var_5 = (610, 1000, 1237);
  var_6 = (570, 1268, 1235);
}

_id_991B(var_0, var_1) {
  if(_func_344(var_0)) {
    for(;;) {
      _id_046C::_id_8DA0(var_0, var_1);
      wait 2;
    }
  }
}

_id_7248() {}

_id_7330() {
  self _meth_8626("fireman_intro_fire_off");
  thread _id_8E8F();
  _id_0366::snd_zmb_set_plr_vox_scare_count_max(1);
}

_id_A979() {}

_id_A97A() {}

_id_37B4() {}

_id_7E51() {}

_id_2A83() {
  var_0 = 5.0;
  _id_0366::_id_8E32(var_0);
}

_id_36A1() {}

_id_3689() {}

_id_70C5(var_0, var_1) {
  if(common_scripts\utility::_id_562E(level._id_943B._id_90C2)) {
    return;
  }
  _id_0380::_id_288D(var_0, undefined, var_1, 0, 1, 3.0);
}

_id_716C(var_0, var_1, var_2) {
  if(isDefined(var_2) && _func_0C0(var_2)) {
    foreach(var_4 in level.players)
    var_4 thread _id_8E8C(var_0, var_2, "exterior");
  }
}

_id_93DE() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_071D._id_6DDA)) {
      _id_0380::_id_6850(var_1._id_071D._id_6DDA, 0.25);
      var_1._id_071D._id_6DDA = undefined;
    }

    if(isDefined(var_1._id_071D._id_6DD9)) {
      _id_0380::_id_6850(var_1._id_071D._id_6DD9, 0.25);
      var_1._id_071D._id_6DD9 = undefined;
    }

    if(isDefined(var_1._id_071D._id_6DDB)) {
      foreach(var_3 in var_1._id_071D._id_6DDB)
      _id_0380::_id_6850(var_3, 0.25);

      var_1._id_071D._id_6DDB = [];
    }
  }
}

_id_8E8C(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0.3;
  var_5 = undefined;
  var_6 = 1.0;
  var_7 = 1;

  if(!isDefined(var_3._id_071D._id_6DD8))
    var_3._id_071D._id_6DDB = [];

  wait(_func_0A4(1, 2));

  if(var_2 == "exterior") {
    var_5 = var_0 + "2";

    if(!_func_344(var_5)) {
      var_5 = var_0 + "_2";

      if(!_func_344(var_5))
        var_5 = undefined;
    }
  }

  var_3._id_071D._id_6DD3 = [];

  for(var_8 = 0; var_8 < var_1.size; var_8++) {
    var_9 = var_1[var_8];
    var_10 = spawnStruct();
    var_10._id_90BE = var_9;
    var_10._id_3018 = distance(var_3.origin, var_9.origin);
    var_3._id_071D._id_6DD3[var_8] = var_10;
  }

  var_11 = common_scripts\utility::_id_7897(var_3._id_071D._id_6DD3, ::_id_716D);

  if(isDefined(var_3._id_071D._id_6DDA)) {
    _id_0380::_id_6850(var_3._id_071D._id_6DDA, 0.25);
    var_3._id_071D._id_6DDA = undefined;
  }

  var_3._id_071D._id_6DDA = _id_0380::_id_6846(var_0, var_3, var_3, 0, 1);

  if(isDefined(var_3._id_071D._id_6DD9)) {
    _id_0380::_id_6850(var_3._id_071D._id_6DD9, 0.25);
    var_3._id_071D._id_6DD9 = undefined;
  }

  if(isDefined(var_5))
    var_3._id_071D._id_6DD9 = _id_0380::_id_6840(var_5, var_3, 0, 0.5);

  foreach(var_13 in var_3._id_071D._id_6DDB)
  _id_0380::_id_6850(var_13, 0.25);

  var_3._id_071D._id_6DDB = [];
  var_15 = _func_0AF(var_7, var_1.size);

  for(var_8 = 0; var_8 < var_15; var_8++) {
    wait(var_4);
    var_9 = var_11[var_8]._id_90BE;
    var_6 = var_6 * 0.5;
    var_3._id_071D._id_6DDB[var_3._id_071D._id_6DDB.size] = _id_0380::_id_6842(var_0 + "_delay", var_3, var_9.origin, 0, var_6);
  }
}

_id_8E8F() {
  self endon("disconnect");
  var_0 = 0.5;
  var_1 = 1;
  var_2 = 1.0;

  for(;;) {
    var_3 = maps\mp\mp_zombie_nest_ee_util::_id_740A();

    if(!isDefined(self)) {
      break;
    }

    if(var_3 != var_1) {
      if(var_3)
        self _meth_8627("pa_inside", 1.0);
      else
        self _meth_8626("pa_inside", 1.0);

      var_1 = var_3;
    }

    wait(var_0);
  }
}

_id_716E(var_0) {
  var_1 = "zmb_wwii_march_music";

  if(!isDefined(var_0) || var_0.size <= 0) {
    return;
  }
  foreach(var_3 in level.players)
  _id_0380::_id_2889(var_1, var_3, var_0[0].origin, 0, 1);
}

_id_716D(var_0, var_1) {
  return var_0._id_3018 <= var_1._id_3018;
}

_id_3FE4(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 getentitynumber();

  if(!isDefined(level._id_11CB._id_A28E))
    level._id_11CB._id_A28E = [];

  var_4 = level._id_11CB._id_A28E[var_3];

  if(!isDefined(var_4)) {
    var_4 = spawnStruct();
    level._id_11CB._id_A28E[var_3] = var_4;
  }

  switch (var_0) {
    case "start_opening":
      if(var_1) {
        var_5 = var_2.origin + (0, 0, 100);
        var_4._id_3FE3 = _id_0380::_id_6842("zmb_valve_gas_flow_lp", undefined, var_5);
        _id_0380::_id_684E(var_4._id_3FE3, 0, 0);
      }

      _id_046C::_id_8DA0("zmb_valve_start_unlock", var_2.origin);
      break;
    case "opening":
      if(isDefined(var_4._id_9E98))
        _func_352(var_4._id_9E98, 0.1);

      var_4._id_9E98 = _func_351("zmb_valve_opening_lp", var_2, undefined, undefined, undefined, "hard");

      if(var_1)
        _id_0380::_id_684E(var_4._id_3FE3, 1, self._id_A29D);

      break;
    case "closing":
      if(isDefined(var_4._id_9E98))
        _func_352(var_4._id_9E98, 0.1);

      var_4._id_9E98 = _func_351("zmb_valve_closing_lp", var_2, undefined, undefined, undefined, "hard");

      if(var_1)
        _id_0380::_id_684E(var_4._id_3FE3, 0, self._id_A29D);

      break;
    case "open":
      _id_046C::_id_8DA0("zmb_valve_open", var_2.origin);

      if(var_1)
        _id_0380::_id_684E(var_4._id_3FE3, 0.666, 2.0);

      _func_352(var_4._id_9E98, 0.1);
      break;
    case "closed":
      _id_046C::_id_8DA0("zmb_valve_stop_lock", var_2.origin);

      if(isDefined(var_4._id_9E98))
        _func_352(var_4._id_9E98, 0.1);

      if(isDefined(var_4._id_3FE3)) {
        _id_0380::_id_6850(var_4._id_3FE3, 0.1);
        var_4._id_3FE3 = undefined;
      }

      break;
  }
}

_id_AC91(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 _meth_8626("earthquakezone1");

  switch (var_0) {
    case "rumble1":
      if(!isDefined(level._id_11CB._id_AC92)) {
        var_5 = var_1;
        var_6 = 2.5;
        _id_0366::_id_8E30(0.75, var_5);
        level._id_11CB._id_AC92 = _id_0378::_id_7207("zone1Earthquake_phase1", undefined, var_5);
      }

      break;
    case "rumble2":
      if(!isDefined(level._id_11CB._id_AC93)) {
        var_5 = var_1;
        var_6 = 1.0;
        level._id_11CB._id_AC93 = _id_0378::_id_7207("zone1Earthquake_phase2", undefined, var_5);
      }

      break;
    case "rumble3":
      if(!isDefined(level._id_11CB._id_AC94)) {
        var_5 = var_1;
        var_6 = 1.0;
        _id_0366::_id_8E30(0.5, var_5);
        level._id_11CB._id_AC94 = _id_0378::_id_7207("zone1Earthquake_phase3", undefined, var_5);
      }

      break;
    case "earthquake":
      if(!isDefined(level._id_11CB._id_AC95)) {
        var_5 = 0.25;
        var_6 = var_1 * 0.5 * 0.95;
        _id_0366::_id_8E30(0.25, var_5);
        level._id_11CB._id_AC95 = _id_0378::_id_7207("zone1Earthquake_phase4", undefined, var_5);
        wait(var_1 * 0.5);
        _id_0378::_id_7207("zone1Earthquake_settle", undefined, var_5);
        _id_AC96(var_6);
      }

      break;
  }
}

_id_AC96(var_0) {
  _id_0366::_id_8E30(1.0, var_0);

  foreach(var_2 in level.players)
  var_2 _meth_8627("earthquakezone1");

  if(isDefined(level._id_11CB._id_AC92))
    _func_352(level._id_11CB._id_AC92, var_0);

  if(isDefined(level._id_11CB._id_AC93))
    _func_352(level._id_11CB._id_AC93, var_0);

  if(isDefined(level._id_11CB._id_AC94))
    _func_352(level._id_11CB._id_AC94, var_0);

  if(isDefined(level._id_11CB._id_AC95))
    _func_352(level._id_11CB._id_AC95, var_0);

  level._id_11CB._id_AC92 = undefined;
  level._id_11CB._id_AC93 = undefined;
  level._id_11CB._id_AC94 = undefined;
  level._id_11CB._id_AC95 = undefined;
}

_id_AB03() {
  _id_0380::_id_288B("zmb_pap_button", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_button");
}

_id_AB02() {
  _id_0380::_id_288B("zmb_pap_begin", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_begin");
}

_id_AB09() {
  _id_0380::_id_288B("zmb_pap_fuse", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_begin");
}

_id_AB04() {
  _id_0380::_id_288B("zmb_pap_cage_up_1", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_cage_up_1");
}

_id_AB05() {
  _id_0380::_id_288B("zmb_pap_cage_up_2", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_cage_up_2");
}

_id_AB06() {
  _id_0380::_id_288B("zmb_pap_cage_up_3", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_cage_up_3");
}

_id_AB07() {
  _id_0380::_id_288B("zmb_pap_cage_up_4", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_cage_up_4");
}

_id_AB08() {
  _id_0380::_id_288B("zmb_pap_end", undefined, self);
  _id_0378::_id_8DC2("zmb_pap_end");
}

_id_2034(var_0) {
  if(1) {
    return;
  }
  switch (var_0) {
    case "button_pressed":
      var_1 = self;
      _id_0378::_id_7208("zm_ctcms_button_press", undefined, var_1.origin);
      break;
    case "cage_powerup":
      var_2 = self;
      _id_0378::_id_7208("zm_ctcms_cage_start", undefined, var_2.origin);
      var_3 = 1.0;
      level._id_11CB._id_8E55 = _id_0378::_id_7208("zm_ctcms_cage_elect_lp", undefined, var_2.origin, var_3);
      break;
    case "cage_stop":
      var_4 = 0.5;
      _func_352(level._id_11CB._id_8E55, var_4);
      break;
    case "fuse_blows":
      var_2 = self;
      var_4 = 0.5;
      _func_352(level._id_11CB._id_8E55, var_4);
      _id_0378::_id_7208("zm_ctcms_fuse", undefined, var_2.origin);
      _id_0366::_id_8E48(0);
      break;
    case "power_down_main":
      var_2 = self;
      _id_0378::_id_7208("zm_ctcms_gen_main_pwr_dwn", undefined, var_2.origin);
      break;
    case "switch_lights_off":
      var_5 = self;
      _id_0378::_id_7208("zm_ctcms_switch_lights_off", undefined, var_5.origin);
      break;
    case "red_lights_on":
      var_6 = self;
      _id_0378::_id_7207("stinger_round_start_hit", [var_6]);
      _id_0378::_id_7207("mus_stinger_lrg", [var_6]);
      _id_0378::_id_7208("zm_ctcms_zobmie_roar", undefined, var_6.origin);
      wait 0.25;
      _id_0366::_id_8E36(1);
      _id_0366::_id_8E48(1);
      break;
    case "power_up_secondary":
      var_2 = self;
      _id_0378::_id_7208("zm_ctcms_gen_2nd_pwr_up", undefined, var_2.origin);
      var_3 = 1.0;
      level._id_11CB._id_8E56 = _id_0378::_id_7208("zm_ctcms_gen_2nd_lp", undefined, var_2.origin, var_3);
      break;
    case "power_up_main":
      var_2 = self;
      var_4 = 3.0;
      _func_352(level._id_11CB._id_8E56, var_4);
      _id_0378::_id_7208("zm_ctcms_gen_main_pwr_up", undefined, var_2.origin);
      _id_0378::_id_7208("zm_ctcms_switch_lights_off", undefined, var_2.origin);
      break;
  }
}

_id_401C(var_0) {
  var_1 = self;

  switch (var_0) {
    case "stopped":
      break;
    case "starting":
      _id_046C::_id_8DA0("zmb_pwr_gen_01_start", var_1.origin);
      var_2 = _id_0380::_id_2889("zmb_pwr_gen_01_start", undefined, var_1.origin);
      wait 1;
      level._id_11CB._id_8E59 = _id_0380::_id_6842("zmb_pwr_gen_01_lp", undefined, var_1.origin, 1.0);
      break;
    case "running":
      break;
    case "stopping":
      _id_0380::_id_2889("zmb_pwr_gen_01_stop", undefined, var_1.origin);
      _id_0380::_id_6850(level._id_11CB._id_8E59, 1.0);
      level._id_11CB._id_8E59 = undefined;
      break;
  }
}

_id_AA38(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = self;

  if(isDefined(var_2) && !var_2)
    _id_0380::_id_2889("zmb_jupmscare_window_blowout", undefined, var_1);

  _id_0380::_id_2888("stinger_round_start_hit", var_3);
  _id_0366::_id_8E34("mus_stinger_lrg", var_3, 1.0, var_0);
  wait 0.1;
  var_0 _id_0366::_id_8E4B("jumpscare1");
}

_id_8A75(var_0, var_1) {
  var_2 = self;
  _id_0380::_id_2888("stinger_anvil_hit_short", var_2);
  _id_0366::_id_8E34("mus_stinger_lrg", var_2, 1.0, var_0);
  wait 0.1;
  var_0 _id_0366::_id_8E4B("jumpscare1");
  wait 0.2;
  _id_0380::_id_2889("zmb_jupmscare_sweage_grate_shake", undefined, var_1);
}

_id_3A11(var_0, var_1) {
  var_2 = self;
  _id_0380::_id_2888("stinger_round_start_hit", var_2);
  _id_0380::_id_2888("mus_stinger_lrg", var_2);
  var_3 = var_2.origin;
  _id_0380::_id_2889("zm_ctcms_zobmie_roar", undefined, var_3);
}

_id_3DB6(var_0) {
  var_1 = self;
  var_2 = self._id_3255;
  _id_0380::_id_2889("zvox_fol_zde_taunt", undefined, var_2.origin);
  _id_0380::_id_2889("zmb_jumpscare_fol_tube_stress", undefined, var_2.origin);
  _id_0380::_id_2889("zmb_jumpscare_fol_tube_pound", undefined, var_2.origin);
}

_id_3DB5() {
  var_0 = self;

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, self.origin) <= 1500)
      var_2 _meth_8626("follower_intro");
  }

  var_4 = _id_0380::_id_2889("zmb_follower_intro_main", undefined, var_0.origin);
  wait 0.96;
  var_5 = _id_0380::_id_2889("zmb_follower_script_duck", undefined, var_0.origin);
  wait 0.89;
  _id_0380::_stoplocalsound(var_5);
  var_5 = undefined;
  var_6 = _id_0380::_id_2889("zmb_follower_script_duck", undefined, var_0.origin);
  wait 1.0;
  _id_0380::_stoplocalsound(var_6);
  var_6 = undefined;
  wait 3.0;
  _id_0380::_stoplocalsound(var_4);
  var_4 = undefined;
}

_id_3DB4() {
  var_0 = self;
  wait 2.11;
  var_1 = _id_0380::_id_2889("zmb_follower_intro_door_slide", undefined, var_0.origin);
  wait 3.3;
  _id_0380::_stoplocalsound(var_1);
  var_1 = undefined;
  _id_0378::_id_8D18("follower_intro");
}

_id_AA02(var_0) {
  _id_0378::_id_8D14(_func_344("zmb_well_explosion_ignite"));
  thread _id_0380::_id_6842("zmb_well_explosion_ignite", undefined, var_0);
}

_id_AA01(var_0) {
  _id_0378::_id_8D14(_func_344("zmb_well_explosion"));
  _id_0380::_id_6842("zmb_well_explosion", undefined, var_0);
  var_1 = 4.0;
  var_2 = 8.0;
  var_3 = _id_0380::_id_6842("burning_well_lp", undefined, var_0, var_1);
  wait 5;
  _id_0380::_id_6850(var_3, var_2);
}

_id_AA03(var_0) {
  _id_046C::_id_8DA0("zmb_well_group_scream", var_0);
}

_id_806F() {
  _id_0380::_id_288B("zmb_blade_trap_up", undefined, self);
  _id_0380::_id_6846("zmb_blade_trap_lp", undefined, self, 0.2, undefined, 0.2);
  _id_0380::_id_6846("zmb_blade_trap_water_lp", undefined, self, 0.2, undefined, 0.2);
}

_id_8071() {
  level._id_11CB._id_8070 = _id_0380::_id_2889("zmb_blade_trap_dwn", undefined, self.origin);
}

_id_9CA9() {
  _id_0380::_id_2889("zmb_trap_electric_strt", undefined, self.origin);
  level._id_11CB._id_35AF = _id_0380::_id_6842("zmb_trap_electirc_lp", undefined, self.origin, 0.5);
}

_id_9CA8() {
  _id_0380::_id_6850(level._id_11CB._id_35AF, 0.5);
  level._id_11CB._id_35AF = undefined;
  _id_0380::_id_2889("zmb_trap_electric_end", undefined, self.origin);
}

_id_3787() {
  var_0 = self _meth_808F();
  playsoundatpos(var_0, "zmb_switch_on");
}

_id_3788(var_0, var_1) {
  var_2 = (0, 0, 0);
  playsoundatpos(var_2, "zmb_enigma_alarm");
}

_id_4BCF(var_0) {
  var_1 = var_0 _meth_808F();
  playsoundatpos(var_1, "zmb_hc_enigma_use");
}

_id_8034() {
  _id_0380::_id_2888("zmb_saltmine_door_powered", self);
}

_id_3F24(var_0) {
  level._id_11CB._id_8E58 = [];

  foreach(var_2 in var_0)
  level._id_11CB._id_8E58[level._id_11CB._id_8E58.size] = _id_0378::_id_7208("zmb_timer_tick", undefined, var_2._id_5F59.origin);
}

_id_3F25(var_0) {
  if(isDefined(level._id_11CB._id_8E58)) {
    foreach(var_2 in level._id_11CB._id_8E58)
    _func_352(var_2);
  }
}

_id_201E() {
  var_0 = (0, 0, 0);
  playsoundatpos(var_0, "zm_ctcms_gen_main_pwr_dwn");
}

_id_1304() {
  self _meth_8626("pneumo_tube_slide");
  _id_0380::_id_288B("zmb_pneumo_tube_main", self, self);
  wait 7.63;
  self _meth_8627("pneumo_tube_slide");
}

_id_12E4() {
  foreach(var_1 in level.players) {
    if(distance(var_1.origin, self.origin) <= 800)
      var_1 _meth_8626("claw_button_press");
  }

  _id_0380::_id_288B("zmb_claw_button_press", undefined, self);
  wait 10.0;
  _id_0378::_id_8D18("claw_button_press");
}

_id_232A(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 _meth_8626("shard_claw_movement");

  _id_0380::_id_288B("zmb_claw_move_start", undefined, var_0);

  if(isDefined(level._id_11CB._id_2328))
    _id_0380::_id_6850(level._id_11CB._id_2328);

  level._id_11CB._id_2328 = _id_0380::_id_6844("zmb_claw_move_lp", undefined, var_0, 0.25);

  if(!isDefined(var_1))
    level._id_11CB._id_2329 = _id_0380::_id_6844("zmb_claw_move_rattle_lp", undefined, var_0, 0.25);
}

_id_232B(var_0) {
  _id_0380::_id_6850(level._id_11CB._id_2328);

  if(isDefined(level._id_11CB._id_2329))
    _id_0380::_id_6850(level._id_11CB._id_2329);

  _id_0380::_id_288B("zmb_claw_move_stop", undefined, var_0);
  wait 3;
  _id_0378::_id_8D18("shard_claw_movement");
}

_id_8AD0() {
  if(!isDefined(level._id_11CB._id_8E57))
    level._id_11CB._id_8E57 = _id_0380::_id_6844("zmb_claw_stuck_lp", undefined, self, 0.1);

  _id_0380::_id_288B("zmb_claw_stuck_imp", undefined, self);
}

_id_255F() {
  var_0 = self;
  var_1 = _id_0380::_id_2889("zmb_compartment_door_open", undefined, var_0.origin);
}

_id_255E() {
  var_0 = self;
  var_1 = _id_0380::_id_2889("zmb_compartment_door_close", undefined, var_0.origin);
}

_id_1D98(var_0) {
  if(var_0 == "off") {
    foreach(var_2 in level.players) {
      var_2 _meth_8626("light_flicker_off_submix");

      if(var_2 maps\mp\mp_zombie_nest_ee_util::_id_7402())
        _id_0380::_id_2888("zmb_bunker_lights_off", var_2);
    }
  } else {
    foreach(var_2 in level.players) {
      if(var_2 maps\mp\mp_zombie_nest_ee_util::_id_7402())
        _id_0380::_id_2888("zmb_bunker_lights_on", var_2);
    }
  }
}

_id_253B(var_0) {
  _id_0380::_id_6842("claw_trapdoor_start_open", undefined, var_0);

  if(isDefined(level._id_11CB._id_232C))
    _id_0380::_id_6850(level._id_11CB._id_232C, 0.1);

  level._id_11CB._id_232C = _id_0380::_id_6842("claw_trapdoor_opening_lp", undefined, var_0);
}

_id_2539(var_0) {
  level._id_11CB._id_232D = _id_0380::_id_6842("claw_trapdoor_slider", undefined, var_0);
}

_id_2537(var_0) {
  _id_0380::_id_6850(level._id_11CB._id_232C, 0.2);
  level._id_11CB._id_232C = undefined;
  _id_0380::_id_6842("claw_trapdoor_closing", undefined, var_0);
}

_id_2536(var_0) {
  _id_0380::_id_6842("claw_trapdoor_closed", undefined, var_0);
  _id_0380::_id_6850(level._id_11CB._id_232D, 0.25);
  level._id_11CB._id_232D = undefined;
}

_id_253A(var_0) {
  _id_0380::_id_6842("claw_trapdoor_stall", undefined, var_0);
}

_id_2538(var_0) {
  _id_0380::_id_6850(level._id_11CB._id_8E57, 0.25);
  level._id_11CB._id_8E57 = undefined;
  _id_0380::_id_6842("claw_trapdoor_end_open", undefined, var_0);
  _id_0380::_id_6850(level._id_11CB._id_232C, 0.2);
  level._id_11CB._id_232C = undefined;
}

_id_3BF8(var_0) {
  _id_0380::_id_2889("zvox_fir_fireman_intro_scream", undefined, var_0);
}

_id_3BF3(var_0) {
  _id_0378::_id_8D18("fireman_intro_fire_off");
  var_1 = _id_0380::_id_6842("emt_fireman_fire_raging_lp", undefined, var_0);
  wait 15;
  _id_0380::_id_6850(var_1, 3);
}

_id_08A5(var_0) {
  foreach(var_2 in level.players) {
    if(distance(var_2.origin, var_0) <= 1000)
      var_2 thread _id_08A6(var_0);
  }
}

_id_08A6(var_0) {
  var_1 = self;
  var_2 = 15;
  var_1 _meth_8626("build_ww_submix");
  _id_0380::_id_2889("zmb_build_ww_transients", undefined, var_0);
  common_scripts\utility::waittill_notify_or_timeout("death", var_2);
  var_1 _meth_8627("build_ww_submix");
}

_id_ABF7() {}

_id_ABF8(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2);
  var_2 _meth_82B1(var_1, 1.9);
  wait 2;
  var_2 delete();
}

_id_ABF9(var_0) {
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_0);
}

_id_47CA(var_0) {
  _id_0366::_id_8E33(5);
  _id_046C::_id_8DA0("gl_brdg_lower_button", var_0.origin);
  _id_046C::_id_8DA0("gl_brdg_lower_belt", var_0.origin);
  var_1 = (-500, 2250, 1665);
  var_2 = 10;
  level._id_11CB._id_8E5D = _id_0378::_id_7208("zvox_gen_hord_lrg_snarl", undefined, var_1, var_2);
}

_id_22F6(var_0) {
  if(!isDefined(level._id_11CB._id_22F7))
    level._id_11CB._id_22F7 = [];

  for(var_1 = 0; var_1 < level._id_11CB._id_22F7.size; var_1++) {
    _id_0380::_id_6850(level._id_11CB._id_22F7[var_1], 3.0);
    level._id_11CB._id_22F7[var_1] = undefined;
  }

  if(var_0.size > 0) {
    _id_0378::_id_8DC2("\n____CIRCUIT MAP____");
    var_2 = _id_0380::_id_288B("circuit_map_led_on", undefined, self, 0);

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_3 + 1;
      _id_0378::_id_8DC2("Circuit " + var_4 + ":" + var_0[var_3]);
      var_5 = "circuit_map_circuit_tone_os_" + var_4 + "_" + var_0[var_3];
      var_2 = _id_0380::_id_288B(var_5, undefined, self, 0);
      var_5 = "circuit_map_circuit_tone_lp_" + var_4 + "_" + var_0[var_3];
      var_6 = _id_0380::_id_6844(var_5, undefined, self, 0.25);
      level._id_11CB._id_22F7[var_3] = var_6;
    }

    _id_0378::_id_8DC2("________________\n");
  }
}

_id_22F8(var_0, var_1) {
  var_2 = self;

  if(!isDefined(level._id_11CB._id_3F21))
    level._id_11CB._id_3F21 = [];

  _id_22F4(var_0);
  var_3 = _id_0380::_id_288B("fuse_color_switch", undefined, var_2);
  var_4 = var_0 + 1;
  var_5 = "circuit_map_circuit_tone_os_" + var_4 + "_" + var_1;
  var_3 = _id_0380::_id_288B(var_5, undefined, var_2);
  var_5 = "circuit_map_circuit_tone_lp_" + var_4 + "_" + var_1;
  var_6 = _id_0380::_id_6844(var_5, undefined, var_2, 0.25);
  level._id_11CB._id_3F21[var_0] = var_6;
}

_id_22F4(var_0) {
  var_1 = self;

  if(!isDefined(level._id_11CB._id_3F21))
    level._id_11CB._id_3F21 = [];

  if(isDefined(level._id_11CB._id_3F21[var_0])) {
    _id_0380::_id_6850(level._id_11CB._id_3F21[var_0], 0.5);
    level._id_11CB._id_3F21[var_0] = undefined;
  }
}

_id_3F20() {
  var_0 = _id_0380::_id_288B("fuse_color_switch_door_open", undefined, self);
}

_id_3F1F() {
  var_0 = _id_0380::_id_288B("fuse_color_switch_door_close", undefined, self);

  if(isDefined(level._id_11CB._id_3F21)) {
    var_1 = level._id_11CB._id_3F21.size;

    for(var_2 = 0; var_2 < var_1; var_2++) {
      if(isDefined(level._id_11CB._id_3F21[var_2])) {
        _id_0380::_id_6850(level._id_11CB._id_3F21[var_2], 1);
        level._id_11CB._id_3F21[var_2] = undefined;
      }
    }
  }
}

_id_A604() {
  level._id_11CB._id_A5FE = [];
  level._id_11CB._id_A5FF = [];
  level._id_11CB._id_A5F9 = [];
  var_0 = [];
  var_1 = 1.05946;
  var_2 = 12;

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_0[var_3] = 0.5 * _func_1E2(var_1, var_2);
    var_2 = var_2 - 1;
  }

  level._id_11CB._id_A5FD = var_0;
}

_id_A609(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_1345))
    var_1._id_1345 = 1;
  else {
    var_2 = "voice_of_god_tumbler";

    if(var_0 == 0)
      var_2 = var_2 + "_reset";
    else if(var_0 == 1)
      var_2 = var_2 + "_first";

    _id_0380::_id_6844(var_2, undefined, var_1, 0);
  }
}

_id_A606(var_0, var_1) {
  _id_0378::_id_8D64("voice_of_god_play");
  level._id_11CB._id_A5FB = self;
  thread _id_A5FA(level._id_11CB._id_A5FB.origin);
  thread voice_of_god_mix_begin();

  for(var_2 = 0; var_2 < 4; var_2++) {
    _id_0380::_id_6850(level._id_11CB._id_A5FE[var_2], 2.0);
    level._id_11CB._id_A5FE[var_2] = undefined;
    _id_0380::_id_6850(level._id_11CB._id_A5FF[var_2], 2.0);
    level._id_11CB._id_A5FF[var_2] = undefined;
  }

  if(var_1.size > 0) {
    _id_0378::_id_8DC2("\n____VOICE_OF_GOD_PLAY____");
    var_3 = _id_0380::_id_6844("voice_of_god_startup", undefined, level._id_11CB._id_A5FB, 0);
    wait 2.5;
    _id_0380::_id_6850(var_3, 1);
    _id_0380::_id_6844("voice_of_god_intro", undefined, level._id_11CB._id_A5FB, 0);
    _id_0380::_id_6844("voice_of_god_intro_delayed", undefined, level._id_11CB._id_A5FB, 0);
    level._id_11CB.vog_drone_lp = _id_0380::_id_6844("voice_of_god_intro_drone_lp", undefined, level._id_11CB._id_A5FB, 0);
    var_4 = 10.0;
    var_5 = 5.0;
    var_6 = 10.0;
    var_7 = "";
    var_8 = 0.2;
    var_9 = 0.1;
    level._id_11CB._id_A5FE = _id_A605(var_1, var_7, var_8, var_4, var_9);
    wait(var_4 - var_6);
    var_7 = "b";
    var_8 = 0;
    var_9 = 0.666;
    level._id_11CB._id_A5FF = _id_A605(var_1, var_7, var_8, var_6, var_9);
    var_10 = 16;
    _id_4950(var_10);
    _id_0378::_id_8DC2("________________\n");
  }
}

_id_4950(var_0) {
  wait(var_0);
  thread _id_A607();
}

_id_A605(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = [];

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = var_7 + 1;
    _id_0378::_id_8DC2("Tumbler Code " + var_8 + ":" + var_0[var_7]);
    var_9 = "voice_of_god_tone_lp_" + var_8 + var_1;
    var_10 = var_2;

    if(var_10 <= 0)
      var_10 = 0.01;

    var_11 = _id_0380::_id_6844(var_9, undefined, var_5, 0, var_10);
    var_12 = var_0[var_7];
    var_13 = level._id_11CB._id_A5FD[var_12];
    var_14 = 0;
    _id_0380::_id_684D(var_11, var_4, 0);
    var_6[var_7] = var_11;
    level._id_11CB._id_A5F9[var_7] = var_13;
  }

  waitframe();

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_15 = var_6[var_7];
    var_13 = level._id_11CB._id_A5F9[var_7];
    _id_0380::_id_684E(var_15, 1.0, var_3);
  }

  waitframe();

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_15 = var_6[var_7];
    var_13 = level._id_11CB._id_A5F9[var_7];
    _id_0380::_id_684D(var_15, 1.0, var_3);
  }

  return var_6;
}

_id_A607() {
  var_0 = 10;
  var_1 = 0.1;
  var_2 = 0.2;

  for(var_3 = 0; var_3 < 4; var_3++) {
    _id_0380::_id_6850(level._id_11CB._id_A5FE[var_3], var_2);
    _id_0380::_id_684E(level._id_11CB._id_A5FF[var_3], var_1, var_2);
  }

  var_4 = _id_0380::_id_6844("voice_of_god_shutdown", undefined, level._id_11CB._id_A5FB, 0);
  level._id_11CB._id_A5FB thread _id_A608(level._id_11CB._id_A5FF, level._id_11CB._id_A5F9, var_0);
  level._id_11CB._id_A5FE = undefined;
  level._id_11CB._id_A5FF = undefined;
  level._id_11CB._id_A5FB = undefined;
  wait 5;
  level._id_11CB._id_A5FC = 0;
}

_id_A608(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_0)) {
    return;
  }
  var_4 = 1.2;
  var_5 = 0.5;

  for(var_6 = 0; var_6 < 4; var_6++)
    _id_0380::_id_684D(var_0[var_6], var_4, var_5);

  _id_0380::_id_6850(level._id_11CB.vog_drone_lp, 0.1);
  _id_0380::_id_6844("voice_of_god_outro", undefined, level._id_11CB._id_A5FB, 0);
  _id_0380::_id_6844("voice_of_god_choir", undefined, level._id_11CB._id_A5FB, 4.0);
  thread voice_of_god_mix_end(8, 8);
  wait(var_5);
  var_4 = 0.125;
  var_5 = 4.0;

  for(var_6 = 0; var_6 < 4; var_6++) {
    _id_0380::_id_684D(var_0[var_6], var_4, var_5);
    _id_0380::_id_684E(var_0[var_6], 0, var_5);
  }

  wait(var_5);

  for(var_6 = 0; var_6 < 4; var_6++)
    _id_0380::_id_6850(var_0[var_6], var_2);
}

voice_of_god_mix_begin() {
  foreach(var_1 in level.players) {
    if(distance(var_1.origin, level._id_11CB._id_A5FB.origin) <= 2000) {
      var_1 _id_0366::_id_8E32(1);
      var_1.voice_of_god_music_stopped = 1;
      var_1 _meth_8626("voice_of_god");
      var_1 thread vog_do_earthshake();
    }
  }
}

vog_do_earthshake() {
  wait 3;
  self _meth_809F("grenade_rumble");
  _func_17F(0.2, 30, self.origin, 900, self);
}

voice_of_god_mix_end(var_0, var_1) {
  wait(var_0);

  foreach(var_3 in level.players) {
    var_3 _meth_8627("voice_of_god", var_1);

    if(isDefined(var_3.voice_of_god_music_stopped)) {
      if(_id_0366::snd_is_level_wave_active()) {
        var_3 _id_0366::_id_8DCF(var_3 _id_0366::_id_8D46());
        var_4 = 5.0;
        var_5 = 10.0;
        var_3 _id_0366::_id_8E31(var_3._id_071D._id_A97B, var_4, var_5);
      } else
        var_3 _id_0366::_id_AB0D();

      var_3.voice_of_god_music_stopped = undefined;
    }
  }
}

_id_A5FA(var_0) {
  var_1 = 1188;
  level._id_11CB._id_A5FC = 1;

  while(level._id_11CB._id_A5FC) {
    foreach(var_3 in level.players) {
      var_4 = distance(var_3.origin, var_0);

      if(level._id_11CB._id_A5FC && var_4 <= var_1) {
        var_3 _id_0366::_id_8E47(1.0);
        continue;
      }

      var_3 _id_0366::_id_8E09();
    }

    wait 1.0;
  }

  foreach(var_3 in level.players)
  var_3 _id_0366::_id_8E09();
}

_id_A603() {
  var_0 = self;
  _id_0380::_id_6844("voice_of_god_fail", undefined, var_0);
}

_id_7E8B() {
  level._id_11CB._id_7E8C = _id_0380::_id_6842("zmb_hand_of_god_off_lp", undefined, self.origin);
}

_id_089C() {
  var_0 = self;
  _id_0380::_id_6850(level._id_11CB._id_7E8C, 1);
  level._id_11CB._id_7E89 = _id_0380::_id_2889("zmb_hand_of_god_activate", undefined, var_0.origin);
  level._id_11CB._id_7E8A = _id_0380::_id_6842("zmb_hand_of_god_on_lp_1", undefined, var_0.origin, 2);
}

_id_0897() {
  var_0 = self;
  _id_0380::_id_6850(level._id_11CB._id_7E8C, 1);
  level._id_11CB._id_7E89 = _id_0380::_id_2889("zmb_hand_of_god_activate", undefined, var_0.origin);
  level._id_11CB._id_7E8A = _id_0380::_id_6842("zmb_hand_of_god_on_lp_2", undefined, var_0.origin, 2);
}

_id_9AC8() {
  level._id_11CB._id_8E5A = _id_0380::_id_6842("zmb_tower_alarm", undefined, self.origin);
}

_id_9AC9() {
  if(isDefined(level._id_11CB._id_8E5A)) {
    _id_0380::_id_6850(level._id_11CB._id_8E5A, 0.25);
    level._id_11CB._id_8E5A = undefined;
  }
}

_id_9B3A() {
  if(isDefined(level._id_11CB._id_8E5B)) {
    _id_0380::_id_6850(level._id_11CB._id_8E5B, 1);
    level._id_11CB._id_8E5B = undefined;
  }

  level._id_11CB._id_9B39 = _id_0380::_id_2889("zmb_tower_machine_destroyed", undefined, self.origin);
  wait 2;
  level._id_1336 = _id_0380::_id_2889("zmb_tower_machine_power_down", undefined, self.origin);
}

_id_9B38() {
  level._id_11CB._id_7EC1 = _id_0380::_id_2889("zmb_twr_rod_fail_imp", undefined, self.origin);
}

_id_9B3E() {
  level._id_11CB._id_5CC5 = _id_0380::_id_2889("zmb_twr_lvr_pull", undefined, self.origin);
}

_id_9B3D() {
  wait 1.5;
  level._id_11CB._id_8E5C = _id_0380::_id_288B("zmb_twr_rod_move_strt", undefined, self);
  wait 0.25;
  level._id_11CB._id_8E5B = _id_0380::_id_6844("zmb_twr_rod_move_lp", undefined, self, 0.25);
}

_id_9B3C() {
  if(isDefined(level._id_11CB._id_8E5B)) {
    _id_0380::_id_6850(level._id_11CB._id_8E5B, 0.25);
    level._id_11CB._id_8E5B = undefined;
  }

  _id_0380::_id_2889("zmb_twr_rod_move_end", undefined, self.origin);

  if(isDefined(level._id_11CB._id_9FD0)) {
    _id_0380::_id_6850(level._id_11CB._id_9FD0, 0.1);
    level._id_11CB._id_9FD0 = undefined;
  }

  if(isDefined(level._id_11CB._id_9FD1)) {
    _id_0380::_id_6850(level._id_11CB._id_9FD1, 0.1);
    level._id_11CB._id_9FD1 = undefined;
  }

  if(isDefined(level._id_11CB._id_9FD2)) {
    _id_0380::_id_6850(level._id_11CB._id_9FD2, 0.1);
    level._id_11CB._id_9FD2 = undefined;
  }

  if(isDefined(level._id_11CB._id_9FCE)) {
    _id_0380::_id_6850(level._id_11CB._id_9FCE);
    level._id_11CB._id_9FCE = undefined;
  }
}

_id_9B3F() {}

_id_9B3B(var_0, var_1) {
  if(var_0 <= var_1 && var_0 > var_1 * 0.75) {
    return;
  }
  if(var_0 <= var_1 * 0.75 && var_0 > var_1 * 0.5) {
    if(!isDefined(level._id_11CB._id_9FD0)) {
      level._id_11CB._id_9FCC = _id_0380::_id_2889("zmb_twr_lvr_explo_sml", undefined, self.origin);
      level._id_11CB._id_9FD0 = _id_0380::_id_6844("zmb_twr_rod_dmg_state1_lp", undefined, self, 0.1);
    }
  } else if(var_0 <= var_1 * 0.5 && var_0 > var_1 * 0.25) {
    if(!isDefined(level._id_11CB._id_9FD1)) {
      _id_0380::_id_6850(level._id_11CB._id_9FD0, 0.1);
      level._id_11CB._id_9FCB = _id_0380::_id_2889("zmb_twr_lvr_explo_med", undefined, self.origin);
      level._id_11CB._id_9FD1 = _id_0380::_id_6844("zmb_twr_rod_dmg_state2_lp", undefined, self, 0.1);
      level._id_11CB._id_9FD0 = undefined;
      wait 0.25;

      if(!isDefined(level._id_11CB._id_9FCE)) {
        level._id_11CB._id_9FCF = _id_0380::_id_2889("zmb_twr_lvr_fire_strt", undefined, self.origin);
        level._id_11CB._id_9FCE = _id_0380::_id_6842("zmb_twr_lvr_fire_lp", undefined, self.origin);
      }
    }
  } else if(var_0 <= var_1 * 0.25 && var_0 > 0) {
    if(!isDefined(level._id_11CB._id_9FD2)) {
      _id_0380::_id_6850(level._id_11CB._id_9FD1, 0.1);
      level._id_11CB._id_9FCB = _id_0380::_id_2889("zmb_twr_lvr_explo_med", undefined, self.origin);
      level._id_11CB._id_9FD2 = _id_0380::_id_6844("zmb_twr_rod_dmg_state3_lp", undefined, self, 0.1);
      level._id_11CB._id_9FD1 = undefined;
    }
  } else if(var_0 <= 0) {
    level._id_11CB._id_9FCA = _id_0380::_id_2889("zmb_twr_lvr_explo_lrg", undefined, self.origin);
    level._id_11CB._id_9FC9 = _id_0380::_id_2889("zmb_twr_rod_dmg_end", undefined, self.origin);

    if(isDefined(level._id_11CB._id_9FD0)) {
      _id_0380::_id_6850(level._id_11CB._id_9FD0, 0.1);
      level._id_11CB._id_9FD0 = undefined;
    }

    if(isDefined(level._id_11CB._id_9FD1)) {
      _id_0380::_id_6850(level._id_11CB._id_9FD1, 0.1);
      level._id_11CB._id_9FD1 = undefined;
    }

    if(isDefined(level._id_11CB._id_9FD2)) {
      _id_0380::_id_6850(level._id_11CB._id_9FD2, 0.1);
      level._id_11CB._id_9FD2 = undefined;
    }

    if(isDefined(level._id_11CB._id_9FCE)) {
      wait 5;
      level._id_11CB._id_9FCD = _id_0380::_id_2889("zmb_twr_lvr_fire_end", undefined, self.origin);
      _id_0380::_id_6850(level._id_11CB._id_9FCE, 0.25);
      level._id_11CB._id_9FCE = undefined;
    }
  } else {}
}

_id_9B4D(var_0) {
  if(isDefined(level._id_11CB._id_8E5B)) {
    _id_0380::_id_6850(level._id_11CB._id_8E5B, 0.25);
    level._id_11CB._id_8E5B = undefined;
  }

  _id_0380::_id_2889("zmb_twr_lightning_strike_lightning", undefined, self.origin);

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, self.origin) <= 2000)
      var_2 _meth_8626("tower_lightning_strike_submix");
  }
}

_id_9B4F() {
  foreach(var_1 in level.players)
  var_1 thread _id_9B50();
}

_id_9B50() {
  var_0 = 10;
  common_scripts\utility::waittill_notify_or_timeout("death", var_0);
  self _meth_8627("tower_lightning_strike_submix");
}

_id_12D7() {
  _id_0380::_id_6842("zmb_spinning_top_shot", undefined, self.origin);
}

_id_12D4() {
  _id_0380::_id_6842("zmb_spinning_top_shot_fall", undefined, self.origin);
}

_id_12D5() {
  var_0 = _id_0380::_id_6842("zmb_spinning_top_place", undefined, self.origin);
  wait 1.5;
  _id_0380::_id_6850(var_0, 0.05);
  var_0 = undefined;
}

_id_12D8() {
  var_0 = _id_0380::_id_6842("zmb_spinning_top_turn", undefined, self.origin);
  wait 1.0;
  _id_0380::_id_6850(var_0, 1.0);
  var_0 = undefined;
}

_id_12D3() {
  wait 0.15;
  _id_0380::_id_6844("zmb_spinning_top_drawer_open", undefined, self);
}

_id_12D6() {
  var_0 = _id_0380::_id_6844("zmb_spinning_top_record_grab", undefined, self);
  wait 2.0;
  _id_0380::_id_6850(var_0, 0.05);
  var_0 = undefined;
}

_id_134F() {
  var_0 = self;
  var_1 = _id_0380::_id_6844("zmb_wonder_weapon_coil_charge", undefined, var_0);
  wait 8.0;
  _id_0380::_id_6850(var_1);
  var_1 = undefined;
}

_id_9549() {
  level._id_11CB._id_9549 = _id_0380::_id_2889("zmb_hc_switch_hit", undefined, self.origin);
}

_id_A96F() {
  level._id_11CB._id_A96F = _id_0380::_id_2889("zmb_waterwheel_spin", undefined, self.origin);
}

_id_1BAB() {
  var_0 = self;
  level._id_11CB._id_1BAB = _id_0380::_id_2889("zmb_break_statue", undefined, var_0.origin);
}

_id_17A2() {
  var_0 = self;
  var_1 = undefined;
  var_2 = 2.0;
  var_3 = 1.0;
  var_4 = 5.0;
  wait 1;
  var_5 = spawn("script_origin", var_0.origin);
  var_5 _meth_8055(var_0, "tag_origin", (0, 0, -720), (0, 0, 0));
  var_6 = _id_0380::_id_6846("zmb_blimp_engine_lp", var_1, var_5, var_4, var_3, var_4);
  var_6 = _id_0380::_id_6846("zmb_blimp_engine_lfe_lp", var_1, var_5, var_4, var_3, var_4);
  var_0 thread _id_179E(var_5);
}

_id_179E(var_0) {
  self waittill("death");

  if(isDefined(var_0))
    var_0 delete();
}

_id_990B(var_0) {
  for(;;) {
    var_1 = distance(level.players[0].origin, var_0.origin);
    _id_0378::_id_8DC2("Disance: " + var_1);
    wait 1;
  }
}

_id_179D() {
  wait 0.75;
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_charge", self.origin);
}

_id_17A0() {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_shoot", self.origin);
  wait 0.3;

  if(isDefined(self))
    _id_046C::_id_8DA2("zmb_blimp_elec_turret_projectile", self);
}

_id_179F() {
  _id_046C::_id_8DA2("zmb_blimp_elec_turret_hit_plr", self);
}

_id_17A3() {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_explo", self.origin);
  wait 1.2;

  if(isDefined(self))
    _id_046C::_id_8DA2("zmb_blimp_elec_turret_fall", self);
}

_id_179B(var_0) {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_land", var_0.origin);
}

_id_17A1() {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_impact", self.origin);
}

_id_1633() {
  var_0 = self;
  _id_0380::_id_288B("zmb_blimp_elec_turret_shoot", undefined, var_0);
  _id_0380::_id_6846("zmb_blimp_battery_retract_lp", undefined, var_0, 0.2, undefined, 0.2);
}

_id_71C5(var_0, var_1) {
  if(isPlayer(var_1) && !isDefined(var_1._id_9AA9)) {
    var_2 = _func_0A4(1, 100);

    if(var_2 == 1) {
      _id_0378::_id_7208("mp_nest_tortured_scream", var_1, var_0);
      var_1._id_9AA9 = 1;
    }
  }
}

_id_80DF() {
  var_0 = _func_18E("scream_trigger_01", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);
    _id_71C5(var_0.origin, var_1);
    wait 1;
  }
}

_id_80E0() {
  var_0 = _func_18E("scream_trigger_02", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);
    _id_71C5(var_0.origin, var_1);
    wait 1;
  }
}

_id_80E1() {
  var_0 = _func_18E("scream_trigger_03", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);
    _id_71C5(var_0.origin, var_1);
    wait 1;
  }
}

_id_11F6() {
  var_0 = self;
  var_1 = _id_0380::_id_6844("zmb_claw_connection", undefined, var_0);
  wait 8.0;
  _id_0380::_id_6850(var_1, 0.5);
  var_1 = undefined;
}

_id_1302() {
  var_0 = self;
  wait 0.45;
  var_1 = _id_0380::_id_288B("zmb_med_forge_hydro_part01", undefined, var_0);
  var_2 = _id_0380::_id_288B("zmb_med_forge_propeller_part01", undefined, var_0);
  var_3 = _id_0380::_id_288B("zmb_med_forge_room_part01", undefined, var_0);
  wait 9.91;
  _id_0380::_stoplocalsound(var_1, 1.0);
  var_1 = undefined;
  _id_0380::_stoplocalsound(var_2, 1.0);
  var_2 = undefined;
  _id_0380::_stoplocalsound(var_3, 1.0);
  var_3 = undefined;
  var_4 = _id_0380::_id_288B("zmb_med_forge_hydro_part02", undefined, var_0);
  var_5 = _id_0380::_id_288B("zmb_med_forge_propeller_part02", undefined, var_0);
  var_6 = _id_0380::_id_288B("zmb_med_forge_room_part02", undefined, var_0);
  wait 9.94;
  _id_0380::_stoplocalsound(var_4, 1.0);
  var_4 = undefined;
  _id_0380::_stoplocalsound(var_5, 1.0);
  var_5 = undefined;
  _id_0380::_stoplocalsound(var_6, 1.0);
  var_6 = undefined;
  var_7 = _id_0380::_id_288B("zmb_med_forge_hydro_part03", undefined, var_0);
  var_8 = _id_0380::_id_288B("zmb_med_forge_hydro_trans_part03", undefined, var_0);
  var_9 = _id_0380::_id_288B("zmb_med_forge_propeller_part03", undefined, var_0);
  var_10 = _id_0380::_id_288B("zmb_med_forge_room_part03", undefined, var_0);
  wait 9.94;
  _id_0380::_stoplocalsound(var_7, 1.0);
  var_7 = undefined;
  _id_0380::_stoplocalsound(var_8, 1.0);
  var_8 = undefined;
  _id_0380::_stoplocalsound(var_9, 1.0);
  var_9 = undefined;
  _id_0380::_stoplocalsound(var_10, 1.0);
  var_10 = undefined;
  var_11 = _id_0380::_id_288B("zmb_med_forge_hydro_part04", undefined, var_0);
  var_12 = _id_0380::_id_288B("zmb_med_forge_steam_01", undefined, var_0);
  var_13 = _id_0380::_id_288B("zmb_med_forge_steam_02", undefined, var_0);
  var_14 = _id_0380::_id_2889("zmb_med_forge_blood_cough", undefined, (-644, -2406, 1305));
  var_15 = _id_0380::_id_288B("zmb_med_forge_room_part04", undefined, var_0);
  wait 9.94;
  _id_0380::_stoplocalsound(var_11, 1.0);
  var_11 = undefined;
  _id_0380::_stoplocalsound(var_12, 3.0);
  var_12 = undefined;
  _id_0380::_stoplocalsound(var_13, 3.0);
  var_13 = undefined;
  _id_0380::_stoplocalsound(var_14, 3.0);
  var_14 = undefined;
  _id_0380::_stoplocalsound(var_15, 1.0);
  var_15 = undefined;
  var_16 = _id_0380::_id_288B("zmb_med_forge_hydro_part05", undefined, var_0);
  var_17 = _id_0380::_id_288B("zmb_med_forge_hydro_trans_part05_a", undefined, var_0);
  var_18 = _id_0380::_id_288B("zmb_med_forge_hydro_trans_part05_b", undefined, var_0);
  var_19 = _id_0380::_id_288B("zmb_med_forge_room_part05", undefined, var_0);
  wait 9.87;
  _id_0380::_stoplocalsound(var_16, 1.0);
  var_16 = undefined;
  _id_0380::_stoplocalsound(var_17, 1.0);
  var_17 = undefined;
  _id_0380::_stoplocalsound(var_18, 1.0);
  var_18 = undefined;
  _id_0380::_stoplocalsound(var_19, 1.0);
  var_19 = undefined;
  var_20 = _id_0380::_id_288B("zmb_med_forge_hydro_part06", undefined, var_0);
  var_21 = _id_0380::_id_288B("zmb_med_forge_hydro_trans_part06", undefined, var_0);
  var_22 = _id_0380::_id_288B("zmb_med_forge_room_part06", undefined, var_0);
  wait 2.73;
  _id_0380::_stoplocalsound(var_20, 1.0);
  var_20 = undefined;
  _id_0380::_stoplocalsound(var_21, 1.0);
  var_21 = undefined;
  _id_0380::_stoplocalsound(var_22, 1.0);
  var_22 = undefined;
  var_23 = _id_0380::_id_288B("zmb_med_forge_room_end", undefined, var_0);
}

_id_1305() {
  var_0 = self;
  wait 0.45;
  var_1 = _id_0380::_id_288B("zmb_rnd_forge_engine_part01", undefined, var_0);
  var_2 = _id_0380::_id_288B("zmb_rnd_forge_pistons_part01", undefined, var_0);
  var_3 = _id_0380::_id_288B("zmb_rnd_forge_room_part01", undefined, var_0);
  wait 10.52;
  _id_0380::_stoplocalsound(var_1, 1.0);
  var_1 = undefined;
  _id_0380::_stoplocalsound(var_2, 1.0);
  var_2 = undefined;
  _id_0380::_stoplocalsound(var_3, 1.5);
  var_3 = undefined;
  var_4 = _id_0380::_id_288B("zmb_rnd_forge_engine_part02", undefined, var_0);
  var_5 = _id_0380::_id_288B("zmb_rnd_forge_pistons_part02", undefined, var_0);
  var_6 = _id_0380::_id_288B("zmb_rnd_forge_room_part02", undefined, var_0);
  wait 10.24;
  _id_0380::_stoplocalsound(var_4, 1.0);
  var_4 = undefined;
  _id_0380::_stoplocalsound(var_5, 1.0);
  var_5 = undefined;
  _id_0380::_stoplocalsound(var_6, 1.5);
  var_6 = undefined;
  var_7 = _id_0380::_id_288B("zmb_rnd_forge_engine_part03", undefined, var_0);
  var_8 = _id_0380::_id_288B("zmb_rnd_forge_pistons_part03", undefined, var_0);
  var_9 = _id_0380::_id_288B("zmb_rnd_forge_room_part03", undefined, var_0);
  wait 10.11;
  _id_0380::_stoplocalsound(var_7, 1.0);
  var_7 = undefined;
  _id_0380::_stoplocalsound(var_8, 1.0);
  var_8 = undefined;
  _id_0380::_stoplocalsound(var_9, 1.5);
  var_9 = undefined;
  var_10 = _id_0380::_id_288B("zmb_rnd_forge_engine_part04", undefined, var_0);
  var_11 = _id_0380::_id_288B("zmb_rnd_forge_pistons_part04", undefined, var_0);
  var_12 = _id_0380::_id_288B("zmb_rnd_forge_room_part04", undefined, var_0);
  wait 10.16;
  _id_0380::_stoplocalsound(var_10, 1.0);
  var_10 = undefined;
  _id_0380::_stoplocalsound(var_11, 1.0);
  var_11 = undefined;
  _id_0380::_stoplocalsound(var_12, 1.5);
  var_12 = undefined;
  var_13 = _id_0380::_id_288B("zmb_rnd_forge_chassis_end", undefined, var_0);
  wait 3.15;
  _id_0380::_stoplocalsound(var_13, 1.0);
  var_13 = undefined;
}

_id_9CA7(var_0) {
  var_1 = common_scripts\utility::_id_46B5("trap_elec_sfx", "targetname");
  var_2 = var_1.origin;
  var_3 = _id_0380::_id_6842("trap_elec_arc_lp", undefined, var_2);
  var_4 = _id_0380::_id_6842("trap_elec_crackle_lp", undefined, var_2);
  var_5 = _id_0380::_id_6842("trap_elec_pulse_lp", undefined, var_2);
  var_6 = _id_0380::_id_6842("trap_elec_hiss_lp", undefined, var_2);
  var_7 = _id_0380::_id_6842("trap_elec_hum_lp", undefined, var_2);
  var_8 = _id_0380::_id_6842("trap_elec_energy_lp", undefined, var_2);
  var_9 = 0;
  var_10 = undefined;

  while(var_9 < 20) {
    var_11 = _func_0A4(1, 2);

    if(var_11 == 1)
      var_10 = _id_0380::_id_2889("trap_elec_arc", undefined, var_2);

    var_9++;
    wait 1;
  }

  _id_0380::_id_6850(var_3);
  _id_0380::_id_6850(var_4);
  _id_0380::_id_6850(var_5);
  _id_0380::_id_6850(var_6);
  _id_0380::_id_6850(var_7);
  _id_0380::_id_6850(var_8);
  _id_0380::_stoplocalsound(var_10);
  _id_0380::_id_2889("trap_elec_stop", undefined, var_2);
}

_id_9C99(var_0) {
  _id_0380::_id_2889("wpn_betty_triggered", undefined, var_0);
}

_id_9C98(var_0) {
  _id_0380::_id_2889("wpn_betty_exp", undefined, var_0);
}

_id_A9FB(var_0) {
  var_1 = common_scripts\utility::_id_46B5("weathervane_sfx", "targetname");
  var_2 = var_1.origin;

  if(var_0 == "long")
    _id_0380::_id_2889("zmb_weathervane_squeak_long", undefined, var_2);
  else if(var_0 == "short")
    _id_0380::_id_2889("zmb_weathervane_squeak_short", undefined, var_2);
  else
    _id_0380::_id_2889("zmb_weathervane_squeak_struggle", undefined, var_2);
}

_id_9FE7() {
  var_0 = common_scripts\utility::_id_46B5("battery_deposit_sfx", "targetname");
  var_1 = var_0.origin;
  _id_0380::_id_2889("zmb_uberschnelle_place_altar", undefined, var_1);
}

_id_1632() {
  var_0 = self;
  var_1 = _id_0380::_id_2889("zmb_wonder_weapon_proj_zap", undefined, var_0.origin);
}

_id_7E55(var_0, var_1) {
  switch (var_1) {
    case 1:
      _id_0380::_id_288B("zmb_nst01_klau_meinmeineschwester", undefined, var_0);
      break;
    case 2:
      _id_0380::_id_288B("zmb_nst01_klau_whathaveyoudonewhathaveyo", undefined, var_0);
      break;
    case 3:
      break;
    case 4:
      _id_0380::_id_288B("zmb_nst01_klau_straubyouopenedthegatesof", undefined, var_0);
      break;
    case 5:
      break;
    case 6:
      _id_0380::_id_288B("zmb_nst01_klau_donotfollowmethereareothe", undefined, var_0);
      break;
    case 7:
      _id_0380::_id_288B("zmb_nst01_klau_keepfightingtheemperormus", undefined, var_0);
      break;
  }
}

_id_1806() {
  _id_0380::_id_288B("zmb_uber_reveal_door_blast", undefined, self);
}

_id_2A32(var_0) {
  level._id_11CB._id_2A31 = spawnStruct();
  level._id_11CB._id_2A31._id_37EB = [[0, 1], [1, 0.001]];
  level._id_11CB._id_2A31._id_37E9 = [[0, 0.001], [1, 1]];

  foreach(var_2 in level.players)
  var_2 _id_0366::_id_8E30(0, 2.0);

  var_4 = 0;
  var_5 = 0;
  var_6 = _id_0378::_id_8D73(var_4, 0, 1, level._id_11CB._id_2A31._id_37EB);
  level._id_11CB._id_2A31._id_8E54 = _id_0380::_id_288D("zmb_mus_darkwings_straight", undefined, var_0, var_5, var_6);
  var_6 = _id_0378::_id_8D73(var_4, 0, 1, level._id_11CB._id_2A31._id_37E9);
  level._id_11CB._id_2A31._id_8E53 = _id_0380::_id_288D("zmb_mus_darkwings_demented", undefined, var_0, var_5, var_6);
}

_id_2A34(var_0, var_1) {
  var_2 = _id_0378::_id_8D73(var_0, 0, 1, level._id_11CB._id_2A31._id_37EB);
  _id_0380::_id_2891(level._id_11CB._id_2A31._id_8E54, var_2, var_1);
  var_2 = _id_0378::_id_8D73(var_0, 0, 1, level._id_11CB._id_2A31._id_37E9);
  _id_0380::_id_2891(level._id_11CB._id_2A31._id_8E53, var_2, var_1);
}

_id_2A33() {
  var_0 = 1.5;
  _id_0380::_stoplocalsound(level._id_11CB._id_2A31._id_8E54, var_0);
  _id_0380::_stoplocalsound(level._id_11CB._id_2A31._id_8E53, var_0);

  foreach(var_2 in level.players)
  var_2 _id_0366::_id_8E30(1.0, 2.0);
}

_id_9226() {
  var_0 = self;

  if(!isDefined(level._id_11CB._id_4D75))
    level._id_11CB._id_4D75 = _id_0380::_id_6842("zmb_hilt_sphere_lp", undefined, var_0.origin);
}

_id_8B10() {
  var_0 = self.origin;

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, var_0) <= 1200)
      var_2 thread _id_6343(var_0);
  }
}

_id_6343(var_0) {
  var_1 = self;
  var_2 = 9;
  var_1 _meth_8626("shoot_chandelier");
  _id_0380::_id_2889("zmb_shoot_chandelier_main", undefined, var_0);
  var_1 common_scripts\utility::waittill_notify_or_timeout("death", var_2);
  self _meth_8627("shoot_chandelier");
}

_id_4D73() {
  _id_0380::_id_6850(level._id_11CB._id_4D75, 0.25);
  level._id_11CB._id_4D75 = undefined;
  _id_0380::_id_2889("zmb_hilt_destroy", undefined, self.origin);
}

_id_6FC3() {
  var_0 = _id_0380::_id_2888("zmb_pickup_raven_swrd");
}

_id_6BF4() {
  var_0 = self;
  _id_0380::_id_2889("zmb_raven_stone_open", undefined, var_0.origin);
}

_id_6854() {
  var_0 = _id_0380::_id_288B("zmb_nuke_explo", undefined, self);
}

_id_9CC8(var_0) {
  wait 0.3;
  var_1 = 1;
  var_2 = 0;

  while(var_1) {
    _id_0380::_id_2889("trap_spikes", undefined, var_0);

    if(var_2 < 19)
      var_2++;
    else
      var_1 = 0;

    wait 1;
  }
}

_id_1CC1() {
  foreach(var_1 in level.players)
  var_1 _meth_8626("brute_intro", 2.0);

  _id_0366::_id_8E33(3);
  _id_0380::_id_6840("zmb_mus_brute_intro");
}

_id_1CC2() {
  foreach(var_1 in level.players)
  var_1 _meth_8627("brute_intro", 0.1);
}