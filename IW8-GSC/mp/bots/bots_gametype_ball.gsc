/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_ball.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_ball();
  thread monitor_ball_carrier();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_ball_think;
}

setup_bot_ball() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 600;
  level.bodyguard_radius = 400;
  thread bot_ball_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

bot_get_available_ball() {
  foreach(var_1 in level.balls) {
    if(isDefined(var_1.carrier)) {
      continue;
    }
    if(istrue(var_1.in_goal)) {
      continue;
    }
    if(istrue(var_1.isresetting)) {
      continue;
    }
    return var_1;
  }

  return undefined;
}

bot_get_ball_carrier() {
  foreach(var_1 in level.balls) {
    if(isDefined(var_1.carrier))
      return var_1.carrier;
  }

  return undefined;
}

bot_do_doublejump() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self botsetstance("_encstr_A5AD069B231F0BAF");

  for(var_0 = 0; var_0 < 5; var_0++) {
    self botpressbutton("_encstr_84DD05D205AA0B");
    waitframe();
  }

  waitframe();
  waitframe();

  for(var_0 = 0; var_0 < 60; var_0++) {
    self botpressbutton("_encstr_84DD05D205AA0B");
    waitframe();

    if(!isDefined(self.carryobject)) {
      break;
    }
  }
}

bot_throw_ball() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(var_0 = 0; var_0 < 5; var_0++) {
    self botpressbutton("_encstr_999A07C61338F9A23A");
    waitframe();
  }
}

bot_get_enemy_team() {
  if(self.team == "_encstr_9A8507BA4040188D08")
    return "_encstr_8E8405EA382B2A";

  return "_encstr_9A8507BA4040188D08";
}

bot_ball_think() {
  self notify("_encstr_8E2D0F2A70E1D18BD1C19CB7E5D86F2567");
  self endon("_encstr_8E2D0F2A70E1D18BD1C19CB7E5D86F2567");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.role)) {
      initialize_ball_role();
      var_0 = undefined;
    }

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      var_0 = undefined;
      continue;
    }

    if(self.role != "_encstr_933B08D82C93934BCA39" && isDefined(self.carryobject)) {
      var_0 = undefined;
      ball_set_role("_encstr_933B08D82C93934BCA39");
    }

    if(self.role == "_encstr_933B08D82C93934BCA39") {
      if(isDefined(self.carryobject)) {
        self botsetflag("_encstr_A3D70F23D29BB0988D95D7B0D1D10BB16D", 1);
        var_2 = 0;

        if(isDefined(self.enemy))
          var_2 = distancesquared(self.enemy.origin, self.origin);

        if(isDefined(self.enemy) && var_2 < 9216) {
          self botsetflag("_encstr_A3D70F23D29BB0988D95D7B0D1D10BB16D", 0);
          self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 1);
        } else {
          self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 0);
          self botsetflag("_encstr_A3D70F23D29BB0988D95D7B0D1D10BB16D", 1);
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

          self botsetscriptgoal(var_0, 16, "_encstr_99CC09DA9020C4ECD149AD");
          var_5 = distance2dsquared(self.origin, var_3);

          if(var_5 < 30625) {
            var_6 = self getEye();
            var_7 = var_3;

            if(scripts\engine\trace::ray_trace_passed(var_6, var_7, self)) {
              if(var_5 < 256) {
                self botsetscriptgoal(self.origin, 16, "_encstr_99CC09DA9020C4ECD149AD");
                wait 0.25;
              }

              bot_do_doublejump();
              wait 0.2;

              if(!isDefined(self.carryobject))
                self botclearscriptgoal();
            }
          }
        } else {
          self botclearscriptgoal();

          if(!isDefined(var_1))
            var_1 = gettime() + randomintrange(500, 1000);

          if(gettime() > var_1) {
            var_1 = gettime() + randomintrange(500, 1000);

            if(isDefined(self.enemy)) {
              if(self botcanseeentity(self.enemy)) {
                var_8 = anglesToForward(self.angles);
                var_9 = self.enemy.origin - self.origin;
                var_10 = vectorNormalize((var_9[0], var_9[1], 0));
                var_11 = vectordot(var_8, var_10);

                if(var_11 > 0.707) {
                  if(var_2 < 57600 && var_2 > 9216)
                    bot_throw_ball();
                }
              }
            }
          }
        }
      } else {
        self botsetflag("_encstr_A3D70F23D29BB0988D95D7B0D1D10BB16D", 0);
        self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 0);
        var_12 = bot_get_available_ball();

        if(!isDefined(var_12)) {
          var_13 = bot_get_ball_carrier();

          if(isDefined(var_13) && var_13 != self)
            initialize_ball_role();
        } else {
          self botsetscriptgoal(var_12.curorigin, 16, "_encstr_9A2B0A12F03587575B7BBEA5");
          continue;
        }
      }
    } else
      var_0 = undefined;

    if(self.role == "_encstr_AA7B09475984AF0F6F0F0B") {
      self botsetflag("_encstr_A3D70F23D29BB0988D95D7B0D1D10BB16D", 0);
      self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 0);
      var_12 = bot_get_available_ball();

      if(!isDefined(var_12)) {
        var_13 = bot_get_ball_carrier();

        if(isDefined(var_13)) {
          if(!scripts\mp\bots\bots_util::bot_is_guarding_player(var_13))
            scripts\mp\bots\bots_strategy::bot_guard_player(var_13, level.bodyguard_radius);
        }
      } else if(!istrue(var_12.isresetting) && !istrue(var_12.in_goal)) {
        var_14 = getclosestpointonnavmesh(var_12.curorigin);

        if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_14))
          scripts\mp\bots\bots_strategy::bot_protect_point(var_14, level.protect_radius);
      }

      continue;
    }

    if(self.role == "_encstr_8E460991ACCC59378C56C9") {
      self botsetflag("_encstr_A3D70F23D29BB0988D95D7B0D1D10BB16D", 0);
      self botsetflag("_encstr_AC230DCB5AADF87DF3A73B2343AAB5", 0);
      var_15 = level.ball_goals[self.team];
      var_3 = var_15.origin;

      if(!scripts\mp\bots\bots_util::bot_is_defending_point(var_3))
        scripts\mp\bots\bots_strategy::bot_protect_point(var_3, level.protect_radius);
    }
  }
}

initialize_ball_role() {
  var_0 = get_allied_attackers_for_team(self.team);
  var_1 = get_allied_defenders_for_team(self.team);
  var_2 = ball_bot_attacker_limit_for_team(self.team);
  var_3 = ball_bot_defender_limit_for_team(self.team);
  var_4 = level.bot_personality_type[self.personality];

  if(var_4 == "_encstr_930B07BB1B6B3854FF") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level.bot_personality_type[var_7.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
          var_7.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        ball_set_role("_encstr_AA7B09475984AF0F6F0F0B");
        return;
      }

      ball_set_role("_encstr_8E460991ACCC59378C56C9");
      return;
    } else
      ball_set_role("_encstr_AA7B09475984AF0F6F0F0B");
  } else if(var_4 == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level.bot_personality_type[var_10.personality] == "_encstr_930B07BB1B6B3854FF") {
          var_10.role = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        ball_set_role("_encstr_8E460991ACCC59378C56C9");
        return;
      }

      ball_set_role("_encstr_AA7B09475984AF0F6F0F0B");
      return;
    } else
      ball_set_role("_encstr_8E460991ACCC59378C56C9");
  }
}

bot_ball_ai_director_update() {
  level notify("_encstr_ABA11CE15A7B08B0C6F44937E12C916DF763994953BFD6219BC051431C17");
  level endon("_encstr_ABA11CE15A7B08B0C6F44937E12C916DF763994953BFD6219BC051431C17");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0[0] = "_encstr_9A8507BA4040188D08";
  var_0[1] = "_encstr_8E8405EA382B2A";
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

        foreach(var_11 in var_6) {
          if(isai(var_11)) {
            if(level.bot_personality_type[var_11.personality] == "_encstr_88FA0B7271CF407FE86D0FEBE3") {
              var_11 ball_set_role("_encstr_8E460991ACCC59378C56C9");
              var_9 = 1;
              break;
            } else
              var_8 = scripts\engine\utility::array_add(var_8, var_11);
          }
        }

        if(!var_9 && var_8.size > 0)
          scripts\engine\utility::random(var_8) ball_set_role("_encstr_8E460991ACCC59378C56C9");
      }

      if(var_7.size > var_5) {
        var_13 = [];
        var_14 = 0;

        foreach(var_16 in var_7) {
          if(isai(var_16)) {
            if(level.bot_personality_type[var_16.personality] == "_encstr_930B07BB1B6B3854FF") {
              var_16 ball_set_role("_encstr_AA7B09475984AF0F6F0F0B");
              var_14 = 1;
              break;
            } else
              var_13 = scripts\engine\utility::array_add(var_13, var_16);
          }
        }

        if(!var_14 && var_13.size > 0)
          scripts\engine\utility::random(var_13) ball_set_role("_encstr_AA7B09475984AF0F6F0F0B");
      }

      var_18 = bot_get_available_ball();

      if(isDefined(var_18)) {
        var_19 = pick_ball_carrier(var_3, var_18);

        if(isDefined(var_19) && isDefined(var_19.role) && var_19.role != "_encstr_933B08D82C93934BCA39") {
          if(!isDefined(var_19.carryobject)) {
            var_20 = var_1[var_3];

            if(isDefined(var_20))
              var_20 ball_set_role(undefined);

            var_19 ball_set_role("_encstr_933B08D82C93934BCA39");
            var_1[var_19.team] = var_19;
          }
        }
      }
    }

    wait 1.0;
  }
}

ball_bot_attacker_limit_for_team(var_0) {
  var_1 = ball_get_num_players_on_team(var_0);

  if(!isDefined(level.ball_goals))
    return var_1;

  return int(int(var_1) / 2) + 1 + int(var_1) % 2;
}

ball_bot_defender_limit_for_team(var_0) {
  if(!isDefined(level.ball_goals))
    return 0;

  var_1 = ball_get_num_players_on_team(var_0);
  return max(int(int(var_1) / 2) - 1, 0);
}

ball_get_num_players_on_team(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(scripts\mp\utility\entity::isteamparticipant(var_3) && isDefined(var_3.team) && var_3.team == var_0)
      var_1++;
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
    if(isDefined(var_5.role) && var_5.role == "_encstr_8E460991ACCC59378C56C9") {
      continue;
    }
    var_6 = distancesquared(var_5.origin, var_1.curorigin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2))
    return var_2;

  return undefined;
}

get_allied_attackers_for_team(var_0) {
  var_1 = get_players_by_role("_encstr_AA7B09475984AF0F6F0F0B", var_0);

  if(isDefined(level.ball_goals)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(distancesquared(level.ball_goals[var_0].origin, var_3.origin) > level.protect_radius * level.protect_radius)
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

get_allied_defenders_for_team(var_0) {
  var_1 = get_players_by_role("_encstr_8E460991ACCC59378C56C9", var_0);

  if(isDefined(level.ball_goals)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(distancesquared(level.ball_goals[var_0].origin, var_3.origin) <= level.protect_radius * level.protect_radius)
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }
  }

  return var_1;
}

ball_set_role(var_0) {
  self.role = var_0;
  self botclearscriptgoal();
  scripts\mp\bots\bots_strategy::bot_defend_stop();
}

get_players_by_role(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(isalive(var_4) && scripts\mp\utility\entity::isteamparticipant(var_4) && var_4.team == var_1 && isDefined(var_4.role) && var_4.role == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

monitor_ball_carrier() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;

  for(;;) {
    var_1 = bot_get_ball_carrier();

    if(!isDefined(var_0) || !isDefined(var_1) || var_1 != var_0) {
      if(isDefined(var_0) && var_0.threatbias == 505)
        var_0.threatbias = 0;

      var_0 = var_1;
    }

    if(isDefined(var_1) && var_1.threatbias == 0)
      var_1.threatbias = 505;

    wait 0.05;
  }
}