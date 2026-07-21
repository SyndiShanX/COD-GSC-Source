/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_wolf.gsc
************************************************/

wolf_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("wolf", [level.player]);
  thread wolf_start_setup_farah();
}

wolf_start_setup_farah() {
  wait 0.25;
  var_0 = getnode("wolf_tunnel_node_1", "targetname");
  level.farah forceteleport(var_0.origin, var_0.angles);
  wait 0.05;
  level.farah.ignoreall = 0;
  level.farah.ignoreme = 0;
  level.farah scripts\common\utility::demeanor_override("combat");
  level.farah scripts\engine\sp\utility::enable_ai_color();
  level.farah thread scripts\sp\spawner::go_to_node(var_0);
}

wolf_catchup() {
  scripts\engine\utility::flag_set("wolf_killed");
}

wolf() {
  scripts\sp\utility::notetrack_mission_failed_vo_disable();
  var_0 = getEnt("wolf_obj_trig", "targetname");
  var_0 thread wolf_objective();
  level.wolf = scripts\engine\sp\utility::spawn_targetname("wolfSpawner", 1);
  level.wolf.animname = "wolf";
  level.wolf.ignoreall = 1;
  level.wolf.ignoreme = 1;
  level.wolf.noragdoll = 1;
  level.wolf.team = "axis";
  level.wolf thread update_wolf_face_position();
  level.wolf scripts\common\ai::magic_bullet_shield();
  level.wolf scripts\sp\utility::context_melee_allow(0);
  level.wolf scripts\common\ai::gun_remove();
  thread wolf_tunnel_farah_movement_and_vo();
  thread wolf_tunnel_first_frame();
  thread wolf_bomb_vest();
  thread wolf_scene_door();
  scripts\engine\utility::flag_wait("wolf_door_unlocked");
  scripts\engine\utility::flag_wait("wolfdoor_open");
  level.farah.anim_playvo_func = scripts\engine\utility::playsoundontag;
  thread wolf_death_farah_points_out_vest_vo();
  thread wolf_death_detect_player_escapes_wolf();
  thread wolf_death_detect_player_too_close_to_wolf();
  thread wolf_death_detect_player_shoots_next_to_wolf();
  thread wolf_death_detect_player_wolf_kill();
  thread wolf_death_detect_molotov_wolf_kill();
  thread wolf_death_detect_player_shoot_vest();
  thread wolf_death_intro();
  scripts\engine\utility::flag_wait("wolf_killed");
  thread mus_wolf_killed();
  scripts\engine\utility::flag_wait("bomb_vest_scene_finished");
  thread scripts\sp\analytics::analytics_fake_start_point("wolf");
}

wolf_objective() {
  wait 0.25;
  scripts\engine\sp\objectives::objective_remove("tunnels_search");
  var_0 = level.wolf getEye() + (0, 0, 10);
  scripts\engine\sp\objectives::objective_add("Wolf", "current", var_0, &"ZD30/OBJ_TUNNELS_WOLF");
  self waittill("trigger");
  thread mus_get_to_wolf();
  scripts\engine\utility::flag_wait("wolf_killed");
  scripts\engine\sp\objectives::objective_remove("Wolf");
  var_0 = level.wolf_vest.control.origin + (0, 0, 6);
  scripts\engine\sp\objectives::objective_add("Bomb", "current", var_0, &"ZD30/OBJ_TUNNELS_BOMB");
  level waittill("wolf_vest_defused");
  scripts\engine\sp\objectives::objective_remove("Bomb");
}

mus_get_to_wolf() {
  setmusicstate("mx_zd30_wolf_bunker_intro");
}

mus_wolf_killed() {
  setmusicstate("mx_zd30_wolf_dead");
}

update_wolf_face_position() {
  level endon("wolf_killed");
  level.wolf_death_origin = level.wolf.origin;
  level.wolf_death_angles = level.wolf.angles;
  level.wolf_death_eye = level.wolf getEye();

  while(isDefined(level.wolf)) {
    level.wolf_death_origin = level.wolf.origin;
    level.wolf_death_angles = level.wolf.angles - (0, 48, 0);
    level.wolf_death_eye = level.wolf getEye();
    wait 0.05;
  }
}

wolf_tunnel_first_frame() {
  var_0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.wolf, "death_intro");
}

wolf_tunnel_farah_movement_and_vo() {
  level endon("wolfdoor_open");
  level.farah notify("disable_bump_management");
  level.farah.script_pushable = 1;
  level.farah pushplayer(0);
  childthread wolf_tunnel_approach_vo();
  level.farah thread scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 125, 205, 250);
  scripts\engine\utility::flag_wait("wolf_door_unlocked");
  level.farah scripts\engine\sp\utility::disable_ai_color();
  waitframe();
  level.farah scripts\engine\sp\utility::set_goal_radius(16);
  level.farah scripts\engine\sp\utility::set_goal_node_targetname("node_outside_wolf");
  level.farah waittill("goal");
  var_0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var_0 scripts\sp\anim::anim_reach_solo(level.farah, "death_intro_enter_idle");
  level.farah scripts\engine\sp\utility::disable_dynamic_run_speed();
  thread wolf_outside_room_farah_nag(var_0, "wolfdoor_open");
}

wolf_tunnel_approach_vo() {
  level endon("wolfdoor_open");
  thread stop_wolf_pa_on_death();
  wait 1.2;
  level.wolf thread say_wolf_line("dx_vom_wolf_wolf_death_10", "dx_vom_wolf_wolf_death_11");
  level.farah waittill("goal_changed");
  wait 1.5;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_far_wolf_death_12");
  scripts\engine\utility::flag_wait("wolf_door_unlocked");
  level.wolf say_wolf_line("dx_vom_wolf_wolf_death_20", "dx_vom_wolf_wolf_death_21");
  level.wolf say_wolf_line("dx_vom_wolf_wolf_death_30", "dx_vom_wolf_wolf_death_31");
}

stop_wolf_pa_on_death() {
  level.wolf waittill("damage");
  wait 0.25;

  if(isDefined(level.wolf_speaker))
    level.wolf_speaker stopsounds();
}

say_wolf_line(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0;

  level.wolf_speaker = scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc::get_closest_speaker();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say(var_0);
  wait 0.25;
  level.wolf_speaker scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say(var_1);
}

wolf_outside_room_farah_nag(var_0, var_1) {
  level endon(var_1);
  var_2 = 0;
  var_3 = [];
  var_3[0] = "dx_vom_far_wolf_death_13";
  var_3[1] = "dx_vom_far_wolf_death_14";
  var_4 = 4;
  var_5 = 6;

  for(var_6 = 24; var_6 > 0; var_6 = var_6 - var_9 / 1000) {
    var_7 = gettime();
    var_0 thread scripts\common\anim::anim_loop_solo(level.farah, "death_intro_enter_idle", "death_intro_enter_idle_stop");
    var_8 = randomintrange(var_4, var_5);
    wait(var_8);
    var_0 notify("death_intro_enter_idle_stop");
    level.farah thread scripts\engine\sp\utility::smart_dialogue(var_3[var_2]);
    var_2++;

    if(var_2 > var_3.size - 1)
      var_2 = 0;

    var_0 scripts\common\anim::anim_single_solo(level.farah, "death_intro_enter_nag");
    var_9 = gettime() - var_7;
  }
}

wolf_scene_door() {
  var_0 = getEnt("wolfdoor_unlock", "targetname");
  var_0 waittill("trigger");
  thread scripts\sp\analytics::analytics_kleenex_update("Shaft to Wolf");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getEntArray("wolfdoor", "targetname");

  foreach(var_6 in var_4) {
    if(!isDefined(var_6) || !isDefined(var_6.classname)) {
      continue;
    }
    if(var_6.classname == "script_model")
      var_1 = var_6;

    if(var_6.classname == "script_brushmodel")
      var_2 = var_6;

    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "handle")
      var_3 = var_6;
  }

  var_8 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_9 = scripts\engine\utility::getStruct(var_8.target, "targetname");
  var_10 = scripts\engine\utility::getStruct(var_9.target, "targetname");
  var_3 linkTo(var_2);
  var_1 linkTo(var_2);
  var_11 = anglesdelta(var_8.angles, var_9.angles);
  var_2 rotateYaw(var_11, 1, 0.1, 0.55);
  scripts\engine\utility::flag_set("wolf_door_unlocked");
  var_12 = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
  var_3 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var_12, 45, 200 * level.interactive_doors.hint_dist_scale, 55 * level.interactive_doors.hint_dist_scale, 0);
  var_3 thread set_wolfdoor_open_flag_on_trigger();
  scripts\engine\utility::flag_wait("wolfdoor_open");
  var_3 playSound("scrpt_door_metal_heavy_open_soft");
  var_3 thread scripts\sp\player\cursor_hint::remove_cursor_hint();
  thread wolf_death_player_cleared_door();
  var_1 thread scripts\engine\utility::play_loop_sound_on_entity("scrpt_door_metal_heavy_creak_lp");
  var_11 = anglesdelta(var_9.angles, var_10.angles);
  var_2 rotateYaw(var_11, 1.5, 0.1, 0.5);
  var_2 connectpaths();
  wait 1.5;
  var_1 notify("stop soundscrpt_door_metal_heavy_creak_lp");
}

set_wolfdoor_open_flag_on_trigger() {
  scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "trigger");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "wolfdoor_open");
  scripts\engine\sp\utility::do_wait_any();

  if(scripts\engine\utility::flag("wolfdoor_open"))
    return;
  else
    waitframe();

  scripts\engine\utility::flag_set("wolfdoor_open");
}

wolf_death_player_cleared_door() {
  var_0 = getEnt("wolf_room_door_clear_trig", "targetname");

  while(level.player istouching(var_0))
    wait 0.05;

  scripts\engine\utility::flag_set("wolfdeath_player_cleared_door");
}

wolf_death_farah_points_out_vest_vo() {
  wait 2.6;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_wolf_death_40");
}

wolf_death_detect_player_escapes_wolf() {
  level.player endon("ready_to_defuse");
  var_0 = getEnt("safe_room_exit_trig", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("wolfdeath_player_escaped");
  level.wolf_vest wolf_vest_defuse_failed();
}

wolf_death_detect_player_shoots_next_to_wolf() {
  level endon("wolf_killed");
  level endon("wolfdeath_player_escaped");
  level endon("wolfdeath_player_too_close");
  var_0 = 0.6;

  for(;;) {
    level.player scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire", "offhand_fired");
    wait 0.15;

    if(!scripts\engine\utility::flag("wolf_killed") && scripts\engine\sp\utility::player_looking_at(level.wolf getEye(), var_0, 1, level.wolf)) {
      scripts\engine\utility::flag_set("wolfdeath_player_shoots_around");
      return;
    }
  }
}

wolf_death_detect_player_too_close_to_wolf() {
  level endon("wolf_killed");
  level endon("wolfdeath_player_escaped");
  level endon("wolfdeath_player_shoots_around");
  var_0 = 64;
  var_1 = spawn("trigger_radius", level.wolf.origin, 0, var_0, 256);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      var_1 delete();
      break;
    }
  }

  scripts\engine\utility::flag_set("wolfdeath_player_too_close");
}

wolf_death_detect_player_shoot_vest() {
  level endon("wolfdeath_player_defuse_interacted");

  for(;;) {
    level.wolf waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(!isDefined(var_1) || !isPlayer(var_1) || !isDefined(var_4) || !isDefined(var_7)) {
      continue;
    }
    if(var_4 != "MOD_PISTOL_BULLET" && var_4 != "MOD_RIFLE_BULLET" && var_4 != "MOD_MELEE" && var_4 != "MOD_IMPACT") {
      continue;
    }
    if(scripts\engine\utility::hastag(level.wolf.model, var_7) && var_7 == "j_spinelower" || var_4 == "MOD_IMPACT") {
      wolf_death_fail_due_to_damage();
      return;
    }
  }
}

wolf_death_detect_player_wolf_kill() {
  level endon("wolfdeath_player_escaped");

  for(;;) {
    level.wolf waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_1) && (isPlayer(var_1) || var_1 == level.farah)) {
      if(isPlayer(var_1))
        scripts\engine\utility::flag_set("wolfdeath_player_shoots_wolf");
      else
        scripts\engine\utility::flag_set("wolfdeath_farah_shoots_wolf");

      level.wolf stopsounds();

      if(isDefined(var_4) && var_4 == "MOD_MELEE")
        level.wolf playSound("generic_pain_enemy_1");

      break;
    }
  }

  level.wolf.team = "neutral";
  level.wolf.no_friendly_fire_fail = 1;
  scripts\engine\utility::flag_set("wolf_killed");
  var_8 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var_8 scripts\common\anim::anim_single_solo(level.wolf, "death_kill");
  var_8 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_kill");
}

wolf_death_fail_due_to_damage() {
  if(!isDefined(level.farah) || !isDefined(level.wolf_vest)) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var_0 notify("stop_loop");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  level.wolf_vest wolf_vest_defuse_failed(undefined, 1);
}

wolf_death_detect_molotov_wolf_kill() {
  for(;;) {
    level waittill("molotov_fire_trigger", var_0);

    if(level.wolf istouching(var_0)) {
      scripts\engine\utility::flag_set("wolfdeath_player_shoots_wolf");
      level.wolf stopsounds();
      level.wolf playSound("generic_pain_enemy_1");
      break;
    }

    var_1 = spawn("script_origin", var_0.origin);
    var_2 = getEnt("wolf_room_trig", "targetname");

    if(var_1 istouching(var_2)) {
      wait 0.05;
      var_1 delete();
      break;
    }

    wait 0.05;
  }

  var_3 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var_3 notify("stop_loop");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  wait 1;
  level.wolf_vest wolf_vest_defuse_failed();
}

wolf_death_intro() {
  level endon("wolfdeath_player_shoots_wolf");
  var_0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var_0 notify("death_intro_enter_idle_stop");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  thread wolf_death_intro_wolf_monologue(var_0);
  thread wolf_death_intro_farah_anim(var_0);
  scripts\engine\utility::flag_wait("wolfdeath_farah_shoot");
  level.wolf scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittillmatch_any_return, "single anim", "start_farah_kill");
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait_any, "wolfdeath_player_too_close", "wolfdeath_player_shoots_around");
  scripts\engine\sp\utility::do_wait_any();
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_wolf_death_57");
  level.farah shoot(1, level.wolf getEye());
  level.wolf notify("damage", 10, level.farah);
  wait 0.5;
}

wolf_death_intro_wolf_monologue(var_0) {
  level endon("wolf_killed");
  level thread scripts\engine\utility::flag_set_delayed("wolfdeath_timer_low", 8);
  var_0 scripts\common\anim::anim_single_solo(level.wolf, "death_intro");
  var_0 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_intro");
}

wolf_death_intro_farah_anim(var_0) {
  level endon("wolfdeath_player_defuse_interacted");
  scripts\engine\utility::flag_wait_any("wolfdeath_timer_low", "wolfdeath_player_cleared_door", "wolfdeath_player_shoots_wolf", "wolfdeath_player_too_close", "wolfdeath_player_shoots_around");
  var_0 scripts\sp\anim::anim_reach_solo(level.farah, "death_intro");
  level.farah scripts\engine\sp\utility::disable_dynamic_run_speed();
  scripts\engine\utility::delaythread(1.9, scripts\engine\utility::flag_set, "wolfdeath_farah_shoot");
  var_0 scripts\common\anim::anim_single_solo(level.farah, "death_intro");
  var_0 thread scripts\common\anim::anim_loop_solo(level.farah, "death_intro_idle", "death_intro_idle_stop");
  waitframe();
  scripts\engine\utility::flag_set("wolfdeath_farah_in_position");
}

wolf_bomb_vest() {
  level.looking_at_wire = undefined;
  level.vest_required_wire = undefined;
  level.defuse_count = 0;
  var_0 = "j_chest";
  var_1 = level.wolf gettagorigin("j_chest");
  var_2 = level.wolf gettagangles("j_chest");
  var_3 = getEnt("wolf_vest_new2", "targetname");
  var_3.control = getEnt("wolf_vest_control", "targetname");
  var_3.control linkTo(var_3);
  var_3 thread vest_timer_countdown();
  waitframe();
  var_3.red_wire_upper = var_3 setup_wire("red_wire_upper", 1, "red");
  var_3.red_wire_lower = var_3 setup_wire("red_wire_lower", 1, "red");
  var_3.yellow_wire = var_3 setup_wire("yellow_wire", 4, "yellow");
  var_3.green_wire = var_3 setup_wire("green_wire", 2, "green");
  var_3.blue_wire = var_3 setup_wire("blue_wire", 0, "blue");
  var_3.wires = [var_3.red_wire_upper, var_3.red_wire_lower, var_3.yellow_wire, var_3.green_wire, var_3.blue_wire];
  var_4 = (-19.1, -1.65, -0.05);
  var_5 = (90, 0, -2);
  var_3 linkTo(level.wolf, var_0, var_4, var_5);
  level.wolf_vest = var_3;
  level.wolf_vest hide();
  thread wolf_bomb_clacker_setup();
  wolf_bomb_tablet_setup();
  thread wolf_bomb_vest_think();
}

debug_vest_pos_ang() {
  for(;;) {
    wait 0.25;
    self unlink();
    var_0 = (getdvarfloat("zd_x"), getdvarfloat("zd_y"), getdvarfloat("zd_z"));
    var_1 = (getdvarfloat("zd_pitch"), getdvarfloat("zd_yaw"), getdvarfloat("zd_roll"));
    self linkTo(level.wolf, "j_chest", var_0, var_1);
  }
}

wolf_bomb_clacker_setup() {
  level.wolf_clacker = spawn("script_model", level.wolf gettagorigin("tag_accessory_right"));
  level.wolf_clacker setModel("offhand_wm_clacker");
  level.wolf_clacker.angles = level.wolf gettagangles("tag_accessory_right");
  level.wolf_clacker linkTo(level.wolf, "tag_accessory_right");
}

wolf_bomb_vest_think() {
  scripts\engine\utility::flag_wait("wolf_killed");
  thread detect_player_leaving_after_wolf_death();
  thread wolf_bomb_vest_farah_defuse_enter_anim();
  thread timeout_explode();
  var_0 = &"ZD30/DEFUSE";
  level.wolf_vest.control scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var_0, 90, 128, 52, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 25);
  level.wolf_vest.control waittill("trigger");
  scripts\engine\utility::flag_set("wolfdeath_player_defuse_interacted");
  thread cleanup_enemies_for_wolf_defuse();
  scripts\sp\player_death::clear_custom_death_quote();
  level.wolf_vest.control scripts\sp\player\cursor_hint::remove_cursor_hint();
  level.wolf_vest thread wolf_bomb_vest_defuse_anim();
  level.wolf_vest thread wire_look_at_think();
  level thread wolf_bomb_vest_defuse_dof();
  level.player waittill("ready_to_defuse");
  level.player notifyonplayercommand("wire_cut_button_press", "+usereload");
  level.player notifyonplayercommand("wire_cut_button_press", "+activate");
  var_1 = 3;

  while(level.defuse_count < var_1) {
    level.player waittill("wire_cut", var_2, var_3);

    if(!isDefined(level.looking_at_wire) || !isDefined(level.vest_required_wire) || level.vest_required_wire != var_3 || var_2 < level.vest_required_start_time || var_2 > level.vest_required_end_time) {
      level.wolf_vest wolf_vest_defuse_failed(1);
      return;
    } else
      level.defuse_count++;

    waitframe();
  }

  level.wolf_vest.defused = 1;
  wait 1.5;
  level notify("wolf_vest_defused");
}

wolf_bomb_vest_defuse_dof() {
  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof on bomb vest");

  level.player enablephysicaldepthoffieldscripting(1);
  level.player setphysicaldepthoffield(2.8, 20, 1, 2);
  level waittill("wolf_vest_defused");
  wait 0.25;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof off");
}

cleanup_enemies_for_wolf_defuse() {
  var_0 = getaiarray("axis");

  for(;;) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_2 == level.wolf) {
        continue;
      }
      var_3 = distance(level.player.origin, var_2.origin);
      var_2.ignoreme = 1;
      var_2.ignoreall = 1;

      if(var_3 < 500 || var_2 cansee(level.player)) {
        if(isalive(var_2))
          var_2 kill();

        wait 0.25;

        if(isDefined(var_2))
          var_2 delete();
      }
    }

    clearallcorpses();
    wait 2;
  }
}

timeout_explode() {
  level endon("wolfdeath_player_defuse_interacted");
  scripts\engine\utility::flag_wait("wolfdeath_farah_defuse_ready");
  wait 6;
  level.wolf_vest thread wolf_vest_defuse_failed();
}

wolf_bomb_vest_farah_defuse_enter_anim() {
  level endon("wolfdeath_player_escaped");
  level endon("wolfdeath_farah_teleport");
  level.wolf_vest.control endon("player_left");
  var_0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  scripts\engine\utility::flag_wait("wolfdeath_farah_in_position");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 notify("death_intro_idle_stop");
  level.farah scripts\engine\utility::delaythread(1.5, scripts\engine\sp\utility::smart_dialogue, "dx_vom_far_wolf_death_62");
  level.farah scripts\engine\utility::delaythread(2.85, scripts\engine\sp\utility::smart_dialogue, "dx_vom_far_wolf_death_63");
  scripts\engine\utility::delaythread(2.3, scripts\engine\utility::flag_set, "wolfdeath_farah_defuse_ready_tele");
  var_0 thread scripts\common\anim::anim_single_solo(level.farah, "death_diffuse_enter");
  level.farah waittillmatch("single anim", "tablet_pickup");
  wolf_bomb_tablet_pickup();
  level.farah waittillmatch("single anim", "end");
  var_0 thread scripts\common\anim::anim_last_frame_solo(level.farah, "death_diffuse_enter");
  scripts\engine\utility::flag_set("wolfdeath_farah_defuse_ready");
  thread wolf_bomb_vest_farah_defuse_enter_anim_loop(var_0);
}

wolf_bomb_tablet_setup() {
  level.wolf_bomb_tablet = getEnt("wolf_bomb_tablet", "targetname");
  level.wolf_bomb_tablet.origin = (-3532.14, 1746.84, -383.878);
  level.wolf_bomb_tablet.angles = (359.574, 136.413, -0.109768);
}

wolf_bomb_tablet_pickup() {
  level.wolf_bomb_tablet.origin = level.farah gettagorigin("tag_accessory_left");
  level.wolf_bomb_tablet.angles = level.farah gettagangles("tag_accessory_left");
  level.wolf_bomb_tablet linkTo(level.farah, "tag_accessory_left");
}

wolf_bomb_vest_farah_defuse_enter_anim_loop(var_0) {
  level.wolf_vest.control endon("player_left");
  level endon("wolf_bomb_vest_defuse_enter_anim_loop");
  level endon("wolf_vest_defuse_failed");

  if(scripts\engine\utility::flag("wolfdeath_player_defuse_interacted")) {
    return;
  }
  var_1 = 0;
  var_2 = [];
  var_2[0] = "dx_vom_far_wolf_death_64";

  for(;;) {
    if(var_1 > var_2.size - 1)
      var_1 = 0;

    level.farah thread scripts\engine\sp\utility::smart_dialogue(var_2[var_1]);
    var_1++;
    var_0 scripts\common\anim::anim_single_solo(level.farah, "death_diffuse_enter_nag");
    var_0 thread scripts\common\anim::anim_loop_solo(level.farah, "death_diffuse_enter_idle", "death_diffuse_enter_loop_stop");
    wait(randomfloatrange(3.25, 4));
    var_0 notify("death_diffuse_enter_loop_stop");
  }
}

wolf_bomb_vest_defuse_anim() {
  var_0 = spawn("script_model", level.player.origin + (0, 0, -300));
  var_0 setModel("body_hero_farah_nobraids");
  level.player modifybasefov(level.fov_wolf_bomb_defuse, 0.5);
  level.player lerpfovscalefactor(0, 0.5);
  var_1 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var_2 = 5;
  var_1 scripts\sp\player_rig::link_player_to_rig("death_diffuse_enter", undefined, 1, 0.5, undefined, var_2, var_2, var_2, var_2, 1);
  level.player_rig hide();
  var_1 scripts\common\anim::anim_single_solo(level.player_rig, "death_diffuse_enter");
  level.player_rig show();
  thread fade_farah_glowstick();

  if(!scripts\engine\utility::flag("wolfdeath_farah_defuse_ready_tele")) {
    var_1 thread scripts\common\anim::anim_loop_solo(level.player_rig, "death_diffuse_enter_idle", "death_diffuse_enter_idle_stop");
    level.farah scripts\engine\sp\utility::anim_stopanimScripted();
    var_1 notify("death_diffuse_enter_loop_stop");
    level notify("wolf_bomb_vest_defuse_enter_anim_loop");
    level notify("wolfdeath_farah_teleport");
    var_1 thread scripts\common\anim::anim_single_solo(level.farah, "death_diffuse_enter");
    waitframe();
    level.farah setanimtime(level.farah scripts\engine\utility::getanim("death_diffuse_enter"), 0.39);
    level.farah waittillmatch("single anim", "tablet_pickup");
    wolf_bomb_tablet_pickup();
    level.farah waittillmatch("single anim", "end");
    var_1 notify("death_diffuse_enter_idle_stop");
    scripts\engine\utility::flag_set("wolfdeath_farah_defuse_ready");
  } else {
    scripts\engine\utility::flag_wait("wolfdeath_farah_defuse_ready");
    level.farah scripts\engine\sp\utility::anim_stopanimScripted();
    var_1 notify("death_diffuse_enter_loop_stop");
    level notify("wolf_bomb_vest_defuse_enter_anim_loop");
  }

  level.wolf_vest notify("timer_start");
  thread scripts\engine\sp\utility::autosave_now();
  crosshair_overlay_dot(1);
  level.wolf scripts\engine\sp\utility::anim_stopanimScripted();
  thread player_defuse_anim(var_1);
  thread wolf_defuse_anim(var_1);
  farah_nobraids_body_swap();
  var_1 scripts\common\anim::anim_single_solo(level.farah, "death_diffuse");
  thread farah_defuse_anim(var_1);
  var_0 delete();
  level.player notify("ready_to_defuse");
  var_3 = level scripts\engine\utility::waittill_any_return("wolf_vest_defused", "wolf_vest_defuse_failed");
  crosshair_overlay_dot(0);

  if(!isDefined(var_3) || var_3 == "wolf_vest_defuse_failed")
    return;
  else {
    scripts\engine\utility::flag_wait("wolfdeath_defuse_done");
    level.player_rig scripts\engine\sp\utility::anim_stopanimScripted();
    level.farah scripts\engine\sp\utility::anim_stopanimScripted();
    thread cine_dof();
    thread wolf_post_defuse_alex_farah_vo();
    thread cine_bars_clamp();
    var_1 thread scripts\common\anim::anim_single([level.player_rig, level.farah], "death_end");
    thread wolf_dies_in_last_frame(var_1);
    level.player_rig waittillmatch("single anim", "end");
    scripts\sp\player_rig::unlink_player_from_rig();
    level.player modifybasefov(level.fov_mine, 0.25);
  }
}

farah_nobraids_body_swap() {
  level.farah.original_body_model = level.farah.model;
  level.farah setModel("body_hero_farah_nobraids");
}

fade_farah_glowstick() {
  playFXOnTag(level._effect[level.farah.glowstick_fade_vfx], level.farah.glowstick, "tag_fx");
  stopFXOnTag(level._effect[level.farah.glowstick_vfx], level.farah.glowstick, "tag_fx");
}

vest_intro_vo(var_0) {}

player_defuse_anim(var_0) {
  setmusicstate("mx_zd30_wolf_diffuse");
  scripts\engine\utility::delaythread(2, ::player_view_lerp_clamp, 25);
  var_0 scripts\common\anim::anim_single_solo(level.player_rig, "death_diffuse");
  var_0 scripts\common\anim::anim_last_frame_solo(level.player_rig, "death_diffuse");
}

player_view_lerp_clamp(var_0) {
  level.player lerpviewangleclamp(1.25, 0.5, 0, var_0, var_0, var_0, var_0);
}

wolf_defuse_anim(var_0) {
  var_0 scripts\common\anim::anim_single_solo(level.wolf, "death_diffuse");
  var_0 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_diffuse");
}

farah_defuse_anim(var_0) {
  level endon("wolf_vest_defuse_failed");
  var_0 do_defuse_anim("death_diffuse_green", self.green_wire, "wolfdeath_defuse_green", 1);
  var_0 do_defuse_anim("death_diffuse_yellow", self.yellow_wire, "wolfdeath_defuse_yellow", 2);
  var_0 do_defuse_anim("death_diffuse_red", self.red_wire_upper, "wolfdeath_defuse_red", 3);
  scripts\engine\utility::flag_set("wolfdeath_defuse_done");
}

do_defuse_anim(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::get_notetrack_time(level.farah scripts\engine\utility::getanim(var_0), "farah_says_cut_wire") * 1000;
  var_5 = 1000;
  level.vest_required_wire = var_1;
  level.vest_required_start_time = gettime() + var_4;
  level.vest_required_end_time = level.vest_required_start_time + var_5;
  scripts\engine\utility::flag_set(var_2);
  thread fail_cut(var_4 + var_5);
  thread confirm_cut(var_4);
  scripts\common\anim::anim_single_solo(level.farah, var_0);
}

fail_cut(var_0) {
  level.player endon("wire_cut");
  wait(var_0 / 1000);
  level.wolf_vest wolf_vest_defuse_failed(1);
}

confirm_cut(var_0) {
  level endon("wolf_vest_defuse_failed");
  wait(var_0 / 1000);
  level.player waittill("wire_cut");

  switch (level.defuse_count) {
    case 0:
      level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_wolf_death_90");
      break;
    case 1:
      level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_wolf_death_110");
      break;
    case 2:
      level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_wolf_death_175");
      break;
    default:
      break;
  }
}

wolf_post_defuse_alex_farah_vo() {
  level waittill("jackpot_line_start");
  scripts\engine\utility::flag_set("bomb_vest_scene_finished");
  wait 0.5;
  level.player scripts\engine\utility::delaycall(1.0, ::setclienttriggeraudiozone, "fade_to_black_minus_scripted5_music_and_dx", 10.0);
  thread scripts\sp\hud_util::fade_out(2, "black");
  thread scripts\sp\analytics::analytics_kleenex_update("Wolf to Exfil");
  wait 6;
  level.farah.anim_playvo_func = undefined;
  level notify("mission_over");
  scripts\engine\sp\utility::nextmission();
}

cine_bars_clamp() {
  level.player springcamenabled(0, 1, 1);
  level.player lerpviewangleclamp(2, 0.5, 0.5, 30, 30, 30, 30);
  level.player setcinematicmotionoverride("disabled");
  wait 9.5;
  setsaveddvar("NOOPLKSRQT", 2.35);
  hidecinematicletterboxing(2, 0);
  level.player lerpviewangleclamp(2, 0.5, 0.5, 0, 0, 0, 0);
  wait 5.5;
  level.player springcamdisabled(0);
}

cine_dof() {
  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(2.0, 1000, undefined, undefined, "tag_eye");
  wait 15;
  scripts\engine\sp\utility::dof_disable();
}

wolf_dies_in_last_frame(var_0) {
  level.wolf waittillmatch("single anim", "end");
  var_0 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_end");
}

detect_player_leaving_after_wolf_death() {
  var_0 = 500;

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(level.wolf_vest.origin, level.player.origin) > var_0 * var_0) {
      while(isDefined(level.wolf) && isDefined(level.wolf_vest) && isDefined(level.wolf_vest.control)) {
        level.wolf_vest.control notify("player_left");
        wait 0.2;
      }
    }

    wait 0.1;
  }
}

wolf_vest_defuse_failed(var_0, var_1) {
  level notify("wolf_vest_defuse_failed");
  scripts\sp\utility::notetrack_vo_disable();

  if(isDefined(level.player_rig))
    level.player_rig stopsounds();

  if(!istrue(var_1)) {
    if(istrue(self.defuse_failed)) {
      return;
    }
    self.defuse_failed = 1;
    wait 0.25;

    if(istrue(var_0))
      level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_basement_tunnel_leftpath_30", 1, 0.25);

    wait 0.25;
  }

  level.farah stopsounds();
  level.wolf stopsounds();
  crosshair_overlay_dot(0);
  wolf_tunnel_explode();
}

wolf_tunnel_explode() {
  var_0 = scripts\engine\utility::getStruct("wolf_tunnel_exp_struct", "targetname");
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  thread wolf_room_barrels_explode(0.05);
  scripts\engine\utility::exploder("wolf_fail");
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_trans", var_1);
  wait 0.25;
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_fireball_front", var_1);
  level.wolf_tunnel_fire_trig.script_multiplier = 10;
  level.wolf_tunnel_fire_trig thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::supplementary_fire_damage();
  level.wolf_tunnel_fire_trig scripts\engine\utility::delaythread(0.25, scripts\engine\utility::trigger_on);
  wait 1;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_burn_death_overlay(0.35);
  level.player playSound("scn_zd30_collapse_lr_02");
  wait 1;
  level.player kill();
}

wolf_room_barrels_explode(var_0) {
  var_1 = getEnt("wolf_room_trig", "targetname");
  var_2 = [];

  foreach(var_4 in level.spewing_barrels) {
    if(isDefined(var_4) && var_4 istouching(var_1))
      var_2[var_2.size] = var_4;
  }

  if(isDefined(var_0))
    wait(var_0);

  var_2 = sortbydistance(var_2, level.player.origin);
  var_6 = 3;
  var_7 = int(min(var_6, var_2.size));

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_2[var_8] thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::detonate_spewing_barrel();
    wait(randomfloatrange(0.15, 0.3));
  }
}

debug_tag_accessory(var_0) {
  level endon("wolf_vest_defused_and_player_unlinked");

  while(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug()) {
    var_1 = level.farah gettagangles(var_0);
    var_2 = level.farah gettagorigin(var_0);
    scripts\engine\utility::draw_angles(var_1, var_2, (1, 1, 1), 1, 1);
    level.farah_tag_acc_org = var_2;
    level.farah_tag_acc_ang = var_1;
    wait 0.05;
  }
}

crosshair_overlay_dot(var_0) {
  if(var_0) {
    var_1 = newhudelem();
    var_1.alignx = "center";
    var_1.aligny = "middle";
    var_1.foreground = 1;
    var_1.hidewheninmenu = 1;
    var_1.sort = 1;
    var_1.alpha = 1;
    var_1.x = 322;
    var_1.y = 237;
    var_1 setshader("reticle_center_dot", 32, 32);
    level.player.crosshair_overlay = var_1;
  } else if(isDefined(level.player.crosshair_overlay))
    level.player.crosshair_overlay destroy();
}

vest_timer_countdown() {
  level endon("wolf_vest_defuse_failed");
  level endon("wolf_vest_defused");
  self endon("entitydeleted");
  self endon("death");
  thread beeper_loop();
  self waittill("timer_start");
  thread start_phone_countdown();
  var_0 = 0.1;
  var_1 = 26.2;
  var_2 = int(var_0 * 20);

  for(;;) {
    var_1 = var_1 - var_0;

    if(var_1 < 0)
      var_1 = 0;

    var_3 = (1, 1, 0);

    if(var_1 < 23.2)
      var_3 = (1, 0.5, 0);

    if(var_1 < 20.2)
      var_3 = (1, 0, 0);

    wait(var_0);

    if(istrue(level.wolf_vest.defused))
      return;
  }
}

start_phone_countdown() {
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame("sp_tunnels_vest_timer");
}

beeper_loop() {
  self endon("entitydeleted");
  self endon("death");
  scripts\engine\utility::flag_wait("wolfdoor_open");
  var_0 = 1.19048;

  for(;;) {
    self playSound("bomb_beep");
    wait(var_0);

    if(istrue(self.defused) || istrue(self.defuse_failed))
      return;
  }
}

setup_wire(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_3.wire_type = var_2;
  var_3.color_index = var_1;
  var_3.interacts = getEntArray(var_3.target, "targetname");
  var_3.cut = getEnt(var_0 + "_cut", "targetname");
  var_3.cut linkTo(self);
  var_3.cut hide();
  var_3.cut_alt = getEnt(var_0 + "_cut_alt", "targetname");

  if(isDefined(var_3.cut_alt)) {
    var_3.cut_alt linkTo(self);
    var_3.cut_alt hide();
  }

  foreach(var_5 in var_3.interacts)
  var_5 linkTo(var_3);

  var_3 linkTo(self);
  var_3 thread wire_cut_button_press_watch();
  return var_3;
}

wire_cut_button_press_watch() {
  level endon("wolf_vest_defuse_failed");
  level endon("wolf_vest_defused");
  self endon("entitydeleted");

  for(;;) {
    level.player waittill("wire_cut_button_press");
    var_0 = get_closest_look_at_interact();

    if(!isDefined(level.looking_at_wire) || level.looking_at_wire != self) {
      waitframe();
      continue;
    }

    level.player notify("wire_cut", gettime(), self);

    if(var_0.script_noteworthy == "cursor_alt")
      self.cut_alt show();
    else
      self.cut show();

    self playSound("scn_tunnels_wolf_wire_cut");
    self hide();
    self.is_cut = 1;
    return;
  }
}

wire_look_at_think() {
  level endon("wolf_vest_defuse_failed");
  level endon("wolf_vest_defused");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("wolfdeath_farah_defuse_ready");
  wait 2.5;
  thread wire_look_at_hint();

  while(!istrue(level.wolf_vest.defused)) {
    var_0 = get_closest_look_at_interact();
    var_1 = get_wire_from_interact(var_0);
    wire_outline_active_and_waittill_not(var_1, var_0);
    wait 0.05;
  }
}

wire_look_at_hint() {
  wait 2;

  if(!scripts\engine\utility::flag("wolfdeath_defuse_looked_at_green_wire")) {
    if(level.player usinggamepad())
      scripts\engine\sp\utility::display_hint("wolf_defuse_hint");
    else
      scripts\engine\sp\utility::display_hint("wolf_defuse_hint_kbm");
  }
}

wolf_bomb_vest_defuse_looked_at_any_wire() {
  return scripts\engine\utility::flag("wolfdeath_defuse_looked_at_green_wire");
}

wire_outline_active_and_waittill_not(var_0, var_1) {
  var_2 = "outline_depth_red";

  switch (var_0.color_index) {
    case 2:
      scripts\engine\utility::flag_set("wolfdeath_defuse_looked_at_green_wire");
      var_2 = "outline_depth_green";
      break;
    case 1:
      var_2 = "outline_depth_red";
      break;
    case 4:
      var_2 = "outline_depth_yellow";
      break;
    case 0:
      var_2 = "outline_depth_cyan";
      break;
  }

  var_0 thread scripts\engine\sp\utility::hudoutline_enable_new(var_2);
  level.looking_at_wire = var_0;
  var_3 = get_wire_cut_hint(var_0.wire_type);
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint_forced("tag_origin", (0, 0, 0), var_3, 60, 60, 60, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 10);

  while(is_player_looking_at_interact(var_1) && !istrue(var_0.is_cut) && !istrue(level.wolf_vest.defused))
    wait 0.05;

  var_1 scripts\sp\player\cursor_hint::remove_cursor_hint();
  var_0 thread scripts\engine\sp\utility::hudoutline_disable();
  level.looking_at_wire = undefined;
}

is_player_looking_at_interact(var_0) {
  var_1 = get_closest_look_at_interact();

  if(!isDefined(var_1) || var_0 != var_1)
    return 0;

  return 1;
}

get_wire_from_interact(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.wolf_vest.wires) {
    if(scripts\engine\utility::array_contains(var_3.interacts, var_0))
      var_1 = var_3;
  }

  return var_1;
}

get_closest_look_at_interact() {
  var_0 = getEntArray("cursor", "script_noteworthy");
  var_1 = getEntArray("cursor_alt", "script_noteworthy");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = vectorNormalize(anglesToForward(level.player getplayerangles()));
  var_4 = var_2[0];

  foreach(var_6 in var_2) {
    if(var_4 == var_6) {
      continue;
    }
    var_7 = vectorNormalize(var_6.origin - level.player getEye());
    var_8 = vectorNormalize(var_4.origin - level.player getEye());
    var_9 = vectordot(var_3, var_7);
    var_10 = vectordot(var_3, var_8);

    if(var_9 > var_10)
      var_4 = var_6;
  }

  return var_4;
}

get_wire_cut_hint(var_0) {
  if(var_0 == "red")
    return &"ZD30/DEFUSE_RED";
  else if(var_0 == "green")
    return &"ZD30/DEFUSE_GREEN";
  else if(var_0 == "yellow")
    return &"ZD30/DEFUSE_YELLOW";
  else if(var_0 == "blue")
    return &"ZD30/DEFUSE_BLUE";
  else
    return "";
}

wolf_vest_led_flash_think(var_0) {
  self endon("entitydeleted");
  self endon("death");
  var_1 = 1.5;
  var_2 = "on";

  while(!istrue(var_0.defuse_failed)) {
    self setscriptablepartstate("onoff", var_2);

    if(var_2 == "on")
      var_2 = "off";
    else
      var_2 = "on";

    if(istrue(var_0.defused)) {
      self setscriptablepartstate("onoff", "on");
      return;
    }

    var_3 = var_1 / (level.defuse_count + 1);

    while(var_3 > 0) {
      if(istrue(var_0.defuse_failed)) {
        break;
      }

      var_3 = var_3 - 0.05;
      wait 0.05;
    }
  }

  self setscriptablepartstate("onoff", "off_blink");
}