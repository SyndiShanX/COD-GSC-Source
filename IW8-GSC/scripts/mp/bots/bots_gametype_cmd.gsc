/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cmd.gsc
*************************************************/

function main() {
  setup_callbacks();
  setup_hardpoint();
}

function setup_hardpoint() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  thread bot_hardpoint_ai_director_update();
  level.protect_radius = 128;
  level.patrol_radius = 800;
  level.bot_gametype_precaching_done = 1;
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_hardpoint_think;
}

function initialize_role() {
  var_0 = get_allied_attackers_for_team(self.team);
  var_1 = get_allied_defenders_for_team(self.team);
  var_2 = bot_attacker_limit_for_team(self.team);
  var_3 = bot_defender_limit_for_team(self.team);
  var_4 = level.bot_personality_type[self.personality];

  if(var_4 == "active") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level.bot_personality_type[var_7.personality] == "stationary") {
          var_7.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        bot_set_role("attacker");
        return;
      }

      bot_set_role("defender");
      return;
    }

    bot_set_role("attacker");
    return;
  }

  if(var_4 == "stationary") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level.bot_personality_type[var_10.personality] == "active") {
          var_10.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        bot_set_role("defender");
        return;
      }

      bot_set_role("attacker");
      return;
    }

    bot_set_role("defender");
    return;
  }
}

function bot_hardpoint_think() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botclearscriptgoal();

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(level.currentobjective)) {
      continue;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      continue;
    }

    if(!isDefined(self.role)) {
      initialize_role();
    }

    if(!istrue(self.bot_defending)) {
      var_0 = undefined;
      var_1 = undefined;
    }

    if(self.role == "attacker") {
      var_2 = 0;
      var_1 = undefined;

      if(!isDefined(var_0)) {
        var_2 = 1;
      } else if(isDefined(level.currentobjective.trigger)) {
        if(var_0 != level.currentobjective.trigger) {
          var_2 = 1;
        }
      }

      if(var_2) {
        var_3 = getclosestpointonnavmesh(level.currentobjective.trigger.origin, self);
        GscBinSkip1(0x45, "min_goal_time", 1);
      }

      continue;
    }

    if(self.role == "defender") {
      var_1 = undefined;
      var_5 = 0;

      if(!isDefined(var_2)) {
        var_5 = 1;
      } else if(isDefined(level.currentobjective.trigger)) {
        if(var_2 != level.currentobjective.trigger) {
          var_5 = 1;
        }
      }

      if(var_5) {
        var_6 = getnodesintrigger(level.currentobjective.trigger);

        if(var_6.size > 0) {
          GscBinSkip1(0x45, "min_goal_time", 3);
        }
      }
    }
  }
}

function bot_attacker_limit_for_team(var_0) {
  var_1 = get_num_players_on_team(var_0);
  return int(int(var_1) / 2) + 1 + int(var_1) % 2;
}

function bot_defender_limit_for_team(var_0) {
  var_1 = get_num_players_on_team(var_0);
  return max(int(int(var_1) / 2) - 1, 0);
}

function get_num_players_on_team(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function get_allied_attackers_for_team(var_0) {
  var_1 = get_players_by_role("attacker", var_0);

  if(isDefined(level.currentobjective.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(!var_3 istouching(level.currentobjective.trigger)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

function get_allied_defenders_for_team(var_0) {
  var_1 = get_players_by_role("defender", var_0);

  if(isDefined(level.currentobjective.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(var_3 istouching(level.currentobjective.trigger)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

function get_players_by_role(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && var_4.team == var_1 && isDefined(var_4.role) && var_4.role == var_0) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function bot_set_role(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

function is_b_better_defender(var_0, var_1) {
  var_2 = var_0 istouching(level.currentobjective.trigger);
  var_3 = var_1 istouching(level.currentobjective.trigger);

  if(var_2 != var_3) {
    if(var_2) {
      return false;
    }

    return true;
  }

  if(var_2) {
    if(var_0.role != var_1.role) {
      if(var_1.role == "defender") {
        return true;
      }

      return false;
    }
  }

  var_4 = distance2dsquared(var_0.origin, level.currentobjective.trigger.origin);
  var_5 = distance2dsquared(var_1.origin, level.currentobjective.trigger.origin);

  if(var_4 < var_5) {
    return true;
  }

  return false;
}

function bot_hardpoint_ai_director_update() {
  level notify("bot_hardpoint_ai_director_update");
  level endon("bot_hardpoint_ai_director_update");
  level endon("game_ended");
  GscBinSkip1(0x45, 0, "allies");
}

function crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return false;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return false;
  }

  return !scripts\mp\bots\bots_util::bot_is_defending() || scripts\mp\bots\bots_util::bot_is_protecting();
}

function setup_bot_koth() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.objectives)) {
    wait 0.05;
  }

  scripts\mp\bots\bots_gametype_common::bot_setup_objective_bottargets();

  foreach(var_1 in level.objectives) {
    var_1 thread scripts\mp\bots\bots_gametype_common::monitor_zone_control();
  }

  scripts\mp\bots\bots_gametype_common::bot_cache_entrances_to_gametype_array(level.objectives, "radio", level.bot_ignore_precalc_paths);
  level.bot_gametype_precaching_done = 1;
}

function bot_headquarters_think() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("grenade_objectives", 1);
  init_bot_game_headquarters();

  for(;;) {
    var_0 = randomintrange(1, 11) * 0.05;
    wait var_0;

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(level.radioobject)) {
      if(scripts\mp\bots\bots_util::bot_is_defending()) {
        scripts\mp\bots\bots_strategy::bot_defend_stop();
      }

      var_1 = 1;

      if(self botgetscriptgoaltype() != "none") {
        var_2 = distancesquared(self botgetscriptgoal(), self.origin);
        var_3 = self botgetscriptgoalRadius();

        if(var_2 > var_3 * var_3) {
          var_1 = 0;
        }
      }

      if(var_1) {
        var_4 = self botfindrandomgoal();

        if(isDefined(var_4)) {
          self botsetscriptgoal(var_4, 128, "hunt");
        }
      }

      continue;
    }

    var_5 = level.radioobject scripts\mp\gameobjects::getownerteam();

    if(self.team != var_5) {
      if(!is_capturing_current_headquarters()) {
        var_6 = get_num_ai_capturing_headquarters();
        var_7 = find_current_radio().bot_nodes.size;

        if(var_6 < var_7) {
          capture_current_headquarters();
        } else if(!is_protecting_current_headquarters()) {
          protect_current_headquarters();
        }
      }
    } else if(!is_protecting_current_headquarters()) {
      wait randomfloat(2);

      if(isDefined(level.radioobject)) {
        protect_current_headquarters();
      }
    }
  }
}

function find_current_radio() {
  foreach(var_1 in level.radios) {
    if(var_1.trig == level.radioobject.trigger) {
      return var_1;
    }
  }
}

function is_capturing_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_capturing();
}

function get_num_ai_capturing_headquarters() {
  var_0 = 0;

  foreach(var_2 in level.participants) {
    if(isai(var_2) && var_2.health > 0 && var_2.team == self.team && is_capturing_current_headquarters(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

function capture_current_headquarters() {
  var_0 = find_current_radio();
  GscBinSkip1(0x45, "entrance_points_index", "radio" + var_0.objectivekey);
}

function is_protecting_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

function protect_current_headquarters() {
  var_0 = self botgetworldsize();
  var_1 = (var_0[0] + var_0[1]) / 2;
  var_2 = min(1000, var_1 / 4);
  scripts\mp\bots\bots_strategy::bot_protect_point(find_current_radio().origin, var_2);
}

function init_bot_game_headquarters() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;

  foreach(var_1 in level.radios) {
    var_1.bot_nodes = getnodesintrigger(var_1.trig);
  }
}