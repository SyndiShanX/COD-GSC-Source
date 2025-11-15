/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = get_allied_attackers_for_team(self.team);
  var_01 = get_allied_defenders_for_team(self.team);
  var_02 = bot_attacker_limit_for_team(self.team);
  var_03 = bot_defender_limit_for_team(self.team);
  var_04 = level.bot_personality_type[self.personality];
  if(var_04 == "active") {
    if(var_00.size >= var_02) {
      var_05 = 0;
      foreach(var_07 in var_00) {
        if(isai(var_07) && level.bot_personality_type[var_07.personality] == "stationary") {
          var_07.role = undefined;
          var_05 = 1;
          break;
        }
      }

      if(var_05) {
        bot_set_role("attacker");
        return;
      }

      bot_set_role("defender");
      return;
    }

    bot_set_role("attacker");
    return;
  }

  if(var_04 == "stationary") {
    if(var_01.size >= var_03) {
      var_05 = 0;
      foreach(var_0A in var_01) {
        if(isai(var_0A) && level.bot_personality_type[var_0A.personality] == "active") {
          var_0A.role = undefined;
          var_05 = 1;
          break;
        }
      }

      if(var_05) {
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
  var_00 = undefined;
  var_01 = undefined;
  for(;;) {
    wait(0.05);
    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
      continue;
    }

    if(!isDefined(self.role)) {
      func_986A();
    }

    if(!scripts\engine\utility::istrue(self.bot_defending)) {
      var_00 = undefined;
      var_01 = undefined;
    }

    if(self.role == "attacker") {
      var_02 = 0;
      var_01 = undefined;
      if(!isDefined(var_00)) {
        var_02 = 1;
      } else if(isDefined(level.zone.gameobject.trigger)) {
        if(var_00 != level.zone.gameobject.trigger) {
          var_02 = 1;
        }
      }

      if(var_02) {
        var_03 = getclosestpointonnavmesh(level.zone.gameobject.trigger.origin, self);
        var_04["min_goal_time"] = 1;
        var_04["max_goal_time"] = 4;
        scripts\mp\bots\_bots_strategy::bot_patrol_area(var_03, level.var_C992, var_04);
        var_00 = level.zone.gameobject.trigger;
      }

      continue;
    }

    if(self.role == "defender") {
      var_00 = undefined;
      var_05 = 0;
      if(!isDefined(var_01)) {
        var_05 = 1;
      } else if(isDefined(level.zone.gameobject.trigger)) {
        if(var_01 != level.zone.gameobject.trigger) {
          var_05 = 1;
        }
      }

      if(var_05) {
        var_06 = getnodesintrigger(level.zone.gameobject.trigger);
        if(var_06.size > 0) {
          var_04["min_goal_time"] = 3;
          var_04["max_goal_time"] = 6;
          scripts\mp\bots\_bots_strategy::bot_capture_zone(level.zone.gameobject.trigger.origin, var_06, level.zone.gameobject.trigger, var_04);
          var_01 = level.zone.gameobject.trigger;
        }
      }
    }
  }
}

bot_attacker_limit_for_team(param_00) {
  var_01 = func_7B3C(param_00);
  return int(int(var_01) / 2) + 1 + int(var_01) % 2;
}

bot_defender_limit_for_team(param_00) {
  var_01 = func_7B3C(param_00);
  return max(int(int(var_01) / 2) - 1, 0);
}

func_7B3C(param_00) {
  var_01 = 0;
  foreach(var_03 in level.participants) {
    if(scripts\mp\utility::isteamparticipant(var_03) && isDefined(var_03.team) && var_03.team == param_00) {
      var_01++;
    }
  }

  return var_01;
}

get_allied_attackers_for_team(param_00) {
  var_01 = get_players_by_role("attacker", param_00);
  if(isDefined(level.zone.gameobject.trigger)) {
    foreach(var_03 in level.players) {
      if(!isai(var_03) && isDefined(var_03.team) && var_03.team == param_00) {
        if(!var_03 istouching(level.zone.gameobject.trigger)) {
          var_01 = scripts\engine\utility::array_add(var_01, var_03);
        }
      }
    }
  }

  return var_01;
}

get_allied_defenders_for_team(param_00) {
  var_01 = get_players_by_role("defender", param_00);
  if(isDefined(level.zone.gameobject.trigger)) {
    foreach(var_03 in level.players) {
      if(!isai(var_03) && isDefined(var_03.team) && var_03.team == param_00) {
        if(var_03 istouching(level.zone.gameobject.trigger)) {
          var_01 = scripts\engine\utility::array_add(var_01, var_03);
        }
      }
    }
  }

  return var_01;
}

get_players_by_role(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in level.participants) {
    if(!isDefined(var_04.team)) {
      continue;
    }

    if(isalive(var_04) && scripts\mp\utility::isteamparticipant(var_04) && var_04.team == param_01 && isDefined(var_04.role) && var_04.role == param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

bot_set_role(param_00) {
  self.role = param_00;
  self botclearscriptgoal();
  scripts\mp\bots\_bots_strategy::bot_defend_stop();
}

func_9B74(param_00, param_01) {
  var_02 = param_00 istouching(level.zone.gameobject.trigger);
  var_03 = param_01 istouching(level.zone.gameobject.trigger);
  if(var_02 != var_03) {
    if(var_02) {
      return 0;
    }

    return 1;
  }

  if(var_02) {
    if(param_00.role != param_01.role) {
      if(param_01.role == "defender") {
        return 1;
      }

      return 0;
    }
  }

  var_04 = distance2dsquared(param_00.origin, level.zone.gameobject.trigger.origin);
  var_05 = distance2dsquared(param_01.origin, level.zone.gameobject.trigger.origin);
  if(var_04 < var_05) {
    return 1;
  }

  return 0;
}

func_2DC3() {
  level notify("bot_hardpoint_ai_director_update");
  level endon("bot_hardpoint_ai_director_update");
  level endon("game_ended");
  var_00[0] = "allies";
  var_00[1] = "axis";
  var_01["allies"] = 0;
  var_01["axis"] = 0;
  for(;;) {
    var_02 = "neutral";
    if(isDefined(level.zone.gameobject.trigger)) {
      var_02 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
    }

    foreach(var_04 in var_00) {
      var_05 = [];
      var_06 = [];
      if(var_04 != var_02) {
        var_01[var_04] = 0;
        foreach(var_08 in level.participants) {
          if(scripts\mp\utility::isteamparticipant(var_08) && isDefined(var_08.team) && var_08.team == var_04) {
            if(isbot(var_08) && !isDefined(var_08.role) || var_08.role != "defender") {
              var_08 bot_set_role("defender");
            }
          }
        }

        continue;
      }

      var_0A = bot_attacker_limit_for_team(var_04);
      var_0B = bot_defender_limit_for_team(var_04);
      if(!var_01[var_04]) {
        var_01[var_04] = 1;
        var_0C = [];
        foreach(var_08 in level.participants) {
          if(scripts\mp\utility::isteamparticipant(var_08) && isDefined(var_08.team) && var_08.team == var_04) {
            if(isbot(var_08)) {
              var_0C[var_0C.size] = var_08;
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

      var_11 = get_allied_attackers_for_team(var_04);
      var_12 = get_allied_defenders_for_team(var_04);
      if(var_11.size > var_0A) {
        var_13 = 0;
        foreach(var_15 in var_11) {
          if(isai(var_15)) {
            if(level.bot_personality_type[var_15.personality] == "stationary") {
              var_15 bot_set_role("defender");
              var_13 = 1;
              break;
            } else {
              var_05 = scripts\engine\utility::array_add(var_05, var_15);
            }
          }
        }

        if(!var_13 && var_05.size > 0) {
          scripts\engine\utility::random(var_05) bot_set_role("defender");
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
              var_06 = scripts\engine\utility::array_add(var_06, var_19);
            }
          }
        }

        if(!var_17 && var_06.size > 0) {
          scripts\engine\utility::random(var_06) bot_set_role("attacker");
        }
      }

      if(var_12.size == 0) {
        var_1B = get_players_by_role("attacker", var_04);
        if(var_1B.size > 0) {
          scripts\engine\utility::random(var_1B) bot_set_role("defender");
        }
      }
    }

    wait(1);
  }
}

crate_can_use(param_00) {
  if(isagent(self) && !isDefined(param_00.boxtype)) {
    return 0;
  }

  if(isDefined(param_00.cratetype) && !scripts\mp\bots\_bots_killstreaks::bot_is_killstreak_supported(param_00.cratetype)) {
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
    var_00 = 0;
    if(isDefined(level.var_DBFD) && self.var_1270F == level.var_DBFD.trigger) {
      var_01 = level.var_DBFD scripts\mp\gameobjects::getownerteam();
      if(var_01 != "neutral") {
        var_02 = getzonenearest(self.origin);
        if(isDefined(var_02)) {
          botzonesetteam(var_02, var_01);
          var_00 = 1;
        }
      }
    }

    if(!var_00) {
      var_02 = getzonenearest(self.origin);
      if(isDefined(var_02)) {
        botzonesetteam(var_02, "free");
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
  for(var_00 = 0; var_00 < level.radios.size; var_00++) {
    level.radios[var_00].script_label = "_" + var_00;
    level.radios[var_00] thread monitor_zone_control();
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
    var_00 = randomintrange(1, 11) * 0.05;
    wait(var_00);
    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(level.var_DBFD)) {
      if(scripts\mp\bots\_bots_util::bot_is_defending()) {
        scripts\mp\bots\_bots_strategy::bot_defend_stop();
      }

      var_01 = 1;
      if(self botgetscriptgoaltype() != "none") {
        var_02 = distancesquared(self botgetscriptgoal(), self.origin);
        var_03 = self botgetscriptgoalradius();
        if(var_02 > var_03 * var_03) {
          var_01 = 0;
        }
      }

      if(var_01) {
        var_04 = self botfindnoderandom();
        if(isDefined(var_04)) {
          self botsetscriptgoal(var_04.origin, 128, "hunt");
        }
      }

      continue;
    }

    var_05 = level.var_DBFD scripts\mp\gameobjects::getownerteam();
    if(self.team != var_05) {
      if(!func_9B83()) {
        var_06 = func_7B2C();
        var_07 = find_current_radio().var_2E28.size;
        if(var_06 < var_07) {
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
  foreach(var_01 in level.radios) {
    if(var_01.var_1270F == level.var_DBFD.trigger) {
      return var_01;
    }
  }
}

func_9B83() {
  return scripts\mp\bots\_bots_util::bot_is_capturing();
}

func_7B2C() {
  var_00 = 0;
  foreach(var_02 in level.participants) {
    if(isai(var_02) && var_02.health > 0 && var_02.team == self.team && var_02 func_9B83()) {
      var_00++;
    }
  }

  return var_00;
}

func_3A36() {
  var_00 = find_current_radio();
  var_01["entrance_points_index"] = "radio" + var_00.script_label;
  scripts\mp\bots\_bots_strategy::bot_capture_zone(var_00.origin, var_00.var_2E28, undefined, var_01);
}

func_9C94() {
  return scripts\mp\bots\_bots_util::bot_is_protecting();
}

func_DAA1() {
  var_00 = self botgetworldsize();
  var_01 = var_00[0] + var_00[1] / 2;
  var_02 = min(1000, var_01 / 4);
  scripts\mp\bots\_bots_strategy::bot_protect_point(find_current_radio().origin, var_02);
}

init_bot_game_headquarters() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
  foreach(var_01 in level.radios) {
    var_01.var_2E28 = getnodesintrigger(var_01.var_1270F);
  }
}