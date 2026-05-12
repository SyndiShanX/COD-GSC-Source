/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_01_aud.gsc
*********************************************/

func_00F9() {
  func_7BBA();
  func_526E();
}

func_7BBA() {
  lib_0378::func_8DC7("player_connect_map", ::func_7248);
  lib_0378::func_8DC7("player_spawned", ::func_7330);
  lib_0378::func_8DC7("wave_begin", ::func_A979);
  lib_0378::func_8DC7("wave_end", ::func_A97A);
  lib_0378::func_8DC7("enter_last_stand", ::func_37B4);
  lib_0378::func_8DC7("revive", ::func_7E51);
  lib_0378::func_8DC7("death", ::func_2A83);
  lib_0378::func_8DC7("end_respawn", ::func_36A1);
  lib_0378::func_8DC7("end_joined_spectators", ::func_3689);
  lib_0378::func_8DC7("play_blimp_dialog", ::func_70C5);
  lib_0378::func_8DC7("play_pa_dialog", ::func_716C);
  lib_0378::func_8DC7("stop_pa_dialog", ::func_93DE);
  lib_0378::func_8DC7("play_pa_music", ::func_716E);
  lib_0378::func_8DC7("gas_valve_state", ::func_3FE4);
  lib_0378::func_8DC7("zone1Earthquake", ::func_AC91);
  lib_0378::func_8DC7("zmb_pap_button", ::func_AB03);
  lib_0378::func_8DC7("zmb_pap_begin", ::func_AB02);
  lib_0378::func_8DC7("zmb_pap_fuse", ::func_AB09);
  lib_0378::func_8DC7("zmb_pap_cage_up_1", ::func_AB04);
  lib_0378::func_8DC7("zmb_pap_cage_up_2", ::func_AB05);
  lib_0378::func_8DC7("zmb_pap_cage_up_3", ::func_AB06);
  lib_0378::func_8DC7("zmb_pap_cage_up_4", ::func_AB07);
  lib_0378::func_8DC7("zmb_pap_end", ::func_AB08);
  lib_0378::func_8DC7("catacombs_scare", ::func_2034);
  lib_0378::func_8DC7("generator_power_switch_state", ::func_401C);
  lib_0378::func_8DC7("window_jumpscare", ::func_AA38);
  lib_0378::func_8DC7("sewage_jumpscare", ::func_8A75);
  lib_0378::func_8DC7("fall_jumpscare", ::func_3A11);
  lib_0378::func_8DC7("fol_tube_jumpscare_rattle", ::func_3DB6);
  lib_0378::func_8DC7("fol_tube_jumpscare_execute", ::func_3DB5);
  lib_0378::func_8DC7("fol_tube_jumpscare_door_fall", ::func_3DB4);
  lib_0378::func_8DC7("well_explosion_ignite", ::func_AA02);
  lib_0378::func_8DC7("well_explosion", ::func_AA01);
  lib_0378::func_8DC7("well_zombies_group_scream", ::func_AA03);
  lib_0378::func_8DC7("aud_saw_blade_sound", ::func_806F);
  lib_0378::func_8DC7("aud_saw_blade_end", ::func_8071);
  lib_0378::func_8DC7("aud_start_electricity", ::func_9CA9);
  lib_0378::func_8DC7("aud_stop_electricity", ::func_9CA8);
  lib_0378::func_8DC7("aud_enigma_switch_activate", ::func_3787);
  lib_0378::func_8DC7("aud_start_enigma_timer", ::func_3788);
  lib_0378::func_8DC7("aud_fuse_timer_start", ::func_3F24);
  lib_0378::func_8DC7("aud_fuse_timer_stop", ::func_3F25);
  lib_0378::func_8DC7("aud_hc_enigma_use", ::func_4BCF);
  lib_0378::func_8DC7("aud_saltmine_door_powered", ::func_8034);
  lib_0378::func_8DC7("aud_cart_lights_off", ::func_201E);
  lib_0378::func_8DC7("aud_start_pneumo_tube", ::func_1304);
  lib_0378::func_8DC7("aud_compartment_door_open", ::func_255F);
  lib_0378::func_8DC7("aud_compartment_door_close", ::func_255E);
  lib_0378::func_8DC7("aud_start_claw_button_press", ::func_12E4);
  lib_0378::func_8DC7("comm_room_claw_trapdoor_start_open", ::func_253B);
  lib_0378::func_8DC7("comm_room_claw_trapdoor_slider", ::func_2539);
  lib_0378::func_8DC7("comm_room_claw_trapdoor_closing", ::func_2537);
  lib_0378::func_8DC7("comm_room_claw_trapdoor_closed", ::func_2536);
  lib_0378::func_8DC7("comm_room_claw_trapdoor_stall", ::func_253A);
  lib_0378::func_8DC7("comm_room_claw_trapdoor_end_open", ::func_2538);
  lib_0378::func_8DC7("shard_room_claw_stuck_impact", ::func_8AD0);
  lib_0378::func_8DC7("circuit_map_reveal_machine_lights", ::func_22F6);
  lib_0378::func_8DC7("circuit_set_fuse_color_switch", ::func_22F8);
  lib_0378::func_8DC7("fuse_color_switch_door_open", ::func_3F20);
  lib_0378::func_8DC7("fuse_color_switch_door_close", ::func_3F1F);
  lib_0378::func_8DC7("voice_of_god_update_tumbler", ::func_A609);
  lib_0378::func_8DC7("voice_of_god_start", ::func_A606);
  lib_0378::func_8DC7("voice_of_god_fail", ::func_A603);
  lib_0378::func_8DC7("aud_right_hand_of_god_ready", ::func_7E8B);
  lib_0378::func_8DC7("aud_activate_right_hand_of_god", ::func_089C);
  lib_0378::func_8DC7("aud_activate_left_hand_of_god", ::func_0897);
  lib_0378::func_8DC7("aud_activate_workbench", ::func_08A5);
  lib_0378::func_8DC7("fireman_intro_scream", ::func_3BF8);
  lib_0378::func_8DC7("aud_zombie_soul_absorb", ::func_ABF7);
  lib_0378::func_8DC7("zombie_soul_suck", ::func_ABF8);
  lib_0378::func_8DC7("zombie_soul_suck_threshold", ::func_ABF9);
  lib_0378::func_8DC7("blimp_start", ::func_17A2);
  lib_0378::func_8DC7("blimp_charge", ::func_179D);
  lib_0378::func_8DC7("blimp_projectile", ::func_17A0);
  lib_0378::func_8DC7("blimp_hit_plr", ::func_179F);
  lib_0378::func_8DC7("blimp_turret_explode", ::func_17A3);
  lib_0378::func_8DC7("blimp_battery_land", ::func_179B);
  lib_0378::func_8DC7("blimp_projectile_impact", ::func_17A1);
  lib_0378::func_8DC7("aud_battery_retract", ::func_1633);
  lib_0378::func_8DC7("aud_claw_connection_forge", ::func_11F6);
  lib_0378::func_8DC7("aud_start_med_forge", ::func_1302);
  lib_0378::func_8DC7("aud_start_rnd_forge", ::func_1305);
  lib_0378::func_8DC7("aud_tower_alarm", ::func_9AC8);
  lib_0378::func_8DC7("aud_tower_alarm_stop", ::func_9AC9);
  lib_0378::func_8DC7("aud_tower_machine_dmg_state", ::func_9B3B);
  lib_0378::func_8DC7("aud_tower_machine_destroyed", ::func_9B3A);
  lib_0378::func_8DC7("aud_tower_machine_crash", ::func_9B38);
  lib_0378::func_8DC7("aud_tower_machine_use", ::func_9B3E);
  lib_0378::func_8DC7("aud_tower_machine_move_strt", ::func_9B3D);
  lib_0378::func_8DC7("aud_tower_machine_move_stop", ::func_9B3C);
  lib_0378::func_8DC7("aud_tower_machine_zombie_hit", ::func_9B3F);
  lib_0378::func_8DC7("aud_tower_shockwave", ::func_9B4D);
  lib_0378::func_8DC7("aud_tower_strike", ::func_9B4F);
  lib_0378::func_8DC7("aud_spinning_top_shot", ::func_12D7);
  lib_0378::func_8DC7("aud_spinning_top_fall", ::func_12D4);
  lib_0378::func_8DC7("aud_spinning_top_place", ::func_12D5);
  lib_0378::func_8DC7("aud_spinning_top_turn", ::func_12D8);
  lib_0378::func_8DC7("aud_spinning_top_drawer_open", ::func_12D3);
  lib_0378::func_8DC7("aud_spinning_top_record_obtained", ::func_12D6);
  lib_0378::func_8DC7("aud_wonder_weapon_elec_coil_charge", ::func_134F);
  lib_0378::func_8DC7("aud_switch_damaged", ::func_9549);
  lib_0378::func_8DC7("aud_waterwheel", ::func_A96F);
  lib_0378::func_8DC7("aud_break_statue", ::func_1BAB);
  lib_0378::func_8DC7("aud_trap_elec_start", ::func_9CA7);
  lib_0378::func_8DC7("aud_trap_betty_explo", ::func_9C98);
  lib_0378::func_8DC7("aud_trap_betty_triggered", ::func_9C99);
  lib_0378::func_8DC7("aud_trap_spikes", ::func_9CC8);
  lib_0378::func_8DC7("aud_weathervane_rotate", ::func_A9FB);
  lib_0378::func_8DC7("aud_uberschnelle_place_altar", ::func_9FE7);
  lib_0378::func_8DC7("aud_battery_electrocute", ::func_1632);
  lib_0378::func_8DC7("dark_wings_start", ::func_2A32);
  lib_0378::func_8DC7("dark_wings_update", ::func_2A34);
  lib_0378::func_8DC7("dark_wings_stop", ::func_2A33);
  lib_0378::func_8DC7("aud_claw_move_start", ::func_232A);
  lib_0378::func_8DC7("aud_claw_move_stop", ::func_232B);
  lib_0378::func_8DC7("aud_bunker_lights", ::func_1D98);
  lib_0378::func_8DC7("aud_start_hilt_sphere_sound", ::func_9226);
  lib_0378::func_8DC7("aud_shoot_chandelier", ::func_8B10);
  lib_0378::func_8DC7("aud_hilt_destroy", ::func_4D73);
  lib_0378::func_8DC7("aud_pickup_raven_sword", ::func_6FC3);
  lib_0378::func_8DC7("aud_open_raven_door", ::func_6BF4);
  lib_0378::func_8DC7("aud_nuke_explo", ::func_6854);
  lib_0378::func_8DC7("aud_revived_klaus_speak", ::func_7E55);
  lib_0378::func_8DC7("blow_open_uber_concealment_door", ::func_1806);
  lib_0378::func_8DC7("aud_fireman_fire_emitters", ::func_3BF3);
  lib_0378::func_8DC7("brute_intro_begin", ::func_1CC1);
  lib_0378::func_8DC7("brute_intro_end", ::func_1CC2);
}

func_526E() {
  func_5196();
  lib_0367::func_8E3E("nst01");
  func_A604();
  thread func_80DF();
  thread func_80E0();
  thread func_80E1();
}

func_5196() {
  var_00 = "conv_lightningtower";
  var_01 = [];
  var_01["primary"]["mari"] = ["lightningtower", 1];
  var_01["primary"]["jeff"] = ["lightningtower", 1];
  var_01["primary"]["oliv"] = ["lightningtower", 1];
  var_01["primary"]["dros"] = ["lightningtower", 1];
  var_01["secondary"]["dros"] = ["lightningtower_reply", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_hiltroomentrance";
  var_01 = [];
  var_01["primary"]["jeff"] = ["hiltroomentrance_both", 1];
  var_01["primary"]["dros"] = ["hiltroomentrance_both", 1];
  var_01["primary"]["mari"] = ["hiltroomentrance_both", 1];
  var_01["primary"]["oliv"] = ["hiltroomentrance_both", 1];
  var_01["secondary"]["jeff"] = ["hiltroomentrance_both", 1];
  var_01["secondary"]["dros"] = ["hiltroomentrance_both", 1];
  var_01["secondary"]["mari"] = ["hiltroomentrance_both", 1];
  var_01["secondary"]["oliv"] = ["hiltroomentrance_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_hiltlook";
  var_01 = [];
  var_01["primary"]["jeff"] = ["hiltlook_both", 1];
  var_01["primary"]["dros"] = ["hiltlook_both", 1];
  var_01["primary"]["mari"] = ["hiltlook_both", 1];
  var_01["primary"]["oliv"] = ["hiltlook_both", 1];
  var_01["secondary"]["jeff"] = ["hiltlook_both", 1];
  var_01["secondary"]["dros"] = ["hiltlook_both", 1];
  var_01["secondary"]["mari"] = ["hiltlook_both", 1];
  var_01["secondary"]["oliv"] = ["hiltlook_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_hiltshoot";
  var_01 = [];
  var_01["primary"]["jeff"] = ["hiltshoot1", 1];
  var_01["primary"]["dros"] = ["hiltshoot1", 1];
  var_01["primary"]["mari"] = ["hiltshoot1", 1];
  var_01["primary"]["oliv"] = ["hiltshoot1", 1];
  var_01["secondary"]["dros"] = ["hiltshoot1_reply", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_righthandaltarfinish";
  var_01 = [];
  var_01["primary"]["jeff"] = ["righthandaltarfinish_both", 1];
  var_01["primary"]["dros"] = ["righthandaltarfinish_both", 1];
  var_01["primary"]["mari"] = ["righthandaltarfinish_both", 1];
  var_01["primary"]["oliv"] = ["righthandaltarfinish_both", 1];
  var_01["secondary"]["jeff"] = ["righthandaltarfinish_both", 1];
  var_01["secondary"]["dros"] = ["righthandaltarfinish_both", 1];
  var_01["secondary"]["mari"] = ["righthandaltarfinish_both", 1];
  var_01["secondary"]["oliv"] = ["righthandaltarfinish_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_righthandaltarclue";
  var_01 = [];
  var_01["primary"]["jeff"] = ["righthandaltarclue_both", 1];
  var_01["primary"]["dros"] = ["righthandaltarclue_both", 1];
  var_01["primary"]["mari"] = ["righthandaltarclue_both", 1];
  var_01["primary"]["oliv"] = ["righthandaltarclue_both", 1];
  var_01["secondary"]["jeff"] = ["righthandaltarclue_both", 1];
  var_01["secondary"]["dros"] = ["righthandaltarclue_both", 1];
  var_01["secondary"]["mari"] = ["righthandaltarclue_both", 1];
  var_01["secondary"]["oliv"] = ["righthandaltarclue_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_zepreaction";
  var_01 = [];
  var_01["primary"]["jeff"] = ["zepreaction_both", 1];
  var_01["primary"]["dros"] = ["zepreaction_both", 1];
  var_01["primary"]["mari"] = ["zepreaction_both", 1];
  var_01["primary"]["oliv"] = ["zepreaction_both", 1];
  var_01["secondary"]["jeff"] = ["zepreaction_both", 1];
  var_01["secondary"]["dros"] = ["zepreaction_both", 1];
  var_01["secondary"]["mari"] = ["zepreaction_both", 1];
  var_01["secondary"]["oliv"] = ["zepreaction_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_wavedifficultyclue";
  var_01 = [];
  var_01["primary"]["jeff"] = ["wavedifficultyclue_both", 1];
  var_01["primary"]["dros"] = ["wavedifficultyclue_both", 1];
  var_01["primary"]["mari"] = ["wavedifficultyclue_both", 1];
  var_01["primary"]["oliv"] = ["wavedifficultyclue_both", 1];
  var_01["secondary"]["jeff"] = ["wavedifficultyclue_both", 1];
  var_01["secondary"]["dros"] = ["wavedifficultyclue_both", 1];
  var_01["secondary"]["mari"] = ["wavedifficultyclue_both", 1];
  var_01["secondary"]["oliv"] = ["wavedifficultyclue_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_juicerintro";
  var_01 = [];
  var_01["primary"]["dros"] = ["juicerintro_both", 1];
  var_01["primary"]["mari"] = ["juicerintro_both", 1];
  var_01["primary"]["oliv"] = ["juicerintro_both", 1];
  var_01["secondary"]["jeff"] = ["juicerintro_both", 1];
  var_01["secondary"]["dros"] = ["juicerintro_both", 1];
  var_01["secondary"]["mari"] = ["juicerintro_both", 1];
  var_01["secondary"]["oliv"] = ["juicerintro_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_klausroom";
  var_01 = [];
  var_01["primary"]["jeff"] = ["klausroom_both", 1];
  var_01["primary"]["dros"] = ["klausroom_both", 1];
  var_01["primary"]["mari"] = ["klausroom_both", 1];
  var_01["primary"]["oliv"] = ["klausroom_both", 1];
  var_01["secondary"]["jeff"] = ["klausroom_both", 1];
  var_01["secondary"]["dros"] = ["klausroom_both", 1];
  var_01["secondary"]["mari"] = ["klausroom_both", 1];
  var_01["secondary"]["oliv"] = ["klausroom_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_hiltrecovered";
  var_01 = [];
  var_01["primary"]["jeff"] = ["hiltrecovered_both", 1];
  var_01["primary"]["dros"] = ["hiltrecovered_both", 1];
  var_01["primary"]["mari"] = ["hiltrecovered_both", 1];
  var_01["primary"]["oliv"] = ["hiltrecovered_both", 1];
  var_01["secondary"]["jeff"] = ["hiltrecovered_both", 1];
  var_01["secondary"]["dros"] = ["hiltrecovered_both", 1];
  var_01["secondary"]["mari"] = ["hiltrecovered_both", 1];
  var_01["secondary"]["oliv"] = ["hiltrecovered_both", 1];
  lib_0367::func_8E38(var_00, var_01);
  var_00 = "conv_hiltroomcollapse";
  var_01 = [];
  var_01["primary"]["jeff"] = ["hiltroomcollapse", 1];
  var_01["primary"]["mari"] = ["hiltroomcollapse", 1];
  var_01["primary"]["oliv"] = ["hiltroomcollapse_both", 1];
  var_01["primary"]["dros"] = ["hiltroomcollapse_both", 1];
  var_01["secondary"]["dros"] = ["hiltroomcollapse_both", 1];
  var_01["secondary"]["oliv"] = ["hiltroomcollapse_both", 1];
  lib_0367::func_8E38(var_00, var_01);
}

func_8DEC() {
  var_00 = self;
  wait(0.5);
  var_01 = (3389, 2001, 1176);
  var_02 = (-2035, 2586, 1235);
  var_03 = (610, 1350, 1237);
  var_04 = (1196, 1198, 1237);
  var_05 = (610, 1000, 1237);
  var_06 = (570, 1268, 1235);
}

func_991B(param_00, param_01) {
  if(function_0344(param_00)) {
    for(;;) {
      maps\mp\_audio::func_8DA0(param_00, param_01);
      wait(2);
    }
  }
}

func_7248() {}

func_7330() {
  self method_8626("fireman_intro_fire_off");
  thread func_8E8F();
  lib_0366::snd_zmb_set_plr_vox_scare_count_max(1);
}

func_A979() {}

func_A97A() {}

func_37B4() {}

func_7E51() {}

func_2A83() {
  var_00 = 5;
  lib_0366::func_8E32(var_00);
}

func_36A1() {}

func_3689() {}

func_70C5(param_00, param_01) {
  if(common_scripts\utility::func_562E(level.var_943B.var_90C2)) {
    return;
  }

  lib_0380::func_288D(param_00, undefined, param_01, 0, 1, 3);
}

func_716C(param_00, param_01, param_02) {
  if(isDefined(param_02) && isarray(param_02)) {
    foreach(var_04 in level.var_744A) {
      var_04 thread func_8E8C(param_00, param_02, "exterior");
    }
  }
}

func_93DE() {
  foreach(var_01 in level.var_744A) {
    if(isDefined(var_01.var_071D.var_6DDA)) {
      lib_0380::func_6850(var_01.var_071D.var_6DDA, 0.25);
      var_01.var_071D.var_6DDA = undefined;
    }

    if(isDefined(var_01.var_071D.var_6DD9)) {
      lib_0380::func_6850(var_01.var_071D.var_6DD9, 0.25);
      var_01.var_071D.var_6DD9 = undefined;
    }

    if(isDefined(var_01.var_071D.var_6DDB)) {
      foreach(var_03 in var_01.var_071D.var_6DDB) {
        lib_0380::func_6850(var_03, 0.25);
      }

      var_01.var_071D.var_6DDB = [];
    }
  }
}

func_8E8C(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = 0.3;
  var_05 = undefined;
  var_06 = 1;
  var_07 = 1;
  if(!isDefined(var_03.var_071D.var_6DD8)) {
    var_03.var_071D.var_6DDB = [];
  }

  wait(randomintrange(1, 2));
  if(param_02 == "exterior") {
    var_05 = param_00 + "2";
    if(!function_0344(var_05)) {
      var_05 = param_00 + "_2";
      if(!function_0344(var_05)) {
        var_05 = undefined;
      }
    }
  }

  var_03.var_071D.var_6DD3 = [];
  for(var_08 = 0; var_08 < param_01.size; var_08++) {
    var_09 = param_01[var_08];
    var_0A = spawnStruct();
    var_0A.var_90BE = var_09;
    var_0A.var_3018 = distance(var_03.var_0116, var_09.var_0116);
    var_03.var_071D.var_6DD3[var_08] = var_0A;
  }

  var_0B = common_scripts\utility::func_7897(var_03.var_071D.var_6DD3, ::func_716D);
  if(isDefined(var_03.var_071D.var_6DDA)) {
    lib_0380::func_6850(var_03.var_071D.var_6DDA, 0.25);
    var_03.var_071D.var_6DDA = undefined;
  }

  var_03.var_071D.var_6DDA = lib_0380::func_6846(param_00, var_03, var_03, 0, 1);
  if(isDefined(var_03.var_071D.var_6DD9)) {
    lib_0380::func_6850(var_03.var_071D.var_6DD9, 0.25);
    var_03.var_071D.var_6DD9 = undefined;
  }

  if(isDefined(var_05)) {
    var_03.var_071D.var_6DD9 = lib_0380::func_6840(var_05, var_03, 0, 0.5);
  }

  foreach(var_0D in var_03.var_071D.var_6DDB) {
    lib_0380::func_6850(var_0D, 0.25);
  }

  var_03.var_071D.var_6DDB = [];
  var_0F = min(var_07, param_01.size);
  for(var_08 = 0; var_08 < var_0F; var_08++) {
    wait(var_04);
    var_09 = var_0B[var_08].var_90BE;
    var_06 = var_06 * 0.5;
    var_03.var_071D.var_6DDB[var_03.var_071D.var_6DDB.size] = lib_0380::func_6842(param_00 + "_delay", var_03, var_09.var_0116, 0, var_06);
  }
}

func_8E8F() {
  self endon("disconnect");
  var_00 = 0.5;
  var_01 = 1;
  var_02 = 1;
  for(;;) {
    var_03 = maps\mp\mp_zombie_nest_ee_util::func_740A();
    if(!isDefined(self)) {
      break;
    }

    if(var_03 != var_01) {
      if(var_03) {
        self method_8627("pa_inside", 1);
      } else {
        self method_8626("pa_inside", 1);
      }

      var_01 = var_03;
    }

    wait(var_00);
  }
}

func_716E(param_00) {
  var_01 = "zmb_wwii_march_music";
  if(!isDefined(param_00) || param_00.size <= 0) {
    return;
  }

  foreach(var_03 in level.var_744A) {
    lib_0380::func_2889(var_01, var_03, param_00[0].var_0116, 0, 1);
  }
}

func_716D(param_00, param_01) {
  return param_00.var_3018 <= param_01.var_3018;
}

func_3FE4(param_00, param_01) {
  var_02 = self;
  var_03 = var_02 getentitynumber();
  if(!isDefined(level.var_11CB.var_A28E)) {
    level.var_11CB.var_A28E = [];
  }

  var_04 = level.var_11CB.var_A28E[var_03];
  if(!isDefined(var_04)) {
    var_04 = spawnStruct();
    level.var_11CB.var_A28E[var_03] = var_04;
  }

  switch (param_00) {
    case "start_opening":
      if(param_01) {
        var_05 = var_02.var_0116 + (0, 0, 100);
        var_04.var_3FE3 = lib_0380::func_6842("zmb_valve_gas_flow_lp", undefined, var_05);
        lib_0380::func_684E(var_04.var_3FE3, 0, 0);
      }

      maps\mp\_audio::func_8DA0("zmb_valve_start_unlock", var_02.var_0116);
      break;

    case "opening":
      if(isDefined(var_04.var_9E98)) {
        stopclientsound(var_04.var_9E98, 0.1);
      }

      var_04.var_9E98 = playclientsound("zmb_valve_opening_lp", var_02, undefined, undefined, undefined, "hard");
      if(param_01) {
        lib_0380::func_684E(var_04.var_3FE3, 1, self.var_A29D);
      }
      break;

    case "closing":
      if(isDefined(var_04.var_9E98)) {
        stopclientsound(var_04.var_9E98, 0.1);
      }

      var_04.var_9E98 = playclientsound("zmb_valve_closing_lp", var_02, undefined, undefined, undefined, "hard");
      if(param_01) {
        lib_0380::func_684E(var_04.var_3FE3, 0, self.var_A29D);
      }
      break;

    case "open":
      maps\mp\_audio::func_8DA0("zmb_valve_open", var_02.var_0116);
      if(param_01) {
        lib_0380::func_684E(var_04.var_3FE3, 0.666, 2);
      }

      stopclientsound(var_04.var_9E98, 0.1);
      break;

    case "closed":
      maps\mp\_audio::func_8DA0("zmb_valve_stop_lock", var_02.var_0116);
      if(isDefined(var_04.var_9E98)) {
        stopclientsound(var_04.var_9E98, 0.1);
      }

      if(isDefined(var_04.var_3FE3)) {
        lib_0380::func_6850(var_04.var_3FE3, 0.1);
        var_04.var_3FE3 = undefined;
      }
      break;
  }
}

func_AC91(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    var_03 method_8626("earthquakezone1");
  }

  switch (param_00) {
    case "rumble1":
      if(!isDefined(level.var_11CB.var_AC92)) {
        var_05 = param_01;
        var_06 = 2.5;
        lib_0366::func_8E30(0.75, var_05);
        level.var_11CB.var_AC92 = lib_0378::func_7207("zone1Earthquake_phase1", undefined, var_05);
      }
      break;

    case "rumble2":
      if(!isDefined(level.var_11CB.var_AC93)) {
        var_05 = param_01;
        var_06 = 1;
        level.var_11CB.var_AC93 = lib_0378::func_7207("zone1Earthquake_phase2", undefined, var_05);
      }
      break;

    case "rumble3":
      if(!isDefined(level.var_11CB.var_AC94)) {
        var_05 = param_01;
        var_06 = 1;
        lib_0366::func_8E30(0.5, var_05);
        level.var_11CB.var_AC94 = lib_0378::func_7207("zone1Earthquake_phase3", undefined, var_05);
      }
      break;

    case "earthquake":
      if(!isDefined(level.var_11CB.var_AC95)) {
        var_05 = 0.25;
        var_06 = param_01 * 0.5 * 0.95;
        lib_0366::func_8E30(0.25, var_05);
        level.var_11CB.var_AC95 = lib_0378::func_7207("zone1Earthquake_phase4", undefined, var_05);
        wait(param_01 * 0.5);
        lib_0378::func_7207("zone1Earthquake_settle", undefined, var_05);
        func_AC96(var_06);
      }
      break;
  }
}

func_AC96(param_00) {
  lib_0366::func_8E30(1, param_00);
  foreach(var_02 in level.var_744A) {
    var_02 method_8627("earthquakezone1");
  }

  if(isDefined(level.var_11CB.var_AC92)) {
    stopclientsound(level.var_11CB.var_AC92, param_00);
  }

  if(isDefined(level.var_11CB.var_AC93)) {
    stopclientsound(level.var_11CB.var_AC93, param_00);
  }

  if(isDefined(level.var_11CB.var_AC94)) {
    stopclientsound(level.var_11CB.var_AC94, param_00);
  }

  if(isDefined(level.var_11CB.var_AC95)) {
    stopclientsound(level.var_11CB.var_AC95, param_00);
  }

  level.var_11CB.var_AC92 = undefined;
  level.var_11CB.var_AC93 = undefined;
  level.var_11CB.var_AC94 = undefined;
  level.var_11CB.var_AC95 = undefined;
}

func_AB03() {
  lib_0380::func_288B("zmb_pap_button", undefined, self);
  lib_0378::func_8DC2("zmb_pap_button");
}

func_AB02() {
  lib_0380::func_288B("zmb_pap_begin", undefined, self);
  lib_0378::func_8DC2("zmb_pap_begin");
}

func_AB09() {
  lib_0380::func_288B("zmb_pap_fuse", undefined, self);
  lib_0378::func_8DC2("zmb_pap_begin");
}

func_AB04() {
  lib_0380::func_288B("zmb_pap_cage_up_1", undefined, self);
  lib_0378::func_8DC2("zmb_pap_cage_up_1");
}

func_AB05() {
  lib_0380::func_288B("zmb_pap_cage_up_2", undefined, self);
  lib_0378::func_8DC2("zmb_pap_cage_up_2");
}

func_AB06() {
  lib_0380::func_288B("zmb_pap_cage_up_3", undefined, self);
  lib_0378::func_8DC2("zmb_pap_cage_up_3");
}

func_AB07() {
  lib_0380::func_288B("zmb_pap_cage_up_4", undefined, self);
  lib_0378::func_8DC2("zmb_pap_cage_up_4");
}

func_AB08() {
  lib_0380::func_288B("zmb_pap_end", undefined, self);
  lib_0378::func_8DC2("zmb_pap_end");
}

func_2034(param_00) {
  if(1) {
    return;
  }

  switch (param_00) {
    case "button_pressed":
      var_01 = self;
      lib_0378::func_7208("zm_ctcms_button_press", undefined, var_01.var_0116);
      break;

    case "cage_powerup":
      var_02 = self;
      lib_0378::func_7208("zm_ctcms_cage_start", undefined, var_02.var_0116);
      var_03 = 1;
      level.var_11CB.var_8E55 = lib_0378::func_7208("zm_ctcms_cage_elect_lp", undefined, var_02.var_0116, var_03);
      break;

    case "cage_stop":
      var_04 = 0.5;
      stopclientsound(level.var_11CB.var_8E55, var_04);
      break;

    case "fuse_blows":
      var_02 = self;
      var_04 = 0.5;
      stopclientsound(level.var_11CB.var_8E55, var_04);
      lib_0378::func_7208("zm_ctcms_fuse", undefined, var_02.var_0116);
      lib_0366::func_8E48(0);
      break;

    case "power_down_main":
      var_02 = self;
      lib_0378::func_7208("zm_ctcms_gen_main_pwr_dwn", undefined, var_02.var_0116);
      break;

    case "switch_lights_off":
      var_05 = self;
      lib_0378::func_7208("zm_ctcms_switch_lights_off", undefined, var_05.var_0116);
      break;

    case "red_lights_on":
      var_06 = self;
      lib_0378::func_7207("stinger_round_start_hit", [var_06]);
      lib_0378::func_7207("mus_stinger_lrg", [var_06]);
      lib_0378::func_7208("zm_ctcms_zobmie_roar", undefined, var_06.var_0116);
      wait(0.25);
      lib_0366::func_8E36(1);
      lib_0366::func_8E48(1);
      break;

    case "power_up_secondary":
      var_02 = self;
      lib_0378::func_7208("zm_ctcms_gen_2nd_pwr_up", undefined, var_02.var_0116);
      var_03 = 1;
      level.var_11CB.var_8E56 = lib_0378::func_7208("zm_ctcms_gen_2nd_lp", undefined, var_02.var_0116, var_03);
      break;

    case "power_up_main":
      var_02 = self;
      var_04 = 3;
      stopclientsound(level.var_11CB.var_8E56, var_04);
      lib_0378::func_7208("zm_ctcms_gen_main_pwr_up", undefined, var_02.var_0116);
      lib_0378::func_7208("zm_ctcms_switch_lights_off", undefined, var_02.var_0116);
      break;
  }
}

func_401C(param_00) {
  var_01 = self;
  switch (param_00) {
    case "stopped":
      break;

    case "starting":
      maps\mp\_audio::func_8DA0("zmb_pwr_gen_01_start", var_01.var_0116);
      var_02 = lib_0380::func_2889("zmb_pwr_gen_01_start", undefined, var_01.var_0116);
      wait(1);
      level.var_11CB.var_8E59 = lib_0380::func_6842("zmb_pwr_gen_01_lp", undefined, var_01.var_0116, 1);
      break;

    case "running":
      break;

    case "stopping":
      lib_0380::func_2889("zmb_pwr_gen_01_stop", undefined, var_01.var_0116);
      lib_0380::func_6850(level.var_11CB.var_8E59, 1);
      level.var_11CB.var_8E59 = undefined;
      break;
  }
}

func_AA38(param_00, param_01, param_02) {
  param_00 endon("death");
  var_03 = self;
  if(isDefined(param_02) && !param_02) {
    lib_0380::func_2889("zmb_jupmscare_window_blowout", undefined, param_01);
  }

  lib_0380::func_2888("stinger_round_start_hit", var_03);
  lib_0366::func_8E34("mus_stinger_lrg", var_03, 1, param_00);
  wait(0.1);
  param_00 lib_0366::func_8E4B("jumpscare1");
}

func_8A75(param_00, param_01) {
  var_02 = self;
  lib_0380::func_2888("stinger_anvil_hit_short", var_02);
  lib_0366::func_8E34("mus_stinger_lrg", var_02, 1, param_00);
  wait(0.1);
  param_00 lib_0366::func_8E4B("jumpscare1");
  wait(0.2);
  lib_0380::func_2889("zmb_jupmscare_sweage_grate_shake", undefined, param_01);
}

func_3A11(param_00, param_01) {
  var_02 = self;
  lib_0380::func_2888("stinger_round_start_hit", var_02);
  lib_0380::func_2888("mus_stinger_lrg", var_02);
  var_03 = var_02.var_0116;
  lib_0380::func_2889("zm_ctcms_zobmie_roar", undefined, var_03);
}

func_3DB6(param_00) {
  var_01 = self;
  var_02 = self.var_3255;
  lib_0380::func_2889("zvox_fol_zde_taunt", undefined, var_02.var_0116);
  lib_0380::func_2889("zmb_jumpscare_fol_tube_stress", undefined, var_02.var_0116);
  lib_0380::func_2889("zmb_jumpscare_fol_tube_pound", undefined, var_02.var_0116);
}

func_3DB5() {
  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(distance(var_02.var_0116, self.var_0116) <= 1500) {
      var_02 method_8626("follower_intro");
    }
  }

  var_04 = lib_0380::func_2889("zmb_follower_intro_main", undefined, var_00.var_0116);
  wait(0.96);
  var_05 = lib_0380::func_2889("zmb_follower_script_duck", undefined, var_00.var_0116);
  wait(0.89);
  lib_0380::func_2893(var_05);
  var_05 = undefined;
  var_06 = lib_0380::func_2889("zmb_follower_script_duck", undefined, var_00.var_0116);
  wait(1);
  lib_0380::func_2893(var_06);
  var_06 = undefined;
  wait(3);
  lib_0380::func_2893(var_04);
  var_04 = undefined;
}

func_3DB4() {
  var_00 = self;
  wait(2.11);
  var_01 = lib_0380::func_2889("zmb_follower_intro_door_slide", undefined, var_00.var_0116);
  wait(3.3);
  lib_0380::func_2893(var_01);
  var_01 = undefined;
  lib_0378::func_8D18("follower_intro");
}

func_AA02(param_00) {
  lib_0378::func_8D14(function_0344("zmb_well_explosion_ignite"));
  thread lib_0380::func_6842("zmb_well_explosion_ignite", undefined, param_00);
}

func_AA01(param_00) {
  lib_0378::func_8D14(function_0344("zmb_well_explosion"));
  lib_0380::func_6842("zmb_well_explosion", undefined, param_00);
  var_01 = 4;
  var_02 = 8;
  var_03 = lib_0380::func_6842("burning_well_lp", undefined, param_00, var_01);
  wait(5);
  lib_0380::func_6850(var_03, var_02);
}

func_AA03(param_00) {
  maps\mp\_audio::func_8DA0("zmb_well_group_scream", param_00);
}

func_806F() {
  lib_0380::func_288B("zmb_blade_trap_up", undefined, self);
  lib_0380::func_6846("zmb_blade_trap_lp", undefined, self, 0.2, undefined, 0.2);
  lib_0380::func_6846("zmb_blade_trap_water_lp", undefined, self, 0.2, undefined, 0.2);
}

func_8071() {
  level.var_11CB.var_8070 = lib_0380::func_2889("zmb_blade_trap_dwn", undefined, self.var_0116);
}

func_9CA9() {
  lib_0380::func_2889("zmb_trap_electric_strt", undefined, self.var_0116);
  level.var_11CB.var_35AF = lib_0380::func_6842("zmb_trap_electirc_lp", undefined, self.var_0116, 0.5);
}

func_9CA8() {
  lib_0380::func_6850(level.var_11CB.var_35AF, 0.5);
  level.var_11CB.var_35AF = undefined;
  lib_0380::func_2889("zmb_trap_electric_end", undefined, self.var_0116);
}

func_3787() {
  var_00 = self getorigin();
  playsoundatpos(var_00, "zmb_switch_on");
}

func_3788(param_00, param_01) {
  var_02 = (0, 0, 0);
  playsoundatpos(var_02, "zmb_enigma_alarm");
}

func_4BCF(param_00) {
  var_01 = param_00 getorigin();
  playsoundatpos(var_01, "zmb_hc_enigma_use");
}

func_8034() {
  lib_0380::func_2888("zmb_saltmine_door_powered", self);
}

func_3F24(param_00) {
  level.var_11CB.var_8E58 = [];
  foreach(var_02 in param_00) {
    level.var_11CB.var_8E58[level.var_11CB.var_8E58.size] = lib_0378::func_7208("zmb_timer_tick", undefined, var_02.var_5F59.var_0116);
  }
}

func_3F25(param_00) {
  if(isDefined(level.var_11CB.var_8E58)) {
    foreach(var_02 in level.var_11CB.var_8E58) {
      stopclientsound(var_02);
    }
  }
}

func_201E() {
  var_00 = (0, 0, 0);
  playsoundatpos(var_00, "zm_ctcms_gen_main_pwr_dwn");
}

func_1304() {
  self method_8626("pneumo_tube_slide");
  lib_0380::func_288B("zmb_pneumo_tube_main", self, self);
  wait(7.63);
  self method_8627("pneumo_tube_slide");
}

func_12E4() {
  foreach(var_01 in level.var_744A) {
    if(distance(var_01.var_0116, self.var_0116) <= 800) {
      var_01 method_8626("claw_button_press");
    }
  }

  lib_0380::func_288B("zmb_claw_button_press", undefined, self);
  wait(10);
  lib_0378::func_8D18("claw_button_press");
}

func_232A(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    var_03 method_8626("shard_claw_movement");
  }

  lib_0380::func_288B("zmb_claw_move_start", undefined, param_00);
  if(isDefined(level.var_11CB.var_2328)) {
    lib_0380::func_6850(level.var_11CB.var_2328);
  }

  level.var_11CB.var_2328 = lib_0380::func_6844("zmb_claw_move_lp", undefined, param_00, 0.25);
  if(!isDefined(param_01)) {
    level.var_11CB.var_2329 = lib_0380::func_6844("zmb_claw_move_rattle_lp", undefined, param_00, 0.25);
  }
}

func_232B(param_00) {
  lib_0380::func_6850(level.var_11CB.var_2328);
  if(isDefined(level.var_11CB.var_2329)) {
    lib_0380::func_6850(level.var_11CB.var_2329);
  }

  lib_0380::func_288B("zmb_claw_move_stop", undefined, param_00);
  wait(3);
  lib_0378::func_8D18("shard_claw_movement");
}

func_8AD0() {
  if(!isDefined(level.var_11CB.var_8E57)) {
    level.var_11CB.var_8E57 = lib_0380::func_6844("zmb_claw_stuck_lp", undefined, self, 0.1);
  }

  lib_0380::func_288B("zmb_claw_stuck_imp", undefined, self);
}

func_255F() {
  var_00 = self;
  var_01 = lib_0380::func_2889("zmb_compartment_door_open", undefined, var_00.var_0116);
}

func_255E() {
  var_00 = self;
  var_01 = lib_0380::func_2889("zmb_compartment_door_close", undefined, var_00.var_0116);
}

func_1D98(param_00) {
  if(param_00 == "off") {
    foreach(var_02 in level.var_744A) {
      var_02 method_8626("light_flicker_off_submix");
      if(var_02 maps\mp\mp_zombie_nest_ee_util::func_7402()) {
        lib_0380::func_2888("zmb_bunker_lights_off", var_02);
      }
    }

    return;
  }

  foreach(var_02 in level.var_744A) {
    if(var_02 maps\mp\mp_zombie_nest_ee_util::func_7402()) {
      lib_0380::func_2888("zmb_bunker_lights_on", var_02);
    }
  }
}

func_253B(param_00) {
  lib_0380::func_6842("claw_trapdoor_start_open", undefined, param_00);
  if(isDefined(level.var_11CB.var_232C)) {
    lib_0380::func_6850(level.var_11CB.var_232C, 0.1);
  }

  level.var_11CB.var_232C = lib_0380::func_6842("claw_trapdoor_opening_lp", undefined, param_00);
}

func_2539(param_00) {
  level.var_11CB.var_232D = lib_0380::func_6842("claw_trapdoor_slider", undefined, param_00);
}

func_2537(param_00) {
  lib_0380::func_6850(level.var_11CB.var_232C, 0.2);
  level.var_11CB.var_232C = undefined;
  lib_0380::func_6842("claw_trapdoor_closing", undefined, param_00);
}

func_2536(param_00) {
  lib_0380::func_6842("claw_trapdoor_closed", undefined, param_00);
  lib_0380::func_6850(level.var_11CB.var_232D, 0.25);
  level.var_11CB.var_232D = undefined;
}

func_253A(param_00) {
  lib_0380::func_6842("claw_trapdoor_stall", undefined, param_00);
}

func_2538(param_00) {
  lib_0380::func_6850(level.var_11CB.var_8E57, 0.25);
  level.var_11CB.var_8E57 = undefined;
  lib_0380::func_6842("claw_trapdoor_end_open", undefined, param_00);
  lib_0380::func_6850(level.var_11CB.var_232C, 0.2);
  level.var_11CB.var_232C = undefined;
}

func_3BF8(param_00) {
  lib_0380::func_2889("zvox_fir_fireman_intro_scream", undefined, param_00);
}

func_3BF3(param_00) {
  lib_0378::func_8D18("fireman_intro_fire_off");
  var_01 = lib_0380::func_6842("emt_fireman_fire_raging_lp", undefined, param_00);
  wait(15);
  lib_0380::func_6850(var_01, 3);
}

func_08A5(param_00) {
  foreach(var_02 in level.var_744A) {
    if(distance(var_02.var_0116, param_00) <= 1000) {
      var_02 thread func_08A6(param_00);
    }
  }
}

func_08A6(param_00) {
  var_01 = self;
  var_02 = 15;
  var_01 method_8626("build_ww_submix");
  lib_0380::func_2889("zmb_build_ww_transients", undefined, param_00);
  common_scripts\utility::func_A74B("death", var_02);
  var_01 method_8627("build_ww_submix");
}

func_ABF7() {}

func_ABF8(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02);
  var_02 moveto(param_01, 1.9);
  wait(2);
  var_02 delete();
}

func_ABF9(param_00) {
  lib_0380::func_2889("zombie_soul_suck_threshold", undefined, param_00);
}

func_47CA(param_00) {
  lib_0366::func_8E33(5);
  maps\mp\_audio::func_8DA0("gl_brdg_lower_button", param_00.var_0116);
  maps\mp\_audio::func_8DA0("gl_brdg_lower_belt", param_00.var_0116);
  var_01 = (-500, 2250, 1665);
  var_02 = 10;
  level.var_11CB.var_8E5D = lib_0378::func_7208("zvox_gen_hord_lrg_snarl", undefined, var_01, var_02);
}

func_22F6(param_00) {
  if(!isDefined(level.var_11CB.var_22F7)) {
    level.var_11CB.var_22F7 = [];
  }

  for(var_01 = 0; var_01 < level.var_11CB.var_22F7.size; var_01++) {
    lib_0380::func_6850(level.var_11CB.var_22F7[var_01], 3);
    level.var_11CB.var_22F7[var_01] = undefined;
  }

  if(param_00.size > 0) {
    lib_0378::func_8DC2("\n____CIRCUIT MAP____");
    var_02 = lib_0380::func_288B("circuit_map_led_on", undefined, self, 0);
    for(var_03 = 0; var_03 < param_00.size; var_03++) {
      var_04 = var_03 + 1;
      lib_0378::func_8DC2("Circuit " + var_04 + ":" + param_00[var_03]);
      var_05 = "circuit_map_circuit_tone_os_" + var_04 + "_" + param_00[var_03];
      var_02 = lib_0380::func_288B(var_05, undefined, self, 0);
      var_05 = "circuit_map_circuit_tone_lp_" + var_04 + "_" + param_00[var_03];
      var_06 = lib_0380::func_6844(var_05, undefined, self, 0.25);
      level.var_11CB.var_22F7[var_03] = var_06;
    }

    lib_0378::func_8DC2("________________\n");
  }
}

func_22F8(param_00, param_01) {
  var_02 = self;
  if(!isDefined(level.var_11CB.var_3F21)) {
    level.var_11CB.var_3F21 = [];
  }

  func_22F4(param_00);
  var_03 = lib_0380::func_288B("fuse_color_switch", undefined, var_02);
  var_04 = param_00 + 1;
  var_05 = "circuit_map_circuit_tone_os_" + var_04 + "_" + param_01;
  var_03 = lib_0380::func_288B(var_05, undefined, var_02);
  var_05 = "circuit_map_circuit_tone_lp_" + var_04 + "_" + param_01;
  var_06 = lib_0380::func_6844(var_05, undefined, var_02, 0.25);
  level.var_11CB.var_3F21[param_00] = var_06;
}

func_22F4(param_00) {
  var_01 = self;
  if(!isDefined(level.var_11CB.var_3F21)) {
    level.var_11CB.var_3F21 = [];
  }

  if(isDefined(level.var_11CB.var_3F21[param_00])) {
    lib_0380::func_6850(level.var_11CB.var_3F21[param_00], 0.5);
    level.var_11CB.var_3F21[param_00] = undefined;
  }
}

func_3F20() {
  var_00 = lib_0380::func_288B("fuse_color_switch_door_open", undefined, self);
}

func_3F1F() {
  var_00 = lib_0380::func_288B("fuse_color_switch_door_close", undefined, self);
  if(isDefined(level.var_11CB.var_3F21)) {
    var_01 = level.var_11CB.var_3F21.size;
    for(var_02 = 0; var_02 < var_01; var_02++) {
      if(isDefined(level.var_11CB.var_3F21[var_02])) {
        lib_0380::func_6850(level.var_11CB.var_3F21[var_02], 1);
        level.var_11CB.var_3F21[var_02] = undefined;
      }
    }
  }
}

func_A604() {
  level.var_11CB.var_A5FE = [];
  level.var_11CB.var_A5FF = [];
  level.var_11CB.var_A5F9 = [];
  var_00 = [];
  var_01 = 1.059463;
  var_02 = 12;
  for(var_03 = 0; var_03 < 5; var_03++) {
    var_00[var_03] = 0.5 * pow(var_01, var_02);
    var_02 = var_02 - 1;
  }

  level.var_11CB.var_A5FD = var_00;
}

func_A609(param_00) {
  var_01 = self;
  if(!isDefined(var_01.var_1345)) {
    var_01.var_1345 = 1;
    return;
  }

  var_02 = "voice_of_god_tumbler";
  if(param_00 == 0) {
    var_02 = var_02 + "_reset";
  } else if(param_00 == 1) {
    var_02 = var_02 + "_first";
  }

  lib_0380::func_6844(var_02, undefined, var_01, 0);
}

func_A606(param_00, param_01) {
  lib_0378::func_8D64("voice_of_god_play");
  level.var_11CB.var_A5FB = self;
  thread func_A5FA(level.var_11CB.var_A5FB.var_0116);
  thread voice_of_god_mix_begin();
  for(var_02 = 0; var_02 < 4; var_02++) {
    lib_0380::func_6850(level.var_11CB.var_A5FE[var_02], 2);
    level.var_11CB.var_A5FE[var_02] = undefined;
    lib_0380::func_6850(level.var_11CB.var_A5FF[var_02], 2);
    level.var_11CB.var_A5FF[var_02] = undefined;
  }

  if(param_01.size > 0) {
    lib_0378::func_8DC2("\n____VOICE_OF_GOD_PLAY____");
    var_03 = lib_0380::func_6844("voice_of_god_startup", undefined, level.var_11CB.var_A5FB, 0);
    wait(2.5);
    lib_0380::func_6850(var_03, 1);
    lib_0380::func_6844("voice_of_god_intro", undefined, level.var_11CB.var_A5FB, 0);
    lib_0380::func_6844("voice_of_god_intro_delayed", undefined, level.var_11CB.var_A5FB, 0);
    level.var_11CB.vog_drone_lp = lib_0380::func_6844("voice_of_god_intro_drone_lp", undefined, level.var_11CB.var_A5FB, 0);
    var_04 = 10;
    var_05 = 5;
    var_06 = 10;
    var_07 = "";
    var_08 = 0.2;
    var_09 = 0.1;
    level.var_11CB.var_A5FE = func_A605(param_01, var_07, var_08, var_04, var_09);
    wait(var_04 - var_06);
    var_07 = "b";
    var_08 = 0;
    var_09 = 0.666;
    level.var_11CB.var_A5FF = func_A605(param_01, var_07, var_08, var_06, var_09);
    var_0A = 16;
    func_4950(var_0A);
    lib_0378::func_8DC2("________________\n");
  }
}

func_4950(param_00) {
  wait(param_00);
  thread func_A607();
}

func_A605(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self;
  var_06 = [];
  for(var_07 = 0; var_07 < 4; var_07++) {
    var_08 = var_07 + 1;
    lib_0378::func_8DC2("Tumbler Code " + var_08 + ":" + param_00[var_07]);
    var_09 = "voice_of_god_tone_lp_" + var_08 + param_01;
    var_0A = param_02;
    if(var_0A <= 0) {
      var_0A = 0.01;
    }

    var_0B = lib_0380::func_6844(var_09, undefined, var_05, 0, var_0A);
    var_0C = param_00[var_07];
    var_0D = level.var_11CB.var_A5FD[var_0C];
    var_0E = 0;
    lib_0380::func_684D(var_0B, param_04, 0);
    var_06[var_07] = var_0B;
    level.var_11CB.var_A5F9[var_07] = var_0D;
  }

  wait 0.05;
  for(var_07 = 0; var_07 < 4; var_07++) {
    var_0F = var_06[var_07];
    var_0D = level.var_11CB.var_A5F9[var_07];
    lib_0380::func_684E(var_0F, 1, param_03);
  }

  wait 0.05;
  for(var_07 = 0; var_07 < 4; var_07++) {
    var_0F = var_06[var_07];
    var_0D = level.var_11CB.var_A5F9[var_07];
    lib_0380::func_684D(var_0F, 1, param_03);
  }

  return var_06;
}

func_A607() {
  var_00 = 10;
  var_01 = 0.1;
  var_02 = 0.2;
  for(var_03 = 0; var_03 < 4; var_03++) {
    lib_0380::func_6850(level.var_11CB.var_A5FE[var_03], var_02);
    lib_0380::func_684E(level.var_11CB.var_A5FF[var_03], var_01, var_02);
  }

  var_04 = lib_0380::func_6844("voice_of_god_shutdown", undefined, level.var_11CB.var_A5FB, 0);
  level.var_11CB.var_A5FB thread func_A608(level.var_11CB.var_A5FF, level.var_11CB.var_A5F9, var_00);
  level.var_11CB.var_A5FE = undefined;
  level.var_11CB.var_A5FF = undefined;
  level.var_11CB.var_A5FB = undefined;
  wait(5);
  level.var_11CB.var_A5FC = 0;
}

func_A608(param_00, param_01, param_02) {
  var_03 = self;
  if(!isDefined(param_00)) {
    return;
  }

  var_04 = 1.2;
  var_05 = 0.5;
  for(var_06 = 0; var_06 < 4; var_06++) {
    lib_0380::func_684D(param_00[var_06], var_04, var_05);
  }

  lib_0380::func_6850(level.var_11CB.vog_drone_lp, 0.1);
  lib_0380::func_6844("voice_of_god_outro", undefined, level.var_11CB.var_A5FB, 0);
  lib_0380::func_6844("voice_of_god_choir", undefined, level.var_11CB.var_A5FB, 4);
  thread voice_of_god_mix_end(8, 8);
  wait(var_05);
  var_04 = 0.125;
  var_05 = 4;
  for(var_06 = 0; var_06 < 4; var_06++) {
    lib_0380::func_684D(param_00[var_06], var_04, var_05);
    lib_0380::func_684E(param_00[var_06], 0, var_05);
  }

  wait(var_05);
  for(var_06 = 0; var_06 < 4; var_06++) {
    lib_0380::func_6850(param_00[var_06], param_02);
  }
}

voice_of_god_mix_begin() {
  foreach(var_01 in level.var_744A) {
    if(distance(var_01.var_0116, level.var_11CB.var_A5FB.var_0116) <= 2000) {
      var_01 lib_0366::func_8E32(1);
      var_01.voice_of_god_music_stopped = 1;
      var_01 method_8626("voice_of_god");
      var_01 thread vog_do_earthshake();
    }
  }
}

vog_do_earthshake() {
  wait(3);
  self playrumbleonentity("grenade_rumble");
  earthquake(0.2, 30, self.var_0116, 900, self);
}

voice_of_god_mix_end(param_00, param_01) {
  wait(param_00);
  foreach(var_03 in level.var_744A) {
    var_03 method_8627("voice_of_god", param_01);
    if(isDefined(var_03.voice_of_god_music_stopped)) {
      if(lib_0366::snd_is_level_wave_active()) {
        var_03 lib_0366::func_8DCF(var_03 lib_0366::func_8D46());
        var_04 = 5;
        var_05 = 10;
        var_03 lib_0366::func_8E31(var_03.var_071D.var_A97B, var_04, var_05);
      } else {
        var_03 lib_0366::func_AB0D();
      }

      var_03.voice_of_god_music_stopped = undefined;
    }
  }
}

func_A5FA(param_00) {
  var_01 = 1188;
  level.var_11CB.var_A5FC = 1;
  while(level.var_11CB.var_A5FC) {
    foreach(var_03 in level.var_744A) {
      var_04 = distance(var_03.var_0116, param_00);
      if(level.var_11CB.var_A5FC && var_04 <= var_01) {
        var_03 lib_0366::func_8E47(1);
        continue;
      }

      var_03 lib_0366::func_8E09();
    }

    wait(1);
  }

  foreach(var_03 in level.var_744A) {
    var_03 lib_0366::func_8E09();
  }
}

func_A603() {
  var_00 = self;
  lib_0380::func_6844("voice_of_god_fail", undefined, var_00);
}

func_7E8B() {
  level.var_11CB.var_7E8C = lib_0380::func_6842("zmb_hand_of_god_off_lp", undefined, self.var_0116);
}

func_089C() {
  var_00 = self;
  lib_0380::func_6850(level.var_11CB.var_7E8C, 1);
  level.var_11CB.var_7E89 = lib_0380::func_2889("zmb_hand_of_god_activate", undefined, var_00.var_0116);
  level.var_11CB.var_7E8A = lib_0380::func_6842("zmb_hand_of_god_on_lp_1", undefined, var_00.var_0116, 2);
}

func_0897() {
  var_00 = self;
  lib_0380::func_6850(level.var_11CB.var_7E8C, 1);
  level.var_11CB.var_7E89 = lib_0380::func_2889("zmb_hand_of_god_activate", undefined, var_00.var_0116);
  level.var_11CB.var_7E8A = lib_0380::func_6842("zmb_hand_of_god_on_lp_2", undefined, var_00.var_0116, 2);
}

func_9AC8() {
  level.var_11CB.var_8E5A = lib_0380::func_6842("zmb_tower_alarm", undefined, self.var_0116);
}

func_9AC9() {
  if(isDefined(level.var_11CB.var_8E5A)) {
    lib_0380::func_6850(level.var_11CB.var_8E5A, 0.25);
    level.var_11CB.var_8E5A = undefined;
  }
}

func_9B3A() {
  if(isDefined(level.var_11CB.var_8E5B)) {
    lib_0380::func_6850(level.var_11CB.var_8E5B, 1);
    level.var_11CB.var_8E5B = undefined;
  }

  level.var_11CB.var_9B39 = lib_0380::func_2889("zmb_tower_machine_destroyed", undefined, self.var_0116);
  wait(2);
  level.var_1336 = lib_0380::func_2889("zmb_tower_machine_power_down", undefined, self.var_0116);
}

func_9B38() {
  level.var_11CB.var_7EC1 = lib_0380::func_2889("zmb_twr_rod_fail_imp", undefined, self.var_0116);
}

func_9B3E() {
  level.var_11CB.var_5CC5 = lib_0380::func_2889("zmb_twr_lvr_pull", undefined, self.var_0116);
}

func_9B3D() {
  wait(1.5);
  level.var_11CB.var_8E5C = lib_0380::func_288B("zmb_twr_rod_move_strt", undefined, self);
  wait(0.25);
  level.var_11CB.var_8E5B = lib_0380::func_6844("zmb_twr_rod_move_lp", undefined, self, 0.25);
}

func_9B3C() {
  if(isDefined(level.var_11CB.var_8E5B)) {
    lib_0380::func_6850(level.var_11CB.var_8E5B, 0.25);
    level.var_11CB.var_8E5B = undefined;
  }

  lib_0380::func_2889("zmb_twr_rod_move_end", undefined, self.var_0116);
  if(isDefined(level.var_11CB.var_9FD0)) {
    lib_0380::func_6850(level.var_11CB.var_9FD0, 0.1);
    level.var_11CB.var_9FD0 = undefined;
  }

  if(isDefined(level.var_11CB.var_9FD1)) {
    lib_0380::func_6850(level.var_11CB.var_9FD1, 0.1);
    level.var_11CB.var_9FD1 = undefined;
  }

  if(isDefined(level.var_11CB.var_9FD2)) {
    lib_0380::func_6850(level.var_11CB.var_9FD2, 0.1);
    level.var_11CB.var_9FD2 = undefined;
  }

  if(isDefined(level.var_11CB.var_9FCE)) {
    lib_0380::func_6850(level.var_11CB.var_9FCE);
    level.var_11CB.var_9FCE = undefined;
  }
}

func_9B3F() {}

func_9B3B(param_00, param_01) {
  if(param_00 <= param_01 && param_00 > param_01 * 0.75) {
    return;
  }

  if(param_00 <= param_01 * 0.75 && param_00 > param_01 * 0.5) {
    if(!isDefined(level.var_11CB.var_9FD0)) {
      level.var_11CB.var_9FCC = lib_0380::func_2889("zmb_twr_lvr_explo_sml", undefined, self.var_0116);
      level.var_11CB.var_9FD0 = lib_0380::func_6844("zmb_twr_rod_dmg_state1_lp", undefined, self, 0.1);
      return;
    }

    return;
  }

  if(param_00 <= param_01 * 0.5 && param_00 > param_01 * 0.25) {
    if(!isDefined(level.var_11CB.var_9FD1)) {
      lib_0380::func_6850(level.var_11CB.var_9FD0, 0.1);
      level.var_11CB.var_9FCB = lib_0380::func_2889("zmb_twr_lvr_explo_med", undefined, self.var_0116);
      level.var_11CB.var_9FD1 = lib_0380::func_6844("zmb_twr_rod_dmg_state2_lp", undefined, self, 0.1);
      level.var_11CB.var_9FD0 = undefined;
      wait(0.25);
      if(!isDefined(level.var_11CB.var_9FCE)) {
        level.var_11CB.var_9FCF = lib_0380::func_2889("zmb_twr_lvr_fire_strt", undefined, self.var_0116);
        level.var_11CB.var_9FCE = lib_0380::func_6842("zmb_twr_lvr_fire_lp", undefined, self.var_0116);
        return;
      }

      return;
    }

    return;
  }

  if(param_00 <= param_01 * 0.25 && param_00 > 0) {
    if(!isDefined(level.var_11CB.var_9FD2)) {
      lib_0380::func_6850(level.var_11CB.var_9FD1, 0.1);
      level.var_11CB.var_9FCB = lib_0380::func_2889("zmb_twr_lvr_explo_med", undefined, self.var_0116);
      level.var_11CB.var_9FD2 = lib_0380::func_6844("zmb_twr_rod_dmg_state3_lp", undefined, self, 0.1);
      level.var_11CB.var_9FD1 = undefined;
      return;
    }

    return;
  }

  if(param_00 <= 0) {
    level.var_11CB.var_9FCA = lib_0380::func_2889("zmb_twr_lvr_explo_lrg", undefined, self.var_0116);
    level.var_11CB.var_9FC9 = lib_0380::func_2889("zmb_twr_rod_dmg_end", undefined, self.var_0116);
    if(isDefined(level.var_11CB.var_9FD0)) {
      lib_0380::func_6850(level.var_11CB.var_9FD0, 0.1);
      level.var_11CB.var_9FD0 = undefined;
    }

    if(isDefined(level.var_11CB.var_9FD1)) {
      lib_0380::func_6850(level.var_11CB.var_9FD1, 0.1);
      level.var_11CB.var_9FD1 = undefined;
    }

    if(isDefined(level.var_11CB.var_9FD2)) {
      lib_0380::func_6850(level.var_11CB.var_9FD2, 0.1);
      level.var_11CB.var_9FD2 = undefined;
    }

    if(isDefined(level.var_11CB.var_9FCE)) {
      wait(5);
      level.var_11CB.var_9FCD = lib_0380::func_2889("zmb_twr_lvr_fire_end", undefined, self.var_0116);
      lib_0380::func_6850(level.var_11CB.var_9FCE, 0.25);
      level.var_11CB.var_9FCE = undefined;
      return;
    }

    return;
  }
}

func_9B4D(param_00) {
  if(isDefined(level.var_11CB.var_8E5B)) {
    lib_0380::func_6850(level.var_11CB.var_8E5B, 0.25);
    level.var_11CB.var_8E5B = undefined;
  }

  lib_0380::func_2889("zmb_twr_lightning_strike_lightning", undefined, self.var_0116);
  foreach(var_02 in level.var_744A) {
    if(distance(var_02.var_0116, self.var_0116) <= 2000) {
      var_02 method_8626("tower_lightning_strike_submix");
    }
  }
}

func_9B4F() {
  foreach(var_01 in level.var_744A) {
    var_01 thread func_9B50();
  }
}

func_9B50() {
  var_00 = 10;
  common_scripts\utility::func_A74B("death", var_00);
  self method_8627("tower_lightning_strike_submix");
}

func_12D7() {
  lib_0380::func_6842("zmb_spinning_top_shot", undefined, self.var_0116);
}

func_12D4() {
  lib_0380::func_6842("zmb_spinning_top_shot_fall", undefined, self.var_0116);
}

func_12D5() {
  var_00 = lib_0380::func_6842("zmb_spinning_top_place", undefined, self.var_0116);
  wait(1.5);
  lib_0380::func_6850(var_00, 0.05);
  var_00 = undefined;
}

func_12D8() {
  var_00 = lib_0380::func_6842("zmb_spinning_top_turn", undefined, self.var_0116);
  wait(1);
  lib_0380::func_6850(var_00, 1);
  var_00 = undefined;
}

func_12D3() {
  wait(0.15);
  lib_0380::func_6844("zmb_spinning_top_drawer_open", undefined, self);
}

func_12D6() {
  var_00 = lib_0380::func_6844("zmb_spinning_top_record_grab", undefined, self);
  wait(2);
  lib_0380::func_6850(var_00, 0.05);
  var_00 = undefined;
}

func_134F() {
  var_00 = self;
  var_01 = lib_0380::func_6844("zmb_wonder_weapon_coil_charge", undefined, var_00);
  wait(8);
  lib_0380::func_6850(var_01);
  var_01 = undefined;
}

func_9549() {
  level.var_11CB.var_9549 = lib_0380::func_2889("zmb_hc_switch_hit", undefined, self.var_0116);
}

func_A96F() {
  level.var_11CB.var_A96F = lib_0380::func_2889("zmb_waterwheel_spin", undefined, self.var_0116);
}

func_1BAB() {
  var_00 = self;
  level.var_11CB.var_1BAB = lib_0380::func_2889("zmb_break_statue", undefined, var_00.var_0116);
}

func_17A2() {
  var_00 = self;
  var_01 = undefined;
  var_02 = 2;
  var_03 = 1;
  var_04 = 5;
  wait(1);
  var_05 = spawn("script_origin", var_00.var_0116);
  var_05 linkto(var_00, "tag_origin", (0, 0, -720), (0, 0, 0));
  var_06 = lib_0380::func_6846("zmb_blimp_engine_lp", var_01, var_05, var_04, var_03, var_04);
  var_06 = lib_0380::func_6846("zmb_blimp_engine_lfe_lp", var_01, var_05, var_04, var_03, var_04);
  var_00 thread func_179E(var_05);
}

func_179E(param_00) {
  self waittill("death");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_990B(param_00) {
  for(;;) {
    var_01 = distance(level.var_744A[0].var_0116, param_00.var_0116);
    lib_0378::func_8DC2("Disance: " + var_01);
    wait(1);
  }
}

func_179D() {
  wait(0.75);
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_charge", self.var_0116);
}

func_17A0() {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_shoot", self.var_0116);
  wait(0.3);
  if(isDefined(self)) {
    maps\mp\_audio::func_8DA2("zmb_blimp_elec_turret_projectile", self);
  }
}

func_179F() {
  maps\mp\_audio::func_8DA2("zmb_blimp_elec_turret_hit_plr", self);
}

func_17A3() {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_explo", self.var_0116);
  wait(1.2);
  if(isDefined(self)) {
    maps\mp\_audio::func_8DA2("zmb_blimp_elec_turret_fall", self);
  }
}

func_179B(param_00) {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_land", param_00.var_0116);
}

func_17A1() {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_impact", self.var_0116);
}

func_1633() {
  var_00 = self;
  lib_0380::func_288B("zmb_blimp_elec_turret_shoot", undefined, var_00);
  lib_0380::func_6846("zmb_blimp_battery_retract_lp", undefined, var_00, 0.2, undefined, 0.2);
}

func_71C5(param_00, param_01) {
  if(isPlayer(param_01) && !isDefined(param_01.var_9AA9)) {
    var_02 = randomintrange(1, 100);
    if(var_02 == 1) {
      lib_0378::func_7208("mp_nest_tortured_scream", param_01, param_00);
      param_01.var_9AA9 = 1;
    }
  }
}

func_80DF() {
  var_00 = getent("scream_trigger_01", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    func_71C5(var_00.var_0116, var_01);
    wait(1);
  }
}

func_80E0() {
  var_00 = getent("scream_trigger_02", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    func_71C5(var_00.var_0116, var_01);
    wait(1);
  }
}

func_80E1() {
  var_00 = getent("scream_trigger_03", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    func_71C5(var_00.var_0116, var_01);
    wait(1);
  }
}

func_11F6() {
  var_00 = self;
  var_01 = lib_0380::func_6844("zmb_claw_connection", undefined, var_00);
  wait(8);
  lib_0380::func_6850(var_01, 0.5);
  var_01 = undefined;
}

func_1302() {
  var_00 = self;
  wait(0.45);
  var_01 = lib_0380::func_288B("zmb_med_forge_hydro_part01", undefined, var_00);
  var_02 = lib_0380::func_288B("zmb_med_forge_propeller_part01", undefined, var_00);
  var_03 = lib_0380::func_288B("zmb_med_forge_room_part01", undefined, var_00);
  wait(9.91);
  lib_0380::func_2893(var_01, 1);
  var_01 = undefined;
  lib_0380::func_2893(var_02, 1);
  var_02 = undefined;
  lib_0380::func_2893(var_03, 1);
  var_03 = undefined;
  var_04 = lib_0380::func_288B("zmb_med_forge_hydro_part02", undefined, var_00);
  var_05 = lib_0380::func_288B("zmb_med_forge_propeller_part02", undefined, var_00);
  var_06 = lib_0380::func_288B("zmb_med_forge_room_part02", undefined, var_00);
  wait(9.94);
  lib_0380::func_2893(var_04, 1);
  var_04 = undefined;
  lib_0380::func_2893(var_05, 1);
  var_05 = undefined;
  lib_0380::func_2893(var_06, 1);
  var_06 = undefined;
  var_07 = lib_0380::func_288B("zmb_med_forge_hydro_part03", undefined, var_00);
  var_08 = lib_0380::func_288B("zmb_med_forge_hydro_trans_part03", undefined, var_00);
  var_09 = lib_0380::func_288B("zmb_med_forge_propeller_part03", undefined, var_00);
  var_0A = lib_0380::func_288B("zmb_med_forge_room_part03", undefined, var_00);
  wait(9.94);
  lib_0380::func_2893(var_07, 1);
  var_07 = undefined;
  lib_0380::func_2893(var_08, 1);
  var_08 = undefined;
  lib_0380::func_2893(var_09, 1);
  var_09 = undefined;
  lib_0380::func_2893(var_0A, 1);
  var_0A = undefined;
  var_0B = lib_0380::func_288B("zmb_med_forge_hydro_part04", undefined, var_00);
  var_0C = lib_0380::func_288B("zmb_med_forge_steam_01", undefined, var_00);
  var_0D = lib_0380::func_288B("zmb_med_forge_steam_02", undefined, var_00);
  var_0E = lib_0380::func_2889("zmb_med_forge_blood_cough", undefined, (-644, -2406, 1305));
  var_0F = lib_0380::func_288B("zmb_med_forge_room_part04", undefined, var_00);
  wait(9.94);
  lib_0380::func_2893(var_0B, 1);
  var_0B = undefined;
  lib_0380::func_2893(var_0C, 3);
  var_0C = undefined;
  lib_0380::func_2893(var_0D, 3);
  var_0D = undefined;
  lib_0380::func_2893(var_0E, 3);
  var_0E = undefined;
  lib_0380::func_2893(var_0F, 1);
  var_0F = undefined;
  var_10 = lib_0380::func_288B("zmb_med_forge_hydro_part05", undefined, var_00);
  var_11 = lib_0380::func_288B("zmb_med_forge_hydro_trans_part05_a", undefined, var_00);
  var_12 = lib_0380::func_288B("zmb_med_forge_hydro_trans_part05_b", undefined, var_00);
  var_13 = lib_0380::func_288B("zmb_med_forge_room_part05", undefined, var_00);
  wait(9.87);
  lib_0380::func_2893(var_10, 1);
  var_10 = undefined;
  lib_0380::func_2893(var_11, 1);
  var_11 = undefined;
  lib_0380::func_2893(var_12, 1);
  var_12 = undefined;
  lib_0380::func_2893(var_13, 1);
  var_13 = undefined;
  var_14 = lib_0380::func_288B("zmb_med_forge_hydro_part06", undefined, var_00);
  var_15 = lib_0380::func_288B("zmb_med_forge_hydro_trans_part06", undefined, var_00);
  var_16 = lib_0380::func_288B("zmb_med_forge_room_part06", undefined, var_00);
  wait(2.73);
  lib_0380::func_2893(var_14, 1);
  var_14 = undefined;
  lib_0380::func_2893(var_15, 1);
  var_15 = undefined;
  lib_0380::func_2893(var_16, 1);
  var_16 = undefined;
  var_17 = lib_0380::func_288B("zmb_med_forge_room_end", undefined, var_00);
}

func_1305() {
  var_00 = self;
  wait(0.45);
  var_01 = lib_0380::func_288B("zmb_rnd_forge_engine_part01", undefined, var_00);
  var_02 = lib_0380::func_288B("zmb_rnd_forge_pistons_part01", undefined, var_00);
  var_03 = lib_0380::func_288B("zmb_rnd_forge_room_part01", undefined, var_00);
  wait(10.52);
  lib_0380::func_2893(var_01, 1);
  var_01 = undefined;
  lib_0380::func_2893(var_02, 1);
  var_02 = undefined;
  lib_0380::func_2893(var_03, 1.5);
  var_03 = undefined;
  var_04 = lib_0380::func_288B("zmb_rnd_forge_engine_part02", undefined, var_00);
  var_05 = lib_0380::func_288B("zmb_rnd_forge_pistons_part02", undefined, var_00);
  var_06 = lib_0380::func_288B("zmb_rnd_forge_room_part02", undefined, var_00);
  wait(10.24);
  lib_0380::func_2893(var_04, 1);
  var_04 = undefined;
  lib_0380::func_2893(var_05, 1);
  var_05 = undefined;
  lib_0380::func_2893(var_06, 1.5);
  var_06 = undefined;
  var_07 = lib_0380::func_288B("zmb_rnd_forge_engine_part03", undefined, var_00);
  var_08 = lib_0380::func_288B("zmb_rnd_forge_pistons_part03", undefined, var_00);
  var_09 = lib_0380::func_288B("zmb_rnd_forge_room_part03", undefined, var_00);
  wait(10.11);
  lib_0380::func_2893(var_07, 1);
  var_07 = undefined;
  lib_0380::func_2893(var_08, 1);
  var_08 = undefined;
  lib_0380::func_2893(var_09, 1.5);
  var_09 = undefined;
  var_0A = lib_0380::func_288B("zmb_rnd_forge_engine_part04", undefined, var_00);
  var_0B = lib_0380::func_288B("zmb_rnd_forge_pistons_part04", undefined, var_00);
  var_0C = lib_0380::func_288B("zmb_rnd_forge_room_part04", undefined, var_00);
  wait(10.16);
  lib_0380::func_2893(var_0A, 1);
  var_0A = undefined;
  lib_0380::func_2893(var_0B, 1);
  var_0B = undefined;
  lib_0380::func_2893(var_0C, 1.5);
  var_0C = undefined;
  var_0D = lib_0380::func_288B("zmb_rnd_forge_chassis_end", undefined, var_00);
  wait(3.15);
  lib_0380::func_2893(var_0D, 1);
  var_0D = undefined;
}

func_9CA7(param_00) {
  var_01 = common_scripts\utility::func_46B5("trap_elec_sfx", "targetname");
  var_02 = var_01.var_0116;
  var_03 = lib_0380::func_6842("trap_elec_arc_lp", undefined, var_02);
  var_04 = lib_0380::func_6842("trap_elec_crackle_lp", undefined, var_02);
  var_05 = lib_0380::func_6842("trap_elec_pulse_lp", undefined, var_02);
  var_06 = lib_0380::func_6842("trap_elec_hiss_lp", undefined, var_02);
  var_07 = lib_0380::func_6842("trap_elec_hum_lp", undefined, var_02);
  var_08 = lib_0380::func_6842("trap_elec_energy_lp", undefined, var_02);
  var_09 = 0;
  var_0A = undefined;
  while(var_09 < 20) {
    var_0B = randomintrange(1, 2);
    if(var_0B == 1) {
      var_0A = lib_0380::func_2889("trap_elec_arc", undefined, var_02);
    }

    var_09++;
    wait(1);
  }

  lib_0380::func_6850(var_03);
  lib_0380::func_6850(var_04);
  lib_0380::func_6850(var_05);
  lib_0380::func_6850(var_06);
  lib_0380::func_6850(var_07);
  lib_0380::func_6850(var_08);
  lib_0380::func_2893(var_0A);
  lib_0380::func_2889("trap_elec_stop", undefined, var_02);
}

func_9C99(param_00) {
  lib_0380::func_2889("wpn_betty_triggered", undefined, param_00);
}

func_9C98(param_00) {
  lib_0380::func_2889("wpn_betty_exp", undefined, param_00);
}

func_A9FB(param_00) {
  var_01 = common_scripts\utility::func_46B5("weathervane_sfx", "targetname");
  var_02 = var_01.var_0116;
  if(param_00 == "long") {
    lib_0380::func_2889("zmb_weathervane_squeak_long", undefined, var_02);
    return;
  }

  if(param_00 == "short") {
    lib_0380::func_2889("zmb_weathervane_squeak_short", undefined, var_02);
    return;
  }

  lib_0380::func_2889("zmb_weathervane_squeak_struggle", undefined, var_02);
}

func_9FE7() {
  var_00 = common_scripts\utility::func_46B5("battery_deposit_sfx", "targetname");
  var_01 = var_00.var_0116;
  lib_0380::func_2889("zmb_uberschnelle_place_altar", undefined, var_01);
}

func_1632() {
  var_00 = self;
  var_01 = lib_0380::func_2889("zmb_wonder_weapon_proj_zap", undefined, var_00.var_0116);
}

func_7E55(param_00, param_01) {
  switch (param_01) {
    case 1:
      lib_0380::func_288B("zmb_nst01_klau_meinmeineschwester", undefined, param_00);
      break;

    case 2:
      lib_0380::func_288B("zmb_nst01_klau_whathaveyoudonewhathaveyo", undefined, param_00);
      break;

    case 3:
      break;

    case 4:
      lib_0380::func_288B("zmb_nst01_klau_straubyouopenedthegatesof", undefined, param_00);
      break;

    case 5:
      break;

    case 6:
      lib_0380::func_288B("zmb_nst01_klau_donotfollowmethereareothe", undefined, param_00);
      break;

    case 7:
      lib_0380::func_288B("zmb_nst01_klau_keepfightingtheemperormus", undefined, param_00);
      break;
  }
}

func_1806() {
  lib_0380::func_288B("zmb_uber_reveal_door_blast", undefined, self);
}

func_2A32(param_00) {
  level.var_11CB.var_2A31 = spawnStruct();
  level.var_11CB.var_2A31.var_37EB = [[0, 1], [1, 0.001]];
  level.var_11CB.var_2A31.var_37E9 = [[0, 0.001], [1, 1]];
  foreach(var_02 in level.var_744A) {
    var_02 lib_0366::func_8E30(0, 2);
  }

  var_04 = 0;
  var_05 = 0;
  var_06 = lib_0378::func_8D73(var_04, 0, 1, level.var_11CB.var_2A31.var_37EB);
  level.var_11CB.var_2A31.var_8E54 = lib_0380::func_288D("zmb_mus_darkwings_straight", undefined, param_00, var_05, var_06);
  var_06 = lib_0378::func_8D73(var_04, 0, 1, level.var_11CB.var_2A31.var_37E9);
  level.var_11CB.var_2A31.var_8E53 = lib_0380::func_288D("zmb_mus_darkwings_demented", undefined, param_00, var_05, var_06);
}

func_2A34(param_00, param_01) {
  var_02 = lib_0378::func_8D73(param_00, 0, 1, level.var_11CB.var_2A31.var_37EB);
  lib_0380::func_2891(level.var_11CB.var_2A31.var_8E54, var_02, param_01);
  var_02 = lib_0378::func_8D73(param_00, 0, 1, level.var_11CB.var_2A31.var_37E9);
  lib_0380::func_2891(level.var_11CB.var_2A31.var_8E53, var_02, param_01);
}

func_2A33() {
  var_00 = 1.5;
  lib_0380::func_2893(level.var_11CB.var_2A31.var_8E54, var_00);
  lib_0380::func_2893(level.var_11CB.var_2A31.var_8E53, var_00);
  foreach(var_02 in level.var_744A) {
    var_02 lib_0366::func_8E30(1, 2);
  }
}

func_9226() {
  var_00 = self;
  if(!isDefined(level.var_11CB.var_4D75)) {
    level.var_11CB.var_4D75 = lib_0380::func_6842("zmb_hilt_sphere_lp", undefined, var_00.var_0116);
  }
}

func_8B10() {
  var_00 = self.var_0116;
  foreach(var_02 in level.var_744A) {
    if(distance(var_02.var_0116, var_00) <= 1200) {
      var_02 thread func_6343(var_00);
    }
  }
}

func_6343(param_00) {
  var_01 = self;
  var_02 = 9;
  var_01 method_8626("shoot_chandelier");
  lib_0380::func_2889("zmb_shoot_chandelier_main", undefined, param_00);
  var_01 common_scripts\utility::func_A74B("death", var_02);
  self method_8627("shoot_chandelier");
}

func_4D73() {
  lib_0380::func_6850(level.var_11CB.var_4D75, 0.25);
  level.var_11CB.var_4D75 = undefined;
  lib_0380::func_2889("zmb_hilt_destroy", undefined, self.var_0116);
}

func_6FC3() {
  var_00 = lib_0380::func_2888("zmb_pickup_raven_swrd");
}

func_6BF4() {
  var_00 = self;
  lib_0380::func_2889("zmb_raven_stone_open", undefined, var_00.var_0116);
}

func_6854() {
  var_00 = lib_0380::func_288B("zmb_nuke_explo", undefined, self);
}

func_9CC8(param_00) {
  wait(0.3);
  var_01 = 1;
  var_02 = 0;
  while(var_01) {
    lib_0380::func_2889("trap_spikes", undefined, param_00);
    if(var_02 < 19) {
      var_02++;
      continue;
    }

    var_01 = 0;
    wait(1);
  }
}

func_1CC1() {
  foreach(var_01 in level.var_744A) {
    var_01 method_8626("brute_intro", 2);
  }

  lib_0366::func_8E33(3);
  lib_0380::func_6840("zmb_mus_brute_intro");
}

func_1CC2() {
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("brute_intro", 0.1);
  }
}