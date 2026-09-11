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

function crate_can_use(var0) {
  if(isagent(self) && !isDefined(var0.boxtype)) {
    return false;
  }

  if(isDefined(var0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var0.cratetype)) {
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
  var0 = scripts\mp\bots\bots_gametype_common::debug_consoles(["_a", "_b"]);

  if(var0) {
    foreach(var2 in level.objectives) {
      var2 thread scripts\mp\bots\bots_gametype_common::monitor_bombzone_control();
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
  var0 = game["attackers"];
  var1 = 1;

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.carrier) && level.sdbomb.carrier == self && isDefined(self.role) && self.role == "atk_bomber") {
    var1 = 0;
  }

  if(var1) {
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

  if(self.team == var0 && !isDefined(level.can_pickup_bomb_time)) {
    var2 = 0;

    if(!level.multibomb) {
      var3 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(var0);

      foreach(var5 in var3) {
        if(!isai(var5)) {
          var2 = 1;
        }
      }
    }

    if(var2) {
      var7 = 6000;
      level.can_pickup_bomb_time = gettime() + var7;
      badplace_cylinder("bomb", var7 / 1000, level.sdbomb.curorigin, 75, 300, var0);
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

    if(self.team == var0) {
      if(!level.multibomb && isDefined(level.can_pickup_bomb_time) && gettime() < level.can_pickup_bomb_time && !isDefined(level.sdbomb.carrier)) {
        if(!scripts\mp\bots\bots_util::bot_is_defending_point(level.sdbomb.curorigin)) {
          var8 = getclosestnodeinsight(level.sdbomb.curorigin);

          if(isDefined(var8)) {
            GscBinSkip1(0x45, "nearest_node_to_center", var8);
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

function create_player_rig_laser_panel(var0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  self botsetstance("stand");
  wait var0;
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
      var1 = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);
      var2 = undefined;

      foreach(var4 in var1) {
        if(!var4 nodeisdisconnected()) {
          var2 = var4;
          break;
        }
      }

      if(isDefined(var2)) {
        self botsetscriptgoal(var2.origin, 20, "critical");
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
          level.sdbomb scripts\mp\gameobjects::setpickedup(self);
        }
      }

      return;
    }

    if(!self bothasscriptgoal()) {
      var6 = 15;
      var7 = 32;
      var8 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var6 + var7, self);

      if(isDefined(var8)) {
        var9 = self botsetscriptgoal(level.sdbomb.curorigin, 0, "critical");

        if(var9) {
          GscBinSkip4(0x35);
        }

        return;
      }

      var1 = getnodesinradiussorted(level.sdbomb.curorigin, 512, 0);

      if(var1.size > 0) {
        self botsetscriptgoal(var1[0].origin, 0, "critical");
        scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
      }

      if(isDefined(level.sdbomb) && !isDefined(level.sdbomb.carrier)) {
        var8 = scripts\mp\bots\bots_util::bot_queued_process("BotGetClosestNavigablePoint", &scripts\mp\bots\bots_util::func_bot_get_closest_navigable_point, level.sdbomb.curorigin, var6 + var7, self);

        if(!isDefined(var8)) {
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

  var10 = level.bomb_zone_assaulting;
  self.bombzonegoal = var10;

  if(!isDefined(level.initial_bomb_pickup_time) || gettime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time) {
    level.initial_bomb_pickup_time = gettime() + level.initial_pickup_wait_time;
    thread create_player_rig_laser_panel(level.initial_pickup_wait_time / 1000);
    wait level.initial_pickup_wait_time / 1000;
  }

  self botclearscriptgoal();

  if(level.attack_behavior == "rush") {
    self botsetpathingstyle("scripted");
    var11 = scripts\mp\bots\bots_gametype_common::process_should_do_pain(var10, 1);
    self botsetscriptgoal(var11.origin, 0, "critical");
  }

  var12 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var12 == "goal") {
    var13 = get_round_end_time() - gettime();
    var14 = var13 - level.planttime * 2 * 1000;
    var15 = gettime() + var14;

    if(var14 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var14);
    }

    var16 = gettime() >= var15;
    var17 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.planttime + 2, "bomb_planted", var16);
    self botclearscriptgoal();

    if(var17) {
      scripts\mp\bots\bots_strategy::bot_enable_tactical_goals();
      bot_set_role("defend_planted_bomb");
      return;
    }

    if(var14 > 5000) {
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
        var1 = level.atk_bomber.bombzonegoal;
      } else if(isDefined(level.bomb_zone_assaulting)) {
        var1 = level.bomb_zone_assaulting;
      } else {
        var1 = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(level.atk_bomber);
      }

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var1.curorigin)) {
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

  var0 = find_ticking_bomb();

  if(!isDefined(var0)) {
    return;
  }

  var1 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var0.bottargets);
  var2 = (level.sdbombmodel.origin[0], level.sdbombmodel.origin[1], var1[0].origin[2]);

  if(self.defuser_bad_path_counter <= 1) {
    var3 = cautious_approach_till_close(var2, undefined);
  } else {
    self botclearscriptgoal();
    var3 = self botsetscriptgoal(var3, 20, "critical");
  }

  if(!var3) {
    return;
  }

  var4 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var4 == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for(;;) {
        var5 = getnodesinradiussorted(var3, 50, 0);
        var6 = self.defuser_bad_path_counter - 4;

        if(var5.size <= var6) {
          var7 = botgetclosestnavigablepoint(var3, 50, self);

          if(isDefined(var7)) {
            self botsetscriptgoal(var7, 20, "critical");
          } else {
            break;
          }
        } else {
          self botsetscriptgoal(var4[var5].origin, 20, "critical");
        }

        var3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(var3 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var3 == "goal") {
    var8 = get_round_end_time() - gettime();
    var9 = var8 - level.defusetime * 2 * 1000;
    var10 = gettime() + var9;

    if(var9 > 0) {
      scripts\mp\bots\bots_util::bot_waittill_out_of_combat_or_time(var9);
    }

    var11 = gettime() >= var10;
    var12 = level.sdbombmodel.origin[2] - self.origin[2];
    var13 = scripts\mp\bots\bots_gametype_common::current_respawn_point_override(level.defusetime + 2, "bomb_defused", var11, var12 > 40);

    if(!var13 && self.defuser_bad_path_counter >= 4) {
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

  var0 = scripts\mp\bots\bots_gametype_common::find_closest_bombzone_to_player(self);
  self botsetscriptgoalnode(scripts\engine\utility::random(var0.bottargets), "critical");
  var1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  if(var1 == "goal") {
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
    var0 = level.objectives["_a"].curorigin;
    var1 = level.objectives["_b"].curorigin;
    var2 = ((var0[0] + var1[0]) * 0.5, (var0[1] + var1[1]) * 0.5, (var0[2] + var1[2]) * 0.5);
    var3 = getnodesinradiussorted(var2, 512, 0);

    if(var3.size == 0) {
      bot_set_role("random_killer");
      return;
    }

    var4 = undefined;
    var5 = int(var3.size * (var3.size + 1) * 0.5);
    var6 = randomint(var5);

    for(var7 = 0; var7 < var3.size; var7++) {
      var8 = var3.size - var7;

      if(var6 < var8) {
        var4 = var3[var7];
        break;
      }

      var6 -= var8;
    }

    self botsetpathingstyle("scripted");
    var9 = self botsetscriptgoalnode(var4, "guard");

    if(var9) {
      var10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var10 == "goal") {
        wait randomfloatrange(1, 4);
        self.backstabber_stage = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self.backstabber_stage == "2_move_to_enemy_spawn") {
    var11 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    var12 = scripts\engine\utility::random(var11);
    self botsetpathingstyle("scripted");
    var9 = self botsetscriptgoal(var12.origin, 250, "guard");

    if(var9) {
      var10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var10 == "goal") {
        self.backstabber_stage = "3_move_to_bombzone";
      }
    }
  }

  if(self.backstabber_stage == "3_move_to_bombzone") {
    if(!isDefined(self.current_respawn_point)) {
      self.current_respawn_point = scripts\engine\utility::random(level.objectives);
    }

    self botsetpathingstyle(undefined);
    var9 = self botsetscriptgoal(scripts\engine\utility::random(self.current_respawn_point.bottargets).origin, 160, "objective");

    if(var9) {
      var10 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

      if(var10 == "goal") {
        self botclearscriptgoal();
        self.backstabber_stage = "2_move_to_enemy_spawn";

        foreach(var14 in level.objectives) {
          if(var14 != self.current_respawn_point) {
            self.current_respawn_point = var14;
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

function cautious_approach_till_close(var0, var1) {
  var2 = level.capture_radius;
  GscBinSkip1(0x45, "entrance_points_index", var1);
}

function notify_enemy_team_bomb_used(var0) {
  var1 = scripts\mp\bots\bots_gametype_common::prematchinitx1blueprintloadouts(var0);

  foreach(var3 in var1) {
    if(isDefined(var3.role)) {
      bot_set_role(var3, "investigate_someone_using_bomb");
    }
  }
}

function should_start_cautious_approach_sd(var0) {
  var1 = 2000;
  var2 = var1 * var1;

  if(var0) {
    if(get_round_end_time() - gettime() < 15000) {
      return 0;
    }

    var3 = 0;
    var4 = scripts\engine\utility::get_enemy_team(self.team);

    foreach(var6 in level.players) {
      if(!isDefined(var6.team)) {
        continue;
      }

      if(isalive(var6) && var6.team == var4) {
        var3 = 1;
      }
    }

    return var3;
  }

  return distancesquared(self.origin, self.bot_defending_center) <= var7 && self botpursuingscriptgoal();
}

function get_players_defending_zone(var0) {
  var1 = [];
  var2 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["defenders"]);

  foreach(var4 in var2) {
    if(isai(var4) && isDefined(var4.role) && var4.role == "defender") {
      if(isDefined(var4.defend_zone) && var4.defend_zone == var0) {
        var1 = scripts\engine\utility::array_add(var1, var4);
      }

      continue;
    }

    if(distancesquared(var4.origin, var0.curorigin) < level.protect_radius * level.protect_radius) {
      var1 = scripts\engine\utility::array_add(var1, var4);
    }
  }

  return var1;
}

function find_ticking_bomb() {
  if(isDefined(level.tickingobject)) {
    foreach(var1 in level.objectives) {
      if(distancesquared(level.tickingobject.origin, var1.curorigin) < 90000) {
        return var1;
      }
    }
  }

  return undefined;
}

function get_specific_zone(var0) {
  var0 = "_" + tolower(var0);
  return level.objectives[var0];
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

  var0 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["attackers"], 1);
  force_all_players_to_role(var0, undefined);
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

  var0 = get_players_by_role("backstabber");
  var1 = get_players_by_role("defender");
  var2 = level.bot_personality_type[self.personality];
  var3 = self botgetdifficultysetting("strategyLevel");

  if(var2 == "active") {
    if(!isDefined(self.role) && level.allow_backstabbers && var3 > 0) {
      if(var0.size == 0) {
        bot_set_role("backstabber");
      } else {
        var4 = 1;

        foreach(var6 in var0) {
          var7 = level.bot_personality_type[var6.personality];

          if(var7 == "active") {
            var4 = 0;
            break;
          }
        }

        if(var4) {
          bot_set_role("backstabber");
          bot_set_role(var0[0], undefined);
        }
      }
    }

    if(!isDefined(self.role)) {
      if(var1.size < 4) {
        bot_set_role("defender");
      }
    }

    if(!isDefined(self.role)) {
      var9 = randomint(4);

      if(var9 == 3 && level.allow_random_killers && var3 > 0) {
        bot_set_role("random_killer");
      } else if(var9 == 2 && level.allow_backstabbers && var3 > 0) {
        bot_set_role("backstabber");
      } else {
        bot_set_role("defender");
      }
    }
  } else if(var2 == "stationary") {
    if(!isDefined(self.role)) {
      if(var1.size < 4) {
        bot_set_role("defender");
      } else {
        foreach(var11 in var1) {
          var12 = level.bot_personality_type[var11.personality];

          if(var12 == "active") {
            bot_set_role("defender");
            bot_set_role(var11, undefined);
            break;
          }
        }
      }
    }

    if(!isDefined(self.role) && level.allow_backstabbers && var3 > 0) {
      if(var0.size == 0) {
        bot_set_role("backstabber");
      }
    }

    if(!isDefined(self.role)) {
      bot_set_role("defender");
    }
  }

  if(self.role == "defender") {
    var14 = level.objectives;

    if(has_override_zone_targets(self.team)) {
      var14 = get_override_zone_targets(self.team);
    }

    if(var14.size == 1) {
      self.defend_zone = var14["_a"];
      return;
    }

    var15 = get_players_defending_zone(var14["_a"]);
    var16 = get_players_defending_zone(var14["_b"]);

    if(var15.size < var16.size) {
      self.defend_zone = var14["_a"];
      return;
    }

    if(var16.size < var15.size) {
      self.defend_zone = var14["_b"];
      return;
    }

    self.defend_zone = scripts\engine\utility::random(var14);
    return;
  }
}

function bot_set_role(var0) {
  if(isai(self)) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
    self botsetpathingstyle(undefined);
  }

  self.prev_role = self.role;
  self.role = var0;
  self notify("new_role");
}

function bot_set_role_delayed(var0, var1) {
  self endon("death_or_disconnect");
  self endon("new_role");
  wait var1;
  bot_set_role(var0);
}

function force_all_players_to_role(var0, var1, var2) {
  foreach(var4 in var0) {
    if(isDefined(var2)) {
      thread bot_set_role_delayed(var4, var1);
      continue;
    }

    thread bot_set_role(var4);
  }
}

function get_override_zone_targets(var0) {
  return level.bot_sd_override_zone_targets[var0];
}

function has_override_zone_targets(var0) {
  var1 = get_override_zone_targets(var0);
  return var1.size > 0;
}

function get_players_by_role(var0) {
  var1 = [];

  foreach(var3 in level.participants) {
    if(isalive(var3) && scripts\mp\utility\entity::isteamparticipant(var3) && isDefined(var3.role) && var3.role == var0) {
      var1 = var3;
    }
  }

  return var1;
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

    var0 = 0;

    if(!level.bombplanted) {
      var1 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["attackers"]);

      foreach(var3 in var1) {
        if(var3.isbombcarrier) {
          level.can_pickup_bomb_time = gettime();

          if(!isDefined(level.atk_bomber) || var3 != level.atk_bomber) {
            if(isDefined(level.atk_bomber) && isalive(level.atk_bomber)) {
              bot_set_role(level.atk_bomber, undefined);
              level.atk_bomber notify("stopped_being_bomb_carrier");
            }

            var0 = 1;
            set_new_bomber(var3);
          }
        }
      }

      if(!level.multibomb && !isDefined(level.sdbomb.carrier)) {
        var5 = getclosestnodeinsight(level.sdbomb.curorigin);

        if(isDefined(var5)) {
          level.sdbomb.nearest_node_for_camping = var5;
          var6 = 0;
          var7 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["defenders"], 1);

          foreach(var9 in var7) {
            var10 = var9 getnearestnode();
            var11 = var9 botgetdifficultysetting("strategyLevel");

            if(var11 > 0 && var9.role != "camp_bomb" && isDefined(var10) && nodesvisible(var5, var10, 1)) {
              var12 = var9 botgetfovdot();

              if(scripts\engine\utility::within_fov(var9.origin, var9 getplayerangles(), level.sdbomb.curorigin, var12)) {
                if(var11 >= 2 || distancesquared(var9.origin, level.sdbomb.curorigin) < squared(700)) {
                  var6 = 1;
                  break;
                }
              }
            }
          }

          var7 = undefined;
          var11 = undefined;

          if(var5) {
            foreach(var8 in var6) {
              if(var8.role != "camp_bomb" && var8 botgetdifficultysetting("strategyLevel") > 0) {
                bot_set_role(var8, "camp_bomb");
              }
            }
          }
        }
      }

      var16 = level.objectives;

      if(has_override_zone_targets(game["defenders"])) {
        var16 = get_override_zone_targets(game["defenders"]);
      }

      foreach(var18 in var16) {
        foreach(var20 in var16) {
          var21 = get_players_defending_zone(var18);
          var22 = get_players_defending_zone(var20);

          if(var21.size > var22.size + 1) {
            var23 = [];

            foreach(var2 in var21) {
              if(isai(var2)) {
                var23 = scripts\engine\utility::array_add(var23, var2);
              }
            }

            if(var23.size > 0) {
              var26 = scripts\engine\utility::random(var23);
              var26 scripts\mp\bots\bots_strategy::bot_defend_stop();
              var26.defend_zone = var20;
            }
          }
        }
      }
    } else {
      if(isDefined(level.atk_bomber)) {
        level.atk_bomber = undefined;
      }

      if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser)) {
        var29 = [];
        var30 = get_players_by_role("defender");
        var31 = get_players_by_role("backstabber");
        var32 = get_players_by_role("random_killer");

        if(var30.size > 0) {
          var29 = var30;
        } else if(var31.size > 0) {
          var29 = var31;
        } else if(var32.size > 0) {
          var29 = var32;
        }

        if(var29.size > 0 && isDefined(level.sdbombmodel)) {
          var33 = scripts\engine\utility::get_array_of_closest(level.sdbombmodel.origin, var29);
          level.bomb_defuser = var33[0];
          bot_set_role(level.bomb_defuser, "defuser");
          level.bomb_defuser scripts\mp\bots\bots_strategy::bot_disable_tactical_goals();
          thread defuser_wait_for_death();
        }
      }

      if(!isDefined(level.sd_bomb_just_planted)) {
        level.sd_bomb_just_planted = 1;
        var34 = scripts\mp\bots\bots_gametype_common::get_living_players_on_team(game["attackers"]);

        foreach(var3 in var34) {
          if(isDefined(var3.role)) {
            if(var3.role == "atk_bomber") {
              thread bot_set_role(var3);
              continue;
            }

            if(var3.role != "defend_planted_bomb") {
              thread bot_set_role_delayed(var3, "defend_planted_bomb");
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

function vehicle_compass_br_shouldbevisibletoplayer(var0) {
  var1 = spawncovernode(var0, (0, randomint(360), 0), "Cover Stand");
}

function damage_multiplier() {
  if(level.mapname == "mp_malyshev") {
    var0 = (360, 2676, 16);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (319, 2772, 16);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (-1499, 3395, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (-1543, 3344, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (-1456, 3343, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    var0 = (-1498, 3294, 40);
    thread vehicle_compass_br_shouldbevisibletoplayer(var0);
    return;
  }
}