/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc
*******************************************************************/

function civ_ambush_init() {
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
  scripts\sp\maps\marines\marines_civilians::civilians_init();
  scripts\sp\drone_civilian::init();
  precachemodel("weapon_vm_ar_akilo47_brprop");
  precachemodel("head_sc_f_toyouri_civ");
}

function civ_ambush_main() {
  thread scripts\sp\maps\marines\marines_utility::transient_waittill("flag_civ_ambush_wounded_aq_walkby", undefined, "marines_mghall_geo_tr");
  scripts\sp\maps\marines\marines_utility::autosave();
  level.manpile_monitor.maximum = 8;
  level.manpile_monitor.maximum_in_fov = 4;
  level.manpile_monitor.ideal = 5;
  level.manpile_monitor.safe_delete_distance = 1500;
  level.manpile_monitor.maximum_weapons = 5;
  level.manpile_monitor.wait_time = 1;
  thread bed_civs_init();
  thread civ_ambush_exit_door_setup();
  thread civ_ambush_stairwell_advance();
  thread civ_ambusher_init();
  thread containment_civambush();
  thread containment_civambush_teleport();
  thread groundfloor_aq_alive_monitor();
  thread scripts\sp\maps\marines\marines_utility::spawn_corpses("civ_ambush_dead_doctor_spawner", "flag_upperfloor_murderhole_flank_left");
  thread civ_ambush_stair_blocking_marine_handler();
  thread civambush_griggs_nag_dialogue();
  thread scripts\sp\maps\marines\marines_vo::vo_civ_ambush_alex_dialogue();
  level.griggs_vo_civambush_speaking = 0;
  scripts\engine\sp\utility::battlechatter_off("axis");
  scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\utility::flag_wait("flag_civ_ambush_start");
  level.griggs pushplayer(0);
  scripts\sp\maps\marines\marines_utility::autosave();
  thread civ_ambush_marine_color_update();
  thread clean_up_first_floor_corpses();
  thread clean_up_first_floor_scriptables();
  level.player scripts\sp\player::player_movement_state("creep");
  thread civ_ambush_movement_handler();
  scripts\engine\utility::flag_wait("flag_civ_ambush_griggs_react_vo");
  scripts\engine\sp\utility::activate_trigger_with_targetname("civ_ambush_entry_color_trigger");
  thread scripts\sp\maps\marines\marines_vo::vo_civambush_marine_intro_dialogue();
  scripts\engine\utility::flag_wait("flag_civ_ambush_wounded_aq_walkby");
  thread scripts\sp\maps\marines\marines_utility::spawn_corpses("mg_hall_dead_marine_spawner", "flag_wolf_snakecam_starting");
  scripts\sp\maps\marines\marines_utility::autosave();
  scripts\engine\utility::flag_wait("flag_civ_ambush_ambusher_attack_trigger");
  var0 = level.allymarines["all"];

  foreach(var2 in var0) {
    if(isalive(var2) && isDefined(var2.asmname)) {
      var2 scripts\common\utility::demeanor_override("combat");
    }
  }

  scripts\engine\utility::flag_wait("flag_civ_ambush_end");
  civ_ambush_marine_color_reset();
  level.player scripts\sp\player::player_movement_state("default");
}

function civ_ambush_stair_blocking_marine_handler() {
  var0 = getEnt("second_floor_marine_teleport_check", "targetname");
  var1 = getEnt("civ_ambush_blocker_clip", "targetname");
  var2 = getspawner("civ_ambush_stair_blocker_spawner", "targetname");
  var1 movez(9999, 0.5, 0.25, 0.25);
  scripts\engine\utility::flag_wait("flag_civ_ambush_start");

  foreach(var4 in getaiarray("allies")) {
    var4 thread scripts\sp\maps\marines\marines_gameplay_hospital_upper::marine_cowabunga_advance_to_goal();
  }

  var6 = var2 scripts\engine\sp\utility::spawn_ai();
  thread civ_ambush_stair_blocker_ai_handler();
  var6 thread scripts\sp\maps\marines\marines_utility::marine_callsign_picker();
  var1 movez(-9999, 0.5, 0.25, 0.25);
}

function civ_ambush_stair_blocker_ai_handler() {
  if(isDefined(self)) {
    self.friend_kill_points = -100000;
    self.grenadeawareness = 0;
    self.script_pushable = 0;
    self.dontavoidplayer = 1;
    self.dontchangepushplayer = 0;
    self pushplayer(1);
  }

  scripts\engine\utility::flag_wait("flag_containment_civambush");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function civ_ambush_movement_handler() {
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
    thread scripts\sp\maps\marines\marines_vo::vo_civambush_alex_take_point();
    scripts\sp\utility::disable_stayahead();
    scripts\engine\sp\utility::enable_ai_color();
    wait 1;

    if(isDefined(self) && isalive(self)) {
      thread scripts\asm\gesture::ai_request_gesture("advance");
      return;
    }

    return;
  }

  scripts\sp\utility::disable_stayahead();
  scripts\engine\sp\utility::enable_ai_color();
}

function go_to_targetname(var0) {
  var1 = getnode(var0, "targetname");

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct(var0, "targetname");
  }

  scripts\sp\spawner::go_to_node(var1);
}

function groundfloor_aq_alive_monitor() {
  var0 = [];
  var0 = scripts\engine\sp\utility::get_living_ai_array("ai_aq_groundfloor", "script_noteworthy");
  waitframe();

  while(var0.size > 0) {
    var0 = scripts\engine\sp\utility::get_living_ai_array("ai_aq_groundfloor", "script_noteworthy");
    waitframe();
  }
}

function civ_ambush_start() {
  scripts\engine\sp\utility::set_start_location("start_civ_ambush", [level.player]);
  level.griggs = scripts\sp\maps\marines\marines_utility::setup_named_ai("griggs", "Sgt. Griggs", "start_civ_ambush_griggs", undefined, undefined, undefined, "Demon 1-2");
  thread scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_civ_ambush");
  var0 = getspawnerarray("ally_marine_civ_ambush");
  thread scripts\sp\maps\marines\marines_utility::marines_checkpoint_forcespawn_allies(var0);
  thread scripts\sp\maps\marines\marines_utility::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread scripts\sp\maps\marines\marines_utility::spawn_corpses("stairwell_dead_body", "flag_civ_ambush_end");
  thread scripts\sp\maps\marines\marines_utility::stairwell_corpses_cleanup();
  scripts\sp\maps\marines\marines_lighting::sun_adjustments_hospital_force("lighting_hospital", 2);
}

function civ_ambush_catchup() {
  thread civ_ambush_exit_door_setup();
  thread clean_up_first_floor_scriptables();
  thread containment_civambush();
  scripts\engine\utility::flag_set("flag_containment_civambush");
}

function civ_ambush_exit_door_setup() {
  var0 = scripts\sp\door::get_interactive_door("civ_ambush_exit_door_left");
  var1 = scripts\sp\door::get_interactive_door("civ_ambush_exit_door_right");
  var0 scripts\game\sp\door::remove_door_snake_cam_ability();
  var1 scripts\game\sp\door::remove_door_snake_cam_ability();
  var0.open_left = 1;
  var0.hinge_side = "open_left";
  var1.open_left = 0;
  var1.hinge_side = "open_right";
  var0.script_max_left_angle = 120;
  var0.script_max_right_angle = 65;
  var0 scripts\sp\door::init_max_yaws();
  var1.script_max_left_angle = 120;
  var1.script_max_right_angle = 120;
  var1 scripts\sp\door::init_max_yaws();
  var0.script_spawn_open_yaw = 65;
  var0 notify("first_interact");
  var0.open_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
  var1.script_spawn_open_yaw = -100;
  var1 notify("first_interact");
  var1.open_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
  var0.bashed_full = 1;
  var1.bashed_full = 1;
  thread push_manager();
  thread bash_manager();
  thread push_manager();
  scripts\engine\utility::flag_set("civ_ambush_exit_door_setup");
}

function push_manager() {
  self endon("stop_push_open");
  self endon("bashed_full");
  self endon("entitydeleted");

  for(;;) {
    if(scripts\sp\door::interact_door_ispushentclose()) {
      push_door_override();
    } else if(istrue(self.isplayingpushsound)) {
      self.isplayingpushsound = 0;
      self notify("stop_door_creak");
    }

    waitframe();
  }
}

function bash_manager() {
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

function push_door_override() {
  if(istrue(self.bash_opening)) {
    return;
  }

  var0 = 36;
  var1 = 0;
  var2 = 25;
  var3 = scripts\sp\door_internal::interact_door_get_endpoint();
  var4 = distance(level.player.origin, var3);
  var5 = scripts\engine\math::normalize_value(var1, var0, var4);
  var6 = var2 * (1 - var5);

  if(abs(var6) < 0.001) {
    return;
  }

  self.prompt_moved = 1;
  self.open_left = scripts\sp\door::should_open_left(self.pivot_ent.angles);
  var7 = scripts\sp\door::get_door_angles()[1];
  var8 = scripts\engine\utility::ter_op(self.open_left == 1, 1, -1);
  var9 = var7 + var6 * var8;

  if(self.open_left) {
    if(self.hinge_side == "open_left") {
      var10 = abs(scripts\sp\door::angle_diff(var9, self.true_start_angles[1]));

      if(var10 > self.max_yaw_left) {
        self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
        self.open_completely = 1;
        thread scripts\sp\door::updatenavobstacle();
        self notify("stop_push_open");
        return;
      }
    } else if(var9 > self.true_start_angles[1]) {
      self.debug_activity = "Pushed back closed, right hinge";
      thread scripts\sp\door::reset_door();
      self notify("stop_push_open");
      return;
    }
  } else if(self.hinge_side == "open_right") {
    var10 = abs(scripts\sp\door::angle_diff(var9, self.true_start_angles[1]));

    if(var10 > self.max_yaw_right) {
      self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
      self.open_completely = 1;
      thread scripts\sp\door::updatenavobstacle();
      self notify("stop_push_open");
      return;
    }
  } else if(var9 < self.true_start_angles[1]) {
    self.debug_activity = "Pushed back closed, left hinge";
    thread scripts\sp\door::reset_door();
    self notify("stop_push_open");
    return;
  }

  if(self.open_left) {
    if(self.hinge_side == "open_left") {
      scripts\sp\door_internal::set_pivot_point(1);
    } else {
      scripts\sp\door_internal::set_pivot_point(0);
    }
  } else if(self.hinge_side == "open_right") {
    scripts\sp\door_internal::set_pivot_point(0);
  } else {
    scripts\sp\door_internal::set_pivot_point(1);
  }

  if(var6 > 0.4) {
    thread scripts\sp\door_internal::try_push_sound();

    if(!scripts\engine\utility::flag("door_second_interact")) {
      scripts\engine\utility::flag_set("door_second_interact");
    }
  } else if(istrue(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
    self notify("stop_door_creak");
  }

  self.pivot_ent.angles = (self.pivot_ent.angles[0], var9, self.pivot_ent.angles[2]);
  self.forward = anglesToForward(self.pivot_ent.angles);

  if(scripts\sp\door_internal::door_is_half_open()) {
    if(!self.was_opened_halfway) {
      thread scripts\sp\door_internal::suspicious_door_stealth_check(1);
    }

    self.was_opened_halfway = 1;
  }

  if(abs(angleclamp180(self.pivot_ent.angles[1] - self.nav_lastupdateangle)) > 20 && gettime() - self.nav_lastupdatetime > 1500) {
    thread scripts\sp\door::updatenavobstacle(1);
    return;
  }
}

function civ_ambush_stairwell_advance() {
  var0 = scripts\engine\utility::getStruct("stairwell_travel_path_left_a", "targetname");
  var1 = scripts\engine\utility::getStruct("stairwell_travel_path_left_b", "targetname");
  var2 = scripts\engine\utility::getStruct("stairwell_travel_path_left_c", "targetname");
  var3 = scripts\engine\utility::getStruct("stairwell_travel_path_right_a", "targetname");
  var4 = scripts\engine\utility::getStruct("stairwell_travel_path_right_b", "targetname");
  var5 = getnode("stairwell_travel_path_right_b_arrival_node", "targetname");
  var6 = scripts\engine\utility::getStruct("stairwell_travel_path_left_c", "targetname");
  var7 = [];
  level.stairwell_available_paths = [];
  var8 = [];
  var9 = [];
  level.stairwell_available_paths_index = 0;
  var10 = [];
  var10 = scripts\engine\sp\utility::get_living_ai_array("aq_groundfloor_stairwell_spawners", "targetname");
  waitframe();

  if(var10.size > 0) {
    var11 = getaiarray("allies");

    foreach(var13 in var11) {
      if(isDefined(var13) && isalive(var13)) {
        var13 scripts\engine\sp\utility::set_baseaccuracy(1);
      }
    }
  }

  thread scripts\engine\utility::delaythread(5, &scripts\engine\utility::flag_set, "flag_stairwell_wait_time_elapsed");

  while(var10.size > 0 && !scripts\engine\utility::flag("flag_stairwell_wait_time_elapsed")) {
    var10 = scripts\engine\sp\utility::get_living_ai_array("aq_groundfloor_stairwell_spawners", "targetname");
    waitframe();
  }

  thread scripts\sp\maps\marines\marines_vo::vo_civambush_griggs_stairwell_advance_dialogue();
  var11 = getaiarray("allies");

  foreach(var13 in var11) {
    if(isDefined(var13) && isalive(var13)) {
      var13 scripts\engine\sp\utility::set_baseaccuracy(0.5);
    }
  }

  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var4);
  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var0);
  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var3);
  level.stairwell_available_paths = scripts\engine\utility::array_add(level.stairwell_available_paths, var1);
  wait 1;
  var7 = getaiarray("allies");

  foreach(var18 in var7) {
    if(isalive(var18) && isDefined(var18.asmname)) {
      var18 scripts\common\utility::demeanor_override("cqb");
    }
  }

  waitframe();

  if(var7.size < 4) {
    thread marine_stairwell_respawn_monitor(var7);
  }

  var20 = sortbydistance(var7, var6.origin);
  var21 = 0;

  foreach(var18 in var20) {
    if(isDefined(var18) && isalive(var18)) {
      if(level.stairwell_available_paths_index <= level.stairwell_available_paths.size) {
        if(var21 == 4) {
          wait 1;

          if(isDefined(var18) && isalive(var18)) {
            if(var18 == level.griggs) {
              var18 thread scripts\sp\maps\marines\marines_utility::marine_path_util(var2, undefined, undefined, undefined, undefined, 0);
            } else {
              var18 thread scripts\sp\maps\marines\marines_utility::marine_path_util(var2, undefined, undefined, undefined, undefined, 1);
            }

            thread stairwell_advance_ignore_player_enable();
            var21++;
          }
        } else {
          if(var18 == level.griggs) {
            var18 thread scripts\sp\maps\marines\marines_utility::marine_path_util(level.stairwell_available_paths[level.stairwell_available_paths_index], undefined, undefined, undefined, undefined, 0);
          } else {
            var18 thread scripts\sp\maps\marines\marines_utility::marine_path_util(level.stairwell_available_paths[level.stairwell_available_paths_index], undefined, undefined, undefined, undefined, 1);
          }

          var18.script_index = level.stairwell_available_paths_index;
          level.stairwell_available_paths_index++;
          var21++;
          thread stairwell_advance_ignore_player_enable();
        }
      }
    }

    wait 1.5;
  }

  scripts\engine\utility::flag_set("flag_stairwell_marine_initial_pathing_done");
}

function stairwell_advance_ignore_player_enable() {
  self.dontavoidplayer = 1;
  self.disablebulletwhizbyreaction = 1;
  self.script_pushable = 0;
  self enableavoidance(0);
  self.doavoidanceblocking = 0;
  self.dontchangepushplayer = undefined;
  self pushplayer(1);
}

function stairwell_advance_ignore_player_clear() {
  self.dontavoidplayer = 0;
  self.disablebulletwhizbyreaction = 0;
  self.script_pushable = 1;
  self enableavoidance(1);
  self.doavoidanceblocking = 1;
  self.dontchangepushplayer = 1;
  self pushplayer(0);
}

function civ_ambush_marine_color_update() {
  var0 = level.allymarines["all"];
  var0 = scripts\engine\utility::array_remove(var0, level.griggs);
  thread stairwell_advance_ignore_player_clear();
  waitframe();
  var1 = scripts\engine\utility::getStruct("civ_ambush_ai_advance_ref", "targetname");
  var0 = sortbydistance(var0, var1.origin);
  var0 = scripts\engine\utility::array_remove(var0, level.griggs);
  thread griggs_stairwell_advance_demeanor();
  level.griggs thread scripts\sp\maps\marines\marines_gameplay_hospital_upper::marine_cowabunga_advance_to_goal();
  var2 = 0;

  foreach(var4 in var0) {
    thread switch_color_at_goal_thread(var4, var4.script_forcecolor);
    var2++;
  }

  level.civ_ambush_marine_color_swap_waiting = var2;

  while(level.civ_ambush_marine_color_swap_waiting) {
    waitframe();
  }

  level.griggs scripts\engine\sp\utility::disable_ai_color();
  scripts\sp\spawner::killspawner(95);
  scripts\engine\utility::flag_wait("flag_civ_ambush_start");
  thread scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_civ_ambush");
}

function griggs_stairwell_advance_demeanor() {
  self endon("death");
  var0 = scripts\engine\utility::getStruct("civ_ambush_ai_advance_ref", "targetname");

  while(distancesquared(self.origin, var0.origin) > 10000) {
    if(isDefined(self.asmname)) {
      scripts\common\utility::demeanor_override("combat");
    }

    waitframe();
  }

  while(distancesquared(self.origin, var0.origin) <= 10000) {
    if(isDefined(self.asmname)) {
      scripts\common\utility::demeanor_override("combat");
    }

    waitframe();
  }

  if(isDefined(self.asmname)) {
    scripts\common\utility::demeanor_override("cqb");
    return;
  }
}

function switch_color_at_goal_thread(var0, var1) {
  switch_color_at_goal(var0, var1);
  level.civ_ambush_marine_color_swap_waiting--;
}

function switch_color_at_goal(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  self waittill("goal");
  scripts\engine\sp\utility::disable_ai_color();
  self setgoalpos(self.origin);
  thread stairwell_advance_ignore_player_clear();
  scripts\common\ai::set_gunpose("ready", 1);
  scripts\engine\utility::flag_wait("flag_griggs_enter_civ_ambush_gate");
  thread scripts\sp\maps\marines\marines_utility::switch_marine_color(var0, var1);
}

function civ_ambush_marine_color_reset() {
  var0 = level.allymarines["all"];
  var0 = scripts\engine\utility::array_remove(var0, level.griggs);
  var1 = 0;

  foreach(var3 in var0) {
    if(isDefined(var3) && isalive(var3)) {
      var3 scripts\common\ai::set_gunpose("ready", 1);

      if(isDefined(var3.poiauto)) {
        var3 scripts\common\ai::poi_enable(0);
      }

      if(var1 == 0) {
        var4 = var3.script_forcecolor;
        var3 scripts\sp\maps\marines\marines_utility::switch_marine_color(var4, "g");
        var1++;
        continue;
      }

      if(var1 == 1) {
        var4 = var3.script_forcecolor;
        var3 scripts\sp\maps\marines\marines_utility::switch_marine_color(var4, "g");
        var1++;
        continue;
      }

      if(var1 == 2) {
        var4 = var3.script_forcecolor;
        var3 scripts\sp\maps\marines\marines_utility::switch_marine_color(var4, "g");
        var1++;
        continue;
      }

      if(var1 > 2) {
        var4 = var3.script_forcecolor;
        var3 scripts\sp\maps\marines\marines_utility::switch_marine_color(var4, "g");
        var1++;
      }
    }
  }
}

function marine_stairwell_respawn_monitor(var0) {
  scripts\engine\utility::flag_wait("flag_stairwell_marine_initial_pathing_done");

  while(level.stairwell_available_paths_index <= level.stairwell_available_paths.size) {
    var0 = level.allymarines["all"];
    waitframe();
    var0 = scripts\engine\utility::array_remove(var0, level.griggs);

    foreach(var2 in var0) {
      if(isDefined(var2) && isalive(var2)) {
        if(!isDefined(var2.script_index)) {
          if(level.stairwell_available_paths_index <= level.stairwell_available_paths.size) {
            var2 thread scripts\sp\maps\marines\marines_utility::marine_path_util(level.stairwell_available_paths[level.stairwell_available_paths_index], undefined, undefined, undefined, undefined, 1);
            var2.script_index = level.stairwell_available_paths_index;
            level.stairwell_available_paths_index++;
          }
        }
      }
    }

    wait 1;
  }
}

function clean_up_first_floor_corpses() {
  scripts\engine\sp\utility::trigger_wait_targetname("hospital_first_floor_delete");
  var0 = getcorpsearray();
  var1 = getweaponarray();
  var2 = getEnt("hospital_first_floor_catcher1", "targetname");
  var3 = getEnt("hospital_first_floor_catcher2", "targetname");
  var4 = getEnt("hospital_first_floor_catcher3", "targetname");

  foreach(var6 in var0) {
    if(var6 istouching(var2) || var6 istouching(var3) || var6 istouching(var4)) {
      var6 delete();
    }
  }

  foreach(var9 in var1) {
    if(var9 istouching(var2) || var9 istouching(var3) || var9 istouching(var4)) {
      var9 delete();
    }
  }
}

function clean_up_first_floor_scriptables() {
  scripts\engine\sp\utility::trigger_wait_targetname("hospital_first_floor_delete");
  var0 = getscriptablearray("deletable_hospital_first_floor", "script_noteworthy");

  foreach(var2 in var0) {
    if(var2.model == "" || !isDefined(var2.model)) {
      continue;
    }

    var2 hideallparts();
  }
}

function civ_trap_hint_clear() {
  return istrue(level.civ_trap_hint_started);
}

function bed_civs_init() {
  level.flinch_civs = [];
  var0 = getspawner("civtrap_civ_bed_1_spawner", "targetname");
  var1 = getspawner("civtrap_civ_bed_2_spawner", "targetname");
  var2 = getspawner("civtrap_civ_bed_3_spawner", "targetname");
  var3 = getspawner("civtrap_civ_bed_4_spawner", "targetname");
  var4 = getspawner("civtrap_civ_bed_5_spawner", "targetname");
  var5 = getspawner("civtrap_civ_bed_6_spawner", "targetname");
  var6 = getspawner("civtrap_civ_bed_7_spawner", "targetname");
  var7 = getspawner("civtrap_civ_bed_8_spawner", "targetname");
  var8 = getspawner("civtrap_civ_bed_9_spawner", "targetname");
  var9 = getspawner("civtrap_civ_bed_10_spawner", "targetname");
  var10 = getspawner("civtrap_civ_bed_11_spawner", "targetname");
  var11 = getspawner("civtrap_civ_bed_12_spawner", "targetname");
  var12 = scripts\engine\utility::getStruct("civtrap_civ_bed_1_struct", "targetname");
  var13 = scripts\engine\utility::getStruct("civtrap_civ_bed_2_struct", "targetname");
  var14 = scripts\engine\utility::getStruct("civtrap_civ_bed_3_struct", "targetname");
  var15 = scripts\engine\utility::getStruct("civtrap_civ_bed_4_struct", "targetname");
  var16 = scripts\engine\utility::getStruct("civtrap_civ_bed_5_struct", "targetname");
  var17 = scripts\engine\utility::getStruct("civtrap_civ_bed_6_struct", "targetname");
  var18 = scripts\engine\utility::getStruct("civtrap_civ_bed_7_struct", "targetname");
  var19 = scripts\engine\utility::getStruct("civtrap_civ_bed_8_struct", "targetname");
  var20 = scripts\engine\utility::getStruct("civtrap_civ_bed_9_struct", "targetname");
  var21 = scripts\engine\utility::getStruct("civtrap_civ_bed_10_struct", "targetname");
  var22 = scripts\engine\utility::getStruct("civtrap_civ_bed_11_struct", "targetname");
  var23 = scripts\engine\utility::getStruct("civtrap_civ_bed_12_struct", "targetname");
  var0 scripts\engine\sp\utility::add_spawn_function(&bed_civ_handsup_trigger, 1);
  var1 scripts\engine\sp\utility::add_spawn_function(&bed_civ_handsup_trigger, 2);
  var5 scripts\engine\sp\utility::add_spawn_function(&bed_civ_handsup_trigger, 6);
  var4 scripts\engine\sp\utility::add_spawn_function(&bed_civ_handsup_trigger, 5);
  var7 scripts\engine\sp\utility::add_spawn_function(&bed_civ_handsup_trigger, 8);
  var3 scripts\engine\sp\utility::add_spawn_function(&vo_civ_ambush_wounded_aq_init);
  thread bed_civ_init(var0, var12, 0, 0, 1, 1, "body_civ_syrkistan_male_3_1", "head_sc_m_kargorgis_civ");
  thread bed_civ_init(var1, var13, 0, 1, 1, 0, "body_civ_syrkistan_female_10_1", "head_sc_f_toyouri_civ");
  thread bed_civ_init(var2, var14, 0, 0, 1, 1);
  thread bed_civ_init(var3, var15, 0, 0, 1, 1);
  thread bed_civ_init(var4, var16, 0, 0, 1, 0);
  thread bed_civ_init(var5, var17, 0, 0, 1, 1);
  thread bed_civ_init(var6, var18, 1, 0, 1, 1);
  thread bed_civ_init(var7, var19, 0, 1, 1, 1);
  thread bed_civ_init(var8, var20, 0, 0, 1, 1);
  thread bed_civ_init(var9, var21, 0, 1, 1, 1);
  thread bed_civ_init(var10, var22, 0, 0, 1, 1);
  thread bed_civ_init(var11, var23, 0, 0, 1, 1);
}

function bed_civ_handsup_trigger(var0) {
  self endon("entitydeleted");
  wait 1;
  var1 = getnode("civ_" + var0 + "_handsup_node", "script_noteworthy");
  var2 = undefined;

  while(!isDefined(var2)) {
    foreach(var4 in getaiarray("allies")) {
      if(isDefined(var4.node) && var4.node == var1) {
        var2 = var4;
      }
    }

    waitframe();
  }

  while(isDefined(var2) && distance2dsquared(self.origin, var2.origin) > 40000) {
    waitframe();
  }

  if(isDefined(var2) && !scripts\engine\utility::flag("flag_civ_ambush_ambusher_grabbing_gun")) {
    var6 = scripts\engine\utility::getStruct("civ_" + var0 + "_handsup_struct", "targetname");
    var2 scripts\common\ai::poi_enable(1, var6);

    if(self.responsive) {
      self notify("handsup");
    }

    self.ignoreme = 0;
    self.team = "axis";
    var2.favoriteenemy = self;
    var2 scripts\common\ai::set_gunpose("ads");
    var2 scripts\sp\maps\marines\marines_vo::vo_civ_ambush_friendly_hands_up_dialogue();
    wait 2;
    var2 scripts\common\ai::poi_enable(0);
    var2 scripts\common\ai::set_gunpose("ready", 1);
    var2 scripts\asm\shared\utility::toggle_poiauto(1, 10, 30, 5, 10);
    self notify("handsup_complete");
    return;
  }
}

function vo_civ_ambush_wounded_aq_init() {
  level.vo_civ_ambush_wounded_aq = self;
}

#using_animtree("generic_human");

function bed_civ_init(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(level.civ_ambush_poi_structs)) {
    level.civ_ambush_poi_structs = [];
  }

  level.civ_ambush_poi_structs = scripts\engine\utility::array_add(level.civ_ambush_poi_structs, var1);
  var8 = var0 scripts\engine\sp\utility::spawn_ai();
  var8.dead = var2;
  var8.responsive = var3;
  var8.dialogue = var4;
  var8.sex = scripts\engine\utility::ter_op(var5, "male", "female");
  var8.team = "neutral";
  var8.ignoreme = 1;
  var8.allowdeath = 1;
  var8.noragdoll = 1;
  var8.dontmelee = 1;
  var8 scripts\sp\utility::context_melee_allow(0);

  if(getdvarint("scr_use_procedural_bones")) {
    var8 setanim(%proc_node, 1, 0);
  }

  if(isDefined(var6) && isDefined(var7)) {
    var8 scripts\sp\maps\marines\marines_gameplay_hospital_upper::setcharmodels(var6, var7, undefined);
  }

  if(istrue(var8.script_fakeactor)) {
    var8 scripts\sp\fakeactor::take_control();
  }

  waitframe();
  level thread scripts\sp\friendlyfire::friendly_fire_think(var8);
  var8.struct = var1;
  var8.health = 99999;
  var8.noragdoll = 1;

  if(istrue(var8.script_fakeactor)) {
    var8.origin = var1.origin;
    var8.angles = var1.angles;
  } else {
    var8 teleport(var1.origin, var1.angles);
  }

  thread bed_civ_ads_monitor();

  if(var2) {
    var8.animname = "bed_civ_8";
    var8.friend_kill_points = 0;
    var8.skip_friendly_fire_check = 1;
    thread bed_civ_cleanup_monitor();
    var8 thread scripts\common\ai::magic_bullet_shield();
    var8.struct thread scripts\common\anim::anim_loop_solo(var8, "bed_laying_idle", "end_laying_idle");
    return;
  }

  var8 scripts\engine\utility::ent_flag_init("play_dead");
  var8.index = var1.script_index;
  assign_bed_civ_index(var8, get_script_index(var1));
  thread bed_civ_death_monitor();
  thread bed_civ_cleanup_monitor();
  thread bed_civ_state_laying();
  thread bed_civ_flinch_monitor();

  if(isDefined(level.flinch_civs)) {
    level.flinch_civs = scripts\engine\utility::array_add(level.flinch_civs, var8);
  }

  return var8;
}

function get_script_index() {
  if(isDefined(self.script_index) && self.script_index >= 1 && self.script_index <= 7) {
    return self.script_index;
  }

  return undefined;
}

function assign_bed_civ_index(var0) {
  if(isDefined(var0)) {
    if(var0 >= 1 && var0 <= 7) {
      self.animname = "bed_civ_" + var0;
      return;
    }

    return;
  }

  if(self.index >= 1 && self.index <= 7) {
    self.animname = "bed_civ_" + self.index;
    return;
  }

  assign_random_bed_civ_index();
}

function assign_random_bed_civ_index() {
  self.animname = "bed_civ_" + randomint(7) + 1;
}

function bed_civ_state_laying() {
  self endon("damage");
  self endon("entitydeleted");
  self.struct thread scripts\common\anim::anim_loop_solo(self, "bed_laying_idle", "end_laying_idle");

  if(self.index < 4 && !isDefined(self.handsup_complete)) {
    thread bed_civ_state_laying_responsive();
    return;
  }

  thread bed_civ_state_laying_unresponsive();
}

function bed_civ_state_laying_responsive() {
  self endon("damage");
  self endon("entitydeleted");
  var0 = scripts\engine\utility::waittill_any_return("handsup", "flinch");
  self.struct notify("end_laying_idle");

  switch (var0) {
    case "handsup":
      self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup");
      thread bed_civ_state_handsup();
      break;
    case "flinch":
      thread bed_civ_state_laying_flinch();
      break;
    default:
      break;
  }
}

function bed_civ_state_laying_unresponsive() {
  self endon("damage");
  self endon("entitydeleted");
  self waittill("flinch");
  self.struct notify("end_laying_idle");
  thread bed_civ_state_laying_flinch();
}

function bed_civ_flinch_monitor() {
  self endon("damage");
  self endon("entitydeleted");

  if(isDefined(self.struct.target)) {
    for(;;) {
      var0 = getEnt(self.struct.target, "targetname");
      var0 waittill("damage");
      self notify("flinch");
    }

    return;
  }
}

function bed_civ_state_laying_flinch() {
  self endon("damage");
  self endon("entitydeleted");

  if(self.index < 4) {
    self.struct scripts\common\anim::anim_single_solo(self, "bed_laying_flinch");
  } else if(scripts\engine\utility::cointoss()) {
    self.struct scripts\common\anim::anim_single_solo(self, "bed_laying_flinch_a");
  } else {
    self.struct scripts\common\anim::anim_single_solo(self, "bed_laying_flinch_b");
  }

  thread bed_civ_state_laying();
}

function bed_civ_ads_monitor() {
  self endon("damage");
  self endon("entitydeleted");
  var0 = cos(30);
  var1 = squared(500);
  var2 = getEnt("handsup_suppression", "targetname");

  for(;;) {
    var3 = distancesquared(self.origin, level.player.origin) < var1;
    var4 = level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), var0);
    var5 = !ispointinvolume(level.player.origin, var2);
    var6 = sighttracepassed(self getEye(), level.player getEye(), 0, level.player, 1);

    if(var3 && var4 && var5 && var6) {
      if(self.dead) {
        break;
      } else {
        if(self.responsive) {
          self notify("handsup");

          if(self.dialogue) {
            thread scripts\sp\maps\marines\marines_vo::vo_civ_ambush_player_handsup_responsive_dialogue(self);
          }
        } else if(self.dialogue) {}

        break;
      }
    }

    waitframe();
  }
}

function bed_civ_state_handsup() {
  self endon("damage");
  self endon("entitydeleted");
  self.struct thread scripts\common\anim::anim_loop_solo(self, "bed_handsup_idle", "end_handsup_idle");
  thread bed_civ_handsup_complete_monitor();
  var0 = scripts\engine\utility::waittill_any_return("handsup_complete", "flinch");
  self.struct notify("end_handsup_idle");

  switch (var0) {
    case "handsup_complete":
      self.handsup_complete = 1;
      self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup2laying");
      thread bed_civ_state_laying();
      break;
    case "flinch":
      thread bed_civ_state_handsup_flinch();
      break;
    default:
      break;
  }
}

function bed_civ_handsup_complete_monitor() {
  self endon("damage");
  self endon("entitydeleted");
  self endon("flinch");
  waitframe();
  var0 = squared(200);

  while(distance2dsquared(self.origin, level.player.origin) < var0) {
    waitframe();
  }

  self notify("handsup_complete");
}

function bed_civ_state_handsup_flinch() {
  self endon("damage");
  self endon("entitydeleted");

  if(scripts\engine\utility::cointoss()) {
    self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup_flinch_a");
  } else {
    self.struct scripts\common\anim::anim_single_solo(self, "bed_handsup_flinch_b");
  }

  thread bed_civ_state_handsup();
}

function bed_civ_death_monitor() {
  self endon("entitydeleted");
  self waittill("damage", var0, var1);

  if(var1 == level.player) {
    if(isDefined(self.struct.script_noteworthy) && self.struct.script_noteworthy == "civ_ambush_civ") {
      level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;
      level thread scripts\sp\friendlyfire::missionfail(1);
    } else if(!isDefined(self.struct.script_noteworthy)) {
      level.friendlyfire["civilians_killed"] = level.friendlyfire["civilians_killed"] + 1;

      if(level.player.participation <= level.friendlyfire["min_participation"]) {
        level thread scripts\sp\friendlyfire::missionfail(1);
      }
    }
  }

  scripts\engine\utility::ent_flag_set("play_dead");
  self.friend_kill_points = 0;
  self.skip_friendly_fire_check = 1;
  thread scripts\common\ai::magic_bullet_shield();
  self.struct scripts\common\anim::anim_single_solo(self, "bed_death");
  self linkTo(spawn("script_origin", self.struct.origin));
  self.struct thread scripts\common\anim::anim_set_time_solo(self, "bed_death", 0.99);
  self.struct thread scripts\sp\anim::anim_set_rate_single(self, "bed_death", 0);
}

function bed_civ_cleanup_monitor() {
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");

  if(isDefined(self)) {
    if(isDefined(self.struct)) {
      self.struct notify("end_laying_idle");
      self.struct notify("end_handsup_idle");
    }

    scripts\engine\sp\utility::anim_stopanimScripted();
    waitframe();

    if(isDefined(self)) {
      if(isDefined(self.magic_bullet_shield)) {
        scripts\common\ai::stop_magic_bullet_shield();
      }

      self delete();
      return;
    }

    return;
  }
}

function flinch_civs() {
  foreach(var1 in level.flinch_civs) {
    var1 notify("flinch");
  }
}

function civ_ambusher_init() {
  var0 = getspawner("civtrap_civ_ambush_spawner", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("civtrap_civ_ambush_struct", "script_noteworthy");
  level.civ_ambusher = var0 scripts\engine\sp\utility::spawn_ai();
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
  level.civ_ambusher forceteleport(var1.origin, var1.angles);
  level.civ_ambusher.health = 9999;
  level.civ_ambusher.noragdoll = 1;
  level.civ_ambusher.struct = var1;
  level.civ_ambusher.index = var1.script_index;
  thread civ_ambusher_death_monitor();
  thread civ_ambusher_cleanup_monitor();
  level.civ_ambusher.fake_target = scripts\engine\utility::spawn_tag_origin(level.civ_ambusher getEye(), level.civ_ambusher.angles);
  level.civ_ambusher.fake_target linktoblendtotag(level.civ_ambusher, "tag_eye");
  var1 thread scripts\common\anim::anim_loop_solo(level.civ_ambusher, "bed_laying_idle", "end_laying_idle");
  thread civ_ambusher_ambush_manager();
  thread civ_ambusher_gun_manager();
  thread civ_ambusher_player_threat_monitor();
}

function civ_ambusher_ambush_manager() {
  level endon("civ_ambusher_dead");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait_any("flag_civ_ambush_ambusher_attack_check", "flag_civ_ambush_player_threat");
  var0 = 0;

  if(level.player issprinting() == 1) {
    var0 = 1;
  } else {
    scripts\engine\utility::flag_wait_any("flag_civ_ambush_ambusher_attack_trigger", "flag_civ_ambush_player_threat");

    if(scripts\engine\utility::flag("flag_civ_ambush_player_threat") == 1) {
      var0 = 1;
    }
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

  if(var0 == 1) {
    var1 = 2;
    scripts\engine\utility::flag_set("flag_civ_ambush_ambusher_grabbing_gun");
    self.struct thread scripts\common\anim::anim_single_solo(self, "bed_gungrab");
    waitframe();
    var2 = getanimlength(scripts\engine\utility::getanim("bed_gungrab")) / var1;
    self setanimrate(scripts\engine\utility::getanim("bed_gungrab"), var1);
    self notify("waittime", var2);
    wait var2;
  } else {
    scripts\engine\utility::flag_set("flag_civ_ambush_ambusher_grabbing_gun");
    self.struct thread scripts\common\anim::anim_single_solo(self, "bed_gungrab");
    waitframe();
    var2 = getanimlength(scripts\engine\utility::getanim("bed_gungrab"));
    self notify("waittime", var2);
    wait var2;
  }

  level notify("civ_ambush_triggered");
  level notify("civtrap_color_trigger_touched");
  thread scripts\sp\maps\marines\marines_vo::vo_civ_ambush_ambusher_shoot_dialogue();
  self notify("shoot");
  self.struct thread scripts\common\anim::anim_loop_solo(self, "bed_gungrab_idle", "civ_ambusher_shot");
  GscBinSkip4(0x35, self.gun);
}

function death_hint_watcher_marines_civ_ambush_death() {
  level endon("civ_ambusher_dead");
  level.player waittill("death", var0, var1, var2);

  if(var0 == level.civ_ambusher) {
    scripts\sp\player_death::set_custom_death_quote(403);
    return;
  }
}

function civ_ambusher_shooting_manager(var0) {
  level endon("civ_ambusher_dead");
  self endon("entitydeleted");
  var1 = 0;
  var2 = getcompleteweaponname("iw8_ar_akilo47");
  var3 = weaponclipsize(var2);
  var4 = weaponfiretime(var2);
  level.ambusher_can_be_shot = 0;

  if(level.civ_ambusher_target != level.player) {
    self.fake_target = scripts\engine\utility::spawn_tag_origin(level.civ_ambusher_target getEye(), level.civ_ambusher_target.angles);
    GscBinSkip4(0x6e, self.fake_target);
  }

  var5 = 1;

  while(var1 < var3) {
    if(level.civ_ambusher_target != level.player && level.civ_ambusher scripts\engine\utility::ent_flag("civ_ambusher_target_player")) {
      level.civ_ambusher_target = level.player;
    }

    if(level.civ_ambusher_target == level.player) {
      var6 = level.player;
    } else {
      var6 = self.fake_target;
    }

    self setlookatentity(var6);

    while(var1 < var3) {
      var7 = var0 gettagorigin("tag_flash");

      if(level.civ_ambusher_target == level.player) {
        var8 = level.player getEye() - (0, 0, 10);
      } else {
        var8 = self.fake_target.origin;
      }

      magicbullet("iw8_ar_akilo47_low_damage", var7, var8 + scripts\engine\utility::randomvectorrange(0.2, 2), level.civ_ambusher);
      playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var0 gettagorigin("tag_flash") + (0, 0, 7), var0 gettagangles("tag_flash"));
      var1++;
      wait 0.125;

      if(var5 == 1) {
        thread flinch_civs();
        var5 = 0;
      }

      thread player_runby_monitor();

      if(level.ambusher_can_be_shot == 0 && var1 >= 20) {
        self.ignoreme = 0;
        level.ambusher_can_be_shot = 1;
        var9 = level.allymarines["all"];

        foreach(var11 in var9) {
          var11 clearentitytarget();
          waitframe();
          var11.favoriteenemy = self;
          var11 getenemyinfo(self);
        }
      }
    }
  }

  thread civ_ambusher_autokill();
}

function civ_ambusher_autokill() {
  var0 = scripts\engine\utility::getStruct("civ_ambusher_autokill", "targetname").origin;
  var1 = level.civ_ambusher gettagorigin("j_spinelower");
  var2 = level.civ_ambusher gettagorigin("j_spineupper");
  var3 = level.civ_ambusher gettagorigin("j_head");
  var4 = var0 - var3;
  var5 = var4 / 7;
  var0 -= var5;
  magicbullet("iw8_ar_akilo47", var0, var1);
  wait 0.1;
  magicbullet("iw8_ar_akilo47", var0, var2);
  wait 0.1;
  magicbullet("iw8_ar_akilo47", var0, var3);
}

function civ_ambusher_move_fake_target() {
  level.civ_ambusher_target waittill("death");
  var0 = 1;
  self moveTo(level.player getEye(), var0, 0.1, 0.1);
  level.civ_ambusher scripts\engine\utility::ent_flag_set("civ_ambusher_target_player");
}

function player_runby_monitor() {
  level endon("civ_ambusher_dead");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("flag_civ_ambush_ambusher_allow_kill");

  if(level.ambusher_can_be_shot == 0) {
    self.ignoreme = 0;
    level.ambusher_can_be_shot = 1;
    var0 = level.allymarines["all"];

    foreach(var2 in var0) {
      var2 clearentitytarget();
      waitframe();
      var2.favoriteenemy = self;
      var2 getenemyinfo(self);
    }

    return;
  }
}

function civ_ambusher_gun_manager() {
  self waittill("waittime", var0);
  self.gun = getEnt("civ_ambusher_gun", "targetname");
  self.gun linkTo(level.civ_ambusher, "j_gun");
  wait var0 * 0.35;

  if(isalive(self)) {
    scripts\sp\maps\marines\marines_vo::vo_civambush_griggs_shoot_dialogue();
  }

  self.gun hide();
  var1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  scripts\anim\shared::forceuseweapon(var1, "primary");
  level waittill("civ_ambusher_dead");

  if(isDefined(self.fake_target)) {
    self.fake_target delete();
  }

  self.gun delete();
}

function civ_ambusher_death_monitor() {
  self waittill("damage");
  thread scripts\sp\maps\marines\marines_utility::autosave();
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

function civ_ambusher_cleanup_monitor() {
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");

  if(isDefined(self)) {
    scripts\common\ai::stop_magic_bullet_shield();
    self delete();
    return;
  }
}

function civ_ambush_compliment_dialogue() {
  scripts\engine\utility::delaythread(0.5, &scripts\sp\maps\marines\marines_vo::vo_civambush_alex_shoot_dialogue);
  var0 = level.civ_ambusher scripts\engine\utility::waittill_any_return("damage", "shoot");

  if(var0 == "damage") {
    wait 0.5;
    thread scripts\sp\maps\marines\marines_vo::vo_civ_ambush_ambusher_killed_dialogue();
    return;
  }

  level.civ_ambusher waittill("damage");
  wait 0.5;
  thread scripts\sp\maps\marines\marines_vo::vo_civ_ambush_ambusher_killed_dialogue();
}

function civ_ambush_allies_push_forward() {
  var0 = getEnt("mg_hall_first_ally_positions", "targetname");

  if(isDefined(var0)) {
    scripts\engine\sp\utility::activate_trigger_with_targetname("mg_hall_first_ally_positions");
    return;
  }
}

function civ_ambusher_player_threat_monitor() {
  self endon("damage");
  thread civ_ambusher_player_ads_monitor();
  thread civ_ambusher_player_whizby_monitor();
  scripts\engine\utility::flag_wait_any("flag_civ_ambush_ads_trigger", "flag_civ_ambush_whizby_trigger");
  scripts\engine\utility::flag_set("flag_civ_ambush_player_threat");
}

function civ_ambusher_player_ads_monitor() {
  self endon("damage");
  var0 = cos(5);
  var1 = squared(450);

  for(;;) {
    var2 = distancesquared(self.origin, level.player.origin) < var1;
    var3 = level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), var0);

    if(var2 && var3) {
      scripts\engine\utility::flag_set("flag_civ_ambush_ads_trigger");
      break;
    }

    waitframe();
  }
}

function civ_ambusher_player_whizby_monitor() {
  self endon("damage");
  var0 = getEnt(self.struct.target, "targetname");
  var1 = squared(450);

  for(;;) {
    var0 waittill("damage");
    var2 = distancesquared(self.origin, level.player.origin) < var1;

    if(var2) {
      scripts\engine\utility::flag_set("flag_civ_ambush_whizby_trigger");
      break;
    }

    waitframe();
  }
}

function containment_civambush() {
  var0 = getEnt("containment_civambush_open_left", "targetname");
  var1 = getEnt("containment_civambush_open_left_glass", "targetname");
  var2 = getEnt("containment_civambush_open_left_clip", "targetname");
  var3 = scripts\engine\utility::getStruct("containment_civambush_open_left_show_ref", "targetname");
  var4 = scripts\engine\utility::getStruct("containment_civambush_open_left_hide_ref", "targetname");
  var5 = getEnt("containment_civambush_closed_left", "targetname");
  var6 = getEnt("containment_civambush_closed_left_glass", "targetname");
  var7 = getEnt("containment_civambush_closed_left_clip", "targetname");
  var8 = scripts\engine\utility::getStruct("containment_civambush_closed_left_show_ref", "targetname");
  var9 = scripts\engine\utility::getStruct("containment_civambush_closed_left_hide_ref", "targetname");
  var10 = getEnt("containment_civambush_open_right", "targetname");
  var11 = getEnt("containment_civambush_open_right_glass", "targetname");
  var12 = getEnt("containment_civambush_open_right_clip", "targetname");
  var13 = scripts\engine\utility::getStruct("containment_civambush_open_right_show_ref", "targetname");
  var14 = scripts\engine\utility::getStruct("containment_civambush_open_right_hide_ref", "targetname");
  var15 = getEnt("containment_civambush_closed_right", "targetname");
  var16 = getEnt("containment_civambush_closed_right_glass", "targetname");
  var17 = getEnt("containment_civambush_closed_right_clip", "targetname");
  var18 = scripts\engine\utility::getStruct("containment_civambush_closed_right_show_ref", "targetname");
  var19 = scripts\engine\utility::getStruct("containment_civambush_closed_right_hide_ref", "targetname");
  var20 = getEntArray("containment_civambush_clips", "script_noteworthy");
  waitframe();
  var1 linkTo(var0);
  var2 linkTo(var0);
  var11 linkTo(var10);
  var12 linkTo(var10);
  var6 linkTo(var5);
  var7 linkTo(var5);
  var16 linkTo(var15);
  var17 linkTo(var15);
  waitframe();
  scripts\engine\utility::flag_wait("flag_containment_civambush");
  var0 moveTo(var4.origin, 0.1);
  var10 moveTo(var14.origin, 0.1);
  var5 moveTo(var8.origin, 0.1);
  var15 moveTo(var18.origin, 0.1);
  wait 0.2;

  foreach(var22 in var20) {
    var22 disconnectPaths();
  }
}

function containment_civambush_teleport() {
  var0 = getEnt("containment_civambush_teleport_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_containment_civambush");
  wait 1;
  var1 = getaiarray("allies");
  var2 = 0;

  foreach(var4 in var1) {
    if(isDefined(var4) && isalive(var4)) {
      if(!var4 istouching(var0)) {
        if(var2 <= 1) {
          var5 = scripts\engine\utility::getStruct("containment_civambush_teleport_destination_" + var2, "targetname");

          if(isDefined(var4) && isalive(var4)) {
            var4 teleport(var5.origin);
            var2++;
          }
        }
      }
    }
  }
}

function civambush_griggs_nag_dialogue() {
  scripts\engine\utility::flag_wait("flag_allies_reach_stair_top");
  wait randomfloatrange(15, 23);

  while(!scripts\engine\utility::flag("flag_civ_ambush_griggs_react_vo")) {
    scripts\sp\maps\marines\marines_vo::vo_civambush_griggs_nag_dialogue();
    wait randomfloatrange(15, 23);
  }
}