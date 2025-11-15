/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_ball.gsc
*********************************************/

main() {
  setup_callbacks();
  setup_bot_ball();
  thread monitor_ball_carrier();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::func_2D12;
}

setup_bot_ball() {
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 600;
  level.bodyguard_radius = 400;
  thread func_2D11();
  level.bot_gametype_precaching_done = 1;
}

bot_get_available_ball() {
  foreach(var_01 in level.balls) {
    if(isDefined(var_01.carrier)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_01.in_goal)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_01.isresetting)) {
      continue;
    }

    return var_01;
  }

  return undefined;
}

bot_get_ball_carrier() {
  foreach(var_01 in level.balls) {
    if(isDefined(var_01.carrier)) {
      return var_01.carrier;
    }
  }

  return undefined;
}

bot_do_doublejump() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetstance("stand");
  for(var_00 = 0; var_00 < 5; var_00++) {
    self botpressbutton("jump");
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  for(var_00 = 0; var_00 < 60; var_00++) {
    self botpressbutton("jump");
    scripts\engine\utility::waitframe();
    if(!isDefined(self.carryobject)) {
      break;
    }
  }
}

bot_throw_ball() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(var_00 = 0; var_00 < 5; var_00++) {
    self botpressbutton("attack");
    scripts\engine\utility::waitframe();
  }
}

bot_get_enemy_team() {
  if(self.team == "allies") {
    return "axis";
  }

  return "allies";
}

func_2D12() {
  self notify("bot_ball_think");
  self endon("bot_ball_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self botsetflag("separation", 0);
  var_00 = undefined;
  var_01 = undefined;
  for(;;) {
    wait(0.05);
    if(!isDefined(self.role)) {
      initialize_ball_role();
      var_00 = undefined;
    }

    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
      var_00 = undefined;
      continue;
    }

    if(self.role != "carrier" && isDefined(self.carryobject)) {
      var_00 = undefined;
      ball_set_role("carrier");
    }

    if(self.role == "carrier") {
      if(isDefined(self.carryobject)) {
        self botsetflag("disable_attack", 1);
        var_02 = 0;
        if(isDefined(self.isnodeoccupied)) {
          var_02 = distancesquared(self.isnodeoccupied.origin, self.origin);
        }

        if(isDefined(self.isnodeoccupied) && var_02 < 9216) {
          self botsetflag("disable_attack", 0);
          self botsetflag("prefer_melee", 1);
        } else {
          self botsetflag("prefer_melee", 0);
          self botsetflag("disable_attack", 1);
        }

        if(isDefined(level.ball_goals)) {
          var_03 = level.ball_goals[bot_get_enemy_team()].origin;
          if(!isDefined(var_00)) {
            var_00 = getclosestpointonnavmesh(var_03, self);
            if(distance2dsquared(var_00, var_03) > 256) {
              var_04 = (var_03[0], var_03[1], var_03[2] - 90);
              var_00 = getclosestpointonnavmesh(var_04, self);
            }
          }

          self botsetscriptgoal(var_00, 16, "critical");
          var_05 = distance2dsquared(self.origin, var_03);
          if(var_05 < 30625) {
            var_06 = self getEye();
            var_07 = var_03;
            if(scripts\common\trace::ray_trace_passed(var_06, var_07, self)) {
              if(var_05 < 256) {
                self botsetscriptgoal(self.origin, 16, "critical");
                wait(0.25);
              }

              bot_do_doublejump();
              wait(0.2);
              if(!isDefined(self.carryobject)) {
                self botclearscriptgoal();
              }
            }
          }
        } else {
          self botclearscriptgoal();
          if(!isDefined(var_01)) {
            var_01 = gettime() + randomintrange(500, 1000);
          }

          if(gettime() > var_01) {
            var_01 = gettime() + randomintrange(500, 1000);
            if(isDefined(self.isnodeoccupied)) {
              if(self botcanseeentity(self.isnodeoccupied)) {
                var_08 = anglesToForward(self.angles);
                var_09 = self.isnodeoccupied.origin - self.origin;
                var_0A = vectornormalize((var_09[0], var_09[1], 0));
                var_0B = vectordot(var_08, var_0A);
                if(var_0B > 0.707) {
                  if(var_02 < -7936 && var_02 > 9216) {
                    bot_throw_ball();
                  }
                }
              }
            }
          }
        }
      } else {
        self botsetflag("disable_attack", 0);
        self botsetflag("prefer_melee", 0);
        var_0C = bot_get_available_ball();
        if(!isDefined(var_0C)) {
          var_0D = bot_get_ball_carrier();
          if(isDefined(var_0D) && var_0D != self) {
            initialize_ball_role();
          }
        } else {
          self botsetscriptgoal(var_0D.curorigin, 16, "objective");
          continue;
        }
      }
    } else {
      var_00 = undefined;
    }

    if(self.role == "attacker") {
      self botsetflag("disable_attack", 0);
      self botsetflag("prefer_melee", 0);
      var_0C = bot_get_available_ball();
      if(!isDefined(var_0C)) {
        var_0D = bot_get_ball_carrier();
        if(isDefined(var_0D)) {
          if(!scripts\mp\bots\_bots_util::bot_is_guarding_player(var_0D)) {
            scripts\mp\bots\_bots_strategy::bot_guard_player(var_0D, level.bodyguard_radius);
          }
        }
      } else if(!scripts\engine\utility::istrue(var_0C.isresetting) && !scripts\engine\utility::istrue(var_0C.in_goal)) {
        var_0E = getclosestpointonnavmesh(var_0C.curorigin);
        if(!scripts\mp\bots\_bots_util::bot_is_defending_point(var_0E)) {
          scripts\mp\bots\_bots_strategy::bot_protect_point(var_0E, level.protect_radius);
        }
      }

      continue;
    }

    if(self.role == "defender") {
      self botsetflag("disable_attack", 0);
      self botsetflag("prefer_melee", 0);
      var_0F = level.ball_goals[self.team];
      var_03 = var_0F.origin;
      if(!scripts\mp\bots\_bots_util::bot_is_defending_point(var_03)) {
        scripts\mp\bots\_bots_strategy::bot_protect_point(var_03, level.protect_radius);
      }
    }
  }
}

initialize_ball_role() {
  var_00 = get_allied_attackers_for_team(self.team);
  var_01 = get_allied_defenders_for_team(self.team);
  var_02 = ball_bot_attacker_limit_for_team(self.team);
  var_03 = ball_bot_defender_limit_for_team(self.team);
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
        ball_set_role("attacker");
        return;
      }

      ball_set_role("defender");
      return;
    }

    ball_set_role("attacker");
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
        ball_set_role("defender");
        return;
      }

      ball_set_role("attacker");
      return;
    }

    ball_set_role("defender");
    return;
  }
}

func_2D11() {
  level notify("bot_ball_ai_director_update");
  level endon("bot_ball_ai_director_update");
  level endon("game_ended");
  var_00[0] = "allies";
  var_00[1] = "axis";
  var_01 = [];
  for(;;) {
    foreach(var_03 in var_00) {
      var_04 = ball_bot_attacker_limit_for_team(var_03);
      var_05 = ball_bot_defender_limit_for_team(var_03);
      var_06 = get_allied_attackers_for_team(var_03);
      var_07 = get_allied_defenders_for_team(var_03);
      if(var_06.size > var_04) {
        var_08 = [];
        var_09 = 0;
        foreach(var_0B in var_06) {
          if(isai(var_0B)) {
            if(level.bot_personality_type[var_0B.personality] == "stationary") {
              var_0B ball_set_role("defender");
              var_09 = 1;
              break;
            } else {
              var_08 = scripts\engine\utility::array_add(var_08, var_0B);
            }
          }
        }

        if(!var_09 && var_08.size > 0) {
          scripts\engine\utility::random(var_08) ball_set_role("defender");
        }
      }

      if(var_07.size > var_05) {
        var_0D = [];
        var_0E = 0;
        foreach(var_10 in var_07) {
          if(isai(var_10)) {
            if(level.bot_personality_type[var_10.personality] == "active") {
              var_10 ball_set_role("attacker");
              var_0E = 1;
              break;
            } else {
              var_0D = scripts\engine\utility::array_add(var_0D, var_10);
            }
          }
        }

        if(!var_0E && var_0D.size > 0) {
          scripts\engine\utility::random(var_0D) ball_set_role("attacker");
        }
      }

      var_12 = bot_get_available_ball();
      if(isDefined(var_12)) {
        var_13 = pick_ball_carrier(var_03, var_12);
        if(isDefined(var_13) && isDefined(var_13.role) && var_13.role != "carrier") {
          if(!isDefined(var_13.carryobject)) {
            var_14 = var_01[var_03];
            if(isDefined(var_14)) {
              var_14 ball_set_role(undefined);
            }

            var_13 ball_set_role("carrier");
            var_01[var_13.team] = var_13;
          }
        }
      }
    }

    wait(1);
  }
}

ball_bot_attacker_limit_for_team(param_00) {
  var_01 = ball_get_num_players_on_team(param_00);
  if(!isDefined(level.ball_goals)) {
    return var_01;
  }

  return int(int(var_01) / 2) + 1 + int(var_01) % 2;
}

ball_bot_defender_limit_for_team(param_00) {
  if(!isDefined(level.ball_goals)) {
    return 0;
  }

  var_01 = ball_get_num_players_on_team(param_00);
  return max(int(int(var_01) / 2) - 1, 0);
}

ball_get_num_players_on_team(param_00) {
  var_01 = 0;
  foreach(var_03 in level.participants) {
    if(scripts\mp\utility::isteamparticipant(var_03) && isDefined(var_03.team) && var_03.team == param_00) {
      var_01++;
    }
  }

  return var_01;
}

pick_ball_carrier(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in level.participants) {
    if(!isDefined(var_05.team)) {
      continue;
    }

    if(var_05.team != param_00) {
      continue;
    }

    if(!isalive(var_05)) {
      continue;
    }

    if(!isai(var_05)) {
      continue;
    }

    if(isDefined(var_05.role) && var_05.role == "defender") {
      continue;
    }

    var_06 = distancesquared(var_05.origin, param_01.curorigin);
    if(!isDefined(var_03) || var_06 < var_03) {
      var_03 = var_06;
      var_02 = var_05;
    }
  }

  if(isDefined(var_02)) {
    return var_02;
  }

  return undefined;
}

get_allied_attackers_for_team(param_00) {
  var_01 = get_players_by_role("attacker", param_00);
  if(isDefined(level.ball_goals)) {
    foreach(var_03 in level.players) {
      if(!isai(var_03) && isDefined(var_03.team) && var_03.team == param_00) {
        if(distancesquared(level.ball_goals[param_00].origin, var_03.origin) > level.protect_radius * level.protect_radius) {
          var_01 = scripts\engine\utility::array_add(var_01, var_03);
        }
      }
    }
  }

  return var_01;
}

get_allied_defenders_for_team(param_00) {
  var_01 = get_players_by_role("defender", param_00);
  if(isDefined(level.ball_goals)) {
    foreach(var_03 in level.players) {
      if(!isai(var_03) && isDefined(var_03.team) && var_03.team == param_00) {
        if(distancesquared(level.ball_goals[param_00].origin, var_03.origin) <= level.protect_radius * level.protect_radius) {
          var_01 = scripts\engine\utility::array_add(var_01, var_03);
        }
      }
    }
  }

  return var_01;
}

ball_set_role(param_00) {
  self.role = param_00;
  self botclearscriptgoal();
  scripts\mp\bots\_bots_strategy::bot_defend_stop();
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

monitor_ball_carrier() {
  level endon("game_ended");
  var_00 = undefined;
  for(;;) {
    var_01 = bot_get_ball_carrier();
    if(!isDefined(var_00) || !isDefined(var_01) || var_01 != var_00) {
      if(isDefined(var_00) && var_00.var_33F == 505) {
        var_00.var_33F = 0;
      }

      var_00 = var_01;
    }

    if(isDefined(var_01) && var_01.var_33F == 0) {
      var_01.var_33F = 505;
    }

    wait(0.05);
  }
}