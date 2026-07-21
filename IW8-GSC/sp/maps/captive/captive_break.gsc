/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_break.gsc
***********************************************/

break_flags() {
  scripts\engine\utility::flag_init("thirsty_awake");
  scripts\engine\utility::flag_init("allow_coughs");
  scripts\engine\utility::flag_init("doing_question_nag");
  scripts\engine\utility::flag_init("intro_vo_done");
  scripts\engine\utility::flag_init("in_bed");
  scripts\engine\utility::flag_init("hadir_idling");
  scripts\engine\utility::flag_init("near_hadir");
  scripts\engine\utility::flag_init("safe_key_catch");
  scripts\engine\utility::flag_init("took_key");
  scripts\engine\utility::flag_init("barkov_entered_cell");
  scripts\engine\utility::flag_init("near_cell_door");
  scripts\engine\utility::flag_init("heading_to_corner");
  scripts\engine\utility::flag_init("barkov_arrived_at_corner");
  scripts\engine\utility::flag_init("barkov_telling_face_wall");
  scripts\engine\utility::flag_init("told_to_face_wall");
  scripts\engine\utility::flag_init("facing_wall");
  scripts\engine\utility::flag_init("corner_vo_started");
  scripts\engine\utility::flag_init("corner_vo_done");
  scripts\engine\utility::flag_init("barkov_began_order_turn_to_face");
  scripts\engine\utility::flag_init("barkov_ordered_turn_to_face");
  scripts\engine\utility::flag_init("barkov_killing_player");
  scripts\engine\utility::flag_init("barkov_performing_action");
  scripts\engine\utility::flag_init("squatting");
  scripts\engine\utility::flag_init("clear_blur_fx");
  scripts\engine\utility::flag_init("tried_stealing_stunstick");
  scripts\engine\utility::flag_init("paused_squat_override");
  scripts\engine\utility::flag_init("obstructing_cell_exit");
  scripts\engine\utility::flag_init("henchman_reached_escort_start");
  scripts\engine\utility::flag_init("barkov_reached_escort_start");
  scripts\engine\utility::flag_init("in_cell");
  scripts\engine\utility::flag_init("entering_opposite_cell");
  scripts\engine\utility::flag_init("entering_own_cell");
  scripts\engine\utility::flag_init("approaching_wb_room");
  scripts\engine\utility::flag_init("did_shove_comment");
  scripts\engine\utility::flag_init("henchman_in_doorway");
  scripts\engine\utility::flag_init("reached_waterboard_room");
  scripts\engine\utility::flag_init("entered_chair");
  scripts\engine\utility::flag_init("has_done_question_nag");
  scripts\engine\utility::flag_init("waterboard_allow_move");
  scripts\engine\utility::flag_init("is_pouring");
  scripts\engine\utility::flag_init("jerrycan_reached_center");
  scripts\engine\utility::flag_init("pouring_finished");
  scripts\engine\utility::flag_init("started_passout_countdown");
  scripts\engine\utility::flag_init("passed_out");
  scripts\engine\utility::flag_init("moved_head");
  scripts\engine\utility::flag_init("is_waterboard_tutorial");
  scripts\engine\utility::flag_init("done_waterboard_tutorial");
  scripts\engine\utility::flag_init("waterboard_in_safe_zone");
  scripts\engine\utility::flag_init("took_breath");
  scripts\engine\utility::flag_init("has_taken_first_breath");
  scripts\engine\utility::flag_init("final_waterboard");
  scripts\engine\utility::flag_init("waterboard_complete");
  scripts\engine\utility::flag_init("saved_azadeh");
  scripts\engine\utility::flag_init("barkov_playing_nag");
  scripts\engine\utility::flag_init("escaped_shackles");
  scripts\engine\utility::flag_init("exited_cell");
}

break_precache() {
  precachemodel("accessory_un_shackle_01");
  precachemodel("accessory_un_shackle_02");
  precachemodel("body_villain_barkov_captive_gloves");
  precachemodel("head_villain_barkov_blendshape");
  precachemodel("barkov_canteen");
  precachemodel("weapon_vm_me_spoon");
  precachemodel("uk_misc_hand_towel_dirty_03");
  precachemodel("military_stun_gun_baton_01");
  precachemodel("tool_jerry_can_01");
  precachemodel("dynlt_ind_flood_light_standing_tall_off");
}

break_start() {
  break_setup();
}

break_intro_main() {
  level.player setclienttriggeraudiozone("cap_cell_farah_intro", 0.05);
  thread scripts\sp\maps\captive\captive_lighting.gsc::cells_cascade();
  level.player lerpfovscalefactor(0, 0);
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);
  level.eyeshutoverlay.lowresbackground = 1;
  level.breakanimref scripts\sp\player_rig::link_player_to_rig("bed_idle", "stand", 0, 0, 0, 40, 40, 40, 40, 1, ::attach_shackles_to_rig);
  level.player_rig_shadow = scripts\engine\sp\utility::spawn_anim_model("player_rig_shadow");
  level.breakanimref thread scripts\common\anim::anim_loop([level.player_rig, level.player_rig_shadow], "bed_idle", "end_idle");
  var_0 = scripts\engine\utility::getStruct("hadir_spawn", "targetname");
  level.hadir = scripts\engine\sp\utility::spawn_targetname("hadir");
  level.hadir attach("accessory_un_shackle_02", "j_gun");
  level.key = scripts\engine\sp\utility::spawn_anim_model("key", (0, 0, 0), (0, 0, 0));
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("hadir_cell");
  level.celldoorclip = getEnt("clip_cell_door", "targetname");
  level.breakanimref thread scripts\common\anim::anim_loop([level.hadir, level.key], "break_intro_start_idle", "end_idle");
  setomnvar("ui_hide_hud", 0);
  thread audio_intro_mix();
  wait 7;
  setomnvar("ui_hide_hud", 1);
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_intro_hadir_calls_out();
  level.player thread thirsty_tired_effects();
  level.player thread thirsty_wake_timer(3.5);
  scripts\sp\maps\captive\captive_lighting.gsc::explore_dof();
  wake_up();
  var_1 = 0;
  scripts\engine\utility::flag_set("in_bed");
  level.breakanimref notify("end_idle");
  level thread hadir_wakeup_react();
  level waittill("allow_movement");

  while(scripts\engine\utility::flag("in_bed")) {
    level thread check_for_get_up();
    level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(randomfloatrange(4, 8));
    var_2 = level scripts\engine\utility::waittill_any_return("get_up", "timeout");
    level notify("kill_checks");

    if(var_2 == "get_up") {
      play_bed_exit("exit_bed_tired", scripts\sp\maps\captive\captive_vo.gsc::vo_break_exit_bed);
      level.player scripts\common\utility::allow_sprint(0, "cell_movement");
      level.player.currentspeedscale = 0.25;
      level.player setmovespeedscale(level.player.currentspeedscale);
      scripts\engine\utility::flag_clear("in_bed");
      continue;
    }

    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_intro_hadir_beckon_from_bed(var_1);
    var_1++;
  }

  level notify("kill_get_up_checks");
  level thread shackled_squat_override();
  level thread player_tired_movement();
  wait 0.2;
  do_cough();
  scripts\sp\maps\captive\captive_lighting.gsc::hadir_dof();
  scripts\engine\utility::flag_wait("hadir_idling");
  var_1 = 0;

  while(!scripts\engine\utility::flag("near_hadir")) {
    scripts\engine\utility::flag_wait_or_timeout("near_hadir", randomfloatrange(4, 8));

    if(!scripts\engine\utility::flag("near_hadir")) {
      level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_intro_hadir_beckon_to_bars(var_1);
      var_1++;
    }
  }

  scripts\engine\utility::flag_waitopen("hadir_speaking");
  level.breakanimref notify("end_idle");
  level.breakanimref scripts\common\anim::anim_single([level.hadir, level.key], "break_intro_toss_start");
  level.breakanimref thread scripts\common\anim::anim_loop([level.hadir, level.key], "break_intro_toss_idle", "end_idle");
  level thread check_show_take_key_cursor();
  var_1 = 0;
  var_3 = 0;

  while(!scripts\engine\utility::flag("took_key")) {
    level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(randomfloatrange(4, 8));
    level.hadir thread scripts\sp\maps\captive\captive_util.gsc::check_item_interact();
    var_4 = level scripts\engine\utility::waittill_any_return("item_interact", "timeout");
    level notify("kill_checks");

    if(var_4 == "item_interact") {
      scripts\engine\utility::flag_set("took_key");
      scripts\sp\maps\captive\captive_lighting.gsc::key_dof();
      continue;
    }

    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_intro_hadir_key_beckon(var_1);
    var_1++;
  }

  scripts\engine\utility::flag_waitopen("hadir_speaking");
  spawn_barkov();
  spawn_henchman();
  spawn_henchman2();
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_barkov_intro();
  level thread notetrack_listener_cattleprod_shock_player_at_gate();
  scripts\engine\utility::flag_set("ignore_efforts");
  thread scripts\engine\utility::play_sound_in_space("cap_cells_010_cellmate_approach_enemies_predoorway", (5969, 967, -91));
  thread clear_shackled_squat_override();
  level.breakanimref thread scripts\sp\player_rig::link_player_to_rig("break_intro_barkov_arrives", "stand", 1, 0.5, undefined, undefined, undefined, undefined, undefined, 1, ::attach_shackles_to_rig);
  level.breakanimref notify("end_idle");
  var_5 = [level.hadir, level.henchman, level.henchman2];
  var_5 thread scripts\sp\maps\captive\captive_util.gsc::play_group_single_anim_into_idle_anim(level.breakanimref, "break_intro_barkov_arrives", "break_intro_arrival_idle", "end_barkov_arrives_idle");
  level thread barkov_play_anime_into_idle("break_intro_barkov_arrives", "break_intro_arrival_idle");
  level.breakanimref scripts\common\anim::anim_single([level.player_rig, level.key], "break_intro_barkov_arrives");
  scripts\sp\player_rig::unlink_player_from_rig();
  level.key delete();
  level thread shackled_squat_override();
  level thread wait_hide_key();
  scripts\sp\maps\captive\captive_lighting.gsc::hadir_dof();
  level thread change_to_barkov_dof();

  if(scripts\sp\maps\captive\captive_util.gsc::should_skip_torture_scene()) {
    wait 18;
    scripts\engine\utility::flag_clear("ignore_efforts");
    thread scripts\sp\hud_util::fade_out(1);
    wait 2;
    level notify("cancel_barkov_actions");
    level.breakanimref notify("end_barkov_idle");
    level.barkov.fakepapa unlink();
    level.barkov.fakepapa delete();
    level.barkov delete();

    foreach(var_7 in var_5) {
      var_7 notify("kill_self_anim_instructions");
      var_7 delete();
    }

    thread clear_shackled_squat_override();
    wait 2;
    thread scripts\sp\hud_util::fade_in(1);
    return;
  } else {
    level waittill("barkov_anime_ended");
    scripts\engine\utility::flag_clear("ignore_efforts");
  }

  if(scripts\engine\utility::flag("near_cell_door")) {
    barkov_play_anime_into_idle("break_intro_arrival_nag", "break_intro_arrival_idle");

    if(scripts\engine\utility::flag("near_cell_door")) {
      level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(2.5);
      level thread check_stepped_back_from_bars();
      var_9 = level scripts\engine\utility::waittill_any_return("stepped_back", "timeout");
      level notify("kill_checks");
      scripts\engine\utility::flag_set("barkov_entered_cell");

      if(var_9 == "timeout") {
        level thread notetrack_listener_cattleprod_shock_player(scripts\engine\utility::getStruct("cell_center", "targetname"));
        barkov_play_anime_into_idle("break_intro_shock_at_gate", "break_intro_arrival_idle");
      }
    }
  }

  level.henchman notify("kill_self_anim_instructions");
  level thread test_shock_as_entering_cell();
  level.henchman thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.breakanimref, "break_intro_enter_cell", "break_intro_cell_idle", "end_cell_idle");
  level thread hadir_dragged_away();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("main_cell");
  barkov_play_anime_into_idle("break_intro_enter_cell", "break_intro_cell_idle");
  level notify("entered_cell");
  thread scripts\engine\sp\utility::autosave_by_name_silent("break_orders");
  thread scripts\sp\analytics::analytics_kleenex_update("Intro");
  level thread scripts\sp\maps\captive\captive_util.gsc::enable_cell_door_collision();
}

audio_intro_mix() {
  wait 0.8;
  level.player setsoundsubmix("iw8_captive_start_1", 1.0);
  wait 1.0;
  level.player setclienttriggeraudiozone("cap_cell_farah_intro_2", 0.1);
  wait 8;
  level.player clearsoundsubmix("iw8_captive_start_1", 3);
  level waittill("farahgetupchangeaudio");
  level.player clearclienttriggeraudiozone(2.0);
  wait 6;
  wait 11;
  level.player clearclienttriggeraudiozone(10.0);
}

break_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  level.breakanimref = scripts\engine\utility::getStruct("cell_center", "targetname");

  if(!scripts\sp\starts::is_after_start("basement_stealth"))
    thread scripts\sp\maps\captive\captive_lighting.gsc::cells_cascade();

  level thread scripts\sp\maps\captive\captive_util.gsc::enable_cell_door_collision();
}

hadir_wakeup_react() {
  level.breakanimref scripts\common\anim::anim_single([level.hadir, level.key], "break_intro_start_react");
  level.breakanimref thread scripts\common\anim::anim_loop([level.hadir, level.key], "break_intro_react_idle", "end_idle");
  scripts\engine\utility::flag_set("hadir_idling");
}

#using_animtree("script_model");

wait_hide_key() {
  level waittill("hide_key");
  scripts\engine\utility::flag_set("paused_squat_override");
  waitframe();
  var_0 = scripts\engine\sp\utility::spawn_anim_model("shackles", level.player.origin);
  var_1 = scripts\engine\sp\utility::spawn_anim_model("key", level.player.origin);
  var_0 notsolid();
  var_0 linktoplayerview(level.player, "j_wrist_le", (0, 0, 0), (0, 0, 0), 0, "none");
  var_0 setanim(%cap_vm_gesture_hide_shackles);
  var_1 notsolid();
  var_1 linktoplayerview(level.player, "j_wrist_le", (0, 0, 0), (0, 0, 0), 0, "none");
  var_1 setanim(%cap_vm_gesture_hide_keys);
  setsaveddvar("NMLOKNMRSK", 1);
  level.player forceplaygestureviewmodel("cap_vm_gesture_hide_key");
  wait 2;
  scripts\engine\utility::flag_clear("paused_squat_override");
  setsaveddvar("NMLOKNMRSK", 0);
  var_0 delete();
  var_1 delete();
}

change_to_barkov_dof() {
  wait 17;
  scripts\sp\maps\captive\captive_lighting.gsc::barkov_dof();
}

check_show_take_key_cursor() {
  level endon("took_key");

  for(;;) {
    while(level.player getstance() == "prone" || !scripts\engine\utility::flag("safe_key_catch"))
      waitframe();

    level.hadir thread scripts\sp\player\cursor_hint::create_cursor_hint("j_wrist_ri", (0, 0, 0), &"CAPTIVE/CURSOR_TAKE", 180, 200, 150, 1);

    while(level.player getstance() != "prone" && scripts\engine\utility::flag("safe_key_catch"))
      waitframe();

    level.hadir scripts\sp\player\cursor_hint::remove_cursor_hint();
  }
}

hadir_dragged_away() {
  level.hadir notify("kill_self_anim_instructions");
  level.henchman2 notify("kill_self_anim_instructions");
  level.breakanimref notify("end_barkov_arrives_idle");
  level.breakanimref scripts\common\anim::anim_single([level.hadir, level.henchman2], "break_intro_enter_cell");
  level.hadir delete();
  level.henchman2 delete();
}

check_stepped_back_from_bars() {
  level endon("kill_checks");
  scripts\engine\utility::flag_waitopen("near_cell_door");
  level notify("stepped_back");
}

test_shock_as_entering_cell() {
  level endon("entered_cell");
  level waittill("barkov_entering_cell");
  var_0 = scripts\engine\utility::getStruct("cell_door_target", "targetname");
  var_1 = scripts\engine\utility::getStructArray("cell_enter_knockback_check", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("near_cell_door")) {
      var_2 = vectortoangles(level.player.origin - var_0.origin);
      var_3 = anglesToForward(var_2);
      var_4 = anglesToForward(var_0.angles);
      var_5 = vectordot(var_3, var_4);

      if(var_5 < 0) {
        if(distance2d(level.player.origin, level.barkov.origin) < 24 || distance2d(level.player.origin, var_0.origin) < distance2d(level.barkov.origin, var_0.origin)) {
          var_6 = scripts\engine\utility::getclosest(level.player.origin, var_1, 1000);
          level thread barkov_perform_partial_shock(1, scripts\engine\utility::getStruct("cell_center", "targetname"), 1, 2, 1);
          wait 2;
        }
      }
    }

    waitframe();
  }
}

break_orders_start() {
  break_setup();
  level.celldoorclip = getEnt("clip_cell_door", "targetname");
  scripts\engine\utility::flag_set("thirsty_awake");
  level.player thread thirsty_tired_effects();
  level thread player_tired_movement();
  level thread shackled_squat_override();
  level.player scripts\common\utility::allow_sprint(0, "cell_movement");
  spawn_barkov();
  spawn_henchman();
  scripts\sp\maps\captive\captive_util.gsc::cellblock_open_door(1);
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.barkov, "break_intro_cell_idle", "end_barkov_idle");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.henchman, "break_intro_cell_idle", "end_cell_idle");
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.eyeshutoverlay.lowresbackground = 1;
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("main_cell");
}

break_orders_main() {
  level.player enableweapons();
  var_0 = 0;
  var_1 = 0;
  var_2 = getEnt("bottom_right_corner", "targetname");
  var_3 = scripts\engine\utility::getStruct("cell_center", "targetname");
  var_4 = 0;
  var_5 = 0;
  wait 0.4;

  if(level.player istouching(var_2))
    barkov_play_anime_into_idle("break_exercise_stay_corner", "break_intro_cell_idle");
  else
    barkov_play_anime_into_idle("break_exercise_order_corner", "break_intro_cell_idle");

  var_6 = "";
  var_7 = 0;
  var_8 = "";
  var_9 = 0;
  var_10 = 0;
  var_11 = scripts\engine\utility::getStructArray("going_behind_kb", "script_noteworthy");

  if(!scripts\engine\utility::flag("heading_to_corner")) {
    level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(5);
    level thread check_corner_enter(var_8);
    level thread check_player_too_close();
    level thread check_going_behind_barkov();
    var_12 = level scripts\engine\utility::waittill_any_return("heading_to_corner", "bottom_left_corner", "top_left_corner", "top_right_corner", "got_too_close", "going_behind", "timeout");
    level notify("kill_checks");

    if(var_12 == "going_behind") {
      barkov_perform_shock();
      var_10 = gettime();
    } else if(scripts\engine\utility::time_has_passed(var_10, 4) && (var_12 == "bottom_left_corner" || var_12 == "top_left_corner" || var_12 == "top_right_corner")) {
      var_8 = var_12;
      scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_not_that_corner(var_7);
      scripts\engine\utility::flag_waitopen("barkov_killing_player");

      if(var_6 != "top_right_corner")
        barkov_perform_shock();

      var_7++;
      var_10 = gettime();
    } else if(scripts\engine\utility::time_has_passed(var_10, 4) && (var_12 == "timeout" || var_12 == "got_too_close")) {
      scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_goto_corner_nag();
      scripts\engine\utility::flag_waitopen("barkov_killing_player");

      if(distance(level.player.origin, level.barkov.origin) < 120) {
        barkov_perform_shock();
        var_10 = gettime();
      } else
        barkov_play_anime_into_idle("break_exercise_give_order_at_back", "break_intro_cell_idle");
    }
  }

  while(!var_9) {
    level thread check_corner_enter(var_8);
    level thread check_player_too_close();
    level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(5);
    level thread check_going_behind_barkov();
    var_6 = level scripts\engine\utility::waittill_any_return("bottom_left_corner", "top_left_corner", "bottom_right_corner", "top_right_corner", "got_too_close", "going_behind", "timeout");
    level notify("kill_checks");

    if(var_6 == "bottom_right_corner") {
      var_9 = 1;
      continue;
    }

    if(var_6 == "going_behind") {
      var_13 = scripts\engine\utility::getclosest(level.player.origin, var_11);
      barkov_perform_shock(var_13, 1, 1);
      var_10 = gettime();
      continue;
    }

    if(scripts\engine\utility::time_has_passed(var_10, 4) && (var_6 == "bottom_left_corner" || var_6 == "top_left_corner" || var_6 == "top_right_corner")) {
      var_8 = var_6;
      scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_not_that_corner(var_7);
      scripts\engine\utility::flag_waitopen("barkov_killing_player");

      if(var_6 != "top_right_corner") {
        barkov_perform_shock();
        var_10 = gettime();
      }

      var_7++;
      continue;
    }

    if(scripts\engine\utility::time_has_passed(var_10, 4) && (var_6 == "timeout" || var_6 == "got_too_close")) {
      level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_goto_corner_nag();
      scripts\engine\utility::flag_waitopen("barkov_killing_player");

      if(distance(level.player.origin, level.barkov.origin) < 120) {
        barkov_perform_shock();
        var_10 = gettime();
        continue;
      }

      barkov_play_anime_into_idle("break_exercise_give_order_at_back", "break_intro_cell_idle");
    }
  }

  level thread barkov_move_to_corner();
  visionsetnaked("captive_hero", 13);
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_play_corner_dialog();
  level.dovofacingwait = 0;
  level.dovofacingwaittime = 0;

  while(!scripts\engine\utility::flag("corner_vo_done")) {
    if(scripts\engine\utility::flag("barkov_killing_player"))
      waitframe();
    else if(!level.player istouching(var_2)) {
      scripts\engine\utility::flag_clear("facing_wall");

      if(!scripts\engine\utility::flag("barkov_telling_face_wall")) {
        scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
        scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_left_corner_nag();
        scripts\engine\utility::flag_waitopen("barkov_killing_player");
      }

      if(scripts\engine\utility::flag("barkov_arrived_at_corner") && !scripts\engine\utility::flag("barkov_telling_face_wall"))
        barkov_perform_shock(scripts\engine\utility::getStruct("corner_knockback_pos", "targetname"), 1, 2);
      else
        level thread barkov_perform_partial_shock(1, scripts\engine\utility::getStruct("corner_knockback_pos", "targetname"), 1, 2);

      var_1++;
      wait 2;

      if(scripts\engine\utility::flag("told_to_face_wall")) {
        if(!scripts\engine\utility::flag("done_face_after_move_reminder"))
          level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_remind_dont_face_after_move();

        var_5 = gettime();
      }
    } else if(level.player scripts\engine\math::is_point_in_front(var_3.origin)) {
      scripts\engine\utility::flag_clear("facing_wall");

      if(scripts\engine\utility::flag("barkov_arrived_at_corner")) {
        if((gettime() - var_5) / 1000 > 7) {
          scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
          waitframe();

          if(scripts\engine\utility::flag("told_to_face_wall")) {
            scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
            scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_facewall_nag(var_0);
            var_0++;
            scripts\engine\utility::flag_waitopen("barkov_killing_player");
            barkov_perform_shock();
            level.dovofacingwaittime = gettime();
            level.dovofacingwait = 1;
          } else
            level thread barkov_tell_face_wall();

          var_5 = gettime();
        }
      } else if(scripts\engine\utility::flag("corner_vo_started") && !scripts\engine\utility::flag("told_to_face_wall")) {
        scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
        scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_facewall_moving();
        scripts\engine\utility::flag_set("told_to_face_wall");
        var_0++;
        var_5 = gettime();
      }
    } else if(!scripts\engine\utility::flag("barkov_telling_face_wall")) {
      scripts\engine\utility::flag_set("facing_wall");
      var_5 = 0;
    }

    waitframe();
  }

  if(scripts\engine\utility::flag("barkov_telling_face_wall")) {
    scripts\engine\utility::flag_waitopen("barkov_telling_face_wall");
    level.dovofacingwaittime = gettime();
  }

  if(level.dovofacingwait && (gettime() - level.dovofacingwaittime) / 1000 < 2) {
    var_14 = gettime();

    while(level.player scripts\engine\math::is_point_in_front(var_3.origin)) {
      if(!level.player istouching(var_2)) {
        scripts\engine\utility::flag_clear("facing_wall");
        scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
        scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_left_corner_nag();
        scripts\engine\utility::flag_waitopen("barkov_killing_player");
        barkov_perform_shock(scripts\engine\utility::getStruct("corner_knockback_pos", "targetname"), 1, 2);
      } else if((gettime() - var_14) / 1000 > 4) {
        scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
        scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_facewall_nag(var_0);
        var_0++;
        scripts\engine\utility::flag_waitopen("barkov_killing_player");
        barkov_perform_shock();
        var_14 = gettime();
      }

      waitframe();
    }

    while((gettime() - level.dovofacingwaittime) / 1000 < 2) {
      if(!level.player istouching(var_2)) {
        scripts\engine\utility::flag_clear("facing_wall");
        scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
        scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_left_corner_nag();
        scripts\engine\utility::flag_waitopen("barkov_killing_player");
        barkov_perform_shock(scripts\engine\utility::getStruct("corner_knockback_pos", "targetname"), 1, 2);
      } else if(level.player scripts\engine\math::is_point_in_front(var_3.origin)) {
        scripts\engine\utility::flag_clear("facing_wall");
        scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
        scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_facewall_nag(var_0);
        var_0++;
        scripts\engine\utility::flag_waitopen("barkov_killing_player");
        barkov_perform_shock();
        level.dovofacingwaittime = gettime();
      }

      waitframe();
    }
  }

  if(!scripts\engine\sp\utility::player_looking_at(level.barkov gettagorigin("j_head"), 0.95, 1)) {
    level thread barkov_orders_turn_to_face();
    var_15 = 0;
    var_16 = 1;

    while(var_16) {
      level thread check_player_left_corner();
      level thread check_looking_at(level.barkov gettagorigin("j_head"));
      level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(5);
      var_17 = level scripts\engine\utility::waittill_any_return("left_corner", "looking_at", "timeout");
      level notify("kill_checks");

      if(var_17 == "left_corner") {
        level notify("cancel_turn_to_face_command");
        scripts\sp\maps\captive\captive_vo.gsc::barkov_dialog_interrupt();
        scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_left_corner_nag();
        scripts\engine\utility::flag_waitopen("barkov_killing_player");
        barkov_perform_shock(scripts\engine\utility::getStruct("corner_knockback_pos", "targetname"), 1, 2);

        if(!scripts\engine\utility::flag("barkov_ordered_turn_to_face"))
          level thread barkov_orders_turn_to_face();

        continue;
      }

      if(var_17 == "looking_at") {
        if(scripts\engine\utility::flag("barkov_ordered_turn_to_face"))
          var_16 = 0;

        continue;
      }

      scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_face_me_nag(var_15);
      var_15++;
      scripts\engine\utility::flag_waitopen("barkov_killing_player");
      barkov_perform_shock();
    }
  }

  getEnt("barkov_bed_clip", "targetname") solid();
  setmusicstate("");
  barkov_play_chained_anime_into_idle("break_exercise_bed_enter", "break_exercise_drink_offer", "break_exercise_drink_offer_idle");
  level.barkov scripts\sp\player\cursor_hint::create_cursor_hint("j_strap4", (0, 0, 0), &"CAPTIVE/CURSOR_TAKE", 180, 160, 64, 1);
  level.barkov thread scripts\sp\maps\captive\captive_util.gsc::check_item_interact();
  level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(8);
  var_18 = level scripts\engine\utility::waittill_any_return("item_interact", "timeout");
  level notify("kill_checks");
  level.barkov scripts\sp\player\cursor_hint::remove_cursor_hint();

  if(var_18 == "item_interact") {
    scripts\sp\utility::nvidiaansel_scriptdisable(1);
    level thread player_tries_to_take_water();
    wait 0.25;
  }

  scripts\engine\utility::flag_waitopen("tried_stealing_stunstick");
  barkov_play_anime_into_idle("break_exercise_drink_deny", "break_exercise_bed_exit_idle");
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  scripts\engine\utility::flag_waitopen("tried_stealing_stunstick");
  level.breakanimref notify("end_henchman_idle");
  getEnt("barkov_bed_clip", "targetname") delete();
  thread scripts\engine\sp\utility::autosave_by_name_silent("break_waterboarding");
  thread scripts\sp\analytics::analytics_kleenex_update("Orders");
}

break_orders_catchup() {}

check_looking_at(var_0, var_1) {
  self endon("kill_checks");
  self endon("barkov_left");

  if(isDefined(var_1))
    wait(var_1);
  else
    waitframe();

  for(;;) {
    if(scripts\engine\sp\utility::player_looking_at(var_0, 0.9, 1))
      self notify("looking_at");

    waitframe();
  }
}

barkov_tell_face_wall() {
  scripts\engine\utility::flag_set("barkov_telling_face_wall");
  barkov_play_anime_into_idle("break_exercise_order_wall", "break_exercise_approach_idle");
  level.dovofacingwait = 1;
  level.dovofacingwaittime = gettime();
  scripts\engine\utility::flag_set("told_to_face_wall");
  scripts\engine\utility::flag_clear("barkov_telling_face_wall");
}

check_corner_enter(var_0) {
  level endon("kill_checks");
  var_1 = getEnt("bottom_left_corner", "targetname");
  var_2 = getEnt("top_left_corner", "targetname");
  var_3 = getEnt("bottom_right_corner", "targetname");
  var_4 = getEnt("top_right_corner", "targetname");

  for(;;) {
    if(level.player istouching(var_1)) {
      if(var_0 != "bottom_left_corner")
        level notify("bottom_left_corner");
    } else if(level.player istouching(var_2)) {
      if(var_0 != "top_left_corner")
        level notify("top_left_corner");
    } else if(level.player istouching(var_3))
      level notify("bottom_right_corner");
    else if(level.player istouching(var_4)) {
      if(var_0 != "top_right_corner")
        level notify("top_right_corner");
    }

    waitframe();
  }
}

check_player_left_corner() {
  level endon("kill_checks");
  var_0 = getEnt("bottom_right_corner", "targetname");

  for(;;) {
    if(!level.player istouching(var_0))
      level notify("left_corner");

    waitframe();
  }
}

barkov_move_to_corner() {
  barkov_play_anime_into_idle("break_exercise_approach", "break_exercise_approach_idle");
  scripts\engine\utility::flag_set("barkov_arrived_at_corner");
}

barkov_orders_turn_to_face() {
  level endon("cancel_turn_to_face_command");
  scripts\engine\utility::flag_set("barkov_began_order_turn_to_face");
  level notify("cancel_barkov_actions");
  barkov_play_anime_into_idle("break_exercise_now_look", "break_exercise_approach_idle");
  scripts\engine\utility::flag_set("barkov_ordered_turn_to_face");
}

player_tries_to_take_water() {
  if(distance2d(level.barkov gettagorigin("j_chest"), level.player.origin) < 30)
    level thread scripts\sp\maps\captive\captive_util.gsc::link_player_and_move(2, level.player.origin, level.player.angles);

  var_0 = scripts\engine\sp\utility::spawn_anim_model("shackles", level.player.origin);
  var_0 notsolid();
  var_0 linktoplayerview(level.player, "j_wrist_le", (0, 0, 0), (0, 0, 0), 0, "none");
  var_0 setanim(%cap_cells_020_exercise_drink_reach_restraints);
  setsaveddvar("NMLOKNMRSK", 1);
  level.player forceplaygestureviewmodel("cap_cells_020_exercise_drink_reach_gesture");
  wait 2.35;
  setsaveddvar("NMLOKNMRSK", 0);
  var_0 delete();
}

check_going_behind_barkov() {
  level endon("kill_checks");

  for(;;) {
    if(distance2d(level.barkov.origin, level.player.origin) < 48) {
      var_0 = vectordot(anglesToForward(level.barkov.angles), vectorNormalize(level.player.origin - level.barkov.origin));

      if(var_0 < 0.1)
        level notify("going_behind");
    }

    waitframe();
  }
}

barkov_kills_player(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level notify("kill_checks");
  scripts\engine\utility::flag_set("barkov_killing_player");

  if(distance(level.player.origin, level.barkov.origin) >= 120) {
    level thread barkov_play_anime_into_idle("break_exercise_approach", "break_exercise_approach_idle");

    while(distance(level.player.origin, level.barkov.origin) > 120)
      waitframe();

    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_enough_of_this();

    if(!var_0)
      wait 1.5;

    level.barkov thread wait_for_notetrack_shock(undefined, 1, 10, 1);
    var_1 = "shock_stand_" + level.barkov get_shock_anim();
    level.barkov scripts\common\anim::anim_single_solo(level.barkov, var_1);
  } else {
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_enough_of_this();

    if(!var_0)
      wait 1.5;

    level.barkov thread wait_for_notetrack_shock(undefined, 1, 10, 1);
    var_1 = "shock_stand_" + level.barkov get_shock_anim();
    level.barkov scripts\common\anim::anim_single_solo(level.barkov, var_1);
  }
}

check_try_pickup_stunstick() {
  level endon("end_stunstick_pickup_test");
  wait 1;
  thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (3, 0, 0), &"CAPTIVE/CURSOR_TAKE", 60, 50, 38, 1);
  self waittill("trigger");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_try_steal_stunstick();
  thread scripts\sp\utility::notetrack_vo_disable();
  level thread attempt_take_stunstick();
}

attempt_take_stunstick() {
  scripts\engine\utility::flag_set("tried_stealing_stunstick");
  level thread henchman_fire_at_player();
  level.player scripts\common\utility::allow_death(0);
  level.playermover.origin = level.player.origin;
  level.playermover.angles = level.player.angles;
  level.player playerlinktodelta(level.playermover, undefined, 1, 5, 5, 0, 70);
  var_0 = scripts\engine\sp\utility::spawn_anim_model("shackles", level.player.origin);
  var_0 notsolid();
  var_0 linktoplayerview(level.player, "j_wrist_le", (0, 0, 0), (0, 0, 0), 0, "none");
  var_0 setanim(%cap_cells_020_exercise_drink_reach_restraints);
  setsaveddvar("NMLOKNMRSK", 1);
  level.player forceplaygestureviewmodel("cap_cells_020_exercise_drink_reach_gesture");
  wait 2.35;
  setsaveddvar("NMLOKNMRSK", 0);
  var_0 delete();
}

henchman_fire_at_player() {
  level.breakanimref notify("end_cell_idle");
  level.henchman delete();
  level.stunstickattacker = scripts\engine\sp\utility::spawn_targetname("steal_stunstick_attacker");
  level.stunstickattacker scripts\engine\sp\utility::set_favoriteenemy(level.player);
  level.stunstickattacker.animname = "henchman";
  wait 1;
  level.stunstickattacker shoot();
  level.player scripts\sp\utility::do_damage(30, level.stunstickattacker.origin);
  wait 0.35;
  level.stunstickattacker shoot();
  level.player unlink();
  level.player scripts\common\utility::allow_death(1);
  level.player kill(level.stunstickattacker.origin, level.stunstickattacker);
}

break_waterboard_start() {
  break_setup();
  scripts\engine\utility::flag_set("thirsty_awake");
  level.celldoorclip = getEnt("clip_cell_door", "targetname");
  spawn_barkov();
  spawn_henchman();
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.barkov, "break_exercise_bed_exit_idle", "end_barkov_idle");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.henchman, "break_intro_cell_idle", "end_cell_idle");
  level.player scripts\common\utility::allow_sprint(0, "cell_movement");
  level thread shackled_squat_override();
  level thread player_tired_movement();
  level.player.currentspeedscale = 0.25;
  level.player setmovespeedscale(level.player.currentspeedscale);
  scripts\sp\maps\captive\captive_util.gsc::cellblock_open_door(1);
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("main_cell");
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.eyeshutoverlay.lowresbackground = 1;
}

break_waterboard_main() {
  scripts\engine\utility::flag_set("clear_blur_fx");
  setup_breath_overlay();
  visionsetnaked("", 4);
  level.breakanimref = scripts\engine\utility::getStruct("cell_center", "targetname");
  level.jerrycan = getEnt("jerrycan", "targetname");
  level.jerrycan.clip = getEnt("jerrycan_clip", "targetname");
  level.leftchains = scripts\engine\sp\utility::spawn_anim_model("left_chains", (0, 0, 0), (0, 0, 0));
  level.rightchains = scripts\engine\sp\utility::spawn_anim_model("right_chains", (0, 0, 0), (0, 0, 0));
  level.breakanimref thread scripts\common\anim::anim_first_frame([level.leftchains, level.rightchains], "break_intro_barkov_arrives");
  scripts\sp\maps\captive\captive_util.gsc::get_cell_chair();

  if(scripts\engine\utility::flag("obstructing_cell_exit")) {
    barkov_play_anime_into_idle("break_exercise_wait_clear", "break_exercise_bed_exit_idle");
    scripts\engine\utility::flag_waitopen_or_timeout("obstructing_cell_exit", 5);

    if(scripts\engine\utility::flag("obstructing_cell_exit")) {
      var_0 = scripts\engine\utility::getStructArray("cell_exit_knockback_check", "targetname");
      var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0, 1000);
      barkov_perform_shock(var_1, 1, 4);
    }
  }

  level thread check_player_trying_to_obstruct_exit();
  level thread check_for_clip_deletion();
  level thread henchman_start_escort();
  level thread barkov_start_escort();
  scripts\engine\utility::flag_wait("henchman_reached_escort_start");
  level thread waterboard_march_check(1);
  level thread check_nag_out_of_cell();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_azadeh_torture();
  scripts\engine\utility::flag_waitopen("in_cell");
  level thread do_cough();
  scripts\engine\utility::flag_wait("exited_cell");
  level notify("kill_checks");
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_waterboard_int();
  level thread henchman_waterboard_walk();
  level thread waterboard_march_check(0);
  scripts\engine\utility::flag_wait("barkov_reached_escort_start");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("waterboarding");
  scripts\engine\utility::flag_wait("approaching_wb_room");
  level thread scripts\sp\maps\captive\captive_util.gsc::player_speed_lerp(0.25, 0.4, 5);
  level thread wait_do_waterboard_point();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\engine\utility::flag_wait("reached_waterboard_room");
  level notify("kill_checks");
  level.barkov notify("kill_checks");
  scripts\engine\utility::flag_waitopen("barkov_speaking");
  level thread barkov_play_anime_into_idle("break_wboard_chair_enter_nag1", "break_wboard_escort_idle");
  level.cellchair thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 28), &"CAPTIVE/CURSOR_SIT");
  level.cellchair thread check_enter_chair();
  scripts\engine\utility::flag_clear("allow_coughs");
  level waittill("used_chair");
  level.barkov stop_eye_barkov();
  visionsetnaked("captive_hero_hl", 4);
  level thread clear_player_tired_movement();
  level.barkov detach("military_stun_gun_baton_01", "tag_accessory_right");
  level.barkov detach("barkov_canteen", "j_spinelower");
  level.player scripts\common\utility::allow_sprint(1, "cell_movement");
  level.henchman notify("kill_checks");
  thread clear_shackled_squat_override();
  level thread notetrack_listener_enable_spring_cam();
  level.breakanimref thread scripts\sp\player_rig::link_player_to_rig("break_wboard_enter_chair", "stand", 1, 0.5, 0, 40, 40, 40, 40, 1, ::attach_shackles_to_rig);
  level notify("cancel_barkov_actions");
  scripts\engine\utility::flag_clear("barkov_performing_action");
  waitframe();
  level thread barkov_play_anime_into_idle("break_wboard_enter_chair", "break_wboard_question_idle");
  thread scripts\sp\maps\captive\captive_lighting.gsc::waterboarding_dof_barkov();
  level notify("kill_henchman_walk");
  level.breakanimref notify("end_escort_idle");
  level.henchman thread scripts\sp\maps\captive\captive_util.gsc::notify_end_of_anim("henchman_anime_ended");
  level.player enableweapons();
  level thread check_attach_jerrycan();
  level thread attach_chains_to_chair();
  level thread player_play_anime_into_idle("break_wboard_enter_chair", "break_wboard_chair_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.henchman, "break_wboard_enter_chair");
  attach_chair();
  level waittill("henchman_anime_ended");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.henchman, "break_wboard_question_idle", "end_henchman_chair_idle");
  level.breakanswer1 = question_answer_check(1, "break_wboard_question_nag", "break_wboard_question_idle");
  level thread question_barkov_response(level.breakanswer1, 1);
  level.player springcamdisabled(0.5);
  level waittill("start_tilt_back");
  var_2 = first_waterboard_sequence();
  level thread notetrack_listener_enable_spring_cam(1);

  if(var_2) {
    level notify("cancel_player_actions");
    level.breakanimref notify("end_player_idle");
    level thread player_play_anime_into_idle("break_wboard_question2_enter", "break_wboard_chair_idle_right");
    barkov_play_anime_into_idle("break_wboard_question2_enter", "break_wboard_question2_idle");
  } else {
    level notify("cancel_player_actions");
    level.breakanimref notify("end_player_idle");
    level thread player_play_anime_into_idle("break_wboard_question_wake2", "break_wboard_chair_idle_right");
    barkov_play_anime_into_idle("break_wboard_question_wake2", "break_wboard_question2_idle");
  }

  var_3 = "break_wboard_question2_nag1";

  if(scripts\engine\utility::flag("has_done_question_nag"))
    var_3 = "break_wboard_question2_nag2";

  level.breakanswer2 = question_answer_check(2, var_3, "break_wboard_question2_idle");

  if(level.breakanswer1 == "truth" && level.breakanswer2 == "truth")
    level.breakanswer2 = "truth_truth";
  else if(level.breakanswer1 == "lie" && level.breakanswer2 == "lie")
    level.breakanswer2 = "lie_lie";
  else if(level.breakanswer1 == "attack" && level.breakanswer2 == "attack")
    level.breakanswer2 = "attack_attack";
  else if(level.breakanswer1 == "timeout" && level.breakanswer2 == "timeout")
    level.breakanswer2 = "timeout_timeout";
  else if(level.breakanswer1 == "resist" && level.breakanswer2 == "resist")
    level.breakanswer2 = "resist_resist";

  level.player springcamdisabled(0.5);
  question_barkov_response(level.breakanswer2, 2);
  level.barkov scripts\common\ai::gun_recall();
  level.barkov.fakepapa hide();
  thread scripts\sp\maps\captive\captive_lighting.gsc::lights_off("barkov_rim");
  level.femaleprisoner = scripts\engine\sp\utility::spawn_targetname("azadeh_break");
  level.femaleprisoner attach("accessory_un_shackle_02", "j_gun");
  level thread scripts\sp\maps\captive\captive_lighting.gsc::azadeh_brought_in();
  spawn_henchman3();
  level thread scripts\engine\sp\utility::autosave_by_name_silent("waterboarding_final");
  level.breakanimref notify("end_player_idle");
  level.breakanimref thread scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_test_intro");
  level thread barkov_play_anime_into_idle("break_wboard_test_intro", "break_wboard_test_idle");
  level.henchman3 thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.breakanimref, "break_wboard_test_intro", "break_wboard_test_idle", "end_test_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.femaleprisoner, "break_wboard_test_intro");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.femaleprisoner, "break_wboard_test_idle", "end_azadeh_test_idle");
  var_4 = final_waterboard_sequence();

  if(var_4) {
    level thread notetrack_listener_enable_spring_cam();
    level.breakanimref notify("end_azadeh_test_idle");
    level.femaleprisoner thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.breakanimref, "break_wboard_question3_enter", "break_wboard_question3_idle", "end_test_idle");
    level thread player_play_anime_into_idle("break_wboard_question3_enter", "break_wboard_question3_idle");
    barkov_play_anime_into_idle("break_wboard_question3_enter", "break_wboard_question3_idle");
    level.breakanswer3 = question_answer_check(3, "break_wboard_question3_nag", "break_wboard_question3_idle");
    level.player springcamdisabled(0.5);
    setomnvar("ui_dialogue_prompts_active", 0);

    if(level.breakanswer3 == "truth")
      scripts\engine\utility::flag_set("saved_azadeh");
    else if(level.breakanswer3 == "lie")
      level.player scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_break_55");
    else if(level.breakanswer3 == "resist")
      level.player scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_break_53");
    else if(level.breakanswer3 == "attack")
      level.player scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_break_57");
  } else {
    level thread quick_wake_up();
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_fail_wake3();
    level.player.breathoverlay fadeovertime(1);
    level.player.breathoverlay.alpha = 0;
    level.breakanimref notify("end_barkov_idle");
    level.breakanimref notify("end_player_idle");
    level.breakanimref scripts\common\anim::anim_single([level.barkov, level.player_rig], "break_wboard_test_fail_wake");
  }

  level.breakanimref notify("end_test_idle");
  level.breakanimref notify("end_player_idle");

  if(scripts\engine\utility::flag("saved_azadeh")) {
    scripts\sp\analytics::analytics_event_upload("Player Passed Waterboarding", 1);
    thread scripts\sp\maps\captive\captive_vo.gsc::mus_barkov_spare_prisoner();
    level.breakanimref thread scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_test_save_prisoner");
    level.henchman3 thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.breakanimref, "break_wboard_test_save_prisoner", "break_wboard_test_idle", "end_henchman_idle");
    level.breakanimref thread scripts\common\anim::anim_single_solo(level.femaleprisoner, "break_wboard_test_save_prisoner");
    level thread barkov_play_anime_into_idle("break_wboard_test_save_prisoner", "break_final_food_idle");
  } else {
    scripts\sp\analytics::analytics_event_upload("Player Passed Waterboarding", 0);
    thread scripts\sp\maps\captive\captive_vo.gsc::mus_barkov_shoot_prisoner();
    level thread scripts\sp\maps\captive\captive_lighting.gsc::check_kill_azadeh();
    level.player setsoundsubmix("sp_npc_weap_up", 3.0, 1.0);
    level.breakanimref thread scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_test_kill_prisoner");
    level.henchman3 thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.breakanimref, "break_wboard_test_kill_prisoner", "break_wboard_test_idle", "end_henchman_idle");
    level.breakanimref thread scripts\common\anim::anim_single_solo(level.femaleprisoner, "break_wboard_test_kill_prisoner");
    level thread barkov_play_anime_into_idle("break_wboard_test_kill_prisoner", "break_final_food_idle");
  }

  level waittill("clamp_view");
  level.player lerpviewangleclamp(1, 0.2, 0.5, 0, 0, 0, 0);
  level waittill("knockout");
  level.player clearsoundsubmix("sp_npc_weap_up", 1.0);
  level.player shellshock("captive_hit", 2);
  level.player scripts\sp\utility::do_damage(25, level.barkov.origin, level.barkov, undefined, "MOD_MELEE");
  level.player playRumbleOnEntity("heavy_1s");
  level.eyeshutoverlay fadeovertime(0.3);
  level.eyeshutoverlay.alpha = 1;
  wait 0.3;
  level notify("end_idle");
  level.henchman detach("tool_jerry_can_01", "tag_accessory_left");
  level.jerrycan show();
  level.jerrycan.origin = scripts\engine\utility::getStruct("jerrycan_start", "targetname").origin;
  setsaveddvar("MLTTMLTKOR", 0);
  setsaveddvar("LSOPQMRPNR", 0);
  setblur(0, 0.05);
  scripts\sp\maps\captive\captive_util.gsc::cell_close_doors(1);
  level.player.breathoverlay fadeovertime(0.1);
  level.player.breathoverlay.alpha = 0;
  level.femaleprisoner delete();
  level.cellchair show();
  thread scripts\sp\analytics::analytics_kleenex_update("Waterboard");
  level.barkov scripts\common\ai::gun_remove();
  level.barkov.fakepapa show();
  thread scripts\engine\sp\utility::autosave_by_name_silent("break_final");
  level.jerrycan.clip delete();
  level.jerrycan delete();
  level.breakanimref notify("end_chair_idle");
  scripts\sp\player_rig::unlink_player_from_rig();
}

break_waterboard_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  level.jerrycan = getEnt("jerrycan", "targetname");
  level.jerrycan.clip = getEnt("jerrycan_clip", "targetname");
  level.jerrycan.clip delete();
  level.jerrycan delete();
  scripts\sp\maps\captive\captive_util.gsc::get_cell_chair();
  level.celldoorclip = getEnt("clip_cell_door", "targetname");
  level.celldoorclip delete();
}

check_for_clip_deletion() {
  level waittill("delete_clip");
  level.celldoorclip delete();
  level notify("end_obstruction_check");
}

check_player_trying_to_obstruct_exit() {
  level endon("end_obstruction_check");
  var_0 = scripts\engine\utility::getStruct("cell_door_target", "targetname");
  var_1 = scripts\engine\utility::getStructArray("cell_exit_knockback_check", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("obstructing_cell_exit")) {
      var_2 = vectortoangles(level.player.origin - var_0.origin);
      var_3 = anglesToForward(var_2);
      var_4 = anglesToForward(var_0.angles);
      var_5 = vectordot(var_3, var_4);

      if(var_5 < 0) {
        if(distance2d(level.player.origin, var_0.origin) < distance2d(level.barkov.origin, var_0.origin)) {
          var_6 = scripts\engine\utility::getclosest(level.player.origin, var_1, 1000);
          level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_obstructing_exit();
          level thread barkov_perform_partial_shock(1, var_6, 1, 2);
          wait 2;
        }
      }
    }

    waitframe();
  }
}

check_nag_out_of_cell() {
  scripts\engine\utility::flag_wait("barkov_reached_escort_start");

  if(scripts\engine\utility::flag("in_cell"))
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_nag_out_of_cell();
}

setup_breath_overlay() {
  level.player.breathoverlay = newclienthudelem(level.player);
  level.player.breathoverlay.sort = 12;
  level.player.breathoverlay.x = 0;
  level.player.breathoverlay.y = 0;
  level.player.breathoverlay.alignx = "left";
  level.player.breathoverlay.aligny = "top";
  level.player.breathoverlay.sort = 1;
  level.player.breathoverlay.foreground = 0;
  level.player.breathoverlay.lowresbackground = 1;
  level.player.breathoverlay.horzalign = "fullscreen";
  level.player.breathoverlay.vertalign = "fullscreen";
  level.player.breathoverlay.alpha = 0;
  level.player.breathoverlay.enablehudlighting = 1;
  level.player.breathoverlay setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
}

henchman_start_escort() {
  level.breakanimref notify("end_cell_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.henchman, "break_wboard_escort_start");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.henchman, "break_wboard_escort_idle", "end_escort_start_idle");
  scripts\engine\utility::flag_set("henchman_reached_escort_start");
}

barkov_start_escort() {
  barkov_play_anime_into_idle("break_wboard_escort_start", "break_wboard_escort_idle");
  scripts\engine\utility::flag_set("barkov_reached_escort_start");
}

waterboard_march_check(var_0) {
  self endon("kill_checks");
  var_1 = scripts\engine\utility::getStruct("henchman_waterboard_walk_start", "targetname");
  var_2 = anglesToForward(var_1.angles) * 32;

  for(;;) {
    var_3 = level.henchman.origin + var_2;

    if(scripts\engine\utility::flag("entering_opposite_cell") || scripts\engine\utility::flag("exited_cell") && scripts\engine\utility::flag("entering_own_cell"))
      henchman_waterboard_walk_shove(var_3, var_1.angles);

    var_4 = vectortoangles(level.player.origin - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = anglesToForward(var_1.angles);
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0) {
      var_8 = 1;

      if(var_0) {
        if(scripts\engine\utility::flag("in_cell"))
          var_8 = 0;
      }

      if(var_8)
        henchman_waterboard_walk_shove(var_3, var_1.angles);
    }

    waitframe();
  }
}

henchman_waterboard_walk() {
  self endon("kill_henchman_walk");
  level.breakanimref notify("end_escort_start_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.henchman, "break_wboard_escort_move");
  scripts\engine\utility::flag_set("henchman_in_doorway");
  scripts\engine\utility::flag_set("reached_waterboard_room");

  if(!scripts\engine\utility::flag("entered_chair")) {
    level.henchman thread trigger_check_shove("waterboard_door_block", "waterboard_room_target");
    level.breakanimref scripts\common\anim::anim_loop_solo(level.henchman, "break_wboard_escort_move_idle", "end_escort_idle");
  }
}

henchman_waterboard_walk_shove(var_0, var_1) {
  var_2 = anglesToForward(var_1) * 70;
  var_3 = var_0 + var_2;

  if(!level.player.beingshoved) {
    level thread henchman_shove_moving(var_0, var_3, var_1);

    if(!scripts\engine\utility::flag("did_shove_comment")) {
      scripts\engine\utility::flag_set("did_shove_comment");
      level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_shove_remark();
    }
  }
}

trigger_check_shove(var_0, var_1) {
  self endon("kill_checks");
  var_2 = getEnt(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");

  for(;;) {
    var_2 waittill("trigger");

    if(!level.player.beingshoved) {
      if(scripts\engine\utility::flag("henchman_in_doorway")) {
        level thread henchman_shove_doorway(level.henchman.origin, var_3.origin, var_3.angles);
        continue;
      }

      level thread henchman_shove_moving(level.henchman.origin, var_3.origin, var_3.angles);
    }
  }
}

henchman_shove_doorway(var_0, var_1, var_2) {
  level.player.beingshoved = 1;
  scripts\engine\utility::delaythread(0.3, ::shove, var_0, var_1, var_2);
  level.breakanimref notify("end_escort_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.henchman, "break_wboard_door_push");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.henchman, "break_wboard_escort_move_idle", "end_escort_idle");
  level.player.beingshoved = 0;
}

#using_animtree("generic_human");

henchman_shove_moving(var_0, var_1, var_2) {
  level.player.beingshoved = 1;
  var_3 = % cap_cells_030_hallway_push_front_enemy02;
  var_4 = vectordot(vectorNormalize(level.player.origin - level.henchman.origin), anglesToForward(level.henchman.angles));

  if(var_4 < 0.8) {
    var_5 = vectordot(vectorNormalize(level.player.origin - level.henchman.origin), anglestoright(level.henchman.angles));

    if(var_5 >= 0)
      var_3 = % cap_cells_030_hallway_push_right_enemy02;
    else
      var_3 = % cap_cells_030_hallway_push_left_enemy02;
  }

  level.player playSound("cap_cells_030_waterboard_push_plr_lr");
  level.henchman setanim(var_3, 5);
  wait 0.3;

  if(scripts\engine\utility::flag("exited_cell"))
    shove(var_0, var_1, var_2);
  else {
    var_6 = scripts\engine\utility::getStruct("henchman_short_shove", "targetname");
    shove(var_0, var_6.origin, var_6.angles);
  }

  level.henchman clearanim(var_3, 0.2);
  level.player.beingshoved = 0;
}

wait_do_waterboard_point() {
  if(scripts\engine\utility::flag("barkov_speaking")) {
    scripts\engine\utility::flag_waitopen("barkov_speaking");
    wait 0.5;
  }

  if(!scripts\engine\utility::flag("reached_waterboard_room")) {
    scripts\engine\utility::flag_set("barkov_speaking");
    barkov_play_anime_into_idle("break_wboard_escort_point", "break_wboard_escort_idle");
    scripts\engine\utility::flag_clear("barkov_speaking");
  }
}

check_enter_chair() {
  level thread check_enter_chair_vo();
  self waittill("trigger");
  level.player lerpfovscalefactor(0, 0.5);
  level notify("used_chair");
}

check_enter_chair_vo() {
  self endon("used_chair");
  wait 10;
  level thread barkov_play_anime_into_idle("break_wboard_chair_enter_nag2", "break_wboard_escort_idle");
  wait 12;
  level thread barkov_play_anime_into_idle("break_wboard_chair_enter_nag3", "break_wboard_escort_idle");
  wait 12;
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_all_day_nag();
}

check_attach_jerrycan() {
  level waittill("attach_jug");
  level.jerrycan hide();
  level.henchman attach("tool_jerry_can_01", "tag_accessory_left");
}

attach_chair() {
  level.cellchair hide();
  level.player_rig attach("furniture_old_wooden_chair_vm_01", "tag_accessory_right");
}

attach_chains_to_chair() {
  level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.rightchains], "break_intro_barkov_arrives");
  level.breakanimref thread scripts\common\anim::anim_loop([level.leftchains, level.rightchains], "break_wboard_chair_idle", "end_chair_idle");
}

first_waterboard_sequence() {
  var_0 = 0;
  var_1 = 1;
  var_2 = 0;
  var_3 = [[5, 1.5, 2, 5], [5, 1, 1.5, 5], [5, 1, 1.5, 5]];

  for(level.barkov.waterboardindex = 0; var_1; var_0++) {
    switch (var_0) {
      case 0:
        setmusicstate("");
        level.groundrefent = scripts\engine\utility::spawn_script_origin();
        level.groundrefent linkTo(level.player_rig, "tag_camera", (0, 0, 0), (0, 0, 0));
        level thread waterboard_clamp_then_spring_cam();
        level.breakanimref notify("end_player_idle");
        level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_chair_tipped_back(1);
        level.breakanimref scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_chair_tilt");
        level.player playersetgroundreferenceent(level.groundrefent);
        level thread wait_waterboard_cloth_applied();
        level.cloth = scripts\engine\sp\utility::spawn_anim_model("wb_cloth", level.barkov.origin, level.barkov.angles);
        level.breakanimref thread scripts\common\anim::anim_single_solo(level.cloth, "break_wboard_chair_tilt");
        level thread waterboard_player_first_tilt();
        barkov_play_anime_into_idle("break_wboard_chair_tilt", "break_wboard_pour");
        level thread waterboard_clamp_to_waterboard_view();
        level.player springcamdisabled(0.5);
        waterboard_pour_setup();
        level.breakanimref notify("end_henchman_chair_idle");
        level.breakanimref scripts\common\anim::anim_single_solo(level.henchman, "break_wboard_chair_pour_start");
        var_2 = waterboard(var_3, 1);

        if(var_2) {
          scripts\engine\utility::flag_waitopen("pouring_finished");
          level thread barkov_return_ready_next_anim("break_wboard_question2_enter");
          scripts\engine\utility::exploder("waterboard_face_drip_persistent");
        }

        waterboard_tilt_forward(var_2);
        break;
      case 1:
        level notify("passout_wake");
        level thread quick_wake_up();
        level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_fail_wake1();
        level notify("cancel_player_actions");
        level notify("end_player_idle");
        level.breakanimref thread scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_question_wake1");
        barkov_play_anime_into_idle("break_wboard_question_wake1", "break_wboard_question_wake_idle");
        level.groundrefent = scripts\engine\utility::spawn_script_origin();
        level.groundrefent linkTo(level.player_rig, "tag_camera", (0, 0, 0), (0, 0, 0));
        level.breakanimref notify("end_player_idle");
        level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_chair_tipped_back(0);
        level.breakanimref scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_chair_tilt");
        level.player playersetgroundreferenceent(level.groundrefent);
        level thread wait_waterboard_cloth_applied();
        level thread waterboard_player_pour_start();
        level.cloth = scripts\engine\sp\utility::spawn_anim_model("wb_cloth", level.barkov.origin, level.barkov.angles);
        level.breakanimref thread scripts\common\anim::anim_single_solo(level.cloth, "break_wboard_pour_start");
        level thread barkov_play_anime_into_idle("break_wboard_pour_start", "break_wboard_pour");
        level thread waterboard_clamp_to_waterboard_view();
        waterboard_pour_setup();
        level.breakanimref notify("end_henchman_chair_idle");
        level.breakanimref scripts\common\anim::anim_single_solo(level.henchman, "break_wboard_chair_pour_start");
        var_2 = waterboard(var_3, 1);

        if(var_2) {
          scripts\engine\utility::flag_waitopen("pouring_finished");
          level thread barkov_return_ready_next_anim("break_wboard_question2_enter");
          scripts\engine\utility::exploder("waterboard_face_drip_persistent");
        }

        waterboard_tilt_forward(var_2);
        break;
    }

    if(var_2) {
      var_1 = 0;
      continue;
    }

    if(var_0 >= 1) {
      var_1 = 0;
      level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_fail_wake2();
      level thread quick_wake_up();
    }
  }

  return var_2;
}

final_waterboard_sequence() {
  level.barkov.waterboardindex = 1;
  level.barkov.wboardvosuccessbreathcount = 0;
  level.barkov.wboardvofailbreathcount = 0;
  level.barkov.wboardvoholdstillcount = 0;
  level.barkov.wboardvonotmovingcount = 0;
  level.barkov.wboardvobreathlowcount = 0;
  var_0 = [[5, 1.25, 2, 5], [5, 0.75, 1.5, 5], [5, 0.75, 1.25, 5], [5, 0.75, 1.25, 5]];

  if(scripts\common\utility::getdifficulty() == "fu")
    var_0 = [[5, 1, 1.75, 5], [5, 0.75, 1.25, 5], [5, 0.5, 1, 5], [5, 0.5, 1, 5]];

  level.groundrefent = scripts\engine\utility::spawn_script_origin();
  level.groundrefent linkTo(level.player_rig, "tag_camera", (0, 0, 0), (0, 0, 0));
  level.breakanimref notify("end_player_idle");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_chair_tipped_back(0);
  level.breakanimref scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_chair_tilt");
  level.player playersetgroundreferenceent(level.groundrefent);
  level thread wait_waterboard_cloth_applied();
  level thread waterboard_player_pour_start();
  level.cloth = scripts\engine\sp\utility::spawn_anim_model("wb_cloth", level.barkov.origin, level.barkov.angles);
  level.breakanimref thread scripts\common\anim::anim_single_solo(level.cloth, "break_wboard_pour_start");
  level thread barkov_play_anime_into_idle("break_wboard_pour_start", "break_wboard_pour");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_tougher();
  level thread waterboard_clamp_to_waterboard_view();
  waterboard_pour_setup();
  level.breakanimref notify("end_henchman_chair_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.henchman, "break_wboard_chair_pour_start");
  var_1 = waterboard(var_0, 0);

  if(var_1) {
    scripts\engine\utility::flag_waitopen("pouring_finished");
    level thread barkov_return_ready_next_anim("break_wboard_question3_enter");
    scripts\engine\utility::exploder("waterboard_face_drip_persistent");
  }

  waterboard_tilt_forward(var_1);
  return var_1;
}

waterboard_player_first_tilt() {
  level endon("waterboard_complete");
  level.breakanimref scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_chair_first_tilt");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.player_rig, "break_wboard_chair_tilt_idle", "end_tilt_idle");
}

wait_waterboard_cloth_applied() {
  level waittill("cloth_applied");
  level.player playRumbleOnEntity("light_1s");

  if(isDefined(level.cloth))
    level.cloth delete();

  setomnvar("ui_waterboardingcloth_state", 1);
}

waterboard_clamp_then_spring_cam() {
  level.player lerpviewangleclamp(1, 0.2, 0.2, 0, 0, 0, 0);
  wait 1;
  level.player lerpviewangleclamp(1, 0.2, 0.2, 30, 30, 20, 20);
  level.player springcamenabled(1, 5.0, 0.2);
}

waterboard_clamp_to_waterboard_view() {
  level.player lerpviewangleclamp(0.5, 0.2, 0.2, 5, 5, 5, 5);
  wait 0.5;
  level.player playersetgroundreferenceent(level.groundrefent);
  scripts\engine\utility::flag_wait("jerrycan_reached_center");
  level.player lerpviewangleclamp(1, 0.2, 0.2, 40, 40, 5, 5);
  level.player enableslowaim(0.5, 0.5);
}

waterboard_player_pour_start() {
  level endon("waterboard_complete");
  level.breakanimref notify("end_tilt_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.player_rig, "break_wboard_pour_start");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.player_rig, "break_wboard_chair_tilt_idle", "end_tilt_idle");
}

waterboard_pour_setup() {
  scripts\engine\utility::flag_clear("waterboard_complete");
  scripts\engine\utility::flag_clear("moved_head");
  scripts\engine\utility::flag_clear("took_breath");
  scripts\engine\utility::flag_clear("is_waterboard_tutorial");
  scripts\engine\utility::flag_clear("jerrycan_reached_center");
  scripts\engine\utility::flag_clear("started_passout_countdown");
  scripts\engine\utility::flag_clear("pouring_finished");
  scripts\engine\utility::flag_clear("passed_out");
  level.currentpatternduration = 0;
  level.maxangledot = 0.36;
  level.breathranouttime = 0;
  level.breathlevel = 0;
  level.tookbreath = 0;
  level.pouranimpct = 0;
  level.playerfacingpct = 0;
  level.pourdangerrange = 0.45;
  level.safebreathrange = 0.4;
  level.movedurationmin = -1;
  level.movedurationmax = -1;
  level.pourdistancediff = 0;
  level.passoutthreshold = 5;
  level.passouttime = 0;
  level.spout = scripts\engine\utility::spawn_tag_origin(level.henchman gettagorigin("nozzle_01"), level.henchman gettagangles("nozzle_01"));
  level.spout linkTo(level.henchman, "nozzle_01");
  level thread waterboard_pour_effects();
}

waterboard(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1) {
    scripts\engine\utility::flag_set("is_waterboard_tutorial");
    var_0 = scripts\engine\utility::array_insert(var_0, [-1, -1, -1, 5], 0);
  }

  level.currentpatternduration = var_0[0][0];
  level.movedurationmin = var_0[0][1];
  level.movedurationmax = var_0[0][2];
  level.passoutthreshold = var_0[0][3];
  level.henchman thread scripts\asm\asm_sp::asm_animcustom(::waterboard_anim);
  level thread waterboard_rumble();
  level thread waterboard_sfx();
  level thread waterboard_splash_effects();
  level thread waterboard_check_took_breath();
  level thread waterboard_check_breath_fx();
  level thread waterboard_check_near_passout_fx();

  if(level.barkov.waterboardindex == 1)
    level thread waterboard_check_barkov_resistance();

  foreach(var_3 in var_0) {
    scripts\engine\utility::flag_clear("waterboard_allow_move");
    level.currentpatternduration = var_3[0];
    level.movedurationmin = var_3[1];
    level.movedurationmax = var_3[2];
    level.passoutthreshold = var_3[3];

    if(level.currentpatternduration == -1)
      level thread waterboard_tutorial();

    scripts\engine\utility::flag_set("waterboard_allow_move");
    var_4 = 1;
    var_5 = gettime();

    while(var_4 && !scripts\engine\utility::flag("passed_out")) {
      if(level.currentpatternduration > 0 && (gettime() - var_5) / 1000 >= level.currentpatternduration) {
        if(!scripts\engine\utility::flag("started_passout_countdown"))
          var_4 = 0;
      } else if(level.currentpatternduration < 0 && scripts\engine\utility::flag("done_waterboard_tutorial")) {
        if(!scripts\engine\utility::flag("started_passout_countdown"))
          var_4 = 0;
      }

      if(scripts\engine\utility::flag("started_passout_countdown")) {
        if((gettime() - level.passouttime) / 1000 >= 4) {
          scripts\sp\maps\captive\captive_vo.gsc::clear_effort_sound();
          scripts\engine\utility::flag_clear("is_pouring");
          scripts\engine\utility::flag_set("passed_out");
        }
      } else if(level.breathlevel >= level.passoutthreshold) {
        scripts\engine\utility::flag_set("started_passout_countdown");
        level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_breath_low();
        level.passouttime = gettime();
      }

      waitframe();
    }
  }

  scripts\engine\utility::flag_set("waterboard_complete");

  if(scripts\engine\utility::flag("passed_out")) {
    scripts\engine\utility::flag_set("moved_head");
    scripts\engine\utility::flag_set("took_breath");
    level.player lerpviewangleclamp(0.75, 0.2, 0.4, 0, 0, 0, 0);
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_waterboard_choke();
    sleep(1, 0);
    return 0;
  } else {
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_passed();
    level.player lerpviewangleclamp(0.75, 0.2, 0.4, 0, 0, 0, 0);
    return 1;
  }
}

waterboard_tilt_forward(var_0) {
  scripts\engine\utility::flag_clear("is_pouring");
  scripts\engine\utility::flag_wait("pouring_finished");
  level.player painvisionoff();
  level.player.breathoverlay fadeovertime(1);
  level.player.breathoverlay.alpha = 0;

  if(var_0) {
    scripts\sp\maps\captive\captive_vo.gsc::clear_effort_sound();
    level thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_break_waterboard_interrogate_216");
  }

  level.player disableslowaim();
  level.player playersetgroundreferenceent(undefined);
  level.groundrefent delete();
  level thread waterboard_cloth_removed();
  level.breakanimref notify("end_tilt_idle");
  level.breakanimref notify("end_chair_idle");
  level.breakanimref notify("end_player_idle");

  if(var_0)
    level.breakanimref scripts\common\anim::anim_single([level.henchman, level.player_rig, level.leftchains, level.rightchains], "break_wboard_chair_tilt_return");

  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.henchman, "break_wboard_chair_idle", "end_henchman_chair_idle");
  level.breakanimref thread scripts\common\anim::anim_loop([level.leftchains, level.rightchains], "break_wboard_chair_idle", "end_chair_idle");
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.player_rig, "break_wboard_chair_idle", "end_player_idle");

  if(!var_0)
    wait 3;

  level.player lerpviewangleclamp(1, 0.2, 0.2, 40, 40, 40, 40);
  level.spout delete();
}

barkov_return_ready_next_anim(var_0) {
  level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, "break_wboard_chair_tilt_return");
  level.breakanimref scripts\common\anim::anim_first_frame_solo(level.barkov, var_0);
}

waterboard_cloth_removed() {
  setomnvar("ui_waterboardingcloth_state", 2);
}

waterboard_anim() {
  level.forcequickduration = 0;
  level thread waterboard_check_facing();
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self animmode("noclip");
  var_0 = getanimlength(%cap_cells_030_waterboard_pour_enemy02);
  self setanim(%cap_cells_030_waterboard_pour_enemy02, 1, 0.2, 0);
  var_1 = 0.5 * var_0 / 1;
  self setanimrate(%cap_cells_030_waterboard_pour_enemy02, var_1);
  wait(0.5 * var_0 / var_1);
  self setanimrate(%cap_cells_030_waterboard_pour_enemy02, 0);
  scripts\engine\utility::flag_set("jerrycan_reached_center");
  self setanim(%cap_cells_030_waterboard_pour_additive_enemy02);
  scripts\engine\utility::flag_set("is_pouring");
  var_2 = 0;
  var_3 = 0;
  var_4 = level.forcequickduration;

  while(scripts\engine\utility::flag("is_pouring")) {
    if(!var_2 && !scripts\engine\utility::flag("is_waterboard_tutorial") && scripts\engine\utility::flag("waterboard_allow_move")) {
      var_5 = 0.2;

      if(!var_4)
        var_5 = randomfloatrange(level.movedurationmin, level.movedurationmax);

      var_6 = abs(level.pourdistancediff);

      if(var_6 > level.pourdangerrange - 0.1) {
        var_1 = var_6 * var_0 / var_5;

        if(level.pourdistancediff >= 0)
          self setanimrate(%cap_cells_030_waterboard_pour_enemy02, var_1);
        else
          self setanimrate(%cap_cells_030_waterboard_pour_enemy02, var_1 * -1);

        wait(var_6 * var_0 / var_1);
        self setanimrate(%cap_cells_030_waterboard_pour_enemy02, 0);

        if(level.forcequickduration)
          level.forcequickduration = 0;

        if(var_3)
          var_2 = 1;
      }
    }

    if(var_3) {
      if(level.movedurationmin > 0) {
        var_3 = 0;
        var_2 = 0;
      }
    }

    if(abs(level.pourdistancediff) > level.safebreathrange)
      scripts\engine\utility::flag_set("waterboard_in_safe_zone");
    else {
      scripts\engine\utility::flag_clear("waterboard_in_safe_zone");
      level thread waterboard_check_still_in_danger_zone(3);
    }

    waitframe();
  }

  var_7 = self getanimtime(%cap_cells_030_waterboard_pour_enemy02);

  if(var_7 >= 0.5) {
    self setanimrate(%cap_cells_030_waterboard_pour_enemy02, -5);

    while(self getanimtime(%cap_cells_030_waterboard_pour_enemy02) > 0.5)
      waitframe();
  } else {
    self setanimrate(%cap_cells_030_waterboard_pour_enemy02, 5);

    while(self getanimtime(%cap_cells_030_waterboard_pour_enemy02) < 0.5)
      waitframe();
  }

  scripts\engine\utility::exploder("waterboard_end_ripple");
  wait 0.5;
  self clearanim(%cap_cells_030_waterboard_pour_additive_enemy02, 0.2);
  self setanimrate(%cap_cells_030_waterboard_pour_enemy02, -5);

  while(self getanimtime(%cap_cells_030_waterboard_pour_enemy02) > 0)
    waitframe();

  scripts\engine\utility::exploder("waterboard_end_ripple");
  self clearanim(%cap_cells_030_waterboard_pour_enemy02, 0.2);
  scripts\engine\utility::flag_set("pouring_finished");
}

waterboard_check_barkov_resistance() {
  level endon("waterboard_complete");
  wait 3;

  for(;;) {
    scripts\engine\utility::flag_waitopen("started_passout_countdown");
    scripts\engine\utility::flag_waitopen("barkov_speaking");
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_hold_still();
    var_0 = 1;
    var_1 = level.player getnormalizedcameramovement()[0];
    level.player enableslowaim(0.05, 0.05);

    if(var_1 == 0) {
      while(var_1 == 0) {
        var_1 = level.player getnormalizedcameramovement()[0];
        waitframe();
      }
    }

    var_2 = gettime();
    wait 0.2;

    while(var_0) {
      level.player enableslowaim(0.05, 0.05);

      if((gettime() - var_2) / 1000 >= 3)
        var_0 = 0;

      if(var_1 > 0) {
        if(level.player getnormalizedcameramovement()[0] < 0)
          var_0 = 0;
      } else if(level.player getnormalizedcameramovement()[0] > 0)
        var_0 = 0;

      waitframe();
    }

    level.player enableslowaim(0.4, 0.4);
    scripts\engine\utility::flag_wait("took_breath");
    wait 3;
  }
}

update_anim_phase_debug() {
  scripts\engine\utility::flag_wait("is_pouring");

  for(;;) {
    level.pouranimpct = self getanimtime(%cap_cells_030_waterboard_pour_enemy02);
    waitframe();
  }
}

waterboard_check_still_in_danger_zone(var_0) {
  level endon("waterboard_in_safe_zone");
  level endon("waterboard_complete");
  level endon("took_breath");
  level endon("start_move_head_comment");

  if(!isDefined(level.lastmoveheadcommenttime))
    level.lastmoveheadcommenttime = 0;

  if((gettime() - level.lastmoveheadcommenttime) / 1000 > 10) {
    wait(var_0);
    level.lastmoveheadcommenttime = gettime();
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_not_moving();
    level notify("start_move_head_comment");
  }
}

waterboard_check_facing() {
  level endon("pouring_finished");

  for(;;) {
    var_0 = vectordot(anglesToForward(level.player_rig.angles), scripts\engine\utility::flat_origin(anglesToForward(level.player getplayerangles())));
    level.playerfacingpct = 1 - scripts\engine\math::normalize_value(level.maxangledot * -1, level.maxangledot, var_0);
    level.pourdistancediff = level.playerfacingpct - level.henchman getanimtime(%cap_cells_030_waterboard_pour_enemy02);
    waitframe();
  }
}

waterboard_check_took_breath() {
  level endon("pouring_finished");
  level endon("waterboard_complete");
  scripts\engine\utility::flag_wait("jerrycan_reached_center");
  scripts\engine\utility::flag_clear("took_breath");
  level.player enableweapons();

  for(;;) {
    level.player waittill("release_breath");

    if(!scripts\engine\utility::flag("waterboard_complete")) {
      if(scripts\engine\utility::flag("is_pouring") && abs(level.pourdistancediff) < level.safebreathrange) {
        level.player forceplaygestureviewmodel("cap_cells_030_waterboard_pour_gesture_plr");
        scripts\sp\maps\captive\captive_vo.gsc::clear_effort_sound();
        setsaveddvar("MLLRKTPNRR", 1);
        level.player painvisionon();
        level.breathlevel = level.breathlevel + 1.5;

        if(level.breathlevel > level.passoutthreshold)
          level.breathlevel = level.passoutthreshold;

        if(scripts\engine\utility::flag("started_passout_countdown")) {
          if((gettime() - level.passouttime) / 1000 >= 2.0)
            scripts\engine\utility::flag_set("passed_out");
        } else {
          level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_waterboard_choke();
          level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_fail_breath();
          wait 0.5;
        }

        continue;
      }

      level.player forceplaygestureviewmodel("cap_cells_030_waterboard_breath_gesture_plr");
      scripts\engine\utility::flag_set("has_taken_first_breath");
      scripts\engine\utility::flag_set("took_breath");
      scripts\engine\utility::flag_clear("started_passout_countdown");
      level.forcequickduration = 1;
      scripts\sp\maps\captive\captive_vo.gsc::clear_effort_sound();
      scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_waterboard_take_breath();
      level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wboard_success_breath();
      wait 0.5;
    }
  }
}

waterboard_check_breath_fx() {
  self endon("waterboard_complete");
  var_0 = 0.05;
  setsaveddvar("OONLORSMO", 2);
  setsaveddvar("MLLRKTPNRR", 0.1);
  visionsetpain("captive_near_death");
  level.player painvisionon();

  for(;;) {
    if(scripts\engine\utility::flag("is_pouring")) {
      if(scripts\engine\utility::flag("took_breath")) {
        level.player painvisionoff();
        level thread restart_breath_fade();
        level.breathlevel = 0;
        scripts\engine\utility::flag_clear("took_breath");
      } else if(level.breathlevel < level.passoutthreshold) {
        level.breathlevel = level.breathlevel + var_0;

        if(level.breathlevel > level.passoutthreshold)
          level.breathlevel = level.passoutthreshold;
      }
    }

    waitframe();
  }
}

restart_breath_fade() {
  level endon("waterboard_complete");
  wait 0.45;
  setsaveddvar("MLLRKTPNRR", 0.1);
  level.player painvisionon();
}

waterboard_check_near_passout_fx() {
  self endon("waterboard_complete");

  for(;;) {
    scripts\engine\utility::flag_wait("started_passout_countdown");

    while(scripts\engine\utility::flag("started_passout_countdown")) {
      var_0 = (gettime() - level.passouttime) / 1000 / 4;
      level.player.breathoverlay fadeovertime(0.05);
      level.player.breathoverlay.alpha = var_0;
      waitframe();
    }

    level.player.breathoverlay fadeovertime(1);
    level.player.breathoverlay.alpha = 0;
  }
}

waterboard_has_taken_breath() {
  if(scripts\engine\utility::flag("has_taken_first_breath"))
    return 1;

  if(!scripts\engine\utility::flag("waterboard_in_safe_zone"))
    return 1;

  return 0;
}

waterboard_has_moved_head() {
  if(scripts\engine\utility::flag("moved_head"))
    return 1;

  if(scripts\engine\utility::flag("waterboard_in_safe_zone"))
    return 1;

  return 0;
}

waterboard_pour_effects() {
  playFXOnTag(level._effect["vfx_waterboarding_pour"], level.spout, "tag_origin");
  var_0 = spawn("script_origin", level.spout.origin);
  var_0 linkTo(level.spout);
  var_0 scripts\engine\sp\utility::sound_fade_in("cap_cells_waterboard_loop_spout", 1, 1, 1);
  wait 1;
  scripts\engine\utility::flag_set("is_pouring");
  scripts\engine\utility::flag_wait("pouring_finished");
  level.spout thread scripts\engine\sp\utility::play_sound_on_entity("cap_cells_waterboard_end");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
  stopFXOnTag(level._effect["vfx_waterboarding_pour"], level.spout, "tag_origin");
}

waterboard_rumble() {
  var_0 = 0;
  var_1 = scripts\engine\utility::spawn_script_origin(level.player.origin + (0, 0, -600), (0, 0, 0));
  var_2 = level.player.origin + (0, 0, -1000000.0);
  var_3 = level.player.origin + (0, 0, -600);
  var_4 = level.player.origin + (0, 0, -400);
  var_5 = level.player.origin + (0, 0, -400);
  scripts\engine\utility::flag_wait("is_pouring");
  wait 0.3;
  var_1 playrumblelooponentity("tank_rumble");

  while(!scripts\engine\utility::flag("pouring_finished")) {
    if(abs(level.pourdistancediff) >= level.pourdangerrange)
      var_1.origin = var_2;
    else if(level.pourdistancediff <= -0.35 || level.pourdistancediff >= 0.35)
      var_1.origin = var_3;
    else if(level.pourdistancediff < -0.1 || level.pourdistancediff >= 0.1)
      var_1.origin = var_4;
    else
      var_1.origin = var_5;

    waitframe();
  }

  var_1 delete();
}

waterboard_sfx() {
  scripts\engine\utility::flag_wait("is_pouring");
  wait 0.3;
  var_0 = 0;
  var_1 = spawn("script_origin", level.spout.origin);
  var_1 scripts\engine\sp\utility::sound_fade_in("cap_cells_waterboard_loop_quad_front", 1, 0.3, 1);
  var_2 = spawn("script_origin", level.spout.origin + (0, 37, 0));
  var_2 linkTo(level.spout);
  var_2 scripts\engine\sp\utility::sound_fade_in("cap_cells_waterboard_loop_floor_splashes", 1, 0.3, 1);

  while(!scripts\engine\utility::flag("pouring_finished")) {
    if(abs(level.pourdistancediff) >= level.pourdangerrange) {
      if(var_0 == 1) {
        var_1 scalevolume(0, 1.3);
        var_2 scalevolume(1, 1.3);
        var_0 = 0;
      }
    } else if(level.pourdistancediff <= -0.5 || level.pourdistancediff >= 0.5) {
      if(var_0 == 1) {
        var_1 scalevolume(0, 1.3);
        var_2 scalevolume(1, 1.3);
        var_0 = 0;
      }
    } else if(var_0 == 0) {
      var_1 scalevolume(1, 1.3);
      var_2 scalevolume(0, 1.3);
      var_0 = 1;
    }

    wait 0.1;
  }

  var_1 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
  var_2 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
}

waterboard_splash_effects() {
  var_0 = scripts\engine\utility::spawn_tag_origin(level.player getEye(), level.player getplayerangles());
  var_1 = scripts\engine\utility::spawn_script_origin();
  var_1 linkTo(level.spout, "tag_origin", (-2, 0, 5), (0, 0, 0));
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 linkTo(var_0, "tag_origin", (5, 0, 0), (0, 0, 0));
  scripts\engine\utility::flag_wait("is_pouring");
  var_2 thread splash_loop();

  while(!scripts\engine\utility::flag("pouring_finished")) {
    var_0.angles = vectortoangles(var_1.origin - var_0.origin);
    var_2.angles = vectortoangles(var_0.origin - var_2.origin);
    waitframe();
  }

  wait 0.3;
  level notify("stop_splashes");
  var_0 delete();
  var_2 delete();
  var_1 delete();
}

splash_loop() {
  level endon("stop_splashes");

  while(!scripts\engine\utility::flag("pouring_finished")) {
    playFXOnTag(level._effect["vfx_cpt_waterboard_scrn_splash"], self, "tag_origin");
    wait 0.15;
  }
}

waterboard_tutorial() {
  level endon("waterboard_complete");
  level endon("done_waterboard_tutorial");
  scripts\engine\utility::flag_clear("has_taken_first_breath");
  scripts\engine\utility::flag_wait("jerrycan_reached_center");

  while(!scripts\engine\utility::flag("has_taken_first_breath")) {
    if(scripts\engine\utility::flag("waterboard_in_safe_zone")) {
      level.player thread scripts\engine\sp\utility::display_hint_forced("take_breath", undefined, undefined, [level, level.player], ["waterboard_complete", "end_hint"]);
      scripts\engine\utility::flag_wait("waterboard_in_safe_zone");
    } else {
      if(level.player usinggamepad())
        level.player thread scripts\engine\sp\utility::display_hint_forced("move_head");
      else
        level.player thread scripts\engine\sp\utility::display_hint_forced("move_head_kbm");

      while(!scripts\engine\utility::flag("waterboard_in_safe_zone") && !scripts\engine\utility::flag("has_taken_first_breath"))
        waitframe();
    }

    waitframe();
  }

  scripts\engine\utility::flag_clear("waterboard_allow_move");
  scripts\engine\utility::flag_clear("is_waterboard_tutorial");
  scripts\engine\utility::flag_set("done_waterboard_tutorial");
}

waterboard_debug_display() {
  level.barkov thread update_anim_phase_debug();
  level.waterboarddebug1 = newhudelem();
  level.waterboarddebug1.alignx = "left";
  level.waterboarddebug1.foreground = 1;
  level.waterboarddebug1.font = "objective";
  level.waterboarddebug1.sort = 5;
  level.waterboarddebug1.x = 500;
  level.waterboarddebug1.y = 300;
  level.waterboarddebug1.color = (1, 1, 1);
  level.waterboarddebug1 settext("Pattern Duration: ");
  level.waterboarddebug2 = newhudelem();
  level.waterboarddebug2.alignx = "left";
  level.waterboarddebug2.foreground = 1;
  level.waterboarddebug2.font = "objective";
  level.waterboarddebug2.sort = 5;
  level.waterboarddebug2.x = 500;
  level.waterboarddebug2.y = 310;
  level.waterboarddebug2.color = (1, 1, 1);
  level.waterboarddebug2 settext("Min Move Duration: ");
  level.waterboarddebug3 = newhudelem();
  level.waterboarddebug3.alignx = "left";
  level.waterboarddebug3.foreground = 1;
  level.waterboarddebug3.font = "objective";
  level.waterboarddebug3.sort = 5;
  level.waterboarddebug3.x = 500;
  level.waterboarddebug3.y = 320;
  level.waterboarddebug3.color = (1, 1, 1);
  level.waterboarddebug3 settext("Max Move Duration: ");
  level.waterboarddebug4 = newhudelem();
  level.waterboarddebug4.alignx = "left";
  level.waterboarddebug4.foreground = 1;
  level.waterboarddebug4.font = "objective";
  level.waterboarddebug4.sort = 5;
  level.waterboarddebug4.x = 500;
  level.waterboarddebug4.y = 330;
  level.waterboarddebug4.color = (1, 1, 1);
  level.waterboarddebug4 settext("Passout Threshold: ");
  level.waterboarddebug5 = newhudelem();
  level.waterboarddebug5.alignx = "left";
  level.waterboarddebug5.foreground = 1;
  level.waterboarddebug5.font = "objective";
  level.waterboarddebug5.sort = 5;
  level.waterboarddebug5.x = 500;
  level.waterboarddebug5.y = 340;
  level.waterboarddebug5.color = (1, 1, 1);
  level.waterboarddebug5 settext("Breath Level: ");
  level.waterboarddebug6 = newhudelem();
  level.waterboarddebug6.alignx = "left";
  level.waterboarddebug6.foreground = 1;
  level.waterboarddebug6.font = "objective";
  level.waterboarddebug6.sort = 5;
  level.waterboarddebug6.x = 500;
  level.waterboarddebug6.y = 350;
  level.waterboarddebug6.color = (1, 1, 1);
  level.waterboarddebug6 settext("Anim Phase: ");
  level.waterboarddebug7 = newhudelem();
  level.waterboarddebug7.alignx = "left";
  level.waterboarddebug7.foreground = 1;
  level.waterboarddebug7.font = "objective";
  level.waterboarddebug7.sort = 5;
  level.waterboarddebug7.x = 500;
  level.waterboarddebug7.y = 360;
  level.waterboarddebug7.color = (1, 1, 1);
  level.waterboarddebug7 settext("Facing Pct: ");
  level.waterboarddebug8 = newhudelem();
  level.waterboarddebug8.alignx = "left";
  level.waterboarddebug8.foreground = 1;
  level.waterboarddebug8.font = "objective";
  level.waterboarddebug8.sort = 5;
  level.waterboarddebug8.x = 500;
  level.waterboarddebug8.y = 370;
  level.waterboarddebug8.color = (1, 1, 1);
  level.waterboarddebug8 settext("Distance Diff: ");
  level.waterboarddebug9 = newhudelem();
  level.waterboarddebug9.alignx = "left";
  level.waterboarddebug9.foreground = 1;
  level.waterboarddebug9.font = "objective";
  level.waterboarddebug9.sort = 5;
  level.waterboarddebug9.x = 500;
  level.waterboarddebug9.y = 380;
  level.waterboarddebug9.color = (1, 1, 1);
  level.waterboarddebug9 settext("Left Angle: ");
  level.waterboarddebug10 = newhudelem();
  level.waterboarddebug10.alignx = "left";
  level.waterboarddebug10.foreground = 1;
  level.waterboarddebug10.font = "objective";
  level.waterboarddebug10.sort = 5;
  level.waterboarddebug10.x = 500;
  level.waterboarddebug10.y = 390;
  level.waterboarddebug10.color = (1, 1, 1);
  level.waterboarddebug10 settext("Right Angle: ");

  for(;;) {
    if(isDefined(level.currentpatternduration)) {
      var_0 = "Pattern Duration: " + level.currentpatternduration;
      level.waterboarddebug1 settext(var_0);
    }

    if(isDefined(level.movedurationmin)) {
      var_1 = "Min Move Duration: " + level.movedurationmin;
      level.waterboarddebug2 settext(var_1);
    }

    if(isDefined(level.movedurationmin)) {
      var_2 = "Min Move Duration: " + level.movedurationmax;
      level.waterboarddebug3 settext(var_2);
    }

    if(isDefined(level.movedurationmin)) {
      var_3 = "Passout Threshold: " + level.passoutthreshold;
      level.waterboarddebug4 settext(var_3);
    }

    if(isDefined(level.breathlevel)) {
      var_4 = "Breath Level: " + level.breathlevel;
      level.waterboarddebug5 settext(var_4);
    }

    if(isDefined(level.pouranimpct)) {
      var_5 = "Anim Phase: " + level.pouranimpct;
      level.waterboarddebug6 settext(var_5);
    }

    if(isDefined(level.playerfacingpct)) {
      var_6 = "Facing Pct: " + level.playerfacingpct;
      level.waterboarddebug7 settext(var_6);
    }

    if(isDefined(level.pourdistancediff)) {
      var_7 = "Distance Diff: " + level.pourdistancediff;
      level.waterboarddebug8 settext(var_7);
    }

    if(isDefined(level.currentleftangle)) {
      var_8 = "Left Angle: " + level.currentleftangle;
      level.waterboarddebug9 settext(var_8);
    }

    if(isDefined(level.currentrightangle)) {
      var_9 = "Right Angle: " + level.currentrightangle;
      level.waterboarddebug10 settext(var_9);
    }

    waitframe();
  }
}

break_final_start() {
  level.player lerpfovscalefactor(0, 0);
  break_setup();

  if(!scripts\sp\maps\captive\captive_util.gsc::should_skip_torture_scene()) {
    spawn_barkov();
    spawn_henchman();
    spawn_henchman3();
    level.breakanimref thread scripts\common\anim::anim_loop_solo(level.barkov, "break_final_food_idle", "end_barkov_idle");
    level.barkov detach("military_stun_gun_baton_01", "tag_accessory_right");
    level.barkov detach("barkov_canteen", "j_spinelower");
  }

  level.player.currentspeedscale = 0.5;
  level.player setmovespeedscale(level.player.currentspeedscale);
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);
  level.eyeshutoverlay.lowresbackground = 1;
  level.eyeshutoverlay fadeovertime(0.1);
  level.eyeshutoverlay.alpha = 1;
  level.leftchains = scripts\engine\sp\utility::spawn_anim_model("left_chains", (0, 0, 0), (0, 0, 0));
  level.rightchains = scripts\engine\sp\utility::spawn_anim_model("right_chains", (0, 0, 0), (0, 0, 0));
}

break_final_main() {
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("break_final");
  visionsetnaked("captive_hero", 0);
  var_0 = getEnt("waterboard_floodlight", "targetname");
  var_0 setModel("dynlt_ind_flood_light_standing_tall_off");
  level.player.currentspeedscale = 0.5;
  level.player setmovespeedscale(level.player.currentspeedscale);
  scripts\sp\maps\captive\captive_util.gsc::cellblock_open_door(1);
  level.henchman scripts\common\ai::gun_recall();
  level.henchman3 scripts\common\ai::gun_recall();
  level.foodbowl = scripts\engine\sp\utility::spawn_anim_model("food_bowl");
  level.foodbowl linkTo(level.barkov, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  thread scripts\sp\maps\captive\captive_lighting.gsc::foodbowl_dof();
  playFXOnTag(level._effect["vfx_cpt_food_bowl_maggots"], level.foodbowl, "food_joint");
  level.breakanimref notify("end_barkov_idle");
  level.breakanimref scripts\sp\player_rig::link_player_to_rig("bed_idle", "stand", 0, 0, 0, 0, 0, 0, 0, 1, ::attach_shackles_to_rig);
  level.player_rig_shadow = scripts\engine\sp\utility::spawn_anim_model("player_rig_shadow");
  level.breakanimref thread scripts\common\anim::anim_loop([level.player_rig, level.player_rig_shadow], "bed_idle", "end_idle");
  level.groundrefent = scripts\engine\utility::spawn_script_origin();
  level.groundrefent linkTo(level.player_rig, "tag_camera", (0, 0, 0), (0, 0, 0));
  level.player playersetgroundreferenceent(level.groundrefent);
  wait 5;
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wakeup();
  thread quick_wake_up(1);
  level.breakanimref notify("end_idle");
  level.foodbowl notify("end_start_idle");
  level.breakanimref notify("end_start_idle");
  level.player lerpviewangleclamp(2, 0.25, 0.5, 40, 40, 40, 40);
  [level.leftchains, level.player_rig, level.player_rig_shadow] thread scripts\sp\maps\captive\captive_util.gsc::play_group_single_anim_into_idle_anim(level.breakanimref, "break_final_food_offer", "break_final_food_offer_idle", "end_idle");
  level thread barkov_play_anime_into_idle("break_final_food_offer", "break_final_food_offer_idle");
  level.breakanimref thread scripts\common\anim::anim_single_solo(level.rightchains, "break_final_food_offer");
  level.foodbowl scripts\common\anim::anim_single_solo(level.foodbowl, "break_final_food_offer");
  level.player springcamenabled(1, 5.0, 0.2);
  level.foodbowl thread scripts\common\anim::anim_loop_solo(level.foodbowl, "break_final_food_offer_idle", "end_offer_idle");
  level.foodbowl scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_TAKE");
  level thread check_do_food_nag();
  level.foodbowl thread scripts\sp\maps\captive\captive_util.gsc::check_item_interact();
  level thread scripts\sp\maps\captive\captive_util.gsc::captive_timeout(10);
  var_1 = level scripts\engine\utility::waittill_any_return("player_spat", "item_interact", "timeout");
  scripts\engine\utility::flag_waitopen("barkov_playing_nag");
  level notify("end_nag_check");
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_barkov_intel();
  level.player springcamdisabled(0.5);
  level.foodbowl scripts\sp\player\cursor_hint::remove_cursor_hint();
  level notify("kill_checks");
  level.breakanimref notify("end_idle");

  if(var_1 == "item_interact")
    level.breakanimref thread scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_food_throw");
  else
    level.breakanimref thread scripts\common\anim::anim_single([level.player_rig, level.player_rig_shadow], "break_final_food_throw_refuse");

  level thread notetrack_listener_unshackle();
  thread scripts\sp\maps\captive\captive_lighting.gsc::waterboarding_dof_barkov();
  level thread throw_bowl_and_create_food();
  level thread wait_barkov_grabs_farah();
  level.breakanimref notify("end_barkov_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, "break_final_food_throw");

  if(!scripts\engine\utility::flag("saved_azadeh")) {
    level.breakanimref thread scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_grab_always_knew");
    level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, "break_final_grab_always_knew");
  }

  level.breakanimref thread scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_question");
  barkov_play_anime_into_idle("break_final_question", "break_final_question_idle");
  level.player enableweapons();
  level.breakanswer4 = question_answer_check(4, "break_final_question_nag", "break_final_question_idle");
  level thread wait_barkov_hits_farah();
  question_barkov_response(level.breakanswer4, 4);
  level thread wait_start_choking();
  level thread wait_for_distant_explosion();
  level thread barkov_final_anim_and_cleanup();
  level thread henchmen_final_anim_and_cleanup();
  level thread swap_barkov_model();
  level.breakanimref notify("end_idle");
  level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_grab_exit");
  level.breakanimref notify("end_question_idle");
  level.breakanimref thread scripts\common\anim::anim_loop([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_grab_exit_idle", "end_bed_idle");
  visionsetnaked("", 5);
  level waittill("allow_shackle_exit");
  var_2 = 0;
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_walla_guards_alert();
  var_3 = ["dx_vom_far_cell_escape_spoon_60", "dx_vom_far_cell_escape_spoon_70", "dx_vom_far_cell_escape_spoon_80"];
  var_4 = scripts\engine\sp\utility::create_deck(var_3);
  level.player thread scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(12, "started_shackle_escape", var_4, 15, 1.2, 30);

  while(!var_2) {
    if(level.player getnormalizedmovement()[0] > 0.5)
      var_2 = 1;
    else if(level.player meleeButtonPressed())
      var_2 = 1;

    waitframe();
  }

  level notify("started_shackle_escape");
  level.breakanimref notify("end_bed_idle");
  level.player springcamenabled(1, 5.0, 0.2);
  level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_unshackle_start");
  level.breakanimref thread scripts\common\anim::anim_loop([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_unshackle_idle", "break_final_unshackle_idle");
  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_spoon_02");
  level.player thread scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(12, "item_interact", var_4, 15, 1.2, 30);
  scripts\sp\maps\captive\captive_lighting.gsc::shackle_dof();
  level.player_rig scripts\sp\player\cursor_hint::create_cursor_hint("j_wrist_ri", (0, 0, 0), &"CAPTIVE/CURSOR_LOOSEN", 180, 128, 60, 1);
  level.player_rig thread scripts\sp\maps\captive\captive_util.gsc::check_item_interact();
  level waittill("item_interact");
  level.player lerpviewangleclamp(0.5, 0.2, 0.25, 0, 0, 0, 0);
  level.player scripts\engine\utility::delaycall(3, ::lerpviewangleclamp, 1, 0.2, 0.5, 40, 40, 40, 40);
  level.breakanimref notify("break_final_unshackle_idle");
  level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_unshackle_pull");
  level.breakanimref thread scripts\common\anim::anim_loop([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_unshackle_pull_idle", "end_bed_idle");
  level.player springcamdisabled(0.5);
  scripts\engine\utility::flag_set("escaped_shackles");
  level.player thread scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(12, "get_up", var_4, 15, 1.2, 30);
  level thread check_for_get_up();
  level waittill("get_up");
  level.breakanimref notify("end_bed_idle");
  level.breakanimref thread scripts\common\anim::anim_single_solo(level.leftchains, "break_final_unshackle_exit");
  play_bed_exit("break_final_unshackle_exit", scripts\sp\maps\captive\captive_vo.gsc::vo_break_exit_bed);
  var_5 = scripts\engine\sp\utility::spawn_anim_model("shackles");
  level.breakanimref thread scripts\common\anim::anim_last_frame_solo(var_5, "shackles_on_bed");
  scripts\sp\maps\captive\captive_lighting.gsc::dof_off();
  level.player playersetgroundreferenceent(undefined);
  level.groundrefent delete();
  level.player enableweapons();
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread scripts\engine\sp\utility::autosave_by_name("cell_escape");
}

break_final_main_wegame() {
  scripts\sp\maps\captive\captive_util.gsc::get_cell_chair();

  if(!isDefined(level.leftchains))
    level.leftchains = scripts\engine\sp\utility::spawn_anim_model("left_chains", (0, 0, 0), (0, 0, 0));

  if(!isDefined(level.rightchains))
    level.rightchains = scripts\engine\sp\utility::spawn_anim_model("right_chains", (0, 0, 0), (0, 0, 0));

  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("break_final");
  visionsetnaked("captive_hero", 0);
  var_0 = getEnt("waterboard_floodlight", "targetname");
  var_0 setModel("dynlt_ind_flood_light_standing_tall_off");
  level.player.currentspeedscale = 0.5;
  level.player setmovespeedscale(level.player.currentspeedscale);
  level.breakanimref notify("end_barkov_idle");
  level.breakanimref scripts\sp\player_rig::link_player_to_rig("bed_idle", "stand", 0, 0, 0, 0, 0, 0, 0, 1, ::attach_shackles_to_rig);
  level.player_rig_shadow = scripts\engine\sp\utility::spawn_anim_model("player_rig_shadow");
  level.breakanimref thread scripts\common\anim::anim_loop([level.player_rig, level.player_rig_shadow], "bed_idle", "end_idle");
  level.groundrefent = scripts\engine\utility::spawn_script_origin();
  level.groundrefent linkTo(level.player_rig, "tag_camera", (0, 0, 0), (0, 0, 0));
  level.player playersetgroundreferenceent(level.groundrefent);
  wait 5;
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wakeup();
  thread quick_wake_up(1);
  level.breakanimref notify("end_idle");
  level.breakanimref notify("end_start_idle");
  level.player lerpviewangleclamp(2, 0.25, 0.5, 40, 40, 40, 40);
  level.player springcamenabled(1, 5.0, 0.2);
  level notify("end_nag_check");
  level.player springcamdisabled(0.5);
  level notify("kill_checks");
  level.breakanimref notify("end_idle");
  level thread notetrack_listener_unshackle();
  level.spoon = spawn("script_model", scripts\engine\utility::getStruct("spoon_spawn", "targetname").origin + (0, 0, 1));
  level.spoon.angles = scripts\engine\utility::getStruct("spoon_spawn", "targetname").angles;
  level.spoon setModel("weapon_vm_me_spoon");
  level.player enableweapons();
  visionsetnaked("", 5);
  var_1 = 0;
  var_2 = ["dx_vom_far_cell_escape_spoon_60", "dx_vom_far_cell_escape_spoon_70", "dx_vom_far_cell_escape_spoon_80"];
  var_3 = scripts\engine\sp\utility::create_deck(var_2);
  level.player thread scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(12, "started_shackle_escape", var_3, 15, 1.2, 30);

  while(!var_1) {
    if(level.player getnormalizedmovement()[0] > 0.5)
      var_1 = 1;
    else if(level.player meleeButtonPressed())
      var_1 = 1;

    waitframe();
  }

  level notify("started_shackle_escape");
  level.breakanimref notify("end_bed_idle");
  level.player springcamenabled(1, 5.0, 0.2);
  level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_unshackle_start");
  level.breakanimref thread scripts\common\anim::anim_loop([level.leftchains, level.player_rig, level.player_rig_shadow], "break_final_unshackle_idle", "break_final_unshackle_idle");
  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_cell_escape_spoon_02");
  level.player thread scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(12, "item_interact", var_3, 15, 1.2, 30);
  scripts\sp\maps\captive\captive_lighting.gsc::shackle_dof();
  level.player_rig scripts\sp\player\cursor_hint::create_cursor_hint("j_wrist_ri", (0, 0, 0), &"CAPTIVE/CURSOR_LOOSEN", 180, 128, 60, 1);
  level.player_rig thread scripts\sp\maps\captive\captive_util.gsc::check_item_interact();
  level waittill("item_interact");
  level.player lerpviewangleclamp(0.5, 0.2, 0.25, 0, 0, 0, 0);
  level.player scripts\engine\utility::delaycall(3, ::lerpviewangleclamp, 1, 0.2, 0.5, 40, 40, 40, 40);
  level.breakanimref notify("break_final_unshackle_idle");
  level.breakanimref scripts\common\anim::anim_single([level.player_rig, level.player_rig_shadow], "break_final_unshackle_pull");
  level.breakanimref thread scripts\common\anim::anim_loop([level.player_rig, level.player_rig_shadow], "break_final_unshackle_pull_idle", "end_bed_idle");
  level.player springcamdisabled(0.5);
  scripts\engine\utility::flag_set("escaped_shackles");
  level.player thread scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(12, "get_up", var_3, 15, 1.2, 30);
  level thread check_for_get_up();
  level waittill("get_up");
  level.breakanimref notify("end_bed_idle");
  level.breakanimref thread scripts\common\anim::anim_single_solo(level.leftchains, "break_final_unshackle_exit");
  play_bed_exit("break_final_unshackle_exit", scripts\sp\maps\captive\captive_vo.gsc::vo_break_exit_bed);
  var_4 = scripts\engine\sp\utility::spawn_anim_model("shackles");
  level.breakanimref thread scripts\common\anim::anim_last_frame_solo(var_4, "shackles_on_bed");
  scripts\sp\maps\captive\captive_lighting.gsc::dof_off();
  level.player playersetgroundreferenceent(undefined);
  level.groundrefent delete();
  level.player enableweapons();
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread scripts\engine\sp\utility::autosave_by_name("cell_escape");
}

break_final_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  var_0 = getEnt("waterboard_floodlight", "targetname");
  var_0 setModel("dynlt_ind_flood_light_standing_tall_off");
  scripts\engine\sp\objectives::objective_add("objective", "current", undefined, &"CAPTIVE/OBJ_SURVIVE", &"CAPTIVE/OBJ_SURVIVE");
  setaudiotriggerstate("cap_battle", "under_attack", 3.0);
}

check_do_food_nag() {
  level endon("end_nag_check");
  wait 4;
  scripts\engine\utility::flag_set("barkov_playing_nag");
  level thread barkov_play_anime_into_idle("break_final_food_offer_nag", "break_final_food_offer_idle");
  level.breakanimref notify("end_offer_idle");
  level.foodbowl notify("end_offer_idle");
  level.foodbowl scripts\common\anim::anim_single_solo(level.foodbowl, "break_final_food_offer_nag");
  level.foodbowl thread scripts\common\anim::anim_loop_solo(level.foodbowl, "break_final_food_offer_idle", "end_offer_idle");
  scripts\engine\utility::flag_clear("barkov_playing_nag");
}

throw_bowl_and_create_food() {
  level.foodbowl notify("end_offer_idle");
  level thread wait_hide_bowl();
  level.foodbowl scripts\common\anim::anim_single_solo(level.foodbowl, "break_final_food_throw");
  level.foodbowl delete();
  level.food = scripts\engine\utility::getStruct("food", "targetname");
  playFX(level._effect["vfx_cpt_food_maggots"], level.food.origin, anglesToForward(level.food.angles), (0, 0, 1));
  level.spoon = spawn("script_model", scripts\engine\utility::getStruct("spoon_spawn", "targetname").origin + (0, 0, 1));
  level.spoon.angles = scripts\engine\utility::getStruct("spoon_spawn", "targetname").angles;
  level.spoon setModel("weapon_vm_me_spoon");
}

wait_hide_bowl() {
  level waittill("hide_bowl");
  level.foodbowl hide();
}

wait_barkov_grabs_farah() {
  level waittill("barkov_grabs_farah");
  level.player springcamenabled(1, 5.0, 0.2);
}

wait_barkov_hits_farah() {
  level waittill("barkov_hits_farah");
  level.player thread scripts\sp\anim::play_sound_at_viewheight("dx_vom_far_break_exercise_corner_27");
  level.player playSound("scn_captive_break_barkov_hit_plr");
  level.player shellshock("captive_hit_02", 2);
  level.player scripts\sp\utility::do_damage(25, level.barkov.origin, level.barkov, undefined, "MOD_MELEE");
  level.player playRumbleOnEntity("heavy_1s");
  level.player lerpviewangleclamp(1, 0.2, 0.2, 0, 0, 0, 0);
  wait 2;
  level.player lerpviewangleclamp(1, 0.2, 0.2, 30, 30, 20, 20);
}

swap_barkov_model() {
  level waittill("swap_barkov");
  level.barkov setModel("body_villain_barkov_captive_gloves");
}

wait_start_choking() {
  level waittill("start_choking");
  level.player playRumbleOnEntity("light_1s");

  if(!isDefined(level.player.breathoverlay))
    setup_breath_overlay();

  level.player.breathoverlay fadeovertime(6);
  level.player.breathoverlay.alpha = 1;
  wait 5;
  thread scripts\sp\maps\captive\captive_lighting.gsc::explosion_flicker();
  setsaveddvar("OONLORSMO", 2);
  setsaveddvar("MLLRKTPNRR", 0.1);
  visionsetpain("captive_near_death");
  level.player painvisionon();
  level waittill("stop_choking");
  level.player.breathoverlay fadeovertime(1);
  level.player.breathoverlay.alpha = 0;
  level.player springcamdisabled(0.5);
  level.player painvisionoff();
}

move_rumble_towards_player(var_0) {
  level endon("end_rumble");
  self endon("death");
  self moveTo(level.player.origin, var_0);
}

wait_for_distant_explosion() {
  level waittill("distant_explosion");
  level thread scripts\engine\utility::play_sound_in_space("captive_cell_distant_explosion", scripts\engine\utility::getStruct("distant_explosion_sound", "targetname").origin);
  wait 0.3;
  earthquake(0.6, 2, level.player_rig.origin, 850);
  level.player playRumbleOnEntity("heavy_1s");
  setaudiotriggerstate("cap_battle", "under_attack", 3.0);
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_walla_expl_react();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\engine\utility::exploder("explode_dust");
}

barkov_final_anim_and_cleanup() {
  level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, "break_final_grab_exit");
  level notify("barkov_left");
  level.barkov.fakepapa unlink();
  level.barkov.fakepapa delete();
  level.barkov delete();
  scripts\sp\maps\captive\captive_util.gsc::cellblock_close_door();
}

henchmen_final_anim_and_cleanup() {
  level.breakanimref notify("end_henchman_idle");
  level.breakanimref scripts\common\anim::anim_single([level.henchman, level.henchman3], "break_final_grab_exit");
  level.henchman delete();
  level.henchman3 delete();
}

break_setup() {
  scripts\sp\player\teenagefarah::teenage_farah_cell_setup();
  level.player.lastshocktime = 0;
  level.player setmovespeedscale(0.5);
  level.player.isinshockhold = 0;
  level.player.beingshoved = 0;
  level thread scripts\sp\maps\captive\captive_util.gsc::notetrack_listener_close_cell_doors();
  level thread scripts\sp\maps\captive\captive_util.gsc::notetrack_listener_open_cell_doors();
  level thread scripts\sp\maps\captive\captive_util.gsc::notetrack_listener_close_cellblock_door();
  level thread scripts\sp\maps\captive\captive_util.gsc::notetrack_listener_open_cellblock_door();
  level.breakanimref = scripts\engine\utility::getStruct("cell_center", "targetname");
  scripts\sp\maps\captive\captive_util.gsc::disable_context_melee();
  setomnvar("ui_hide_hud", 1);
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("upstairs");
  scripts\engine\sp\objectives::objective_add("objective", "current", undefined, &"CAPTIVE/OBJ_SURVIVE", &"CAPTIVE/OBJ_SURVIVE");
}

spawn_barkov() {
  if(!isDefined(level.barkov)) {
    level.barkov = scripts\engine\sp\utility::spawn_targetname("barkov");
    level.barkov thread scripts\sp\maps\captive\captive_util.gsc::wait_clear_friendname(30);
    level.barkov.anim_playvo_func = scripts\engine\utility::playsoundontag;
  }
}

barkov_spawn_func() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.demeanoroverride = "casual";
  self.allowdeath = 0;
  self actoraimassistoff();
  scripts\common\ai::gun_remove();
  self.fakepapa = scripts\engine\sp\utility::spawn_anim_weapon("fakepapa", self gettagorigin("tag_stowed_thigh"), self gettagangles("tag_stowed_thigh"), 0);
  self.fakepapa linkTo(self, "tag_stowed_thigh", (0.5, 0, -0.5), (0, 0, 0));
  self detach("head_villain_barkov");
  self attach("head_villain_barkov_blendshape");
  self.headmodel = "head_villain_barkov_blendshape";
  self attach("military_stun_gun_baton_01", "tag_accessory_right");
  self attach("barkov_canteen", "tag_origin");
  self detach("barkov_canteen", "tag_origin");
  self attach("barkov_canteen", "j_spinelower");
  start_eye_barkov();
  self.battlechatterallowed = 0;

  while(!istrue(self.battlechatterallowed))
    wait 0.1;

  scripts\engine\sp\utility::set_battlechatter(0);
}

spawn_henchman() {
  if(!isDefined(level.henchman))
    level.henchman = scripts\engine\sp\utility::spawn_targetname("henchman");
}

spawn_henchman2() {
  if(!isDefined(level.henchman2))
    level.henchman2 = scripts\engine\sp\utility::spawn_targetname("henchman2");
}

spawn_henchman3() {
  if(!isDefined(level.henchman3))
    level.henchman3 = scripts\engine\sp\utility::spawn_targetname("henchman3");
}

henchman_spawn_func() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.demeanoroverride = "casual";
  self.allowdeath = 0;
  self actoraimassistoff();
  scripts\common\ai::gun_remove();
  self.battlechatterallowed = 0;

  while(!istrue(self.battlechatterallowed))
    wait 0.1;

  scripts\engine\sp\utility::set_battlechatter(0);
}

attach_shackles_to_rig() {
  if(!scripts\engine\utility::flag("escaped_shackles"))
    level.player_rig attach("accessory_un_shackle_01", "j_gun");
}

player_play_anime_into_idle(var_0, var_1) {
  level endon("cancel_player_actions");
  level.breakanimref notify("end_player_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.player_rig, var_0);
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.player_rig, var_1, "end_player_idle");
}

barkov_play_anime_into_idle(var_0, var_1) {
  level endon("cancel_barkov_actions");
  scripts\engine\utility::flag_set("barkov_performing_action");
  level.breakanimref notify("end_barkov_idle");
  level.barkov.lastidle = var_1;
  level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, var_0);
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.barkov, var_1, "end_barkov_idle");
  scripts\engine\utility::flag_clear("barkov_performing_action");
  level notify("barkov_anime_ended");
}

barkov_play_idle(var_0) {
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.barkov, var_0, "end_barkov_idle");
}

barkov_play_chained_anime_into_idle(var_0, var_1, var_2) {
  level endon("cancel_barkov_actions");
  scripts\engine\utility::flag_set("barkov_performing_action");
  level.breakanimref notify("end_barkov_idle");
  level.barkov.lastidle = var_2;
  level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, var_0);
  level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, var_1);
  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.barkov, var_2, "end_barkov_idle");
  scripts\engine\utility::flag_clear("barkov_performing_action");
  level notify("barkov_anime_ended");
}

barkov_perform_shock(var_0, var_1, var_2, var_3) {
  level.breakanimref notify("end_barkov_idle");
  level notify("cancel_barkov_actions");

  if(!isDefined(var_0))
    var_0 = undefined;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_1))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  level.barkov thread wait_for_notetrack_shock(var_0, var_1, var_2, var_3);
  scripts\engine\utility::flag_set("barkov_performing_action");

  if(!isDefined(level.barkovmodel)) {
    var_4 = "shock_stand_" + level.barkov get_shock_anim();
    level.barkov scripts\common\anim::anim_single_solo(level.barkov, var_4);
  }

  level.breakanimref thread scripts\common\anim::anim_loop_solo(level.barkov, level.barkov.lastidle, "end_barkov_idle");
  scripts\engine\utility::flag_clear("barkov_performing_action");
  level notify("shock_complete");
}

get_shock_anim() {
  var_0 = "";

  if(distance(level.player.origin, self.origin) > 70)
    var_0 = "far";
  else
    var_0 = "near";

  var_1 = vectorNormalize(level.player.origin - level.barkov.origin);
  var_2 = anglesToForward(level.barkov.angles);
  var_3 = anglestoleft(level.barkov.angles);
  var_4 = vectordot(var_2, var_1);
  var_5 = vectordot(var_3, var_1);
  var_6 = 0;

  if(var_4 > 0.75)
    var_0 = var_0 + "_front";
  else if(var_4 < 0.25) {
    var_0 = var_0 + "_rear";
    var_6 = 1;
  }

  if(var_5 > 0.25 || var_6 && var_5 >= 0)
    var_0 = var_0 + "_left";
  else if(var_5 < -0.25 || var_6 && var_5 < 0)
    var_0 = var_0 + "_right";

  return var_0;
}

barkov_perform_partial_shock(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = undefined;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_2))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(var_4)
    level.barkov enablescriptedlookat(0);

  var_5 = vectorNormalize(level.player.origin - level.barkov.origin);
  var_6 = anglesToForward(level.barkov.angles);
  var_7 = anglestoleft(level.barkov.angles);
  var_8 = vectordot(var_6, var_5);
  var_9 = vectordot(var_7, var_5);
  var_10 = "front";

  if(var_8 < 0.75) {
    if(var_9 >= 0)
      var_10 = "left";
    else
      var_10 = "right";
  }

  playFXOnTag(level._effect["vfx_captive_cattleprod_sparks_01"], level.barkov, "tag_accessory_right");
  var_11 = undefined;

  switch (var_10) {
    case "front":
      var_11 = % cap_cells_020_shock_partial_center_barkov;
      break;
    case "left":
      var_11 = % cap_cells_020_shock_partial_left_barkov;
      break;
    case "right":
      var_11 = % cap_cells_020_shock_partial_right_barkov;
      break;
  }

  level.barkov scripts\engine\utility::delaythread(0.25, scripts\engine\utility::playsoundontag, "cap_cells_020_shocker", "tag_accessory_right");
  level.barkov setanim(var_11);
  wait 0.25;
  level thread shock_player(var_1, var_2, var_3);
  wait 0.75;
  stopFXOnTag(level._effect["vfx_captive_cattleprod_sparks_01"], level.barkov, "tag_accessory_right");
  wait 1.5;
  level.barkov clearanim(var_11, 0.2);

  if(var_4) {
    wait 0.2;
    level.barkov setuplookatfornotetrack();
    level.barkov enablescriptedlookat(1);
  }
}

wait_for_notetrack_shock(var_0, var_1, var_2, var_3) {
  level endon("shock_complete");

  if(!isDefined(var_3))
    var_3 = 0;

  level waittill("shock");
  self.lastshocktime = gettime();
  level thread shock_player(var_0, var_1, var_2, var_3);
}

shock_player(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = undefined;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  level.player scripts\sp\utility::do_damage(25, level.barkov.origin, level.barkov, undefined, "MOD_MELEE");
  level.player thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_exercise_shock_effort();
  level.player viewkick(8, level.barkov.origin, 0);
  earthquake(1, 0.3, level.barkov.origin, 50);
  level.player playRumbleOnEntity("light_1s");

  if(isDefined(var_0)) {
    if(level.player scripts\engine\math::is_point_in_front(var_0.origin)) {
      var_4 = vectortoangles(var_0.origin - level.player.origin);
      shove(level.barkov.origin, var_0.origin, var_4, 0.3);
    } else
      shove(level.barkov.origin, var_0.origin, level.player.angles, 0.3);
  } else {
    var_5 = vectorNormalize(level.player.origin - level.barkov.origin) * 400;
    level.player setvelocity(var_5);
  }

  if(var_3)
    level.player kill();
  else if(var_1) {
    if(!level.player.isinshockhold) {
      level.player.isinshockhold = 1;
      clear_shackled_squat_override();
      level.player scripts\common\utility::allow_stand(0, "shock");
      level.player scripts\common\utility::allow_prone(0, "shock");
      level.player.currentspeedscale = 0;
      level.player.currentpronespeedscale = 0;
      level.player setmovespeedscale(level.player.currentspeedscale);
      wait(var_2);
      level.player.currentspeedscale = 0.5;
      level.player.currentpronespeedscale = 1.25;
      level.player scripts\common\utility::allow_stand(1, "shock");
      level.player scripts\common\utility::allow_crouch(0, "shock");
      level.player forceplaygestureviewmodel("cap_vm_gesture_stand");
      wait 0.4;
      level thread shackled_squat_override();
      level.player scripts\common\utility::allow_prone(1, "shock");
      level.player scripts\common\utility::allow_crouch(1, "shock");
      level thread scripts\sp\maps\captive\captive_util.gsc::player_speed_lerp(0, level.player.currentspeedscale, 2);
      level.player.isinshockhold = 0;
    }
  }

  return 1;
}

wake_up() {
  wait 3.5;
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_wakeup();
  level.eyeshutoverlay fadeovertime(0.6);
  level.eyeshutoverlay.alpha = 0.5;
  wait 0.6;
  level.eyeshutoverlay fadeovertime(0.6);
  level.eyeshutoverlay.alpha = 1.0;
  wait 0.6;
  level.eyeshutoverlay fadeovertime(0.4);
  level.eyeshutoverlay.alpha = 0.7;
  wait 0.4;
  level.eyeshutoverlay fadeovertime(0.5);
  level.eyeshutoverlay.alpha = 1.0;
  wait 0.5;
  level.eyeshutoverlay fadeovertime(1.0);
  level.eyeshutoverlay.alpha = 0.0;
  wait 1.0;
}

quick_wake_up(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    wait 1;

  level.eyeshutoverlay fadeovertime(0.4);
  level.eyeshutoverlay.alpha = 0.5;
  wait 0.4;
  level.eyeshutoverlay fadeovertime(0.3);
  level.eyeshutoverlay.alpha = 1.0;
  wait 0.3;
  level.eyeshutoverlay fadeovertime(0.5);
  level.eyeshutoverlay.alpha = 0.0;
  wait 0.5;
}

play_bed_exit(var_0, var_1) {
  level thread[[var_1]]();

  if(!isDefined(var_0))
    var_0 = "exit_bed";

  level.breakanimref scripts\common\anim::anim_single([level.player_rig, level.player_rig_shadow], var_0);
  level.player_rig_shadow delete();
  scripts\sp\player_rig::unlink_player_from_rig();
}

question_answer_check(var_0, var_1, var_2) {
  setomnvar("ui_dialogue_prompts_choice", 0);

  switch (var_0) {
    case 1:
      setomnvar("ui_dialogue_prompts_option_a", "captive/question_1_lie");
      setomnvar("ui_dialogue_prompts_option_b", "captive/question_1_resist");
      setomnvar("ui_dialogue_prompts_option_c", "captive/question_1_truth");
      setomnvar("ui_dialogue_prompts_option_d", "captive/silence");
      break;
    case 2:
      setomnvar("ui_dialogue_prompts_option_a", "captive/question_2_lie");

      if(level.breakanswer1 == "resist")
        setomnvar("ui_dialogue_prompts_option_b", "captive/question_2_resist_alt");
      else
        setomnvar("ui_dialogue_prompts_option_b", "captive/question_2_resist");

      setomnvar("ui_dialogue_prompts_option_c", "captive/question_2_truth");
      setomnvar("ui_dialogue_prompts_option_d", "captive/silence");
      break;
    case 3:
      setomnvar("ui_dialogue_prompts_option_a", "captive/question_3_lie");
      setomnvar("ui_dialogue_prompts_option_b", "captive/question_3_resist");
      setomnvar("ui_dialogue_prompts_option_c", "captive/question_3_truth");
      setomnvar("ui_dialogue_prompts_option_d", "captive/silence");
      break;
    case 4:
      if(scripts\engine\utility::flag("saved_azadeh"))
        setomnvar("ui_dialogue_prompts_option_a", "captive/question_4_lie_no_azadeh");
      else
        setomnvar("ui_dialogue_prompts_option_a", "captive/question_4_lie");

      setomnvar("ui_dialogue_prompts_option_b", "captive/question_4_resist");
      setomnvar("ui_dialogue_prompts_option_c", "captive/question_4_truth");
      setomnvar("ui_dialogue_prompts_option_d", "captive/silence");
      break;
  }

  setomnvar("ui_dialogue_prompts_duration", 12);
  setomnvar("ui_dialogue_prompts_active", 1);
  level.waitingforresponse = 1;
  level.responsetimedout = 0;
  level thread response_timeout(12);

  if(isDefined(var_1))
    level thread wait_for_question_nag(var_1, var_2);

  while(level.waitingforresponse) {
    if(level.responsetimedout) {
      level notify("question_answered");
      setomnvar("ui_dialogue_prompts_choice", 0);
      scripts\engine\utility::flag_waitopen("doing_question_nag");
      return "timeout";
    } else if(level.player attackButtonPressed() || level.player secondaryoffhandbuttonPressed() || level.player meleeButtonPressed()) {
      var_3 = 1;
      level notify("question_answered");
      setomnvar("ui_dialogue_prompts_choice", 0);
      scripts\engine\utility::flag_waitopen("doing_question_nag");
      var_4 = "dx_vom_far_break_waterboard_interrogate_130";

      switch (var_0) {
        case 2:
          var_4 = "dx_vom_far_break_waterboard_interrogate_134";

          if(level.breakanswer1 == "attack")
            var_4 = "dx_vom_far_break_waterboard_interrogate_136";

          break;
        case 4:
          var_4 = "dx_vom_far_break_final_kiss_95";
          var_3 = 0;
          break;
      }

      level thread play_spit(var_4, var_3);
      scripts\sp\utility::giveachievement_wrapper("barkovspit");
      return "attack";
    } else if(level.player buttonPressed("BUTTON_X") || level.player buttonPressed("1")) {
      level notify("question_answered");
      setomnvar("ui_dialogue_prompts_choice", 1);
      scripts\engine\utility::flag_waitopen("doing_question_nag");
      return "lie";
    } else if(level.player buttonPressed("BUTTON_A") || level.player buttonPressed("2")) {
      level notify("question_answered");
      setomnvar("ui_dialogue_prompts_choice", 2);
      scripts\engine\utility::flag_waitopen("doing_question_nag");
      return "resist";
    } else if(level.player buttonPressed("BUTTON_B") || level.player buttonPressed("3")) {
      level notify("question_answered");
      setomnvar("ui_dialogue_prompts_choice", 3);
      scripts\engine\utility::flag_waitopen("doing_question_nag");
      return "truth";
    } else if(level.player buttonPressed("BUTTON_Y") || level.player buttonPressed("4")) {
      level notify("question_answered");
      setomnvar("ui_dialogue_prompts_choice", 4);
      scripts\engine\utility::flag_waitopen("doing_question_nag");
      return "timeout";
    }

    waitframe();
  }
}

question_barkov_response(var_0, var_1) {
  setomnvar("ui_dialogue_prompts_active", 0);

  switch (var_0) {
    case "timeout":
      switch (var_1) {
        case 1:
          level thread player_play_response("break_wboard_question_response_timeout");
          barkov_play_response("break_wboard_question_response_timeout");
          break;
        case 2:
          level thread player_play_response("break_wboard_question2_response_timeout");
          barkov_play_response("break_wboard_question2_response_timeout");
          break;
        case 4:
          level.breakanimref notify("end_barkov_idle");
          level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow, level.barkov], "break_final_question_response_timeout");
          break;
      }

      break;
    case "attack":
      switch (var_1) {
        case 1:
          level thread player_play_response("break_wboard_question_response_spit");
          barkov_play_response("break_wboard_question_response_spit");
          break;
        case 2:
          level thread player_play_response("break_wboard_question2_response_spit");
          barkov_play_response("break_wboard_question2_response_spit");
          break;
        case 4:
          level.breakanimref notify("end_barkov_idle");
          level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow, level.barkov], "break_final_question_response_spit");
          break;
      }

      break;
    case "lie":
      switch (var_1) {
        case 1:
          level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_100");
          wait 0.5;
          level thread player_play_response("break_wboard_question_response_lie");
          barkov_play_response("break_wboard_question_response_lie");
          break;
        case 2:
          level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_105");
          level thread player_play_response("break_wboard_question2_response_lie");
          barkov_play_response("break_wboard_question2_response_lie");
          break;
        case 4:
          level.breakanimref notify("end_barkov_idle");

          if(scripts\engine\utility::flag("saved_azadeh"))
            level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow, level.barkov], "break_final_question_response_lie_hadir");
          else
            level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow, level.barkov], "break_final_question_response_lie_azadeh");

          break;
      }

      break;
    case "resist":
      switch (var_1) {
        case 1:
          level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_70");
          wait 0.5;
          level thread player_play_response("break_wboard_question_response_resist");
          barkov_play_response("break_wboard_question_response_resist");
          break;
        case 2:
          level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_70");
          wait 0.5;
          level thread player_play_response("break_wboard_question2_response_resist");
          barkov_play_response("break_wboard_question2_response_resist");
          break;
        case 4:
          level.breakanimref notify("end_barkov_idle");
          level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow, level.barkov], "break_final_question_response_resist");
          break;
      }

      break;
    case "truth":
      switch (var_1) {
        case 1:
          level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_50");
          wait 0.25;
          level thread player_play_response("break_wboard_question_response_truth");
          barkov_play_response("break_wboard_question_response_truth");
          break;
        case 2:
          level.player scripts\engine\utility::delaythread(0.25, scripts\engine\sp\utility::play_sound_on_entity, "dx_vom_far_break_waterboard_interrogate_55");
          level thread player_play_response("break_wboard_question2_response_truth");
          barkov_play_response("break_wboard_question2_response_truth");
          break;
        case 4:
          level.breakanimref notify("end_barkov_idle");
          level.breakanimref scripts\common\anim::anim_single([level.leftchains, level.player_rig, level.player_rig_shadow, level.barkov], "break_final_question_response_truth");
          break;
      }

      break;
    case "truth_truth":
      level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_65");
      level thread player_play_response("break_wboard_question2_response_truth_truth");
      barkov_play_response("break_wboard_question2_response_truth_truth");
      break;
    case "lie_lie":
      level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_115");
      level thread player_play_response("break_wboard_question2_response_lie_lie");
      barkov_play_response("break_wboard_question2_response_lie_lie");
      break;
    case "attack_attack":
      level.breakanimref notify("end_barkov_idle");
      level thread player_play_response("break_wboard_question2_response_spit_spit");
      barkov_play_response("break_wboard_question2_response_spit_spit");
      break;
    case "timeout_timeout":
      level thread player_play_response("break_wboard_question2_response_timeout_timeout");
      barkov_play_response("break_wboard_question2_response_timeout_timeout");
      break;
    case "resist_resist":
      level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_far_break_waterboard_interrogate_94");
      level thread player_play_response("break_wboard_question2_response_resist_resist");
      barkov_play_response("break_wboard_question2_response_resist_resist");
      break;
    default:
      break;
  }
}

player_play_response(var_0) {
  level.breakanimref notify("end_player_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.player_rig, var_0);
}

barkov_play_response(var_0) {
  level.breakanimref notify("end_barkov_idle");
  level.breakanimref scripts\common\anim::anim_single_solo(level.barkov, var_0);
}

response_timeout(var_0) {
  self endon("death");
  self endon("kill_checks");

  if(var_0 > 0)
    wait(var_0);

  level.responsetimedout = 1;
}

wait_for_question_nag(var_0, var_1) {
  level endon("question_answered");
  wait 5;
  level thread play_question_nag(var_0, var_1);
}

play_question_nag(var_0, var_1) {
  scripts\engine\utility::flag_set("has_done_question_nag");
  scripts\engine\utility::flag_set("doing_question_nag");
  barkov_play_anime_into_idle(var_0, var_1);
  scripts\engine\utility::flag_clear("doing_question_nag");
}

sleep(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 3;

  if(!isDefined(var_1))
    var_1 = 1;

  level.eyeshutoverlay fadeovertime(var_0);
  level.eyeshutoverlay.alpha = 1;
  wait(var_0);

  if(var_1) {
    level notify("end_idle");
    scripts\sp\player_rig::unlink_player_from_rig();
  }
}

check_for_get_up() {
  level endon("kill_get_up_checks");
  level endon("barkov_left");
  var_0 = 1;

  while(var_0) {
    if(level.player getnormalizedmovement()[0] > 0.5)
      var_0 = 0;
    else if(level.player crouchbuttonPressed() || level.player jumpbuttonPressed())
      var_0 = 0;

    waitframe();
  }

  level notify("get_up");
}

check_player_too_close(var_0) {
  level endon("kill_checks");
  level endon("barkov_left");
  var_1 = 3000;

  if(!isDefined(var_0))
    var_0 = 0;
  else if(var_0)
    var_1 = 2000;

  waitframe();

  for(;;) {
    if(distance2dsquared(level.barkov.origin, level.player.origin) < var_1) {
      if(level.player getstance() == "stand") {
        var_2 = vectorNormalize(level.player getvelocity());

        if(length(var_2) > 0) {
          var_3 = vectordot(var_2, vectorNormalize(level.barkov.origin - level.player.origin));

          if(var_3 > 0.85)
            level notify("got_too_close");
        }
      }
    }

    waitframe();
  }
}

shove(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0.4;

  level.playermover.origin = level.player.origin;
  level.playermover.angles = level.player.angles;
  earthquake(1, 0.3, var_0, 50);
  level.player viewkick(8, var_0, 0);
  level.player playRumbleOnEntity("heavy_1s");
  level.player playerlinktodelta(level.playermover, undefined, var_3, 50, 70, 50, 50);
  level thread shove_gesture();
  level.player thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_shoved();
  scripts\sp\maps\captive\captive_util.gsc::link_player_and_move(0.5, var_1, var_2, 0.1, 0.3);
  level.player unlink();
}

shove_gesture() {
  wait 0.25;

  if(check_gesture_not_obstructed())
    level.player forceplaygestureviewmodel("ges_stumble_1", undefined, 0, 0.75);
}

notetrack_listener_cattleprod_shock_player(var_0) {
  self endon("kill_listeners");
  level waittill("cattleprod_shock_player");
  shock_player(var_0);
}

notetrack_listener_cattleprod_shock_player_at_gate() {
  self endon("kill_listeners");
  self waittill("cattleprod_shock_player_sfx");
  level.barkov scripts\engine\utility::delaythread(0.05, scripts\engine\utility::playsoundontag, "cap_cells_020_shocker", "tag_accessory_right");
}

notetrack_listener_unshackle() {
  self endon("kill_listeners");
  level waittill("start_unshackle");
}

notetrack_listener_enable_spring_cam(var_0) {
  level waittill("enable_spring_cam");

  if(!isDefined(var_0))
    var_0 = 1;

  level.player springcamenabled(var_0, 5.0, 0.2);
}

notetrack_listener_disable_spring_cam(var_0) {
  level waittill("disable_spring_cam");

  if(!isDefined(var_0))
    var_0 = 0.5;

  level.player springcamdisabled(var_0);
}

play_spit(var_0, var_1) {
  level.player lerpviewangleclamp(0.5, 0.1, 0.1, 0, 0, 0, 0);
  wait 0.1;
  level.player forceplaygestureviewmodel("cap_vm_gesture_spit");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_spit(var_0);
  wait 0.3;

  if(var_1)
    playFX(level._effect["vfx_cpt_spit_blood"], level.player getEye() + anglesToForward(level.player getplayerangles()) * 2, anglesToForward(level.player getplayerangles()));
  else
    playFX(level._effect["vfx_cpt_spit_blood"], level.player getEye() + anglesToForward(level.player_rig gettagangles("tag_camera")) * 2, anglesToForward(level.player_rig gettagangles("tag_camera")));

  wait 0.6;
  level.player lerpviewangleclamp(2, 1, 0.5, 40, 40, 40, 40);
}

player_tired_movement() {
  self endon("death");
  self endon("stop_player_tired_movement");
  level.player childthread player_limp();
}

player_limp() {
  level.player.limpmaxpitch = 4;
  level.player.limpmaxroll = 3;
  level.player.limpsteptime = 1;
  level.player.limpdownpct = 0.4;
  level.player.limpuppct = 0.6;
  level.player.limpent = scripts\engine\utility::spawn_tag_origin(self.origin, (0, 0, 0));
  self playersetgroundreferenceent(level.player.limpent);
  var_0 = 0;
  var_1 = getdvarfloat("NSRPQNLSNK") * getdvarfloat("OLMLOTTLRM");
  var_2 = (level.player.limpmaxroll, 0, level.player.limpmaxpitch);
  var_3 = sqrt(2);

  for(;;) {
    waitframe();

    if(!self isonground()) {
      continue;
    }
    if(self getstance() == "prone") {
      continue;
    }
    if(self issprintsliding()) {
      continue;
    }
    if(length2dsquared(level.player getvelocity()) < 1) {
      continue;
    }
    if(scripts\engine\utility::time_has_passed(var_0, level.player.limpsteptime) && abs(level.player getnormalizedmovement()[0] > 0.2) && length(level.player getvelocity()) > 10) {
      if(self issprinting())
        var_4 = 1;
      else {
        var_5 = self getnormalizedmovement();
        var_4 = length2d(var_5) / var_3;
        var_4 = var_4 * 0.8;
      }

      var_6 = var_4 * var_2;
      thread player_limp_step(level.player.limpent, var_6);
      var_0 = gettime();
    }
  }
}

player_limp_step(var_0, var_1) {
  var_2 = adjust_angles_to_player(var_1);
  var_3 = level.player.limpsteptime * level.player.limpdownpct;
  var_4 = min(0.2, var_3 / 2);
  var_0 rotateTo(var_2, var_3, var_4, var_4);
  wait(var_3);
  var_2 = adjust_angles_to_player((0, 0, 0));
  var_5 = level.player.limpsteptime * level.player.limpuppct;
  var_6 = min(0.2, var_5 / 2);
  var_0 rotateTo(var_2, var_5, var_6, var_6);
}

adjust_angles_to_player(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}

do_cough() {
  if(check_gesture_not_obstructed()) {
    level.player playRumbleOnEntity("slide_start");
    level.player forceplaygestureviewmodel("cap_vm_gesture_cough");
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_break_cough();
  }
}

check_gesture_not_obstructed() {
  var_0 = getEnt("bar_clip_check", "targetname");

  if(ispointinvolume(level.player.origin, var_0)) {
    if(level.player scripts\engine\math::is_point_in_front(scripts\engine\utility::getStruct(var_0.target, "targetname").origin))
      return 0;
  }

  var_1 = anglesToForward(level.player.angles) * (20 + length(level.player getvelocity()));

  if(level.player getnormalizedcameramovement()[1] > 0.2) {
    var_2 = anglestoright(level.player.angles) * (20 + length(level.player getvelocity()));

    if(!scripts\engine\trace::ray_trace_passed(level.player.origin + (0, 0, 32), level.player.origin + (0, 0, 32) + var_2, level.player))
      return 0;
  } else if(level.player getnormalizedcameramovement()[1] < -0.2) {
    var_3 = anglestoleft(level.player.angles) * (20 + length(level.player getvelocity()));

    if(!scripts\engine\trace::ray_trace_passed(level.player.origin + (0, 0, 32), level.player.origin + (0, 0, 32) + var_3, level.player))
      return 0;
  }

  if(!scripts\engine\trace::ray_trace_passed(level.player.origin + (0, 0, 32), level.player.origin + (0, 0, 32) + var_1, level.player))
    return 0;

  return 1;
}

clear_player_tired_movement() {
  level notify("stop_player_tired_movement");
  wait 3;
  level.player playersetgroundreferenceent(undefined);
  level.player.limpent delete();
}

shackled_squat_override() {
  self endon("kill_squat_override");
  level.player endon("death");
  level.player scripts\common\utility::allow_crouch(0, "squat");
  level.player scripts\common\utility::allow_prone(0, "squat");
  var_0 = "crouch";

  for(;;) {
    if(var_0 == "stand")
      level.player scripts\engine\utility::waittill_any("stance_pressed", "jump_pressed");
    else
      level.player scripts\engine\utility::waittill_any("stance_pressed", "stance_down_pressed");

    if(!scripts\engine\utility::flag("paused_squat_override")) {
      level.lastsquattime = gettime();

      if(var_0 == "crouch") {
        level.player scripts\common\utility::allow_crouch(1, "squat");
        level.player scripts\common\utility::allow_stand(0, "squat");

        if(check_gesture_not_obstructed())
          level.player forceplaygestureviewmodel("cap_vm_gesture_squat");

        scripts\engine\utility::flag_set("squatting");
        var_0 = "stand";
        continue;
      }

      level.player scripts\common\utility::allow_stand(1, "squat");
      level.player scripts\common\utility::allow_crouch(0, "squat");
      scripts\engine\utility::flag_clear("squatting");
      level.player forceplaygestureviewmodel("cap_vm_gesture_stand");
      var_0 = "crouch";
    }
  }
}

clear_shackled_squat_override() {
  level notify("kill_squat_override");
  level.squatefforts = undefined;

  if(scripts\engine\utility::flag("squatting"))
    level.player scripts\common\utility::allow_stand(1, "squat");
  else
    level.player scripts\common\utility::allow_crouch(1, "squat");

  level.player scripts\common\utility::allow_prone(1, "squat");
  scripts\engine\utility::flag_clear("squatting");
}

thirsty_tired_effects() {
  var_0 = 0.07;
  var_1 = 0.05;
  var_2 = 5;
  var_3 = 0;
  var_4 = var_2;
  level.player.tirednessfactor = 0;
  setsaveddvar("MLTTMLTKOR", var_0);
  setsaveddvar("LSOPQMRPNR", var_1);

  while(!scripts\engine\utility::flag("thirsty_awake")) {
    setblur(var_4, 0.05);
    waitframe();
  }

  var_5 = gettime();
  var_6 = 2.0;
  var_7 = 1;
  var_8 = 0;
  var_9 = 0;
  var_4 = 0;
  var_10 = 0;

  while(var_7 > 0) {
    var_7 = 1 - scripts\engine\math::normalize_value(var_5, var_5 + var_6 * 1000, gettime());
    var_10 = var_7;
    var_8 = scripts\engine\math::factor_value(0, var_0, var_7);
    var_9 = scripts\engine\math::factor_value(0, var_1, var_7);
    var_4 = scripts\engine\math::factor_value(0, var_2, var_7);
    setsaveddvar("MLTTMLTKOR", var_8);
    setsaveddvar("LSOPQMRPNR", var_9);
    setblur(var_4, 0.05);
    waitframe();
  }

  var_0 = 0.01;
  var_1 = 0.01;
  var_2 = 0.1;
  var_11 = 0;
  var_12 = 5;
  var_13 = var_3;

  while(!scripts\engine\utility::flag("clear_blur_fx")) {
    var_3 = sin(var_11);
    var_11 = scripts\engine\math::wrap(0, 360, var_11 + var_12);
    var_3 = (var_3 + 1) / 2;
    var_8 = scripts\engine\math::factor_value(0, var_0, var_3);
    var_9 = scripts\engine\math::factor_value(0, var_1, var_3);
    var_4 = scripts\engine\math::factor_value(0, var_2, var_3);
    var_13 = var_3;
    setsaveddvar("MLTTMLTKOR", var_8);
    setsaveddvar("LSOPQMRPNR", var_9);
    setblur(var_4, 0.05);
    waitframe();
  }

  var_14 = 1;

  while(var_14) {
    var_13 = var_13 - 0.01;

    if(var_13 < 0)
      var_13 = 0;

    var_8 = scripts\engine\math::factor_value(0, var_0, var_13);
    var_9 = scripts\engine\math::factor_value(0, var_1, var_13);
    var_4 = scripts\engine\math::factor_value(0, var_2, var_13);
    setsaveddvar("MLTTMLTKOR", var_8);
    setsaveddvar("LSOPQMRPNR", var_9);
    setblur(var_4, 0.05);

    if(var_13 == 0)
      var_14 = 0;

    waitframe();
  }
}

thirsty_wake_timer(var_0) {
  wait(var_0);
  scripts\engine\utility::flag_set("thirsty_awake");
}

bink_speech() {
  scripts\engine\sp\utility::set_start_location("barkov_speech_player", [level.player]);
  scripts\sp\maps\captive\captive_util.gsc::disable_context_melee();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("upstairs");
  scripts\engine\utility::array_delete(getEntArray("cell_exit_door", "script_noteworthy"));
}

bink_speech_main() {
  var_0 = scripts\engine\utility::getStruct("barkov_speech", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_script_origin();
  move_barkov(var_1);
  level.barkov unlink();
  wait 5;
  var_1 thread scripts\common\anim::anim_single_solo(level.barkov, "bink_speech");
}

move_barkov(var_0) {
  thread stop_move_barkov();
  level endon("picked_spot");
  level.barkov = havemapentseffects("actor_enemy_villain_barkov_old", var_0.origin, var_0.angles, 1);
  level.barkov.ignoreme = 1;
  level.barkov.ignoreall = 1;
  level.barkov.animname = "barkov";
  level.barkov scripts\common\ai::gun_remove();
  level.barkov visiblenotsolid();
  level.barkov forceteleport(var_0.origin, var_0.angles, 10000);
  level.barkov linkTo(var_0);

  for(;;) {
    var_1 = level.player.origin + anglesToForward(level.player.angles) * 60;
    var_2 = level.player.angles + (0, 180, 0);
    var_0.origin = var_1;
    var_0.angles = var_2;
    var_0 scripts\common\anim::anim_first_frame_solo(level.barkov, "bink_speech");
    waitframe();
  }
}

stop_move_barkov() {
  var_0 = 0;

  for(;;) {
    if(level.player useButtonPressed()) {
      var_0++;

      if(var_0 == 10) {
        break;
      }
    } else
      var_0 = 0;

    waitframe();
  }

  level.player playRumbleOnEntity("damage_heavy");
  level notify("picked_spot");
}

start_eye_barkov() {
  self setanim(%lookatplayer_node, 1.0, 0.2, 1.0);
}

stop_eye_barkov() {
  self setanim(%lookatplayer_node, 0.0, 0.2, 1.0);
}