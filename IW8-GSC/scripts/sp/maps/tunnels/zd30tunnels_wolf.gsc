/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\zd30tunnels_wolf.gsc
********************************************************/

function wolf_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::set_start_location("wolf", [level.player]);
  thread wolf_start_setup_farah();
}

function wolf_start_setup_farah() {
  wait 0.25;
  var0 = getnode("wolf_tunnel_node_1", "targetname");
  level.farah forceteleport(var0.origin, var0.angles);
  wait 0.05;
  level.farah.ignoreall = 0;
  level.farah.ignoreme = 0;
  level.farah scripts\common\utility::demeanor_override("combat");
  level.farah scripts\engine\sp\utility::enable_ai_color();
  level.farah thread scripts\sp\spawner::go_to_node(var0);
}

function wolf_catchup() {
  scripts\engine\utility::flag_set("wolf_killed");
}

function wolf() {
  scripts\sp\utility::notetrack_mission_failed_vo_disable();
  var0 = getEnt("wolf_obj_trig", "targetname");
  thread wolf_objective();
  level.wolf = scripts\engine\sp\utility::spawn_targetname("wolfSpawner", 1);
  level.wolf.animname = "wolf";
  level.wolf.ignoreall = 1;
  level.wolf.ignoreme = 1;
  level.wolf.noragdoll = 1;
  level.wolf.team = "axis";
  thread update_wolf_face_position();
  level.wolf scripts\common\ai::magic_bullet_shield();
  level.wolf scripts\sp\utility::context_melee_allow(0);
  level.wolf scripts\common\ai::gun_remove();
  thread wolf_tunnel_farah_movement_and_vo();
  thread wolf_tunnel_first_frame();
  thread wolf_bomb_vest();
  thread wolf_scene_door();
  scripts\engine\utility::flag_wait("wolf_door_unlocked");
  scripts\engine\utility::flag_wait("wolfdoor_open");
  level.farah.anim_playvo_func = &scripts\engine\utility::playsoundontag;
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

function wolf_objective() {
  wait 0.25;
  scripts\engine\sp\objectives::objective_remove("tunnels_search");
  var0 = level.wolf getEye() + (0, 0, 10);
  scripts\engine\sp\objectives::objective_add("Wolf", "current", var0, &"ZD30/OBJ_TUNNELS_WOLF");
  self waittill("trigger");
  thread mus_get_to_wolf();
  scripts\engine\utility::flag_wait("wolf_killed");
  scripts\engine\sp\objectives::objective_remove("Wolf");
  var0 = level.wolf_vest.control.origin + (0, 0, 6);
  scripts\engine\sp\objectives::objective_add("Bomb", "current", var0, &"ZD30/OBJ_TUNNELS_BOMB");
  level waittill("wolf_vest_defused");
  scripts\engine\sp\objectives::objective_remove("Bomb");
}

function mus_get_to_wolf() {
  setmusicstate("mx_zd30_wolf_bunker_intro");
}

function mus_wolf_killed() {
  setmusicstate("mx_zd30_wolf_dead");
}

function update_wolf_face_position() {
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

function wolf_tunnel_first_frame() {
  var0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var0 thread scripts\common\anim::anim_first_frame_solo(level.wolf, "death_intro");
}

function wolf_tunnel_farah_movement_and_vo() {
  level endon("wolfdoor_open");
  level.farah notify("disable_bump_management");
  level.farah.script_pushable = 1;
  level.farah pushplayer(0);
  GscBinSkip4(0x35);
}

function wolf_tunnel_approach_vo() {
  level endon("wolfdoor_open");
  thread stop_wolf_pa_on_death();
  wait 1.2;
  thread say_wolf_line(level.wolf, "dx_vom_wolf_wolf_death_10");
  level.farah waittill("goal_changed");
  wait 1.5;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_far_wolf_death_12");
  scripts\engine\utility::flag_wait("wolf_door_unlocked");
  say_wolf_line(level.wolf, "dx_vom_wolf_wolf_death_20", "dx_vom_wolf_wolf_death_21");
  say_wolf_line(level.wolf, "dx_vom_wolf_wolf_death_30", "dx_vom_wolf_wolf_death_31");
}

function stop_wolf_pa_on_death() {
  level.wolf waittill("damage");
  wait 0.25;

  if(isDefined(level.wolf_speaker)) {
    level.wolf_speaker stopsounds();
    return;
  }
}

function say_wolf_line(var0, var1) {
  if(!isDefined(var1)) {
    var1 = var0;
  }

  level.wolf_speaker = scripts\sp\maps\tunnels\zd30tunnels_mineshaft::get_closest_speaker();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::say(var0);
  wait 0.25;
  level.wolf_speaker scripts\sp\maps\tunnels\zd30tunnels_utility::say(var1);
}

function wolf_outside_room_farah_nag(var0, var1) {
  level endon(var1);
  var2 = 0;
  var3 = [];
  GscBinSkip0(0x2e, 0, "dx_vom_far_wolf_death_13");
}

function wolf_scene_door() {
  var0 = getEnt("wolfdoor_unlock", "targetname");
  var0 waittill("trigger");
  thread scripts\sp\analytics::analytics_kleenex_update("Shaft to Wolf");
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = getEntArray("wolfdoor", "targetname");

  foreach(var6 in var4) {
    if(!isDefined(var6) || !isDefined(var6.classname)) {
      continue;
    }

    if(var6.classname == "script_model") {
      var1 = var6;
    }

    if(var6.classname == "script_brushmodel") {
      var2 = var6;
    }

    if(isDefined(var6.script_noteworthy) && var6.script_noteworthy == "handle") {
      var3 = var6;
    }
  }

  var8 = scripts\engine\utility::getStruct(var2.target, "targetname");
  var9 = scripts\engine\utility::getStruct(var8.target, "targetname");
  var10 = scripts\engine\utility::getStruct(var9.target, "targetname");
  var3 linkTo(var2);
  var1 linkTo(var2);
  var11 = anglesdelta(var8.angles, var9.angles);
  var2 rotateYaw(var11, 1, 0.1, 0.55);
  scripts\engine\utility::flag_set("wolf_door_unlocked");
  var12 = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
  var3 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var12, 45, 200 * level.interactive_doors.hint_dist_scale, 55 * level.interactive_doors.hint_dist_scale, 0);
  thread set_wolfdoor_open_flag_on_trigger();
  scripts\engine\utility::flag_wait("wolfdoor_open");
  var3 playSound("scrpt_door_metal_heavy_open_soft");
  var3 thread scripts\sp\player\cursor_hint::remove_cursor_hint();
  thread wolf_death_player_cleared_door();
  var1 thread scripts\engine\utility::play_loop_sound_on_entity("scrpt_door_metal_heavy_creak_lp");
  var11 = anglesdelta(var9.angles, var10.angles);
  var2 rotateYaw(var11, 1.5, 0.1, 0.5);
  var2 connectpaths();
  wait 1.5;
  var1 notify("stop soundscrpt_door_metal_heavy_creak_lp");
}

function set_wolfdoor_open_flag_on_trigger() {
  scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "trigger");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "wolfdoor_open");
  scripts\engine\sp\utility::do_wait_any();

  if(scripts\engine\utility::flag("wolfdoor_open")) {
    return;
  } else {
    waitframe();
  }

  scripts\engine\utility::flag_set("wolfdoor_open");
}

function wolf_death_player_cleared_door() {
  var0 = getEnt("wolf_room_door_clear_trig", "targetname");

  while(level.player istouching(var0)) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("wolfdeath_player_cleared_door");
}

function wolf_death_farah_points_out_vest_vo() {
  wait 2.6;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_wolf_death_40");
}

function wolf_death_detect_player_escapes_wolf() {
  level.player endon("ready_to_defuse");
  var0 = getEnt("safe_room_exit_trig", "targetname");
  var0 waittill("trigger");
  scripts\engine\utility::flag_set("wolfdeath_player_escaped");
  wolf_vest_defuse_failed(level.wolf_vest);
}

function wolf_death_detect_player_shoots_next_to_wolf() {
  level endon("wolf_killed");
  level endon("wolfdeath_player_escaped");
  level endon("wolfdeath_player_too_close");
  var0 = 0.6;

  for(;;) {
    level.player scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire", "offhand_fired");
    wait 0.15;

    if(!scripts\engine\utility::flag("wolf_killed") && scripts\engine\sp\utility::player_looking_at(level.wolf getEye(), var0, 1, level.wolf)) {
      scripts\engine\utility::flag_set("wolfdeath_player_shoots_around");
      return;
    }
  }
}

function wolf_death_detect_player_too_close_to_wolf() {
  level endon("wolf_killed");
  level endon("wolfdeath_player_escaped");
  level endon("wolfdeath_player_shoots_around");
  var0 = 64;
  var1 = spawn("trigger_radius", level.wolf.origin, 0, var0, 256);

  for(;;) {
    var1 waittill("trigger", var2);

    if(isPlayer(var2)) {
      var1 delete();
      break;
    }
  }

  scripts\engine\utility::flag_set("wolfdeath_player_too_close");
}

function wolf_death_detect_player_shoot_vest() {
  level endon("wolfdeath_player_defuse_interacted");

  for(;;) {
    level.wolf waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7);

    if(!isDefined(var1) || !isPlayer(var1) || !isDefined(var4) || !isDefined(var7)) {
      continue;
    }

    if(var4 != "MOD_PISTOL_BULLET" && var4 != "MOD_RIFLE_BULLET" && var4 != "MOD_MELEE" && var4 != "MOD_IMPACT") {
      continue;
    }

    if(scripts\engine\utility::hastag(level.wolf.model, var7) && var7 == "j_spinelower" || var4 == "MOD_IMPACT") {
      wolf_death_fail_due_to_damage();
      return;
    }
  }
}

function wolf_death_detect_player_wolf_kill() {
  level endon("wolfdeath_player_escaped");

  for(;;) {
    level.wolf waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7);

    if(isDefined(var1) && (isPlayer(var1) || var1 == level.farah)) {
      if(isPlayer(var1)) {
        scripts\engine\utility::flag_set("wolfdeath_player_shoots_wolf");
      } else {
        scripts\engine\utility::flag_set("wolfdeath_farah_shoots_wolf");
      }

      level.wolf stopsounds();

      if(isDefined(var4) && var4 == "MOD_MELEE") {
        level.wolf playSound("generic_pain_enemy_1");
      }

      break;
    }
  }

  level.wolf.team = "neutral";
  level.wolf.no_friendly_fire_fail = 1;
  scripts\engine\utility::flag_set("wolf_killed");
  var8 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var8 scripts\common\anim::anim_single_solo(level.wolf, "death_kill");
  var8 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_kill");
}

function wolf_death_fail_due_to_damage() {
  if(!isDefined(level.farah) || !isDefined(level.wolf_vest)) {
    return;
  }

  var0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var0 notify("stop_loop");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  wolf_vest_defuse_failed(level.wolf_vest, undefined, 1);
}

function wolf_death_detect_molotov_wolf_kill() {
  for(;;) {
    level waittill("molotov_fire_trigger", var0);

    if(level.wolf istouching(var0)) {
      scripts\engine\utility::flag_set("wolfdeath_player_shoots_wolf");
      level.wolf stopsounds();
      level.wolf playSound("generic_pain_enemy_1");
      break;
    }

    var1 = spawn("script_origin", var0.origin);
    var2 = getEnt("wolf_room_trig", "targetname");

    if(var1 istouching(var2)) {
      wait 0.05;
      var1 delete();
      break;
    }

    wait 0.05;
  }

  var3 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var3 notify("stop_loop");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  wait 1;
  wolf_vest_defuse_failed(level.wolf_vest);
}

function wolf_death_intro() {
  level endon("wolfdeath_player_shoots_wolf");
  var0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var0 notify("death_intro_enter_idle_stop");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  thread wolf_death_intro_wolf_monologue(var0);
  thread wolf_death_intro_farah_anim(var0);
  scripts\engine\utility::flag_wait("wolfdeath_farah_shoot");
  level.wolf scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittillmatch_any_return, "single anim", "start_farah_kill");
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait_any, "wolfdeath_player_too_close", "wolfdeath_player_shoots_around");
  scripts\engine\sp\utility::do_wait_any();
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_wolf_death_57");
  level.farah shoot(1, level.wolf getEye());
  level.wolf notify("damage", 10, level.farah);
  wait 0.5;
}

function wolf_death_intro_wolf_monologue(var0) {
  level endon("wolf_killed");
  level thread scripts\engine\utility::flag_set_delayed("wolfdeath_timer_low", 8);
  var0 scripts\common\anim::anim_single_solo(level.wolf, "death_intro");
  var0 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_intro");
}

function wolf_death_intro_farah_anim(var0) {
  level endon("wolfdeath_player_defuse_interacted");
  scripts\engine\utility::flag_wait_any("wolfdeath_timer_low", "wolfdeath_player_cleared_door", "wolfdeath_player_shoots_wolf", "wolfdeath_player_too_close", "wolfdeath_player_shoots_around");
  var0 scripts\sp\anim::anim_reach_solo(level.farah, "death_intro");
  level.farah scripts\engine\sp\utility::disable_dynamic_run_speed();
  scripts\engine\utility::delaythread(1.9, &scripts\engine\utility::flag_set, "wolfdeath_farah_shoot");
  var0 scripts\common\anim::anim_single_solo(level.farah, "death_intro");
  var0 thread scripts\common\anim::anim_loop_solo(level.farah, "death_intro_idle", "death_intro_idle_stop");
  waitframe();
  scripts\engine\utility::flag_set("wolfdeath_farah_in_position");
}

function wolf_bomb_vest() {
  level.looking_at_wire = undefined;
  level.vest_required_wire = undefined;
  level.defuse_count = 0;
  var0 = "j_chest";
  var1 = level.wolf gettagorigin("j_chest");
  var2 = level.wolf gettagangles("j_chest");
  var3 = getEnt("wolf_vest_new2", "targetname");
  var3.control = getEnt("wolf_vest_control", "targetname");
  var3.control linkTo(var3);
  thread vest_timer_countdown();
  waitframe();
  var3.red_wire_upper = setup_wire(var3, "red_wire_upper", 1, "red");
  var3.red_wire_lower = setup_wire(var3, "red_wire_lower", 1, "red");
  var3.yellow_wire = setup_wire(var3, "yellow_wire", 4, "yellow");
  var3.green_wire = setup_wire(var3, "green_wire", 2, "green");
  var3.blue_wire = setup_wire(var3, "blue_wire", 0, "blue");
  var3.wires = [var3.red_wire_upper, var3.red_wire_lower, var3.yellow_wire, var3.green_wire, var3.blue_wire];
  var4 = (-19.1, -1.65, -0.05);
  var5 = (90, 0, -2);
  var3 linkTo(level.wolf, var0, var4, var5);
  level.wolf_vest = var3;
  level.wolf_vest hide();
  thread wolf_bomb_clacker_setup();
  wolf_bomb_tablet_setup();
  thread wolf_bomb_vest_think();
}

function debug_vest_pos_ang() {
  for(;;) {
    wait 0.25;
    self unlink();
    var0 = (getdvarfloat("zd_x"), getdvarfloat("zd_y"), getdvarfloat("zd_z"));
    var1 = (getdvarfloat("zd_pitch"), getdvarfloat("zd_yaw"), getdvarfloat("zd_roll"));
    self linkTo(level.wolf, "j_chest", var0, var1);
  }
}

function wolf_bomb_clacker_setup() {
  level.wolf_clacker = spawn("script_model", level.wolf gettagorigin("tag_accessory_right"));
  level.wolf_clacker setModel("offhand_wm_clacker");
  level.wolf_clacker.angles = level.wolf gettagangles("tag_accessory_right");
  level.wolf_clacker linkTo(level.wolf, "tag_accessory_right");
}

function wolf_bomb_vest_think() {
  scripts\engine\utility::flag_wait("wolf_killed");
  thread detect_player_leaving_after_wolf_death();
  thread wolf_bomb_vest_farah_defuse_enter_anim();
  thread timeout_explode();
  var0 = &"ZD30/DEFUSE";
  level.wolf_vest.control scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var0, 90, 128, 52, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 25);
  level.wolf_vest.control waittill("trigger");
  scripts\engine\utility::flag_set("wolfdeath_player_defuse_interacted");
  thread cleanup_enemies_for_wolf_defuse();
  scripts\sp\player_death::clear_custom_death_quote();
  level.wolf_vest.control scripts\sp\player\cursor_hint::remove_cursor_hint();
  thread wolf_bomb_vest_defuse_anim();
  thread wire_look_at_think();
  thread wolf_bomb_vest_defuse_dof();
  level.player waittill("ready_to_defuse");
  level.player notifyonplayercommand("wire_cut_button_press", "+usereload");
  level.player notifyonplayercommand("wire_cut_button_press", "+activate");
  var1 = 3;

  while(level.defuse_count < var1) {
    level.player waittill("wire_cut", var2, var3);

    if(!isDefined(level.looking_at_wire) || !isDefined(level.vest_required_wire) || level.vest_required_wire != var3 || var2 < level.vest_required_start_time || var2 > level.vest_required_end_time) {
      wolf_vest_defuse_failed(level.wolf_vest, 1);
      return;
    } else {
      level.defuse_count++;
    }

    waitframe();
  }

  level.wolf_vest.defused = 1;
  wait 1.5;
  level notify("wolf_vest_defused");
}

function wolf_bomb_vest_defuse_dof() {
  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof on bomb vest");
  }

  level.player enablephysicaldepthoffieldscripting(1);
  level.player setphysicaldepthoffield(2.8, 20, 1, 2);
  level waittill("wolf_vest_defused");
  wait 0.25;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof off");
    return;
  }
}

function cleanup_enemies_for_wolf_defuse() {
  var0 = getaiarray("axis");

  for(;;) {
    foreach(var2 in var0) {
      if(!isDefined(var2)) {
        continue;
      }

      if(var2 == level.wolf) {
        continue;
      }

      var3 = distance(level.player.origin, var2.origin);
      var2.ignoreme = 1;
      var2.ignoreall = 1;

      if(var3 < 500 || var2 cansee(level.player)) {
        if(isalive(var2)) {
          var2 kill();
        }

        wait 0.25;

        if(isDefined(var2)) {
          var2 delete();
        }
      }
    }

    clearallcorpses();
    wait 2;
  }
}

function timeout_explode() {
  level endon("wolfdeath_player_defuse_interacted");
  scripts\engine\utility::flag_wait("wolfdeath_farah_defuse_ready");
  wait 6;
  thread wolf_vest_defuse_failed();
}

function wolf_bomb_vest_farah_defuse_enter_anim() {
  level endon("wolfdeath_player_escaped");
  level endon("wolfdeath_farah_teleport");
  level.wolf_vest.control endon("player_left");
  var0 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  scripts\engine\utility::flag_wait("wolfdeath_farah_in_position");
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  var0 notify("death_intro_idle_stop");
  level.farah scripts\engine\utility::delaythread(1.5, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_far_wolf_death_62");
  level.farah scripts\engine\utility::delaythread(2.85, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_far_wolf_death_63");
  scripts\engine\utility::delaythread(2.3, &scripts\engine\utility::flag_set, "wolfdeath_farah_defuse_ready_tele");
  var0 thread scripts\common\anim::anim_single_solo(level.farah, "death_diffuse_enter");
  level.farah waittillmatch("single anim", "tablet_pickup");
  wolf_bomb_tablet_pickup();
  level.farah waittillmatch("single anim", "end");
  var0 thread scripts\common\anim::anim_last_frame_solo(level.farah, "death_diffuse_enter");
  scripts\engine\utility::flag_set("wolfdeath_farah_defuse_ready");
  thread wolf_bomb_vest_farah_defuse_enter_anim_loop(var0);
}

function wolf_bomb_tablet_setup() {
  level.wolf_bomb_tablet = getEnt("wolf_bomb_tablet", "targetname");
  level.wolf_bomb_tablet.origin = (-3532.14, 1746.84, -383.878);
  level.wolf_bomb_tablet.angles = (359.574, 136.413, -0.109768);
}

function wolf_bomb_tablet_pickup() {
  level.wolf_bomb_tablet.origin = level.farah gettagorigin("tag_accessory_left");
  level.wolf_bomb_tablet.angles = level.farah gettagangles("tag_accessory_left");
  level.wolf_bomb_tablet linkTo(level.farah, "tag_accessory_left");
}

function wolf_bomb_vest_farah_defuse_enter_anim_loop(var0) {
  level.wolf_vest.control endon("player_left");
  level endon("wolf_bomb_vest_defuse_enter_anim_loop");
  level endon("wolf_vest_defuse_failed");

  if(scripts\engine\utility::flag("wolfdeath_player_defuse_interacted")) {
    return;
  }

  var1 = 0;
  var2 = [];
  GscBinSkip0(0x2e, 0, "dx_vom_far_wolf_death_64");
}

function wolf_bomb_vest_defuse_anim() {
  var0 = spawn("script_model", level.player.origin + (0, 0, -300));
  var0 setModel("body_hero_farah_nobraids");
  level.player modifybasefov(level.fov_wolf_bomb_defuse, 0.5);
  level.player lerpfovscalefactor(0, 0.5);
  var1 = scripts\engine\utility::getStruct("wolfdeath", "targetname");
  var2 = 5;
  var1 scripts\sp\player_rig::link_player_to_rig("death_diffuse_enter", undefined, 1, 0.5, undefined, var2, var2, var2, var2, 1);
  level.player_rig hide();
  var1 scripts\common\anim::anim_single_solo(level.player_rig, "death_diffuse_enter");
  level.player_rig show();
  thread fade_farah_glowstick();

  if(!scripts\engine\utility::flag("wolfdeath_farah_defuse_ready_tele")) {
    var1 thread scripts\common\anim::anim_loop_solo(level.player_rig, "death_diffuse_enter_idle", "death_diffuse_enter_idle_stop");
    level.farah scripts\engine\sp\utility::anim_stopanimScripted();
    var1 notify("death_diffuse_enter_loop_stop");
    level notify("wolf_bomb_vest_defuse_enter_anim_loop");
    level notify("wolfdeath_farah_teleport");
    var1 thread scripts\common\anim::anim_single_solo(level.farah, "death_diffuse_enter");
    waitframe();
    level.farah setanimtime(level.farah scripts\engine\utility::getanim("death_diffuse_enter"), 0.39);
    level.farah waittillmatch("single anim", "tablet_pickup");
    wolf_bomb_tablet_pickup();
    level.farah waittillmatch("single anim", "end");
    var1 notify("death_diffuse_enter_idle_stop");
    scripts\engine\utility::flag_set("wolfdeath_farah_defuse_ready");
  } else {
    scripts\engine\utility::flag_wait("wolfdeath_farah_defuse_ready");
    level.farah scripts\engine\sp\utility::anim_stopanimScripted();
    var1 notify("death_diffuse_enter_loop_stop");
    level notify("wolf_bomb_vest_defuse_enter_anim_loop");
  }

  level.wolf_vest notify("timer_start");
  thread scripts\engine\sp\utility::autosave_now();
  crosshair_overlay_dot(1);
  level.wolf scripts\engine\sp\utility::anim_stopanimScripted();
  thread player_defuse_anim(var1);
  thread wolf_defuse_anim(var1);
  farah_nobraids_body_swap();
  var1 scripts\common\anim::anim_single_solo(level.farah, "death_diffuse");
  thread farah_defuse_anim(var1);
  var0 delete();
  level.player notify("ready_to_defuse");
  var3 = level scripts\engine\utility::waittill_any_return("wolf_vest_defused", "wolf_vest_defuse_failed");
  crosshair_overlay_dot(0);

  if(!isDefined(var3) || var3 == "wolf_vest_defuse_failed") {
    return;
  }

  scripts\engine\utility::flag_wait("wolfdeath_defuse_done");
  level.player_rig scripts\engine\sp\utility::anim_stopanimScripted();
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  thread cine_dof();
  thread wolf_post_defuse_alex_farah_vo();
  thread cine_bars_clamp();
  var1 thread scripts\common\anim::anim_single([level.player_rig, level.farah], "death_end");
  thread wolf_dies_in_last_frame(var1);
  level.player_rig waittillmatch("single anim", "end");
  scripts\sp\player_rig::unlink_player_from_rig();
  level.player modifybasefov(level.fov_mine, 0.25);
}

function farah_nobraids_body_swap() {
  level.farah.original_body_model = level.farah.model;
  level.farah setModel("body_hero_farah_nobraids");
}

function fade_farah_glowstick() {
  playFXOnTag(level._effect[level.farah.glowstick_fade_vfx], level.farah.glowstick, "tag_fx");
  stopFXOnTag(level._effect[level.farah.glowstick_vfx], level.farah.glowstick, "tag_fx");
}

function vest_intro_vo(var0) {}

function player_defuse_anim(var0) {
  setmusicstate("mx_zd30_wolf_diffuse");
  scripts\engine\utility::delaythread(2, &player_view_lerp_clamp, 25);
  var0 scripts\common\anim::anim_single_solo(level.player_rig, "death_diffuse");
  var0 scripts\common\anim::anim_last_frame_solo(level.player_rig, "death_diffuse");
}

function player_view_lerp_clamp(var0) {
  level.player lerpviewangleclamp(1.25, 0.5, 0, var0, var0, var0, var0);
}

function wolf_defuse_anim(var0) {
  var0 scripts\common\anim::anim_single_solo(level.wolf, "death_diffuse");
  var0 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_diffuse");
}

function farah_defuse_anim(var0) {
  level endon("wolf_vest_defuse_failed");
  do_defuse_anim(var0, "death_diffuse_green", self.green_wire, "wolfdeath_defuse_green", 1);
  do_defuse_anim(var0, "death_diffuse_yellow", self.yellow_wire, "wolfdeath_defuse_yellow", 2);
  do_defuse_anim(var0, "death_diffuse_red", self.red_wire_upper, "wolfdeath_defuse_red", 3);
  scripts\engine\utility::flag_set("wolfdeath_defuse_done");
}

function do_defuse_anim(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::get_notetrack_time(level.farah scripts\engine\utility::getanim(var0), "farah_says_cut_wire") * 1000;
  var5 = 1000;
  level.vest_required_wire = var1;
  level.vest_required_start_time = gettime() + var4;
  level.vest_required_end_time = level.vest_required_start_time + var5;
  scripts\engine\utility::flag_set(var2);
  thread fail_cut(var4 + var5);
  thread confirm_cut(var4);
  scripts\common\anim::anim_single_solo(level.farah, var0);
}

function fail_cut(var0) {
  level.player endon("wire_cut");
  wait var0 / 1000;
  wolf_vest_defuse_failed(level.wolf_vest, 1);
}

function confirm_cut(var0) {
  level endon("wolf_vest_defuse_failed");
  wait var0 / 1000;
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

function wolf_post_defuse_alex_farah_vo() {
  level waittill("jackpot_line_start");
  scripts\engine\utility::flag_set("bomb_vest_scene_finished");
  wait 0.5;
  level.player scripts\engine\utility::delaycall(1, &setclienttriggeraudiozone, "fade_to_black_minus_scripted5_music_and_dx", 10);
  thread scripts\sp\hud_util::fade_out(2, "black");
  thread scripts\sp\analytics::analytics_kleenex_update("Wolf to Exfil");
  wait 6;
  level.farah.anim_playvo_func = undefined;
  level notify("mission_over");
  scripts\engine\sp\utility::nextmission();
}

function cine_bars_clamp() {
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

function cine_dof() {
  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(2, 1000, undefined, undefined, "tag_eye");
  wait 15;
  scripts\engine\sp\utility::dof_disable();
}

function wolf_dies_in_last_frame(var0) {
  level.wolf waittillmatch("single anim", "end");
  var0 scripts\common\anim::anim_last_frame_solo(level.wolf, "death_end");
}

function detect_player_leaving_after_wolf_death() {
  var0 = 500;

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(level.wolf_vest.origin, level.player.origin) > var0 * var0) {
      while(isDefined(level.wolf) && isDefined(level.wolf_vest) && isDefined(level.wolf_vest.control)) {
        level.wolf_vest.control notify("player_left");
        wait 0.2;
      }
    }

    wait 0.1;
  }
}

function wolf_vest_defuse_failed(var0, var1) {
  level notify("wolf_vest_defuse_failed");
  scripts\sp\utility::notetrack_vo_disable();

  if(isDefined(level.player_rig)) {
    level.player_rig stopsounds();
  }

  if(!istrue(var1)) {
    if(istrue(self.defuse_failed)) {
      return;
    }

    self.defuse_failed = 1;
    wait 0.25;

    if(istrue(var0)) {
      level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_alx_basement_tunnel_leftpath_30", 1, 0.25);
    }

    wait 0.25;
  }

  level.farah stopsounds();
  level.wolf stopsounds();
  crosshair_overlay_dot(0);
  wolf_tunnel_explode();
}

function wolf_tunnel_explode() {
  var0 = scripts\engine\utility::getStruct("wolf_tunnel_exp_struct", "targetname");
  var1 = var0.origin;
  var2 = var0.angles;
  thread wolf_room_barrels_explode(0.05);
  scripts\engine\utility::exploder("wolf_fail");
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_trans", var1);
  wait 0.25;
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_fireball_front", var1);
  level.wolf_tunnel_fire_trig.script_multiplier = 10;
  level.wolf_tunnel_fire_trig thread scripts\sp\maps\tunnels\zd30tunnels_utility::supplementary_fire_damage();
  level.wolf_tunnel_fire_trig scripts\engine\utility::delaythread(0.25, &scripts\engine\utility::trigger_on);
  wait 1;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::player_burn_death_overlay(0.35);
  level.player playSound("scn_zd30_collapse_lr_02");
  wait 1;
  level.player kill();
}

function wolf_room_barrels_explode(var0) {
  var1 = getEnt("wolf_room_trig", "targetname");
  var2 = [];

  foreach(var4 in level.spewing_barrels) {
    if(isDefined(var4) && var4 istouching(var1)) {
      var2 = var4;
    }
  }

  if(isDefined(var0)) {
    wait var0;
  }

  var2 = sortbydistance(var2, level.player.origin);
  var6 = 3;
  var7 = int(min(var6, var2.size));

  for(var8 = 0; var8 < var7; var8++) {
    var2[var8] thread scripts\sp\maps\tunnels\zd30tunnels_utility::detonate_spewing_barrel();
    wait randomfloatrange(0.15, 0.3);
  }
}

function debug_tag_accessory(var0) {
  level endon("wolf_vest_defused_and_player_unlinked");

  while(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    var1 = level.farah gettagangles(var0);
    var2 = level.farah gettagorigin(var0);
    scripts\engine\utility::draw_angles(var1, var2, (1, 1, 1), 1, 1);
    level.farah_tag_acc_org = var2;
    level.farah_tag_acc_ang = var1;
    wait 0.05;
  }
}

function crosshair_overlay_dot(var0) {
  if(var0) {
    var1 = newhudelem();
    var1.alignx = "center";
    var1.aligny = "middle";
    var1.foreground = 1;
    var1.hidewheninmenu = 1;
    var1.sort = 1;
    var1.alpha = 1;
    var1.x = 322;
    var1.y = 237;
    var1 setshader("reticle_center_dot", 32, 32);
    level.player.crosshair_overlay = var1;
    return;
  }

  if(isDefined(level.player.crosshair_overlay)) {
    level.player.crosshair_overlay destroy();
    return;
  }
}

function vest_timer_countdown() {
  level endon("wolf_vest_defuse_failed");
  level endon("wolf_vest_defused");
  self endon("entitydeleted");
  self endon("death");
  thread beeper_loop();
  self waittill("timer_start");
  thread start_phone_countdown();
  var0 = 0.1;
  var1 = 26.2;
  var2 = int(var0 * 20);

  for(;;) {
    var1 -= var0;

    if(var1 < 0) {
      var1 = 0;
    }

    var3 = (1, 1, 0);

    if(var1 < 23.2) {
      var3 = (1, 0.5, 0);
    }

    if(var1 < 20.2) {
      var3 = (1, 0, 0);
    }

    wait var0;

    if(istrue(level.wolf_vest.defused)) {
      return;
    }
  }
}

function start_phone_countdown() {
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame("sp_tunnels_vest_timer");
}

function beeper_loop() {
  self endon("entitydeleted");
  self endon("death");
  scripts\engine\utility::flag_wait("wolfdoor_open");
  var0 = 1.19048;

  for(;;) {
    self playSound("bomb_beep");
    wait var0;

    if(istrue(self.defused) || istrue(self.defuse_failed)) {
      return;
    }
  }
}

function setup_wire(var0, var1, var2) {
  var3 = getEnt(var0, "targetname");
  var3.wire_type = var2;
  var3.color_index = var1;
  var3.interacts = getEntArray(var3.target, "targetname");
  var3.cut = getEnt(var0 + "_cut", "targetname");
  var3.cut linkTo(self);
  var3.cut hide();
  var3.cut_alt = getEnt(var0 + "_cut_alt", "targetname");

  if(isDefined(var3.cut_alt)) {
    var3.cut_alt linkTo(self);
    var3.cut_alt hide();
  }

  foreach(var5 in var3.interacts) {
    var5 linkTo(var3);
  }

  var3 linkTo(self);
  thread wire_cut_button_press_watch();
  return var3;
}

function wire_cut_button_press_watch() {
  level endon("wolf_vest_defuse_failed");
  level endon("wolf_vest_defused");
  self endon("entitydeleted");

  for(;;) {
    level.player waittill("wire_cut_button_press");
    var0 = get_closest_look_at_interact();

    if(!isDefined(level.looking_at_wire) || level.looking_at_wire != self) {
      waitframe();
      continue;
    }

    level.player notify("wire_cut", gettime(), self);

    if(var0.script_noteworthy == "cursor_alt") {
      self.cut_alt show();
    } else {
      self.cut show();
    }

    self playSound("scn_tunnels_wolf_wire_cut");
    self hide();
    self.is_cut = 1;
    return;
  }
}

function wire_look_at_think() {
  level endon("wolf_vest_defuse_failed");
  level endon("wolf_vest_defused");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("wolfdeath_farah_defuse_ready");
  wait 2.5;
  thread wire_look_at_hint();

  while(!istrue(level.wolf_vest.defused)) {
    var0 = get_closest_look_at_interact();
    var1 = get_wire_from_interact(var0);
    wire_outline_active_and_waittill_not(var1, var0);
    wait 0.05;
  }
}

function wire_look_at_hint() {
  wait 2;

  if(!scripts\engine\utility::flag("wolfdeath_defuse_looked_at_green_wire")) {
    if(level.player usinggamepad()) {
      scripts\engine\sp\utility::display_hint("wolf_defuse_hint");
      return;
    }

    scripts\engine\sp\utility::display_hint("wolf_defuse_hint_kbm");
    return;
  }
}

function wolf_bomb_vest_defuse_looked_at_any_wire() {
  return scripts\engine\utility::flag("wolfdeath_defuse_looked_at_green_wire");
}

function wire_outline_active_and_waittill_not(var0, var1) {
  var2 = "outline_depth_red";

  switch (var0.color_index) {
    case 2:
      scripts\engine\utility::flag_set("wolfdeath_defuse_looked_at_green_wire");
      var2 = "outline_depth_green";
      break;
    case 1:
      var2 = "outline_depth_red";
      break;
    case 4:
      var2 = "outline_depth_yellow";
      break;
    case 0:
      var2 = "outline_depth_cyan";
      break;
  }

  var0 thread scripts\engine\sp\utility::hudoutline_enable_new(var2);
  level.looking_at_wire = var0;
  var3 = get_wire_cut_hint(var0.wire_type);
  var1 scripts\sp\player\cursor_hint::create_cursor_hint_forced("tag_origin", (0, 0, 0), var3, 60, 60, 60, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 10);

  while(is_player_looking_at_interact(var1) && !istrue(var0.is_cut) && !istrue(level.wolf_vest.defused)) {
    wait 0.05;
  }

  var1 scripts\sp\player\cursor_hint::remove_cursor_hint();
  var0 thread scripts\engine\sp\utility::hudoutline_disable();
  level.looking_at_wire = undefined;
}

function is_player_looking_at_interact(var0) {
  var1 = get_closest_look_at_interact();

  if(!isDefined(var1) || var0 != var1) {
    return false;
  }

  return true;
}

function get_wire_from_interact(var0) {
  var1 = undefined;

  foreach(var3 in level.wolf_vest.wires) {
    if(scripts\engine\utility::array_contains(var3.interacts, var0)) {
      var1 = var3;
    }
  }

  return var1;
}

function get_closest_look_at_interact() {
  var0 = getEntArray("cursor", "script_noteworthy");
  var1 = getEntArray("cursor_alt", "script_noteworthy");
  var2 = scripts\engine\utility::array_combine(var0, var1);
  var3 = vectorNormalize(anglesToForward(level.player getplayerangles()));
  var4 = var2[0];

  foreach(var6 in var2) {
    if(var4 == var6) {
      continue;
    }

    var7 = vectorNormalize(var6.origin - level.player getEye());
    var8 = vectorNormalize(var4.origin - level.player getEye());
    var9 = vectordot(var3, var7);
    var10 = vectordot(var3, var8);

    if(var9 > var10) {
      var4 = var6;
    }
  }

  return var4;
}

function get_wire_cut_hint(var0) {
  if(var0 == "red") {
    return &"ZD30/DEFUSE_RED";
  }

  if(var0 == "green") {
    return &"ZD30/DEFUSE_GREEN";
  }

  if(var0 == "yellow") {
    return &"ZD30/DEFUSE_YELLOW";
  }

  if(var0 == "blue") {
    return &"ZD30/DEFUSE_BLUE";
  }

  return "";
}

function wolf_vest_led_flash_think(var0) {
  self endon("entitydeleted");
  self endon("death");
  var1 = 1.5;
  var2 = "on";

  while(!istrue(var0.defuse_failed)) {
    self setscriptablepartstate("onoff", var2);

    if(var2 == "on") {
      var2 = "off";
    } else {
      var2 = "on";
    }

    if(istrue(var0.defused)) {
      self setscriptablepartstate("onoff", "on");
      return;
    }

    var3 = var1 / (level.defuse_count + 1);

    while(var3 > 0) {
      if(istrue(var0.defuse_failed)) {
        break;
      }

      var3 -= 0.05;
      wait 0.05;
    }
  }

  self setscriptablepartstate("onoff", "off_blink");
}