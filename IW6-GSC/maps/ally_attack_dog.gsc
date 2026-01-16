/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ally_attack_dog.gsc
*****************************************************/

pip_init() {
  level.pip = level.player newpip();
  level.pip.enable = 0;
}

ally_dog_sniff_mode(var_0) {
  self.sniff_mode = var_0;
}

ally_dog_bark_not_growl(var_0) {
  if(isDefined(var_0) && var_0)
    self.script_bark_not_growl = var_0;
  else
    self.script_bark_not_growl = undefined;
}

init_ally_dog(var_0, var_1, var_2, var_3) {
  common_scripts\utility::flag_init("dog_no_draw_locator");
  common_scripts\utility::flag_init("dog_forever");
  common_scripts\utility::flag_init("pip_lockout");
  common_scripts\utility::flag_init("dog_active_zone");
  common_scripts\utility::flag_init("dog_control_lockout");
  common_scripts\utility::flag_init("dog_injuries_healed");
  var_1.goalradius = 64;
  var_1.goalheight = 128;
  var_1.pathenemyfightdist = 0;
  var_1.pathenemylookahead = 0;
  var_1 setdogattackradius(64);

  if(!isDefined(level.ally_dogs))
    level.ally_dogs = [];

  level.ally_dogs[level.ally_dogs.size] = var_1;
  var_1.ally_dog_guardpoint_radius = 64;

  if(isDefined(var_3))
    var_1.use_pip = var_3;
  else
    var_1.use_pip = 0;

  var_1.pip_active = 0;
  var_1.monitor_pain = 0;
  var_1.ally_owner = var_0;
  var_1.team = var_0.team;
  var_1.ally_current_state = ::ally_dog_guard_owner;
  var_1.ally_new_state = ::ally_dog_guard_owner;
  var_1.meleealwayswin = 1;
  var_1.ignoresuppression = 1;
  var_1.suppressionwait = 0;
  var_1.pitch_changed = 0;
  var_1.active_force_dog_talk = 0;
  var_1.guard_goal_radius = 128;
  var_1.recent_pain_hits = 0;
  var_1 thread dog_manage_damage(var_0);
  level.last_dog_attack = 0;
  var_1.clear_override_node = 0;
  var_1.clear_this_node = undefined;
  var_1.disablebulletwhizbyreaction = 1;
  var_1.nododgemove = 1;
  var_1.dontavoidplayer = 1;
  var_1.return_fail_los = 0;
  var_1.laser_active = 0;
  var_1.dog_marker = common_scripts\utility::spawn_tag_origin();
  var_1 maps\_utility::ent_flag_init("watch_los_to_owner");
  var_1 maps\_utility::ent_flag_set("watch_los_to_owner");
  var_1.curr_interruption = "inactive";

  if(isDefined(var_2) && var_2)
    var_1 thread ally_listen_dog_commands(var_0);

  if(!isDefined(level.ally_dog_guardpoint_radius))
    level.ally_dog_guardpoint_radius = 512;

  if(!isDefined(level.ally_dog_search_radius))
    level.ally_dog_search_radius = 256;

  level.dog_active_zones = [];
  thread handle_dog_hud(1);
  var_1 thread ally_dog_think(var_0);
}

set_dog_arrow(var_0, var_1) {
  if(isDefined(level.aim_arrow)) {
    stopFXOnTag(common_scripts\utility::getfx("target_marker_yellow"), level.aim_arrow, "tag_origin");
    stopFXOnTag(common_scripts\utility::getfx("target_marker_red"), level.aim_arrow, "tag_origin");
    level notify("kill_dog_arrow_wait");
    wait 0.05;
  } else {
    level.aim_arrow = spawn("script_model", var_0);
    level.aim_arrow setModel("tag_origin");
  }

  if(common_scripts\utility::flag("dog_no_draw_locator")) {
    return;
  }
  level.aim_arrow.origin = var_0;

  if(isDefined(var_1)) {
    level.aim_arrow linkto(var_1, "tag_origin", (0, 0, 0), (-90, 0, -90));
    wait 0.05;
    playFXOnTag(common_scripts\utility::getfx("target_marker_red"), level.aim_arrow, "tag_origin");
  } else {
    level.aim_arrow.origin = var_0;
    level.aim_arrow.angles = (-90, 0, -90);
    wait 0.05;
    level notify("outline_enable");
    playFXOnTag(common_scripts\utility::getfx("target_marker_yellow"), level.aim_arrow, "tag_origin");
  }

  level timed_remove_arrow(10, var_1);

  if(isDefined(level.aim_arrow)) {
    level.aim_arrow unlink();
    stopFXOnTag(common_scripts\utility::getfx("target_marker_yellow"), level.aim_arrow, "tag_origin");
    stopFXOnTag(common_scripts\utility::getfx("target_marker_red"), level.aim_arrow, "tag_origin");
  }
}

timed_remove_arrow(var_0, var_1) {
  level notify("kill_dog_arrow_wait");
  level endon("kill_dog_arrow_wait");

  if(isDefined(var_1))
    var_1 waittill("death");
  else
    wait(var_0);
}

ally_listen_dog_commands(var_0) {
  self endon("death");
  nothread_listen_dog_commands(var_0);
  self.ally_current_state = ::ally_dog_attack_free;
  self notify("ally_dog_state_change");
}

nothread_listen_dog_commands(var_0) {
  var_0 endon("death");
  self endon("stop_watching_dog_commands");
  self endon("death");
  var_0 notifyonplayercommand("fired_laser", "+smoke");
  thread watch_guard_me(var_0);
  thread watch_attack(var_0);
  thread watch_laser(var_0);

  for(;;) {
    var_0 waittill("ally_dog_check_new_state");

    if(self.clear_override_node) {
      self.clear_override_node = 0;

      if(isDefined(self.clear_this_node) && isDefined(self.force_dog_look_point) && self.clear_this_node == self.force_dog_look_point)
        self.force_dog_look_point = undefined;
    }

    self.ally_current_state = self.ally_new_state;
    self notify("ally_dog_state_change");
  }
}

watch_guard_me(var_0) {
  var_0 endon("death");
  self endon("stop_watching_dog_commands");
  self endon("death");

  for(;;) {
    var_0 waittill("dog_guard_me");
    self.ally_new_state = ::ally_dog_guard_owner;
    var_0 notify("ally_dog_check_new_state");
    wait 1;
  }
}

watch_laser(var_0) {
  for(;;) {
    var_0 waittill("fired_laser");

    if(!common_scripts\utility::flag("dog_control_lockout")) {
      var_0 notify("dog_attack_command");
      continue;
    }

    level.dog playSound("anml_dog_whine");
    level.player playSound("anml_dog_whine");
  }
}

notify_on_designate(var_0) {
  var_0 endon("cancel_designate");
  var_0 waittill("fired_laser");
  var_0 notify("dog_attack_command");
  var_0 notify("dog_attack_laser");
}

watch_attack(var_0) {
  var_0 endon("death");
  self endon("stop_watching_dog_commands");
  self endon("death");

  for(;;) {
    var_1 = var_0 common_scripts\utility::waittill_any_return("dog_attack", "dog_attack_command", "dog_attack_override");
    var_2 = 0;

    if(var_1 == "dog_attack_override")
      var_2 = 1;
    else if(var_1 == "dog_attack_command" && var_0.dog_hud_visible[0] && !common_scripts\utility::flag("dog_control_lockout"))
      var_2 = 1;
    else if(self.ally_current_state != ::ally_dog_attack_free)
      var_2 = 1;

    if(var_2) {
      setup_colors_for_attack();
      self.ally_new_state = ::ally_dog_attack_free;

      if(isDefined(level.pip_watch_flag))
        common_scripts\utility::flag_set(level.pip_watch_flag);

      level.last_dog_attack = gettime();
      var_0 set_dog_hud_attack();
      var_0 notify("ally_dog_check_new_state");
      wait 1;
    }
  }
}

ally_dog_think(var_0) {
  self endon("death");

  for(;;) {
    dispatch_dog_think(var_0);
    wait 0.1;
  }
}

dispatch_dog_think(var_0) {
  self notify("new_dispatch_dog_think");
  self endon("new_dispatch_dog_think");
  self endon("ally_dog_state_change");
  [[self.ally_current_state]](var_0);
}

set_dog_guard_owner(var_0) {
  self.ally_new_state = ::ally_dog_guard_owner;
  var_0 notify("ally_dog_check_new_state");
  var_0 set_dog_hud_guard();

  if(isDefined(level.pip_watch_flag))
    common_scripts\utility::flag_clear(level.pip_watch_flag);
}

set_dog_follow_owner(var_0) {
  self hudoutlinedisable();
  self.ally_new_state = ::ally_dog_follow_owner;
  var_0 notify("ally_dog_check_new_state");
}

clear_dog_scripted_mode(var_0) {
  if(!isDefined(var_0.controlled_dog))
    var_0 maps\_dog_control::enable_dog_control(level.dog);
}

disable_control() {
  self notify("disable_dog_control");
  self.controlled_dog = undefined;
  self enableoffhandweapons();
  setdvar("ui_dog_grenade", 0);
}

set_dog_scripted_mode(var_0) {
  var_0 disable_control();
}

dog_using_colors() {
  return isDefined(self.script_forcecolor) || isDefined(self.script_old_forcecolor);
}

setup_colors_for_attack() {
  var_0 = dog_using_colors();

  if(var_0 && isDefined(self.script_forcecolor)) {
    self.script_old_forcecolor = self.script_forcecolor;
    maps\_utility::disable_ai_color();
  }

  return var_0;
}

reset_colors_start_guard() {
  var_0 = dog_using_colors();

  if(var_0 && isDefined(self.script_old_forcecolor)) {
    maps\_utility::enable_ai_color();
    self.script_old_forcecolor = undefined;
    self.old_path = undefined;
  }

  return var_0;
}

watch_color_change_on_guard(var_0) {
  self notify("end_watch_color_guard");
  self endon("end_watch_color_guard");
  self waittill("done_setting_new_color");
  set_dog_guard_owner(var_0);
}

ally_dog_scripted(var_0) {
  self.goalradius = 64;
  self hudoutlinedisable();
  self waittill("dog_scripted_end");
  set_dog_guard_owner(var_0);
}

check_pain_lockout() {
  self.monitor_pain = 0;
  self.recent_pain_hits = 0;
}

vector2d(var_0) {
  return (var_0[0], var_0[1], 0);
}

ally_dog_follow_owner(var_0) {
  ally_dog_follow_owner_internal(var_0, 0);
}

ally_dog_guard_owner(var_0) {
  ally_dog_follow_owner_internal(var_0, 1);
}

ally_dog_follow_owner_internal(var_0, var_1) {
  self.pushable = 1;
  self.script_pushable = 1;

  if(reset_colors_start_guard()) {
    while(isDefined(self.script_forcecolor)) {
      self hudoutlinedisable();
      thread check_pain_lockout();
      self waittill("stop_color_move");
    }
  }

  childthread watch_color_change_on_guard(var_0);
  self clearenemy();
  self hudoutlinedisable();

  if(var_1)
    thread check_pain_lockout();

  var_2 = 128;
  var_3 = var_2 * var_2;
  var_4 = 50;
  var_5 = var_4 * var_4;
  var_6 = 900;
  var_7 = 160000;
  var_8 = var_0.origin;
  var_9 = var_8;
  self.last_follow_node = undefined;

  for(;;) {
    self.pushable = 1;
    self.script_pushable = 1;
    self.goalradius = var_2;

    if(var_1 && _dog_guard(var_0)) {
      common_scripts\utility::waitframe();
      continue;
    }

    var_8 = var_9;
    var_9 = var_0.origin;

    if(_dog_too_close_to_owner(var_0, var_3)) {
      self.pushable = 1;
      self.script_pushable = 1;
      common_scripts\utility::waitframe();
      continue;
    }

    if(isplayer(var_0))
      var_10 = vectornormalize(vector2d(var_0 getvelocity()));
    else
      var_10 = vectornormalize(vector2d(var_9 - var_8));

    var_11 = getnodesinradiussorted(var_0.origin, var_2, var_4, 64, "Path");

    if(var_11.size == 0) {
      common_scripts\utility::waitframe();
      continue;
    }

    if(var_1)
      var_12 = _pick_best_node_heeled_by_owner(var_11, var_0, var_10);
    else
      var_12 = _pick_best_node_behind_owner(var_11, var_0, var_10);

    var_13 = var_12["best"];
    var_14 = var_12["best_dist_to_node_sq"];

    if(isDefined(self.last_follow_node) && var_13 == self.last_follow_node) {
      common_scripts\utility::waitframe();
      continue;
    }

    if(var_14 < var_6) {
      common_scripts\utility::waitframe();
      continue;
    }

    var_15 = bulletTrace(var_0.origin + (0, 0, 30), var_13.origin + (0, 0, 30), 0, var_0);

    if(var_15["fraction"] != 1) {
      var_16 = getclosestnodeinsight(var_0.origin);

      if(isDefined(var_16)) {
        var_11 = getlinkednodes(var_16);
        var_11[var_11.size] = var_16;
        var_11 = _remove_nodes_too_close(var_11, var_0.origin, var_5);
        var_12 = _pick_best_node_behind_owner(var_11, var_0, var_10);
        var_13 = var_12["best"];
        var_14 = var_12["best_dist_to_node_sq"];
      }
    }

    if(var_14 > var_7)
      maps\_utility_dogs::disable_dog_walk();
    else
      maps\_utility_dogs::enable_dog_walk(1);

    self.last_follow_node = var_13;
    self setgoalnode(var_13);
    common_scripts\utility::waittill_notify_or_timeout("goal", 3);
    common_scripts\utility::waitframe();
  }
}

_dog_too_close_to_owner(var_0, var_1) {
  var_2 = distance2dsquared(self.origin, var_0.origin);
  return var_2 <= var_1;
}

_pick_best_node_behind_owner(var_0, var_1, var_2) {
  var_3 = -0.342;
  var_4 = [];
  var_4["best"] = var_0[0];
  var_4["best_dist_to_node_sq"] = distance2dsquared(self.origin, var_0[0].origin);

  foreach(var_6 in var_0) {
    var_7 = vectornormalize(vector2d(var_6.origin - var_1.origin));
    var_8 = vectordot(var_2, var_7);

    if(var_8 > var_3) {
      continue;
    }
    var_9 = distance2dsquared(self.origin, var_6.origin);

    if(var_4["best_dist_to_node_sq"] == -1 || var_9 < var_4["best_dist_to_node_sq"]) {
      var_4["best"] = var_6;
      var_4["best_dist_to_node_sq"] = var_9;
    }
  }

  return var_4;
}

_pick_best_node_heeled_by_owner(var_0, var_1, var_2) {
  var_3 = 0.94;
  var_4 = 0.766;
  var_5 = 0.342;
  var_6 = 0;
  var_7 = [];
  var_7["best"] = undefined;
  var_7["best_dist_to_node_sq"] = -1;
  var_8 = [];
  var_9 = [];

  foreach(var_11 in var_0) {
    var_12 = vectornormalize(vector2d(var_11.origin - var_1.origin));
    var_13 = vectordot(var_2, var_12);

    if(var_13 > var_3 || var_13 < var_4) {
      if(var_13 < var_3 && var_13 > var_5) {
        var_8[var_8.size] = var_11;
        continue;
      }

      if(var_13 < var_3 && var_13 > var_6) {
        var_9[var_9.size] = var_11;
        continue;
      }
    } else {
      var_14 = distance2dsquared(self.origin, var_11.origin);

      if(var_7["best_dist_to_node_sq"] == -1 || var_14 < var_7["best_dist_to_node_sq"]) {
        var_7["best"] = var_11;
        var_7["best_dist_to_node_sq"] = var_14;
      }
    }
  }

  if(!isDefined(var_7["best"]) && var_8.size > 0) {
    foreach(var_11 in var_8) {
      var_14 = distance2dsquared(self.origin, var_11.origin);

      if(var_7["best_dist_to_node_sq"] == -1 || var_14 < var_7["best_dist_to_node_sq"]) {
        var_7["best"] = var_11;
        var_7["best_dist_to_node_sq"] = var_14;
      }
    }
  }

  if(!isDefined(var_7["best"]) && var_9.size > 0) {
    foreach(var_11 in var_9) {
      var_14 = distance2dsquared(self.origin, var_11.origin);

      if(var_7["best_dist_to_node_sq"] == -1 || var_14 < var_7["best_dist_to_node_sq"]) {
        var_7["best"] = var_11;
        var_7["best_dist_to_node_sq"] = var_14;
      }
    }
  }

  if(!isDefined(var_7["best"]))
    var_7 = _pick_best_node_behind_owner(var_0, var_1, var_2);

  return var_7;
}

_remove_nodes_too_close(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    var_6 = distance2dsquared(var_5.origin, var_1);

    if(var_6 > var_2)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

_dog_guard(var_0) {
  var_1 = get_dog_enemies(var_0);
  var_2 = undefined;
  var_3 = common_scripts\utility::get_array_of_closest(var_0.origin, var_1, undefined, undefined, 1024);
  var_4 = undefined;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "good_dog_target") {
      var_4 = var_6;
      break;
    }
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_7 = length(var_6.origin - var_0.origin);
    var_8 = isDefined(var_6.enemy) && var_6.enemy == var_0 && var_7 < 600;
    var_9 = isDefined(var_6.enemy) && var_6.enemy == var_0 && var_7 < 400;
    var_10 = var_6.a.special == "dying_crawl";
    var_11 = isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "good_dog_target";

    if(var_9 || var_10 || var_8 || var_11) {
      if(var_7 < 250 || check_enemy_clump(var_0, var_6)) {
        if(isDefined(var_4) && var_4 != var_6) {
          var_12 = length(var_4.origin - var_0.origin);

          if(var_7 > 250 && var_7 / var_12 > 0.7)
            var_6 = var_12;
        }

        var_2 = var_6;

        if(var_2.a.special == "dying_crawl")
          self.goalradius = 75;
        else
          self.goalradius = 64;

        break;
      }
    }
  }

  if(!isDefined(var_2)) {
    var_3 = maps\_utility::get_within_range(self.origin, var_1, 300);

    if(var_3.size > 0) {
      var_2 = var_3[0];

      if(var_2.a.special == "dying_crawl")
        self.goalradius = 75;
      else
        self.goalradius = 64;
    }
  }

  if(isDefined(var_2)) {
    self.ignoreall = 0;
    maps\_utility_dogs::disable_dog_walk();
    self setgoalentity(var_2);
    var_2 notify("dog_has_ai_as_goal");
    monitor_dog_enemy(var_2);
    return 1;
  }

  return 0;
}

check_enemy_clump(var_0, var_1) {
  var_2 = get_dog_enemies(var_0);
  var_3 = maps\_utility::get_within_range(var_1.origin, var_2, 350);

  if(var_3.size >= 3)
    return 0;

  return 1;
}

get_best_dog_target(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = level.player;

  if(!isDefined(var_3))
    var_3 = -1;

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_4 = var_1 getEye();

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = -1;
  var_9 = 2;

  foreach(var_11 in var_0) {
    if(isDefined(var_11.no_dog_target) && var_11.no_dog_target) {
      continue;
    }
    var_12 = length(var_11.origin - var_4);

    if(var_12 > 1500) {
      continue;
    }
    var_12 = var_12 / 100;
    var_13 = vectortoangles(var_11.origin - var_4);
    var_14 = anglesToForward(var_13);
    var_15 = vectordot(var_7, var_14);

    if(var_15 < var_3) {
      continue;
    }
    var_15 = var_15 - 0.8;
    var_15 = var_15 * 100;
    var_15 = var_15 * var_15;
    var_16 = (15 - var_12) * var_9 * var_15 + var_15 * 100;

    if(var_16 < var_8) {
      continue;
    }
    var_8 = var_16;
    var_5 = var_11;
  }

  return var_5;
}

dog_debug_goto() {}

ally_dog_attack_free(var_0) {
  var_1 = undefined;
  self endon("new_attack_started");
  maps\_utility_dogs::disable_dog_walk();
  var_2 = 0;
  var_3 = 1;

  if(isDefined(level.override_dog_enemy)) {
    var_2 = 1;
    var_1 = level.override_dog_enemy;
    level.override_dog_enemy = undefined;
    var_3 = 0;
  }

  if(!isDefined(var_1)) {
    var_4 = getaiarray("axis");
    var_1 = get_best_dog_target(var_4, level.player, 1, 0.95);
  }

  if(!isDefined(var_1)) {
    set_dog_guard_owner(var_0);
    wait 4;
    return;
  }

  if(!var_2)
    self.monitor_pain = 1;

  var_1 notify("dog_has_ai_as_goal");
  childthread check_start_attack(var_1);
  self.goalradius = 64;
  self setgoalentity(var_1);

  if(var_3)
    level thread hud_outlineenable(var_1, self);

  if(isDefined(var_1.ignoreme) && var_1.ignoreme)
    var_1 maps\_utility::set_ignoreme(0);

  self playSound("anml_dog_bark");
  maps\_utility::disable_pain();
  maps\_utility::delaythread(2, maps\_utility::enable_pain);
  monitor_dog_enemy(var_1);
  set_dog_guard_owner(var_0);
}

monitor_dog_enemy(var_0) {
  var_1 = var_0.origin;
  var_2 = gettime();

  while(isalive(var_0) && self.recent_pain_hits < 2) {
    var_3 = gettime() - var_2;
    wait 0.2;
  }

  var_3 = (gettime() - var_2) / 1000;

  if(self.recent_pain_hits >= 2) {
    level notify("outline_enable");
    set_dog_guard_owner(self.ally_owner);
    level.player playSound("anml_dog_whine");
  }
}

volume_holding_state(var_0) {
  common_scripts\utility::flag_wait("dog_forever");
}

get_dog_enemies(var_0) {
  var_1 = getaiarray("axis");
  return var_1;
}

get_owner_pointing_info(var_0, var_1, var_2) {
  var_3 = 1536;
  var_4 = var_0 getEye();
  var_5 = var_0 getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = var_4 + var_6 * (var_3 + 128);
  var_8 = bulletTrace(var_4, var_7, 1, var_0);
  var_9 = undefined;
  var_10 = var_8["position"];

  if(lengthsquared(var_4 - var_10) > var_3 * var_3) {
    var_8["entity"] = undefined;
    return var_8;
  }

  var_11 = check_against_active_zones(var_4, var_10);

  if(isDefined(var_11))
    return undefined;

  if(var_1) {
    var_12 = getnodesinradiussorted(var_10, 128, 0, 72);

    if(var_12.size > 0) {
      var_8["node"] = var_12[0];
      var_13 = var_12[0].origin;
    }
  }

  if(var_2) {
    if(isDefined(var_8["entity"])) {
      var_9 = var_8["entity"];

      if(issentient(var_9) && isenemyteam(var_9.team, self.team))
        var_8["enemy"] = var_9;
    } else {
      var_14 = get_enemy_from_active_zone(var_4, var_10);

      if(isDefined(var_14))
        var_8["enemy"] = var_14;
      else {
        var_15 = get_dog_enemies(var_0);
        var_14 = maps\_utility::get_closest_living(var_10, var_15, 256);

        if(isDefined(var_14))
          var_8["enemy"] = var_14;
      }
    }

    if(isDefined(var_8["enemy"])) {
      var_14 = var_8["enemy"];
      var_13 = var_14.origin;
    }
  }

  return var_8;
}

dog_force_talk(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(self.active_force_dog_talk == 1) {
    if(!var_2) {
      return;
    }
    self waittill("force_dog_talk_continue");

    if(self.active_force_dog_talk == 1)
      return;
  }

  if(!isDefined(var_1))
    var_1 = "anml_dog_bark";

  self.active_force_dog_talk = 1;
  self waittill("force_dog_talk");
  self.active_force_dog_talk = 0;
  self notify("force_dog_talk_continue");
}

lock_player_control_until_flag(var_0) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  if(!isDefined(level.dog_lock_check))
    level.dog_lock_check = 0;

  level.dog_lock_check++;
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  level.dog_lock_flag = var_0;
  self.ally_owner.dog_hud_active[0] = 0;
  level.player notify("cancel_designate");
  common_scripts\utility::flag_wait(var_0);
  level.dog_lock_flag = undefined;
  level.dog_lock_check--;

  if(level.dog_lock_check == 0)
    unlock_player_control();

  self.ally_owner.dog_hud_active[0] = 1;
}

lock_player_control(var_0) {
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  return;
}

unlock_player_control() {
  clear_dog_scripted_mode(level.player);
  level.dog maps\_utility::ent_flag_clear("pause_dog_command");
}

watch_active_zones(var_0, var_1) {
  self endon("death");
  level.dog_active_zones = getEntArray(var_1, "targetname");
  level.dog_tag_origin = common_scripts\utility::spawn_tag_origin();
  level.dog_active_touch_zones = [];
  level.dog_active_aim_zones = [];

  foreach(var_3 in level.dog_active_zones) {
    var_3.dogs_touching = [];

    if(!isDefined(var_3.script_parameters)) {
      level.dog_active_touch_zones[level.dog_active_touch_zones.size] = var_3;
      level.dog_active_aim_zones[level.dog_active_aim_zones.size] = var_3;
      continue;
    }

    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "dog_touch") {
      level.dog_active_touch_zones[level.dog_active_touch_zones.size] = var_3;
      continue;
    }

    if(isDefined(var_3.script_parameters) && issubstr(var_3.script_parameters, "dog_aim"))
      level.dog_active_aim_zones[level.dog_active_aim_zones.size] = var_3;
  }

  for(;;) {
    foreach(var_3 in level.dog_active_touch_zones) {
      if(check_zone_flags(var_3) && !check_already_touching(var_3)) {
        if(self istouching(var_3)) {
          add_to_zone(var_3);
          self notify("touched_zone", var_3);
          self notify("activated_zone", var_3);
          level.dog_active_aim_zones = common_scripts\utility::array_remove(level.dog_active_aim_zones, var_3);
          level.dog_active_touch_zones = common_scripts\utility::array_remove(level.dog_active_touch_zones, var_3);
          level.dog_active_zones = common_scripts\utility::array_remove(level.dog_active_zones, var_3);
          thread dispatch_activated_zone(var_3);
          continue;
        }

        if(remove_if_touching(var_3))
          self notify("left_zone", var_3);
      }
    }

    wait 0.25;
  }
}

check_zone_flags(var_0) {
  if(isDefined(var_0.script_flag_false)) {
    var_1 = strtok(var_0.script_flag_false, " ");

    foreach(var_3 in var_1) {
      if(common_scripts\utility::flag(var_3))
        return 0;
    }
  }

  if(isDefined(var_0.script_flag_true)) {
    var_1 = strtok(var_0.script_flag_true, " ");

    foreach(var_3 in var_1) {
      if(!common_scripts\utility::flag(var_3))
        return 0;
    }
  }

  return 1;
}

add_to_zone(var_0) {
  var_0.dogs_touching[var_0.dogs_touching.size] = self;
}

remove_if_touching(var_0) {
  foreach(var_2 in var_0.dogs_touching) {
    if(var_2 == self) {
      var_0.dogs_touching = common_scripts\utility::array_remove(var_0.dogs_touching, self);
      return 1;
    }
  }

  return 0;
}

check_already_touching(var_0) {
  foreach(var_2 in var_0.dogs_touching) {
    if(var_2 == self)
      return 1;
  }

  return 0;
}

cleanup_zone_arrays(var_0) {
  remove_if_touching(var_0);
}

dispatch_activated_zone(var_0) {
  dispatch_activated_zone_thread(var_0);
  cleanup_zone_arrays(var_0);
}

dispatch_activated_zone_thread(var_0) {
  var_1 = var_0.script_noteworthy;

  if(!isDefined(var_1)) {
    return;
  }
  self notify("activated_new_zone");
  self endon("activated_new_zone");
  var_2 = var_0.target;
  var_3 = getnode(var_2, "targetname");
  self.last_zone = var_0;
  self.sniff_mode = 0;

  switch (var_1) {
    case "dog_point_sniff":
      self.sniff_mode = 1;
    case "dog_point":
      level.dog_guard_override = var_3;
      self.ally_owner notify("dog_guard_owner_pointing");
      self.curr_interruption = "make_active";
      wait 0.1;
      self.clear_override_node = 1;
      self.clear_this_node = var_3;
      self waittill("forever");
      break;
    case "dog_path_sniff":
      self.sniff_mode = 1;
    case "dog_path":
      self.ally_new_state = ::volume_holding_state;
      self.ally_owner notify("ally_dog_check_new_state");
      self.curr_interruption = "make_active";
      thread maps\_spawner::go_to_node(var_3);
      self waittill("reached_path_end");
      self notify("finished_dog_path");
      self waittill("forever");
      break;
  }
}

check_against_active_zones(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(level.dog_active_touch_zones))
    return var_2;

  level.dog_tag_origin.origin = var_1;

  foreach(var_4 in level.dog_active_aim_zones) {
    if(check_zone_flags(var_4) && !check_already_touching(var_4)) {
      if(level.dog_tag_origin istouching(var_4)) {
        var_2 = var_4;
        break;
      }

      var_5 = var_4 getcentroid();
      var_6 = pointonsegmentnearesttopoint(var_0, var_1, var_5);
      level.dog_tag_origin.origin = var_6;

      if(level.dog_tag_origin istouching(var_4)) {
        var_2 = var_4;
        break;
      }
    }
  }

  if(isDefined(var_2)) {
    if(isDefined(var_2.script_flag_set))
      common_scripts\utility::flag_set(var_2.script_flag_set);

    level.dog_active_aim_zones = common_scripts\utility::array_remove(level.dog_active_aim_zones, var_2);
    level.dog_active_touch_zones = common_scripts\utility::array_remove(level.dog_active_touch_zones, var_2);
    level.dog_active_zones = common_scripts\utility::array_remove(level.dog_active_zones, var_2);
    add_to_zone(var_2);
    self notify("aimed_zone", var_2);
    self notify("activated_zone", var_2);
    thread dispatch_activated_zone(var_2);
    var_8 = undefined;

    if(isDefined(var_2.script_linkto))
      var_8 = common_scripts\utility::getstruct(var_2.script_linkto, "script_linkname");
    else if(isDefined(var_2.target))
      var_8 = var_2 common_scripts\utility::get_target_ent();

    if(isDefined(var_8))
      thread set_dog_arrow(var_8.origin);
  }

  return var_2;
}

get_enemy_from_active_zone(var_0, var_1) {
  var_2 = undefined;
  var_3 = check_against_active_zones(var_0, var_1);

  if(isDefined(var_3)) {
    var_4 = var_3 maps\_utility::get_ai_touching_volume("axis");
    var_2 = common_scripts\utility::getclosest(var_1, var_4);
  }

  return var_2;
}

handle_dog_hud(var_0) {
  level.player endon("death");
  level notify("stop_dog_hud");
  level endon("stop_dog_hud");
  level.player.dog_hud_visible = [];
  level.player.dog_hud_active = [];
  level.player.dog_hud_visible[0] = 0;
  level.player.dog_hud_visible[1] = 0;
  level.player.dog_hud_active[0] = 0;
  level.player.dog_hud_active[1] = 0;

  if(var_0) {
    level.player.dog_hud_visible[1] = 1;
    level.player.dog_hud_visible[0] = 1;
  }
}

set_dog_hud_guard() {
  set_dog_hud_attack();
}

set_dog_hud_attack() {}

set_dog_hud_disabled() {}

set_dog_hud_enabled() {
  level.player.dog_hud_visible[0] = 1;
  level.player.dog_hud_visible[1] = 1;
  set_dog_hud_guard();
  refreshhudammocounter();
}

set_dog_hud_for_intro() {
  set_dog_hud_for_intro_loop();
}

set_dog_hud_for_intro_loop() {
  level.player endon("dog_attack");
  level.player endon("dog_command_attack");
  level.player endon("cancel_dog_hud");
  level.player.dog_hud_visible[0] = 1;
  level.player.dog_hud_active[0] = 0;
  level.player.dog_hud_active[1] = 0;
  var_0 = 0;
}

set_dog_hud_for_guard() {}

set_dog_hud_for_guard_loop() {}

debug_cross(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 10;

  if(!isDefined(var_2))
    var_2 = (1, 1, 1);
}

dog_manage_damage(var_0) {
  self.damage_level = 0;
  self.last_damage_time = gettime();

  for(;;) {
    self waittill("pain");

    if(self.monitor_pain)
      self.recent_pain_hits++;

    wait 1;
  }
}

dog_damage_reduction() {
  for(;;) {
    wait 1;

    if(self.damage_level > 0) {
      if(self.last_damage_time + 10000 < gettime()) {
        self.damage_level--;
        self.last_damage_time = gettime() - 6000;
      }
    }
  }
}

hud_outlineenable(var_0, var_1) {
  var_0 hud_outlineenable_static(var_0, var_1);

  if(isalive(var_0))
    var_0 hudoutlinedisable();
}

hud_outlineenable_static(var_0, var_1) {
  level notify("kill_dog_arrow_wait");
  level notify("outline_enable");
  level endon("outline_enable");
  wait 0.05;
  var_0 maps\_utility::set_hudoutline("enemy", 0);
  var_1 maps\_utility::set_hudoutline("friendly", 0);
  level thread hudoutline_wait_death(var_0, var_1);
  var_0 endon("death");
  var_0 waittill("dog_attacks_ai");
  var_1 maps\_utility::disable_pain();
  var_1.monitor_pain = 0;
  var_1 maps\_utility::delaythread(6, maps\_utility::enable_pain);
  wait 5;

  if(isDefined(var_0)) {
    var_0.no_more_outlines = 1;
    var_0 hudoutlinedisable();
  }
}

hudoutline_wait_death(var_0, var_1) {
  level endon("outline_enable");
  var_0 waittill("death");
  wait 2.5;

  if(isDefined(var_0)) {
    var_0.no_more_outlines = 1;
    var_0 hudoutlinedisable();
  }

  var_2 = getcorpsearray();

  foreach(var_4 in var_2)
  var_4 hudoutlinedisable();
}

check_start_attack(var_0) {
  var_0 endon("death");
  var_1 = 128;
  var_2 = 0.423;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, self.origin, var_2)) {
    var_3 = var_1 * var_1;
    var_4 = _get_guard_node_behind_player(var_1);

    if(isDefined(var_4) && lengthsquared(var_4.origin - level.player.origin) <= var_3) {
      if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_4.origin + (0, 0, 60), var_2))
        self forceteleport(var_4.origin, level.player.angles);
    }
  }

  var_5 = 65536;

  for(;;) {
    wait 0.05;

    if(length2dsquared(self.origin - var_0.origin) < var_5) {
      break;
    }
  }
}

_get_guard_node_behind_player(var_0) {
  var_1 = 40;
  var_2 = vectornormalize(vector2d(level.player getvelocity()));
  var_3 = length(var_2);

  if(var_3 == 0)
    var_2 = vectornormalize(anglesToForward(level.player.angles));

  var_4 = getnodesinradiussorted(level.player.origin, var_0, var_1, 64, "Path");

  if(var_4.size == 0) {
    return;
  }
  var_5 = _pick_best_node_behind_owner(var_4, level.player, var_2);
  return var_5["best"];
}

dog_disable_ai_color() {
  self.script_old_forcecolor = undefined;
  maps\_utility::disable_ai_color();
}

dog_enable_ai_color() {
  maps\_utility::enable_ai_color();
}