/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_audio.gsc
*****************************************************/

main() {
  aud_init_globals();
  aud_ignore_timescale();
}

aud_init_globals() {
  level.aud_old_rotation = 0;
  level.aud_old_height = 0;
  level.aud_updating_movement = 0;
  level.aud_can_play_rope_creak = 1;
  level.aud_can_play_rappel_footsteps = 1;
  level.aud_can_play_bldg_shake = 1;
  level.aud_ext_bombs = 0;
  level.aud_can_play_outside_wind_gusts = 0;
  level.aud_outside_music = spawn("script_origin", (-22880, 658, 13956));
  level.aud_outside_crowd = spawn("script_origin", (-22880, 658, 13956));
  level.aud_outside_music_rear = spawn("script_origin", (-22880, 658, 13956));
  level.aud_outside_crowd_rear = spawn("script_origin", (-22880, 658, 13956));
  level.aud_turret_loop_on = 0;
  level.aud_weapon_strobe = spawn("script_origin", level.player.origin);
  level.aud_wind_state_last = "down";
  level.aud_wind_loop = spawn("script_origin", level.player.origin);
  level.aud_wind_loop linkto(level.player);
  level.aud_flap_loop = spawn("script_origin", level.player.origin);
  level.aud_flap_loop linkto(level.player);
  level.aud_slow_mo = spawn("script_origin", level.player.origin);
  level.aud_slow_mo linkto(level.player);
  level.last_audio_bink_percentage = 1.0;
  level.last_audio_bink_beep_array_num = 0;
  level.audio_bink_percentage_beep_array[0] = 0.122;
  level.audio_bink_percentage_beep_array[1] = 0.215;
  level.audio_bink_percentage_beep_array[2] = 0.306;
  level.audio_bink_percentage_beep_array[3] = 0.398;
  level.audio_bink_percentage_beep_array[4] = 0.489;
  level.audio_bink_percentage_beep_array[5] = 0.581;
  level.audio_bink_percentage_beep_array[6] = 0.674;
  level.audio_bink_percentage_beep_array[7] = 0.765;
  level.audio_bink_percentage_beep_array[8] = 0.857;
  level.audio_bink_percentage_beep_array[9] = 0.948;
}

aud_ignore_timescale() {
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("auto", 0);
  soundsettimescalefactor("voice", 0);
  soundsettimescalefactor("local3", 0);
}

aud_check(var_0) {
  if(var_0 == "intro") {
    level.player setclienttriggeraudiozone("intro");
    wait 1;
    thread intro_convoy();
    wait 5;
    wait 22.9;
    level.player setclienttriggeraudiozone("ext_roof");
  } else if(var_0 == "zipline") {
    level.player setclienttriggeraudiozone("ext_roof");
    thread aud_ally_gear_rustle();
    level.aud_ext_bombs = 1;
  } else if(var_0 == "rappel_stealth") {
    level.player setclienttriggeraudiozone("ext_stealth_rappel");
    thread aud_party("out_amb_lower");
  } else if(var_0 == "building_entry") {
    level.player setclienttriggeraudiozone("ext_rappel");
    level.aud_ext_bombs = 0;
  } else {
    if(var_0 == "shadow_kill") {
      return;
    }
    if(var_0 == "inverted") {
      aud_party("out_music");
      thread aud_play_loop_until_flag("outside_party_crowd_3d", (-23084, 1715, 25130), "player_has_exited_the_building");
      thread aud_play_loop_until_flag("outside_party_crowd_3d", (-22988, 1715, 25130), "player_has_exited_the_building");
      thread aud_play_loop_until_flag("amb_ext_wind_hum_window_lp", (-23084, 1715, 25130), "player_has_exited_the_building");
      thread aud_play_loop_until_flag("amb_ext_wind_hum_window_lp", (-22988, 1715, 25130), "player_has_exited_the_building");
    } else if(var_0 == "courtyard")
      aud_party("out_amb");
    else {
      if(var_0 == "rappel") {
        return;
      }
      if(var_0 == "bar") {
        return;
      }
      if(var_0 == "junction") {
        return;
      }
      if(var_0 == "garden") {
        level.player setclienttriggeraudiozone("ext_rappel");
        wait 0.5;
        aud_start_garden_events();
      } else if(var_0 == "stairwell")
        level.player setclienttriggeraudiozone("int_collapse");
      else if(var_0 == "atrium") {
        level.player setclienttriggeraudiozone("int_collapse");
        thread aud_collapse("rumble");
      } else if(var_0 == "horizontal") {
        level.player setclienttriggeraudiozone("int_horizontal");
        thread aud_collapse("window_check");
      } else if(var_0 == "ending")
        level.player setclienttriggeraudiozone("int_horizontal");
      else if(var_0 == "ending_ground")
        level.player setclienttriggeraudiozone("int_postgarden");
      else {
        return;
        return;
        return;
      }
    }
  }
}

aud_intro(var_0) {
  if(var_0 == "r_goggles") {
    wait 0.7;
    level.allies[level.const_rorke] playSound("rorke_intro_movement");
    wait 3;
    level.allies[level.const_rorke] playSound("rorke_intro_movement2");
  } else if(var_0 == "r_jump") {
    wait 10.5;
    level.allies[level.const_rorke] playSound("rorke_intro_jump");
    aud_ally_gear_rustle();
  } else if(var_0 == "rorke_movement")
    return;
}

aud_ally_gear_rustle() {
  foreach(var_1 in level.allies)
  var_1 thread aud_ally_gear_rustle_2();
}

aud_ally_gear_rustle_2() {
  common_scripts\utility::flag_wait("rorke_ready_to_setup_zipline");

  for(;;) {
    self waittill("single anim", var_0);

    if(var_0 == "equipment_rustle_quiet") {
      self playSound("mvmt_vestlight_npc_run");
      continue;
    }

    if(var_0 == "equipment_rustle_loud")
      self playSound("mvmt_vestheavy_npc_run");
  }
}

intro_convoy() {
  if(getDvar("intro_mask") == "0")
    wait 9;
  else
    wait 12;

  var_0 = spawn("script_origin", (-29840, -3886, 27535));
  var_1 = spawn("script_origin", (-28130, -4864, 27535));
  var_2 = spawn("script_origin", (-29113, -6568, 27535));
  var_3 = spawn("script_origin", (-30818, -5585, 27535));
  var_0 playSound("crnd_intro_convoy_1");
  var_1 playSound("crnd_intro_convoy_2");
  var_2 playSound("crnd_intro_convoy_3");
  var_3 playSound("crnd_intro_convoy_4");
  wait 22;
  var_0 scalevolume(0.0, 15.0);
  var_1 scalevolume(0.0, 15.0);
  var_2 scalevolume(0.0, 15.0);
  var_3 scalevolume(0.0, 15.0);
  wait 15.5;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

aud_binoculars(var_0) {
  if(var_0 == "on")
    self playSound("fly_binoc_vision_on");
  else if(var_0 == "off")
    self playSound("fly_binoc_vision_off");
  else if(var_0 == "bg_loop") {
    var_1 = spawn("script_origin", self.origin);
    var_1 playLoopSound("fly_binoc_bg_loop");
    self waittill("stop_binocular_bg_loop_sound");
    var_1 stoploopsound();
    var_1 delete();
  } else if(var_0 == "zoom_in")
    self playSound("fly_binoc_zoom_in");
  else if(var_0 == "zoom_out")
    self playSound("fly_binoc_zoom_out");
  else if(var_0 == "scan_loop") {
    self.scan_loop_sound = spawn("script_origin", self.origin);
    self.scan_loop_sound playLoopSound("fly_binoc_scan_loop");
    common_scripts\utility::waittill_any("stop_binocular_scan_loop_sound", "stop_binocular_bg_loop_sound");
    self.scan_loop_sound stoploopsound();
    self.scan_loop_sound delete();
    self.scan_loop_sound = undefined;
  } else if(var_0 == "scan_loop_red") {
    self.scan_loop_red_sound = spawn("script_origin", self.origin);
    self.scan_loop_red_sound playLoopSound("fly_binoc_scan_loop_red");
    common_scripts\utility::waittill_any("stop_binocular_scan_loop_red_sound", "stop_binocular_bg_loop_sound");
    self.scan_loop_red_sound stoploopsound();
    self.scan_loop_red_sound delete();
    self.scan_loop_red_sound = undefined;
  } else if(var_0 == "positive")
    self playSound("fly_binoc_scan_positive");
  else if(var_0 == "negative")
    self playSound("fly_binoc_scan_negative");
  else if(var_0 == "seeker_move")
    self playSound("fly_binoc_seeker_move");
  else if(var_0 == "seeker_on")
    self playSound("fly_binoc_seeker_on");
  else if(var_0 == "seeker_off")
    self playSound("fly_binoc_seeker_off");
}

aud_zipline(var_0, var_1) {
  if(var_0 == "unfold") {
    level.player thread maps\_utility::play_sound_on_entity("crnd_gun_putaway");
    wait 1.25;
    level.player playSound("zipline_launcher_unfold");
    level.aud_zipline_launcher_turn_cooldown = 0;
    level.aud_zipline_launcher_loop = spawn("script_origin", level.player.origin);
    wait 4.2;
    thread common_scripts\utility::play_sound_in_space("zipline_launcher_anchor");
    common_scripts\utility::flag_wait("player_fired_zipline");
    level.aud_zipline_launcher_loop scalevolume(0, 0.05);
    common_scripts\utility::waitframe();
    level.aud_zipline_launcher_loop stoploopsound();
    common_scripts\utility::waitframe();
    wait 2;
    level.aud_zipline_launcher_loop delete();
  } else if(var_0 == "unfold2") {
    wait 3.4;
    thread common_scripts\utility::play_sound_in_space("zipline_launcher_unfold_2", var_1);
  } else if(var_0 == "unfold3")
    thread common_scripts\utility::play_sound_in_space("zipline_launcher_unfold_3", var_1);
  else if(var_0 == "aim") {
    var_2 = 0.09;
    var_3 = 0.01;

    if(!level.aud_turret_loop_on) {
      level.aud_turret_loop_on = 1;
      level.aud_zipline_launcher_loop playLoopSound("zipline_fire_turn_horizontal");
    }

    var_4 = 0.3;

    if(var_1 < var_2)
      var_4 = var_4 * ((var_1 - var_3) / (var_2 - var_3));

    if(var_4 > 0.09)
      var_4 = 0.09;

    level.aud_zipline_launcher_loop scalevolume(var_4, 0.1);
    level.aud_zipline_launcher_loop scalepitch(1, 0.1);
  } else if(var_0 == "stop_loop") {
    level.aud_zipline_launcher_loop scalepitch(0.5, 0.25);
    level.aud_zipline_launcher_loop scalevolume(0, 0.25);
  } else if(var_0 == "rope_shot_ally") {
    thread common_scripts\utility::play_sound_in_space("zipline_fire", var_1);
    thread common_scripts\utility::play_sound_in_space("zipline_post_fire", var_1);
  } else if(var_0 == "rope_shot_verb") {
    thread common_scripts\utility::play_sound_in_space("zipline_fire_verb", var_1);
    thread common_scripts\utility::play_sound_in_space("zipline_post_fire", var_1);
  } else if(var_0 == "rope_shot") {
    thread common_scripts\utility::play_sound_in_space("zipline_fireb", var_1);
    thread common_scripts\utility::play_sound_in_space("zipline_post_fire", var_1);
  } else if(var_0 == "start") {
    thread common_scripts\utility::play_sound_in_space("rappel_clickin", level.player.origin);
    wait 2.57;
    thread aud_zipline("pre");
    level.player setclienttriggeraudiozone("ext_zipline");
    wait 0.9;
    wait 0.3;
    thread common_scripts\utility::play_sound_in_space("zipline_movement_plr", level.player.origin);
    wait 0.2;
    thread zipline_mvmt_npc();
    wait 2;
    level.player playSound("zipline_wind");
    thread aud_zipline("wind");
    level.player playSound("plr_breathe_exert_2");
    wait 1;
    thread aud_party("fade_in");
  } else if(var_0 == "intro_hookup_hesh") {
    wait 5.25;
    thread common_scripts\utility::play_sound_in_space("zipline_hookup_npc_1", level.allies[level.const_baker].origin);
  } else if(var_0 == "intro_hookup_merrick") {
    wait 3.7;
    thread common_scripts\utility::play_sound_in_space("zipline_hookup_npc_2", level.allies[level.const_rorke].origin);
  } else if(var_0 == "pre") {
    level.player playSound("step_run_plr_concrete");
    wait 0.72;
    level.player playSound("step_run_plr_concrete");
    wait 0.5;
    level.player playSound("step_run_plr_concrete");
    wait 0.25;
    level.player playSound("step_run_plr_concrete");
    wait 0.25;
    level.player playSound("step_run_plr_concrete");
    wait 0.21;
    level.player playSound("step_run_plr_concrete");
    wait 0.21;
    level.player playSound("step_run_plr_concrete");
    wait 0.76;
    level.player playSound("rappel_rope_creak");
  } else if(var_0 == "detach") {
    wait 9.76;
    level.player playSound("rappel_clipout");
    level.player playSound("wind_zipline_detach");
    wait 1.0;
    wait 0.8;
    level.player playSound("zipline_movement_2");
    wait 1.7;
    level.player playSound("plr_breathe_exert");
    wait 1.5;
    level.player setclienttriggeraudiozone("ext_stealth_rappel", 5);
  } else if(var_0 == "wind") {
    thread _aud_zip_wind_1();
    level.player playSound("wind_gust_near");
    var_5 = spawn("script_origin", level.player.origin);
    var_5 playLoopSound("wind_ext_lp_3");
    var_5 scalevolume(0);
    var_5 scalevolume(0.7, 3);
    wait 3.6;
    var_5 scalevolume(0, 0.25);
    wait 1;
    var_5 stoploopsound();
    wait 0.1;
    var_5 delete();
  } else if(var_0 == "landing") {
    level.player playSound("rappel_land");
    wait 1.4;
    level.player playSound("rappel_land");
  }
}

zipline_mvmt_npc() {
  var_0 = spawn("script_origin", (-28957, -4495, 27315));
  var_1 = (-24549, 516, 26865);
  var_0 playSound("zipline_movement_npc", "sounddone");
  var_0 moveto(var_1, 10.25);
  var_0 waittill("sounddone");
  var_0 delete();
}

_aud_zip_wind_1() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playLoopSound("wind_ext_lp_2");
  var_0 scalevolume(0);
  wait 1.5;
  var_0 scalevolume(0.5, 3);
  wait 5.5;
  var_0 scalevolume(0, 3);
  wait 4;
  var_0 stoploopsound();
  wait 0.1;
  var_0 delete();
}

aud_rappel(var_0) {
  if(var_0 == "jump") {
    if(!common_scripts\utility::flag("player_pounce"))
      level.player playSound("rappel_pushoff");

    if(common_scripts\utility::flag("player_has_exited_the_building") && !common_scripts\utility::flag("inverted_rappel_finished"))
      wait 1.35;
    else
      wait 1.9;

    level.player playSound("rappel_land");
  } else if(var_0 == "foot") {
    if(level.aud_can_play_rappel_footsteps) {
      level.aud_can_play_rappel_footsteps = 0;
      level.player playSound("step_run_plr_rappel");
      thread aud_rappel("creak");
      wait 0.15;
      level.aud_can_play_rappel_footsteps = 1;
    }
  } else if(var_0 == "foot_npc")
    thread maps\_utility::play_sound_on_entity("step_run_npc_rappel");
  else if(var_0 == "event1") {
    var_1 = spawn("script_origin", level.player.origin);
    common_scripts\utility::flag_wait("rappel_stealth_finished");
    wait 4;
    wait 0.1;
    var_1 delete();
  } else if(var_0 == "creak") {
    if(level.aud_can_play_rope_creak && !common_scripts\utility::flag("player_can_start_inverted_kill")) {
      level.aud_can_play_rope_creak = 0;
      level.player playSound("rappel_rope_creak");
      wait(randomfloatrange(2, 6));
      level.aud_can_play_rope_creak = 1;
    }
  } else if(var_0 == "r_glass") {
    level.allies[level.const_rorke] playSound("building_entry_glass_rorke_preentry");
    wait 2.2;
    level.allies[level.const_rorke] playSound("building_entry_glass_rorke");
    wait 5.4;
    level.allies[level.const_rorke] playSound("building_entry_glass_rorke_punch");
    wait 0.6;
    thread common_scripts\utility::play_sound_in_space("building_entry_glass_rorke_smash", (-22940, 1867, 25080));
    wait 0.6;
    level.allies[level.const_rorke] playSound("building_entry_glass_rorke_land");
  } else if(var_0 == "enter") {
    level.player playSound("building_entry_glass");
    wait 1.7;
    level.player playSound("building_entry_glass2");
  } else if(var_0 == "enter2") {
    level.player playSound("building_entry_glass4");
    wait 0.5;
    level.player playSound("wind_gust_fall");
    wait 1;
    level.player playSound("building_entry_glass_kick_through");
    level.player setclienttriggeraudiozone("int_building_entry", 1);
    level.player playSound("building_entry_glass3");
    level.aud_ext_bombs = 0;
    wait 1.2;
    level.player playSound("rappel_clipout");
    level.player clearclienttriggeraudiozone(1);
    wait 3;
    level.aud_can_play_outside_wind_gusts = 1;
    thread aud_play_random_wind_gust((-23090, 1760, 25132), 6, 13);
    thread aud_play_random_wind_gust((-22982, 1760, 25132), 5, 10);
  }
}

aud_do_wind(var_0) {
  if(var_0 == "up" && level.aud_wind_state_last != "up") {
    level.player playSound("wind_gust_rappel");
    level.player playSound("rappel_rope_creak");
    level.aud_flap_loop playLoopSound("rappel_wind_flap");
    level.aud_flap_loop scalevolume(0.5, 3);
    thread aud_rand_creak();
    thread aud_rand_gust_near();
  } else if(var_0 == "down" && level.aud_wind_state_last != "down")
    thread aud_stop_wind();

  level.aud_wind_state_last = var_0;
}

aud_rand_creak() {
  wait(randomfloatrange(0, 2));
  level.player playSound("rappel_rope_creak");
  wait(randomfloatrange(0, 5, 2));
  level.player playSound("rappel_rope_creak");
}

aud_rand_gust_near() {
  wait(randomfloatrange(1.0, 2.5));
  level.player playSound("wind_gust_near");
}

aud_stop_wind() {
  level.aud_flap_loop scalevolume(0, 5);
  wait 5;
  level.aud_flap_loop stoploopsound();
  wait 2;
}

aud_play_random_wind_gust(var_0, var_1, var_2) {
  while(level.aud_can_play_outside_wind_gusts) {
    common_scripts\utility::play_sound_in_space("wind_gust_close", var_0);
    wait(randomfloatrange(var_1, var_2));
  }
}

aud_start_pseudo_occlusion() {
  var_0 = getent("aud_ai_trigger", "targetname");
  var_1 = getent("aud_ai_trigger2", "targetname");
  var_2 = 0;
  aud_filter_on();
  level.player seteqlerp(1, 1);

  while(!common_scripts\utility::flag("player_has_exited_the_building") && !common_scripts\utility::flag("enemies_aware")) {
    if(common_scripts\utility::flag("aud_player_in_alcove")) {
      if(isalive(level.first_patroller) && level.first_patroller istouching(var_0) == 0) {
        if(!var_2) {
          aud_filter_on();
          thread aud_lerp_eq_over_time(1);
          var_2 = 1;
        }
      } else if(var_2) {
        aud_filter_off();
        thread aud_lerp_eq_over_time(0);
        var_2 = 0;
      }
    } else if(isalive(level.first_patroller) && level.player istouching(var_1) == 0) {
      if(!var_2) {
        aud_filter_on();
        level.player seteqlerp(1, 1);
        var_2 = 1;
      }
    } else if(var_2) {
      aud_filter_off();
      level.player seteqlerp(1, 1);
      var_2 = 0;
    }

    wait 0.05;
  }

  aud_filter_off();
  level.player seteqlerp(1, 1);
}

aud_filter_on() {
  level.player seteq("voice", 1, 0, "highshelf", -7, 800, 1);
  level.player seteq("voice", 1, 1, "highshelf", -5, 1200, 1);
}

aud_filter_off() {
  level.player seteq("voice", 1, 0, "highshelf", 0, 400, 1);
  level.player seteq("voice", 1, 1, "highshelf", 0, 800, 1);
}

aud_lerp_eq_over_time(var_0) {
  self endon("enemy_aware");

  for(var_1 = 0; var_1 < 40; var_1++) {
    level.player seteqlerp(var_1 * 0.025 + 0.025, var_0);
    wait 0.05;
  }
}

aud_enemy_foley() {
  self endon("enemy_aware");
  common_scripts\utility::flag_wait("start_power_junction_patrol_chatter");
  wait 30;

  if(isDefined(level.first_patroller) && isalive(level.first_patroller))
    level.first_patroller playSound("shadowkill_enemy_foley2");

  wait 2.75;

  if(isDefined(level.first_patroller) && isalive(level.first_patroller))
    level.first_patroller playSound("shadowkill_enemy_foley1");
}

aud_play_loop_until_flag(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3 playLoopSound(var_0);
  common_scripts\utility::flag_wait(var_2);
  var_3 scalevolume(0, 1);
  wait 1;
  var_3 stoploopsound();
  common_scripts\utility::waitframe();
  var_3 delete();
}

aud_virus(var_0, var_1) {
  if(var_0 == "plant") {
    level.player playSound("plant_virus_6");
    wait 0.35;
    level.player playSound("plant_virus");
    wait 4.5;
    level.player playSound("plant_virus_2");
    thread aud_virus("upload");
    thread aud_start_pseudo_occlusion();
  } else if(var_0 == "replant") {
    level.player playSound("plant_virus_6");
    wait 0.35;
    level.player playSound("plant_virus");
    wait 4.5;
    level.player playSound("plant_virus_2");
  } else if(var_0 == "upload") {
    var_1 = spawn("script_origin", level.player.origin);
    aud_virus("loop", var_1);
    level.player playSound("plant_virus_3");
    common_scripts\utility::waitframe();
    var_1 delete();
  } else if(var_0 == "loop") {
    thread aud_virus("outside_ambience");
    thread aud_enemy_foley();

    while(!common_scripts\utility::flag("virus_audio_stop_loop")) {
      common_scripts\utility::flag_wait("player_start_upload");
      wait 0.1;
      level.player playSound("plant_virus_2");
      wait 0.15;
      var_1 playLoopSound("plant_virus_beep_loop");
      var_1 scalevolume(0.4);
      common_scripts\utility::flag_wait_any("player_stop_upload", "virus_upload_bar_complete", "virus_audio_stop_loop");
      var_1 scalevolume(0, 0.1);
      wait 0.1;
      var_1 stoploopsound();
    }

    wait 1.3;
    level.player playSound("plant_virus_end");
  } else if(var_0 == "outside_ambience") {
    common_scripts\utility::flag_wait("virus_upload_bar_complete");
    thread aud_party("out_music");
    thread aud_play_loop_until_flag("outside_party_crowd_3d", (-23084, 1715, 25130), "player_has_exited_the_building");
    thread aud_play_loop_until_flag("outside_party_crowd_3d", (-22988, 1715, 25130), "player_has_exited_the_building");
    thread aud_play_loop_until_flag("amb_ext_wind_hum_window_lp", (-23084, 1715, 25130), "player_has_exited_the_building");
    thread aud_play_loop_until_flag("amb_ext_wind_hum_window_lp", (-22988, 1715, 25130), "player_has_exited_the_building");
  } else if(var_0 == "stop")
    level.player playSound("plant_virus_5");
  else if(var_0 == "restart") {
    wait 0.7;
    level.player playSound("plant_virus_4");
  } else if(var_0 == "r_approach") {
    wait 6.6;
    thread common_scripts\utility::play_sound_in_space("plant_virus_rorke_start", (-21917, 2888, 25113));
  } else if(var_0 == "r_loop") {
    var_2 = level.scr_anim["rorke"]["virus_upload_loop_rorke"][0];
    var_3 = 1;

    while(!common_scripts\utility::flag("start_power_junction_patrol_chatter")) {
      var_4 = self getanimtime(var_2);

      if(var_4 < var_3) {
        level.allies[level.const_rorke] stopsounds();
        wait 0.1;
        level.allies[level.const_rorke] playSound("plant_virus_rorke");
      }

      var_3 = var_4;
      common_scripts\utility::waitframe();
    }

    level.allies[level.const_rorke] stopsounds();
  } else if(var_0 == "r_end") {
    wait 5.25;
    level.allies[level.const_rorke] playSound("plant_virus_rorke_end");
  } else if(var_0 == "kill") {
    wait 1.7;
    level.allies[level.const_rorke] playSound("rorke_stealth_kill");
  } else if(var_0 == "activate") {
    thread common_scripts\utility::play_sound_in_space("activate_virus", (-23088, 1734, 24952));
    wait 2;
    thread common_scripts\utility::play_sound_in_space("lights_power_down_2", (-23086, 1732, 24950));
  }
}

audio_check_to_play_a_beep_or_not() {
  if(level.last_audio_bink_beep_array_num < 10) {
    if(level.last_audio_bink_percentage <= level.audio_bink_percentage_beep_array[level.last_audio_bink_beep_array_num] && level.bink_percentage >= level.audio_bink_percentage_beep_array[level.last_audio_bink_beep_array_num]) {
      if(level.last_audio_bink_beep_array_num < 9) {
        level.player playSound("plant_virus_beep_02");
        level.last_audio_bink_beep_array_num = level.last_audio_bink_beep_array_num + 1;
      } else
        thread audio_play_last_upload_beep();
    }

    level.last_audio_bink_percentage = level.bink_percentage;
  }
}

audio_play_last_upload_beep() {
  common_scripts\utility::flag_set("virus_audio_stop_loop");
  level notify("stop_virus_upload_loop_sound");
  level.player playSound("plant_virus_beep_01");
  wait 0.12;
  level.player playSound("plant_virus_beep_01");
  wait 0.12;
  level.player playSound("plant_virus_beep_01");
}

aud_invert(var_0) {
  if(var_0 == "start") {
    level.player playSound("inverted_hookup");
    level.allies[level.const_rorke] playSound("inverted_hookup_merrick");
    level.aud_can_play_outside_wind_gusts = 1;
    wait 3;
    level.player setclienttriggeraudiozone("ext_inverted_rappel", 1);
    aud_party("crowd");
    common_scripts\utility::waitframe();
    thread aud_party("crowd_swell");
    wait 2.6;
    level.player playSound("wind_gust_near");
  } else if(var_0 == "knife") {
    wait 0.44;
    level.player playSound("crnd_inverted_knife_out");
  } else if(var_0 == "ready")
    level.player playSound("crnd_inverted_pounce_ready");
  else if(var_0 == "pounce") {
    level.player playSound("crnd_inv_kill_drop");
    thread aud_inverted_kill_firstguy();
    level.player clearclienttriggeraudiozone(0.5);
  } else if(var_0 == "throw") {
    var_1 = spawn("script_origin", level.player.origin);
    var_1 playSound("crnd_inv_kill_slowknife");
    wait 0.5;
    var_1 playSound("crnd_inv_kill_slowknife_death");
    wait 3;
    var_1 delete();
  } else if(var_0 == "slow")
    level.aud_slow_mo playSound("crnd_inv_kill_slowmo");
  else if(var_0 == "slow_end") {
    level.aud_slow_mo scalevolume(0, 0.5);
    wait 0.5;
    level.aud_slow_mo stopsounds();
  } else if(var_0 == "hit") {
    thread aud_inverted_kill_finish();
    wait 0.3;
    thread common_scripts\utility::play_sound_in_space("crnd_inverted_knife_hit", (-23110, 1745, 22860));
  } else if(var_0 == "r_pounce")
    return;
}

aud_inverted_kill_firstguy() {
  wait 0.55;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playSound("crnd_inv_kill_land", "sounddone");
  wait 0.1;
  var_0 playSound("crnd_inv_kill_knife_in_1");
  wait 0.6;
  thread common_scripts\utility::play_sound_in_space("generic_pain_enemy_8", (-23238, 1730, 22818));
  wait 0.45;
  var_0 playSound("crnd_inv_kill_knife_in_2");
  wait 0.4;
  var_0 playSound("crnd_inv_kill_transition", "sounddone");
  wait 0.35;
  var_0 playSound("crnd_inv_kill_knife_out");
  var_0 waittill("sounddone");
  var_0 delete();
}

aud_inverted_kill_finish() {
  wait 0.5;
  level.player playSound("crnd_inv_kill_finish");
  wait 0.75;
  thread common_scripts\utility::play_sound_in_space("generic_death_enemy_6", (-22973, 1752, 22870));
}

aud_party(var_0) {
  if(var_0 == "out_amb") {
    aud_party("out_music");
    aud_party("crowd");
  } else if(var_0 == "out_amb_lower")
    level.aud_outside_music common_scripts\utility::play_loopsound_in_space("outside_party_music", (-22880, 658, 13956));
  else if(var_0 == "out_music")
    level.aud_outside_music playLoopSound("outside_party_music");
  else if(var_0 == "crowd")
    level.aud_outside_crowd playLoopSound("outside_party_crowd");
  else if(var_0 == "fade_in") {
    wait 4;
    wait 5;
  } else if(var_0 == "crowd_swell") {
    var_1 = 1;

    while(!common_scripts\utility::flag("start_courtyard")) {
      if(var_1) {
        thread common_scripts\utility::play_sound_in_space("outside_party_crowd_swell", (-23313, -2048, 14120));
        wait 2.7;
      } else {
        thread common_scripts\utility::play_sound_in_space("outside_party_crowd_swell_02", (-23313, -2048, 14120));
        wait 3.2;
      }

      common_scripts\utility::exploder(890);
      var_1 = !var_1;
      wait(randomintrange(8, 15));
    }
  }
}

aud_bar(var_0) {
  if(var_0 == "amb") {
    level.crnd_bar_amb = spawn("script_origin", (-24220, 4169, 22770));
    level.crnd_bar_amb playLoopSound("crnd_bar_ambience");
    var_1 = spawn("script_origin", (-23777, 3976, 22676));
    var_1 playLoopSound("restaurant_music");
    common_scripts\utility::flag_wait("bar_light_shot");
    var_1 stoploopsound("restaurant_music");
    waittillframeend;
    var_1 delete();
  } else if(var_0 == "stop") {
    common_scripts\utility::flag_wait("_stealth_spotted");

    if(!isDefined(level.crnd_bar_amb)) {
      return;
    }
    level.crnd_bar_amb stoploopsound("crnd_bar_ambience");
    waittillframeend;
    level.crnd_bar_amb delete();
  } else if(var_0 == "stop2") {
    if(!isDefined(level.crnd_bar_amb)) {
      return;
    }
    level.crnd_bar_amb stoploopsound("crnd_bar_ambience");
    waittillframeend;
    level.crnd_bar_amb delete();
  } else if(var_0 == "shuffle") {
    wait 1.0;

    if(!common_scripts\utility::flag("bar_guys_new_dead"))
      thread common_scripts\utility::play_sound_in_space("crnd_bar_shuffle", (-24220, 4169, 22770));
  } else if(var_0 == "panic") {
    level endon("junction_entrance_close");
    common_scripts\utility::flag_wait("strobe_on");

    if(!common_scripts\utility::flag("bar_guys_new_dead")) {
      wait 0.7;
      thread common_scripts\utility::play_sound_in_space("crnd_bar_stool_01", (-24127, 4404, 22749));
      wait 1.65;
      thread common_scripts\utility::play_sound_in_space("crnd_bar_stool_02", (-23909, 4033, 22749));
      wait 2;
      thread common_scripts\utility::play_sound_in_space("crnd_bar_stool_03", (-24169, 3968, 22749));
      wait 2.38;
      thread common_scripts\utility::play_sound_in_space("crnd_bar_stool_04", (-24231, 4223, 22749));
    }
  } else if(var_0 == "strobe") {
    thread common_scripts\utility::play_sound_in_space("crnd_weapon_strobe_on", level.player.origin);
    level.aud_weapon_strobe playLoopSound("crnd_weapon_strobe");
  } else if(var_0 == "strobe_stop") {
    thread common_scripts\utility::play_sound_in_space("crnd_weapon_strobe_off", level.player.origin);
    level.aud_weapon_strobe stoploopsound("crnd_weapon_strobe");
  } else if(var_0 == "light")
    thread common_scripts\utility::play_sound_in_space("crnd_strobe_lights_out", (-24040, 3799, 22720));
}

aud_door(var_0) {
  if(var_0 == "elevator_open")
    thread common_scripts\utility::play_sound_in_space("crnd_elev_door_open", (-22544, 2351, 22701));
  else if(var_0 == "elevator_close")
    thread common_scripts\utility::play_sound_in_space("crnd_elevator_close", (-22544, 2351, 22701));
  else if(var_0 == "carani") {
    wait 2.35;
    thread common_scripts\utility::play_sound_in_space("crnd_office_door_open_03", (-22233, 3097, 22667));
    wait 1;
    wait 3.2;
    level.aud_outside_crowd stoploopsound();
    level.aud_outside_music stoploopsound();
  } else if(var_0 == "stealth1") {
    wait 1.1;
    thread common_scripts\utility::play_sound_in_space("crnd_office_door_open_02", (-23696, 5147, 22676));
  } else if(var_0 == "stealth1b") {
    wait 0.75;
    thread common_scripts\utility::play_sound_in_space("crnd_office_door_close", (-23696, 5147, 22676));
  } else if(var_0 == "stealth2") {
    wait 1.05;
    thread common_scripts\utility::play_sound_in_space("crnd_office_door_open_01", (-23757, 5574, 22676));
    level.crnd_elevator_hum = spawn("script_origin", (-25298, 4901, 22652));
    level.crnd_elevator_hum playLoopSound("crnd_elevator_motor");
  } else if(var_0 == "elevator_room") {
    wait 2.6;
    thread common_scripts\utility::play_sound_in_space("crnd_elevator_room_open", (-25409, 4995, 22652));
  }
}

aud_junction(var_0) {
  if(var_0 == "hesh") {
    wait 1.6;
    thread common_scripts\utility::play_sound_in_space("crnd_hesh_junction_door_01", (-25621, 4896, 22652));
    wait 0.75;
    thread common_scripts\utility::play_sound_in_space("crnd_hesh_junction_door_02", (-25621, 4896, 22652));
    wait 3.1;
    thread common_scripts\utility::play_sound_in_space("crnd_hesh_junction_keypad", (-25453, 4943, 22652));
    wait 1.25;
    thread common_scripts\utility::play_sound_in_space("crnd_hesh_junction_doorbuzz", (-25401, 4988, 22637));
  } else if(var_0 == "stock") {
    wait 4.6;
    level.allies[level.const_baker] playSound("crnd_hesh_junction_stockup_01");
    wait 1.2;
    level.allies[level.const_baker] playSound("crnd_hesh_junction_stockup_02");
  } else if(var_0 == "panel") {
    thread aud_junction("stock");
    thread common_scripts\utility::play_sound_in_space("crnd_elevator_panel", level.player.origin);
    wait 3.33;
    thread common_scripts\utility::play_sound_in_space("crnd_elevator_disabled", (-25297, 4914, 22652));
    wait 0.15;
    level.crnd_elevator_hum stoploopsound("crnd_elevator_motor");
    wait 3;
    level.crnd_elevator_hum delete();
    thread common_scripts\utility::play_sound_in_space("crnd_junction_ambush_expl", (-24232, 5873, 22652));
    wait 0.2;
    thread common_scripts\utility::play_sound_in_space("crnd_junction_ambush_expl_02", (-24232, 5873, 22652));
    wait 1.8;
    thread common_scripts\utility::play_sound_in_space("cornered_junction_scripted_battlechatter_01", (-24637, 5630, 22652));
    wait 2.5;
    thread common_scripts\utility::play_sound_in_space("cornered_junction_scripted_battlechatter_01", (-24637, 5630, 22652));
    wait 1.5;
    thread common_scripts\utility::play_sound_in_space("cornered_junction_scripted_battlechatter_01", (-24637, 5630, 22652));
    wait 2;
    thread common_scripts\utility::play_sound_in_space("cornered_junction_scripted_battlechatter_01", (-24637, 5630, 22652));
  } else if(var_0 == "hookup") {
    wait 0.3;
    level.player playSound("crnd_third_rappel_hookup");
    wait 2.25;
    thread common_scripts\utility::play_sound_in_space("cornered_junction_scripted_battlechatter_01", (-25078, 5824, 22652));
    wait 1;
    thread common_scripts\utility::play_sound_in_space("cornered_junction_scripted_battlechatter_01", (-25078, 5824, 22652));
    wait 1;
    thread common_scripts\utility::play_sound_in_space("cornered_junction_scripted_battlechatter_01", (-25078, 5824, 22652));
  }
}

aud_c4_keegan(var_0) {
  wait 5.2;
  var_0 playSound("crnd_c4_toss");
}

aud_c4_hesh(var_0) {
  wait 6;
  var_0 playSound("crnd_c4_catch");
}

aud_rappel_combat(var_0, var_1) {
  if(var_0 == "event") {
    wait 1;
    wait 2;
    level.player setclienttriggeraudiozone("ext_rappel", 2);
    wait 1.5;
    wait 1.5;
  } else if(var_0 == "swing") {
    thread common_scripts\utility::play_sound_in_space("crnd_swing_to_garden", level.player.origin);
    wait 1.5;
    maps\_utility::music_play("mus_cornered_combat_garden");
  } else if(var_0 == "window1")
    thread common_scripts\utility::play_sound_in_space("crnd_into_garden_window_01", (-24976, 6182, 21134));
  else if(var_0 == "window2")
    thread common_scripts\utility::play_sound_in_space("crnd_into_garden_window_02", (-24889, 6317, 21130));
  else if(var_0 == "window3")
    thread common_scripts\utility::play_sound_in_space("crnd_into_garden_window_03", level.player.origin);
  else if(var_0 == "copy") {
    wait 1.6;
    var_1 playSound("falling_item");
  } else if(var_0 == "hit")
    level.player playSound("copy_machine_hit");
  else if(var_0 == "explode") {
    wait 0.5;
    thread common_scripts\utility::play_sound_in_space("crnd_die_hard_expl", (-24947, 6287, 22305));
    wait 1.6;
    thread common_scripts\utility::play_sound_in_space("crnd_die_hard_expl_rear", (-24958, 6296, 21764));
    wait 2.35;
    thread common_scripts\utility::play_sound_in_space("crnd_hesh_die_hard", (-24838, 6396, 22069));
  }
}

aud_rappel_jump_down(var_0, var_1) {
  level.player playSound("rappel_pushoff");
  wait(var_0);
  level.player playSound("rappel_slide");
  wait(var_1);
  level.player playSound("rappel_land");
}

aud_start_garden_events() {
  maps\_utility::music_stop(7);
  wait 4.4;
  level.player setclienttriggeraudiozone("int_garden", 1);
  wait 2;
  level.player clearclienttriggeraudiozone(1);
}

aud_hvt(var_0, var_1) {
  if(var_0 == "door") {
    wait 4.5;
    var_2 = spawn("script_origin", (-22359, 3308, 21116));
    var_2 playSound("crnd_hvt_sliding_door");
    var_2 moveto((-22348, 3251, 21116), 1);
    wait 4;
    thread common_scripts\utility::play_sound_in_space("crnd_hvt_door_scuffle", (-22769, 3254, 21116));
    var_2 delete();
  } else if(var_0 == "part1") {
    thread common_scripts\utility::play_sound_in_space("crnd_office_door_open", (-22770, 3255, 21116));
    thread aud_hvt("v1", var_1);
    thread aud_hvt("desk");
    thread aud_hvt("chair");
    thread aud_hvt("gun1");
  } else if(var_0 == "part2") {
    var_1 waittillmatch("single anim", "vo_cornered_rms_idontknowno");
    wait 3.6;
    thread aud_hvt("v2", var_1);
    level.allies[level.const_rorke] waittillmatch("single anim", "vo_cornered_mrk_rorke");
    wait 3.6;
    var_1 playSound("crnd_hvt_villain_06");
  } else if(var_0 == "asplode01") {
    thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_01", (-22445, 3610, 21116));
    wait 0.49;
    thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_02", (-22817, 3553, 21116));
    wait 0.61;
    thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_03", (-22697, 3131, 21116));
    wait 0.61;
    thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_04", (-22359, 3142, 21116));
    wait 0.74;
    thread common_scripts\utility::play_sound_in_space("crnd_detonation", level.player.origin);
    level.player setclienttriggeraudiozone("int_collapse");
    wait 0.5;
    level.crnd_hvt_alarm01 = spawn("script_origin", (-23441, 3090, 21068));
    level.crnd_hvt_alarm01 playLoopSound("crnd_fire_alarm_lp_02");
    level.crnd_hvt_alarm02 = spawn("script_origin", (-23242, 4069, 20730));
    level.crnd_hvt_alarm02 playLoopSound("crnd_fire_alarm_lp_01");
  } else {
    if(var_0 == "part3") {
      return;
    }
    if(var_0 == "v1") {
      wait 0.15;
      var_1 playSound("crnd_hvt_villain_01");
    } else if(var_0 == "desk") {
      wait 1.3;
      var_3 = spawn("script_origin", (-22559, 3218, 21116));
      var_3 playSound("crnd_hvt_desk_debris_01");
      var_3 moveto((-22382, 3195, 21082), 1.1);
      wait 5;
      var_3 delete();
    } else if(var_0 == "chair") {
      wait 3.36;
      thread common_scripts\utility::play_sound_in_space("crnd_hvt_chair_01", (-22576, 3166, 21111));
    } else if(var_0 == "gun1") {
      wait 8.39;
      level.allies[level.const_rorke] playSound("crnd_hvt_rorkegun_draw");
    } else if(var_0 == "p1") {
      thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_01", (-22445, 3610, 21116));
      wait 0.49;
      thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_02", (-22817, 3553, 21116));
      wait 0.61;
      thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_03", (-22697, 3131, 21116));
      wait 0.61;
      thread common_scripts\utility::play_sound_in_space("crnd_hvt_bomb_04", (-22359, 3142, 21116));
      wait 0.74;
      thread common_scripts\utility::play_sound_in_space("crnd_detonation", level.player.origin);
      level.player setclienttriggeraudiozone("int_collapse");
      wait 0.5;
      level.crnd_hvt_alarm01 = spawn("script_origin", (-23441, 3090, 21068));
      level.crnd_hvt_alarm01 playLoopSound("crnd_fire_alarm_lp_02");
      level.crnd_hvt_alarm02 = spawn("script_origin", (-23242, 4069, 20730));
      level.crnd_hvt_alarm02 playLoopSound("crnd_fire_alarm_lp_01");
    } else if(var_0 == "p2") {
      wait 13.75;
      thread common_scripts\utility::play_sound_in_space("crnd_hvt_player_02", (-22573, 3236, 21109));
    } else {
      if(var_0 == "p3") {
        return;
      }
      if(var_0 == "v2")
        var_1 playSound("crnd_hvt_villain_02");
      else if(var_0 == "v3") {
        wait 11.7;
        var_1 playSound("crnd_hvt_villain_03");
      } else {
        if(var_0 == "r1") {
          return;
        }
        if(var_0 == "v4") {
          return;
        }
        if(var_0 == "r2") {
          return;
        }
        if(var_0 == "b1") {
          return;
        }
        if(var_0 == "r3") {
          return;
        }
        if(var_0 == "v5") {
          wait 44.5;
          thread common_scripts\utility::play_sound_in_space("crnd_hvt_villain_05", (-22588, 3170, 21104));
        } else if(var_0 == "gun2") {
          wait 4.18;
          level.allies[level.const_rorke] playSound("crnd_hvt_rorkegun_holster");
        } else if(var_0 == "gun3") {
          wait 16.17;
          level.allies[level.const_rorke] playSound("crnd_hvt_rorkegun_draw");
        } else if(var_0 == "b2") {
          wait 8.11;
          thread common_scripts\utility::play_sound_in_space("crnd_hvt_baker_02", (-22582, 3227, 21116));
        } else if(var_0 == "b3") {
          wait 16.6;
          thread common_scripts\utility::play_sound_in_space("crnd_hvt_baker_03", (-22582, 3227, 21116));
        } else if(var_0 == "v6") {
          wait 15.45;
          thread common_scripts\utility::play_sound_in_space("crnd_hvt_villain_06", (-22545, 3182, 21116));
        } else if(var_0 == "exit") {
          maps\_utility::music_play("mus_cornered_building_falls");
          thread common_scripts\utility::play_sound_in_space("crnd_office_door_open", (-22940, 3267, 21116));
        } else {
          return;
          return;
          return;
          return;
          return;
          return;
        }
      }
    }
  }
}

aud_hvt_boomtimer01() {
  wait 32.5;
  thread aud_hvt("asplode01");
}

aud_hvt_destruct01() {
  thread common_scripts\utility::play_sound_in_space("crnd_hvt_destruct_01", (-23379, 3257, 21124));
  thread common_scripts\utility::play_sound_in_space("crnd_hvt_destruct_01_lsrs", (-22789, 3224, 21116));
}

aud_hvt_destruct02() {
  thread common_scripts\utility::play_sound_in_space("crnd_hvt_destruct_02", (-23385, 3156, 20830));
  thread common_scripts\utility::play_sound_in_space("crnd_hvt_destruct_02_lsrs", (-22987, 3067, 20911));
}

aud_collapse(var_0) {
  if(var_0 == "crack") {
    thread common_scripts\utility::play_sound_in_space("crnd_building_blast_01", (-21989, 4468, 20492));
    thread common_scripts\utility::play_sound_in_space("bldg_death_slide", (-22380, 3988, 20518));
    level.aud_can_play_bldg_shake = 0;
    thread aud_collapse("debris");
    thread aud_collapse("chunk1");
    wait 4.5;
    thread common_scripts\utility::play_sound_in_space("crnd_building_blast_02", (-22448, 4054, 20544));
    thread common_scripts\utility::play_sound_in_space("crnd_building_blast_02b", (-22654, 4604, 20544));
    thread aud_collapse("slide1");
    thread aud_collapse("slide2");
    thread aud_collapse("slide3");
    thread aud_collapse("tilt2");
    thread aud_collapse("panic_scream");
    thread aud_collapse("short_scream");
    thread aud_collapse("pulsing_hum");
  } else if(var_0 == "debris") {
    wait 1.45;
    thread common_scripts\utility::play_sound_in_space("crnd_building_tilt_01", (-22355, 4446, 20668));
  } else if(var_0 == "collapse_music") {
    wait 1.5;
    maps\_utility::music_play("mus_cornered_building_falls");
  } else if(var_0 == "chunk1") {
    wait 0.7;
    thread common_scripts\utility::play_sound_in_space("crnd_horiz_debris_01", (-22293, 4025, 20487));
    wait 0.6;
    thread common_scripts\utility::play_sound_in_space("crnd_horiz_debris_02", (-22509, 4162, 20483));
    wait 3.5;
    thread common_scripts\utility::play_sound_in_space("crnd_chunk_fall_01", (-22437, 4069, 20490));
    wait 2.1;
    thread common_scripts\utility::play_sound_in_space("crnd_chunk_fall_02", (-22494, 4038, 20457));
  } else if(var_0 == "slide1") {
    wait 1.85;
    thread common_scripts\utility::play_sound_in_space("crnd_player_slide_01", level.player.origin);
  } else if(var_0 == "slide2")
    wait 9.33;
  else if(var_0 == "slide3")
    wait 18.2;
  else if(var_0 == "tilt2") {
    wait 0.32;
    thread common_scripts\utility::play_sound_in_space("crnd_building_tilt_02", (-22390, 3961, 20527));
    wait 9.97;
    thread common_scripts\utility::play_sound_in_space("crnd_building_tilt_03", (-22363, 3504, 20527));
    wait 7.13;
    thread common_scripts\utility::play_sound_in_space("crnd_plr_building_plummet", level.player.origin);
    wait 3.2;
    thread common_scripts\utility::play_sound_in_space("crnd_plummet_gapper", (-22509, 4162, 20483));
    wait 0.41;
    thread common_scripts\utility::play_sound_in_space("crnd_slowmo_window_imp", level.player.origin);
    level.player setclienttriggeraudiozone("ext_collapse");
    wait 0.1;
    thread common_scripts\utility::play_sound_in_space("crnd_end_city", level.player.origin);
    wait 2.1;
    thread common_scripts\utility::play_sound_in_space("crnd_parachute_dist", (-22356, -58, 18097));
    wait 0.1;
    wait 0.9;
    thread common_scripts\utility::play_sound_in_space("crnd_building_top_hit", (-22481, -5972, 19973));
    wait 15;
    level.player setclienttriggeraudiozone("end_fade", 5);
  } else if(var_0 == "panic_scream") {
    wait 12;
    var_1 = spawn("script_origin", (-22635, 3575, 20521));
    var_2 = spawn("script_origin", (-22164, 3617, 20457));
    var_1 playSound("cornered_saf1_panickyyellsasbuilding");
    var_2 playSound("cornered_saf2_panickyyellsasbuilding");
    var_1 moveto((-22590, 1886, 20516), 9.8);
    var_2 moveto((-22162, 1874, 20516), 9.8);
  } else if(var_0 == "short_scream") {
    wait 5;
    thread common_scripts\utility::play_sound_in_space("cornered_saf1_shortfallscream", (-22387, 3724, 20457));
    wait 0.95;
    thread common_scripts\utility::play_sound_in_space("crnd_ceiling_enemy_fall", (-22376, 3660, 20457));
  } else if(var_0 == "stumble") {
    thread common_scripts\utility::play_sound_in_space("crnd_lobby_boom", (-22822, 4323, 20582));
    thread common_scripts\utility::play_sound_in_space("crnd_lobby_boom_02", (-22822, 4323, 20582));
    thread common_scripts\utility::play_sound_in_space("crnd_building_shifting", (-22822, 4323, 20582));
    wait 0.1;
    thread common_scripts\utility::play_sound_in_space("crnd_baker_atrium_stumble", (-22822, 4323, 20582));
    thread common_scripts\utility::play_sound_in_space("crnd_blast_debris", (-22426, 4406, 20538));
  } else if(var_0 == "shelf") {
    thread common_scripts\utility::play_sound_in_space("crnd_atrium_shelf_debris_01", (-22928, 4593, 20714));
    wait 0.75;
    thread common_scripts\utility::play_sound_in_space("crnd_atrium_shelf_debris_02", (-22852, 4586, 20578));
  } else if(var_0 == "pillar")
    wait 0.56;
  else if(var_0 == "slow") {
    maps\_utility::music_play("mus_cornered_escape");
    wait 2.6;
    thread aud_collapse("window");
  } else if(var_0 == "window") {
    level.player setclienttriggeraudiozone("ext_collapse", 2);
    _window_imp();
  } else if(var_0 == "window_check") {
    wait 0.05;
    _window_imp();
  } else if(var_0 == "debris2") {
    wait 7.5;
    wait 3.5;
  } else if(var_0 == "stairs1")
    wait 12.93;
  else if(var_0 == "stairs2")
    wait 15.3;
  else {
    if(var_0 == "metal") {
      return;
    }
    if(var_0 == "chunk") {
      return;
    }
    if(var_0 == "event1")
      wait 0.5;
    else {
      if(var_0 == "event3") {
        return;
      }
      if(var_0 == "event9") {
        return;
      }
      if(var_0 == "building") {
        thread aud_collapse("rumble");
        thread aud_collapse("pipes");
      } else {
        if(var_0 == "rumble") {
          return;
        }
        if(var_0 == "pipes") {
          common_scripts\utility::flag_wait("stairwell_shake_1");
          thread common_scripts\utility::play_loopsound_in_space("crnd_pipe_spray", (-23393, 3142, 21116));
          thread common_scripts\utility::play_loopsound_in_space("emt_water_pipe_splashy", (-23410, 3088, 20964));
          thread common_scripts\utility::play_sound_in_space("crnd_pipe_burst1", (-23393, 3142, 21116));
          common_scripts\utility::flag_wait("stairwell_pipe_2");
          thread common_scripts\utility::play_loopsound_in_space("crnd_pipe_spray", (-22994, 3048, 20860));
          thread common_scripts\utility::play_loopsound_in_space("emt_water_pipe_splashy", (-22999, 3048, 20811));
          thread common_scripts\utility::play_sound_in_space("crnd_pipe_burst2", (-22994, 3048, 20860));
          thread common_scripts\utility::play_loopsound_in_space("emt_water_drip_splat_int", (-23395, 3116, 20685));
        } else if(var_0 == "lobby") {
          if(!common_scripts\utility::flag("go_building_fall") && level.aud_can_play_bldg_shake == 1)
            thread common_scripts\utility::play_sound_in_space("crnd_shake", (-22420, 4412, 20727));
        } else if(var_0 == "pulsing_hum")
          wait 11.75;
        else {
          return;
          return;
          return;
          return;
        }
      }
    }
  }
}

_window_imp() {}

aud_rumble_loop(var_0, var_1, var_2, var_3) {}