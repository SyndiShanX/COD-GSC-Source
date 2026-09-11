/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_sd.gsc
************************************************/

function main() {
  setup_callbacks();
  bot_sd_start();
}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_sd_think;
  level.bot_funcs["should_start_cautious_approach"] = &should_start_cautious_approach_sd;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = &notify_enemy_team_bomb_used;
}

function bot_sd_start() {
  setup_bot_sd();
}

function crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return false;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return false;
  }

  if(!scripts\mp\utility\entity::isteamparticipant(self)) {
    return true;
  }

  if(!isDefined(self.role)) {
    return false;
  }

  switch (self.role) {
    case "investigate_someone_using_bomb":
    case "defuser":
    case "atk_bomber":
      return false;
  }

  return true;
}

function setup_bot_sd() {
  level.bots_disable_team_switching = 1;
  level.initial_pickup_wait_time = 3000;
  damage_multiplier();
  scripts\mp\bots\bots_gametype_common::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  level.bot_sd_override_zone_targets = [];
  level.bot_sd_override_zone_targets["axis"] = [];
  level.bot_sd_override_zone_targets["allies"] = [];
  level.bot_default_sd_role_behavior["atk_bomber"] = &atk_bomber_update;
  level.bot_default_sd_role_behavior["clear_target_zone"] = &clear_target_zone_update;
  level.bot_default_sd_role_behavior["defend_planted_bomb"] = &defend_planted_bomb_update;
  level.bot_default_sd_role_behavior["defuser"] = &bomb_defuser_update;
  level.bot_default_sd_role_behavior["investigate_someone_using_bomb"] = &investigate_someone_using_bomb_update;
  level.bot_default_sd_role_behavior["camp_bomb"] = &camp_bomb_update;
  level.bot_default_sd_role_behavior["defender"] = &defender_update;
  level.bot_default_sd_role_behavior["backstabber"] = &backstabber_update;
  level.bot_default_sd_role_behavior["random_killer"] = &random_killer_update;
  var_0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level.objectives) {
      var_2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
    }

    thread bot_sd_ai_director_update();
    level.bot_gametype_precaching_done = 1;
    return;
  }
}

function bot_sd_think() {
  self notify("bot_sd_think");
  self endon("bot_sd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.has_started_thinking = undefined;

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
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

    if(isDefined(level.atk_bomber) && level.atk_bomber == self) {
      level.atk_bomber = undefined;
    }
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
      var_3 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(var_0);

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
    wait randomintrange(1, 3) * 0.05;

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
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
          var_8 = getclosestnodeinsight(level.sdbomb.curorigin);

          if(isDefined(var_8)) {
            GscBinSkip1(0x45, "nearest_node_to_center", var_8);
          }

          level.can_pickup_bomb_time = gettime();
        }
      } else {
        self[[level.bot_default_sd_role_behavior[self.role]]]();
      }

      continue;
    }

    if(level.bombplanted) {
      if(isDefined(level.sdbombmodel) && distancesquared(self.origin, level.sdbombmodel.origin) > squared(level.protect_radius * 2)) {
        if(!isDefined(self.defender_set_script_pathstyle)) {
          self.defender_set_script_pathstyle = 1;
          self botsetpathingstyle("scripted");
        }
      } else if(isDefined(self.defender_set_script_pathstyle) && !isDefined(self.scripted_path_style)) {
        self.defender_set_script_pathstyle = undefined;
        self botsetpathingstyle(undefined);
      }
    }

    if(level.bombplanted && isDefined(level.sdbombmodel) && isDefined(level.bomb_defuser) && self.role != "defuser") {
      if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
        self botclearscriptgoal();
        scripts\mp\bots\bots_strategy::bot_protect_point(level.sdbombmodel.origin, level.protect_radius);
      }

      continue;
    }

    self[[level.bot_default_sd_role_behavior[self.role]]]();
  }
}

function create_player_rig_laser_panel(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  self botsetstance("stand");
  wait var_0;
  self botsetflag("disable_movement", 0);
  self botsetstance("none");
}

function atk_bomber_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && isalive(level.sdbomb.carrier) && level.sdbomb.carrier != self) {
    wait 0.7;
  }

  if(!self.isbombcarrier && !level.multibomb) {
    if(level.bombplanted) {
      level.atk_bomber = undefined;
      scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
      bot_set_role("defend_planted_bomb");
      return;
    }

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
        if(!var_4 nodeisdisconnected()) {
          var_2 = var_4;
          break;
        }
      }

      if(isDefined(var_2)) {
        self botsetscriptgoal(var_2.origin, 20, "critical");
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
          level.sdbomb scripts\mp\gameobjects::setpickedup(self);
        }
      }

      return;
    }

    if(!self bothasscriptgoal()) {
      var_6 = 15;
      var_7 = 32;
      var_8 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var_6 + var_7, self);

      if(isDefined(var_8)) {
        var_9 = self botsetscriptgoal(level.sdbomb.curorigin, 0, "critical");

        if(var_9) {
          GscBinSkip4(0x35);
        }

        return;
      }

      var_1 = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);

      if(var_1.size > 0) {
        self botsetscriptgoal(var_1[0].origin, 0, "critical");
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
      }

      if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
        var_8 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var_6 + var_7, self);

        if(!isDefined(var_8)) {
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
    level.bomb_zone_assaulting = scripts\engine\utility::random(level.objectives);
  }

  var_10 = level.bomb_zone_assaulting;
  self.bombzonegoal = var_10;

  if(!isDefined(level.initial_bomb_pickup_time) || gettime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time) {
    level.initial_bomb_pickup_time = gettime() + level.initial_pickup_wait_time;
    thread create_player_rig_laser_panel(level.initial_pickup_wait_time / 1000);
    wait level.initial_pickup_wait_time / 1000;
  }

  self botclearscriptgoal();

  if(level.attack_behavior == "rush") {
    self botsetpathingstyle("scripted");
    var_11 = scripts\mp\bots\bots_gametype_common::process_should_do_pain(var_10, 1);
    self botsetscriptgoal(var_11.origin, 0, "critical");
  }

  var_12 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_12 == "goal") {
    var_13 = get_round_end_time() - gettime();
    var_14 = var_13 - level.planttime * 2 * 1000;
    var_15 = gettime() + var_14;

    if(var_14 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_14);
    }

    var_16 = gettime() >= var_15;
    var_17 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.planttime + 2, "bomb_planted", var_16);
    self botclearscriptgoal();

    if(var_17) {
      scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
      bot_set_role("defend_planted_bomb");
      return;
    }

    if(var_14 > 5000) {
      self.dont_plant_until_time = gettime() + 5000;
      return;
    }

    return;
  }
}

function get_round_end_time() {
  if(level.bombplanted) {
    return level.defuseendtime;
  }

  return gettime() + scripts\mp\gamelogic::gettimeremaining();
}

function bomber_monitor_no_path() {
  self notify("bomber_monitor_no_path");
  self endon("death_or_disconnect");
  self endon("goal");
  self endon("bomber_monitor_no_path");
  level.sdbomb endon("pickup_object");

  for(;;) {
    self waittill("no_path");
    self.atk_bomber_no_path_to_bomb_count++;
  }
}

function clear_target_zone_update() {
  self endon("new_role");

  if(isDefined(level.atk_bomber)) {
    if(level.attack_behavior == "rush") {
      if(!isDefined(self.set_initial_rush_goal)) {
        if(!level.multibomb) {
          GscBinSkip1(0x45, "nearest_node_to_center", level.initial_bomb_location_nearest_node);
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
        var_1 = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(level.atk_bomber);
      }

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_1.curorigin)) {
        GscBinSkip1(0x45, "min_goal_time", 2);
      }

      return;
    }

    return;
  }
}

function defend_planted_bomb_update() {
  self endon("new_role");

  if(level.bombplanted && isDefined(level.sdbombmodel)) {
    if(level.attack_behavior == "rush") {
      disable_force_sprint();
    }

    if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbombmodel.origin)) {
      GscBinSkip1(0x45, "score_flags", "strongly_avoid_center");
    }

    return;
  }
}

function bomb_defuser_update() {
  self endon("new_role");

  if(level.bombdefused || !isDefined(level.sdbombmodel)) {
    return;
  }

  var_0 = find_ticking_bomb();

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var_0.bottargets);
  var_2 = (level.sdbombmodel.origin[0], level.sdbombmodel.origin[1], var_1[0].origin[2]);

  if(self.defuser_bad_path_counter <= 1) {
    var_3 = cautious_approach_till_close(var_2, undefined);
  } else {
    self botclearscriptgoal();
    var_3 = self botsetscriptgoal(var_3, 20, "critical");
  }

  if(!var_3) {
    return;
  }

  var_4 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_4 == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        var_5 = getnodesinradiussorted(var_3, 50, 0);
        var_6 = self.defuser_bad_path_counter - 4;

        if(var_5.size <= var_6) {
          var_7 = botgetclosestnavigablepoint(var_3, 50, self);

          if(isDefined(var_7)) {
            self botsetscriptgoal(var_7, 20, "critical");
          } else {
            break;
          }
        } else {
          self botsetscriptgoal(var_4[var_5].origin, 20, "critical");
        }

        var_3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(var_3 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var_3 == "goal") {
    var_8 = get_round_end_time() - gettime();
    var_9 = var_8 - level.defusetime * 2 * 1000;
    var_10 = gettime() + var_9;

    if(var_9 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var_9);
    }

    var_11 = gettime() >= var_10;
    var_12 = level.sdbombmodel.origin[2] - self.origin[2];
    var_13 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.defusetime + 2, "bomb_defused", var_11, var_12 > 40);

    if(!var_13 && self.defuser_bad_path_counter >= 4) {
      self.defuser_bad_path_counter++;
    }

    self botclearscriptgoal();
    scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
    return;
  }
}

function investigate_someone_using_bomb_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  var_0 = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(self);
  self botsetscriptgoalnode(scripts\engine\utility::random(var_0.bottargets), "critical");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var_1 == "goal") {
    wait 2;
    bot_set_role(self.prev_role);
    return;
  }
}

function camp_bomb_update() {
  self endon("new_role");

  if(isDefined(level.sdbomb.carrier)) {
    if(self.prev_role == "defender") {
      self.defend_zone = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(self);
    }

    bot_set_role(self.prev_role);
    return;
  }

  if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
    GscBinSkip1(0x45, "nearest_node_to_center", level.sdbomb.nearest_node_for_camping);
  }
}

function defender_update() {
  self endon("new_role");

  if(!scripts\mp\bots\bots_util::bot_is_defending_point(self.defend_zone.curorigin)) {
    GscBinSkip1(0x45, "score_flags", "strict_los");
  }
}

function backstabber_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  if(!isDefined(self.backstabber_stage)) {
    self.backstabber_stage = "1_move_to_midpoint";
  }

  if(self.backstabber_stage == "1_move_to_midpoint") {
    var_0 = level.objectives["_a"].curorigin;
    var_1 = level.objectives["_b"].curorigin;
    var_2 = ((var_0[0] + var_1[0]) * 0.5, (var_0[1] + var_1[1]) * 0.5, (var_0[2] + var_1[2]) * 0.5);
    var_3 = getnodesinradiussorted(var_2, 512, 0);

    if(var_3.size == 0) {
      bot_set_role("random_killer");
      return;
    }

    var_4 = undefined;
    var_5 = int(var_3.size * (var_3.size + 1) * 0.5);
    var_6 = randomint(var_5);

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_8 = var_3.size - var_7;

      if(var_6 < var_8) {
        var_4 = var_3[var_7];
        break;
      }

      var_6 -= var_8;
    }

    self botsetpathingstyle("scripted");
    var_9 = self botsetscriptgoalnode(var_4, "guard");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_10 == "goal") {
        wait randomfloatrange(1, 4);
        self.backstabber_stage = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self.backstabber_stage == "2_move_to_enemy_spawn") {
    var_11 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    var_12 = scripts\engine\utility::random(var_11);
    self botsetpathingstyle("scripted");
    var_9 = self botsetscriptgoal(var_12.origin, 250, "guard");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_10 == "goal") {
        self.backstabber_stage = "3_move_to_bombzone";
      }
    }
  }

  if(self.backstabber_stage == "3_move_to_bombzone") {
    if(!isDefined(self.current_respawn_point)) {
      self.current_respawn_point = scripts\engine\utility::random(level.objectives);
    }

    self botsetpathingstyle(undefined);
    var_9 = self botsetscriptgoal(scripts\engine\utility::random(self.current_respawn_point.bottargets).origin, 160, "objective");

    if(var_9) {
      var_10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var_10 == "goal") {
        self botclearscriptgoal();
        self.backstabber_stage = "2_move_to_enemy_spawn";

        foreach(var_14 in level.objectives) {
          if(var_14 != self.current_respawn_point) {
            self.current_respawn_point = var_14;
            break;
          }
        }

        return;
      }

      return;
    }

    return;
  }
}

function random_killer_update() {
  self endon("new_role");

  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  self[[self.personality_update_function]]();
}

function set_force_sprint() {
  if(!isDefined(self.always_sprint)) {
    self botsetflag("force_sprint", 1);
    self.always_sprint = 1;
    return;
  }
}

function disable_force_sprint() {
  if(isDefined(self.always_sprint)) {
    self botsetflag("force_sprint", 0);
    self.always_sprint = undefined;
    return;
  }
}

function set_scripted_pathing_style() {
  if(!isDefined(self.scripted_path_style)) {
    self botsetpathingstyle("scripted");
    self.scripted_path_style = 1;
    return;
  }
}

function cautious_approach_till_close(var_0, var_1) {
  var_2 = level.capture_radius;
  GscBinSkip1(0x45, "entrance_points_index", var_1);
}

function notify_enemy_team_bomb_used(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::prematchinitx1blueprintloadouts(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.role)) {
      bot_set_role(var_3, "investigate_someone_using_bomb");
    }
  }
}

function should_start_cautious_approach_sd(var_0) {
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

function get_players_defending_zone(var_0) {
  var_1 = [];
  var_2 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["defenders"]);

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

function find_ticking_bomb() {
  if(isDefined(level.tickingobject)) {
    foreach(var_1 in level.objectives) {
      if(distancesquared(level.tickingobject.origin, var_1.curorigin) < 90000) {
        return var_1;
      }
    }
  }

  return undefined;
}

function get_specific_zone(var_0) {
  var_0 = "_" + tolower(var_0);
  return level.objectives[var_0];
}

function bomber_wait_for_death() {
  self endon("stopped_being_bomb_carrier");
  self endon("new_role");
  self waittill("death_or_disconnect");
  level.atk_bomber = undefined;
  level.last_atk_bomber_death_time = gettime();

  if(isDefined(self)) {
    self.role = undefined;
  }

  var_0 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["attackers"], 1);
  force_all_players_to_role(var_0, undefined);
}

function bomber_wait_for_bomb_reset() {
  self endon("death_or_disconnect");
  self endon("stopped_being_bomb_carrier");
  level.sdbomb endon("pickup_object");
  level.sdbomb waittill("reset");

  if(scripts\mp\utility\entity::isaiteamparticipant(self)) {
    self botclearscriptgoal();
  }

  bot_set_role("atk_bomber");
}

function set_new_bomber() {
  level.atk_bomber = self;
  bot_set_role("atk_bomber");
  thread bomber_wait_for_death();

  if(!level.multibomb) {
    thread bomber_wait_for_bomb_reset();
  }

  if(isai(self)) {
    scripts\mp\bots\bots_strategy::bot_disable_tactical_goals();

    if(level.attack_behavior == "rush" && self botgetdifficultysetting("strategyLevel") > 0) {
      set_force_sprint();
      return;
    }

    return;
  }
}

function initialize_sd_role() {
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
          bot_set_role(var_0[0], undefined);
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
            bot_set_role(var_11, undefined);
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
    var_14 = level.objectives;

    if(has_override_zone_targets(self.team)) {
      var_14 = get_override_zone_targets(self.team);
    }

    if(var_14.size == 1) {
      self.defend_zone = var_14["_a"];
      return;
    }

    var_15 = get_players_defending_zone(var_14["_a"]);
    var_16 = get_players_defending_zone(var_14["_b"]);

    if(var_15.size < var_16.size) {
      self.defend_zone = var_14["_a"];
      return;
    }

    if(var_16.size < var_15.size) {
      self.defend_zone = var_14["_b"];
      return;
    }

    self.defend_zone = scripts\engine\utility::random(var_14);
    return;
  }
}

function bot_set_role(var_0) {
  if(isai(self)) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
    self botsetpathingstyle(undefined);
  }

  self.prev_role = self.role;
  self.role = var_0;
  self notify("new_role");
}

function bot_set_role_delayed(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("new_role");
  wait var_1;
  bot_set_role(var_0);
}

function force_all_players_to_role(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isDefined(var_2)) {
      thread bot_set_role_delayed(var_4, var_1);
      continue;
    }

    thread bot_set_role(var_4);
  }
}

function get_override_zone_targets(var_0) {
  return level.bot_sd_override_zone_targets[var_0];
}

function has_override_zone_targets(var_0) {
  var_1 = get_override_zone_targets(var_0);
  return var_1.size > 0;
}

function get_players_by_role(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(isalive(var_3) && scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.role) && var_3.role == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function bot_sd_ai_director_update() {
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
      level.bomb_zone_assaulting = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(level.sdbomb.carrier);
    }

    var_0 = 0;

    if(!level.bombplanted) {
      var_1 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["attackers"]);

      foreach(var_3 in var_1) {
        if(var_3.isbombcarrier) {
          level.can_pickup_bomb_time = gettime();

          if(!isDefined(level.atk_bomber) || var_3 != level.atk_bomber) {
            if(isDefined(level.atk_bomber) && isalive(level.atk_bomber)) {
              bot_set_role(level.atk_bomber, undefined);
              level.atk_bomber notify("stopped_being_bomb_carrier");
            }

            var_0 = 1;
            set_new_bomber(var_3);
          }
        }
      }

      if(!level.multibomb && !isDefined(level.sdbomb.carrier)) {
        var_5 = getclosestnodeinsight(level.sdbomb.curorigin);

        if(isDefined(var_5)) {
          level.sdbomb.nearest_node_for_camping = var_5;
          var_6 = 0;
          var_7 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["defenders"], 1);

          foreach(var_9 in var_7) {
            var_10 = var_9 getnearestnode();
            var_11 = var_9 botgetdifficultysetting("strategyLevel");

            if(var_11 > 0 && var_9.role != "camp_bomb" && isDefined(var_10) && nodesvisible(var_5, var_10, 1)) {
              var_12 = var_9 botgetfovdot();

              if(scripts\engine\utility::within_fov(var_9.origin, var_9 getplayerangles(), level.sdbomb.curorigin, var_12)) {
                if(var_11 >= 2 || distancesquared(var_9.origin, level.sdbomb.curorigin) < squared(700)) {
                  var_6 = 1;
                  break;
                }
              }
            }
          }

          var_7 = undefined;
          var_11 = undefined;

          if(var_5) {
            foreach(var_8 in var_6) {
              if(var_8.role != "camp_bomb" && var_8 botgetdifficultysetting("strategyLevel") > 0) {
                bot_set_role(var_8, "camp_bomb");
              }
            }
          }
        }
      }

      var_16 = level.objectives;

      if(has_override_zone_targets(game["defenders"])) {
        var_16 = get_override_zone_targets(game["defenders"]);
      }

      foreach(var_18 in var_16) {
        foreach(var_20 in var_16) {
          var_21 = get_players_defending_zone(var_18);
          var_22 = get_players_defending_zone(var_20);

          if(var_21.size > var_22.size + 1) {
            var_23 = [];

            foreach(var_2 in var_21) {
              if(isai(var_2)) {
                var_23 = scripts\engine\utility::array_add(var_23, var_2);
              }
            }

            if(var_23.size > 0) {
              var_26 = scripts\engine\utility::random(var_23);
              var_26 scripts\mp\bots\bots_strategy::bot_defend_stop();
              var_26.defend_zone = var_20;
            }
          }
        }
      }
    } else {
      if(isDefined(level.atk_bomber)) {
        level.atk_bomber = undefined;
      }

      if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser)) {
        var_29 = [];
        var_30 = get_players_by_role("defender");
        var_31 = get_players_by_role("backstabber");
        var_32 = get_players_by_role("random_killer");

        if(var_30.size > 0) {
          var_29 = var_30;
        } else if(var_31.size > 0) {
          var_29 = var_31;
        } else if(var_32.size > 0) {
          var_29 = var_32;
        }

        if(var_29.size > 0 && isDefined(level.sdbombmodel)) {
          var_33 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var_29);
          level.bomb_defuser = var_33[0];
          bot_set_role(level.bomb_defuser, "defuser");
          level.bomb_defuser scripts\mp\bots\bots_strategy::bot_disable_tactical_goals();
          thread defuser_wait_for_death();
        }
      }

      if(!isDefined(level.sd_bomb_just_planted)) {
        level.sd_bomb_just_planted = 1;
        var_34 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["attackers"]);

        foreach(var_3 in var_34) {
          if(isDefined(var_3.role)) {
            if(var_3.role == "atk_bomber") {
              thread bot_set_role(var_3);
              continue;
            }

            if(var_3.role != "defend_planted_bomb") {
              thread bot_set_role_delayed(var_3, "defend_planted_bomb");
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

function defuser_wait_for_death() {
  self waittill("death_or_disconnect");
  level.bomb_defuser = undefined;
}

function vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "Cover Stand");
}

function damage_multiplier() {
  if(level.mapname == "mp_malyshev") {
    var_0 = (360, 2676, 16);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (319, 2772, 16);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1499, 3395, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1543, 3344, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1456, 3343, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    var_0 = (-1498, 3294, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
    return;
  }
}