/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_code.gsc
****************************************/

intro_track_player_gunfire() {
  level endon("start_small_wreck");

  for(;;) {
    level.player waittill("weapon_fired");

    if(level.deadly_sharks.size > 0) {
      wait 0.5;
      level.deadly_sharks = maps\_utility::array_removedead(level.deadly_sharks);
      level.deadly_sharks = common_scripts\utility::array_removeundefined(level.deadly_sharks);
      var_0 = sortbydistance(level.deadly_sharks, level.player.origin);

      foreach(var_2 in var_0) {
        if(level.player maps\_utility::player_looking_at(var_2.origin, 0.8) && distance(var_2.origin, level.player.origin) < 800) {
          var_2 maps\ship_graveyard_util::shark_kill_player();
          wait 1;
          break;
        }
      }
    }

    wait 0.05;
  }
}

tutorial_player_recover() {
  var_0 = common_scripts\utility::get_target_ent("tutorial_dive_player_anim");
  level.player_rig = maps\_player_rig::get_player_rig();
  level.player_rig.origin = level.player.origin;
  level.player_rig.angles = level.player.angles;
  var_1 = (0, 0, 48);
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = level.player_rig.origin;
  var_2.angles = level.player_rig.angles;
  var_2 linkto(level.player_rig, "tag_player", var_1, (0, 0, 0));
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel(level.baker.model);
  var_3.animname = "legs";
  var_3 maps\_anim::setanimtree();
  level.player playerlinktoabsolute(var_2, "tag_player");
  playFXOnTag(common_scripts\utility::getfx("dive_in_bubbles_hand"), level.player_rig, "j_wrist_le");
  playFXOnTag(common_scripts\utility::getfx("dive_in_bubbles_hand"), level.player_rig, "j_wrist_ri");
  playFXOnTag(common_scripts\utility::getfx("dive_in_bubbles_feet"), var_3, "J_Ankle_LE");
  playFXOnTag(common_scripts\utility::getfx("dive_in_bubbles_feet"), var_3, "J_Ankle_RI");
  common_scripts\utility::exploder("dive_in");
  var_4 = getent("start_boat", "targetname");
  var_4.script_max_left_angle = 1;
  var_4 thread maps\ship_graveyard_surface::pitch_and_roll();
  var_0 maps\_anim::anim_single([level.player_rig, var_3], "below_water_tutorial_dive");
  level.player unlink();
  level.player_rig delete();
  var_3 delete();
  level.player enableweapons();
  level.player givemaxammo("aps_underwater+swim");

  if(!maps\ship_graveyard_util::greenlight_check()) {
    wait 2;
    thread maps\ship_graveyard_util::track_hint_down();

    if(level.console || level.player usinggamepad())
      thread maps\_utility::display_hint_timeout("hint_down_gamepad", 4);
    else if(maps\_utility::is_command_bound("+togglecrouch"))
      thread maps\_utility::display_hint_timeout("hint_down_crouch", 4);
    else if(maps\_utility::is_command_bound("+stance"))
      thread maps\_utility::display_hint_timeout("hint_down_stance", 4);
    else if(maps\_utility::is_command_bound("+movedown"))
      thread maps\_utility::display_hint_timeout("hint_down_hold_crouch", 4);
    else
      thread maps\_utility::display_hint_timeout("hint_down_crouch", 4);
  }

  maps\_utility::trigger_wait_targetname("exit_tiny_cave");
  maps\_utility::autosave_by_name("intro");
  maps\_utility::smart_radio_dialogue("shipg_bkr_thisway");
  maps\_utility::delaythread(0.5, maps\_utility::smart_radio_dialogue, "shipg_bkr_5klicks");
  maps\_utility::trigger_wait_targetname("tutorial_hint_up");
}

intro_dialgue() {}

baker_path_to_wreck() {
  var_0 = common_scripts\utility::get_target_ent("baker_start_path");
  wait 1;
  level.baker maps\_utility::follow_path_and_animate(var_0);
  common_scripts\utility::flag_set("baker_at_wreck");
}

#using_animtree("generic_human");

wreck_reveal_spotted(var_0) {
  level endon("entering_small_wreck");
  common_scripts\utility::flag_wait("_stealth_spotted");
  level.baker.ignoreall = 0;
  var_1 = getnode("baker_wreck_approach_spotted", "script_noteworthy");
  level.baker setgoalnode(var_1);
  common_scripts\utility::flag_set("_stealth_spotted_punishment");
  common_scripts\utility::flag_set("spotted_at_wreck");
  thread maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_ontous");
  wait 1;
  maps\_utility::array_spawn_targetname("wreck_reveal_backup");
  common_scripts\utility::flag_clear("_stealth_spotted_punishment");
  wait 1;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_droppingin");
  thread wreck_reveal_spotted_ai_swarm();
  wait 3;
  level waittill("never");
  var_0 thread maps\ship_graveyard_util::boat_shoot_entity(level.player, "entering_small_wreck");
  var_2 = common_scripts\utility::get_target_ent("wreck_approach_dam_trig");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(var_3 == level.player) {
      break;
    }
  }

  var_0 notify("stop_shooting");
  var_4 = % ship_graveyard_boat_death_a;
  var_5 = common_scripts\utility::get_target_ent("wreck_approach_boat_shooter");
  var_6 = var_5 maps\_utility::spawn_ai(1);
  var_6.origin = (var_5.origin[0], var_5.origin[1], level.water_level_z + 5);
  common_scripts\utility::waitframe();
  var_7 = getanimlength(var_4);
  var_8 = common_scripts\utility::get_target_ent("wreck_approach_boat_shooter_fx");
  var_6 thread maps\_utility::magic_bullet_shield();
  var_6.forceragdollimmediate = 1;
  var_6.skipdeathanim = 1;
  playFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_6, "tag_origin");
  var_5 thread maps\_anim::anim_generic(var_6, "death_boat_A");
  wait 1.5;
  playFX(common_scripts\utility::getfx("jump_into_water_splash"), var_8.origin);
  thread common_scripts\utility::play_sound_in_space("enemy_water_splash", var_8.origin);
  var_5 waittill("death_boat_A");
  var_9 = var_6 common_scripts\utility::spawn_tag_origin();
  var_6 linkto(var_9, "tag_origin");
  var_10 = getweaponmodel(var_6.weapon);
  var_11 = var_6.weapon;

  if(isDefined(var_10)) {
    var_6 detach(var_10, "tag_weapon_right");
    var_8 = var_6 gettagorigin("tag_weapon_right");
    var_12 = var_6 gettagangles("tag_weapon_right");
    var_13 = spawn("script_model", (0, 0, 0));
    var_13 setModel(var_10);
    var_13.angles = var_12;
    var_13.origin = var_8;
    var_13 physicslaunchclient(var_13.origin, (0, 0, 0));
  }

  var_9 thread maps\_anim::anim_generic_loop(var_6, "death_boat_A_loop");
  var_14 = bulletTrace(var_6.origin - (0, 0, 200), var_6.origin - (0, 0, 6000), 0, var_6);
  var_15 = var_14["position"];
  var_15 = (var_15[0], var_15[1], var_15[2] + 50);
  var_9 maps\ship_graveyard_util::moveto_speed(var_15, 100, 0, 0);
  var_6 maps\_utility::stop_magic_bullet_shield();
  var_6 startragdoll();
  var_6 unlink();
  var_9 notify("stop_loop");
  wait 0.1;
  var_9 delete();
  wait 0.5;
  stopFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_6, "tag_origin");
  var_6 kill();
}

wreck_reveal_spotted_ai_swarm() {
  var_0 = getaiarray("axis");

  while(var_0.size > 0) {
    if(var_0.size <= 3) {
      var_0 = sortbydistance(var_0, level.player.origin);
      var_1 = var_0[var_0.size - 1];
      var_1 ai_go_to_player();
      var_0 = getaiarray("axis");
      continue;
    }

    wait 0.05;
  }
}

ai_go_to_player() {
  self endon("death");
  self.goalradius = 300;
  self setgoalentity(level.player);
  self waittill("death");
}

sonar_ping(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(self, "tag_origin", (0, 0, -80), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("sonar_ping_light"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("sonar_ping_distortion"), var_1, "tag_origin");
  wait 0.1;

  if(isDefined(var_0)) {
    var_2 = "";
    var_2 = "sonar_ping_dist_" + var_0;
    maps\_utility::play_sound_on_entity(var_2);
  } else
    maps\_utility::play_sound_on_entity("sonar_ping_dist_01");

  var_1 delete();
}

boat_triggers_spotted() {
  level endon("clear_to_enter_wreck");
  var_0 = common_scripts\utility::get_target_ent("wreck_approach_dam_trig");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == level.player) {
      break;
    }
  }

  common_scripts\utility::flag_set("_stealth_spotted");
}

wreck_zodiac_event() {
  level.zodiac_b = maps\_vehicle::spawn_vehicle_from_targetname("wreck_zodiac");
  var_0 = level.zodiac_b;
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("wreck_zodiac_dropoff");
  common_scripts\utility::flag_wait("start_small_wreck");
  thread boat_triggers_spotted();
  thread wreck_reveal_spotted(var_1);
  common_scripts\utility::flag_wait("approaching_wreck");
  maps\_utility::array_spawn_targetname("a1_patrol_2");
  var_1 vehicle_turnengineoff();
  var_0 vehicle_turnengineoff();
  var_1 thread maps\_utility::play_sound_on_entity("scn_shipg_sm_wreck_zod1");
  var_0 thread maps\_utility::play_sound_on_entity("scn_shipg_sm_wreck_zod2");
  var_0 thread maps\_vehicle::gopath();
  thread zodiac_arrive(var_1);
  common_scripts\utility::flag_wait("baker_at_wreck");
  wait 1;
  common_scripts\utility::flag_wait("drop_off_guys");
  maps\ship_graveyard_fx::trigger_fish_school("fish_school_wreck_approach", "start");
  thread maps\ship_graveyard_util::sardines_path_sound_no_trigger("fish_school_wreck_approach", "scn_fish_swim_away_wreck");
  wait 0.5;
  var_1 thread sonar_ping("04");
  wait 1.5;
  maps\_utility::array_spawn_targetname("a1_patrol_1");
  common_scripts\utility::flag_set("wreck_patrol_in");
  thread too_close_to_guys();
  thread too_close_to_boat();
}

zodiac_arrive(var_0) {
  var_0 notify("newpath");
  var_0.animname = "missile_boat";
  var_1 = common_scripts\utility::get_target_ent("wreck_approach_boat_arrival");
  var_1 maps\_anim::anim_single_solo(var_0, "missile_boat_arrive");
  common_scripts\utility::flag_set("drop_off_guys");
  var_0 notify("reached_end_node");
  var_1 thread maps\_anim::anim_loop_solo(var_0, "missile_boat_idle");
}

too_close_to_guys() {
  level endon("wreck_approach_guys_dead");
  level endon("_stealth_spotted");
  maps\_utility::trigger_wait_targetname("wreck_approach_too_close");
  var_0 = getaiarray("axis");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_1 = var_0[0];
  var_1 setgoalpos(level.player.origin);
}

too_close_to_boat() {
  level endon("clear_to_enter_cave");
  level endon("_stealth_spotted");
  level endon("clear_to_enter_wreck");
  maps\_utility::trigger_wait_targetname("wreck_approach_close_to_boat");
  var_0 = getaiarray("axis");
  var_0 = sortbydistance(var_0, level.player.origin);
  common_scripts\utility::flag_set("_stealth_spotted");
  var_1 = var_0[0];
  var_1 setgoalpos(level.player.origin);
}

baker_approach() {
  level endon("_stealth_spotted");
  level.zodiac_b maps\_utility::delaythread(0, ::sonar_ping, "01");
  wait 1.4;
  maps\ship_graveyard_util::baker_glint_off();
  level.baker.ignoreall = 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_enemysonar");
  thread maps\_utility::display_hint("hint_flashlight");
  wait 0.3;
  level.zodiac_b maps\_utility::delaythread(0, ::sonar_ping, "02");
  wait 0.6;
  maps\_utility::smart_radio_dialogue("shipg_bkr_easy");
  wait 1.0;
  level.zodiac_b maps\_utility::delaythread(0, ::sonar_ping, "03");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("shipg_bkr_hugtheground");
  maps\_utility::smart_radio_dialogue("shipg_bkr_maskoursig");
  common_scripts\utility::flag_wait("approaching_wreck");
  common_scripts\utility::flag_wait("baker_at_wreck");
  wait 0.8;
  maps\_utility::smart_radio_dialogue("shipg_bkr_holdup");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_boatpatrol");
  maps\_utility::autosave_stealth_silent();
  level.baker maps\ship_graveyard_util::dyn_swimspeed_disable();
  common_scripts\utility::flag_wait("drop_off_guys");
  level endon("wreck_approach_guys_dead");
  wait 2.7;
  maps\_utility::smart_radio_dialogue("shipg_bkr_gotcompany");
  wait 0.8;
  maps\_utility::smart_radio_dialogue("shipg_bkr_themseparate");
  wait 1.6;
  maps\_utility::smart_radio_dialogue("shipg_bkr_ok");
  wait 0.5;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_staylow");
  wait 0.5;
  maps\_utility::autosave_stealth();
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_approach_wreck"));
  maps\ship_graveyard_util::baker_glint_off();
  level.baker maps\_utility::delaythread(2, maps\_utility::set_ignoreall, 0);
  maps\_utility::smart_radio_dialogue("shipg_bkr_inposition");
  wait 0.9;
  maps\_utility::smart_radio_dialogue("shipg_bkr_aseffective");
  wait 1.2;
  maps\_utility::smart_radio_dialogue("shipg_bkr_weaponsfree");
}

baker_wreck_cleanup() {
  level endon("start_stealth_area_1");
  common_scripts\utility::flag_wait("drop_off_guys");
  thread wreck_jumper_watcher();
  maps\_utility::delaythread(5, maps\ship_graveyard_util::paired_death_wait_flag, "wreck_approach_guys_dead");
  common_scripts\utility::flag_wait("wreck_approach_guys_dead");
  wait 0.7;
  common_scripts\utility::flag_wait("wreck_jumpers_alive");
  common_scripts\utility::flag_waitopen("_stealth_spotted");
  level endon("_stealth_spotted");
  maps\ship_graveyard_util::baker_glint_on();
  maps\ship_graveyard_util::baker_noncombat();
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_nicelydone");
  common_scripts\utility::flag_set("clear_to_enter_wreck");
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable();
  maps\_utility::smart_radio_dialogue("shipg_hsh_letsmovethruthe");
  wait 0.3;
  maps\_utility::smart_radio_dialogue("shipg_bkr_distancefromboat");
  wait 0.3;
  maps\_utility::smart_radio_dialogue("shipg_bkr_moreattention");
}

wreck_jumper_watcher() {
  level endon("start_stealth_area_1");
  common_scripts\utility::flag_wait("wreck_patrol_in");

  while(level.total_jumpers.size) {
    level.total_jumpers = maps\_utility::array_removedead_or_dying(level.total_jumpers);
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("wreck_jumpers_alive");
}

a1_patrol_1_setup() {
  self endon("death");
  self endon("_stealth_spotted");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "jumper")
    self waittill("done_jumping_in");
  else {
    thread maps\ship_graveyard_util::paired_death_think(level.baker);
    maps\ship_graveyard_util::teleport_to_target();
    return;
  }

  var_0 = common_scripts\utility::get_target_ent();
  var_0 = var_0 common_scripts\utility::get_target_ent();

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "deleteme")) {
    if(maps\_utility::ent_flag("_stealth_spotted")) {
      return;
    }
    self.goalradius = 64;
    self.goalheight = 64;
    maps\_utility::follow_path_and_animate(var_0, 0);
    wait 2;

    while(level.player maps\_utility::player_looking_at(self.origin + (0, 0, 50), 0.7))
      common_scripts\utility::waitframe();

    self delete();
  } else {
    thread maps\ship_graveyard_util::paired_death_think(level.baker);

    if(maps\_utility::ent_flag("_stealth_spotted")) {
      return;
    }
    maps\ship_graveyard_util::stealth_idle_reach(var_0);
  }
}

baker_wait_in_front_of_wreck() {
  if(common_scripts\utility::flag("player_close_to_small_wreck")) {
    return;
  }
  level endon("player_close_to_small_wreck");

  while(!common_scripts\utility::flag("player_close_to_small_wreck")) {
    level.baker maps\_utility::waittill_player_lookat_for_time(0.5, 0.8);

    if(distance(level.player.origin, level.baker.origin) < 250) {
      break;
    }

    wait 0.1;
  }
}

baker_enter_wreck() {
  level endon("stop_for_e3");
  common_scripts\utility::flag_wait_either("clear_to_enter_wreck", "player_close_to_small_wreck");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");
  thread baker_wreck_dialogue();
  level.baker pushplayer(1);
  var_0 = common_scripts\utility::get_target_ent("friendly_follow_2");
  level.baker setgoalpos(var_0.origin);
  level.baker.ignoreall = 1;
  baker_wait_in_front_of_wreck();
  var_0 = var_0 common_scripts\utility::get_target_ent();
  level.baker maps\_utility::follow_path_and_animate(var_0);
  var_1 = common_scripts\utility::get_target_ent("baker_small_wreck_cover_l");
  var_1 maps\_anim::anim_generic_reach(level.baker, "swimming_aiming_move_to_cover_l1");
  common_scripts\utility::flag_set("baker_at_small_wreck");
  var_2 = 0;

  if(!common_scripts\utility::flag("sdv_passed") && !common_scripts\utility::flag("salvage_baloon_goes")) {
    var_2 = 1;
    var_1 maps\_anim::anim_generic(level.baker, "swimming_aiming_move_to_cover_l1");
    var_1.origin = level.baker.origin;
    var_1.angles = level.baker.angles;
    level.baker.my_animnode = var_1;
    var_1 thread maps\_anim::anim_generic_loop(level.baker, "swimming_cover_l1_idle");
    common_scripts\utility::flag_wait("sdv_passed");
    level.baker maps\_utility::disable_exits();
    var_1 notify("stop_loop");
    level.baker thread maps\ship_graveyard_util::dyn_swimspeed_disable();
    var_1 thread maps\_anim::anim_generic_run(level.baker, "swimming_cover_l1_exit_r180");
  }

  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("friendly_follow_3"), 250);

  if(var_2) {
    var_1 waittill("swimming_cover_l1_exit_r180");
    wait 0.1;
    level.baker maps\_utility::enable_exits();
  }
}

baker_wreck_dialogue() {
  level endon("stop_for_e3");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");
  common_scripts\utility::flag_wait("small_wreck_sdv_spawned");
  common_scripts\utility::flag_wait_or_timeout("baker_at_small_wreck", 1);
  wait 0.2;
  maps\_utility::smart_radio_dialogue("shipg_bkr_slowdown");
  wait 1.5;

  if(!common_scripts\utility::flag("sdv_passed")) {
    thread maps\_utility::smart_radio_dialogue("shipg_bkr_stayyydownstaydown");
    common_scripts\utility::flag_wait("sdv_passed");
  }

  thread greenlight_skip();

  if(!common_scripts\utility::flag("salvage_baloon_goes")) {
    wait 0.2;
    thread maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_salvaging");
  }
}

wreck_hint_up() {
  if(common_scripts\utility::flag("_stealth_spotted") || level.start_point == "old_e3") {
    return;
  }
  level endon("_stealth_spotted");
  common_scripts\utility::flag_wait("clear_to_enter_wreck");
  level endon("entering_small_wreck");
  maps\_utility::trigger_wait_targetname("trigger_hint_up");

  if(maps\ship_graveyard_util::greenlight_check()) {
    return;
  }
  thread maps\ship_graveyard_util::track_hint_up();

  if(level.console || level.player usinggamepad())
    thread maps\_utility::display_hint_timeout("hint_up_gamepad", 4);
  else
    thread maps\_utility::display_hint_timeout("hint_up_stand", 4);
}

wreck_spotted_reaction() {
  level endon("start_stealth_area_1");
  level endon("stop_for_e3");
  common_scripts\utility::flag_wait("_stealth_spotted");

  if(!common_scripts\utility::flag("spotted_at_wreck"))
    thread maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_ontous");

  level.baker stopanimscripted();
  level.baker notify("stop_loop");

  if(isDefined(level.baker.my_animnode))
    level.baker.my_animnode notify("stop_loop");

  common_scripts\utility::flag_waitopen("_stealth_spotted");
  common_scripts\utility::flag_set("move_to_stealth_1");

  if(maps\ship_graveyard_util::greenlight_check())
    greenlight_skip();

  maps\_utility::smart_radio_dialogue("shipg_bkr_areaclear");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_onme");
}

sdv_follow_spotted_react() {
  self endon("death");
  wait 5;
  common_scripts\utility::flag_wait("_stealth_spotted");
  maps\_vehicle::vehicle_unload();
}

wreck_cargo_surprise() {
  level endon("_stealth_spotted");
  level endon("stop_for_e3");
  var_0 = common_scripts\utility::get_target_ent("baloon_rise_1");
  common_scripts\utility::flag_wait("entering_small_wreck");
  common_scripts\utility::noself_delaycall(3, ::playfx, common_scripts\utility::getfx("bubble_burst_large"), var_0.origin - (0, 32, 32));
  common_scripts\utility::flag_wait("salvage_baloon_goes");
  musicstop(4);
  maps\_utility::delaythread(1.15, maps\_utility::smart_radio_dialogue, "shipg_bkr_hold2");
  var_1 = maps\_utility::spawn_targetname("baloon_guy");
  var_1 setgoalpos(var_1.origin);
  var_1 thread melee_on_spotted();
  var_1.ignoreme = 1;
  var_1.moveplaybackrate = 0.75;
  var_1.movetransitionrate = var_1.moveplaybackrate;
  thread common_scripts\utility::play_sound_in_space("scn_shipg_balloon_inflate", var_0.origin);
  common_scripts\utility::noself_delaycall(0.15, ::playfx, common_scripts\utility::getfx("bubble_burst_large"), var_0.origin - (0, 32, 32));
  var_0 thread maps\ship_graveyard_util::salvage_cargo_rise(38);
  wait 1;
  var_2 = var_1 common_scripts\utility::get_target_ent();
  var_1.goalradius = 32;
  var_1.goalheight = 32;
  var_1 forceteleport(var_2.origin, var_2.angles);
  var_2 = var_2 common_scripts\utility::get_target_ent();
  var_1 thread maps\_utility::follow_path_and_animate(var_2, 0);
  level.baker.oldbaseaccuracy = level.baker.baseaccuracy;
  var_1 thread baker_quip_on_death();
  var_1 thread delete_on_path_end();
  var_1 thread maps\_utility::flag_on_death("move_to_stealth_1");
  var_1.health = 1;
  var_1 endon("death");
  var_1 common_scripts\utility::waittill_notify_or_timeout("kill_me", 16.5);
  common_scripts\utility::flag_set("move_to_stealth_1");
}

melee_on_spotted() {
  self endon("death");
  maps\_utility::ent_flag_wait("_stealth_spotted");
  self waittill("stealth_change_values");
  common_scripts\utility::waitframe();
  maps\ship_graveyard_util::enemy_attempt_melee();
}

shark_moment(var_0) {
  var_1 = common_scripts\utility::get_target_ent("shark_attack_1_node");
  var_2 = maps\_utility::spawn_anim_model("shark", (0, 0, 0));
  level.deadly_sharks = common_scripts\utility::array_add(level.deadly_sharks, var_2);
  var_0.animname = "generic";
  thread shark_attack_fx(var_0, var_2);
  var_1 maps\_anim::anim_single([var_0, var_2], "shark_moment");
  var_0 delete();
  var_2 delete();
  common_scripts\utility::flag_set("move_to_stealth_1");
}

shark_attack_fx(var_0, var_1) {
  wait 8.9;
  common_scripts\utility::flag_set("no_shark_heartbeat");
  thread common_scripts\utility::play_sound_in_space("scn_shark_bite_flesh", var_0 gettagorigin("j_knee_ri"));
  playFX(common_scripts\utility::getfx("swim_ai_blood_impact"), var_0 gettagorigin("j_knee_ri"));
  playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), var_0, "j_knee_ri");
  maps\_utility::delaythread(0.5, common_scripts\utility::play_sound_in_space, "scn_shark_bite_flesh", var_0 gettagorigin("j_knee_ri"));
  maps\_utility::delaythread(0.9, common_scripts\utility::play_sound_in_space, "scn_shark_bite_flesh", var_0 gettagorigin("j_knee_ri"));
  maps\_utility::delaythread(1.6, common_scripts\utility::play_sound_in_space, "scn_shark_bite_flesh", var_0 gettagorigin("j_knee_ri"));
}

transition_to_stealth_1() {
  level endon("start_stealth_area_2");
  level endon("stop_for_e3");
  common_scripts\utility::flag_wait("move_to_stealth_1");
  thread transition_to_stealth_1_glint_off();
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_stealth_1_path"));
  maps\_utility::autosave_stealth();
}

transition_to_stealth_1_glint_off() {
  maps\ship_graveyard_util::baker_glint_on();
  var_0 = getnode("trans1_eop", "script_noteworthy");
  var_0 waittill("trigger");
  maps\ship_graveyard_util::baker_glint_off();
}

baker_quip_on_death() {
  var_0 = common_scripts\utility::waittill_any_return("death", "kill_me");

  if(!maps\ship_graveyard_util::greenlight_check()) {
    level.baker.baseaccuracy = level.baker.oldbaseaccuracy;

    if(isDefined(self))
      wait 1.5;

    var_1 = getaiarray("axis");

    if(var_1.size == 0) {
      maps\_utility::smart_radio_dialogue("shipg_bkr_closecall");
      wait 0.7;
      thread maps\_utility::smart_radio_dialogue("shipg_bkr_thisway");
      wait 0.5;
    }

    maps\ship_graveyard_util::baker_noncombat();
  }

  common_scripts\utility::flag_set("move_to_stealth_1");
}

delete_on_path_end() {
  self waittill("path_end_reached");
  var_0 = level.player maps\_utility::player_looking_at(self.origin + (0, 0, -100), 0.7);

  if(!var_0)
    self delete();
  else
    self notify("kill_me");

  common_scripts\utility::flag_set("move_to_stealth_1");
}

stealth_1_zodiac_setup() {
  if(!isDefined(level.stealth_1_zodiac_sounds)) {
    level.stealth_1_zodiac_sounds = ["scn_shipg_stealth_1_zod1", "scn_shipg_stealth_1_zod2"];
    level.stealth_1_zodiac_soundindex = 0;
  }

  self vehicle_turnengineoff();
  thread maps\_utility::play_sound_on_entity(level.stealth_1_zodiac_sounds[level.stealth_1_zodiac_soundindex]);
  level.stealth_1_zodiac_soundindex = level.stealth_1_zodiac_soundindex + 1;
}

stealth_1_encounter() {
  level.baker.ignoreall = 1;
  var_0 = maps\_utility::array_spawn_targetname("stealth_1_guys");
  common_scripts\utility::array_thread(var_0, maps\ship_graveyard_util::teleport_to_target);
  common_scripts\utility::flag_wait("stealth_1_engage");
  wait 1;
  level.baker.ignoreall = 0;
  var_1 = maps\_utility::spawn_targetname("stealth_1_jumper");
  var_0 = common_scripts\utility::array_add(var_0, var_1);
  level endon("start_stealth_area_2");

  while(getaiarray("axis").size > 0)
    wait 0.05;

  level notify("stealth_1_done");
  wait 1;
  maps\ship_graveyard_util::baker_noncombat();
  maps\_utility::smart_radio_dialogue("shipg_bkr_clear");
  thread baker_move_to_stealth_2();
  thread move_to_stealth_2_dialogue();
}

sdv_follow_2_passby_audio() {
  maps\_utility::play_sound_on_entity("scn_shipg_sub_by_01");
}

sdv_stealth_2_sub_1_passby_audio() {
  maps\_utility::play_sound_on_entity("scn_shipg_sub_by_02");
}

sdv_stealth_2_sub_2_passby_audio() {
  maps\_utility::play_sound_on_entity("scn_shipg_sub_by_03");
}

baker_move_to_stealth_2() {
  maps\ship_graveyard_util::baker_glint_on();
  thread stealth_2_light_off();
  setsaveddvar("player_swimSpeed", 85);
  level.baker.pathrandompercent = 0;
  level.baker.goalradius = 128;
  level.baker.moveplaybackrate = 1.15;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable(100);
  level.baker.ignoreall = 1;
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_stealth_2_path"));
  level.baker.ignoreall = 0;
  level.baker maps\ship_graveyard_util::dyn_swimspeed_disable();
  setsaveddvar("player_swimSpeed", 75);
  maps\ship_graveyard_util::baker_glint_off();
}

stealth_2_light_off() {
  var_0 = common_scripts\utility::getstruct("rounding_corner", "script_noteworthy");
  var_0 waittill("trigger");
  maps\ship_graveyard_util::baker_glint_off();
}

move_to_stealth_2_dialogue() {
  wait 0.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_moveup");
  wait 5.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_rallypoint");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("shipg_orb_doubletimeit");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("shipg_hsh_rogerthat");
}

stealth_1_spotted_cleanup() {
  level endon("stealth_1_done");
  common_scripts\utility::flag_wait("_stealth_spotted");
  common_scripts\utility::waitframe();
  var_0 = (1683, -60695, 519);
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(distance2d(var_3.origin, var_0) < 700)
      var_3 kill();
  }
}

stealth_1_dialogue() {
  common_scripts\utility::flag_wait("move_to_stealth_1");
  thread stealth_1_spotted_cleanup();

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  wait 4;
  level endon("_stealth_spotted");
  thread stealth_1_dialogue_kickoff();
  maps\_utility::smart_radio_dialogue("shipg_hsh_shittheyrealreadyhere");
  wait 0.8;
  thread maps\_utility::smart_radio_dialogue("shipg_hsh_neptunewehavecontact");
  wait 0.7;
  thread maps\_utility::smart_radio_dialogue("shipg_hsh_nosignofthe");
  wait 0.6;
  maps\_utility::smart_radio_dialogue("shipg_pri_bastardsdontwasteany");
  common_scripts\utility::flag_wait("stealth_1_engage");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");
  wait 2.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_count4");
  wait 1.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_takeemout");
}

vantage_nag() {
  level endon("stealth_1_done");
  level endon("_stealth_spotted");
  self endon("trigger");
  wait 5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_outoftime");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("shipg_bkr_bettervantage");
}

stealth_1_dialogue_kickoff() {
  level endon("stealth_1_done");
  common_scripts\utility::flag_wait("_stealth_spotted");
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_weaponsfree2");
}

stealth_2_encounter() {
  thread stealth_2_other_guys();
  var_0 = maps\_utility::array_spawn_targetname("stealth_2_guys");
  wait 0.5;
  thread stealth_2_movement();

  while(getaiarray("axis").size > 0)
    wait 0.05;

  common_scripts\utility::flag_set("clear_to_enter_cave");
  wait 2;
  maps\ship_graveyard_util::baker_noncombat();
  maps\_utility::smart_radio_dialogue("shipg_bkr_areaclear");
  wait 0.75;
  maps\_utility::smart_radio_dialogue("shipg_bkr_onme");
  common_scripts\utility::flag_set("to_cave_vo_begin");
}

stealth_2_other_guys() {
  var_0 = common_scripts\utility::get_target_ent("stealth_2_other_guys");
  var_0 waittill("trigger");
  var_1 = maps\_utility::array_spawn_targetname(var_0.target);
  level endon("_stealth_spotted");

  if(!common_scripts\utility::flag("_stealth_spotted")) {
    wait 1;
    common_scripts\utility::array_thread(var_1, maps\_utility::set_moveplaybackrate, 0.8);
  }
}

stealth_2_dialogue() {
  level endon("clear_to_enter_cave");
  level endon("_stealth_spotted");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  thread stealth_2_spotted();
  maps\_utility::trigger_wait_targetname("stealth_2_contact");
  thread maps\_utility::music_play("mus_shipgrave_plane_stinger");
  maps\_utility::smart_radio_dialogue("shipg_bkr_contact");
  wait 0.8;
  maps\_utility::smart_radio_dialogue("shipg_hsh_looksliketheygot");
  wait 2;
  maps\_utility::smart_radio_dialogue("shipg_bkr_flankthem");
  wait 5;
  maps\_utility::autosave_stealth();
  maps\_utility::smart_radio_dialogue("shipg_bkr_weaponsfree");
}

stealth_2_spotted() {
  level endon("clear_to_enter_cave");
  common_scripts\utility::flag_wait("_stealth_spotted");
  thread stealth_2_melee();
  thread delay_drop_boat();
  maps\_utility::delaythread(3, maps\_utility::smart_radio_dialogue_interrupt, "shipg_bkr_knowwerehere");
  maps\_utility::array_spawn_targetname("stealth_2_backup");

  while(getaiarray("axis").size > 2)
    wait 0.05;

  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::setgoalentity, level.player);
  common_scripts\utility::array_thread(var_0, ::find_best_cover);
}

stealth_2_melee() {
  common_scripts\utility::flag_wait("middle_boat_fell");
  maps\ship_graveyard_util::try_to_melee_player("clear_to_enter_cave");
}

find_best_cover() {
  self endon("death");
  self.favoriteenemy = level.player;
  wait(randomfloatrange(4, 8));
  var_0 = self findbestcovernode();

  if(isDefined(var_0)) {
    self.goalradius = 32;
    self.goalheight = 96;
    self setgoalnode(var_0);
    self waittill("goal");
    self.goalradius = 800;
  }
}

stealth_2_movement() {
  level endon("clear_to_enter_cave");
  common_scripts\utility::flag_wait("_stealth_spotted");
  maps\ship_graveyard_util::volume_waittill_no_axis("stealth_2_area_1_volume", 1);
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("stealth_2_moveup_1"));
}

delay_drop_boat() {
  wait(randomfloatrange(4, 7));

  if(!common_scripts\utility::flag("clear_to_enter_cave")) {
    foreach(var_1 in level.middle_boat.balloons) {
      if(isDefined(var_1) && isDefined(var_1.collision))
        var_1.collision notify("pop");
    }
  }
}

stealth_2_middle_boat_think() {
  common_scripts\utility::flag_init("middle_boat_fell");
  var_0 = common_scripts\utility::get_target_ent("stealth_2_middle_boat");
  level.middle_boat = var_0;
  var_1 = var_0 common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_call(var_1, ::linkto, var_0);
  var_2 = [];
  var_3 = undefined;
  var_4 = getEntArray(var_0.target, "targetname");

  foreach(var_6 in var_4) {
    if(var_6.script_parameters == "balloon") {
      var_2 = common_scripts\utility::array_add(var_2, var_6);
      continue;
    }

    if(var_6.script_parameters == "target_pos")
      var_3 = var_6;
  }

  level.middle_boat.balloons = var_2;
  common_scripts\utility::flag_wait("start_stealth_area_2");
  common_scripts\utility::array_thread(var_2, ::middle_boat_balloon_think, var_2);
  level waittill("middle_boat_pop");
  var_8 = common_scripts\utility::get_target_ent("middle_ship_hurttrigger");
  var_8 enablelinkto();
  var_8 linkto(var_0);
  var_8 thread maps\ship_graveyard_util::trigger_hurt();

  if(!common_scripts\utility::flag("_stealth_spotted")) {
    var_9 = getaiarray("axis");

    foreach(var_11 in var_9)
    var_11.favoriteenemy = level.player;
  }

  var_0 connectpaths();
  var_13 = 5;
  var_0 thread middle_boat_audio_explode_crash(var_13);
  var_0 maps\ship_graveyard_util::moveto_rotateto(var_3, var_13, 3, 0);
  earthquake(0.5, 1.0, var_0.origin, 3000);
  common_scripts\utility::exploder("plane_wreck_impact");
  var_8 delete();
  var_0 disconnectpaths();
  common_scripts\utility::flag_set("middle_boat_fell");
}

middle_boat_audio_explode_crash(var_0) {
  thread maps\_utility::play_sound_on_entity("scn_middle_airliner_fall");
  wait(var_0 - 0.766);
  thread maps\_utility::play_sound_on_entity("scn_middle_airliner_crash");
}

middle_boat_balloon_think(var_0) {
  self.collision = common_scripts\utility::get_linked_ent();
  self.collision setCanDamage(1);
  var_1 = self.collision common_scripts\utility::waittill_any_return("damage", "pop");

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isDefined(var_3.collision))
      var_3.collision notify("pop");
  }

  if(isDefined(var_1) && var_1 != "damage")
    wait(randomfloatrange(0.2, 0.4));

  playFX(common_scripts\utility::getfx("shpg_underwater_bubble_explo"), self.origin);
  level notify("middle_boat_pop");
  self.collision delete();
  common_scripts\utility::waitframe();
  self delete();
}

cave_flashlight_logic() {
  for(;;) {
    common_scripts\utility::flag_wait("flashlight_on");
    level.player notify("toggle_flashlight_on");
    common_scripts\utility::flag_waitopen("flashlight_on");
    level.player notify("toggle_flashlight_off");
  }
}

sonar_approach() {
  level.baker endon("start_weld");
  maps\ship_graveyard_util::baker_noncombat();
  var_0 = common_scripts\utility::get_target_ent("baker_cave_path");
  level.baker setgoalpos(var_0.origin);
  maps\ship_graveyard_util::baker_glint_on();
  level.baker thread kill_lookat_on_cave_enter();

  while(!common_scripts\utility::flag("inside_cave") && distance(level.player.origin, (708, -59172, 277.9)) > 300) {
    if(maps\_utility::player_looking_at(level.baker.origin, 0.8) && distance(level.player.origin, level.baker.origin) < 300) {
      break;
    }

    wait 0.1;
  }

  var_0 = var_0 common_scripts\utility::get_target_ent();
  level.baker thread waittill_goal_and_set_flag_to_cave();
  level.baker maps\_utility::follow_path_and_animate(var_0);
  level.baker.goalradius = 196;
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_cave_path_2"), 150);
  level.baker.goalradius = 256;
  common_scripts\utility::flag_set("end_of_cave_path");
}

kill_lookat_on_cave_enter() {
  common_scripts\utility::flag_wait("inside_cave");
  self notify("timeout");
}

waittill_goal_and_set_flag_to_cave() {
  self waittill("goal");
  common_scripts\utility::flag_set("go_into_cave_vo");
}

cave_dialogue() {
  common_scripts\utility::flag_wait_any("to_cave_vo_begin", "cave_sonar");

  if(common_scripts\utility::flag("to_cave_vo_begin") && !common_scripts\utility::flag("cave_sonar")) {
    wait 2;
    maps\_utility::smart_radio_dialogue("shipg_hsh_looksliketheresan");
    wait 2;
    common_scripts\utility::flag_wait("go_into_cave_vo");
    maps\_utility::smart_radio_dialogue("shipg_hsh_okcheckyourregulator");
    wait 2;
    common_scripts\utility::flag_wait("inside_cave");
    maps\_utility::smart_radio_dialogue("shipg_hsh_alrightweregoingfurther");
  }

  thread cave_dialogue_2();
  level endon("stop_cave_dialogue_1");
  wait 3;
}

cave_dialogue_2() {
  level endon("player_ready_to_weld");
  maps\_utility::trigger_wait_targetname("sonat_boat_cave_spawn");
  level notify("stop_cave_dialogue_1");
  wait 1.5;

  if(distance(level.baker.origin, level.player.origin) < 1000) {
    maps\_utility::smart_radio_dialogue("shipg_bkr_theresheis");
    wait 1.5;
    maps\_utility::smart_radio_dialogue("shipg_bkr_movingtoengage");
    wait 3;
  }

  maps\_utility::smart_radio_dialogue("shipg_orb_heavysonarblasts");
  maps\_utility::smart_radio_dialogue("shipg_orb_waterpressure");
  maps\_utility::smart_radio_dialogue("shipg_orb_proceedwithcaution");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_wilco");
  wait 1;

  while(distance(level.baker.origin, level.weld_use_trigger.origin) > 1000)
    wait 0.25;

  maps\_utility::smart_radio_dialogue("shipg_hsh_aintnowaywe");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("shipg_hsh_weregonnahaveto");
}

cave_dust() {
  common_scripts\utility::flag_wait("cave_sonar");
  level endon("stop_cave_dust");
  var_0 = common_scripts\utility::get_target_ent("cave_volume");
  var_1 = common_scripts\utility::get_target_ent("cave_shake_origin");
  var_2 = maps\_utility::getstructarray_delete("cave_shake_source", "targetname");

  for(;;) {
    common_scripts\utility::flag_wait("cave_sonar");
    wait(randomfloatrange(1, 3));

    if(!level.player istouching(var_0)) {
      continue;
    }
    var_3 = randomfloatrange(0.3, 0.5);
    level notify("sonar_ping_go");
    thread common_scripts\utility::play_sound_in_space("weaponized_sonar_muffled", var_1.origin);
    level.player playrumbleonentity("damage_light");
    cave_shake(var_3, var_2);
    wait(randomfloatrange(3, 6));
  }
}

cave_shake(var_0, var_1, var_2) {
  var_1 = sortbydistance(var_1, level.player.origin);
  var_3 = 0;
  wait 0.2;
  earthquake(var_0, randomfloatrange(0.5, 1), level.player.origin, 1024);

  if(isDefined(var_2) && var_1.size > 0)
    thread common_scripts\utility::play_sound_in_space(var_2, var_1[0].origin);

  foreach(var_5 in var_1) {
    if(maps\_utility::within_fov_2d(level.player.origin, level.player.angles, var_5.origin, 0.6)) {
      if(common_scripts\utility::cointoss()) {
        if(!isDefined(var_5.script_fxid))
          var_5.script_fxid = "cave_ceiling_silt_knockoff";

        var_6 = randomfloatrange(0, 2.5);
        maps\_utility::delaythread(var_6, common_scripts\utility::play_sound_in_space, "cave_debris", var_5.origin);
        common_scripts\utility::noself_delaycall(var_6, ::playfx, common_scripts\utility::getfx(var_5.script_fxid), var_5.origin);
        var_3 = var_3 + 1;
      }
    }

    if(var_3 > 5) {
      break;
    }
  }
}

sonar_boat_cave_think() {
  wait 3;
  common_scripts\utility::flag_clear("cave_sonar");
  wait 10;
  common_scripts\utility::flag_set("cave_sonar");
}

sonar_boat_cave_quake() {
  level.sonar_boat = self;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = (0, 0, 1024);
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = common_scripts\utility::spawn_tag_origin();
  level.sonar_quake_org = var_2;
  var_2 thread boat_quake(var_0);
  var_2 linkto(self);
  var_1 linkto(self);
  var_1 playrumblelooponentity("littoral_ship_rumble");
  maps\_utility::trigger_wait_targetname("cave_past_hole");
  var_0 moveto((0, 0, 300), 3);
  var_1 moveto(var_1.origin + (0, 0, 2000), 4);
  common_scripts\utility::flag_wait("start_sonar");
  waittillframeend;
  common_scripts\utility::flag_wait("welding_done");
  var_2 unlink();
  var_2 moveto(level.sonar_boat.origin, 2);
  var_1 moveto(level.sonar_boat.origin, 3);
  var_1 waittill("movedone");
  var_2 linkto(level.sonar_boat);
  var_1 linkto(level.sonar_boat);
  var_0 moveto((0, 0, 1200), 6);
  level.sonar_boat waittill("death");
  var_2 delete();
  var_1 stoprumble("littoral_ship_rumble");
  var_1 delete();
}

boat_quake(var_0) {
  self endon("death");

  for(;;) {
    earthquake(0.3, 0.2, self.origin, var_0.origin[2]);
    wait 0.1;
  }
}

baker_weld_door() {
  var_0 = common_scripts\utility::get_target_ent("weld_use_trigger");
  var_0 sethintstring(&"SHIP_GRAVEYARD_HINT_WELD");
  var_0 common_scripts\utility::trigger_off();
  var_1 = common_scripts\utility::get_target_ent("baker_weld_node_final");
  var_2 = common_scripts\utility::get_target_ent("baker_weld_door_L");
  var_2.animname = "door_L";
  var_2 maps\_anim::setanimtree();
  weld_door_setup(var_2);
  var_3 = common_scripts\utility::get_target_ent("baker_weld_door_R");
  var_3.animname = "door_R";
  var_3 maps\_anim::setanimtree();
  weld_door_setup(var_3);
  var_4 = spawn("script_model", var_2.origin);
  var_4.origin = var_2.origin;
  var_4.angles = var_2.angles;
  var_4 setModel("shpg_wrkdoor_a1_normal");
  var_4 linkto(var_2);
  var_5 = maps\_utility::spawn_anim_model("pipe");
  var_1 maps\_anim::anim_first_frame([var_2, var_3, var_5], "weld_approach");
  common_scripts\utility::flag_wait("inside_cave");
  var_6 = 16;
  var_7 = [];
  var_8 = getEntArray("barrel_col", "targetname");

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = spawn("script_model", (0, 0, 0));
    var_10 setModel("com_barrel_benzin2");
    var_10.animname = "barrel";
    var_10 maps\_anim::setanimtree();
    var_10.animname = "barrel_" + var_9;
    var_7 = common_scripts\utility::array_add(var_7, var_10);
    var_8[var_9].origin = var_7[var_9].origin;
    var_8[var_9].angles = var_7[var_9].angles;
    var_8[var_9] linkto(var_7[var_9]);
  }

  var_1 maps\_anim::anim_first_frame(var_7, "weld_breach");
  common_scripts\utility::flag_wait("end_of_cave_path");

  if(maps\_utility::is_gen4())
    thread maps\_utility::lerp_saveddvar("r_tessellationFactor", 15, 8);

  var_1 maps\_anim::anim_reach_solo(level.baker, "weld_approach");
  level.baker notify("start_weld");
  level.baker notify("stop_path");
  var_11 = maps\_player_rig::get_player_rig();
  var_11 hide();
  var_11 dontcastshadows();
  var_12 = common_scripts\utility::spawn_tag_origin();
  var_12.origin = var_11.origin;
  var_12.angles = var_11.angles;
  var_13 = spawn("script_model", var_2.origin);
  var_13.angles = var_2.angles;
  var_13 setModel(var_2.model + "_obj");
  var_13 hide();
  var_13 linkto(var_2);
  var_13.top = var_4;
  var_0 common_scripts\utility::trigger_on();
  var_14 = maps\_utility::spawn_anim_model("torch_f", (0, 0, 0));
  var_15 = maps\_utility::spawn_anim_model("torch_p", (0, 0, 0));
  var_16 = common_scripts\utility::spawn_tag_origin();
  var_16 linkto(var_15, "j_gun", (8, 0, 0), (0, 0, 0));
  level.player.torch_fx_org = var_16;
  var_17 = common_scripts\utility::spawn_tag_origin();
  var_17 linkto(var_14, "j_gun", (8, 0, 0), (0, 0, 0));
  level.baker.torch_fx_org = var_17;
  var_16 thread maps\ship_graveyard_fx::weld_breach_fx(var_15, "");
  var_17 thread maps\ship_graveyard_fx::weld_breach_fx(var_14, "_npc");
  maps\_utility::delaythread(1, ::player_approach_weld, var_1, var_11, var_12, var_2, var_13, var_15);

  if(!maps\ship_graveyard_util::greenlight_check())
    var_1 maps\_anim::anim_single([level.baker, var_3, var_2, var_14, var_5], "weld_approach");
  else {
    var_18 = level.baker maps\_utility::getanim("weld_approach");
    var_19 = var_3 maps\_utility::getanim("weld_approach");
    var_20 = var_2 maps\_utility::getanim("weld_approach");
    var_21 = var_14 maps\_utility::getanim("weld_approach");
    var_22 = var_5 maps\_utility::getanim("weld_approach");
    var_23 = 0.17;
    var_1 thread maps\_anim::anim_single([level.baker, var_3, var_2, var_14, var_5], "weld_approach");
    var_24 = getanimlength(var_18);
    wait 0.5;
    level.baker setanimtime(var_18, var_23);
    var_3 setanimtime(var_19, var_23);
    var_2 setanimtime(var_20, var_23);
    var_14 setanimtime(var_21, var_23);
    var_5 setanimtime(var_22, var_23);
    wait(var_24 * (1 - var_23));
  }

  common_scripts\utility::flag_set("ai_ready_to_weld");
  var_1 thread maps\_anim::anim_loop([level.baker, var_14], "weld_breach_idle");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("player_ready_to_weld");
  var_25 = common_scripts\utility::get_target_ent("sonar_player_blocker");
  var_25 delete();
  common_scripts\utility::waitframe();
  var_1 notify("stop_loop");
  maps\_utility::delaythread(6.5, common_scripts\utility::exploder, "barrel_collapse_dust");
  var_1 thread maps\_anim::anim_single(var_7, "weld_breach");
  var_1 thread maps\_anim::anim_single_solo_run(level.baker, "weld_breach");
  var_26 = common_scripts\utility::get_target_ent("baker_path_after_weld");
  level.baker.goalradius = 96;
  level.baker setgoalpos(var_26.origin);
  level.baker maps\_utility::disable_exits();
  var_4 thread door_l_modelswap(var_2);
  var_1 maps\_anim::anim_single([var_3, var_2, var_11, var_15, var_14], "weld_breach");

  if(maps\_utility::is_gen4())
    thread maps\_utility::lerp_saveddvar("r_tessellationFactor", 60, 8);

  common_scripts\utility::flag_set("welding_done");
  level.player unlink();
  var_11 delete();
  var_12 delete();
  var_14 delete();
  var_15 delete();
  var_16 delete();
  var_17 delete();
  level.player enableweapons();
  level.player allowmelee(1);
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_thisway");
  maps\_utility::autosave_by_name("sonar");
  common_scripts\utility::flag_wait("start_new_trench");

  foreach(var_10 in var_2.brushes)
  var_10 delete();

  foreach(var_10 in var_3.brushes)
  var_10 delete();

  var_2 delete();
  var_3 delete();

  foreach(var_10 in var_8)
  var_10 delete();

  foreach(var_10 in var_7)
  var_10 delete();

  var_7 = undefined;
  var_4 delete();
  var_5 delete();
}

door_l_modelswap(var_0) {
  var_0 waittillmatch("single anim", "door_cut_1");
  self setModel("shpg_wrkdoor_a1_broken01");
  var_0 waittillmatch("single anim", "door_cut_2");
  self setModel("shpg_wrkdoor_a1_broken02");
}

player_approach_weld(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.player allowmelee(0);
  var_6 = common_scripts\utility::get_target_ent("weld_use_trigger");
  var_4 show();
  var_3 hide();
  var_0 maps\_anim::anim_first_frame([var_1], "weld_approach");
  var_6 waittill("trigger");
  maps\ship_graveyard_util::baker_glint_off();
  var_6 common_scripts\utility::trigger_off();
  var_3 hudoutlinedisable();
  var_3 show();
  var_4 delete();
  var_7 = (0, 0, 48);
  var_2 linkto(var_1, "tag_player", var_7, (0, 0, 0));
  level.player disableweapons();
  level.player playerlinktoblend(var_2, "tag_origin", 1, 0.1, 0);
  var_1 common_scripts\utility::delaycall(1, ::show);
  thread open_up_player_view_during_weld(var_2);
  level.player notify("toggle_flashlight_off");
  var_0 maps\_anim::anim_single([var_1, var_5], "weld_approach");
  common_scripts\utility::flag_set("player_ready_to_weld");

  if(!common_scripts\utility::flag("ai_ready_to_weld")) {
    var_0 thread maps\_anim::anim_loop([var_1, var_5], "weld_breach_idle");
    common_scripts\utility::flag_wait("ai_ready_to_weld");
    var_1 notify("stop_loop");
    var_5 notify("stop_loop");
  }
}

open_up_player_view_during_weld(var_0) {
  level waittill("script 87");
  level.player playerlinktodelta(var_0, "tag_origin", 1, 0, 0, 0, 1);
  var_1 = 4;
  level.player lerpviewangleclamp(var_1, var_1 * 0.5, var_1 * 0.5, 25, 15, 30, 15);
  common_scripts\utility::flag_wait("ai_ready_to_weld");
  common_scripts\utility::flag_wait("player_ready_to_weld");
  wait 10.1;
  level.player playerlinktoblend(var_0, "tag_origin", 1, 0.5, 0);
}

weld_door_setup(var_0) {
  var_1 = var_0 common_scripts\utility::get_linked_ents();
  var_0.brushes = var_1;
  common_scripts\utility::array_call(var_1, ::linkto, var_0);
}

first_sonar_ping() {
  common_scripts\utility::flag_wait("welding_done");

  if(maps\ship_graveyard_util::greenlight_check() && level.start_point == "e3") {
    level waittill("e3_black_scene_done");
    wait 1.25;
  }

  thread weaponized_sonar_chargeup();
  common_scripts\utility::flag_wait("super_sonar_ping");
  level notify("sonar_ping_go");
  thread common_scripts\utility::play_sound_in_space("weaponized_sonar_near", level.sonar_boat.origin);
  wait 0.2;
  common_scripts\utility::exploder(1);
  wait 0.3;
  common_scripts\utility::noself_delaycall(0.1, ::earthquake, 0.3, 1, level.player.origin, 512);
  level.player common_scripts\utility::delaycall(0.1, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(0.3, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(0.6, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(0.7, ::playrumbleonentity, "damage_light");
  wait 1;
  level.sonar_boat vehicle_setspeed(6, 3, 1);
  level.sonar_boat common_scripts\utility::delaycall(6, ::vehicle_setspeed, 1, 1, 1);
  var_0 = level.player common_scripts\utility::spawn_tag_origin();
  var_0.angles = level.player getplayerangles();
  thread baker_sonar_path_dialogue();
  thread baker_sonar_path();
  var_1 = getdvarint("player_swimSpeed");
  earthquake(0.7, 1, level.player.origin, 512);
  var_2 = 30 * anglesToForward(level.player.angles);
  level.player disableweapons();
  level.player allowsprint(0);
  level.player playrumbleonentity("damage_heavy");
  level.player common_scripts\utility::delaycall(0.1, ::playrumbleonentity, "damage_heavy");
  level.player common_scripts\utility::delaycall(0.2, ::playrumbleonentity, "damage_heavy");
  level.player common_scripts\utility::delaycall(0.3, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(0.4, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(0.6, ::playrumbleonentity, "damage_light");
  level.player shellshock("sonar_ping", 5);
  level.player dodamage(90, level.player.origin);
  level.player common_scripts\utility::delaycall(2, ::unlink);
  wait 2;
  wait 2;
  level.player enableweapons();
  wait 1;
  level.player allowsprint(1);
  thread maps\ship_graveyard_util::track_hint_sprint();

  if(!maps\ship_graveyard_util::greenlight_check())
    thread maps\_utility::display_hint_timeout("hint_sprint", 4);

  common_scripts\utility::flag_set("start_sonar_pings");
}

baker_sonar_path() {
  level.baker endon("stop_sonar_paths");
  level.baker maps\_utility::disable_exits();
  level.baker maps\_anim::anim_generic_run(level.baker, "sonar_hit");
  level.baker maps\_utility::delaythread(0.5, maps\_utility::enable_exits);
  level.baker.goalradius = 128;
  thread baker_sonar_speed_change();
  level.baker.movetransitionrate = 1.7;
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("sonar_path_1"), 450);
  common_scripts\utility::flag_init("sonar_baker_waiting");
  var_0 = common_scripts\utility::get_target_ent("sonar_wait_at_container");
  level.sonar_node = var_0;
  var_0 maps\_anim::anim_generic_reach(level.baker, "swimming_aiming_move_to_cover_l1_r90");
  thread baker_wait_at_container();
  common_scripts\utility::flag_wait("sonar_clear_to_go");
  wait 2.5;
  level.baker.moveplaybackrate = 1.7;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  common_scripts\utility::flag_wait("sonar_baker_waiting");
  level.sonar_node notify("stop_loop");
  level.baker maps\_utility::disable_exits();
  level.sonar_node thread maps\_anim::anim_generic_run(level.baker, "swimming_cover_l1_to_aiming_move_l90");
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("sonar_path_3"), 450);
  level.baker maps\_utility::enable_exits();
  common_scripts\utility::flag_wait("sonar_clear_to_go");
  wait 1;
  thread maps\_utility::smart_radio_dialogue("shipg_hsh_intothatlighthouse");
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("sonar_path_4"), 450);
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("sonar_path_5"), 450);
  level.sonar_node = undefined;
}

baker_wait_at_container() {
  level.sonar_node maps\_anim::anim_generic(level.baker, "swimming_aiming_move_to_cover_l1_r90");
  level.sonar_node.origin = level.baker.origin;
  level.sonar_node.angles = level.baker.angles;
  level.sonar_node thread maps\_anim::anim_generic_loop(level.baker, "swimming_cover_l1_idle");
  common_scripts\utility::flag_set("sonar_baker_waiting");
}

baker_sonar_path_dialogue() {
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_pain2");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_gettocover");
  wait 5;

  if(player_safe_from_sonar())
    maps\_utility::autosave_by_name("sonar");

  maps\_utility::smart_radio_dialogue("shipg_bkr_cannotengage");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("shipg_orb_pulloutimmediately");
  wait 0.3;
  maps\_utility::smart_radio_dialogue("shipg_bkr_missionistoast");
  setsaveddvar("player_swimSpeed", 90);
  setsaveddvar("player_sprintUnlimited", "1");
}

baker_sonar_speed_change() {
  level.baker.moveplaybackrate = 1.7;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker waittill("goal");
  wait 5.5;
  level.baker.moveplaybackrate = 1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
}

weaponized_sonar_chargeup() {
  thread common_scripts\utility::play_sound_in_space("weaponized_sonar_chargeup", level.sonar_boat.origin);
  wait 1.8;
}

weaponized_sonar_pings() {
  common_scripts\utility::flag_wait("start_sonar_pings");
  level.sonar_exploder = 1;
  level.sonar_times_hit = 0;
  level.sonar_ping_delay = 8;
  var_0 = 1.9;
  common_scripts\utility::array_thread(getEntArray("sonar_fire_trigger", "targetname"), ::sonar_fire_trigger_think);
  common_scripts\utility::array_thread(getEntArray("sonar_safe_trigger", "targetname"), ::sonar_safe_trigger_think);
  level.sonar_boat endon("death");
  level endon("mine_moveup");
  wait 1;

  for(;;) {
    level common_scripts\utility::waittill_notify_or_timeout("weaponized_ping", level.sonar_ping_delay);
    common_scripts\utility::flag_waitopen("pause_sonar_pings");
    weaponized_sonar_chargeup();
    wait 0.75;
    level notify("sonar_ping_go");
    common_scripts\utility::exploder(level.sonar_exploder);
    thread common_scripts\utility::play_sound_in_space("weaponized_sonar_near", level.sonar_boat.origin);
    wait(var_0);
    common_scripts\utility::flag_set("sonar_clear_to_go");
    maps\_utility::delaythread(1, common_scripts\utility::flag_clear, "sonar_clear_to_go");
    thread sonar_movers();

    if(player_safe_from_sonar()) {
      earthquake(0.3, 1, level.player.origin, 512);
      level.player playrumbleonentity("damage_light");
      level.player shellshock("sonar_ping_light", 2);
      continue;
    }

    earthquake(0.6, 1, level.player.origin, 512);
    level.player playrumbleonentity("damage_heavy");
    level.player shellshock("sonar_ping", 6);
    var_1 = 200;

    if(level.gameskill > 1)
      var_1 = 100;

    level.player dodamage(var_1, level.player.origin);

    if(level.player getcurrentweapon() != "underwater_torpedo" && level.player getcurrentweapon() != "remote_torpedo_tablet") {
      level.player common_scripts\utility::_disableweapon();
      level.player maps\_utility::delaythread(6, common_scripts\utility::_enableweapon);
    }

    level.sonar_times_hit++;

    if(level.sonar_times_hit > 1)
      level.player kill();

    wait 4;
  }
}

player_safe_from_sonar() {
  if(common_scripts\utility::flag("torpedo_out"))
    return 1;

  var_0 = getEntArray("sonar_safe_trigger", "targetname");

  foreach(var_2 in var_0) {
    if(level.player istouching(var_2))
      return 1;
  }

  return 0;
}

sonar_safe_trigger_think() {
  for(;;) {
    self waittill("trigger");

    if(isDefined(self.script_index))
      level.sonar_exploder = self.script_index;

    wait 0.5;
  }
}

sonar_fire_trigger_think() {
  self waittill("trigger");
  maps\_utility::script_delay();
  level notify("weaponized_ping");
}

sonar_movers() {
  var_0 = getEntArray("sonar_ping_mover", "targetname");

  foreach(var_2 in var_0)
  var_2 thread sonar_mover_think();
}

sonar_wreck_think() {
  var_0 = common_scripts\utility::get_target_ent("sonar_big_wreck_start");
  var_1 = getent("main_lighthouse", "script_noteworthy");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = getglassarray("lighthouse_glass");

  foreach(var_5 in var_3)
  deleteglass(var_5);

  var_7 = getEntArray("sonar_big_wreck_d", "targetname");

  foreach(var_9 in var_7)
  var_9 linkto(var_1);

  var_2.target = "sonar_wreck_move";
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.script_wait = 2.5;
  var_2.script_radius = 1500;
  var_1 linkto(var_2);
  level.sonar_wreck = var_1;
  level.sonar_wreck.glass = spawn("script_model", level.sonar_wreck.origin);
  level.sonar_wreck.glass.angles = level.sonar_wreck.angles;
  level.sonar_wreck.glass setModel("shpg_lighthouse_glass");
  level.sonar_wreck.glass linkto(level.sonar_wreck);
  level.sonar_wreck.top = spawn("script_model", level.sonar_wreck.origin);
  level.sonar_wreck.top.angles = level.sonar_wreck.angles;
  level.sonar_wreck.top setModel("shpg_lighthouse_top");
  level.sonar_wreck.top linkto(level.sonar_wreck);
  level.sonar_wreck.damage_states = [];
  level.sonar_wreck.mover = var_2;
  var_11 = [];

  for(var_12 = 0; var_12 < var_7.size; var_12++)
    var_11[var_12] = [];

  foreach(var_9 in var_7) {
    var_11[var_9.script_index] = common_scripts\utility::array_add(var_11[var_9.script_index], var_9);
    var_9 hide();
    var_9 notsolid();
  }

  for(var_12 = 0; var_12 < var_11.size; var_12++) {
    if(var_11[var_12].size > 0) {
      level.sonar_wreck.damage_states[var_12] = var_11[var_12];
      continue;
    }

    break;
  }

  if(level.sonar_wreck.damage_states.size < 0) {
    foreach(var_9 in level.sonar_wreck.damage_states[0]) {
      var_9 show();
      var_9 solid();
    }
  }

  common_scripts\utility::flag_wait("start_sonar_mines");
  level notify("weaponized_ping");
  level.sonar_ping_delay = 2;
  wait 0.5;
  var_17 = 0;

  while(var_17 <= level.sonar_wreck.damage_states.size) {
    common_scripts\utility::flag_wait("sonar_clear_to_go");

    if(var_17 > 0) {
      foreach(var_9 in level.sonar_wreck.damage_states[var_17 - 1]) {
        var_9 hide();
        var_9 notsolid();
      }

      foreach(var_9 in level.sonar_wreck.damage_states[var_17]) {
        var_9 show();
        var_9 solid();

        if(isDefined(var_9.script_noteworthy)) {
          var_21 = var_9.origin - level.player.origin;
          var_21 = vectortoangles(var_21);
          var_21 = anglesToForward((var_21[0], var_21[1] * 1.3, var_21[2]));
          var_21 = vectornormalize(var_21);
          playFX(common_scripts\utility::getfx("sm_dust"), var_9.origin);
          var_9 unlink();
          var_9 rotatevelocity(var_21 * common_scripts\utility::random([50, 12.5, 20.0, 32.5]), 10);
          var_9 movegravity(var_21 * common_scripts\utility::random([45.0, 57.5, 60.0, 22.5]), 20);
          var_9 notsolid();
        }
      }
    } else {
      common_scripts\utility::exploder("lighthouse_glass_break");
      level.sonar_wreck.glass setModel("shpg_lighthouse_glass_broken");
      var_23 = common_scripts\utility::getstruct("lighthouse_break_org", "targetname");
      common_scripts\utility::play_sound_in_space("scn_shipg_lighthouse_wood_hit", var_23.origin);
    }

    common_scripts\utility::flag_set("first_damage_state");
    var_17++;
    var_24 = getent("inside_sonar_boat", "script_noteworthy");

    if(isDefined(var_24)) {
      if(level.player istouching(var_24)) {
        level.sonar_ping_delay = 7;
        level.sonar_times_hit = 0;
      } else if(!player_safe_from_sonar())
        level.player kill();

      var_24 delete();
    }

    wait 1.1;
  }
}

sonar_glass_destroy(var_0) {
  wait(randomfloatrange(0, 0.5));
  var_1 = getglassorigin(var_0);
  deleteglass(var_0);
}

sonar_mover_think() {
  if(!isDefined(self.done_linking)) {
    self.linked = common_scripts\utility::get_linked_ents();
    common_scripts\utility::array_call(self.linked, ::linkto, self);
    self.done_linking = 1;

    if(!isDefined(self.script_wait))
      self.script_wait = 0.75;

    if(!isDefined(self.script_radius))
      self.script_radius = 400;
  }

  maps\_utility::script_delay();
  var_0 = common_scripts\utility::get_target_ent();
  var_1 = var_0;

  if(isDefined(var_0.target))
    var_1 = var_0 common_scripts\utility::get_target_ent();

  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = self.script_wait;

  if(var_1 != var_0)
    thread common_scripts\utility::play_sound_in_space(var_1.script_sound, var_1.origin);

  thread common_scripts\utility::play_sound_in_space("metal_sonar_hit", self.origin);
  self moveto(var_0.origin, var_4, 0, var_4);
  self rotateto(var_0.angles, var_4, 0, var_4);
  wait(var_4);
  self moveto(var_2, var_4, var_4, 0);
  self rotateto(var_3, var_4, var_4, 0);
  wait(var_4);
  earthquake(0.35, 0.5, self.origin, self.script_radius);
}

sonar_door_think() {
  var_0 = common_scripts\utility::get_target_ent("sonar_cargo_door");
  var_0.linked = var_0 common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_call(var_0.linked, ::linkto, var_0);
  var_1 = common_scripts\utility::get_target_ent("sonar_cargo_door_start");
  var_2 = common_scripts\utility::get_target_ent("sonar_cargo_door_slam");
  var_3 = var_2 common_scripts\utility::get_target_ent();
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_4 = 1.2;

  for(;;) {
    common_scripts\utility::flag_wait("sonar_clear_to_go");
    var_5 = 0.3 * var_4;
    var_0 moveto(var_2.origin, var_5, var_5, 0);
    var_0 rotateto(var_2.angles, var_5, var_5, 0);
    wait(var_5);
    var_5 = 0.4 * var_4;
    var_0 moveto(var_3.origin, var_5, 0, var_5);
    var_0 rotateto(var_3.angles, var_5, 0, var_5);
    wait(var_5);
    var_5 = 0.35 * var_4;
    var_0 moveto(var_2.origin, var_5, var_5 / 2, var_5 / 2);
    var_0 rotateto(var_2.angles, var_5, var_5 / 2, var_5 / 2);
    wait(var_5);
    var_5 = 0.6 * var_4;
    var_0 moveto(var_3.origin, var_5, var_5 / 2, var_5 / 2);
    var_0 rotateto(var_3.angles, var_5, var_5 / 2, var_5 / 2);
    wait(var_5);

    if(!common_scripts\utility::flag("sonar_door_fly")) {
      var_5 = 2 * var_4;
      var_0 moveto(var_1.origin, var_5, 0, var_5);
      var_0 rotateto(var_1.angles, var_5, 0, var_5);
      wait(var_5);
      continue;
    }

    var_0 thread maps\_utility::play_sound_on_entity("scn_shipg_mtl_door_flap");
    var_5 = 1.75;
    var_0 rotateto((15, 0, 0), var_5, 0, var_5);
    wait(var_5 - 0.4);
    var_1 = common_scripts\utility::get_target_ent("sonar_cargo_door_fly");
    var_5 = 3;
    var_0 moveto(var_1.origin, var_5, 0, 0);
    var_0 rotateto(var_1.angles, var_5, 0, 0);
    var_0 moveto((2601, -60053, 157), var_5, 0, 0);
    var_0 rotateto((25.6015, 355.278, 3.16485), var_5, 0, 0);
    wait(var_5);
    var_5 = 3;
    var_0 moveto((2609, -60087, 154), var_5, 0, 0);
    var_0 rotateto((20.7217, 29.665, 93.757), var_5, 0, 0);
    wait(var_5);
    var_5 = 2;
    var_0 moveto((2600, -60098, 111), var_5, 0, var_5);
    var_0 rotateto((334.31, 34.0427, 92.4214), var_5, 0, var_5);
    common_scripts\utility::array_call(var_0.linked, ::delete);
    break;
  }
}

sonar_boat_think() {
  var_0 = level.sonar_boat;
  common_scripts\utility::flag_wait("welding_done");
  maps\_utility::trigger_wait_targetname("sonar_boat_allow_spawn");
  var_0 thread maps\ship_graveyard_util::lcs_setup();
  var_1 = getvehiclenode("sonar_boat_cont", "targetname");
  var_0 vehicle_teleport(var_1.origin, var_1.angles);
  var_0.target = "sonar_boat_cont";
  var_0 thread maps\_vehicle_code::getonpath();
  var_0 resumespeed(2);
  maps\_utility::delaythread(1, ::weaponized_sonar_chargeup);
  thread boat_teleport(var_0);
  var_0 thread sonar_ping_light_think();
}

sonar_ping_light_think(var_0) {
  self endon("death");

  for(;;) {
    level waittill("sonar_ping_go");
    thread sonar_ping_light();
  }
}

sonar_boat_e3() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("sonar_boat");
  var_0 thread maps\ship_graveyard_util::littoral_ship_lights();
  level.sonar_boat = var_0;
  level.sonar_boat vehicle_turnengineoff();
  common_scripts\utility::flag_wait("welding_done");
  maps\_utility::trigger_wait_targetname("sonar_boat_allow_spawn");
  var_0 thread maps\_vehicle::gopath();
  level.sonar_boat vehicle_turnengineoff();
  thread boat_teleport(var_0);
  var_0 thread sonar_ping_light_think();
}

sonar_boat_one_shot_audio() {
  maps\_utility::trigger_wait_targetname("sonat_boat_cave_spawn");
  level thread common_scripts\utility::play_sound_in_space("scn_lcs_passby_overhead_groans", (1516, -58253, 362));
}

sonar_boat_audio(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = (1545.29, -57932.6, 560);
  var_2.origin = (1301.13, -57170.8, 560);
  var_3.origin = (1056.96, -56408.9, 560);
  var_4.origin = (921.01, -55657.1, 560);
  var_5.origin = (730.553, -55718.2, 560);
  var_1 playLoopSound("scn_sub_fronts_lp");
  var_2 playLoopSound("scn_sub_engine_lp");
  var_3 playLoopSound("scn_sub_rumble_lp");
  var_4 playLoopSound("scn_sub_prop_l_lp");
  var_5 playLoopSound("scn_sub_prop_r_lp");
  thread scale_lcs_audio_fade(var_1, var_2, var_3, var_4, var_5);

  while(!isDefined(level.sonar_boat))
    wait 0.1;

  level.sonar_boat vehicle_turnengineoff();
  var_1 linkto(level.sonar_boat, "tag_splash_front", (0, 0, 0), (0, 0, 0));
  var_2 linkto(level.sonar_boat, "tag_splash_front", (-800, 0, 0), (0, 0, 0));
  var_3 linkto(level.sonar_boat, "tag_splash_front", (-1600, 0, 0), (0, 0, 0));
  var_4 linkto(level.sonar_boat, "tag_splash_back", (0, 100, 0), (0, 0, 0));
  var_5 linkto(level.sonar_boat, "tag_splash_back", (0, -100, 0), (0, 0, 0));
  thread sonar_boat_audio_mover(var_1, var_2, var_3, var_4, var_5);
  common_scripts\utility::flag_wait("player_ready_to_weld");
  common_scripts\utility::flag_wait("ai_ready_to_weld");
  var_6 = 10;
  var_1 moveto(level.sonar_boat gettagorigin("tag_splash_front"), var_6, var_6 * 0.5, var_6 * 0.5);
  var_2 moveto(level.sonar_boat gettagorigin("tag_splash_front") + (-800, 0, 0), var_6, var_6 * 0.5, var_6 * 0.5);
  var_3 moveto(level.sonar_boat gettagorigin("tag_splash_front") + (-1600, 0, 0), var_6, var_6 * 0.5, var_6 * 0.5);
  var_4 moveto(level.sonar_boat gettagorigin("tag_splash_back") + (0, 100, 0), var_6, var_6 * 0.5, var_6 * 0.5);
  var_5 moveto(level.sonar_boat gettagorigin("tag_splash_back") + (0, -100, 0), var_6, var_6 * 0.5, var_6 * 0.5);
  wait(var_6);
  var_1 linkto(level.sonar_boat, "tag_splash_front", (0, 0, 0), (0, 0, 0));
  var_2 linkto(level.sonar_boat, "tag_splash_front", (-800, 0, 0), (0, 0, 0));
  var_3 linkto(level.sonar_boat, "tag_splash_front", (-1600, 0, 0), (0, 0, 0));
  var_4 linkto(level.sonar_boat, "tag_splash_back", (0, 100, 0), (0, 0, 0));
  var_5 linkto(level.sonar_boat, "tag_splash_back", (0, -100, 0), (0, 0, 0));
  common_scripts\utility::flag_wait("sonar_boat_explode");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

scale_lcs_audio_fade(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 5;
  var_0 scalevolume(0);
  var_1 scalevolume(0);
  var_2 scalevolume(0);
  var_3 scalevolume(0);
  var_4 scalevolume(0);
  wait 0.1;
  var_0 scalevolume(1, var_5);
  var_1 scalevolume(1, var_5);
  var_2 scalevolume(1, var_5);
  var_3 scalevolume(1, var_5);
  var_4 scalevolume(1, var_5);
}

sonar_boat_audio_mover(var_0, var_1, var_2, var_3, var_4) {
  level endon("welding_done");
  wait 40;
  var_0 unlink();
  var_1 unlink();
  var_2 unlink();
  var_3 unlink();
  var_4 unlink();
  var_0.old_org = var_0.origin;
  var_1.old_org = var_1.origin;
  var_2.old_org = var_2.origin;
  var_3.old_org = var_3.origin;
  var_4.old_org = var_4.origin;
  var_5 = 500;
  var_6 = 30;

  for(;;) {
    var_0 moveto(var_0.old_org - (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_1 moveto(var_1.old_org - (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_2 moveto(var_2.old_org - (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_3 moveto(var_3.old_org - (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_4 moveto(var_4.old_org - (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    wait(var_6);
    var_0 moveto(var_0.old_org + (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_1 moveto(var_1.old_org + (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_2 moveto(var_2.old_org + (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_3 moveto(var_3.old_org + (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    var_4 moveto(var_4.old_org + (var_5, var_5, 0), var_6, var_6 / 2, var_6 / 2);
    wait(var_6);
  }
}

sonar_boat_audio_e3(var_0) {
  if(level.start_point != "start_sonar" && level.start_point != "start_sonar_mines" && level.start_point != "e3") {
    return;
  }
  while(!isDefined(level.sonar_boat))
    common_scripts\utility::waitframe();

  self vehicle_turnengineoff();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(self, "tag_splash_front", (0, 0, 0), (0, 0, 0));
  var_1 playLoopSound("scn_sub_fronts_lp");
  var_2 linkto(self, "tag_splash_front", (-800, 0, 0), (0, 0, 0));
  var_2 playLoopSound("scn_sub_engine_lp");
  var_3 linkto(self, "tag_splash_front", (-1600, 0, 0), (0, 0, 0));
  var_3 playLoopSound("scn_sub_rumble_lp");
  var_4 linkto(self, "tag_splash_back", (0, 100, 0), (0, 0, 0));
  var_4 playLoopSound("scn_sub_prop_l_lp");
  var_5 linkto(self, "tag_splash_back", (0, -100, 0), (0, 0, 0));
  var_5 playLoopSound("scn_sub_prop_r_lp");
  thread scale_lcs_audio_fade(var_1, var_2, var_3, var_4, var_5);
  common_scripts\utility::flag_wait("sonar_boat_explode");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

update_line(var_0) {
  while(isDefined(var_0)) {
    thread common_scripts\utility::draw_line_for_time(var_0.origin, level.player.origin, 1, 1, 1, 0.05);
    wait 0.05;
  }
}

boat_teleport(var_0) {
  common_scripts\utility::flag_wait("sonar_boat_teleport");
  var_1 = common_scripts\utility::get_target_ent("sonar_boat_teleport");
  var_0 vehicle_teleport(var_1.origin, var_1.angles);
  var_0.target = "sonar_boat_teleport";
  var_0 thread maps\_vehicle_code::getonpath();
  var_0 resumespeed(2);
}

sonar_ping_light() {
  playFXOnTag(common_scripts\utility::getfx("sonar_ping_light"), self, "TAG_SONAR");
  playFXOnTag(common_scripts\utility::getfx("sonar_ping_distortion"), self, "TAG_SONAR");
}

sonar_mines_dialogue() {
  level endon("start_new_trench");
  thread hit_chain_dialogue();
  maps\_utility::smart_radio_dialogue("shipg_bkr_endoftheline");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("shipg_bkr_takeoutthatship");
  common_scripts\utility::flag_wait("first_damage_state");
  level endon("mine_moveup");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("shipg_bkr_thosemines");
  wait 0.2;
  maps\_utility::smart_radio_dialogue("shipg_bkr_shootchains");
  wait 7;

  while(!common_scripts\utility::flag("mine_moveup")) {
    maps\_utility::smart_radio_dialogue("shipg_bkr_chainsonthemines");
    wait 7;
  }
}

torpedo_dialogue() {
  thread torpedo_dialogue_2();
  level endon("player_holding_torpedo");
  maps\_utility::smart_radio_dialogue("shipg_hsh_thereitis");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("shipg_bkr_syncuponme");
}

torpedo_dialogue_2() {
  common_scripts\utility::flag_wait("player_holding_torpedo");
  thread torpedo_dialogue_3();
  level endon("player_on_torpedo");
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_proteuscomingonline");
  wait 0.5;
  thread maps\_utility::smart_radio_dialogue("shipg_hsh_weveonlygotone");
}

torpedo_dialogue_3() {
  common_scripts\utility::flag_wait("player_on_torpedo");
  wait 0.3;
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_illlineitup");
  level waittill("fire_torpedo");
  maps\_utility::smart_radio_dialogue("shipg_bkr_firing");
}

baker_torpedo_position(var_0) {
  var_0 maps\_anim::anim_single([level.baker], "lighthouse_entry");
  var_0 thread maps\_anim::anim_loop([level.baker], "lighthouse_idle");
}

torpedo_the_ship() {
  level.sonar_boat thermaldrawenable();
  level.baker thermaldrawdisable();
  var_0 = getEntArray("torpedo_nets", "targetname");
  common_scripts\utility::array_call(var_0, ::thermaldrawenable);
  thread sonar_mines_boat_reaction();
  var_1 = common_scripts\utility::get_target_ent("lighthouse_node");
  var_2 = level.baker;
  var_3 = getent("grab_torpedo", "targetname");
  level.baker notify("stop_path");
  level.baker notify("stop_sonar_paths");
  var_1 maps\_anim::anim_reach_solo(level.baker, "lighthouse_entry");
  thread torpedo_dialogue();
  thread baker_torpedo_position(var_1);
  var_2 makeusable();
  var_2 thread watch_if_used();
  var_3 common_scripts\utility::trigger_on();
  var_3 thread watch_if_used();

  if(!maps\ship_graveyard_util::greenlight_check()) {
    var_2 sethintstring(&"SHIP_GRAVEYARD_USE_TORPEDO");
    var_3 sethintstring(&"SHIP_GRAVEYARD_USE_TORPEDO");
  }

  common_scripts\utility::flag_wait("grabbed_torpedo");
  var_2 makeunusable();
  var_3 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_set("player_holding_torpedo");
  common_scripts\utility::flag_set("pause_sonar_pings");
  maps\_utility::delaythread(6, common_scripts\utility::flag_clear, "pause_sonar_pings");
  setsaveddvar("player_swimSpeed", 50);
  setsaveddvar("ammoCounterHide", 1);
  level.player enableslowaim(0.6, 0.6);
  level.player.last_weapon = level.player getcurrentweapon();
  level.player disableweaponswitch();
  level.player giveweapon("underwater_torpedo");
  level.player switchtoweapon("underwater_torpedo");
  level.player allowmelee(0);
  level.player thread torpedo_drillbit_audio();
  level.player allowfire(0);
  wait 4;

  for(;;) {
    level.player waittill("fire weapon");

    if(!maps\_utility::player_looking_at(level.sonar_boat.origin, 0.8, 1)) {
      maps\_utility::display_hint("hint_notfound");
      continue;
    }

    if(!maps\ship_graveyard_util::player_not_obstructed(250)) {
      maps\_utility::display_hint("hint_blocked");
      continue;
    }

    break;
  }

  var_4 = level.player getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = level.player getEye();
  var_6 = var_6 + var_5 * 64;
  common_scripts\utility::flag_set("player_on_torpedo");
  thread maps\ship_graveyard_torpedo::torpedo_go(var_6, var_4);
  level waittill("torpedo_ready");
  var_7 = 1.5;
  level.player.dom.ref_ent moveto(level.player.dom.ref_ent.origin + var_5 * 32, var_7, 0, var_7);
  level.player.dom.ref_ent rotateto(level.player.dom.ref_ent.angles - (level.player.dom.ref_ent.angles[0], 0, 0), var_7, 0, var_7);
  wait(var_7);
  var_1 notify("stop_loop");

  while(getdvarint("debug_torpedo", 0))
    wait 0.05;

  level notify("fire_torpedo");
  level waittill("exit_torpedo", var_8);
  level.baker thread maps\ship_graveyard_util::baker_glint_on();
  setsaveddvar("ammoCounterHide", 0);

  if(var_8) {
    thread impact_vision_set();
    level.player takeweapon("underwater_torpedo");
    level.player allowfire(1);
    level.player allowmelee(1);
    level notify("mine_moveup");
    wait 0.15;
    common_scripts\utility::flag_set("sonar_boat_explode");
    wait 1.772;
    thread maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_nicework");

    if(getdvarint("shpg_torpedo_tries", 0) == 0)
      level.player maps\_utility::player_giveachievement_wrapper("LEVEL_12A");
  } else {
    wait 0.5;
    maps\ship_graveyard_util::force_deathquote(&"SHIP_GRAVEYARD_HINT_TORPEDO");
    maps\_utility::missionfailedwrapper();
    setDvar("shpg_torpedo_tries", 1);
  }
}

watch_if_used() {
  self waittill("trigger");
  common_scripts\utility::flag_set("grabbed_torpedo");
}

torpedo_drillbit_audio() {
  while(level.player.disabledweapon)
    common_scripts\utility::waitframe();

  var_0 = 68;

  for(var_1 = 0; var_1 < var_0; var_1++)
    common_scripts\utility::waitframe();

  level.sound_torpedo_ent = spawn("script_origin", level.player getEye());
  level.sound_torpedo_ent playLoopSound("scn_shipg_torpedo_drillbit_loop");
  level.sound_torpedo_ent scalevolume(0.7, 0.0);
  level.sound_torpedo_ent scalepitch(0.5, 0.0);
  wait 0.1;
  level.sound_torpedo_ent scalevolume(1.0, 1.5);
  level.sound_torpedo_ent scalepitch(1.0, 1.5);
}

impact_vision_set() {
  wait 0.3;
  thread maps\_utility::vision_set_fog_changes("", 0);
  common_scripts\utility::flag_set("pause_dynamic_dof");
  maps\_art::dof_enable_script(1, 1, 4.5, 500, 500, 0.05, 0.1);
  wait 1;
  thread maps\_utility::vision_set_fog_changes("shpg_lcs_detonation", 1);
  wait 1;
  thread maps\_utility::vision_set_fog_changes("", 3);
  maps\_art::dof_disable_script(1);
  wait 1;
  common_scripts\utility::flag_clear("pause_dynamic_dof");
}

sonar_mines() {
  var_0 = getEntArray("sonar_mine", "targetname");
  common_scripts\utility::array_thread(var_0, ::sonar_mine_think);
  level waittill("sonar_boat_explode");
  wait 0.15;

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 notify("explode");
      wait(randomfloatrange(0.3, 0.5));
    }
  }
}

hit_chain_dialogue() {
  level waittill("mine_moveup");
  thread maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_nicework");
}

sonar_mine_think() {
  var_0 = common_scripts\utility::get_target_ent();
  thread mine_notify_on_tigger(var_0);
  thread mine_notify_on_level();
  thread mine_explode_think();
  self waittill("moveup");
  common_scripts\utility::flag_set("mine_moveup");
  var_1 = (self.origin[0], self.origin[1], level.water_level_z - 686);
  maps\ship_graveyard_util::moveto_speed(var_1, 150, 0.8);
  common_scripts\utility::flag_set("sonar_boat_explode");
  self notify("explode");
}

mine_explode_think() {
  self waittill("explode");
  playFX(common_scripts\utility::getfx("shpg_underwater_explosion_med_a"), self.origin + (0, 0, 646));

  if(level.water_level_z - 120 - 686 - self.origin[2] < 10)
    playFX(common_scripts\utility::getfx("underwater_surface_splash"), self.origin + (0, 0, 646));

  playFX(common_scripts\utility::getfx("shpg_underwater_explosion_med_a"), self.origin + (0, 0, 646));
  thread common_scripts\utility::play_sound_in_space("underwater_explosion", self.origin + (0, 0, 646));
  earthquake(0.7, 0.7, self.origin + (0, 0, 646), 2000);
  self delete();
}

mine_notify_on_tigger(var_0) {
  self endon("moveup");
  var_0 waittill("trigger");
  self notify("moveup");
}

mine_notify_on_level() {
  self endon("moveup");
  level waittill("mine_moveup");
  wait(randomfloatrange(0.5, 1.5));
  self notify("moveup");
}

sonar_mines_boat_reaction() {
  var_0 = common_scripts\utility::get_target_ent("lighthouse_node");
  common_scripts\utility::flag_wait("player_on_torpedo");
  level waittill("exit_torpedo");
  level.baker dontinterpolate();
  level.baker.animname = "baker";
  var_0 thread maps\_anim::anim_first_frame([level.baker], "lighthouse_fall");
  common_scripts\utility::flag_wait("sonar_boat_explode");
  musicstop(1);
  var_1 = level.sonar_boat;
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("vehicle_lcs_destroyed_front");
  var_2.animname = "lcs_front";
  var_2 maps\_anim::setanimtree();
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_2.origin;
  var_3.angles = var_2.angles;
  var_3 linkto(var_2);
  var_3 thread maps\ship_graveyard_util::lcs_lights_front();
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("vehicle_lcs_destroyed_back");
  var_4.animname = "lcs_back";
  var_4 maps\_anim::setanimtree();
  var_4 thread maps\ship_graveyard_util::lcs_lights_back();
  var_5 = (0, 0, 48);
  var_6 = maps\_player_rig::get_player_rig();
  var_6.origin = level.player.origin - var_5;
  var_6.angles = level.player.angles;
  var_7 = common_scripts\utility::spawn_tag_origin();
  var_7.origin = var_6.origin;
  var_7.angles = var_6.angles;
  var_7 linkto(var_6, "tag_player", var_5, (0, 0, 0));
  var_8 = spawn("script_model", (0, 0, 0));
  var_8 setModel("body_fed_udt_assault_a_ally_trailer");
  var_8.animname = "legs";
  var_8 maps\_anim::setanimtree();
  level.sonar_wreck unlink();
  level.sonar_wreck.animname = "lighthouse";
  level.sonar_wreck maps\_anim::setanimtree();
  level.player thread maps\_utility::play_sound_on_entity("scn_shipg_lighthosue_fall_lr");
  thread sonar_crash_player_setup(var_6, var_7, var_8);
  thread sonar_crash_dialogue();
  var_1 delete();
  level.baker notify("stop_first_frame");
  thread sonar_crash_fx(var_6, var_2, var_4);
  setsaveddvar("sv_znear", "1");
  var_9 = getanimlength(level.sonar_wreck maps\_utility::getanim("lighthouse_fall"));
  thread sonar_crash_solo_arms();
  level.sonar_wreck.top delete();
  var_0 thread maps\_anim::anim_single([var_6, level.sonar_wreck, var_2, var_4, level.baker, var_8], "lighthouse_fall");
  level.sonar_wreck waittillmatch("single anim", "fadeout");
  level notify("stop_earthquake");
  earthquake(0.8, 0.5, level.player.origin, 2000);
  level.player_rig stoprumble("subtle_tank_rumble");
  level.player playrumbleonentity("damage_heavy");
  maps\_hud_util::fade_out(0.05);
  wait 1;
  level.player stopshellshock();
  wait 0.05;
  level.sonar_wreck.glass delete();
  level.sonar_wreck.mover delete();
  level.sonar_wreck delete();
  level.player unlink();
  level.player_rig delete();
  common_scripts\utility::flag_set("start_new_trench");
  level.player showviewmodel();
  var_2 delete();
  var_4 delete();
  var_8 delete();
  var_3 delete();
}

sonar_crash_solo_arms() {
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_0 linktoplayerview(level.player, "tag_origin", (0, 0, -64), (0, 0, 0), 1);
  var_0 setanim(var_0 maps\_utility::getanim("lighthouse_fall_arms"), 1, 0, 1);
  wait 7;
  var_0 delete();
  common_scripts\utility::flag_set("turn_on_bubbles_after_torpedo");
}

sonar_crash_fx(var_0, var_1, var_2) {
  var_3 = level.sonar_wreck.origin;
  var_4 = level.sonar_wreck.angles;
  var_5 = anglestoup(var_4);
  var_6 = -1 * var_5;
  var_7 = level.sonar_wreck common_scripts\utility::spawn_tag_origin();
  var_8 = level.sonar_wreck common_scripts\utility::spawn_tag_origin();
  var_8.angles = vectortoangles(var_6);
  var_9 = level.sonar_wreck common_scripts\utility::spawn_tag_origin();
  var_8 linkto(level.sonar_wreck);
  var_7 linkto(var_8, "tag_origin", (-400, 0, 0), (0, 0, 0));
  var_9 linkto(var_8, "tag_origin", (-600, 0, 0), (-90, 0, 0));
  wait 0.1;
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_10.origin = (2810, -61853, 89);
  var_10.angles = (0, 141, -45);
  common_scripts\utility::noself_delaycall(2.5, ::playfxontag, common_scripts\utility::getfx("lighthouse_window_mess"), var_10, "tag_origin");
  common_scripts\utility::noself_delaycall(6.0, ::playfxontag, common_scripts\utility::getfx("lighthouse_debris"), var_7, "tag_origin");
  common_scripts\utility::noself_delaycall(6.0, ::playfxontag, common_scripts\utility::getfx("lighthouse_bubbles"), var_9, "tag_origin");
  maps\_utility::delaythread(0.0, common_scripts\utility::exploder, "lighthouse_lcs_detonation");
  maps\_utility::delaythread(2, common_scripts\utility::exploder, "debris_hit_wood_metal");
  playFXOnTag(common_scripts\utility::getfx("lighthouse_debris"), var_7, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("lighthouse_bubbles"), var_9, "tag_origin");
  maps\_utility::delaythread(3.1, maps\ship_graveyard_util::player_panic_bubbles);
  maps\_utility::delaythread(4, common_scripts\utility::exploder, "base_snap_debris");
  maps\_utility::delaythread(4.5, maps\ship_graveyard_util::player_panic_bubbles);
  maps\_utility::delaythread(6, maps\ship_graveyard_util::player_panic_bubbles);
  common_scripts\utility::flag_wait("start_new_trench");
  var_7 delete();
  var_8 delete();
  var_9 delete();
  var_10 delete();
}

sonar_crash_earthquake() {
  level endon("stop_earthquake");
  level.earthquake_strength = 0.2;
  thread increase_earthquake_strength();
  level.player common_scripts\utility::delaycall(8, ::setblurforplayer, 6, 5);
  maps\_utility::delaythread(9, maps\_hud_util::fade_out, 9);

  for(;;) {
    earthquake(level.earthquake_strength, 0.2, level.player.origin, 3000);
    wait 0.1;
  }
}

increase_earthquake_strength() {
  level endon("stop_earthquake");
  wait 4;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = (0, 0, level.earthquake_strength);
  var_0 movez(0.22, 6, 6, 0);
  var_0 thread maps\ship_graveyard_util::delete_on_notify("stop_earthquake");
  level.f_min["gasmask_overlay"] = 0.7;
  level.f_max["gasmask_overlay"] = 0.9;
  level.f_min["halo_overlay_scuba_steam"] = 0.6;
  level.f_max["halo_overlay_scuba_steam"] = 0.7;

  for(;;) {
    level.earthquake_strength = var_0.origin[2];
    wait 0.05;
  }
}

sonar_crash_player_setup(var_0, var_1, var_2) {
  level.player disableweapons();
  level.player playerlinktoabsolute(var_1, "tag_origin");
  wait 0.2;
  level.player enableslowaim(0.35, 0.35);
  setsaveddvar("player_swimSpeed", 35);
  setsaveddvar("player_swimVerticalSpeed", 10);
  var_0 hide();
  var_2 hide();
  level.player unlink();
  level.player allowsprint(0);
  thread sonar_crash_dof();
  wait 3.25;
  level.player playerlinktoblend(var_1, "tag_origin", 0.5, 0, 0);
  wait 0.5;
  level.player playerlinktodelta(var_1, "tag_origin", 1, 10, 10, 10, 10);
  wait 1;
  var_0 show();
  var_2 show();
  level.player shellshock("nearby_crash_underwater", 4.5);
  wait 0.5;
  var_0 hide();
  var_2 hide();
  wait 2.25;
  wait 0.5;
  var_0 show();
  var_2 show();
  level.player allowsprint(1);
}

sonar_crash_dof() {
  wait 0.75;
  common_scripts\utility::flag_set("pause_dynamic_dof");
  maps\_art::dof_enable_script(0, 250, 4, 1500, 4000, 1.5, 1);
  wait 5.5;
  maps\_art::dof_disable_script(1);
  wait 1;
  common_scripts\utility::flag_clear("pause_dynamic_dof");
}

sonar_crash_dialogue() {
  wait 5;
  thread sonar_crash_earthquake();
  level.player_rig playrumblelooponentity("subtle_tank_rumble");
  wait 3;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_ohshit");
  wait 3.3;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_hangon");
}

base_alarm() {
  common_scripts\utility::flag_init("start_base_alarm");
  var_0 = getdvarint("play_alarm", 1);

  if(var_0) {
    common_scripts\utility::flag_wait("start_base_alarm");
    var_1 = getent("origin_base_alarm", "targetname");
    var_1 base_alarm_loop();
    common_scripts\utility::flag_waitopen("start_base_alarm");
  }
}

base_alarm_loop() {
  level endon("start_base_alarm");

  for(;;) {
    self playSound("emt_alarm_base_alert", "done_playing");
    self waittill("done_playing");
  }
}

canyon_jumper_setup() {
  self endon("death");
  var_0 = common_scripts\utility::get_target_ent();

  if(isDefined(var_0)) {
    if(isDefined(var_0.target)) {
      self waittill("done_jumping_in");
      var_0 = var_0 common_scripts\utility::get_target_ent();
      maps\_utility::follow_path_and_animate(var_0, 0);
    }
  }
}

initial_depth_charge_run() {
  level endon("start_big_wreck");
  wait 4.5;

  for(;;) {
    common_scripts\utility::array_thread(common_scripts\utility::getstructarray("depth_charge_test", "targetname"), maps\ship_graveyard_util::depth_charge_org);
    wait 4;
    common_scripts\utility::array_thread(common_scripts\utility::getstructarray("depth_charge_test_2", "targetname"), maps\ship_graveyard_util::depth_charge_org);
    wait 6.5;
    common_scripts\utility::array_thread(common_scripts\utility::getstructarray("depth_charge_test_3", "targetname"), maps\ship_graveyard_util::depth_charge_org);
    wait 6.5;
  }
}

depth_charges() {
  maps\_utility::autosave_by_name("depth_charges");
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("depth_charge_test", "targetname"), maps\ship_graveyard_util::depth_charge_org);
  wait 1.5;
  wait 2.75;
  wait 1.5;
  level notify("stop_killing_player");
  common_scripts\utility::flag_clear("allow_killfirms");
  thread initial_depth_charge_run();
  thread random_depth_charges("depth_charge_constant", 9, 13);
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_depthcharges");
  maps\_utility::delaythread(4, common_scripts\utility::flag_set, "depth_charge_run_start");
  thread depth_charge_enemy_check();
  common_scripts\utility::flag_wait("depth_charge_run_start");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2.baseaccuracy = 0.01;

  maps\_utility::delaythread(2, ::depth_charges_near_player);
  thread depth_charge_dialogue();
  thread depth_charge_death();
  var_4 = getdvarfloat("player_swimSpeed");
  setsaveddvar("player_swimSpeed", 110);
  setsaveddvar("player_sprintUnlimited", "1");
  level.baker maps\_utility::disable_ai_color();
  var_5 = level.baker.pathrandompercent;
  level.baker.pathrandompercent = 0;
  level.baker maps\ship_graveyard_util::dyn_swimspeed_disable();
  level.baker.moveplaybackrate = 1.55;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker.a.disablepain = 1;
  level.baker maps\_utility::disable_arrivals();
  level.baker maps\_utility::delaythread(0.3, maps\_utility::disable_exits);
  level.baker.ignoreall = 1;
  maps\ship_graveyard_util::baker_noncombat();
  level.baker maps\_utility::delaythread(0.1, maps\ship_graveyard_util::dyn_swimspeed_enable, 350);
  maps\ship_graveyard_util::baker_glint_on();
  level.baker thread big_wreck_wait_turnaround();
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_enter_big_wreck"), 0);
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 kill();

  level.baker maps\ship_graveyard_util::dyn_swimspeed_disable();
  level.baker.moveplaybackrate = 1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker.pathrandompercent = var_5;
  level.baker maps\_utility::enable_arrivals();
  level.baker.a.disablepain = 0;
  level.baker.ignoreall = 0;
  common_scripts\utility::flag_wait("start_big_wreck");
  setsaveddvar("player_sprintUnlimited", "0");
}

depth_charge_enemy_check() {
  level endon("depth_charge_run_start");
  var_0 = getaiarray("axis");
  var_1 = 0.0;

  foreach(var_3 in var_0) {
    var_3 thread kill_after_time(var_1);
    var_1 = var_1 + 0.75;
  }

  for(;;) {
    var_5 = 0;
    var_0 = getaiarray("axis");

    foreach(var_3 in var_0) {
      if(distance(var_3.origin, level.player.origin) < 1024)
        var_5 = var_5 + 1;
    }

    if(var_5 > 0) {
      wait 0.1;
      continue;
    }

    break;
  }

  common_scripts\utility::flag_set("depth_charge_run_start");
}

kill_after_time(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("depth_charge_run_start");
  wait(var_0);
  self kill();
}

depth_charge_dialogue() {
  level.baker animscripts\weaponlist::refillclip();
  maps\_utility::smart_radio_dialogue("shipg_bkr_takecover");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_thiswaymovemove");
}

depth_charge_death() {
  level endon("start_big_wreck");
  var_0 = getEntArray("depth_charge_death", "targetname");
  common_scripts\utility::array_thread(var_0, ::depth_charge_death_trig);
  wait 2;

  if(!common_scripts\utility::flag("baker_prepare_to_leave_flag")) {
    for(;;) {
      wait 3;

      if(distance(level.player.origin, level.baker.origin) < 600) {
        wait 3;
        continue;
      }

      thread maps\_utility::smart_radio_dialogue("shipg_bkr_takecover");
      wait 5;

      if(distance(level.player.origin, level.baker.origin) > 600)
        depth_charge_death_trig_kill();
    }
  }
}

random_depth_charges(var_0, var_1, var_2) {
  level endon("stop_depth_charges");
  var_3 = maps\_utility::getstructarray_delete(var_0, "targetname");

  for(;;) {
    var_4 = anglesToForward(level.player.angles);
    var_4 = var_4 * 500;
    var_5 = sortbydistance(var_3, level.player.origin + var_4);
    var_5 = [var_5[0], var_5[1], var_5[2]];
    var_6 = common_scripts\utility::random(var_5);
    var_6 thread maps\ship_graveyard_util::depth_charge_org();
    wait(randomfloatrange(var_1, var_2));
  }
}

depth_charges_near_player() {
  level endon("stop_depth_charges");

  for(;;) {
    var_0 = anglesToForward(level.player.angles);
    var_1 = anglestoright(level.player.angles);
    var_0 = var_0 * randomfloatrange(100, 300);
    var_1 = var_1 * randomfloatrange(50, 200);
    var_1 = var_1 * common_scripts\utility::random([-1, 1]);
    thread maps\ship_graveyard_util::drop_depth_charge(level.player.origin + var_0 + var_1);
    wait(randomfloatrange(4, 6));
  }
}

boat_fall_trigs() {
  var_0 = getEntArray("depth_charge_boat_fall_trigger", "targetname");
  common_scripts\utility::array_thread(var_0, ::depth_charge_boat_fall_trigger);
}

depth_charge_boat_fall_trigger() {
  var_0 = common_scripts\utility::get_target_ent();
  self waittill("trigger");
  var_0 thread maps\_utility::play_sound_on_entity("scn_shipg_depth_charge_boat_fall");
  var_0 thread maps\ship_graveyard_new_trench::crash_model_go(var_0 common_scripts\utility::get_linked_ents());
}

middle_room_fall() {
  var_0 = common_scripts\utility::get_target_ent("big_wreck_middle_room_beam");
  var_1 = var_0 common_scripts\utility::get_linked_ent();
  var_1 linkto(var_0);
  var_2 = var_0 common_scripts\utility::get_target_ent();
  var_3 = var_0 common_scripts\utility::spawn_tag_origin();
  var_3 linkto(var_0);
  playFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_3, "Tag_origin");
  var_0 thread maps\_utility::play_sound_on_entity("scn_shipg_titanic_debris_fall");
  var_0 maps\ship_graveyard_util::moveto_rotateto(var_2, 5, 3, 0);
  stopFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_3, "Tag_origin");
  earthquake(0.4, 0.7, var_0.origin, 2000);
  common_scripts\utility::play_sound_in_space("scn_shipg_titanic_debris_crash", var_0.origin);
}

big_wreck_baker_stealth() {
  level endon("big_wreck_shark");
  level.baker.goalradius = 32;
  common_scripts\utility::flag_wait("big_wreck_baker_path_1");
  thread middle_room_fall();
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_areaclear");
  wait 2;
  var_0 = common_scripts\utility::get_target_ent("big_wreck_baker_node_1");
  level.baker maps\_utility::follow_path_and_animate(var_0);
  wait 2;
  common_scripts\utility::flag_wait("big_wreck_baker_path_2");
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable();
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_zerocontacts");
  wait 1;
  var_0 = common_scripts\utility::get_target_ent("big_wreck_baker_node_2");
  level.baker setgoalnode(var_0);
  level.baker waittill("goal");
}

big_wreck_shark() {
  common_scripts\utility::flag_wait("big_wreck_shark");
  maps\_utility::autosave_stealth();
  level endon("shark_eating_player");
  level endon("start_shark_room");
  common_scripts\utility::exploder("wreck_hallway");
  big_wreck_shark_baker_teleport();
  var_0 = common_scripts\utility::get_target_ent("big_wreck_baker_node_2");
  level.baker setgoalnode(var_0);
  var_1 = maps\_utility::spawn_targetname("big_wreck_shark_model");
  var_1 thread maps\_utility::deletable_magic_bullet_shield();
  var_1 thread attack_player_after_death();
  thread shark_moment_2(var_1);
  thread big_wreck_track_player_gunfire();
  maps\_utility::delaythread(1.15, maps\_utility::music_play, "mus_shipgrave_shark_showup");
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_easy2");
  wait 2.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_handsfull");
  wait 0.8;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_inthemiddle");
  wait 1;
  level.baker getenemyinfo(var_1);
  level.baker.ignoreall = 1;
  level.baker clearenemy();
  level.baker maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("to_shark_room_turn"));
  level.baker.my_animnode = common_scripts\utility::get_target_ent("big_wreck_2_baker_shark_entry");
  level.baker pushplayer(1);
  level.baker.my_animnode maps\_anim::anim_generic_reach(level.baker, "shark_pit_in");
  level.baker thread baker_post_up_at_sharks();
  var_1 thread maps\_utility::stop_magic_bullet_shield();
  level.baker maps\_utility::waittill_player_lookat(0.65);
  common_scripts\utility::flag_set("start_shark_room");
}

big_wreck_shark_baker_teleport() {
  var_0 = common_scripts\utility::get_target_ent("big_wreck_shark_check");

  if(!level.baker istouching(var_0)) {
    if(!level.player maps\_utility::player_looking_at(level.baker.origin, 0.7)) {
      var_1 = common_scripts\utility::get_target_ent("big_wreck_shark_teleport");

      if(!level.player maps\_utility::player_looking_at(var_1.origin, 0.7, 0))
        level.baker forceteleport(var_1.origin, var_1.angles);
    }
  }
}

baker_post_up_at_sharks() {
  common_scripts\utility::flag_set("baker_ready_at_sharks");
  level.baker.my_animnode maps\_anim::anim_generic(level.baker, "shark_pit_in");
  level.baker maps\_anim::anim_generic_loop(level.baker, "shark_pit_idle", "stop_loop");
}

shark_room_pusher() {
  level endon("shark_eating_player");
  level endon("player_past_sharks");
  var_0 = (13610.7, -54317.2, 39.9686);
  var_1 = spawn("trigger_radius", var_0, 0, 24, 24);

  for(;;) {
    var_1 waittill("trigger");
    var_2 = vectornormalize(level.player.origin - var_1.origin);
    level.player setvelocity(level.player getvelocity() + var_2 * 5);
    common_scripts\utility::waitframe();
  }
}

shark_room() {
  level endon("shark_eating_player");
  level endon("player_warp_hesh");
  thread shark_room_pusher();
  thread shark_room_end();
  thread player_shoots_sharks();
  common_scripts\utility::flag_wait("big_wreck_shark");
  var_0 = maps\_utility::array_spawn_targetname("big_wreck_shark_model_veh");
  common_scripts\utility::array_thread(var_0, ::attack_player_after_death);
  common_scripts\utility::array_call(var_0, ::pushplayer, 0);
  common_scripts\utility::flag_wait("start_shark_room");
  level.baker maps\ship_graveyard_util::dyn_swimspeed_disable();
  level.baker.ignoreall = 1;
  var_1 = common_scripts\utility::get_target_ent("shark_room_trig");
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_holdup");
  wait 1.5;
  maps\_utility::smart_radio_dialogue("shipg_bkr_doesntlook");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_oneatatime");
  wait 1;
  thread greenlight_end();

  if(!level.player istouching(var_1)) {
    thread shark_room_baker_first_dialogue();
    thread tell_player_to_stay(var_1);
  } else {
    maps\_utility::smart_radio_dialogue("shipg_bkr_headstart");
    wait 1.5;
    maps\_utility::smart_radio_dialogue("shipg_bkr_noquick");
    wait 1.5;
    maps\_utility::smart_radio_dialogue("shipg_bkr_trytoanticipatetheir");
    wait 1;
    maps\_utility::smart_radio_dialogue("shipg_bkr_coveryou");
    common_scripts\utility::flag_wait("player_past_sharks");
    wait 2;
    maps\_utility::smart_radio_dialogue("shipg_bkr_keepcovered");
    wait 2;
  }

  common_scripts\utility::flag_wait("shark_b_clear_2");
  level.baker.moveplaybackrate = 0.5;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker.goalradius = 32;
  var_2 = common_scripts\utility::get_target_ent("baker_wreck_stealth_path_3");
  level.baker notify("stop_loop");
  level.baker setgoalnode(var_2);

  if(common_scripts\utility::flag("baker_ready_at_sharks")) {
    level.baker.my_animnode thread maps\_anim::anim_generic_run(level.baker, "shark_pit_out");
    level.baker maps\_utility::disable_exits();
    level.baker.my_animnode waittill("shark_pit_out");
    wait 0.1;
    level.baker maps\_utility::enable_exits();
  }

  level.baker waittill("goal");

  if(maps\ship_graveyard_util::greenlight_check() && (isDefined(level.start_point) && level.start_point != "fallon")) {
    return;
  }
  while(!common_scripts\utility::flag("shark_a_clear") || !common_scripts\utility::flag("shark_b_clear"))
    wait 0.05;

  common_scripts\utility::flag_set("shark_room_player_can_go");
  level.baker.goalradius = 256;
  var_2 = var_2 common_scripts\utility::get_target_ent();
  level.baker.moveplaybackrate = 0.7;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker setgoalnode(var_2);
  common_scripts\utility::flag_set("baker_past_sharks");

  if(!common_scripts\utility::flag("player_past_sharks")) {
    level.baker.dontevershoot = 1;
    level.baker.ignoreall = 0;
    maps\_utility::autosave_stealth();

    if(!level.player istouching(var_1)) {
      maps\_utility::smart_radio_dialogue("shipg_bkr_youreup");
      maps\ship_graveyard_util::baker_glint_on();
      var_3 = getdvarint("shpg_killed_by_shark", 0);

      if(var_3 > 1) {}

      common_scripts\utility::trigger_off("big_wreck_shatk_heartbeat_trig", "targetname");
      wait 2;
    }

    maps\_utility::smart_radio_dialogue("shipg_bkr_noquick");
    wait 2;
    thread maps\_utility::smart_radio_dialogue("shipg_bkr_trytoanticipatetheir");
    thread shark_room_faster_hint();
    common_scripts\utility::flag_wait("player_past_sharks");
    wait 1;
    level.baker.dontevershoot = undefined;
    level.baker.ignoreall = 1;
    level.baker.moveplaybackrate = 1;
  }
}

attack_player_after_death() {
  self waittill("death");
  wait 0.1;
  var_0 = level.deadly_sharks;
  var_0 = maps\_utility::array_removedead(var_0);
  var_0 = common_scripts\utility::array_removeundefined(var_0);
  var_0 = sortbydistance(var_0, level.player.origin);
  common_scripts\utility::flag_clear("shark_eating_player");

  foreach(var_2 in var_0) {
    var_2 thread maps\ship_graveyard_util::shark_kill_player(1);
    break;
  }
}

shark_room_end() {
  common_scripts\utility::flag_wait("start_shark_room");
  common_scripts\utility::flag_wait("player_past_sharks");
  level.baker hudoutlinedisable();
  common_scripts\utility::flag_waitopen("shark_eating_player");
  common_scripts\utility::flag_wait_either("player_warp_hesh", "baker_past_sharks");

  if(common_scripts\utility::flag("baker_past_sharks"))
    level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_wreck_stealth_path_4"), 250);
  else if(common_scripts\utility::flag("player_warp_hesh")) {
    level.baker notify("stop_loop");
    level.baker stopanimscripted();
    level.baker.moveplaybackrate = 1;
    level.baker.goalradius = 196;
    var_0 = common_scripts\utility::get_target_ent("baker_shark_room_teleport");
    level.baker forceteleport(var_0.origin, var_0.angles);
    common_scripts\utility::flag_set("baker_past_sharks");
    level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_wreck_stealth_path_5"), 250);
  }

  level notify("shark_room_player_can_go");
  thread maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_letsgo");
  maps\ship_graveyard_util::baker_glint_off();
  level.baker.moveplaybackrate = 1;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  thread shark_safe_autosave();
  level.baker.goalradius = 200;
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable();
}

shark_safe_autosave() {
  level endon("trying_new_autosave");

  while(common_scripts\utility::flag("player_near_shark"))
    wait 0.05;

  thread maps\_utility::autosave_stealth();
}

player_shoots_sharks() {
  var_0 = common_scripts\utility::get_target_ent("shark_room_trig");
  common_scripts\utility::flag_wait("shark_eating_player");

  if(isDefined(level.baker.my_animnode))
    level.baker.my_animnode notify("stop_loop");

  level.baker stopanimscripted();
  var_1 = 1;

  while(var_1) {
    common_scripts\utility::flag_waitopen("shark_eating_player");
    wait 1;
    common_scripts\utility::flag_waitopen("shark_eating_player");
    var_1 = 0;

    foreach(var_3 in level.deadly_sharks) {
      if(var_3 istouching(var_0)) {
        var_1 = 1;
        break;
      }
    }
  }

  if(!common_scripts\utility::flag("baker_past_sharks")) {
    var_5 = common_scripts\utility::get_target_ent("baker_wreck_stealth_path_3");
    level.baker thread maps\_utility::follow_path_and_animate(var_5);
  }

  common_scripts\utility::flag_set("baker_past_sharks");
  maps\_utility::smart_radio_dialogue("shipg_bkr_onme");
}

shark_room_faster_hint() {
  level.player endon("death");
  level endon("shark_eating_player");
  level endon("player_past_sharks");
  common_scripts\utility::flag_wait("shark_room_close_to_exit");
  common_scripts\utility::flag_wait_either("shark_a_clear_comeback", "shark_b_clear_comeback");
  maps\_utility::smart_radio_dialogue("shipg_hsh_hurryuptheyrecoming");
}

big_wreck_track_player_gunfire() {
  for(;;) {
    level.player waittill("weapon_fired");
    wait 0.5;
    level.deadly_sharks = maps\_utility::array_removedead(level.deadly_sharks);
    level.deadly_sharks = common_scripts\utility::array_removeundefined(level.deadly_sharks);

    if(level.deadly_sharks.size > 0) {
      var_0 = sortbydistance(level.deadly_sharks, level.player.origin);

      for(var_1 = 0; var_1 < level.deadly_sharks.size; var_1++) {
        if(distance(var_0[var_1].origin, level.player.origin) < 800) {
          var_2 = var_0[var_1] maps\ship_graveyard_util::shark_kill_player();

          if(isDefined(var_2) && var_2) {
            break;
          }
        } else
          break;
      }
    }

    wait 0.05;
  }
}

shark_moment_2(var_0) {
  var_1 = common_scripts\utility::get_target_ent("big_wreck_shark_1_path");
  var_2 = common_scripts\utility::get_target_ent("shark_moment_2");
  var_3 = common_scripts\utility::get_target_ent("shark_moment_2_sound");
  var_0.animnode = var_2;
  var_0.animname = "shark";
  var_0 thread maps\ship_graveyard_util::shark_kill_think();
  var_0 endon("killing_player");
  var_0 endon("death");
  var_0 maps\_utility::follow_path_and_animate(var_1, 0);
}

shark_attack_2_fx(var_0, var_1) {
  wait 3.75;
  thread common_scripts\utility::play_sound_in_space("scn_shark_bite_flesh", var_0 gettagorigin("j_knee_ri"));
  playFX(common_scripts\utility::getfx("swim_ai_blood_impact"), var_0 gettagorigin("j_knee_ri"));
  wait 0.25;
  thread common_scripts\utility::play_sound_in_space("scn_shark_bite_flesh", var_0 gettagorigin("j_knee_ri"));
  playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), var_0, "j_knee_ri");
  common_scripts\utility::exploder(10);
}

shark_room_baker_first_dialogue() {
  level endon("told_player_to_stay");
  maps\_utility::smart_radio_dialogue("shipg_bkr_gofirst");
  wait 1.5;

  if(!maps\ship_graveyard_util::greenlight_check())
    maps\_utility::smart_radio_dialogue("shipg_bkr_stayhere");

  wait 2;
}

tell_player_to_stay(var_0) {
  level endon("shark_eating_player");
  level endon("shark_room_player_can_go");
  var_0 waittill("trigger");
  level notify("told_player_to_stay");
  maps\_utility::smart_radio_dialogue_interrupt("shipg_bkr_stop");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_onlyroom");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_atentrance");
}

big_wreck_wait_turnaround() {
  level.baker waittill("path_end_reached");
  common_scripts\utility::flag_set("big_wreck_wait_turnaround");
}

big_wreck_dialogue() {
  maps\ship_graveyard_util::baker_noncombat();
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_saferhere");
  wait 2;
  maps\ship_graveyard_util::baker_glint_off();
  level.baker.pathrandompercent = 0;
  level.baker.goalradius = 128;
  maps\_utility::delaythread(3.5, maps\_utility::smart_radio_dialogue, "shipg_bkr_eyeout");
  wait 0.5;
  level.baker maps\_utility::disable_exits();
  common_scripts\utility::flag_wait("big_wreck_wait_turnaround");
  level.baker thread maps\_anim::anim_generic(level.baker, "swimming_idle_to_aiming_move_180");
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_enter_big_wreck_inside"));
  level.baker waittill("swimming_idle_to_aiming_move_180");
  wait 0.2;
  level.baker maps\_utility::enable_exits();
  common_scripts\utility::flag_wait("inside_big_wreck");
  maps\_utility::autosave_by_name("big_wreck");
  level notify("stop_depth_charges");
  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::delete);
}

big_wreck_encounter() {
  maps\_utility::trigger_wait_targetname("big_wreck_spawn_1");
  level.baker maps\_utility::set_force_color("r");
  wait 0.1;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_contact");

  for(;;) {
    var_0 = getaiarray("axis");

    if(var_0.size <= 1) {
      break;
    }

    wait 0.1;
  }

  level.baker.maxfaceenemydist = 64;
  wait 1;
  var_0 = getaiarray("axis");

  if(var_0.size > 0) {
    foreach(var_2 in var_0)
    var_2 setgoalentity(level.player);
  }
}

big_wreck_kill_when_outside() {
  var_0 = common_scripts\utility::get_target_ent("big_wreck_outside");
  var_0 thread depth_charge_death_trig();
}

depth_charge_death_trig() {
  self waittill("trigger");
  depth_charge_death_trig_kill();
}

depth_charge_death_trig_kill() {
  playFX(common_scripts\utility::getfx("shpg_underwater_explosion_med_a"), level.player.origin);
  thread common_scripts\utility::play_sound_in_space("underwater_explosion", level.player.origin);
  earthquake(0.6, 0.75, level.player.origin, 1024);
  level.player viewkick(15, level.player.origin);
  level.player shellshock("depth_charge_hit", 2.5);
  wait 0.3;
  radiusdamage(level.player.origin, 300, 100, 20);
  wait 1;
  level.player kill();
}

big_wreck_fake_shake() {
  level endon("stop_wreck_shake");
  var_0 = maps\_utility::getstructarray_delete("depth_charge_sound_source", "targetname");
  var_1 = maps\_utility::getstructarray_delete("big_wreck_shake_org", "targetname");

  for(;;) {
    wait(randomfloatrange(1, 2));
    var_2 = common_scripts\utility::random(var_0);
    var_3 = randomfloatrange(0.2, 0.4);
    thread common_scripts\utility::play_sound_in_space("underwater_explosion_muffled", var_2.origin);
    cave_shake(var_3, var_1, "scn_shipg_wreck_rattle");
    wait(randomfloatrange(1, 6));
  }
}

big_wreck_2_dialogue() {
  common_scripts\utility::flag_wait("player_inside_glass_room");
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_stayaway");
  maps\_utility::trigger_wait_targetname("baker_down_hatch");
  maps\_utility::smart_radio_dialogue("shipg_bkr_hatchmove");
}

watch_baker_prepare_to_leave_trig() {
  maps\_utility::trigger_wait_targetname("baker_prepare_to_leave_trig");
  common_scripts\utility::flag_set("baker_prepare_to_leave_flag");
  thread depth_charge_death();
}

big_wreck_collapse() {
  thread watch_baker_prepare_to_leave_trig();
  common_scripts\utility::flag_wait("big_wreck_out");

  if(maps\_utility::is_gen4()) {
    var_0 = getdvarfloat("r_tessellationCutoffDistanceBase", 960.0);
    var_1 = getdvarfloat("r_tessellationCutoffFalloffBase", 320.0);
    thread maps\_art::tess_set_goal(var_0, var_1, 3);
    thread maps\_utility::lerp_saveddvar("r_tessellationFactor", 25, 10);
  }

  thread exit_wreck_check();
  thread common_scripts\utility::play_sound_in_space("scn_shipg_end_collapse", (12539, -53384, 152));
  thread common_scripts\utility::play_sound_in_space("scn_shipg_end_collapse_layer", (12378, -53513, 93));
  thread common_scripts\utility::exploder(97);
  wait 0.5;
  thread common_scripts\utility::exploder(101);
  var_2 = common_scripts\utility::get_target_ent("out_of_wreck_volume");

  if(level.player istouching(var_2)) {
    musicstop(1);
    level.player givemaxammo(level.player getcurrentweapon());
    level.player thread maps\ship_graveyard_util::delay_reset_swim_shock(2);
    level.player disableweapons();
    level.player common_scripts\utility::delaycall(2, ::enableweapons);
  } else
    level.player kill();

  maps\_utility::smart_radio_dialogue("shipg_bkr_pain2");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_bkr_intheclear");
  thread maps\_utility::music_play("mus_shipgrave_collapse_travel");

  if(!common_scripts\utility::flag("exiting_to_end")) {
    wait 0.5;
    thread maps\_utility::smart_radio_dialogue("shipg_bkr_thisway2");
  }

  maps\_utility::autosave_by_name("end");
  setsaveddvar("player_swimSpeed", 120);
  level.baker pushplayer(1);
  level.baker.dontchangepushplayer = 1;
  level.baker.goalradius = 256;
  level.baker.moveplaybackrate = 1.7;
  level.baker.movetransitionrate = level.baker.moveplaybackrate;
  level.baker.pathrandompercent = 0;
  level.baker maps\_utility::disable_exits();
  level.baker thread maps\_anim::anim_generic_run(level.baker, "swimming_idle_to_aiming_move_180");
  level.baker setgoalnode(common_scripts\utility::get_target_ent("baker_prepare_to_leave"));
  common_scripts\utility::flag_wait("baker_prepare_to_leave_flag");
  level.baker thread maps\ship_graveyard_util::dyn_swimspeed_enable();
  level.baker thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("baker_end_level_path"));
  level.baker maps\_utility::delaythread(2, maps\_utility::enable_exits);
  thread end_dialogue();
  common_scripts\utility::flag_wait("the_end");
  level notify("stop_depth_charges");
}

exit_wreck_check() {
  maps\_utility::trigger_wait_targetname("baker_prepare_to_leave_trig");
  common_scripts\utility::flag_set("exiting_to_end");
}

end_dialogue() {
  wait 7;
  maps\_utility::smart_radio_dialogue("shipg_bkr_rallypointecho");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("shipg_orb_goodtohear");
  wait 0.2;
  maps\_utility::smart_radio_dialogue("shipg_bkr_ihearya");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_orb_greenlit");
  wait 0.3;
  thread maps\_hud_util::fade_out(4);
  maps\_utility::smart_radio_dialogue("shipg_bkr_seeyoutopside");
  maps\_utility::nextmission();
}

delay_remove_invul() {
  level endon("killed_a_guy");
  wait 4;
  level.player disableinvulnerability();
}

final_stand_dialogue() {
  maps\_utility::smart_radio_dialogue("shipg_bkr_doorsjammed");
  wait 1;
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_watchmyback");
}

player_notify_on_lookup() {
  var_0 = common_scripts\utility::get_target_ent("big_wreck_player_looking_up");
  var_0 maps\_utility::waittill_player_lookat(0.7);
  level.player notify("player_looking_up");
}

door_open() {
  var_0 = common_scripts\utility::get_target_ent();
  var_1 = var_0.angles;
  self rotateto(var_1, 0.5, 0, 0.3);
}

underwater_flood_spawn() {
  level endon("wreck_ceiling_collapse");

  for(;;) {
    var_0 = maps\_utility::spawn_ai(1);
    var_0 thread maps\ship_graveyard_util::teleport_to_target();
    var_0 waittill("death");
    level notify("killed_a_guy");
    wait(randomfloatrange(2, 4));
  }
}

big_wreck_tilt() {
  common_scripts\utility::flag_wait("wreck_tilt");
  wait 2.5;
  thread common_scripts\utility::play_sound_in_space("underwater_explosion", level.player.origin);
  earthquake(0.2, 0.75, level.player.origin, 1024);
  thread wreck_tilt_baker_hurt();
  var_0 = common_scripts\utility::spawn_tag_origin();
  level.player playersetgroundreferenceent(var_0);
  var_0 rotateto((330, 0, 0), 0.6, 0, 0.4);
  level.player disableweapons();
  level.player shellshock("default", 2);
  level.player thread maps\ship_graveyard_util::delay_reset_swim_shock(3);
  level.player common_scripts\utility::delaycall(3, ::enableweapons);
  var_0 waittill("rotatedone");
  var_0 rotateto((0, 0, 0), 0.8, 0.6, 0.1);
  var_0 waittill("rotatedone");
  level.player playersetgroundreferenceent(undefined);
  var_0 delete();
}

wreck_tilt_baker_hurt() {
  thread maps\_utility::smart_radio_dialogue("shipg_bkr_pain2", 0.1);
  var_0 = level.baker common_scripts\utility::spawn_tag_origin();
  level.baker linkto(var_0, "tag_origin");
  level.baker dodamage(50, level.baker.origin + (0, 0, 0));
  var_0 rotateto((30, 0, 0), 0.6, 0, 0.4);
  var_0 waittill("rotatedone");
  var_0 rotateto((0, 0, 0), 0.8, 0.6, 0.1);
  var_0 waittill("rotatedone");
  level.baker unlink();
  var_0 delete();
}

greenlight_skip() {
  if(!maps\ship_graveyard_util::greenlight_check()) {
    return;
  }
  wait 3;
  common_scripts\utility::flag_set("greenlight_next_phase");
  level.player setclienttriggeraudiozone("ship_graveyard_e3_black", 5);
  maps\_hud_util::fade_out(3);
  level.baker setgoalpos(level.baker.origin);
  wait 1;
  maps\_utility::music_stop(2);
  wait 2;
  level notify("e3_in_wreck");
}

greenlight_end() {
  if(!maps\ship_graveyard_util::greenlight_check() || isDefined(level.start_point) && level.start_point == "fallon") {
    return;
  }
  maps\_utility::battlechatter_off("allies");
  thread maps\_utility::set_audio_zone("ship_graveyard_gl_fadeout_end", 5.5);
  wait 5.65;
  maps\_hud_util::fade_out(0.05);

  if(level.start_point == "e3") {
    wait 0.1;
    maps\ship_graveyard_util::set_start_positions("sonar_event");
  }

  level.player freezecontrols(1);
  wait 11;
  maps\_utility::nextmission();
}

end_tunnel_swim() {
  var_0 = getent("trig_swim_up_transition_out", "targetname");
  var_0 waittill("trigger");
  var_1 = 2;
  maps\_hud_util::fade_out(var_1);
  thread stop_player_fire_sounds(var_1);
  level.player thread maps\_utility::play_sound_on_entity("enemy_water_splash");
  common_scripts\utility::flag_set("go_to_surface");
}

stop_player_fire_sounds(var_0) {
  wait(var_0);
  level.player disableweapons();
}

end_surface() {
  var_0 = common_scripts\utility::get_target_ent("surface_ai_clip_end");
  var_0 moveto(var_0.origin + (0, 0, -28.5), 0.01);
  common_scripts\utility::flag_wait("go_to_surface");
  level.player setclienttriggeraudiozone("ship_graveyard_abovewater_end", 1);
  level notify("stop_particulates");

  if(!isDefined(level.ground_ref_ent)) {
    level.ground_ref_ent = common_scripts\utility::spawn_tag_origin();
    level.ground_ref_ent.script_duration = 1;
  }

  level.ground_ref_ent.script_max_left_angle = 1;
  level.player playersetgroundreferenceent(level.ground_ref_ent);
  level.ground_ref_ent thread maps\ship_graveyard_surface::pitch_and_roll();
  level.player setorigin(common_scripts\utility::get_target_ent("end_tunnel_above_surface").origin);
  level.player setplayerangles(common_scripts\utility::get_target_ent("end_tunnel_above_surface").angles);
  level notify("end_swimming");
  setsaveddvar("player_swimWaterCurrent", "0 0 0");
  setsaveddvar("g_gravity", 800);
  setsaveddvar("sm_sunshadowscale", 1);
  setsaveddvar("sm_sunsamplesizeNear", 1);
  maps\_art::dof_set_base(1, 1, 4.5, 500, 500, 0.05, 0);

  if(isDefined(level.distorg))
    level.distorg delete();

  var_1 = common_scripts\utility::get_target_ent("baker_end");
  level.baker_end = var_1 maps\_utility::spawn_ai(1);
  level.baker_end thread maps\_utility::magic_bullet_shield();
  level.baker_end.animname = "baker";
  level.baker_end maps\_utility::set_generic_idle_anim("surface_swim_idle");
  level.player thread maps\_swim_player::disable_player_swim();
  level.player notify("stop_scuba_breathe");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player_view_pitch_down = getDvar("player_view_pitch_down");
  setsaveddvar("player_view_pitch_down", 5);
  level.player enableslowaim(0.5, 0.5);
  level.player disableweapons();
  level.player maps\_utility::player_speed_percent(100, 0.1);
  level.player maps\_utility::player_speed_percent(10, 0.1);
  wait 0.25;
  thread maps\_hud_util::fade_in(0.25);
  playFX(common_scripts\utility::getfx("large_water_impact_surface_breach"), level.player.origin);
  level.player thread maps\_utility::play_sound_on_entity("enemy_water_splash");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_orb_greenlit");
  wait 0.3;
  thread maps\_hud_util::fade_out(4);
  maps\_utility::smart_radio_dialogue("shipg_bkr_seeyoutopside");
  level.player setclienttriggeraudiozone("ship_graveyard_fadeout_end", 2.1);
  wait 3.5;
  maps\_utility::nextmission();
}