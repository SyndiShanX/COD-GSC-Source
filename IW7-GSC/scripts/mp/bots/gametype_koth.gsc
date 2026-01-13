/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_koth.gsc
*********************************************/

main() {
  setup_callbacks();
  setup_bot_koth();
}

setup_bot_koth() {
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled(1);
  thread func_2DC3();
  level.protect_radius = 128;
  level.var_C992 = 800;
  level.bot_gametype_precaching_done = 1;
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::func_2DC4;
}

func_986A() {
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
      foreach(var_0A in var_1) {
        if(isai(var_0A) && level.bot_personality_type[var_0A.personality] == "active") {
          var_0A.role = undefined;
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

func_2DC4() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botclearscriptgoal();
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self botsetflag("separation", 0);
  var_0 = undefined;
  var_1 = undefined;
  for(;;) {
    wait(0.05);
    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
      continue;
    }

    if(!isDefined(self.role)) {
      func_986A();
    }

    if(!scripts\engine\utility::istrue(self.bot_defending)) {
      var_0 = undefined;
      var_1 = undefined;
    }

    if(self.role == "attacker") {
      var_2 = 0;
      var_1 = undefined;
      if(!isDefined(var_0)) {
        var_2 = 1;
      } else if(isDefined(level.zone.gameobject.trigger)) {
        if(var_0 != level.zone.gameobject.trigger) {
          var_2 = 1;
        }
      }

      if(var_2) {
        var_3 = getclosestpointonnavmesh(level.zone.gameobject.trigger.origin, self);
        var_4["min_goal_time"] = 1;
        var_4["max_goal_time"] = 4;
        scripts\mp\bots\_bots_strategy::bot_patrol_area(var_3, level.var_C992, var_4);
        var_0 = level.zone.gameobject.trigger;
      }

      continue;
    }

    if(self.role == "defender") {
      var_0 = undefined;
      var_5 = 0;
      if(!isDefined(var_1)) {
        var_5 = 1;
      } else if(isDefined(level.zone.gameobject.trigger)) {
        if(var_1 != level.zone.gameobject.trigger) {
          var_5 = 1;
        }
      }

      if(var_5) {
        var_6 = getnodesintrigger(level.zone.gameobject.trigger);
        if(var_6.size > 0) {
          var_4["min_goal_time"] = 3;
          var_4["max_goal_time"] = 6;
          scripts\mp\bots\_bots_strategy::bot_capture_zone(level.zone.gameobject.trigger.origin, var_6, level.zone.gameobject.trigger, var_4);
          var_1 = level.zone.gameobject.trigger;
        }
      }
    }
  }
}

bot_attacker_limit_for_team(var_0) {
  var_1 = func_7B3C(var_0);
  return int(int(var_1) / 2) + 1 + int(var_1) % 2;
}

bot_defender_limit_for_team(var_0) {
  var_1 = func_7B3C(var_0);
  return max(int(int(var_1) / 2) - 1, 0);
}

func_7B3C(var_0) {
  var_1 = 0;
  foreach(var_3 in level.participants) {
    if(scripts\mp\utility::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

get_allied_attackers_for_team(var_0) {
  var_1 = get_players_by_role("attacker", var_0);
  if(isDefined(level.zone.gameobject.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(!var_3 istouching(level.zone.gameobject.trigger)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

get_allied_defenders_for_team(var_0) {
  var_1 = get_players_by_role("defender", var_0);
  if(isDefined(level.zone.gameobject.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(var_3 istouching(level.zone.gameobject.trigger)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

get_players_by_role(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }

    if(isalive(var_4) && scripts\mp\utility::isteamparticipant(var_4) && var_4.team == var_1 && isDefined(var_4.role) && var_4.role == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

bot_set_role(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\_bots_strategy::bot_defend_stop();
}

func_9B74(var_0, var_1) {
  var_2 = var_0 istouching(level.zone.gameobject.trigger);
  var_3 = var_1 istouching(level.zone.gameobject.trigger);
  if(var_2 != var_3) {
    if(var_2) {
      return 0;
    }

    return 1;
  }

  if(var_2) {
    if(var_0.role != var_1.role) {
      if(var_1.role == "defender") {
        return 1;
      }

      return 0;
    }
  }

  var_4 = distance2dsquared(var_0.origin, level.zone.gameobject.trigger.origin);
  var_5 = distance2dsquared(var_1.origin, level.zone.gameobject.trigger.origin);
  if(var_4 < var_5) {
    return 1;
  }

  return 0;
}

func_2DC3() {
  level notify("bot_hardpoint_ai_director_update");
  level endon("bot_hardpoint_ai_director_update");
  level endon("game_ended");
  var_0[0] = "allies";
  var_0[1] = "axis";
  var_1["allies"] = 0;
  var_1["axis"] = 0;
  for(;;) {
    var_2 = "neutral";
    if(isDefined(level.zone.gameobject.trigger)) {
      var_2 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
    }

    foreach(var_4 in var_0) {
      var_5 = [];
      var_6 = [];
      if(var_4 != var_2) {
        var_1[var_4] = 0;
        foreach(var_8 in level.participants) {
          if(scripts\mp\utility::isteamparticipant(var_8) && isDefined(var_8.team) && var_8.team == var_4) {
            if(isbot(var_8) && !isDefined(var_8.role) || var_8.role != "defender") {
              var_8 bot_set_role("defender");
            }
          }
        }

        continue;
      }

      var_0A = bot_attacker_limit_for_team(var_4);
      var_0B = bot_defender_limit_for_team(var_4);
      if(!var_1[var_4]) {
        var_1[var_4] = 1;
        var_0C = [];
        foreach(var_8 in level.participants) {
          if(scripts\mp\utility::isteamparticipant(var_8) && isDefined(var_8.team) && var_8.team == var_4) {
            if(isbot(var_8)) {
              var_0C[var_0C.size] = var_8;
            }
          }
        }

        var_0F = scripts\engine\utility::array_sort_with_func(var_0C, ::func_9B74);
        if(var_0C.size < var_0B) {
          var_0B = var_0C.size;
        }

        var_0B = int(var_0B);
        for(var_10 = 0; var_10 < var_0B; var_10++) {
          var_0C[var_10] bot_set_role("defender");
        }

        for(var_10 = var_0B; var_10 < var_0C.size; var_10++) {
          var_0C[var_10] bot_set_role("attacker");
        }

        wait(1);
        continue;
      }

      var_11 = get_allied_attackers_for_team(var_4);
      var_12 = get_allied_defenders_for_team(var_4);
      if(var_11.size > var_0A) {
        var_13 = 0;
        foreach(var_15 in var_11) {
          if(isai(var_15)) {
            if(level.bot_personality_type[var_15.personality] == "stationary") {
              var_15 bot_set_role("defender");
              var_13 = 1;
              break;
            } else {
              var_5 = scripts\engine\utility::array_add(var_5, var_15);
            }
          }
        }

        if(!var_13 && var_5.size > 0) {
          scripts\engine\utility::random(var_5) bot_set_role("defender");
        }
      }

      if(var_12.size > var_0B) {
        var_17 = 0;
        foreach(var_19 in var_12) {
          if(isai(var_19)) {
            if(level.bot_personality_type[var_19.personality] == "active") {
              var_19 bot_set_role("attacker");
              var_17 = 1;
              break;
            } else {
              var_6 = scripts\engine\utility::array_add(var_6, var_19);
            }
          }
        }

        if(!var_17 && var_6.size > 0) {
          scripts\engine\utility::random(var_6) bot_set_role("attacker");
        }
      }

      if(var_12.size == 0) {
        var_1B = get_players_by_role("attacker", var_4);
        if(var_1B.size > 0) {
          scripts\engine\utility::random(var_1B) bot_set_role("defender");
        }
      }
    }

    wait(1);
  }
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype)) {
    return 0;
  }

  return !scripts\mp\bots\_bots_util::bot_is_defending() || scripts\mp\bots\_bots_util::bot_is_protecting();
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(1);
    var_0 = 0;
    if(isDefined(level.var_DBFD) && self.var_1270F == level.var_DBFD.trigger) {
      var_1 = level.var_DBFD scripts\mp\gameobjects::getownerteam();
      if(var_1 != "neutral") {
        var_2 = getzonenearest(self.origin);
        if(isDefined(var_2)) {
          botzonesetteam(var_2, var_1);
          var_0 = 1;
        }
      }
    }

    if(!var_0) {
      var_2 = getzonenearest(self.origin);
      if(isDefined(var_2)) {
        botzonesetteam(var_2, "free");
      }
    }
  }
}

func_F8DE() {
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled();
  while(!isDefined(level.radios)) {
    wait(0.05);
  }

  scripts\mp\bots\_bots_strategy::bot_setup_objective_bottargets();
  for(var_0 = 0; var_0 < level.radios.size; var_0++) {
    level.radios[var_0].script_label = "_" + var_0;
    level.radios[var_0] thread monitor_zone_control();
  }

  scripts\mp\bots\_bots_util::bot_cache_entrances_to_flags_or_radios(level.radios, "radio");
  level.bot_gametype_precaching_done = 1;
}

bot_headquarters_think() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self botsetflag("grenade_objectives", 1);
  init_bot_game_headquarters();
  for(;;) {
    var_0 = randomintrange(1, 11) * 0.05;
    wait(var_0);
    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(level.var_DBFD)) {
      if(scripts\mp\bots\_bots_util::bot_is_defending()) {
        scripts\mp\bots\_bots_strategy::bot_defend_stop();
      }

      var_1 = 1;
      if(self botgetscriptgoaltype() != "none") {
        var_2 = distancesquared(self botgetscriptgoal(), self.origin);
        var_3 = self botgetscriptgoalradius();
        if(var_2 > var_3 * var_3) {
          var_1 = 0;
        }
      }

      if(var_1) {
        var_4 = self botfindnoderandom();
        if(isDefined(var_4)) {
          self botsetscriptgoal(var_4.origin, 128, "hunt");
        }
      }

      continue;
    }

    var_5 = level.var_DBFD scripts\mp\gameobjects::getownerteam();
    if(self.team != var_5) {
      if(!func_9B83()) {
        var_6 = func_7B2C();
        var_7 = find_current_radio().var_2E28.size;
        if(var_6 < var_7) {
          func_3A36();
        } else if(!func_9C94()) {
          func_DAA1();
        }
      }
    } else if(!func_9C94()) {
      wait(randomfloat(2));
      if(isDefined(level.var_DBFD)) {
        func_DAA1();
      }
    }
  }
}

find_current_radio() {
  foreach(var_1 in level.radios) {
    if(var_1.var_1270F == level.var_DBFD.trigger) {
      return var_1;
    }
  }
}

func_9B83() {
  return scripts\mp\bots\_bots_util::bot_is_capturing();
}

func_7B2C() {
  var_0 = 0;
  foreach(var_2 in level.participants) {
    if(isai(var_2) && var_2.health > 0 && var_2.team == self.team && var_2 func_9B83()) {
      var_0++;
    }
  }

  return var_0;
}

func_3A36() {
  var_0 = find_current_radio();
  var_1["entrance_points_index"] = "radio" + var_0.script_label;
  scripts\mp\bots\_bots_strategy::bot_capture_zone(var_0.origin, var_0.var_2E28, undefined, var_1);
}

func_9C94() {
  return scripts\mp\bots\_bots_util::bot_is_protecting();
}

func_DAA1() {
  var_0 = self botgetworldsize();
  var_1 = var_0[0] + var_0[1] / 2;
  var_2 = min(1000, var_1 / 4);
  scripts\mp\bots\_bots_strategy::bot_protect_point(find_current_radio().origin, var_2);
}

init_bot_game_headquarters() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
  foreach(var_1 in level.radios) {
    var_1.var_2E28 = getnodesintrigger(var_1.var_1270F);
  }
}