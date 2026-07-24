/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3840.gsc
**************************************/

_id_25D8(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 16;
  }

  _id_9736();
  _id_974E();
  _id_13ED(var_0);
}

_id_9736() {
  if(!isDefined(level._id_2571)) {
    level._id_2571 = spawnStruct();
  }

  if(!isDefined(level._id_2571._id_5A61)) {
    level._id_2571._id_5A61 = [];
  }

  if(!isDefined(level._id_2571._id_DC72)) {
    level._id_2571._id_DC72 = [];
    level._id_2571._id_DC72["linear_up"] = [0.0, 0.02, 0.045, 0.065, 0.09, 0.11, 0.135, 0.155, 0.18, 0.2];
    level._id_2571._id_DC72["linear_down"] = [0.2, 0.18, 0.155, 0.135, 0.11, 0.09, 0.065, 0.045, 0.02, 0.0];
    level._id_2571._id_DC72["exponential_slow_up"] = [0.0, 0.01, 0.019, 0.03, 0.049, 0.068, 0.102, 0.15, 0.229, 0.343];
    level._id_2571._id_DC72["exponential_fast_down"] = [0.343, 0.229, 0.15, 0.102, 0.068, 0.049, 0.03, 0.019, 0.01, 0.0];
    level._id_2571._id_DC72["exponential_fast_up"] = [0.0, 0.051, 0.077, 0.094, 0.108, 0.118, 0.127, 0.135, 0.142, 0.148];
    level._id_2571._id_DC72["exponential_slow_down"] = [0.148, 0.142, 0.135, 0.127, 0.118, 0.108, 0.094, 0.077, 0.051, 0.0];
    level._id_2571._id_DC72["bell"] = [0.003, 0.017, 0.057, 0.14, 0.283, 0.283, 0.14, 0.057, 0.017, 0.003];
    level._id_2571._id_DC72["inverted_bell"] = [0.283, 0.14, 0.057, 0.017, 0.003, 0.003, 0.017, 0.057, 0.14, 0.283];
  }
}

_id_974E() {
  scripts\engine\utility::flag_init("stop_jackal_interior_sound");
  scripts\engine\utility::flag_init("entering_airlock");
  scripts\engine\utility::flag_init("entering_ship_interior");
  scripts\engine\utility::flag_init("sa_bridge_3d_amb");
  scripts\engine\utility::flag_init("stop_sfx_emitter");
}

_id_DED4() {
  if(!isDefined(level._id_E97F)) {
    level._id_E97F = [];
  }

  var_0 = scripts\engine\utility::getStructArray("sa_ambient_loop", "targetname");

  foreach(var_2 in var_0) {
    foreach(var_4 in level._id_E6E0) {
      if(ispointinvolume(var_2.origin, var_4)) {
        var_5 = undefined;

        if(isDefined(var_4.targetname)) {
          var_5 = var_4.targetname;
        }

        if(!isDefined(level._id_E97F[var_5])) {
          level._id_E97F[var_5] = [];
        }

        var_6 = level._id_E97F[var_5].size;
        level._id_E97F[var_5][var_6] = var_2;
      }
    }
  }
}

_id_E9DF(var_0, var_1) {
  if(!var_0 scripts\sp\utility::_id_65DF("clear_room_audio")) {
    var_0 scripts\sp\utility::_id_65E0("clear_room_audio");
  }

  level thread _id_CDED(var_0, var_1.targetname, "clear_room_audio");
  var_0 scripts\sp\utility::_id_65E3("clear_room_audio");
  wait 1.0;
  var_0 scripts\sp\utility::_id_65DD("clear_room_audio");
}

_id_CDED(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(level._id_E97F[var_1])) {
    var_4 = undefined;

    foreach(var_6 in level._id_E97F[var_1]) {
      var_4 = scripts\engine\utility::spawn_tag_origin(var_6.origin, var_6.angles);
      var_3 = scripts\engine\utility::add_to_array(var_3, var_4);
      var_7 = var_6.script_noteworthy;

      switch (var_7) {
        case "amb_sa_big_light_":
          var_8 = randomintrange(1, 6);
          var_7 = var_7 + var_8;
          break;
        case "amb_sa_small_light_":
          var_8 = randomintrange(1, 5);
          var_7 = var_7 + var_8;
          break;
        case "amb_sa_conduit_":
          var_8 = randomintrange(1, 9);
          var_7 = var_7 + var_8;
          break;
        case "amb_sa_elec_":
          var_8 = randomintrange(1, 4);
          var_7 = var_7 + var_8;
          break;
        case "amb_sa_screen_":
          var_8 = randomintrange(1, 7);
          var_7 = var_7 + var_8;
          break;
        default:
          break;
      }

      wait(randomfloatrange(0.25, 1.0));
      var_9 = randomint(100);

      if(var_9 < 65) {
        var_4 playLoopSound(var_7);
      }
    }

    if(isDefined(var_2) && var_3.size > 0) {
      var_0 scripts\sp\utility::_id_65E3(var_2);

      foreach(var_4 in var_3) {
        var_12 = randomfloatrange(0.25, 1.0);
        var_4 scripts\engine\utility::delaythread(var_12, scripts\sp\utility::_id_10460, 2);
      }
    }
  }
}

_id_CD09(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  var_4 playLoopSound(var_1);
  scripts\engine\utility::flag_wait(var_2);
  wait 4;
  var_4 scripts\sp\utility::_id_10460(2);
  wait 2;
  var_4 delete();
}

_id_E9C3() {
  thread _id_D050();
  thread _id_A070();
  thread _id_A06F();
}

_id_D050() {
  level.player setsoundsubmix("sa_player_jackal_interior");
  level.player playSound("dogfight_high_thrust_start");
  thread _id_A1C8();
  scripts\engine\utility::flag_clear("stop_jackal_interior_sound");
  thread _id_A378();
}

_id_D05A() {
  scripts\engine\utility::flag_set("stop_jackal_interior_sound");
  wait 2;
  level.player clearsoundsubmix();
  wait 2;
  level.player _meth_82C0("default", 3);
}

_id_A1C8() {
  wait 3;
  thread scripts\sp\utility::_id_6EEB("allies");
}

_id_A378() {
  level.player endon("exit_jackal");
  level._id_2571._id_A378 = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_A37A = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_A37B = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_A378 _meth_8278(0);
  level._id_2571._id_A37A _meth_8278(0);
  level._id_2571._id_A378 playLoopSound("dogfight_high_thrust_lp");
  level._id_2571._id_A37A playLoopSound("dogfight_high_thrust_shake_lp");

  while(!scripts\engine\utility::flag("stop_jackal_interior_sound")) {
    var_0 = _id_A377();

    if(isDefined(var_0) && var_0 > 0) {
      thread _id_A376(var_0);
    }

    scripts\engine\utility::waitframe();
  }

  wait 0.3;
  level._id_2571._id_A378 stoploopsound("dogfight_high_thrust_lp");
  level._id_2571._id_A37A stoploopsound("dogfight_high_thrust_shake_lp");
  scripts\engine\utility::waitframe();
  level._id_2571._id_A378 delete();
  level._id_2571._id_A37A delete();
  wait 4;
  level._id_2571._id_A37B scripts\sp\utility::_id_10460(1);
}

_id_A377() {
  level.player endon("exit_jackal");
  level.player waittill("engage boost");
  var_0 = gettime();
  level._id_2571._id_A378 _meth_8277(2, 12);
  level._id_2571._id_A378 _meth_8278(1, 1);
  level._id_2571._id_A37A _meth_8277(1.2, 10);
  level._id_2571._id_A37A _meth_8278(1, 1);
  level._id_2571._id_A37B _meth_8277(2, 12);
  level.player scripts\engine\utility::waittill_any("disengage boost", "exit_jackal");
  return gettime() - var_0;
}

_id_A376(var_0) {
  level.player endon("exit_jackal");
  level.player endon("engage boost");

  if(!isDefined(var_0)) {
    level._id_2571._id_A37B _meth_8277(1);
    level._id_2571._id_A37B playSound("dogfight_high_thrust_end");
    return;
  }

  if(var_0 > 1000) {
    level._id_2571._id_A37B playSound("dogfight_high_thrust_end");
  }

  level._id_2571._id_A37B _meth_8277(1, 0.05);
  var_1 = clamp(var_0 / 4000, 0, 1.0);
  level._id_2571._id_A378 _meth_8278(0.398, 0.25 * var_1);
  level._id_2571._id_A378 _meth_8277(1, 12 * var_1);
  level._id_2571._id_A37A _meth_8277(1, 0.25 * var_1);
  wait(0.5 * var_1);
  var_2 = 1.5 * var_1;
  level._id_2571._id_A378 _meth_8278(0, var_2);
  level._id_2571._id_A37A _meth_8278(0, var_2);
  wait(var_2);
  level._id_2571._id_A378 _meth_8277(1);
}

_id_A070() {
  while(!scripts\engine\utility::flag("stop_jackal_interior_sound")) {
    level.player playSound("jackal_ambient_rattle_sm");
    wait(randomfloatrange(0.1, 5));
  }
}

_id_A06F() {
  while(!scripts\engine\utility::flag("stop_jackal_interior_sound")) {
    level.player playSound("jackal_ambient_rattle_lg");
    wait(randomfloatrange(1, 9));
  }
}

_id_6FFD() {
  var_0 = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  var_0 playLoopSound("amb_sa_flybys_lr");
}

_id_FC1B() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\utility::flag_set("entering_airlock");
  level.player setsoundsubmix("sa_ship_interior");
  level.player notify("started_dynamic_ambience");
  thread _id_FBEF("amb_sa_battle_distant", 3, 10, 3, 10, 3000, 3001, 300, 90, 90, 4, 0, 0, 0);
  thread _id_FBEF("amb_sa_impact", 6, 18, 6, 8, 3000, 3001, 300, 180, 180, 2, 1, 0.5, 3);
  thread _id_FBEF("amb_sa_battle_tracer_short", 4, 8, 4, 8, 3000, 3001, 300, 45, 90, 1, 0, 0, 0);
  thread _id_FBEF("amb_sa_battle_jack_flyby", 18, 30, 18, 30, 3000, 3001, 300, 180, 360, 2, 0, 0, 0);
}

_id_FC1D() {
  level.player notify("started_dynamic_ambience");
  thread _id_FBEF("amb_sa_metal_groan_large", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0, "linear_up");
  thread _id_FBEF("amb_sa_metal_groan_ominous", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
}

_id_FC1C() {
  level.player notify("started_dynamic_ambience");
  thread _id_FBEF("amb_sa_battle_distant_deep", 5, 12, 0, 4, 3000, 3001, 300, 90, 90, 4, 0, 0, 0);
  thread _id_FBEF("amb_sa_impact_deep", 8, 22, 4, 8, 3000, 3001, 300, 180, 180, 2, 1, 0.5, 3);
  thread _id_FBEF("amb_sa_battle_tracer_short_deep", 6, 10, 6, 10, 3000, 3001, 300, 45, 90, 1, 0, 0, 0);
  thread _id_FBEF("amb_sa_battle_jack_flyby_deep", 25, 40, 10, 20, 3000, 3001, 300, 180, 360, 2, 0, 0, 0);
  thread _id_FBEF("amb_sa_metal_groan_ominous", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0, "linear_up");
}

_id_CDE4(var_0) {
  scripts\engine\utility::play_sound_in_space("sa_robot_sec_station_deploy_01", var_0);
}

_id_CDE5(var_0) {
  scripts\engine\utility::play_sound_in_space("sa_robot_sec_station_disable_01", var_0);
}

_id_DED5() {
  level._id_C851[""] = spawnStruct();
  _id_4931("war", "sa_paa_fuel_leak");
  _id_4931("war", "sa_paa_violent_decompressions");
  _id_4931("war", "sa_paa_medical_teams");
  _id_4931("war", "sa_paa_fire_control");
  _id_4931("war", "sa_paa_action_stations");
  _id_4931("war", "sa_paa_forces_boarded");
  _id_4931("war", "sa_paa_unsa_attack");
  _id_4931("war", "sa_paa_thrust_correction");
  _id_4931("war", "sa_paa_battle_maneuvers");
  _id_4931("war", "sa_paa_seal_bulkheads");
  _id_4931("war", "sa_paa_forces_rallying");
  _id_4931("war", "sa_paa_receive_enemy");
  _id_4931("war", "sa_paa_port_hangar_bay");
  _id_4931("war", "sa_paa_starboard_control");
  _id_4931("war", "sa_paa_condition_one");
  _id_4931("war", "sa_paa_positive_flow");
  _id_4931("war", "sa_paa_protocol_orange");
  _id_4931("war", "sa_paa_portside_armory");
  _id_4931("war", "sa_paa_weapons_grid");
  _id_4931("war", "sa_paa_alpha_juliet");
  _id_4931("war", "sa_paa_upper_bow");
  _id_4931("war", "sa_paa_auxiliary_ops");
  _id_4931("war", "sa_paa_backup_munitions");
  _id_4931("war", "sa_paa_internal_comms");
  _id_4931("war", "sa_paa_grid_position");
  _id_4931("war", "sa_paa_ordnance_team");
  _id_4931("war", "sa_paa_engineering_cancel");
  _id_4931("war", "sa_paa_set_condition");
  _id_4931("war", "sa_paa_aft_damage");
  _id_4931("war", "sa_paa_aux_ops");
  _id_4931("war", "sa_paa_bay_3_asap");
  _id_4931("war", "sa_paa_airlock_6c");
  _id_4931("war", "sa_paa_atmo_controls");
  _id_4931("war", "sa_paa_dct6");
  _id_4931("war", "sa_paa_on_the_double");
  _id_4931("war", "sa_paa_ordnance_bay5");
  _id_4931("war", "sa_paa_inoperative");
  _id_4931("war", "sa_paa_leak");
  _id_4931("normal_operations", "sa_paa_thrust_correction");
  _id_4931("normal_operations", "sa_paa_port_hangar_bay");
  _id_4931("normal_operations", "sa_paa_starboard_control");
  _id_4931("normal_operations", "sa_paa_engineering_cancel");
  _id_4931("normal_operations", "sa_paa_bay_3_asap");
  _id_4931("normal_operations", "sa_paa_airlock_6c");
  _id_4931("normal_operations", "sa_paa_atmo_controls");
  _id_4931("normal_operations", "sa_paa_inoperative");
}

_id_4931(var_0, var_1) {
  if(!isDefined(level._id_C851) || !isDefined(level._id_C851[var_0])) {
    level._id_C851[var_0] = [];
  }

  var_2 = level._id_C851[var_0].size;
  level._id_C851[var_0][var_2] = spawnStruct();
  level._id_C851[var_0][var_2].sound = var_1;
  level._id_C851[var_0][var_2].played = 0;
}

_id_BF4E(var_0) {
  var_1 = randomint(level._id_C851[var_0].size);
  var_2 = undefined;

  if(level._id_C851[var_0][var_1].played == 1) {
    for(var_3 = 0; var_3 < level._id_C851[var_0].size; var_3++) {
      var_1++;

      if(var_1 >= level._id_C851[var_0].size) {
        var_1 = 0;
      }

      if(level._id_C851[var_0][var_1].played == 1) {
        continue;
      }
      var_2 = var_1;
      break;
    }

    if(!isDefined(var_2)) {
      for(var_3 = 0; var_3 < level._id_C851[var_0].size; var_3++) {
        level._id_C851[var_0][var_3].played = 0;
      }

      var_2 = randomint(level._id_C851[var_0].size);
    }
  } else
    var_2 = var_1;

  level._id_C851[var_0][var_2].played = 1;
  var_4 = level._id_C851[var_0][var_2].sound;
  return var_4;
}

_id_CDD7(var_0, var_1, var_2) {
  level notify("end_pa_group");
  level endon("end_pa_group");

  if(!isDefined(var_1) || !isDefined(var_2)) {
    var_1 = 10;
    var_2 = 20;
  }

  for(;;) {
    var_3 = _id_DCC4(var_1, var_2);
    wait(var_3);
    var_4 = _id_BF4E(var_0);
    _id_CDBC(var_4);
  }
}

_id_BF4D(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) == 0) {
    var_0 = 512.0;
  }

  if(isDefined(var_1) == 0) {
    var_1 = -180.0;
  }

  if(isDefined(var_2) == 0) {
    var_2 = 180.0;
  }

  if(isDefined(var_3) == 0) {
    var_3 = var_0;
  }

  if(isDefined(level._id_C851[""]._id_56EC) == 0) {
    level._id_C851[""]._id_56EC = 0;
  }

  if(isDefined(level._id_C851[""]._id_C71C) == 0) {
    level._id_C851[""]._id_C71C = level.player.origin - (0, 0, var_3 * 2);
  }

  if(isDefined(level._id_C851[""]._id_C71A) == 0) {
    level._id_C851[""]._id_C71A = level.player.origin + (0, 0, var_3 * 2);
  }

  var_4 = length(level._id_C851[""]._id_C71A - level.player.origin);

  if(level._id_C851[""]._id_56EC == var_0 && var_4 < var_3) {
    return level._id_C851[""]._id_C71C;
  }

  var_6 = _id_DCC4(var_1, var_2, 0);
  var_7 = 18.0;
  var_8 = _id_11E3(level.player getvieworigin(), level.player.angles, var_0, var_6, var_7);
  level._id_C851[""]._id_56EC = var_0;
  level._id_C851[""]._id_C71A = level.player.origin;
  level._id_C851[""]._id_C71C = var_8;
  return var_8;
}

free_pa_sound() {
  self waittill("sounddone");
  level._id_C851[""]._id_10482 = undefined;
  _id_13EC();
}

_id_CDBC(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 512.0;
  var_6 = -180.0;
  var_7 = 180.0;
  var_8 = var_5;

  if(scripts\engine\utility::is_true(level._id_D4A5)) {
    return;
  }
  if(isDefined(var_1) && isDefined(var_3) && var_1 == 1 && var_3 == 1) {}

  if(isDefined(var_1) == 0) {
    var_1 = 0;
  }

  if(isDefined(var_3) == 0) {
    var_3 = 0;
  }

  if(var_1 == 1) {
    if(isDefined(var_2)) {
      wait(var_2);
    }

    if(isDefined(level._id_C851[""]._id_10482) == 1) {
      var_4 = 1;
      level._id_C851[""]._id_10482 stopsounds();
      level._id_C851[""]._id_10482 waittill("deleted");
    }

    var_5 = 192.0;
    var_6 = -30.0;
    var_7 = 30.0;
    var_8 = var_5;
  } else {
    if(isDefined(level._id_C851[""]._id_10482) == 1) {
      level._id_C851[""]._id_10482 waittill("deleted");
    }

    if(isDefined(var_2)) {
      wait(var_2);
    }
  }

  var_9 = _id_BF4D(var_5, var_6, var_7, var_8);

  while(isDefined(level._id_C851[""]._id_10482) == 1) {
    scripts\engine\utility::waitframe();
  }

  level._id_C851[""]._id_10482 = _id_13EB(var_9);

  if(isDefined(level._id_C851[""]._id_10482) == 1) {
    if(var_4 == 1) {
      var_10 = "sa_pa_alert_captain";
      level._id_C851[""]._id_10482 playSound(var_10, "sounddone", 1);
      level._id_C851[""]._id_10482._id_10475 = var_10;
      level._id_C851[""]._id_10482 waittill("sounddone");
    }

    level._id_C851[""]._id_10482 playSound(var_0, "sounddone", 1);
    level._id_C851[""]._id_10482._id_10475 = var_0;
    level._id_C851[""]._id_10482 thread free_pa_sound();
  } else {}
}

_id_CDBD(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 == 0) {}

  var_1 = 1;
  _id_CDBC(var_0, 1, var_2, 0);
}

_id_EBAF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2 - var_1;
  var_6 = clamp(var_0, var_1, var_2);
  var_7 = (var_6 - var_1) / var_5;
  var_8 = var_4 - var_3;
  var_9 = var_3 + var_8 * var_7;
  return var_9;
}

_id_DCC4(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(var_0 == var_1) {
      return var_0;
    } else {
      var_3 = randomfloatrange(var_0, var_1);
      return var_3;
    }
  } else if(isDefined(var_0) == 1 && isDefined(var_1) == 0)
    return var_0;
  else if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

_id_13F2(var_0, var_1) {
  var_2 = level.player getvieworigin();
  var_3 = pointonsegmentnearesttopoint(var_0, var_1, var_2);
  return var_3;
}

_id_13F0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  var_7 = 0.0666;
  self._id_10475 = var_0;
  self._id_ACE7 = var_2;
  self._id_ACE4 = var_3;

  if(isDefined(var_4) == 1) {
    self _meth_8278(0.0, 0);
    scripts\engine\utility::waitframe();
    self _meth_8278(1.0, var_4);
  }

  if(var_1 == 1) {
    self playLoopSound(var_0);
  } else {
    var_6 = "sounddone";
    self playSound(var_0, var_6);
  }

  if(isDefined(var_6) == 1) {
    thread _id_13EF(var_1, var_5, var_6);
  }

  for(;;) {
    var_8 = _id_13F2(var_2, var_3);
    self moveTo(var_8, var_7, 0, 0);
    wait(var_7);
  }
}

_id_13EF(var_0, var_1, var_2) {
  if(isDefined(var_2) == 1) {
    self waittill(var_2);
  }

  if(isDefined(var_1) == 1 && var_1 > 0.0) {
    self _meth_8278(0.0, var_1);
    wait(var_1);
  }

  if(var_0 == 1) {
    self stoploopsound();
  } else {}

  _id_13EC();
}

_id_FBB7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_13F2(var_2, var_3);
  var_8 = _id_13EB(var_7);

  if(isDefined(var_8) == 0) {
    return;
  }
  var_8 thread _id_13F0(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  return var_8;
}

_id_FB80(var_0, var_1, var_2, var_3, var_4) {
  self endon("stop_sfx_emitter");
  self endon("stop_sfx_emitter_line");
  self endon("death");

  for(;;) {
    _id_FBB7(var_0, 0, var_1, var_2);
    var_5 = _id_DCC4(var_3, var_4);
    wait(var_5);
  }
}

_id_FB7D(var_0, var_1, var_2) {
  self endon("stop_sfx_emitter");
  self endon("death");

  for(;;) {
    var_3 = randomfloatrange(var_1, var_2);
    wait(var_3);
    self playSound(var_0);
  }
}

_id_FB7F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("stop_sfx_emitter");
  self endon("death");
  var_7 = 1024;
  var_8 = 0;

  for(;;) {
    var_9 = _id_DCC4(var_3, var_4, var_7);
    var_10 = _id_DCC4(var_5, var_6, var_8);
    var_11 = _id_DCC4(var_1, var_2);
    wait(var_11);
    _id_CE29(var_0, var_9, var_10);
  }
}

_id_FB81(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self endon("started_dynamic_ambience");
  self endon("stop_sfx_emitter");
  self endon("death");

  if(isDefined(var_14)) {
    self endon(var_14);
  }

  var_15 = [];
  var_16 = [];

  if(isDefined(var_12)) {
    var_16 = level._id_2571._id_DC72[var_12];
    var_15 = _id_4971(var_1, var_2, var_12);

    if(isDefined(var_13)) {
      var_16 = _id_7C2A(var_16, var_13);
    }
  }

  for(;;) {
    if(!isDefined(var_12)) {
      var_17 = _id_DCC4(var_1, var_2);
      wait(var_17);
    } else {
      var_18 = _id_7D78(var_16, var_15);
      wait(var_18);
    }

    thread _id_FBDA(var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

_id_FB82(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  self endon("started_dynamic_ambience");
  self endon("stop_sfx_emitter");
  self endon("death");

  if(isDefined(var_16)) {
    self endon(var_16);
  }

  var_17 = _id_DCC4(var_3, var_4);
  wait(var_17);
  thread _id_FBDA(var_0, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  var_18 = [];
  var_19 = [];

  if(isDefined(var_14)) {
    var_19 = level._id_2571._id_DC72[var_14];
    var_18 = _id_4971(var_1, var_2, var_14);

    if(isDefined(var_15)) {
      var_19 = _id_7C2A(var_19, var_15);
    }
  }

  for(;;) {
    if(!isDefined(var_14)) {
      wait(randomfloatrange(var_1, var_2));
    } else {
      var_20 = _id_7D78(var_19, var_18);
      wait(var_20);
    }

    thread _id_FBDA(var_0, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  }
}

_id_FBEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  level.player _id_FB82(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
}

_id_4971(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  var_4 = level._id_2571._id_DC72[var_2].size;
  var_5 = (var_1 - var_0) / (var_4 - 1);

  for(var_6 = 1; var_6 < var_4 - 1; var_6++) {
    var_3[var_6] = var_3[var_6 - 1] + var_5;
  }

  var_3[var_3.size] = var_1;
  return var_3;
}

_id_7C2A(var_0, var_1) {
  var_2 = [];
  var_3 = 1.0 / var_0.size;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_3 - var_0[var_4];
    var_6 = (1 - var_1) * abs(var_5);

    if(var_5 < 0) {
      var_6 = var_6 * -1;
    }

    var_2[var_4] = var_0[var_4] + var_6;
  }

  return var_2;
}

_id_7D78(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomfloat(1);
  var_4 = 0;
  var_5 = var_1[var_1.size - 1];

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_4 = var_4 + var_0[var_6];

    if(var_3 < var_4) {
      var_5 = var_1[var_6];
      break;
    }
  }

  return var_5;
}

_id_FBDA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = _id_DCC4(var_1, var_2, 0);
  var_11 = 0;
  var_12 = _id_DCC4(var_4, var_5, 0);

  if(isDefined(var_3) && var_3 > 0) {
    var_11 = randomintrange(0, var_3) * randomintrange(0, 2) * 2 - 1;
  }

  var_13 = var_12;
  var_12 = var_12 * (randomfloatrange(0, 2) * 2 - 1);
  thread _id_FBCA(var_0, var_13, var_10, var_12, var_11, var_6);

  if(scripts\engine\utility::is_true(var_7) && isDefined(var_8) && isDefined(var_9)) {
    wait(var_9);
    thread _id_ECCB(var_8);
  }
}

_id_ECCB(var_0) {
  screenshake(level.player.origin, var_0, var_0, var_0, 1.0, 0, 1.0, 128, 7, 6, 5);
  scripts\engine\utility::exploder("vfx_rumble");
}

_id_FBCA(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self.origin + (0, 0, var_4);
  var_7 = (0, var_1, 0);
  var_8 = var_6 + var_2 * anglesToForward(var_7);
  var_9 = _id_13EB(var_8);

  if(isDefined(var_9) == 0) {
    return;
  }
  if(isDefined(self._id_13543) == 1) {
    var_9 _meth_8278(self._id_13543, 0);
  }

  var_9 playSound(var_0, "sounddone");
  var_9._id_10475 = var_0;
  var_9 thread _id_FBC8();

  if(isDefined(var_3) && var_3 != 0 && isDefined(var_5) && var_5 > 0) {
    var_9 thread _id_FBC9(var_6, var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_FBC9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("sounddone");
  var_8 = 0.0;
  var_9 = 0.1;
  var_10 = getdvarint("snd_debugShipAssault");

  if(var_10 > 2) {
    thread _id_FBC7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  while(var_8 < var_7) {
    wait(var_9);
    var_1 = (0, var_3 + var_5 * var_8 / var_7, 0);
    var_11 = var_0 + var_4 * anglesToForward(var_1);
    self moveTo(var_11, var_9);
    var_8 = var_8 + var_9;
  }
}

_id_FBC7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("sounddone");
  var_8 = 0.0;
  var_9 = 0.1;
  var_10 = var_2;
  var_11 = (randomfloatrange(0.25, 1.0), randomfloatrange(0.5, 1.0), randomfloatrange(0.25, 1.0));

  while(var_8 < var_7) {
    var_1 = (0, var_3 + var_5 * var_8 / var_7, 0);
    var_12 = var_0 + var_4 * anglesToForward(var_1);
    var_10 = var_12;
    var_8 = var_8 + var_9;
    scripts\engine\utility::waitframe();
  }

  wait(var_7);
}

_id_FBC8() {
  self waittill("sounddone");
  _id_13EC();
}

_id_FBDB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_FBDA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_FBC5(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_FBCA(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_FB7E() {
  _id_FBC8();
}

_id_CC79(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin);

  for(var_2 = 0; var_2 < var_0; var_2 = var_2 + 1) {
    var_1 playSound("emt_sa_alarm_01_wet");

    if(var_2 < var_0 - 1) {
      var_3 = 1.2;
    } else {
      var_3 = randomfloatrange(0.2, 0.5);
    }

    wait(var_3);
  }

  var_1 stopsounds();
  scripts\engine\utility::waitframe();
  var_1 delete();
}

_id_CD43() {
  var_0 = scripts\engine\utility::getStruct("hologram_console", "targetname");

  if(isDefined(var_0)) {
    scripts\engine\utility::play_loopsound_in_space("emt_computer_hologram_display_lp_01", var_0.origin);

    for(;;) {
      wait(randomfloatrange(0.0, 5.0));
      scripts\engine\utility::play_sound_in_space("sa_computer_tech_ui_short", var_0.origin);
    }
  }
}

_id_CCAE() {
  scripts\engine\utility::flag_wait("sa_bridge_3d_amb");
  thread _id_CD43();
}

_id_1358F(var_0, var_1) {
  var_2 = 0.0333333 * var_0;

  if(isDefined(var_1) == 0) {
    var_1 = 0.0;
  }

  var_3 = var_2 + var_1;

  if(var_3 <= 0.0) {
    return;
  }
  wait(var_3);
}

_id_CE35(var_0, var_1, var_2) {
  _id_1358F(var_1, var_2);
  self playSound(var_0);
}

_id_CE23(var_0, var_1, var_2, var_3) {
  _id_1358F(var_2, var_3);
  _id_CE21(var_0, var_1);
}

_id_CE33(var_0, var_1, var_2, var_3) {
  _id_1358F(var_2, var_3);
  scripts\sp\utility::play_sound_on_tag(var_0, var_1);
}

_id_CDD1(var_0, var_1, var_2) {
  if(!isDefined(level._id_2571._id_1DAB)) {
    _id_96FF();
  }

  if(level._id_2571._id_1D8F == var_0 && level._id_2571._id_1D90 == var_1) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = level._id_2571._id_1DAE;
  var_4 = level._id_2571._id_1DAF;
  var_5 = level._id_2571._id_1DAB;
  var_6 = level._id_2571._id_1DAD;

  if(level._id_2571._id_1DAC) {
    var_3 = level._id_2571._id_1DAB;
    var_4 = level._id_2571._id_1DAD;
    var_5 = level._id_2571._id_1DAE;
    var_6 = level._id_2571._id_1DAF;
  }

  var_5 playLoopSound(var_0);
  var_6 playLoopSound(var_1);
  _id_4A82(var_3, var_5, var_2, var_2, 1);
  _id_4A82(var_4, var_6, var_2, var_2, 1);
  level._id_2571._id_1D8F = var_0;
  level._id_2571._id_1D90 = var_1;
  level._id_2571._id_1DAC = !level._id_2571._id_1DAC;
}

_id_11034(var_0) {
  if(!isDefined(level._id_2571._id_1DAB)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  _id_11042(level._id_2571._id_1DAB, var_0, 1);
  _id_11042(level._id_2571._id_1DAE, var_0, 1);
  level._id_2571._id_1D8F = "";
  level._id_2571._id_1D90 = "";
}

_id_96FF() {
  level._id_2571._id_1DAB = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_1DAD = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_1DAE = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_1DAF = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_1DAB _meth_8278(0);
  level._id_2571._id_1DAD _meth_8278(0);
  level._id_2571._id_1DAE _meth_8278(0);
  level._id_2571._id_1DAF _meth_8278(0);
  level._id_2571._id_1DAC = 0;
  level._id_2571._id_1D8F = "";
  level._id_2571._id_1D90 = "";
}

_id_CDA7(var_0, var_1, var_2) {
  if(!isDefined(level._id_2571._id_BDD8)) {
    _id_9695();
  }

  if(var_0 == level._id_2571._id_BDD6) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = level._id_2571._id_BDD8;
  var_4 = level._id_2571._id_BDDA;

  if(!level._id_2571._id_BDD9) {
    var_3 = level._id_2571._id_BDDA;
    var_4 = level._id_2571._id_BDD8;
  }

  var_4 playLoopSound(var_0);
  _id_4A82(var_3, var_4, var_2, var_1, level._id_2571._id_BDDE);
  level._id_2571._id_BDD9 = !level._id_2571._id_BDD9;
  level._id_2571._id_BDDE = 1;
  level._id_2571._id_BDD6 = var_0;
}

_id_CDA8(var_0, var_1, var_2) {
  if(!isDefined(level._id_2571._id_BDD8)) {
    _id_9695();
  }

  if(var_0 == level._id_2571._id_BDD6) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = level._id_2571._id_BDD8;
  var_4 = level._id_2571._id_BDDA;

  if(!level._id_2571._id_BDD9) {
    var_3 = level._id_2571._id_BDDA;
    var_4 = level._id_2571._id_BDD8;
  }

  var_4 playSound(var_0);
  _id_4A82(var_3, var_4, var_2, var_1, level._id_2571._id_BDDE);
  level._id_2571._id_BDD9 = !level._id_2571._id_BDD9;
  level._id_2571._id_BDDE = 0;
  level._id_2571._id_BDD6 = var_0;
}

_id_9695() {
  level._id_2571._id_BDD8 = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_BDDA = scripts\engine\utility::spawn_tag_origin((0, 0, 0));
  level._id_2571._id_BDD8 _meth_8278(0);
  level._id_2571._id_BDDA _meth_8278(0);
  level._id_2571._id_BDD9 = 0;
  level._id_2571._id_BDDE = 0;
  level._id_2571._id_BDD6 = "";
}

_id_4A82(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 _meth_8278(1, var_3);
  _id_11042(var_0, var_2, var_4);

  if(scripts\engine\utility::is_true(var_5)) {
    var_0 scripts\engine\utility::delaycall(var_2 + 0.05, ::delete);
  }
}

_id_11021(var_0) {
  if(!isDefined(level._id_2571._id_BDD8)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  _id_11042(level._id_2571._id_BDDA, var_0, level._id_2571._id_BDDE);
  _id_11042(level._id_2571._id_BDD8, var_0, level._id_2571._id_BDDE);
}

_id_11042(var_0, var_1, var_2) {
  var_0 _meth_8278(0, var_1);

  if(var_2) {
    var_0 scripts\engine\utility::delaycall(var_1 + 0.05, ::stoploopsound);
  } else {
    var_0 scripts\engine\utility::delaycall(var_1 + 0.05, ::stopsounds);
  }
}

_id_CE21(var_0, var_1) {
  thread _id_CE22(var_0, var_1);
}

_id_CE22(var_0, var_1) {
  var_2 = _id_13EB(var_1);

  if(isDefined(var_2) == 0) {
    return;
  }
  var_2._id_10475 = var_0;
  var_2 playSound(var_0, "sounddone");
  var_2 waittill("sounddone");
  var_2 _id_13EC();
}

_id_CD7B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  thread _id_CD7C(var_0, var_1, var_2, var_3, var_4);
}

_id_CD7C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::spawn_tag_origin(var_1);

  if(isDefined(var_2)) {
    var_5 _meth_8278(0);
  }

  var_5 playLoopSound(var_0);

  if(isDefined(var_2)) {
    var_5 _meth_8278(1, var_2);
  }

  if(isDefined(var_3)) {
    level waittill(var_3);
    var_5 scripts\sp\utility::_id_10460(var_4);
  }
}

_id_CE24(var_0, var_1, var_2) {
  thread _id_CE25(var_0, var_1, var_2);
}

_id_CE25(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_2)) {
    wait(var_1);
    _id_CE21(var_0, var_2);
  } else if(isDefined(self)) {
    wait(var_1);
    self playSound(var_0);
  }
}

_id_11E3(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) == 0) {
    var_3 = 0;
  }

  if(isDefined(var_4) == 0) {
    var_4 = 0;
  }

  var_5 = (-1.0 * var_4, -1.0 * var_3, 0);
  var_6 = anglesToForward(var_1 + var_5);
  var_7 = var_0 + var_6 * var_2;
  return var_7;
}

_id_CE26(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) == 0) {
    var_1 = 1024;
  }

  var_5 = self.origin;
  var_6 = self.angles;

  if(self == level.player) {
    var_5 = level.player getvieworigin();

    if(var_4 == 1) {
      var_6 = level.player getplayerangles();
    }
  }

  var_7 = _id_11E3(var_5, var_6, var_1, var_2, var_3);
  _id_CE22(var_0, var_7);
}

_id_CE27(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _id_DCC4(var_1, var_2, 1024);
  var_9 = _id_DCC4(var_3, var_4, 0);
  var_10 = _id_DCC4(var_5, var_6, 0);
  _id_CE26(var_0, var_8, var_9, var_10, var_7);
}

_id_CE29(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 1024;
  }

  if(isDefined(var_2)) {
    var_4 = self.origin + (anglestoleft(self.angles) * var_2 + anglesToForward(self.angles) * var_1);
  } else {
    var_4 = self.origin + anglesToForward(self.angles) * var_1;
  }

  if(isDefined(var_3)) {
    wait(var_3);
  }

  _id_CE21(var_0, var_4);
}

_id_CCC7(var_0, var_1) {
  var_2 = _id_13EB(var_1);

  if(isDefined(var_2) == 0) {
    return;
  }
  var_2._id_10475 = var_0;
  var_2 playSound(var_0);

  while(iscinematicplaying() == 0) {
    scripts\engine\utility::waitframe();
  }

  while(iscinematicplaying() == 1) {
    scripts\engine\utility::waitframe();
  }

  var_2 stopsounds();
  var_2 _id_13EC();
}

_id_5E68() {
  level.player playSound("sa_scn_dropship_plr_exit_seat_lr_01");
}

_id_5E53() {
  self playSound("sa_scn_dropship_npc_exit_seat");
}

_id_5DBA() {
  self playSound("sa_scn_dropship_door_open");
}

_id_13EA(var_0, var_1) {
  self endon("death");
  self endon("stop_doppler");

  if(var_0 == 1 && isDefined(level.player._id_1213) == 0) {
    level.player._id_1213 = spawnStruct();
    level.player._id_1213._id_C717 = level.player getvieworigin();
    level.player._id_1213.velocity = 0;
    waittillframeend;
  }

  while(level._id_2571._id_5A61.size > 0) {
    if(isDefined(level.player._id_1213) == 1) {
      var_2 = level.player getvieworigin();
      level.player._id_1213.velocity = var_2 - level.player._id_1213._id_C717;
      level.player._id_1213._id_C717 = var_2;
    }

    level._id_2571._id_5A61 = scripts\engine\utility::array_removeundefined(level._id_2571._id_5A61);
    scripts\engine\utility::waitframe();
  }

  level thread _id_13E9();
}

_id_13E9() {
  level._id_2571._id_5A61 = scripts\engine\utility::array_removeundefined(level._id_2571._id_5A61);

  if(isDefined(level.player._id_1213) == 1) {
    level.player._id_1213 = undefined;
  }
}

_id_13E8() {
  while(isent(self) == 1) {
    if(isDefined(self.active) && self.active == 0) {
      level._id_2571._id_5A61 = scripts\engine\utility::array_remove(level._id_2571._id_5A61, self);
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level._id_2571._id_5A61 = scripts\engine\utility::array_removeundefined(level._id_2571._id_5A61);
}

_id_FB6F(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("deleted");
  self endon("destroyed");
  self endon("entitydeleted");
  self endon("stop_doppler");
  var_4 = 32;
  var_5 = (0, 0, 0);
  var_6 = 39.3701;
  var_7 = 343.3 * var_6;

  if(isDefined(var_0) == 0) {
    var_0 = 1.0;
  }

  if(isDefined(var_1) == 0) {
    var_1 = 1.0;
  }

  if(isDefined(var_2) == 0) {
    var_2 = 1.0;
  }

  if(isDefined(var_3) == 0) {
    var_3 = 0;
  }

  if(scripts\engine\utility::array_contains(level._id_2571._id_5A61, self) == 1) {
    return;
  } else if(level._id_2571._id_5A61.size < var_4) {
    level._id_2571._id_5A61 = scripts\engine\utility::array_add(level._id_2571._id_5A61, self);
    thread _id_13E8();
  } else
    return;

  if(isDefined(level.player._id_1213) == 0) {
    var_8 = var_2 > 0;
    level.player thread _id_13EA(var_8, var_3);
  }

  if(isDefined(self._id_1213) == 0) {
    self._id_1213 = spawnStruct();
    self._id_1213._id_C717 = self.origin;
    self._id_1213._id_EB9C = var_0;
    self._id_1213._id_CBF7 = var_1;
    self._id_1213._id_D45D = var_2;
  }

  while(isent(self) == 1) {
    var_9 = level.player getvieworigin();
    var_10 = var_5;

    if(isDefined(level.player._id_1213) == 1 && isDefined(level.player._id_1213.velocity) == 1) {
      var_10 = level.player._id_1213.velocity;
    }

    var_11 = self getorigin();
    var_12 = var_11 - self._id_1213._id_C717;
    self._id_1213._id_C717 = var_11;
    var_13 = var_11 - var_9;
    var_14 = length(var_13);
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;

    if(var_12 != var_5) {
      var_18 = vectordot(var_12, var_13) / var_14;
      var_15 = var_18 * self._id_1213._id_EB9C;
      var_17 = var_15;
    }

    if(self._id_1213._id_D45D > 0 && isDefined(var_10) == 1 && var_10 != var_5) {
      var_19 = vectordot(var_10, var_13) / var_14;
      var_16 = var_19 * self._id_1213._id_EB9C * self._id_1213._id_D45D;
      var_17 = var_17 + var_16;
    }

    var_20 = (var_7 - var_15) / (var_7 - var_16);
    self _meth_8277(clamp(var_20 * self._id_1213._id_CBF7, 0.0, 4.0), 0.05);
    scripts\engine\utility::waitframe();
  }
}

_id_13EB(var_0, var_1) {
  if(level._id_2571._id_664B._id_6602 < level._id_2571._id_664B._id_6668) {
    for(var_2 = 0; var_2 < level._id_2571._id_664B._id_6668; var_2++) {
      var_3 = level._id_2571._id_664B._id_6664[var_2];

      if(var_3.active == 0) {
        if(isDefined(var_1) == 0 && isDefined(self.angles) == 1) {
          var_1 = self.angles;
        }

        if(isDefined(var_0) == 0 && isDefined(self.origin) == 1) {
          var_0 = self.origin;
        }

        var_3 dontinterpolate();

        if(isDefined(var_0) == 1) {
          var_3.origin = var_0;
        }

        if(isDefined(var_1) == 1) {
          var_3.angles = var_1;
        }

        var_3 _meth_8278(1);
        var_3 _meth_8277(1);
        var_3.active = 1;
        level._id_2571._id_664B._id_6602 = level._id_2571._id_664B._id_6602 + 1;
        return var_3;
      }
    }
  }

  return undefined;
}

_id_13EC() {
  var_0 = (0, 0, 0);

  while(self _meth_81CB()) {
    scripts\engine\utility::waitframe();
  }

  self notify("death");
  self notify("deleted");
  self notify("destroyed");
  self notify("entitydeleted");
  self notify("movedone");
  self notify("stop_doppler");
  self._id_10475 = undefined;
  self._id_ACE7 = undefined;
  self._id_ACE4 = undefined;
  self unlink();
  self dontinterpolate();
  self.origin = var_0;
  self.angles = var_0;
  self.active = 0;
  level._id_2571._id_664B._id_6602 = level._id_2571._id_664B._id_6602 - 1;
}

_id_13ED(var_0) {
  var_1 = (0, 0, 0);

  if(isDefined(level._id_2571._id_664B) == 1) {
    return;
  }
  level._id_2571._id_664B = spawnStruct();
  level._id_2571._id_664B._id_6664 = [];
  level._id_2571._id_664B._id_6668 = var_0;
  level._id_2571._id_664B._id_6602 = 0;

  for(var_2 = 0; var_2 < level._id_2571._id_664B._id_6668; var_2++) {
    var_3 = spawn("script_origin", var_1);
    var_3 _meth_8278(1);
    var_3 _meth_8277(1);
    var_3.active = 0;
    level._id_2571._id_664B._id_6664[var_2] = var_3;
  }
}

_id_13EE() {
  for(var_0 = 0; var_0 < level._id_2571._id_664B._id_6668; var_0++) {
    var_1 = level._id_2571._id_664B._id_6664[var_0];
    var_1 notify("stop_sfx_emitter");
    var_1 delete();
    level._id_2571._id_664B._id_6664[var_0] = undefined;
  }

  level._id_2571._id_664B._id_6664 = undefined;
  level._id_2571._id_664B = undefined;
}

_id_13E5() {
  var_0 = undefined;
  var_1 = "unknown";

  if(isDefined(self.origin) == 1) {
    var_0 = self.origin;

    if(isDefined(self._id_10475) == 1) {
      var_1 = self._id_10475;
    }
  } else if(isDefined(self.v) == 1) {
    if(scripts\engine\utility::string_starts_with(self.v["type"], "soundfx") == 1) {
      var_0 = self.v["origin"];

      if(isDefined(self.v["soundalias"]) == 1) {
        var_1 = self.v["soundalias"];
      }
    }
  }

  if(isDefined(var_0) == 1) {
    var_2 = scripts\engine\utility::within_fov(level.player getvieworigin(), level.player getplayerangles(), var_0, cos(getdvarfloat("cg_fov")));

    if(var_2 == 1) {
      var_3 = (1, 1, 1);
      var_4 = getdvarfloat("snd_debugShipAssaultRadius");

      if(isDefined(var_1) == 1) {}

      if(isDefined(self._id_ACE7) == 1 && isDefined(self._id_ACE4) == 1) {
        var_5 = (var_4, 0, 0);
        var_6 = (0, var_4, 0);
        var_7 = (0, 0, var_4);
      }
    }
  }
}

_id_13E4(var_0) {
  if(isDefined(level._id_2571) && isDefined(level._id_2571._id_5A61) == 1) {
    return;
  }
}

_id_13E6(var_0) {
  if(isDefined(level._id_2571) == 0) {
    return;
  }
  if(isDefined(level._id_2571._id_664B) == 0) {
    return;
  }
  var_1 = (1, 1, 1);

  if(level._id_2571._id_664B._id_6602 >= level._id_2571._id_664B._id_6668 - 1) {
    var_1 = (1, 0.5, 0.5);
  }

  if(var_0 > 1) {
    for(var_2 = 0; var_2 < level._id_2571._id_664B._id_6668; var_2++) {
      var_3 = level._id_2571._id_664B._id_6664[var_2];

      if(scripts\engine\utility::is_true(var_3.active == 1)) {
        var_3 _id_13E5();
      }
    }
  }
}

_id_13E3(var_0) {
  if(isDefined(level.createfxent) == 0) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
    var_4 = level.createfxent[var_3];

    if(isDefined(var_4.v["type"]) == 0) {
      continue;
    }
    if(var_4.v["type"] == "soundfx") {
      var_1++;
    }

    if(var_4.v["type"] == "soundfx_interval") {
      var_2++;
    }
  }

  if(var_0 > 2) {
    for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
      var_4 = level.createfxent[var_3];

      if(scripts\engine\utility::string_starts_with(var_4.v["type"], "soundfx") == 1) {
        var_4 _id_13E5();
      }
    }
  }
}

_id_13E7() {}