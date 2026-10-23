/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_ball.gsc
********************************************************/

main() {
  setup_callbacks();
  setup_bot_ball();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_ball_think;
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
}

setup_bot_ball() {
  level.bot_gametype_attacker_limit_for_team = ::bot_ball_attacker_limit_for_team;
  level.bot_gametype_defender_limit_for_team = ::bot_ball_defender_limit_for_team;
  level.bot_gametype_allied_attackers_for_team = ::_id_4091;
  level.bot_gametype_allied_defenders_for_team = ::_id_4092;
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.ball_goals)) {
    waitframe();
  }

  level.ball_goals["allies"].shootblank = "allies";
  level.ball_goals["axis"].shootblank = "axis";
  bot_setup_ball_goal_node();
  var_0 = _getzonenearest(level.ball_goals["allies"].origin);

  if(isDefined(var_0)) {
    _botzonesetteam(var_0, "allies");
  }

  var_0 = _getzonenearest(level.ball_goals["axis"].origin);

  if(isDefined(var_0)) {
    _botzonesetteam(var_0, "axis");
  }

  foreach(var_2 in level.balls) {
    var_2 thread monitor_ball();
  }

  var_4 = 0;
  thread maps\mp\bots\_bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

monitor_ball() {
  var_0 = self.visuals[0].origin;
  self.nearest_node = _getclosestnodeinsight(var_0);

  for(;;) {
    var_1 = self.visuals[0].origin;
    self.ball_at_rest = maps\mp\bots\_bots_util::bot_vectors_are_equal(var_0, var_1);

    if(!self.ball_at_rest) {
      var_2 = _getclosestnodeinsight(var_1);

      if(!isDefined(var_2)) {
        var_3 = _getnodesinradiussorted(var_1, 512, 0, 6000);

        if(var_3.size > 0) {
          var_2 = var_3[0];
        }
      }

      if(isDefined(var_2)) {
        self.nearest_node = var_2;
      }
    }

    var_0 = var_1;
    wait 0.2;
  }
}

bot_setup_ball_goal_node() {
  wait 1.0;

  foreach(var_1 in level.ball_goals) {
    var_1.nearest_node = _getclosestnodeinsight(var_1.origin);

    if(!isDefined(var_1.nearest_node)) {
      var_2 = _getnodesinradiussorted(var_1.origin, 375, 0);

      if(var_2.size > 0) {
        var_1.nearest_node = var_2[0];
      }
    }

    waitframe();
  }
}

bot_ball_origin_can_see_goal(var_0, var_1, var_2) {
  var_3 = bot_ball_trace_to_origin(var_0, var_1.origin);

  if(isDefined(var_2) && var_2) {
    if(!var_3) {
      var_4 = var_1.origin - (0, 0, var_1.radius * 0.5);
      var_3 = bot_ball_trace_to_origin(var_0, var_4);
    }

    if(!var_3) {
      var_4 = var_1.origin + (0, 0, var_1.radius * 0.5);
      var_3 = bot_ball_trace_to_origin(var_0, var_4);
    }
  }

  return var_3;
}

bot_ball_trace_to_origin(var_0, var_1) {
  if(isDefined(self) && (isPlayer(self) || _isagent(self))) {
    var_2 = _playerphysicstrace(var_0, var_1, self);
  } else {
    var_2 = _playerphysicstrace(var_0, var_1);
  }

  return distancesquared(var_2, var_1) < 1;
}

crate_can_use(var_0) {
  if(_isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(has_ball()) {
    return 0;
  }

  return 1;
}

bot_ball_think() {
  self notify("bot_ball_think");
  self endon("bot_ball_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    waitframe();
  }

  self botsetflag("separation", 0);
  var_0 = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  var_1 = 0;
  self.last_pass_throw_check = 0;
  self.ball_can_pass_ally = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  self.ball_can_pass_enemy = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  self.ball_can_throw = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  var_2 = level.ball_goals[self.team];
  var_3 = level.ball_goals[common_scripts\utility::get_enemy_team(self.team)];
  childthread watch_ball_pickup_and_loss();

  for(;;) {
    var_4 = !isDefined(self.role);

    if(var_4) {
      maps\mp\bots\_bots_gametype_common::bot_gametype_initialize_attacker_defender_role();
    }

    self botsetflag("force_sprint", 0);
    var_5 = bot_ball_get_balls_carried_by_team(self.team);
    var_6 = bot_ball_get_balls_carried_by_team(common_scripts\utility::get_enemy_team(self.team));

    foreach(var_8 in var_6) {
      var_9 = var_8 bot_ball_get_origin() - (0, 0, 75);
      self botgetimperfectenemyinfo(var_8.carrier, var_9);
    }

    if(has_ball()) {
      self botsetflag("force_sprint", 1);
      clear_defend_or_goal_if_necessary();
      self botsetscriptgoal(var_3.origin, 0, "critical");
      maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "bot_no_longer_has_ball");
      self botclearscriptgoal();
    } else if(self.role == "attacker") {
      var_11 = bot_ball_get_free_balls();

      if(var_11.size <= 0) {
        if(var_6.size > 0) {
          var_12 = bot_ball_get_closest_ball(var_6);
          var_13 = var_12 bot_ball_get_origin() - (0, 0, 75);

          if(var_0) {
            if(gettime() > var_1) {
              var_1 = gettime() + 5000;
              var_14 = undefined;
              var_15 = _getnodesonpath(var_13, var_2.nearest_node.origin);

              if(isDefined(var_15) && var_15.size > 0) {
                var_14 = var_15[int(var_15.size * _randomfloatrange(0.25, 0.75))].origin;
              }

              clear_defend_or_goal_if_necessary();

              if(isDefined(var_14) && maps\mp\bots\_bots_personality::find_ambush_node(var_14, 512)) {
                self botsetscriptgoalnode(self.node_ambushing_from, "guard", self._id_0D94);
              } else {
                self botsetscriptgoal(var_13, 16, "guard");
              }
            }
          } else {
            clear_defend_or_goal_if_necessary();
            self botsetscriptgoal(var_13, 16, "guard");
          }
        } else if(var_5.size > 0) {
          if(!maps\mp\bots\_bots_util::bot_is_bodyguarding()) {
            var_16 = bot_ball_get_closest_ball(var_5);
            clear_defend_or_goal_if_necessary();
            maps\mp\bots\_bots_strategy::bot_guard_player(var_16.carrier, 500);
          }
        } else {
          var_17 = common_scripts\utility::get_array_of_closest(self.origin, level.ball_starts);
          clear_defend_or_goal_if_necessary();
          self botsetscriptgoal(var_17[0].origin, 16, "guard");
        }
      } else {
        var_18 = bot_ball_get_closest_ball(var_11);
        clear_defend_or_goal_if_necessary("objective");

        if(var_18.ball_at_rest) {
          var_19 = var_18 bot_ball_get_origin();

          if(!self bothasscriptgoal() || !maps\mp\bots\_bots_util::bot_vectors_are_equal(var_19, self botgetscriptgoal())) {
            self botsetscriptgoal(var_19, 16, "objective", undefined, 180);
          }
        } else
          self botsetscriptgoal(var_18.nearest_node.origin, 16, "objective", undefined, 180);
      }
    } else {
      var_20 = undefined;
      var_11 = bot_ball_get_free_balls();

      foreach(var_8 in var_11) {
        var_22 = _distance2dsquared(var_8 bot_ball_get_origin(), var_2.origin);

        if(var_22 < _squared(get_ball_goal_protect_radius())) {
          var_20 = var_8;
          break;
        }
      }

      if(isDefined(var_20)) {
        clear_defend_or_goal_if_necessary();

        if(var_20.ball_at_rest) {
          self botsetscriptgoal(var_20 bot_ball_get_origin(), 16, "guard");
        } else {
          self botsetscriptgoal(var_20.nearest_node.origin, 16, "guard");
        }

        maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(1.0);
      } else if(!maps\mp\bots\_bots_util::bot_is_protecting()) {
        self botclearscriptgoal();
        var_24["score_flags"] = "strict_los";
        var_24["override_origin_node"] = var_2.nearest_node;
        maps\mp\bots\_bots_strategy::bot_protect_point(var_2.nearest_node.origin, get_ball_goal_protect_radius(), var_24);
      }
    }

    waitframe();
  }
}

watch_ball_pickup_and_loss() {
  var_0 = 0;

  for(;;) {
    if(has_ball() && !var_0) {
      childthread monitor_pass_throw();
      var_0 = 1;
      self botsetflag("melee_critical_path", 1);
    } else if(!has_ball() && var_0) {
      self notify("bot_no_longer_has_ball");
      var_0 = 0;
      self botsetflag("melee_critical_path", 0);
    }

    waitframe();
  }
}

monitor_pass_throw() {
  self endon("bot_no_longer_has_ball");
  var_0 = level.ball_goals[self.team];
  var_1 = level.ball_goals[common_scripts\utility::get_enemy_team(self.team)];

  for(;;) {
    if(self.ball_can_pass_ally) {
      if(isDefined(self.pass_target)) {
        var_2 = 1;

        if(var_2) {
          var_3 = distancesquared(self.origin, var_1.origin);
          var_4 = distancesquared(self.pass_target.origin, var_1.origin);

          if(var_4 <= var_3) {
            var_5 = anglesToForward(self getplayerangles());
            var_6 = vectorNormalize(self.pass_target.origin - self.origin);
            var_7 = vectordot(var_5, var_6);

            if(var_7 > 0.7) {
              self botlookatpoint(self.pass_target.origin + (0, 0, 40), 1.25, "script_forced");
              wait 0.25;
              self botpressbutton("throw");
              wait 1.0;
            }
          }
        }
      }
    }

    if(self.ball_can_pass_enemy) {
      if(isDefined(self._id_0088) && isalive(self._id_0088) && self botcanseeentity(self._id_0088)) {
        var_8 = 1;

        if(var_8) {
          var_9 = distancesquared(self.origin, var_0.origin);
          var_10 = var_9 < _squared(get_ball_goal_protect_radius());

          if(!var_10 && distancesquared(self.origin, self._id_0088.origin) < _squared(350)) {
            var_11 = anglesToForward(self._id_0088 getplayerangles());
            var_12 = vectorNormalize(self.origin - self._id_0088.origin);
            var_7 = vectordot(var_11, var_12);

            if(var_7 > 0.5) {
              var_5 = anglesToForward(self getplayerangles());
              var_13 = -1 * var_12;
              var_7 = vectordot(var_5, var_13);

              if(var_7 > 0.77) {
                self botlookatpoint(self._id_0088.origin + (0, 0, 40), 1.25, "script_forced");
                wait 0.25;
                self botpressbutton("attack");
                wait 1.0;
              }
            }
          }
        }
      }
    }

    if(self.ball_can_throw) {
      if(self.health < 100 && bot_ball_origin_can_see_goal(self.origin, var_1)) {
        self botlookatpoint(var_1.origin, 1.25, "script_forced");
        wait 0.25;
        self botpressbutton("attack");
        wait 1.0;
      } else if(self.role == "defender") {
        var_9 = distancesquared(self.origin, var_0.origin);

        if(var_9 < _squared(get_ball_goal_protect_radius())) {
          var_14 = anglesToForward(self getplayerangles() * (0, 1, 1) + (-30, 0, 0));
          self botlookatpoint(self getEye() + var_14 * 200, 1.25, "script_forced");
          wait 0.25;
          self botpressbutton("attack");
          wait 1.0;
        }
      }
    }

    waitframe();
  }
}

ball_carrier_is_almost_visible(var_0) {
  var_1 = self getnearestnode();
  var_2 = var_0 getnearestnode();

  if(isDefined(var_1) && isDefined(var_2)) {
    if(_nodesvisible(var_1, var_2, 1)) {
      return var_2;
    }

    var_3 = _getlinkednodes(var_2);

    foreach(var_5 in var_3) {
      if(_nodesvisible(var_1, var_5, 1)) {
        return var_5;
      }
    }
  }

  return undefined;
}

bot_ball_is_resetting() {
  return self.compassicons["friendly"] == "waypoint_ball_download" || self.compassicons["friendly"] == "waypoint_ball_upload";
}

bot_ball_get_closest_ball(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_1 = 99999999;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = distancesquared(self.origin, var_4 bot_ball_get_origin());

    if(var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

bot_ball_get_origin() {
  if(isDefined(self.carrier)) {
    return self.curorigin;
  } else {
    return self.visuals[0].origin;
  }
}

clear_defend_or_goal_if_necessary(var_0) {
  if(maps\mp\bots\_bots_util::bot_is_defending()) {
    maps\mp\bots\_bots_strategy::bot_defend_stop();
  }

  if(self botgetscriptgoaltype() == "objective") {
    var_1 = isDefined(var_0) && var_0 == "objective";

    if(!var_1) {
      self botclearscriptgoal();
    }
  }
}

has_ball() {
  return isDefined(self.ball_carried);
}

bot_ball_get_free_balls() {
  var_0 = [];

  foreach(var_2 in level.balls) {
    if(var_2 bot_ball_is_resetting()) {
      continue;
    }
    if(!isDefined(var_2.carrier)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

bot_ball_get_balls_carried_by_team(var_0) {
  var_1 = [];

  foreach(var_3 in level.balls) {
    if(var_3 bot_ball_is_resetting()) {
      continue;
    }
    if(isDefined(var_3.carrier) && var_3.carrier.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

bot_ball_attacker_limit_for_team(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(var_0);
  var_2 = var_1 * 0.67;
  var_3 = _floor(var_2);
  var_4 = _ceil(var_2);
  var_5 = var_2 - var_3;
  var_6 = var_4 - var_2;

  if(var_5 < var_6) {
    var_7 = int(var_3);
  } else {
    var_7 = int(var_4);
  }

  return var_7;
}

bot_ball_defender_limit_for_team(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(var_0);
  return var_1 - bot_ball_attacker_limit_for_team(var_0);
}

get_ball_goal_protect_radius() {
  if(isalive(self) && !isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = _min(800, var_1 / 5.5);
  }

  if(!isDefined(level.protect_radius)) {
    return 900;
  }

  return level.protect_radius;
}

_id_4091(var_0) {
  return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_attackers_for_team(var_0, level.ball_goals[var_0].origin, get_ball_goal_protect_radius());
}

_id_4092(var_0) {
  return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_defenders_for_team(var_0, level.ball_goals[var_0].origin, get_ball_goal_protect_radius());
}