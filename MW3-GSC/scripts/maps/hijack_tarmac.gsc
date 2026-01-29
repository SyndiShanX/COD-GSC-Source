/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_tarmac.gsc
******************************************/

_id_59D6() {
  level._id_58D2 = maps\hijack_code::_id_594A("commander_tarmac");
  waittillframeend;
  var_0 = getnode("commander_pre_ramp_node", "targetname");
  level._id_58D2 maps\_utility::_id_27A1(var_0);
  var_1 = common_scripts\utility::getstruct("player_start_tarmac", "targetname");
  level.player setorigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
  maps\hijack_crash::_id_59D7();
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread _id_5A04();
  maps\_audio::aud_send_msg("start_tarmac");
  common_scripts\utility::flag_set("stop_managing_crash_player");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("commander_finished_wake_up_anim");
  thread _id_599A();
  var_2 = common_scripts\utility::getstruct("agent_helps_player_origin", "targetname");
  thread maps\hijack_crash::_id_59D8();
}

_id_59D9(var_0, var_1) {
  self endon("death");

  for(;;) {
    var_2 = distance(self.origin, level._id_58D2.origin);

    if(var_2 < var_0) {
      break;
    }

    wait 0.1;
  }

  level._id_58D2 setlookatentity(self);
  level notify("commander_looks_at_something");
  level endon("commander_looks_at_something");
  wait(var_1);
  level._id_58D2 setlookatentity();
}

_id_59DA() {
  level._id_58D2 = maps\hijack_code::_id_594A("commander_tarmac");
  waittillframeend;
  var_0 = common_scripts\utility::getstruct("player_start_tarmac_2", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread _id_5A04();
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
  thread _id_599A();
  common_scripts\utility::flag_set("commander_finished_wake_up_anim");
  level._id_59DB = 0.6;
  waittillframeend;
  level notify("start_commander_wake_up_anim");
}

_id_59DC() {
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

_id_59DD() {
  precachemodel("vehicle_mi17_woodland_landing_door");
  precachemodel("vehicle_mi17_woodland_landing_door_obj");
  precachemodel("com_blackhawk_spotlight_on_mg_setup");
  precacheturret("heli_spotlight");
  precachemodel("hjk_plane_debris_02");
  precachemodel("hjk_seat_cover_sml");
}

_id_59DE() {
  common_scripts\utility::flag_wait("player_on_feet_post_crash");
  objective_add(maps\_utility::_id_2816("follow_commander"), "current", &"HIJACK_OBJ_COMMANDER", level._id_58D2.origin);
  objective_onentity(maps\_utility::_id_2816("follow_commander"), level._id_58D2, (0, 0, 70));
  common_scripts\utility::flag_wait("player_entered_end_area");
  maps\_utility::_id_2727(maps\_utility::_id_2816("follow_commander"));
  var_0 = common_scripts\utility::getstruct("find_pres_obj", "targetname");
  objective_add(maps\_utility::_id_2816("find_president"), "current", &"HIJACK_OBJ_PRESIDENT_END", var_0.origin);
  common_scripts\utility::flag_wait_or_timeout("player_near_pres", 15);
  objective_position(maps\_utility::_id_2816("find_president"), (0, 0, 0));
  common_scripts\utility::flag_wait_all("guys_ready_for_door", "heli_landed");
  objective_position(maps\_utility::_id_2816("find_president"), level._id_5943 gettagorigin("tag_handle_objective") + (0, 0, -1));
  level waittill("door_used");
  objective_state(maps\_utility::_id_2816("find_president"), "failed");
}

_id_59DF() {
  var_0 = common_scripts\utility::getstruct("post_crash_scene_origin", "targetname");
  var_1 = maps\_utility::_id_272F("postcrash_agent1", 1);
  var_1._id_1032 = "plane_exit_agent1";
  var_1 maps\_utility::_id_24F5();
  var_2 = maps\_utility::_id_272F("postcrash_agent2", 1);
  var_2._id_1032 = "plane_exit_agent2";
  level._id_59E0 = maps\_utility::_id_272F("daughter_tarmac");
  level._id_59E0 maps\hijack::_id_59E1();
  var_3 = maps\_utility::_id_1287("daughter_blanket");
  var_3 startusingheroonlylighting();
  var_0 thread maps\_anim::_id_11CF(var_1, "secure_daughter");
  var_0 thread maps\_anim::_id_11CF(var_2, "secure_daughter");
  var_0 thread maps\_anim::_id_11CF(level._id_59E0, "secure_daughter");
  var_0 thread maps\_anim::_id_11CF(var_3, "secure_daughter");

  if(level._id_1F19 != "tarmac") {
    level waittill("start_commander_wake_up_anim");

  }
  var_4 = getent("crashed_plane_engine", "targetname");
  var_4._id_1032 = "engine";
  var_4 maps\_anim::_id_1244();
  var_4 thread maps\_anim::_id_1246(var_4, "engine_spin_slow");
  common_scripts\utility::flag_wait("commander_finished_wake_up_anim");

  if(level._id_1F19 != "tarmac_2") {
    var_0 thread maps\_anim::_id_124E(level._id_58D2, "exit_top_idle", "stop_top_loop");

  }
  common_scripts\utility::flag_wait_any("player_exit_plane_1", "start_commander_ramp_anim");
  common_scripts\utility::flag_set("commander_started_ramp_anim");
  var_0 notify("stop_top_loop");

  if(level._id_1F19 != "tarmac_2") {
    level._id_58D2._id_240A = "metal";
    var_0 maps\_anim::_id_1246(level._id_58D2, "exit_down_ramp");
    var_0 thread maps\_anim::_id_124E(level._id_58D2, "exit_bottom_idle", "stop_bottom_loop");
  }

  common_scripts\utility::flag_wait("player_exit_plane_3");
  var_0 notify("stop_bottom_loop");
  var_5 = getent("engine_outside", "targetname");
  var_5._id_1032 = "engine";
  var_5 maps\_anim::_id_1244();
  var_5 thread maps\_anim::_id_1246(var_5, "engine_spin_slow");
  var_1._id_240A = "snow";
  var_2._id_240A = "snow";
  level._id_59E0._id_240A = "snow";
  var_1 thread _id_5A0B(var_0, "secure_daughter", "secure_daughter_loop");
  var_2 thread _id_5A0B(var_0, "secure_daughter", "secure_daughter_loop");
  level._id_59E0 thread _id_5A0B(var_0, "secure_daughter", "secure_daughter_loop");
  var_3 thread _id_5A0B(var_0, "secure_daughter", "secure_daughter_loop");

  if(level._id_1F19 != "tarmac_2") {
    thread _id_59E2(var_1, var_2);
    level._id_58D2._id_240A = "snow";
    var_0 maps\_anim::_id_1246(level._id_58D2, "secure_daughter");
    thread _id_59ED();
  }

  level._id_58D2 maps\_utility::_id_109E();
  level._id_58D2.ignoreall = 0;
  level._id_58D2._id_59C3 = 0;
  level._id_58D2 thread _id_59E9();
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_1 delete();
  var_2 delete();
  level._id_59E0 maps\_utility::_id_1902();
  level._id_59E0 delete();
  common_scripts\utility::flag_set("commander_ready_for_heli");
}

_id_59E2(var_0, var_1) {
  wait 0.5;
  var_0 maps\_utility::_id_168C("hijack_fso1_howdidthey");
  wait 0.5;
  var_1 maps\_utility::_id_168C("hijack_fso2_theyknew2");
}

_id_59E3() {
  level endon("entered_post_tarmac_area");
  level endon("stop_monitoring_commander_speed");
  wait 0.2;

  for(;;) {
    var_0 = _id_59E5();

    if(var_0 > 120) {
      if(level._id_58D2 _id_59E6()) {
        if(var_0 > 240) {
          level._id_58D2._id_0FC6 = level._id_59E4 + 0.27;
        } else {
          level._id_58D2._id_0FC6 = level._id_59E4 + 0.16;
        }
      }
    } else {
      level._id_58D2._id_0FC6 = level._id_59E4;
      _id_59C4(level._id_59DB);
    }

    wait 1.0;
  }
}

_id_59E5() {
  var_0 = level.player.origin - level._id_58D2.origin;
  return length(var_0);
}

_id_59E6() {
  var_0 = level.player.origin - self.origin;
  var_0 = vectornormalize(var_0);
  var_1 = vectornormalize(self.goalpos - self.origin);
  var_2 = vectordot(var_1, var_0);

  if(var_2 < -0.2) {
    return 0;

  }
  return 1;
}

_id_59E7() {
  for(;;) {
    if(_id_59E8() == 0) {
      var_0 = 1;
      var_1 = 5 + randomint(2);

      for(var_2 = 0; var_2 < var_1 && var_0; var_2++) {
        wait 2;
        var_0 = _id_59E8() == 0;
      }

      if(var_0) {
        var_3 = randomint(3);

        if(var_3 == 0) {
          level._id_58D2 maps\_utility::_id_168C("hijack_cmd_keepmoving2");
        } else if(var_3 == 1) {
          level._id_58D2 maps\_utility::_id_168C("hijack_cmd_comeon");
        } else if(var_3 == 2) {
          level._id_58D2 maps\_utility::_id_168C("hijack_cmd_letsgo");
        }
      }
    }

    wait 0.1;
  }
}

_id_59E8() {
  var_0 = level._id_58D2.origin;
  wait 0.05;
  var_1 = level._id_58D2.origin;
  var_2 = distance(var_0, var_1);
  return var_2;
}

_id_59E9() {
  level endon("entered_post_tarmac_area");
  level._id_59E4 = 1.1;
  level._id_58D2._id_0FC6 = level._id_59E4;
  level._id_58D2 maps\_utility::_id_26F7("injured_run");
  thread _id_59E3();
  childthread _id_59E7();
  var_0 = getnode("commander_tarmac_node_1", "targetname");
  thread _id_59EA(var_0);
  common_scripts\utility::flag_wait("move_commander_to_flare_node");
  self notify("stop_relaxed_idle");
  maps\_utility::_id_1414();
  _id_59EB();
  var_1 = getnode("commander_tarmac_node_3", "targetname");
  thread _id_59EA(var_1);
  common_scripts\utility::flag_wait_all("commander_finished_engine_react_anim");
  var_2 = common_scripts\utility::getstruct("post_crash_scene_origin", "targetname");
  self notify("stop_relaxed_idle");
  maps\_utility::_id_1414();
  var_2 maps\_anim::_id_124A(level._id_58D2, "heli_wave");
  level._id_58D2 thread maps\_anim::_id_124E(level._id_58D2, "heli_wait");
  common_scripts\utility::flag_set("commander_ready_for_heli");
  level._id_5943 maps\_utility::_id_1654("start_commander_anim");
  level._id_58D2 notify("stop_loop");
  var_2 maps\_anim::_id_1246(level._id_58D2, "heli_wave");
  var_3 = getnode("commander_tarmac_node_4", "targetname");
  thread _id_59EA(var_3);
  self notify("stop_relaxed_idle");
  var_4 = getnode("commander_tarmac_node_5", "targetname");
  self setgoalnode(var_4);
  level waittill("commander_react_to_combat");
  level notify("stop_monitoring_commander_speed");
  animscripts\animset::_id_0C87();
  maps\_utility::_id_140C();
  maps\_utility::_id_26FC();
  self._id_0FC6 = 1.0;
}

_id_59EA(var_0) {
  self notify("stop_relaxed_idle");
  maps\_utility::_id_1414();
  self setgoalnode(var_0);
  self._id_117F = 1;
  self.goalradius = 16;
  self endon("stop_relaxed_idle");
  maps\_utility::_id_26FC();
  self waittill("goal");
  waittillframeend;
  maps\_anim::_id_124E(self, "relaxed_idle", "stop_relaxed_idle");
}

_id_59EB() {
  thread _id_59EC();
  var_0 = common_scripts\utility::getstruct("post_crash_scene_origin", "targetname");
  var_0 maps\_anim::_id_124A(level._id_58D2, "flare_reaction");
  level._id_58D2 thread maps\_anim::_id_124E(level._id_58D2, "relaxed_idle");
  common_scripts\utility::flag_wait("start_flare_event");

  if(!common_scripts\utility::flag("commander_finished_engine_react_anim")) {
    maps\_audio::aud_send_msg("flare_gun");
    level._id_58D2 notify("stop_loop");
    level._id_58D2._id_240A = "snow";
    common_scripts\utility::flag_set("commander_started_flare_anim");
    var_0 thread maps\_anim::_id_1246(level._id_58D2, "flare_reaction");
    thread maps\_flare::_id_409C("tarmac_flare");
    level._id_58D2 waittillmatch("single anim", "end");
    common_scripts\utility::flag_set("commander_finished_flare_anim");
  }
}

_id_59EC() {
  var_0 = getent("commander_flare_vo_trigger", "targetname");
  var_0 waittill("trigger");

  if(!common_scripts\utility::flag("start_engine_explosion")) {
    level.player maps\_utility::_id_11F4("hijack_fso4_sendingflare");
  }
}

_id_59ED() {
  wait 1.8;
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_evacontheway");
  wait 1;
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_team4report");
  wait 0.2;
  level.player maps\_utility::_id_11F4("hijack_fso4_wounded");
  wait 0.2;

  if(!common_scripts\utility::flag("start_flare_event")) {
    level._id_58D2 maps\_utility::_id_168C("hijack_cmd_securearea");
  }
}

_id_59EE() {
  level endon("stop_drunk_walk");
  common_scripts\utility::flag_wait("start_engine_explosion");
  wait 6;
  level._id_59EF = spawn("script_origin", level.player.origin);
  level._id_59EF linkto(level.player);
  level._id_59EF._id_1046 = 1;
  var_0 = randomfloatrange(0, 5);
  maps\hijack_code::_id_5956("hijack_fso1_confirmation", level._id_59EF);
  maps\hijack_code::_id_5956("hijack_rt1_onsceneinten", level._id_59EF);
  wait(var_0);
  maps\hijack_code::_id_5956("hijack_fso2_cordonoff", level._id_59EF);
  wait(var_0);
  maps\hijack_code::_id_5956("hijack_fso3_leakingfuel", level._id_59EF);
  wait(var_0);
  maps\hijack_code::_id_5956("hijack_rt1_blackbox", level._id_59EF);
  wait 0.4;
  maps\hijack_code::_id_5956("hijack_fso3_blackbox", level._id_59EF);
  wait(var_0);
  maps\hijack_code::_id_5956("hijack_fso2_medical", level._id_59EF);
  wait(var_0);
  maps\hijack_code::_id_5956("hijack_fso1_satcom", level._id_59EF);
  wait(var_0);
  maps\hijack_code::_id_5956("hijack_fso3_cockpit", level._id_59EF);
  wait(var_0);
  maps\hijack_code::_id_5956("hijack_fso2_tailsection", level._id_59EF);
}

_id_59F0() {
  if(level._id_1F19 == "tarmac") {
    common_scripts\utility::flag_wait("player_exit_plane_2");

  }
  if(level._id_1F19 == "tarmac_2") {
    common_scripts\utility::flag_wait("start_engine_explosion");

  }
  thread maps\hijack_drunk_player::_id_5988();
}

_id_59F1() {
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

_id_59C4(var_0) {
  level.player setmovespeedscale(var_0);
  setsaveddvar("jump_height", level._id_59C2 * var_0);
}

_id_59F2() {
  common_scripts\utility::flag_wait("stop_managing_crash_player");
  level._id_59C2 = getdvarfloat("jump_height");

  if(level._id_1F19 != "tarmac_2") {
    thread _id_59F7();

  }
  thread _id_59FA();
  thread _id_59EE();

  if(level._id_1F19 != "tarmac" && level._id_1F19 != "tarmac_2") {
    wait 3.5;

  }
  thread maps\hijack_drunk_player::main();
  thread _id_59F0();
  thread _id_5A00();
  _id_59C4(0.2);

  if(!common_scripts\utility::flag("player_exit_plane_4")) {
    thread _id_59F1();

  }
  thread maps\hijack_drunk_player::_id_5985();
  common_scripts\utility::flag_set("start_doing_aftermath_walk");
  common_scripts\utility::flag_wait("player_on_feet_post_crash");
  setsaveddvar("player_sprintSpeedScale", 1.1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  wait 0.1;
  common_scripts\utility::flag_wait("player_exit_plane_1");

  if(level._id_1F19 != "tarmac_2") {
    wait 3;

  }
  _id_59C4(0.24);
  common_scripts\utility::flag_wait("player_exit_plane_3");
  _id_59C4(0.35);
  level._id_598D = 2.5;
  thread _id_59F3();

  if(isDefined(level._id_59EF)) {
    level._id_59EF._id_1B71 = 1;

  }
  common_scripts\utility::flag_wait("player_exit_plane_4");
  thread _id_59F4();
  level._id_598D = 1.0;
  setsaveddvar("player_sprintSpeedScale", 1.3);
  level.player allowjump(1);

  if(level._id_1F19 != "tarmac_2") {
    level._id_1C4C = 0;
    thread maps\_utility::_id_1425("exit_airplane");
    wait 2;
    level._id_1C4C = 1;
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

_id_59F3() {
  wait 11;
  level.player enableweapons();
}

_id_59F4() {
  if(level._id_1F19 == "tarmac_2") {
    level._id_59DB = 0.8;
    _id_59C4(level._id_59DB);
  } else {
    level._id_59DB = 0.35;

    while(level._id_59DB < 0.8) {
      level._id_59DB = level._id_59DB + 0.05;
      _id_59C4(level._id_59DB);
      wait 0.5;
    }
  }
}

_id_59F5() {
  level notify("not_random_blur");
}

_id_59F6() {
  thread maps\hijack_drunk_player::_id_51E6();
}

_id_59F7() {
  thread _id_59F8();
  common_scripts\utility::flag_wait("commander_started_ramp_anim");
  _id_59F5();
  maps\_audio::aud_send_msg("tarmac_shift");
  earthquake(0.3, 5.5, level.player.origin, 80000);
  level.player playrumbleonentity("hijack_plane_medium");
  wait 3.5;
  _id_59F6();
}

_id_59F8() {
  var_0 = common_scripts\utility::getstruct("post_crash_scene_origin", "targetname");
  var_1 = getent("cab2_med_door1", "targetname");
  var_2 = getent("cab2_med_door2", "targetname");
  var_3 = getent("cab2_lg_door1", "targetname");
  var_4 = getent("cab2_lg_door2", "targetname");
  var_5 = getent("cab1_sm_door1", "targetname");
  var_6 = getent("cab1_sm_door2", "targetname");
  var_7 = getent("cab1_sm_door3", "targetname");
  var_8 = getent("cab1_sm_door4", "targetname");
  var_9 = getent("cab1_med_door1", "targetname");
  var_10 = getent("cab1_med_door2", "targetname");
  var_11 = getent("cab1_med_door3", "targetname");
  var_12 = getent("cab1_med_door4", "targetname");
  var_13 = getent("cab1_med_door5", "targetname");
  var_14 = getent("cab1_med_door6", "targetname");
  var_15 = getent("cab1_med_door7", "targetname");
  var_16 = getent("cab1_med_door8", "targetname");
  var_17 = getent("cab1_lg_door1", "targetname");
  var_18 = getent("cab1_drawer1", "targetname");
  var_19 = getent("cab1_drawer2", "targetname");
  var_20 = getent("cab3_med_door1", "targetname");
  var_21 = getent("cab3_med_door2", "targetname");
  var_22 = getent("cab3_med_door3", "targetname");
  var_23 = getent("cab3_med_door4", "targetname");
  var_24 = getent("post_crash_airplane_ladder", "targetname");
  var_25 = getent("post_crash_airplane_floor_chunk", "targetname");
  var_26 = getent("post_crash_airplane_tire", "targetname");
  var_27 = getent("post_crash_airplane_crate", "targetname");
  var_28 = getent("post_crash_airplane_crate_2", "targetname");
  var_29 = getent("post_crash_pipe_small", "targetname");
  var_30 = getent("post_crash_pipe_large", "targetname");
  var_1 thread _id_59F9(var_0, "post_crash_locker1");
  var_2 thread _id_59F9(var_0, "post_crash_locker2");
  var_3 thread _id_59F9(var_0, "post_crash_locker3");
  var_4 thread _id_59F9(var_0, "post_crash_locker4");
  var_5 thread _id_59F9(var_0, "post_crash_locker6");
  var_6 thread _id_59F9(var_0, "post_crash_locker7");
  var_7 thread _id_59F9(var_0, "post_crash_locker8");
  var_8 thread _id_59F9(var_0, "post_crash_locker9");
  var_9 thread _id_59F9(var_0, "post_crash_locker5");
  var_10 thread _id_59F9(var_0, "post_crash_locker11");
  var_11 thread _id_59F9(var_0, "post_crash_locker14");
  var_12 thread _id_59F9(var_0, "post_crash_locker16");
  var_13 thread _id_59F9(var_0, "post_crash_locker12");
  var_14 thread _id_59F9(var_0, "post_crash_locker15");
  var_15 thread _id_59F9(var_0, "post_crash_locker17");
  var_16 thread _id_59F9(var_0, "post_crash_locker10");
  var_17 thread _id_59F9(var_0, "post_crash_locker13");
  var_20 thread _id_59F9(var_0, "post_crash_locker18");
  var_21 thread _id_59F9(var_0, "post_crash_locker20");
  var_22 thread _id_59F9(var_0, "post_crash_locker19");
  var_23 thread _id_59F9(var_0, "post_crash_locker21");
  var_18 thread _id_59F9(var_0, "post_crash_drawer1");
  var_19 thread _id_59F9(var_0, "post_crash_drawer2");
  var_24 thread _id_59F9(var_0, "post_crash_ladder");
  var_25 thread _id_59F9(var_0, "post_crash_ladder", "J_prop_2");
  var_26 thread _id_59F9(var_0, "post_crash_tire");
  var_27 thread _id_59F9(var_0, "post_crash_crate");
  var_28 thread _id_59F9(var_0, "post_crash_crate", "J_prop_2");
  var_29 thread _id_59F9(var_0, "post_crash_pipe_small");
  var_30 thread _id_59F9(var_0, "post_crash_pipe_large");
}

_id_59F9(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "J_prop_1";

  }
  var_3 = maps\_utility::_id_1287("post_crash_prop");
  waittillframeend;
  var_0 thread maps\_anim::_id_11CF(var_3, var_1);
  self linkto(var_3, var_2);
  common_scripts\utility::flag_wait("commander_started_ramp_anim");
  var_0 maps\_anim::_id_1246(var_3, var_1);
  waittillframeend;
  var_3 delete();
}

_id_59FA() {
  thread _id_59FB();
  thread _id_592D();
  thread _id_59FE();
}

_id_59FB() {
  common_scripts\utility::flag_wait("distant_explosion");
  maps\_audio::aud_send_msg("wreck_exit_expl");
  common_scripts\utility::exploder("distant_exp");
}

_id_592D() {
  var_0 = getent("crashed_plane_engine", "targetname");
  var_1 = getent("crashed_plane_engine_destroyed", "targetname");
  var_1 hide();
  common_scripts\utility::flag_wait("start_engine_explosion");
  wait 1;
  maps\_audio::aud_send_msg("engine_explosion");
  _id_59F5();
  common_scripts\utility::exploder("engine_exp");
  common_scripts\utility::exploder("engine_exp_fire");
  wait 0.1;
  thread _id_59FD(var_0);
  var_0 hide();
  var_1 show();
  thread _id_59FC();
  wait 2.0;
  _id_59F6();
  common_scripts\utility::flag_set("spawn_makarov_heli");
}

_id_59FC() {
  if(!common_scripts\utility::flag("commander_started_flare_anim") || common_scripts\utility::flag("commander_finished_flare_anim")) {
    level._id_58D2 notify("stop_loop");
    level._id_58D2 maps\_anim::_id_1246(level._id_58D2, "engine_stumble");
  } else {
    common_scripts\utility::flag_wait("commander_finished_flare_anim");

  }
  common_scripts\utility::flag_set("commander_finished_engine_react_anim");
}

_id_59FD(var_0) {
  level.player maps\_utility::dirteffect(var_0.origin);
  level.player shellshock("hijack_engine_explosion", 1);
  level.player dodamage(level.player.health - 1, var_0.origin);
  earthquake(0.5, 1.5, var_0.origin, 10000);
  level.player playrumbleonentity("hijack_plane_large");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = var_0.origin - level.player.origin;
  var_4 = vectortoangles(var_3);
  var_2.angles = var_4;
  var_1.angles = level._id_5258.angles;
  var_1 linkto(var_2);
  level._id_27A4 = 1;
  var_5 = -1.0 * anglesToForward(var_2.angles);
  level.player setvelocity(var_5 * 400);
  level._id_595D = 1;
  level.player maps\hijack_code::_id_595C();
  level.player playersetgroundreferenceent(var_1);
  var_2 rotatepitch(-25, 0.2, 0, 0.15);
  wait 0.1;
  level.player maps\hijack_code::_id_595E();
  level._id_595D = undefined;
  wait 0.6;
  var_2 rotatepitch(25, 0.8, 0.4, 0.1);
  wait 0.8;
  var_1 rotateto(level._id_5258.angles, 0.5, 0.4, 0.1);
  wait 0.5;
  level._id_5258.angles = var_1.angles;
  level.player playersetgroundreferenceent(level._id_5258);
}

_id_59FE() {
  level endon("entered_post_tarmac_area");
  common_scripts\utility::flag_wait("player_exit_plane_4");

  for(;;) {
    common_scripts\utility::exploder("random_tail_exp");
    maps\_audio::aud_send_msg("random_tail_expl");
    earthquake(0.05, 2.0, (8820.26, 7283.35, 239.12), 80000);
    wait(randomfloatrange(8, 15));
  }
}

_id_59FF() {
  common_scripts\utility::flag_wait("tail_explosion");
  maps\_audio::aud_send_msg("tail_explosion");
  level notify("big_tail_exp");
  _id_59F5();
  common_scripts\utility::exploder("final_tail_exp");
  earthquake(0.5, 2.0, (8815.42, 7106.38, 273.014), 80000);
  level.player shellshock("hijack_tail_explosion", 1);
  level.player playrumbleonentity("hijack_plane_medium");
  common_scripts\utility::exploder("tail_exp_fire_1");
  common_scripts\utility::exploder("tail_exp_fire_2");
  common_scripts\utility::exploder("tail_exp_fire_3");
  common_scripts\utility::exploder("tail_exp_fire_4");
  _id_59F6();
}

_id_5A00() {
  while(!common_scripts\utility::flag("entered_post_tarmac_area")) {
    level.player maps\_utility::play_sound_on_entity("breathing_hurt_start");
    wait(randomfloatrange(2, 5));
  }

  level.player maps\_utility::play_sound_on_entity("breathing_better");
}

_id_5999() {
  wait 1;
  level._id_5A01 = maps\_utility::_id_272C("dead_secret_service");
  level._id_5A02 = maps\_utility::_id_272C("dead_secret_service_no_weapon");

  foreach(var_1 in level._id_5A02) {}
  var_1 maps\_utility::_id_24F5();

  level._id_5A01 = common_scripts\utility::array_combine(level._id_5A01, level._id_5A02);

  foreach(var_1 in level._id_5A01) {
    var_1._id_0D16 = 1;
    var_1.diequietly = 1;
    var_1.delete_on_death = 0;
    var_1 kill();
  }
}

_id_599A() {
  common_scripts\utility::flag_set("pause_inflight_fx");
  common_scripts\utility::flag_clear("pause_tarmac_fx");
  thread maps\_blizzard_hijack::_id_567C(3);
  thread maps\_blizzard_hijack::_id_5692();
  maps\_utility::_id_265A("axis");
  common_scripts\utility::flag_init("stop_aftermath_player");
  thread _id_5A03();
  thread _id_59DF();
  thread _id_59DE();
  thread _id_59F2();
  thread _id_5943();
  thread maps\hijack_script_2b::main();
}

_id_5A03() {
  common_scripts\utility::flag_wait("tarmac_level_fail");
  setdvar("ui_deadquote", &"HIJACK_FAIL_TARMAC");
  level notify("mission failed");
  maps\_utility::_id_1826();
}

_id_5A04() {
  _id_5999();
  wait 1;
  var_0 = common_scripts\utility::getstruct("post_crash_scene_origin", "targetname");
  thread _id_5A05(var_0);
  thread _id_5A06(var_0);
  thread _id_5A07(var_0);
  wait 1;
  thread _id_5A08();
  thread _id_5A09(var_0);
  thread _id_5A0A(var_0);
  wait 1;
  var_1 = getaiarray();

  foreach(var_3 in var_1) {
    if(!isenemyteam(var_3.team, level.player.team)) {
      var_3 thread maps\hijack_code::_id_5951();
    }
  }
}

_id_5A05(var_0) {
  var_1[0] = maps\_utility::_id_272F("FSO_idlers_0");
  var_1[1] = maps\_utility::_id_272F("FSO_idlers_1");
  var_1[2] = maps\_utility::_id_272F("FSO_idlers_2");
  var_1[2] maps\_utility::_id_2611();
  var_1[0] thread maps\hijack_code::_id_5951();
  var_1[1] thread maps\hijack_code::_id_5951();
  var_1[2] thread maps\hijack_code::_id_5951();

  foreach(var_3 in var_1) {
    var_3._id_1032 = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::_id_24F5();
    }
  }

  var_0 thread maps\_anim::_id_124E(var_1[0], "injured_hands_on_knees");
  var_0 thread maps\_anim::_id_124E(var_1[1], "injured_on_back");
  var_0 thread maps\_anim::_id_124E(var_1[2], "injured_leg_loop");
  common_scripts\utility::flag_wait("fso_arm_vo");
  wait 0.5;
  var_1[1] maps\_utility::_id_168C("hijack_fso1_myarm");
  common_scripts\utility::flag_wait("entered_post_tarmac_area");

  if(isDefined(var_1[0])) {
    var_1[0] delete();

  }
  if(isDefined(var_1[2])) {
    var_1[2] delete();
  }
}

_id_5A06(var_0) {
  var_1 = [];
  var_1[0] = maps\_utility::_id_272F("FSO_check_deadguy_agent");
  var_1[1] = maps\_utility::_id_272F("FSO_check_deadguy_hijacker");
  var_1[1].ignoreall = 1;
  var_1[1].ignoreme = 1;
  var_1[1] maps\_utility::_id_24F5();
  var_1[0] thread maps\hijack_code::_id_5951();
  var_1[0] thread _id_59D9(400, 3.0);
  var_1[0]._id_1032 = "checkguy";
  var_1[1]._id_1032 = "deadguy";
  var_0 thread maps\_anim::_id_11BF(var_1, "checkdeadguy_start");
  common_scripts\utility::flag_wait("start_checkdeadguy_anim");
  var_0 maps\_anim::_id_11DD(var_1, "checkdeadguy_start");
  var_0 thread maps\_anim::_id_11D6(var_1, "checkdeadguy_loop");
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_1[0] delete();
  var_1[1] delete();
}

_id_5A07(var_0) {
  var_1 = maps\_utility::_id_272F("FSO_scout");
  var_2 = maps\_utility::_id_272F("buried_hijacker");
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_2.ignoreall = 1;
  var_2.ignoreme = 1;
  var_2 maps\_utility::_id_24F5();
  var_2 thread maps\hijack_code::_id_5951();
  var_1 thread maps\hijack_code::_id_5951();
  var_1._id_1032 = "generic";
  var_2._id_1032 = "generic";
  var_2 thread _id_59D9(400, 3.0);
  var_0 thread maps\_anim::_id_11CF(var_1, "scout_finds_buried_hijacker");
  var_0 thread maps\_anim::_id_11CF(var_2, "buried_hijacker");
  var_3 = maps\_utility::_id_1287("plane_seats");
  waittillframeend;
  var_0 thread maps\_anim::_id_11CF(var_3, "buried_prop");
  var_3 attach("hjk_seat_cover_sml", "J_prop_1");
  common_scripts\utility::flag_wait("move_commander_to_flare_node");
  wait 2;
  var_1._id_240A = "snow";
  var_0 thread maps\_anim::_id_1246(var_1, "scout_finds_buried_hijacker");
  var_0 thread maps\_anim::_id_1246(var_2, "buried_hijacker");
  var_0 thread maps\_anim::_id_1246(var_3, "buried_prop");
  var_2 waittillmatch("single anim", "die");
  thread maps\_anim::_id_127B(var_2, "buried_hijacker", 0.0);
  thread maps\_anim::_id_127B(var_3, "buried_prop", 0.0);
  var_2 notify("stop personal effect");
  var_2.team = "neutral";
  var_1 setgoalpos(var_1.origin);
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  var_2 delete();
  var_1 delete();
}

_id_5A08() {
  var_0[0] = maps\_utility::_id_272F("FSO_engine_react_0");
  var_0[1] = maps\_utility::_id_272F("FSO_engine_react_1");
  var_0[2] = maps\_utility::_id_272F("FSO_engine_react_2");
  var_0[0] thread maps\hijack_code::_id_5951();
  var_0[1] thread maps\hijack_code::_id_5951();
  var_0[2] thread maps\hijack_code::_id_5951();
  var_1 = common_scripts\utility::getstruct("temp_exp_anim_origin", "targetname");

  foreach(var_3 in var_0) {
    var_3._id_1032 = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::_id_24F5();
    }
  }

  var_0[2] delete();
  var_1 thread maps\_anim::_id_11CF(var_0[0], "drag_from_engine_agent1");
  var_1 thread maps\_anim::_id_11CF(var_0[1], "drag_from_engine_agent2");
  common_scripts\utility::flag_wait("start_exp_anims");
  var_1 thread maps\_anim::_id_1246(var_0[0], "drag_from_engine_agent1");
  var_1 thread maps\_anim::_id_1246(var_0[1], "drag_from_engine_agent2");
  var_0[0] waittillmatch("single anim", "end");
  var_1 thread maps\_anim::_id_124E(var_0[0], "drag_from_engine_agent1_loop");
  var_1 thread maps\_anim::_id_124E(var_0[1], "drag_from_engine_agent2_loop");
}

_id_5A09(var_0) {
  var_1[0] = maps\_utility::_id_272F("FSO_tail_react_0");
  var_1[1] = maps\_utility::_id_272F("FSO_tail_react_1");
  var_1[0] maps\_utility::_id_2611();
  var_1[0] thread maps\hijack_code::_id_5951();
  var_1[1] thread maps\hijack_code::_id_5951();

  foreach(var_3 in var_1) {
    var_3._id_1032 = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::_id_24F5();
    }
  }

  var_0 thread maps\_anim::_id_124E(var_1[0], "reach_to_explosion_agent1_loop_start", "stop_tail_exp_loop");
  var_0 thread maps\_anim::_id_124E(var_1[1], "reach_to_explosion_agent2_loop_start", "stop_tail_exp_loop");
  common_scripts\utility::flag_wait("start_tail_exp_anims");
  var_0 notify("stop_tail_exp_loop");
  var_0 thread maps\_anim::_id_1246(var_1[0], "reach_to_explosion_agent1");
  var_0 thread maps\_anim::_id_1246(var_1[1], "reach_to_explosion_agent2");
  var_1[0] waittillmatch("single anim", "explosion_reaction_2");
  common_scripts\utility::flag_set("tail_explosion");
  wait 2;
  var_1[0] maps\_utility::_id_168C("hijack_fso1_injuredman");
  var_1[0] waittillmatch("single anim", "end");
  var_0 thread maps\_anim::_id_124E(var_1[0], "reach_to_explosion_agent1_loop_end");
  var_0 thread maps\_anim::_id_124E(var_1[1], "reach_to_explosion_agent2_loop_end");
}

_id_5A0A(var_0) {
  var_1[0] = maps\_utility::_id_272F("FSO_trapped_agent_0");
  var_1[1] = maps\_utility::_id_272F("FSO_trapped_agent_1");
  var_1[2] = maps\_utility::_id_272F("FSO_trapped_agent_2");
  var_1[0] thread maps\hijack_code::_id_5951();
  var_1[1] thread maps\hijack_code::_id_5951();
  var_1[2] thread maps\hijack_code::_id_5951();

  foreach(var_3 in var_1) {
    var_3._id_1032 = "generic";

    if(var_3.weapon != "none") {
      var_3 maps\_utility::_id_24F5();
    }
  }

  var_0 thread maps\_anim::_id_11CF(var_1[0], "samaritan_start");
  var_0 thread maps\_anim::_id_11CF(var_1[1], "limping_agent_start");
  var_0 thread maps\_anim::_id_11CF(var_1[2], "trapped_agent_start");
  var_5 = maps\_utility::_id_1287("metal_beam");
  waittillframeend;
  var_0 thread maps\_anim::_id_11CF(var_5, "trapped_prop");
  var_5 attach("hjk_plane_debris_02", "J_prop_1");
  common_scripts\utility::flag_wait("start_trapped_anims");
  var_1[0]._id_240A = "snow";
  var_1[0] thread _id_5A0B(var_0, "samaritan_start", "samaritan_loop");
  var_1[1] thread _id_5A0B(var_0, "limping_agent_start", "limping_agent_loop");
  var_1[2] thread _id_5A0B(var_0, "trapped_agent_start", "trapped_agent_loop");
  var_0 thread maps\_anim::_id_1246(var_5, "trapped_prop");
  wait 8;
  var_1[2] maps\_utility::_id_168C("hijack_fso3_helpme");
  wait 2;
  var_1[0] maps\_utility::_id_168C("hijack_fso1_agentdown");
  wait 8;
  var_1[0] maps\_utility::_id_168C("hijack_fso2_medical");
}

_id_5A0B(var_0, var_1, var_2) {
  var_0 maps\_anim::_id_1246(self, var_1);

  if(isDefined(self)) {
    var_0 maps\_anim::_id_124E(self, var_2);
  }
}

_id_5943() {
  level endon("kill_heli_1");
  common_scripts\utility::flag_wait("spawn_makarov_heli");
  level._id_5943 = maps\_vehicle::_id_2881("makarov_heli");
  level._id_59A9 = spawn("script_model", level._id_5943.origin);
  level._id_59A9 setModel("vehicle_mi17_woodland_landing_door");
  level._id_59A9.angles = level._id_5943.angles;
  level._id_59A9 linkto(level._id_5943);
  var_0 = 1.6;

  if(level._id_1F19 == "post_tarmac" || level._id_1F19 == "end_scene") {
    var_0 = 0.0;

  }
  level._id_5943 thread _id_5A0D(var_0);
  level._id_5943 thread _id_5A0C();
  level._id_5943 maps\_utility::_id_1402("makarov_heli_reached_end");
  level._id_5943 maps\_utility::_id_1402("start_commander_anim");
  level._id_5943 maps\_utility::_id_1402("makarov_heli_disable_spotlight");
  level._id_5943 maps\_utility::_id_1402("heli_start_flyaway");
  level._id_5943 maps\_utility::_id_1402("heli_end_flyaway");
  level._id_5943 maps\_utility::_id_1402("heli_start_approach");
  level._id_5943 maps\_utility::_id_1402("heli_end_approach");
  thread maps\hijack_aud::_id_5942();

  if(level._id_1F19 != "post_tarmac" && level._id_1F19 != "end_scene") {
    common_scripts\utility::flag_wait("commander_finished_engine_react_anim");
    wait 0.25;
    level._id_58D2 maps\_utility::_id_168C("hijack_cmd_evacchoppers");
  }

  if(level._id_1F19 == "end_scene") {
    return;
  }
  common_scripts\utility::flag_wait("move_heli_to_hover_point");
  level._id_5943 maps\_utility::_id_2698();
  var_1 = common_scripts\utility::getstruct("heli_fly_away", "targetname");
  level._id_5943 setgoalyaw(var_1.angles[1]);
  level._id_5943 settargetyaw(var_1.angles[1]);
  level._id_5943 setvehgoalpos(var_1.origin, 1);
  level._id_5943 common_scripts\utility::waittill_any("near_goal", "goal");
  level._id_5943 thread maps\_vehicle::_id_26A1(var_1);
  level._id_5943 maps\_utility::_id_1654("heli_end_flyaway");
  level notify("stop_spotlight_fx");
  level._id_5943 maps\_utility::_id_2698();
  var_2 = common_scripts\utility::getstruct("heli_approach", "targetname");
  level._id_5943 setgoalyaw(var_2.angles[1]);
  level._id_5943 settargetyaw(var_2.angles[1]);
  level._id_5943 setvehgoalpos(var_2.origin, 1);
  level._id_5943 common_scripts\utility::waittill_any("near_goal", "goal");
  thread _id_599C();
}

_id_599C() {
  common_scripts\utility::flag_wait("heli_start_approach");
  maps\_audio::aud_send_msg("end_heli_approach");
  level notify("kill_heli_1");
  level._id_5943._id_2891 thread _id_5275("heli_spotlight", "tag_flash", level._id_5943);
  var_0 = common_scripts\utility::getstruct("heli_approach", "targetname");
  level._id_5943 thread maps\_vehicle::_id_26A1(var_0);
  level._id_5943 maps\_utility::_id_1654("heli_end_approach");
  level._id_5943 maps\_utility::_id_2698();
  var_1 = common_scripts\utility::getstruct("heli_start_descent", "targetname");
  level._id_5943 setgoalyaw(var_1.angles[1]);
  level._id_5943 settargetyaw(var_1.angles[1]);
  level._id_5943 setvehgoalpos(var_1.origin, 1);
  level._id_5943 sethoverparams(175, 40, 20);
  level._id_5943 thread maps\hijack_script_2c::_id_59BE();
  common_scripts\utility::flag_wait("start_heli_descent");
  level._id_5943 thread maps\hijack_script_2c::_id_59BC();
  var_2 = common_scripts\utility::getstruct("heli_start_descent", "targetname");
  level._id_5943 thread maps\_vehicle::_id_26A1(var_2);
}

_id_5A0C() {
  level._id_5943 thread _id_5A12();
  common_scripts\utility::flag_wait("start_spotlight_random_targeting");
  level._id_5943 thread _id_5A13();
}

_id_5A0D(var_0) {
  self._id_2891 = spawnturret("misc_turret", self gettagorigin("tag_turret"), "heli_spotlight");
  self._id_2891 setmode("manual");
  self._id_2891 setModel("com_blackhawk_spotlight_on_mg_setup");
  self._id_2891 linkto(self, "tag_turret");
  self._id_2891 makeunusable();

  if(isDefined(var_0)) {
    wait(var_0);

  }
  self._id_2891 thread _id_5275("heli_spotlight", "tag_flash", self);
}

_id_5275(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_536B = common_scripts\utility::getfx(var_0);
  var_3.entity = self;
  self._id_5275 = var_3;
  var_3._id_536A = var_1;
  playFXOnTag(var_3._id_536B, var_3.entity, var_3._id_536A);
  thread _id_536E(var_2);
  level waittill("stop_spotlight_fx");

  if(isDefined(var_3.entity)) {
    stopFXOnTag(var_3._id_536B, var_3.entity, var_3._id_536A);
    wait 0.05;
    var_3._id_5A0E = common_scripts\utility::getfx(var_0 + "_off");
    playFXOnTag(var_3._id_5A0E, var_3.entity, var_3._id_536A);
  }
}

_id_536E(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    var_0 waittill("death");

  }
  self delete();
}

_id_5A0F() {
  for(;;) {
    var_0 = anglesToForward(self.angles * (0, 1, 0) + (40, -25, 0));
    self._id_5A10.origin = self gettagorigin("tag_turret") + var_0 * 100;
    var_1 = anglesToForward(self.angles * (0, 1, 0) + (40, 25, 0));
    self._id_5A11.origin = self gettagorigin("tag_turret") + var_1 * 100;
    wait 0.05;
  }
}

_id_5A12() {
  self endon("death");
  self endon("start_random_spotlight_targets");
  self endon("shine_spotlight_on_president");
  var_0 = getent("tail_spotlight_target_1", "targetname");
  self._id_2891 settargetentity(var_0);
  wait 4;
  var_1 = getent("tail_spotlight_target_2", "targetname");
  var_2 = spawn("script_origin", var_1.origin);
  self._id_2891 settargetentity(var_2);
  var_2 thread maps\hijack_script_2c::_id_59BD(var_1);
  wait 4;
  var_3 = getent("ring_spotlight_target", "targetname");
  self._id_2891 settargetentity(var_3);
  common_scripts\utility::flag_wait("commander_ready_for_heli");
  self._id_2891 settargetentity(level._id_58D2);
  wait 4;
  common_scripts\utility::flag_set("start_spotlight_random_targeting");
}

_id_5A13() {
  self endon("death");
  self endon("shine_spotlight_on_president");
  self notify("start_random_spotlight_targets");
  self._id_5A10 = spawn("script_origin", self.origin);
  self._id_5A11 = spawn("script_origin", self.origin);
  childthread _id_5A0F();

  for(;;) {
    self._id_2891 settargetentity(self._id_5A10);
    wait 2;
    self._id_2891 settargetentity(self._id_5A11);
    wait 2;
  }
}

_id_5A14() {}

_id_59C7() {
  maps\_vehicle::_id_2B17();
  self waittill("death");
  maps\_vehicle::_id_2B18("all");
}