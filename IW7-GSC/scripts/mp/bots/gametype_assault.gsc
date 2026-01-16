/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_assault.gsc
************************************************/

main() {
  setup_callbacks();
  bot_sd_start();
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_sd_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_sd;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;
}

bot_sd_start() {
  setup_bot_sd();
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return 0;
  }

  if(!scripts\mp\utility::isteamparticipant(self)) {
    return 1;
  }

  if(!isDefined(self.role)) {
    return 0;
  }

  switch (self.role) {
    case "investigate_someone_using_bomb":
    case "bomb_defuser":
    case "atk_bomber":
      return 0;
  }

  return 1;
}

setup_bot_sd() {
  level.bots_disable_team_switching = 1;
  level.initial_pickup_wait_time = 3000;
  scripts\mp\bots\_bots_strategy::bot_setup_bombzone_bottargets();
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled(1);
  level.bot_sd_override_zone_targets = [];
  level.bot_sd_override_zone_targets["axis"] = [];
  level.bot_sd_override_zone_targets["allies"] = [];
  level.bot_default_sd_role_behavior["atk_bomber"] = ::atk_bomber_update;
  level.bot_default_sd_role_behavior["clear_target_zone"] = ::clear_target_zone_update;
  level.bot_default_sd_role_behavior["defend_planted_bomb"] = ::defend_planted_bomb_update;
  level.bot_default_sd_role_behavior["bomb_defuser"] = ::bomb_defuser_update;
  level.bot_default_sd_role_behavior["investigate_someone_using_bomb"] = ::investigate_someone_using_bomb_update;
  level.bot_default_sd_role_behavior["camp_bomb"] = ::camp_bomb_update;
  level.bot_default_sd_role_behavior["defender"] = ::defender_update;
  level.bot_default_sd_role_behavior["backstabber"] = ::backstabber_update;
  level.bot_default_sd_role_behavior["random_killer"] = ::random_killer_update;
  var_0 = 0;
  botzonesetteam(level.curbombzone, game["defenders"]);
}

bot_sd_think() {
  self notify("bot_sd_think");
  self endon("bot_sd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  var_0 = game["attackers"];
  var_1 = 1;
  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && level.sdbomb.carrier == self && isDefined(self.role) && self.role == "atk_bomber") {
    var_1 = 0;
  }

  if(var_1) {
    self.role = undefined;
  }

  self.suspend_sd_role = undefined;
  self.has_started_thinking = 0;
  self.atk_bomber_no_path_to_bomb_count = 0;
  self.scripted_path_style = undefined;
  self.defender_set_script_pathstyle = undefined;
  self.defuser_bad_path_counter = 0;
  if(!isDefined(level.initial_bomb_location) && !level.multibomb) {
    level.initial_bomb_location = level.sdbomb.curorigin;
    level.initial_bomb_location_nearest_node = getclosestnodeinsight(level.sdbomb.curorigin);
  }

  if(self.team == var_0 && !isDefined(level.can_pickup_bomb_time)) {
    var_2 = 0;
    if(!level.multibomb) {
      var_3 = get_living_players_on_team(var_0);
      foreach(var_5 in var_3) {
        if(!isai(var_5)) {
          var_2 = 1;
        }
      }
    }

    if(var_2) {
      var_7 = 6000;
      level.can_pickup_bomb_time = gettime() + var_7;
      badplace_cylinder("bomb", var_7 / 1000, level.sdbomb.curorigin, 75, 300, var_0);
    }
  }

  for(;;) {
    wait(randomintrange(1, 3) * 0.05);
    if(self.health <= 0) {
      continue;
    }

    self.has_started_thinking = 1;
    if(!isDefined(self.role)) {
      initialize_sd_role();
    }

    if(isDefined(self.suspend_sd_role)) {
      continue;
    }

    if(self.team == var_0) {
      if(!level.multibomb && isDefined(level.can_pickup_bomb_time) && gettime() < level.can_pickup_bomb_time && !isDefined(level.sdbomb.carrier)) {
        if(!scripts\mp\bots\_bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
          var_8 = getclosestnodeinsight(level.sdbomb.curorigin);
          if(isDefined(var_8)) {
            var_9["nearest_node_to_center"] = var_8;
            scripts\mp\bots\_bots_strategy::bot_protect_point(level.sdbomb.curorigin, 900, var_9);
          } else {
            level.can_pickup_bomb_time = gettime();
          }
        }
      } else {
        self[[level.bot_default_sd_role_behavior[self.role]]]();
      }

      continue;
    }

    if(level.bombplanted) {
      if(distancesquared(self.origin, level.sdbombmodel.origin) > squared(level.protect_radius * 2)) {
        if(!isDefined(self.defender_set_script_pathstyle)) {
          self.defender_set_script_pathstyle = 1;
          self getpathactionvalue("scripted");
        }
      } else if(isDefined(self.defender_set_script_pathstyle) && !isDefined(self.scripted_path_style)) {
        self.defender_set_script_pathstyle = undefined;
        self getpathactionvalue(undefined);
      }
    }

    if(level.bombplanted && isDefined(level.bomb_defuser) && self.role != "bomb_defuser") {
      if(!scripts\mp\bots\_bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
        self botclearscriptgoal();
        scripts\mp\bots\_bots_strategy::bot_protect_point(level.sdbombmodel.origin, level.protect_radius);
      }

      continue;
    }

    self[[level.bot_default_sd_role_behavior[self.role]]]();
  }
}

atk_bomber_update() {
  self endon("new_role");
  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && isalive(level.sdbomb.carrier) && level.sdbomb.carrier != self) {
    wait(0.7);
  }

  if(!self.isbombcarrier && !level.multibomb) {
    if(isDefined(level.sdbomb)) {
      if(!isDefined(self.last_bomb_location)) {
        self.last_bomb_location = level.sdbomb.curorigin;
      }

      if(distancesquared(self.last_bomb_location, level.sdbomb.curorigin) > 4) {
        self botclearscriptgoal();
        self.last_bomb_location = level.sdbomb.curorigin;
      }
    }

    if(self.atk_bomber_no_path_to_bomb_count >= 2) {
      var_1 = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);
      var_2 = undefined;
      foreach(var_4 in var_1) {
        if(!var_4 getweaponbarsize()) {
          var_2 = var_4;
          break;
        }
      }

      if(isDefined(var_2)) {
        self botsetscriptgoal(var_2.origin, 20, "critical");
        scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
        if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
          level.sdbomb scripts\mp\gameobjects::setpickedup(self);
        }
      }

      return;
    }

    if(!self bothasscriptgoal()) {
      var_6 = 15;
      var_7 = 32;
      var_8 = scripts\mp\bots\_bots_util::bot_queued_process("BotGetClosestNavigablePoint", scripts\mp\bots\_bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var_6 + var_7, self);
      if(isDefined(var_8)) {
        var_9 = self botsetscriptgoal(level.sdbomb.curorigin, 0, "critical");
        if(var_9) {
          childthread bomber_monitor_no_path();
          return;
        }

        return;
      }

      var_1 = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);
      if(var_8.size > 0) {
        self botsetscriptgoal(var_8[0].origin, 0, "critical");
        scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
      }

      if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
        var_7 = scripts\mp\bots\_bots_util::bot_queued_process("BotGetClosestNavigablePoint", scripts\mp\bots\_bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var_5 + var_6, self);
        if(!isDefined(var_7)) {
          level.sdbomb scripts\mp\gameobjects::setpickedup(self);
          return;
        }

        return;
      }

      return;
    }

    return;
  }

  if(isDefined(self.dont_plant_until_time) && gettime() < self.dont_plant_until_time) {
    return;
  }

  if(!isDefined(level.bomb_zone_assaulting)) {
    level.bomb_zone_assaulting = level.curbombzone;
  }

  var_10 = level.bomb_zone_assaulting;
  self.bombzonegoal = var_10;
  if(!isDefined(level.initial_bomb_pickup_time) || gettime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time) {
    level.initial_bomb_pickup_time = gettime() + level.initial_pickup_wait_time;
    self botclearscriptgoal();
    self botsetscriptgoal(self.origin, 0, "tactical");
    wait(level.initial_pickup_wait_time / 1000);
  }

  self botclearscriptgoal();
  if(level.attack_behavior == "rush") {
    self getpathactionvalue("scripted");
    var_11 = self getparent(var_10.bottargets, "node_exposed");
    var_12 = self botgetdifficultysetting("strategyLevel") * 0.45;
    var_13 = self botgetdifficultysetting("strategyLevel") + 1 * 0.15;
    foreach(var_14 in var_10.bottargets) {
      if(!scripts\engine\utility::array_contains(var_10, var_14)) {
        var_10[var_10.size] = var_14;
      }
    }

    if(randomfloat(1) < var_11) {
      var_10 = var_10[0];
    } else if(randomfloat(1) < var_13) {
      var_10 = var_11[1];
    } else {
      var_10 = scripts\engine\utility::random(var_11);
    }

    self botsetscriptgoal(var_10.origin, 0, "critical");
  }

  var_11 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
  if(var_11 == "goal") {
    var_12 = get_round_end_time() - gettime();
    var_13 = var_12 - level.planttime * 2 * 1000;
    var_14 = gettime() + var_13;
    if(var_13 > 0) {
      scripts\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_13);
    }

    var_15 = gettime() >= var_14;
    var_16 = sd_press_use(level.planttime + 2, "bomb_planted", var_15);
    self botclearscriptgoal();
    if(var_16) {
      scripts\mp\bots\_bots_strategy::bot_enable_tactical_goals();
      bot_set_role("defend_planted_bomb");
      return;
    }

    if(var_13 > 5000) {
      self.dont_plant_until_time = gettime() + 5000;
      return;
    }

    return;
  }
}

get_round_end_time() {
  if(level.bombplanted) {
    return level.defuseendtime;
  }

  return gettime() + scripts\mp\gamelogic::gettimeremaining();
}

bomber_monitor_no_path() {
  self notify("bomber_monitor_no_path");
  self endon("death");
  self endon("disconnect");
  self endon("goal");
  self endon("bomber_monitor_no_path");
  level.sdbomb endon("pickup_object");
  for(;;) {
    self waittill("no_path");
    self.atk_bomber_no_path_to_bomb_count++;
  }
}

clear_target_zone_update() {
  self endon("new_role");
  if(isDefined(level.atk_bomber)) {
    if(level.attack_behavior == "rush") {
      if(!isDefined(self.set_initial_rush_goal)) {
        if(!level.multibomb) {
          var_0["nearest_node_to_center"] = level.initial_bomb_location_nearest_node;
          scripts\mp\bots\_bots_strategy::bot_protect_point(level.initial_bomb_location, 900, var_0);
          wait(randomfloatrange(0, 4));
          scripts\mp\bots\_bots_strategy::bot_defend_stop();
        }

        self.set_initial_rush_goal = 1;
      }

      if(self botgetdifficultysetting("strategyLevel") > 0) {
        set_force_sprint();
      }

      if(isai(level.atk_bomber) && isDefined(level.atk_bomber.bombzonegoal)) {
        var_1 = level.atk_bomber.bombzonegoal;
      } else if(isDefined(level.bomb_zone_assaulting)) {
        var_1 = level.bomb_zone_assaulting;
      } else {
        var_1 = find_closest_bombzone_to_player(level.atk_bomber);
      }

      if(!scripts\mp\bots\_bots_util::bot_is_defending_point(var_1.curorigin)) {
        var_1["min_goal_time"] = 2;
        var_1["max_goal_time"] = 4;
        var_1["override_origin_node"] = ::scripts\engine\utility::random(var_1.bottargets);
        scripts\mp\bots\_bots_strategy::bot_protect_point(var_1.curorigin, level.protect_radius, var_1);
        return;
      }
    }
  }
}

defend_planted_bomb_update() {
  self endon("new_role");
  if(level.bombplanted) {
    if(level.attack_behavior == "rush") {
      disable_force_sprint();
    }

    if(!scripts\mp\bots\_bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
      scripts\mp\bots\_bots_strategy::bot_protect_point(level.sdbombmodel.origin, level.protect_radius);
    }
  }
}

bomb_defuser_update() {
  self endon("new_role");
  if(level.bombdefused) {
    return;
  }

  var_0 = find_ticking_bomb();
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var_0.bottargets);
  var_2 = (level.sdbombmodel.origin[0], level.sdbombmodel.origin[1], var_1[0].origin[2]);
  var_3 = cautious_approach_till_close(var_2, undefined);
  if(!var_3) {
    return;
  }

  var_4 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
  if(var_4 == "bad_path") {
    self.defuser_bad_path_counter++;
    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        var_5 = getnodesinradiussorted(var_2, 50, 0);
        var_6 = self.defuser_bad_path_counter - 4;
        if(var_5.size <= var_6) {
          break;
        }

        self botsetscriptgoal(var_5[var_6].origin, 20, "critical");
        var_4 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
        if(var_4 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var_4 == "goal") {
    var_7 = get_round_end_time() - gettime();
    var_8 = var_7 - level.defusetime * 2 * 1000;
    var_9 = gettime() + var_8;
    if(var_8 > 0) {
      scripts\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_8);
    }

    var_10 = gettime() >= var_9;
    sd_press_use(level.defusetime + 2, "bomb_defused", var_10);
    self botclearscriptgoal();
    scripts\mp\bots\_bots_strategy::bot_enable_tactical_goals();
  }
}

investigate_someone_using_bomb_update() {
  self endon("new_role");
  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  var_0 = find_closest_bombzone_to_player(self);
  self botsetscriptgoalnode(scripts\engine\utility::random(var_0.bottargets), "guard");
  var_1 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
  if(var_1 == "goal") {
    wait(4);
    bot_set_role(self.prev_role);
  }
}

camp_bomb_update() {
  self endon("new_role");
  if(isDefined(level.sdbomb.carrier)) {
    if(self.prev_role == "defender") {
      self.defend_zone = find_closest_bombzone_to_player(self);
    }

    bot_set_role(self.prev_role);
    return;
  }

  if(!scripts\mp\bots\_bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
    var_0["nearest_node_to_center"] = level.sdbomb.nearest_node_for_camping;
    scripts\mp\bots\_bots_strategy::bot_protect_point(level.sdbomb.curorigin, level.protect_radius, var_0);
  }
}

defender_update() {
  self endon("new_role");
  if(!scripts\mp\bots\_bots_util::bot_is_defending_point(self.defend_zone.curorigin)) {
    var_0["score_flags"] = "strict_los";
    var_0["override_origin_node"] = ::scripts\engine\utility::random(self.defend_zone.bottargets);
    scripts\mp\bots\_bots_strategy::bot_protect_point(self.defend_zone.curorigin, level.protect_radius, var_0);
  }
}

backstabber_update() {
  self endon("new_role");
  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  if(!isDefined(self.backstabber_stage)) {
    self.backstabber_stage = "1_move_to_midpoint";
  }

  if(self.backstabber_stage == "1_move_to_midpoint") {
    var_0 = level.bombzones[0].curorigin;
    var_1 = level.bombzones[1].curorigin;
    var_2 = (var_0[0] + var_1[0] * 0.5, var_0[1] + var_1[1] * 0.5, var_0[2] + var_1[2] * 0.5);
    var_3 = getnodesinradiussorted(var_2, 512, 0);
    if(var_3.size == 0) {
      bot_set_role("random_killer");
      return;
    }

    var_4 = undefined;
    var_5 = int(var_3.size * var_3.size + 1 * 0.5);
    var_6 = randomint(var_5);
    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_8 = var_3.size - var_7;
      if(var_6 < var_8) {
        var_4 = var_3[var_7];
        break;
      }

      var_6 = var_6 - var_8;
    }

    self getpathactionvalue("scripted");
    var_9 = self botsetscriptgoalnode(var_4, "guard");
    if(var_9) {
      var_10 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
      if(var_10 == "goal") {
        wait(randomfloatrange(1, 4));
        self.backstabber_stage = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self.backstabber_stage == "2_move_to_enemy_spawn") {
    var_11 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    var_12 = scripts\engine\utility::random(var_11);
    self getpathactionvalue("scripted");
    var_9 = self botsetscriptgoal(var_12.origin, 250, "guard");
    if(var_9) {
      var_10 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
      if(var_10 == "goal") {
        self.backstabber_stage = "3_move_to_bombzone";
      }
    }
  }

  if(self.backstabber_stage == "3_move_to_bombzone") {
    if(!isDefined(self.bombzone_num_picked)) {
      self.bombzone_num_picked = randomint(level.bombzones.size);
    }

    self getpathactionvalue(undefined);
    var_9 = self botsetscriptgoal(scripts\engine\utility::random(level.bombzones[self.bombzone_num_picked].bottargets).origin, 160, "objective");
    if(var_9) {
      var_10 = scripts\mp\bots\_bots_util::bot_waittill_goal_or_fail();
      if(var_10 == "goal") {
        self botclearscriptgoal();
        self.backstabber_stage = "2_move_to_enemy_spawn";
        self.bombzone_num_picked = 1 - self.bombzone_num_picked;
        return;
      }
    }
  }
}

random_killer_update() {
  self endon("new_role");
  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  self[[self.personality_update_function]]();
}

set_force_sprint() {
  if(!isDefined(self.always_sprint)) {
    self botsetflag("force_sprint", 1);
    self.always_sprint = 1;
  }
}

disable_force_sprint() {
  if(isDefined(self.always_sprint)) {
    self botsetflag("force_sprint", 0);
    self.always_sprint = undefined;
  }
}

set_scripted_pathing_style() {
  if(!isDefined(self.scripted_path_style)) {
    self getpathactionvalue("scripted");
    self.scripted_path_style = 1;
  }
}

cautious_approach_till_close(var_0, var_1) {
  var_2 = level.capture_radius;
  var_3["entrance_points_index"] = var_1;
  scripts\mp\bots\_bots_strategy::bot_capture_point(var_0, var_2, var_3);
  wait(0.05);
  while(distancesquared(self.origin, var_0) > var_2 * var_2 && scripts\mp\bots\_bots_util::bot_is_defending()) {
    if(get_round_end_time() - gettime() < 20000) {
      set_scripted_pathing_style();
      set_force_sprint();
      break;
    }

    wait(0.05);
  }

  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }

  return self botsetscriptgoal(var_0, 20, "critical");
}

sd_press_use(var_0, var_1, var_2) {
  var_3 = 0;
  if(self botgetdifficultysetting("strategyLevel") == 1) {
    var_3 = 40;
  } else if(self botgetdifficultysetting("strategyLevel") >= 2) {
    var_3 = 80;
  }

  if(randomint(100) < var_3) {
    self botsetstance("prone");
    wait(0.2);
  }

  if(self botgetdifficultysetting("strategyLevel") > 0 && !var_2) {
    thread notify_on_whizby();
    thread notify_on_damage();
  }

  self botpressbutton("use", var_0);
  var_4 = scripts\mp\bots\_bots_util::bot_usebutton_wait(var_0, var_1, "use_interrupted");
  self botsetstance("none");
  self getothermode("use");
  var_5 = var_4 == var_1;
  return var_5;
}

notify_enemy_team_bomb_used(var_0) {
  var_1 = get_living_players_on_team(scripts\engine\utility::get_enemy_team(self.team), 1);
  foreach(var_3 in var_1) {
    var_4 = 0;
    if(var_0 == "plant") {
      var_4 = 300 + var_3 botgetdifficultysetting("strategyLevel") * 100;
    } else if(var_0 == "defuse") {
      var_4 = 500 + var_3 botgetdifficultysetting("strategyLevel") * 500;
    }

    if(distancesquared(var_3.origin, self.origin) < squared(var_4)) {
      var_3 bot_set_role("investigate_someone_using_bomb");
    }
  }
}

notify_on_whizby() {
  var_0 = find_closest_bombzone_to_player(self);
  self waittill("bulletwhizby", var_1);
  if(!isDefined(var_1.team) || var_1.team != self.team) {
    var_2 = var_0.usetime - var_0.curprogress;
    if(var_2 > 1000) {
      self notify("use_interrupted");
    }
  }
}

notify_on_damage() {
  self waittill("damage", var_0, var_1);
  if(!isDefined(var_1.team) || var_1.team != self.team) {
    self notify("use_interrupted");
  }
}

should_start_cautious_approach_sd(var_0) {
  var_1 = 2000;
  var_2 = var_1 * var_1;
  if(var_0) {
    if(get_round_end_time() - gettime() < 15000) {
      return 0;
    }

    var_3 = 0;
    var_4 = scripts\engine\utility::get_enemy_team(self.team);
    foreach(var_6 in level.players) {
      if(!isDefined(var_6.team)) {
        continue;
      }

      if(isalive(var_6) && var_6.team == var_4) {
        var_3 = 1;
      }
    }

    return var_3;
  }

  return distancesquared(self.origin, self.bot_defending_center) <= var_7 && self botpursuingscriptgoal();
}

find_closest_bombzone_to_player(var_0) {
  var_1 = undefined;
  var_2 = 999999999;
  foreach(var_4 in level.bombzones) {
    var_5 = distancesquared(var_4.curorigin, var_0.origin);
    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

get_players_defending_zone(var_0) {
  var_1 = [];
  var_2 = get_living_players_on_team(game["defenders"]);
  foreach(var_4 in var_2) {
    if(isai(var_4) && isDefined(var_4.role) && var_4.role == "defender") {
      if(isDefined(var_4.defend_zone) && var_4.defend_zone == var_0) {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
      }

      continue;
    }

    if(distancesquared(var_4.origin, var_0.curorigin) < level.protect_radius * level.protect_radius) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  return var_1;
}

find_ticking_bomb() {
  if(isDefined(level.tickingobject)) {
    foreach(var_1 in level.bombzones) {
      if(distancesquared(level.tickingobject.origin, var_1.curorigin) < 90000) {
        return var_1;
      }
    }
  }

  return undefined;
}

get_specific_zone(var_0) {
  var_0 = "_" + tolower(var_0);
  for(var_1 = 0; var_1 < level.bombzones.size; var_1++) {
    if(level.bombzones[var_1].label == var_0) {
      return level.bombzones[var_1];
    }
  }
}

bomber_wait_for_death() {
  self endon("stopped_being_bomb_carrier");
  self endon("new_role");
  scripts\engine\utility::waittill_any("death", "disconnect");
  level.atk_bomber = undefined;
  level.last_atk_bomber_death_time = gettime();
  if(isDefined(self)) {
    self.role = undefined;
  }

  var_0 = get_living_players_on_team(game["attackers"], 1);
  force_all_players_to_role(var_0, undefined);
}

bomber_wait_for_bomb_reset() {
  self endon("death");
  self endon("disconnect");
  self endon("stopped_being_bomb_carrier");
  level.sdbomb endon("pickup_object");
  level.sdbomb waittill("reset");
  if(scripts\mp\utility::isaiteamparticipant(self)) {
    self botclearscriptgoal();
  }

  bot_set_role("atk_bomber");
}

set_new_bomber() {
  level.atk_bomber = self;
  bot_set_role("atk_bomber");
  thread bomber_wait_for_death();
  if(!level.multibomb) {
    thread bomber_wait_for_bomb_reset();
  }

  if(isai(self)) {
    scripts\mp\bots\_bots_strategy::bot_disable_tactical_goals();
    if(level.attack_behavior == "rush" && self botgetdifficultysetting("strategyLevel") > 0) {
      set_force_sprint();
    }
  }
}

initialize_sd_role() {
  if(self.team == game["attackers"]) {
    if(level.bombplanted) {
      bot_set_role("defend_planted_bomb");
      return;
    }

    if(!isDefined(level.atk_bomber)) {
      set_new_bomber();
      return;
    }

    if(level.attack_behavior == "rush") {
      bot_set_role("clear_target_zone");
      return;
    }

    return;
  }

  var_0 = get_players_by_role("backstabber");
  var_1 = get_players_by_role("defender");
  var_2 = level.bot_personality_type[self.personality];
  var_3 = self botgetdifficultysetting("strategyLevel");
  if(var_2 == "active") {
    if(!isDefined(self.role) && level.allow_backstabbers && var_3 > 0) {
      if(var_0.size == 0) {
        bot_set_role("backstabber");
      } else {
        var_4 = 1;
        foreach(var_6 in var_0) {
          var_7 = level.bot_personality_type[var_6.personality];
          if(var_7 == "active") {
            var_4 = 0;
            break;
          }
        }

        if(var_4) {
          bot_set_role("backstabber");
          var_0[0] bot_set_role(undefined);
        }
      }
    }

    if(!isDefined(self.role)) {
      if(var_1.size < 4) {
        bot_set_role("defender");
      }
    }

    if(!isDefined(self.role)) {
      var_9 = randomint(4);
      if(var_9 == 3 && level.allow_random_killers && var_3 > 0) {
        bot_set_role("random_killer");
      } else if(var_9 == 2 && level.allow_backstabbers && var_3 > 0) {
        bot_set_role("backstabber");
      } else {
        bot_set_role("defender");
      }
    }
  } else if(var_2 == "stationary") {
    if(!isDefined(self.role)) {
      if(var_1.size < 4) {
        bot_set_role("defender");
      } else {
        foreach(var_11 in var_1) {
          var_12 = level.bot_personality_type[var_11.personality];
          if(var_12 == "active") {
            bot_set_role("defender");
            var_11 bot_set_role(undefined);
            break;
          }
        }
      }
    }

    if(!isDefined(self.role) && level.allow_backstabbers && var_3 > 0) {
      if(var_0.size == 0) {
        bot_set_role("backstabber");
      }
    }

    if(!isDefined(self.role)) {
      bot_set_role("defender");
    }
  }

  if(self.role == "defender") {
    var_14 = level.bombzones;
    if(has_override_zone_targets(self.team)) {
      var_14 = get_override_zone_targets(self.team);
    }

    if(var_14.size == 1) {
      self.defend_zone = var_14[0];
      return;
    }

    var_15 = get_players_defending_zone(var_14[0]);
    var_10 = get_players_defending_zone(var_14[1]);
    if(var_15.size < var_10.size) {
      self.defend_zone = var_14[0];
      return;
    }

    if(var_10.size < var_15.size) {
      self.defend_zone = var_14[1];
      return;
    }

    self.defend_zone = scripts\engine\utility::random(var_14);
    return;
  }
}

bot_set_role(var_0) {
  if(isai(self)) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
    self getpathactionvalue(undefined);
  }

  self.prev_role = self.role;
  self.role = var_0;
  self notify("new_role");
}

bot_set_role_delayed(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("new_role");
  wait(var_1);
  bot_set_role(var_0);
}

force_all_players_to_role(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isDefined(var_2)) {
      var_4 thread bot_set_role_delayed(var_1, randomfloatrange(0, var_2));
      continue;
    }

    var_4 thread bot_set_role(var_1);
  }
}

get_override_zone_targets(var_0) {
  return level.bot_sd_override_zone_targets[var_0];
}

has_override_zone_targets(var_0) {
  var_1 = get_override_zone_targets(var_0);
  return var_1.size > 0;
}

get_players_by_role(var_0) {
  var_1 = [];
  foreach(var_3 in level.participants) {
    if(isalive(var_3) && scripts\mp\utility::isteamparticipant(var_3) && isDefined(var_3.role) && var_3.role == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

get_living_players_on_team(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(scripts\mp\utility::isreallyalive(var_4) && scripts\mp\utility::isteamparticipant(var_4) && var_4.team == var_0) {
      if(!isDefined(var_1) || var_1 && isai(var_4) && isDefined(var_4.role)) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

bot_sd_ai_director_update() {
  level notify("bot_sd_ai_director_update");
  level endon("bot_sd_ai_director_update");
  level endon("game_ended");
  level.allow_backstabbers = randomint(3) <= 1;
  level.allow_random_killers = randomint(3) <= 1;
  level.attack_behavior = "rush";
  level.protect_radius = 725;
  level.capture_radius = 140;
  for(;;) {
    if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && !isai(level.sdbomb.carrier)) {
      level.bomb_zone_assaulting = find_closest_bombzone_to_player(level.sdbomb.carrier);
    }

    var_0 = 0;
    if(!level.bombplanted) {
      var_1 = get_living_players_on_team(game["attackers"]);
      foreach(var_3 in var_1) {
        if(var_3.isbombcarrier) {
          level.can_pickup_bomb_time = gettime();
          if(!isDefined(level.atk_bomber) || var_3 != level.atk_bomber) {
            if(isDefined(level.atk_bomber) && isalive(level.atk_bomber)) {
              level.atk_bomber bot_set_role(undefined);
              level.atk_bomber notify("stopped_being_bomb_carrier");
            }

            var_0 = 1;
            var_3 set_new_bomber();
          }
        }
      }

      if(!level.multibomb && !isDefined(level.sdbomb.carrier)) {
        var_5 = getclosestnodeinsight(level.sdbomb.curorigin);
        if(isDefined(var_5)) {
          level.sdbomb.nearest_node_for_camping = var_5;
          var_6 = 0;
          var_7 = get_living_players_on_team(game["defenders"], 1);
          foreach(var_9 in var_7) {
            var_10 = var_9 getnearestnode();
            var_11 = var_9 botgetdifficultysetting("strategyLevel");
            if(var_11 > 0 && var_9.role != "camp_bomb" && isDefined(var_10) && nodesvisible(var_5, var_10, 1)) {
              var_12 = var_9 botgetfovdot();
              if(scripts\engine\utility::within_fov(var_9.origin, var_9.angles, level.sdbomb.curorigin, var_12)) {
                if(var_11 >= 2 || distancesquared(var_9.origin, level.sdbomb.curorigin) < squared(700)) {
                  var_6 = 1;
                  break;
                }
              }
            }
          }

          if(var_6) {
            foreach(var_9 in var_7) {
              if(var_9.role != "camp_bomb" && var_9 botgetdifficultysetting("strategyLevel") > 0) {
                var_9 bot_set_role("camp_bomb");
              }
            }
          }
        }
      }

      var_10 = level.bombzones;
      if(has_override_zone_targets(game["defenders"])) {
        var_10 = get_override_zone_targets(game["defenders"]);
      }

      for(var_11 = 0; var_11 < var_10.size; var_11++) {
        for(var_12 = 0; var_12 < var_10.size; var_12++) {
          var_13 = get_players_defending_zone(var_10[var_11]);
          var_14 = get_players_defending_zone(var_10[var_12]);
          if(var_13.size > var_14.size + 1) {
            var_15 = [];
            foreach(var_3 in var_13) {
              if(isai(var_3)) {
                var_15 = scripts\engine\utility::array_add(var_15, var_3);
              }
            }

            if(var_15.size > 0) {
              var_18 = scripts\engine\utility::random(var_15);
              var_18 scripts\mp\bots\_bots_strategy::bot_defend_stop();
              var_18.defend_zone = var_10[var_12];
            }
          }
        }
      }
    } else {
      if(isDefined(level.atk_bomber)) {
        level.atk_bomber = undefined;
      }

      if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser)) {
        var_19 = [];
        var_1A = get_players_by_role("defender");
        var_1B = get_players_by_role("backstabber");
        var_1C = get_players_by_role("random_killer");
        if(var_1A.size > 0) {
          var_19 = var_1A;
        } else if(var_1B.size > 0) {
          var_19 = var_1B;
        } else if(var_1C.size > 0) {
          var_19 = var_1C;
        }

        if(var_19.size > 0) {
          var_1D = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var_19);
          level.bomb_defuser = var_1D[0];
          level.bomb_defuser bot_set_role("bomb_defuser");
          level.bomb_defuser scripts\mp\bots\_bots_strategy::bot_disable_tactical_goals();
          level.bomb_defuser thread defuser_wait_for_death();
        }
      }

      if(!isDefined(level.sd_bomb_just_planted)) {
        level.sd_bomb_just_planted = 1;
        var_1E = get_living_players_on_team(game["attackers"]);
        foreach(var_3 in var_1E) {
          if(isDefined(var_3.role)) {
            if(var_3.role == "atk_bomber") {
              var_3 thread bot_set_role(undefined);
              continue;
            }

            if(var_3.role != "defend_planted_bomb") {
              var_3 thread bot_set_role_delayed("defend_planted_bomb", randomfloatrange(0, 3));
            }
          }
        }
      }
    }

    wait(0.5);
  }
}

defuser_wait_for_death() {
  scripts\engine\utility::waittill_any("death", "disconnect");
  level.bomb_defuser = undefined;
}