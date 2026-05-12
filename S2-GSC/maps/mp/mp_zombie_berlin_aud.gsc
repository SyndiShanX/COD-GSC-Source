/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_aud.gsc
*********************************************/

func_00F9() {
  func_5196();
  lib_0367::func_8E3E("berl");
  func_7BBA();
  func_5C22();
  level.var_11CB.intermission_music_aliases = ["mus_intermission_dlc2"];
  level.var_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_07", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  lib_0366::snd_set_mus_combat_cues_override(level.var_11CB.wave_cues);
  lib_0366::snd_zmb_set_start_intermission_music_override_callback(::start_intermission_music_override_callback);
  thread do_trippy_global_random_stuff();
  lib_0366::snd_zmb_set_map_wave_music_master_volume_scalar(0.8);
}

func_7BBA() {
  lib_0378::func_8DC7("player_connect_map", ::func_7248);
  lib_0378::func_8DC7("player_spawned", ::func_7330);
  lib_0378::func_8DC7("wave_begin", ::func_A979);
  lib_0378::func_8DC7("wave_end", ::func_A97A);
  lib_0378::func_8DC7("play_vignette_victim_hurt_vo", ::play_vignette_victim_hurt_vo);
  lib_0378::func_8DC7("player_falls_into_sewer", ::player_falls_into_sewer);
  lib_0378::func_8DC7("player_using_radio", ::player_using_radio);
  lib_0378::func_8DC7("aud_radio_tuning", ::radio_tuning);
  lib_0378::func_8DC7("radio_stop_using_watcher", ::radio_stop_using_watcher);
  lib_0378::func_8DC7("aud_open_flare_crate", ::open_flare_crate);
  lib_0378::func_8DC7("aud_flare_triggered", ::flare_triggered);
  lib_0378::func_8DC7("start_airship_loop", ::start_airship_loop);
  lib_0378::func_8DC7("start_straub_airship_loop", ::start_straub_airship_loop);
  lib_0378::func_8DC7("straub_airship_entrance", ::straub_airship_entrance);
  lib_0378::func_8DC7("stop_airship_loop", ::stop_airship_loop);
  lib_0378::func_8DC7("blimp_projectile", ::func_17A0);
  lib_0378::func_8DC7("start_trap_tank", ::start_trap_tank);
  lib_0378::func_8DC7("stop_trap_tank", ::stop_trap_tank);
  lib_0378::func_8DC7("trap_tank_damage", ::trap_tank_damage);
  lib_0378::func_8DC7("start_trap_cage", ::start_trap_cage);
  lib_0378::func_8DC7("stop_trap_cage", ::stop_trap_cage);
  lib_0378::func_8DC7("trap_cage_damage", ::trap_cage_damage);
  lib_0378::func_8DC7("start_trap_prop", ::start_trap_prop);
  lib_0378::func_8DC7("stop_trap_prop", ::stop_trap_prop);
  lib_0378::func_8DC7("trap_prop_damage", ::trap_prop_damage);
  lib_0378::func_8DC7("aud_axe_hc_amoire_open", ::axe_hc_amoire_open);
  lib_0378::func_8DC7("aud_axe_hc_pickup_scale", ::axe_hc_pickup_scale);
  lib_0378::func_8DC7("aud_axe_hc_place_scale_piece", ::axe_hc_place_scale_piece);
  lib_0378::func_8DC7("aud_axe_hc_place_head", ::axe_hc_place_head);
  lib_0378::func_8DC7("aud_axe_hc_drawer_open", ::axe_hc_drawer_open);
  lib_0378::func_8DC7("start_droppod_descend_loop", ::start_droppod_descend_loop);
  lib_0378::func_8DC7("stop_droppod_descend_loop", ::stop_droppod_descend_loop);
  lib_0378::func_8DC7("droppod_ground_impact", ::droppod_ground_impact);
  lib_0378::func_8DC7("tether_ground_impact", ::tether_ground_impact);
  lib_0378::func_8DC7("droppod_winch_down", ::droppod_winch_down);
  lib_0378::func_8DC7("droppod_winch_up", ::droppod_winch_up);
  lib_0378::func_8DC7("aud_start_drop_pod_sway", ::start_drop_pod_sway);
  lib_0378::func_8DC7("inside_droppod_submix_strt", ::inside_droppod_submix_strt);
  lib_0378::func_8DC7("inside_droppod_submix_stp", ::inside_droppod_submix_stp);
  lib_0378::func_8DC7("droppod_lock_in", ::droppod_lock_in);
  lib_0378::func_8DC7("droppod_escape_fire", ::droppod_escape_fire);
  lib_0378::func_8DC7("zombie_soul_suck", ::func_ABF8);
  lib_0378::func_8DC7("zombie_soul_suck_threshold", ::func_ABF9);
  lib_0378::func_8DC7("js_corpse_becomes_zombie", ::js_corpse_becomes_zombie);
  lib_0378::func_8DC7("js_assassin_landing", ::js_assassin_landing);
  lib_0378::func_8DC7("aud_bob_engine", ::bob_engine);
  lib_0378::func_8DC7("aud_bob_smoke_attack_strt", ::bob_smoke_attack_strt);
  lib_0378::func_8DC7("aud_bob_smoke_attack_loop", ::bob_smoke_attack_loop);
  lib_0378::func_8DC7("aud_bob_stab_leg", ::bob_stab_leg);
  lib_0378::func_8DC7("aud_bob_shoot_gun", ::bob_shoot_gun);
  lib_0378::func_8DC7("wonderbuss_build_collect_battery", ::wonderbuss_build_collect_battery);
  lib_0378::func_8DC7("wonderbuss_build_battery_door_unlock", ::wonderbuss_build_battery_door_unlock);
  lib_0378::func_8DC7("wonderbuss_build_battery_door_lock", ::wonderbuss_build_battery_door_lock);
  lib_0378::func_8DC7("wonderbuss_weapon_build_infusion", ::wonderbuss_weapon_build_infusion);
  lib_0378::func_8DC7("aud_pap_move_elevator", ::pap_move_elevator);
  lib_0378::func_8DC7("aud_pap_open_elevator", ::pap_open_elevator);
  lib_0378::func_8DC7("aud_zep_puzzle_light_switch", ::zep_puzzle_light_switch);
  lib_0378::func_8DC7("aud_zep_puzzle_light_switch_off", ::zep_puzzle_light_switch_off);
  lib_0378::func_8DC7("aud_zep_puzzle_spark_arrive", ::zep_puzzle_spark_arrive);
  lib_0378::func_8DC7("aud_zep_puzzle_spark_leave", ::zep_puzzle_spark_leave);
  lib_0378::func_8DC7("aud_zep_puzzle_spark_loop", ::zep_puzzle_spark_loop);
  lib_0378::func_8DC7("aud_electroschnell_overload_explo", ::electroschnell_overload_explo);
  lib_0378::func_8DC7("aud_open_barbarosa_area_door", ::open_barbarosa_area_door);
  lib_0378::func_8DC7("aud_close_barbarosa_area_door", ::close_barbarosa_area_door);
  lib_0378::func_8DC7("aud_place_weapon_in_slot", ::place_weapon_in_slot);
  lib_0378::func_8DC7("aud_statue_rotate_handler", ::statue_rotate_handler);
  lib_0378::func_8DC7("aud_statue_wall_complete", ::statue_wall_complete);
  lib_0378::func_8DC7("aud_place_bird", ::place_bird);
  lib_0378::func_8DC7("aud_pickup_bird", ::pickup_bird);
  lib_0378::func_8DC7("aud_sword_reveal", ::sword_reveal);
  lib_0378::func_8DC7("aud_pickup_barbarosa_sword", ::pickup_barbarosa_sword);
  lib_0378::func_8DC7("smugglers_bat_power_generator_start", ::smugglers_bat_power_generator_start);
  lib_0378::func_8DC7("smugglers_bat_power_generator_stop", ::smugglers_bat_power_generator_stop);
  lib_0378::func_8DC7("smugglers_bat_big_doors_open", ::smugglers_bat_big_doors_open);
  lib_0378::func_8DC7("smugglers_bat_cash_register", ::smugglers_bat_cash_register);
  lib_0378::func_8DC7("smugglers_bat_door_break_down", ::smugglers_bat_door_break_down);
  lib_0378::func_8DC7("smugglers_bat_door_open_squeaky", ::smugglers_bat_door_open_squeaky);
  lib_0378::func_8DC7("smugglers_bat_door_pound", ::smugglers_bat_door_pound);
  lib_0378::func_8DC7("smugglers_bat_gas_cover_open_01", ::smugglers_bat_gas_cover_open_01);
  lib_0378::func_8DC7("smugglers_bat_gas_cover_open_02", ::smugglers_bat_gas_cover_open_02);
  lib_0378::func_8DC7("smugglers_bat_pickup", ::smugglers_bat_pickup);
  lib_0378::func_8DC7("smugglers_bat_weapon_drop", ::smugglers_bat_weapon_drop);
  lib_0378::func_8DC7("smugglers_bat_start_combat_loop", ::smugglers_bat_start_combat_loop);
  lib_0378::func_8DC7("smugglers_bat_stop_combat_loop", ::smugglers_bat_stop_combat_loop);
  lib_0378::func_8DC7("ddagger_film_canister_fall", ::ddagger_film_canister_fall);
  lib_0378::func_8DC7("ddagger_film_canister_pickup", ::ddagger_film_canister_pickup);
  lib_0378::func_8DC7("ddagger_picture_placement", ::ddagger_picture_placement);
  lib_0378::func_8DC7("ddagger_picture_remove", ::ddagger_picture_remove);
  lib_0378::func_8DC7("ddagger_projector_attach_reel", ::ddagger_projector_attach_reel);
  lib_0378::func_8DC7("ddagger_projector_on", ::ddagger_projector_on);
  lib_0378::func_8DC7("ddagger_vault_door_open", ::ddagger_vault_door_open);
  lib_0378::func_8DC7("ddagger_vault_handle_open", ::ddagger_vault_handle_open);
  lib_0378::func_8DC7("ddagger_vault_tick", ::ddagger_vault_tick);
  lib_0378::func_8DC7("ddagger_vault_tick_success", ::ddagger_vault_tick_success);
  lib_0378::func_8DC7("aud_dancer_jumpscare", ::dancer_jumpscare);
  lib_0378::func_8DC7("aud_ring_bell", ::ring_bell);
}

do_trippy_global_random_stuff() {
  level.var_11CB.trippy_global_random_stuff_enabled = 1;
  thread do_trippy_global_door_pound();
  thread do_creepy_kid();
}

do_creepy_kid() {
  var_00 = 36;
  var_01 = 360;
  var_02 = 90;
  var_03 = 300;
  wait(5);
  for(;;) {
    wait(randomfloatrange(var_02, var_03));
    var_04 = level.var_744A[randomint(level.var_744A.size)];
    if(isDefined(var_04) && level.var_11CB.trippy_global_random_stuff_enabled && lib_0378::func_8D1B(0.5)) {
      var_05 = var_00 * 2 - var_00;
      var_06 = var_01 * 2 - var_01;
      var_07 = (randomfloatrange(var_05, var_06), randomfloatrange(var_05, var_06), 0);
      var_08 = "zmb_creepy_kid_dist";
      if(lib_0378::func_8D1B(0.5)) {
        var_08 = "zmb_creepy_vox_fx";
      }

      var_09 = lib_0380::func_2889(var_08, var_04, var_04.var_116 + var_07);
    }
  }
}

do_horror_audio_vignettes() {
  var_00 = 540;
  var_01 = 900;
  var_02 = 20;
  var_03 = 60;
  var_04 = gettime() * 1000 + var_02;
  wait(5);
  for(;;) {
    wait(2);
    var_05 = level.var_744A[randomint(level.var_744A.size)];
    if(isDefined(var_05) && level.var_11CB.trippy_global_random_stuff_enabled) {
      var_06 = gettime() * 1000;
      if(var_06 < var_04 || var_05 lib_0366::func_8E14() > 0.333) {
        continue;
      }

      var_04 = randomintrange(var_02, var_03);
      var_07 = "_ext";
      if(lib_0378::func_8D1B(0.5)) {
        var_07 = "_int" + randomintrange(1, 2);
      }

      var_08 = "zmb_audio_vignette_dist" + var_07;
      lib_0378::func_8DC2("Playing " + var_08, 1);
      var_09 = calc_rnd_point_xy_offset(var_00, var_01);
      var_0A = lib_0380::func_2889(var_08, var_05, var_05.var_116 + var_09);
      if(var_0A) {
        lib_0380::func_288F(var_0A, var_05, "zmb_audio_vignette_dist_done");
        var_05 waittill("zmb_audio_vignette_dist_done");
      }
    }
  }
}

do_occluded_foley_vignettes() {
  var_00 = 360;
  var_01 = 540;
  var_02 = 20;
  var_03 = 60;
  wait(5);
  for(;;) {
    wait(randomintrange(var_02, var_03));
    var_04 = level.var_744A[randomint(level.var_744A.size)];
    if(isDefined(var_04) && level.var_11CB.trippy_global_random_stuff_enabled) {
      var_05 = "zmb_audio_vignette_occl_foley";
      var_06 = calc_rnd_point_xy_offset(var_00, var_01);
      var_07 = var_04.var_116 + var_06;
      var_08 = lib_0380::func_2889(var_05, var_04, var_07);
      if(var_08) {
        lib_0380::func_288F(var_08, var_04, "zmb_audio_vignette_dist_done");
        var_04 waittill("zmb_audio_vignette_dist_done");
      }
    }
  }
}

calc_rnd_point_xy_offset(param_00, param_01) {
  if(randomint(2)) {
    var_02 = randomfloatrange(param_00, param_01);
  } else {
    var_02 = randomfloatrange(-1 * var_02, -1 * param_01);
  }

  if(randomint(2)) {
    var_03 = randomfloatrange(param_00, param_01);
  } else {
    var_03 = randomfloatrange(-1 * var_02, -1 * param_01);
  }

  var_04 = (var_02, var_03, 0);
  return var_04;
}

do_trippy_global_door_pound() {
  wait(5);
  for(;;) {
    var_00 = level.var_744A[randomint(level.var_744A.size)];
    if(isDefined(var_00) && level.var_11CB.trippy_global_random_stuff_enabled) {
      if(!lib_0366::snd_is_level_wave_active() && getomnvar("ui_zm_round_number") > 10 && !randomint(100)) {
        lib_0380::func_2888("zmb_trippy_door_pound", var_00);
        return;
      }
    }

    wait(60);
  }
}

start_intermission_music_override_callback() {
  var_00 = level.var_11CB.intermission_music_aliases[randomint(level.var_11CB.intermission_music_aliases.size)];
  var_01 = 3;
  var_02 = 5;
  lib_0366::func_8E31(var_00, var_01, var_02);
}

func_7248() {
  if(!isDefined(self.var_11CB)) {
    self.var_11CB = spawnStruct();
  }
}

func_7330() {
  thread berlin_player_inside_outside_mixer();
  self method_8626("dlc2_default_mix");
  lib_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

func_A979(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  if(lib_0366::snd_get_auto_wave_music_enabled()) {
    self method_85A7("snd_randomize_ambient_mus_layers");
    wait 0.05;
    thread wave_mus_switcher();
  }
}

func_A97A() {
  self notify("kill_wave_mus_switcher");
  self method_8627("dlc2_plr_idle_mus_fade", 3);
}

wave_mus_switcher() {
  self endon("death");
  self endon("kill_wave_mus_switcher");
  self endon("disconnect");
  var_00 = self;
  var_01 = -5536;
  var_02 = 240000;
  var_03 = randomintrange(var_01, var_02);
  var_04 = 2000;
  var_05 = 0.1;
  var_06 = gettime();
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  var_0A = 1;
  var_0B = var_00.var_116;
  var_0C = 1;
  var_0D = 6;
  var_0E = 14;
  var_0F = 3;
  var_10 = lib_0366::snd_get_curr_combat_cue_name();
  wait(1);
  for(;;) {
    if(!lib_0366::snd_get_auto_wave_music_enabled()) {
      wait(1);
      continue;
    }

    var_11 = gettime() - var_06;
    var_12 = var_00 lib_0366::func_8E14();
    var_13 = var_00.var_116 != var_0B;
    var_0B = var_00.var_116;
    var_14 = var_04;
    if(var_13) {
      if(!var_0A) {
        var_0A = 1;
        var_09 = var_11;
      }
    } else if(var_0A) {
      var_0A = 0;
      var_08 = var_11;
    }

    if(!var_13 && var_11 - var_08 > var_14 && var_12 <= var_05 && var_0C) {
      var_0C = 0;
      var_00 method_8626("dlc2_plr_idle_mus_fade", var_0E);
    } else if(!var_0C && var_13 || var_12 > var_05 && var_11 - var_09 > var_14 * 0.5) {
      var_0C = 1;
      var_00 method_8627("dlc2_plr_idle_mus_fade", var_0D);
    } else if(var_0C && var_11 - var_07 > var_03) {
      var_07 = var_11;
      var_10 = var_00 lib_0366::func_8D46();
      if(lib_0378::func_8D1B(0.02)) {
        var_10 = "ravens";
      }

      var_00 lib_0366::func_8DCF(var_10);
      lib_0366::func_8E32(var_0E);
      wait(0.1);
      lib_0366::func_8E31(var_10, var_0F);
      var_03 = randomintrange(var_01, var_02);
    }

    wait(0.5);
  }
}

func_5196() {}

func_5C22() {
  thread func_35E1();
  thread drop_pod_intro_mix();
  thread play_radio_tuner_idle_static();
}

func_35E1() {
  wait(0.5);
  thread large_fire_textures();
  thread fire_metal_textures();
  thread small_fire_textures();
  lib_0380::func_2889("wreckage_fire_metal_med", undefined, (232, -2213, 1188));
  lib_0380::func_2889("wreckage_fire_metal_large", undefined, (1358, -603, 1129));
  lib_0380::func_2889("wreckage_fire_metal_med", undefined, (1910, 1426, 1065));
  lib_0380::func_2889("wreckage_fire_metal_med", undefined, (871, 863, 1219));
  lib_0380::func_2889("wreckage_fire_metal_large", undefined, (651, 693, 1115));
  lib_0380::func_2889("wreckage_fire_metal_med", undefined, (602, 1059, 1093));
  lib_0380::func_2889("wreckage_fire_metal_small", undefined, (511, 446, 1271));
  lib_0380::func_2889("wreckage_fire_metal_med", undefined, (637, 393, 1256));
  lib_0380::func_2889("wreckage_fire_wood_med", undefined, (1303, -949, 1084));
  lib_0380::func_2889("wreckage_fire_wood_large", undefined, (-433, -822, 1125));
  lib_0380::func_2889("wreckage_fire_wood_med", undefined, (984, -1054, 1071));
  lib_0380::func_2889("wreckage_fire_wood_med", undefined, (-243, -870, 1125));
  lib_0380::func_2889("wreckage_fire_wood_small", undefined, (290, 206, 1127));
  lib_0380::func_2889("wreckage_fire_wood_med", undefined, (544, 1174, 1063));
  lib_0380::func_2889("wreckage_fire_wood_med", undefined, (-177, 1864, 1220));
  lib_0380::func_2889("wreckage_fire_wood_small", undefined, (-452, 1428, 1196));
  lib_0380::func_2889("wreckage_fire_wood_med", undefined, (853, -2615, 912));
  lib_0380::func_2889("wreckage_fire_wood_small", undefined, (176, 1763, 1314));
  lib_0380::func_2889("zmb_ber_gas_fire", undefined, (1454, 1791, 1319));
  lib_0380::func_2889("zmb_ber_pod_wtr_spray_lp", undefined, (352, -2177, 1019));
  lib_0380::func_2889("zmb_berl_flare_sizzle_lp", undefined, (325, 360, 1169));
  thread cellar_drop_pod_stress_handler();
}

cellar_drop_pod_stress_handler() {
  level endon("death");
  for(;;) {
    wait(2);
    lib_0380::func_2889("zmb_berlin_cellar_pod_wood_stress", undefined, (218, -2221, 925));
    wait(randomintrange(18, 38));
  }
}

large_fire_textures() {
  apartment_left_exit_wood_pile_texture();
}

apartment_left_exit_wood_pile_texture() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_texture_lrg", undefined, (-433, -822, 1125));
    wait(randomintrange(7, 15));
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
    lib_0380::func_2889("zmb_ber_fire_mtl_stress", undefined, (232, -2213, 1188));
    wait(randomintrange(7, 12));
  }
}

club_entrance_truck_metal_stress() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_mtl_stress", undefined, (1358, -603, 1129));
    wait(randomintrange(7, 12));
  }
}

cathedral_truck_metal_stress() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_mtl_stress", undefined, (1910, 1426, 1065));
    wait(randomintrange(7, 12));
  }
}

crashed_plane_01_metal_stress_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_mtl_stress", undefined, (651, 693, 1115));
    wait(randomintrange(7, 12));
  }
}

crashed_plane_01_metal_stress_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_mtl_stress", undefined, (637, 393, 1256));
    wait(randomintrange(7, 12));
  }
}

crashed_plane_02_metal_stress() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_mtl_stress", undefined, (602, 1059, 1093));
    wait(randomintrange(7, 12));
  }
}

small_fire_textures() {
  crashed_plane_wood_and_rubble_texture();
  barbed_wire_between_cathedral_and_museum();
}

crashed_plane_wood_and_rubble_texture() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_texture_sml", undefined, (544, 1174, 1063));
    wait(randomintrange(7, 15));
  }
}

barbed_wire_between_cathedral_and_museum() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("zmb_ber_fire_texture_sml", undefined, (-452, 1428, 1196));
    wait(randomintrange(7, 15));
  }
}

play_vignette_victim_hurt_vo(param_00) {
  lib_0380::func_6844("zmb_vignettes_gsld1_hurt", undefined, param_00);
}

player_falls_into_sewer() {
  if(isDefined(self)) {
    var_00 = self;
    lib_0380::func_288B("zmb_berl_fall_into_sewer_debris", undefined, var_00);
    lib_0380::func_288B("zmb_berl_fall_into_sewer_foley", undefined, var_00);
    lib_0380::func_288B("zmb_berl_fall_into_sewer_trans", undefined, var_00);
  }
}

play_radio_tuner_idle_static() {
  wait(0.5);
  var_00 = getent("radio_tuner_link_org", "targetname");
  level.var_11CB.radio_tuner_idle_static_lp = lib_0380::func_6844("zmb_berl_radio_idle_lp", undefined, var_00, 0.2);
}

player_using_radio() {
  var_00 = self;
  var_00 method_8626("radio_interact_mix");
}

radio_tuning(param_00, param_01) {
  var_02 = getent("radio_tuner_link_org", "targetname");
  switch (param_00) {
    case "tuning":
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 0, 0.4);
      level.var_11CB.tuning_radio_lp = lib_0380::func_6844("zmb_berl_radio_tune_lp", undefined, var_02, 0.1);
      break;

    case "idle":
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 1, 0.1);
      lib_0380::func_6850(level.var_11CB.tuning_radio_lp, 0.5);
      break;

    case "dialog_playing":
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 0, 0.4);
      lib_0380::func_6850(level.var_11CB.tuning_radio_lp, 0.2);
      lib_0380::func_288B("zmb_berl_radio_rply_sfx", undefined, var_02);
      level.var_11CB.radio_reply_vo = lib_0380::func_6844(param_01, undefined, var_02);
      lib_0380::func_684C(level.var_11CB.radio_reply_vo, var_02, "radio_vo_done");
      var_02 waittill("radio_vo_done");
      level notify("radio_response_done");
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 1, 0.2);
      break;

    case "morse_code":
      common_scripts\utility::func_3C87("morse_code_freq_changed");
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 0.5, 0.2);
      if(isDefined(level.var_11CB.tuning_radio_lp)) {
        lib_0380::func_6850(level.var_11CB.tuning_radio_lp, 0.2);
      }

      lib_0380::func_288B("zmb_berl_radio_morse_strt", undefined, var_02);
      level.var_11CB.radio_reply_vo = lib_0380::func_6844(param_01, undefined, var_02);
      lib_0380::func_684C(level.var_11CB.radio_reply_vo, var_02, "radio_vo_done");
      var_02 waittill("radio_vo_done");
      level notify("radio_response_done");
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 1, 0.4);
      morse_code_loop_watcher(param_01, var_02);
      break;

    case "smuggler_dialog_playing":
      var_03 = var_02.var_116;
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 0, 0.4);
      lib_0380::func_6850(level.var_11CB.tuning_radio_lp, 0.2);
      var_04 = lib_0380::func_6842(param_01, undefined, var_03);
      lib_0380::func_684C(var_04, var_02, "smuggler_vo_1_done");
      lib_0380::func_288B("zmb_ber_smgler_sfx_a", undefined, var_02);
      var_02 waittill("smuggler_vo_1_done");
      wait(0.2);
      level.player_using_radio lib_0367::func_8E3C("hc_smuggler_intro");
      wait(0.4);
      var_05 = lib_0380::func_6842("zmb_berl_gsmg_hc_smuggler_stuck", undefined, var_03);
      lib_0380::func_684C(var_05, var_02, "smuggler_vo_2_done");
      lib_0380::func_288B("zmb_ber_smgler_sfx_b", undefined, var_02);
      var_02 waittill("smuggler_vo_2_done");
      wait(0.3);
      level.player_using_radio lib_0367::func_8E3C("hc_smuggler_react");
      level notify("radio_response_done");
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 1, 0.2);
      break;
  }
}

morse_code_loop_watcher(param_00, param_01) {
  level endon("game_over");
  var_02 = 2;
  for(;;) {
    var_03 = level.bat_hc_radio_code_left;
    var_04 = level.tuner_values["radio_tuner"]["left"];
    var_05 = abs(var_04 - var_03);
    var_06 = level.bat_hc_radio_code_right;
    var_07 = level.tuner_values["radio_tuner"]["right"];
    var_08 = abs(var_07 - var_06);
    if(var_05 <= var_02 && var_08 <= var_02) {
      thread morse_code_loop(param_00, param_01);
      while(var_05 <= var_02 && var_08 <= var_02) {
        wait 0.05;
        var_04 = level.tuner_values["radio_tuner"]["left"];
        var_05 = abs(var_04 - var_03);
        var_07 = level.tuner_values["radio_tuner"]["right"];
        var_08 = abs(var_07 - var_06);
      }

      common_scripts\utility::func_3C8F("morse_code_freq_changed");
      wait 0.05;
      common_scripts\utility::func_3C7B("morse_code_freq_changed");
      lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 1, 0.1);
      lib_0380::func_2893(level.var_11CB.morse_code_loop_snd, 0.2);
      lib_0380::func_288B("zmb_berl_radio_morse_end", undefined, param_01);
      continue;
    }

    wait(0.25);
  }
}

morse_code_loop(param_00, param_01) {
  level endon("morse_code_freq_changed");
  var_02 = 1.5;
  wait(var_02);
  lib_0380::func_288B("zmb_berl_radio_morse_strt", undefined, param_01);
  wait(0.2);
  while(!common_scripts\utility::func_3C77("morse_code_freq_changed")) {
    lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 0.5, 0.2);
    level.var_11CB.morse_code_loop_snd = lib_0380::func_288B(param_00, undefined, param_01);
    lib_0380::func_288F(level.var_11CB.morse_code_loop_snd, param_01, "morse_code_done");
    param_01 waittill("morse_code_done");
    wait(var_02);
  }
}

radio_stop_using_watcher() {
  self endon("death");
  self endon("disconnect");
  var_00 = self;
  var_01 = getent("radio_tuner_link_org", "targetname");
  self waittill("stop_using_station");
  var_00 method_8627("radio_interact_mix");
  lib_0380::func_684E(level.var_11CB.radio_tuner_idle_static_lp, 1, 0.2);
  lib_0380::func_6850(level.var_11CB.tuning_radio_lp, 0.3);
}

open_flare_crate(param_00) {
  lib_0380::func_2889("zmb_berl_flare_box_open", undefined, param_00);
}

flare_triggered(param_00) {
  lib_0380::func_2889("hur_clearing_flare", undefined, param_00);
}

snd_mute_horror_audio_vignettes() {
  self method_8626("mute_horror_audio_vignettes");
}

drop_pod_intro_mix() {
  for(;;) {
    if(isDefined(level.var_744A)) {
      foreach(var_01 in level.var_744A) {
        var_01 method_8626("berl_zepp_intro_mix");
        level waittill("zombie_wave_ended");
        var_01 method_8627("berl_zepp_intro_mix");
        return;
      }
    }

    wait(0.2);
  }
}

berlin_player_inside_outside_mixer() {
  self endon("disconnect");
  var_00 = 0.5;
  wait(0.5);
  var_01 = snd_is_outside(self);
  if(!var_01) {
    self method_8626("player_inside", 1);
  }

  var_02 = self.var_295A;
  level.var_11CB.airship_zones = ["zone_airship", "zone_airship_middle_front", "zone_airship_left", "zone_airship_right"];
  for(;;) {
    var_03 = snd_is_outside(self);
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(var_02)) {
      var_02 = "";
    }

    if(var_03 != var_01 || isDefined(self.var_295A) && self.var_295A != var_02) {
      var_02 = self.var_295A;
      if(var_03) {
        self method_8627("player_inside", 1);
        self method_8627("player_inside_airship", 1);
      } else {
        var_04 = 0;
        foreach(var_06 in level.var_11CB.airship_zones) {
          if(lib_055A::func_7413(self, var_06)) {
            var_04 = 1;
            break;
          }
        }

        if(var_04) {
          self method_8626("player_inside_airship", 1);
          self method_8627("player_inside", 1);
        } else {
          self method_8626("player_inside", 1);
          self method_8627("player_inside_airship", 1);
        }
      }

      var_01 = var_03;
    }

    wait(var_00);
  }
}

snd_is_outside(param_00) {
  return lib_055A::func_7413(param_00, "zone_street") || lib_055A::func_7413(param_00, "zone_church_garden");
}

start_airship_loop() {
  var_00 = self;
  self.airship_engine_loop = lib_0380::func_6846("zmb_berl_zepp_lp", undefined, var_00, 1);
  self.airship_engine_loop2 = lib_0380::func_6846("zmb_berl_zepp_eng_lp", undefined, var_00, 1);
}

start_straub_airship_loop() {
  var_00 = self;
  self.airship_engine_loop = lib_0380::func_6846("zmb_straub_blimp_engine_lp", undefined, var_00, 2);
  self.airship_engine_loop2 = lib_0380::func_6846("zmb_straub_blimp_engine_lfe_lp", undefined, var_00, 2);
  self.airship_engine_loop3 = lib_0380::func_6846("zmb_straub_blimp_engine_lfe_lp2", undefined, var_00, 2);
}

straub_airship_entrance() {
  var_00 = self;
  lib_0380::func_6844("zmb_berl_straub_zepp_enter", undefined, var_00);
}

stop_airship_loop(param_00) {
  var_01 = self;
  if(isDefined(self.airship_engine_loop)) {
    lib_0380::func_6850(self.airship_engine_loop, param_00);
    self.airship_engine_loop = undefined;
  }

  if(isDefined(self.airship_engine_loop2)) {
    lib_0380::func_6850(self.airship_engine_loop2, param_00);
    self.airship_engine_loop2 = undefined;
  }

  if(isDefined(self.airship_engine_loop3)) {
    lib_0380::func_6850(self.airship_engine_loop3, param_00);
    self.airship_engine_loop3 = undefined;
  }
}

func_17A0() {
  var_00 = self;
  lib_0380::func_288B("zmb_artillery_cannon_shot", undefined, var_00);
}

start_trap_tank(param_00, param_01) {
  var_02 = self.var_116;
  lib_0380::func_2889("zmb_berl_trap_water_activate", undefined, var_02);
  wait(0.6);
  self.trap_elec_lp1 = lib_0380::func_6842("trap_elec_arc_lp", undefined, var_02, param_00);
  self.trap_elec_lp2 = lib_0380::func_6842("trap_elec_crackle_lp", undefined, var_02, param_00);
  self.trap_elec_lp3 = lib_0380::func_6842("trap_elec_hiss_lp", undefined, var_02, param_00);
  self.trap_elec_lp4 = lib_0380::func_6842("trap_elec_hum_lp", undefined, var_02, param_00);
  self.trap_arc_sfx = undefined;
  var_03 = 0;
  while(var_03 < param_01) {
    var_04 = randomintrange(1, 2);
    if(var_04 == 1) {
      self.trap_arc_sfx = lib_0380::func_2889("trap_elec_arc", undefined, var_02);
    }

    var_03++;
    wait(1);
  }
}

stop_trap_tank() {
  var_00 = self.var_116;
  lib_0380::func_6850(self.trap_elec_lp1);
  lib_0380::func_6850(self.trap_elec_lp2);
  lib_0380::func_6850(self.trap_elec_lp3);
  lib_0380::func_6850(self.trap_elec_lp4);
  lib_0380::func_2893(self.trap_arc_sfx);
  lib_0380::func_2889("trap_elec_stop", undefined, var_00);
}

trap_tank_damage() {
  var_00 = self.var_116;
  lib_0380::func_2889("trap_elec_kill", undefined, var_00);
}

start_trap_cage(param_00, param_01) {
  var_02 = self.var_116;
  lib_0380::func_2889("zmb_berl_trap_cage_activate", undefined, var_02);
  wait(0.6);
  self.trap_elec_lp1 = lib_0380::func_6842("trap_elec_arc_lp", undefined, var_02, param_00);
  self.trap_elec_lp2 = lib_0380::func_6842("trap_elec_crackle_lp", undefined, var_02, param_00);
  self.trap_elec_lp3 = lib_0380::func_6842("trap_elec_hiss_lp", undefined, var_02, param_00);
  self.trap_elec_lp4 = lib_0380::func_6842("trap_elec_hum_lp", undefined, var_02, param_00);
  self.trap_arc_sfx = undefined;
  var_03 = 0;
  while(var_03 < param_01) {
    var_04 = randomintrange(1, 3);
    if(var_04 == 1) {
      self.trap_arc_sfx = lib_0380::func_2889("trap_elec_arc", undefined, var_02);
    } else if(var_04 == 2) {
      self.trap_arc_sfx = lib_0380::func_2889("zmb_berl_trap_cage_spark", undefined, var_02);
    }

    var_03++;
    wait(1);
  }
}

stop_trap_cage() {
  var_00 = self.var_116;
  lib_0380::func_6850(self.trap_elec_lp1);
  lib_0380::func_6850(self.trap_elec_lp2);
  lib_0380::func_6850(self.trap_elec_lp3);
  lib_0380::func_6850(self.trap_elec_lp4);
  lib_0380::func_2893(self.trap_arc_sfx);
  lib_0380::func_2889("trap_elec_stop", undefined, var_00);
}

trap_cage_damage() {
  var_00 = self.var_116;
  lib_0380::func_2889("trap_elec_kill", undefined, var_00);
}

start_trap_prop(param_00) {
  var_01 = self.var_116;
  lib_0380::func_2889("zmb_berl_trap_prop_start", undefined, var_01);
  wait(0.6);
  self.trap_prop_lp1 = lib_0380::func_6842("zmb_berl_trap_prop_lp", undefined, var_01, param_00);
  self.trap_prop_lp2 = lib_0380::func_6842("zmb_berl_trap_prop_lp2", undefined, var_01, param_00);
  self.trap_prop_lp3 = lib_0380::func_6842("zmb_berl_trap_prop_lp3", undefined, var_01, param_00);
}

stop_trap_prop() {
  var_00 = self.var_116;
  lib_0380::func_6850(self.trap_prop_lp1);
  lib_0380::func_6850(self.trap_prop_lp2);
  lib_0380::func_6850(self.trap_prop_lp3);
  lib_0380::func_2889("zmb_berl_trap_prop_stop", undefined, var_00);
}

trap_prop_damage() {
  var_00 = self.var_116;
  lib_0380::func_2889("zmb_berl_trap_prop_hit", undefined, var_00);
}

axe_hc_amoire_open() {
  var_00 = self;
  lib_0380::func_288B("zmb_berl_axe_hc_armoire_open", undefined, var_00);
}

axe_hc_pickup_scale(param_00) {
  lib_0380::func_2889("zmb_berl_axe_hc_scale_pu", undefined, param_00);
}

axe_hc_place_scale_piece(param_00) {
  lib_0380::func_288B("zmb_berl_axe_hc_place_scale_piece", undefined, param_00);
}

axe_hc_place_head(param_00) {
  lib_0380::func_288B("zmb_berl_axe_hc_place_head", undefined, param_00);
}

axe_hc_drawer_open(param_00) {
  lib_0380::func_288B("zmb_berl_axe_hc_drawer_open", undefined, param_00);
}

tether_ground_impact() {
  if(self == level.anchor_courtyard) {
    lib_0380::func_6844("zmb_berl_tether_impact_court", undefined, self);
    return;
  }

  lib_0380::func_6844("zmb_berl_tether_impact", undefined, self);
}

start_droppod_descend_loop() {
  var_00 = self;
  level.var_11CB.droppod_descend_pulley = lib_0380::func_6844("zmb_berl_droppod_descend_pulley", undefined, var_00);
  level.var_11CB.droppod_descend_wind_loop = lib_0380::func_6844("zmb_berl_droppod_descend_wind_lp", undefined, var_00, 1.5);
  level.var_11CB.droppod_descend_rattle_loop = lib_0380::func_6844("zmb_berl_droppod_descend_rattle_lp", undefined, var_00, 1.5);
  droppod_descend_bangs();
}

stop_droppod_descend_loop() {
  var_00 = self;
  lib_0380::func_6844("zmb_berl_droppod_descend_stop", undefined, var_00);
  if(isDefined(level.var_11CB.droppod_descend_pulley)) {
    lib_0380::func_6850(level.var_11CB.droppod_descend_pulley, 0.25);
    level.var_11CB.droppod_descend_pulley = undefined;
  }

  if(isDefined(level.var_11CB.droppod_descend_wind_loop)) {
    lib_0380::func_6850(level.var_11CB.droppod_descend_wind_loop, 0.25);
    level.var_11CB.droppod_descend_wind_loop = undefined;
  }

  if(isDefined(level.var_11CB.droppod_descend_rattle_loop)) {
    lib_0380::func_6850(level.var_11CB.droppod_descend_rattle_loop, 0.25);
    level.var_11CB.droppod_descend_rattle_loop = undefined;
  }
}

stop_droppod_winch_up_loop() {
  if(isDefined(level.var_11CB.droppod_winch_up_loop)) {
    lib_0380::func_6850(level.var_11CB.droppod_winch_up_loop, 0.25);
    level.var_11CB.droppod_winch_up_loop = undefined;
  }

  if(isDefined(level.var_11CB.droppod_ascend_rattle_loop)) {
    lib_0380::func_6850(level.var_11CB.droppod_ascend_rattle_loop, 0.25);
    level.var_11CB.droppod_ascend_rattle_loop = undefined;
  }
}

droppod_descend_bangs() {
  var_00 = 0.5;
  var_01 = 1.5;
  level endon("airship_drop_pod_reached_ground");
  level endon("stop_move_down_rumble");
  for(;;) {
    var_02 = randomfloatrange(var_00, var_01);
    wait(var_02);
    lib_0380::func_6840("zmb_berl_droppod_bang", undefined);
  }
}

droppod_ground_impact() {
  var_00 = self;
  lib_0380::func_6844("zmb_berl_droppod_descend_impact", undefined, var_00);
  stop_droppod_descend_loop();
}

start_drop_pod_sway() {
  thread drop_pod_sway_1();
  thread drop_pod_sway_2();
  thread drop_pod_sway_3();
  thread drop_pod_sway_4();
}

inside_droppod_submix_strt() {
  foreach(var_01 in level.var_744A) {
    var_01 method_8626("inside_droppod");
  }
}

inside_droppod_submix_stp() {
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("inside_droppod");
  }
}

drop_pod_sway_1() {
  level endon("airship_escape_drop_pod_doors_complete");
  for(;;) {
    var_00 = randomintrange(4, 6);
    lib_0380::func_6842("zmb_berl_pod_sway_low", undefined, (251, 9116, -2889));
    wait(var_00);
  }
}

drop_pod_sway_2() {
  level endon("airship_escape_drop_pod_doors_complete");
  for(;;) {
    var_00 = randomintrange(4, 6);
    lib_0380::func_6842("zmb_berl_pod_sway_low", undefined, (1184, 9096, -2889));
    wait(var_00);
  }
}

drop_pod_sway_3() {
  level endon("airship_escape_drop_pod_doors_complete");
  for(;;) {
    var_00 = randomintrange(4, 6);
    lib_0380::func_6842("zmb_berl_pod_sway_low", undefined, (1264, 8153, -2889));
    wait(var_00);
  }
}

drop_pod_sway_4() {
  level endon("airship_escape_drop_pod_doors_complete");
  for(;;) {
    var_00 = randomintrange(4, 6);
    lib_0380::func_6842("zmb_berl_pod_sway_low", undefined, (320, 8148, -2889));
    wait(var_00);
  }
}

droppod_winch_up() {
  var_00 = self;
  if(isDefined(level.var_11CB.droppod_descend_wind_loop)) {
    stop_droppod_descend_loop();
  }

  lib_0380::func_6844("zmb_berl_droppod_winch_start", undefined, var_00);
  level.var_11CB.droppod_winch_up_loop = lib_0380::func_6844("zmb_berl_droppod_winch_lp", undefined, var_00, 1.75);
  level.var_11CB.droppod_ascend_rattle_loop = lib_0380::func_6844("zmb_berl_droppod_ascend_rattle_lp", undefined, var_00, 1.75);
}

droppod_winch_down() {
  var_00 = self;
  stop_droppod_winch_up_loop();
  lib_0380::func_6844("zmb_berl_droppod_winch_stop", undefined, var_00);
  start_droppod_descend_loop();
}

droppod_lock_in() {
  var_00 = self;
  stop_droppod_winch_up_loop();
  lib_0380::func_2888("zmb_berl_droppod_ascend_lock_in", var_00);
}

droppod_escape_fire() {
  var_00 = self;
  lib_0380::func_6844("zmb_berl_droppod_escape", undefined, var_00);
  zepplin_damaged_cleanup();
}

func_ABF8(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  var_03 = 0;
  var_04 = 0.875;
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02, 0, var_04);
  var_02 moveto(param_01, 1.9);
  wait(2);
  var_02 delete();
}

func_ABF9(param_00) {
  lib_0380::func_2889("zombie_soul_suck_threshold", undefined, param_00);
}

js_corpse_becomes_zombie() {
  lib_0366::snd_not_so_simple_jump_scare();
}

js_assassin_landing() {
  lib_0366::snd_not_so_simple_jump_scare();
}

bob_engine(param_00) {
  var_01 = self;
  thread handle_bob_spawned_music();
  thread bob_spawned_submix();
  switch (param_00) {
    case "bob_punch":
      level.var_11CB.bob_engine_loop = lib_0380::func_6844("zmb_berl_bob_engine_lp", undefined, var_01, 0.2);
      level.var_11CB.bob_engine_loop_hi = lib_0380::func_6844("zmb_berl_bob_engine_hi_lp", undefined, var_01, 0.2);
      level.var_11CB.curr_phase = "bob_punch";
      break;

    case "bob_smoke":
      wait(1);
      lib_0380::func_6850(level.var_11CB.bob_engine_loop, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_loop_hi, 0.5);
      level.var_11CB.bob_engine_phase3_loop = lib_0380::func_6844("zmb_berl_bob_engine_phase_3_lp", undefined, var_01, 0.2);
      level.var_11CB.bob_engine_phase3_loop_hi = lib_0380::func_6844("zmb_berl_bob_engine_phase_3_hi_lp", undefined, var_01, 0.2);
      level.var_11CB.bob_engine_phase3_loop_dmgd = lib_0380::func_6844("zmb_berl_bob_engine_phase_3_dmged_lp", undefined, var_01, 0.2);
      level.var_11CB.curr_phase = "bob_smoke";
      break;

    case "bob_killed":
      lib_0380::func_6850(level.var_11CB.bob_engine_loop, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_loop_hi, 0.5);
      wait(1.5);
      lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop, 0.65, 0.25);
      lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_hi, 0.65, 0.25);
      lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_dmgd, 0.65, 0.25);
      wait(11);
      lib_0380::func_6850(level.var_11CB.bob_engine_phase3_loop, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_phase3_loop_hi, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_phase3_loop_dmgd, 0.5);
      lib_0380::func_288B("zmb_berl_bob_engine_turn_off", undefined, var_01);
      wait(2);
      thread post_bob_zepplin_events();
      level.var_11CB.bob_engine_loop = undefined;
      level.var_11CB.bob_engine_loop_hi = undefined;
      level.var_11CB.bob_engine_phase3_loop = undefined;
      level.var_11CB.bob_engine_phase3_loop_hi = undefined;
      level.var_11CB.bob_engine_phase3_loop_dmgd = undefined;
      thread handle_bob_killed_music();
      break;

    case "bob_engine_rev":
      if(level.var_11CB.curr_phase == "bob_punch") {
        lib_0380::func_684E(level.var_11CB.bob_engine_loop, 0, 0.7);
        lib_0380::func_684E(level.var_11CB.bob_engine_loop_hi, 0, 0.7);
        lib_0380::func_288B("zmb_berl_bob_engine_rev", undefined, var_01);
        wait(1.75);
        lib_0380::func_684E(level.var_11CB.bob_engine_loop, 1, 1);
        lib_0380::func_684E(level.var_11CB.bob_engine_loop_hi, 1, 1);
      }

      if(level.var_11CB.curr_phase == "bob_smoke") {
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop, 0, 0.7);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_hi, 0, 0.7);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_dmgd, 0, 0.7);
        lib_0380::func_288B("zmb_berl_bob_engine_rev_dmg", undefined, var_01);
        wait(1.75);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop, 1, 1);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_hi, 1, 1);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_dmgd, 1, 1);
      }
      break;

    default:
      break;
  }
}

bob_spawned_submix() {
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("escape_zepplin_loud");
    var_01 method_8626("escape_zepplin_soft");
  }
}

handle_bob_spawned_music() {
  if(!isDefined(level.var_11CB.bob_music_playing) && !isDefined(level.var_11CB.bob_is_dead)) {
    level.var_11CB.bob_music_playing = 1;
    foreach(var_01 in level.var_744A) {
      var_01 lib_0366::snd_set_auto_wave_music_enabled(0);
      var_01 notify("kill_wave_mus_switcher");
      var_01 lib_0366::func_8E31("bob_fight", 0.25, 3);
    }
  }
}

handle_bob_killed_music() {
  level.var_11CB.bob_music_playing = undefined;
  level.var_11CB.bob_is_dead = 1;
  foreach(var_01 in level.var_744A) {
    var_01 thread play_boss_killed_stinger();
  }
}

play_boss_killed_stinger() {
  self method_8626("bob_death_stinger", 0.2);
  lib_0380::func_2888("mus_bob_death_stinger", self);
  wait(10);
  self method_8627("bob_death_stinger", 4);
}

bob_smoke_attack_strt() {
  var_00 = self;
  wait(1.25);
  lib_0380::func_288B("zmb_berl_bob_smoke_atk_explo", undefined, var_00);
}

bob_smoke_attack_loop(param_00, param_01) {
  var_02 = lib_0380::func_6842("zmb_berl_bob_smoke_atk_smk_lp", undefined, param_01, 0.5);
  var_03 = lib_0380::func_6842("zmb_berl_bob_smoke_atk_elec_hum_lp", undefined, param_01, 0.5);
  var_04 = lib_0380::func_6842("zmb_berl_bob_smoke_atk_elec_static_lp", undefined, param_01, 0.5);
  wait(param_00);
  lib_0380::func_6850(var_02, 0.5);
  lib_0380::func_6850(var_03, 0.5);
  lib_0380::func_6850(var_04, 0.5);
  lib_0380::func_2889("zmb_berl_bob_smoke_atk_end", undefined, param_01);
}

bob_stab_leg() {
  var_00 = self;
  wait(1.4);
  lib_0380::func_288B("zmb_berl_bob_shoot_leg", undefined, var_00);
}

bob_shoot_gun(param_00) {
  var_01 = self;
  if(!isDefined(level.var_11CB.bob_shoot_snd)) {
    level.var_11CB.bob_shoot_snd = lib_0380::func_2889("zmb_bob_gun_fire", undefined, param_00);
    lib_0380::func_288F(level.var_11CB.bob_shoot_snd, var_01, "shoot_sound_done");
    var_01 waittill("shoot_sound_done");
    level.var_11CB.bob_shoot_snd = undefined;
  }
}

wonderbuss_build_collect_battery(param_00) {
  lib_0380::func_2889("zmb_wonderbuss_battery_pickup", undefined, param_00);
}

wonderbuss_build_battery_door_unlock(param_00) {
  lib_0380::func_2889("zmb_wonderbuss_battery_place", undefined, param_00);
  lib_0380::func_2889("zmb_wonderbuss_door_open", undefined, (225, -1495, 971));
}

wonderbuss_build_battery_door_lock(param_00) {
  lib_0380::func_2889("zmb_wonderbuss_battery_pickup", undefined, param_00);
  lib_0380::func_2889("zmb_wonderbuss_door_close", undefined, (225, -1495, 971));
}

wonderbuss_weapon_build_infusion(param_00) {
  lib_0380::func_2889("zmb_wonderbuss_build_infusion", undefined, param_00);
}

pap_move_elevator() {
  var_00 = self;
  lib_0380::func_288B("zmb_island_pap_elevator_move", undefined, var_00);
}

pap_open_elevator() {
  var_00 = self;
  lib_0380::func_288B("zmb_island_pap_elev_door_open", undefined, var_00);
}

zep_puzzle_light_switch() {
  var_00 = self;
  var_00.switch_on_sound = lib_0380::func_288B("zmb_berl_elect_puzzle_light", undefined, var_00);
}

zep_puzzle_light_switch_off() {
  var_00 = self;
  var_00.switch_off_sound = lib_0380::func_288B("zmb_berl_elect_puzzle_light_off", undefined, var_00);
}

zep_puzzle_spark_loop() {
  var_00 = lib_0380::func_6844("zmb_berl_elect_puzzle_electricity", undefined, level.in_world_spark, 0.2);
  common_scripts\utility::func_3C9F("flag_override_electroschnell_complete");
  lib_0380::func_6850(var_00, 0.5);
  lib_0380::func_2889("zmb_berl_electro_overload_hit_a", undefined, (776, 6939, -3170));
}

zep_puzzle_spark_arrive() {
  var_00 = self;
  var_01 = lib_0380::func_288B("zmb_berl_elect_puzzle_energy_lock", undefined, var_00);
}

zep_puzzle_spark_leave() {
  var_00 = self;
  wait(0.2);
  var_01 = lib_0380::func_288B("zmb_berl_elect_puzzle_energy_release", undefined, var_00);
}

electroschnell_overload_explo() {
  wait(0.8);
  lib_0380::func_2889("zmb_berl_electro_overload_explode", undefined, (776, 6939, -3170));
  thread straub_death_maul();
  thread zepplin_damaged_sounds();
}

straub_death_maul() {
  wait(1.7);
  foreach(var_01 in level.var_744A) {
    var_01 method_8626("straub_death_vignette");
  }

  lib_0380::func_288B("zmb_berl_straub_death_zom_vox", undefined, level.airship_straub);
  lib_0380::func_288B("zmb_berl_straub_death_zom_vox_pa", undefined, level.airship_straub);
  wait(9.2);
  lib_0380::func_2889("zmb_berl_straub_death_splatter_a", undefined, (942, 6820, -3170));
  lib_0380::func_2889("zmb_berl_straub_death_splatter_b", undefined, (935, 6963, -3170));
  lib_0380::func_2889("zmb_berl_straub_death_splatter_c", undefined, (623, 6977, -3170));
  lib_0380::func_2889("zmb_berl_straub_death_splatter_d", undefined, (627, 6809, -3170));
  lib_0380::func_2889("zmb_berl_straub_death_splatter_e", undefined, (848, 6698, -3170));
  wait(3.2);
  lib_0380::func_2889("zmb_berl_straub_death_shutters_a", undefined, (948, 6892, -3170));
  lib_0380::func_2889("zmb_berl_straub_death_shutters_b", undefined, (622, 6880, -3170));
  lib_0380::func_2889("zmb_berl_straub_death_shutters_c", undefined, (799, 6676, -3170));
  wait(1.5);
  lib_0380::func_2889("zmb_berl_straub_death_shutters_steam", undefined, (948, 6892, -3170));
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("straub_death_vignette");
    var_01 method_8626("escape_zepplin_loud");
  }
}

zepplin_damaged_sounds() {
  wait(2);
  lib_0380::func_2888("zmb_berl_zepplin_alarm");
  level.var_11CB.airship_damaged_rattle_lp = lib_0380::func_6840("zmb_berl_zeppelin_damaged", undefined, 0.5);
  level.var_11CB.airship_damaged_engine_lp = lib_0380::func_6840("zmb_berl_zepplin_dmg_engine", undefined, 0.5);
  thread zepplin_damaged_2d_oneshots();
  thread zepplin_damaged_3d_oneshots();
}

post_bob_zepplin_events() {
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("escape_zepplin_soft");
    var_01 method_8626("escape_zepplin_loud");
  }

  level.var_11CB.zepplin_damaged_sub = lib_0380::func_6840("zmb_berl_zepplin_damaged_sub_lp");
}

zepplin_damaged_2d_oneshots() {
  level endon("airship_escape_drop_pod_doors_complete");
  for(;;) {
    var_00 = randomintrange(7, 9);
    lib_0380::func_2888("zmb_berl_zepplin_dmgd_hit_heavy");
    wait(var_00);
  }
}

zepplin_damaged_3d_oneshots() {
  level endon("airship_escape_drop_pod_doors_complete");
  for(;;) {
    foreach(var_01 in level.var_744A) {
      var_02 = randomintrange(6, 9);
      var_03 = var_01.var_116 + (randomintrange(-500, 500), randomintrange(-500, 500), 0);
      lib_0380::func_2889("zmb_berl_zepplin_dmgd_rattle", var_01, var_03);
      wait(var_02);
    }
  }
}

zepplin_damaged_cleanup() {
  lib_0380::func_6850(level.var_11CB.airship_damaged_rattle_lp, 0.5);
  lib_0380::func_6850(level.var_11CB.airship_damaged_engine_lp, 0.5);
  lib_0380::func_6850(level.var_11CB.zepplin_damaged_sub, 0.5);
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("escape_zepplin_loud");
  }

  level.var_11CB.airship_damaged_rattle_lp = undefined;
  level.var_11CB.airship_damaged_engine_lp = undefined;
  level.var_11CB.zepplin_damaged_sub = undefined;
}

open_barbarosa_area_door(param_00) {
  lib_0380::func_2889("zmb_berl_barb_door_open", undefined, param_00);
}

close_barbarosa_area_door(param_00) {
  lib_0380::func_2889("zmb_berl_barb_door_close", undefined, param_00);
}

place_weapon_in_slot(param_00, param_01) {
  if(param_00 == "bat") {
    lib_0380::func_2889("zmb_berl_barb_place_bat", undefined, param_01);
  }

  if(param_00 == "dagger") {
    lib_0380::func_2889("zmb_berl_barb_place_dagger", undefined, param_01);
  }

  if(param_00 == "pickaxe") {
    lib_0380::func_2889("zmb_berl_barb_place_pickaxe", undefined, param_01);
  }

  if(param_00 == "sword") {
    lib_0380::func_2889("zmb_berl_barb_place_pickaxe", undefined, param_01);
  }
}

statue_rotate_handler() {
  var_00 = self;
  if(common_scripts\utility::func_3C77("raven_puzzle_currently_rotating")) {
    var_00.statue_rotating_snd = lib_0380::func_6844("zmb_berl_barb_statue_rotate_lp", undefined, var_00, 0.3);
    return;
  }

  if(!common_scripts\utility::func_3C77("raven_puzzle_currently_rotating")) {
    lib_0380::func_6850(var_00.statue_rotating_snd, 0.3);
    var_00.statue_stop_snd = lib_0380::func_288B("zmb_berl_barb_statue_stop_impact", undefined, var_00);
  }
}

statue_wall_complete() {
  wait(0.8);
  lib_0380::func_2889("zmb_berl_barb_statue_solve_imp", undefined, (1561, 3104, 857));
}

pickup_bird(param_00) {
  lib_0380::func_2889("zmb_berl_barb_statue_pickup_bird", undefined, param_00);
}

place_bird(param_00) {
  lib_0380::func_2889("zmb_berl_barb_statue_place_bird", undefined, param_00);
}

sword_reveal() {
  var_00 = getent("bird_statue_sword_bit", "targetname");
  wait(0.6);
  lib_0380::func_2889("zmb_berl_barb_statue_swrd_reveal", undefined, var_00.var_116);
}

pickup_barbarosa_sword() {
  var_00 = self;
  lib_0380::func_288B("zmb_pickup_raven_swrd", var_00, var_00);
}

smugglers_bat_power_generator_start(param_00) {
  lib_0380::func_6842("smugglers_bat_power_generator_start", undefined, param_00);
  level.var_11CB.smugglers_bat_power_generator_lp = lib_0380::func_6842("smugglers_bat_smugglers_bat_lp", undefined, param_00);
}

smugglers_bat_power_generator_stop(param_00) {
  lib_0380::func_6842("smugglers_bat_smugglers_bat_stop", undefined, param_00);
  lib_0380::func_6850(level.var_11CB.smugglers_bat_power_generator_lp);
  level.var_11CB.smugglers_bat_power_generator_lp = undefined;
}

smugglers_bat_big_doors_open(param_00) {
  lib_0380::func_2889("smugglers_bat_big_doors_open", undefined, param_00);
}

smugglers_bat_cash_register(param_00) {
  lib_0380::func_2889("smugglers_bat_cash_register", undefined, param_00);
}

smugglers_bat_door_break_down(param_00) {
  lib_0380::func_2889("smugglers_bat_door_break_down", undefined, param_00);
}

smugglers_bat_door_open_squeaky(param_00) {
  lib_0380::func_2889("smugglers_bat_door_open_squeaky", undefined, param_00);
}

smugglers_bat_door_pound(param_00) {
  lib_0380::func_2889("smugglers_bat_door_pound", undefined, param_00);
}

smugglers_bat_gas_cover_open_01(param_00) {
  lib_0380::func_2889("smugglers_bat_gas_cover_open_01", undefined, param_00);
}

smugglers_bat_gas_cover_open_02(param_00) {
  lib_0380::func_2889("smugglers_bat_gas_cover_open_02", undefined, param_00);
}

smugglers_bat_pickup(param_00) {
  lib_0380::func_2889("zmb_hc_bat_aoe_fx", undefined, param_00);
}

smugglers_bat_weapon_drop(param_00) {
  lib_0380::func_2889("smugglers_bat_weapon_drop", undefined, param_00);
}

smugglers_bat_start_combat_loop(param_00, param_01) {
  smugglers_bat_stop_combat_loop();
  level.var_11CB.smugglers_bat_combat_lp = lib_0380::func_6842(param_01, undefined, param_00);
}

smugglers_bat_stop_combat_loop() {
  lib_0380::func_6850(level.var_11CB.smugglers_bat_combat_lp, 1);
  level.var_11CB.smugglers_bat_combat_lp = undefined;
}

ddagger_film_canister_fall(param_00) {
  lib_0380::func_288B("ddagger_film_canister_fall", undefined, param_00);
}

ddagger_film_canister_pickup(param_00) {
  lib_0380::func_288B("ddagger_film_canister_pickup", undefined, param_00);
}

ddagger_picture_placement(param_00) {
  lib_0380::func_2889("ddagger_picture_placement", undefined, param_00);
}

ddagger_picture_remove(param_00) {
  lib_0380::func_2889("ddagger_picture_remove", undefined, param_00);
}

ddagger_projector_attach_reel(param_00) {
  lib_0380::func_2889("ddagger_projector_attach_reel", undefined, param_00);
}

ddagger_projector_on(param_00) {
  lib_0380::func_2889("ddagger_projector_on", undefined, param_00);
  level.var_11CB.ddagger_projector_loop = lib_0380::func_2889("ddagger_projector_loop", undefined, param_00, 0.5);
}

ddagger_projector_off() {
  lib_0380::func_2893(level.var_11CB.ddagger_projector_loop, 1);
}

ddagger_vault_door_open(param_00) {
  lib_0380::func_2889("ddagger_vault_door_open", undefined, param_00);
}

ddagger_vault_handle_open(param_00) {
  lib_0380::func_2889("ddagger_vault_handle_open", undefined, param_00);
}

ddagger_vault_tick(param_00) {
  lib_0380::func_2889("ddagger_vault_tick", undefined, param_00);
}

ddagger_vault_tick_success(param_00) {
  lib_0380::func_2889("ddagger_vault_tick_success", undefined, param_00);
}

dancer_jumpscare() {
  var_00 = self;
  lib_0380::func_288B("zmb_berl_al_scream", undefined, var_00);
}

ring_bell() {
  var_00 = self;
  lib_0380::func_288B("zmb_berl_al_bell", undefined, var_00);
}

pa_system_dialogue_setup() {
  foreach(var_01 in level.var_744A) {
    if(isDefined(var_01.pa_player_speaker_1)) {
      continue;
    }

    var_01.pa_player_speaker_1 = spawn("script_model", var_01.var_116);
    var_01.pa_player_speaker_1 setModel("tag_origin");
    var_01.pa_player_speaker_2 = spawn("script_model", var_01.var_116);
    var_01.pa_player_speaker_2 setModel("tag_origin");
    var_01 thread pa_system_dialogue_cleanup();
  }
}

pa_system_dialogue_cleanup() {
  var_00 = self;
  var_00 common_scripts\utility::func_A732("pa_system_cleanup", "disconnect");
  if(isDefined(var_00.pa_player_speaker_1)) {
    var_00.pa_player_speaker_1 delete();
    var_00.pa_player_speaker_1 = undefined;
  }

  if(isDefined(var_00.pa_player_speaker_2)) {
    var_00.pa_player_speaker_2 delete();
    var_00.pa_player_speaker_2 = undefined;
  }
}

pa_system_dialogue_all_players(param_00, param_01, param_02, param_03) {
  if(!function_0344(param_00)) {
    return;
  }

  pa_system_dialogue_setup();
  for(var_04 = 0; var_04 < level.var_744A.size - 1; var_04++) {
    level.var_744A[var_04] thread pa_system_dialogue(param_00, param_01, param_02, param_03);
  }

  level.var_744A[level.var_744A.size - 1] pa_system_dialogue(param_00, param_01, param_02, param_03);
}

pa_system_dialogue(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_04 endon("disconnect");
  var_04 endon("death");
  var_05 = 0.3;
  var_06 = [];
  var_07 = 1;
  if(isDefined(param_02)) {
    var_07 = param_02;
  }

  if(!isDefined(param_03)) {
    return;
  }

  if(!isarray(param_03)) {
    var_06 = [param_03];
  } else {
    var_06 = param_03;
  }

  var_04 childthread pa_system_player_track(var_06);
  wait 0.05;
  var_08 = param_00;
  var_09 = param_00 + "_echo";
  var_0A = param_00 + "_delay";
  var_0B = 0;
  var_0C = 0;
  if(function_0344(var_09)) {
    var_0B = 1;
  }

  if(function_0344(var_0A)) {
    var_0C = 1;
  }

  lib_0380::func_6850(var_04.var_71D.pa_vo_on_player, 0.25);
  var_04.var_71D.pa_vo_on_player = undefined;
  if(isDefined(var_08)) {
    var_04.var_71D.pa_vo_on_player = lib_0380::func_6844(var_08, var_04, var_04, 0, 1);
    lib_0380::func_684C(var_04.var_71D.pa_vo_on_player, var_04, "pa_vo_on_player_done");
  }

  if(isDefined(var_04.var_71D.var_6DD9)) {
    lib_0380::func_6850(var_04.var_71D.var_6DD9, 0.25);
    var_04.var_71D.var_6DD9 = undefined;
  }

  if(isDefined(var_09) && var_0B) {
    var_04.var_71D.var_6DD9 = lib_0380::func_6840(var_09, var_04, 0, 0.25);
    lib_0380::func_684C(var_04.var_71D.var_6DD9, var_04, "pa_vo_echo_done");
  }

  if(isDefined(var_04.pa_player_speaker_1) && isDefined(var_04.pa_player_speaker_1.pa_speaker_1_snd)) {
    lib_0380::func_6850(var_04.pa_player_speaker_1.pa_speaker_1_snd, 0.25);
    var_04.pa_player_speaker_1.pa_speaker_1_snd = undefined;
  }

  if(isDefined(var_0A) && var_0C) {
    var_04.pa_player_speaker_1.pa_speaker_1_snd = lib_0380::func_6844(var_0A, var_04, var_04.pa_player_speaker_1, 0, 0.5);
    if(isDefined(var_04.pa_player_speaker_1.pa_speaker_1_snd)) {
      var_04.pa_player_speaker_1.pa_speaker_1_snd waittill("death");
    } else {
      wait 0.05;
    }
  } else if(var_0B) {
    var_04 waittill("pa_vo_echo_done");
  } else {
    var_04 waittill("pa_vo_on_player_done");
  }

  if(common_scripts\utility::func_562E(var_07)) {
    var_04 notify("pa_system_cleanup");
  }
}

pa_system_player_track(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01.pa_player_speaker_1 endon("pa_system_line_done");
  for(;;) {
    var_02 = function_01AC(param_00, var_01.var_116);
    if(isDefined(var_01.pa_player_speaker_1)) {
      var_01.pa_player_speaker_1.var_116 = var_02[0].var_116;
    }

    if(isDefined(var_01.pa_player_speaker_2)) {
      if(isDefined(var_02[1])) {
        var_01.pa_player_speaker_2.var_116 = var_02[1].var_116;
      } else {
        var_01.pa_player_speaker_2.var_116 = var_02[0].var_116;
      }
    }

    wait(0.5);
  }
}