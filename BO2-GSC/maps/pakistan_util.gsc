/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_util.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_skipto;
#include maps\_scene;
#include maps\_turret;
#include maps\_music;
#include maps\_vehicle;
#include maps\_dialog;
#include maps\createart\pakistan_2_art;
#include maps\_fxanim;

init_flags() {
  flag_init("harper_kick");
  flag_init("door_exploded");
  flag_init("intro_fallback");
  flag_init("market_drone_dead");
  flag_init("bus_crash_drone");
  flag_init("player_inside_sewer");
  flag_init("market_done");
  flag_init("frogger_perk_active");
  flag_init("frogger_started");
  flag_init("player_hit_by_frogger_debris");
  flag_init("harper_car_wait_1");
  flag_init("frogger_done");
  flag_init("claw_challenge_done");
  flag_init("harper_to_gate");
  flag_init("bus_dam_done");
  flag_init("zone_stealth_restored");
  flag_init("pakistan_introscreen_show");
  flag_init("intruder_perk_used");
  flag_init("lockbreaker_used");
  flag_init("player_hiding_underwater");
  flag_init("drone_attacks_player");
  flag_init("drone_detected_player");
  flag_init("helicopter_dead");
  flag_init("civ_targeted");
  flag_init("looking_at_target");
  flag_init("moveto_cafe");
  flag_init("move1");
  flag_init("move3");
  flag_init("moveto_cafe_side");
  flag_init("drone_intro_done");
  flag_init("drone_stealth_half_way");
  flag_init("intro_drone_done");
  flag_init("harper_ai_dont_stop");
  flag_init("drone_searcher_look_left");
  flag_init("drone_searcher_look_away");
  flag_init("drone_searcher_done");
  flag_init("drone_searcher_flyoff");
  flag_init("drone_searcher_low");
  flag_init("drones_gone");
  flag_init("bank_drone_dead");
  flag_init("intruder_guards_alerted");
  flag_init("harper_kills_two");
  flag_init("drone_searcher_attack");
  flag_init("drone_intro_attack");
  flag_init("drone_bank_attack");
  flag_init("drone_spotlight_off");
  flag_init("sewer_move_up");
  flag_init("lead_gaz_go");
  flag_init("alert_drones");
  flag_init("millibar_activate");
  flag_init("rooftop_melee");
  flag_init("rooftop_clear");
  flag_init("osprey_away");
  flag_init("drone_at_helipad");
  flag_init("player_detected");
  flag_init("delete_rope_player");
  flag_init("delete_rope_harper");
  flag_init("spawn_rooftop_guard");
  flag_init("anthem_grapple_complete");
  flag_init("rooftop_guards_alerted");
  flag_init("searchlight_focus_off");
  flag_init("anthem_voice_analysis_complete");
  flag_init("anthem_facial_recognition_complete");
  flag_init("anthem_guard_tower_reached");
  flag_init("anthem_surveillance_complete");
  flag_init("anthem_player_in_interference");
  flag_init("anthem_harper_start_tracking");
  flag_init("spotlight_jump_down_enter");
  flag_init("anthem_harper_drop");
  flag_init("anthem_harper_stand");
  flag_init("anthem_start_soldiers_exit");
  flag_init("rooftop_open_entrance");
  flag_init("rooftop_close_entrance");
  flag_init("rooftop_open_exit");
  flag_init("tower_melee_complete");
  flag_init("meeting_over");
  flag_init("rooftop_meeting_harper_hide");
  flag_init("rooftop_meeting_harper_pursue");
  flag_init("rooftop_meeting_harper_slide");
  flag_init("rooftop_meeting_harper_observe");
  flag_init("rooftop_meeting_convoy_start");
  flag_init("drone_detection_end");
  flag_init("roof_meeting_defalco_identified");
  flag_init("trigger_jump_down");
  flag_init("railyard_melee_ready");
  flag_init("railyard_melee_start");
  flag_init("trainyard_melee_finished");
  flag_init("gaz_melee_failed");
  flag_init("railyard_drone_meeting_room_entered");
  flag_init("railyard_train_enter");
  flag_init("train_arrived");
  flag_init("railyard_drone_meeting_ready");
  flag_init("railyard_millibar_meeting_ready");
  flag_init("railyard_player_millibar_start");
  flag_init("railyard_harper_millibar_approach");
  flag_init("underground_millibar_on");
  flag_init("firewater_surface");
  flag_init("trainyard_elevator_escape_ready");
  flag_init("trainyard_elevator_escape_start");
  flag_init("claw_start_ready");
  flag_init("claw_start");
  flag_init("claw_pip_on");
  flag_init("claw_end");
  flag_init("claw_battle_end");
  flag_init("drone_player_detected");
  flag_init("claw_suicide_target_reached");
  flag_init("claw2_obj1_reached");
  flag_init("claw2_obj2_reached");
  flag_init("claw_switch_done");
  flag_init("stop_claw_switch_think");
  flag_init("id_ready");
  flag_init("anthem_harper_vo_id");
  flag_init("anthem_harper_vo_surveillance");
  flag_init("anthem_harper_vo_interference");
  flag_init("anthem_harper_vo_take_cover");
  flag_init("anthem_harper_vo_drone_meeting_drone");
  flag_init("anthem_harper_vo_millibar_meeting_start");
  flag_init("rooftop_meeting_defalco_vo_start");
  flag_init("salazar_vo_claw_positioned");
  flag_init("millibar_vo_started");
  flag_init("millibar_vo_discovery");
  flag_init("claw_start_vo_done");
  flag_init("xcam_off");
  flag_init("start_anthem_approach");
  flag_init("section_3_started");
  flag_init("vehicle_can_switch");
  flag_init("blockage_scaffolding_collision_deleted");
  flag_init("drone_intro_path_complete");
  flag_init("vehicle_switched");
  flag_init("vehicle_switch_fade_in_started");
  flag_init("stop_drone_speed_control");
  flag_init("player_cannot_get_hurt");
  flag_init("st_salazar_clear");
  flag_init("heli_crash_ready");
  flag_init("escape_bosses_end");
  flag_init("enter_hotel_cleanup");
  flag_init("super_soct_created");
  flag_init("pipe_fall_0");
  flag_init("pipe_fall_1");
  flag_init("pipe_fall_2");
  flag_init("enter_final_warehouse");
  flag_init("player_drone_death_collision");
  flag_init("ending_player_blocker_moving");
  flag_init("evac_chase_starts");
  flag_init("player_drone_fatal_collision_starts");
  flag_init("player_drone_crashes_chain_reaction");
  flag_init("player_enters_hanger");
  flag_init("start_defend_convoy");
  flag_init("spawn_spotlight_drone");
  flag_init("start_player_claw_switch");
  flag_init("start_switch_ability");
  flag_init("courtyard_event_done");
  flag_init("intro_drone_died");
  flag_init("trig_fallback_1");
  flag_init("trig_fallback_archway");
  flag_init("start_courtyard_event");
  flag_init("trig_spawn_left_path_guys");
  flag_init("street_claw_dead");
  flag_init("rooftop_claw_dead");
  flag_init("player_switched_to_claw");
  flag_init("intro_drone_shooting_done");
  flag_init("spawn_garage_breachers");
  flag_init("open_garage_door");
  flag_init("drone_is_dead");
  flag_init("player_soct_in_position");
  flag_init("protect_objective_set");
  flag_init("pakistan_is_raining");
  flag_init("pakistan_is_rain_drops");
}

setup_objectives() {
  level.obj_interact_lock_breaker = register_objective(&"");
  level.obj_interact_brute_force = register_objective(&"");
  level.obj_interact_intruder = register_objective(&"");
  level.obj_get_to_base = register_objective(&"PAKISTAN_SHARED_OBJ_GET_TO_BASE");
  level.obj_get_to_base_again = register_objective(&"PAKISTAN_SHARED_OBJ_GET_TO_BASE");
  level.obj_avoid_drones = register_objective(&"PAKISTAN_SHARED_OBJ_AVOID_DRONES");
  level.obj_name2 = register_objective(&"pakistan_OBJ_NAME2");
  level.obj_bus_escape = register_objective(&"");
  level.obj_hide = register_objective(&"");
  level.obj_grapple = register_objective(&"PAKISTAN_SHARED_OBJ_GRAPPLE");
  level.obj_id_menendez = register_objective(&"PAKISTAN_SHARED_OBJ_ID_MENENDEZ");
  level.obj_record_menendez = register_objective(&"PAKISTAN_SHARED_OBJ_RECORD_MENENDEZ");
  level.obj_record_menendez_again = register_objective(&"PAKISTAN_SHARED_OBJ_RECORD_MENENDEZ");
  level.obj_reacquire = register_objective(&"PAKISTAN_SHARED_OBJ_REACQUIRE");
  level.obj_reacquire_again = register_objective(&"PAKISTAN_SHARED_OBJ_REACQUIRE_AGAIN");
  level.obj_salazar = register_objective(&"PAKISTAN_SHARED_OBJ_SALAZAR");
  level.obj_clear_railyard = register_objective(&"PAKISTAN_SHARED_OBJ_CLEAR_RAILYARD");
  level.obj_info1 = register_objective(&"PAKISTAN_SHARED_INFO1");
  level.obj_info2 = register_objective(&"PAKISTAN_SHARED_INFO2");
  level.obj_info3 = register_objective(&"PAKISTAN_SHARED_INFO3");
  level.obj_info_complete = register_objective(&"PAKISTAN_SHARED_INFO_COMPLETE");
  level.obj_info_incomplete1 = register_objective(&"PAKISTAN_SHARED_INFO_INCOMPLETE1");
  level.obj_info_incomplete2 = register_objective(&"PAKISTAN_SHARED_INFO_INCOMPLETE2");
  level.obj_escape = register_objective(&"PAKISTAN_SHARED_OBJ_ESCAPE");
  level.obj_blockade = register_objective(&"PAKISTAN_SHARED_OBJ_BLOCKADE");
  level.obj_evac_face_burn_point = register_objective(&"");
  level.obj_evac_point = register_objective(&"PAKISTAN_SHARED_OBJ_GET_TO_EXTRACTION_POINT");
  level.obj_evac = register_objective(&"PAKISTAN_SHARED_OBJ_EVAC");
  level.obj_follow_salazars_soct = register_objective(&"");
}

skipto_cleanup() {
  load_gumps_pakistan();
  skipto = level.skipto_point;

  if(level.script == "pakistan")
    set_water_dvars_market();

  if(level.skipto_point == "intro") {
    return;
  }
  if(level.script == "pakistan" && !is_after_skipto("dev_sewer_interior_no_perk"))
    flag_set("intro_anim_done");

  if(level.skipto_point == "market" || level.skipto_point == "dev_market_perk") {
    return;
  }
  if(level.skipto_point == "car_smash") {
    return;
  }
  if(level.script == "pakistan")
    set_water_dvars_street();

  if(level.skipto_point == "market_exit" || level.skipto_point == "dev_market_exit_perk" || level.skipto_point == "dev_market_exit_no_perk") {
    return;
  }
  flag_set("market_done");

  if(level.script == "pakistan")
    level thread frogger_set_dvars();

  if(level.skipto_point == "frogger" || level.skipto_point == "dev_frogger_claw_support") {
    return;
  }
  if(level.skipto_point == "bus_street") {
    return;
  }
  if(level.skipto_point == "bus_dam") {
    return;
  }
  if(level.script == "pakistan")
    set_water_dvars_drone();

  if(level.skipto_point == "alley") {
    return;
  }
  if(level.skipto_point == "anthem_approach") {
    return;
  }
  if(level.skipto_point == "sewer_exterior") {
    return;
  }
  clientnotify("cleanup_stealth_dynents");
  set_water_dvars_sewer();

  if(level.skipto_point == "sewer_interior" || level.skipto_point == "dev_sewer_interior_perk" || level.skipto_point == "dev_sewer_interior_no_perk") {
    return;
  }
  if(level.skipto_point == "anthem") {
    return;
  }
  if(level.skipto_point == "roof_meeting") {
    return;
  }
  if(level.skipto_point == "gaz_melee") {
    return;
  }
  if(level.skipto_point == "claw") {
    return;
  }
  if(level.skipto_point == "escape_intro") {
    return;
  }
  if(level.skipto_point == "escape_battle") {
    return;
  }
  if(level.skipto_point == "escape_bosses") {
    return;
  }
  if(level.skipto_point == "warehouse") {
    return;
  }
  if(level.skipto_point == "hangar") {
    return;
  }
  if(level.skipto_point == "standoff")
    return;
}

skipto_market_exit_deconstruct_ents() {
  level.a_str_behind_bus_names = deconstruct_fxanims_in_trigger("street_behind_bus_trig");
  level.a_str_bus_dam_names = deconstruct_fxanims_in_trigger("bus_dam_fxanim_cleanup_trig");
  level.a_str_sewer_names = deconstruct_fxanims_in_trigger("sewer_fxanim_cleanup_trig");
  vol_market_exit = getent("zone_market_exit", "script_noteworthy");
  vol_market_exit delete();
  pakistan_deconstruct_models();
  bus_dam_reconstruct_ents();
  stealth_reconstruct_ents();
  sewer_reconstruct_ents();
}

skipto_frogger_deconstruct_ents() {
  level.a_str_behind_bus_names = deconstruct_fxanims_in_trigger("street_behind_bus_trig");
  level.a_str_bus_dam_names = deconstruct_fxanims_in_trigger("bus_dam_fxanim_cleanup_trig");
  level.a_str_sewer_names = deconstruct_fxanims_in_trigger("sewer_fxanim_cleanup_trig");
  vol_market_exit = getent("zone_market_exit", "script_noteworthy");
  vol_market_exit delete();
  vol_frogger = getent("zone_frogger", "script_noteworthy");
  vol_frogger delete();
  pakistan_deconstruct_models();
  pakistan_reconstruct_ents();
}

skipto_bus_dam_deconstruct_ents() {
  level.a_str_behind_bus_names = deconstruct_fxanims_in_trigger("street_behind_bus_trig");
  level.a_str_bus_dam_names = deconstruct_fxanims_in_trigger("bus_dam_fxanim_cleanup_trig");
  level.a_str_sewer_names = deconstruct_fxanims_in_trigger("sewer_fxanim_cleanup_trig");
  vol_market_exit = getent("zone_market_exit", "script_noteworthy");
  vol_market_exit delete();
  vol_frogger = getent("zone_frogger", "script_noteworthy");
  vol_frogger delete();
  pakistan_deconstruct_models();
  bus_dam_reconstruct_ents();
  stealth_reconstruct_ents();
  sewer_reconstruct_ents();
}

skipto_stealth_deconstruct_ents() {
  level.a_str_sewer_names = deconstruct_fxanims_in_trigger("sewer_fxanim_cleanup_trig");
  vol_market_exit = getent("zone_market_exit", "script_noteworthy");
  vol_market_exit delete();
  vol_frogger = getent("zone_frogger", "script_noteworthy");
  vol_frogger delete();
  vol_bus_dam = getent("zone_bus_dam", "script_noteworthy");
  vol_bus_dam delete();
  vol_bus_dam = getent("zone_stealth", "script_noteworthy");
  vol_bus_dam delete();
  pakistan_deconstruct_models();
  sewer_reconstruct_ents();
}

set_water_dvars_market() {
  setdvar("r_waterwavespeed", "1.092 1.060 1.085 1.045");
  setdvar("r_waterwaveamplitude", "0.339979 0.47448 0 0.209791");
  setdvar("r_waterwavewavelength", "111.9 77 187.6 245");
  setdvar("r_waterwaveangle", "70.6 46.9 117.1 179.67");
  setdvar("r_waterwavephase", "0 0 0 0");
  setdvar("r_waterwavesteepness", "1 1 1 1");
}

set_water_dvars_street() {
  setdvar("r_waterwavespeed", "1.092 1.060 1.085 1.045");
  setdvar("r_waterwaveamplitude", "3.0 1.25 2.69307 2.95");
  setdvar("r_waterwavewavelength", "111.9 77 187.6 245");
  setdvar("r_waterwaveangle", "70.6 46.9 117.1 179.67");
  setdvar("r_waterwavephase", "0 0 0 0");
  setdvar("r_waterwavesteepness", "1 1 1 1");
}

set_water_dvars_drone() {
  setdvar("r_waterwavespeed", "0.847797 0.927097 0.988564 0.912813");
  setdvar("r_waterwaveamplitude", "0.7029 0.283211 0.197808 0");
  setdvar("r_waterwavewavelength", "520.518 655.591 295.898 444.711");
  setdvar("r_waterwaveangle", "70.6 46.9 117.1 179.67");
  setdvar("r_waterwavephase", "0 0 0 0");
  setdvar("r_waterwavesteepness", "1 1 1 1");
}

set_water_dvars_sewer() {
  setdvar("r_waterwavespeed", "1.2576 1.04451 0.988564 0.912813");
  setdvar("r_waterwaveamplitude", "1.12939 0.872787 0.0633609 0.208114");
  setdvar("r_waterwavewavelength", "520.518 655.591 295.898 444.711");
  setdvar("r_waterwaveangle", "136.289 18.793 47.1117 0");
  setdvar("r_waterwavephase", "0 0 0 0");
  setdvar("r_waterwavesteepness", "1 1 1 1");
}

frogger_set_dvars() {
  wait_network_frame();
  setsaveddvar("phys_ragdoll_buoyancy", 1);
  setsaveddvar("phys_buoyancyFloatHeightOffset", 0);
  setsaveddvar("phys_buoyancyDistanceCutoff", 50000);
  level.player setclientdvar("dynEnt_spawnedLimit", 100);
}

load_gumps_pakistan() {
  screen_fade_out(0);

  if(level.script == "pakistan") {
    if(is_after_skipto("bus_dam"))
      load_gump("pakistan_gump_alley");
    else
      load_gump("pakistan_gump_street");
  } else if(level.script == "pakistan_2") {
    if(is_after_skipto("roof_meeting"))
      load_gump("pakistan_2_gump_escape");
    else
      load_gump("pakistan_2_gump_anthem");
  } else if(level.script == "pakistan_3") {
    if(is_after_skipto("warehouse"))
      load_gump("pakistan_3_gump_escape_end");
    else if(is_after_skipto("escape_battle"))
      load_gump("pakistan_3_gump_escape");
    else
      load_gump("pakistan_3_gump_escape_intro");
  }

  level thread screen_fade_in(1);
}

mission_fail(str_dead_quote_ref) {
  setdvar("ui_deadquote", str_dead_quote_ref);
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

hud_signal_indicator_blink() {
  self endon("hud_signal_indicator_destroy");
  self.blink = 0;
  self.blinkspeed = 2.0;
  str_interp_direction = "down";

  while(true) {
    while(self.blink) {
      if(self.alpha == 0.0) {
        str_interp_direction = "up";
        level.player thread play_sound_on_entity("soundalias evt_pak_surv_cursor_beep");
      } else if(self.alpha == 1.0)
        str_interp_direction = "down";

      n_alpha_step_size = 2.0 / (self.blinkspeed / 0.05);

      if(str_interp_direction == "up")
        self.alpha = min(self.alpha + n_alpha_step_size, 1.0);
      else
        self.alpha = max(self.alpha - n_alpha_step_size, 0.0);

      wait 0.05;
    }

    self.alpha = 1.0;
    wait 0.05;
  }
}

id_think(ai_target, n_view_angle_max, n_view_angle_min, wait_for_flag) {
  if(!isDefined(wait_for_flag))
    wait_for_flag = 0;

  level endon("stop_id");
  level endon("anthem_facial_recognition_complete");
  is_analyzing_voice_match = 1;
  n_player_view_angle_max = cos(n_view_angle_max);
  n_player_view_angle_min = cos(n_view_angle_min);
  n_signal_indicator_blink_speed_max = 2.0;
  n_signal_indicator_blink_speed_step = n_signal_indicator_blink_speed_max / n_player_view_angle_min;
  n_signal_indicator_color_red_max = 1.0;
  n_signal_indicator_color_red_step = n_signal_indicator_color_red_max / n_player_view_angle_min;
  n_facial_recognition_time_start = undefined;
  flag_clear("anthem_facial_recognition_complete");
  id_status_info_think();
  level.player thread play_sound_on_entity("play evt_pak_surv_cursor_good");

  if(!wait_for_flag)
    flag_set("id_ready");
  else
    flag_clear("id_ready");

  while(is_analyzing_voice_match) {
    if(isDefined(ai_target)) {
      n_player_view_angle = level.player get_dot_direction(ai_target geteye(), 0, 1, "forward", 1);

      if(n_player_view_angle <= n_player_view_angle_min) {
        if(flag("anthem_voice_analysis_complete")) {
          flag_clear("anthem_voice_analysis_complete");
          n_facial_recognition_time_start = undefined;
          level notify("stop_facial_recognition");
          luinotifyevent(&"hud_pak_stop_scan", 1, ai_target getentitynumber());
          level.player notify("stop soundevt_surv_scan_dude");
          id_status_info_think();
        }
      } else if(flag("id_ready") && !isDefined(n_facial_recognition_time_start)) {
        flag_set("anthem_voice_analysis_complete");
        level.player notify("stop soundevt_surv_scanning_lp");
        level thread launch_facial_recognition(ai_target);
        luinotifyevent(&"hud_pak_start_scan", 1, ai_target getentitynumber());
        n_facial_recognition_time_start = gettime();
      } else if(flag("id_ready") && gettime() - n_facial_recognition_time_start >= 5000)
        is_analyzing_voice_match = 0;
    }

    wait 0.05;
  }
}

stop_id(ai_target) {
  level notify("stop_id");
  level notify("stop_facial_recognition");

  if(isDefined(ai_target))
    luinotifyevent(&"hud_pak_stop_scan", 1, ai_target getentitynumber());

  level.player notify("stop soundevt_surv_scanning_lp");
}

id_status_info_think() {
  level.player thread play_loop_sound_on_entity("evt_surv_scanning_lp");
  level.player thread play_sound_on_entity("evt_surv_startup");
}

monitor_surveillance_zoom() {
  level endon("xcam_off");

  while(true) {
    self waittill_ads_button_pressed();
    self setclientflag(7);
    luinotifyevent(&"hud_pak_toggle_zoom", 1, 1);
    self playsound("evt_pak_surv_zoom_in");

    while(self ads_button_pressed())
      wait 0.05;

    self clearclientflag(7);
    luinotifyevent(&"hud_pak_toggle_zoom", 1, 0);
    self playsound("evt_pak_surv_zoom_out");
  }
}

surveillance_mode_hint() {
  if(flag("xcam_off")) {
    level thread screen_message_create(&"PAKISTAN_SHARED_SURV_ACTIVATE", undefined, undefined, undefined, 6);

    while(!level.player actionslotonebuttonpressed())
      wait 0.05;

    screen_message_delete();
  }
}

surveillance_think(ai_target) {
  level endon("stop_surveillance");
  n_los_angle_max = cos(12.0);
  n_los_angle_min = cos(3.0);
  n_los_angle_range = n_los_angle_min - n_los_angle_max;
  n_dist_to_menendez_max = 2200.0;
  n_dist_to_menendez_min = 500.0;
  n_dist_to_menendez_range = n_dist_to_menendez_max - n_dist_to_menendez_min;
  n_los_angle_step = n_los_angle_range / n_dist_to_menendez_range;
  level.str_hud_current_state = "recording";
  level.player thread play_sound_on_entity("evt_pak_surv_cursor_starting");
  level thread hud_surveillance_recording();
  init_interference_triggers();
  level.player thread check_in_interference();

  if(isDefined(level.menendez)) {
  }

  if(!isDefined(ai_target)) {
    level notify("stop_surveillance");
    wait 0.1;
  }

  while(true) {
    if(isDefined(ai_target)) {
      n_player_view_angle = level.player get_dot_direction(ai_target geteye(), 0, 1, "forward", 1);
      n_los_angle_constraint = n_los_angle_max + n_los_angle_step * (distance(level.player geteye(), ai_target geteye()) - n_dist_to_menendez_min);
      n_los_angle_constraint = min(n_los_angle_constraint, cos(0.5));

      if(flag("anthem_player_in_interference")) {
        if(level.str_hud_current_state != "interference") {
          surveillance_state_change_cleanup(level.str_hud_current_state);
          hud_surveillance_interference();
          level.str_hud_current_state = "interference";
          level clientnotify("surv_OFF");
        }
      } else if(is_menendez_los(n_player_view_angle, n_los_angle_constraint)) {
        if(level.str_hud_current_state != "recording") {
          surveillance_state_change_cleanup(level.str_hud_current_state);
          level thread hud_surveillance_recording();
          level.str_hud_current_state = "recording";
          level clientnotify("surv_ON");
        }
      } else if(flag("xcam_off")) {
        if(level.str_hud_current_state != "switched_off") {
          surveillance_state_change_cleanup(level.str_hud_current_state);
          hud_surveillance_interference();
          level.str_hud_current_state = "switched_off";
          level clientnotify("surv_OFF");
        }
      } else if(level.str_hud_current_state != "no target") {
        surveillance_state_change_cleanup(level.str_hud_current_state);
        hud_surveillance_no_target();
        level.str_hud_current_state = "no target";
        level clientnotify("surv_OFF");
      }
    }

    wait 0.05;
  }
}

stop_surveillance() {
  level notify("stop_surveillance");

  if(isDefined(level.menendez)) {
  }

  surveillance_state_change_cleanup(level.str_hud_current_state);
  level.player notify("anthem_surveillance_complete");
}

surveillance_state_change_cleanup(str_hud_current_state) {
  level notify("hud_surveillance_state_change");

  if(isDefined(str_hud_current_state)) {
    switch (str_hud_current_state) {
      case "interference":
        level.player stop_loop_sound_on_entity("evt_pak_surv_interference_lp");
        break;
      case "no target":
        level.player stop_loop_sound_on_entity("evt_pak_surv_notarget_lp");
        break;
    }
  }
}

is_menendez_los(n_player_view_angle, n_los_angle_constraint) {
  v_trace_pos = bullettrace(level.player geteye(), level.menendez geteye(), 0, level.player, 1, 1)["position"];

  if(n_player_view_angle > n_los_angle_constraint && v_trace_pos == level.menendez geteye())
    return true;
  else
    return false;
}

hud_surveillance_recording() {
  level endon("hud_surveillance_state_change");
  level.player thread play_sound_on_entity("evt_pak_surv_cursor_good");

  while(true) {
    wait 0.5;
    level.recorded_data = level.recorded_data + 2;
    luinotifyevent(&"hud_pak_update_recording", 1, level.recorded_data);
  }
}

hud_surveillance_interference() {
  level.player thread play_sound_on_entity("evt_pak_surv_cursor_bad");
  level.player thread play_loop_sound_on_entity("evt_pak_surv_interference_lp");
}

hud_surveillance_no_target() {
  str_blink_interp_direction = "down";
  level.player thread play_sound_on_entity("evt_pak_surv_cursor_bad");
  level.player thread play_loop_sound_on_entity("evt_pak_surv_notarget_lp");
}

init_interference_triggers() {
  array_thread(getentarray("sound_interference_trigger", "targetname"), ::interference_trigger_think);
}

interference_trigger_think() {
  level endon("anthem_surveillance_complete");

  while(true) {
    self waittill("trigger");
    self thread trigger_thread(level.player, ::push_interference_trigger, ::pop_interference_trigger);
  }
}

push_interference_trigger(ent, endon_string) {
  flag_set("anthem_player_in_interference");

  if(!isDefined(level.a_interference_trigger_stack))
    level.a_interference_trigger_stack = [];

  level.a_interference_trigger_stack[level.a_interference_trigger_stack.size] = self;
}

pop_interference_trigger(ent) {
  arrayremovevalue(level.a_interference_trigger_stack, self);

  if(level.a_interference_trigger_stack.size == 0)
    flag_clear("anthem_player_in_interference");
}

check_in_interference() {
  level endon("stop_surveillance");

  while(true) {
    flag_wait("anthem_player_in_interference");
    luinotifyevent(&"hud_pak_interference", 1, 1);
    flag_waitopen("anthem_player_in_interference");
    luinotifyevent(&"hud_pak_interference", 1, 0);
  }
}

launch_facial_recognition(ai_target) {
  level endon("stop_facial_recognition");
  level.player thread play_sound_on_entity("evt_pak_surv_cursor_starting");
  level.player thread play_loop_sound_on_entity("evt_surv_scan_dude");
  wait 2.0;
  level.player notify("stop soundevt_surv_scan_dude");
  level.player thread play_sound_on_entity("evt_surv_scan_affirm");
  wait 1.0;
  luinotifyevent(&"hud_pak_scan_complete", 1, ai_target getentitynumber());
  flag_set("anthem_facial_recognition_complete");
}

run_anim_to_idle(str_start_scene, str_idle_scene) {
  run_scene(str_start_scene);
  self thread run_scene(str_idle_scene);
}

run_anim_on_flag(str_flag, str_scene_name) {
  flag_wait(str_flag);
  self run_scene(str_scene_name);
}

debug_print_line(str_text) {
  iprintln(str_text);
}

spotlight_search_path(e_start_pos, n_speed, do_face, do_loop, e_target) {
  if(!isDefined(n_speed))
    n_speed = 384;

  if(!isDefined(do_face))
    do_face = 0;

  if(!isDefined(do_loop))
    do_loop = 1;

  if(!isDefined(e_target))
    e_target = undefined;

  self endon("stop_searching");
  e_current_pos = e_start_pos;
  e_previous_pos = undefined;

  if(!isDefined(e_target))
    e_target = spawn("script_origin", e_current_pos.origin);

  n_target_time = distance2dsquared(e_target.origin, e_current_pos.origin) / (n_speed * n_speed);

  if(n_target_time <= 0)
    n_target_time = 0.05;

  if(do_face)
    self setlookatent(e_target);

  self set_turret_target(e_target, undefined, 0);

  while(true) {
    e_target moveto(e_current_pos.origin, n_target_time);
    e_target waittill("movedone");

    if(isDefined(e_current_pos.script_int))
      wait(e_current_pos.script_int);

    if(isDefined(e_current_pos.target)) {
      e_previous_pos = e_current_pos;
      e_current_pos = getent(e_current_pos.target, "targetname");
    } else if(do_loop) {
      e_previous_pos = e_current_pos;
      e_current_pos = e_start_pos;
    } else
      break;

    n_target_time = distance2dsquared(e_previous_pos.origin, e_current_pos.origin) / (n_speed * n_speed);
    wait 0.05;
  }

  self notify("search_done");
}

play_fx_anim_on_trigger(str_targetname, str_notify, func_on_notify) {
  t_fx_anim = get_ent(str_targetname, "targetname", 1);
  b_is_damage_trigger = t_fx_anim.classname == "trigger_damage";
  b_trace = 1;
  b_played_fx_anim = 0;

  while(!b_played_fx_anim) {
    t_fx_anim trigger_wait();
    b_should_play_anim = !b_is_damage_trigger || level.player is_looking_at(t_fx_anim, 0.7, b_trace);

    if(b_should_play_anim) {
      level notify(str_notify);
      debug_print_line(str_targetname + " sending level notify: " + str_notify);
      b_played_fx_anim = 1;

      if(isDefined(func_on_notify))
        self thread[[func_on_notify]]();
    }
  }

  if(isDefined(t_fx_anim.target)) {
    e_lookat_target = get_ent(t_fx_anim.target, "targetname");

    if(isDefined(e_lookat_target))
      e_lookat_target delete();
  }

  waittillframeend;
  waittillframeend;

  if(isDefined(t_fx_anim))
    t_fx_anim delete();
}

is_underwater() {
  return self._swimming.is_underwater;
}

run_swimming_sheeting() {
  assert(isDefined(self._swimming), "must first call _swimming::main");

  if(!isDefined(self._swimming)) {
    return;
  }
  while(true) {
    while(!self is_underwater())
      wait 1.0;

    while(self is_underwater())
      wait 0.5;

    self setwatersheeting(1, 3.0);
    self setwaterdrops(50);

    for(time_waited_s = 0.0; time_waited_s < 3.0 && !self is_underwater(); time_waited_s = time_waited_s + 0.5)
      wait 0.5;

    self setwaterdrops(0);
  }
}

watch_player_rain_water_sheeting() {
  level.b_turn_off_sheeting_already_running = 0;

  while(true) {
    trigger = trigger_wait("water_sheeting_trigger");
    level.player setwatersheeting(1);
    level.player setwaterdrops(50);

    if(!level.b_turn_off_sheeting_already_running) {
      trigger thread watch_to_turn_off_water_sheeting();
      level.b_turn_off_sheeting_already_running = 1;
    }

    wait 1;
  }
}

watch_to_turn_off_water_sheeting() {
  while(level.player istouching(self))
    wait 0.05;

  level.b_turn_off_sheeting_already_running = 0;
  level.player setwatersheeting(1, 2);
  level.player setwaterdrops(0);
}

watch_water_vision() {
  level endon("start_defend_convoy");
  t_firewater = getent("trigger_firewater_room", "targetname");

  while(true) {
    self waittill("underwater");
    clientnotify("blur_yes");
    level.player setclientdvar("cg_aggressiveCullRadius", 400);

    if(self istouching(t_firewater))
      level thread maps\createart\pakistan_2_art::underground_fire_fx_vision();
    else
      level thread maps\createart\pakistan_2_art::vision_underwater_swimming();

    self waittill("surface");
    clientnotify("blur_no");
    self thread water_on_visor();
    level.player setclientdvar("cg_aggressiveCullRadius", 0);

    if(self istouching(t_firewater)) {
      level thread maps\createart\pakistan_2_art::above_water_fire_vision();
      self thread encourage_player_to_dive(t_firewater);
    } else if(self istouching(getent("millibar_vision_trigger", "targetname")))
      level thread maps\createart\pakistan_2_art::vision_millibar_room();
    else if(self istouching(getent("interrogation_vision_trigger", "targetname")))
      level thread maps\createart\pakistan_2_art::vision_torture_room();
    else
      level thread maps\createart\pakistan_2_art::turn_back_to_default();
  }
}

water_on_visor() {
  self setwatersheeting(1, 4);
  self setwaterdrops(100);
  wait 6;
  self setwaterdrops(0);
}

encourage_player_to_dive(t_firewater) {
  self endon("underwater");

  while(self istouching(t_firewater)) {
    if(flag("trainyard_millibar_grenades_warp_done"))
      self dodamage(10, self.origin);

    wait 0.2;
  }
}

trainyard_light_on() {
  flag_wait("railyard_player_millibar_approach");
  e_light = getent("grate_light", "targetname");
  e_light setlightintensity(level.n_intensity);
}

trainyard_light_off() {
  e_light = getent("grate_light", "targetname");
  level.n_intensity = e_light getlightintensity();
  e_light setlightintensity(0);
}

autoexec init_node_flags() {
  a_nodes = getallnodes();

  foreach(node in a_nodes) {
    if(isDefined(node.script_flag_wait)) {
      if(!level flag_exists(node.script_flag_wait))
        level flag_init(node.script_flag_wait);
    }

    if(isDefined(node.script_flag_set)) {
      if(!level flag_exists(node.script_flag_set))
        level flag_init(node.script_flag_set);
    }
  }
}

follow_path(nd_path) {
  self endon("death");
  self endon("stop_follow_path");
  self thread _stop_follow_path("stop_follow_path");
  assert(isDefined(self.targetname), "Must have a targetname to follow a path.");
  str_dont_stop_flag = self.targetname + "_dont_stop";

  if(!level flag_exists(str_dont_stop_flag))
    level flag_init(str_dont_stop_flag);

  if(!self flag_exists("walk_path_pause"))
    self ent_flag_init("walk_path_pause");

  a_path = [];

  while(isDefined(nd_path)) {
    a_path[a_path.size] = nd_path;

    if(isDefined(nd_path.target)) {
      if(isai(self))
        nd_path = getnode(nd_path.target, "targetname");
      else if(isDefined(self.classname) && self.classname == "script_vehicle")
        nd_path = getvehiclenode(nd_path.target, "targetname");

      e_trig = getent(nd_path.targetname, "target");

      if(isDefined(e_trig))
        nd_path thread follow_path_node_trigger_wait(e_trig);
    } else
      break;
  }

  if(isai(self)) {
    self.follow_path_old_forcecolor = self.script_forcecolor;
    disable_ai_color();
  }

  goal_radius = 20;
  max_dist_sq = 640000;
  sprint_dist_sq = 40000;

  foreach(nd_path in a_path) {
    self ent_flag_waitopen("walk_path_pause");

    if(isDefined(self.follow_path_skipto)) {
      if(!isDefined(nd_path.script_noteworthy) || nd_path.script_noteworthy != self.follow_path_skipto)
        continue;
    }

    self.follow_path_skipto = undefined;

    if(isDefined(nd_path.radius) && nd_path.radius != 0)
      self.goalradius = nd_path.radius;
    else
      self.goalradius = goal_radius;

    self notify("new_follow_node", nd_path);
    b_stop = nd_path should_stop_at_goal();

    if(isai(self)) {
      self.disablearrivals = !b_stop;
      self.perfectaim = 1;
      self force_goal(nd_path);
      self.perfectaim = 0;
      self.disablearrivals = 0;
    } else if(isDefined(self.classname) && self.classname == "script_vehicle") {
      self setvehgoalpos(nd_path.origin, b_stop);

      if(isDefined(nd_path.angles))
        self settargetyaw(nd_path.angles[1]);

      if(isDefined(nd_path.speed))
        self setspeed(nd_path.speed * 0.0568182);

      if(isDefined(nd_path.radius) && nd_path.radius != 0)
        self setneargoalnotifydist(nd_path.radius);
      else
        self setneargoalnotifydist(50);

      self waittill("near_goal");
    }

    self notify("reached_follow_node", nd_path);

    if(isDefined(nd_path.script_notify))
      self notify(nd_path.script_notify);

    if(isDefined(nd_path.script_ignoreall))
      self set_ignoreall(nd_path.script_ignoreall);

    if(isDefined(nd_path.script_flag_set))
      flag_set(nd_path.script_flag_set);

    if(nd_path flag_exists("trigger_wait") && !isgodmode(level.player))
      nd_path ent_flag_waitopen("trigger_wait");

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_aigroup))
        flag_wait_either(nd_path.script_aigroup + "_cleared", str_dont_stop_flag);
    }

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_flag_wait))
        flag_wait_either(nd_path.script_flag_wait, str_dont_stop_flag);
    }

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_waittill) && nd_path.script_waittill != "look_at")
        level waittill_either(nd_path.script_waittill, str_dont_stop_flag);
    }

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_wait))
        nd_path script_wait();
    }

    if(!flag(str_dont_stop_flag)) {
      if(isDefined(nd_path.script_run_scene))
        level run_scene(nd_path.script_run_scene);
    }
  }

  _stop_follow_path();
}

should_stop_at_goal() {
  if(flag_exists("trigger_wait") && !ent_flag("trigger_wait"))
    return true;

  if(isDefined(self.script_aigroup) && !flag(self.script_aigroup + "_cleared"))
    return true;

  if(isDefined(self.script_flag_wait) && !flag(self.script_flag_wait))
    return true;

  if(isDefined(self.script_waittill))
    return true;

  if(isDefined(self.script_wait))
    return true;

  return false;
}

_stop_follow_path(str_waittill) {
  self endon("death");
  self endon("_stop_follow_path");

  if(isDefined(str_waittill))
    self waittill(str_waittill);

  if(isai(self)) {
    enable_pain();
    set_ignoreall(0);

    if(isDefined(self.follow_path_old_forcecolor))
      enable_ai_color();
  }

  self notify("_stop_follow_path");
}

follow_path_node_trigger_wait(e_trig) {
  self ent_flag_init("trigger_wait", 1);
  e_trig trigger_wait();
  self ent_flag_clear("trigger_wait");
}

hide_post_grenade_room() {
  a_room_models_after = getentarray("gernade_room_after", "targetname");

  for(i = 0; i < a_room_models_after.size; i++)
    a_room_models_after[i] hide();
}

pakistan_move_mode(str_movemode) {
  self.pakistan_move_mode = 1;
  change_movemode(str_movemode);
}

pakistan_reset_movemode() {
  self.pakistan_move_mode = undefined;
  reset_movemode();
}

anim_magic_bullet_shield(ai) {
  ai magic_bullet_shield();
}

play_light_rumble(e_entity) {
  level.player playrumbleonentity("damage_light");
  earthquake(0.3, 0.5, level.player.origin, 1000, level.player);
}

datapad_rumble(m_player_body) {
  if(!isDefined(m_player_body))
    m_player_body = undefined;

  level.player playrumbleonentity("reload_clipout");
}

spawn_grenades_at_structs(str_struct) {
  a_s_spots = getstructarray(str_struct, "targetname");

  foreach(s_spot in a_s_spots) {
    e_temp = spawn("script_origin", s_spot.origin);
    e_temp magicgrenadetype("frag_grenade_sp", s_spot.origin, (0, 0, 0), 0.25);
    e_temp delete();
  }
}

ragdoll_corpse_control() {
  a_t_spawn_trigs = getentarray("corpse_spawn_trig", "targetname");
  array_thread(a_t_spawn_trigs, ::ragdoll_corpse_control_think);
}

ragdoll_corpse_control_think() {
  level endon("kill_corpse_control");
  str_target = self.target;
  self trigger_wait();
  delete_ragdoll_corpses(self.script_noteworthy);
  spawn_ragdoll_corpses_at_structs(str_target);
  wait 0.05;
}

spawn_ragdoll_corpses_at_structs(str_struct) {
  a_s_spots = getstructarray(str_struct, "targetname");
  i = 0;

  foreach(s_spot in a_s_spots) {
    if(i < 10) {
      m_body = spawn_script_model_at_struct(s_spot);
      m_body startragdoll();
      i++;
      continue;
    }

    println("Corpse Limit Hit");

  }
}

spawn_script_model_at_struct(s_start_spot) {
  m_script_model = spawn("script_model", s_start_spot.origin);

  if(cointoss())
    m_script_model setmodel("c_pak_civ_male_corpse1_fb");
  else
    m_script_model setmodel("c_pak_civ_male_corpse2_fb");

  m_script_model.angles = s_start_spot.angles;
  m_script_model.targetname = s_start_spot.targetname + "_model";
  return m_script_model;
}

delete_ragdoll_corpses(str_name) {
  sink_ragdoll_corpses(str_name);
  wait 0.25;
  a_m_corpses = getentarray(str_name, "targetname");
  array_delete(a_m_corpses);
}

sink_ragdoll_corpses(str_name) {
  a_m_corpses = getentarray(str_name, "targetname");

  foreach(m_corpse in a_m_corpses)
  m_corpse scalebuoyancy(0.9);
}

kill_ragdoll_corpse_control() {
  level notify("kill_corpse_control");
  a_s_spots = getstructarray("stealth_corpse_spot", "script_noteworthy");
  a_t_trigs = getentarray("corpse_spawn_trig", "targetname");

  foreach(s_spot in a_s_spots)
  s_spot structdelete();

  array_delete(a_t_trigs);
}

static_bodies_enable(str_scene_prefix, n_start_index, n_stop_index) {
  for(i = n_start_index; i <= n_stop_index; i++) {
    level thread run_scene_first_frame(str_scene_prefix + i);
    wait 0.1;
  }
}

static_bodies_disable(str_scene_prefix, n_start_index, n_stop_index) {
  a_s_align_spots = getstructarray("death_pose_align", "script_noteworthy");

  for(i = n_start_index; i <= n_stop_index; i++) {
    delete_scene_all(str_scene_prefix + i, 1, 0, 1);
    wait 0.1;
  }
}

drone_punisher_logic(s_goal) {
  self endon("death");
  self setforcenocull();
  self setspeed(75, 25, 20);
  n_zpos = self.origin[2] + (2100 - self.origin[2]);
  self setvehgoalpos(self.origin + (0, 0, n_zpos), 1);
  self waittill("goal");
  self play_fx("drone_spotlight_cheap", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), undefined, 1, "tag_spotlight");
  self set_turret_target(level.player, undefined, 0);
  self setvehgoalpos(getstruct(s_goal, "targetname").origin, 1);
  self waittill("goal");
  self setlookatent(level.player);
  self thread drone_punisher_fire();
}

drone_punisher_fire() {
  self endon("death");

  while(isalive(level.player)) {
    self thread fire_turret_for_time(3, 0);
    self shoot_turret_at_target(level.player, 1, (randomintrange(-200, 200), randomintrange(-200, 200), 0), randomintrange(1, 3));
    wait(randomfloatrange(3.5, 4.5));
  }
}

ambient_drone_punish() {
  self endon("death");
  flag_wait("player_detected");
  self setspeed(50, 25, 15);
  self setvehgoalpos(self.origin, 1);
  self setlookatent(level.player);
  self set_turret_target(level.player, undefined, 0);
  self thread fire_turret_for_time(-1, 0);

  while(isalive(level.player)) {
    self shoot_turret_at_target(level.player, 1, (randomintrange(-200, 200), randomintrange(-200, 200), 0), randomintrange(1, 3));
    wait(randomfloatrange(3.5, 4.5));
  }
}

kill_player_after_time() {
  wait 2;

  while(isalive(level.player)) {
    level.player dodamage(25, level.player.origin);
    wait 0.1;
  }
}

delete_ents_inside_trigger(str_trigger) {
  t_touching = getent(str_trigger, "targetname");
  t_touching delete_fxanims_touching();
  t_touching delete_vehicles_touching();
  t_touching delete_ents_touching("script_model");
  t_touching delete_ents_touching("script_origin");
  t_touching delete_ents_touching("trigger_radius");
  t_touching delete_spawners_touching();
  t_touching delete();
}

delete_fxanims_touching() {
  a_m_fxanims = getentarray("fxanim", "script_noteworthy");

  foreach(m_fxanim in a_m_fxanims) {
    if(m_fxanim istouching(self)) {
      m_fxanim.script_string = "delete_me";
      maps\_fxanim::fxanim_delete("delete_me", 1);
    }
  }
}

delete_vehicles_touching() {
  a_vh_vehicles = getvehiclearray("allies", "axis", "neutral");

  foreach(vh_vehicle in a_vh_vehicles) {
    if(vh_vehicle istouching(self)) {
      vh_vehicle.delete_on_death = 1;
      vh_vehicle notify("death");

      if(!isalive(vh_vehicle))
        vh_vehicle delete();
    }
  }
}

delete_ents_touching(str_class) {
  a_e_ents = getentarray(str_class, "classname");

  foreach(e_ent in a_e_ents) {
    if(e_ent istouching(self) && e_ent != self)
      e_ent delete();
  }
}

delete_spawners_touching() {
  a_sp_spawners = getspawnerteamarray("axis", "allies", "neutral");

  foreach(sp_spawner in a_sp_spawners) {
    if(sp_spawner istouching(self))
      sp_spawner delete();
  }
}

deconstruct_fxanims_in_trigger(str_trigger) {
  i = 0;
  a_str_fxanim_names = [];
  t_touching = getent(str_trigger, "targetname");
  a_m_fxanims = getentarray("fxanim", "script_noteworthy");

  foreach(m_fxanim in a_m_fxanims) {
    if(m_fxanim istouching(t_touching) && isDefined(m_fxanim.targetname) && m_fxanim.targetname != "fxanim_market_bus_crash" && m_fxanim.targetname != "fxanim_pak_sign_dangle") {
      a_m_each_fxanim_with_name = getentarray(m_fxanim.targetname, "targetname");

      foreach(m_each_fxanim in a_m_each_fxanim_with_name) {
        a_str_fxanim_names[i] = m_fxanim.targetname;
        i++;
        fxanim_deconstruct(m_fxanim.targetname);
      }
    }
  }

  return a_str_fxanim_names;
}

reconstruct_fxanims_from_list(a_str_names) {
  foreach(str_name in a_str_names) {
    s_m_each_fxanim_with_name = getstructarray(str_name, "targetname");

    foreach(s_fxanim in s_m_each_fxanim_with_name)
    fxanim_reconstruct(s_fxanim.targetname);
  }
}

skipt_model_convert_area(str_area) {
  level._struct_models = [];
  vol_area = getent(str_area, "targetname");
  model_convert_area(vol_area);
}

claw_run_over_enemy_watcher(str_notify_end) {
  if(!isDefined(str_notify_end))
    str_notify_end = undefined;

  self endon("death");
  self endon("delete");

  if(isDefined(str_notify_end))
    level endon(str_notify_end);

  a_str_hit_locs = array("torso_lower", "left_leg_lower", "right_leg_lower", "torso_upper");

  while(true) {
    a_ai_enemies = getaiarray("axis");

    foreach(ai_enemy in a_ai_enemies) {
      if(ai_enemy istouching(self) || distance2d(ai_enemy.origin, self.origin) <= 128)
        ai_enemy dodamage(ai_enemy.health + 150, (0, 0, 0), self, self, random(a_str_hit_locs), "hitbyobject");
    }

    wait 0.1;
  }
}

_claw_scripted_set_turret_target(e_target) {
  o_target = _get_fake_target(e_target);
  o_target.targetname = self.script_noteworthy + "_target";
  self.scripted_target = o_target;
}

_get_fake_target(e_target) {
  o_target = spawn("script_origin", e_target.origin);
  o_target linkto(e_target);
  return o_target;
}

_claw_scripted_fire_turret_at_target(str_notify) {
  if(!isDefined(str_notify))
    str_notify = undefined;

  self endon("death");
  self endon("delete");

  if(isDefined(str_notify))
    level endon(str_notify);

  n_fire_time = weaponfiretime(self.turret.weaponinfo);
  o_target = getent(self.script_noteworthy + "_target", "targetname");

  while(true) {
    if(self.turret can_turret_hit_target(o_target, 1))
      self.turret fire_turret(1);

    wait(n_fire_time);
  }
}

_claw_scripted_stop_turret() {
  o_target = getent(self.script_noteworthy + "_target", "targetname");
  self.scripted_target = undefined;
  self.turret maps\_turret::stop_turret();
  wait_network_frame();
  o_target delete();
}

ai_claw_walk_rumble() {
  self endon("death");
  self endon("delete");
  level endon("claw_walk_rumble_disable");

  while(true) {
    n_dist = distance2d(level.player.origin, self.origin);

    if(self is_claw_walking()) {
      if(n_dist <= 195 / 2) {
        earthquake(randomfloatrange(0.08, 0.12), 1, self.origin, 195, level.player);
        level.player rumble_loop(2, 1 / 2, "damage_light");
      }

      if(n_dist > 195 / 2 && n_dist <= 195) {
        earthquake(randomfloatrange(0.03, 0.07), 1, self.origin, 195, level.player);
        level.player rumble_loop(2, 1 / 2, "reload_clipout");
      }
    }

    wait 0.1;
  }
}

is_claw_walking() {
  v_velocity = self getvelocity();

  if(v_velocity[0] > 0 || v_velocity[1] > 0)
    return true;
  else
    return false;
}

_first_person_claw_flamethrower_fire_watch() {
  self endon("death");
  self endon("delete");

  while(true) {
    a_ai_enemies = getaiarray("axis");

    while(level.player adsbuttonpressed()) {
      self flamethrower_pick_target(a_ai_enemies);
      wait 0.25;
    }

    while(!level.player adsbuttonpressed())
      wait 0.1;
  }
}

flamethrower_pick_target(a_ai_enemies) {
  foreach(ai_enemy in a_ai_enemies) {
    a_trace = bullettrace(self gettagorigin("tag_flame_thrower_fx"), ai_enemy geteye(), 1, self, 1);

    if(distance2d(ai_enemy geteye(), a_trace["position"]) <= 300) {
      e_projectile = magicbullet("bigdog_flamethrower", a_trace["position"], ai_enemy.origin);
      break;
    }
  }
}

_gas_grenade_think(b_from_player) {
  self endon("death");
  level endon("menendez_near_plane");
  n_player_safe_distance_sq = 256;
  n_enemy_detect_dist_sq = 211600;

  while(isDefined(self)) {
    if(!b_from_player || distancesquared(get_players()[0].origin, self.origin) > n_player_safe_distance_sq) {
      a_enemies = getaiarray("axis");

      foreach(enemy in a_enemies) {
        if(distancesquared(enemy.origin, self.origin) < n_enemy_detect_dist_sq) {
          b_trace_pass = bullettracepassed(enemy geteye(), self.origin, 1, enemy);

          if(b_trace_pass) {
            self resetmissiledetonationtime(0);
            return;
          }
        }
      }
    }

    wait 0.05;
  }
}

ambient_vehicles_enable(str_node) {
  a_vnd_splines = getvehiclenodearray(str_node, "targetname");

  foreach(vnd_spline in a_vnd_splines) {
    vnd_spline thread ambient_vehicle_loop();
    wait(randomfloatrange(2, 2.53));
  }
}

ambient_vehicle_loop() {
  level endon("kill_ambient_vehicles");

  while(true) {
    self spawn_ambient_vehicle_and_drive();
    wait(randomfloatrange(1.2, 4.1));
  }
}

spawn_ambient_vehicle_and_drive(b_selfremove) {
  level endon("kill_ambient_vehicles");
  vh_vehicle = maps\_vehicle::spawn_vehicle_from_targetname(self.script_noteworthy);
  vh_vehicle.drivepath = 1;
  vh_vehicle.origin = self.origin;
  vh_vehicle.script_noteworthy = "ambient_enemy_vehicle";
  vh_vehicle veh_magic_bullet_shield(1);
  vh_vehicle maps\_utility::go_path(self);
  wait_network_frame();

  if(!isDefined(b_selfremove) || b_selfremove == 1) {
    vh_vehicle.delete_on_death = 1;
    vh_vehicle notify("death");

    if(!isalive(vh_vehicle))
      vh_vehicle delete();
  }
}

waittill_zero_enemies() {
  while(true) {
    a_ai_enemies = getaiarray("axis");

    if(a_ai_enemies.size < 1) {
      break;
    }

    wait 0.1;
  }
}

is_claw_flamethrower_unlocked() {
  return level.player get_temp_stat(3);
}

get_random_vector_range(n_min, n_max) {
  return (randomfloatrange(n_min, n_max), randomfloatrange(n_min, n_max), randomfloatrange(n_min, n_max));
}

objects_to_vectors() {
  i = 0;
  a_v_spots = undefined;
  v_spot = undefined;

  foreach(s_spot in self) {
    a_v_spots[i] = s_spot.origin;
    i++;
  }

  return a_v_spots;
}

delete_structs(str_value, str_key) {
  s_a_structs = getstructarray(str_value, str_key);

  foreach(s_struct in s_a_structs)
  s_struct structdelete();
}

say_vo_fake_ent(str_vo, n_delay) {
  a_ai_guys = getaiarray("axis");

  if(a_ai_guys.size)
    e_fake_vo = spawn("script_origin", a_ai_guys[randomint(a_ai_guys.size)].origin + vectorscale((0, 0, 1), 50.0));
  else
    e_fake_vo = spawn("script_origin", level.player.origin + (0, 200, 50));

  e_fake_vo say_dialog(str_vo, n_delay, 1);
  e_fake_vo delete();
}

radial_damage_from_spot(str_spot, n_delay) {
  if(isDefined(n_delay))
    wait(n_delay);

  if(isDefined(str_spot)) {
    center = getstruct(str_spot, "targetname");
    n_radius = center.radius;
  }

  if(!isDefined(center)) {
    center = self;
    n_radius = center.radius / 2;
  }

  radiusdamage(center.origin, n_radius, 1000, 900);
}

dont_prone_while_touching(str_ent) {
  self endon("allow_prone");
  player_flag_init("player_in_water");
  e_no_prone = getent(str_ent, "targetname");

  while(true) {
    if(!self istouching(e_no_prone) && player_flag("player_in_water")) {
      player_flag_clear("player_in_water");
      self allow_prone(1);
    }

    e_no_prone trigger_wait();

    if(!player_flag("player_in_water")) {
      player_flag_set("player_in_water");
      self allow_prone(0);
    }

    while(self istouching(e_no_prone))
      wait 0.5;

    wait 0.2;
  }
}

dont_prone_while_touching_kill() {
  self notify("allow_prone");
  t_no_prone = getent("no_prone_trigger", "targetname");
  player_flag_clear("player_in_water");
  self allow_prone(1);
  wait_network_frame();
  t_no_prone delete();
}

allow_prone(b_can_prone) {
  self allowprone(b_can_prone);
  self allow_divetoprone(b_can_prone);
}

ambient_flight_path(s_start) {
  level endon("player_detected");
  self endon("vehicle_stop");
  self endon("death");
  self setforcenocull();
  wait 0.1;
  self thread ambient_drone_searchlight();
  self thread ambient_drone_punish();
  self setspeed(15, 10, 5);
  self setvehgoalpos(s_start.origin, 0);
  self waittill("goal");

  if(isDefined(s_start.target))
    s_next_pos = getstruct(s_start.target, "targetname");

  if(isDefined(s_next_pos)) {
    v_next_pos = s_next_pos.origin;

    while(true) {
      self setspeed(15, 10, 5);
      self setvehgoalpos(v_next_pos, 0);
      self waittill("goal");

      if(isDefined(s_next_pos.target)) {
        s_next_pos = getstruct(s_next_pos.target, "targetname");
        v_next_pos = s_next_pos.origin;
      } else {
        self.spotlight delete();
        self.delete_on_death = 1;
        self notify("death");

        if(!isalive(self))
          self delete();
      }
    }
  }
}

ambient_drone_searchlight() {
  e_spotlight_target = spawn("script_model", self.origin);
  e_spotlight_target setmodel("tag_origin");
  e_spotlight_target linkto(self, "tag_origin");
  self.spotlight = e_spotlight_target;
  self set_turret_target(e_spotlight_target, anglestoforward(self.angles) * 800 + vectorscale((0, 0, -1), 500.0), 0);
  self play_fx("drone_spotlight_cheap", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), "kill_spotlight", 1, "tag_spotlight");
}

pakistan_deconstruct_ents() {
  level.a_str_frogger_names = deconstruct_fxanims_in_trigger("frogger_fxanim_cleanup_trig");
  level.a_str_behind_bus_names = deconstruct_fxanims_in_trigger("street_behind_bus_trig");
  level.a_str_bus_dam_names = deconstruct_fxanims_in_trigger("bus_dam_fxanim_cleanup_trig");
  level.a_str_sewer_names = deconstruct_fxanims_in_trigger("sewer_fxanim_cleanup_trig");
  pakistan_deconstruct_models();
  pakistan_reconstruct_ents();
}

pakistan_deconstruct_models() {
  model_convert_areas();
  wait_network_frame();
  a_vol_convert = get_ent_array("model_convert", "targetname");
  array_delete(a_vol_convert);
}

pakistan_reconstruct_ents() {
  level thread frogger_reconstruct_ents();
  level thread bus_dam_reconstruct_ents();
  level thread stealth_reconstruct_ents();
  level thread sewer_reconstruct_ents();
}

frogger_reconstruct_ents(a_string_list) {
  flag_wait("bus_smash_go");
  reconstruct_fxanims_from_list(level.a_str_frogger_names);
  level.a_str_frogger_names = undefined;
  flag_wait("vo_street_killzone");
  model_restore_area("zone_frogger");
}

bus_dam_reconstruct_ents() {
  flag_wait("frogger_done");
  model_restore_area("zone_bus_dam");
  reconstruct_fxanims_from_list(level.a_str_behind_bus_names);
  reconstruct_fxanims_from_list(level.a_str_bus_dam_names);
  level.a_str_behind_bus_names = undefined;
  level.a_str_bus_dam_names = undefined;
}

stealth_reconstruct_ents() {
  flag_wait("bus_dam_gate_success_started");
  model_restore_area("zone_stealth");
  flag_set("zone_stealth_restored");
}

sewer_reconstruct_ents() {
  reconstruct_fxanims_from_list(level.a_str_sewer_names);
  flag_wait("player_entered_bank");
  level.a_str_sewer_names = undefined;
  model_restore_area("zone_sewer");
  sewer_gate_clip_setup();
}

sewer_gate_clip_setup() {
  bm_gate_clip = get_ent("sewer_gate_clip", "targetname", 1);
  m_gate = get_ent("sewer_entry_gate", "targetname", 1);
  bm_gate_clip linkto(m_gate, "j_hinge");
}

market_corpse_control() {
  level endon("frogger_started");

  while(true) {
    a_m_corpses = getcorpsearray();

    foreach(m_corpse in a_m_corpses) {
      if(isDefined(m_corpse)) {
        if(a_m_corpses.size > 2) {
          m_corpse thread corpse_sink_and_delete(0.9, 2);
          continue;
        }

        if(self get_dot_from_eye(m_corpse.origin, 1) < 0.91)
          m_corpse thread corpse_sink_and_delete(0.9, 0.5);
      }
    }

    wait 0.2;
  }
}

frogger_corpse_control() {
  t_sinkhole = getent("sinkhole_kill_trigger", "targetname");
  t_behind_bus = getent("street_behind_bus_trig", "targetname");

  while(true) {
    if(flag("bus_dam_gate_push_setup_started")) {
      break;
    }

    a_m_corpses = getcorpsearray();

    foreach(m_corpse in a_m_corpses) {
      if(isDefined(m_corpse)) {
        if(a_m_corpses.size > 5) {
          m_corpse thread corpse_sink_and_delete(0.9, 2);
          continue;
        }

        if(self get_dot_from_eye(m_corpse.origin, 1) < 0.8) {
          m_corpse thread corpse_sink_and_delete(0.9, 0.5);
          continue;
        }

        if(m_corpse istouching(t_sinkhole) || m_corpse istouching(t_behind_bus))
          m_corpse thread corpse_sink_and_delete(0.9, 2);
      }
    }

    wait 0.2;
  }

  t_sinkhole delete();
  t_behind_bus delete();
}

corpse_sink_and_delete(n_buoyancy, n_time) {
  if(isDefined(self))
    self scalebuoyancy(n_buoyancy);

  wait(n_time);

  if(isDefined(self))
    self delete();
}

disable_player_weapon_fire_for_time(n_wait) {
  level.player disableweaponfire();
  wait(n_wait);
  level.player enableweaponfire();
}

claw_data_glove_on(m_player_body) {
  e_hint = createstreamerhint(level.player.origin, 1.0);
  e_hint linkto(m_player_body, "tag_origin", vectorscale((0, 0, 1), 8.0));
  m_player_body attach("c_usa_cia_claw_viewbody_vson", "J_WristTwist_LE");
  wait 5;
  e_hint delete();
}

data_glove_animation(str_weapon) {
  self enableinvulnerability();
  self disableweaponcycling();
  self disableweaponfire();
  self disableoffhandweapons();

  for(str_current_weapon = level.player getcurrentweapon(); str_current_weapon == "none"; str_current_weapon = level.player getcurrentweapon())
    wait 1;

  self giveweapon(str_weapon);
  self switchtoweapon(str_weapon);
  self waittill("weapon_change_complete");
  self switchtoweapon(str_current_weapon);
  wait 0.2;
  self takeweapon(str_weapon);
  self enableweaponcycling();
  self enableweaponfire();
  self enableoffhandweapons();
  self disableinvulnerability();
}