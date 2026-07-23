/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_crash.gsc
*****************************************/

start_crash() {
  level.player giveweapon("fnfiveseven");
  level.player switchtoweapon("fnfiveseven");
  maps\_compass::setupminimap("compass_map_dcemp_static", "crash_minimap_corner");
  setsaveddvar("compassmaxrange", 50000);
  common_scripts\utility::flag_set("show_crash_model");
  level.door3 = getEnt("intro_door3", "targetname");
  level.door3 movey(50, 0.1);
  level.commander = maps\hijack_code::spawn_ally("commander");
  level.president = maps\hijack_code::spawn_ally("president");
  level.hero_agent_01 = maps\hijack_code::spawn_ally("hero_agent_01");
  level.advisor = maps\hijack_code::spawn_ally("advisor", "end_scene_advisor");
  level.daughter = maps\_utility::spawn_targetname("find_daughter_pre_crash");
  level.hero_agent_01 maps\_utility::disable_ai_color();
  level.commander maps\_utility::set_force_color("c");
  level.commander maps\_utility::enable_ai_color();
  level.daughter_struct = common_scripts\utility::getStruct("cargo_room_anim_struct", "targetname");
  var_0 = [];
  var_0[0] = level.president;
  var_0[1] = level.daughter;
  level.daughter_struct thread maps\_anim::anim_loop(var_0, "post_find_loop");
  common_scripts\utility::flag_set("find_daughter_moment_finished");
  maps\_audio::aud_send_msg("cargo_room_zone_off");
  level.daughter_struct thread maps\_anim::anim_loop_solo(level.commander, "find_daughter_commander_loop");
  var_1 = common_scripts\utility::getStruct("player_start_crash", "targetname");
  level.player setOrigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
  level.player giveweapon("fnfiveseven");
  level.player switchtoweapon("fnfiveseven");
  var_2 = getnode("hero_agent_crash_node", "targetname");
  level.hero_agent_01 maps\_utility::teleport_ai(var_2);
  level.hero_agent_01 setgoalnode(var_2);
  thread setup_jump_to_rollers();
  thread maps\hijack_crash_fx::handle_crash_lights();
  thread maps\hijack_crash_fx::pre_sled_light();
  thread open_cargo_door();
  thread pre_plane_crash();
  thread maps\hijack::setup_cloud_tunnel();
  thread crash_objectives();
  main();
  level waittill("crash_teleport");
  level.daughter_struct notify("stop_loop");
}

crash_init_flags() {
  common_scripts\utility::flag_init("stop_managing_crash_player");
  common_scripts\utility::flag_init("crash_throw_player");
  common_scripts\utility::flag_init("hero_agent_ready_for_crash");
  common_scripts\utility::flag_init("commander_finished_wake_up_anim");
  common_scripts\utility::flag_init("stop_sun_crash_lerp");
  common_scripts\utility::flag_init("tower_is_down");
}

crash_objectives() {
  objective_add(maps\_utility::obj("escape_pod"), "current", &"HIJACK_OBJ_ESCAPE_HATCH", level.hero_agent_01.origin);
  objective_onentity(maps\_utility::obj("escape_pod"), level.hero_agent_01, (0, 0, 70));
  level waittill("crash_teleport");
  objective_state(maps\_utility::obj("escape_pod"), "failed");
}

pre_plane_crash() {
  maps\_audio::aud_send_msg("approaching_ground");
  thread maps\_utility::autosave_by_name("pre_crash");
  thread maps\hijack_code::plane_rumbling();
  thread maps\hijack_airplane::stop_combat();
  common_scripts\utility::flag_wait("player_is_in_crash_room");
  thread enemy_pre_crash_chatter();
  common_scripts\utility::flag_wait("player_is_in_end_room");
}

commander_pre_crash_door_anim() {
  level.commander endon("start_crash_anim");
  level.daughter_struct notify("stop_loop");
  level.commander stopanimScripted();
  var_0 = common_scripts\utility::getStruct("cargo_room_anim_struct", "targetname");
  var_0 maps\_anim::anim_reach_solo(level.commander, "door1");
  var_0 maps\_anim::anim_single_solo(level.commander, "door1");
  level.commander thread maps\_anim::anim_loop_solo(level.commander, "corner_standL_alert_twitch04", "stop_door_loop");
}

crash_room_door_blocker() {
  var_0 = getEnt("crash_door_blocker_2", "targetname");
  var_0 notsolid();
  common_scripts\utility::flag_wait_any("start_plane_crash_aisle_1", "start_plane_crash_aisle_2");
  var_0 solid();
}

#using_animtree("animated_props");

open_cargo_door() {
  foreach(var_1 in level.crash_models) {
    var_1.animname = "generic";
    var_1 useanimtree(#animtree);
  }

  var_3 = getEnt("hijack_crash_model_props", "script_noteworthy");
  var_3 thread maps\_anim::anim_loop_solo(var_3, "hijack_pre_plane_crash_compartments", "stop loop");
  var_4 = getEnt("hijack_crash_model_front_interior", "script_noteworthy");
  maps\_audio::aud_send_msg("pre_crash_door");
  var_4 maps\_anim::anim_single_solo(var_4, "hijack_pre_plane_crash_door");
  var_5 = getEnt("crash_door_blocker", "targetname");
  var_5 notsolid();
  thread crash_room_door_blocker();
  common_scripts\utility::flag_wait("player_is_in_crash_room");
  var_5 solid();
  var_4 maps\_anim::anim_single_solo(var_4, "hijack_pre_plane_crash_door_close");
}

start_plane_crash() {
  thread main();
}

setup_jump_to_rollers() {
  level.org_view_roll = getEnt("org_view_roll", "targetname");
  level.player playersetgroundreferenceent(level.org_view_roll);
  level.arollers = [];
  level.arollers = maps\_utility::array_add(level.arollers, level.org_view_roll);
  thread maps\hijack_code::plane_rumbling();
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_roll, -10, 1, 0, 0);
  wait 1;
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_roll, 20, 1.5, 0, 0);
  wait 1.5;
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_roll, -10, 1, 0, 0);
  level waittill("planecrash_approaching");
}

main() {
  thread handle_crash_enemies();
  thread maps\hijack_crash_fx::handle_crash_fx();
  level.hero_agent_01 hero_agent_prepare_for_crash(level.crash_models[0]);
  common_scripts\utility::flag_wait_any("start_plane_crash_aisle_1", "start_plane_crash_aisle_2");
  thread maps\hijack_airplane::airplane_cleanup();
  level.using_aisle_1 = 0;
  var_0 = "tag_player1_rotate";
  var_1 = common_scripts\utility::getStruct("struct_aisle2_front", "targetname");
  var_2 = common_scripts\utility::getStruct("struct_aisle2_back", "targetname");
  var_3 = common_scripts\utility::getStruct("struct_aisle2_left", "targetname");
  var_4 = common_scripts\utility::getStruct("struct_aisle2_right", "targetname");

  if(common_scripts\utility::flag("start_plane_crash_aisle_1")) {
    level.using_aisle_1 = 1;
  }
  maps\_utility::delaythread(0.75, ::quickfade, 0.05);
  var_5 = level.crash_models;
  var_6 = 0;

  foreach(var_8 in var_5) {
    level.crash_models[var_6] = spawn("script_model", (0, 0, 0));
    level.crash_models[var_6] setModel(var_5[var_6].model);
    level.crash_models[var_6].animname = "generic";
    level.crash_models[var_6] useanimtree(#animtree);

    if(isDefined(var_8.script_noteworthy)) {
      level.crash_models[var_6].script_noteworthy = var_8.script_noteworthy + "_new";
    }
    var_6++;
  }

  var_5[0] useanimtree(#animtree);
  var_5[0].animname = "generic";
  plane_crash_anim_firstframe(level.crash_models);
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_0 = "tag_player1_rotate";

  if(!level.using_aisle_1) {}

  calculate_plane_movement_limits(var_5[0], var_0);
  var_10 linkTo(level.crash_models[0], var_0, (0, 0, 0), (0, 0, 0));
  level.groundent = var_10;
  level.player playersetgroundreferenceent(var_10);
  level.attach_tag = var_0;
  level notify("planecrash_approaching");
  level notify("crash_lights_out");
  wait_for_agents_to_align_for_crash();
  level.hero_agent_01.ignoreall = 1;
  thread handle_crash_sunlight();
  earthquake(0.3, 1.2, level.player.origin, 200000);
  thread quickfade(0.05);
  common_scripts\utility::flag_clear("in_flight");
  wait 0.05;
  var_11 = (var_1.origin[0] - level.player.origin[0]) / (var_1.origin[0] - var_2.origin[0]);
  var_11 = clamp(var_11, 0.0, 1.0);
  var_12 = (var_3.origin[1] - level.player.origin[1]) / (var_3.origin[1] - var_4.origin[1]);
  var_12 = clamp(var_12, 0.0, 1.0);
  teleport_crash_ents(var_5[1], level.crash_models[1]);
  maps\_compass::setupminimap("compass_map_dcemp_static", "crash_minimap_corner");
  setsaveddvar("compassmaxrange", 50000);
  level.player playrumblelooponentity("hijack_plane_medium");
  level.hero_agent_01 thread handle_hero_agent_crash();
  level.commander thread handle_commander_crash();
  level notify("crash_teleport");
  thread plane_crash_anim(level.crash_models);
  thread crash_manage_player_position_new(level.crash_models[0], var_11, var_12, level.using_aisle_1);
  thread crash_hit_throw_player(level.crash_models[0]);
  common_scripts\utility::flag_wait("stop_managing_crash_player");
  transition_to_tarmac();
}

calculate_plane_movement_limits(var_0, var_1) {
  var_2 = % hijack_plane_crash_player_move_forward;
  var_3 = % hijack_plane_crash_player_move_right;
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4 linkTo(var_0, var_1, (0, 0, 0), (0, 0, 0));
  var_0 setanim(var_2, 1, 0, 0);
  var_0 setanim(var_3, 1, 0, 0);
  waittillframeend;
  var_0 setanimtime(var_2, 1.0);
  waittillframeend;
  level.fwd_point = var_0 gettagorigin(var_1);
  var_0 setanimtime(var_2, 0.0);
  waittillframeend;
  level.back_point = var_0 gettagorigin(var_1);
  var_0 setanimtime(var_3, 1.0);
  waittillframeend;
  level.right_point = var_0 gettagorigin(var_1);
  var_0 setanimtime(var_3, 0.0);
  waittillframeend;
  level.left_point = var_0 gettagorigin(var_1);
}

hero_agent_prepare_for_crash(var_0) {
  level.hero_agent_01.animname = "generic";
  level.hero_agent_01.disablearrivals = 1;
  level.hero_agent_01.disableexits = 1;
  var_0 maps\_anim::anim_reach_solo(level.hero_agent_01, "planecrash_agent1", "tag_agent");
  common_scripts\utility::flag_set("hero_agent_ready_for_crash");
}

wait_for_agents_to_align_for_crash() {}

pre_crash_radio_vo(var_0) {
  var_0 waittillmatch("single anim", "vo_line");
  maps\_utility::radio_dialogue("hijack_plt_brace");
}

quickfade(var_0) {
  maps\hijack_code::fade_out(var_0);
  maps\hijack_code::fade_in(0.05);
}

thread_spin() {
  for(;;) {
    var_0 = 0;
    wait 0.05;
  }
}

plane_crash_anim_firstframe(var_0) {
  var_1 = common_scripts\utility::getStruct("hijack_crash_align", "targetname");

  foreach(var_3 in var_0) {}
  var_3.animname = "generic";

  var_1 maps\_anim::anim_first_frame(var_0, "hijack_plane_crash_anim");
}

plane_crash_anim(var_0) {
  maps\_audio::aud_send_msg("crash_sequence");
  level notify("crash_anim_start");
  var_1 = common_scripts\utility::getStruct("hijack_crash_align", "targetname");
  level thread maps\_utility::notify_delay("luggage_falls_out", 15.5);
  var_1 thread plane_crash_trees();
  thread pre_crash_radio_vo(var_0[0]);
  thread crash_hit_ground_thread(var_0[0]);
  maps\_audio::aud_send_msg("suitcase_prop_sound_impact", var_0[0]);
  var_2 = maps\_utility::spawn_anim_model("crash_tower", (0, 0, 0));
  var_3 = maps\_utility::spawn_anim_model("crash_tower_lights", (0, 0, 0));
  var_4[0] = var_2;
  var_4[1] = var_3;
  var_1 thread maps\_anim::anim_single(var_4, "hijack_plane_crash_anim");
  var_3 thread tower_light_flicker();
  thread plane_crash_audio_messages(var_0[0]);
  var_5 = maps\_utility::spawn_anim_model("crash_engine_1", (0, 0, 0));
  var_0 = maps\_utility::array_add(var_0, var_5);
  thread handle_engine_swap(var_5);
  var_1 maps\_anim::anim_single(var_0, "hijack_plane_crash_anim");
  level notify("crash_done");
  common_scripts\utility::flag_set("stop_managing_crash_player");
  waittillframeend;
  maps\_utility::array_delete(level.crash_models);
}

tower_light_flicker() {
  level waittill("tail_hits_tower");
  wait 0.3;
  thread maps\_utility::flag_set_delayed("tower_is_down", 2.0);
  self hide();
  wait 0.15;
  self show();

  for(var_0 = 1.0; !common_scripts\utility::flag("tower_is_down"); var_0 = var_0 * 0.8) {
    self hide();
    var_1 = randomfloatrange(0.1 * var_0, 0.2 * var_0);
    wait(var_1);
    self show();
    var_1 = randomfloatrange(0.1 * var_0, 0.5 * var_0);
    wait(var_1);
  }

  self delete();
}

plane_crash_audio_messages(var_0) {
  level.crash_explosion_origin = common_scripts\utility::spawn_tag_origin();
  level.crash_explosion_origin linkTo(var_0, "FX_R_Wing", (0, 0, 0), (0, 0, 0));
  level.crash_breakaway_chunk = common_scripts\utility::spawn_tag_origin();
  level.crash_breakaway_chunk linkTo(var_0, "J_Break_Chunk", (0, 0, 0), (0, 0, 0));
  level waittill("crash_impact");
  wait 0.5;
  maps\_audio::aud_send_msg("crash_chunk_breaks_away");
  wait 1.0;
  maps\_audio::aud_send_msg("crash_explosion");
  common_scripts\utility::flag_wait("crash_throw_player");
  level.crash_explosion_origin delete();
  level.crash_breakaway_chunk delete();
}

handle_engine_swap(var_0) {
  var_0 waittillmatch("single anim", "engine_fire");
  var_0 setModel(level.scr_model["crash_engine_2"]);
}

plane_crash_trees() {
  var_0 = maps\_utility::spawn_anim_model("pine_tree_lg");
  var_1 = maps\_utility::spawn_anim_model("pine_tree_lg");
  var_2 = maps\_utility::spawn_anim_model("pine_tree_sm");
  var_3 = maps\_utility::spawn_anim_model("pine_tree_sm");
  var_4 = maps\_utility::spawn_anim_model("pine_tree_lg");
  var_5 = maps\_utility::spawn_anim_model("pine_tree_sm");
  thread maps\_anim::anim_single_solo(var_0, "crash_tree_1");
  thread maps\_anim::anim_single_solo(var_1, "crash_tree_2");
  thread maps\_anim::anim_single_solo(var_2, "crash_tree_3");
  thread maps\_anim::anim_single_solo(var_3, "crash_tree_4");
  thread maps\_anim::anim_single_solo(var_4, "crash_tree_5");
  thread maps\_anim::anim_single_solo(var_5, "crash_tree_6");
  common_scripts\utility::flag_wait("crash_throw_player");
}

transition_to_tarmac() {
  level notify("stop_rumbling");
  level.commander notify("stop_loop");
  level.commander stopanimScripted();
  thread maps\hijack_tarmac::tarmac_carnage();
  level.player setweaponammostock("fnfiveseven", 60);
  maps\hijack_tarmac::main_script_thread();
}

crash_manage_player_position_new(var_0, var_1, var_2, var_3) {
  thread manage_player_movement_limits();
  var_4 = "tag_player1_rotate";
  var_5 = % hijack_plane_crash_player_move_forward;
  var_6 = % hijack_plane_crash_player_move_back;
  var_7 = % hijack_plane_crash_player_move_left;
  var_8 = % hijack_plane_crash_player_move_right;
  level.fwd_aisle_ranges = [];
  level.fwd_aisle_ranges[0]["left"] = 0.3;
  level.fwd_aisle_ranges[0]["right"] = 0.4;
  level.fwd_aisle_ranges[0]["front"] = 1.0;
  level.fwd_aisle_ranges[0]["back"] = 0.45;
  level.fwd_aisle_ranges[1]["left"] = 0.7;
  level.fwd_aisle_ranges[1]["right"] = 0.79;
  level.fwd_aisle_ranges[1]["front"] = 1.0;
  level.fwd_aisle_ranges[1]["back"] = 0.3;
  level.side_aisle_ranges = [];
  level.side_aisle_ranges[0]["back"] = 0.84;
  level.side_aisle_ranges[0]["front"] = 0.9;
  level.side_aisle_ranges[0]["left"] = 0.15;
  level.side_aisle_ranges[0]["right"] = 1.0;
  level.side_aisle_ranges[1]["back"] = 0.55;
  level.side_aisle_ranges[1]["front"] = 0.6;
  level.side_aisle_ranges[1]["left"] = 0.1;
  level.side_aisle_ranges[1]["right"] = 1.0;
  find_player_aisles(var_1, var_2);
  var_9 = var_5;
  var_10 = var_5;
  var_0 setanim(var_9, 1, 0, 0);
  var_0 setanimtime(var_9, var_1);
  var_11 = var_8;
  var_12 = var_8;
  var_0 setanim(var_11, 1, 0, 0);
  var_0 setanimtime(var_11, var_2);
  level.player playerlinktodelta(level.groundent, "tag_origin", 0.0, 180, 180, 70, 70, 1);
  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = 1;
  level.pushing_at_edge_time = 0;
  level.pushing_at_edge_measure_time = gettime();

  while(!common_scripts\utility::flag("stop_managing_crash_player")) {
    if(!common_scripts\utility::flag("crash_throw_player")) {
      if(!isalive(level.player)) {
        var_17 = (0, 0, 0);
      } else {
        var_17 = level.player getnormalizedmovement();
      }
      var_18 = distance((0, 0, 0), var_17);
      var_17 = (var_17[0], var_17[1] * -1, 0);
      var_19 = vectortoangles(var_17);
      var_20 = level.player getplayerangles();

      if(isDefined(level.groundent)) {
        var_20 = combineangles(level.groundent.angles, var_20);
      }
      var_21 = combineangles(var_20, var_19);
      var_22 = vectorNormalize(anglesToForward(var_21));
      var_23 = var_0 gettagangles(var_4);
      var_24 = vectorNormalize(anglesToForward(var_23));
      var_25 = vectorNormalize(anglestoright(var_23));
      var_26 = vectordot(var_22, var_24);
      var_27 = var_18 * var_26;
      var_28 = vectordot(var_22, var_25);
      var_29 = var_18 * var_28;
      var_30 = var_0 getanimtime(var_9);
      var_31 = getanimlength(var_9);
      var_32 = var_30 / var_31;
      var_33 = var_0 getanimtime(var_11);
      var_34 = getanimlength(var_11);
      var_35 = var_33 / var_34;

      if(var_18 == 0 || var_27 == 0) {
        if(var_13) {
          var_0 setanim(var_9, 1, 0, 0);
        }
        if(var_14) {
          var_0 setanim(var_11, 1, 0, 0);
        }
        var_13 = 0;
        var_14 = 0;
        wait 0.05;
        continue;
      }

      var_36 = 1.0;
      var_37 = 1.0;
      var_38 = 1.0;
      var_39 = 0.0;

      if(var_27 <= 0) {
        var_10 = var_6;
      } else {
        var_10 = var_5;
      }
      var_40 = 1.0;
      var_41 = 1.0;
      var_42 = 1.0;
      var_43 = 1.0;

      if(level.current_fwd_aisle != -1) {
        var_40 = 1.0 - level.fwd_aisle_ranges[level.current_fwd_aisle]["back"];
        var_41 = level.fwd_aisle_ranges[level.current_fwd_aisle]["front"];
      } else {
        var_40 = 1.0 - level.side_aisle_ranges[level.current_side_aisle]["back"];
        var_41 = level.side_aisle_ranges[level.current_side_aisle]["front"];
      }

      if(level.current_side_aisle != -1) {
        var_42 = 1.0 - level.side_aisle_ranges[level.current_side_aisle]["left"];
        var_43 = level.side_aisle_ranges[level.current_side_aisle]["right"];
      } else {
        var_43 = level.fwd_aisle_ranges[level.current_fwd_aisle]["right"];
        var_42 = 1.0 - level.fwd_aisle_ranges[level.current_fwd_aisle]["left"];
      }

      if(var_10 == var_6) {
        var_44 = var_30 + 0.05 * (abs(var_27) * var_36 * 0.5 * var_16);

        if(var_44 > var_40) {
          var_36 = 0.0;
          var_30 = var_40;
          var_0 setanimtime(var_6, var_40);
        }
      }

      if(var_10 == var_5) {
        var_44 = var_30 + 0.05 * (abs(var_27) * var_36 * 0.5 * var_16);

        if(var_44 > var_41) {
          var_36 = 0.0;
          var_30 = var_41;
          var_0 setanimtime(var_6, var_41);
        }
      }

      if(var_12 == var_7) {
        var_45 = var_33 + 0.05 * (abs(var_29) * var_37 * 0.5 * var_16);

        if(var_45 > var_42) {
          var_37 = 0.0;
          var_33 = var_42;
          var_0 setanimtime(var_7, var_42);
        }
      }

      if(var_12 == var_8) {
        var_46 = var_33 + 0.05 * (abs(var_29) * var_37 * 0.5 * var_16);

        if(var_46 > var_43) {
          var_37 = 0.0;
          var_33 = var_43;
          var_0 setanimtime(var_8, var_43);
        }
      }

      if(var_9 != var_10) {
        var_0 clearanim(var_9, 0);
        var_32 = 1 - var_32;
        var_32 = clamp(var_32, var_39, var_38);
        var_0 setanim(var_10, 1, 0, abs(var_27) * var_36 * 0.5 * var_16);
        var_0 setanimtime(var_10, var_32);
        var_9 = var_10;
      } else {
        var_0 setanim(var_9, 1, 0, abs(var_27) * var_36 * 0.5 * var_16);
      }
      if(var_29 < 0) {
        var_12 = var_7;
      } else {
        var_12 = var_8;
      }
      if(var_11 != var_12) {
        var_0 clearanim(var_11, 0);
        var_35 = 1 - var_35;
        var_35 = clamp(var_35, 0.0, 1.0);
        var_0 setanim(var_12, 1, 0, abs(var_29) * var_37 * 0.5 * var_16);
        var_0 setanimtime(var_12, var_35);
        var_11 = var_12;
      } else {
        var_0 setanim(var_11, 1, 0, abs(var_29) * 0.5 * var_16);
      }
      var_13 = 1;
      var_14 = 1;

      if(var_27 < 0 && var_9 == var_6 && var_0 getanimtime(var_9) > 0.99) {
        level.pushing_at_edge_time = level.pushing_at_edge_time + (gettime() - level.pushing_at_edge_measure_time);

        if(level.pushing_at_edge_time > 1000) {
          thread player_falls_out();
          return;
        }
      } else {
        var_47 = 0;
      }
      level.pushing_at_edge_measure_time = gettime();
      wait 0.05;
      var_48 = var_0 getanimtime(var_9);

      if(var_9 == var_6) {
        var_48 = 1.0 - var_48;
      }
      var_49 = var_0 getanimtime(var_11);

      if(var_11 == var_7) {
        var_49 = 1.0 - var_49;
      }
      find_player_aisles(var_48, var_49);
      continue;
    }

    if(!var_15) {
      var_15 = 1;
      level.player freezecontrols(1);
      var_0 setanim(var_5, 1.0, 0, 3.0);
      var_0 setanim(var_6, 0.0, 0);
      var_50 = var_0 getanimtime(var_11);

      if(var_50 > 0.8) {
        var_0 setanimtime(var_11, 0.8);
      } else if(var_50 < 0.35) {
        var_0 setanimtime(var_11, 0.35);
      }
      var_0 setanim(var_11, 1.0, 0.0, 0.0);
      wait 0.85;
      level.player freezecontrols(0);
      var_16 = 0.6;
      common_scripts\utility::flag_clear("crash_throw_player");
      var_10 = var_5;
      var_9 = var_5;
      var_32 = 1.0;
    }

    wait 0.05;
  }
}

find_player_aisles(var_0, var_1) {
  level.current_fwd_aisle = -1;
  var_2 = -1;
  var_3 = 1.0;

  for(var_4 = 0; var_4 < level.fwd_aisle_ranges.size; var_4++) {
    var_5 = abs(var_1 - 0.5 * (level.fwd_aisle_ranges[var_4]["left"] + level.fwd_aisle_ranges[var_4]["right"]));

    if(var_1 >= level.fwd_aisle_ranges[var_4]["left"] && var_1 <= level.fwd_aisle_ranges[var_4]["right"]) {
      level.current_fwd_aisle = var_4;
      break;
    }

    if(var_5 < var_3) {
      var_3 = var_5;
      var_2 = var_4;
    }
  }

  level.current_side_aisle = -1;
  var_6 = -1;
  var_7 = 1.0;

  for(var_4 = 0; var_4 < level.side_aisle_ranges.size; var_4++) {
    var_5 = abs(var_0 - 0.5 * (level.side_aisle_ranges[var_4]["back"] + level.side_aisle_ranges[var_4]["front"]));

    if(var_0 >= level.side_aisle_ranges[var_4]["back"] && var_0 <= level.side_aisle_ranges[var_4]["front"]) {
      level.current_side_aisle = var_4;
      break;
    }

    if(var_5 < var_7) {
      var_7 = var_5;
      var_6 = var_4;
    }
  }

  if(level.current_fwd_aisle == -1 && level.current_side_aisle == -1) {
    if(var_7 < var_3) {
      level.current_side_aisle = var_6;
    } else {
      level.current_fwd_aisle = var_2;
    }
  }
}

manage_player_movement_limits() {
  thread handle_left_aisle_limit();
  thread handle_right_aisle_limit();
}

handle_left_aisle_limit() {
  level waittill("luggage_falls_out");
  level.fwd_aisle_ranges[1]["back"] = 0.0;
}

handle_right_aisle_limit() {
  level waittill("agent_falls_out");
  level.fwd_aisle_ranges[0]["back"] = 0.0;
}

teleport_to_crashmodel(var_0, var_1) {
  if(!isDefined(level.helper)) {
    level.helper = common_scripts\utility::spawn_tag_origin();
  }
  level.helper.origin = var_0 gettagorigin("J_Mid_Section");
  var_2 = level.helper maps\_shg_common::worldtolocalcoords(self.origin);
  level.helper.origin = var_1 gettagorigin("J_Mid_Section");
  var_3 = level.helper localtoworldcoords(var_2);

  if(isai(self)) {
    self forceteleport(var_3, self.angles);
  } else if(isPlayer(self)) {
    level.helper.origin = var_3;
    level.helper.angles = self getplayerangles();
    maps\_utility::teleport_player(level.helper);
  } else {
    self.origin = var_3;
  }
}

teleport_crash_ents(var_0, var_1) {
  level.player teleport_to_crashmodel(var_0, var_1);
  level.hero_agent_01 teleport_to_crashmodel(var_0, var_1);
  level.hero_agent_01 linkTo(var_1, "tag_agent", (0, 0, 0), (0, 0, 0));
  level.commander teleport_to_crashmodel(var_0, var_1);
  level.commander linkTo(var_1, "J_Mid_Section");
  var_2 = getEntArray("sled_attach_ents", "targetname");

  foreach(var_4 in var_2) {
    var_4 teleport_to_crashmodel(var_0, var_1);
    var_4 setModel("tag_origin");
    var_4 linkTo(var_1, "J_Mid_Section");
  }

  var_6 = getEntArray("tail_attach_ents", "targetname");

  foreach(var_4 in var_6) {
    var_4 teleport_to_crashmodel(var_0, var_1);
    var_4 setModel("tag_origin");
    var_4 linkTo(var_1, "J_Tail_Sled");
  }
}

handle_hero_agent_crash() {
  self.ignoreall = 1;
  self.animname = "generic";
  maps\_audio::aud_send_msg("agent_scream", level.hero_agent_01);
  level thread maps\_utility::notify_delay("agent_falls_out", 19.5);
  level.crash_models[0] maps\_anim::anim_single_solo(self, "planecrash_agent1", "tag_agent");

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    maps\_utility::stop_magic_bullet_shield();
  }
  self.deathfunction = undefined;
  waittillframeend;
  self kill();
}

handle_commander_crash() {
  level.commander notify("stop_door_loop");
}

handle_crash_enemies() {
  level waittill("crash_teleport");
  thread tail_enemy_spawn(getEnt("planecrash_enemy1", "targetname"), "planecrash_enemy1");
  thread tail_enemy_spawn(getEnt("planecrash_enemy2", "targetname"), "planecrash_enemy2");
  thread tail_enemy_spawn(getEnt("planecrash_enemy3", "targetname"), "planecrash_enemy3");
  thread tail_enemy_spawn(getEnt("planecrash_enemy4", "targetname"), "planecrash_enemy4");
  thread tail_enemy_spawn(getEnt("planecrash_enemy5", "targetname"), "planecrash_enemy5");
  thread tail_enemy_spawn(getEnt("planecrash_enemy6", "targetname"), "planecrash_enemy6");
}

tail_enemy_spawn(var_0, var_1) {
  var_2 = var_0 maps\_utility::spawn_ai();
  var_2.ignoreall = 1;
  var_2 linkTo(level.crash_models[0], "tag_enemy", (0, 0, 0), (0, 0, 0));
  var_2.dontshootstraight = 1;
  level.crash_models[0] thread maps\_anim::anim_generic(var_2, var_1, "tag_enemy");
  var_2.allowdeath = 1;
  var_2.noragdoll = 1;
  level waittill("crash_done");

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

shell_shock(var_0, var_1) {
  self shellshock(var_0, var_1);
}

player_falls_out() {
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_0.angles = level.player.angles;
  var_0 maps\_anim::setanimtree();
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player maps\_utility::delaythread(0.75, ::shell_shock, "hijack_airplane", 3.0);
  maps\_audio::aud_send_msg("crash_death");
  var_0 linkTo(level.crash_models[0], level.attach_tag, (0, 0, 0), (0, 180, 0));
  level.player playerlinktoabsolute(var_0, "tag_player");
  level.player playersetgroundreferenceent(undefined);
  var_1 = getanimlength(var_0 maps\_utility::getanim("crash_fall_out"));
  level.crash_models[0] thread maps\_anim::anim_single_solo(var_0, "crash_fall_out", level.attach_tag);
  wait(var_1 - 0.5);
  setDvar("ui_deadquote", &"HIJACK_FELL_OUT_OF_PLANE");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

handle_crash_sunlight() {
  setsunlight(0, 0, 0);
  level waittill("crash_impact");
  setsaveddvar("sm_sunSampleSizeNear", 2.5);
  enableforcedsunshadows();
  resetsunlight();
  thread sunlight_flicker();
  thread sunlight_direction_lerp();
  common_scripts\utility::flag_wait("crash_throw_player");
  disableforcedsunshadows();
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

sunlight_flicker() {
  wait 0.5;
  var_0 = (0, 0, 0);
  thread sunlight_flicker_lifetime_values();

  while(!common_scripts\utility::flag("stop_sun_crash_lerp")) {
    var_1 = randomfloatrange(level.crash_light_scale_min, level.crash_light_scale_max);
    wait(randomfloatrange(0.1, 0.3));
    var_0 = level.crash_light_val_base * var_1;
    setsunlight(var_0[0], var_0[1], var_0[2]);
  }

  var_2 = (0.878431, 0.443137, 0.121569);
  sun_lerp_value(var_0, var_2, 0.5);
}

sunlight_flicker_lifetime_values() {
  var_0 = (0.878431, 0.443137, 0.121569);
  var_1 = (0.965, 0.847, 0.584);
  var_2 = 1.2;
  var_3 = 3.0;
  var_4 = 0.9;
  var_5 = 0.98;
  level.crash_light_val_base = var_0;
  level.crash_light_scale_min = var_2;
  level.crash_light_scale_max = var_3;
  var_6 = 13;
  var_7 = var_6;

  while(var_7 > 0) {
    var_8 = (var_6 - var_7) / var_6;
    var_8 = var_8 * var_8;
    level.crash_light_val_base = vectorlerp(var_0, var_1, var_8);
    level.crash_light_scale_min = maps\_utility::linear_interpolate(var_8, var_2, var_4);
    level.crash_light_scale_max = maps\_utility::linear_interpolate(var_8, var_3, var_5);
    var_7 = var_7 - 0.1;
    wait 0.1;
  }

  common_scripts\utility::flag_set("stop_sun_crash_lerp");
}

sun_lerp_value(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = 0;

  while(var_3 > 0) {
    var_3 = var_3 - 0.05;
    var_4 = (var_2 - var_3) / var_2;
    var_5 = var_0 + (var_1 - var_0) * var_4;
    setsunlight(var_5[0], var_5[1], var_5[2]);
  }
}

sunlight_direction_lerp() {
  var_0 = (-5, -90, 0);
  var_1 = -5;
  var_2 = -120;
  var_3 = -70;
  var_4 = (-5, -130, 0);
  var_5 = (-5, -80, 0);
  var_6 = (0.878431, 0.443137, 0.121569);
  lerpsunangles(var_0, var_4, 0.05);

  while(!common_scripts\utility::flag("stop_sun_crash_lerp")) {
    lerpsunangles(var_5, var_4, randomfloatrange(0.5, 1.1));
    wait(randomfloatrange(0.6, 0.9));
    lerpsunangles(var_4, var_5, 0.05);
    wait 0.05;
  }
}

crash_hit_ground_thread(var_0) {
  var_0 waittillmatch("single anim", "hit_ground");
  level notify("crash_impact");
  level notify("crash_stop_pre_sled_lights");
  thread handle_runner_lights();
  level.player stoprumble("hijack_plane_medium");
  earthquake(0.7, 1.2, level.player.origin, 200000);
  level.player disableweapons();
  wait 0.5;
  level.player playrumblelooponentity("hijack_plane_large");
  thread maps\hijack_code::plane_rumbling();
  wait 1.5;
  level.player enableweapons();
}

crash_hit_throw_player(var_0) {
  var_0 waittillmatch("single anim", "hit_stop");
  common_scripts\utility::flag_set("crash_throw_player");
  level notify("crash_stop_flashing_lights");
  level notify("sled_scrape_stop");
  stopallrumbles();
  level notify("stop_rumbling");
  var_1 = common_scripts\utility::getStruct("player_crash_end_lookat", "targetname");
  var_2 = getEnt("crash_player_dest_2", "script_noteworthy");

  if(level.using_aisle_1) {
    var_2 = getEnt("crash_player_dest_1", "script_noteworthy");
  }
  var_3 = vectortoangles(var_1.origin - var_2.origin);
  var_3 = (0, var_3[1], 0);
  remove_all_weapons_post_crash();
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_0 gettagorigin(level.attach_tag);
  var_4.angles = var_0 gettagangles(level.attach_tag) + (10, 180, 0);
  var_4 linkTo(level.groundent);
  level.player playerlinktoblend(var_4, "tag_origin", 0.1, 0, 0);
  wait 0.1;

  if(isDefined(level.commander)) {
    level.commander maps\_utility::stop_magic_bullet_shield();
    level.commander delete();
    level.commander = maps\hijack_code::spawn_ally("commander_tarmac", "tarmac_commander_tarmac");
    var_5 = getnode("commander_pre_ramp_node", "targetname");
    level.commander maps\_utility::teleport_ai(var_5);
    level.commander hide();
  }

  level.player shellshock("hijack_airplane", 2.5);
  level.player playRumbleOnEntity("damage_heavy");
  wait 0.3;
  var_0 waittillmatch("single anim", "hit_end");
  common_scripts\utility::flag_set("stop_managing_crash_player");
  level.player playRumbleOnEntity("damage_heavy");
  thread maps\hijack_code::fade_out(0.05);
  wait 0.2;
  level notify("crash_sequence_done");
  setsaveddvar("compass", 0);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  level.player enableslowaim(0, 0);
  wait 10.0;
  setsaveddvar("compass", 1);
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  level.player disableslowaim();
  level.commander show();
  level.player allowcrouch(0);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread maps\hijack_code::fade_in(3.0);
  thread post_crash_background_chatter();
  var_6 = common_scripts\utility::getStruct("agent_helps_player_origin", "targetname");
  thread player_wake_up(var_6);
  thread commander_wake_up(var_6);
  thread animated_telephone();
}

remove_all_weapons_post_crash() {
  level.player disableweapons();
}

animated_telephone() {
  var_0 = common_scripts\utility::getStruct("agent_helps_player_origin", "targetname");
  var_1 = getEnt("post_crash_phone", "targetname");
  var_1.animname = "post_crash_telephone";
  var_1 maps\_anim::setanimtree();
  var_0 thread maps\_anim::anim_single_solo(var_1, "telephone_swing");
}

player_wake_up(var_0) {
  var_1 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  level.player playerlinktodelta(var_1, "tag_player", 1.0, 10, 10, 10, 10, 1);
  thread player_blur();
  level.player enableslowaim();
  var_0 maps\_anim::anim_single_solo(var_1, "help_player_up");
  level.player unlink();
  var_1 delete();
  thread slowly_restore_aim_speed();
  common_scripts\utility::flag_set("player_on_feet_post_crash");
}

commander_wake_up(var_0) {
  level notify("start_commander_wake_up_anim");
  var_0 maps\_anim::anim_single_solo(level.commander, "help_player_up");
  common_scripts\utility::flag_set("commander_finished_wake_up_anim");
}

slowly_restore_aim_speed() {
  var_0 = 0.4;
  level.player enableslowaim(0.2, 0.2);
  wait(var_0);
  level.player enableslowaim(0.3, 0.3);
  wait(var_0);
  level.player enableslowaim(0.4, 0.4);
  wait(var_0);
  level.player enableslowaim(0.5, 0.5);
  wait(var_0);
  level.player enableslowaim(0.6, 0.6);
  wait(var_0);
  level.player enableslowaim(0.7, 0.7);
  wait(var_0);
  level.player enableslowaim(0.8, 0.8);
  wait(var_0);
  level.player enableslowaim(0.9, 0.9);
  wait(var_0);
  level.player disableslowaim();
}

player_blur() {
  setblur(9, 1);
  wait 1;
  setblur(0, 1);
  wait 2;
  setblur(4, 0.5);
  wait 0.5;
  setblur(0, 0.5);
  wait 2.5;
  setblur(5, 3);
  wait 2.5;
  setblur(0, 1.5);
  wait 0.5;
  var_0 = level.dofdefault;
  var_1 = [];
  var_1["nearStart"] = 0.1;
  var_1["nearEnd"] = 0.2;
  var_1["nearBlur"] = 6.0;
  var_1["farStart"] = 50;
  var_1["farEnd"] = 100;
  var_1["farBlur"] = 5;
  maps\_utility::blend_dof(var_0, var_1, 2.5);
  common_scripts\utility::flag_wait("player_on_feet_post_crash");
  maps\_utility::blend_dof(var_1, var_0, 5);
}

post_crash_background_chatter() {
  level endon("player_exit_plane_3");
  level.tarmac_radio_org = spawn("script_origin", level.player.origin);
  level.tarmac_radio_org linkTo(level.player);
  level.tarmac_radio_org.linked = 1;
  var_0 = 1.75;
  var_1 = 3.0;
  maps\hijack_code::background_chatter("hijack_rt1_stillinarea", level.tarmac_radio_org);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::background_chatter("hijack_rt2_command", level.tarmac_radio_org);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::background_chatter("hijack_rt3_scrambling", level.tarmac_radio_org);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::background_chatter("hijack_rt1_clearing", level.tarmac_radio_org);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::background_chatter("hijack_rt2_neutralized", level.tarmac_radio_org);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::background_chatter("hijack_rt3_wounded", level.tarmac_radio_org);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::background_chatter("hijack_rt1_verifylocation", level.tarmac_radio_org);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::background_chatter("hijack_rt2_hamburg", level.tarmac_radio_org);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::background_chatter("hijack_fso1_flightpath", level.tarmac_radio_org);
}

handle_runner_lights() {
  var_0 = getEnt("hijack_crash_model_front_interior_new", "script_noteworthy");
  var_1 = getEnt("hijack_crash_model_rear_interior_new", "script_noteworthy");
  runner_lights_seton(0, var_0, "plane_crash_lights_on_front", "plane_crash_lights_off_front");
  runner_lights_seton(0, var_1, "plane_crash_lights_on_rear", "plane_crash_lights_off_rear");
  wait 2.0;
  thread flicker_model(var_0, "stop_front_flicker", "plane_crash_lights_on_front", "plane_crash_lights_off_front");
  wait 3.0;
  runner_lights_seton(0, var_1, "plane_crash_lights_on_rear", "plane_crash_lights_off_rear");
  common_scripts\utility::flag_wait("crash_throw_player");
  level notify("stop_front_flicker");
  runner_lights_seton(0, var_0, "plane_crash_lights_on_front", "plane_crash_lights_off_front");
  runner_lights_seton(0, var_1, "plane_crash_lights_on_rear", "plane_crash_lights_off_rear");
}

enemy_pre_crash_chatter() {
  level endon("crash_teleport");
  var_0 = getEnt("crash_battlechatter_origin", "script_noteworthy");

  for(;;) {
    var_0 maps\_utility::play_sound_on_entity("RU_1_order_move_combat");
    var_0 maps\_utility::play_sound_on_entity("RU_1_hostile_burst");
  }
}

flicker_model(var_0, var_1, var_2, var_3) {
  level endon(var_1);

  for(;;) {
    runner_lights_seton(1, var_0, var_2, var_3);
    wait(randomfloatrange(0.05, 0.5));
    runner_lights_seton(0, var_0, var_2, var_3);
    wait(randomfloatrange(0.05, 0.2));
  }
}

runner_lights_seton(var_0, var_1, var_2, var_3) {
  if(var_0) {
    var_1 setModel(level.scr_model[var_2]);
  } else {
    var_1 setModel(level.scr_model[var_3]);
  }
}