/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_gameplay_civ_ambush.gsc
***********************************************************/

civ_ambush_init() {
  scripts\engine\utility::flag_init("flag_stairwell_marine_initial_pathing_done");
  scripts\engine\utility::flag_init("flag_stairwell_exit");
  scripts\engine\utility::flag_init("flag_stairwell_progress_vo");
  scripts\engine\utility::flag_init("flag_civ_ambush_start");
  scripts\engine\utility::flag_init("flag_allies_reach_stair_top");
  scripts\engine\utility::flag_init("flag_alex_vo_corridor");
  scripts\engine\utility::flag_init("flag_civ_ambush_griggs_react_vo");
  scripts\engine\utility::flag_init("flag_civ_ambush_wounded_aq_walkby");
  scripts\engine\utility::flag_init("flag_civ_ambush_ambusher_attack_check");
  scripts\engine\utility::flag_init("flag_civ_ambush_ads_trigger");
  scripts\engine\utility::flag_init("flag_civ_ambush_whizby_trigger");
  scripts\engine\utility::flag_init("flag_civ_ambush_player_threat");
  scripts\engine\utility::flag_init("flag_civ_ambush_ambusher_attack_trigger");
  scripts\engine\utility::flag_init("flag_civ_ambush_ambusher_grabbing_gun");
  scripts\engine\utility::flag_init("flag_civ_ambush_ambusher_allow_kill");
  scripts\engine\utility::flag_init("flag_civ_ambush_end");
  scripts\engine\utility::flag_init("civ_ambush_exit_door_setup");
  scripts\engine\utility::flag_init("flag_containment_civambush");
  scripts\engine\utility::flag_init("flag_stairwell_wait_time_elapsed");
  scripts\engine\utility::flag_init("flag_ambusher_killed_clear_vo");
  scripts\engine\utility::flag_init("flag_griggs_first_bed_civ");
  scripts\engine\utility::flag_init("flag_griggs_enter_civ_ambush_gate");
  scripts\engine\utility::flag_init("flag_griggs_corner_gate");
  scripts\engine\utility::flag_init("flag_civ_ambush_vo_zombie");
  scripts\engine\utility::flag_init("flag_civ_ambush_vo_expire");
  scripts\sp\maps\marines\marines_civilians.gsc::civilians_init();
  scripts\sp\drone_civilian::init();
  precachemodel("weapon_vm_ar_akilo47_brprop");
  precachemodel("head_sc_f_toyouri_civ");
}

civ_ambush_main() {
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("flag_civ_ambush_wounded_aq_walkby", undefined, "marines_mghall_geo_tr");
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  level.manpile_monitor.maximum = 8;
  level.manpile_monitor.maximum_in_fov = 4;
  level.manpile_monitor.ideal = 5;
  level.manpile_monitor.safe_delete_distance = 1500;
  level.manpile_monitor.maximum_weapons = 5;
  level.manpile_monitor.wait_time = 1.0;
  thread bed_civs_init();
  thread civ_ambush_exit_door_setup();
  thread civ_ambush_stairwell_advance();
  thread civ_ambusher_init();
  thread containment_civambush();
  thread containment_civambush_teleport();
  thread groundfloor_aq_alive_monitor();
  thread scripts\sp\maps\marines\marines_utility.gsc::spawn_corpses("civ_ambush_dead_doctor_spawner", "flag_upperfloor_murderhole_flank_left");
  thread civ_ambush_stair_blocking_marine_handler();
  thread civambush_griggs_nag_dialogue();
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_civ_ambush_alex_dialogue();
  level.griggs_vo_civambush_speaking = 0;
  scripts\engine\sp\utility::battlechatter_off("axis");
  scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\utility::flag_wait("flag_civ_ambush_start");
  level.griggs pushplayer(0);
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  thread civ_ambush_marine_color_update();
  thread clean_up_first_floor_corpses();
  thread clean_up_first_floor_scriptables();
  level.player scripts\sp\player::player_movement_state("creep");
  level.griggs thread civ_ambush_movement_handler();
  scripts\engine\utility::flag_wait("flag_civ_ambush_griggs_react_vo");
  scripts\engine\sp\utility::activate_trigger_with_targetname("civ_ambush_entry_color_trigger");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_civambush_marine_intro_dialogue();
  scripts\engine\utility::flag_wait("flag_civ_ambush_wounded_aq_walkby");
  thread scripts\sp\maps\marines\marines_utility.gsc::spawn_corpses("mg_hall_dead_marine_spawner", "flag_wolf_snakecam_starting");
  scripts\sp\maps\marines\marines_utility.gsc::autosave();
  scripts\engine\utility::flag_wait("flag_civ_ambush_ambusher_attack_trigger");
  var_0 = level.allymarines["all"];

  foreach(var_2 in var_0) {
    if(isalive(var_2) && isDefined(var_2.asmname))
      var_2 scripts\common\utility::demeanor_override("combat");
  }

  scripts\engine\utility::flag_wait("flag_civ_ambush_end");
  civ_ambush_marine_color_reset();
  level.player scripts\sp\player::player_movement_state("default");
}

civ_ambush_stair_blocking_marine_handler() {
  var_0 = getEnt("second_floor_marine_teleport_check", "targetname");
  var_1 = getEnt("civ_ambush_blocker_clip", "targetname");
  var_2 = getspawner("civ_ambush_stair_blocker_spawner", "targetname");
  var_1 movez(9999, 0.5, 0.25, 0.25);
  scripts\engine\utility::flag_wait("flag_civ_ambush_start");

  foreach(var_4 in getaiarray("allies"))
  var_4 thread scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::marine_cowabunga_advance_to_goal();

  var_6 = var_2 scripts\engine\sp\utility::spawn_ai();
  var_6 thread civ_ambush_stair_blocker_ai_handler();
  var_6 thread scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_picker();
  var_1 movez(-9999, 0.5, 0.25, 0.25);
}

civ_ambush_stair_blocker_ai_handler() {
  if(isDefined(self)) {
    self.friend_kill_points = -100000;
    self.grenadeawareness = 0;
    self.script_pushable = 0;
    self.dontavoidplayer = 1;
    self.dontchangepushplayer = 0;
    self pushplayer(1);
  }

  scripts\engine\utility::flag_wait("flag_containment_civambush");

  if(isDefined(self))
    self delete();
}

civ_ambush_movement_handler() {
  level.griggs.script_pushable = 0;
  scripts\sp\utility::set_stayahead_values(1, 110, -50, 0.1);
  scripts\sp\utility::set_stayahead_values(2, 100, -150, 0.1);
  scripts\sp\utility::set_stayahead_values(3, 80, -200, 0.1);
  scripts\sp\utility::set_stayahead_values(4, 60, -250, 0.15);
  scripts\sp\utility::enable_stayahead(level.player);
  scripts\engine\sp\utility::disable_ai_color();
  thread go_to_targetname("civ_ambush_route_1");
  scripts\engine\utility::flag_wait("flag_griggs_corner_gate");
  self waittill("reached_path_end");

  if(!scripts\engine\utility::flag("flag_civ_ambush_end")) {
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_civambush_alex_take_point();
    scripts\sp\utility::disable_stayahead();
    scripts\engine\sp\utility::enable_ai_color();
    wait 1;

    if(isDefined(self) && isalive(self))
      thread scripts\asm\gesture::ai_request_gesture("advance");
  } else {
    scripts\sp\utility::disable_stayahead();
    scripts\engine\sp\utility::enable_ai_color();
  }
}

go_to_targetname(var_0) {
  var_1 = getnode(var_0, "targetname");

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  scripts\sp\spawner::go_to_node(var_1);
}

groundfloor_aq_alive_monitor() {
  var_0 = [];
  var_0 = scripts\engine\sp\utility::get_living_ai_array("ai_aq_groundfloor", "script_noteworthy");
  waitframe();

  while(var_0.size > 0) {
    var_0 = scripts\engine\sp\utility::get_living_ai_array("ai_aq_groundfloor", "script_noteworthy");
    waitframe();
  }
}

civ_ambush_start() {
  scripts\engine\sp\utility::set_start_location("start_civ_ambush", [level.player]);
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_civ_ambush_griggs", undefined, undefined, undefined, "Demon 1-2");
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_civ_ambush");
  var_0 = getspawnerarray("ally_marine_civ_ambush");
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_checkpoint_forcespawn_allies(var_0);
  thread scripts\sp\maps\marines\marines_utility.gsc::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread scripts\sp\maps\marines\marines_utility.gsc::spawn_corpses("stairwell_dead_body", "flag_civ_ambush_end");
  thread scripts\sp\maps\marines\marines_utility.gsc::stairwell_corpses_cleanup();
  scripts\sp\maps\marines\marines_lighting.gsc::sun_adjustments_hospital_force("lighting_hospital", 2);
}

civ_ambush_catchup() {
  thread civ_ambush_exit_door_setup();
  thread clean_up_first_floor_scriptables();
  thread containment_civambush();
  scripts\engine\utility::flag_set("flag_containment_civambush");
}

civ_ambush_exit_door_setup() {
  var_0 = scripts\sp\door::get_interactive_door("civ_ambush_exit_door_left");
  var_1 = scripts\sp\door::get_interactive_door("civ_ambush_exit_door_right");
  var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  var_1 scripts\game\sp\door::remove_door_snake_cam_ability();
  var_0.open_left = 1;
  var_0.hinge_side = "open_left";
  var_1.open_left = 0;
  var_1.hinge_side = "open_right";
  var_0.script_max_left_angle = 120;
  var_0.script_max_right_angle = 65;
  var_0 scripts\sp\door::init_max_yaws();
  var_1.script_max_left_angle = 120;
  var_1.script_max_right_angle = 120;
  var_1 scripts\sp\door::init_max_yaws();
  var_0.script_spawn_open_yaw = 65;
  var_0 notify("first_interact");
  var_0.open_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
  var_1.script_spawn_open_yaw = -100;
  var_1 notify("first_interact");
  var_1.open_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
  var_0.bashed_full = 1;
  var_1.bashed_full = 1;
  var_0 thread push_manager();
  var_0 thread bash_manager();
  var_1 thread push_manager();
  scripts\engine\utility::flag_set("civ_ambush_exit_door_setup");
}

push_manager() {
  self endon("stop_push_open");
  self endon("bashed_full");
  self endon("entitydeleted");

  for(;;) {
    if(scripts\sp\door::interact_door_ispushentclose())
      push_door_override();
    else if(istrue(self.isplayingpushsound)) {
      self.isplayingpushsound = 0;
      self notify("stop_door_creak");
    }

    waitframe();
  }
}

bash_manager() {
  self endon("stop_push_open");
  self endon("bashed_full");
  self endon("entitydeleted");

  for(;;) {
    if(scripts\sp\door::bash_door_isplayerclose() && scripts\sp\door_internal::should_bash_open()) {
      scripts\game\sp\door::remove_door_snake_cam_ability();
      scripts\sp\door::remove_open_ability();
      thread scripts\sp\door::door_open_completely(level.player, 0.5);
      return;
    }

    waitframe();
  }
}

push_door_override() {
  if(istrue(self.bash_opening)) {
    return;
  }
  var_0 = 36;
  var_1 = 0;
  var_2 = 25;
  var_3 = scripts\sp\door_internal::interact_door_get_endpoint();
  var_4 = distance(level.player.origin, var_3);
  var_5 = scripts\engine\math::normalize_value(var_1, var_0, var_4);
  var_6 = var_2 * (1 - var_5);

  if(abs(var_6) < 0.001) {
    return;
  }
  self.prompt_moved = 1;
  self.open_left = scripts\sp\door::should_open_left(self.pivot_ent.angles);
  var_7 = scripts\sp\door::get_door_angles()[1];
  var_8 = scripts\engine\utility::ter_op(self.open_left == 1, 1, -1);
  var_9 = var_7 + var_6 * var_8;

  if(self.open_left) {
    if(self.hinge_side == "open_left") {
      var_10 = abs(scripts\sp\door::angle_diff(var_9, self.true_start_angles[1]));

      if(var_10 > self.max_yaw_left) {
        self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
        self.open_completely = 1;
        thread scripts\sp\door::updatenavobstacle();
        self notify("stop_push_open");
        return;
      }
    } else if(var_9 > self.true_start_angles[1]) {
      self.debug_activity = "Pushed back closed, right hinge";
      thread scripts\sp\door::reset_door();
      self notify("stop_push_open");
      return;
    }
  } else if(self.hinge_side == "open_right") {
    var_10 = abs(scripts\sp\door::angle_diff(var_9, self.true_start_angles[1]));

    if(var_10 > self.max_yaw_right) {
      self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
      self.open_completely = 1;
      thread scripts\sp\door::updatenavobstacle();
      self notify("stop_push_open");
      return;
    }
  } else if(var_9 < self.true_start_angles[1]) {
    self.debug_activity = "Pushed back closed, left hinge";
    thread scripts\sp\door::reset_door();
    self notify("stop_push_open");
    return;
  }

  if(self.open_left) {
    if(self.hinge_side == "open_left")
      scripts\sp\door_internal::set_pivot_point(1);
    else
      scripts\sp\door_internal::set_pivot_point(0);
  } else if(self.hinge_side == "open_right")
    scripts\sp\door_internal::set_pivot_point(0);
  else
    scripts\sp\door_internal::set_pivot_point(1);

  if(var_6 > 0.4) {
    thread scripts\sp\door_internal::try_push_sound();

    if(!scripts\engine\utility::flag("door_second_interact"))
      scripts\engine\utility::flag_set("door_second_interact");
  } else if(istrue(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
    self notify("stop_door_creak");
  }

  self.pivot_ent.angles = (self.pivot_ent.angles[0], var_9, self.pivot_ent.angles[2]);
  self.forward = anglesToForward(self.pivot_ent.angles);

  if(scripts\sp\door_internal::door_is_half_open()) {
    if(!self.was_opened_halfway)
      thread scripts\sp\door_internal::suspicious_door_stealth_check(1);

    self.was_opened_halfway = 1;
  }

  if(abs(angleclamp180(self.pivot_ent.angles[1] - self.nav_lastupdateangle)) > 20 && gettime() - self.nav_lastupdatetime > 1500)
    thread scripts\sp\door::updatenavobstacle(1);
}

civ_ambush_stairwell_advance() {
  var_0 = scripts\engine\utility::getStruct("stairwell_travel_path_left_a", "targetname");
  var_1 = scripts\engine\utility::getStruct("stairwell_travel_path_left_b", "targetname");
  var_2 = scripts\engine\utility::getStruct("stairwell_travel_path_left_c", "targetname");
  var_3 = scripts\engine\utility::getStruct("stairwell_travel_path_right_a", "targetname");
  var_4 = scripts\engine\utility::getStruct("stairwell_travel_path_right_b", "targetname");
  var_5 = getnode("stairwell_travel_path_right_b_arrival_node", "targetname");
  var_6 = scripts\engine\utility::getStruct("stairwell_travel_path_left_c", "targetname");
  var_7 = [];
  level.stairwell_available_paths = [];
  var_8 = [];
  var_9 = [];
  level.stairwell_available_paths_index = 0;
  var_10 = [];
  var_10 = scripts\engine\sp\utility::get_living_ai_array("aq_groundfloor_stairwell_spawners", "targetname");
  waitframe();

  if(var_10.size > 0) {
    var_11 = getaiarray("allies");

    foreach(var_13 in var_11) {
      if(isDefined(var_13) && isalive(var_13))
        var_13 scripts\engine\sp\utility::set_baseaccuracy(1);
    }
  }

  thread scripts\engine\utility::delaythread(5, scripts\engine\utility::flag_set, "flag_stairwell_wait_time_elapsed");

  while(var_10.size > 0 && !scripts\engine\utility::flag("flag_stairwell_wait_time_elapsed")) {
    var_10 = scripts\engine\sp\utility::get_living_ai_array("aq_groundfloor_stairwell_spawners", "targetname");
    waitframe();
  }

  thread scripts\sp\maps\marines\marines_vo.gsc::vo_civambush_griggs_stairwell_advance_dialogue();
  var_11 = getaiarray("allies");

  foreach(var_13 in var_11) {
    if(isDefined(var_13) && isalive(var_13))
      var_13 scripts\engine\sp\utility::set_baseaccuracy(0.5);
  }

  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var_4);
  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var_0);
  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var_3);
  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var_1);
  wait 1.0;
  var_7 = getaiarray("allies");

  foreach(var_18 in var_7) {
    if(isalive(var_18) && isDefined(var_18.asmname))
      var_18 scripts\common\utility::demeanor_override("cqb");
  }

  waitframe();

  if(var_7.size < 4)
    thread marine_stairwell_respawn_monitor(var_7);

  var_20 = sortbydistance(var_7, var_6.origin);
  var_21 = 0;

  foreach(var_18 in var_20) {
    if(isDefined(var_18) && isalive(var_18)) {
      if(level.stairwell_available_paths_index <= level.stairwell_available_paths.size) {
        if(var_21 == 4) {
          wait 1;

          if(isDefined(var_18) && isalive(var_18)) {
            if(var_18 == level.griggs)
              var_18 thread scripts\sp\maps\marines\marines_utility.gsc::marine_path_util(var_2, undefined, undefined, undefined, undefined, 0);
            else
              var_18 thread scripts\sp\maps\marines\marines_utility.gsc::marine_path_util(var_2, undefined, undefined, undefined, undefined, 1);

            var_18 thread stairwell_advance_ignore_player_enable();
            var_21++;
          }
        } else {
          if(var_18 == level.griggs)
            var_18 thread scripts\sp\maps\marines\marines_utility.gsc::marine_path_util(level.stairwell_available_paths[level.stairwell_available_paths_index], undefined, undefined, undefined, undefined, 0);
          else
            var_18 thread scripts\sp\maps\marines\marines_utility.gsc::marine_path_util(level.stairwell_available_paths[level.stairwell_available_paths_index], undefined, undefined, undefined, undefined, 1);

          var_18.script_index = level.stairwell_available_paths_index;
          level.stairwell_available_paths_index++;
          var_21++;
          var_18 thread stairwell_advance_ignore_player_enable();
        }
      }
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("flag_stairwell_marine_initial_pathing_done");
}

stairwell_advance_ignore_player_enable() {
  self.dontavoidplayer = 1;
  self.disablebulletwhizbyreaction = 1;
  self.script_pushable = 0;
  self enableavoidance(0);
  self.doavoidanceblocking = 0;
  self.dontchangepushplayer = undefined;
  self pushplayer(1);
}

stairwell_advance_ignore_player_clear() {
  self.dontavoidplayer = 0;
  self.disablebulletwhizbyreaction = 0;
  self.script_pushable = 1;
  self enableavoidance(1);
  self.doavoidanceblocking = 1;
  self.dontchangepushplayer = 1;
  self pushplayer(0);
}

civ_ambush_marine_color_update() {
  var_0 = level.allymarines["all"];
  var_0 = scripts\engine\utility::array_remove(var_0, level.griggs);
  level.griggs thread stairwell_advance_ignore_player_clear();
  waitframe();
  var_1 = scripts\engine\utility::getStruct("civ_ambush_ai_advance_ref", "targetname");
  var_0 = sortbydistance(var_0, var_1.origin);
  var_0 = scripts\engine\utility::array_remove(var_0, level.griggs);
  level.griggs thread griggs_stairwell_advance_demeanor();
  level.griggs thread scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::marine_cowabunga_advance_to_goal();
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_4 thread switch_color_at_goal_thread(var_4.script_forcecolor, "b");
    var_2++;
  }

  level.civ_ambush_marine_color_swap_waiting = var_2;

  while(level.civ_ambush_marine_color_swap_waiting)
    waitframe();

  level.griggs scripts\engine\sp\utility::disable_ai_color();
  scripts\sp\spawner::killspawner(95);
  scripts\engine\utility::flag_wait("flag_civ_ambush_start");
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_civ_ambush");
}

griggs_stairwell_advance_demeanor() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("civ_ambush_ai_advance_ref", "targetname");

  while(distancesquared(self.origin, var_0.origin) > 10000) {
    if(isDefined(self.asmname))
      scripts\common\utility::demeanor_override("combat");

    waitframe();
  }

  while(distancesquared(self.origin, var_0.origin) <= 10000) {
    if(isDefined(self.asmname))
      scripts\common\utility::demeanor_override("combat");

    waitframe();
  }

  if(isDefined(self.asmname))
    scripts\common\utility::demeanor_override("cqb");
}

switch_color_at_goal_thread(var_0, var_1) {
  switch_color_at_goal(var_0, var_1);
  level.civ_ambush_marine_color_swap_waiting--;
}

switch_color_at_goal(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self waittill("goal");
  scripts\engine\sp\utility::disable_ai_color();
  self setgoalpos(self.origin);
  thread stairwell_advance_ignore_player_clear();
  scripts\common\ai::set_gunpose("ready", 1);
  scripts\engine\utility::flag_wait("flag_griggs_enter_civ_ambush_gate");
  thread scripts\sp\maps\marines\marines_utility.gsc::switch_marine_color(var_0, var_1);
}

civ_ambush_marine_color_reset() {
  var_0 = level.allymarines["all"];
  var_0 = scripts\engine\utility::array_remove(var_0, level.griggs);
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3 scripts\common\ai::set_gunpose("ready", 1);

      if(isDefined(var_3.poiauto))
        var_3 scripts\common\ai::poi_enable(0);

      if(var_1 == 0) {
        var_4 = var_3.script_forcecolor;
        var_3 scripts\sp\maps\marines\marines_utility.gsc::switch_marine_color(var_4, "g");
        var_1++;
        continue;
      }

      if(var_1 == 1) {
        var_4 = var_3.script_forcecolor;
        var_3 scripts\sp\maps\marines\marines_utility.gsc::switch_marine_color(var_4, "g");
        var_1++;
        continue;
      }

      if(var_1 == 2) {
        var_4 = var_3.script_forcecolor;
        var_3 scripts\sp\maps\marines\marines_utility.gsc::switch_marine_color(var_4, "g");
        var_1++;
        continue;
      }

      if(var_1 > 2) {
        var_4 = var_3.script_forcecolor;
        var_3 scripts\sp\maps\marines\marines_utility.gsc::switch_marine_color(var_4, "g");
        var_1++;
      }
    }
  }
}

marine_stairwell_respawn_monitor(var_0) {
  scripts\engine\utility::flag_wait("flag_stairwell_marine_initial_pathing_done");

  while(level.stairwell_available_paths_index <= level.stairwell_available_paths.size) {
    var_0 = level.allymarines["all"];
    waitframe();
    var_0 = scripts\engine\utility::array_remove(var_0, level.griggs);

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && isalive(var_2)) {
        if(!isDefined(var_2.script_index)) {
          if(level.stairwell_available_paths_index <= level.stairwell_available_paths.size) {
            var_2 thread scripts\sp\maps\marines\marines_utility.gsc::marine_path_util(level.stairwell_available_paths[level.stairwell_available_paths_index], undefined, undefined, undefined, undefined, 1);
            var_2.script_index = level.stairwell_available_paths_index;
            level.stairwell_available_paths_index++;
          }
        }
      }
    }

    wait 1;
  }
}

clean_up_first_floor_corpses() {
  scripts\engine\sp\utility::trigger_wait_targetname("hospital_first_floor_delete");
  var_0 = getcorpsearray();
  var_1 = getweaponarray();
  var_2 = getEnt("hospital_first_floor_catcher1", "targetname");
  var_3 = getEnt("hospital_first_floor_catcher2", "targetname");
  var_4 = getEnt("hospital_first_floor_catcher3", "targetname");

  foreach(var_6 in var_0) {
    if(var_6 istouching(var_2) || var_6 istouching(var_3) || var_6 istouching(var_4))
      var_6 delete();
  }

  foreach(var_9 in var_1) {
    if(var_9 istouching(var_2) || var_9 istouching(var_3) || var_9 istouching(var_4))
      var_9 delete();
  }
}

clean_up_first_floor_scriptables() {
  scripts\engine\sp\utility::trigger_wait_targetname("hospital_first_floor_delete");
  var_0 = getscriptablearray("deletable_hospital_first_floor", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.model == "" || !isDefined(var_2.model)) {
      continue;
    }
    var_2 hideallparts();
  }
}

civ_trap_hint_clear() {
  return istrue(level.civ_trap_hint_started);
}

bed_civs_init() {
  level.flinch_civs = [];
  var_0 = getspawner("civtrap_civ_bed_1_spawner", "targetname");
  var_1 = getspawner("civtrap_civ_bed_2_spawner", "targetname");
  var_2 = getspawner("civtrap_civ_bed_3_spawner", "targetname");
  var_3 = getspawner("civtrap_civ_bed_4_spawner", "targetname");
  var_4 = getspawner("civtrap_civ_bed_5_spawner", "targetname");
  var_5 = getspawner("civtrap_civ_bed_6_spawner", "targetname");
  var_6 = getspawner("civtrap_civ_bed_7_spawner", "targetname");
  var_7 = getspawner("civtrap_civ_bed_8_spawner", "targetname");
  var_8 = getspawner("civtrap_civ_bed_9_spawner", "targetname");
  var_9 = getspawner("civtrap_civ_bed_10_spawner", "targetname");
  var_10 = getspawner("civtrap_civ_bed_11_spawner", "targetname");
  var_11 = getspawner("civtrap_civ_bed_12_spawner", "targetname");
  var_12 = scripts\engine\utility::getStruct("civtrap_civ_bed_1_struct", "targetname");
  var_13 = scripts\engine\utility::getStruct("civtrap_civ_bed_2_struct", "targetname");
  var_14 = scripts\engine\utility::getStruct("civtrap_civ_bed_3_struct", "targetname");
  var_15 = scripts\engine\utility::getStruct("civtrap_civ_bed_4_struct", "targetname");
  var_16 = scripts\engine\utility::getStruct("civtrap_civ_bed_5_struct", "targetname");
  var_17 = scripts\engine\utility::getStruct("civtrap_civ_bed_6_struct", "targetname");
  var_18 = scripts\engine\utility::getStruct("civtrap_civ_bed_7_struct", "targetname");
  var_19 = scripts\engine\utility::getStruct("civtrap_civ_bed_8_struct", "targetname");
  var_20 = scripts\engine\utility::getStruct("civtrap_civ_bed_9_struct", "targetname");
  var_21 = scripts\engine\utility::getStruct("civtrap_civ_bed_10_struct", "targetname");
  var_22 = scripts\engine\utility::getStruct("civtrap_civ_bed_11_struct", "targetname");
  var_23 = scripts\engine\utility::getStruct("civtrap_civ_bed_12_struct", "targetname");
  var_0 scripts\engine\sp\utility::add_spawn_function(::bed_civ_handsup_trigger, 1);
  var_1 scripts\engine\sp\utility::add_spawn_function(::bed_civ_handsup_trigger, 2);
  var_5 scripts\engine\sp\utility::add_spawn_function(::bed_civ_handsup_trigger, 6);
  var_4 scripts\engine\sp\utility::add_spawn_function(::bed_civ_handsup_trigger, 5);
  var_7 scripts\engine\sp\utility::add_spawn_function(::bed_civ_handsup_trigger, 8);
  var_3 scripts\engine\sp\utility::add_spawn_function(::vo_civ_ambush_wounded_aq_init);
  thread bed_civ_init(var_0, var_12, 0, 0, 1, 1, "body_civ_syrkistan_male_3_1", "head_sc_m_kargorgis_civ");
  thread bed_civ_init(var_1, var_13, 0, 1, 1, 0, "body_civ_syrkistan_female_10_1", "head_sc_f_toyouri_civ");
  thread bed_civ_init(var_2, var_14, 0, 0, 1, 1);
  thread bed_civ_init(var_3, var_15, 0, 0, 1, 1);
  thread bed_civ_init(var_4, var_16, 0, 0, 1, 0);
  thread bed_civ_init(var_5, var_17, 0, 0, 1, 1);
  thread bed_civ_init(var_6, var_18, 1, 0, 1, 1);
  thread bed_civ_init(var_7, var_19, 0, 1, 1, 1);
  thread bed_civ_init(var_8, var_20, 0, 0, 1, 1);
  thread bed_civ_init(var_9, var_21, 0, 1, 1, 1);
  thread bed_civ_init(var_10, var_22, 0, 0, 1, 1);
  thread bed_civ_init(var_11, var_23, 0, 0, 1, 1);
}

bed_civ_handsup_trigger(var_0) {
  self endon("entitydeleted");
  wait 1;
  var_1 = getnode("civ_" + var_0 + "_handsup_node", "script_noteworthy");
  var_2 = undefined;

  while(!isDefined(var_2)) {
    foreach(var_4 in getaiarray("allies")) {
      if(isDefined(var_4.node) && var_4.node == var_1)
        var_2 = var_4;
    }

    waitframe();
  }

  while(isDefined(var_2) && distance2dsquared(self.origin, var_2.origin) > 40000)
    waitframe();

  if(isDefined(var_2) && !scripts\engine\utility::flag("flag_civ_ambush_ambusher_grabbing_gun")) {
    var_6 = scripts\engine\utility::getStruct("civ_" + var_0 + "_handsup_struct", "targetname");
    var_2 scripts\common\ai::poi_enable(1, var_6);

    if(self.responsive)
      self notify("handsup");

    self.ignoreme = 0;
    self.team = "axis";
    var_2.favoriteenemy = self;
    var_2 scripts\common\ai::set_gunpose("ads");
    var_2 scripts\sp\maps\marines\marines_vo.gsc::vo_civ_ambush_friendly_hands_up_dialogue();
    wait 2;
    var_2 scripts\common\ai::poi_enable(0);
    var_2 scripts\common\ai::set_gunpose("ready", 1);
    var_2 scripts\asm\shared\utility::toggle_poiauto(1, 10, 30, 5, 10);
    self notify("handsup_complete");
  }
}

vo_civ_ambush_wounded_aq_init() {
  level.vo_civ_ambush_wounded_aq = self;
}

#using_animtree("generic_human");

bed_civ_init(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.civ_ambush_poi_structs))
    level.civ_ambush_poi_structs = [];

  level.civ_ambush_poi_structs = scripts\engine\utility::array_add(level.civ_ambush_poi_structs, var_1);
  var_8 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_8.dead = var_2;
  var_8.responsive = var_3;
  var_8.dialogue = var_4;
  var_8.sex = scripts\engine\utility::ter_op(var_5, "male", "female");
  var_8.team = "neutral";
  var_8.ignoreme = 1;
  var_8.allowdeath = 1;
  var_8.noragdoll = 1;
  var_8.dontmelee = 1;
  var_8 scripts\sp\utility::context_melee_allow(0);

  if(getdvarint("scr_use_procedural_bones"))
    var_8 setanim(%proc_node, 1.0, 0.0);

  if(isDefined(var_6) && isDefined(var_7))
    var_8 scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::setcharmodels(var_6, var_7, undefined);

  if(istrue(var_8.script_fakeactor))
    var_8 scripts\sp\fakeactor::take_control();

  waitframe();
  level thread scripts\sp\friendlyfire::friendly_fire_think(var_8);
  var_8.struct = var_1;
  var_8.health = 99999;
  var_8.noragdoll = 1;

  if(istrue(var_8.script_fakeactor)) {
    var_8.origin = var_1.origin;
    var_8.angles = var_1.angles;
  } else
    var_8 teleport(var_1.origin, var_1.angles);

  var_8 thread bed_civ_ads_monitor();

  if(var_2) {
    var_8.animname = "bed_civ_8";
    var_8.friend_kill_points = 0;
    var_8.skip_friendly_fire_check = 1;
    var_8 thread bed_civ_cleanup_monitor();
    var_8 thread scripts\common\ai::magic_bullet_shield();
    var_8.struct thread scripts\common\anim::anim_loop_solo(var_8, "bed_laying_idle", "end_laying_idle");
  } else {
    var_8 scripts\engine\utility::ent_flag_init("play_dead");
    var_8.index = var_1.script_index;
    var_8 assign_bed_civ_index(var_1 get_script_index());
    var_8 thread bed_civ_death_monitor();
    var_8 thread bed_civ_cleanup_monitor();
    var_8 thread bed_civ_state_laying();
    var_8 thread bed_civ_flinch_monitor();

    if(isDefined(level.flinch_civs))
      level.flinch_civs = scripts\engine\utility::array_add(level.flinch_civs, var_8);
  }
}

get_script_index() {
  if(isDefined(self.script_index) && self.script_index >= 1 && self.script_index <= 7)
    return self.script_index;
  else
    return undefined;
}

assign_bed_civ_index(var_0) {
  if(isDefined(var_0)) {
    if(var_0 >= 1 && var_0 <= 7)
      self.animname = "bed_civ_" + var_0;
    else {}
  } else if(self.index >= 1 && self.index <= 7)
    self.animname = "bed_civ_" + self.index;
  else
    assign_random_bed_civ_index();
}

assign_random_bed_civ_index() {
  self.animname = "bed_civ_" + (randomint(7) + 1);
}

bed_civ_state_laying() {
  self endon("damage");
  self endon("entitydeleted");
  self.struct thread scripts\common\anim::anim_loop_solo(self, "bed_laying_idle", "end_laying_idle");

  if(self.index < 4 && !isDefined(self.handsup_complete))
    thread bed_civ_state_laying_responsive();
  else
    thread bed_civ_state_laying_unresponsive();
}

bed_civ_state_laying_responsive() {
  self endon("damage");
  self endon("entitydeleted");
  var_0 = scripts\engine\utility::waittill_any_return("handsup", "flinch");
  self.struct notify("end_laying_idle");

  switch (var_0) {
    case "handsup":
      self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup");
      thread bed_civ_state_handsup();
      break;
    case "flinch":
      thread bed_civ_state_laying_flinch();
      break;
    default:
  }
}

bed_civ_state_laying_unresponsive() {
  self endon("damage");
  self endon("entitydeleted");
  self waittill("flinch");
  self.struct notify("end_laying_idle");
  thread bed_civ_state_laying_flinch();
}

bed_civ_flinch_monitor() {
  self endon("damage");
  self endon("entitydeleted");

  if(isDefined(self.struct.target)) {
    for(;;) {
      var_0 = getEnt(self.struct.target, "targetname");
      var_0 waittill("damage");
      self notify("flinch");
    }
  }
}

bed_civ_state_laying_flinch() {
  self endon("damage");
  self endon("entitydeleted");

  if(self.index < 4)
    self.struct scripts\common\anim::anim_single_solo(self, "bed_laying_flinch");
  else if(scripts\engine\utility::cointoss())
    self.struct scripts\common\anim::anim_single_solo(self, "bed_laying_flinch_a");
  else
    self.struct scripts\common\anim::anim_single_solo(self, "bed_laying_flinch_b");

  thread bed_civ_state_laying();
}

bed_civ_ads_monitor() {
  self endon("damage");
  self endon("entitydeleted");
  var_0 = cos(30);
  var_1 = squared(500);
  var_2 = getEnt("handsup_suppression", "targetname");

  for(;;) {
    var_3 = distancesquared(self.origin, level.player.origin) < var_1;
    var_4 = level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), var_0);
    var_5 = !ispointinvolume(level.player.origin, var_2);
    var_6 = sighttracepassed(self getEye(), level.player getEye(), 0, level.player, 1);

    if(var_3 && var_4 && var_5 && var_6) {
      if(self.dead) {
        break;
      } else {
        if(self.responsive) {
          self notify("handsup");

          if(self.dialogue)
            thread scripts\sp\maps\marines\marines_vo.gsc::vo_civ_ambush_player_handsup_responsive_dialogue(self);
        } else if(self.dialogue) {}

        break;
      }
    }

    waitframe();
  }
}

bed_civ_state_handsup() {
  self endon("damage");
  self endon("entitydeleted");
  self.struct thread scripts\common\anim::anim_loop_solo(self, "bed_handsup_idle", "end_handsup_idle");
  thread bed_civ_handsup_complete_monitor();
  var_0 = scripts\engine\utility::waittill_any_return("handsup_complete", "flinch");
  self.struct notify("end_handsup_idle");

  switch (var_0) {
    case "handsup_complete":
      self.handsup_complete = 1;
      self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup2laying");
      thread bed_civ_state_laying();
      break;
    case "flinch":
      thread bed_civ_state_handsup_flinch();
      break;
    default:
  }
}

bed_civ_handsup_complete_monitor() {
  self endon("damage");
  self endon("entitydeleted");
  self endon("flinch");
  waitframe();
  var_0 = squared(200);

  while(distance2dsquared(self.origin, level.player.origin) < var_0)
    waitframe();

  self notify("handsup_complete");
}

bed_civ_state_handsup_flinch() {
  self endon("damage");
  self endon("entitydeleted");

  if(scripts\engine\utility::cointoss())
    self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup_flinch_a");
  else
    self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup_flinch_b");

  thread bed_civ_state_handsup();
}

bed_civ_death_monitor() {
  self endon("entitydeleted");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player) {
    if(isDefined(self.struct.script_noteworthy) && self.struct.script_noteworthy == "civ_ambush_civ") {
      level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;
      level thread scripts\sp\friendlyfire::missionfail(1);
    } else if(!isDefined(self.struct.script_noteworthy)) {
      level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;

      if(level.player.participation <= level.friendlyfire["min_participation"])
        level thread scripts\sp\friendlyfire::missionfail(1);
    }
  }

  scripts\engine\utility::ent_flag_set("play_dead");
  self.friend_kill_points = 0;
  self.skip_friendly_fire_check = 1;
  thread scripts\common\ai::magic_bullet_shield();
  self.struct scripts\common\anim::anim_single_solo(self, "bed_death");
  self linkTo(spawn("script_origin", self.struct.origin));
  self.struct thread scripts\common\anim::anim_set_time_solo(self, "bed_death", 0.99);
  self.struct thread scripts\sp\anim::anim_set_rate_single(self, "bed_death", 0.0);
}

bed_civ_cleanup_monitor() {
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");

  if(isDefined(self)) {
    if(isDefined(self.struct)) {
      self.struct notify("end_laying_idle");
      self.struct notify("end_handsup_idle");
    }

    scripts\engine\sp\utility::anim_stopanimScripted();
    waitframe();

    if(isDefined(self)) {
      if(isDefined(self.magic_bullet_shield))
        scripts\common\ai::stop_magic_bullet_shield();

      self delete();
    }
  }
}

flinch_civs() {
  foreach(var_1 in level.flinch_civs)
  var_1 notify("flinch");
}

civ_ambusher_init() {
  var_0 = getspawner("civtrap_civ_ambush_spawner", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("civtrap_civ_ambush_struct", "script_noteworthy");
  level.civ_ambusher = var_0 scripts\engine\sp\utility::spawn_ai();
  level.civ_ambusher.team = "neutral";
  level.civ_ambusher.ignoreme = 1;
  level.civ_ambusher.allowdeath = 1;
  level.civ_ambusher.noragdoll = 1;
  level.civ_ambusher.dontmelee = 1;
  level.civ_ambusher.dontmeleeme = 1;
  level.civ_ambusher scripts\sp\utility::context_melee_allow(0);
  level.civ_ambusher scripts\common\ai::gun_remove();
  level.civ_ambusher actoraimassistoff();
  level.civ_ambusher.disableplayeradsloscheck = 1;
  self.skipdeathanim = 1;
  self.diequietly = 1;
  waitframe();
  level.civ_ambusher.animname = "bed_decoy";
  level.civ_ambusher forceteleport(var_1.origin, var_1.angles);
  level.civ_ambusher.health = 9999;
  level.civ_ambusher.noragdoll = 1;
  level.civ_ambusher.struct = var_1;
  level.civ_ambusher.index = var_1.script_index;
  level.civ_ambusher thread civ_ambusher_death_monitor();
  level.civ_ambusher thread civ_ambusher_cleanup_monitor();
  level.civ_ambusher.fake_target = scripts\engine\utility::spawn_tag_origin(level.civ_ambusher getEye(), level.civ_ambusher.angles);
  level.civ_ambusher.fake_target linktoblendtotag(level.civ_ambusher, "tag_eye");
  var_1 thread scripts\common\anim::anim_loop_solo(level.civ_ambusher, "bed_laying_idle", "end_laying_idle");
  level.civ_ambusher thread civ_ambusher_ambush_manager();
  level.civ_ambusher thread civ_ambusher_gun_manager();
  level.civ_ambusher thread civ_ambusher_player_threat_monitor();
}

civ_ambusher_ambush_manager() {
  level endon("civ_ambusher_dead");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait_any("flag_civ_ambush_ambusher_attack_check", "flag_civ_ambush_player_threat");
  var_0 = 0;

  if(level.player issprinting() == 1)
    var_0 = 1;
  else {
    scripts\engine\utility::flag_wait_any("flag_civ_ambush_ambusher_attack_trigger", "flag_civ_ambush_player_threat");

    if(scripts\engine\utility::flag("flag_civ_ambush_player_threat") == 1)
      var_0 = 1;
  }

  level.civ_ambusher_target = level.player;
  thread death_hint_watcher_marines_civ_ambush_death();
  self notify("gungrab");
  thread civ_ambush_compliment_dialogue();
  scripts\engine\utility::ent_flag_init("civ_ambusher_target_player");
  self.ignoreme = 1;
  self.skip_friendly_fire_check = 1;
  self.team = "axis";
  self.animname = "bed_decoy";
  self.friend_kill_points = undefined;
  self.struct notify("end_laying_idle");
  self actoraimassiston();

  if(var_0 == 1) {
    var_1 = 2.0;
    scripts\engine\utility::flag_set("flag_civ_ambush_ambusher_grabbing_gun");
    self.struct thread scripts\common\anim::anim_single_solo(self, "bed_gungrab");
    waitframe();
    var_2 = getanimlength(scripts\engine\utility::getanim("bed_gungrab")) / var_1;
    self setanimrate(scripts\engine\utility::getanim("bed_gungrab"), var_1);
    self notify("waittime", var_2);
    wait(var_2);
  } else {
    scripts\engine\utility::flag_set("flag_civ_ambush_ambusher_grabbing_gun");
    self.struct thread scripts\common\anim::anim_single_solo(self, "bed_gungrab");
    waitframe();
    var_2 = getanimlength(scripts\engine\utility::getanim("bed_gungrab"));
    self notify("waittime", var_2);
    wait(var_2);
  }

  level notify("civ_ambush_triggered");
  level notify("civtrap_color_trigger_touched");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_civ_ambush_ambusher_shoot_dialogue();
  self notify("shoot");
  self.struct thread scripts\common\anim::anim_loop_solo(self, "bed_gungrab_idle", "civ_ambusher_shot");
  childthread civ_ambusher_shooting_manager(self.gun);
}

death_hint_watcher_marines_civ_ambush_death() {
  level endon("civ_ambusher_dead");
  level.player waittill("death", var_0, var_1, var_2);

  if(var_0 == level.civ_ambusher)
    scripts\sp\player_death::set_custom_death_quote(403);
}

civ_ambusher_shooting_manager(var_0) {
  level endon("civ_ambusher_dead");
  self endon("entitydeleted");
  var_1 = 0;
  var_2 = getcompleteweaponname("iw8_ar_akilo47");
  var_3 = weaponclipsize(var_2);
  var_4 = weaponfiretime(var_2);
  level.ambusher_can_be_shot = 0;

  if(level.civ_ambusher_target != level.player) {
    self.fake_target = scripts\engine\utility::spawn_tag_origin(level.civ_ambusher_target getEye(), level.civ_ambusher_target.angles);
    self.fake_target childthread civ_ambusher_move_fake_target();
  }

  var_5 = 1;

  while(var_1 < var_3) {
    if(level.civ_ambusher_target != level.player && level.civ_ambusher scripts\engine\utility::ent_flag("civ_ambusher_target_player"))
      level.civ_ambusher_target = level.player;

    if(level.civ_ambusher_target == level.player)
      var_6 = level.player;
    else
      var_6 = self.fake_target;

    self setlookatentity(var_6);

    while(var_1 < var_3) {
      var_7 = var_0 gettagorigin("tag_flash");

      if(level.civ_ambusher_target == level.player)
        var_8 = level.player getEye() - (0, 0, 10);
      else
        var_8 = self.fake_target.origin;

      magicbullet("iw8_ar_akilo47_low_damage", var_7, var_8 + scripts\engine\utility::randomvectorrange(0.2, 2.0), level.civ_ambusher);
      playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var_0 gettagorigin("tag_flash") + (0, 0, 7), var_0 gettagangles("tag_flash"));
      var_1++;
      wait 0.125;

      if(var_5 == 1) {
        thread flinch_civs();
        var_5 = 0;
      }

      thread player_runby_monitor();

      if(level.ambusher_can_be_shot == 0 && var_1 >= 20) {
        self.ignoreme = 0;
        level.ambusher_can_be_shot = 1;
        var_9 = level.allymarines["all"];

        foreach(var_11 in var_9) {
          var_11 clearentitytarget();
          waitframe();
          var_11.favoriteenemy = self;
          var_11 getenemyinfo(self);
        }
      }
    }
  }

  thread civ_ambusher_autokill();
}

civ_ambusher_autokill() {
  var_0 = scripts\engine\utility::getStruct("civ_ambusher_autokill", "targetname").origin;
  var_1 = level.civ_ambusher gettagorigin("j_spinelower");
  var_2 = level.civ_ambusher gettagorigin("j_spineupper");
  var_3 = level.civ_ambusher gettagorigin("j_head");
  var_4 = var_0 - var_3;
  var_5 = var_4 / 7;
  var_0 = var_0 - var_5;
  magicbullet("iw8_ar_akilo47", var_0, var_1);
  wait 0.1;
  magicbullet("iw8_ar_akilo47", var_0, var_2);
  wait 0.1;
  magicbullet("iw8_ar_akilo47", var_0, var_3);
}

civ_ambusher_move_fake_target() {
  level.civ_ambusher_target waittill("death");
  var_0 = 1.0;
  self moveTo(level.player getEye(), var_0, 0.1, 0.1);
  level.civ_ambusher scripts\engine\utility::ent_flag_set("civ_ambusher_target_player");
}

player_runby_monitor() {
  level endon("civ_ambusher_dead");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_civ_ambush_ambusher_allow_kill");

  if(level.ambusher_can_be_shot == 0) {
    self.ignoreme = 0;
    level.ambusher_can_be_shot = 1;
    var_0 = level.allymarines["all"];

    foreach(var_2 in var_0) {
      var_2 clearentitytarget();
      waitframe();
      var_2.favoriteenemy = self;
      var_2 getenemyinfo(self);
    }
  }
}

civ_ambusher_gun_manager() {
  self waittill("waittime", var_0);
  self.gun = getEnt("civ_ambusher_gun", "targetname");
  self.gun linkTo(level.civ_ambusher, "j_gun");
  wait(var_0 * 0.35);

  if(isalive(self))
    scripts\sp\maps\marines\marines_vo.gsc::vo_civambush_griggs_shoot_dialogue();

  self.gun hide();
  var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  level waittill("civ_ambusher_dead");

  if(isDefined(self.fake_target))
    self.fake_target delete();

  self.gun delete();
}

civ_ambusher_death_monitor() {
  self waittill("damage");
  thread scripts\sp\maps\marines\marines_utility.gsc::autosave();
  self.team = "neutral";
  self actoraimassistoff();
  scripts\common\ai::magic_bullet_shield();
  level notify("civ_ambusher_dead");
  self.struct notify("civ_ambusher_shot");
  self linkTo(spawn("script_origin", self.struct.origin));
  self.struct notify("end_laying_idle");
  self.ignoreme = 1;
  self.skip_friendly_fire_check = 1;
  self.team = "axis";
  self.friend_kill_points = undefined;
  scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\common\anim::anim_single_solo(self, "bed_death_b");
  scripts\common\anim::anim_last_frame_solo(self, "bed_death_b");
}

civ_ambusher_cleanup_monitor() {
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");

  if(isDefined(self)) {
    scripts\common\ai::stop_magic_bullet_shield();
    self delete();
  }
}

civ_ambush_compliment_dialogue() {
  scripts\engine\utility::delaythread(0.5, scripts\sp\maps\marines\marines_vo.gsc::vo_civambush_alex_shoot_dialogue);
  var_0 = level.civ_ambusher scripts\engine\utility::waittill_any_return("damage", "shoot");

  if(var_0 == "damage") {
    wait 0.5;
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_civ_ambush_ambusher_killed_dialogue();
  } else {
    level.civ_ambusher waittill("damage");
    wait 0.5;
    thread scripts\sp\maps\marines\marines_vo.gsc::vo_civ_ambush_ambusher_killed_dialogue();
  }
}

civ_ambush_allies_push_forward() {
  var_0 = getEnt("mg_hall_first_ally_positions", "targetname");

  if(isDefined(var_0))
    scripts\engine\sp\utility::activate_trigger_with_targetname("mg_hall_first_ally_positions");
}

civ_ambusher_player_threat_monitor() {
  self endon("damage");
  thread civ_ambusher_player_ads_monitor();
  thread civ_ambusher_player_whizby_monitor();
  scripts\engine\utility::flag_wait_any("flag_civ_ambush_ads_trigger", "flag_civ_ambush_whizby_trigger");
  scripts\engine\utility::flag_set("flag_civ_ambush_player_threat");
}

civ_ambusher_player_ads_monitor() {
  self endon("damage");
  var_0 = cos(5);
  var_1 = squared(450);

  for(;;) {
    var_2 = distancesquared(self.origin, level.player.origin) < var_1;
    var_3 = level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), var_0);

    if(var_2 && var_3) {
      scripts\engine\utility::flag_set("flag_civ_ambush_ads_trigger");
      break;
    }

    waitframe();
  }
}

civ_ambusher_player_whizby_monitor() {
  self endon("damage");
  var_0 = getEnt(self.struct.target, "targetname");
  var_1 = squared(450);

  for(;;) {
    var_0 waittill("damage");
    var_2 = distancesquared(self.origin, level.player.origin) < var_1;

    if(var_2) {
      scripts\engine\utility::flag_set("flag_civ_ambush_whizby_trigger");
      break;
    }

    waitframe();
  }
}

containment_civambush() {
  var_0 = getEnt("containment_civambush_open_left", "targetname");
  var_1 = getEnt("containment_civambush_open_left_glass", "targetname");
  var_2 = getEnt("containment_civambush_open_left_clip", "targetname");
  var_3 = scripts\engine\utility::getStruct("containment_civambush_open_left_show_ref", "targetname");
  var_4 = scripts\engine\utility::getStruct("containment_civambush_open_left_hide_ref", "targetname");
  var_5 = getEnt("containment_civambush_closed_left", "targetname");
  var_6 = getEnt("containment_civambush_closed_left_glass", "targetname");
  var_7 = getEnt("containment_civambush_closed_left_clip", "targetname");
  var_8 = scripts\engine\utility::getStruct("containment_civambush_closed_left_show_ref", "targetname");
  var_9 = scripts\engine\utility::getStruct("containment_civambush_closed_left_hide_ref", "targetname");
  var_10 = getEnt("containment_civambush_open_right", "targetname");
  var_11 = getEnt("containment_civambush_open_right_glass", "targetname");
  var_12 = getEnt("containment_civambush_open_right_clip", "targetname");
  var_13 = scripts\engine\utility::getStruct("containment_civambush_open_right_show_ref", "targetname");
  var_14 = scripts\engine\utility::getStruct("containment_civambush_open_right_hide_ref", "targetname");
  var_15 = getEnt("containment_civambush_closed_right", "targetname");
  var_16 = getEnt("containment_civambush_closed_right_glass", "targetname");
  var_17 = getEnt("containment_civambush_closed_right_clip", "targetname");
  var_18 = scripts\engine\utility::getStruct("containment_civambush_closed_right_show_ref", "targetname");
  var_19 = scripts\engine\utility::getStruct("containment_civambush_closed_right_hide_ref", "targetname");
  var_20 = getEntArray("containment_civambush_clips", "script_noteworthy");
  waitframe();
  var_1 linkTo(var_0);
  var_2 linkTo(var_0);
  var_11 linkTo(var_10);
  var_12 linkTo(var_10);
  var_6 linkTo(var_5);
  var_7 linkTo(var_5);
  var_16 linkTo(var_15);
  var_17 linkTo(var_15);
  waitframe();
  scripts\engine\utility::flag_wait("flag_containment_civambush");
  var_0 moveTo(var_4.origin, 0.1);
  var_10 moveTo(var_14.origin, 0.1);
  var_5 moveTo(var_8.origin, 0.1);
  var_15 moveTo(var_18.origin, 0.1);
  wait 0.2;

  foreach(var_22 in var_20)
  var_22 disconnectPaths();
}

containment_civambush_teleport() {
  var_0 = getEnt("containment_civambush_teleport_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_containment_civambush");
  wait 1.0;
  var_1 = getaiarray("allies");
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4)) {
      if(!var_4 istouching(var_0)) {
        if(var_2 <= 1) {
          var_5 = scripts\engine\utility::getStruct("containment_civambush_teleport_destination_" + var_2, "targetname");

          if(isDefined(var_4) && isalive(var_4)) {
            var_4 teleport(var_5.origin);
            var_2++;
          }
        }
      }
    }
  }
}

civambush_griggs_nag_dialogue() {
  scripts\engine\utility::flag_wait("flag_allies_reach_stair_top");
  wait(randomfloatrange(15, 23));

  while(!scripts\engine\utility::flag("flag_civ_ambush_griggs_react_vo")) {
    scripts\sp\maps\marines\marines_vo.gsc::vo_civambush_griggs_nag_dialogue();
    wait(randomfloatrange(15, 23));
  }
}