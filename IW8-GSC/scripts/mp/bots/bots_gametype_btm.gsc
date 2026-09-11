/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_btm.gsc
*************************************************/

function main() {}

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
  var0 = get_allied_attackers_for_team(self.team);
  var1 = get_allied_defenders_for_team(self.team);
  var2 = bot_attacker_limit_for_team(self.team);
  var3 = bot_defender_limit_for_team(self.team);
  var4 = level.bot_personality_type[self.personality];

  if(var4 == "active") {
    if(var0.size >= var2) {
      var5 = 0;

      foreach(var7 in var0) {
        if(isai(var7) && level.bot_personality_type[var7.personality] == "stationary") {
          var7.role = undefined;
          var5 = 1;
          break;
        }
      }

      if(var5) {
        bot_set_role("attacker");
        return;
      }

      bot_set_role("defender");
      return;
    }

    bot_set_role("attacker");
    return;
  }

  if(var4 == "stationary") {
    if(var1.size >= var3) {
      var5 = 0;

      foreach(var10 in var1) {
        if(isai(var10) && level.bot_personality_type[var10.personality] == "active") {
          var10.role = undefined;
          var5 = 1;
          break;
        }
      }

      if(var5) {
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
  var0 = undefined;
  var1 = undefined;

  for(;;) {
    wait 0.05;

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      continue;
    }

    if(!isDefined(self.role)) {
      initialize_role();
    }

    if(!istrue(self.bot_defending)) {
      var0 = undefined;
      var1 = undefined;
    }

    if(self.role == "attacker") {
      var2 = 0;
      var1 = undefined;

      if(!isDefined(var0)) {
        var2 = 1;
      } else if(isDefined(level.zone.trigger)) {
        if(var0 != level.zone.trigger) {
          var2 = 1;
        }
      }

      if(var2) {
        var3 = getclosestpointonnavmesh(level.zone.trigger.origin, self);
        GscBinSkip1(0x45, "min_goal_time", 1);
      }

      continue;
    }

    if(self.role == "defender") {
      var1 = undefined;
      var5 = 0;

      if(!isDefined(var2)) {
        var5 = 1;
      } else if(isDefined(level.zone.trigger)) {
        if(var2 != level.zone.trigger) {
          var5 = 1;
        }
      }

      if(var5) {
        var6 = getnodesintrigger(level.zone.trigger);

        if(var6.size > 0) {
          GscBinSkip1(0x45, "min_goal_time", 3);
        }
      }
    }
  }
}

function bot_attacker_limit_for_team(var0) {
  var1 = get_num_players_on_team(var0);
  return int(int(var1) / 2) + 1 + int(var1) % 2;
}

function bot_defender_limit_for_team(var0) {
  var1 = get_num_players_on_team(var0);
  return max(int(int(var1) / 2) - 1, 0);
}

function get_num_players_on_team(var0) {
  var1 = 0;

  foreach(var3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var3) && isDefined(var3.team) && var3.team == var0) {
      var1++;
    }
  }

  return var1;
}

function get_allied_attackers_for_team(var0) {
  var1 = get_players_by_role("attacker", var0);

  if(isDefined(level.zone.trigger)) {
    foreach(var3 in level.players) {
      if(!isai(var3) && isDefined(var3.team) && var3.team == var0) {
        if(!var3 istouching(level.zone.trigger)) {
          var1 = scripts\engine\utility::array_add(var1, var3);
        }
      }
    }
  }

  return var1;
}

function get_allied_defenders_for_team(var0) {
  var1 = get_players_by_role("defender", var0);

  if(isDefined(level.zone.trigger)) {
    foreach(var3 in level.players) {
      if(!isai(var3) && isDefined(var3.team) && var3.team == var0) {
        if(var3 istouching(level.zone.trigger)) {
          var1 = scripts\engine\utility::array_add(var1, var3);
        }
      }
    }
  }

  return var1;
}

function get_players_by_role(var0, var1) {
  var2 = [];

  foreach(var4 in level.participants) {
    if(!isDefined(var4.team)) {
      continue;
    }

    if(isalive(var4) && scripts\mp\utility\entity::isteamparticipant(var4) && var4.team == var1 && isDefined(var4.role) && var4.role == var0) {
      var2 = var4;
    }
  }

  return var2;
}

function bot_set_role(var0) {
  self.role = var0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

function is_b_better_defender(var0, var1) {
  var2 = var0 istouching(level.zone.trigger);
  var3 = var1 istouching(level.zone.trigger);

  if(var2 != var3) {
    if(var2) {
      return false;
    }

    return true;
  }

  if(var2) {
    if(var0.role != var1.role) {
      if(var1.role == "defender") {
        return true;
      }

      return false;
    }
  }

  var4 = distance2dsquared(var0.origin, level.zone.trigger.origin);
  var5 = distance2dsquared(var1.origin, level.zone.trigger.origin);

  if(var4 < var5) {
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

function crate_can_use(var0) {
  if(isagent(self) && !isDefined(var0.boxtype)) {
    return false;
  }

  if(isDefined(var0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var0.cratetype)) {
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

  foreach(var1 in level.objectives) {
    var1 thread scripts\mp\bots\bots_gametype_common::monitor_zone_control();
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
    var0 = randomintrange(1, 11) * 0.05;
    wait var0;

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(level.radioobject)) {
      if(scripts\mp\bots\bots_util::bot_is_defending()) {
        scripts\mp\bots\bots_strategy::bot_defend_stop();
      }

      var1 = 1;

      if(self botgetscriptgoaltype() != "none") {
        var2 = distancesquared(self botgetscriptgoal(), self.origin);
        var3 = self botgetscriptgoalRadius();

        if(var2 > var3 * var3) {
          var1 = 0;
        }
      }

      if(var1) {
        var4 = self botfindrandomgoal();

        if(isDefined(var4)) {
          self botsetscriptgoal(var4, 128, "hunt");
        }
      }

      continue;
    }

    var5 = level.radioobject scripts\mp\gameobjects::getownerteam();

    if(self.team != var5) {
      if(!is_capturing_current_headquarters()) {
        var6 = get_num_ai_capturing_headquarters();
        var7 = find_current_radio().bot_nodes.size;

        if(var6 < var7) {
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
  foreach(var1 in level.radios) {
    if(var1.trig == level.radioobject.trigger) {
      return var1;
    }
  }
}

function is_capturing_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_capturing();
}

function get_num_ai_capturing_headquarters() {
  var0 = 0;

  foreach(var2 in level.participants) {
    if(isai(var2) && var2.health > 0 && var2.team == self.team && is_capturing_current_headquarters(var2)) {
      var0++;
    }
  }

  return var0;
}

function capture_current_headquarters() {
  var0 = find_current_radio();
  GscBinSkip1(0x45, "entrance_points_index", "radio" + var0.objectivekey);
}

function is_protecting_current_headquarters() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

function protect_current_headquarters() {
  var0 = self botgetworldsize();
  var1 = (var0[0] + var0[1]) / 2;
  var2 = min(1000, var1 / 4);
  scripts\mp\bots\bots_strategy::bot_protect_point(find_current_radio().origin, var2);
}

function init_bot_game_headquarters() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;

  foreach(var1 in level.radios) {
    var1.bot_nodes = getnodesintrigger(var1.trig);
  }
}