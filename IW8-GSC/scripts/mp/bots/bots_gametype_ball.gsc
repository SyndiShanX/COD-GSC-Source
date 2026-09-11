/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_ball.gsc
**************************************************/

function main() {
  setup_callbacks();
  setup_bot_ball();
  thread monitor_ball_carrier();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_ball_think;
}

function setup_bot_ball() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 600;
  level.bodyguard_radius = 400;
  thread bot_ball_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

function bot_get_available_ball() {
  foreach(var1 in level.balls) {
    if(isDefined(var1.carrier)) {
      continue;
    }

    if(istrue(var1.in_goal)) {
      continue;
    }

    if(istrue(var1.isresetting)) {
      continue;
    }

    return var1;
  }

  return undefined;
}

function bot_get_ball_carrier() {
  foreach(var1 in level.balls) {
    if(isDefined(var1.carrier)) {
      return var1.carrier;
    }
  }

  return undefined;
}

function bot_do_doublejump() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetstance("stand");

  for(var0 = 0; var0 < 5; var0++) {
    self botpressbutton("jump");
    waitframe();
  }

  waitframe();
  waitframe();

  for(var0 = 0; var0 < 60; var0++) {
    self botpressbutton("jump");
    waitframe();

    if(!isDefined(self.carryobject)) {
      break;
    }
  }
}

function bot_throw_ball() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(var0 = 0; var0 < 5; var0++) {
    self botpressbutton("attack");
    waitframe();
  }
}

function bot_get_enemy_team() {
  if(self.team == "allies") {
    return "axis";
  }

  return "allies";
}

function bot_ball_think() {
  self notify("bot_ball_think");
  self endon("bot_ball_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  var0 = undefined;
  var1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.role)) {
      initialize_ball_role();
      var0 = undefined;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      var0 = undefined;
      continue;
    }

    if(self.role != "carrier" && isDefined(self.carryobject)) {
      var0 = undefined;
      ball_set_role("carrier");
    }

    if(self.role == "carrier") {
      if(isDefined(self.carryobject)) {
        self botsetflag("disable_attack", 1);
        var2 = 0;

        if(isDefined(self.enemy)) {
          var2 = distancesquared(self.enemy.origin, self.origin);
        }

        if(isDefined(self.enemy) && var2 < 9216) {
          self botsetflag("disable_attack", 0);
          self botsetflag("prefer_melee", 1);
        } else {
          self botsetflag("prefer_melee", 0);
          self botsetflag("disable_attack", 1);
        }

        if(isDefined(level.ball_goals)) {
          var3 = level.ball_goals[bot_get_enemy_team()].origin;

          if(!isDefined(var0)) {
            var0 = getclosestpointonnavmesh(var3, self);

            if(distance2dsquared(var0, var3) > 256) {
              var4 = (var3[0], var3[1], var3[2] - 90);
              var0 = getclosestpointonnavmesh(var4, self);
            }
          }

          self botsetscriptgoal(var0, 16, "critical");
          var5 = distance2dsquared(self.origin, var3);

          if(var5 < 30625) {
            var6 = self getEye();
            var7 = var3;

            if(scripts\engine\trace::ray_trace_passed(var6, var7, self)) {
              if(var5 < 256) {
                self botsetscriptgoal(self.origin, 16, "critical");
                wait 0.25;
              }

              bot_do_doublejump();
              wait 0.2;

              if(!isDefined(self.carryobject)) {
                self botclearscriptgoal();
              }
            }
          }
        } else {
          self botclearscriptgoal();

          if(!isDefined(var1)) {
            var1 = gettime() + randomintrange(500, 1000);
          }

          if(gettime() > var1) {
            var1 = gettime() + randomintrange(500, 1000);

            if(isDefined(self.enemy)) {
              if(self botcanseeentity(self.enemy)) {
                var8 = anglesToForward(self.angles);
                var9 = self.enemy.origin - self.origin;
                var10 = vectorNormalize((var9[0], var9[1], 0));
                var11 = vectordot(var8, var10);

                if(var11 > 0.707) {
                  if(var2 < 57600 && var2 > 9216) {
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
        var12 = bot_get_available_ball();

        if(!isDefined(var12)) {
          var13 = bot_get_ball_carrier();

          if(isDefined(var13) && var13 != self) {
            initialize_ball_role();
          }
        } else {
          self botsetscriptgoal(var13.curorigin, 16, "objective");
          continue;
        }
      }
    } else {
      var0 = undefined;
    }

    if(self.role == "attacker") {
      self botsetflag("disable_attack", 0);
      self botsetflag("prefer_melee", 0);
      var12 = bot_get_available_ball();

      if(!isDefined(var12)) {
        var13 = bot_get_ball_carrier();

        if(isDefined(var13)) {
          if(!scripts\mp\bots\bots_util::bot_is_guarding_player(var13)) {
            scripts\mp\bots\bots_strategy::bot_guard_player(var13, level.bodyguard_radius);
          }
        }
      } else if(!istrue(var12.isresetting) && !istrue(var12.in_goal)) {
        var14 = getclosestpointonnavmesh(var12.curorigin);

        if(!scripts\mp\bots\bots_util::bot_is_defending_point(var14)) {
          scripts\mp\bots\bots_strategy::bot_protect_point(var14, level.protect_radius);
        }
      }

      continue;
    }

    if(self.role == "defender") {
      self botsetflag("disable_attack", 0);
      self botsetflag("prefer_melee", 0);
      var15 = level.ball_goals[self.team];
      var3 = var15.origin;

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var3)) {
        scripts\mp\bots\bots_strategy::bot_protect_point(var3, level.protect_radius);
      }
    }
  }
}

function initialize_ball_role() {
  var0 = get_allied_attackers_for_team(self.team);
  var1 = get_allied_defenders_for_team(self.team);
  var2 = ball_bot_attacker_limit_for_team(self.team);
  var3 = ball_bot_defender_limit_for_team(self.team);
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
        ball_set_role("attacker");
        return;
      }

      ball_set_role("defender");
      return;
    }

    ball_set_role("attacker");
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

function bot_ball_ai_director_update() {
  level notify("bot_ball_ai_director_update");
  level endon("bot_ball_ai_director_update");
  level endon("game_ended");
  GscBinSkip1(0x45, 0, "allies");
}

function ball_bot_attacker_limit_for_team(var0) {
  var1 = ball_get_num_players_on_team(var0);

  if(!isDefined(level.ball_goals)) {
    return var1;
  }

  return int(int(var1) / 2) + 1 + int(var1) % 2;
}

function ball_bot_defender_limit_for_team(var0) {
  if(!isDefined(level.ball_goals)) {
    return 0;
  }

  var1 = ball_get_num_players_on_team(var0);
  return max(int(int(var1) / 2) - 1, 0);
}

function ball_get_num_players_on_team(var0) {
  var1 = 0;

  foreach(var3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var3) && isDefined(var3.team) && var3.team == var0) {
      var1++;
    }
  }

  return var1;
}

function pick_ball_carrier(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in level.participants) {
    if(!isDefined(var5.team)) {
      continue;
    }

    if(var5.team != var0) {
      continue;
    }

    if(!isalive(var5)) {
      continue;
    }

    if(!isai(var5)) {
      continue;
    }

    if(isDefined(var5.role) && var5.role == "defender") {
      continue;
    }

    var6 = distancesquared(var5.origin, var1.curorigin);

    if(!isDefined(var3) || var6 < var3) {
      var3 = var6;
      var2 = var5;
    }
  }

  if(isDefined(var2)) {
    return var2;
  }

  return undefined;
}

function get_allied_attackers_for_team(var0) {
  var1 = get_players_by_role("attacker", var0);

  if(isDefined(level.ball_goals)) {
    foreach(var3 in level.players) {
      if(!isai(var3) && isDefined(var3.team) && var3.team == var0) {
        if(distancesquared(level.ball_goals[var0].origin, var3.origin) > level.protect_radius * level.protect_radius) {
          var1 = scripts\engine\utility::array_add(var1, var3);
        }
      }
    }
  }

  return var1;
}

function get_allied_defenders_for_team(var0) {
  var1 = get_players_by_role("defender", var0);

  if(isDefined(level.ball_goals)) {
    foreach(var3 in level.players) {
      if(!isai(var3) && isDefined(var3.team) && var3.team == var0) {
        if(distancesquared(level.ball_goals[var0].origin, var3.origin) <= level.protect_radius * level.protect_radius) {
          var1 = scripts\engine\utility::array_add(var1, var3);
        }
      }
    }
  }

  return var1;
}

function ball_set_role(var0) {
  self.role = var0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
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

function monitor_ball_carrier() {
  level endon("game_ended");
  var0 = undefined;

  for(;;) {
    var1 = bot_get_ball_carrier();

    if(!isDefined(var0) || !isDefined(var1) || var1 != var0) {
      if(isDefined(var0) && var0.threatbias == 505) {
        var0.threatbias = 0;
      }

      var0 = var1;
    }

    if(isDefined(var1) && var1.threatbias == 0) {
      var1.threatbias = 505;
    }

    wait 0.05;
  }
}