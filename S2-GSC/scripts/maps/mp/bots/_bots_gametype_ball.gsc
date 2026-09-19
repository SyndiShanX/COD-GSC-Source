/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_ball.gsc
********************************************************/

main() {
  _id_87A7();
  _id_878F();
}

_id_87A7() {
  level.bot_funcs["gametype_think"] = ::_id_1948;
  level.bot_funcs["crate_can_use"] = ::_id_2734;
}

_id_878F() {
  level._id_19DB = ::_id_1940;
  level._id_19DE = ::_id_1941;
  level._id_19D6 = ::_id_4091;
  level._id_19D7 = ::_id_4092;
  maps\mp\bots\_bots_util::_id_1B20();

  while(!isDefined(level._id_152B))
    waitframe();

  level._id_152B["allies"].shootblank = "allies";
  level._id_152B["axis"].shootblank = "axis";
  bot_setup_ball_goal_node();
  var_0 = _getzonenearest(level._id_152B["allies"].origin);

  if(isDefined(var_0))
    _botzonesetteam(var_0, "allies");

  var_0 = _getzonenearest(level._id_152B["axis"].origin);

  if(isDefined(var_0))
    _botzonesetteam(var_0, "axis");

  foreach(var_2 in level._id_1562)
  var_2 thread _id_62E7();

  var_4 = 0;
  thread maps\mp\bots\_bots_gametype_common::_id_19DA();
  level._id_19E8 = 1;
}

_id_62E7() {
  var_0 = self._id_A582[0].origin;
  self._id_6638 = _getclosestnodeinsight(var_0);

  for(;;) {
    var_1 = self._id_A582[0].origin;
    self._id_150B = maps\mp\bots\_bots_util::_id_1B1C(var_0, var_1);

    if(!self._id_150B) {
      var_2 = _getclosestnodeinsight(var_1);

      if(!isDefined(var_2)) {
        var_3 = _getnodesinradiussorted(var_1, 512, 0, 6000);

        if(var_3.size > 0)
          var_2 = var_3[0];
      }

      if(isDefined(var_2))
        self._id_6638 = var_2;
    }

    var_0 = var_1;
    wait 0.2;
  }
}

bot_setup_ball_goal_node() {
  wait 1.0;

  foreach(var_1 in level._id_152B) {
    var_1._id_6638 = _getclosestnodeinsight(var_1.origin);

    if(!isDefined(var_1._id_6638)) {
      var_2 = _getnodesinradiussorted(var_1.origin, 375, 0);

      if(var_2.size > 0)
        var_1._id_6638 = var_2[0];
    }

    waitframe();
  }
}

_id_1947(var_0, var_1, var_2) {
  var_3 = _id_1949(var_0, var_1.origin);

  if(isDefined(var_2) && var_2) {
    if(!var_3) {
      var_4 = var_1.origin - (0, 0, var_1.radius * 0.5);
      var_3 = _id_1949(var_0, var_4);
    }

    if(!var_3) {
      var_4 = var_1.origin + (0, 0, var_1.radius * 0.5);
      var_3 = _id_1949(var_0, var_4);
    }
  }

  return var_3;
}

_id_1949(var_0, var_1) {
  if(isDefined(self) && (isPlayer(self) || _isagent(self)))
    var_2 = _playerphysicstrace(var_0, var_1, self);
  else
    var_2 = _playerphysicstrace(var_0, var_1);

  return distancesquared(var_2, var_1) < 1;
}

_id_2734(var_0) {
  if(_isagent(self) && !isDefined(var_0._id_1B7B))
    return 0;

  if(_id_4B23())
    return 0;

  return 1;
}

_id_1948() {
  self notify("bot_ball_think");
  self endon("bot_ball_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(!isDefined(level._id_19E8))
    waitframe();

  self botsetflag("separation", 0);
  var_0 = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  var_1 = 0;
  self._id_5B38 = 0;
  self._id_150C = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  self._id_150D = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  self._id_150F = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  var_2 = level._id_152B[self.team];
  var_3 = level._id_152B[common_scripts\utility::_id_416F(self.team)];
  childthread _id_A87E();

  for(;;) {
    var_4 = !isDefined(self._id_7ECA);

    if(var_4)
      maps\mp\bots\_bots_gametype_common::_id_19E7();

    self botsetflag("force_sprint", 0);
    var_5 = _id_1942(self.team);
    var_6 = _id_1942(common_scripts\utility::_id_416F(self.team));

    foreach(var_8 in var_6) {
      var_9 = var_8 _id_1945() - (0, 0, 75);
      self botgetimperfectenemyinfo(var_8.carrier, var_9);
    }

    if(_id_4B23()) {
      self botsetflag("force_sprint", 1);
      _id_23B3();
      self botsetscriptgoal(var_3.origin, 0, "critical");
      maps\mp\bots\_bots_util::_id_1B21(undefined, "bot_no_longer_has_ball");
      self botclearscriptgoal();
    } else if(self._id_7ECA == "attacker") {
      var_11 = _id_1944();

      if(var_11.size <= 0) {
        if(var_6.size > 0) {
          var_12 = _id_1943(var_6);
          var_13 = var_12 _id_1945() - (0, 0, 75);

          if(var_0) {
            if(gettime() > var_1) {
              var_1 = gettime() + 5000;
              var_14 = undefined;
              var_15 = _getnodesonpath(var_13, var_2._id_6638.origin);

              if(isDefined(var_15) && var_15.size > 0)
                var_14 = var_15[int(var_15.size * _randomfloatrange(0.25, 0.75))].origin;

              _id_23B3();

              if(isDefined(var_14) && maps\mp\bots\_bots_personality::_id_3B64(var_14, 512))
                self botsetscriptgoalnode(self._id_6708, "guard", self._id_0D94);
              else
                self botsetscriptgoal(var_13, 16, "guard");
            }
          } else {
            _id_23B3();
            self botsetscriptgoal(var_13, 16, "guard");
          }
        } else if(var_5.size > 0) {
          if(!maps\mp\bots\_bots_util::_id_1A27()) {
            var_16 = _id_1943(var_5);
            _id_23B3();
            maps\mp\bots\_bots_strategy::_id_1A0C(var_16.carrier, 500);
          }
        } else {
          var_17 = common_scripts\utility::_id_40B0(self.origin, level._id_1554);
          _id_23B3();
          self botsetscriptgoal(var_17[0].origin, 16, "guard");
        }
      } else {
        var_18 = _id_1943(var_11);
        _id_23B3("objective");

        if(var_18._id_150B) {
          var_19 = var_18 _id_1945();

          if(!self bothasscriptgoal() || !maps\mp\bots\_bots_util::_id_1B1C(var_19, self botgetscriptgoal()))
            self botsetscriptgoal(var_19, 16, "objective", undefined, 180);
        } else
          self botsetscriptgoal(var_18._id_6638.origin, 16, "objective", undefined, 180);
      }
    } else {
      var_20 = undefined;
      var_11 = _id_1944();

      foreach(var_8 in var_11) {
        var_22 = _distance2dsquared(var_8 _id_1945(), var_2.origin);

        if(var_22 < _squared(_id_40BB())) {
          var_20 = var_8;
          break;
        }
      }

      if(isDefined(var_20)) {
        _id_23B3();

        if(var_20._id_150B)
          self botsetscriptgoal(var_20 _id_1945(), 16, "guard");
        else
          self botsetscriptgoal(var_20._id_6638.origin, 16, "guard");

        maps\mp\bots\_bots_util::_id_1B21(1.0);
      } else if(!maps\mp\bots\_bots_util::_id_1A33()) {
        self botclearscriptgoal();
        var_24["score_flags"] = "strict_los";
        var_24["override_origin_node"] = var_2._id_6638;
        maps\mp\bots\_bots_strategy::_id_1AA6(var_2._id_6638.origin, _id_40BB(), var_24);
      }
    }

    waitframe();
  }
}

_id_A87E() {
  var_0 = 0;

  for(;;) {
    if(_id_4B23() && !var_0) {
      childthread _id_632C();
      var_0 = 1;
      self botsetflag("melee_critical_path", 1);
    } else if(!_id_4B23() && var_0) {
      self notify("bot_no_longer_has_ball");
      var_0 = 0;
      self botsetflag("melee_critical_path", 0);
    }

    waitframe();
  }
}

_id_632C() {
  self endon("bot_no_longer_has_ball");
  var_0 = level._id_152B[self.team];
  var_1 = level._id_152B[common_scripts\utility::_id_416F(self.team)];

  for(;;) {
    if(self._id_150C) {
      if(isDefined(self._id_6EA9)) {
        var_2 = 1;

        if(var_2) {
          var_3 = distancesquared(self.origin, var_1.origin);
          var_4 = distancesquared(self._id_6EA9.origin, var_1.origin);

          if(var_4 <= var_3) {
            var_5 = anglesToForward(self getplayerangles());
            var_6 = vectorNormalize(self._id_6EA9.origin - self.origin);
            var_7 = vectordot(var_5, var_6);

            if(var_7 > 0.7) {
              self botlookatpoint(self._id_6EA9.origin + (0, 0, 40), 1.25, "script_forced");
              wait 0.25;
              self botpressbutton("throw");
              wait 1.0;
            }
          }
        }
      }
    }

    if(self._id_150D) {
      if(isDefined(self._id_0088) && isalive(self._id_0088) && self botcanseeentity(self._id_0088)) {
        var_8 = 1;

        if(var_8) {
          var_9 = distancesquared(self.origin, var_0.origin);
          var_10 = var_9 < _squared(_id_40BB());

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

    if(self._id_150F) {
      if(self.health < 100 && _id_1947(self.origin, var_1)) {
        self botlookatpoint(var_1.origin, 1.25, "script_forced");
        wait 0.25;
        self botpressbutton("attack");
        wait 1.0;
      } else if(self._id_7ECA == "defender") {
        var_9 = distancesquared(self.origin, var_0.origin);

        if(var_9 < _squared(_id_40BB())) {
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

_id_1512(var_0) {
  var_1 = self getnearestnode();
  var_2 = var_0 getnearestnode();

  if(isDefined(var_1) && isDefined(var_2)) {
    if(_nodesvisible(var_1, var_2, 1))
      return var_2;

    var_3 = _getlinkednodes(var_2);

    foreach(var_5 in var_3) {
      if(_nodesvisible(var_1, var_5, 1))
        return var_5;
    }
  }

  return undefined;
}

_id_1946() {
  return self._id_2562["friendly"] == "waypoint_ball_download" || self._id_2562["friendly"] == "waypoint_ball_upload";
}

_id_1943(var_0) {
  if(var_0.size == 1)
    return var_0[0];

  var_1 = 99999999;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = distancesquared(self.origin, var_4 _id_1945());

    if(var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

_id_1945() {
  if(isDefined(self.carrier))
    return self._id_28D4;
  else
    return self._id_A582[0].origin;
}

_id_23B3(var_0) {
  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();

  if(self botgetscriptgoaltype() == "objective") {
    var_1 = isDefined(var_0) && var_0 == "objective";

    if(!var_1)
      self botclearscriptgoal();
  }
}

_id_4B23() {
  return isDefined(self._id_1510);
}

_id_1944() {
  var_0 = [];

  foreach(var_2 in level._id_1562) {
    if(var_2 _id_1946()) {
      continue;
    }
    if(!isDefined(var_2.carrier))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_1942(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_1562) {
    if(var_3 _id_1946()) {
      continue;
    }
    if(isDefined(var_3.carrier) && var_3.carrier.team == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_1940(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::_id_19E1(var_0);
  var_2 = var_1 * 0.67;
  var_3 = _floor(var_2);
  var_4 = _ceil(var_2);
  var_5 = var_2 - var_3;
  var_6 = var_4 - var_2;

  if(var_5 < var_6)
    var_7 = int(var_3);
  else
    var_7 = int(var_4);

  return var_7;
}

_id_1941(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::_id_19E1(var_0);
  return var_1 - _id_1940(var_0);
}

_id_40BB() {
  if(isalive(self) && !isDefined(level._id_7790)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level._id_7790 = _min(800, var_1 / 5.5);
  }

  if(!isDefined(level._id_7790))
    return 900;

  return level._id_7790;
}

_id_4091(var_0) {
  return maps\mp\bots\_bots_gametype_common::_id_19DF(var_0, level._id_152B[var_0].origin, _id_40BB());
}

_id_4092(var_0) {
  return maps\mp\bots\_bots_gametype_common::_id_19E0(var_0, level._id_152B[var_0].origin, _id_40BB());
}