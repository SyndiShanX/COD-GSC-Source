/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_audio.gsc
*****************************************************/

main() {
  aud_init_globals();
  aud_ignore_timescale();
}

aud_init_globals() {
  level.aud_zoom_on = 0;
  level.aud_last_zoom = 1;
  level.aud_zoom_in_sound = spawn("script_origin", level.player.origin);
  level.aud_zoom_in_sound linkto(level.player);
  level.aud_zoom_out_sound = spawn("script_origin", level.player.origin);
  level.aud_zoom_out_sound linkto(level.player);
  level.aud_sniper_background = spawn("script_origin", level.player.origin);
  level.aud_bullet_count = 0;
  level.aud_max_bullets = 8;
  level.aud_vehicle_jolt_count = 0;
  level.aud_intro_convoy_counter = -1;
  level.aud_play_jet_flyby = 1;
  level.aud_random_enemy_chatter = spawn("script_origin", (2541, -2799, -798));
  level.aud_finale_sniper = spawn("script_origin", (3278, -292, 136));
  level.aud_finale_sniper2 = spawn("script_origin", (3182, -313, 136));
  level.aud_vip_combat = spawn("script_origin", (2129, -6592, -76));
  level.aud_finale_chopper1 = spawn("script_origin", (3409, 1652, 137));
  level.aud_finale_chopper2 = spawn("script_origin", (3614, 1675, 137));
  level.aud_finale_chopper3 = spawn("script_origin", (3681, 2329, 137));
  level.aud_finale_chopper4 = spawn("script_origin", (3520, 2351, 137));
  level.aud_finale_pa_guys = spawn("script_origin", (3115, -3430, 137));
  level.aud_stadium_crumble1 = spawn("script_origin", (613, -5735, -212));
  level.aud_stadium_crumble2 = spawn("script_origin", (1288, -5762, -165));
  level.aud_vip_ally_locs = [(3616, 734, 138), (3462, 785, 138), (3329, 811, 138), (3145, 813, 138)];
  level.aud_traverse_ally_locs = [(3462, 1516, 138), (3275, 1343, 138), (3254, 1785, 138), (2487, 1874, 138)];
  level.aud_finale_ally_locs = [(3552, -204, 138), (3355, -113, 138), (3200, -71, 138), (2938, -147, 138)];
  level.aud_lynx_guys = 3;
  level.aud_turret_indices = [0, 1, 2];
  level.aud_player_reloading = 0;
}

aud_ignore_timescale() {
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("norestrict", 0);
  soundsettimescalefactor("effects2dlim", 0);
}

aud_check(var_0) {
  if(var_0 == "rooftop_shoot") {
    thread aud_birds();
    thread aud_intro_choppers();
  } else if(var_0 == "drive_in") {
    level.player_truck vehicle_turnengineoff();
    wait 0.5;
    thread aud_convoy_done();
  } else if(var_0 == "atrium") {
    level.player setclienttriggeraudiozone("enhq_truck", 0);
    thread aud_alarm();
    thread aud_salsa_music();
    level.player thread maps\_utility::play_sound_on_entity("enhq_truck_shake_suspension");
    level.player thread maps\_utility::play_sound_on_entity("enhq_truck_enter_bleachers");
    wait 0.25;
    level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy");
    level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy2");
    level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy3");
    level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy_lfe");
  } else if(var_0 == "vip") {
    thread aud_distant_alarm();
    thread aud_salsa_music();
  } else if(var_0 == "traverse") {
    thread aud_distant_alarm();
    thread aud_random_enemy_chatter();
    thread aud_random_enemy_pa(level.aud_random_enemy_chatter);
    thread aud_random_rumbles();
  } else {
    if(var_0 == "teargas") {
      return;
    }
    if(var_0 == "combat") {
      return;
    }
    if(var_0 == "clubhouse") {
      return;
    }
    if(var_0 == "hvt") {
      maps\_utility::music_play("mus_hq_found_ajax");
    }
    else {
      if(var_0 == "finale") {
        return;
      }
      if(var_0 == "newfinale") {
        return;
      }
      return;
      return;
      return;
      return;
    }
  }
}

aud_music(var_0) {
  if(var_0 == "drivein") {
    wait 1.5;
    maps\_utility::music_play("mus_hq_truck1");
  } else {
    if(var_0 == "atriumcombat") {
      return;
    }
    if(var_0 == "lookfordoor") {
      maps\_utility::music_play("mus_hq_breach_search");
    }
    else if(var_0 == "foundajax") {
      wait 2;
      maps\_utility::music_play("mus_hq_found_ajax");
    } else if(var_0 == "combatprep")
      maps\_utility::music_crossfade("mus_hq_combat_prep", 1.0);
    else if(var_0 == "finalbattle") {
      maps\_utility::music_crossfade("mus_hq_final_battle", 1.0);
    }
    else {
      if(var_0 == "exfil") {
        return;
      }
      return;
    }
  }
}

aud_start_sniper_intro() {
  level.player setclienttriggeraudiozone("enhq_intro", 0);
  levelsoundfade(1, 3);
  thread aud_birds();
  thread aud_intro_choppers();
  wait 3.7;
  level.player thread maps\_utility::play_sound_on_entity("enhq_intro_sniper_setup");
  wait 0.3;
  level.aud_zoom_in_sound scalevolume(0);
  level.aud_zoom_out_sound scalevolume(0);
  level.aud_zoom_in_sound playLoopSound("enhq_sniper_zoom_in_lp");
  level.aud_zoom_out_sound playLoopSound("enhq_sniper_zoom_out_lp");
  level.aud_sniper_background playLoopSound("enhq_sniper_zoom_background_lp");
  wait 0.6;
  level.player thread maps\_utility::play_sound_on_entity("enhq_intro_allies_setup");
  wait 2.4;
  common_scripts\utility::flag_wait("bishop_glimpse_over");
  level.player clearclienttriggeraudiozone(0.25);
}

aud_intro_choppers() {
  thread common_scripts\utility::play_sound_in_space("enhq_intro_choppers", (969, -6135, 712));
}

aud_fx_planes() {
  if(common_scripts\utility::flag("start_gas_scene")) {
    return;
  }
  wait 1.7;

  if(self.model == "ehq_bomber_y_8" && level.aud_play_jet_flyby) {
    thread common_scripts\utility::play_sound_in_space("enhq_jet_flyby_1", (1133, -8854, 5440));
  }

  level.aud_play_jet_flyby = !level.aud_play_jet_flyby;
}

aud_birds() {
  while(!common_scripts\utility::flag("FLAG_intro_truck_arrived")) {
    thread common_scripts\utility::play_sound_in_space("enhq_birds_ambience", (5380, 3841, 663));
    wait(randomintrange(15, 25));
  }
}

aud_dry_fire() {
  level.player thread maps\_utility::play_sound_on_entity("enhq_dryfire_rifle_plr");

  for(;;) {
    level.player waittill("attack");

    if(!common_scripts\utility::flag("bishop_glimpse_over")) {
      level.player thread maps\_utility::play_sound_on_entity("enhq_dryfire_rifle_plr");
      continue;
    }

    return;
  }
}

aud_start_sniper(var_0) {
  level.player notify("sniper_started");
  level.player setclienttriggeraudiozone(var_0, 0);
  level.aud_zoom_in_sound scalevolume(0);
  level.aud_zoom_out_sound scalevolume(0);
  level.aud_zoom_in_sound playLoopSound("enhq_sniper_zoom_in_lp");
  level.aud_zoom_out_sound playLoopSound("enhq_sniper_zoom_out_lp");
  level.player playSound("enhq_sniper_start");
  thread aud_sniper_fire();

  if(var_0 == "enhq_atrium_covered") {
    level.aud_convo linkto(level.player);
    level.aud_vip_combat linkto(level.player);
    var_1 = getaiarray("axis");
    var_2 = getaiarray("allies");

    foreach(var_4 in var_2) {
    var_4 thread aud_handle_allies_remote_sniper(level.aud_vip_ally_locs);
    }

    foreach(var_7 in var_1) {
    var_7 thread aud_handle_remote_sniper_ai(level.aud_vip_combat);
    }
  } else if(var_0 == "enhq_stadium_large_room") {
    wait 2;
    level.aud_finale_sniper notify("start_sniping");
    var_1 = getaiarray("axis");
    var_2 = getaiarray("allies");

    foreach(var_4 in var_2) {
    var_4 thread aud_handle_allies_remote_sniper(level.aud_finale_ally_locs);
    }

    foreach(var_7 in var_1) {
    var_7 thread aud_handle_remote_sniper_ai(level.aud_finale_sniper);
    }

    level.aud_finale_sniper linkto(level.player);
    level.aud_finale_sniper2 linkto(level.player);
    thread aud_pa_guys();
  } else if(var_0 == "enhq_stadium_open") {
    level.aud_stadium_crumble1 linkto(level.player);
    level.aud_stadium_crumble2 linkto(level.player);
    thread aud_rpg_listener();
    var_2 = getaiarray("allies");

    foreach(var_4 in var_2) {
    var_4 thread aud_handle_allies_remote_sniper(level.aud_traverse_ally_locs);
    }
  }

  wait 1.7;
  level.aud_sniper_background playLoopSound("enhq_sniper_zoom_background_lp");

  if(var_0 == "enhq_stadium_open") {
    level.player waittill("sniper_done");
    level.aud_stadium_crumble1 unlink();
    level.aud_stadium_crumble2 unlink();
    level.aud_stadium_crumble1 moveto((613, -5735, -212), 0.05);
    level.aud_stadium_crumble2 moveto((1288, -5762, -165), 0.05);
  }
}

aud_start_sniper_finale() {
  level.player setclienttriggeraudiozone("enhq_chopper", 0);
  level.aud_zoom_in_sound scalevolume(0);
  level.aud_zoom_out_sound scalevolume(0);
  level.aud_zoom_in_sound playLoopSound("enhq_sniper_zoom_in_lp");
  level.aud_zoom_out_sound playLoopSound("enhq_sniper_zoom_out_lp");
  level.player playSound("enhq_sniper_start");
  thread aud_sniper_fire();
}

aud_sniper_fire() {
  level.player endon("sniper_done");

  for(;;) {
    level.player waittill("weapon_fired");
    level.player playSound("enhq_sniper_shot");
    level.player thread maps\_utility::play_sound_on_entity("enhq_sniper_shot_tail");
  }
}

aud_focus_zoom() {
  level.aud_zoom_in_sound scalepitch(1);
  level.aud_zoom_in_sound scalevolume(1, 0.1);
}

aud_end_sniper() {
  level.player notify("sniper_done");
  level.aud_sniper_background stoploopsound();
  level.aud_zoom_in_sound stoploopsound();
  level.aud_zoom_out_sound stoploopsound();
  level.player playSound("enhq_sniper_end");
  level.player clearclienttriggeraudiozone(0.5);
}

aud_sniper_start_zoom(var_0) {
  if(!level.aud_zoom_on) {
    var_1 = var_0 > 0;

    if(var_1) {
      level.aud_zoom_in_sound scalepitch(1);
      level.aud_zoom_in_sound scalevolume(1, 0.1);
    } else
      level.aud_zoom_out_sound scalevolume(1, 0.1);

    level.aud_zoom_on = 1;
  }
}

aud_sniper_stop_zoom() {
  if(level.aud_zoom_on) {
    level.aud_zoom_in_sound scalepitch(0.5, 0.15);
    level.aud_zoom_in_sound scalevolume(0, 0.15);
    level.aud_zoom_out_sound scalevolume(0, 0.15);
    level.aud_zoom_on = 0;
  }
}

aud_intro_keegan_tinkering() {
  var_0 = spawn("script_origin", (4631, 6842, -184));
  var_0 playSound("enhq_intro_keegan_tinkering");
  common_scripts\utility::flag_wait("picked_up_mk32");
  var_0 stopsounds();
  wait 1;
  var_0 delete();
}

aud_pickup_mk32() {}

aud_convoy_start(var_0) {
  var_0 vehicle_turnengineoff();
  wait 2;
  level.aud_intro_convoy_counter++;

  if(level.aud_intro_convoy_counter == 0) {
    wait 0.3;
    var_0 playSound("enhq_convoy_intro_half_1");
  } else if(level.aud_intro_convoy_counter == 1) {
    wait 2.05;
    var_0 playSound("enhq_convoy_intro_half_2");
  } else if(level.aud_intro_convoy_counter == 2) {
    wait 3.9;
    var_0 playSound("enhq_convoy_intro_jeep_2");
  } else if(level.aud_intro_convoy_counter == 3)
    var_0 playSound("enhq_convoy_intro_jeep_1");
  else if(level.aud_intro_convoy_counter == 4 || level.aud_intro_convoy_counter == 5) {
    if(var_0.vehicletype == "iveco_lynx") {
      wait 2.45;
      var_0 playSound("enhq_convoy_intro_jeep_3");
    } else {
      wait 2.45;
      var_0 playSound("enhq_convoy_intro_half_3");
    }
  } else if(level.aud_intro_convoy_counter == 6 || level.aud_intro_convoy_counter == 7) {
    if(var_0.vehicletype == "iveco_lynx") {
      var_0 playSound("enhq_convoy_intro_jeep_1");
    }
    else {
      wait 0.6;
      var_0 playSound("enhq_convoy_intro_half_4");
    }
  } else if(level.aud_intro_convoy_counter == 8 || level.aud_intro_convoy_counter == 9) {
    if(var_0.target == "pf251_auto120") {
      var_0 playSound("enhq_convoy_intro_jeep_1");
    }
    else {
      wait 4;
      var_0 playSound("enhq_convoy_intro_jeep_2");
    }
  } else if(level.aud_intro_convoy_counter == 10 || level.aud_intro_convoy_counter == 11) {
    if(var_0.vehicletype == "iveco_lynx") {
      wait 2;
      var_0 playSound("enhq_convoy_intro_jeep_3");
    } else {
      wait 0.3;
      var_0 playSound("enhq_convoy_intro_half_1");
    }
  } else if(level.aud_intro_convoy_counter == 12 || level.aud_intro_convoy_counter == 13) {
    if(var_0.vehicletype == "iveco_lynx") {
      var_0 playSound("enhq_convoy_intro_jeep_4");
    }
    else {
      wait 2.05;
      var_0 playSound("enhq_convoy_intro_half_2");
    }
  } else if(level.aud_intro_convoy_counter == 14 || level.aud_intro_convoy_counter == 15) {
    if(var_0.unique_id == "ai41") {
      var_0 playSound("enhq_convoy_intro_jeep_1");
    }
    else {
      wait 2.45;
      var_0 playSound("enhq_convoy_intro_jeep_3");
    }
  } else if(level.aud_intro_convoy_counter == 16)
    var_0 playSound("enhq_convoy_intro_jeep_4");
}

aud_convoy_done() {
  thread aud_car_creak();
  thread aud_random_rumbles_intro();
  thread common_scripts\utility::play_sound_in_space("enhq_airplanes_intro_lfe_1", level.player.origin);
  maps\_utility::delaythread(0.05, common_scripts\utility::play_sound_in_space, "enhq_airplanes_intro_shake", level.player.origin);
  maps\_utility::delaythread(2.85, common_scripts\utility::play_sound_in_space, "enhq_airplanes_intro_shake_debris", (4667, 6910, -163));
  maps\_utility::delaythread(2.85, common_scripts\utility::play_sound_in_space, "enhq_airplanes_intro_shake_debris", (4346, 7281, -163));
  maps\_utility::delaythread(2.85, common_scripts\utility::play_sound_in_space, "enhq_airplanes_intro_shake_debris", (3162, 7012, -420));
  maps\_utility::delaythread(1.9, common_scripts\utility::play_sound_in_space, "enhq_airplanes_intro_lfe_2", level.player.origin);
  wait 0.1;
  thread aud_play_and_move_sound("enhq_airplanes_intro_plane_1", (5092, 7686, 1769), (1776, 7639, 1769), 9);
  wait 0.2;
  thread aud_play_and_move_sound("enhq_airplanes_intro_plane_2", (5093, 6838, 1769), (1814, 6684, 1769), 9);
  wait 1.5;
  thread aud_play_and_move_sound("enhq_airplanes_intro_jet_1", (5092, 7686, 1769), (1776, 7639, 1769), 9);
  wait 1.7;
  thread aud_play_and_move_sound("enhq_airplanes_intro_jet_2", (5093, 6838, 1769), (1814, 6684, 1769), 9);
}

aud_play_and_move_sound(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", var_1);
  var_4 playSound(var_0, "sounddone");
  var_4 moveto(var_2, var_3);
  var_4 waittill("sounddone");
  var_4 delete();
}

aud_mk32_dud_beep_atrium(var_0) {
  var_0 playLoopSound("enhq_mk203_beep_lp");
  var_0 thread aud_doppler_grenade();
  wait 1;
  var_0 stoploopsound();
}

aud_listen_mk32_reload() {
  level endon("watching_player_mk32");
  level endon("death");
  thread aud_listen_sprint_or_switch();

  for(;;) {
    if(level.player isreloading()) {
      level.aud_player_reloading = 1;
    }
    else {
      wait 0.1;
      level.aud_player_reloading = 0;
    }

    common_scripts\utility::waitframe();
  }
}

aud_listen_sprint_or_switch() {
  level endon("watching_player_mk32");
  level endon("death");
  wait 0.1;

  for(;;) {
    if(level.aud_player_reloading) {
      if(level.player issprinting() || level.player isswitchingweapon()) {
        level.player stopsoundchannel("effects2d2");
      }
    }

    common_scripts\utility::waitframe();
  }
}

aud_mk32_dud_beep(var_0) {
  var_0 playLoopSound("enhq_mk203_beep_lp");
  var_0 thread aud_doppler_grenade();
}

aud_mk32_dud_beep_hit(var_0, var_1, var_2) {
  var_0 stoploopsound();

  if(var_1) {
    var_0 thread maps\_utility::play_sound_on_entity("enhq_mk203_impact");
  }
  else {
    var_0 thread maps\_utility::play_sound_on_entity("enhq_mk203_impact_stone");
  }
}

aud_doppler_grenade() {
  wait 0.25;
  self scalepitch(0.75, 5.5);
}

aud_car_creak() {
  var_0 = spawn("script_origin", (3480, 6927, -239));
  wait 4;

  while(!common_scripts\utility::flag("FLAG_player_enter_truck")) {
    var_0 playSound("enhq_car_creak");
    wait(randomintrange(5, 10));
  }

  wait 4;
  var_0 delete();
}

aud_random_rumbles_intro() {
  level.player endon("entered_truck");
  var_0 = spawn("trigger_radius", (3867, 6920, -162), 1, 200, 200);
  var_0 waittill("trigger");
  thread common_scripts\utility::play_sound_in_space("enhq_stadium_crumbles_intro", (3693, 7070, -140));
  var_0 delete();
}

aud_truck_start() {
  level.player_truck vehicle_turnengineoff();
  thread common_scripts\utility::play_sound_in_space("enhq_truck_start", (2918, 7212, -420));
  wait 0.4;
  thread aud_truck_ext_idle_loop();
}

aud_truck_ext_idle_loop() {
  var_0 = spawn("script_origin", (2918, 7212, -420));
  var_1 = spawn("script_origin", (2634, 7217, -454));
  var_0 maps\_utility::sound_fade_in("enhq_truck_ride_ext_idle_loop", 1, 1, 1);
  var_1 maps\_utility::sound_fade_in("enhq_truck_ride_ext_idle_tail_loop", 1, 1, 1);
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  wait 4.3;
  var_0 maps\_utility::sound_fade_and_delete(1.5);
  var_1 maps\_utility::sound_fade_and_delete(1.5);
}

aud_truck_enter() {
  level.player notify("entered_truck");
  level.player common_scripts\utility::delaycall(1.1, ::playsound, "enhq_truck_ride_open");
  level.player stopsoundchannel("effects2d2");
  thread aud_music("drivein");
  thread aud_truck_ride_idle();
  thread aud_dog_thread();
  wait 2.4;
  level.player setclienttriggeraudiozone("enhq_truck", 1);
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_interior");
  wait 1.05;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 thread maps\_utility::sound_fade_in("enhq_truck_interior_loop", 1, 0.6, 1);
  level.allies[1] common_scripts\utility::delaycall(3.75, ::playsound, "enhq_ally_ghost_mask");
  maps\enemyhq_intro::ehq_intro_flag_wait_all("ally1_enter_veh", "ally2_enter_veh", "ally3_enter_veh", "ally5_enter_veh", "FLAG_player_enter_truck");
  wait 0.25;
  var_0 maps\_utility::sound_fade_and_delete(1);
}

aud_truck_drive() {
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride");
  level.allies[1] playSound("enhq_truck_ride_gear");
  level.player playrumbleonentity("light_3s");
  wait 8.4;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_suspension_potholes_1");
  level.player playrumbleonentity("light_1s");
  wait 1.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_suspension_potholes_2");
  level.player playrumbleonentity("light_1s");
  wait 2;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_suspension_potholes_3");
  level.player playrumbleonentity("light_1s");
}

aud_truck_ride_idle() {
  wait 3;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkto(level.player);
  var_0 thread maps\_utility::sound_fade_in("enhq_truck_ride_idle_loop", 1, 2, 1);
  wait 2;
  var_0 thread maps\_utility::sound_fade_and_delete(4);
}

aud_dog_thread() {
  wait 2;
  thread common_scripts\utility::play_sound_in_space("enhq_dog_bark", (2889, 7105, -398));
  wait 0.25;
  level.dog thread maps\_utility::play_sound_on_entity("enhq_dog_enter_truck");
  wait 3.05;
  level.player playSound("enhq_dog_pet_2");
  wait 0.45;
  level.dog playSound("enhq_dog_pet_1");
  wait 1.3;
  level.dog playSound("enhq_dog_pant");
  common_scripts\utility::flag_wait("FLAG_dog_bark_truck");
  wait 1;
  thread maps\enemyhq_intro::dog_bark_anims();
  wait 0.23;
  level.dog thread maps\_utility::play_sound_on_entity("enhq_dog_bark_2");
}

aud_blow_vehicle(var_0) {
  var_0 playSound("car_explode");
}

aud_blow_vehicle_low(var_0) {
  var_0 playSound("car_explode_2");
}

aud_vehicle_jolt() {
  if(level.aud_vehicle_jolt_count == 0) {
    level.player thread maps\_utility::play_sound_on_entity("enhq_enemy_car_bash_01");
    thread aud_aux_explosions();
    thread aud_alarm();
    wait 1;
  } else if(level.aud_vehicle_jolt_count == 2)
    level.player thread maps\_utility::play_sound_on_entity("enhq_enemy_car_bash_02");
  else if(level.aud_vehicle_jolt_count == 3) {
    level.player thread maps\_utility::play_sound_on_entity("enhq_enemy_car_bash_04");
  }

  level.aud_vehicle_jolt_count++;
}

aud_alarm() {
  var_0 = spawn("script_origin", (2985, -86, -619));
  var_0 playLoopSound("enhq_military_base_alarm");
  common_scripts\utility::flag_wait("FLAG_bust_thru_prep");
  wait 4;
  thread aud_distant_alarm();
  var_0 stoploopsound();
  common_scripts\utility::waitframe();
  var_0 delete();
}

aud_distant_alarm() {
  var_0 = spawn("script_origin", (1873, 2280, 620));
  var_0 playLoopSound("enhq_military_base_alarm_distant");
  common_scripts\utility::flag_wait("start_gas_scene");
  var_0 maps\_utility::sound_fade_and_delete(6);
}

aud_mute_field_guys() {
  var_0 = maps\_utility::get_ai_group_ai("field_chaos_guys");

  foreach(var_2 in var_0) {
  var_2 thread aud_limit_weaps();
  }
}

aud_limit_weaps() {
  self endon("death");

  if(isalive(self)) {
    self waittill("shooting");
    level.aud_bullet_count = level.aud_bullet_count + 1;

    if(level.aud_bullet_count > level.aud_max_bullets) {
      self stopsounds();
    }
    else {
      wait 1.5;
    }

    level.aud_bullet_count = level.aud_bullet_count - 1;
  }
}

aud_aux_explosions() {
  wait 4.5;
  thread common_scripts\utility::play_sound_in_space("car_explode", (3316, 899, -747));
  wait 4.05;
  thread common_scripts\utility::play_sound_in_space("car_explode", (2886, -1020, -747));
  wait 2;
  thread common_scripts\utility::play_sound_in_space("enhq_metal_structure_fall", (2792, -1694, -747));
  wait 3;
  thread common_scripts\utility::play_sound_in_space("car_explode", (3705, -2146, -747));
  wait 1;
  thread common_scripts\utility::play_sound_in_space("car_explode", (3356, -2380, -807));
  wait 1.8;
  thread common_scripts\utility::play_sound_in_space("car_explode", (5147, -1465, -780));
}

aud_screen_shake_jumps() {
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_shake_suspension");
}

aud_bust_windshield() {
  wait 1;
  level.player playSound("enhq_truck_glass_smash");
  wait 0.5;
  level.player setclienttriggeraudiozone("enhq_broken_window", 0.5);
}

aud_jeep_flip(var_0) {
  var_1 = spawn("script_origin", (2262, -1494, -797));
  var_1 playSound("enhq_npc_vehicle_twist");
  var_1 moveto((2572, -1558, -797), 2);
  wait 1.05;
  var_1 playSound("enhq_npc_vehicle_fall_crash", "sounddone");
  var_1 waittill("sounddone");
  wait 0.5;
  var_1 delete();
}

aud_bumpy_ride() {
  wait 2.5;
  thread common_scripts\utility::play_sound_in_space("enhq_npc_vehicle_approach", (4887, -2698, -803));
  wait 2.5;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_shake_suspension");
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_enter_bleachers");
  wait 0.25;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy");
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy2");
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy3");
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bumpy_lfe");
}

aud_bust_thru() {
  thread aud_end_truck();
  wait 2.75;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bust_thru_lfe");
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bust_thru");
  wait 2.5;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_ride_bust_thru_2");
}

aud_end_truck() {
  wait 3;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkto(level.player);
  var_0 thread maps\_utility::sound_fade_in("enhq_truck_ride_idle_loop", 1, 4, 1);
  wait 2;
  level.dog maps\_utility::play_sound_on_entity("enhq_dog_bark");
  level.dog maps\_utility::play_sound_on_entity("enhq_dog_enter_truck");
  common_scripts\utility::flag_wait("FLAG_player_exit_truck");
  thread aud_music("atriumcombat");
  wait 1;
  var_0 thread maps\_utility::sound_fade_and_delete(1);
  level.player clearclienttriggeraudiozone();
  thread common_scripts\utility::play_loopsound_in_space("enhq_truck_ride_ext_idle_loop", (7780, -4550, -565));
  thread common_scripts\utility::play_loopsound_in_space("enhq_truck_ride_ext_idle_tail_loop", (7826, -4325, -578));
  thread aud_salsa_music();
}

aud_exit_truck() {
  wait 3.8;
  level.player thread maps\_utility::play_sound_on_entity("enhq_truck_exit");
}

aud_salsa_music() {
  var_0 = spawn("script_origin", (3879, -6719, -570));
  var_0 playLoopSound("enhq_radio_salsa");
  common_scripts\utility::flag_wait("vip_done");
  var_0 stoploopsound();
  wait 1;
  var_0 delete();
}

aud_vip_breach() {
  wait 0.6;
  level.player thread maps\_utility::play_sound_on_entity("enhq_ally_breach");
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_dog_bark_2");
}

aud_enemy_muffled_vo(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = "enemyhq_saf1_doyouhearthe";
  var_3[1] = "enemyhq_saf2_weneedtocall";
  var_3[2] = "enemyhq_saf1_ialreadydidthat";
  var_3[3] = "enemyhq_saf2_thenweshouldrun";
  var_3[4] = "enemyhq_saf1_wecantdothat";
  var_3[5] = "enemyhq_saf2_wellwecantjust";
  var_4 = 0;
  common_scripts\utility::flag_wait(var_2);
  level.aud_convo = getent(var_1, "targetname");

  while(!common_scripts\utility::flag(var_0)) {
    level.aud_convo playSound(var_3[var_4], "done", 1);
    level.aud_convo waittill("done");
    var_4++;

    if(var_4 >= var_3.size) {
      var_4 = 0;
    }
  }

  wait 2;
  level.aud_convo delete();
}

aud_interrogation() {
  level endon("start_pre_rpg_ambush");
  thread aud_random_enemy_chatter();
  thread aud_random_enemy_pa(level.aud_random_enemy_chatter);
  wait 8.2;
  level.allies[1] playSound("enhq_interrogation_kill_1");
  wait 9.6;
  level.allies[1] playSound("enhq_interrogation_kill_2", "sounddone");
  level.allies[1] waittill("sounddone");
  wait 0.05;
  thread common_scripts\utility::play_sound_in_space("enhq_interrogation_kill_3", (2038, -6353, -129));
  thread aud_random_rumbles();
}

aud_random_rumbles() {
  while(!common_scripts\utility::flag("start_gas_scene")) {
    wait(randomintrange(4, 8));
    level.aud_stadium_crumble1 playSound("enhq_stadium_crumbles");
    wait(randomintrange(4, 8));
    level.aud_stadium_crumble2 playSound("enhq_stadium_crumbles");
  }
}

aud_random_enemy_chatter() {
  level.aud_random_enemy_chatter endon("chatter_done");
  thread aud_end_random_chatter_and_pa();
  var_0 = ["enemyhq_saf1_helpmeputthis", "enemyhq_saf1_callbackthefleet", "enemyhq_saf1_findthemgogo", "enemyhq_saf2_needamedicover", "enemyhq_saf2_blockthefrontgate", "enemyhq_saf2_howlargeisthe", "enemyhq_pmc3_sendreinforcementstothe", "enemyhq_pmc3_medicmedic", "enemyhq_pmc3_alertcommandweneed"];

  for(;;) {
    var_1 = "";

    foreach(var_3 in var_0) {
      if(var_3 != var_1) {
        thread common_scripts\utility::play_sound_in_space(var_3, level.aud_random_enemy_chatter.origin);
        var_1 = var_3;
        wait(randomfloatrange(2.0, 6.0));
      }
    }

    var_0 = common_scripts\utility::array_randomize(var_0);
  }
}

aud_random_enemy_pa(var_0) {
  var_0 endon("chatter_done");
  var_1 = ["enemyhq_saf1_squad4reportto", "enemyhq_saf1_lieutenantmoralesyoure", "enemyhq_saf1_perimeteroutpostswill", "enemyhq_saf1_ascoutteamis", "enemyhq_saf1_allinteriorpatrolsreport", "enemyhq_saf1_asquadisneeded"];

  for(;;) {
    var_2 = "";

    foreach(var_4 in var_1) {
      if(var_4 != var_2) {
        thread common_scripts\utility::play_sound_in_space(var_4, var_0.origin);
        var_2 = var_4;
        wait(randomfloatrange(4.0, 10.0));
      }
    }

    var_1 = common_scripts\utility::array_randomize(var_1);
  }
}

aud_end_random_chatter_and_pa() {
  common_scripts\utility::flag_wait("start_gas_scene");
  level.aud_random_enemy_chatter notify("chatter_done");
  wait 20;
  level.aud_random_enemy_chatter delete();
}

aud_player_slide() {
  level.player thread maps\_utility::play_sound_on_entity("enhq_player_slide");
}

aud_pre_sniper_rpg_listener() {
  foreach(var_1 in level.rpg_ambush_guys) {
  var_1 thread aud_pre_sniper_rpg_gunner_listener();
  }
}

aud_pre_sniper_rpg_gunner_listener() {
  self endon("death");
  level.player endon("sniper_started");

  for(;;) {
    self waittill("missile_fire", var_0);
    self stopsounds();
    var_0 scalevolume(0);
    thread aud_pre_sniper_rpg_explode(var_0);
  }
}

aud_pre_sniper_rpg_explode(var_0) {
  var_0 endon("death");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playLoopSound("weap_rpg_loop");
  var_0 thread aud_pre_sniper_rpg_death_listener(var_1);
  level.player waittill("sniper_started");

  if(isDefined(var_1)) {
    var_1 unlink();
    var_1 linkto(level.player);
  }
}

aud_pre_sniper_rpg_death_listener(var_0) {
  self waittill("death");
  var_0 stoploopsound();

  if(isDefined(self)) {
    self playSound("rocket_explode_concrete", "sounddone");
    self waittill("sounddone");
  }

  wait 1;
  var_0 delete();
}

aud_rpg_listener() {
  var_0 = level.player.origin;
  wait 1;
  var_1 = getaiarray("axis");
  var_2 = [(4420, 2983, 138), (3671, 2848, 138), (3123, 1711, 138), (3798, 1238, 138)];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3] thread aud_rpg_gunner_listener(var_2[var_3]);
  }
}

aud_rpg_gunner_listener(var_0) {
  self endon("death");

  for(;;) {
    self waittill("missile_fire", var_1);
    self stopsounds();
    thread common_scripts\utility::play_sound_in_space("weap_rpg_fire_npc", (2316, 294, 136));
    thread aud_rpg_explode(var_1, var_0);
  }
}

aud_rpg_explode(var_0, var_1) {
  var_0 stopsounds();
  var_2 = spawn("script_origin", (2316, 294, 136));
  var_2 playLoopSound("weap_rpg_loop");
  var_2 moveto(var_1, 1.5);
  wait 1.5;
  var_2 stoploopsound();
  var_3 = spawn("script_origin", var_1);
  var_3 playSound("rocket_explode_concrete", "sounddone");
  var_3 waittill("sounddone");
  var_3 delete();
  var_2 delete();
}

aud_gas_mask_on() {
  wait 0.3;
  level.player playSound("enhq_gas_mask");
  wait 2.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_breathing_gasmask");
  common_scripts\utility::flag_wait("gassed_out");
  wait 3.1;
  thread common_scripts\utility::play_sound_in_space("enhq_door_bust_open", (438, -5252, -897));
  common_scripts\utility::flag_wait("enter_cage_vo");
  wait 1.4;
  thread common_scripts\utility::play_sound_in_space("enhq_garage_door_open", (340, -5127, -858));
}

aud_dog_scratch() {
  wait 0.2;
  level.dog maps\_utility::play_sound_on_entity("enhq_dog_scratch");
}

aud_flare_grab() {
  var_0 = spawn("script_origin", (4077, -5685, -955));
  var_0 playLoopSound("enhq_flare_lp");
  level.allies[1] waittill("start_flare");
  wait 0.85;
  level.allies[1] thread maps\_utility::play_sound_on_entity("enhq_flare_pickup");
  var_0 moveto((4084, -5664, -915), 1);
  wait 1;
  var_0 linkto(level.allies[1]);
  thread aud_random_metal_crumbles();
  level.allies[1] waittill("steath_kill_done");
  wait 9.9;
  level.allies[1] thread maps\_utility::play_sound_on_entity("enhq_flare_drop_foley");
  wait 0.7;
  var_0 unlink();
  var_0 moveto((4813, -5840, -953), 0.25);
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("enhq_flare_drop", (4813, -5840, -953));
}

aud_random_metal_crumbles() {
  var_0 = spawn("script_origin", (4076, -5852, -847));
  var_1 = spawn("script_origin", (4287, -5928, -848));
  var_2 = var_0;

  while(!common_scripts\utility::flag("basement_combat_done")) {
    if(var_2 == var_0) {
      var_2 playSound("enhq_stadium_crumbles_metal_1");
      var_2 = var_1;
    } else {
      var_2 playSound("enhq_stadium_crumbles_metal_2");
      var_2 = var_0;
    }

    wait(randomintrange(8, 14));
  }

  wait 3;
  var_0 delete();
  var_1 delete();
}

aud_flare_kill() {
  wait 1;
  level.allies[1] thread maps\_utility::play_sound_on_entity("enhq_flare_kill");
}

aud_breach() {
  thread aud_coughing();
  var_0 = spawn("script_origin", level.player.origin);
  var_1 = spawn("script_origin", level.player.origin);
  level.player playSound("enhq_gun_putaway");
  wait 0.7;
  level.player playSound("enhq_door_breach_1");
  wait 2.7;
  thread common_scripts\utility::play_sound_in_space("enhq_breach_grenade", (4474, -5432, -952));
  wait 1.6;
  level.allies[1] thread maps\_utility::play_sound_on_entity("enhq_breach_akimbo_guns");
  wait 1.1;
  wait 2.05;
  var_0 playSound("enhq_door_breach_2");
  var_1 playSound("enhq_door_breach_lfe");
  wait 0.8;
  level.player setclienttriggeraudiozone("enhq_clubhouse_breach", 0.25);
  thread aud_player_gunfire();
  level common_scripts\utility::waittill_any("finished_slowmo", "abort_slowmo");
  var_0 maps\_utility::sound_fade_and_delete(1);
  var_1 maps\_utility::sound_fade_and_delete(1);
  level.player clearclienttriggeraudiozone(1.5);
}

aud_coughing() {
  wait 6.75;
  thread common_scripts\utility::play_sound_in_space("enhq_cough_1", (4442, -5605, -905));
  wait 0.7;
  thread common_scripts\utility::play_sound_in_space("enhq_cough_2", (4803, -5294, -905));
  wait 1.2;
  thread common_scripts\utility::play_sound_in_space("enhq_cough_3", (4488, -5326, -905));
}

aud_player_gunfire() {
  level endon("finished_slowmo");

  for(;;) {
    level.player waittill("weapon_fired");
    level.player playSound("enhq_slowmo_gunshot");
  }
}

aud_keegan_gunfire() {
  self stopsounds();
  self playSound("enhq_slowmo_gunshot_allies");
}

aud_hvt_rescue_thread() {
  thread aud_ajax_flare();
  thread aud_radio_chatter();
  thread aud_ajax_chair();
  thread aud_ajax_coughing();
  wait 0.45;
  level.allies[2] playSound("enhq_hvt_hesh");
  wait 0.2;
  level.allies[1] playSound("enhq_hvt_keegan");
  wait 0.15;
  level.allies[0] playSound("enhq_hvt_merrick");
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_gas_mask_off");
  wait 0.9;
  level.dog thread maps\_utility::play_sound_on_entity("enhq_hvt_dog");
  wait 0.1;
  level.player thread maps\_utility::play_sound_on_entity("enhq_ally_ghost_mask");
  wait 23.95;
  var_0 = spawn("script_origin", (4925, -4573, -934));
  var_0 playSound("enhq_chair_roll");
  var_0 moveto((4867, -4627, -934), 2);
  wait 2;
  var_0 delete();
  wait 21;
  thread aud_music("combatprep");
}

aud_ajax_coughing() {
  wait 2.75;
  var_0 = spawn("script_origin", (5192, -4678, -952));
  var_0 playSound("enemyhq_ajx_wounded", "sounddone");
  wait 3.75;
  var_0 moveto((5205, -4711, -931), 3);
  var_0 waittill("sounddone");
  var_0 delete();
}

aud_ajax_chair() {
  wait 4.25;
  level.allies[1] thread maps\_utility::play_sound_on_entity("enhq_hvt_chair_kick");
  wait 0.7;
  thread common_scripts\utility::play_sound_in_space("enhq_hvt_chair_impact", (5255, -4646, -957));
}

aud_ajax_flare() {
  wait 25;
  var_0 = spawn("script_origin", (4988, -4564, -908));
  var_0 playSound("enhq_flare_start");
  var_0 moveto((4925, -4549, -906), 1);
  var_1 = spawn("script_origin", (4988, -4564, -908));
  var_1 moveto((4925, -4549, -906), 1);
  wait 0.5;
  var_1 playLoopSound("enhq_flare_lp");
  wait 21;
  var_1 moveto((4973, -4539, -958), 0.25);
  wait 0.25;
  thread common_scripts\utility::play_sound_in_space("enhq_flare_drop", (4973, -4539, -958));
  var_0 delete();
}

aud_radio_chatter() {
  var_0 = 0;

  for(;;) {
    if(var_0) {
      thread common_scripts\utility::play_sound_in_space("enhq_radio_static_1", (4935, -4502, -921));
    }
    else {
      thread common_scripts\utility::play_sound_in_space("enhq_radio_static_2", (4935, -4502, -921));
    }

    var_0 = !var_0;
    wait(randomintrange(8, 14));
  }
}

aud_door_bust_open() {
  thread aud_music("finalbattle");
  common_scripts\utility::play_sound_in_space("enhq_door_bust_open", (3766, -4342, -868));
}

aud_handle_allies_remote_sniper(var_0) {
  level.player endon("sniper_done");

  for(;;) {
    self waittill("shooting");
    self stopsounds();
    thread common_scripts\utility::play_sound_in_space("enhq_ally_fire", common_scripts\utility::random(var_0));
  }
}

aud_handle_remote_sniper_ai(var_0) {
  self endon("death");
  level.player endon("sniper_done");

  for(;;) {
    self waittill("shooting");
    self stopsounds();

    if(var_0 == level.aud_vip_combat) {
      level.aud_vip_combat playSound("weap_sc2010_fire_npc");
      thread aud_play_whizby();
      continue;
    }

    if(var_0 == level.aud_finale_chopper1) {
      if(randomint(10) < 8) {
        var_1 = randomint(4);

        if(var_1 == 0) {
          level.aud_finale_chopper1 playSound("weap_sc2010_fire_npc");
        }
        else if(var_1 == 1) {
          level.aud_finale_chopper2 playSound("weap_m27_fire_npc");
        }
        else if(var_1 == 2) {
          level.aud_finale_chopper3 playSound("weap_m27_fire_npc");
        }
        else if(var_1 == 3) {
          level.aud_finale_chopper4 playSound("weap_m27_fire_npc");
        }

        thread aud_play_whizby();
      }

      continue;
    }

    if(randomint(10) < 9) {
      if(randomint(2) == 0) {
        level.aud_finale_sniper playSound("weap_sc2010_fire_npc");
      }
      else {
        level.aud_finale_sniper2 playSound("weap_m27_fire_npc");
      }

      thread aud_play_whizby();
    }
  }
}

aud_play_whizby() {
  wait(randomfloatrange(0.25, 0.5));
  var_0 = "L";

  if(randomint(2) == 0) {
    var_0 = "R";
  }

  var_1 = "whizby_near_0" + randomint(8) + "_" + var_0;
  level.player playSound(var_1);
}

aud_pa_guys() {
  level.aud_finale_pa_guys linkto(level.player);
  thread aud_random_enemy_pa(level.aud_finale_pa_guys);
  common_scripts\utility::flag_wait("end_of_sniping");
  level.aud_finale_pa_guys moveto((2270, -875, -591), 0.05);
  common_scripts\utility::flag_wait("get_in_choppa");
  level.aud_finale_pa_guys notify("chatter_done");
}

aud_chopper_second(var_0) {
  var_0 vehicle_turnengineoff();
  var_1 = spawn("script_origin", (3573, 2109, 137));
  var_2 = spawn("script_origin", (3573, 2109, 137));
  var_3 = spawn("script_origin", level.player.origin);
  level.aud_finale_sniper waittill("start_sniping");
  common_scripts\utility::flag_wait("end_of_sniping");
  wait 1.3;
  var_0 playLoopSound("enhq_heli_finale_lp");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("enhq_heli_finale_near_lp");
  wait 0.2;
  var_0 thread maps\_utility::play_sound_on_entity("enhq_heli_takedown");
  wait 1;
  level.dog maps\_utility::play_sound_on_entity("enhq_dog_bark");
  common_scripts\utility::flag_wait("get_in_choppa");
  wait 0.2;
  var_3 thread maps\_utility::sound_fade_in("enhq_heli_finale_engine_lp", 1, 2, 1);
  thread aud_music("exfil");
  wait 0.9;
  level.player thread maps\_utility::play_sound_on_entity("enhq_heli_finale_enter");
  wait 2.7;
  level.player thread maps\_utility::play_sound_on_entity("enhq_gun_raise");
  wait 2;
  thread aud_start_sniper_finale();
  var_1 playLoopSound("enhq_heli_finale_lp");
  var_2 playLoopSound("enhq_heli_finale_near_lp");
  wait 1.8;
  var_1 linkto(level.player);
  var_2 linkto(level.player);
  var_4 = getaiarray("axis");
  level.aud_finale_chopper1 linkto(level.player);
  level.aud_finale_chopper2 linkto(level.player);
  level.aud_finale_chopper3 linkto(level.player);
  level.aud_finale_chopper4 linkto(level.player);

  foreach(var_6 in var_4) {
  var_6 thread aud_handle_remote_sniper_ai(level.aud_finale_chopper1);
  }

  thread aud_chopper_down(var_0, var_1, var_2, var_3);
  thread aud_pings();
  wait 20;
  level.player setclienttriggeraudiozone("enhq_end_fade", 10);
  level.player maps\_utility::play_sound_on_entity("enhq_remote_static");
}

aud_lynx_turrets(var_0) {
  var_1 = spawn("script_origin", (3665, 1759, 242));
  var_2 = spawn("script_origin", (3557, 1773, 242));
  var_3 = spawn("script_origin", (3438, 1761, 242));
  var_4 = [var_1, var_2, var_3];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_0[var_5] thread aud_lynx_death_listener();
    var_0[var_5] thread aud_lynx_rider_death_listener();
  }

  thread aud_move_turret_ents(var_4);

  for(;;) {
    if(level.aud_lynx_guys > 0) {
      var_6 = var_4[randomintrange(0, level.aud_lynx_guys)];
      var_6 playSound("gaz_turret_temp_shoot");

      if(randomint(8) == 0) {
        wait 0.2;
      }

      wait 0.1;
      continue;
    }

    break;
  }
}

aud_move_turret_ents(var_0) {
  wait 7;
  common_scripts\utility::array_call(var_0, ::moveto, (3608, 6341, 1372), 20, 5);
}

aud_lynx_death_listener() {
  self waittill("death");

  if(self.riders.size == 2) {
    level.aud_lynx_guys--;
  }
}

aud_lynx_rider_death_listener() {
  self endon("death");

  for(;;) {
    if(self.riders.size == 1) {
      level.aud_lynx_guys--;
      return;
    }

    common_scripts\utility::waitframe();
  }
}

aud_pings() {
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 0.5;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_bursts");
  wait 4;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 0.6;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 7;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 4;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 0.6;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("enhq_bullet_pings");
}

aud_chopper_down(var_0, var_1, var_2, var_3) {
  level.finale_chopper waittill("going_down");
  var_1 thread maps\_utility::sound_fade_and_delete(4);
  var_1 scalepitch(0.5, 3);
  var_2 scalepitch(0.5, 3);
  var_3 thread maps\_utility::sound_fade_and_delete(4);
  var_3 scalepitch(0.5, 3);
  level.player playSound("enhq_heli_finale_fail");
}