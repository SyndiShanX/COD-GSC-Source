/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_command.gsc
**************************************/

start_outside() {
  iprintln("Command_Outside");
  common_scripts\utility::flag_set("flag_fire_damage_on");
  common_scripts\utility::flag_set("flag_fx_screen_bokehdots_rain");
  maps\black_ice_fx::fx_command_interior_on();
  maps\black_ice_util::player_start("player_start_command_outside");
  thread maps\black_ice_refinery::util_show_destroyed_derrick();
  var_0 = ["struct_ally_start_command_outside_01", "struct_ally_start_command_outside_02"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  maps\_utility::activate_trigger_with_targetname("trig_derrick_ally_7");
  var_1 = getglassarray("glass_command_center");

  foreach(var_3 in var_1) {
  destroyglass(var_3);
  }

  thread maps\black_ice_refinery::util_refinery_stack_cleanup();
  thread command_godrays();
  thread shrink_pdeck_lights();
  maps\black_ice_fx::pipe_deck_water_suppression_fx();
  maps\black_ice_pipe_deck::fx_command_snow();
  maps\black_ice_fx::fx_command_interior_on();
}

start_inside() {
  iprintln("Command_Inside");
  maps\black_ice_util::player_start("player_start_command");
  thread maps\black_ice_refinery::util_show_destroyed_derrick();
  maps\black_ice_fx::fx_command_interior_on();
  var_0 = ["struct_ally_start_command_01", "struct_ally_start_command_02"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  var_1 = getglassarray("glass_command_center");

  foreach(var_3 in var_1) {
  destroyglass(var_3);
  }

  thread maps\black_ice_refinery::util_refinery_stack_cleanup();
  thread command_godrays();
  thread shrink_pdeck_lights();
  maps\black_ice_fx::pipe_deck_water_suppression_fx();
  maps\black_ice_pipe_deck::fx_command_snow();
}

main() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::exploder("command_console_baker");
  enemy_init();
  var_0 = level._command.door_out;
  thread command_geyser_light();
  thread allies();
  thread player_disable_suppression_sequence();
  thread dialog_baker_start();
  thread command_light_change();
  thread set_command_dof();
  thread door_close();
  thread maps\black_ice_audio::sfx_blackice_cmd_fire();
  var_1 = getent("trig_flag_command_done", "targetname");
  var_1 common_scripts\utility::trigger_off();
  common_scripts\utility::exploder("command_center_flashing_button");
  maps\black_ice_util::waittill_trigger_activate_looking_at(level._command.player_enemy, "hint_command_button_press");
  disable_player();
  thread maps\black_ice_audio::sfx_plr_cmd_console();
  maps\_utility::stop_exploder("command_center_flashing_button");
  common_scripts\utility::flag_clear("flag_fire_damage_on");
  common_scripts\utility::flag_set("flag_player_start_sequence");
  thread enable_audio_feedback();
  level waittill("flag_start_lights");
  var_0 thread maps\black_ice_util::open_door(90, 1);
  wait 1;
  common_scripts\utility::flag_wait("flag_command_done");
}

section_flag_inits() {
  common_scripts\utility::flag_init("flag_control_sequence_over");
  common_scripts\utility::flag_init("flag_command_start");
  common_scripts\utility::flag_init("flag_objective_fire_supression");
  common_scripts\utility::flag_init("flag_player_start_sequence");
  common_scripts\utility::flag_init("flag_command_fail_late");
  common_scripts\utility::flag_init("flag_command_done");
  common_scripts\utility::flag_init("flag_command_baker_console_anim");
  common_scripts\utility::flag_init("flag_player_started_input");
  common_scripts\utility::flag_init("flag_player_out_of_red");
  common_scripts\utility::flag_init("flag_player_held_green");
  common_scripts\utility::flag_init("flag_start_control_monitor_fx");
  common_scripts\utility::flag_init("flag_player_failed_control");
  common_scripts\utility::flag_init("flag_player_control_success");
  common_scripts\utility::flag_init("flag_baker_instructing");
  common_scripts\utility::flag_init("flag_start_lights");
  common_scripts\utility::flag_init("flag_blowup_pipes");
  common_scripts\utility::flag_init("flag_audio_feedback");
}

section_precache() {
  maps\_utility::add_hint_string("pull_lever", &"BLACK_ICE_COMMAND_PULL_LEVER", ::hint_pull_lever);
  maps\_utility::add_hint_string("pull_lever_reverse", &"BLACK_ICE_COMMAND_PULL_LEVER_REVERSE", ::hint_pull_lever);
  maps\_utility::add_hint_string("pull_lever_no_glyph", &"BLACK_ICE_COMMAND_PULL_LEVER_NO_GLYPH", ::hint_pull_lever);
  maps\_utility::add_hint_string("pull_lever_no_glyph_reverse", &"BLACK_ICE_COMMAND_PULL_LEVER_NO_GLYPH_REVERSE", ::hint_pull_lever);
  maps\_utility::add_hint_string("pull_lever_pc", &"BLACK_ICE_COMMAND_PULL_LEVER_PC", ::hint_pull_lever);
  maps\_utility::add_hint_string("hint_command_button_press", &"BLACK_ICE_COMMAND_USE_CONSOLE", ::hint_button_press);
  precachestring(&"BLACK_ICE_COMMAND_USE_CONSOLE");
  precachestring(&"BLACK_ICE_COMMAND_FAIL_EARLY");
  precachestring(&"BLACK_ICE_COMMAND_FAIL_LATE");
  precacherumble("steady_rumble");
  precachemodel("head_merrick_udt_head_c");
}

hint_pull_lever() {
  return 0 || common_scripts\utility::flag("flag_player_started_input") || common_scripts\utility::flag("flag_player_out_of_red") || common_scripts\utility::flag("flag_player_dying_on_rig");
}

hint_button_press() {
  return !common_scripts\utility::flag("hint_command_button_press");
}

section_post_inits() {
  level._command = spawnStruct();
  level.player_lever_control_sensitivity = 0.033;
  level.bar_drift_rate = 0.0;
  level.player_lever_input = -0.0036;
  level.water_supression_level = 1;
  level.color_status = 0;
  level._command.player_struct = common_scripts\utility::getstruct("struct_command_player", "targetname");
  level._command.baker_struct = common_scripts\utility::getstruct("struct_command_baker", "targetname");

  if(isDefined(level._command.player_struct)) {
    level._command.baker_enter_struct = common_scripts\utility::getstruct("vignette_controlroom_enter", "script_noteworthy");
    level._command.door_in = maps\black_ice_util::setup_door("model_command_door_in", "blackice_door_refinery");
    level._command.door_out = maps\black_ice_util::setup_door("model_command_door_out", "blackice_door_refinery");
    level._command.baker_enter_struct maps\_anim::anim_first_frame_solo(level._command.door_in, "command_enter");
  } else
    iprintln("black_ice_command.gsc: Warning - Command player struct missing (compiled out?)");
}

enable_audio_feedback() {
  wait 5;
  common_scripts\utility::flag_set("flag_audio_feedback");
}

dialog_baker_start() {
  level endon("flag_player_start_sequence");
  level endon("flag_command_fail_late");
  wait 0.5;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_keeganwereaboutto");
  wait 1.2;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_ineedyouto");
  common_scripts\utility::flag_wait("flag_command_start");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_takeoverthatconsole");
  common_scripts\utility::flag_set("flag_objective_fire_supression");
  wait 4.0;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_rookgetthatguy");
  wait 5.0;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_nowrookgetto");
  var_0 = 0;
  var_1 = 6;
  var_2 = ["black_ice_bkr_nowrookgetto", "black_ice_bkr_takeoverthatconsole", "black_ice_bkr_rookgetthatguy"];

  for(;;) {
    wait(var_1);
    level._allies[0] maps\_utility::smart_dialogue(var_2[var_0]);

    if(var_1 < 30) {
      var_1 = var_1 + 3;
    }

    var_0 = var_0 + 1;

    if(var_0 == var_2.size) {
      var_0 = 0;
    }
  }
}

dialog_baker_success() {
  level endon("flag_command_fail_late");
  level waittill("notify_dialog_command_end");
  thread maps\black_ice_audio::blackice_exfil_music();
}

door_close() {
  var_0 = level._command.door_in;

  if(level.start_point != "command_inside") {
    maps\black_ice_util::waittill_trigger_ent_targetname("trig_command_ally", level._allies);
  }

  common_scripts\utility::flag_wait("flag_command_start");
  common_scripts\utility::flag_wait("flag_player_start_sequence");

  if(level.start_point != "command_inside") {
    var_0 maps\black_ice_util::close_door(undefined, 0.6);
  }

  maps\_utility::activate_trigger_with_targetname("trig_command_ally2_position");
  cleanup_pipedeck();
  maps\black_ice_refinery::util_debris_remove();
  thread event_pipe_explosions();
}

cleanup_pipedeck() {
  level notify("notify_stop_pipedeckfx");
}

allies() {
  level._allies[0] = level._allies[0];
  var_0 = level._command.baker_enter_struct;
  var_1 = level._command.baker_struct;
  var_2 = level._command.door_in;
  common_scripts\utility::array_call(level._allies, ::pushplayer, 1);

  if(level.start_point != "command_inside") {
    var_0 maps\_anim::anim_reach_solo(level._allies[0], "command_enter_approach");
    var_0 maps\_anim::anim_single_solo(level._allies[0], "command_enter_approach");
    level._allies[0] maps\black_ice_util::cover_left_idle();

    while(!level.player maps\_utility::player_looking_at(level._allies[0].origin, 0.5)) {
      wait 0.05;
    }

    level._allies[0] notify("stop_loop");
    level._allies[0] thread maps\black_ice_audio::sfx_command_center_door_open();
    var_2.col_brush connectpaths();
    var_0 maps\_anim::anim_single([level._allies[0], var_2], "command_enter");
  }

  maps\_utility::activate_trigger_with_targetname("trig_command_ally_enter");
  var_1 maps\_anim::anim_reach_solo(level._allies[0], "command_init");
  var_1 thread maps\black_ice_vignette::vignette_single_solo(level._allies[0], "command_init", "command_loop");
  level waittill("notify_baker_push_opfor");
  thread enemies_scene(var_1);
  level waittill("notify_player_end_sequence");
  level._allies[0] maps\black_ice_util::unignore_everything();
  level._allies[0] maps\_utility::set_run_anim("DRS_sprint");
  level._allies[0] maps\_utility::enable_ai_color();
}

enemy_init() {
  var_0 = level._command.baker_struct;
  var_1 = level._command.player_struct;
  var_2 = build_human_model("command_enemy_1", "head_oil_worker_a");
  var_3 = build_human_model("command_enemy_2", "head_oil_worker_c");
  var_4 = maps\_utility::spawn_anim_model("command_opfor1_chair", level._command.baker_struct.origin);
  level._command.baker_enemy = var_2;
  level._command.player_enemy = var_3;
  level._command.enemy_chair = var_4;
  var_0 maps\_anim::anim_first_frame_solo(var_2, "command_start");
  var_1 maps\_anim::anim_first_frame_solo(var_3, "command_start");
  var_0 maps\_anim::anim_first_frame_solo(var_4, "command_start");
}

build_human_model(var_0, var_1) {
  var_2 = maps\_utility::spawn_anim_model(var_0);
  var_2 attach(var_1);
  return var_2;
}

enemies_scene(var_0) {
  var_1 = level._command.baker_enemy;
  var_0 thread maps\_anim::anim_single_solo(var_1, "command_start");
  var_2 = level._command.enemy_chair;
  var_0 thread maps\_anim::anim_single_solo(var_2, "command_start");
  thread maps\black_ice_audio::sfx_baker_move_body_chair(var_2);
}

command_fail_late_death() {
  level waittill("notify_blast_kill_player");
  common_scripts\utility::flag_set("flag_player_dying_on_rig");
  maps\_utility::vision_set_fog_changes("black_ice_exfil_explosive_death", 0.5);
  earthquake(0.5, 0.5, level.player.origin, 2048);
  level.player playrumbleonentity("damage_heavy");
  common_scripts\utility::exploder("exfil_pull_early_explosion");
  thread maps\black_ice_audio::sfx_blackice_tanks_dist_explo();
  level.player thread maps\_gameskill::blood_splat_on_screen("left");
  level.player thread maps\_gameskill::blood_splat_on_screen("right");
  level.player thread maps\_gameskill::blood_splat_on_screen("bottom");
  setdvar("ui_deadquote", &"BLACK_ICE_COMMAND_FAIL_LATE");
  wait 1.0;
  maps\_utility::missionfailedwrapper();
  wait 10;
}

player_disable_suppression_sequence() {
  var_0 = level._command.player_struct;
  var_1 = level._command.baker_struct;
  var_2 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_0 maps\_anim::anim_first_frame_solo(var_2, "command_start");
  var_2 hide();
  var_3 = getEntArray("command_shutoff_button", "targetname");
  var_4 = getEntArray("command_lever_baker", "targetname");
  var_5 = getEntArray("command_monitor_baker", "targetname");
  var_6 = getEntArray("command_lever_player", "targetname");
  var_7 = var_6[0];
  var_8 = getEntArray("command_monitor_player", "targetname");

  foreach(var_10 in var_3) {
    var_10 maps\_utility::assign_animtree("command_shutoff_button");
    var_10 maps\_anim::anim_first_frame_solo(var_10, "command_shutoff_button");
  }

  foreach(var_13 in var_4) {
    var_13 maps\_utility::assign_animtree("command_lever");
    var_13 maps\_anim::anim_first_frame_solo(var_13, "command_baker_end");
  }

  var_7 maps\_utility::assign_animtree("command_lever");
  var_7 thread maps\_anim::anim_single_solo(var_7, "command_player_control");
  maps\_anim::anim_set_rate_single(var_7, "command_player_control", 0.0);
  var_7 setanimtime(level.scr_anim["command_lever"]["command_player_control"], 0.5);

  foreach(var_16 in var_5) {
    var_16 maps\_utility::assign_animtree("command_monitor");
    var_16 maps\_anim::anim_first_frame_solo(var_16, "command_monitor_baker");
  }

  foreach(var_16 in var_8) {
    var_16 maps\_utility::assign_animtree("command_monitor");
    var_16 maps\_anim::anim_first_frame_solo(var_16, "command_monitor_player");
  }

  level waittill("flag_player_start_sequence");
  thread smooth_player_link(var_2, 0.5);
  var_20 = level._command.player_enemy;
  var_0 thread maps\_anim::anim_single_solo(var_20, "command_start");
  thread allies_baker_console_anims(var_1, var_2);
  thread player_input_console_animate(var_0, var_2, var_7);

  foreach(var_10 in var_3) {
  var_10 thread maps\_anim::anim_single_solo(var_10, "command_shutoff_button");
  }

  foreach(var_16 in var_5) {
  var_16 thread maps\_anim::anim_single_solo(var_16, "command_monitor_baker");
  }

  var_25 = 0;

  foreach(var_16 in var_8) {
    if(var_25 == 0) {
      var_16 thread maps\_anim::anim_single_solo(var_16, "command_monitor_player");
      thread monitor_controls_and_fx(var_16);
    }

    var_25 = var_25 + 1;
  }

  thread player_view_manager();
  thread water_shutdown_exploder_manager();
  thread dim_overhead_light();
  player_control_sequence();

  if(common_scripts\utility::flag("flag_command_fail_late")) {
    common_scripts\utility::flag_set("flag_start_lights");
    thread maps\black_ice_audio::sfx_blackice_console_fail_explo();
    var_1 thread maps\_anim::anim_single_solo(level._allies[0], "command_late");

    foreach(var_13 in var_4) {
    var_13 thread maps\_anim::anim_single_solo(var_13, "command_baker_late");
    }

    level.player lerpviewangleclamp(2.0, 0, 0, 0, 0, 0, 0);
    wait 2;
    common_scripts\utility::flag_set("flag_control_sequence_over");
    var_0 thread maps\_anim::anim_single_solo(var_2, "command_late");
    var_7 thread maps\_anim::anim_single_solo(var_7, "command_player_late");
    var_30 = var_2 maps\_utility::getanim("command_late");
    var_31 = var_7 maps\_utility::getanim("command_player_late");
    var_32 = level._allies[0] getanimtime(level.scr_anim["ally1"]["command_late"]);
    var_2 setanimtime(var_30, var_32);
    var_7 setanimtime(var_31, var_32);
    command_fail_late_death();
  } else {
    var_33 = 2.8;
    level.water_supression_level = 0;
    thread dialog_baker_success();
    thread explosions_success(var_33);
    thread sucess_swelling_rumble(var_33, 0.4, 0.3);
    level._allies[0] thread allies_baker_command_end_anim(var_1);

    if(maps\_utility::is_gen4() && !level.ps4) {
      setsaveddvar("r_mbEnable", 2);
    }

    common_scripts\utility::flag_set("flag_start_lights");

    foreach(var_16 in var_5) {
    var_16 thread maps\_anim::anim_single_solo(var_16, "command_monitor_baker_end");
    }

    foreach(var_16 in var_8) {
    var_16 thread maps\_anim::anim_single_solo(var_16, "command_monitor_player_end");
    }

    foreach(var_13 in var_4) {
    var_13 thread maps\_anim::anim_single_solo(var_13, "command_baker_end");
    }

    common_scripts\utility::flag_set("flag_control_sequence_over");
    thread maps\black_ice_audio::sfx_cmd_seq_end();

    if(getdvarint("bi_command_pressure_trial", 0) <= 1) {
      level.player maps\_utility::player_giveachievement_wrapper("LEVEL_11A");
    }

    level._command.enemy_chair delete();
    level.player springcamdisabled(0.5);
    var_7 thread maps\_anim::anim_single_solo(var_7, "command_player_end");
    var_0 maps\_anim::anim_single_solo(var_2, "command_end");
    setsaveddvar("g_speed", 100);
  }

  level.player unlink();
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowmelee(1);
  var_2 delete();
  level notify("notify_player_end_sequence");
  common_scripts\utility::flag_set("flag_command_done");
}

disable_player() {
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player disableweaponswitch();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowmelee(0);

  if(issubstr(level.player getcurrentweapon(), "panzerfaust")) {
    wait 0.75;
  }
}

player_control_sequence() {
  level endon("flag_player_failed_control");
  level waittill("notify_start_player_control");
  var_0 = getdvarint("bi_command_pressure_trial", 0);
  setdvar("bi_command_pressure_trial", var_0 + 1);
  thread display_lever_hint();
  thread player_control_baker_nag_and_fail();
  level notify("notify_player_start_input_test");

  while(!common_scripts\utility::flag("flag_player_started_input")) {
    wait(level.timestep);
  }

  check_hold_bar_in_green();
  common_scripts\utility::flag_set("flag_player_held_green");

  while(common_scripts\utility::flag("flag_baker_instructing")) {
    wait(level.timestep);
  }

  level notify("notify_start_control_minigame");
  thread explosion_progression_control_sequence();
  thread check_hold_bar_in_green_or_die();
  thread player_control_increase_difficulty();
  wait 12.9;
}

check_hold_bar_in_green() {
  common_scripts\utility::flag_clear("flag_player_started_input");
  var_0 = 2.0;
  var_1 = var_0;
  var_2 = 0;
  var_3 = 1;
  var_4 = var_3;

  for(;;) {
    if(level.color_status == 0) {
      var_1 = var_1 - level.timestep;

      if(var_1 < 0.0) {
        break;
      }
    } else
      var_1 = var_0;

    if(level.color_status == 2) {
      var_4 = var_4 - level.timestep;

      if(var_2 == 0 && var_4 < 0.0) {
        common_scripts\utility::flag_clear("flag_player_out_of_red");
        thread display_lever_hint();
        var_2 = 1;
      }
    } else {
      var_4 = var_3;
      var_2 = 0;
      common_scripts\utility::flag_set("flag_player_out_of_red");
    }

    wait(level.timestep);
  }
}

display_lever_hint() {
  maps\_utility::set_console_status();
  var_0 = getsticksconfig();

  if(isDefined(level.ps3) && level.ps3 || isDefined(level.ps4) && level.ps4) {
    if(var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacysouthpaw") {
      maps\_utility::display_hint("pull_lever_no_glyph_reverse");
    }
    else {
      maps\_utility::display_hint("pull_lever_no_glyph");
    }
  } else if(level.console || level.player usinggamepad()) {
    if(var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacysouthpaw") {
      maps\_utility::display_hint("pull_lever_reverse");
    }
    else {
      maps\_utility::display_hint("pull_lever");
    }
  } else
    maps\_utility::display_hint("pull_lever_pc");
}

check_hold_bar_in_green_or_die() {
  level endon("flag_start_lights");
  var_0 = 0;
  var_1 = 0.55;
  var_2 = var_1;

  for(;;) {
    if(level.color_status == 2) {
      var_2 = var_2 - level.timestep;

      if(var_2 < 0.0) {
        break;
      }
    } else
      var_2 = var_1;

    wait(level.timestep);
  }

  common_scripts\utility::flag_set("flag_player_failed_control");
  common_scripts\utility::flag_set("flag_command_fail_late");
}

player_control_increase_difficulty() {
  var_0 = 10;
  var_1 = var_0;
  var_2 = 0.0045;
  var_3 = 0.025;

  while(var_1 > 0.0) {
    var_4 = maps\black_ice_util::normalize_value(0, var_0, var_1);
    var_5 = maps\black_ice_util::factor_value_min_max(var_3, var_2, var_4);
    level.bar_drift_rate = var_5;
    var_1 = var_1 - level.timestep;
    wait(level.timestep);
  }
}

dialog_baker_player_control() {
  level endon("flag_command_fail_late");
  level._allies[0] thread maps\_utility::smart_radio_dialogue("black_ice_bkr_rookthefiresression");
  wait 5.95;
  level._allies[0] thread maps\_utility::smart_radio_dialogue("black_ice_bkr_supressionsdownlets");
  wait 4.2;
  level._allies[0] thread maps\_utility::smart_radio_dialogue("black_ice_bkr_ready321now");
  wait 2.0;
  level._allies[0] thread maps\_utility::smart_radio_dialogue("black_ice_bkr_rookpullthelever");
  wait 2.2;
}

player_control_baker_nag_and_fail() {
  level endon("notify_start_control_minigame");
  level waittill("ps_black_ice_mrk_keepusoutof");
  wait 0.1;
  wait_while_color_status_in_green();
  common_scripts\utility::flag_set("flag_player_failed_control");
  common_scripts\utility::flag_set("flag_command_fail_late");
}

wait_while_color_status_in_green() {
  while(level.color_status == 0) {
    wait(level.timestep);
  }
}

dialog_line_with_flag(var_0, var_1, var_2) {
  common_scripts\utility::flag_set("flag_baker_instructing");
  thread maps\black_ice_util::temp_dialogue_line(var_0, var_1, var_2);
  wait(var_2);
  common_scripts\utility::flag_clear("flag_baker_instructing");
}

allies_baker_command_end_anim(var_0) {
  var_0 maps\_anim::anim_single_solo(self, "command_end", undefined, 0.6);
  self notify("notify_command_end_done");
}

player_input_console_animate(var_0, var_1, var_2) {
  var_3 = 0.085;
  var_4 = 0.26;
  var_5 = 0.072;
  var_6 = 0.6;
  var_7 = 0.5;
  var_8 = 1;
  var_9 = 0.6;
  var_10 = 0.5;
  var_11 = [];
  level endon("flag_control_sequence_over");
  var_0 maps\_anim::anim_single_solo(var_1, "command_start");
  level notify("notify_start_player_control");
  var_0 thread maps\_anim::anim_single_solo(var_1, "command_control");
  maps\_anim::anim_set_rate_single(var_1, "command_control", 0.0);
  var_1 setanimtime(level.scr_anim["player_rig"]["command_control"], 0.5);
  level waittill("notify_player_start_input_test");

  for(;;) {
    var_11 = level.player getnormalizedmovement();
    var_12 = var_11[0] * var_5;

    if(var_8 == 1) {
      if(abs(var_11[0]) > 0.2) {
        var_8 = 0;
        common_scripts\utility::flag_set("flag_player_started_input");
      }
    } else {
      var_10 = maps\black_ice_util::normalize_value(-1, 1, var_11[0]);
      var_9 = var_10;
    }

    var_7 = lerp_value(var_7, var_10, var_4);
    var_6 = lerp_value(var_6, var_9, var_3);
    var_1 setanimtime(level.scr_anim["player_rig"]["command_control"], 1 - var_7);
    var_2 setanimtime(level.scr_anim["command_lever"]["command_player_control"], 1 - var_7);
    broadcast_player_input(1 - var_6);
    wait(level.timestep);
  }
}

dialog_baker_init_control() {
  wait 5;
  level._allies[0] maps\_utility::smart_radio_dialogue("black_ice_bkr_shutdownthefire");
}

freeze_input_until_player_pulls() {
  for(;;) {
    var_0 = level.player getnormalizedmovement();

    if(var_0[0] < -0.2) {
      break;
    }

    wait(level.timestep);
  }

  common_scripts\utility::flag_set("flag_player_started_input");
}

broadcast_player_input(var_0) {
  if(var_0 > 0.5) {
    var_1 = maps\black_ice_util::normalize_value(0.5, 1.0, var_0);
    var_2 = maps\black_ice_util::factor_value_min_max(0, level.player_lever_control_sensitivity, var_1);
  } else {
    var_1 = maps\black_ice_util::normalize_value(0.0, 0.5, var_0);
    var_2 = maps\black_ice_util::factor_value_min_max(level.player_lever_control_sensitivity, 0, var_1);
    var_2 = 0 - var_2;
  }

  level.player_lever_input = var_2;
}

monitor_controls_and_fx(var_0) {
  playFXOnTag(common_scripts\utility::getfx("console_command_start"), var_0, "tag_fx_screen");
  thread start_timed_monitor_fx(var_0);
  var_1 = 0.031;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = [0.0, 0.0, 0.0];
  var_7 = [0.0, 0.0, 0.0];
  var_8 = [0.0, 0.0, 0.0];
  var_9 = [0.0, 0, 0.0];
  var_10 = 0.65;
  var_11 = maps\_utility::spawn_anim_model("command_monitor_fx_green", var_0 gettagorigin("j_monitor"));
  var_12 = maps\_utility::spawn_anim_model("command_monitor_fx_yellow", var_0 gettagorigin("j_monitor"));
  var_13 = maps\_utility::spawn_anim_model("command_monitor_fx_red", var_0 gettagorigin("j_monitor"));
  var_12 hide();
  var_13 hide();
  level.monitor_fx = [var_11, var_12, var_13];

  foreach(var_15 in level.monitor_fx) {
    var_15 linkto(var_0, "j_monitor");
    var_15 setanim(level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_1"], 1, 0.0, 0.0);
    var_15 setanim(level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_2"], 1, 0.0, 0.0);
    var_15 setanim(level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_3"], 1, 0.0, 0.0);
  }

  while(!common_scripts\utility::flag("flag_control_sequence_over")) {
    var_9 = monitor_bar_drift(var_9);
    var_6 = monitor_bar_noise(var_6, var_1);
    var_7 = monitor_bar_noise(var_7, var_1);
    var_8 = monitor_bar_noise(var_8, var_1);
    var_10 = var_10 + level.player_lever_input;
    var_10 = var_10 + var_9[0];
    var_10 = cap_range(var_10, var_1, 1 - var_1);

    foreach(var_15 in level.monitor_fx) {
      var_15 setanimtime(level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_1"], var_10 + var_6[2]);
      var_15 setanimtime(level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_2"], var_10 + var_7[2]);
      var_15 setanimtime(level.scr_anim["command_monitor_fx_green"]["command_monitor_fx_3"], var_10 + var_8[2]);
    }

    var_3 = monitor_color_status(var_3, var_10);

    if(var_10 < 0.5) {
      var_19 = 1;
    }
    else {
      var_19 = 0;
    }

    if(common_scripts\utility::flag("flag_player_failed_control")) {
      if(!var_5) {
        if(var_19) {
          killfxontag(common_scripts\utility::getfx("console_command_green_d"), var_0, "tag_fx_screen");
          killfxontag(common_scripts\utility::getfx("console_command_red_u"), var_0, "tag_fx_screen");
        } else {
          killfxontag(common_scripts\utility::getfx("console_command_green_u"), var_0, "tag_fx_screen");
          killfxontag(common_scripts\utility::getfx("console_command_red_d"), var_0, "tag_fx_screen");
        }

        wait(level.timestep);
        killfxontag(common_scripts\utility::getfx("console_command_start"), var_0, "tag_fx_screen");
        killfxontag(common_scripts\utility::getfx("console_command_timer"), var_0, "tag_fx_screen");
        playFXOnTag(common_scripts\utility::getfx("console_command_fail"), var_0, "tag_fx_screen");
        var_11 hide();
        var_12 hide();
        var_13 show();
        var_5 = 1;
      }
    } else if(!(var_3 == var_4)) {
      switch (var_3) {
        case 0:
          var_11 show();
          var_12 hide();
          var_13 hide();

          if(common_scripts\utility::flag("flag_start_control_monitor_fx")) {
            if(var_19) {
              playFXOnTag(common_scripts\utility::getfx("console_command_green_u"), var_0, "tag_fx_screen");
              stopFXOnTag(common_scripts\utility::getfx("console_command_yellow_u"), var_0, "tag_fx_screen");
            } else {
              playFXOnTag(common_scripts\utility::getfx("console_command_green_d"), var_0, "tag_fx_screen");
              stopFXOnTag(common_scripts\utility::getfx("console_command_yellow_d"), var_0, "tag_fx_screen");
            }
          }

          var_2 = 0;
          level.color_status = 0;
          break;
        case 1:
          var_11 hide();
          var_12 show();
          var_13 hide();

          if(common_scripts\utility::flag("flag_start_control_monitor_fx")) {
            if(var_19) {
              playFXOnTag(common_scripts\utility::getfx("console_command_yellow_u"), var_0, "tag_fx_screen");
              stopFXOnTag(common_scripts\utility::getfx("console_command_red_u"), var_0, "tag_fx_screen");
              stopFXOnTag(common_scripts\utility::getfx("console_command_green_u"), var_0, "tag_fx_screen");
            } else {
              playFXOnTag(common_scripts\utility::getfx("console_command_yellow_d"), var_0, "tag_fx_screen");
              stopFXOnTag(common_scripts\utility::getfx("console_command_red_d"), var_0, "tag_fx_screen");
              stopFXOnTag(common_scripts\utility::getfx("console_command_green_d"), var_0, "tag_fx_screen");
            }
          }

          var_2 = 1;
          level.color_status = 1;
          break;
        case 2:
          var_11 hide();
          var_12 hide();
          var_13 show();

          if(common_scripts\utility::flag("flag_start_control_monitor_fx")) {
            if(var_19) {
              stopFXOnTag(common_scripts\utility::getfx("console_command_yellow_u"), var_0, "tag_fx_screen");
              playFXOnTag(common_scripts\utility::getfx("console_command_red_u"), var_0, "tag_fx_screen");
            } else {
              stopFXOnTag(common_scripts\utility::getfx("console_command_yellow_d"), var_0, "tag_fx_screen");
              playFXOnTag(common_scripts\utility::getfx("console_command_red_d"), var_0, "tag_fx_screen");
            }
          }

          var_2 = 2;
          level.color_status = 2;
          break;
      }

      var_4 = var_3;
    }

    if(common_scripts\utility::flag("flag_audio_feedback")) {
      thread maps\black_ice_audio::sfx_lever_logic(var_2);
    }

    if(common_scripts\utility::flag("flag_start_control_monitor_fx")) {
      switch (var_2) {
        case 0:
          break;
        case 1:
          level.player playrumbleonentity("lever_feedback_light");
          break;
        case 2:
          level.player playrumbleonentity("lever_feedback_heavy");
          break;
      }
    }

    fire_supression_status(var_10);
    wait(level.timestep);
  }

  wait 0.25;
  var_11 hide();
  var_12 hide();
  var_13 hide();
  killfxontag(common_scripts\utility::getfx("console_command_red_u"), var_0, "tag_fx_screen");
  killfxontag(common_scripts\utility::getfx("console_command_red_d"), var_0, "tag_fx_screen");
  wait(level.timestep);
  killfxontag(common_scripts\utility::getfx("console_command_yellow_u"), var_0, "tag_fx_screen");
  killfxontag(common_scripts\utility::getfx("console_command_yellow_d"), var_0, "tag_fx_screen");
  wait(level.timestep);
  killfxontag(common_scripts\utility::getfx("console_command_green_u"), var_0, "tag_fx_screen");
  killfxontag(common_scripts\utility::getfx("console_command_green_d"), var_0, "tag_fx_screen");
  wait(level.timestep);
  killfxontag(common_scripts\utility::getfx("console_command_timer"), var_0, "tag_fx_screen");
  playFXOnTag(common_scripts\utility::getfx("console_command_end"), var_0, "tag_fx_screen");
}

start_timed_monitor_fx(var_0) {
  level waittill("notify_start_control_minigame");
  wait 1.5;
  thread maps\black_ice_audio::sfx_cmd_console_acknowledge();
  common_scripts\utility::flag_set("flag_start_control_monitor_fx");
  playFXOnTag(common_scripts\utility::getfx("console_command_green_u"), var_0, "tag_fx_screen");
  playFXOnTag(common_scripts\utility::getfx("console_command_green_d"), var_0, "tag_fx_screen");
  wait(level.timestep);
  killfxontag(common_scripts\utility::getfx("console_command_start"), var_0, "tag_fx_screen");
  playFXOnTag(common_scripts\utility::getfx("console_command_timer"), var_0, "tag_fx_screen");
}

fire_supression_status(var_0) {
  if(var_0 > 0.5) {
    var_1 = maps\black_ice_util::normalize_value(0.53, 0.86, var_0);
    var_2 = maps\black_ice_util::factor_value_min_max(6.99, 1, var_1);
  } else {
    var_1 = maps\black_ice_util::normalize_value(0.16, 0.47, var_0);
    var_2 = maps\black_ice_util::factor_value_min_max(1, 6.99, var_1);
  }

  level.water_supression_level = int(var_2);
}

monitor_color_status(var_0, var_1) {
  var_2 = [0.32, 0.63];
  var_3 = [0.14, 0.8];

  if(var_1 < var_2[0]) {
    if(var_1 < var_3[0]) {
      var_0 = 2;
    }
    else {
      var_0 = 1;
    }
  } else if(var_1 > var_2[1]) {
    if(var_1 > var_3[1]) {
      var_0 = 2;
    }
    else {
      var_0 = 1;
    }
  } else
    var_0 = 0;

  return var_0;
}

monitor_bar_noise(var_0, var_1) {
  var_2 = 0.0022;

  if(abs(var_0[0] - var_0[1]) < var_2) {
    var_0[0] = var_0[1];
    var_0[1] = randomfloatrange(0 - var_1, var_1);
  } else if(var_0[0] > var_0[1])
    var_0[0] = var_0[0] - var_2;
  else {
    var_0[0] = var_0[0] + var_2;
  }

  var_0[2] = lerp_value(var_0[2], var_0[0], 0.13);
  return var_0;
}

monitor_bar_drift(var_0) {
  var_1 = 0.025;
  var_2 = 3.8;
  var_3 = 3.5;

  if(var_0[2] < 0.0) {
    if(var_0[1] == 0) {
      var_0[1] = 1;
    }
    else {
      var_0[1] = 0;
    }

    var_0[2] = randomfloatrange(var_3, var_2);
  }

  if(var_0[1] == 0) {
    var_0[0] = lerp_value(var_0[0], level.bar_drift_rate, var_1);
  }
  else {
    var_0[0] = lerp_value(var_0[0], 0 - level.bar_drift_rate, var_1);
  }

  var_0[2] = var_0[2] - level.timestep;
  return var_0;
}

explosion_progression_control_sequence() {
  thread explode_wait_quake(5.5, "command_control_1", 0.2, 0.26, 0.75);
  thread explode_wait_quake(8.25, "command_control_2", 0.18, 0.35, 0.85);
  thread explode_wait_quake(9.75, "command_control_3", 0.15, 0.41, 1);
}

explosions_success(var_0) {
  explode_wait_quake(var_0, "command_control_4", 0.4, 0.55, 1.3);
  common_scripts\utility::flag_set("flag_blowup_pipes");
  wait 2.0;
  earthquake(0.35, 1, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  wait 1;
  earthquake(0.4, 0.8, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
  wait 1.6;
  earthquake(0.4, 1.3, level.player.origin, 3000);
  level.player playrumbleonentity("grenade_rumble");
}

explode_wait_quake(var_0, var_1, var_2, var_3, var_4) {
  wait(var_0);
  common_scripts\utility::exploder(var_1);
  thread maps\black_ice_audio::sfx_controlroom_explosions(var_1);
  wait(var_2);
  earthquake(var_3, var_4, level.player.origin, 3000);
}

sucess_swelling_rumble(var_0, var_1, var_2) {
  wait(var_1);
  var_0 = var_0 - (var_1 + var_2);
  var_3 = maps\_utility::get_rumble_ent();
  var_3.intensity = 0.0;
  var_3 thread maps\_utility::rumble_ramp_to(0.4, var_0);
  thread maps\black_ice_util::player_view_shake_blender(var_0, 0.001, 0.21);
  wait(var_0);
  var_3 thread maps\_utility::rumble_ramp_to(0.05, var_2);
  thread maps\black_ice_util::player_view_shake_blender(var_2, 0.21, 0.05);
  wait(var_2 + 0.15);
  var_3 thread maps\_utility::rumble_ramp_to(1.3, 0.2);
  wait 0.2;
  var_3 thread maps\_utility::rumble_ramp_to(0.0, 0.8);
  wait 1.3;
  var_3 delete();
}

command_light_change() {
  level endon("flag_ladder_jumpcheck");
  var_0 = getent("comms_overhead_1", "targetname");
  var_1 = getent("comms_overhead_2", "targetname");
  var_2 = [var_0, var_1];
  var_3 = getEntArray("emergency_red_exfil_light", "targetname");

  foreach(var_5 in var_2) {
  var_5 setlightintensity(2);
  }

  var_7 = getEntArray("command_light_siren", "targetname");
  var_8 = getEntArray("command_light_siren_nolight", "targetname");
  var_9 = getEntArray("command_light_siren_off", "targetname");
  var_10 = getEntArray("command_light_siren_nolight_off", "targetname");
  var_11 = [];
  var_12 = 0;

  foreach(var_14 in var_7) {
    var_11[var_12] = common_scripts\utility::spawn_tag_origin();
    var_11[var_12].origin = var_14 gettagorigin("TAG_fx_main");
    var_11[var_12].angles = var_14 gettagangles("TAG_fx_main");
    var_11[var_12] linkto(var_14, "TAG_fx_main");
    var_12 = var_12 + 1;
  }

  var_16 = [];
  var_12 = 0;

  foreach(var_14 in var_8) {
    var_16[var_12] = common_scripts\utility::spawn_tag_origin();
    var_16[var_12].origin = var_14 gettagorigin("TAG_fx_main");
    var_16[var_12].angles = var_14 gettagangles("TAG_fx_main");
    var_16[var_12] linkto(var_14, "TAG_fx_main");
    var_12 = var_12 + 1;
  }

  foreach(var_14 in var_7) {
  var_14 hide();
  }

  foreach(var_14 in var_8) {
  var_14 hide();
  }

  if(level.start_point != "exfil") {
    level waittill("flag_start_lights");
  }

  wait 0.55;

  foreach(var_5 in var_2) {
    var_5 notify("notify_stop_flicker");
    var_5 setlightintensity(0.0001);
    var_5 setlightradius(12);
  }

  var_25 = 0.6;

  for(;;) {
    maps\_utility::stop_exploder("exfil_wall_alarm_yellow");
    wait(level.timestep);

    if(!common_scripts\utility::flag("flag_vision_exfil_deck") && !common_scripts\utility::flag("flag_player_dying_on_rig")) {
      maps\_utility::vision_set_fog_changes("black_ice_command_red", 0);
    }

    foreach(var_27 in var_11) {
    playFXOnTag(level._effect["command_siren_red"], var_27, "tag_origin");
    }

    foreach(var_27 in var_16) {
    playFXOnTag(level._effect["command_siren_red_low"], var_27, "tag_origin");
    }

    foreach(var_5 in var_3) {
    var_5 setlightintensity(1.2);
    }

    foreach(var_14 in var_7) {
    var_14 show();
    }

    foreach(var_14 in var_8) {
    var_14 show();
    }

    foreach(var_14 in var_9) {
    var_14 hide();
    }

    foreach(var_14 in var_10) {
    var_14 hide();
    }

    wait(var_25);

    if(!common_scripts\utility::flag("flag_vision_exfil_deck") && !common_scripts\utility::flag("flag_player_dying_on_rig")) {
      maps\_utility::vision_set_fog_changes("black_ice_command_yellow", 0);
    }

    foreach(var_27 in var_11) {
    stopFXOnTag(level._effect["command_siren_red"], var_27, "tag_origin");
    }

    foreach(var_27 in var_16) {
    stopFXOnTag(level._effect["command_siren_red_low"], var_27, "tag_origin");
    }

    foreach(var_5 in var_3) {
    var_5 setlightintensity(0.0001);
    }

    foreach(var_14 in var_7) {
    var_14 hide();
    }

    foreach(var_14 in var_8) {
    var_14 hide();
    }

    foreach(var_14 in var_9) {
    var_14 show();
    }

    foreach(var_14 in var_10) {
    var_14 show();
    }

    wait(level.timestep);
    common_scripts\utility::exploder("exfil_wall_alarm_yellow");
    wait(var_25);
  }
}

allies_baker_console_anims(var_0, var_1) {
  var_2 = getent("ally_01_command", "targetname");
  var_2.script_friendname = "Merrick";
  var_2 maps\_utility::add_spawn_function(maps\black_ice_util::spawnfunc_ally);
  var_3 = var_2 maps\_utility::spawn_ai();
  var_3 hide();
  var_3.animname = "ally1";
  var_3.v.invincible = 1;
  var_3 maps\black_ice_util::ignore_everything();
  wait 1.5;
  var_3 show();
  level._allies[0] maps\black_ice_vignette::vignette_end();
  level._allies[0] maps\_utility::stop_magic_bullet_shield();
  level._allies[0] delete();
  level._allies[0] = var_3;
  level waittill("flag_command_baker_console_anim");
  var_0 thread maps\_anim::anim_single_solo(level._allies[0], "command_start");
  var_4 = level._allies[0] maps\_utility::getanim("command_start");
  wait(level.timestep);
  var_5 = var_1 getanimtime(level.scr_anim["player_rig"]["command_start"]);
  level._allies[0] setanimtime(var_4, var_5);
  level waittill("notify_start_control_minigame");
  var_0 thread maps\_anim::anim_single_solo(level._allies[0], "command_control");
}

player_view_manager() {
  level.player endon("death");
  level waittill("notify_control_room_allow_free_look");
  level.player lerpviewangleclamp(1.0, 0, 0, 20, 20, 20, 15);
  level waittill("notify_focus_monitor");
  level.player springcamenabled(0.4, 3.2, 1.6);
  wait 1.5;
  level.player springcamenabled(0.4, 3.2, 0.4);
}

smooth_player_link(var_0, var_1) {
  level.player playerlinktoblend(var_0, "tag_player", var_1);
  wait(var_1);
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  var_0 show();
}

player_anim_countdown() {
  wait(getanimlength(level.scr_anim["player_rig"]["command_start"]));
  level notify("notify_player_command_start_anim_done");
}

water_shutdown_exploder_manager() {
  level waittill("notify_control_room_allow_free_look");
  thread supression_shutdown_sequencer("water_supression_on_1", "water_supression_off_a_1", "water_supression_off_b_1", "water_supression_off_c_1", "water_supression_off_d_1", "water_supression_off_e_1", "water_supression_off_f_1");
  wait 0.5;
  thread supression_shutdown_sequencer("water_supression_on_3", "water_supression_off_a_3", "water_supression_off_b_3", "water_supression_off_c_3", "water_supression_off_d_3", "water_supression_off_e_3", "water_supression_off_f_3");
}

supression_shutdown_sequencer(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [var_6, var_5, var_4, var_3, var_2, var_1, var_0];
  var_8 = 6;

  for(;;) {
    if(var_8 > level.water_supression_level) {
      blend_to_exploder(var_7[var_8], var_7[var_8 - 1]);
      var_8 = var_8 - 1;
    } else if(var_8 < level.water_supression_level) {
      blend_to_exploder(var_7[var_8], var_7[var_8 + 1]);
      var_8 = var_8 + 1;
    }

    if(var_8 == 0) {
      blend_to_exploder(var_6);
      break;
    }

    wait(level.timestep);
  }
}

blend_to_exploder(var_0, var_1) {
  var_2 = 3;

  for(var_3 = 0.1; var_2 > 0; var_2 = var_2 - 1) {
    maps\_utility::stop_exploder(var_0);

    if(isDefined(var_1)) {
      common_scripts\utility::exploder(var_1);
    }

    wait(var_3 / var_2);
    common_scripts\utility::exploder(var_0);

    if(isDefined(var_1)) {
      maps\_utility::stop_exploder(var_1);
    }

    wait(var_3 - var_3 / var_2);
  }

  maps\_utility::stop_exploder(var_0);

  if(isDefined(var_1)) {
    common_scripts\utility::exploder(var_1);
  }
}

event_pipe_explosions() {
  common_scripts\utility::flag_wait("flag_command_start");
  var_0 = getEntArray("model_pipedeck_explosion3_old", "targetname");

  foreach(var_2 in var_0) {
  var_2 delete();
  }

  var_4 = maps\black_ice_util::setup_tag_anim_rig("pipe_explosion2", "pipedeck_explosion2_rig");
  var_5 = maps\black_ice_util::setup_tag_anim_rig("pipe_explosion3", "pipedeck_explosion3_rig");
  var_4 thread maps\black_ice_util::tag_anim_rig_init_and_flag_wait("flag_command_pipes_2", "pipes_explode");
  var_5 thread maps\black_ice_util::tag_anim_rig_init_and_flag_wait("flag_command_pipes_3", "pipes_explode");
  common_scripts\utility::flag_wait("flag_blowup_pipes");
  wait 0.3;
  common_scripts\utility::flag_set("flag_command_pipes_2");
  common_scripts\utility::flag_set("flag_command_pipes_3");
}

dim_overhead_light() {
  wait 3.5;
  var_0 = getent("comms_overhead_1", "targetname");
  var_1 = var_0 getlightintensity();
  var_2 = (0.89, 0.75, 0.57);
  var_3 = 1.4;
  var_4 = 0.05;
  thread transitionlightcolor(var_0, var_2);

  while(var_1 > var_3) {
    var_1 = var_1 - var_4;
    var_0 setlightintensity(var_1);
    common_scripts\utility::waitframe();
  }

  light_pulse(var_0, 1.0);
}

set_command_dof() {
  maps\_art::dof_enable_script(0, 7, 4, 121, 545, 0.3, 2.0);
  level waittill("flag_start_lights");
  maps\_art::dof_disable_script(1.25);
}

light_pulse(var_0, var_1) {
  level endon("flag_start_lights");
  self.light = var_0;
  self.min_intensity = var_1;
  var_2 = var_0 getlightintensity();
  var_3 = self.light getlightintensity();

  for(;;) {
    while(var_3 > var_1) {
      var_3 = var_3 - 0.01;
      self.light setlightintensity(var_3);
      common_scripts\utility::waitframe();
    }

    while(var_3 < var_2) {
      var_3 = var_3 + 0.02;
      self.light setlightintensity(var_3);
      common_scripts\utility::waitframe();
    }

    common_scripts\utility::waitframe();
  }
}

transitionlightcolor(var_0, var_1) {
  self.new_color = var_1;
  var_2 = var_0;
  var_3 = var_2 getlightcolor();

  while(var_3[0] > self.new_color[0]) {
    var_3 = var_3 - (0.01, 0.01, 0.01);
    var_2 setlightcolor(var_3);
    common_scripts\utility::waitframe();
  }

  while(var_3[1] > self.new_color[1]) {
    var_3 = var_3 - (0, 0.01, 0.01);
    var_2 setlightcolor(var_3);
    common_scripts\utility::waitframe();
  }

  while(var_3[2] > self.new_color[2]) {
    var_3 = var_3 - (0, 0, 0.01);
    var_2 setlightcolor(var_3);
    common_scripts\utility::waitframe();
  }
}

notetrack_blast_shake_early(var_0) {
  level notify("notify_blast_kill_player");
}

notetrack_blast_shake_late(var_0) {
  level notify("notify_blast_kill_player");
}

command_godrays() {
  var_0 = getent("cc_gr_origin", "targetname");

  if(maps\_utility::is_gen4()) {
    maps\black_ice_util::god_rays_from_world_location(var_0.origin, "flag_command_start", "flag_teleport_rig", undefined, undefined);
  }
}

command_geyser_light() {
  var_0 = getEntArray("command_geyser", "targetname");
  maps\_utility::trigger_wait_targetname("trig_lights_pipedeck_a");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(2.0);
    var_2 thread maps\black_ice_util::flicker(0.15, 1.0, "notify_stop_flicker");
  }
}

shrink_pdeck_lights() {
  var_0 = getEntArray("lights_pipedeck_a", "targetname");
  var_1 = getEntArray("lights_pipedeck_b", "targetname");
  var_2 = getEntArray("lights_pipedeck_c", "targetname");
  var_3 = [getent("escape_emergency_1", "targetname")];

  foreach(var_5 in var_0) {
  var_5 setlightradius(12);
  }

  foreach(var_5 in var_1) {
  var_5 setlightradius(12);
  }

  foreach(var_5 in var_2) {
  var_5 setlightradius(12);
  }

  foreach(var_5 in var_3) {
  var_5 setlightradius(12);
  }

  level waittill("flag_start_lights");

  foreach(var_5 in var_3) {
  var_5 setlightradius(350);
  }
}

copy_node(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  return var_1;
}

lerp_value(var_0, var_1, var_2) {
  var_3 = (var_1 - var_0) * var_2;
  var_0 = var_0 + var_3;
  return var_0;
}

cap_range(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    var_0 = var_2;
  }
  else if(var_0 < var_1) {
    var_0 = var_1;
  }

  return var_0;
}