/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_harbor_aud.gsc
******************************************/

main() {
  maps\_audio::aud_set_level_fade_time(0.25);
  maps\_audio::aud_init();
  maps\_audio::set_stringtable_mapname("shg");
  maps\_audio::aud_set_occlusion("med_occlusion");
  maps\_audio::aud_set_timescale("shg_default");

  if(!isDefined(level.aud)) {
    level.aud = spawnStruct();
  }
  common_scripts\utility::flag_init("aud_player_tunnel_spline");
  common_scripts\utility::flag_init("aud_flag_player_underwater");
  common_scripts\utility::flag_init("player_above_water");
  common_scripts\utility::flag_init("aud_building_exploded");
  common_scripts\utility::flag_init("aud_building_02_exploded");
  common_scripts\utility::flag_init("aud_flag_scubamask_on_player");
  common_scripts\utility::flag_init("aud_flag_inside_sub");
  common_scripts\utility::flag_init("leaving_sub");
  common_scripts\utility::flag_init("aud_end_ship_sink");
  common_scripts\utility::flag_init("aud_engine_stop_monitor");
  common_scripts\utility::flag_init("aud_engine_fade_out");
  common_scripts\utility::flag_init("aud_planting_submine");
  common_scripts\utility::flag_init("scn_gate_cut_spark_01");
  common_scripts\utility::flag_init("aud_first_spark_played");
  common_scripts\utility::flag_init("aud_second_spark");
  common_scripts\utility::flag_init("aud_third_spark");
  common_scripts\utility::flag_init("aud_sink_impact_done");
  common_scripts\utility::flag_init("aud_kill_ship_residuals");
  common_scripts\utility::flag_init("stop_line_emitters");
  common_scripts\utility::flag_init("aud_door_slowmo_exit");
  common_scripts\utility::flag_init("aud_big_ship_missile_explo");
  common_scripts\utility::flag_init("aud_boat_slowmo_outro");
  common_scripts\utility::flag_init("player_zodiac_jump_ramp");
  common_scripts\utility::flag_init("player_zodiac_jump_hitwater");
  common_scripts\utility::flag_init("aud_player_zodiac_in_chinook");
  level.aud.sub_stress_chance = 80;
  level.aud.next_zodiac_splash_time = 0;
  level.aud.zodiac_splash_rate_min = 250;
  level.aud.zodiac_splash_rate_max = 700;
  aud_launch_threads();
  aud_launch_loops();
  aud_create_level_envelop_arrays();
  aud_register_trigger_callbacks();
  aud_add_note_track_data();
  aud_precache_presets();
  maps\_audio_mix_manager::mm_add_submix("nyhb_level_global_mix");
  maps\_audio::aud_register_msg_handler(::audio_msg_handler);
  maps\_audio::aud_register_msg_handler(::music_msg_handler);
}

aud_precache_presets() {
  maps\_audio_mix_manager::mm_precache_preset("nyhb_level_global_mix");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_underwater");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_battleship_sink");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_russian_sub_by");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_surface_breach_se");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_surface_battle");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_sub_interior");
  maps\_audio_mix_manager::mm_precache_preset("sub_player_weapon");
  maps\_audio_mix_manager::mm_precache_preset("sub_entry");
  maps\_audio_mix_manager::mm_precache_preset("pre_bridge_breach");
  maps\_audio_mix_manager::mm_precache_preset("sub_door_breach");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_sub_control_room");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_pre_board_zodiac");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_zodiac_escape");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_boat_slowmo");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_theres_our_bird");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_zodiac_jump");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_chinook_interior_flight");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_finale");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_finale_amb_fade");
  maps\_audio_mix_manager::mm_precache_preset("nyhb_final_flyby");
}

aud_launch_loops() {
  thread aud_ignore_slowmo();
  aud_steam_emitters();
  aud_machinery_emitters();
  aud_sub_computers();
  aud_electric_breakerboxes();
  aud_controlroom_lights();
  aud_steamy_vents();
  aud_controlroom_radios();
  aud_floodroom_water();
  aud_sub_waterfalls();
  aud_flooded_waterfalls();
  thread aud_control_room_alarms();
  aud_velocity_emitters();
  aud_fires();
  aud_uw_bubbles();
}

aud_launch_threads() {
  thread aud_harbor_surface_water_sfx();
  thread aud_russian_sub_start();
  thread aud_player_on_zodiac();
  thread aud_zodiac_jump();
}

aud_create_level_envelop_arrays() {
  level.aud.envs["aud_nyhb_tunnel_zone_env"] = [[0.0, 0.0], [0.2, 0.05], [0.5, 0.2], [0.7, 0.3], [1.0, 1.0]];
  maps\_audio::aud_add_progress_map("aud_nyhb_tunnel_zone_env", level.aud.envs["aud_nyhb_tunnel_zone_env"]);
  level.aud.envs["aud_battleship_sink"] = [[0.0, 1.0], [0.2, 1.0], [0.4, 0.8], [0.6, 0.6], [0.8, 0.4], [1.0, 0.0]];
  level.aud.envs["zodiac_speed_to_ambi_vol"] = [[0.0, 1.0], [1.0, 0.0]];
}

aud_register_trigger_callbacks() {}

aud_add_note_track_data() {
  anim.notetracks["aud_start_missilekeytoss"] = ::aud_start_missilekeytoss;
}

audio_msg_handler(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "e3_demo_fade_out":
      var_3 = var_1;
      maps\_audio_mix_manager::mm_add_submix("mute_all", var_3);
      break;
    case "e3_demo_fade_in":
      var_3 = var_1;
      level.aud.e3 = var_3;
      break;
    case "start_rendezvous_with_seals":
      thread aud_gate_cut_start();
      common_scripts\utility::flag_set("aud_flag_player_underwater");
      common_scripts\utility::flag_set("aud_flag_scubamask_on_player");
      level.player_sdv vehicle_turnengineoff();
      thread aud_player_sdv_intro();
      maps\_audio_zone_manager::azm_start_zone("nyhb_pretunnel_tube");
      break;
    case "start_plant_mine_on_sub":
      common_scripts\utility::flag_set("aud_flag_player_underwater");
      common_scripts\utility::flag_set("aud_flag_scubamask_on_player");
      level.player_sdv vehicle_turnengineoff();
      thread aud_player_sdv_pause();
      maps\_audio_zone_manager::azm_start_zone("nyhb_underwater_pre_sub");
      break;
    case "start_capture_sub":
      maps\_audio_zone_manager::azm_start_zone("nyhb_surface_battle");
      aud_play_city_combat_ambi();
      music_cue("mus_sub_breach_checkpoint");
      maps\_audio_mix_manager::mm_add_submix("sub_player_weapon");
      aud_start_subtop_line_emitters();
      break;
    case "start_bridge_breach":
      maps\_audio_zone_manager::azm_start_zone("nyhb_sub_interior_missileroom2");
      thread aud_scuttle_alarms_start();
      common_scripts\utility::flag_set("aud_flag_inside_sub");
      level.aud.sub_stress_chance = 40;
      maps\_audio_mix_manager::mm_add_submix("sub_player_weapon");

      if(isDefined(level.aud.e3)) {
        music_cue("mus_e3_demo_fade_in");
        var_4 = level.aud.e3;
        maps\_audio_mix_manager::mm_clear_submix("mute_all", var_4);
      } else {
        music_cue("mus_sub_scuttle_announcement", 0);
      }
      break;
    case "start_escape_on_zodiacs":
      maps\_audio_zone_manager::azm_start_zone("nyhb_surface_battle");
      aud_play_city_combat_ambi();
      music_cue("mus_sandman_copies_all");
      maps\_audio_mix_manager::mm_add_submix("nyhb_pre_board_zodiac");
      break;
    case "start_exit_flight":
      maps\_audio_zone_manager::azm_start_zone("nyhb_surface_battle");
      music_cue("mus_finale");
      break;
    case "enter_nyhb_underwater_subway_tunnel":
      var_5 = var_1;
      break;
    case "exit_nyhb_underwater_subway_tunnel":
      break;
    case "enter_nyhb_sub_interior_engineroom":
      var_5 = var_1;
      thread aud_siren_first();
      break;
    case "exit_nyhb_sub_interior_engineroom":
      var_6 = var_1;

      if(var_6 == "nyhb_sub_interior_engineroom") {
        common_scripts\utility::flag_set("aud_flag_inside_sub");
        level notify("aud_notify_inside_sub");
        level.aud.sub_stress_chance = 80;
        aud_stop_city_combat_ambi();
      } else {
        common_scripts\utility::flag_clear("aud_flag_inside_sub");
        aud_play_city_combat_ambi();
      }

      break;
    case "enter_nyhb_sub_interior_barracks":
      var_5 = var_1;
      level.aud.sub_stress_chance = 80;
      break;
    case "exit_nyhb_sub_interior_barracks":
      var_6 = var_1;
      level.aud.sub_stress_chance = 80;
      break;
    case "enter_nyhb_sub_interior_flooded":
      var_5 = var_1;
      level.aud.sub_stress_chance = 80;
      break;
    case "exit_nyhb_sub_interior_flooded":
      var_6 = var_1;

      if(var_6 == "nyhb_sub_interior_flooded") {
        music_cue("mus_sub_interior_flooded");
      }
      level.aud.sub_stress_chance = 80;
      break;
    case "enter_nyhb_sub_interior_pre_missileroom":
      var_5 = var_1;
      break;
    case "exit_nyhb_sub_interior_pre_missileroom":
      var_6 = var_1;
      break;
    case "enter_nyhb_sub_interior_missileroom1":
      var_5 = var_1;

      if(var_5 == "nyhb_sub_interior_pre_missileroom") {
        thread aud_reactor_computers();
      }
      break;
    case "exit_nyhb_sub_interior_missileroom1":
      var_6 = var_1;
      break;
    case "enter_nyhb_sub_interior_missileroom2":
      var_5 = var_1;
      break;
    case "exit_nyhb_sub_interior_missileroom2":
      var_6 = var_1;
      break;
    case "enter_nyhb_sub_interior_controlroom":
      var_5 = var_1;

      if(var_5 == "nyhb_sub_interior_missileroom2") {
        level.aud.sub_stress_chance = 20;
      } else {
        level.aud.sub_stress_chance = 40;
      }
      break;
    case "exit_nyhb_sub_interior_controlroom":
      var_6 = var_1;

      if(var_6 == "nyhb_sub_interior_controlroom") {
        level.aud.sub_stress_chance = 20;
      } else {
        level.aud.sub_stress_chance = 40;
      }
      break;
    case "enter_nyhb_surface_battle":
      var_5 = var_1;

      if(var_5 == "nyhb_sub_interior_controlroom") {
        if(isDefined(level.aud.exit_control_room_to_zodiac)) {
          common_scripts\utility::flag_set("leaving_sub");
          common_scripts\utility::flag_clear("aud_flag_inside_sub");
          maps\_audio_mix_manager::mm_add_submix("nyhb_pre_board_zodiac");
          thread aud_start_subtop_line_emitters();
          aud_play_city_combat_ambi();
          level.aud.sub_stress_chance = 0;
        }
      } else {}

      break;
    case "exit_nyhb_surface_battle":
      var_6 = var_1;

      if(var_6 == "nyhb_sub_interior_controlroom") {
        if(isDefined(level.aud.exit_control_room_to_zodiac)) {
          aud_stop_city_combat_ambi();
          level.aud.sub_stress_chance = 20;
          common_scripts\utility::flag_set("aud_flag_inside_sub");
          common_scripts\utility::flag_set("stop_line_emitters");
          level notify("aud_notify_inside_sub");
        }
      }

      break;
    case "enter_nyhb_surface_pier":
      var_5 = var_1;

      if(var_5 == "nyhb_zodiac_ride") {
        maps\_audio::aud_set_filter("harb_zodiac_pier");
      }
      break;
    case "exit_nyhb_surface_pier":
      var_6 = var_1;

      if(var_6 == "nyhb_zodiac_ride") {
        maps\_audio::aud_clear_filter();
      }
      break;
    case "enter_nyhb_zodiac_ride":
      var_5 = var_1;

      if(var_5 == "nyhb_surface_pier") {
        maps\_audio::aud_clear_filter();
      }
      break;
    case "exit_nyhb_zodiac_ride":
      var_6 = var_1;

      if(var_6 == "nyhb_surface_pier") {
        maps\_audio::aud_set_filter("harb_zodiac_pier");
      }
      break;
    case "enter_nyhb_underwater_open":
      var_5 = var_1;
      break;
    case "exit_nyhb_underwater_open":
      var_6 = var_1;
      break;
    case "player_tunnel_spline":
      music_msg_handler("mus_intro");
      break;
    case "building_missile_explosion_01":
      aud_building_explode();
      break;
    case "land_explosion":
      var_7 = var_1;
      thread common_scripts\utility::play_sound_in_space("harb_explo_dist", var_7);
      thread common_scripts\utility::play_sound_in_space("nymn_explosion_mortar_distant", var_7);
      break;
    case "harbor_missile_03":
      var_8 = spawn("script_origin", level.player.origin);
      var_9 = spawn("script_origin", level.player.origin);
      var_8 playSound("harb_surface_missile_incoming_ext_02");
      wait 0.5;
      var_8 scalevolume(0.0, 0.5);
      level.player playSound("harb_single_missile_overhead");
      level.player playSound("harb_single_missile_overhead_lo");
      var_9 playSound("harb_overhead_missiles_tail");
      wait 0.05;
      var_9 scalevolume(1.0, 0.05);
      common_scripts\utility::flag_wait("aud_building_02_exploded");
      var_9 scalevolume(0.0, 0.3);
      wait 0.75;
      var_9 delete();
      var_8 delete();
      break;
    case "building_missile_explosion_02":
      aud_building_explode_02();
      break;
    case "sdv_scuba_bubbles":
      thread aud_sdv_scuba_bubbles();
      break;
    case "player_scuba_bubbles":
      thread aud_player_scuba_bubbles();
      break;
    case "torch_screen_flash":
      aud_torch_flash();
      break;
    case "sinking_ship_debris_splash":
      wait 1.25;
      level.player playSound("harb_battleship_sink_uw_splash");
      wait 0.6;
      level.player playSound("harb_battleship_sink_uw_splash");
      break;
    case "ship_sink_flash_explosion":
      var_10 = var_1;
      thread maps\_audio_mix_manager::mm_add_submix("nyhb_battleship_sink");
      thread common_scripts\utility::play_sound_in_space("harb_battleship_sink_explosion_01", level.player.origin);
      thread aud_debris_splashes_underwater();
      break;
    case "underwater_battleship_sink":
      var_11 = var_1;
      thread aud_battleship_sink(var_11);
      wait 4;
      level.player playSound("harb_battleship_stress");
      wait 4;
      maps\_audio_zone_manager::azm_start_zone("nyhb_underwater_pre_sub");
      wait 4;
      aud_russian_sub_single_ping();
      wait 3;
      aud_russian_sub_single_ping();
      break;
    case "torpedo_1":
      var_12 = var_1;
      wait 0.9;

      if(isDefined(var_12)) {
        maps\_audio::aud_play_linked_sound("oscar_torpedoes_st", var_12);
      }
      break;
    case "torpedo_2":
      var_13 = var_1;
      break;
    case "sonar_ping_hud":
      thread aud_play_mine_beep();
      break;
    case "aud_mine_explosion":
      var_14 = var_1;
      common_scripts\utility::play_sound_in_space("mine_explo", var_14);
      break;
    case "sonar_ping":
      aud_minewarn(var_1);
      break;
    case "sub_approach":
      common_scripts\utility::flag_set("aud_kill_ship_residuals");
      break;
    case "aud_link_engine_entities_to_scripted_node":
      var_15 = var_1;
      level.aud.cone_sound linkTo(var_15, "tag_origin");
      level.aud.omni_sound linkTo(var_15, "tag_origin");
      break;
    case "aud_limpet_mine_anim":
      aud_player_sdv_off(1.0);
      level.player playSound("shg_sdv_plr_shutdown");
      level.player playSound("harb_se_plantmine_01");
      wait 2.0;
      common_scripts\utility::flag_set("aud_engine_stop_monitor");
      break;
    case "submine_planted":
      break;
    case "sub_breach_started":
      thread aud_player_sub_surface_breach();
      thread aud_sub_destroy();
      break;
    case "submine_detonated":
      aud_prime_city_combat_ambi();
      break;
    case "sub_breach_finished":
      break;
    case "player_surfaces":
      music_cue("mus_drone_E");
      thread aud_overhead_missiles();
      common_scripts\utility::flag_clear("aud_flag_player_underwater");
      maps\_audio_zone_manager::azm_start_zone("nyhb_surface_battle");
      aud_play_primed_city_combat_ambi();
      maps\_audio_mix_manager::mm_add_submix("sub_player_weapon");
      common_scripts\utility::flag_wait("aud_building_exploded");
      music_cue("mus_fist_building_explodes");
      wait 0.5;
      level.player playSound("sub_surface_breach_lead_in");
      break;
    case "slava_missile_launch":
      if(!common_scripts\utility::flag("player_on_boat")) {
        aud_slava_missile_launch(var_1[0]);
      }
      break;
    case "slava_missile_explode":
      if(!common_scripts\utility::flag("player_on_boat")) {
        var_7 = var_1[0];
        thread common_scripts\utility::play_sound_in_space("nymn_explosion_mortar_distant", var_7);
      }

      break;
    case "scubamask_off_player":
      common_scripts\utility::flag_clear("aud_flag_scubamask_on_player");
      level.player playSound("harb_sub_takemaskoff");
      thread aud_start_subtop_line_emitters();
      break;
    case "get_onto_sub":
      break;
    case "aud_prime_player_downladder":
      level.player maps\_audio::aud_prime_stream("harb_se_player_downladder");
      break;
    case "aud_player_downladder":
      level.player maps\_audio::aud_release_stream("harb_se_player_downladder");
      level.player playSound("harb_se_player_downladder");
      wait 2;
      maps\_audio_mix_manager::mm_add_submix("sub_entry", 2);
      thread aud_barracks_sandman_opening_door();
      wait 1;
      common_scripts\utility::flag_set("stop_line_emitters");
      break;
    case "sub_splashes":
      break;
    case "big_splash":
      break;
    case "aud_prime_sandman_grenade_anim":
      level.aud.sandman_sound = spawn("script_origin", level.sandman.origin);
      level.aud.sandman_sound maps\_audio::aud_prime_stream("harb_se_grenadethrow_foley");
      break;
    case "aud_start_sandman_grenade_anim":
      wait 0.9;
      var_16 = level.aud.sandman_sound maps\_audio::aud_is_stream_primed("harb_se_grenadethrow_foley");
      level.aud.sandman_sound maps\_audio::aud_release_stream("harb_se_grenadethrow_foley");
      level.aud.sandman_sound.origin = level.sandman.origin;
      level.aud.sandman_sound linkTo(level.sandman, "tag_origin");
      level.aud.sandman_sound playSound("harb_se_grenadethrow_foley", "sounddone");
      thread maps\_audio::delete_on_sounddone(level.aud.sandman_sound);
      wait 4.2;
      thread common_scripts\utility::play_sound_in_space("harb_sub_grenade_metalres", (-39500, -23857, 10));
      thread common_scripts\utility::play_sound_in_space("grenade_explode_metal", (-39500, -23857, 21));
      thread common_scripts\utility::play_sound_in_space("grenade_explode_layer", (-39500, -23857, 20));
      break;
    case "aud_sub_sandman_pairedkill_headsmash":
      break;
    case "hind_player_killer":
      if(!isDefined(var_1)) {
        return;
      }
      maps\_audio::aud_play_linked_sound("hind_player_killer_inc", var_1);
      maps\_audio::aud_play_linked_sound("hind_player_killer_lp", var_1, "loop", "aud_player_killer_kill_lp");
      break;
    case "if_the_sub_is_a_rocking_dont_come_a_knocking":
      if(common_scripts\utility::flag("aud_flag_inside_sub")) {
        if(maps\_audio::aud_percent_chance(level.aud.sub_stress_chance)) {
          maps\_audio::aud_play_linked_sound("harb_sub_stress", level.player);
        }
      }

      break;
    case "aud_open_bulkhead_door":
      level notify("aud_bulkhead_door_open");
      break;
    case "aud_fire_extinguisher_spray":
      var_17 = var_1;
      var_17 playSound("fire_extinguisher_spray");
      break;
    case "aud_scuttle_alarms_start":
      thread aud_scuttle_alarms_start();
      level.aud.sub_stress_chance = 40;
      wait 30;
      aud_do_sub_scuttle_bombshake();
      break;
    case "bridge_breach":
      level.sandman maps\_audio::aud_prime_stream("harb_se_take_keys");
      music_cue("mus_sub_door_breach");
      break;
    case "aud_control_room_pipe_burst":
      thread common_scripts\utility::play_loopsound_in_space("sub_emt_waterfall_pipe", (-36285, -24116, -230));
      thread common_scripts\utility::play_loopsound_in_space("sub_emt_waterfall_splatter_large", (-36287, -24102, -417));
      level.player playSound("harb_exp_pipe_burst_01");
      break;
    case "aud_flooded_room_pipe_burst":
      level.player playSound("harb_exp_pipe_burst_01");
      break;
    case "aud_premissileroom_pipeburst":
      thread common_scripts\utility::play_sound_in_space("sub_exp_premissileroom_pipeburst", (-37773, -23808, -418));
      thread common_scripts\utility::play_sound_in_space("harb_emt_pipe_burst_premr", (-37773, -23808, -418));
      break;
    case "aud_missile_room_pipe_burst":
      level.player playSound("harb_exp_pipe_burst_02");
      break;
    case "bridge_breach_setup":
      music_cue("mus_bridge_breach_setup");
      break;
    case "player_trigger_sub_door_breach":
      thread maps\_audio_mix_manager::mm_add_submix("pre_bridge_breach", 6);
      break;
    case "door_breach_slowmo_start":
      thread aud_door_breach_slomo();
      level.player playSound("db_sub_drop_slo_01");
      level.player playSound("db_impact_hit_01");
      break;
    case "door_breach_slowmo_end":
      aud_player_exit_slomo();
      break;
    case "aud_prime_sandman_takes_key":
      level.aud.harb_take_keys = spawn("script_origin", (-35670, -23983, -240));
      level.aud.harb_take_keys maps\_audio::aud_prime_stream("harb_se_take_keys");
      break;
    case "aud_start_sandman_takes_key":
      level.aud.harb_take_keys playSound("harb_se_take_keys", "sounddone");
      level.aud.harb_take_keys waittill("sounddone");
      wait 0.05;
      level.aud.harb_take_keys delete();
      break;
    case "aud_prime_missilekeytoss":
      break;
    case "aud_zodiac_slide_se":
      level.player playSound("harb_se_board_zodiac_locked");
      break;
    case "begin_zodiac_ride":
      maps\_audio_mix_manager::mm_clear_submix("nyhb_pre_board_zodiac");
      maps\_audio_mix_manager::mm_clear_submix("sub_player_weapon");
      maps\_audio_zone_manager::azm_start_zone("nyhb_zodiac_ride");
      music_cue("mus_zodiac_ride");
      level.player setwhizbyradii(16, 32, 10000);
      level.player setwhizbyprobabilities(1, 2, 10);
      common_scripts\utility::flag_set("stop_line_emitters");
      break;
    case "sub_missile_door_open":
      var_18 = var_1;
      thread common_scripts\utility::play_sound_in_space("russian_sub_missile_door", var_18.origin);
      break;
    case "sub_missile_launch":
      var_19 = var_1;
      wait 1;
      thread common_scripts\utility::play_sound_in_space("russian_sub_missile_launch", var_19.origin);
      thread common_scripts\utility::play_sound_in_space("russian_sub_rocket_launch", var_19.origin);
      aud_stop_city_combat_ambi();
      break;
    case "spawn_f15_fighters_7_8":
      maps\_audio::aud_play_2d_sound("skybattle_f15_flyby_7_8_front");
      level.aud.exit_control_room_to_zodiac = 1;
      common_scripts\utility::flag_set("leaving_sub");
      common_scripts\utility::flag_clear("aud_flag_inside_sub");
      maps\_audio_mix_manager::mm_add_submix("nyhb_pre_board_zodiac");
      thread aud_start_subtop_line_emitters();
      aud_play_city_combat_ambi();
      level.aud.sub_stress_chance = 0;
      break;
    case "spawn_f15_fighters_1_2":
      var_20 = var_1;

      if(isDefined(var_20)) {
        thread aud_air_vehicle_flyby(var_20, "skybattle_f15_flyby_1", 10000);
      }
      break;
    case "spawn_f15_fighters_3_4":
      var_20 = var_1;

      if(isDefined(var_20)) {
        thread aud_air_vehicle_flyby(var_20, "skybattle_f15_flyby_3", 12000);
      }
      break;
    case "spawn_ship_squeeze_hind":
      var_21 = var_1;

      if(isDefined(var_21)) {
        thread aud_air_vehicle_flyby(var_21, "skybattle_hind_flyby_1", 800);
      }
      break;
    case "tomahawk_the_hind":
      var_19 = var_1;

      if(isDefined(var_19)) {
        var_22 = spawn("script_origin", var_19.origin);
        var_22 linkTo(var_19);
        var_22 playSound("skybattle_missile_overhead", "sounddone");
        var_22 waittill("sounddone");
        wait 0.1;
        var_22 delete();
      }

      break;
    case "spawn_f15_fighter_5":
      var_20 = var_1;

      if(isDefined(var_20)) {
        thread aud_air_vehicle_flyby(var_20, "skybattle_f15_flyby_5", 900);
      }
      break;
    case "spawn_f15_fighter_6":
      var_20 = var_1;

      if(isDefined(var_20)) {
        thread aud_air_vehicle_flyby(var_20, "skybattle_f15_flyby_6", 1000);
      }
      break;
    case "dvora_1":
      var_23 = var_1;

      if(isDefined(var_23)) {
        var_23 playSound("harb_patrol_boat_by_first");
        thread aud_patrol_boats_post_indiana_jones(var_23);
      }

      wait 1.5;
      level.player playSound("harb_patrol_boat_bullet_whizbys");
      break;
    case "dvora_2":
      var_23 = var_1;
      break;
    case "slow_mo_dvora":
      var_23 = var_1;
      var_23 playSound("harb_patrol_boat_post_slow");
      break;
    case "dvora_4":
      var_23 = var_1;
      break;
    case "waterbarrage_inc_normal":
      var_24 = var_1;
      thread aud_zodiac_impacts_incoming_normal(var_24);
      break;
    case "waterbarrage_inc_lateral":
      var_24 = var_1;
      thread aud_zodiac_impacts_incoming_lateral(var_24);
      break;
    case "zodiac_water_impacts":
      var_10 = var_1;
      thread aud_zodiac_water_impacts(var_10);
      break;
    case "zodiac_water_impacts_lateral":
      var_10 = var_1;
      thread aud_zodiac_water_impacts_lateral(var_10);
      break;
    case "explode_wave":
      var_25 = var_1;
      var_25 playSound("water_crash_med_close");
      var_25 playSound("water_splats_close");
      break;
    case "zodiac_sway_left_light":
      if(!common_scripts\utility::flag("aud_player_zodiac_in_chinook")) {
        var_26 = gettime();

        if(var_26 > level.aud.next_zodiac_splash_time) {
          level.player playSound("zodiac_turn_splash_left");
          level.aud.next_zodiac_splash_time = var_26 + randomintrange(level.aud.zodiac_splash_rate_min, level.aud.zodiac_splash_rate_max);
        }
      }

      break;
    case "zodiac_sway_right_light":
      if(!common_scripts\utility::flag("aud_player_zodiac_in_chinook")) {
        var_26 = gettime();

        if(var_26 > level.aud.next_zodiac_splash_time) {
          level.player playSound("zodiac_turn_splash_right");
          level.aud.next_zodiac_splash_time = var_26 + randomintrange(level.aud.zodiac_splash_rate_min, level.aud.zodiac_splash_rate_max);
        }
      }

      break;
    case "zodiac_sway_left":
      if(!common_scripts\utility::flag("aud_player_zodiac_in_chinook")) {
        var_26 = gettime();

        if(var_26 > level.aud.next_zodiac_splash_time) {
          level.player playSound("zodiac_turn_splash_left");
          level.aud.next_zodiac_splash_time = var_26 + randomintrange(level.aud.zodiac_splash_rate_min, level.aud.zodiac_splash_rate_max);
        }
      }

      break;
    case "zodiac_sway_right":
      if(!common_scripts\utility::flag("aud_player_zodiac_in_chinook")) {
        var_26 = gettime();

        if(var_26 > level.aud.next_zodiac_splash_time) {
          level.player playSound("zodiac_turn_splash_right");
          level.aud.next_zodiac_splash_time = var_26 + randomintrange(level.aud.zodiac_splash_rate_min, level.aud.zodiac_splash_rate_max);
        }
      }

      break;
    case "big_missile_launch_1":
      var_19 = var_1;
      wait 0.5;

      if(isDefined(var_19)) {
        var_27 = spawn("script_origin", var_19.origin);
        var_27 linkTo(var_19);
        var_27 playSound("missile_boat_travel_1", "sounddone");
        common_scripts\utility::flag_wait("big_missile0_landed");
        var_27 scalevolume(0.0, 0.1);
        wait 0.2;
        var_27 stopsounds();
        var_27 delete();
      }

      break;
    case "big_ship_missile_hit":
      level.player playSound("missile_big_boat_explo");
      level.player playSound("missile_big_boat_explo_metal");
      wait 0.5;
      level.player playSound("missile_big_boat_groan");
      wait 0.5;
      common_scripts\utility::flag_set("aud_big_ship_missile_explo");
      break;
    case "big_missile_launch_2":
      var_19 = var_1;
      wait 0.4;
      thread maps\_audio::aud_playsound_attach("missile_boat_launch_2", level.player);
      wait 1.0;

      if(isDefined(var_19)) {
        var_27 = spawn("script_origin", var_19.origin);
        var_27 linkTo(var_19);
        var_27 playSound("missile_boat_travel_2", "sounddone");
        var_27 waittill("sounddone");
        wait 0.1;
        var_27 delete();
      }

      break;
    case "incoming_missile_to_boat":
      var_19 = var_1;

      if(isDefined(var_19)) {
        wait 2.8;
        level.player playSound("missile_boat_incoming");
      }

      break;
    case "little_ship_missile_hit":
      if(!common_scripts\utility::flag("aud_player_zodiac_in_chinook")) {
        var_10 = var_1;

        if(isDefined(var_10)) {
          if(common_scripts\utility::flag("aud_big_ship_missile_explo")) {
            maps\_audio::aud_play_2d_sound("missile_boat_explo");
            maps\_audio::aud_play_2d_sound("missile_boat_explo_lfe");
          }

          wait 0.6;
          thread common_scripts\utility::play_sound_in_space("crashing_waves", var_10);
          thread common_scripts\utility::play_sound_in_space("water_splats_close", var_10);
          wait 0.5;
          var_28 = distance2d(level.player.origin, var_10);

          if(var_28 < 2500) {
            wait 0.4;
            thread common_scripts\utility::play_sound_in_space("water_splats_2d", level.player.origin);
          }
        }
      }

      break;
    case "zodiac_landed_big":
      level.player playSound("zodiac_land_big_splash");
      level.player playSound("zodiac_land_big_splats_2d");
      level.player playSound("zodiac_land_big_collision");
      break;
    case "zodiac_landed":
      level.player playSound("burya_destroy_splash");
      level.player playSound("water_splats_2d");
      level.player playSound("zodiac_player_collision");
      break;
    case "missile_launch":
      var_19 = var_1;
      break;
    case "pre_slo_mo_splash":
      level.player playSound("water_crash_med_close_2d");
      thread maps\_audio_mix_manager::mm_start_preset("nyhb_boat_slowmo", 1.5);
      level.player playSound("boat_slowmo_start");
      maps\_audio_stream_manager::sm_start_preset("boat_slowmo_bed_front", 4);
      break;
    case "start_carrier_slowmotion":
      music_cue("mus_start_carrier_slowmotion");
      break;
    case "slowmo_dvora_destroyed":
      thread maps\_audio::aud_stop_slow_mo_gunshot_callback();
      maps\_audio::aud_play_2d_sound("boat_slowmo_fireball");
      maps\_audio::aud_play_2d_sound("boat_slowmo_explode_sweet");
      var_29 = spawn("script_origin", level.player.origin);
      var_29 playSound("boat_slowmo_explode");
      common_scripts\utility::flag_wait("aud_boat_slowmo_outro");
      maps\_audio_stream_manager::sm_stop_ambience(0);
      wait 1;
      var_29 scalevolume(0.0, 0.5);
      wait 1.0;
      var_29 stopsounds();
      var_29 delete();
      break;
    case "boat_slowmo_outro":
      common_scripts\utility::flag_set("aud_boat_slowmo_outro");
      level.player playSound("boat_slowmo_outro");
      wait 1.1;
      level.player playSound("boat_slowmo_splash_lrg");
      level.player playSound("boat_slowmo_tumble");
      wait 0.2;
      level.player playSound("boat_slowmo_end");
      maps\_audio_mix_manager::mm_clear_submix("nyhb_boat_slowmo", 3.0);
      break;
    case "stop_carrier_slowmotion":
      level.escape_zodiac maps\_audio_vehicles::vm_set_range("speed", 0, 65);
      music_cue("mus_stop_carrier_slowmotion");
      break;
    case "boat_slowmo_final_splash":
      break;
    case "dvora_post_carrier_splashes":
      var_30 = var_1;
      thread common_scripts\utility::play_sound_in_space("post_slow_splats_close", var_30);
      thread common_scripts\utility::play_sound_in_space("post_dvora_spash_impacts", var_30);
      thread common_scripts\utility::play_sound_in_space("post_slow_water_splash_lrg", var_30);
      break;
    case "spawn_hind_flyby_5":
      var_21 = var_1;

      if(isDefined(var_21)) {
        thread aud_air_vehicle_flyby(var_21, "skybattle_hind_flyby_2", 4500);
      }
      break;
    case "spawn_hind_flyby_6":
      var_21 = var_1;

      if(isDefined(var_21)) {
        thread aud_air_vehicle_flyby(var_21, "skybattle_hind_flyby_3", 3000);
      }
      break;
    case "spawn_flyby_chinook_left":
      var_31 = var_1;

      if(isDefined(var_31)) {
        thread aud_air_vehicle_flyby(var_31, "chinook_flyby_1", 4500);
      }
      break;
    case "spawn_flyby_chinook_right":
      wait 2;
      level.player playSound("chinook_flyby_rears");
      break;
    case "show_exit_chinook":
      break;
    case "start_zodiac_into_chinook":
      common_scripts\utility::flag_set("aud_player_zodiac_in_chinook");
      wait 1.0;
      level.player playSound("zodoac_to_chinook_splash");
      common_scripts\utility::flag_wait("send_off_second_chinook");
      break;
    case "chinook_finale_escape":
      thread aud_zodiac_into_chinook();
      wait 3.4;
      level.player playSound("chinook_liftoff_fronts");
      break;
    case "spawn_f15_fighters_finale":
      wait 2.3;
      thread maps\_audio_mix_manager::mm_start_preset("nyhb_final_flyby", 0.5);
      level.player playSound("f15_final_flyby_fronts");
      break;
    case "fx_skybox_mig":
      if(!common_scripts\utility::flag("aud_flag_inside_sub") && !common_scripts\utility::flag("player_on_boat")) {
        var_32 = var_1[0];
        var_33 = var_1[1];
        var_34 = var_1[2];
        var_35 = distance(level.player.origin, var_32) / 36;

        if(!isDefined(level.aud.mig_count)) {
          level.aud.mig_count = 0;
        }
        if(level.aud.mig_count < 3 && var_35 < 1000000) {
          level.aud.mig_count++;
          var_36 = spawn("script_origin", var_32);
          aud_play_skybattle_dist_jet(var_36, var_33, var_34);
          var_36 scalevolume(0.0, 0.5);
          wait 0.5;
          var_36 delete();
          level.aud.mig_count--;
        }
      }

      break;
    case "fx_skybox_hind":
      break;
    case "hind_spawned":
      if(!isDefined(level.aud.skybattle_hind_playing)) {
        level.aud.skybattle_hind_playing = 1;
        wait 5;
        var_36 = var_1;
        var_36 playLoopSound("skybattle_hind_loop");

        while(isDefined(var_36)) {
          wait 0.25;
        }
        level.aud.skybattle_hind_playing = undefined;
      }

      break;
    case "chinook_spawned":
      if(!isDefined(level.aud.skybattle_chinook_playing)) {
        level.aud.skybattle_chinook_playing = 1;
        wait 8;
        var_36 = var_1;
        var_36 playLoopSound("skybattle_chinook_loop");

        while(isDefined(var_36)) {
          wait 0.25;
        }
        level.aud.skybattle_chinook_playing = undefined;
      }

      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

music_cue(var_0, var_1) {
  thread music_msg_handler(var_0, var_1);
}

music_msg_handler(var_0, var_1) {
  var_2 = 1;

  if(getsubstr(var_0, 0, 4) != "mus_") {
    return 0;
  }
  level notify("kill_other_music");
  level endon("kill_other_music");

  switch (var_0) {
    case "mus_intro":
      wait 5;
      maps\_audio_music::mus_play("harb_intro");
      break;
    case "mus_sub_passby":
      break;
    case "mus_sub_breach_checkpoint":
      maps\_audio::aud_set_music_submix(0, 0.05);
      wait 0.05;
      maps\_audio_music::mus_play("harb_board_sub", 4);
      maps\_audio::aud_set_music_submix(1.0, 6);
      break;
    case "mus_drone_E":
      maps\_audio_music::mus_play("harb_drone_E", 1);
      break;
    case "mus_fist_building_explodes":
      maps\_audio_music::mus_stop(3);
      wait 10;
      maps\_audio_music::mus_play("harb_board_sub", 4);
      maps\_audio::aud_set_music_submix(1.0, 6);
      break;
    case "mus_enter_sub":
      maps\_audio_music::mus_stop(10);
      break;
    case "mus_sub_combat_begin":
      wait 7;
      maps\_audio_music::mus_play("harb_sub_combat1", 0.2, 3);
      break;
    case "mus_sub_interior_flooded":
      maps\_audio_music::mus_stop(16);
      break;
    case "mus_sub_scuttle_announcement":
      wait 1;
      maps\_audio_music::mus_play("harb_sub_combat2", 0.1, 0.25);
      wait 25;
      maps\_audio_music::mus_play("harb_sub_combat3", 6);
      break;
    case "mus_e3_demo_fade_in":
      maps\_audio_music::mus_play("harb_sub_combat3", 2);
      break;
    case "mus_bridge_breach_setup":
      maps\_audio::aud_set_music_submix(0.6, 8);
      break;
    case "mus_sub_door_breach":
      maps\_audio_music::mus_stop(1.5);
      wait 2;
      maps\_audio::aud_set_music_submix(1, 1);
      break;
    case "mus_sub_combat_end":
      break;
    case "mus_program_launch":
      maps\_audio_music::mus_play("harb_program_launch", 3);
      break;
    case "mus_to_the_zodiac":
      maps\_audio_music::mus_play("harb_to_the_zodiac", 0.2, 3);
      maps\_audio::aud_set_music_submix(10, 0.1);
      break;
    case "mus_zodiac_ride":
      maps\_audio_music::mus_play("harb_zodiac_ride", 0, 3);
      maps\_audio::aud_set_music_submix(1, 0.1);
      break;
    case "mus_start_carrier_slowmotion":
      maps\_audio::aud_set_music_submix(0, 5);
      break;
    case "mus_stop_carrier_slowmotion":
      maps\_audio::aud_set_music_submix(1, 3);
      break;
    case "mus_theres_our_bird":
      wait 2.5;
      maps\_audio_mix_manager::mm_add_submix("nyhb_theres_our_bird", 2);
      maps\_audio_music::mus_play("harb_theres_our_bird", 0, 4);
      wait 6;
      maps\_audio_mix_manager::mm_clear_submix("nyhb_theres_our_bird", 2);
      break;
    case "mus_finale":
      maps\_audio::aud_set_music_submix(10.0, 4);
      maps\_audio_music::mus_play("harb_finale", 4);
      wait 15;
      maps\_audio::aud_set_music_submix(1.0, 4);
      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

aud_prime_city_combat_ambi() {
  level.aud.city_amb_ent_l = thread maps\_audio::aud_prime_point_source_loop("amb_harb_dist_city_combat_L", (-24370, -1271, 0));
  level.aud.city_amb_ent_r = thread maps\_audio::aud_prime_point_source_loop("amb_harb_dist_city_combat_R", (-1441, -20956, 0));
}

aud_play_primed_city_combat_ambi() {
  if(isDefined(level.aud.city_amb_ent_l)) {
    level.aud.city_amb_ent_l thread maps\_audio::aud_play_primed_point_source_loop("amb_harb_dist_city_combat_L", 1.0, 0.25);
    level.aud.city_amb_ent_r thread maps\_audio::aud_play_primed_point_source_loop("amb_harb_dist_city_combat_R", 1.0, 0.25);
  }
}

aud_play_city_combat_ambi() {
  if(!(isDefined(level.aud.city_amb_ent_l) && isDefined(level.aud.city_amb_ent_r)) || !(level.aud.city_amb_ent_l maps\_audio::aud_is_stream_primed("amb_harb_dist_city_combat_L") && level.aud.city_amb_ent_r maps\_audio::aud_is_stream_primed("amb_harb_dist_city_combat_R"))) {
    aud_prime_city_combat_ambi();

    while(!(level.aud.city_amb_ent_l maps\_audio::aud_is_stream_primed("amb_harb_dist_city_combat_L") && level.aud.city_amb_ent_r maps\_audio::aud_is_stream_primed("amb_harb_dist_city_combat_R"))) {
      wait 0.05;
    }
  }

  if(isDefined(level.aud.city_amb_ent_l) && isDefined(level.aud.city_amb_ent_r)) {
    level.aud.city_amb_ent_l maps\_audio::aud_error_if_not_primed("amb_harb_dist_city_combat_L");
    level.aud.city_amb_ent_r maps\_audio::aud_error_if_not_primed("amb_harb_dist_city_combat_R");
    level.aud.city_amb_ent_l thread maps\_audio::aud_play_primed_point_source_loop("amb_harb_dist_city_combat_L", 1.0, 0.25);
    level.aud.city_amb_ent_r thread maps\_audio::aud_play_primed_point_source_loop("amb_harb_dist_city_combat_R", 1.0, 0.25);
  }
}

aud_stop_city_combat_ambi() {
  if(isDefined(level.aud.city_amb_ent_l)) {
    maps\_audio::aud_stop_point_source_loop(level.aud.city_amb_ent_l, 0.1);
    maps\_audio::aud_stop_point_source_loop(level.aud.city_amb_ent_r, 0.1);
    level.aud.city_amb_ent_l = undefined;
    level.aud.city_amb_ent_r = undefined;
  }
}

aud_gate_cut_start() {
  wait 3;
  level.player playSound("scn_gate_cut_tube_drone");
  var_0 = spawn("script_origin", level.player.origin);
  wait 7;
  var_0 playLoopSound("scn_gate_cut_weld_lp");
  var_0 scalevolume(0.0, 0.05);
  wait 0.1;
  var_0 scalevolume(1.0, 9.0);
  wait 15.5;
  var_0 scalevolume(0.0, 0.3);
  wait 3;
  var_0 delete();
}

aud_torch_flash() {
  if(!common_scripts\utility::flag("aud_first_spark_played")) {
    level.player playSound("scn_gate_cut_spark_02");
    common_scripts\utility::flag_set("aud_first_spark_played");
    common_scripts\utility::flag_set("aud_second_spark");
  } else if(common_scripts\utility::flag("aud_second_spark")) {
    level.player playSound("scn_gate_cut_spark_03");
    common_scripts\utility::flag_clear("aud_second_spark");
    common_scripts\utility::flag_set("aud_third_spark");
  } else if(common_scripts\utility::flag("aud_third_spark")) {
    level.player playSound("scn_gate_cut_spark_03");
  }
}

aud_sdv_scuba_bubbles() {
  if(common_scripts\utility::flag("aud_flag_player_underwater")) {
    level.player playSound("nyhb_scuba_breathe_player_bubbles");
    wait 3.5;
  }

  if(common_scripts\utility::flag("aud_flag_scubamask_on_player")) {
    level.player playSound("nyhb_scuba_breaths");
  }
}

aud_player_scuba_bubbles() {
  if(common_scripts\utility::flag("aud_flag_player_underwater")) {
    level.player playSound("nyhb_scuba_breathe_player_bubbles");
    wait 3.5;
  }

  if(common_scripts\utility::flag("aud_flag_scubamask_on_player")) {
    level.player playSound("nyhb_scuba_breaths");
  }
}

aud_battleship_sink(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];
  var_1 thread aud_play_sink_impact_stop(var_2);
  var_4 = 4500;
  var_5 = 4500;
  var_6 = 1500;

  for(;;) {
    level endon("aud_end_ship_sink");
    var_7 = distance(level.player.origin, var_1.origin);
    wait 0.2;

    if(var_4 > var_7) {
      var_1 playSound("harb_battleship_sink");

      for(;;) {
        level endon("aud_end_ship_sink");
        var_7 = distance(level.player.origin, var_1.origin);
        var_8 = maps\_audio::aud_map_range(var_7, var_6, var_5, level.aud.envs["aud_battleship_sink"]);
        var_1 scalevolume(var_8, 0.1);
        wait 0.2;

        if(common_scripts\utility::flag("aud_sink_impact_done")) {
          var_1 scalevolume(0.0, 5.0);
          wait 5.2;
          var_1 stopsounds();
          common_scripts\utility::flag_set("aud_end_ship_sink");
        }
      }
    }
  }
}

aud_debris_splashes_underwater() {
  wait 0.6;
  level.player playSound("harb_battleship_sink_uw_splash");
  wait 1;
  level.player playSound("harb_battleship_sink_uw_splash");
  wait 0.5;
  level.player playSound("harb_battleship_sink_uw_splash");
  wait 0.6;
  level.player playSound("harb_battleship_sink_uw_splash");
  wait 1;
  level.player playSound("harb_battleship_sink_uw_splash");
}

aud_play_sink_impact_stop(var_0) {
  wait(var_0);
  thread common_scripts\utility::play_sound_in_space("harb_battleship_sink_impact_stop_01", self.origin);
  thread maps\_audio_mix_manager::mm_clear_submix("nyhb_battleship_sink", 2.5);
  common_scripts\utility::flag_set("aud_sink_impact_done");
}

aud_play_sink_loops(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", self.origin);
  var_3 linkTo(self);
  var_4 = randomintrange(5, 15);
  wait(var_0);
  var_3 playLoopSound("harb_battleship_sink_bubbles_post");
  common_scripts\utility::flag_wait("aud_end_ship_sink");
  var_3 scalevolume(0.0, 4.0);
  wait 5;
  var_3 stopsounds();
  wait 0.2;
  var_3 delete();
}

aud_battle_bubbles() {
  common_scripts\utility::flag_wait("aud_sink_impact_done");
  var_0 = spawn("script_origin", (-25538, -19991, -676));
  var_1 = spawn("script_origin", (-25157, -19391, -484));
  var_2 = spawn("script_origin", (-25157, -19391, -484));
  var_3 = spawn("script_origin", (-25993, -19981, -1023));
  var_0 playLoopSound("harb_battleship_sink_bubbles_post");
  var_0 scalevolume(0.0, 0.05);
  wait 0.25;
  var_1 playLoopSound("harb_battleship_sink_bubbles");
  var_1 scalevolume(0.0, 0.05);
  wait 0.25;
  var_2 playLoopSound("harb_battleship_sink_bubbles_post");
  var_2 scalevolume(0.0, 0.05);
  wait 0.25;
  var_3 playLoopSound("harb_battleship_sink_bubbles");
  var_3 scalevolume(0.0, 0.05);
  var_0 scalevolume(1.0, 0.2);
  var_1 scalevolume(1.0, 0.2);
  var_2 scalevolume(1.0, 0.2);
  var_3 scalevolume(1.0, 0.2);
  common_scripts\utility::flag_wait("aud_kill_ship_residuals");
  var_0 scalevolume(0.0, 0.3);
  var_1 scalevolume(0.0, 0.3);
  var_2 scalevolume(0.0, 0.3);
  var_3 scalevolume(0.0, 0.3);
  wait 0.4;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

aud_ignore_slowmo() {
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("music", 0);
  soundsettimescalefactor("local", 0.25);
  soundsettimescalefactor("local3", 0.25);
  soundsettimescalefactor("weapon", 0.15);
  soundsettimescalefactor("grondo2d", 0);
  soundsettimescalefactor("bulletimpact", 0);
  soundsettimescalefactor("bulletflesh1", 0);
  soundsettimescalefactor("bulletflesh2", 0);
  soundsettimescalefactor("bulletwhizby", 0);
}

aud_door_breach_slomo() {
  thread maps\_audio::aud_start_slow_mo_gunshot_callback(::aud_play_harb_door_breach_gunshot, ::aud_play_harb_door_breach_impact);
  thread maps\_audio_mix_manager::mm_clear_submix("pre_bridge_breach", 0.05);
  thread maps\_audio_mix_manager::mm_add_submix("sub_door_breach", 0.05);
  thread maps\_audio_zone_manager::azm_start_zone("nyhb_breach_slomo", 0.05);
  var_0 = spawn("script_origin", level.player.origin);
  var_1 = spawn("script_origin", level.player.origin);
  var_0 playLoopSound("surreal_hi_lp");
  var_1 playLoopSound("surreal_lo_lp");
  common_scripts\utility::flag_wait("aud_door_slowmo_exit");
  thread maps\_audio::aud_stop_slow_mo_gunshot_callback();
  thread maps\_audio_mix_manager::mm_clear_submix("sub_door_breach", 0.3);
  level.player playSound("db_fast_forward");
  wait 0.5;
  thread maps\_audio_zone_manager::azm_start_zone("nyhb_sub_interior_controlroom", 1.5);
  var_0 scalevolume(0.0, 0.1);
  var_1 scalevolume(0.0, 0.1);
  wait 0.15;
  var_1 delete();
  var_0 delete();
}

aud_player_exit_slomo() {
  common_scripts\utility::flag_set("aud_door_slowmo_exit");
}

aud_overhead_missiles() {
  var_0 = spawn("script_origin", level.player.origin);
  var_1 = spawn("script_origin", level.player.origin);
  wait 0.3;
  var_0 playSound("harb_surface_missile_incoming_ext");
  wait 1;
  level.player playSound("harb_surface_missile_overhead");
  var_0 scalevolume(0.0, 1.2);
  wait 0.55;
  level.player playSound("harb_surface_missile_overhead_lo");
  wait 0.35;
  var_1 playSound("harb_overhead_missiles_tail");
  wait 0.05;
  var_1 scalevolume(1.0, 1);
  common_scripts\utility::flag_wait("aud_building_exploded");
  var_1 scalevolume(0.0, 0.3);
  wait 0.75;
  var_1 delete();
  var_0 delete();
}

aud_building_explode() {
  common_scripts\utility::flag_set("aud_building_exploded");
  level.player playSound("harb_missile_dist_city_explo_02");
}

aud_building_explode_02() {
  common_scripts\utility::flag_set("aud_building_02_exploded");
  common_scripts\utility::play_sound_in_space("harb_missile_dist_city_explo_02", (-38106, -16892, 2417));
}

aud_start_subtop_line_emitters() {
  thread maps\_audio::aud_play_line_emitter("sub_waves_right", "sub_surfaced_side_water_close_lp", (-40261, -24354, -130), (-35223, -24524, -130), 1.0, 2.0);
  thread maps\_audio::aud_play_line_emitter("sub_waves_right_lyr", "sub_surfaced_churn_lyr_lp", (-40261, -24354, -130), (-35223, -24524, -130), 1.0, 2.0);
  thread maps\_audio::aud_play_line_emitter("sub_waves_left", "sub_surfaced_side_water_close_lp", (-40254, -23394, -130), (-35165, -23366, -130), 1.0, 2.0);
  thread maps\_audio::aud_play_line_emitter("sub_waves_left_lyr", "sub_surfaced_churn_lyr_lp", (-40254, -23394, -130), (-35165, -23366, -130), 1.0, 2.0);
  common_scripts\utility::flag_wait("stop_line_emitters");
  level notify("sub_waves_right_line_emitter_stop");
  level notify("sub_waves_right_lyr_line_emitter_stop");
  level notify("sub_waves_left_line_emitter_stop");
  level notify("sub_waves_left_lyr_line_emitter_stop");
  wait 0.05;
  common_scripts\utility::flag_clear("stop_line_emitters");
}

aud_steam_emitters() {
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-39450, -23922, -308), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-39367, -23762, -311), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-39154, -23918, -311), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-38801, -23701, -385), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-38912, -23853, -332), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-38914, -23729, -332), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-38508, -24115, -557), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-38506, -23916, -487), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-38394, -23595, -547), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-38273, -23678, -479), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37772, -23810, -418), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37300, -23717, -453), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37048, -23715, -465), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37128, -23984, -427), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37387, -23994, -432), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37348, -24006, -444), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37382, -23896, -454), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37487, -23800, -430), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-37387, -23897, -435), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36485, -23720, -431), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36284, -23847, -434), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36482, -23992, -423), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36651, -23991, -439), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36169, -23706, -235), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36529, -23637, -219), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36386, -24069, -221), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-36564, -24065, -218), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-35722, -24071, -209), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-35496, -23919, -204), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-35548, -23829, -206), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_med_steam_lp_01", (-35913, -23651, -212), 1);
}

aud_machinery_emitters() {
  common_scripts\utility::loop_fx_sound("sub_emt_engine_turbine_01", (-39342, -23987, -396), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_engine_turbine_02", (-39308, -23722, -360), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_turbine_diesel_01", (-39342, -23987, -396), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_turbine_diesel_02", (-39308, -23722, -360), 1);
}

aud_electric_breakerboxes() {
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-37693, -23667, -414), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-39101, -23686, -370), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-39134, -23667, -341), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-37512, -23640, -409), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-36837, -24082, -415), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-36387, -24072, -270), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-35921, -24087, -251), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-35467, -24057, -228), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-35877, -23623, -253), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_electric_hum", (-35466, -23677, -224), 1);
}

aud_sub_computers() {
  common_scripts\utility::loop_fx_sound("sub_emt_comp_med_on_01", (-36807, -23594, -249), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle", (-37751, -23638, -417), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_large_on", (-37410, -23627, -353), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle_02", (-37210, -24081, -363), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle", (-37278, -23634, -387), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle", (-36556, -24077, -258), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle_02", (-36967, -24077, -280), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle", (-36697, -24077, -282), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle_02", (-36529, -23638, -282), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_large_on", (-37086, -24076, -264), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_med_idle", (-37092, -24078, -282), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_med_idle", (-36834, -23893, -264), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_med_on_01", (-36834, -23893, -265), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle_02", (-37028, -23561, -387), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle", (-37099, -24083, -358), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle", (-36907, -24083, -358), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_small_idle", (-36087, -24154, -358), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_med_on_01", (-35831, -24081, -253), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_med_on_02", (-35656, -24071, -249), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_comp_large_on", (-35825, -23642, -240), 1);
}

aud_floodroom_water() {
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38532, -24093, -574), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38494, -23921, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38490, -23798, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38477, -23647, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38357, -23649, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38245, -23654, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38123, -23674, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38126, -23796, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38127, -23901, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38117, -24056, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38228, -24049, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-38345, -24048, -569), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_water_flooding_large_lp", (-37982, -24036, -566), 1);
}

aud_reactor_computers() {
  wait 4;
  common_scripts\utility::play_loopsound_in_space("sub_emt_comp_med_on_02", (-37642, -23797, -433));
  common_scripts\utility::play_loopsound_in_space("sub_emt_comp_med_on_01", (-37639, -23938, -441));
}

aud_controlroom_lights() {
  common_scripts\utility::loop_fx_sound("emt_light_fluorescent_hum_harb", (-35789, -24027, -205), 1);
  common_scripts\utility::loop_fx_sound("emt_light_fluorescent_hum_harb", (-35625, -24026, -211), 1);
  common_scripts\utility::loop_fx_sound("emt_light_fluorescent_hum_harb", (-35608, -23701, -210), 1);
  common_scripts\utility::loop_fx_sound("emt_light_fluorescent_hum_harb", (-35808, -23703, -210), 1);
}

aud_steamy_vents() {
  common_scripts\utility::loop_fx_sound("sub_emt_vent_steamy", (-39241, -23751, -431), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_vent_steamy", (-39384, -23749, -428), 1);
}

aud_siren_first() {
  wait 1;
  var_0 = spawn("script_origin", (-38895, -23724, -360));
  var_0 playLoopSound("sub_emt_small_alarm_01_intro");
  wait 0.1;
  var_0 scalevolume(0.0, 0.05);
  var_1 = spawn("script_origin", (-38895, -23724, -360));
  var_1 playLoopSound("sub_emt_small_alarm_01_intro_occ");
  level waittill("aud_bulkhead_door_open");
  wait 7.0;
  var_0 scalevolume(1.0, 1.0);
  var_1 scalevolume(0.0, 1.0);
}

aud_scuttle_alarms_start() {
  var_0 = spawn("script_origin", (-37770, -23772, -348));
  var_0 playLoopSound("sub_emt_alarm_01_tight");
  var_1 = spawn("script_origin", (-37207, -23853, -192));
  var_1 playLoopSound("sub_emt_large_alarm_01");
  var_2 = spawn("script_origin", (-36470, -23856, -192));
  var_2 playLoopSound("sub_emt_alarm_01_reactor");
  common_scripts\utility::flag_wait("player_on_boat");
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

aud_control_room_alarms() {
  common_scripts\utility::loop_fx_sound("sub_emt_small_alarm_02", (-35865, -23727, -238), 1);
  var_0 = spawn("script_origin", (-35755, -23879, -234));
  var_0 playLoopSound("sub_emt_small_alarm_01");
  common_scripts\utility::flag_wait("leaving_sub");
  var_0 scalevolume(0.0, 1.0);
  wait 1.0;
  var_0 delete();
}

aud_start_missilekeytoss(var_0, var_1) {
  wait 8.5;
  common_scripts\utility::play_loopsound_in_space("harb_emt_missilekeytoss_alarm", (-35545, -23648, -261));
}

aud_flooded_waterfalls() {
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_flooded", (-38491, -24081, -557), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_flooded", (-38136, -23636, -520), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_flooded", (-36099, -23717, -313), 1);
}

aud_sub_waterfalls() {
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_splatter_large", (-37052, -23603, -422), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_splatter_large", (-36126, -23685, -431), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_splatter_small", (-36147, -23610, -423), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_splatter_large", (-36619, -24058, -434), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_splatter_large", (-36048, -23886, -439), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_pipe", (-36622, -24035, -242), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_pipe", (-36112, -23656, -242), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_waterfall_pipe", (-36143, -23578, -241), 1);
}

aud_controlroom_radios() {
  common_scripts\utility::loop_fx_sound("sub_emt_rus_radio_01", (-35548, -24070, -245), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_rus_radio_02", (-35500, -23653, -250), 1);
  common_scripts\utility::loop_fx_sound("sub_emt_rus_radio_02", (-35805, -23652, -250), 1);
}

aud_fires() {
  common_scripts\utility::loop_fx_sound("harb_emt_fire_metal_large", (-38541, -23707, -520));
  common_scripts\utility::loop_fx_sound("harb_emt_fire_metal_small", (-39485, -23872, -400), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_fire_metal_small", (-39397, -23885, -400), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_fire_metal_small", (-39465, -23809, -400), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_fire_electrical_small", (-35506, -23630, -224), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_fire_electrical_small", (-35552, -24066, -224), 1);
}

aud_uw_bubbles() {
  common_scripts\utility::loop_fx_sound("harb_emt_uw_bubbles", (-16391, -24217, -1626), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_uw_bubbles", (-16912, -23948, -1638), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_uw_bubbles", (-17111, -23671, -1638), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_uw_bubbles", (-17730, -23752, -1686), 1);
  common_scripts\utility::loop_fx_sound("harb_emt_uw_bubbles", (-19143, -23864, -1715), 1);
}

aud_velocity_emitters() {
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-22365, -18856, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-22581, -19179, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-21995, -19050, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-22208, -19422, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-21775, -19481, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-21300, -19519, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-20937, -19757, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-20548, -20024, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-20209, -20237, -171), 1);
  common_scripts\utility::loop_fx_sound("peer_velo_whoosh", (-19859, -20482, -171), 1);
}

aud_zodiac_impacts_incoming_normal(var_0) {
  var_1 = spawn("script_origin", level.player.origin);
  var_1 playSound("harb_incoming_mortars");
  wait(var_0);
  var_1 scalevolume(0.0, 0.1);
  wait 0.5;
  var_1 delete();
}

aud_zodiac_impacts_incoming_lateral(var_0) {
  var_1 = spawn("script_origin", level.player.origin);
  var_1 playSound("harb_incoming_mortars");
  wait(var_0);
  var_1 scalevolume(0.0, 0.1);
  wait 0.5;
  var_1 delete();
}

aud_zodiac_water_impacts(var_0) {
  thread common_scripts\utility::play_sound_in_space("cannonball_water_explode", var_0);
  thread common_scripts\utility::play_sound_in_space("cannonball_impact_2d", var_0);
  wait 0.4;
  thread common_scripts\utility::play_sound_in_space("cannonball_water_splats_2d", var_0);
  thread common_scripts\utility::play_sound_in_space("cannonball_waves_spray_2d", var_0);
}

aud_zodiac_water_impacts_lateral(var_0) {
  thread common_scripts\utility::play_sound_in_space("cannonball_water_explode", var_0);
  thread common_scripts\utility::play_sound_in_space("cannonball_impact_2d", var_0);
  wait 0.4;
  thread common_scripts\utility::play_sound_in_space("cannonball_water_splats_2d", var_0);
  thread common_scripts\utility::play_sound_in_space("cannonball_waves_spray_2d", var_0);
}

aud_patrol_boats_post_indiana_jones(var_0) {
  common_scripts\utility::flag_wait("zubrs_destroyers");
  wait 2;
  var_0 playSound("harb_patrol_boat_by_last");
}

aud_sub_destroy() {
  wait 10;
  level.player playSound("harb_sub_explosion_front");
}

aud_harbor_surface_water_sfx() {
  common_scripts\utility::play_loopsound_in_space("water_splats_lp_3d", (-31949, -11607, -161));
  common_scripts\utility::play_loopsound_in_space("waterfall_lp_layer_02", (-31949, -11607, -161));
  common_scripts\utility::play_loopsound_in_space("waves_crashing_close_lp", (-31130, -14502, -153));
}

aud_zodiac_jump() {
  common_scripts\utility::flag_wait("player_zodiac_jump_ramp");

  if(isDefined(level.escape_zodiac)) {
    var_0 = level.escape_zodiac vehicle_getspeed();

    if(var_0 > 9.16667) {
      maps\_audio_mix_manager::mm_add_submix("nyhb_zodiac_jump");
      level.escape_zodiac maps\_audio_vehicles::vm_disablethrottleupdate(3);
      common_scripts\utility::flag_clear("player_zodiac_jump_hitwater");
      wait 0.05;
      common_scripts\utility::flag_wait("player_zodiac_jump_hitwater");
      level.player playSound("zodiac_player_collision");
      level.escape_zodiac maps\_audio_vehicles::vm_enablethrottleupdate();
      maps\_audio_mix_manager::mm_clear_submix("nyhb_zodiac_jump");
      wait 0.05;
      level.player playSound("zodiac_player_collision");
    }
  }

  common_scripts\utility::flag_clear("player_zodiac_jump_ramp");
  common_scripts\utility::flag_clear("player_zodiac_jump_hitwater");
}

aud_zodiac_into_chinook() {
  level.player playSound("zodoac_to_chinook_motor");
  thread maps\_audio_vehicles::vm_stop_preset_instance("escape_zodiac", 1);
  thread maps\_audio_vehicles::vm_stop_preset_instance("escape_zodiac_water", 1);
  wait 0.55;
  level.player playSound("zodoac_to_chinook_impact");
  thread maps\_audio_zone_manager::azm_start_zone("nyhb_chinook_interior_flight", 1.5);
  wait 1.6;
  level.player playSound("zodoac_to_chinook_slide");
  wait 3;
  maps\_audio_mix_manager::mm_start_preset("nyhb_finale", 1.5);
  wait 8;
  maps\_audio_mix_manager::mm_start_preset("nyhb_finale_amb_fade", 10);
}

aud_player_on_zodiac() {
  common_scripts\utility::flag_wait("player_on_boat");
  level.escape_zodiac vehicle_turnengineoff();
  thread maps\_audio_vehicles::vm_start_preset("escape_zodiac", "escape_zodiac", level.escape_zodiac, 2.0, "shg_zodiac_plr_startup", (-50, 0, 0));
  thread maps\_audio_vehicles::vm_start_preset("escape_zodiac_water", "escape_zodiac_water", level.escape_zodiac, 2.0);
  thread aud_zodiac_scrape(level.escape_zodiac);
}

aud_zodiac_scrape(var_0) {
  common_scripts\utility::flag_wait("player_zodiac_jump_ramp");

  if(isDefined(var_0)) {
    var_1 = var_0 vehicle_getspeed();

    if(var_1 > 10) {
      level.player playSound("zod_hit_ramp");
      level.player playSound("zod_ramp_scrape");
      wait 0.45;
      level.player playSound("zod_ramp_leave");
    }
  }
}

aud_player_sdv_intro() {
  common_scripts\utility::flag_wait("level_fade_done");
  wait 10;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 maps\_audio::aud_prime_stream("shg_sdv_intro_npc_start");
  wait 3;
  var_1 = spawn("script_origin", level.player.origin);
  var_1 maps\_audio::aud_prime_stream("shg_sdv_intro_plr_spline_fronts");
  wait 4.2;
  var_2 = var_0 maps\_audio::aud_is_stream_primed("shg_sdv_intro_npc_start");
  var_0 playSound("shg_sdv_intro_npc_start");
  common_scripts\utility::flag_wait("aud_player_tunnel_spline");
  var_2 = var_1 maps\_audio::aud_is_stream_primed("shg_sdv_intro_plr_spline_fronts");
  var_1 playSound("shg_sdv_intro_plr_spline_fronts");
  common_scripts\utility::flag_wait("player_out_of_vent");
  aud_player_sdv_on();
  thread aud_player_sdv_pause();
  wait 2;
  var_0 delete();
  var_1 delete();
}

aud_player_sdv_pause() {
  common_scripts\utility::flag_wait("russian_sub_spawned");
  aud_player_sdv_off();
  thread aud_player_sdv_unpause();
  wait 1;
  level.player playSound("shg_sdv_plr_shutdown");
}

aud_player_sdv_unpause() {
  common_scripts\utility::flag_wait("sdvs_chase_sub");
  aud_player_sdv_on();
  thread aud_player_sdv_outro();
}

aud_player_sdv_outro() {
  common_scripts\utility::flag_wait("aud_planting_submine");
  thread aud_surfacing_bubbles();
  thread aud_player_sdv_se();
  level.aud.sdv_temp_speed = level.player_sdv vehicle_getspeed();
  maps\_audio_vehicles::vm_set_speed_callback("sdv_motor_player", ::aud_player_sdv_speed_callback_temp);
  maps\_audio_vehicles::vm_set_throttle_callback("sdv_motor_player", ::aud_player_sdv_throttle_callback_temp);
  maps\_audio_vehicles::vm_set_speed_callback("sdv_water_player", ::aud_player_sdv_speed_callback_temp);
  maps\_audio_vehicles::vm_set_throttle_callback("sdv_water_player", ::aud_player_sdv_throttle_callback_temp);
  level.player playSound("shg_sdv_plr_shutdown");
}

aud_player_sdv_se() {
  wait 7;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playLoopSound("shg_sdv_plr_motor_fast");
  var_0 scalevolume(0.0, 0.05);
  wait 0.05;
  var_0 scalevolume(1.0, 3);
  wait 9;
  var_0 scalevolume(0.0, 6);
  wait 6.5;
  var_0 delete();
}

aud_surfacing_bubbles() {
  wait 4;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playLoopSound("harb_post_mine_speed_bubbles");
  var_0 scalevolume(0.0, 0.05);
  wait 0.05;
  level.player playSound("underwater_movement_02");
  var_0 scalevolume(1, 7);
  wait 10;
  level.player playSound("underwater_movement_03");
  wait 5;
  var_0 scalevolume(0.0, 6);
  wait 6.5;
  var_0 delete();
}

aud_player_sdv_on() {
  thread maps\_audio_vehicles::vm_start_preset("sdv_motor_player", "sdv_motor_player", level.player_sdv, 2.0);
  thread maps\_audio_vehicles::vm_start_preset("sdv_water_player", "sdv_water_player", level.player_sdv, 2.0);
}

aud_player_sdv_speed_callback_temp() {
  var_0 = 12;

  if(isDefined(level.aud.sdv_temp_speed)) {
    var_0 = level.aud.sdv_temp_speed;
  }
  return var_0;
}

aud_player_sdv_throttle_callback_temp() {
  return 1.0;
}

aud_player_sdv_off(var_0) {
  var_1 = 2.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  thread maps\_audio_vehicles::vm_stop_preset_instance("sdv_motor_player", var_1);
  thread maps\_audio_vehicles::vm_stop_preset_instance("sdv_water_player", var_1);
}

waittill_deathspin(var_0) {
  self endon("flyby_ent");
  var_0 waittill("deathspin");
  self notify("flyby_ent", "deathspin");
}

waittill_sounddone() {
  self endon("flyby_ent");
  self waittill("sounddone");
  self notify("flyby_ent", "sounddone");
}

aud_air_vehicle_flyby(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }
  var_6 = 0;

  if(isDefined(var_4)) {
    var_6 = var_4;
  }
  while(isDefined(var_0)) {
    if(var_6) {
      var_7 = distance(var_0.origin, level.player.origin);
    } else {
      var_7 = distance2d(var_0.origin, level.player.origin);
    }
    if(var_5) {}

    if(var_7 < var_2) {
      var_8 = spawn("script_origin", var_0.origin);
      var_8 linkTo(var_0);
      var_8 playSound(var_1, "sounddone");
      var_8 thread waittill_deathspin(var_0);
      var_8 thread waittill_sounddone();
      var_8 waittill("flyby_ent", var_9);

      if(var_9 == "deathspin") {
        var_10 = spawn("script_origin", var_8.origin);
        var_10 playSound("skybattle_hind_rocket_imp");
        var_8 scalevolume(0.0, 0.3);
        wait 0.4;
        var_8 stopsounds();
        var_8 delete();
        wait 1.0;
        var_10 delete();
        return;
      } else if(var_9 == "sounddone") {
        wait 0.1;
        var_8 delete();
        return;
      }

      continue;
    }

    wait 0.05;
  }
}

aud_russian_sub_start() {
  common_scripts\utility::flag_wait("russian_sub_spawned");
  thread aud_propeller_cone(3, 2, 5, 0.25);
  thread aud_russian_sub_se_pings();
  var_0 = spawn("script_origin", level.player.origin);
  var_0 maps\_audio::aud_prime_stream("russian_sub_travel_fronts");
  wait 2;
  thread maps\_audio_mix_manager::mm_add_submix("nyhb_russian_sub_by");
  thread maps\_audio_dynamic_ambi::damb_stop_zone(3);
  var_1 = var_0 maps\_audio::aud_is_stream_primed("russian_sub_travel_fronts");
  var_0 playSound("russian_sub_travel_fronts");
  music_cue("mus_sub_passby");
  thread aud_play_sub_groans();
  wait 18.5;
  var_2 = spawn("script_origin", level.player.origin);
  var_2 maps\_audio::aud_prime_stream("russian_sub_passby_fronts");
  wait 2;
  var_1 = var_2 maps\_audio::aud_is_stream_primed("russian_sub_passby_fronts");
  var_2 playSound("russian_sub_passby_fronts");
  wait 22.5;
  maps\_audio_mix_manager::mm_clear_submix("nyhb_russian_sub_by", 3);
  var_0 delete();
  var_2 delete();
}

aud_barracks_sandman_opening_door() {
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  maps\_audio_mix_manager::mm_clear_submix("sub_entry", 2);
}

aud_play_sub_groans() {
  wait 9;
  level.player playSound("metal_groans_deep_harb_sub");
  wait 3;
  level.player playSound("harb_sub_stress_sub_by");
  level.player playSound("russian_sub_big_groan");
}

aud_russian_sub_single_ping() {
  level.player playSound("russian_sub_sonar_ping_dist");
}

aud_russian_sub_se_pings() {
  wait 5;
  level.player playSound("russian_sub_sonar_ping_rear");
  wait 3;
  level.player playSound("russian_sub_sonar_ping_rear");
  wait 14;
  level.player playSound("russian_sub_sonar_ping_front");
  wait 3;
  level.player playSound("russian_sub_sonar_ping_front");
}

aud_force_cone_to_min(var_0) {
  for(;;) {
    level.aud.cone_sound scalevolume(var_0, 0.05);

    if(level.flag["aud_engine_fade_out"]) {
      return;
    }
    wait 0.05;
  }
}

aud_propeller_cone(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.sdv_player_arms)) {
    return;
  }
  level.aud.cone_sound = spawn("script_origin", (0, 0, 0));
  level.aud.cone_sound.is_playing = 0;
  level.aud.cone_sound.name = "russian_sub_propellor_wake";
  level.aud.omni_sound = spawn("script_origin", (0, 0, 0));
  level.aud.omni_sound.is_playing = 0;
  level.aud.omni_sound.name = "russian_sub_engine_rumble";
  var_4 = 1.0;

  if(isDefined(var_0)) {
    var_4 = var_0;
  }
  var_5 = 1.0;

  if(isDefined(var_1)) {
    var_5 = var_1;
  }
  var_6 = 0.0;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }
  aud_propeller_cone_monitor(var_4, var_5, var_6);
  var_7 = 5.0;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }
  common_scripts\utility::flag_wait("aud_engine_stop_monitor");
  wait 5.0;
  level.aud.cone_sound unlink();
  level.aud.omni_sound unlink();
  wait 0.05;
  level.aud.cone_sound linkTo(level.sdv_player_arms, "tag_player");
  level.aud.omni_sound linkTo(level.sdv_player_arms, "tag_player");
  common_scripts\utility::flag_wait("aud_engine_fade_out");
  level.aud.cone_sound setvolume(0.0, var_7);
  level.aud.omni_sound setvolume(0.0, var_7);
  wait(var_7 + 0.05);
  level.aud.cone_sound delete();
  level.aud.omni_sound delete();
}

aud_get_prop_sound_origin() {
  if(!isDefined(level.russian_sub_02)) {
    return;
  }
  var_0 = undefined;
  var_1 = level.russian_sub_02;
  var_2 = var_1 gettagorigin("tag_left_porpeller");
  var_3 = var_1 gettagangles("tag_left_porpeller");
  var_4 = anglesToForward(var_3);
  var_5 = var_1 gettagorigin("tag_right_propeller");
  var_6 = var_1 gettagangles("tag_right_propeller");
  var_7 = level.player.origin - var_2;
  var_8 = level.player.origin - var_5;
  var_9 = var_2 - var_5;
  var_10 = vectordot(var_7, var_4);

  if(var_10 > 0) {
    self.is_in_cone = 0;
  } else {
    self.is_in_cone = 1;
  }
  var_9 = vectorNormalize(var_9);
  var_11 = vectordot(var_7, var_9);
  var_12 = vectordot(var_8, var_9);

  if(var_11 > 0 && var_12 > 0) {
    var_0 = var_2;
  } else if(var_11 < 0 && var_12 < 0) {
    var_0 = var_5;
  } else {
    var_13 = distance(var_2, var_5);
    var_0 = var_2 + var_11 * var_9;
  }

  self.sound_origin = var_0;
}

aud_propeller_cone_monitor(var_0, var_1, var_2) {
  level endon("aud_stop_sub_propeller");
  var_3 = 0;

  for(;;) {
    if(!isDefined(level.russian_sub_02)) {
      return;
    }
    if(isDefined(level.flag["aud_planting_submine"]) && level.flag["aud_planting_submine"]) {
      thread aud_force_cone_to_min(var_2);
      return;
    }

    var_4 = spawnStruct();
    var_4 aud_get_prop_sound_origin();

    if(var_4.is_in_cone) {
      if(!level.aud.cone_sound.is_playing) {
        level.aud.cone_sound.is_playing = 1;
        level.aud.cone_sound.origin = var_4.sound_origin;
        level.aud.cone_sound playLoopSound(level.aud.cone_sound.name);
        level.aud.cone_sound scalevolume(0.0);
        wait 0.05;
        var_3 = 0;
      } else if(var_3 == 0) {
        var_3 = 1;
        level.aud.cone_sound setvolume(1.0, var_0);
      }
    } else if(var_3 == 1) {
      var_3 = 0;
      level.aud.cone_sound setvolume(var_2, var_1);
    }

    if(!level.aud.omni_sound.is_playing) {
      level.aud.omni_sound.is_playing = 1;
      level.aud.omni_sound.origin = var_4.sound_origin;
      level.aud.omni_sound playLoopSound(level.aud.omni_sound.name);
    }

    level.aud.omni_sound moveTo(var_4.sound_origin, 0.1);
    level.aud.cone_sound moveTo(var_4.sound_origin, 0.1);
    wait 0.1;
  }
}

aud_player_sub_surface_breach() {
  wait 7;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 maps\_audio::aud_prime_stream("surface_breach_fronts");
  thread maps\_audio_mix_manager::mm_add_submix("nyhb_surface_breach_se");
  common_scripts\utility::flag_set("aud_engine_fade_out");
  wait 4.2;
  var_1 = var_0 maps\_audio::aud_is_stream_primed("surface_breach_fronts");
  var_0 playSound("surface_breach_fronts");
  wait 5.2;
  level.player playSound("plyr_surface_breach_fronts");
  wait 7.4;
  level.player playSound("sub_surface_breach_fronts");
  wait 4.2;
  level.player playSound("sub_surface_breach_lfe");
  wait 11.5;
  maps\_audio_mix_manager::mm_clear_submix("nyhb_surface_breach_se", 4);
  wait 10.5;
  var_0 delete();
}

aud_do_sub_scuttle_bombshake() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 thread maps\_audio::aud_prime_stream("sub_scuttle_explosion", 1, 0.1);
  wait 0.5;
  var_0 playSound("sub_scuttle_explosion");
  var_0 maps\_audio::aud_release_stream("sub_scuttle_explosion");
  earthquake(0.3, 3, level.player.origin, 850);
  wait 12;
  wait 0.1;
  var_0 delete();
}

aud_play_skybattle_dist_jet(var_0, var_1, var_2) {
  level endon("aud_notify_inside_sub");
  var_0 playSound("skybattle_dist_jet", "sounddone");
  var_0 moveTo(var_1, var_2);
  var_0 waittill("sounddone");
}

aud_play_mine_beep() {
  if(!isDefined(level.aud.mine_setup)) {
    thread aud_setup_minewarn();
  }
  var_0 = level.aud.mine_pitch;

  for(var_1 = 0; var_1 < level.aud.mine_beep_count; var_1++) {
    level.aud.mine_ents[var_1] playSound("veh_mine_beep");
    level.aud.mine_ents[var_1] setpitch(var_0);
    wait 0.1;
  }
}

aud_setup_minewarn() {
  level.aud.mine_setup = 1;
  level.aud.mine_beep_count = 1;
  level.aud.mine_min_dist = 2.0;
  level.aud.curr_dist = 2.0;
  level.aud.mine_max_num_beeps = 3;
  var_0 = 0.3;
  level.aud.mine_pitch_env = [[0.0, 1.2], [0.2, 1.1], [0.7, 1.0], [1.0, 1.0], [2.0, 1.0]];
  level.aud.mine_pitch = 1.0;
  level.aud.mine_ents = [];

  for(var_1 = 0; var_1 < level.aud.mine_max_num_beeps; var_1++) {
    level.aud.mine_ents[var_1] = spawn("script_origin", level.player.origin);
    level.aud.mine_ents[var_1] linkTo(level.player);
  }

  level waittill("aud_stop_minewarn_loop");

  for(var_1 = 0; var_1 < level.aud.mine_max_num_beeps; var_1++) {
    level.aud.mine_ents[var_1] delete();
  }
}

aud_minewarn(var_0) {
  if(!isDefined(level.aud.mine_setup)) {
    aud_setup_minewarn();
  }
  if(var_0 != level.aud.curr_dist) {
    level.aud.curr_dist = var_0;
    var_1 = level.aud.mine_min_dist;
    var_2 = level.aud.mine_max_num_beeps;
    level.aud.mine_pitch = maps\_audio::aud_map2(var_0, level.aud.mine_pitch_env);
  }
}

aud_slava_missile_launch(var_0) {
  if(!common_scripts\utility::flag("aud_flag_inside_sub")) {
    thread common_scripts\utility::play_sound_in_space("distant_slava_missile_launch", var_0.origin);
    wait 0.3;
    thread maps\_audio::aud_play_linked_sound("distant_slava_missile_travel", var_0, "oneshot");
    var_1 = spawn("script_origin", var_0.origin);
    var_1 linkTo(var_0);
    var_1 playSound("distant_slava_missile_whistle_oneshot");
    var_2 = randomfloatrange(0.5, 0.9);
    var_3 = randomfloatrange(3, 9);
    var_1 setpitch(var_2, var_3);
    var_0 waittill("death");
    var_1 stopsounds();
    var_1 delete();
  }
}

aud_play_harb_slowmo_impact(var_0, var_1, var_2, var_3, var_4) {
  level.player playSound("slowmo_bullet_whoosh");
}

aud_play_harb_slowmo_gunshot(var_0) {
  switch (var_0) {
    default:
      break;
  }
}

aud_play_harb_door_breach_impact(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.aud.last_db_time)) {
    level.aud.last_db_time = 0;
  }
  var_5 = gettime();

  if(var_5 - level.aud.last_db_time > 200) {
    level.aud.last_db_time = var_5;
    level.player playSound("db_bullet_whoosh");
  }
}

aud_play_harb_door_breach_gunshot(var_0) {
  switch (var_0) {
    default:
      break;
  }
}