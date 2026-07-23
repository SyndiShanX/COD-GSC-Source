/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_tarmac.gsc
******************************************/

start_tarmac() {
  level.commander = maps\hijack_code::spawn_ally("commander_tarmac");
  waittillframeend;
  var_0 = getnode("commander_pre_ramp_node", "targetname");
  level.commander maps\_utility::teleport_ai(var_0);
  var_1 = common_scripts\utility::getStruct("player_start_tarmac", "targetname");
  level.player setOrigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
  maps\hijack_crash::remove_all_weapons_post_crash();
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread tarmac_carnage();
  maps\_audio::aud_send_msg("start_tarmac");
  common_scripts\utility::flag_set("stop_managing_crash_player");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("commander_finished_wake_up_anim");
  thread main_script_thread();
  var_2 = common_scripts\utility::getStruct("agent_helps_player_origin", "targetname");
  thread maps\hijack_crash::animated_telephone();
}

commander_lookat(var_0, var_1) {
  self endon("death");

  for(;;) {
    var_2 = distance(self.origin, level.commander.origin);

    if(var_2 < var_0) {
      break;
    }

    wait 0.1;
  }

  level.commander setlookatentity(self);
  level notify("commander_looks_at_something");
  level endon("commander_looks_at_something");
  wait(var_1);
  level.commander setlookatentity();
}

start_tarmac_2() {
  level.commander = maps\hijack_code::spawn_ally("commander_tarmac");
  waittillframeend;
  var_0 = common_scripts\utility::getStruct("player_start_tarmac_2", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread tarmac_carnage();
  maps\_audio::aud_send_msg("start_tarmac_2");
  common_scripts\utility::flag_set("stop_managing_crash_player");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("commander_finished_wake_up_anim");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("player_exit_plane_1");
  common_scripts\utility::flag_set("player_exit_plane_3");
  common_scripts\utility::flag_set("player_exit_plane_4");
  common_scripts\utility::flag_set("start_checkdeadguy_anim");
  common_scripts\utility::flag_set("move_commander_to_flare_node");
  common_scripts\utility::flag_set("start_flare_event");
  common_scripts\utility::flag_set("fx_crash_trench_fire");
  thread main_script_thread();
  common_scripts\utility::flag_set("commander_finished_wake_up_anim");
  level.tarmac_player_move_speed = 0.6;
  waittillframeend;
  level notify("start_commander_wake_up_anim");
}

tarmac_init_flags() {
  common_scripts\utility::flag_init("player_on_feet_post_crash");
  common_scripts\utility::flag_init("commander_started_ramp_anim");
  common_scripts\utility::flag_init("commander_reached_flare_node");
  common_scripts\utility::flag_init("commander_started_flare_anim");
  common_scripts\utility::flag_init("commander_finished_flare_anim");
  common_scripts\utility::flag_init("commander_finished_engine_react_anim");
  common_scripts\utility::flag_init("spawn_makarov_heli");
  common_scripts\utility::flag_init("commander_ready_for_heli");
  common_scripts\utility::flag_init("start_spotlight_random_targeting");
  common_scripts\utility::flag_init("tail_explosion");
  common_scripts\utility::flag_init("end_guys_waiting_for_commander");
  common_scripts\utility::flag_init("guys_ready_for_door");
  common_scripts\utility::flag_init("start_heli_descent");
  common_scripts\utility::flag_init("heli_landed");
}

tarmac_init_assets() {
  precachemodel("vehicle_mi17_woodland_landing_door");
  precachemodel("vehicle_mi17_woodland_landing_door_obj");
  precachemodel("com_blackhawk_spotlight_on_mg_setup");
  precacheturret("heli_spotlight");
  precachemodel("hjk_plane_debris_02");
  precachemodel("hjk_seat_cover_sml");
}

tarmac_objectives() {
  common_scripts\utility::flag_wait("player_on_feet_post_crash");
  objective_add(maps\_utility::obj("follow_commander"), "current", &"HIJACK_OBJ_COMMANDER", level.commander.origin);
  objective_onentity(maps\_utility::obj("follow_commander"), level.commander, (0, 0, 70));
  common_scripts\utility::flag_wait("player_entered_end_area");
  maps\_utility::objective_complete(maps\_utility::obj("follow_commander"));
  var_0 = common_scripts\utility::getStruct("find_pres_obj", "targetname");
  objective_add(maps\_utility::obj("find_president"), "current", &"HIJACK_OBJ_PRESIDENT_END", var_0.origin);
  common_scripts\utility::flag_wait_or_timeout("player_near_pres", 15);
  objective_position(maps\_utility::obj("find_president"), (0, 0, 0));
  common_scripts\utility::flag_wait_all("guys_ready_for_door", "heli_landed");
  objective_position(maps\_utility::obj("find_president"), level.makarov_heli gettagorigin("tag_handle_objective") + (0, 0, -1));
  level waittill("door_used");
  objective_state(maps\_utility::obj("find_president"), "failed");
}

exit_plane_scene() {
  var_0 = common_scripts\utility::getStruct("post_crash_scene_origin", "targetname");
  var_1 = maps\_utility::spawn_targetname("postcrash_agent1", 1);
  var_1.animname = "plane_exit_agent1";
  var_1 maps\_utility::gun_remove();
  var_2 = maps\_utility::spawn_targetname("postcrash_agent2", 1);
  var_2.animname = "plane_exit_agent2";
  level.daughter = maps\_utility::spawn_targetname("daughter_tarmac");
  level.daughter maps\hijack::setup_daughter();
  var_3 = maps\_utility::spawn_anim_model("daughter_blanket");
  var_3 startusingheroonlylighting();
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "secure_daughter");
  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "secure_daughter");
  var_0 thread maps\_anim::anim_first_frame_solo(level.daughter, "secure_daughter");
  var_0 thread maps\_anim::anim_first_frame_solo(var_3, "secure_daughter");

  if(level.start_point != "tarmac") {
    level waittill("start_commander_wake_up_anim");
  }
  var_4 = getEnt("crashed_plane_engine", "targetname");
  var_4.animname = "engine";
  var_4 maps\_anim::setanimtree();
  var_4 thread maps\_anim::anim_single_solo(var_4, "engine_spin_slow");
  common_scripts\utility::flag_wait("commander_finished_wake_up_anim");

  if(level.start_point != "tarmac_2") {
    var_0 thread maps\_anim::anim_loop_solo(level.commander, "exit_top_idle", "stop_top_loop");
  }
  common_scripts\utility::flag_wait_any("player_exit_plane_1", "start_commander_ramp_anim");
  common_scripts\utility::flag_set("commander_started_ramp_anim");
  var_0 notify("stop_top_loop");

  if(level.start_point != "tarmac_2") {
    level.commander.lastgroundtype = "metal";
    var_0 maps\_anim::anim_single_solo(level.commander, "exit_down_ramp");
    var_0 thread maps\_anim::anim_loop_solo(level.commander, "exit_bottom_idle", "stop_bottom_loop");
  }

  common_scripts\utility::flag_wait("player_exit_plane_3");
  var_0 notify("stop_bottom_loop");
  var_5 = getEnt("engine_outside", "targetname");
  var_5.animname = "engine";
  var_5 maps\_anim::setanimtree();
  var_5 thread maps\_anim::anim_single_solo(var_5, "engine_spin_slow");
  var_1.lastgroundtype = "snow";
  var_2.lastgroundtype = "snow";
  level.daughter.lastgroundtype = "snow";
  var_1 thread play_anim_and_loop(var_0, "secure_daughter", "secure_daughter_loop");
  var_2 thread play_anim_and_loop(var_0, "secure_daughter", "secure_daughter_loop");
  level.daughter thread play_anim_and_loop(var_0, "secure_daughter", "secure_daughter_loop");
  var_3 thread play_anim_and_loop(var_0, "secure_daughter", "secure_daughter_loop");

  if(level.start_point != "tarmac_2") {
    thread agent_secure_daughter_vo(var_1, var_2);
    level.commander.lastgroundtype = "snow";
    var_0 maps\_anim::anim_single_solo(level.commander, "secure_daughter");
    thread tarmac_commander_vo();
  }

  level.commander maps\_utility::disable_cqbwalk();
  level.commander.ignoreall = 0;
  level.commander.notarget = 0;
  level.commander thread commander_tarmac_moves();
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_1 delete();
  var_2 delete();
  level.daughter maps\_utility::stop_magic_bullet_shield();
  level.daughter delete();
  common_scripts\utility::flag_set("commander_ready_for_heli");
}

agent_secure_daughter_vo(var_0, var_1) {
  wait 0.5;
  var_0 maps\_utility::dialogue_queue("hijack_fso1_howdidthey");
  wait 0.5;
  var_1 maps\_utility::dialogue_queue("hijack_fso2_theyknew2");
}

commander_keep_up_with_player() {
  level endon("entered_post_tarmac_area");
  level endon("stop_monitoring_commander_speed");
  wait 0.2;

  for(;;) {
    var_0 = distance_commander_to_player();

    if(var_0 > 120) {
      if(level.commander needs_to_catch_up()) {
        if(var_0 > 240) {
          level.commander.moveplaybackrate = level.commander_base_move_speed + 0.27;
        } else {
          level.commander.moveplaybackrate = level.commander_base_move_speed + 0.16;
        }
      }
    } else {
      level.commander.moveplaybackrate = level.commander_base_move_speed;
      set_player_move_and_jump_speed(level.tarmac_player_move_speed);
    }

    wait 1.0;
  }
}

distance_commander_to_player() {
  var_0 = level.player.origin - level.commander.origin;
  return length(var_0);
}

needs_to_catch_up() {
  var_0 = level.player.origin - self.origin;
  var_0 = vectorNormalize(var_0);
  var_1 = vectorNormalize(self.goalpos - self.origin);
  var_2 = vectordot(var_1, var_0);

  if(var_2 < -0.2) {
    return 0;
  }
  return 1;
}

commander_nag_if_stopped() {
  for(;;) {
    if(commander_velocity() == 0) {
      var_0 = 1;
      var_1 = 5 + randomint(2);

      for(var_2 = 0; var_2 < var_1 && var_0; var_2++) {
        wait 2;
        var_0 = commander_velocity() == 0;
      }

      if(var_0) {
        var_3 = randomint(3);

        if(var_3 == 0) {
          level.commander maps\_utility::dialogue_queue("hijack_cmd_keepmoving2");
        } else if(var_3 == 1) {
          level.commander maps\_utility::dialogue_queue("hijack_cmd_comeon");
        } else if(var_3 == 2) {
          level.commander maps\_utility::dialogue_queue("hijack_cmd_letsgo");
        }
      }
    }

    wait 0.1;
  }
}

commander_velocity() {
  var_0 = level.commander.origin;
  wait 0.05;
  var_1 = level.commander.origin;
  var_2 = distance(var_0, var_1);
  return var_2;
}

commander_tarmac_moves() {
  level endon("entered_post_tarmac_area");
  level.commander_base_move_speed = 1.1;
  level.commander.moveplaybackrate = level.commander_base_move_speed;
  level.commander maps\_utility::set_run_anim("injured_run");
  thread commander_keep_up_with_player();
  childthread commander_nag_if_stopped();
  var_0 = getnode("commander_tarmac_node_1", "targetname");
  thread set_goal_and_idle(var_0);
  common_scripts\utility::flag_wait("move_commander_to_flare_node");
  self notify("stop_relaxed_idle");
  maps\_utility::anim_stopanimscripted();
  tarmac_flare_event();
  var_1 = getnode("commander_tarmac_node_3", "targetname");
  thread set_goal_and_idle(var_1);
  common_scripts\utility::flag_wait_all("commander_finished_engine_react_anim");
  var_2 = common_scripts\utility::getStruct("post_crash_scene_origin", "targetname");
  self notify("stop_relaxed_idle");
  maps\_utility::anim_stopanimscripted();
  var_2 maps\_anim::anim_reach_solo(level.commander, "heli_wave");
  level.commander thread maps\_anim::anim_loop_solo(level.commander, "heli_wait");
  common_scripts\utility::flag_set("commander_ready_for_heli");
  level.makarov_heli maps\_utility::ent_flag_wait("start_commander_anim");
  level.commander notify("stop_loop");
  var_2 maps\_anim::anim_single_solo(level.commander, "heli_wave");
  var_3 = getnode("commander_tarmac_node_4", "targetname");
  thread set_goal_and_idle(var_3);
  self notify("stop_relaxed_idle");
  var_4 = getnode("commander_tarmac_node_5", "targetname");
  self setgoalnode(var_4);
  level waittill("commander_react_to_combat");
  level notify("stop_monitoring_commander_speed");
  animscripts\animset::clear_custom_animset();
  maps\_utility::clear_run_anim();
  maps\_utility::clear_generic_idle_anim();
  self.moveplaybackrate = 1.0;
}

set_goal_and_idle(var_0) {
  self notify("stop_relaxed_idle");
  maps\_utility::anim_stopanimscripted();
  self setgoalnode(var_0);
  self.disablearrivals = 1;
  self.goalradius = 16;
  self endon("stop_relaxed_idle");
  maps\_utility::clear_generic_idle_anim();
  self waittill("goal");
  waittillframeend;
  maps\_anim::anim_loop_solo(self, "relaxed_idle", "stop_relaxed_idle");
}

tarmac_flare_event() {
  thread commander_wait_for_trigger();
  var_0 = common_scripts\utility::getStruct("post_crash_scene_origin", "targetname");
  var_0 maps\_anim::anim_reach_solo(level.commander, "flare_reaction");
  level.commander thread maps\_anim::anim_loop_solo(level.commander, "relaxed_idle");
  common_scripts\utility::flag_wait("start_flare_event");

  if(!common_scripts\utility::flag("commander_finished_engine_react_anim")) {
    maps\_audio::aud_send_msg("flare_gun");
    level.commander notify("stop_loop");
    level.commander.lastgroundtype = "snow";
    common_scripts\utility::flag_set("commander_started_flare_anim");
    var_0 thread maps\_anim::anim_single_solo(level.commander, "flare_reaction");
    thread maps\_flare::flare_from_targetname("tarmac_flare");
    level.commander waittillmatch("single anim", "end");
    common_scripts\utility::flag_set("commander_finished_flare_anim");
  }
}

commander_wait_for_trigger() {
  var_0 = getEnt("commander_flare_vo_trigger", "targetname");
  var_0 waittill("trigger");

  if(!common_scripts\utility::flag("start_engine_explosion")) {
    level.player maps\_utility::radio_dialogue("hijack_fso4_sendingflare");
  }
}

tarmac_commander_vo() {
  wait 1.8;
  level.commander maps\_utility::dialogue_queue("hijack_cmd_evacontheway");
  wait 1;
  level.commander maps\_utility::dialogue_queue("hijack_cmd_team4report");
  wait 0.2;
  level.player maps\_utility::radio_dialogue("hijack_fso4_wounded");
  wait 0.2;

  if(!common_scripts\utility::flag("start_flare_event")) {
    level.commander maps\_utility::dialogue_queue("hijack_cmd_securearea");
  }
}

tarmac_background_chatter() {
  level endon("stop_drunk_walk");
  common_scripts\utility::flag_wait("start_engine_explosion");
  wait 6;
  level.tarmac_radio_org = spawn("script_origin", level.player.origin);
  level.tarmac_radio_org linkTo(level.player);
  level.tarmac_radio_org.linked = 1;
  var_0 = randomfloatrange(0, 5);
  maps\hijack_code::background_chatter("hijack_fso1_confirmation", level.tarmac_radio_org);
  maps\hijack_code::background_chatter("hijack_rt1_onsceneinten", level.tarmac_radio_org);
  wait(var_0);
  maps\hijack_code::background_chatter("hijack_fso2_cordonoff", level.tarmac_radio_org);
  wait(var_0);
  maps\hijack_code::background_chatter("hijack_fso3_leakingfuel", level.tarmac_radio_org);
  wait(var_0);
  maps\hijack_code::background_chatter("hijack_rt1_blackbox", level.tarmac_radio_org);
  wait 0.4;
  maps\hijack_code::background_chatter("hijack_fso3_blackbox", level.tarmac_radio_org);
  wait(var_0);
  maps\hijack_code::background_chatter("hijack_fso2_medical", level.tarmac_radio_org);
  wait(var_0);
  maps\hijack_code::background_chatter("hijack_fso1_satcom", level.tarmac_radio_org);
  wait(var_0);
  maps\hijack_code::background_chatter("hijack_fso3_cockpit", level.tarmac_radio_org);
  wait(var_0);
  maps\hijack_code::background_chatter("hijack_fso2_tailsection", level.tarmac_radio_org);
}

try_start_heart_beat() {
  if(level.start_point == "tarmac") {
    common_scripts\utility::flag_wait("player_exit_plane_2");
  }
  if(level.start_point == "tarmac_2") {
    common_scripts\utility::flag_wait("start_engine_explosion");
  }
  thread maps\hijack_drunk_player::start_player_heartbeat();
}

watch_player_jump() {
  level endon("player_exit_plane_4");
  notifyoncommand("playerjump", "+gostand");
  notifyoncommand("playerjump", "+moveup");

  for(;;) {
    level.player waittill("playerjump");
    wait 0.1;
    level.player allowjump(0);
    wait 1.5;
    level.player allowjump(1);
  }
}

set_player_move_and_jump_speed(var_0) {
  level.player setmovespeedscale(var_0);
  setsaveddvar("jump_height", level.player_original_jump_height * var_0);
}

tarmac_events() {
  common_scripts\utility::flag_wait("stop_managing_crash_player");
  level.player_original_jump_height = getdvarfloat("jump_height");

  if(level.start_point != "tarmac_2") {
    thread post_crash_plane_shake();
  }
  thread post_crash_explosions();
  thread tarmac_background_chatter();

  if(level.start_point != "tarmac" && level.start_point != "tarmac_2") {
    wait 3.5;
  }
  thread maps\hijack_drunk_player::main();
  thread try_start_heart_beat();
  thread player_breathing_sound();
  set_player_move_and_jump_speed(0.2);

  if(!common_scripts\utility::flag("player_exit_plane_4")) {
    thread watch_player_jump();
  }
  thread maps\hijack_drunk_player::aftermath_style_walking();
  common_scripts\utility::flag_set("start_doing_aftermath_walk");
  common_scripts\utility::flag_wait("player_on_feet_post_crash");
  setsaveddvar("player_sprintSpeedScale", 1.1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  wait 0.1;
  common_scripts\utility::flag_wait("player_exit_plane_1");

  if(level.start_point != "tarmac_2") {
    wait 3;
  }
  set_player_move_and_jump_speed(0.24);
  common_scripts\utility::flag_wait("player_exit_plane_3");
  set_player_move_and_jump_speed(0.35);
  level.unsteady_scale = 2.5;
  thread enable_weapons_after_time();

  if(isDefined(level.tarmac_radio_org)) {
    level.tarmac_radio_org.deleteme = 1;
  }
  common_scripts\utility::flag_wait("player_exit_plane_4");
  thread blend_player_move_speed();
  level.unsteady_scale = 1.0;
  setsaveddvar("player_sprintSpeedScale", 1.3);
  level.player allowjump(1);

  if(level.start_point != "tarmac_2") {
    level.dopickyautosavechecks = 0;
    thread maps\_utility::autosave_by_name("exit_airplane");
    wait 2;
    level.dopickyautosavechecks = 1;
  }

  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  setsaveddvar("player_sprintSpeedScale", 1.5);
  common_scripts\utility::flag_set("stop_aftermath_player");
  common_scripts\utility::flag_set("stop_fade_in_out");
  level notify("stop_drunk_walk");
  level notify("kill_limp");
  level notify("not_random_blur");
  level notify("stop_heart");
}

enable_weapons_after_time() {
  wait 11;
  level.player enableweapons();
}

blend_player_move_speed() {
  if(level.start_point == "tarmac_2") {
    level.tarmac_player_move_speed = 0.8;
    set_player_move_and_jump_speed(level.tarmac_player_move_speed);
  } else {
    level.tarmac_player_move_speed = 0.35;

    while(level.tarmac_player_move_speed < 0.8) {
      level.tarmac_player_move_speed = level.tarmac_player_move_speed + 0.05;
      set_player_move_and_jump_speed(level.tarmac_player_move_speed);
      wait 0.5;
    }
  }
}

stop_random_blur() {
  level notify("not_random_blur");
}

restart_random_blur() {
  thread maps\hijack_drunk_player::player_random_blur();
}

post_crash_plane_shake() {
  thread post_crash_plane_props();
  common_scripts\utility::flag_wait("commander_started_ramp_anim");
  stop_random_blur();
  maps\_audio::aud_send_msg("tarmac_shift");
  earthquake(0.3, 5.5, level.player.origin, 80000);
  level.player playRumbleOnEntity("hijack_plane_medium");
  wait 3.5;
  restart_random_blur();
}

post_crash_plane_props() {
  var_0 = common_scripts\utility::getStruct("post_crash_scene_origin", "targetname");
  var_1 = getEnt("cab2_med_door1", "targetname");
  var_2 = getEnt("cab2_med_door2", "targetname");
  var_3 = getEnt("cab2_lg_door1", "targetname");
  var_4 = getEnt("cab2_lg_door2", "targetname");
  var_5 = getEnt("cab1_sm_door1", "targetname");
  var_6 = getEnt("cab1_sm_door2", "targetname");
  var_7 = getEnt("cab1_sm_door3", "targetname");
  var_8 = getEnt("cab1_sm_door4", "targetname");
  var_9 = getEnt("cab1_med_door1", "targetname");
  var_10 = getEnt("cab1_med_door2", "targetname");
  var_11 = getEnt("cab1_med_door3", "targetname");
  var_12 = getEnt("cab1_med_door4", "targetname");
  var_13 = getEnt("cab1_med_door5", "targetname");
  var_14 = getEnt("cab1_med_door6", "targetname");
  var_15 = getEnt("cab1_med_door7", "targetname");
  var_16 = getEnt("cab1_med_door8", "targetname");
  var_17 = getEnt("cab1_lg_door1", "targetname");
  var_18 = getEnt("cab1_drawer1", "targetname");
  var_19 = getEnt("cab1_drawer2", "targetname");
  var_20 = getEnt("cab3_med_door1", "targetname");
  var_21 = getEnt("cab3_med_door2", "targetname");
  var_22 = getEnt("cab3_med_door3", "targetname");
  var_23 = getEnt("cab3_med_door4", "targetname");
  var_24 = getEnt("post_crash_airplane_ladder", "targetname");
  var_25 = getEnt("post_crash_airplane_floor_chunk", "targetname");
  var_26 = getEnt("post_crash_airplane_tire", "targetname");
  var_27 = getEnt("post_crash_airplane_crate", "targetname");
  var_28 = getEnt("post_crash_airplane_crate_2", "targetname");
  var_29 = getEnt("post_crash_pipe_small", "targetname");
  var_30 = getEnt("post_crash_pipe_large", "targetname");
  var_1 thread post_crash_prop_anim(var_0, "post_crash_locker1");
  var_2 thread post_crash_prop_anim(var_0, "post_crash_locker2");
  var_3 thread post_crash_prop_anim(var_0, "post_crash_locker3");
  var_4 thread post_crash_prop_anim(var_0, "post_crash_locker4");
  var_5 thread post_crash_prop_anim(var_0, "post_crash_locker6");
  var_6 thread post_crash_prop_anim(var_0, "post_crash_locker7");
  var_7 thread post_crash_prop_anim(var_0, "post_crash_locker8");
  var_8 thread post_crash_prop_anim(var_0, "post_crash_locker9");
  var_9 thread post_crash_prop_anim(var_0, "post_crash_locker5");
  var_10 thread post_crash_prop_anim(var_0, "post_crash_locker11");
  var_11 thread post_crash_prop_anim(var_0, "post_crash_locker14");
  var_12 thread post_crash_prop_anim(var_0, "post_crash_locker16");
  var_13 thread post_crash_prop_anim(var_0, "post_crash_locker12");
  var_14 thread post_crash_prop_anim(var_0, "post_crash_locker15");
  var_15 thread post_crash_prop_anim(var_0, "post_crash_locker17");
  var_16 thread post_crash_prop_anim(var_0, "post_crash_locker10");
  var_17 thread post_crash_prop_anim(var_0, "post_crash_locker13");
  var_20 thread post_crash_prop_anim(var_0, "post_crash_locker18");
  var_21 thread post_crash_prop_anim(var_0, "post_crash_locker20");
  var_22 thread post_crash_prop_anim(var_0, "post_crash_locker19");
  var_23 thread post_crash_prop_anim(var_0, "post_crash_locker21");
  var_18 thread post_crash_prop_anim(var_0, "post_crash_drawer1");
  var_19 thread post_crash_prop_anim(var_0, "post_crash_drawer2");
  var_24 thread post_crash_prop_anim(var_0, "post_crash_ladder");
  var_25 thread post_crash_prop_anim(var_0, "post_crash_ladder", "J_prop_2");
  var_26 thread post_crash_prop_anim(var_0, "post_crash_tire");
  var_27 thread post_crash_prop_anim(var_0, "post_crash_crate");
  var_28 thread post_crash_prop_anim(var_0, "post_crash_crate", "J_prop_2");
  var_29 thread post_crash_prop_anim(var_0, "post_crash_pipe_small");
  var_30 thread post_crash_prop_anim(var_0, "post_crash_pipe_large");
}

post_crash_prop_anim(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "J_prop_1";
  }
  var_3 = maps\_utility::spawn_anim_model("post_crash_prop");
  waittillframeend;
  var_0 thread maps\_anim::anim_first_frame_solo(var_3, var_1);
  self linkTo(var_3, var_2);
  common_scripts\utility::flag_wait("commander_started_ramp_anim");
  var_0 maps\_anim::anim_single_solo(var_3, var_1);
  waittillframeend;
  var_3 delete();
}

post_crash_explosions() {
  thread distant_explosion();
  thread engine_explosion();
  thread tail_random_explosions();
}

distant_explosion() {
  common_scripts\utility::flag_wait("distant_explosion");
  maps\_audio::aud_send_msg("wreck_exit_expl");
  common_scripts\utility::exploder("distant_exp");
}

engine_explosion() {
  var_0 = getEnt("crashed_plane_engine", "targetname");
  var_1 = getEnt("crashed_plane_engine_destroyed", "targetname");
  var_1 hide();
  common_scripts\utility::flag_wait("start_engine_explosion");
  wait 1;
  maps\_audio::aud_send_msg("engine_explosion");
  stop_random_blur();
  common_scripts\utility::exploder("engine_exp");
  common_scripts\utility::exploder("engine_exp_fire");
  wait 0.1;
  thread player_engine_explosion_react(var_0);
  var_0 hide();
  var_1 show();
  thread commander_engine_explosion_react();
  wait 2.0;
  restart_random_blur();
  common_scripts\utility::flag_set("spawn_makarov_heli");
}

commander_engine_explosion_react() {
  if(!common_scripts\utility::flag("commander_started_flare_anim") || common_scripts\utility::flag("commander_finished_flare_anim")) {
    level.commander notify("stop_loop");
    level.commander maps\_anim::anim_single_solo(level.commander, "engine_stumble");
  } else {
    common_scripts\utility::flag_wait("commander_finished_flare_anim");
  }
  common_scripts\utility::flag_set("commander_finished_engine_react_anim");
}

player_engine_explosion_react(var_0) {
  level.player maps\_utility::dirteffect(var_0.origin);
  level.player shellshock("hijack_engine_explosion", 1);
  level.player dodamage(level.player.health - 1, var_0.origin);
  earthquake(0.5, 1.5, var_0.origin, 10000);
  level.player playRumbleOnEntity("hijack_plane_large");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = var_0.origin - level.player.origin;
  var_4 = vectortoangles(var_3);
  var_2.angles = var_4;
  var_1.angles = level.ground_ref_ent.angles;
  var_1 linkTo(var_2);
  level.custom_linkto_slide = 1;
  var_5 = -1.0 * anglesToForward(var_2.angles);
  level.player setvelocity(var_5 * 400);
  level.custom_linkto_slide_allow_prone = 1;
  level.player maps\hijack_code::hjk_beginsliding();
  level.player playersetgroundreferenceent(var_1);
  var_2 rotatepitch(-25, 0.2, 0, 0.15);
  wait 0.1;
  level.player maps\hijack_code::hjk_endsliding();
  level.custom_linkto_slide_allow_prone = undefined;
  wait 0.6;
  var_2 rotatepitch(25, 0.8, 0.4, 0.1);
  wait 0.8;
  var_1 rotateTo(level.ground_ref_ent.angles, 0.5, 0.4, 0.1);
  wait 0.5;
  level.ground_ref_ent.angles = var_1.angles;
  level.player playersetgroundreferenceent(level.ground_ref_ent);
}

tail_random_explosions() {
  level endon("entered_post_tarmac_area");
  common_scripts\utility::flag_wait("player_exit_plane_4");

  for(;;) {
    common_scripts\utility::exploder("random_tail_exp");
    maps\_audio::aud_send_msg("random_tail_expl");
    earthquake(0.05, 2.0, (8820.26, 7283.35, 239.12), 80000);
    wait(randomfloatrange(8, 15));
  }
}

tail_final_explosion() {
  common_scripts\utility::flag_wait("tail_explosion");
  maps\_audio::aud_send_msg("tail_explosion");
  level notify("big_tail_exp");
  stop_random_blur();
  common_scripts\utility::exploder("final_tail_exp");
  earthquake(0.5, 2.0, (8815.42, 7106.38, 273.014), 80000);
  level.player shellshock("hijack_tail_explosion", 1);
  level.player playRumbleOnEntity("hijack_plane_medium");
  common_scripts\utility::exploder("tail_exp_fire_1");
  common_scripts\utility::exploder("tail_exp_fire_2");
  common_scripts\utility::exploder("tail_exp_fire_3");
  common_scripts\utility::exploder("tail_exp_fire_4");
  restart_random_blur();
}

player_breathing_sound() {
  while(!common_scripts\utility::flag("entered_post_tarmac_area")) {
    level.player maps\_utility::play_sound_on_entity("breathing_hurt_start");
    wait(randomfloatrange(2, 5));
  }

  level.player maps\_utility::play_sound_on_entity("breathing_better");
}

tarmac_dead_allies() {
  wait 1;
  level.secret_service_dead = maps\_utility::array_spawn_targetname("dead_secret_service");
  level.secret_service_dead_no_weapons = maps\_utility::array_spawn_targetname("dead_secret_service_no_weapon");

  foreach(var_1 in level.secret_service_dead_no_weapons) {}
  var_1 maps\_utility::gun_remove();

  level.secret_service_dead = common_scripts\utility::array_combine(level.secret_service_dead, level.secret_service_dead_no_weapons);

  foreach(var_1 in level.secret_service_dead) {
    var_1.no_pain_sound = 1;
    var_1.diequietly = 1;
    var_1.delete_on_death = 0;
    var_1 kill();
  }
}

main_script_thread() {
  common_scripts\utility::flag_set("pause_inflight_fx");
  common_scripts\utility::flag_clear("pause_tarmac_fx");
  thread maps\_blizzard_hijack::_id_567C(3);
  thread maps\_blizzard_hijack::_id_5692();
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::flag_init("stop_aftermath_player");
  thread tarmac_fail_conditions();
  thread exit_plane_scene();
  thread tarmac_objectives();
  thread tarmac_events();
  thread makarov_heli();
  thread maps\hijack_script_2b::main();
}

tarmac_fail_conditions() {
  common_scripts\utility::flag_wait("tarmac_level_fail");
  setDvar("ui_deadquote", &"HIJACK_FAIL_TARMAC");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

tarmac_carnage() {
  tarmac_dead_allies();
  wait 1;
  var_0 = common_scripts\utility::getStruct("post_crash_scene_origin", "targetname");
  thread fso_idlers(var_0);
  thread fso_check_deadguy(var_0);
  thread fso_scout_and_terrorist(var_0);
  wait 1;
  thread fso_engine_react();
  thread fso_tail_explosion_react(var_0);
  thread fso_trapped_agent(var_0);
  wait 1;
  var_1 = getaiarray();

  foreach(var_3 in var_1) {
    if(!isenemyteam(var_3.team, level.player.team)) {
      var_3 thread maps\hijack_code::cold_breath_hijack();
    }
  }
}

fso_idlers(var_0) {
  var_1[0] = maps\_utility::spawn_targetname("FSO_idlers_0");
  var_1[1] = maps\_utility::spawn_targetname("FSO_idlers_1");
  var_1[2] = maps\_utility::spawn_targetname("FSO_idlers_2");
  var_1[2] maps\_utility::deletable_magic_bullet_shield();
  var_1[0] thread maps\hijack_code::cold_breath_hijack();
  var_1[1] thread maps\hijack_code::cold_breath_hijack();
  var_1[2] thread maps\hijack_code::cold_breath_hijack();

  foreach(var_3 in var_1) {
    var_3.animname = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::gun_remove();
    }
  }

  var_0 thread maps\_anim::anim_loop_solo(var_1[0], "injured_hands_on_knees");
  var_0 thread maps\_anim::anim_loop_solo(var_1[1], "injured_on_back");
  var_0 thread maps\_anim::anim_loop_solo(var_1[2], "injured_leg_loop");
  common_scripts\utility::flag_wait("fso_arm_vo");
  wait 0.5;
  var_1[1] maps\_utility::dialogue_queue("hijack_fso1_myarm");
  common_scripts\utility::flag_wait("entered_post_tarmac_area");

  if(isDefined(var_1[0])) {
    var_1[0] delete();
  }
  if(isDefined(var_1[2])) {
    var_1[2] delete();
  }
}

fso_check_deadguy(var_0) {
  var_1 = [];
  var_1[0] = maps\_utility::spawn_targetname("FSO_check_deadguy_agent");
  var_1[1] = maps\_utility::spawn_targetname("FSO_check_deadguy_hijacker");
  var_1[1].ignoreall = 1;
  var_1[1].ignoreme = 1;
  var_1[1] maps\_utility::gun_remove();
  var_1[0] thread maps\hijack_code::cold_breath_hijack();
  var_1[0] thread commander_lookat(400, 3.0);
  var_1[0].animname = "checkguy";
  var_1[1].animname = "deadguy";
  var_0 thread maps\_anim::anim_first_frame(var_1, "checkdeadguy_start");
  common_scripts\utility::flag_wait("start_checkdeadguy_anim");
  var_0 maps\_anim::anim_single(var_1, "checkdeadguy_start");
  var_0 thread maps\_anim::anim_loop(var_1, "checkdeadguy_loop");
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_1[0] delete();
  var_1[1] delete();
}

fso_scout_and_terrorist(var_0) {
  var_1 = maps\_utility::spawn_targetname("FSO_scout");
  var_2 = maps\_utility::spawn_targetname("buried_hijacker");
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_2.ignoreall = 1;
  var_2.ignoreme = 1;
  var_2 maps\_utility::gun_remove();
  var_2 thread maps\hijack_code::cold_breath_hijack();
  var_1 thread maps\hijack_code::cold_breath_hijack();
  var_1.animname = "generic";
  var_2.animname = "generic";
  var_2 thread commander_lookat(400, 3.0);
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "scout_finds_buried_hijacker");
  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "buried_hijacker");
  var_3 = maps\_utility::spawn_anim_model("plane_seats");
  waittillframeend;
  var_0 thread maps\_anim::anim_first_frame_solo(var_3, "buried_prop");
  var_3 attach("hjk_seat_cover_sml", "J_prop_1");
  common_scripts\utility::flag_wait("move_commander_to_flare_node");
  wait 2;
  var_1.lastgroundtype = "snow";
  var_0 thread maps\_anim::anim_single_solo(var_1, "scout_finds_buried_hijacker");
  var_0 thread maps\_anim::anim_single_solo(var_2, "buried_hijacker");
  var_0 thread maps\_anim::anim_single_solo(var_3, "buried_prop");
  var_2 waittillmatch("single anim", "die");
  thread maps\_anim::anim_set_rate_single(var_2, "buried_hijacker", 0.0);
  thread maps\_anim::anim_set_rate_single(var_3, "buried_prop", 0.0);
  var_2 notify("stop personal effect");
  var_2.team = "neutral";
  var_1 setgoalpos(var_1.origin);
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_2 delete();
  var_1 delete();
}

fso_engine_react() {
  var_0[0] = maps\_utility::spawn_targetname("FSO_engine_react_0");
  var_0[1] = maps\_utility::spawn_targetname("FSO_engine_react_1");
  var_0[2] = maps\_utility::spawn_targetname("FSO_engine_react_2");
  var_0[0] thread maps\hijack_code::cold_breath_hijack();
  var_0[1] thread maps\hijack_code::cold_breath_hijack();
  var_0[2] thread maps\hijack_code::cold_breath_hijack();
  var_1 = common_scripts\utility::getStruct("temp_exp_anim_origin", "targetname");

  foreach(var_3 in var_0) {
    var_3.animname = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::gun_remove();
    }
  }

  var_0[2] delete();
  var_1 thread maps\_anim::anim_first_frame_solo(var_0[0], "drag_from_engine_agent1");
  var_1 thread maps\_anim::anim_first_frame_solo(var_0[1], "drag_from_engine_agent2");
  common_scripts\utility::flag_wait("start_exp_anims");
  var_1 thread maps\_anim::anim_single_solo(var_0[0], "drag_from_engine_agent1");
  var_1 thread maps\_anim::anim_single_solo(var_0[1], "drag_from_engine_agent2");
  var_0[0] waittillmatch("single anim", "end");
  var_1 thread maps\_anim::anim_loop_solo(var_0[0], "drag_from_engine_agent1_loop");
  var_1 thread maps\_anim::anim_loop_solo(var_0[1], "drag_from_engine_agent2_loop");
}

fso_tail_explosion_react(var_0) {
  var_1[0] = maps\_utility::spawn_targetname("FSO_tail_react_0");
  var_1[1] = maps\_utility::spawn_targetname("FSO_tail_react_1");
  var_1[0] maps\_utility::deletable_magic_bullet_shield();
  var_1[0] thread maps\hijack_code::cold_breath_hijack();
  var_1[1] thread maps\hijack_code::cold_breath_hijack();

  foreach(var_3 in var_1) {
    var_3.animname = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::gun_remove();
    }
  }

  var_0 thread maps\_anim::anim_loop_solo(var_1[0], "reach_to_explosion_agent1_loop_start", "stop_tail_exp_loop");
  var_0 thread maps\_anim::anim_loop_solo(var_1[1], "reach_to_explosion_agent2_loop_start", "stop_tail_exp_loop");
  common_scripts\utility::flag_wait("start_tail_exp_anims");
  var_0 notify("stop_tail_exp_loop");
  var_0 thread maps\_anim::anim_single_solo(var_1[0], "reach_to_explosion_agent1");
  var_0 thread maps\_anim::anim_single_solo(var_1[1], "reach_to_explosion_agent2");
  var_1[0] waittillmatch("single anim", "explosion_reaction_2");
  common_scripts\utility::flag_set("tail_explosion");
  wait 2;
  var_1[0] maps\_utility::dialogue_queue("hijack_fso1_injuredman");
  var_1[0] waittillmatch("single anim", "end");
  var_0 thread maps\_anim::anim_loop_solo(var_1[0], "reach_to_explosion_agent1_loop_end");
  var_0 thread maps\_anim::anim_loop_solo(var_1[1], "reach_to_explosion_agent2_loop_end");
}

fso_trapped_agent(var_0) {
  var_1[0] = maps\_utility::spawn_targetname("FSO_trapped_agent_0");
  var_1[1] = maps\_utility::spawn_targetname("FSO_trapped_agent_1");
  var_1[2] = maps\_utility::spawn_targetname("FSO_trapped_agent_2");
  var_1[0] thread maps\hijack_code::cold_breath_hijack();
  var_1[1] thread maps\hijack_code::cold_breath_hijack();
  var_1[2] thread maps\hijack_code::cold_breath_hijack();

  foreach(var_3 in var_1) {
    var_3.animname = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::gun_remove();
    }
  }

  var_0 thread maps\_anim::anim_first_frame_solo(var_1[0], "samaritan_start");
  var_0 thread maps\_anim::anim_first_frame_solo(var_1[1], "limping_agent_start");
  var_0 thread maps\_anim::anim_first_frame_solo(var_1[2], "trapped_agent_start");
  var_5 = maps\_utility::spawn_anim_model("metal_beam");
  waittillframeend;
  var_0 thread maps\_anim::anim_first_frame_solo(var_5, "trapped_prop");
  var_5 attach("hjk_plane_debris_02", "J_prop_1");
  common_scripts\utility::flag_wait("start_trapped_anims");
  var_1[0].lastgroundtype = "snow";
  var_1[0] thread play_anim_and_loop(var_0, "samaritan_start", "samaritan_loop");
  var_1[1] thread play_anim_and_loop(var_0, "limping_agent_start", "limping_agent_loop");
  var_1[2] thread play_anim_and_loop(var_0, "trapped_agent_start", "trapped_agent_loop");
  var_0 thread maps\_anim::anim_single_solo(var_5, "trapped_prop");
  wait 8;
  var_1[2] maps\_utility::dialogue_queue("hijack_fso3_helpme");
  wait 2;
  var_1[0] maps\_utility::dialogue_queue("hijack_fso1_agentdown");
  wait 8;
  var_1[0] maps\_utility::dialogue_queue("hijack_fso2_medical");
}

play_anim_and_loop(var_0, var_1, var_2) {
  var_0 maps\_anim::anim_single_solo(self, var_1);

  if(isDefined(self)) {
    var_0 maps\_anim::anim_loop_solo(self, var_2);
  }
}

makarov_heli() {
  level endon("kill_heli_1");
  common_scripts\utility::flag_wait("spawn_makarov_heli");
  level.makarov_heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("makarov_heli");
  level.makarov_heli_door = spawn("script_model", level.makarov_heli.origin);
  level.makarov_heli_door setModel("vehicle_mi17_woodland_landing_door");
  level.makarov_heli_door.angles = level.makarov_heli.angles;
  level.makarov_heli_door linkTo(level.makarov_heli);
  var_0 = 1.6;

  if(level.start_point == "post_tarmac" || level.start_point == "end_scene") {
    var_0 = 0.0;
  }
  level.makarov_heli thread setup_spotlight(var_0);
  level.makarov_heli thread manage_spotlight_targets();
  level.makarov_heli maps\_utility::ent_flag_init("makarov_heli_reached_end");
  level.makarov_heli maps\_utility::ent_flag_init("start_commander_anim");
  level.makarov_heli maps\_utility::ent_flag_init("makarov_heli_disable_spotlight");
  level.makarov_heli maps\_utility::ent_flag_init("heli_start_flyaway");
  level.makarov_heli maps\_utility::ent_flag_init("heli_end_flyaway");
  level.makarov_heli maps\_utility::ent_flag_init("heli_start_approach");
  level.makarov_heli maps\_utility::ent_flag_init("heli_end_approach");
  thread maps\hijack_aud::loop_chopper_makarov_flyover();

  if(level.start_point != "post_tarmac" && level.start_point != "end_scene") {
    common_scripts\utility::flag_wait("commander_finished_engine_react_anim");
    wait 0.25;
    level.commander maps\_utility::dialogue_queue("hijack_cmd_evacchoppers");
  }

  if(level.start_point == "end_scene") {
    return;
  }
  common_scripts\utility::flag_wait("move_heli_to_hover_point");
  level.makarov_heli maps\_utility::vehicle_detachfrompath();
  var_1 = common_scripts\utility::getStruct("heli_fly_away", "targetname");
  level.makarov_heli setgoalyaw(var_1.angles[1]);
  level.makarov_heli settargetyaw(var_1.angles[1]);
  level.makarov_heli setvehgoalpos(var_1.origin, 1);
  level.makarov_heli common_scripts\utility::waittill_any("near_goal", "goal");
  level.makarov_heli thread maps\_vehicle::vehicle_paths(var_1);
  level.makarov_heli maps\_utility::ent_flag_wait("heli_end_flyaway");
  level notify("stop_spotlight_fx");
  level.makarov_heli maps\_utility::vehicle_detachfrompath();
  var_2 = common_scripts\utility::getStruct("heli_approach", "targetname");
  level.makarov_heli setgoalyaw(var_2.angles[1]);
  level.makarov_heli settargetyaw(var_2.angles[1]);
  level.makarov_heli setvehgoalpos(var_2.origin, 1);
  level.makarov_heli common_scripts\utility::waittill_any("near_goal", "goal");
  thread makarov_heli_2();
}

makarov_heli_2() {
  common_scripts\utility::flag_wait("heli_start_approach");
  maps\_audio::aud_send_msg("end_heli_approach");
  level notify("kill_heli_1");
  level.makarov_heli.spotlight thread spot_light("heli_spotlight", "tag_flash", level.makarov_heli);
  var_0 = common_scripts\utility::getStruct("heli_approach", "targetname");
  level.makarov_heli thread maps\_vehicle::vehicle_paths(var_0);
  level.makarov_heli maps\_utility::ent_flag_wait("heli_end_approach");
  level.makarov_heli maps\_utility::vehicle_detachfrompath();
  var_1 = common_scripts\utility::getStruct("heli_start_descent", "targetname");
  level.makarov_heli setgoalyaw(var_1.angles[1]);
  level.makarov_heli settargetyaw(var_1.angles[1]);
  level.makarov_heli setvehgoalpos(var_1.origin, 1);
  level.makarov_heli sethoverparams(175, 40, 20);
  level.makarov_heli thread maps\hijack_script_2c::spotlight_monitor_end();
  common_scripts\utility::flag_wait("start_heli_descent");
  level.makarov_heli thread maps\hijack_script_2c::heli_lands();
  var_2 = common_scripts\utility::getStruct("heli_start_descent", "targetname");
  level.makarov_heli thread maps\_vehicle::vehicle_paths(var_2);
}

manage_spotlight_targets() {
  level.makarov_heli thread spotlight_monitor_flyover();
  common_scripts\utility::flag_wait("start_spotlight_random_targeting");
  level.makarov_heli thread spotlight_monitor_random_targets();
}

setup_spotlight(var_0) {
  self.spotlight = spawnturret("misc_turret", self gettagorigin("tag_turret"), "heli_spotlight");
  self.spotlight setmode("manual");
  self.spotlight setModel("com_blackhawk_spotlight_on_mg_setup");
  self.spotlight linkTo(self, "tag_turret");
  self.spotlight makeunusable();

  if(isDefined(var_0)) {
    wait(var_0);
  }
  self.spotlight thread spot_light("heli_spotlight", "tag_flash", self);
}

spot_light(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.effect_id = common_scripts\utility::getfx(var_0);
  var_3.entity = self;
  self.spot_light = var_3;
  var_3.tag_name = var_1;
  playFXOnTag(var_3.effect_id, var_3.entity, var_3.tag_name);
  thread spot_light_death(var_2);
  level waittill("stop_spotlight_fx");

  if(isDefined(var_3.entity)) {
    stopFXOnTag(var_3.effect_id, var_3.entity, var_3.tag_name);
    wait 0.05;
    var_3.effect_id_off = common_scripts\utility::getfx(var_0 + "_off");
    playFXOnTag(var_3.effect_id_off, var_3.entity, var_3.tag_name);
  }
}

spot_light_death(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    var_0 waittill("death");
  }
  self delete();
}

update_spotlight_targets() {
  for(;;) {
    var_0 = anglesToForward(self.angles * (0, 1, 0) + (40, -25, 0));
    self.spotlight_target_right.origin = self gettagorigin("tag_turret") + var_0 * 100;
    var_1 = anglesToForward(self.angles * (0, 1, 0) + (40, 25, 0));
    self.spotlight_target_left.origin = self gettagorigin("tag_turret") + var_1 * 100;
    wait 0.05;
  }
}

spotlight_monitor_flyover() {
  self endon("death");
  self endon("start_random_spotlight_targets");
  self endon("shine_spotlight_on_president");
  var_0 = getEnt("tail_spotlight_target_1", "targetname");
  self.spotlight settargetentity(var_0);
  wait 4;
  var_1 = getEnt("tail_spotlight_target_2", "targetname");
  var_2 = spawn("script_origin", var_1.origin);
  self.spotlight settargetentity(var_2);
  var_2 thread maps\hijack_script_2c::move_around_target(var_1);
  wait 4;
  var_3 = getEnt("ring_spotlight_target", "targetname");
  self.spotlight settargetentity(var_3);
  common_scripts\utility::flag_wait("commander_ready_for_heli");
  self.spotlight settargetentity(level.commander);
  wait 4;
  common_scripts\utility::flag_set("start_spotlight_random_targeting");
}

spotlight_monitor_random_targets() {
  self endon("death");
  self endon("shine_spotlight_on_president");
  self notify("start_random_spotlight_targets");
  self.spotlight_target_right = spawn("script_origin", self.origin);
  self.spotlight_target_left = spawn("script_origin", self.origin);
  childthread update_spotlight_targets();

  for(;;) {
    self.spotlight settargetentity(self.spotlight_target_right);
    wait 2;
    self.spotlight settargetentity(self.spotlight_target_left);
    wait 2;
  }
}

setup_vehicle_light_types() {}

turn_on_headlights() {
  maps\_vehicle::vehicle_lights_on();
  self waittill("death");
  maps\_vehicle::vehicle_lights_off("all");
}