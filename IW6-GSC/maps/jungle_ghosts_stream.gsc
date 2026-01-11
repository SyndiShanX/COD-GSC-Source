/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\jungle_ghosts_stream.gsc
*****************************************/

friendly_stream_navigation() {
  level.close_stream_enemies = [];
  var_0 = getEntArray("watersheet", "targetname");
  common_scripts\utility::array_thread(var_0, ::watersheet_trig_setup);
  thread stream_vo();

  switch (level.start_point) {
    case "jungle_hill":
    case "jungle_corridor":
    case "parachute":
    case "default":
      thread jungle_cleanup();
    case "stream":
    case "waterfall":
      thread second_distant_sat_launch();
      common_scripts\utility::flag_wait("player_rescued_hostage");
      thread chopper_crash();
      thread chopper_hear_vo();
      level.squad = common_scripts\utility::array_combine(level.alpha, level.bravo);
      common_scripts\utility::flag_wait("second_distant_sat_launch");
      common_scripts\utility::array_thread(level.squad, maps\jungle_ghosts_util::stream_waterfx, "stop_water_footsteps", "step_walk_water");
      common_scripts\utility::array_thread(level.bravo, maps\_utility::set_force_color, "b");
      level.alpha2 maps\_utility::set_force_color("g");
      common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
      common_scripts\utility::array_thread(level.squad, maps\jungle_ghosts_util::generic_ignore_on);
      common_scripts\utility::flag_wait("obj_get_to_river");

      if(!common_scripts\utility::flag("waterfall_to_stream")) {
        maps\_utility::activate_trigger_with_targetname("stream_pos_1");
      }

      var_1 = getEntArray("stream_color_trigs", "script_noteworthy");
      common_scripts\utility::array_thread(var_1, common_scripts\utility::trigger_off);
      common_scripts\utility::flag_wait("chopper_crash_arrive");
      maps\_utility::autosave_by_name("stream_fight");
      thread stream_player_rushes_chopper();
      common_scripts\utility::flag_wait_any("smaw_target_detroyed", "stream_heli_out");
      thread stream_fight_goes_hot();
      thread stream_fight_stealth();
      common_scripts\utility::flag_wait("bridge_area_exit");
      var_1 = getEntArray("stream_color_trigs", "script_noteworthy");
      common_scripts\utility::array_thread(var_1, common_scripts\utility::trigger_off);
      common_scripts\utility::flag_wait("squad_to_waterfall_ambush");
    case "stream waterfall":
      maps\_utility::autosave_by_name("waterfall_ambush");

      if(!common_scripts\utility::flag("stream_backend_start")) {
        if(!common_scripts\utility::flag("ambush_open_fire")) {
          maps\_utility::activate_trigger_with_targetname("waterfall_ambush_setup");
          var_2 = getent("ambush_area", "targetname");
          badplace_cylinder("axis_badplace", -1, var_2.origin, 353, 200, "axis");
          ambush_stealth_settings();
          var_3 = [];

          while(var_3.size != level.squad.size && !common_scripts\utility::flag("stream_backend_start")) {
            foreach(var_5 in level.squad) {
              if(var_5 istouching(var_2) && !maps\_utility::is_in_array(var_3, var_5)) {
                var_3 = common_scripts\utility::add_to_array(var_3, var_5);
              }
            }

            wait 0.5;
          }

          foreach(var_5 in var_3) {
          var_5.perfectaim = 1;
          }

          var_3 = undefined;
          common_scripts\utility::flag_set("squad_in_ambush_position");
          maps\_stealth_utility::stealth_detect_ranges_set(level.ambush_hidden_settings);
          thread player_ambush_area_monitor(var_2);
          common_scripts\utility::flag_wait("player_in_ambush_position");
          common_scripts\utility::flag_set("waterfall_ambush_begin");
          thread waterfall_goes_hot();
          common_scripts\utility::flag_wait_any("waterfall_patrollers_dead", "waterfall_patrollers_passed", "player_rushed_waterfall_passers");
          thread common_scripts\utility::play_sound_in_space("scn_sold1_enemy_radio_static", (3588, 5594, 628));
          maps\_utility::autosave_by_name("stream_backend");
          wait 4;
          common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);

          foreach(var_5 in level.squad) {
          var_5.perfectaim = 0;
          }
        } else
          maps\_utility::activate_trigger_with_targetname("stream2_pos1");
      }

      common_scripts\utility::flag_set("waterfall_ambush_over");
    case "stream backend":
      if(!common_scripts\utility::flag("stream_backend_start")) {
        maps\_utility::activate_trigger_with_targetname("stream2_pos1");
      }

      var_11 = maps\jungle_ghosts_jungle::jungle_enemy_logic;
      maps\_utility::array_spawn_function_targetname("tall_grass_intro_guys_stealth", var_11, "zero", 1);
      maps\_utility::array_spawn_function_targetname("tall_grass_intro_guys_stealth", ::pre_tall_grass_patroller_break_on_sight);
      maps\_utility::array_spawn_function_noteworthy("tall_grass_patroller", ::pre_tall_grass_patroller_logic);
      common_scripts\utility::flag_wait("stream_exit");

      if(common_scripts\utility::flag("ambush_open_fire")) {
        var_12 = getent("stream_backend_moveup_stealth", "targetname");
        var_12 delete();
        common_scripts\utility::flag_wait_any("stream_backend_enemies_dead", "stream_backend_moveup");

        if(!common_scripts\utility::flag("stream_backend_moveup")) {
          maps\_utility::activate_trigger_with_targetname("stream_backend_moveup");
        }
      } else {
        common_scripts\utility::array_thread(level.squad, level.ignore_on_func);
        var_12 = getent("stream_backend_moveup", "targetname");

        if(isDefined(var_12)) {
          var_12 delete();
        }

        common_scripts\utility::flag_wait("stream_exit");
        maps\_utility::activate_trigger_with_targetname("stream_backend_moveup_stealth");
        common_scripts\utility::trigger_off("stream_backend_moveup_stealth", "targetname");
      }
    case "grass cold":
    case "grass":
      common_scripts\utility::array_thread(level.squad, ::squad_save_old_color);
      var_0 = getEntArray("pre_tall_grass_color_trigs", "targetname");
      common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_off);
      maps\_utility::autosave_now();

      if(!common_scripts\utility::flag("ambush_open_fire")) {
        wait 0.1;
        common_scripts\utility::array_thread(level.squad, maps\_utility::set_force_color, "c");
        common_scripts\utility::array_thread(level.squad, ::set_goal_ent_flags);
        level thread set_up_when_patroller_goes();
      }

      common_scripts\utility::flag_wait("to_grassy_field");

      if(!common_scripts\utility::flag("ambush_open_fire")) {
        common_scripts\utility::array_thread(level.squad, ::backend_friendly_stealth_logic);
      }

      maps\_utility::array_notify(level.squad, "stop_water_footsteps");
      level.player notify("stop_water_footsteps");
      thread tall_grass_friendly_navigation();
  }
}

set_up_when_patroller_goes() {
  common_scripts\utility::flag_wait("begin_pre_tall_grass_scene");
  common_scripts\utility::flag_wait("to_grassy_field");
  common_scripts\utility::flag_set("start_pre_grass_patroller");
}

set_goal_ent_flags() {
  maps\_utility::ent_flag_init("at_goal");
  self waittill("goal");
  maps\_utility::ent_flag_set("at_goal");
}

chopper_hear_vo() {
  level endon("can_see_chopper");
  common_scripts\utility::flag_wait("obj_get_to_river");
  wait 7;
  level.merrick maps\_utility::smart_dialogue("jungleg_mrk_soundslikeachoppers");
  wait 0.1;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_ihearitthese");
  wait 0.2;
  level.hesh maps\_utility::smart_dialogue("jungleg_hsh_letsuseitto");
}

stream_enemy_setup(var_0) {
  level thread stream_guys_start_removing();
  maps\_utility::array_spawn_function_targetname("close_guys", ::stream_close_enemy_logic);
  maps\_utility::array_spawn_function_targetname("close_guys", ::on_death_chopper_leave_immediate);
  maps\_utility::array_spawn_function_targetname("bridge_guard", ::stream_bridge_guard_logic);
  maps\_utility::array_spawn_function_targetname("upper_stream_right", ::stream_upper_logic);
  maps\_utility::array_spawn_function_targetname("upper_stream_left", ::stream_upper_logic);
  maps\_utility::array_spawn_function_noteworthy("stream_enemies", ::stream_enemy_logic);
  maps\_utility::array_spawn_function_targetname("ambush_patrol", ::ambush_patrol_logic);
  maps\_utility::array_spawn_function_targetname("stream_backend_enemies", ::stream_enemy_logic);
  maps\_utility::array_spawn_function_targetname("tall_grass_intro_guys_stealth", ::pre_tallgrass_stealth_guys_logic);
  maps\_utility::array_spawn_function_targetname("tall_grass_intro_guys", ::pre_tallgrass_guys_logic);

  switch (var_0) {
    case "start":
      maps\_utility::array_spawn_targetname("close_guys", 1);
      maps\_utility::array_spawn_targetname("bridge_guard", 1);
      common_scripts\utility::flag_wait_any("smaw_target_detroyed", "player_rushed_chopper_crash", "stream_heli_out");
      common_scripts\utility::flag_set("stream_fight_begin");
      thread stream_enemy_setup_on_going_hot();
      common_scripts\utility::flag_wait("bridge_area_exit");

      if(common_scripts\utility::flag("stream_clear")) {
        common_scripts\utility::array_thread(level.squad, level.ignore_on_func);
        common_scripts\utility::array_thread(level.squad, maps\_stealth_utility::enable_stealth_for_ai);
        common_scripts\utility::flag_clear("_stealth_spotted");
        common_scripts\utility::flag_clear("stream_enemy_alert");
      }

      if(common_scripts\utility::flag("bridge_area_exit") && (common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("stream_enemy_alert"))) {
        common_scripts\utility::flag_set("ambush_open_fire");
      }
      else {}

      level.alpha2 maps\_utility::set_force_color("r");
    case "waterfall":
      level.ambush_patrollers = maps\_utility::array_spawn_targetname("ambush_patrol", 1);
      level thread ambush_kickoff_logic();
      common_scripts\utility::flag_wait("player_in_ambush_position");
      common_scripts\utility::flag_wait_or_timeout("ambush_open_fire", 6);
      level.ambush_patrollers = maps\_utility::array_removedead_or_dying(level.ambush_patrollers);
      level thread waterfall_check_patrollers();
      var_1 = randomintrange(0, 4);
      var_2 = "SP_" + var_1 + "_order_action_coverme";
      var_1 = randomintrange(0, 4);
      var_3 = "SP_" + var_1 + "_resp_ack_co_gnrc_affirm";

      if(isDefined(level.ambush_patrollers[0])) {
        level.ambush_patrollers[0] maps\_utility::delaythread(1.5, maps\_utility::play_sound_on_tag, var_2, undefined, 1);
        level.ambush_patrollers[0] maps\_utility::delaythread(3, maps\_utility::play_sound_on_tag, var_3, undefined, 1);
      }

      common_scripts\utility::flag_wait_any("waterfall_patrollers_dead", "waterfall_patrollers_passed", "player_rushed_waterfall_passers");
      thread pre_tall_grass_stealth_settings();
    case "backend":
      common_scripts\utility::flag_wait("stream_backend_start");

      if(common_scripts\utility::flag("ambush_open_fire")) {
        common_scripts\utility::array_thread(level.squad, level.ignore_off_func);
      }

      level.player.ignoreme = 0;
      var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("stream_ambient_heli");
      var_4 maps\_vehicle::mgoff();
      thread tall_grass_globals();

      if(common_scripts\utility::flag("ambush_open_fire")) {
        var_5 = maps\_utility::array_spawn_targetname("stream_backend_enemies", 1);
        wait 4.5;
        var_0 = (4562, 7708, 844);
        var_6 = (4600, 5640, 810);
        var_7 = magicbullet("rpg_straight", var_0, var_6);
        var_7 thread maps\jungle_ghosts_util::escape_earthquake_on_missile_impact();
        level thread rpg_vo_react();
        maps\_utility::battlechatter_on("allies");
      }
    case "none":
      null_func();
  }
}

null_func() {}

rpg_vo_react() {
  wait 0.5;
  level.merrick thread maps\_utility::smart_dialogue("jungleg_mrk_rpg");
}

jungle_cleanup() {
  maps\jungle_ghosts_util::delete_ai_array_safe(level.hill_patrollers);
  maps\jungle_ghosts_util::delete_ai_array_safe(level.jungle_enemies);
}

second_distant_sat_launch() {
  common_scripts\utility::flag_wait("second_distant_sat_launch");
  level.player thread common_scripts\utility::play_sound_in_space("jg_sat_launch_distant_second", level.player.origin);
  earthquake(0.15, 5, level.player.origin, 850);
  thread maps\_utility::autosave_by_name("stream_start");
  level.player playrumblelooponentity("damage_light");
  wait 4.5;
  level.player stoprumble("damage_light");
}

stream_player_rushes_chopper() {
  level endon("stream_heli_out");
  common_scripts\utility::flag_wait("stream_rush_chopper");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 thread maps\jungle_ghosts_util::manually_alert_me();
    var_2.favoriteenemy = level.player;
  }
}

stream_fight_goes_hot() {
  level endon("bridge_area_exit");
  common_scripts\utility::flag_wait_any("_stealth_spotted", "smaw_target_detroyed");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
  var_2 thread maps\jungle_ghosts_util::manually_alert_me();
  }

  var_4 = getEntArray("stream_color_trigs", "script_noteworthy");
  common_scripts\utility::array_thread(var_4, common_scripts\utility::trigger_on);
  common_scripts\utility::flag_wait("stream_fight_begin");

  if(common_scripts\utility::flag("smaw_target_detroyed")) {
    wait 7;
  }

  common_scripts\utility::array_thread(level.squad, level.ignore_off_func);
  common_scripts\utility::array_thread(level.squad, maps\_stealth_utility::disable_stealth_for_ai);
  maps\_utility::activate_trigger_with_targetname("stream_fight_pos_1");
  level.alpha2 maps\_utility::set_force_color("r");
}

stream_fight_stealth() {
  level endon("_stealth_spotted");
  common_scripts\utility::flag_wait("stream_heli_out");
  wait 7;
  var_0 = getEntArray("stream_color_trigs", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_on);
  common_scripts\utility::array_thread(level.squad, common_scripts\utility::delaycall, 2, ::clearentitytarget);
  maps\_utility::activate_trigger_with_targetname("stream_fight_pos_1");
  level.alpha2 maps\_utility::set_force_color("r");
  common_scripts\utility::flag_set("stream_clear");
}

stream_enemy_setup_on_going_hot() {
  level endon("bridge_approach");
  common_scripts\utility::flag_wait_any("_stealth_spotted", "smaw_target_detroyed");
  thread maps\jungle_ghosts_util::spawn_ai_throttled_targetname("lower_stream_group_1", 1, 2.5);
  wait 2;

  if(common_scripts\utility::cointoss()) {
    var_0 = "upper_stream_left";
  }
  else {
    var_0 = "upper_stream_right";
  }

  thread spawn_bridge_guys(var_0);
  level thread stream_set_cleared_when_guys_dead();
  common_scripts\utility::waittill_notify_or_timeout("done_throttled_spawn", 7);
}

stream_set_cleared_when_guys_dead() {
  level endon("stream_clear");
  level endon("bridge_area_exit");
  level.stream_baddies = getaiarray("axis");

  if(!isDefined(level.ambush_patrol_guys)) {
    level.ambush_patrol_guys = [];
  }

  level.stream_baddies = common_scripts\utility::array_remove_array(level.stream_baddies, level.ambush_patrol_guys);
  thread maps\jungle_ghosts_util::set_flag_when_x_remain_custom_stream(0, "stream_clear");

  for(;;) {
    wait 0.25;
    var_0 = getaiarray("axis");
    var_0 = common_scripts\utility::array_remove_array(var_0, level.ambush_patrol_guys);
    level.stream_baddies = var_0;
  }
}

stream_upper_logic() {
  maps\_utility::set_ai_bcvoice("shadowcompany");
  self.goalradius = 64;
  self.dropweapon = 0;
  self setgoalnode(getnode(self.target, "targetname"));
}

stream_close_enemy_logic() {
  level endon("_stealth_spotted");
  self endon("death");
  level endon("stream_enemy_alert");
  maps\_utility::set_ai_bcvoice("shadowcompany");
  level.close_stream_enemies = common_scripts\utility::array_add(level.close_stream_enemies, self);
  common_scripts\utility::flag_wait("chopper_about_to_leave");
  thread stream_enemy_alert_team_after_chopper_leaves();
  thread stream_enemy_alerted_after_chopper_logic();
  maps\_utility::clear_run_anim();

  if(isDefined(self.script_noteworthy) && (self.script_noteworthy == "crate_guy1" || self.script_noteworthy == "crate_guy2" || self.script_noteworthy == "crate_guy3")) {
    if(self.script_noteworthy == "crate_guy1") {
      wait 0.5;
    }

    if(self.script_noteworthy == "crate_guy2") {
      wait 1;
    }

    if(self.script_noteworthy == "crate_guy3") {
      wait 1.5;
    }
  } else
    wait(randomfloatrange(2, 4));

  self setgoalpos(self.origin);
  self setgoalvolumeauto(getent("stream_runaway_delete_vol", "targetname"));
  wait 3;
  self waittill("goal");
  common_scripts\utility::flag_set("start_removing_stream_guys");
}

stream_guys_start_removing() {
  common_scripts\utility::flag_wait("start_removing_stream_guys");
  thread maps\_utility::ai_delete_when_out_of_sight(level.close_stream_enemies, 1000);
}

stream_enemy_alert_team_after_chopper_leaves() {
  self waittill("damage");
  common_scripts\utility::flag_set("stream_enemy_alert");
}

stream_squad_disengage_stealth_after_chopper_leaves_on_hot() {
  common_scripts\utility::flag_wait("stream_enemy_alert");
  common_scripts\utility::array_thread(level.squad, maps\_stealth_utility::disable_stealth_for_ai);
  common_scripts\utility::array_thread(level.squad, maps\jungle_ghosts_util::generic_ignore_off);
}

stream_enemy_alerted_after_chopper_logic() {
  self endon("death");
  common_scripts\utility::flag_wait("stream_enemy_alert");
  self.goalradius = 800;
  self setgoalentity(level.player);
  maps\jungle_ghosts_util::manually_alert_me();
  thread maps\_utility::set_battlechatter(1);
}

stream_bridge_guard_logic() {
  level endon("_stealth_spotted");
  self endon("death");
  maps\_utility::set_ai_bcvoice("shadowcompany");
  self.og_node = getnode(self.target, "targetname");
  common_scripts\utility::flag_wait("chopper_about_to_leave");
  thread bridge_guards_backup_alert_after_chopper_leaves();
  self.goalradius = 64;
  maps\_utility::clear_run_anim();
  wait(randomfloatrange(2, 4));
  self setgoalnode(getnode("bridge_guard_run_node", "targetname"));
  wait 3;
  self setgoalnode(getnode("bridge_guard_run_node", "targetname"));
  wait 3;
  self setgoalnode(getnode("bridge_guard_run_node", "targetname"));
  wait 3;
  self setgoalnode(getnode("bridge_guard_run_node", "targetname"));
  self waittill("goal");
  self delete();
}

bridge_guards_backup_alert_after_chopper_leaves() {
  self endon("death");
  common_scripts\utility::flag_wait("_stealth_spotted");
  thread maps\_utility::set_battlechatter(1);
  wait 1;
  self.goalradius = 64;

  for(;;) {
    self.goalradius = 128;
    self setgoalnode(self.og_node);
    wait 0.5;
  }
}

crate_casualty_enemy_logic() {
  level endon("_stealth_spotted");
  self endon("death");
}

spawn_bridge_guys(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy)) {
      var_4 = var_3 maps\_utility::spawn_ai(1);
      var_4 thread stream_enemy_logic();
      var_4 maps\_utility::enable_sprint();
      var_1 = common_scripts\utility::array_remove(var_1, var_3);
      break;
    }
  }

  wait 2;

  foreach(var_3 in var_1) {
    var_4 = var_3 maps\_utility::spawn_ai(1);
    var_4 thread stream_enemy_logic();
    var_4 maps\_utility::enable_sprint();
    wait(randomfloatrange(2, 4));
  }
}

stream_enemy_logic() {
  if(self.target == "director_goto") {
    thread direct_chopper_crate_anim();
  }

  self.goalradius = 32;
  maps\_utility::set_ai_bcvoice("shadowcompany");
  thread maps\_utility::set_battlechatter(0);
  maps\_utility::disable_long_death();
  maps\_utility::disable_blood_pool();
  thread maps\jungle_ghosts_util::grenade_ammo_probability(20);
}

direct_chopper_crate_anim() {
  self endon("death");
  self.allowdeath = 1;
  var_0 = common_scripts\utility::get_target_ent("director_node");
  var_0 thread maps\_anim::anim_generic_loop(self, "chopper_crate_directing", "stop_loop");
  thread maps\jungle_ghosts_util::stop_anim_on_damage_stealth(var_0);
  thread maps\jungle_ghosts_util::stop_anim_on_spotted_or_chopper_leaves(var_0);
  maps\_utility::gun_remove();
  level common_scripts\utility::waittill_any("chopper_about_to_leave", "_stealth_spotted", "stream_rush_chopper");
  wait 2;
  var_0 notify("stop_loop");
  maps\_utility::anim_stopanimscripted();
  common_scripts\utility::waitframe();
  maps\_utility::gun_recall();
}

#using_animtree("vehicles");

chopper_crash() {
  level endon("stream_heli_out");
  chopper_crash_enemies();
  thread chopper_rumble_earthquake();
  var_0 = getent("crash_final_collision", "targetname");
  var_0 notsolid();
  var_1 = getent("dest_crate", "targetname");
  var_1 notsolid();
  var_1 connectpaths();
  var_2 = common_scripts\utility::getstruct("new_crash", "targetname");
  var_2.chopper = maps\_vehicle::spawn_vehicle_from_targetname("supply_heli");
  var_2.chopper endon("suspend_drive_anims");
  var_2.chopper setModel("vehicle_aas_72x_destructible");
  var_2.chopper.animname = "aas";
  wait 1;
  var_2.chopper thread chopper_sound();
  var_2.crate_clip = getent("chopper_clip", "targetname");
  var_2.crate_clip thread kill_player_on_touch();
  var_2.crate_clip.origin = var_2.chopper.origin;
  var_2.crate_clip.angles = var_2.chopper.angles;
  var_2.crate_clip linkto(var_2.chopper, "tag_origin");
  var_2.crate_clip thread notify_on_damage_chopper();
  level.chopper_pilot_ent = var_2.crate_clip;
  var_3 = getent("chopper_pilot", "targetname");
  var_3 setspawnerteam("axis");
  var_2.pristine_crate = maps\_utility::spawn_anim_model("pristine_crate");
  var_2.damaged_crate = maps\_utility::spawn_anim_model("damaged_crate");
  var_2.damaged_crate hide();
  var_2.pilot = maps\_utility::spawn_targetname("chopper_pilot", 1);
  var_2.pilot.animname = "pilot";
  var_2.pilot.team = "axis";
  var_2.pilot.name = "";
  var_2.pilot thread crash_pilot_logic(var_2.chopper);
  var_2.pilot thread notify_on_damage();
  var_2.actors = [var_2.pristine_crate, var_2.damaged_crate, var_2.chopper];
  var_2.pilot linkto(var_2.chopper, "tag_pilot1", (0, 0, 0), (0, 0, 0));
  var_2.chopper thread maps\_anim::anim_loop_solo(var_2.pilot, "new_crash_idle", "stop_loop", "tag_pilot1");
  var_2 thread maps\_anim::anim_loop(var_2.actors, "new_crash_idle");
  var_2 thread chopper_leaves_after_time();
  common_scripts\utility::flag_wait("smaw_target_detroyed");
  var_4 = getaiarray("axis");

  foreach(var_6 in var_4) {
  var_6 thread maps\jungle_ghosts_util::manually_alert_me();
  }

  var_8 = getanimlength( % jungle_ghost_helicrash_helicopter);
  var_2.crate_clip thread crate_clip_of_doom();
  var_2.crate_clip thread maps\_utility::notify_delay("stop_checking_collision", var_8);
  maps\_utility::delaythread(var_8, common_scripts\utility::flag_set, "chopper_crash_complete");
  var_2 notify("stop_loop");
  var_2.chopper notify("stop_loop");
  var_2.pilot notify("stop_loop");
  var_2.chopper thread maps\_anim::anim_single_solo(var_2.pilot, "new_crash", "tag_pilot1");
  var_2.pilot linkto(var_2.chopper, "tag_pilot1");
  var_2 maps\_anim::anim_single(var_2.actors, "new_crash");
  level notify("chopper down");
}

kill_player_on_touch() {
  level endon("chopper down");
  level endon("stream_heli_out");

  for(;;) {
    if(level.player istouching(self)) {
      level.player enabledeathshield(0);
      level.player enablehealthshield(0);
      level.player kill();
    }

    wait 0.1;
  }
}

chopper_leaves_after_time() {
  level endon("smaw_target_detroyed");
  self.chopper endon("death");
  common_scripts\utility::flag_wait("can_see_chopper");
  common_scripts\utility::flag_wait("time_for_chopper_to_leave");
  self notify("stop_loop");
  self.chopper notify("stop_loop");
  self.pilot notify("stop_loop");
  common_scripts\utility::flag_set("stream_heli_out");
  self.pristine_crate linkto(self.chopper, "tag_origin");
  self.chopper thread maps\_anim::anim_loop_solo(self.pilot, "new_crash_idle", "stop_loop", "tag_pilot1");
  self.chopper stopanimscripted();
  self.chopper setanim(level.vehicle_driveidle["vehicle_aas_72x"], 1, 0.2, 1);
  var_0 = getent("supply_chopper_leave", "targetname");
  var_1 = 20;
  self.chopper setlookatent(var_0);
  self.chopper setvehgoalpos(var_0.origin, 1);
  self.chopper vehicle_setspeed(var_1, var_1 / 2, var_1 / 2);
  wait 3;

  while(isDefined(var_0.target)) {
    var_0 = getent(var_0.target, "targetname");
    self.chopper setlookatent(var_0);
    self.chopper setvehgoalpos(var_0.origin, 0);
    wait 8;
  }

  wait 22;

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  if(isDefined(self.pristine_crate)) {
    self.pristine_crate delete();
  }

  if(isDefined(self.damaged_crate)) {
    self.damaged_crate delete();
  }

  if(isDefined(self.chopper)) {
    self.chopper delete();
  }
}

chopper_rumble_earthquake() {
  common_scripts\utility::flag_wait("chopper_impact");
  earthquake(0.6, 0.75, level.player.origin, 800);
  level.player playrumbleonentity("grenade_rumble");
  wait 0.8;
  earthquake(0.4, 0.5, level.player.origin, 800);
  level.player playrumbleonentity("grenade_rumble");
}

chopper_sound() {
  level endon("stream_heli_out");
  thread common_scripts\utility::play_loop_sound_on_entity("aascout72x_engine_high");
  common_scripts\utility::flag_wait("smaw_target_detroyed");
  thread common_scripts\utility::stop_loop_sound_on_entity("aascout72x_engine_high");
  wait 4;
  self notify("stop_kicking_up_dust");
}

crash_pilot_logic(var_0) {
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.ragdoll_immediate = 1;
  common_scripts\utility::flag_wait("chopper_impact");
  wait 3;
  self.allowdeath = 1;
  self.a.nodeath = 1;
  maps\_utility::die();
  self startragdoll();
}

notify_on_damage() {
  level endon("stream_heli_out");
  self setCanDamage(1);
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  var_10 = 0.5;

  if(!common_scripts\utility::flag("smaw_target_detroyed")) {
    if(isDefined(var_1)) {
      if(var_1 == level.player) {
        wait(var_10);
        common_scripts\utility::flag_set("smaw_target_detroyed");
      }
    }
  }
}

notify_on_damage_chopper() {
  level endon("stream_heli_out");
  self setCanDamage(1);

  for(var_0 = 0; var_0 < 600; var_0 = var_0 + var_1) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  common_scripts\utility::flag_set("do_stream_chopper_fx");

  if(!common_scripts\utility::flag("smaw_target_detroyed")) {
    if(isDefined(var_2)) {
      if(var_2 == level.player) {
        common_scripts\utility::flag_set("smaw_target_detroyed");
      }
    }
  }
}

crate_clip_of_doom() {
  self endon("stop_checking_collision");
  var_0 = getaiarray("axis");
  var_0 = common_scripts\utility::add_to_array(var_0, level.player);

  for(;;) {
    foreach(var_2 in var_0) {
      if(isalive(var_2) && var_2 istouching(self)) {
        var_2 thread maps\_utility::die();
      }
    }

    wait 0.05;
  }
}

chopper_crash_enemies() {
  maps\_utility::array_spawn_function_targetname("crate_casualty", ::chopper_crash_guy_logic);
  maps\_utility::array_spawn_function_targetname("crate_casualty", ::crate_casualty_enemy_logic);
  maps\_utility::array_spawn_function_targetname("crate_casualty", ::on_death_chopper_leave_immediate);
  maps\_utility::array_spawn_function_targetname("crate_casualty", ::stream_close_enemy_logic);
  maps\_utility::array_spawn_function_targetname("bridge_guard", ::on_death_chopper_leave_immediate);
  maps\_utility::array_spawn_targetname("crate_casualty", 1);
  thread stream_enemy_setup("start");
  level.crash_hidden_settings["prone"] = 70;
  level.crash_hidden_settings["crouch"] = 300;
  level.crash_hidden_settings["stand"] = 450;
  maps\_stealth_utility::stealth_detect_ranges_set(level.crash_hidden_settings);
}

crate_death_fling() {
  animscripts\shared::dropallaiweapons();
  self.skipdeathanim = 1;
  self startragdollfromimpact("torso_lower", (randomintrange(-4000, -2000), 2500, 2250));
  wait 0.05;
}

on_death_chopper_leave_immediate() {
  level endon("stream_heli_out");
  maps\_utility::set_ai_bcvoice("shadowcompany");
  common_scripts\utility::waittill_any("death", "damage");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 thread maps\jungle_ghosts_util::manually_alert_me();
    var_2.favoriteenemy = level.player;
  }

  wait(randomfloatrange(0.25, 1.0));
  common_scripts\utility::flag_set("time_for_chopper_to_leave");
}

chopper_crash_guy_logic() {
  self endon("death");
  maps\_utility::set_ai_bcvoice("shadowcompany");
  thread maps\_utility::set_battlechatter(0);
  self.goalradius = 32;
  maps\_utility::set_grenadeammo(0);
  maps\_utility::disable_long_death();
  self.animname = "generic";
  common_scripts\utility::flag_wait("box_swap");
  self.old_deathfunction = self.deathfunction;
  self.deathfunction = ::crate_death_fling;
  wait 2;
  self.deathfunction = self.old_deathfunction;
}

stop_anim_on_damage() {
  self endon("death");
  self waittill("damage");
  self stopanimscripted();
}

watersheet_trig_setup() {
  level endon("tall_grass_begin");
  level thread watersheet_sound(self);

  for(;;) {
    self waittill("trigger");
    level.player setwatersheeting(1, 2);
    level.player playrumbleonentity("damage_light");
    wait 0.5;

    if(level.player istouching(self)) {
      level.player setwatersheeting(0);
      continue;
    }

    wait 1.5;
  }
}

watersheet_sound(var_0) {
  level endon("tall_grass_begin");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = spawn("script_origin", level.player getEye());
    var_1 thread maps\_utility::play_sound_on_entity("scn_jungle_under_falls_plr_enter");
    var_1 playLoopSound("scn_jungle_under_falls_plr");
    var_1 scalevolume(0.0, 0.0);
    wait 0.1;
    var_1 scalevolume(1.0, 0.15);

    while(level.player istouching(var_0)) {
      wait 0.1;
    }

    var_1 thread maps\_utility::play_sound_on_entity("scn_jungle_under_falls_plr_exit");
    wait 0.15;
    var_1 scalevolume(0.0, 0.15);
    wait 0.2;
    var_1 common_scripts\utility::stop_loop_sound_on_entity("scn_jungle_under_falls_plr");
    var_1 delete();
  }
}

ambush_stealth_settings() {
  var_0 = [];
  var_0["player_dist"] = 1;
  var_0["sight_dist"] = 1;
  var_0["detect_dist"] = 1;
  var_0["found_dist"] = 1;
  var_0["found_dog_dist"] = 1;
  maps\_stealth_utility::stealth_corpse_ranges_custom(var_0);
  level.ambush_hidden_settings = [];
  level.ambush_hidden_settings["prone"] = 1;
  level.ambush_hidden_settings["crouch"] = 1;
  level.ambush_hidden_settings["stand"] = 1;
  level.ambush_visible_settings = [];
  level.ambush_visible_settings["prone"] = 1024;
  level.ambush_visible_settings["crouch"] = 1024;
  level.ambush_visible_settings["stand"] = 1024;
}

player_ambush_area_monitor(var_0) {
  level endon("ambush_open_fire");
  level endon("waterfall_patrollers_passed");
  var_1 = 1;
  var_2 = 0.5;
  var_3 = 10;
  var_4 = getent("hidden_in_waterfalls", "targetname");

  while(!level.player istouching(var_0) && !level.player istouching(var_4)) {
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("player_in_ambush_position");

  if(!common_scripts\utility::flag("ambush_open_fire")) {
    common_scripts\utility::array_thread(level.squad, level.ignore_on_func);
    common_scripts\utility::array_thread(level.squad, maps\_stealth_utility::enable_stealth_for_ai);
  }

  for(;;) {
    while(level.player istouching(var_0) || level.player istouching(var_4)) {
      wait 0.25;
    }

    common_scripts\utility::flag_clear("player_in_ambush_position");
    maps\_stealth_utility::stealth_detect_ranges_set(level.ambush_visible_settings);
    common_scripts\utility::array_thread(level.ambush_patrollers, maps\_stealth_shared_utilities::ai_clear_custom_animation_reaction);
    common_scripts\utility::array_thread(level.ambush_patrollers, maps\_utility::set_baseaccuracy, var_3);

    while(!level.player istouching(var_0) && !level.player istouching(var_4)) {
      wait 0.25;
    }

    common_scripts\utility::flag_set("player_in_ambush_position");
    maps\_stealth_utility::stealth_detect_ranges_set(level.ambush_hidden_settings);

    foreach(var_6 in level.ambush_patrollers) {
      if(maps\jungle_ghosts_util::isdefined_and_alive(var_6)) {
        var_6 thread maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(var_6, var_6.script_noteworthy, "tag_origin", "steve_ender");
        var_6 thread maps\_utility::set_baseaccuracy(var_2);
      }
    }
  }
}

ambush_patrol_logic() {
  self endon("death");

  if(!isDefined(level.ambush_patrol_guys)) {
    level.ambush_patrol_guys = [];
  }

  level.ambush_patrol_guys = common_scripts\utility::array_add(level.ambush_patrol_guys, self);
  self.oldmaxsight = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 1;
  maps\_utility::enable_cqbwalk();
  maps\_utility::set_ai_bcvoice("shadowcompany");
  thread maps\_utility::set_battlechatter(0);
  self.goalradius = 32;
  self.interval = 0;
  maps\_utility::set_grenadeammo(0);
  thread ambush_damage_notify();
  maps\_utility::disable_long_death();
  self.animname = "generic";
  self.disablearrivals = 1;
  thread ambush_guy_outcome_logic();
  thread ambush_guy_change_sight_dist();
  thread follow_on_went_hot();
  thread delete_me_after_time();
  thread maps\_utility::pathrandompercent_zero();
  thread maps\_utility::walkdist_zero();

  if(maps\jungle_ghosts_util::has_script_parameters("orders_guy")) {
    thread ambush_guy_does_anim("patrol_jog_orders_once");
    return;
  }

  if(maps\jungle_ghosts_util::has_script_parameters("360_guy")) {
    thread ambush_guy_does_anim("patrol_jog_360_once");
    return;
  }

  maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self, self.script_noteworthy, "tag_origin", "steve_ender");
}

set_ignore_until_fired_at() {
  self endon("death");
  self.ignoreme = 1;
  common_scripts\utility::flag_wait("ambush_open_fire");
  self.ignoreme = 0;
}

delete_me_after_time() {
  self endon("death");
  wait 50;

  while(isDefined(self)) {
    if(!maps\_utility::player_can_see_ai(self) && !maps\_utility::within_fov_of_players(self.origin, cos(45)) && level.player.origin[0] > 4096) {
      common_scripts\utility::array_remove(level.ambush_patrollers, self);
      self delete();
    }

    wait 0.5;
  }
}

follow_on_went_hot() {
  self endon("death");
  thread follow_on_went_hot_logic();
  common_scripts\utility::waittill_any("_stealth_spotted", "_stealth_enemy_alert_level_change");
  common_scripts\utility::flag_set("waterfall_went_hot_late");
}

follow_on_went_hot_logic() {
  self endon("death");
  common_scripts\utility::flag_wait_any("ambush_open_fire", "waterfall_went_hot_late");
  wait(randomfloatrange(0.25, 1.25));
  thread maps\jungle_ghosts_util::manually_alert_me();
  self.goalradius = 250;
  self setgoalentity(level.player);
}

ambush_guy_change_sight_dist() {
  self endon("death");
  level endon("ambush_open_fire");
  var_0 = getent("hidden_in_waterfalls", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      self.maxsightdistsqrd = 1;
    }
    else {
      self.maxsightdistsqrd = self.oldmaxsight;
    }

    wait 0.5;
  }
}

ambush_guy_outcome_logic() {
  self endon("death");
  common_scripts\utility::flag_wait("ambush_open_fire");
  wait 0.5;
  self.maxsightdistsqrd = self.oldmaxsight;
  self.goalradius = 100;
  self setgoalentity(level.player);

  if(common_scripts\utility::flag("player_didnt_ambush")) {
    common_scripts\utility::flag_set("waterfall_ambush_begin");
    self stopanimscripted();
    maps\_utility::disable_cqbwalk();
    self.perfectaim = 1;
    self.favoriteenemy = level.player;
    return;
  }
}

ambush_guy_does_anim(var_0) {
  self endon("death");
  self endon("damage");
  self endon("_stealth_enemy_alert_level_change");
  common_scripts\utility::flag_wait("waterfall_ambush_begin");
  maps\_utility::disable_cqbwalk();
  maps\_utility::set_generic_run_anim("patrol_jog");
  var_1 = common_scripts\utility::getstruct(var_0, "script_noteworthy");
  var_1 maps\_anim::anim_reach_solo(self, var_0);
  var_1 maps\_anim::anim_single_solo(self, var_0);
}

ambush_damage_notify() {
  thread maps\_stealth_utility::stealth_enemy_endon_alert();
  common_scripts\utility::waittill_any("damage", "bulletwhizby", "stealth_enemy_endon", "_stealth_enemy_alert_level_change");
  level notify("ambush_enemy_shot");
  common_scripts\utility::flag_set("ambush_open_fire");
  self stopanimscripted();
}

ambush_kickoff_logic() {
  thread ambush_player_ran_ahead();
  thread ambush_player_did_ambush();
}

waterfall_goes_hot() {
  common_scripts\utility::flag_wait("ambush_open_fire");
  badplace_delete("axis_badplace");
  common_scripts\utility::array_thread(level.squad, level.ignore_off_func);
  maps\_utility::battlechatter_on();
}

ambush_player_ran_ahead() {
  level endon("waterfall_patrollers_passed");
  level endon("waterfall_patrollers_dead");
  var_0 = getent("ambush_early", "targetname");
  var_0 waittill("trigger");
  thread sky_change();
  common_scripts\utility::flag_set("player_didnt_ambush");
  common_scripts\utility::flag_set("player_in_ambush_position");
  maps\_stealth_utility::disable_stealth_system();
  common_scripts\utility::array_thread(level.squad, level.ignore_off_func);
  maps\_utility::battlechatter_on();
  common_scripts\utility::flag_wait("stream_backend_start");

  if(!common_scripts\utility::flag("waterfall_patrollers_dead") && !common_scripts\utility::flag("waterfall_patrollers_passed")) {
    common_scripts\utility::flag_set("player_rushed_waterfall_passers");
  }
}

ambush_player_did_ambush() {
  level endon("ambush_enemy_shot");
  common_scripts\utility::flag_wait("player_in_ambush_position");
  thread sky_change();
  wait 0.5;
  var_0 = 13;

  if(!common_scripts\utility::flag("player_didnt_ambush")) {
    wait(var_0);
    level notify("ambush_safe_timeout");
    common_scripts\utility::flag_set("waterfall_patrollers_passed");
  }
}

waterfall_check_patrollers() {
  level endon("stream_exit");
  maps\_utility::waittill_dead_or_dying(level.ambush_patrollers);
  common_scripts\utility::flag_set("waterfall_patrollers_dead");
}

pre_tall_grass_stealth_settings() {
  var_0 = [];
  var_0["prone"] = 70;
  var_0["crouch"] = 400;
  var_0["stand"] = 600;
  var_1 = [];
  var_1["prone"] = 500;
  var_1["crouch"] = 1500;
  var_1["stand"] = 2000;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
  var_2 = [];
  var_2["player_dist"] = 600;
  var_2["sight_dist"] = 200;
  var_2["detect_dist"] = 100;
  var_2["found_dist"] = 50;
  var_2["found_dog_dist"] = 50;
  maps\_stealth_utility::stealth_corpse_ranges_custom(var_2);
}

backend_friendly_stealth_logic() {
  level common_scripts\utility::flag_wait_any("_stealth_spotted", "backend_friendlies_go_hot");
  common_scripts\utility::array_thread(level.squad, level.ignore_off_func);

  if(isDefined(self.old_color)) {
    if(common_scripts\utility::flag("pre_tall_grass_friendly_moveup_3")) {
      common_scripts\utility::flag_wait("moving_into_tall_grass");
    }

    maps\_utility::set_force_color(self.old_color);
  }

  self allowedstances("crouch", "prone", "stand");
  badplace_delete("pre_tall_grass0");
  badplace_delete("pre_tall_grass1");
}

squad_save_old_color() {
  if(isDefined(self.script_forcecolor)) {
    self.old_color = self.script_forcecolor;
  }
  else if(isDefined(self.old_forcecolor)) {
    self.old_color = self.old_forcecolor;
  }
}

pre_tallgrass_stealth_guys_logic() {
  self endon("death");
  maps\_utility::set_ai_bcvoice("shadowcompany");
  thread check_death();
  common_scripts\utility::waittill_any("_stealth_spotted", "_stealth_enemy_alert_level_change");
  common_scripts\utility::flag_set("backend_friendlies_go_hot");
  thread check_if_went_hot_late();
  wait(randomintrange(1, 3));
  self.goalradius = 250;
  self setgoalentity(level.player);
}

check_death() {
  if(isDefined(self.script_noteworthy)) {
    return;
  }
  self waittill("death");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
  var_2 maps\jungle_ghosts_util::manually_alert_me();
  }
}

check_if_went_hot_late() {
  self endon("death");
  common_scripts\utility::flag_wait("field_entrance");
  common_scripts\utility::flag_set("backend_friendlies_go_hot_late");
  common_scripts\utility::flag_clear("clear_to_move_into_tall_grass");
  wait 1;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
  var_2 thread maps\jungle_ghosts_util::manually_alert_me();
  }

  wait 5;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
  var_2 thread maps\jungle_ghosts_util::manually_alert_me();
  }

  wait 5;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
  var_2 thread maps\jungle_ghosts_util::manually_alert_me();
  }

  wait 5;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
  var_2 thread maps\jungle_ghosts_util::manually_alert_me();
  }
}

pre_tall_grass_went_hot_vo() {
  level endon("field_entrance");
  thread player_caught_in_the_middle();
  common_scripts\utility::flag_wait("backend_friendlies_go_hot");
  maps\jungle_ghosts_util::dialogue_stop();
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_shitgoloud");

  while(getaiarray("axis").size > 0) {
    wait 0.25;
  }

  wait 0.75;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_gs1_okwereclear");
}

player_caught_in_the_middle() {
  level endon("field_halfway");
  common_scripts\utility::flag_wait("field_entrance");
  wait 5;
  level common_scripts\utility::waittill_any("backend_friendlies_go_hot", "_stealth_spotted");
  var_0 = getaiarray("axis");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3.origin[1] < 9500) {
      var_1 = 1;
    }
  }

  if(var_1) {
    maps\jungle_ghosts_util::dialogue_stop();
    level.alpha1 maps\_utility::smart_dialogue("jungleg_pri_targetsfrontandbehind");
  }
}

pre_tallgrass_guys_logic() {
  self endon("death");
  maps\_utility::set_ai_bcvoice("shadowcompany");
  common_scripts\utility::flag_wait("retreat_to_tall_grass");
  thread maps\jungle_ghosts_util::kill_me_from_closest_enemy();
  wait(randomfloatrange(0.1, 2.5));
  maps\_utility::set_force_color("p");
  maps\_utility::enable_ai_color();
}

pre_tall_grass_patroller_logic() {
  maps\_utility::set_ai_bcvoice("shadowcompany");
  level thread pre_tall_grass_patroller_watcher();
  thread pre_tall_grass_patroller_break_on_sight();
  thread clean_up_on_death();
}

clean_up_on_death() {
  level endon("_stealth_spotted");
  level endon("_stealth_enemy_alert_level_change");
  level endon("pre_tall_grass_friendly_moveup_3");
  self waittill("death");
  level.alpha2 maps\_utility::smart_dialogue("jungleg_kgn_hesdone");

  if(!common_scripts\utility::flag("_stealth_spotted")) {
    common_scripts\utility::flag_set("pre_tall_grass_friendly_moveup_1");
    wait 10;
    common_scripts\utility::flag_set("pre_tall_grass_friendly_moveup_2");
    wait 20;
    common_scripts\utility::flag_set("pre_tall_grass_friendly_moveup_3");
  }
}

pre_tall_grass_patroller_break_on_sight() {
  self endon("death");
  maps\_utility::set_ai_bcvoice("shadowcompany");
  common_scripts\utility::waittill_any("_stealth_spotted", "_stealth_enemy_alert_level_change");
  common_scripts\utility::flag_set("backend_friendlies_go_hot");
  self setgoalentity(level.player);
}

pre_tall_grass_friendly_movement() {
  level endon("_stealth_spotted");
  level endon("backend_friendlies_go_hot");
  var_0 = common_scripts\utility::getstructarray("pre_grass_friendly_bad_places", "targetname");

  foreach(var_3, var_2 in var_0) {
  badplace_cylinder("pre_tall_grass" + var_3, 0, var_2.origin, var_2.radius, 300, "allies");
  }

  var_4 = getent("pre_tall_grass_stealth_move_1", "script_noteworthy");
  var_5 = getent("pre_tall_grass_stealth_move_2", "script_noteworthy");
  var_6 = getent("pre_tall_grass_stealth_move_3", "script_noteworthy");

  if(level.start_point != "grass chopper") {
    level.squad[0] maps\_utility::ent_flag_wait("at_goal");
    level.squad[1] maps\_utility::ent_flag_wait("at_goal");
    level.squad[2] maps\_utility::ent_flag_wait("at_goal");
    level.squad[3] maps\_utility::ent_flag_wait("at_goal");
  }

  common_scripts\utility::flag_set("begin_pre_tall_grass_scene");
  common_scripts\utility::array_call(level.squad, ::allowedstances, "crouch", "prone");
  common_scripts\utility::flag_wait("pre_tall_grass_friendly_moveup_1");
  wait 5.5;
  var_4 notify("trigger");
  common_scripts\utility::flag_wait("pre_tall_grass_friendly_moveup_2");
  wait 0.25;
  var_5 notify("trigger");
  common_scripts\utility::flag_wait("pre_tall_grass_friendly_moveup_3");
  wait 0.25;
  var_6 notify("trigger");
}

pre_tall_grass_patroller_watcher() {
  level endon("_stealth_spotted");
  level endon("backend_friendlies_go_hot");
  var_0 = common_scripts\utility::getstruct("pre_tall_grass_patrol_1", "script_noteworthy");
  var_1 = common_scripts\utility::getstruct("pre_tall_grass_patrol_2", "script_noteworthy");
  var_2 = common_scripts\utility::getstruct("pre_tall_grass_patrol_3", "script_noteworthy");
  var_3 = common_scripts\utility::getstruct("pre_tall_grass_patrol_4", "script_noteworthy");
  var_4 = common_scripts\utility::getstruct("pre_tall_grass_patrol_5", "script_noteworthy");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set("pre_tall_grass_friendly_moveup_1");
  var_3 waittill("trigger");
  common_scripts\utility::flag_set("pre_tall_grass_friendly_moveup_2");
  var_4 waittill("trigger");
  common_scripts\utility::flag_set("pre_tall_grass_friendly_moveup_3");
}

tall_grass_intro_goes_hot() {
  common_scripts\utility::flag_wait("tall_grass_intro_goes_hot");
  common_scripts\utility::array_thread(level.squad, level.ignore_off_func);
}

tall_grass_globals(var_0) {
  setsaveddvar("ai_foliageSeeThroughDist", 50000);
  thread tall_grass_moving_grass_settings();
  thread tall_grass_vo();
  thread tall_grass_weather();
  thread pre_tall_grass_stealth_settings();
  thread pre_tall_grass_went_hot_vo();
  common_scripts\utility::flag_wait("to_grassy_field");
  common_scripts\utility::flag_set("clear_to_move_into_tall_grass");

  if(!isDefined(var_0) && common_scripts\utility::flag("ambush_open_fire")) {
    maps\_utility::delaythread(7, common_scripts\utility::flag_set, "tall_grass_intro_goes_hot");
    maps\_utility::battlechatter_on();
  }

  level.player setviewkickscale(0.5);
  level.player setmovespeedscale(0.8);
  createthreatbiasgroup("axis_preffered_targets");
  setthreatbias("axis", "axis_preffered_targets", 100000);
  common_scripts\utility::array_thread(level.squad, maps\_utility::set_baseaccuracy, 0.5);
  common_scripts\utility::flag_wait("field_entrance");
  thread grass_aas_approach();
  common_scripts\utility::flag_wait("tall_grass_heli_unloaded");
  thread maps\jungle_ghosts_util::music_tall_grass();
}

grass_aas_approach() {
  if(!common_scripts\utility::flag("_stealth_enabled")) {
    thread maps\_stealth_utility::enable_stealth_system();
  }

  level.clear_to_go_flag_set_once = 0;
  level thread tall_grass_stealth_settings();
  level thread tall_grass_friendly_ignore_state();
  level thread tall_grass_handle_player_opening_fire();
  maps\_utility::array_spawn_function_targetname("tall_grass_chopper_guys", ::aas_guys_spawn_logic);
  common_scripts\utility::array_call(level.squad, ::setthreatbiasgroup, "friendly_squad");

  if(level.player.origin[0] > 4000) {
    var_0[0] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chops_r1");
    var_0[1] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chops_r2");
    var_0[2] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chops_r3");
  } else {
    var_0[0] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chops_l1");
    var_0[1] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chops_l2");
    var_0[2] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("chops_l3");
  }

  common_scripts\utility::array_thread(var_0, ::aas_think);
  maps\_utility::ignoreeachother("chopper_guys", "friendly_squad");
}

tall_grass_handle_player_opening_fire() {
  level endon("moving_into_tall_grass");
  common_scripts\utility::flag_waitopen("clear_to_move_into_tall_grass");

  for(;;) {
    var_0 = getaiarray("axis");

    if(var_0.size < 2 || common_scripts\utility::flag("went_hot_and_out")) {
      break;
    }

    wait 0.5;
  }

  common_scripts\utility::flag_set("clear_to_move_into_tall_grass");
  common_scripts\utility::flag_set("tall_grass_hot_early_skip");
}

tall_grass_friendly_ignore_state() {
  level endon("field_halfway");

  if(!common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
    common_scripts\utility::array_thread(level.squad, maps\jungle_ghosts_util::generic_ignore_on);
    level common_scripts\utility::waittill_any("grass_went_hot");
  }

  maps\jungle_ghosts_util::dialogue_stop();

  if(!common_scripts\utility::flag("field_halfway")) {
    level.alpha1 thread maps\_utility::smart_dialogue("jungleg_els_takeemout");
    level thread tall_grass_hot_vo_end();
  }

  common_scripts\utility::array_thread(level.squad, maps\jungle_ghosts_util::generic_ignore_off);
  common_scripts\utility::array_call(level.squad, ::setthreatbiasgroup);
  level maps\_utility::delaythread(1, maps\_utility::battlechatter_on);
}

tall_grass_hot_vo_end() {
  level endon("field_halfway");

  for(var_0 = getaiarray("axis"); var_0.size > 0; var_0 = getaiarray("axis")) {
    wait 0.5;
  }

  level.alpha1 thread maps\_utility::smart_dialogue("jungleg_gs1_okwereclear");
}

aas_think() {
  wait 7;
  self notify("stop_kicking_up_dust");
}

aas_guys_spawn_logic() {
  self endon("death");
  self setthreatbiasgroup("chopper_guys");
  maps\_stealth_utility::disable_stealth_for_ai();
  maps\_utility::set_ai_bcvoice("shadowcompany");
  thread maps\_utility::set_battlechatter(0);
  self.grenadeammo = 0;
  level.tall_grass_chopper_group_flag = maps\_stealth_utility::stealth_get_group_spotted_flag();
  thread tall_grass_guys_path_to_trees();
  thread tall_grass_guys_went_hot();

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      break;
    }

    wait 0.1;
  }

  common_scripts\utility::flag_set("grass_went_hot");

  if(!level.clear_to_go_flag_set_once && !common_scripts\utility::flag("moving_into_tall_grass")) {
    common_scripts\utility::flag_clear("clear_to_move_into_tall_grass");
    level.clear_to_go_flag_set_once = 1;
  }
}

tall_grass_guys_went_hot() {
  self endon("death");
  common_scripts\utility::flag_wait(level.tall_grass_chopper_group_flag);
  common_scripts\utility::flag_set("grass_went_hot");
  self notify("_utility::follow_path");
  wait(randomintrange(1, 3));
  maps\_stealth_utility::enable_stealth_for_ai();
  self.goalradius = 250;
  maps\_utility::battlechatter_on();
  maps\_utility::disable_cqbwalk();
  self setthreatbiasgroup();

  for(;;) {
    self.goalradius = 250;
    self setgoalentity(level.player);
    wait 1;
  }
}

tall_grass_guys_path_to_trees() {
  self endon("death");
  self waittill("unload");
  common_scripts\utility::flag_set("tall_grass_heli_unloaded");
  wait 3;
  maps\_stealth_utility::enable_stealth_for_ai();
  maps\_utility::enable_cqbwalk();
  wait 10;
  var_0 = common_scripts\utility::getstructarray("tall_grass_guys_paths_out", "targetname");

  for(var_1 = undefined; !isDefined(var_1) || var_0.size > 0; var_0 = common_scripts\utility::array_remove(var_0, var_2)) {
    var_2 = common_scripts\utility::getclosest(self.origin, var_0);

    if(!isDefined(var_2.used)) {
      var_2.used = 1;
      var_1 = var_2;
      break;
    }
  }

  maps\_utility::follow_path(var_1);
  var_3 = getnodesinradiussorted(self.origin, 1024, 0, 512, "cover");

  foreach(var_5 in var_3) {
    if(var_5.angles[1] < 345 && var_5.angles[1] > 190) {
      if(!isDefined(var_5.jg_occupied)) {
        self.goalradius = 128;
        var_5.jg_occupied = 1;
        self setgoalnode(var_5);
        break;
      }
    }
  }
}

tall_grass_stealth_settings() {
  var_0 = [];
  var_0["prone"] = 70;
  var_0["crouch"] = 70;
  var_0["stand"] = 300;
  var_1 = [];
  var_1["prone"] = 500;
  var_1["crouch"] = 1500;
  var_1["stand"] = 2000;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
  var_2 = [];
  var_2["player_dist"] = 50;
  var_2["sight_dist"] = 50;
  var_2["detect_dist"] = 50;
  var_2["found_dist"] = 50;
  var_2["found_dog_dist"] = 50;
  maps\_stealth_utility::stealth_corpse_ranges_custom(var_2);
}

sky_change() {
  if(common_scripts\utility::flag("skybox_changed")) {
    return;
  }
  if(maps\_utility::game_is_current_gen()) {
    var_0 = getmapsunlight();
    var_1 = (0.804688, 0.878906, 0.996094);
    thread maps\_utility::sun_light_fade(var_0, var_1, 10);
  }

  common_scripts\utility::flag_set("skybox_changed");

  if(isDefined(level.rain_skybox)) {
    level.rain_skybox show();
  }
}

tall_grass_weather() {
  common_scripts\utility::flag_wait("field_entrance");
  thread maps\jungle_ghosts_util::thunder_and_lightning(10, 15);
  wait 3;
  thread maps\jungle_ghosts_util::start_raining();
  thread maps\jungle_ghosts_util::thunder_and_lightning(8, 12);
  level.player setclienttriggeraudiozone("jungle_ghosts_escape_rain", 10);
}

tall_grass_moving_grass_settings() {
  setsaveddvar("r_reactiveMotionActorRadius", 80);
  setsaveddvar("r_reactiveMotionWindDir", (-1, 0, 1));
  maps\jungle_ghosts_util::adjust_moving_grass(2, 1, 0.5);
  common_scripts\utility::flag_wait("field_entrance");
  thread tall_grass_wind_gust_logic();
}

tall_grass_wind_gust_logic() {
  chopper_arrive_wind_gust();
  level endon("field_end");

  for(;;) {
    wait(randomintrange(5, 9));
    tall_grass_do_wind_gust();
  }
}

tall_grass_do_wind_gust() {
  if(common_scripts\utility::flag("adjusting_wind")) {
    return;
  }
  common_scripts\utility::flag_set("adjusting_wind");
  level.player maps\_utility::delaythread(0.5, maps\_utility::play_sound_on_entity, "elm_wind_leafy_jg");
  var_0 = randomfloatrange(2.5, 4.5);
  thread maps\jungle_ghosts_util::blend_wind_setting_internal(var_0, "r_reactiveMotionWindStrength");
  var_1 = randomfloatrange(2.5, 4);
  maps\jungle_ghosts_util::blend_wind_setting_internal(var_1, "r_reactiveMotionWindAmplitudeScale");
  thread maps\jungle_ghosts_util::blend_wind_setting_internal(1, "r_reactiveMotionWindStrength");
  maps\jungle_ghosts_util::blend_wind_setting_internal(0.2, "r_reactiveMotionWindAmplitudeScale");
  common_scripts\utility::flag_clear("adjusting_wind");
}

chopper_arrive_wind_gust() {
  level.player maps\_utility::delaythread(0.5, maps\_utility::play_sound_on_entity, "elm_wind_leafy_jg");
  maps\jungle_ghosts_util::blend_wind_setting_internal(1, "r_reactiveMotionWindFrequencyScale");
  var_0 = randomfloatrange(1.5, 3.5);
  thread maps\jungle_ghosts_util::blend_wind_setting_internal(var_0, "r_reactiveMotionWindStrength");
  var_1 = randomfloatrange(1.5, 2.5);
  maps\jungle_ghosts_util::blend_wind_setting_internal(var_1, "r_reactiveMotionWindAmplitudeScale");
  wait 7;
  thread maps\jungle_ghosts_util::blend_wind_setting_internal(1, "r_reactiveMotionWindStrength");
  maps\jungle_ghosts_util::blend_wind_setting_internal(0.2, "r_reactiveMotionWindAmplitudeScale");
  maps\jungle_ghosts_util::blend_wind_setting_internal(0.17, "r_reactiveMotionWindFrequencyScale");
}

tall_grass_get_enemies_except_prone_and_rpg_guys() {
  var_0 = getaiarray("axis");
  return var_0;
}

tall_grass_friendly_navigation() {
  if(!common_scripts\utility::flag("ambush_open_fire")) {
    thread pre_tall_grass_friendly_movement();
  }

  level thread tall_grass_intro_goes_hot();
  common_scripts\utility::flag_wait("field_entrance");

  if(!common_scripts\utility::flag("_stealth_spotted")) {
    maps\_utility::autosave_by_name("tall_grass_begin");
  }

  common_scripts\utility::flag_wait("moving_into_tall_grass");
  common_scripts\utility::flag_wait("clear_to_move_into_tall_grass");
  var_0 = common_scripts\utility::getstructarray("friendly_start_structs", "targetname");
  wait 0.25;

  foreach(var_2 in level.squad) {
    var_2.start_struct = common_scripts\utility::getclosest(var_2.origin, var_0);
    var_2 thread tall_grass_friendly_logic(var_2.start_struct);
  }

  common_scripts\utility::flag_wait("field_halfway");
  level thread maps\jungle_ghosts_runway::runway_setup();
  common_scripts\utility::array_thread(level.squad, ::tall_grass_friendly_exit_logic);
  common_scripts\utility::flag_wait("field_end");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    common_scripts\utility::flag_set("keep_tall_grass_alive_longer");
  }

  var_4 = getaiarray("axis");

  if(var_4.size != 0 && !common_scripts\utility::flag("keep_tall_grass_alive_longer")) {
    foreach(var_2 in var_4) {
    var_2 maps\jungle_ghosts_util::delete_if_player_cant_see_me();
    }
  } else if(var_4.size != 0 && common_scripts\utility::flag("keep_tall_grass_alive_longer"))
    thread auto_spot_player();
}

auto_spot_player() {
  for(var_0 = getaiarray("axis"); var_0.size != 0; var_0 = getaiarray("axis")) {
    wait 0.25;
  }

  common_scripts\utility::flag_clear("keep_tall_grass_alive_longer");
}

tall_grass_friendly_exit_logic() {
  self[[level.ignore_on_func]]();
  self notify("stop_tall_grass_beahavior");

  if(isDefined(self.old_color)) {
    maps\_utility::set_force_color(self.old_color);
  }

  maps\_utility::enable_ai_color();
  self allowedstances("crouch", "stand", "prone");
  self.moveplaybackrate = 1;
}

tall_grass_friendly_logic(var_0) {
  maps\_utility::disable_ai_color();
  self.goalradius = 32;
  self.script_forcegoal = 1;

  if(!common_scripts\utility::flag("grass_went_hot")) {
    self allowedstances("crouch", "prone");
  }

  var_1 = distance(self.origin, var_0.origin);

  if(common_scripts\utility::flag("ambush_open_fire") || common_scripts\utility::flag("backend_friendlies_go_hot")) {
    if(var_1 < 100 && var_1 > 60) {
      wait 2;
    }
  } else if(self.origin[0] > 5050)
    wait 2;

  self pushplayer(1);
  maps\_utility::follow_path(var_0);
}

get_latest_struct() {
  self endon("death");

  for(;;) {
    if(distancesquared(self.origin, self.goal_struct.origin) <= 22500) {
      if(isDefined(self.goal_struct.target)) {
        self.goal_struct = common_scripts\utility::getstruct(self.goal_struct.target, "targetname");
      }
      else {
        maps\_utility::ent_flag_set("end_of_spline");
      }
    }

    wait 1;
  }
}

delete_me_on_parent_ai_death(var_0) {
  var_0 waittill("death");
  self delete();
}

stream_vo() {
  var_0 = ["jungleg_gs1_lightemup", "jungleg_gs1_goinloud", "jungleg_gs1_openfire", "jungleg_gs1_openfire_2"];
  var_1 = 1000;

  switch (level.start_point) {
    case "stream":
    case "waterfall":
    case "jungle_hill":
    case "jungle_corridor":
    case "parachute":
    case "default":
      common_scripts\utility::flag_wait("waterfall_to_stream");
      level.hesh.anmimname = "diaz";
      level.merrick.anmimname = "baker";
      common_scripts\utility::flag_wait("can_see_chopper");
      maps\jungle_ghosts_util::dialogue_stop();
      thread stream_went_hot_vo();

      if(!common_scripts\utility::flag("smaw_target_detroyed") && !common_scripts\utility::flag("stream_heli_out") && !common_scripts\utility::flag("_stealth_spotted")) {
        if(distance(level.alpha1.origin, level.player.origin) < var_1) {
          level.alpha1 thread maps\_utility::smart_dialogue("jungleg_els_supplydroplookslike");
        }

        wait 2;
      }

      if(!common_scripts\utility::flag("smaw_target_detroyed") && !common_scripts\utility::flag("stream_heli_out") && !common_scripts\utility::flag("_stealth_spotted")) {
        if(distance(level.alpha1.origin, level.player.origin) < var_1) {
          if(!common_scripts\utility::flag("player_about_to_break_stream_stealth")) {
            level.alpha1 thread maps\_utility::smart_dialogue("jungleg_els_waitforthemto");
          }
          else {
            level.alpha1 thread maps\_utility::smart_dialogue("jungleg_hsh_whereareyougoing");
          }
        }

        wait 4;
      }

      if(!common_scripts\utility::flag("smaw_target_detroyed") && !common_scripts\utility::flag("stream_heli_out") && !common_scripts\utility::flag("_stealth_spotted")) {
        if(distance(level.alpha1.origin, level.player.origin) < var_1) {
          if(!common_scripts\utility::flag("player_about_to_break_stream_stealth")) {
            level.alpha1 thread maps\_utility::smart_dialogue("jungleg_els_waitforit");
          }
          else {
            level.merrick thread maps\_utility::smart_dialogue("jungleg_mrk_idontlikethe");
          }
        }

        common_scripts\utility::flag_set("chopper_about_to_leave");
        level thread stream_squad_disengage_stealth_after_chopper_leaves_on_hot();
        wait 4;
      }

      common_scripts\utility::flag_set("time_for_chopper_to_leave");

      if(!common_scripts\utility::flag("smaw_target_detroyed") && !common_scripts\utility::flag("_stealth_spotted")) {
        wait 4;

        if(distance(level.alpha1.origin, level.player.origin) < var_1) {
          level.alpha1 thread maps\_utility::smart_dialogue("jungleg_els_okaylooksliketheyre");
        }
      }

      common_scripts\utility::flag_wait("stream_fight_begin");
      thread stealthed_stream_vo();
      common_scripts\utility::flag_wait("bridge_area_exit");

      if(!common_scripts\utility::flag("ambush_open_fire")) {
        level.player playSound("SP_0_order_move_combat_d");
        level.player common_scripts\utility::delaycall(1, ::playsound, "SP_1_response_ack_yes_d");
        common_scripts\utility::flag_set("squad_to_waterfall_ambush");
        wait 2.1;

        if(!common_scripts\utility::flag("ambush_open_fire")) {
          level.merrick maps\_utility::smart_dialogue("jungleg_mrk_moreofthemcoming");
          wait 0.2;
          level.alpha2 maps\_utility::smart_dialogue("jungleg_gs2_sirthatwaterfalll");
          wait 0.2;
          level.alpha1 maps\_utility::smart_dialogue("jungleg_gs1_righteveryoneunderthat");
        }
      }
    case "stream waterfall":
      common_scripts\utility::flag_set("squad_to_waterfall_ambush");

      if(!common_scripts\utility::flag("ambush_open_fire")) {
        common_scripts\utility::flag_wait("squad_in_ambush_position");
        level.alpha1 maps\_utility::delaythread(2, maps\jungle_ghosts_util::do_nags_til_flag, "player_in_ambush_position", 8, 13, "jungleg_gs1_rookunderthewaterfall", "jungleg_gs1_rookwhataredoing");
        common_scripts\utility::flag_wait("player_in_ambush_position");
        wait 5;
        level.alpha1 maps\_utility::smart_dialogue("jungleg_gs1_iseeem");
        wait 2;

        if(!common_scripts\utility::flag("ambush_open_fire")) {
          level.alpha1 maps\_utility::smart_dialogue("jungleg_els_staystillandlet");
          wait 1;
        }

        if(!common_scripts\utility::flag("ambush_open_fire")) {
          level.alpha1 maps\_utility::smart_dialogue("jungleg_mrk_dontmove");
        }

        common_scripts\utility::flag_wait_any("ambush_open_fire", "waterfall_ambush_over", "waterfall_patrollers_dead");

        if(common_scripts\utility::flag("ambush_open_fire")) {
          level.alpha1 maps\_utility::smart_dialogue(common_scripts\utility::random(var_0));
          common_scripts\utility::flag_wait("waterfall_ambush_over");
          level.alpha1 thread maps\_utility::smart_dialogue("jungleg_gs1_weshouldkeepmovin");
        }

        if(common_scripts\utility::flag("waterfall_ambush_over") && !common_scripts\utility::flag("ambush_open_fire")) {
          level.alpha1 maps\_utility::smart_dialogue("jungleg_els_letsmovebeforethey");
        }
      }

      if(common_scripts\utility::flag("ambush_open_fire")) {
        maps\_utility::activate_trigger_with_targetname("stream2_pos1");
        common_scripts\utility::flag_wait("stream_backend_start");
        wait 6;
        level.alpha1 maps\_utility::smart_dialogue("jungleg_gs2_ambush");
        return;
      }
  }
}

stream_went_hot_vo() {
  common_scripts\utility::flag_wait("stream_fight_begin");

  if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("smaw_target_detroyed")) {
    maps\jungle_ghosts_util::dialogue_stop();
    level.hesh maps\_utility::smart_dialogue("jungleg_diz_soundslikereenforcements");
  }
}

stealthed_stream_vo() {
  level endon("_stealth_spotted");
  level endon("bridge_approach");
  wait 7;

  if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("smaw_target_detroyed")) {
    level.alpha1 maps\_utility::smart_dialogue("jungleg_els_makoyoureadwere");
    wait 0.5;
    level.player maps\_utility::play_sound_on_entity("jungleg_mko_stillmovingupriverstalker");
  }
}

tall_grass_vo() {
  level endon("runway_halfway");
  thread pre_tall_grass_vo_stealth();
  common_scripts\utility::flag_wait("retreat_to_tall_grass");
  maps\_utility::battlechatter_off("allies");
  var_0 = getaiarray("axis");

  if(var_0.size > 0 && common_scripts\utility::flag("ambush_open_fire")) {
    level.alpha2 maps\_utility::smart_dialogue("jungleg_kgn_theyreretreatingintothe");
  }

  common_scripts\utility::flag_wait("field_entrance");

  if(!common_scripts\utility::flag("grass_went_hot") && !common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
    wait 2;
    level.hesh maps\_utility::smart_dialogue("jungleg_hsh_youhearthat");
    wait 0.5;
  }

  if(!common_scripts\utility::flag("grass_went_hot") && !common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
    level.alpha1 maps\_utility::smart_dialogue("jungleg_els_helisoverheadwaitat");
  }

  common_scripts\utility::flag_wait("tall_grass_heli_unloaded");
  wait 1;

  if(!common_scripts\utility::flag("grass_went_hot") && !common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
    level.hesh maps\_utility::smart_dialogue("jungleg_gs2_terrific");
    wait 1;
  }

  if(!common_scripts\utility::flag("grass_went_hot") && !common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
    level.alpha1 thread maps\_utility::smart_dialogue("jungleg_gs1_fanout5meter");
  }

  common_scripts\utility::flag_wait("clear_to_move_into_tall_grass");
  common_scripts\utility::flag_set("moving_into_tall_grass");
  common_scripts\utility::flag_set("clear_to_move_into_tall_grass");

  if(!common_scripts\utility::flag("tall_grass_hot_early_skip")) {
    if(!common_scripts\utility::flag("field_halfway") && !common_scripts\utility::flag("grass_went_hot") && !common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
      wait 1;
      level.alpha1 maps\_utility::smart_dialogue("jungleg_els_staybehindmesingle");
      level thread track_distance_from_friendlies();
    }

    if(!common_scripts\utility::flag("field_halfway") && !common_scripts\utility::flag("grass_went_hot") && !common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
      wait 5;
      level.alpha1 maps\_utility::smart_dialogue("jungleg_gs1_staylow");
    }

    if(!common_scripts\utility::flag("field_halfway") && !common_scripts\utility::flag("grass_went_hot") && !common_scripts\utility::flag("backend_friendlies_go_hot_late")) {
      wait 5;
      level.alpha1 maps\_utility::smart_dialogue("jungleg_gs1_staylowwww");
    }
  }

  common_scripts\utility::flag_wait("field_halfway");
  maps\jungle_ghosts_util::dialogue_stop();

  if(!common_scripts\utility::flag("tall_grass_hot_early_skip")) {
    level.alpha1 maps\_utility::smart_dialogue("jungleg_els_alrightletskeepmoving");
    wait 1;
  }

  level.merrick maps\_utility::smart_dialogue("jungleg_mrk_werealmostatthe");
  wait 1;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_heshcallitin");
  wait 1;
  level.hesh maps\_utility::smart_dialogue("jungleg_hsh_makoactualthisis");
  common_scripts\utility::flag_set("field_dialogue_cue");
  wait 1;
  level.merrick maps\_utility::smart_dialogue("jungleg_mrk_whatsdoingthisshit");
  wait 5;
  level.hesh maps\_utility::smart_dialogue("jungleg_hsh_holy");
  wait 1;
  level.player maps\_utility::play_sound_on_entity("jungleg_mko_actualwegota");
  wait 0.2;
  level.hesh maps\_utility::smart_dialogue("jungleg_els_onourwayto");
  wait 2;
  level.hesh maps\_utility::smart_dialogue("jungleg_els_geteyesonthe");
}

track_distance_from_friendlies() {
  level endon("field_halfway");
  level endon("grass_went_hot");
  wait 3;
  var_0 = 1;

  while(var_0) {
    var_1 = 0;

    for(var_2 = 0; var_2 < level.squad.size; var_2++) {
      var_3 = distance(level.player.origin, level.squad[var_2].origin);

      if(var_3 > 200) {
        var_1++;
      }

      if(var_1 >= 3) {
        var_0 = 0;
      }
    }

    wait 0.25;
  }

  maps\jungle_ghosts_util::dialogue_stop();
  level.alpha1 maps\_utility::smart_dialogue("jungleg_pri_keepittightpeople");
}

pre_tall_grass_vo_stealth() {
  level endon("backend_friendlies_go_hot");
  level endon("field_halfway");

  if(common_scripts\utility::flag("ambush_open_fire")) {
    return;
  }
  common_scripts\utility::flag_wait("stream_backend_moveup_stealth");
  thread maps\_utility::battlechatter_off();
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_keepitupwere");
  maps\jungle_ghosts_util::waittill_y_passed(7260);
  wait 1;
  level.merrick maps\_utility::smart_dialogue("jungleg_mrk_morepatrols");
  common_scripts\utility::flag_wait("start_pre_grass_patroller");
  level.hesh maps\_utility::smart_dialogue("jungleg_hsh_rightsidelooksclear");
  wait 0.5;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_alrightflankrightstay");
  wait 0.25;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_onmymark");
  common_scripts\utility::flag_wait("pre_tall_grass_friendly_moveup_1");
  wait 0.25;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_okaygo");
  common_scripts\utility::flag_wait("pre_tall_grass_friendly_moveup_2");
  wait 0.25;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_now");
  common_scripts\utility::flag_wait("pre_tall_grass_friendly_moveup_3");
  wait 0.25;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_move");
}