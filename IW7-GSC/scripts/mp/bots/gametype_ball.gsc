/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  foreach(var_1 in level.balls) {
    if(isDefined(var_1.carrier)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_1.in_goal)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_1.isresetting)) {
      continue;
    }

    return var_1;
  }

  return undefined;
}

bot_get_ball_carrier() {
  foreach(var_1 in level.balls) {
    if(isDefined(var_1.carrier)) {
      return var_1.carrier;
    }
  }

  return undefined;
}

bot_do_doublejump() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetstance("stand");
  for(var_0 = 0; var_0 < 5; var_0++) {
    self botpressbutton("jump");
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  for(var_0 = 0; var_0 < 60; var_0++) {
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
  for(var_0 = 0; var_0 < 5; var_0++) {
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
  var_0 = undefined;
  var_1 = undefined;
  for(;;) {
    wait(0.05);
    if(!isDefined(self.role)) {
      initialize_ball_role();
      var_0 = undefined;
    }

    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
      var_0 = undefined;
      continue;
    }

    if(self.role != "carrier" && isDefined(self.carryobject)) {
      var_0 = undefined;
      ball_set_role("carrier");
    }

    if(self.role == "carrier") {
      if(isDefined(self.carryobject)) {
        self botsetflag("disable_attack", 1);
        var_2 = 0;
        if(isDefined(self.isnodeoccupied)) {
          var_2 = distancesquared(self.isnodeoccupied.origin, self.origin);
        }

        if(isDefined(self.isnodeoccupied) && var_2 < 9216) {
          self botsetflag("disable_attack", 0);
          self botsetflag("prefer_melee", 1);
        } else {
          self botsetflag("prefer_melee", 0);
          self botsetflag("disable_attack", 1);
        }

        if(isDefined(level.ball_goals)) {
          var_3 = level.ball_goals[bot_get_enemy_team()].origin;
          if(!isDefined(var_0)) {
            var_0 = getclosestpointonnavmesh(var_3, self);
            if(distance2dsquared(var_0, var_3) > 256) {
              var_4 = (var_3[0], var_3[1], var_3[2] - 90);
              var_0 = getclosestpointonnavmesh(var_4, self);
            }
          }

          self botsetscriptgoal(var_0, 16, "critical");
          var_5 = distance2dsquared(self.origin, var_3);
          if(var_5 < 30625) {
            var_6 = self getEye();
            var_7 = var_3;
            if(scripts\common\trace::ray_trace_passed(var_6, var_7, self)) {
              if(var_5 < 256) {
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
          if(!isDefined(var_1)) {
            var_1 = gettime() + randomintrange(500, 1000);
          }

          if(gettime() > var_1) {
            var_1 = gettime() + randomintrange(500, 1000);
            if(isDefined(self.isnodeoccupied)) {
              if(self botcanseeentity(self.isnodeoccupied)) {
                var_8 = anglesToForward(self.angles);
                var_9 = self.isnodeoccupied.origin - self.origin;
                var_0A = vectornormalize((var_9[0], var_9[1], 0));
                var_0B = vectordot(var_8, var_0A);
                if(var_0B > 0.707) {
                  if(var_2 < -7936 && var_2 > 9216) {
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
      var_0 = undefined;
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
      var_3 = var_0F.origin;
      if(!scripts\mp\bots\_bots_util::bot_is_defending_point(var_3)) {
        scripts\mp\bots\_bots_strategy::bot_protect_point(var_3, level.protect_radius);
      }
    }
  }
}

initialize_ball_role() {
  var_0 = get_allied_attackers_for_team(self.team);
  var_1 = get_allied_defenders_for_team(self.team);
  var_2 = ball_bot_attacker_limit_for_team(self.team);
  var_3 = ball_bot_defender_limit_for_team(self.team);
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
        ball_set_role("attacker");
        return;
      }

      ball_set_role("defender");
      return;
    }

    ball_set_role("attacker");
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
  var_0[0] = "allies";
  var_0[1] = "axis";
  var_1 = [];
  for(;;) {
    foreach(var_3 in var_0) {
      var_4 = ball_bot_attacker_limit_for_team(var_3);
      var_5 = ball_bot_defender_limit_for_team(var_3);
      var_6 = get_allied_attackers_for_team(var_3);
      var_7 = get_allied_defenders_for_team(var_3);
      if(var_6.size > var_4) {
        var_8 = [];
        var_9 = 0;
        foreach(var_0B in var_6) {
          if(isai(var_0B)) {
            if(level.bot_personality_type[var_0B.personality] == "stationary") {
              var_0B ball_set_role("defender");
              var_9 = 1;
              break;
            } else {
              var_8 = scripts\engine\utility::array_add(var_8, var_0B);
            }
          }
        }

        if(!var_9 && var_8.size > 0) {
          scripts\engine\utility::random(var_8) ball_set_role("defender");
        }
      }

      if(var_7.size > var_5) {
        var_0D = [];
        var_0E = 0;
        foreach(var_10 in var_7) {
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
        var_13 = pick_ball_carrier(var_3, var_12);
        if(isDefined(var_13) && isDefined(var_13.role) && var_13.role != "carrier") {
          if(!isDefined(var_13.carryobject)) {
            var_14 = var_1[var_3];
            if(isDefined(var_14)) {
              var_14 ball_set_role(undefined);
            }

            var_13 ball_set_role("carrier");
            var_1[var_13.team] = var_13;
          }
        }
      }
    }

    wait(1);
  }
}

ball_bot_attacker_limit_for_team(var_0) {
  var_1 = ball_get_num_players_on_team(var_0);
  if(!isDefined(level.ball_goals)) {
    return var_1;
  }

  return int(int(var_1) / 2) + 1 + int(var_1) % 2;
}

ball_bot_defender_limit_for_team(var_0) {
  if(!isDefined(level.ball_goals)) {
    return 0;
  }

  var_1 = ball_get_num_players_on_team(var_0);
  return max(int(int(var_1) / 2) - 1, 0);
}

ball_get_num_players_on_team(var_0) {
  var_1 = 0;
  foreach(var_3 in level.participants) {
    if(scripts\mp\utility::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

pick_ball_carrier(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }

    if(var_5.team != var_0) {
      continue;
    }

    if(!isalive(var_5)) {
      continue;
    }

    if(!isai(var_5)) {
      continue;
    }

    if(isDefined(var_5.role) && var_5.role == "defender") {
      continue;
    }

    var_6 = distancesquared(var_5.origin, var_1.curorigin);
    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

get_allied_attackers_for_team(var_0) {
  var_1 = get_players_by_role("attacker", var_0);
  if(isDefined(level.ball_goals)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(distancesquared(level.ball_goals[var_0].origin, var_3.origin) > level.protect_radius * level.protect_radius) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

get_allied_defenders_for_team(var_0) {
  var_1 = get_players_by_role("defender", var_0);
  if(isDefined(level.ball_goals)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(distancesquared(level.ball_goals[var_0].origin, var_3.origin) <= level.protect_radius * level.protect_radius) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

ball_set_role(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\_bots_strategy::bot_defend_stop();
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

monitor_ball_carrier() {
  level endon("game_ended");
  var_0 = undefined;
  for(;;) {
    var_1 = bot_get_ball_carrier();
    if(!isDefined(var_0) || !isDefined(var_1) || var_1 != var_0) {
      if(isDefined(var_0) && var_0.var_33F == 505) {
        var_0.var_33F = 0;
      }

      var_0 = var_1;
    }

    if(isDefined(var_1) && var_1.var_33F == 0) {
      var_1.var_33F = 505;
    }

    wait(0.05);
  }
}