/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_aud.gsc
****************************************************/

main() {
  _id_5196();
  _id_0367::_id_8E3E("berl");
  _id_7BBA();
  _id_5C22();
  level._id_11CB.intermission_music_aliases = ["mus_intermission_dlc2"];
  level._id_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_07", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  _id_0366::snd_set_mus_combat_cues_override(level._id_11CB.wave_cues);
  _id_0366::snd_zmb_set_start_intermission_music_override_callback(::start_intermission_music_override_callback);
  thread do_trippy_global_random_stuff();
  _id_0366::snd_zmb_set_map_wave_music_master_volume_scalar(0.8);
}

_id_7BBA() {
  _id_0378::_id_8DC7("player_connect_map", ::_id_7248);
  _id_0378::_id_8DC7("player_spawned", ::_id_7330);
  _id_0378::_id_8DC7("wave_begin", ::_id_A979);
  _id_0378::_id_8DC7("wave_end", ::_id_A97A);
  _id_0378::_id_8DC7("play_vignette_victim_hurt_vo", ::play_vignette_victim_hurt_vo);
  _id_0378::_id_8DC7("player_falls_into_sewer", ::player_falls_into_sewer);
  _id_0378::_id_8DC7("player_using_radio", ::player_using_radio);
  _id_0378::_id_8DC7("aud_radio_tuning", ::radio_tuning);
  _id_0378::_id_8DC7("radio_stop_using_watcher", ::radio_stop_using_watcher);
  _id_0378::_id_8DC7("aud_open_flare_crate", ::open_flare_crate);
  _id_0378::_id_8DC7("aud_flare_triggered", ::flare_triggered);
  _id_0378::_id_8DC7("start_airship_loop", ::start_airship_loop);
  _id_0378::_id_8DC7("start_straub_airship_loop", ::start_straub_airship_loop);
  _id_0378::_id_8DC7("straub_airship_entrance", ::straub_airship_entrance);
  _id_0378::_id_8DC7("stop_airship_loop", ::stop_airship_loop);
  _id_0378::_id_8DC7("blimp_projectile", ::_id_17A0);
  _id_0378::_id_8DC7("start_trap_tank", ::start_trap_tank);
  _id_0378::_id_8DC7("stop_trap_tank", ::stop_trap_tank);
  _id_0378::_id_8DC7("trap_tank_damage", ::trap_tank_damage);
  _id_0378::_id_8DC7("start_trap_cage", ::start_trap_cage);
  _id_0378::_id_8DC7("stop_trap_cage", ::stop_trap_cage);
  _id_0378::_id_8DC7("trap_cage_damage", ::trap_cage_damage);
  _id_0378::_id_8DC7("start_trap_prop", ::start_trap_prop);
  _id_0378::_id_8DC7("stop_trap_prop", ::stop_trap_prop);
  _id_0378::_id_8DC7("trap_prop_damage", ::trap_prop_damage);
  _id_0378::_id_8DC7("aud_axe_hc_amoire_open", ::axe_hc_amoire_open);
  _id_0378::_id_8DC7("aud_axe_hc_pickup_scale", ::axe_hc_pickup_scale);
  _id_0378::_id_8DC7("aud_axe_hc_place_scale_piece", ::axe_hc_place_scale_piece);
  _id_0378::_id_8DC7("aud_axe_hc_place_head", ::axe_hc_place_head);
  _id_0378::_id_8DC7("aud_axe_hc_drawer_open", ::axe_hc_drawer_open);
  _id_0378::_id_8DC7("start_droppod_descend_loop", ::start_droppod_descend_loop);
  _id_0378::_id_8DC7("stop_droppod_descend_loop", ::stop_droppod_descend_loop);
  _id_0378::_id_8DC7("droppod_ground_impact", ::droppod_ground_impact);
  _id_0378::_id_8DC7("tether_ground_impact", ::tether_ground_impact);
  _id_0378::_id_8DC7("droppod_winch_down", ::droppod_winch_down);
  _id_0378::_id_8DC7("droppod_winch_up", ::droppod_winch_up);
  _id_0378::_id_8DC7("aud_start_drop_pod_sway", ::start_drop_pod_sway);
  _id_0378::_id_8DC7("inside_droppod_submix_strt", ::inside_droppod_submix_strt);
  _id_0378::_id_8DC7("inside_droppod_submix_stp", ::inside_droppod_submix_stp);
  _id_0378::_id_8DC7("droppod_lock_in", ::droppod_lock_in);
  _id_0378::_id_8DC7("droppod_escape_fire", ::droppod_escape_fire);
  _id_0378::_id_8DC7("zombie_soul_suck", ::_id_ABF8);
  _id_0378::_id_8DC7("zombie_soul_suck_threshold", ::_id_ABF9);
  _id_0378::_id_8DC7("js_corpse_becomes_zombie", ::js_corpse_becomes_zombie);
  _id_0378::_id_8DC7("js_assassin_landing", ::js_assassin_landing);
  _id_0378::_id_8DC7("aud_bob_engine", ::bob_engine);
  _id_0378::_id_8DC7("aud_bob_smoke_attack_strt", ::bob_smoke_attack_strt);
  _id_0378::_id_8DC7("aud_bob_smoke_attack_loop", ::bob_smoke_attack_loop);
  _id_0378::_id_8DC7("aud_bob_stab_leg", ::bob_stab_leg);
  _id_0378::_id_8DC7("aud_bob_shoot_gun", ::bob_shoot_gun);
  _id_0378::_id_8DC7("wonderbuss_build_collect_battery", ::wonderbuss_build_collect_battery);
  _id_0378::_id_8DC7("wonderbuss_build_battery_door_unlock", ::wonderbuss_build_battery_door_unlock);
  _id_0378::_id_8DC7("wonderbuss_build_battery_door_lock", ::wonderbuss_build_battery_door_lock);
  _id_0378::_id_8DC7("wonderbuss_weapon_build_infusion", ::wonderbuss_weapon_build_infusion);
  _id_0378::_id_8DC7("aud_pap_move_elevator", ::pap_move_elevator);
  _id_0378::_id_8DC7("aud_pap_open_elevator", ::pap_open_elevator);
  _id_0378::_id_8DC7("aud_zep_puzzle_light_switch", ::zep_puzzle_light_switch);
  _id_0378::_id_8DC7("aud_zep_puzzle_light_switch_off", ::zep_puzzle_light_switch_off);
  _id_0378::_id_8DC7("aud_zep_puzzle_spark_arrive", ::zep_puzzle_spark_arrive);
  _id_0378::_id_8DC7("aud_zep_puzzle_spark_leave", ::zep_puzzle_spark_leave);
  _id_0378::_id_8DC7("aud_zep_puzzle_spark_loop", ::zep_puzzle_spark_loop);
  _id_0378::_id_8DC7("aud_electroschnell_overload_explo", ::electroschnell_overload_explo);
  _id_0378::_id_8DC7("aud_open_barbarosa_area_door", ::open_barbarosa_area_door);
  _id_0378::_id_8DC7("aud_close_barbarosa_area_door", ::close_barbarosa_area_door);
  _id_0378::_id_8DC7("aud_place_weapon_in_slot", ::place_weapon_in_slot);
  _id_0378::_id_8DC7("aud_statue_rotate_handler", ::statue_rotate_handler);
  _id_0378::_id_8DC7("aud_statue_wall_complete", ::statue_wall_complete);
  _id_0378::_id_8DC7("aud_place_bird", ::place_bird);
  _id_0378::_id_8DC7("aud_pickup_bird", ::pickup_bird);
  _id_0378::_id_8DC7("aud_sword_reveal", ::sword_reveal);
  _id_0378::_id_8DC7("aud_pickup_barbarosa_sword", ::pickup_barbarosa_sword);
  _id_0378::_id_8DC7("smugglers_bat_power_generator_start", ::smugglers_bat_power_generator_start);
  _id_0378::_id_8DC7("smugglers_bat_power_generator_stop", ::smugglers_bat_power_generator_stop);
  _id_0378::_id_8DC7("smugglers_bat_big_doors_open", ::smugglers_bat_big_doors_open);
  _id_0378::_id_8DC7("smugglers_bat_cash_register", ::smugglers_bat_cash_register);
  _id_0378::_id_8DC7("smugglers_bat_door_break_down", ::smugglers_bat_door_break_down);
  _id_0378::_id_8DC7("smugglers_bat_door_open_squeaky", ::smugglers_bat_door_open_squeaky);
  _id_0378::_id_8DC7("smugglers_bat_door_pound", ::smugglers_bat_door_pound);
  _id_0378::_id_8DC7("smugglers_bat_gas_cover_open_01", ::smugglers_bat_gas_cover_open_01);
  _id_0378::_id_8DC7("smugglers_bat_gas_cover_open_02", ::smugglers_bat_gas_cover_open_02);
  _id_0378::_id_8DC7("smugglers_bat_pickup", ::smugglers_bat_pickup);
  _id_0378::_id_8DC7("smugglers_bat_weapon_drop", ::smugglers_bat_weapon_drop);
  _id_0378::_id_8DC7("smugglers_bat_start_combat_loop", ::smugglers_bat_start_combat_loop);
  _id_0378::_id_8DC7("smugglers_bat_stop_combat_loop", ::smugglers_bat_stop_combat_loop);
  _id_0378::_id_8DC7("ddagger_film_canister_fall", ::ddagger_film_canister_fall);
  _id_0378::_id_8DC7("ddagger_film_canister_pickup", ::ddagger_film_canister_pickup);
  _id_0378::_id_8DC7("ddagger_picture_placement", ::ddagger_picture_placement);
  _id_0378::_id_8DC7("ddagger_picture_remove", ::ddagger_picture_remove);
  _id_0378::_id_8DC7("ddagger_projector_attach_reel", ::ddagger_projector_attach_reel);
  _id_0378::_id_8DC7("ddagger_projector_on", ::ddagger_projector_on);
  _id_0378::_id_8DC7("ddagger_vault_door_open", ::ddagger_vault_door_open);
  _id_0378::_id_8DC7("ddagger_vault_handle_open", ::ddagger_vault_handle_open);
  _id_0378::_id_8DC7("ddagger_vault_tick", ::ddagger_vault_tick);
  _id_0378::_id_8DC7("ddagger_vault_tick_success", ::ddagger_vault_tick_success);
  _id_0378::_id_8DC7("aud_dancer_jumpscare", ::dancer_jumpscare);
  _id_0378::_id_8DC7("aud_ring_bell", ::ring_bell);
}

do_trippy_global_random_stuff() {
  level._id_11CB.trippy_global_random_stuff_enabled = 1;
  thread do_trippy_global_door_pound();
  thread do_creepy_kid();
}

do_creepy_kid() {
  var_0 = 36;
  var_1 = 360;
  var_2 = 90.0;
  var_3 = 300.0;
  wait 5;

  for(;;) {
    wait(_randomfloatrange(var_2, var_3));
    var_4 = level.players[randomint(level.players.size)];

    if(isDefined(var_4) && level._id_11CB.trippy_global_random_stuff_enabled && _id_0378::_id_8D1B(0.5)) {
      var_5 = var_0 * 2 - var_0;
      var_6 = var_1 * 2 - var_1;
      var_7 = (_randomfloatrange(var_5, var_6), _randomfloatrange(var_5, var_6), 0);
      var_8 = "zmb_creepy_kid_dist";

      if(_id_0378::_id_8D1B(0.5)) {
        var_8 = "zmb_creepy_vox_fx";
      }

      var_9 = _id_0380::_id_2889(var_8, var_4, var_4.origin + var_7);
    }
  }
}

do_horror_audio_vignettes() {
  var_0 = 540;
  var_1 = 900;
  var_2 = 20;
  var_3 = 60;
  var_4 = gettime() * 1000 + var_2;
  wait 5;

  for(;;) {
    wait 2;
    var_5 = level.players[randomint(level.players.size)];

    if(isDefined(var_5) && level._id_11CB.trippy_global_random_stuff_enabled) {
      var_6 = gettime() * 1000;

      if(var_6 < var_4 || var_5 _id_0366::_id_8E14() > 0.333) {
        continue;
      }
      var_4 = _randomintrange(var_2, var_3);
      var_7 = "_ext";

      if(_id_0378::_id_8D1B(0.5)) {
        var_7 = "_int" + _randomintrange(1, 2);
      }

      var_8 = "zmb_audio_vignette_dist" + var_7;
      _id_0378::_id_8DC2("Playing " + var_8, 1);
      var_9 = calc_rnd_point_xy_offset(var_0, var_1);
      var_10 = _id_0380::_id_2889(var_8, var_5, var_5.origin + var_9);

      if(var_10) {
        _id_0380::_id_288F(var_10, var_5, "zmb_audio_vignette_dist_done");
        var_5 waittill("zmb_audio_vignette_dist_done");
      }
    }
  }
}

do_occluded_foley_vignettes() {
  var_0 = 360;
  var_1 = 540;
  var_2 = 20;
  var_3 = 60;
  wait 5;

  for(;;) {
    wait(_randomintrange(var_2, var_3));
    var_4 = level.players[randomint(level.players.size)];

    if(isDefined(var_4) && level._id_11CB.trippy_global_random_stuff_enabled) {
      var_5 = "zmb_audio_vignette_occl_foley";
      var_6 = calc_rnd_point_xy_offset(var_0, var_1);
      var_7 = var_4.origin + var_6;
      var_8 = _id_0380::_id_2889(var_5, var_4, var_7);

      if(var_8) {
        _id_0380::_id_288F(var_8, var_4, "zmb_audio_vignette_dist_done");
        var_4 waittill("zmb_audio_vignette_dist_done");
      }
    }
  }
}

calc_rnd_point_xy_offset(var_0, var_1) {
  if(randomint(2)) {
    var_2 = _randomfloatrange(var_0, var_1);
  } else {
    var_2 = _randomfloatrange(-1 * var_1, -1 * var_0);
  }

  if(randomint(2)) {
    var_3 = _randomfloatrange(var_0, var_1);
  } else {
    var_3 = _randomfloatrange(-1 * var_1, -1 * var_0);
  }

  var_4 = (var_2, var_3, 0);
  return var_4;
}

do_trippy_global_door_pound() {
  wait 5;

  for(;;) {
    var_0 = level.players[randomint(level.players.size)];

    if(isDefined(var_0) && level._id_11CB.trippy_global_random_stuff_enabled) {
      if(!_id_0366::snd_is_level_wave_active() && _getomnvar("ui_zm_round_number") > 10 && !randomint(100)) {
        _id_0380::_id_2888("zmb_trippy_door_pound", var_0);
        return;
      }
    }

    wait 60;
  }
}

start_intermission_music_override_callback() {
  var_0 = level._id_11CB.intermission_music_aliases[randomint(level._id_11CB.intermission_music_aliases.size)];
  var_1 = 3.0;
  var_2 = 5.0;
  _id_0366::_id_8E31(var_0, var_1, var_2);
}

_id_7248() {
  if(!isDefined(self._id_11CB)) {
    self._id_11CB = spawnStruct();
  }
}

_id_7330() {
  thread berlin_player_inside_outside_mixer();
  self clientaddsoundsubmix("dlc2_default_mix");
  _id_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

_id_A979(var_0) {
  var_1 = self;
  var_1 endon("disconnect");

  if(_id_0366::snd_get_auto_wave_music_enabled()) {
    self _meth_85A7("snd_randomize_ambient_mus_layers");
    waitframe();
    thread wave_mus_switcher();
  }
}

_id_A97A() {
  self notify("kill_wave_mus_switcher");
  self clientclearsoundsubmix("dlc2_plr_idle_mus_fade", 3.0);
}

wave_mus_switcher() {
  self endon("death");
  self endon("kill_wave_mus_switcher");
  self endon("disconnect");
  var_0 = self;
  var_1 = 60000;
  var_2 = 240000;
  var_3 = _randomintrange(var_1, var_2);
  var_4 = 2000;
  var_5 = 0.1;
  var_6 = gettime();
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 1;
  var_11 = var_0.origin;
  var_12 = 1;
  var_13 = 6;
  var_14 = 14;
  var_15 = 3;
  var_16 = _id_0366::snd_get_curr_combat_cue_name();
  wait 1;

  for(;;) {
    if(!_id_0366::snd_get_auto_wave_music_enabled()) {
      wait 1;
      continue;
    }

    var_17 = gettime() - var_6;
    var_18 = var_0 _id_0366::_id_8E14();
    var_19 = var_0.origin != var_11;
    var_11 = var_0.origin;
    var_20 = var_4;

    if(var_19) {
      if(!var_10) {
        var_10 = 1;
        var_9 = var_17;
      }
    } else if(var_10) {
      var_10 = 0;
      var_8 = var_17;
    }

    if(!var_19 && var_17 - var_8 > var_20 && var_18 <= var_5 && var_12) {
      var_12 = 0;
      var_0 clientaddsoundsubmix("dlc2_plr_idle_mus_fade", var_14);
    } else if(!var_12 && (var_19 || var_18 > var_5 && var_17 - var_9 > var_20 * 0.5)) {
      var_12 = 1;
      var_0 clientclearsoundsubmix("dlc2_plr_idle_mus_fade", var_13);
    } else if(var_12 && var_17 - var_7 > var_3) {
      var_7 = var_17;
      var_16 = var_0 _id_0366::_id_8D46();

      if(_id_0378::_id_8D1B(0.02)) {
        var_16 = "ravens";
      }

      var_0 _id_0366::_id_8DCF(var_16);
      _id_0366::_id_8E32(var_14);
      wait 0.1;
      _id_0366::_id_8E31(var_16, var_15);
      var_3 = _randomintrange(var_1, var_2);
    }

    wait 0.5;
  }
}

_id_5196() {}

_id_5C22() {
  thread _id_35E1();
  thread drop_pod_intro_mix();
  thread play_radio_tuner_idle_static();
}

_id_35E1() {
  wait 0.5;
  thread large_fire_textures();
  thread fire_metal_textures();
  thread small_fire_textures();
  _id_0380::_id_2889("wreckage_fire_metal_med", undefined, (232, -2213, 1188));
  _id_0380::_id_2889("wreckage_fire_metal_large", undefined, (1358, -603, 1129));
  _id_0380::_id_2889("wreckage_fire_metal_med", undefined, (1910, 1426, 1065));
  _id_0380::_id_2889("wreckage_fire_metal_med", undefined, (871, 863, 1219));
  _id_0380::_id_2889("wreckage_fire_metal_large", undefined, (651, 693, 1115));
  _id_0380::_id_2889("wreckage_fire_metal_med", undefined, (602, 1059, 1093));
  _id_0380::_id_2889("wreckage_fire_metal_small", undefined, (511, 446, 1271));
  _id_0380::_id_2889("wreckage_fire_metal_med", undefined, (637, 393, 1256));
  _id_0380::_id_2889("wreckage_fire_wood_med", undefined, (1303, -949, 1084));
  _id_0380::_id_2889("wreckage_fire_wood_large", undefined, (-433, -822, 1125));
  _id_0380::_id_2889("wreckage_fire_wood_med", undefined, (984, -1054, 1071));
  _id_0380::_id_2889("wreckage_fire_wood_med", undefined, (-243, -870, 1125));
  _id_0380::_id_2889("wreckage_fire_wood_small", undefined, (290, 206, 1127));
  _id_0380::_id_2889("wreckage_fire_wood_med", undefined, (544, 1174, 1063));
  _id_0380::_id_2889("wreckage_fire_wood_med", undefined, (-177, 1864, 1220));
  _id_0380::_id_2889("wreckage_fire_wood_small", undefined, (-452, 1428, 1196));
  _id_0380::_id_2889("wreckage_fire_wood_med", undefined, (853, -2615, 912));
  _id_0380::_id_2889("wreckage_fire_wood_small", undefined, (176, 1763, 1314));
  _id_0380::_id_2889("zmb_ber_gas_fire", undefined, (1454, 1791, 1319));
  _id_0380::_id_2889("zmb_ber_pod_wtr_spray_lp", undefined, (352, -2177, 1019));
  _id_0380::_id_2889("zmb_berl_flare_sizzle_lp", undefined, (325, 360, 1169));
  thread cellar_drop_pod_stress_handler();
}

cellar_drop_pod_stress_handler() {
  level endon("death");

  for(;;) {
    wait 2.0;
    _id_0380::_id_2889("zmb_berlin_cellar_pod_wood_stress", undefined, (218, -2221, 925));
    wait(_randomintrange(18, 38));
  }
}

large_fire_textures() {
  apartment_left_exit_wood_pile_texture();
}

apartment_left_exit_wood_pile_texture() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_texture_lrg", undefined, (-433, -822, 1125));
    wait(_randomintrange(7, 15));
  }
}

fire_metal_textures() {
  cellar_drop_pod_metal_stress();
  club_entrance_truck_metal_stress();
  cathedral_truck_metal_stress();
  crashed_plane_01_metal_stress_01();
  crashed_plane_01_metal_stress_02();
  crashed_plane_02_metal_stress();
}

cellar_drop_pod_metal_stress() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_mtl_stress", undefined, (232, -2213, 1188));
    wait(_randomintrange(7, 12));
  }
}

club_entrance_truck_metal_stress() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_mtl_stress", undefined, (1358, -603, 1129));
    wait(_randomintrange(7, 12));
  }
}

cathedral_truck_metal_stress() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_mtl_stress", undefined, (1910, 1426, 1065));
    wait(_randomintrange(7, 12));
  }
}

crashed_plane_01_metal_stress_01() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_mtl_stress", undefined, (651, 693, 1115));
    wait(_randomintrange(7, 12));
  }
}

crashed_plane_01_metal_stress_02() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_mtl_stress", undefined, (637, 393, 1256));
    wait(_randomintrange(7, 12));
  }
}

crashed_plane_02_metal_stress() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_mtl_stress", undefined, (602, 1059, 1093));
    wait(_randomintrange(7, 12));
  }
}

small_fire_textures() {
  crashed_plane_wood_and_rubble_texture();
  barbed_wire_between_cathedral_and_museum();
}

crashed_plane_wood_and_rubble_texture() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_texture_sml", undefined, (544, 1174, 1063));
    wait(_randomintrange(7, 15));
  }
}

barbed_wire_between_cathedral_and_museum() {
  level endon("death");

  for(;;) {
    _id_0380::_id_2889("zmb_ber_fire_texture_sml", undefined, (-452, 1428, 1196));
    wait(_randomintrange(7, 15));
  }
}

play_vignette_victim_hurt_vo(var_0) {
  _id_0380::_id_6844("zmb_vignettes_gsld1_hurt", undefined, var_0);
}

player_falls_into_sewer() {
  if(isDefined(self)) {
    var_0 = self;
    _id_0380::_id_288B("zmb_berl_fall_into_sewer_debris", undefined, var_0);
    _id_0380::_id_288B("zmb_berl_fall_into_sewer_foley", undefined, var_0);
    _id_0380::_id_288B("zmb_berl_fall_into_sewer_trans", undefined, var_0);
  }
}

play_radio_tuner_idle_static() {
  wait 0.5;
  var_0 = _getEnt("radio_tuner_link_org", "targetname");
  level._id_11CB.radio_tuner_idle_static_lp = _id_0380::_id_6844("zmb_berl_radio_idle_lp", undefined, var_0, 0.2);
}

player_using_radio() {
  var_0 = self;
  var_0 clientaddsoundsubmix("radio_interact_mix");
}

radio_tuning(var_0, var_1) {
  var_2 = _getEnt("radio_tuner_link_org", "targetname");

  switch (var_0) {
    case "tuning":
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 0, 0.4);
      level._id_11CB.tuning_radio_lp = _id_0380::_id_6844("zmb_berl_radio_tune_lp", undefined, var_2, 0.1);
      break;
    case "idle":
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 1, 0.1);
      _id_0380::_id_6850(level._id_11CB.tuning_radio_lp, 0.5);
      break;
    case "dialog_playing":
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 0, 0.4);
      _id_0380::_id_6850(level._id_11CB.tuning_radio_lp, 0.2);
      _id_0380::_id_288B("zmb_berl_radio_rply_sfx", undefined, var_2);
      level._id_11CB.radio_reply_vo = _id_0380::_id_6844(var_1, undefined, var_2);
      _id_0380::_id_684C(level._id_11CB.radio_reply_vo, var_2, "radio_vo_done");
      var_2 waittill("radio_vo_done");
      level notify("radio_response_done");
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 1, 0.2);
      break;
    case "morse_code":
      common_scripts\utility::flag_init("morse_code_freq_changed");
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 0.5, 0.2);

      if(isDefined(level._id_11CB.tuning_radio_lp)) {
        _id_0380::_id_6850(level._id_11CB.tuning_radio_lp, 0.2);
      }

      _id_0380::_id_288B("zmb_berl_radio_morse_strt", undefined, var_2);
      level._id_11CB.radio_reply_vo = _id_0380::_id_6844(var_1, undefined, var_2);
      _id_0380::_id_684C(level._id_11CB.radio_reply_vo, var_2, "radio_vo_done");
      var_2 waittill("radio_vo_done");
      level notify("radio_response_done");
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 1, 0.4);
      morse_code_loop_watcher(var_1, var_2);
      break;
    case "smuggler_dialog_playing":
      var_3 = var_2.origin;
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 0, 0.4);
      _id_0380::_id_6850(level._id_11CB.tuning_radio_lp, 0.2);
      var_4 = _id_0380::_id_6842(var_1, undefined, var_3);
      _id_0380::_id_684C(var_4, var_2, "smuggler_vo_1_done");
      _id_0380::_id_288B("zmb_ber_smgler_sfx_a", undefined, var_2);
      var_2 waittill("smuggler_vo_1_done");
      wait 0.2;
      level.player_using_radio _id_0367::_id_8E3C("hc_smuggler_intro");
      wait 0.4;
      var_5 = _id_0380::_id_6842("zmb_berl_gsmg_hc_smuggler_stuck", undefined, var_3);
      _id_0380::_id_684C(var_5, var_2, "smuggler_vo_2_done");
      _id_0380::_id_288B("zmb_ber_smgler_sfx_b", undefined, var_2);
      var_2 waittill("smuggler_vo_2_done");
      wait 0.3;
      level.player_using_radio _id_0367::_id_8E3C("hc_smuggler_react");
      level notify("radio_response_done");
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 1, 0.2);
      break;
  }
}

morse_code_loop_watcher(var_0, var_1) {
  level endon("game_over");
  var_2 = 2;

  for(;;) {
    var_3 = level.bat_hc_radio_code_left;
    var_4 = level.tuner_values["radio_tuner"]["left"];
    var_5 = _abs(var_4 - var_3);
    var_6 = level.bat_hc_radio_code_right;
    var_7 = level.tuner_values["radio_tuner"]["right"];
    var_8 = _abs(var_7 - var_6);

    if(var_5 <= var_2 && var_8 <= var_2) {
      thread morse_code_loop(var_0, var_1);

      while(var_5 <= var_2 && var_8 <= var_2) {
        waitframe();
        var_4 = level.tuner_values["radio_tuner"]["left"];
        var_5 = _abs(var_4 - var_3);
        var_7 = level.tuner_values["radio_tuner"]["right"];
        var_8 = _abs(var_7 - var_6);
      }

      common_scripts\utility::flag_set("morse_code_freq_changed");
      waitframe();
      common_scripts\utility::_id_3C7B("morse_code_freq_changed");
      _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 1, 0.1);
      _id_0380::_stoplocalsound(level._id_11CB.morse_code_loop_snd, 0.2);
      _id_0380::_id_288B("zmb_berl_radio_morse_end", undefined, var_1);
      continue;
    }

    wait 0.25;
  }
}

morse_code_loop(var_0, var_1) {
  level endon("morse_code_freq_changed");
  var_2 = 1.5;
  wait(var_2);
  _id_0380::_id_288B("zmb_berl_radio_morse_strt", undefined, var_1);
  wait 0.2;

  while(!common_scripts\utility::_id_3C77("morse_code_freq_changed")) {
    _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 0.5, 0.2);
    level._id_11CB.morse_code_loop_snd = _id_0380::_id_288B(var_0, undefined, var_1);
    _id_0380::_id_288F(level._id_11CB.morse_code_loop_snd, var_1, "morse_code_done");
    var_1 waittill("morse_code_done");
    wait(var_2);
  }
}

radio_stop_using_watcher() {
  self endon("death");
  self endon("disconnect");
  var_0 = self;
  var_1 = _getEnt("radio_tuner_link_org", "targetname");
  self waittill("stop_using_station");
  var_0 clientclearsoundsubmix("radio_interact_mix");
  _id_0380::_id_684E(level._id_11CB.radio_tuner_idle_static_lp, 1, 0.2);
  _id_0380::_id_6850(level._id_11CB.tuning_radio_lp, 0.3);
}

open_flare_crate(var_0) {
  _id_0380::_id_2889("zmb_berl_flare_box_open", undefined, var_0);
}

flare_triggered(var_0) {
  _id_0380::_id_2889("hur_clearing_flare", undefined, var_0);
}

snd_mute_horror_audio_vignettes() {
  self clientaddsoundsubmix("mute_horror_audio_vignettes");
}

drop_pod_intro_mix() {
  for(;;) {
    if(isDefined(level.players)) {
      foreach(var_1 in level.players) {
        var_1 clientaddsoundsubmix("berl_zepp_intro_mix");
        level waittill("zombie_wave_ended");
        var_1 clientclearsoundsubmix("berl_zepp_intro_mix");
        return;
      }
    }

    wait 0.2;
  }
}

berlin_player_inside_outside_mixer() {
  self endon("disconnect");
  var_0 = 0.5;
  wait 0.5;
  var_1 = snd_is_outside(self);

  if(!var_1) {
    self clientaddsoundsubmix("player_inside", 1.0);
  }

  var_2 = self._id_295A;
  level._id_11CB.airship_zones = ["zone_airship", "zone_airship_middle_front", "zone_airship_left", "zone_airship_right"];

  for(;;) {
    var_3 = snd_is_outside(self);

    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(var_2)) {
      var_2 = "";
    }

    if(var_3 != var_1 || isDefined(self._id_295A) && self._id_295A != var_2) {
      var_2 = self._id_295A;

      if(var_3) {
        self clientclearsoundsubmix("player_inside", 1.0);
        self clientclearsoundsubmix("player_inside_airship", 1.0);
      } else {
        var_4 = 0;

        foreach(var_6 in level._id_11CB.airship_zones) {
          if(_id_055A::_id_7413(self, var_6)) {
            var_4 = 1;
            break;
          }
        }

        if(var_4) {
          self clientaddsoundsubmix("player_inside_airship", 1.0);
          self clientclearsoundsubmix("player_inside", 1.0);
        } else {
          self clientaddsoundsubmix("player_inside", 1.0);
          self clientclearsoundsubmix("player_inside_airship", 1.0);
        }
      }

      var_1 = var_3;
    }

    wait(var_0);
  }
}

snd_is_outside(var_0) {
  return _id_055A::_id_7413(var_0, "zone_street") || _id_055A::_id_7413(var_0, "zone_church_garden");
}

start_airship_loop() {
  var_0 = self;
  self.airship_engine_loop = _id_0380::_id_6846("zmb_berl_zepp_lp", undefined, var_0, 1.0);
  self.airship_engine_loop2 = _id_0380::_id_6846("zmb_berl_zepp_eng_lp", undefined, var_0, 1.0);
}

start_straub_airship_loop() {
  var_0 = self;
  self.airship_engine_loop = _id_0380::_id_6846("zmb_straub_blimp_engine_lp", undefined, var_0, 2.0);
  self.airship_engine_loop2 = _id_0380::_id_6846("zmb_straub_blimp_engine_lfe_lp", undefined, var_0, 2.0);
  self.airship_engine_loop3 = _id_0380::_id_6846("zmb_straub_blimp_engine_lfe_lp2", undefined, var_0, 2.0);
}

straub_airship_entrance() {
  var_0 = self;
  _id_0380::_id_6844("zmb_berl_straub_zepp_enter", undefined, var_0);
}

stop_airship_loop(var_0) {
  var_1 = self;

  if(isDefined(self.airship_engine_loop)) {
    _id_0380::_id_6850(self.airship_engine_loop, var_0);
    self.airship_engine_loop = undefined;
  }

  if(isDefined(self.airship_engine_loop2)) {
    _id_0380::_id_6850(self.airship_engine_loop2, var_0);
    self.airship_engine_loop2 = undefined;
  }

  if(isDefined(self.airship_engine_loop3)) {
    _id_0380::_id_6850(self.airship_engine_loop3, var_0);
    self.airship_engine_loop3 = undefined;
  }
}

_id_17A0() {
  var_0 = self;
  _id_0380::_id_288B("zmb_artillery_cannon_shot", undefined, var_0);
}

start_trap_tank(var_0, var_1) {
  var_2 = self.origin;
  _id_0380::_id_2889("zmb_berl_trap_water_activate", undefined, var_2);
  wait 0.6;
  self.trap_elec_lp1 = _id_0380::_id_6842("trap_elec_arc_lp", undefined, var_2, var_0);
  self.trap_elec_lp2 = _id_0380::_id_6842("trap_elec_crackle_lp", undefined, var_2, var_0);
  self.trap_elec_lp3 = _id_0380::_id_6842("trap_elec_hiss_lp", undefined, var_2, var_0);
  self.trap_elec_lp4 = _id_0380::_id_6842("trap_elec_hum_lp", undefined, var_2, var_0);
  self.trap_arc_sfx = undefined;
  var_3 = 0;

  while(var_3 < var_1) {
    var_4 = _randomintrange(1, 2);

    if(var_4 == 1) {
      self.trap_arc_sfx = _id_0380::_id_2889("trap_elec_arc", undefined, var_2);
    }

    var_3++;
    wait 1;
  }
}

stop_trap_tank() {
  var_0 = self.origin;
  _id_0380::_id_6850(self.trap_elec_lp1);
  _id_0380::_id_6850(self.trap_elec_lp2);
  _id_0380::_id_6850(self.trap_elec_lp3);
  _id_0380::_id_6850(self.trap_elec_lp4);
  _id_0380::_stoplocalsound(self.trap_arc_sfx);
  _id_0380::_id_2889("trap_elec_stop", undefined, var_0);
}

trap_tank_damage() {
  var_0 = self.origin;
  _id_0380::_id_2889("trap_elec_kill", undefined, var_0);
}

start_trap_cage(var_0, var_1) {
  var_2 = self.origin;
  _id_0380::_id_2889("zmb_berl_trap_cage_activate", undefined, var_2);
  wait 0.6;
  self.trap_elec_lp1 = _id_0380::_id_6842("trap_elec_arc_lp", undefined, var_2, var_0);
  self.trap_elec_lp2 = _id_0380::_id_6842("trap_elec_crackle_lp", undefined, var_2, var_0);
  self.trap_elec_lp3 = _id_0380::_id_6842("trap_elec_hiss_lp", undefined, var_2, var_0);
  self.trap_elec_lp4 = _id_0380::_id_6842("trap_elec_hum_lp", undefined, var_2, var_0);
  self.trap_arc_sfx = undefined;
  var_3 = 0;

  while(var_3 < var_1) {
    var_4 = _randomintrange(1, 3);

    if(var_4 == 1) {
      self.trap_arc_sfx = _id_0380::_id_2889("trap_elec_arc", undefined, var_2);
    } else if(var_4 == 2) {
      self.trap_arc_sfx = _id_0380::_id_2889("zmb_berl_trap_cage_spark", undefined, var_2);
    }

    var_3++;
    wait 1;
  }
}

stop_trap_cage() {
  var_0 = self.origin;
  _id_0380::_id_6850(self.trap_elec_lp1);
  _id_0380::_id_6850(self.trap_elec_lp2);
  _id_0380::_id_6850(self.trap_elec_lp3);
  _id_0380::_id_6850(self.trap_elec_lp4);
  _id_0380::_stoplocalsound(self.trap_arc_sfx);
  _id_0380::_id_2889("trap_elec_stop", undefined, var_0);
}

trap_cage_damage() {
  var_0 = self.origin;
  _id_0380::_id_2889("trap_elec_kill", undefined, var_0);
}

start_trap_prop(var_0) {
  var_1 = self.origin;
  _id_0380::_id_2889("zmb_berl_trap_prop_start", undefined, var_1);
  wait 0.6;
  self.trap_prop_lp1 = _id_0380::_id_6842("zmb_berl_trap_prop_lp", undefined, var_1, var_0);
  self.trap_prop_lp2 = _id_0380::_id_6842("zmb_berl_trap_prop_lp2", undefined, var_1, var_0);
  self.trap_prop_lp3 = _id_0380::_id_6842("zmb_berl_trap_prop_lp3", undefined, var_1, var_0);
}

stop_trap_prop() {
  var_0 = self.origin;
  _id_0380::_id_6850(self.trap_prop_lp1);
  _id_0380::_id_6850(self.trap_prop_lp2);
  _id_0380::_id_6850(self.trap_prop_lp3);
  _id_0380::_id_2889("zmb_berl_trap_prop_stop", undefined, var_0);
}

trap_prop_damage() {
  var_0 = self.origin;
  _id_0380::_id_2889("zmb_berl_trap_prop_hit", undefined, var_0);
}

axe_hc_amoire_open() {
  var_0 = self;
  _id_0380::_id_288B("zmb_berl_axe_hc_armoire_open", undefined, var_0);
}

axe_hc_pickup_scale(var_0) {
  _id_0380::_id_2889("zmb_berl_axe_hc_scale_pu", undefined, var_0);
}

axe_hc_place_scale_piece(var_0) {
  _id_0380::_id_288B("zmb_berl_axe_hc_place_scale_piece", undefined, var_0);
}

axe_hc_place_head(var_0) {
  _id_0380::_id_288B("zmb_berl_axe_hc_place_head", undefined, var_0);
}

axe_hc_drawer_open(var_0) {
  _id_0380::_id_288B("zmb_berl_axe_hc_drawer_open", undefined, var_0);
}

tether_ground_impact() {
  if(self == level.anchor_courtyard) {
    _id_0380::_id_6844("zmb_berl_tether_impact_court", undefined, self);
  } else {
    _id_0380::_id_6844("zmb_berl_tether_impact", undefined, self);
  }
}

start_droppod_descend_loop() {
  var_0 = self;
  level._id_11CB.droppod_descend_pulley = _id_0380::_id_6844("zmb_berl_droppod_descend_pulley", undefined, var_0);
  level._id_11CB.droppod_descend_wind_loop = _id_0380::_id_6844("zmb_berl_droppod_descend_wind_lp", undefined, var_0, 1.5);
  level._id_11CB.droppod_descend_rattle_loop = _id_0380::_id_6844("zmb_berl_droppod_descend_rattle_lp", undefined, var_0, 1.5);
  droppod_descend_bangs();
}

stop_droppod_descend_loop() {
  var_0 = self;
  _id_0380::_id_6844("zmb_berl_droppod_descend_stop", undefined, var_0);

  if(isDefined(level._id_11CB.droppod_descend_pulley)) {
    _id_0380::_id_6850(level._id_11CB.droppod_descend_pulley, 0.25);
    level._id_11CB.droppod_descend_pulley = undefined;
  }

  if(isDefined(level._id_11CB.droppod_descend_wind_loop)) {
    _id_0380::_id_6850(level._id_11CB.droppod_descend_wind_loop, 0.25);
    level._id_11CB.droppod_descend_wind_loop = undefined;
  }

  if(isDefined(level._id_11CB.droppod_descend_rattle_loop)) {
    _id_0380::_id_6850(level._id_11CB.droppod_descend_rattle_loop, 0.25);
    level._id_11CB.droppod_descend_rattle_loop = undefined;
  }
}

stop_droppod_winch_up_loop() {
  if(isDefined(level._id_11CB.droppod_winch_up_loop)) {
    _id_0380::_id_6850(level._id_11CB.droppod_winch_up_loop, 0.25);
    level._id_11CB.droppod_winch_up_loop = undefined;
  }

  if(isDefined(level._id_11CB.droppod_ascend_rattle_loop)) {
    _id_0380::_id_6850(level._id_11CB.droppod_ascend_rattle_loop, 0.25);
    level._id_11CB.droppod_ascend_rattle_loop = undefined;
  }
}

droppod_descend_bangs() {
  var_0 = 0.5;
  var_1 = 1.5;
  level endon("airship_drop_pod_reached_ground");
  level endon("stop_move_down_rumble");

  for(;;) {
    var_2 = _randomfloatrange(var_0, var_1);
    wait(var_2);
    _id_0380::_id_6840("zmb_berl_droppod_bang", undefined);
  }
}

droppod_ground_impact() {
  var_0 = self;
  _id_0380::_id_6844("zmb_berl_droppod_descend_impact", undefined, var_0);
  stop_droppod_descend_loop();
}

start_drop_pod_sway() {
  thread drop_pod_sway_1();
  thread drop_pod_sway_2();
  thread drop_pod_sway_3();
  thread drop_pod_sway_4();
}

inside_droppod_submix_strt() {
  foreach(var_1 in level.players) {
    var_1 clientaddsoundsubmix("inside_droppod");
  }
}

inside_droppod_submix_stp() {
  foreach(var_1 in level.players) {
    var_1 clientclearsoundsubmix("inside_droppod");
  }
}

drop_pod_sway_1() {
  level endon("airship_escape_drop_pod_doors_complete");

  for(;;) {
    var_0 = _randomintrange(4, 6);
    _id_0380::_id_6842("zmb_berl_pod_sway_low", undefined, (251, 9116, -2889));
    wait(var_0);
  }
}

drop_pod_sway_2() {
  level endon("airship_escape_drop_pod_doors_complete");

  for(;;) {
    var_0 = _randomintrange(4, 6);
    _id_0380::_id_6842("zmb_berl_pod_sway_low", undefined, (1184, 9096, -2889));
    wait(var_0);
  }
}

drop_pod_sway_3() {
  level endon("airship_escape_drop_pod_doors_complete");

  for(;;) {
    var_0 = _randomintrange(4, 6);
    _id_0380::_id_6842("zmb_berl_pod_sway_low", undefined, (1264, 8153, -2889));
    wait(var_0);
  }
}

drop_pod_sway_4() {
  level endon("airship_escape_drop_pod_doors_complete");

  for(;;) {
    var_0 = _randomintrange(4, 6);
    _id_0380::_id_6842("zmb_berl_pod_sway_low", undefined, (320, 8148, -2889));
    wait(var_0);
  }
}

droppod_winch_up() {
  var_0 = self;

  if(isDefined(level._id_11CB.droppod_descend_wind_loop)) {
    stop_droppod_descend_loop();
  }

  _id_0380::_id_6844("zmb_berl_droppod_winch_start", undefined, var_0);
  level._id_11CB.droppod_winch_up_loop = _id_0380::_id_6844("zmb_berl_droppod_winch_lp", undefined, var_0, 1.75);
  level._id_11CB.droppod_ascend_rattle_loop = _id_0380::_id_6844("zmb_berl_droppod_ascend_rattle_lp", undefined, var_0, 1.75);
}

droppod_winch_down() {
  var_0 = self;
  stop_droppod_winch_up_loop();
  _id_0380::_id_6844("zmb_berl_droppod_winch_stop", undefined, var_0);
  start_droppod_descend_loop();
}

droppod_lock_in() {
  var_0 = self;
  stop_droppod_winch_up_loop();
  _id_0380::_id_2888("zmb_berl_droppod_ascend_lock_in", var_0);
}

droppod_escape_fire() {
  var_0 = self;
  _id_0380::_id_6844("zmb_berl_droppod_escape", undefined, var_0);
  zepplin_damaged_cleanup();
}

_id_ABF8(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  var_2 moveTo(var_1, 1.9);
  wait 2.0;
  var_2 delete();
}

_id_ABF9(var_0) {
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_0);
}

js_corpse_becomes_zombie() {
  _id_0366::snd_not_so_simple_jump_scare();
}

js_assassin_landing() {
  _id_0366::snd_not_so_simple_jump_scare();
}

bob_engine(var_0) {
  var_1 = self;
  thread handle_bob_spawned_music();
  thread bob_spawned_submix();

  switch (var_0) {
    case "bob_punch":
      level._id_11CB.bob_engine_loop = _id_0380::_id_6844("zmb_berl_bob_engine_lp", undefined, var_1, 0.2);
      level._id_11CB.bob_engine_loop_hi = _id_0380::_id_6844("zmb_berl_bob_engine_hi_lp", undefined, var_1, 0.2);
      level._id_11CB.curr_phase = "bob_punch";
      break;
    case "bob_smoke":
      wait 1;
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop_hi, 0.5);
      level._id_11CB.bob_engine_phase3_loop = _id_0380::_id_6844("zmb_berl_bob_engine_phase_3_lp", undefined, var_1, 0.2);
      level._id_11CB.bob_engine_phase3_loop_hi = _id_0380::_id_6844("zmb_berl_bob_engine_phase_3_hi_lp", undefined, var_1, 0.2);
      level._id_11CB.bob_engine_phase3_loop_dmgd = _id_0380::_id_6844("zmb_berl_bob_engine_phase_3_dmged_lp", undefined, var_1, 0.2);
      level._id_11CB.curr_phase = "bob_smoke";
      break;
    case "bob_killed":
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop_hi, 0.5);
      wait 1.5;
      _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop, 0.65, 0.25);
      _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_hi, 0.65, 0.25);
      _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_dmgd, 0.65, 0.25);
      wait 11;
      _id_0380::_id_6850(level._id_11CB.bob_engine_phase3_loop, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_phase3_loop_hi, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_phase3_loop_dmgd, 0.5);
      _id_0380::_id_288B("zmb_berl_bob_engine_turn_off", undefined, var_1);
      wait 2;
      thread post_bob_zepplin_events();
      level._id_11CB.bob_engine_loop = undefined;
      level._id_11CB.bob_engine_loop_hi = undefined;
      level._id_11CB.bob_engine_phase3_loop = undefined;
      level._id_11CB.bob_engine_phase3_loop_hi = undefined;
      level._id_11CB.bob_engine_phase3_loop_dmgd = undefined;
      thread handle_bob_killed_music();
      break;
    case "bob_engine_rev":
      if(level._id_11CB.curr_phase == "bob_punch") {
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop, 0, 0.7);
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop_hi, 0, 0.7);
        _id_0380::_id_288B("zmb_berl_bob_engine_rev", undefined, var_1);
        wait 1.75;
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop, 1, 1);
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop_hi, 1, 1);
      }

      if(level._id_11CB.curr_phase == "bob_smoke") {
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop, 0, 0.7);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_hi, 0, 0.7);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_dmgd, 0, 0.7);
        _id_0380::_id_288B("zmb_berl_bob_engine_rev_dmg", undefined, var_1);
        wait 1.75;
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop, 1, 1);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_hi, 1, 1);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_dmgd, 1, 1);
      }

      break;
    default:
      break;
  }
}

bob_spawned_submix() {
  foreach(var_1 in level.players) {
    var_1 clientclearsoundsubmix("escape_zepplin_loud");
    var_1 clientaddsoundsubmix("escape_zepplin_soft");
  }
}

handle_bob_spawned_music() {
  if(!isDefined(level._id_11CB.bob_music_playing) && !isDefined(level._id_11CB.bob_is_dead)) {
    level._id_11CB.bob_music_playing = 1;

    foreach(var_1 in level.players) {
      var_1 _id_0366::snd_set_auto_wave_music_enabled(0);
      var_1 notify("kill_wave_mus_switcher");
      var_1 _id_0366::_id_8E31("bob_fight", 0.25, 3);
    }
  }
}

handle_bob_killed_music() {
  level._id_11CB.bob_music_playing = undefined;
  level._id_11CB.bob_is_dead = 1;

  foreach(var_1 in level.players) {
    var_1 thread play_boss_killed_stinger();
  }
}

play_boss_killed_stinger() {
  self clientaddsoundsubmix("bob_death_stinger", 0.2);
  _id_0380::_id_2888("mus_bob_death_stinger", self);
  wait 10;
  self clientclearsoundsubmix("bob_death_stinger", 4.0);
}

bob_smoke_attack_strt() {
  var_0 = self;
  wait 1.25;
  _id_0380::_id_288B("zmb_berl_bob_smoke_atk_explo", undefined, var_0);
}

bob_smoke_attack_loop(var_0, var_1) {
  var_2 = _id_0380::_id_6842("zmb_berl_bob_smoke_atk_smk_lp", undefined, var_1, 0.5);
  var_3 = _id_0380::_id_6842("zmb_berl_bob_smoke_atk_elec_hum_lp", undefined, var_1, 0.5);
  var_4 = _id_0380::_id_6842("zmb_berl_bob_smoke_atk_elec_static_lp", undefined, var_1, 0.5);
  wait(var_0);
  _id_0380::_id_6850(var_2, 0.5);
  _id_0380::_id_6850(var_3, 0.5);
  _id_0380::_id_6850(var_4, 0.5);
  _id_0380::_id_2889("zmb_berl_bob_smoke_atk_end", undefined, var_1);
}

bob_stab_leg() {
  var_0 = self;
  wait 1.4;
  _id_0380::_id_288B("zmb_berl_bob_shoot_leg", undefined, var_0);
}

bob_shoot_gun(var_0) {
  var_1 = self;

  if(!isDefined(level._id_11CB.bob_shoot_snd)) {
    level._id_11CB.bob_shoot_snd = _id_0380::_id_2889("zmb_bob_gun_fire", undefined, var_0);
    _id_0380::_id_288F(level._id_11CB.bob_shoot_snd, var_1, "shoot_sound_done");
    var_1 waittill("shoot_sound_done");
    level._id_11CB.bob_shoot_snd = undefined;
  }
}

wonderbuss_build_collect_battery(var_0) {
  _id_0380::_id_2889("zmb_wonderbuss_battery_pickup", undefined, var_0);
}

wonderbuss_build_battery_door_unlock(var_0) {
  _id_0380::_id_2889("zmb_wonderbuss_battery_place", undefined, var_0);
  _id_0380::_id_2889("zmb_wonderbuss_door_open", undefined, (225, -1495, 971));
}

wonderbuss_build_battery_door_lock(var_0) {
  _id_0380::_id_2889("zmb_wonderbuss_battery_pickup", undefined, var_0);
  _id_0380::_id_2889("zmb_wonderbuss_door_close", undefined, (225, -1495, 971));
}

wonderbuss_weapon_build_infusion(var_0) {
  _id_0380::_id_2889("zmb_wonderbuss_build_infusion", undefined, var_0);
}

pap_move_elevator() {
  var_0 = self;
  _id_0380::_id_288B("zmb_island_pap_elevator_move", undefined, var_0);
}

pap_open_elevator() {
  var_0 = self;
  _id_0380::_id_288B("zmb_island_pap_elev_door_open", undefined, var_0);
}

zep_puzzle_light_switch() {
  var_0 = self;
  var_0.switch_on_sound = _id_0380::_id_288B("zmb_berl_elect_puzzle_light", undefined, var_0);
}

zep_puzzle_light_switch_off() {
  var_0 = self;
  var_0.switch_off_sound = _id_0380::_id_288B("zmb_berl_elect_puzzle_light_off", undefined, var_0);
}

zep_puzzle_spark_loop() {
  var_0 = _id_0380::_id_6844("zmb_berl_elect_puzzle_electricity", undefined, level.in_world_spark, 0.2);
  common_scripts\utility::_id_3C9F("flag_override_electroschnell_complete");
  _id_0380::_id_6850(var_0, 0.5);
  _id_0380::_id_2889("zmb_berl_electro_overload_hit_a", undefined, (776, 6939, -3170));
}

zep_puzzle_spark_arrive() {
  var_0 = self;
  var_1 = _id_0380::_id_288B("zmb_berl_elect_puzzle_energy_lock", undefined, var_0);
}

zep_puzzle_spark_leave() {
  var_0 = self;
  wait 0.2;
  var_1 = _id_0380::_id_288B("zmb_berl_elect_puzzle_energy_release", undefined, var_0);
}

electroschnell_overload_explo() {
  wait 0.8;
  _id_0380::_id_2889("zmb_berl_electro_overload_explode", undefined, (776, 6939, -3170));
  thread straub_death_maul();
  thread zepplin_damaged_sounds();
}

straub_death_maul() {
  wait 1.7;

  foreach(var_1 in level.players) {
    var_1 clientaddsoundsubmix("straub_death_vignette");
  }

  _id_0380::_id_288B("zmb_berl_straub_death_zom_vox", undefined, level.airship_straub);
  _id_0380::_id_288B("zmb_berl_straub_death_zom_vox_pa", undefined, level.airship_straub);
  wait 9.2;
  _id_0380::_id_2889("zmb_berl_straub_death_splatter_a", undefined, (942, 6820, -3170));
  _id_0380::_id_2889("zmb_berl_straub_death_splatter_b", undefined, (935, 6963, -3170));
  _id_0380::_id_2889("zmb_berl_straub_death_splatter_c", undefined, (623, 6977, -3170));
  _id_0380::_id_2889("zmb_berl_straub_death_splatter_d", undefined, (627, 6809, -3170));
  _id_0380::_id_2889("zmb_berl_straub_death_splatter_e", undefined, (848, 6698, -3170));
  wait 3.2;
  _id_0380::_id_2889("zmb_berl_straub_death_shutters_a", undefined, (948, 6892, -3170));
  _id_0380::_id_2889("zmb_berl_straub_death_shutters_b", undefined, (622, 6880, -3170));
  _id_0380::_id_2889("zmb_berl_straub_death_shutters_c", undefined, (799, 6676, -3170));
  wait 1.5;
  _id_0380::_id_2889("zmb_berl_straub_death_shutters_steam", undefined, (948, 6892, -3170));

  foreach(var_1 in level.players) {
    var_1 clientclearsoundsubmix("straub_death_vignette");
    var_1 clientaddsoundsubmix("escape_zepplin_loud");
  }
}

zepplin_damaged_sounds() {
  wait 2;
  _id_0380::_id_2888("zmb_berl_zepplin_alarm");
  level._id_11CB.airship_damaged_rattle_lp = _id_0380::_id_6840("zmb_berl_zeppelin_damaged", undefined, 0.5);
  level._id_11CB.airship_damaged_engine_lp = _id_0380::_id_6840("zmb_berl_zepplin_dmg_engine", undefined, 0.5);
  thread zepplin_damaged_2d_oneshots();
  thread zepplin_damaged_3d_oneshots();
}

post_bob_zepplin_events() {
  foreach(var_1 in level.players) {
    var_1 clientclearsoundsubmix("escape_zepplin_soft");
    var_1 clientaddsoundsubmix("escape_zepplin_loud");
  }

  level._id_11CB.zepplin_damaged_sub = _id_0380::_id_6840("zmb_berl_zepplin_damaged_sub_lp");
}

zepplin_damaged_2d_oneshots() {
  level endon("airship_escape_drop_pod_doors_complete");

  for(;;) {
    var_0 = _randomintrange(7, 9);
    _id_0380::_id_2888("zmb_berl_zepplin_dmgd_hit_heavy");
    wait(var_0);
  }
}

zepplin_damaged_3d_oneshots() {
  level endon("airship_escape_drop_pod_doors_complete");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = _randomintrange(6, 9);
      var_3 = var_1.origin + (_randomintrange(-500, 500), _randomintrange(-500, 500), 0);
      _id_0380::_id_2889("zmb_berl_zepplin_dmgd_rattle", var_1, var_3);
      wait(var_2);
    }
  }
}

zepplin_damaged_cleanup() {
  _id_0380::_id_6850(level._id_11CB.airship_damaged_rattle_lp, 0.5);
  _id_0380::_id_6850(level._id_11CB.airship_damaged_engine_lp, 0.5);
  _id_0380::_id_6850(level._id_11CB.zepplin_damaged_sub, 0.5);

  foreach(var_1 in level.players) {
    var_1 clientclearsoundsubmix("escape_zepplin_loud");
  }

  level._id_11CB.airship_damaged_rattle_lp = undefined;
  level._id_11CB.airship_damaged_engine_lp = undefined;
  level._id_11CB.zepplin_damaged_sub = undefined;
}

open_barbarosa_area_door(var_0) {
  _id_0380::_id_2889("zmb_berl_barb_door_open", undefined, var_0);
}

close_barbarosa_area_door(var_0) {
  _id_0380::_id_2889("zmb_berl_barb_door_close", undefined, var_0);
}

place_weapon_in_slot(var_0, var_1) {
  if(var_0 == "bat") {
    _id_0380::_id_2889("zmb_berl_barb_place_bat", undefined, var_1);
  }

  if(var_0 == "dagger") {
    _id_0380::_id_2889("zmb_berl_barb_place_dagger", undefined, var_1);
  }

  if(var_0 == "pickaxe") {
    _id_0380::_id_2889("zmb_berl_barb_place_pickaxe", undefined, var_1);
  }

  if(var_0 == "sword") {
    _id_0380::_id_2889("zmb_berl_barb_place_pickaxe", undefined, var_1);
  }
}

statue_rotate_handler() {
  var_0 = self;

  if(common_scripts\utility::_id_3C77("raven_puzzle_currently_rotating")) {
    var_0.statue_rotating_snd = _id_0380::_id_6844("zmb_berl_barb_statue_rotate_lp", undefined, var_0, 0.3);
  } else if(!common_scripts\utility::_id_3C77("raven_puzzle_currently_rotating")) {
    _id_0380::_id_6850(var_0.statue_rotating_snd, 0.3);
    var_0.statue_stop_snd = _id_0380::_id_288B("zmb_berl_barb_statue_stop_impact", undefined, var_0);
  }
}

statue_wall_complete() {
  wait 0.8;
  _id_0380::_id_2889("zmb_berl_barb_statue_solve_imp", undefined, (1561, 3104, 857));
}

pickup_bird(var_0) {
  _id_0380::_id_2889("zmb_berl_barb_statue_pickup_bird", undefined, var_0);
}

place_bird(var_0) {
  _id_0380::_id_2889("zmb_berl_barb_statue_place_bird", undefined, var_0);
}

sword_reveal() {
  var_0 = _getEnt("bird_statue_sword_bit", "targetname");
  wait 0.6;
  _id_0380::_id_2889("zmb_berl_barb_statue_swrd_reveal", undefined, var_0.origin);
}

pickup_barbarosa_sword() {
  var_0 = self;
  _id_0380::_id_288B("zmb_pickup_raven_swrd", var_0, var_0);
}

smugglers_bat_power_generator_start(var_0) {
  _id_0380::_id_6842("smugglers_bat_power_generator_start", undefined, var_0);
  level._id_11CB.smugglers_bat_power_generator_lp = _id_0380::_id_6842("smugglers_bat_smugglers_bat_lp", undefined, var_0);
}

smugglers_bat_power_generator_stop(var_0) {
  _id_0380::_id_6842("smugglers_bat_smugglers_bat_stop", undefined, var_0);
  _id_0380::_id_6850(level._id_11CB.smugglers_bat_power_generator_lp);
  level._id_11CB.smugglers_bat_power_generator_lp = undefined;
}

smugglers_bat_big_doors_open(var_0) {
  _id_0380::_id_2889("smugglers_bat_big_doors_open", undefined, var_0);
}

smugglers_bat_cash_register(var_0) {
  _id_0380::_id_2889("smugglers_bat_cash_register", undefined, var_0);
}

smugglers_bat_door_break_down(var_0) {
  _id_0380::_id_2889("smugglers_bat_door_break_down", undefined, var_0);
}

smugglers_bat_door_open_squeaky(var_0) {
  _id_0380::_id_2889("smugglers_bat_door_open_squeaky", undefined, var_0);
}

smugglers_bat_door_pound(var_0) {
  _id_0380::_id_2889("smugglers_bat_door_pound", undefined, var_0);
}

smugglers_bat_gas_cover_open_01(var_0) {
  _id_0380::_id_2889("smugglers_bat_gas_cover_open_01", undefined, var_0);
}

smugglers_bat_gas_cover_open_02(var_0) {
  _id_0380::_id_2889("smugglers_bat_gas_cover_open_02", undefined, var_0);
}

smugglers_bat_pickup(var_0) {
  _id_0380::_id_2889("zmb_hc_bat_aoe_fx", undefined, var_0);
}

smugglers_bat_weapon_drop(var_0) {
  _id_0380::_id_2889("smugglers_bat_weapon_drop", undefined, var_0);
}

smugglers_bat_start_combat_loop(var_0, var_1) {
  smugglers_bat_stop_combat_loop();
  level._id_11CB.smugglers_bat_combat_lp = _id_0380::_id_6842(var_1, undefined, var_0);
}

smugglers_bat_stop_combat_loop() {
  _id_0380::_id_6850(level._id_11CB.smugglers_bat_combat_lp, 1.0);
  level._id_11CB.smugglers_bat_combat_lp = undefined;
}

ddagger_film_canister_fall(var_0) {
  _id_0380::_id_288B("ddagger_film_canister_fall", undefined, var_0);
}

ddagger_film_canister_pickup(var_0) {
  _id_0380::_id_288B("ddagger_film_canister_pickup", undefined, var_0);
}

ddagger_picture_placement(var_0) {
  _id_0380::_id_2889("ddagger_picture_placement", undefined, var_0);
}

ddagger_picture_remove(var_0) {
  _id_0380::_id_2889("ddagger_picture_remove", undefined, var_0);
}

ddagger_projector_attach_reel(var_0) {
  _id_0380::_id_2889("ddagger_projector_attach_reel", undefined, var_0);
}

ddagger_projector_on(var_0) {
  _id_0380::_id_2889("ddagger_projector_on", undefined, var_0);
  level._id_11CB.ddagger_projector_loop = _id_0380::_id_2889("ddagger_projector_loop", undefined, var_0, 0.5);
}

ddagger_projector_off() {
  _id_0380::_stoplocalsound(level._id_11CB.ddagger_projector_loop, 1);
}

ddagger_vault_door_open(var_0) {
  _id_0380::_id_2889("ddagger_vault_door_open", undefined, var_0);
}

ddagger_vault_handle_open(var_0) {
  _id_0380::_id_2889("ddagger_vault_handle_open", undefined, var_0);
}

ddagger_vault_tick(var_0) {
  _id_0380::_id_2889("ddagger_vault_tick", undefined, var_0);
}

ddagger_vault_tick_success(var_0) {
  _id_0380::_id_2889("ddagger_vault_tick_success", undefined, var_0);
}

dancer_jumpscare() {
  var_0 = self;
  _id_0380::_id_288B("zmb_berl_al_scream", undefined, var_0);
}

ring_bell() {
  var_0 = self;
  _id_0380::_id_288B("zmb_berl_al_bell", undefined, var_0);
}

pa_system_dialogue_setup() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.pa_player_speaker_1)) {
      continue;
    }
    var_1.pa_player_speaker_1 = spawn("script_model", var_1.origin);
    var_1.pa_player_speaker_1 setModel("tag_origin");
    var_1.pa_player_speaker_2 = spawn("script_model", var_1.origin);
    var_1.pa_player_speaker_2 setModel("tag_origin");
    var_1 thread pa_system_dialogue_cleanup();
  }
}

pa_system_dialogue_cleanup() {
  var_0 = self;
  var_0 common_scripts\utility::_id_A732("pa_system_cleanup", "disconnect");

  if(isDefined(var_0.pa_player_speaker_1)) {
    var_0.pa_player_speaker_1 delete();
    var_0.pa_player_speaker_1 = undefined;
  }

  if(isDefined(var_0.pa_player_speaker_2)) {
    var_0.pa_player_speaker_2 delete();
    var_0.pa_player_speaker_2 = undefined;
  }
}

pa_system_dialogue_all_players(var_0, var_1, var_2, var_3) {
  if(!_soundexists(var_0)) {
    return;
  }
  pa_system_dialogue_setup();

  for(var_4 = 0; var_4 < level.players.size - 1; var_4++) {
    level.players[var_4] thread pa_system_dialogue(var_0, var_1, var_2, var_3);
  }

  level.players[level.players.size - 1] pa_system_dialogue(var_0, var_1, var_2, var_3);
}

pa_system_dialogue(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 endon("disconnect");
  var_4 endon("death");
  var_5 = 0.3;
  var_6 = [];
  var_7 = 1;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  if(!isDefined(var_3)) {
    return;
  }
  if(!_isarray(var_3)) {
    var_6 = [var_3];
  } else {
    var_6 = var_3;
  }

  var_4 childthread pa_system_player_track(var_6);
  waitframe();
  var_8 = var_0;
  var_9 = var_0 + "_echo";
  var_10 = var_0 + "_delay";
  var_11 = 0;
  var_12 = 0;

  if(_soundexists(var_9)) {
    var_11 = 1;
  }

  if(_soundexists(var_10)) {
    var_12 = 1;
  }

  _id_0380::_id_6850(var_4._id_071D.pa_vo_on_player, 0.25);
  var_4._id_071D.pa_vo_on_player = undefined;

  if(isDefined(var_8)) {
    var_4._id_071D.pa_vo_on_player = _id_0380::_id_6844(var_8, var_4, var_4, 0, 1.0);
    _id_0380::_id_684C(var_4._id_071D.pa_vo_on_player, var_4, "pa_vo_on_player_done");
  }

  if(isDefined(var_4._id_071D._id_6DD9)) {
    _id_0380::_id_6850(var_4._id_071D._id_6DD9, 0.25);
    var_4._id_071D._id_6DD9 = undefined;
  }

  if(isDefined(var_9) && var_11) {
    var_4._id_071D._id_6DD9 = _id_0380::_id_6840(var_9, var_4, 0, 0.25);
    _id_0380::_id_684C(var_4._id_071D._id_6DD9, var_4, "pa_vo_echo_done");
  }

  if(isDefined(var_4.pa_player_speaker_1) && isDefined(var_4.pa_player_speaker_1.pa_speaker_1_snd)) {
    _id_0380::_id_6850(var_4.pa_player_speaker_1.pa_speaker_1_snd, 0.25);
    var_4.pa_player_speaker_1.pa_speaker_1_snd = undefined;
  }

  if(isDefined(var_10) && var_12) {
    var_4.pa_player_speaker_1.pa_speaker_1_snd = _id_0380::_id_6844(var_10, var_4, var_4.pa_player_speaker_1, 0, 0.5);

    if(isDefined(var_4.pa_player_speaker_1.pa_speaker_1_snd)) {
      var_4.pa_player_speaker_1.pa_speaker_1_snd waittill("death");
    } else {
      waitframe();
    }
  } else if(var_11)
    var_4 waittill("pa_vo_echo_done");
  else {
    var_4 waittill("pa_vo_on_player_done");
  }

  if(common_scripts\utility::_id_562E(var_7)) {
    var_4 notify("pa_system_cleanup");
  }
}

pa_system_player_track(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1.pa_player_speaker_1 endon("pa_system_line_done");

  for(;;) {
    var_2 = _sortbydistance(var_0, var_1.origin);

    if(isDefined(var_1.pa_player_speaker_1)) {
      var_1.pa_player_speaker_1.origin = var_2[0].origin;
    }

    if(isDefined(var_1.pa_player_speaker_2)) {
      if(isDefined(var_2[1])) {
        var_1.pa_player_speaker_2.origin = var_2[1].origin;
      } else {
        var_1.pa_player_speaker_2.origin = var_2[0].origin;
      }
    }

    wait 0.5;
  }
}