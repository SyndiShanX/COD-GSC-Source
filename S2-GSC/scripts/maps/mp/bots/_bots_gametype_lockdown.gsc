/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_lockdown.gsc
************************************************************/

main() {
  level._id_1A1B = 0;
  _id_87A7();
  _id_8794();
  level thread maps\mp\bots\_bots_util::_id_1A80(maps\mp\bots\_bots_util::_id_1B17);
}

_id_87A7() {
  level.bot_funcs["crate_can_use"] = ::_id_2734;
  level.bot_funcs["gametype_think"] = ::_id_19B7;
  level.bot_funcs["should_start_cautious_approach"] = ::_id_8B7B;
  level.bot_funcs["leader_dialog"] = ::_id_19B5;

  if(!level._id_1A1B)
    level.bot_funcs["get_watch_node_chance"] = ::_id_19B4;
}

_id_2734(var_0) {
  if(_isagent(self) && !isDefined(var_0._id_1B7B))
    return 0;

  if(!maps\mp\_utility::_id_5800(self))
    return 1;

  return maps\mp\bots\_bots_util::_id_1A33();
}

_id_631A() {
  self notify("monitor_lockdown_zone_control");
  self endon("monitor_lockdown_zone_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 1;
    var_0 = maps\mp\gametypes\dom::_id_44E3();

    if(var_0 != "neutral") {
      var_1 = _getzonenearest(self.origin);

      if(isDefined(var_1))
        _botzonesetteam(var_1, var_0);
    }
  }
}

_id_630D() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var_0 = maps\mp\gametypes\dom::_id_44E3();

  for(;;) {
    var_1 = maps\mp\gametypes\dom::_id_44E3();

    if(var_1 != var_0)
      level notify("flag_changed_ownership");

    var_0 = var_1;
    waitframe();
  }
}

_id_8794() {
  maps\mp\bots\_bots_util::_id_1B20(1);
  var_0 = _id_19EC();

  if(var_0.size > 3) {
    while(!isDefined(level._id_987B))
      waitframe();

    var_1 = [];

    foreach(var_3 in var_0) {
      if(!isDefined(var_1[var_3._id_98BF]))
        var_1[var_3._id_98BF] = [];

      var_1[var_3._id_98BF] = common_scripts\utility::_id_0F6F(var_1[var_3._id_98BF], var_3);
    }

    foreach(var_7, var_6 in var_1) {
      level._id_37DD = 0;
      _id_1952(var_6);
      maps\mp\bots\_bots_gametype_common::_id_194F(var_6, var_7 + "_flag", level._id_1A1B);
    }
  } else {
    maps\mp\bots\_bots_gametype_common::_id_194F(var_0, "flag", level._id_1A1B);
    _id_1952(var_0);
    thread _id_1B1F(var_0);
  }

  foreach(var_3 in var_0) {
    var_3 thread _id_631A();
    var_3 thread _id_630D();

    if(var_3.shootblank != "_a" && var_3.shootblank != "_b" && var_3.shootblank != "_c") {}

    var_3._id_671A = _getnodesintrigger(var_3);
    maps\mp\bots\_bots_gametype_common::_id_192E(var_3, var_3);
    var_3._id_5B62["allies"] = 0;
    var_3._id_5B62["axis"] = 0;
  }

  level._id_19B6 = [];
  level._id_19B6["axis"] = [];
  level._id_19B6["allies"] = [];
  level._id_19E8 = 1;
}

_id_1B1F(var_0) {
  level endon("game_ended");
  level waittill("dom_flags_moved");
  maps\mp\bots\_bots_gametype_common::_id_194F(var_0, "flag", level._id_1A1B, 1);
  _id_1952(var_0);

  foreach(var_2 in var_0) {
    var_2._id_671A = _getnodesintrigger(var_2);
    maps\mp\bots\_bots_gametype_common::_id_192E(var_2, var_2);
  }

  foreach(var_5 in level._id_6E97) {
    if(maps\mp\_utility::_id_566A(var_5))
      var_5._id_3DF4 = 1;
  }
}

_id_19EC() {
  if(isDefined(level._id_0BCA))
    return level._id_0BCA;
  else
    return level._id_3CC5;
}

_id_1952(var_0) {
  if(!isDefined(level._id_3C81))
    level._id_3C81 = [];

  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for(var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
      var_3 = distance(var_0[var_1].origin, var_0[var_2].origin);
      var_4 = _id_4194(var_0[var_1]);
      var_5 = _id_4194(var_0[var_2]);
      level._id_3C81[var_4][var_5] = var_3;
      level._id_3C81[var_5][var_4] = var_3;
    }
  }
}

_id_8B7B(var_0) {
  if(var_0) {
    if(self._id_28F7 maps\mp\gametypes\dom::_id_44E3() == "neutral" && _id_3C86(self._id_28F7)) {
      var_1 = _id_40FC(self._id_5BE0.origin);

      if(var_1 == self._id_28F7)
        return 0;
      else {
        var_2 = _id_426A(var_1, self._id_28F7);
        var_3 = distancesquared(var_1.origin, self._id_28F7.origin);
        var_4 = distancesquared(var_2.origin, self._id_28F7.origin);

        if(var_3 < var_4)
          return 0;
      }
    }
  }

  return maps\mp\bots\_bots_strategy::_id_8B7A(var_0);
}

_id_19B2() {
  return 0;
}

_id_19B3() {
  return 0;
}

_id_19B7() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_19E8))
    waitframe();

  self._id_3DF4 = 0;
  self._id_668C = 0;
  self._id_66B0 = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    maps\mp\bots\_bots_util::_id_1B13();
    var_0 = gettime();

    if(var_0 > self._id_66B0) {
      self._id_66B0 = gettime() + 10000;
      self._id_943A = self botgetdifficultysetting("strategyLevel");
    }

    if(var_0 > self._id_668C || self._id_3DF4) {
      if(_id_8B52())
        self._id_668C = var_0 + 5000;
      else {
        self._id_3DF4 = 0;
        _id_1975();
        self._id_668C = var_0 + _randomintrange(30000, 45000);
      }
    }

    common_scripts\utility::waittill_notify_or_timeout("needs_new_flag_goal", 1.0);
  }
}

_id_8B52() {
  if(self._id_3DF4)
    return 0;

  if(!maps\mp\bots\_bots_util::_id_1A28())
    return 0;

  if(self._id_28F7 maps\mp\gametypes\dom::_id_44E3() == self.team)
    return 0;

  var_0 = _id_4193();

  if(distancesquared(self.origin, self._id_28F7.origin) < var_0 * 2 * (var_0 * 2)) {
    var_1 = _id_4094(self.team);

    if(var_1.size == 2 && !common_scripts\utility::_id_0F79(var_1, self._id_28F7) && !_id_1934())
      return 0;

    return 1;
  }

  return 0;
}

_id_4278() {
  return level._id_19B6[self.team];
}

_id_4B37() {
  var_0 = _id_4278();
  return var_0.size > 0;
}

_id_3C85(var_0) {
  return !_id_3C86(var_0);
}

_id_3C86(var_0) {
  return var_0._id_A222._id_3C66;
}

_id_1975() {
  var_0 = undefined;
  var_1 = [];
  var_2 = [];
  var_3 = 1;
  var_4 = _id_4278();

  if(var_4.size > 0)
    var_5 = var_4;
  else
    var_5 = level._id_3CC5;

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6] maps\mp\gametypes\dom::_id_44E3();

    if(var_3) {
      if(_id_3C85(var_5[var_6]))
        var_3 = 0;
      else {}
    }

    if(var_7 != self.team) {
      var_1[var_1.size] = var_5[var_6];
      continue;
    }

    var_2[var_2.size] = var_5[var_6];
  }

  var_8 = undefined;

  if(var_1.size == 3)
    var_8 = 1;
  else if(var_1.size == 2) {
    if(var_2.size == 1) {
      if(!_id_1AE1(var_2[0], 1))
        var_8 = 1;
      else
        var_8 = !_id_1AE0(0.34);

      if(maps\mp\bots\_bots_util::_id_19F9(self.team) == 1)
        var_8 = 1;
    } else if(var_2.size == 0)
      var_8 = 1;
  } else if(var_1.size == 1) {
    if(var_2.size == 2) {
      if(_id_1934()) {
        if(!_id_1AE1(var_2[0], 2) && !_id_1AE1(var_2[1], 2))
          var_8 = 1;
        else if(self._id_943A == 0)
          var_8 = !_id_1AE0(0.34);
        else
          var_8 = !_id_1AE0(0.5);
      } else
        var_8 = 0;
    } else if(var_2.size == 1) {
      if(!_id_1AE1(var_2[0], 1))
        var_8 = 1;
      else
        var_8 = !_id_1AE0(0.34);
    } else if(var_2.size == 0)
      var_8 = 1;
  } else if(var_1.size == 0)
    var_8 = 0;

  if(var_8) {
    if(var_1.size > 1)
      var_9 = common_scripts\utility::_id_40B0(self.origin, var_1);
    else
      var_9 = var_1;

    if(var_3 && !_id_4B37()) {
      var_10 = _id_424E(var_9[0], 1);

      if(var_10 < _id_61AD())
        var_11 = 0;
      else {
        var_12 = 20;
        var_13 = 65;
        var_14 = 15;

        if(self._id_943A == 0) {
          var_12 = 50;
          var_13 = 25;
          var_14 = 25;
        } else if(self._id_943A == 1) {
          var_12 = 40;
          var_13 = 40;
          var_14 = 20;
        }

        var_15 = randomint(100);

        if(var_15 < var_12)
          var_11 = 0;
        else if(var_15 < var_12 + var_13)
          var_11 = 1;
        else
          var_11 = 2;
      }

      var_16 = undefined;

      if(var_11 == 0)
        var_16 = "critical";

      _id_1FAD(var_9[var_11], var_16);
      return;
    }

    if(var_9.size == 1)
      var_0 = var_9[0];
    else if(distancesquared(var_9[0].origin, self.origin) < 102400)
      var_0 = var_9[0];
    else {
      var_17 = [];
      var_18 = [];

      for(var_6 = 0; var_6 < var_9.size; var_6++) {
        var_19 = distance(var_9[var_6].origin, self.origin);
        var_18[var_6] = var_19;
        var_17[var_6] = var_19;
      }

      if(var_2.size == 1) {
        var_20 = 1.5;

        for(var_6 = 0; var_6 < var_17.size; var_6++)
          var_17[var_6] = var_17[var_6] + level._id_3C81[_id_4194(var_9[var_6])][_id_4194(var_2[0])] * var_20;
      }

      if(self._id_943A == 0) {
        var_15 = randomint(100);

        if(var_15 < 50)
          var_0 = var_9[0];
        else if(var_15 < 50 + 50 / (var_9.size - 1))
          var_0 = var_9[1];
        else
          var_0 = var_9[2];
      } else if(var_17.size == 2) {
        var_21[0] = 50;
        var_21[1] = 50;

        for(var_6 = 0; var_6 < var_9.size; var_6++) {
          if(var_17[var_6] < var_17[1 - var_6]) {
            var_21[var_6] = var_21[var_6] + 20;
            var_21[1 - var_6] = var_21[1 - var_6] - 20;
          }

          if(var_18[var_6] < 640) {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[1 - var_6] = var_21[1 - var_6] - 15;
          }

          if(var_9[var_6] maps\mp\gametypes\dom::_id_44E3() == "neutral") {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[1 - var_6] = var_21[1 - var_6] - 15;
          }
        }

        var_15 = randomint(100);

        if(var_15 < var_21[0])
          var_0 = var_9[0];
        else
          var_0 = var_9[1];
      } else if(var_17.size == 3) {
        var_21[0] = 34;
        var_21[1] = 33;
        var_21[2] = 33;

        for(var_6 = 0; var_6 < var_9.size; var_6++) {
          var_22 = (var_6 + 1) % 3;
          var_23 = (var_6 + 2) % 3;

          if(var_17[var_6] < var_17[var_22] && var_17[var_6] < var_17[var_23]) {
            var_21[var_6] = var_21[var_6] + 36;
            var_21[var_22] = var_21[var_22] - 18;
            var_21[var_23] = var_21[var_23] - 18;
          }

          if(var_18[var_6] < 640) {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[var_22] = var_21[var_22] - 7;
            var_21[var_23] = var_21[var_23] - 8;
          }

          if(var_9[var_6] maps\mp\gametypes\dom::_id_44E3() == "neutral") {
            var_21[var_6] = var_21[var_6] + 15;
            var_21[var_22] = var_21[var_22] - 7;
            var_21[var_23] = var_21[var_23] - 8;
          }
        }

        var_15 = randomint(100);

        if(var_15 < var_21[0])
          var_0 = var_9[0];
        else if(var_15 < var_21[0] + var_21[1])
          var_0 = var_9[1];
        else
          var_0 = var_9[2];
      }
    }
  } else {
    if(var_2.size > 1)
      var_24 = common_scripts\utility::_id_40B0(self.origin, var_2);
    else
      var_24 = var_2;

    foreach(var_26 in var_24) {
      if(_id_1AE1(var_26, var_2.size)) {
        var_0 = var_26;
        break;
      }
    }

    if(!isDefined(var_0)) {
      if(self._id_943A == 0)
        var_0 = var_2[0];
      else if(var_24.size == 2) {
        var_28 = _id_426A(var_24[0], var_24[1]);
        var_29 = common_scripts\utility::_id_40B0(var_28.origin, var_24);
        var_15 = randomint(100);

        if(var_15 < 70)
          var_0 = var_29[0];
        else
          var_0 = var_29[1];
      } else
        var_0 = var_24[0];
    }
  }

  if(var_8)
    _id_1FAD(var_0);
  else
    _id_2C17(var_0);
}

_id_61AD() {
  var_0 = maps\mp\bots\_bots_util::_id_19F9(self.team);
  return _ceil(var_0 / 3);
}

_id_1934() {
  if(self._id_943A == 0)
    return 1;

  var_0 = _id_4278();

  if(var_0.size == 3)
    return 1;

  var_1 = _id_04D2::_id_063E(common_scripts\utility::_id_416F(self.team));
  var_2 = _id_04D2::_id_063E(self.team);
  var_3 = 200 - var_1;
  var_4 = 200 - var_2;
  var_5 = var_4 * 0.5 > var_3;
  return var_5;
}

_id_1AE0(var_0) {
  if(_randomfloat(1) < var_0)
    return 1;

  var_1 = level._id_1A92[self._id_6F7D];

  if(var_1 == "stationary")
    return 1;
  else if(var_1 == "active")
    return 0;
}

_id_1FAD(var_0, var_1, var_2) {
  self._id_28F7 = var_0;

  if(_id_19B3()) {
    var_3["override_goal_type"] = var_1;
    var_3["entrance_points_index"] = _id_4194(var_0);
    maps\mp\bots\_bots_strategy::_id_1AA6(var_0.origin, _id_4195(), var_3);
  } else {
    var_3["override_goal_type"] = var_1;
    var_3["entrance_points_index"] = _id_4194(var_0);
    maps\mp\bots\_bots_strategy::_id_196B(var_0.origin, var_0._id_671A, var_0, var_3);
  }

  if(!isDefined(var_2) || !var_2)
    thread _id_630E(var_0);
}

_id_2C17(var_0) {
  self._id_28F7 = var_0;

  if(_id_19B2()) {
    var_1["entrance_points_index"] = _id_4194(var_0);
    maps\mp\bots\_bots_strategy::_id_196B(var_0.origin, var_0._id_671A, var_0, var_1);
  } else {
    var_1["entrance_points_index"] = _id_4194(var_0);
    var_1["nearest_node_to_center"] = var_0._id_6638;
    maps\mp\bots\_bots_strategy::_id_1AA6(var_0.origin, _id_4195(), var_1);
  }

  thread _id_630E(var_0);
}

_id_4193() {
  if(!isDefined(level._id_1FB1))
    level._id_1FB1 = 158;

  return level._id_1FB1;
}

_id_4195() {
  if(!isDefined(level._id_7790)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level._id_7790 = _min(1000, var_1 / 3.5);
  }

  return level._id_7790;
}

_id_19B5(var_0, var_1) {
  if(issubstr(var_0, "losing") && var_0 != "losing_score" && var_0 != "losing_time") {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_3 = _id_4341(var_2);

    if(_id_1933(var_3)) {
      self botmemoryevent("known_enemy", undefined, var_3.origin);

      if(!isDefined(self._id_5B30) || gettime() - self._id_5B30 > 10000) {
        if(maps\mp\bots\_bots_util::_id_1A33()) {
          var_4 = distancesquared(self.origin, var_3.origin) < 490000;
          var_5 = _id_1A34(var_3);

          if(var_4 || var_5) {
            _id_1FAD(var_3);
            self._id_5B30 = gettime();
          }
        }
      }
    }
  } else if(issubstr(var_0, "secured")) {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_6 = _id_4341(var_2);
    var_6._id_5B62[self.team] = gettime();
  }

  maps\mp\bots\_bots_util::_id_1A59(var_0, var_1);
}

_id_1933(var_0) {
  var_1 = _id_4278();

  if(var_1.size == 0)
    return 1;

  if(common_scripts\utility::_id_0F79(var_1, var_0))
    return 1;

  return 0;
}

_id_630E(var_0) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = _id_4250(self.team);
  var_2 = _id_4193() * _id_4193();
  var_3 = _id_4193() * 3 * (_id_4193() * 3);
  var_4 = 1;

  while(var_4) {
    var_5 = 0;
    var_6 = var_0 maps\mp\gametypes\dom::_id_44E3();
    var_7 = _id_4250(self.team);
    var_8 = _id_416E(self.team);

    if(maps\mp\bots\_bots_util::_id_1A28()) {
      if(var_6 == self.team && var_0._id_A222._id_230F == "none") {
        if(!_id_19B2())
          var_5 = 1;
      }

      if(var_7 == 2 && var_6 != self.team && !_id_1934()) {
        if(distancesquared(self.origin, var_0.origin) > var_2)
          var_5 = 1;
      }

      foreach(var_10 in var_8) {
        if(var_10 != var_0 && _id_1933(var_10)) {
          if(distancesquared(self.origin, var_10.origin) < var_3)
            var_5 = 1;
        }
      }

      if(self istouching(var_0) && var_0._id_A222._id_A22B <= 0) {
        if(self bothasscriptgoal()) {
          var_12 = self botgetscriptgoal();
          var_13 = self botgetscriptgoalradius();

          if(distancesquared(self.origin, var_12) < _squared(var_13)) {
            var_14 = self getnearestnode();

            if(isDefined(var_14)) {
              var_15 = undefined;

              foreach(var_17 in var_0._id_671A) {
                if(!_nodesvisible(var_17, var_14, 1)) {
                  var_15 = var_17.origin;
                  break;
                }
              }

              if(isDefined(var_15)) {
                self._id_2C87 = var_15;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(maps\mp\bots\_bots_util::_id_1A33()) {
      if(var_6 != self.team) {
        if(!_id_19B3())
          var_5 = 1;
      } else if(var_7 == 1 && var_1 > 1)
        var_5 = 1;
    }

    var_1 = var_7;

    if(var_5) {
      self._id_3DF4 = 1;
      var_4 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var_19 = level common_scripts\utility::_id_A74D("flag_changed_ownership", 1 + _randomfloatrange(0, 2));

    if(!(isDefined(var_19) && var_19 == "timeout")) {
      var_20 = max((3 - self._id_943A) * 1.0 + _randomfloatrange(-0.5, 0.5), 0);
      wait(var_20);
    }
  }
}

_id_19B4(var_0) {
  if(var_0 == self._id_6709)
    return 1.0;

  if(!isDefined(self._id_28F7))
    return 1.0;

  var_1 = 0;
  var_2 = _id_4194(self._id_28F7);
  var_3 = _id_4094(self.team);

  foreach(var_5 in var_3) {
    if(var_5 != self._id_28F7) {
      var_1 = var_0 maps\mp\bots\_bots_util::_id_670D(var_2, _id_4194(var_5));

      if(var_1) {
        var_6 = _id_426A(self._id_28F7, var_5);
        var_7 = var_6 maps\mp\gametypes\dom::_id_44E3();

        if(var_7 != self.team) {
          if(var_0 maps\mp\bots\_bots_util::_id_670D(var_2, _id_4194(var_6)))
            var_1 = 0;
        }
      }
    }
  }

  if(var_1)
    return 0.2;

  return 1.0;
}

_id_4194(var_0) {
  var_1 = "";

  if(isDefined(var_0._id_98BF))
    var_1 = var_1 + (var_0._id_98BF + "_");

  var_1 = var_1 + ("flag" + var_0.shootblank);
  return var_1;
}

_id_426A(var_0, var_1) {
  for(var_2 = 0; var_2 < level._id_3CC5.size; var_2++) {
    if(level._id_3CC5[var_2] != var_0 && level._id_3CC5[var_2] != var_1)
      return level._id_3CC5[var_2];
  }
}

_id_4342(var_0) {
  var_1 = "_" + _tolower(var_0);
  _id_4341(var_1);
}

_id_4341(var_0) {
  for(var_1 = 0; var_1 < level._id_3CC5.size; var_1++) {
    if(level._id_3CC5[var_1].shootblank == var_0)
      return level._id_3CC5[var_1];
  }
}

_id_40FC(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_3CC5) {
    var_5 = distancesquared(var_4.origin, var_0);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

_id_424E(var_0, var_1) {
  var_2 = 0;
  var_3 = _id_4193();

  foreach(var_5 in level._id_6E97) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(var_5.team == self.team && var_5 != self && maps\mp\_utility::_id_5800(var_5)) {
      if(_isai(var_5)) {
        if(var_5 _id_1A29(var_0))
          var_2++;

        continue;
      }

      if(!isDefined(var_1) || !var_1) {
        if(var_5 istouching(var_0))
          var_2++;
      }
    }
  }

  return var_2;
}

_id_1A29(var_0) {
  if(!maps\mp\bots\_bots_util::_id_1A28())
    return 0;

  return _id_1AF8(var_0);
}

_id_1A34(var_0) {
  if(!maps\mp\bots\_bots_util::_id_1A33())
    return 0;

  return _id_1AF8(var_0);
}

_id_1AF8(var_0) {
  return self._id_28F7 == var_0;
}

_id_4250(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_3CC5.size; var_2++) {
    var_3 = level._id_3CC5[var_2] maps\mp\gametypes\dom::_id_44E3();

    if(var_3 == var_0)
      var_1++;
  }

  return var_1;
}

_id_416E(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_3CC5.size; var_2++) {
    var_3 = level._id_3CC5[var_2] maps\mp\gametypes\dom::_id_44E3();

    if(var_3 == common_scripts\utility::_id_416F(var_0))
      var_1 = common_scripts\utility::_id_0F6F(var_1, level._id_3CC5[var_2]);
  }

  return var_1;
}

_id_4094(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_3CC5.size; var_2++) {
    var_3 = level._id_3CC5[var_2] maps\mp\gametypes\dom::_id_44E3();

    if(var_3 == var_0)
      var_1 = common_scripts\utility::_id_0F6F(var_1, level._id_3CC5[var_2]);
  }

  return var_1;
}

_id_1AE1(var_0, var_1) {
  var_2 = _id_420D(var_1);
  var_3 = _id_42B5(var_0);
  return var_3.size < var_2;
}

_id_420D(var_0) {
  var_1 = maps\mp\bots\_bots_util::_id_19F9(self.team);

  if(var_0 == 1)
    return _ceil(var_1 / 6);
  else
    return _ceil(var_1 / 3);
}

_id_42B5(var_0) {
  var_1 = _id_4195();
  var_2 = [];

  foreach(var_4 in level._id_6E97) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(var_4.team == self.team && var_4 != self && maps\mp\_utility::_id_5800(var_4)) {
      if(_isai(var_4)) {
        if(var_4 _id_1A34(var_0))
          var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);

        continue;
      }

      var_5 = gettime() - var_0._id_5B62[self.team];

      if(var_5 < 10000) {
        continue;
      }
      if(distancesquared(var_0.origin, var_4.origin) < var_1 * var_1)
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
    }
  }

  return var_2;
}