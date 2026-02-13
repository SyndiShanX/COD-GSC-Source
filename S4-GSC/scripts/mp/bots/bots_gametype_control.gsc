/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_control.gsc
*****************************************************/

main() {
  level._id_27F6 = 0;
  _id_D795();
  setup_bot_control(2, 5);
  level thread scripts\mp\bots\bots_util::_id_285A(scripts\mp\bots\bots_util::_id_290F);
}

_id_D795() {
  level._id_279D["crate_can_use"] = ::_id_3E6F;
  level._id_279D["gametype_think"] = ::bot_control_think;
  level._id_279D["should_start_cautious_approach"] = ::should_start_cautious_approach_control;
  level._id_279D["leader_dialog"] = ::bot_control_leader_dialog;

  if(!level._id_27F6) {
    level._id_279D["get_watch_node_chance"] = ::bot_control_get_node_chance;
  }
}

bot_control_think() {
  self notify("bot_control_think");
  self endon("bot_control_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self._id_5E5B = 0;
  self._id_A44C = 0;
  self._id_A484 = 0;
  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);
  self _meth_8054("use_obj_path_style", 1);

  for(;;) {
    scripts\mp\bots\bots_util::_id_290C();
    var_0 = gettime();

    if(var_0 > self._id_A484) {
      self._id_A484 = gettime() + 10000;
      self._id_E9FC = self _meth_8030("strategyLevel");
    }

    if(var_0 > self._id_A44C || self._id_5E5B) {
      if(_id_DA81()) {
        self._id_A44C = var_0 + 5000;
      } else {
        self._id_5E5B = 0;
        _id_2733();
        self._id_A44C = var_0 + randomintrange(30000, 45000);
      }
    }

    scripts\engine\utility::_id_108F5("needs_new_flag_goal", 1.0);
  }
}

_id_3E6F(var_0) {
  if(isagent(self) && !isDefined(var_0._id_2991)) {
    return 0;
  }

  if(!scripts\mp\utility\entity::_id_8A94(self)) {
    return 1;
  }

  return scripts\mp\bots\bots_util::_id_280B();
}

_id_A0CD() {
  self notify("monitor_flag_control");
  self endon("monitor_flag_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 1;
    var_0 = scripts\mp\gametypes\control::_id_6A45();

    if(var_0 != "neutral") {
      if(!isDefined(self.trigger)) {
        break;
      }

      var_1 = _func_00F5(self.trigger.origin);

      if(isDefined(var_1)) {
        _func_002C(var_1, var_0);
      }
    }
  }
}

_id_A0CE() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  var_0 = scripts\mp\gametypes\control::_id_6A45();

  for(;;) {
    var_1 = scripts\mp\gametypes\control::_id_6A45();

    if(var_1 != var_0) {
      level notify("flag_changed_ownership");
    }

    var_0 = var_1;
    wait 0.05;
  }
}

setup_bot_control(var_0, var_1) {
  scripts\mp\bots\bots_util::_id_291B();

  while(!isDefined(level._id_A8E8) || level._id_A8E8.size != 2) {
    wait 0.5;
  }

  var_2 = _id_27B5();
  scripts\mp\bots\bots_gametype_common::_id_2711(var_2, "flag", level._id_27F6);
  _id_2715(var_2);

  foreach(var_4 in var_2) {
    var_4 thread _id_A0CD();
    var_4 thread _id_A0CE();

    if(var_4._id_A8E1 != "_a" && var_4._id_A8E1 != "_b") {}

    var_4._id_A578 = scripts\mp\bots\bots_gametype_common::_id_27D8(var_4.trigger);
    var_4._id_8F70["allies"] = 0;
    var_4._id_8F70["axis"] = 0;
  }

  level.bot_control_override_flag_targets = [];
  level.bot_control_override_flag_targets["axis"] = [];
  level.bot_control_override_flag_targets["allies"] = [];
  level._id_27B0 = 1;
}

_id_27B5() {
  var_0 = [];

  foreach(var_2 in level._id_A8E8) {
    if(isDefined(var_2.trigger)) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  return var_0;
}

_id_2715(var_0) {
  if(!isDefined(level._id_5C0A)) {
    level._id_5C0A = [];
  }

  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_1[var_2] = var_4;
    var_2++;
  }

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    for(var_6 = var_2 + 1; var_6 < var_1.size; var_6++) {
      var_7 = distance(var_1[var_2].trigger.origin, var_1[var_6].trigger.origin);
      var_8 = _id_64A8(var_1[var_2]);
      var_9 = _id_64A8(var_1[var_6]);
      level._id_5C0A[var_8][var_9] = var_7;
      level._id_5C0A[var_9][var_8] = var_7;
    }
  }
}

should_start_cautious_approach_control(var_0) {
  if(var_0) {
    if(self._id_416E scripts\mp\gametypes\control::_id_6A45() == "neutral" && _id_5C10(self._id_416E)) {
      var_1 = _id_63DA(self._id_904C.origin);

      if(var_1 == self._id_416E) {
        return 0;
      } else {
        var_2 = _id_6624(var_1, self._id_416E);
        var_3 = distancesquared(var_1.trigger.origin, self._id_416E.trigger.origin);
        var_4 = distancesquared(var_2.trigger.origin, self._id_416E.trigger.origin);

        if(var_3 < var_4) {
          return 0;
        }
      }
    }
  }

  return _id_09F9::_id_DADB(var_0);
}

bot_control_debug_should_capture_all() {
  return 0;
}

bot_control_debug_should_protect_all() {
  return 0;
}

_id_DA81() {
  if(self._id_5E5B) {
    return 0;
  }

  if(!scripts\mp\bots\bots_util::_id_2801()) {
    return 0;
  }

  if(self._id_416E scripts\mp\gametypes\control::_id_6A45() == self.team) {
    return 0;
  }

  var_0 = _id_64A7();

  if(isDefined(self._id_416E.trigger) && distancesquared(self.origin, self._id_416E.trigger.origin) < var_0 * 2 * (var_0 * 2)) {
    var_1 = _id_6343(self.team);

    if(var_1.size == 2 && !scripts\engine\utility::array_contains(var_1, self._id_416E) && !_id_26F9()) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_6631() {
  return level.bot_control_override_flag_targets[self.team];
}

_id_7509() {
  var_0 = _id_6631();
  return var_0.size > 0;
}

_id_5C0F(var_0) {
  return !_id_5C10(var_0);
}

_id_5C10(var_0) {
  return var_0._id_5BC6;
}

_id_2733() {
  var_0 = undefined;
  var_1 = game["attackers"] == self.team;
  var_2 = !istrue(level._id_BB6F);
  var_3 = _id_6631();

  if(var_3.size > 0) {
    var_4 = var_3;
  } else {
    var_4 = _id_27B5();
  }

  if(var_4.size == 0) {
    return undefined;
  }

  foreach(var_0 in var_4) {
    var_6 = var_0 scripts\mp\gametypes\control::_id_6A45();

    if(var_2) {
      if(_id_5C0F(var_0)) {
        var_2 = 0;
      }
    }
  }

  if(var_1) {
    if(var_4.size > 1) {
      var_8 = [];

      foreach(var_10 in var_4) {
        var_8[var_8.size] = var_10.trigger;
      }

      var_12 = scripts\engine\utility::_id_6369(self.origin, var_8);
      var_13 = [];

      foreach(var_15 in var_12) {
        foreach(var_17 in level._id_A8E8) {
          if(var_17.trigger == var_15) {
            var_13[var_13.size] = var_17;
          }
        }
      }

      var_12 = var_13;
    } else
      var_12 = var_4;

    if(var_2 && !_id_7509()) {
      var_20 = _id_65F5(var_12[0], 1);

      if(var_20 < _id_9EA2()) {
        var_21 = 0;
      } else {
        var_22 = 40;
        var_23 = 60;

        if(self._id_E9FC == 0) {
          var_22 = 75;
          var_23 = 25;
        } else if(self._id_E9FC == 1) {
          var_22 = 60;
          var_23 = 40;
        }

        var_24 = randomint(100);

        if(var_24 < var_22) {
          var_21 = 0;
        } else {
          var_21 = 1;
        }
      }

      var_25 = undefined;

      if(var_21 == 0) {
        var_25 = "critical";
      }

      _id_3221(var_12[var_21], var_25);
      return;
    }

    if(var_12.size == 1) {
      var_0 = var_12[0];
    } else if(distancesquared(var_12[0].trigger.origin, self.origin) < 102400) {
      var_0 = var_12[0];
    } else {
      var_26 = [];
      var_27 = [];
      var_28 = [];

      for(var_29 = 0; var_29 < var_12.size; var_29++) {
        var_30 = distance(var_12[var_29].trigger.origin, self.origin);
        var_28[var_29] = var_30;
        var_27[var_29] = var_30;
      }

      if(self._id_E9FC == 0) {
        var_24 = randomint(100);

        if(var_24 < 50) {
          var_0 = var_12[0];
        } else if(var_24 < 50 + 50 / (var_12.size - 1)) {
          var_0 = var_12[1];
        } else {
          var_0 = var_12[2];
        }
      } else if(var_27.size == 2) {
        var_26[0] = 50;
        var_26[1] = 50;

        if(var_27[0] < var_27[1]) {
          var_26[0] = var_26[0] + 20;
          var_26[1] = var_26[1] - 20;
        } else {
          var_26[0] = var_26[0] - 20;
          var_26[1] = var_26[1] + 20;
        }

        if(var_28[0] < 640) {
          var_26[0] = var_26[0] + 15;
          var_26[1] = var_26[1] - 15;
        } else {
          var_26[0] = var_26[0] - 15;
          var_26[1] = var_26[1] + 15;
        }

        if(self._id_E9FC > 0) {
          if(var_12[0]._id_4143 == 1) {
            var_26[0] = var_26[0] + 15;
            var_26[1] = var_26[1] - 15;
          } else if(var_12[0]._id_4143 == 2) {
            var_26[0] = var_26[0] + 20;
            var_26[1] = var_26[1] - 20;
          }

          if(var_12[1]._id_4143 == 1) {
            var_26[0] = var_26[0] - 15;
            var_26[1] = var_26[1] + 15;
          } else if(var_12[1]._id_4143 == 2) {
            var_26[0] = var_26[0] - 20;
            var_26[1] = var_26[1] + 20;
          }
        }

        var_24 = randomint(100);

        if(var_24 < var_26[0]) {
          var_0 = var_12[0];
        } else {
          var_0 = var_12[1];
        }
      }
    }
  } else {
    if(var_4.size > 1) {
      var_8 = [];

      foreach(var_32 in var_4) {
        var_8[var_8.size] = var_32.trigger;
      }

      var_34 = scripts\engine\utility::_id_6369(self.origin, var_8);
      var_13 = [];

      foreach(var_15 in var_34) {
        foreach(var_17 in level._id_A8E8) {
          if(var_17.trigger == var_15) {
            var_13[var_13.size] = var_17;
          }
        }
      }

      var_34 = var_13;
    } else
      var_34 = var_4;

    foreach(var_40 in var_34) {
      if(_id_28D5(var_40, var_34.size)) {
        var_0 = var_40;
        break;
      }
    }

    if(!isDefined(var_0)) {
      var_0 = var_34[0];
    }
  }

  if(var_1) {
    _id_3221(var_0);
  } else {
    _id_45DC(var_0);
  }
}

_id_9EA2() {
  var_0 = scripts\mp\bots\bots_util::_id_27C9(self.team);
  return _func_0037(var_0 / 3);
}

_id_26F9() {
  if(self._id_E9FC == 0) {
    return 1;
  }

  var_0 = _id_6631();

  if(var_0.size == 3) {
    return 1;
  }

  var_1 = scripts\mp\gamescore::_id_0C0F(scripts\engine\utility::_id_647F(self.team));
  var_2 = scripts\mp\gamescore::_id_0C0F(self.team);
  var_3 = 200 - var_1;
  var_4 = 200 - var_2;
  var_5 = var_4 * 0.5 > var_3;
  return var_5;
}

_id_28D4(var_0) {
  if(randomfloat(1) < var_0) {
    return 1;
  }

  var_1 = level._id_2884[self._id_B023];

  if(var_1 == "stationary") {
    return 1;
  } else if(var_1 == "active") {
    return 0;
  }
}

_id_3221(var_0, var_1, var_2) {
  self._id_416E = var_0;

  if(bot_control_debug_should_protect_all()) {
    var_3["override_goal_type"] = var_1;
    var_3["entrance_points_index"] = _id_64A8(var_0);
    _id_09F9::_id_2899(var_0.trigger.origin, _id_64A9(), var_3);
  } else {
    var_3["override_goal_type"] = var_1;
    var_3["entrance_points_index"] = _id_64A8(var_0);
    _id_09F9::_id_272A(var_0.trigger.origin, var_0._id_A578, var_0.trigger, var_3);
  }

  if(!isDefined(var_2) || !var_2) {
    thread _id_A0CF(var_0);
  }
}

_id_45DC(var_0) {
  self._id_416E = var_0;

  if(bot_control_debug_should_capture_all()) {
    var_1["entrance_points_index"] = _id_64A8(var_0);
    _id_09F9::_id_272A(var_0.trigger.origin, var_0._id_A578, var_0.trigger, var_1);
  } else {
    var_1["entrance_points_index"] = _id_64A8(var_0);
    var_1["nearest_node_to_center"] = var_0._id_A3F8;
    _id_09F9::_id_2899(var_0.trigger.origin, _id_64A9(), var_1);
  }

  thread _id_A0CF(var_0);
}

_id_64A7() {
  if(!isDefined(level._id_3222)) {
    level._id_3222 = 158;
  }

  return level._id_3222;
}

_id_64A9() {
  if(!isDefined(level._id_BDBF)) {
    var_0 = self _meth_8041();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level._id_BDBF = min(1000, var_1 / 3.5);
  }

  return level._id_BDBF;
}

bot_control_leader_dialog(var_0, var_1) {
  if(issubstr(var_0, "losing") && var_0 != "losing_score" && var_0 != "losing_time" && var_0 != "gamestate_domlosing") {
    var_2 = _func_00D6(var_0, var_0.size - 2);
    var_3 = _id_6772(var_2);

    if(isDefined(var_3) && _id_26F8(var_3)) {
      self _meth_8046("known_enemy", undefined, var_3.trigger.origin);

      if(!isDefined(self._id_8F3B) || gettime() - self._id_8F3B > 10000) {
        if(scripts\mp\bots\bots_util::_id_280B()) {
          var_4 = distancesquared(self.origin, var_3.trigger.origin) < 490000;
          var_5 = _id_280C(var_3);

          if(var_4 || var_5) {
            _id_3221(var_3);
            self._id_8F3B = gettime();
          }
        }
      }
    }
  } else if(issubstr(var_0, "secured")) {
    var_2 = _func_00D6(var_0, var_0.size - 2);
    var_6 = _id_6772(var_2);
    var_6._id_8F70[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::_id_2832(var_0, var_1);
}

_id_26F8(var_0) {
  var_1 = _id_6631();

  if(var_1.size == 0) {
    return 1;
  }

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 1;
  }

  return 0;
}

_id_A0CF(var_0) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_1 = _id_65F7(self.team);
  var_2 = _id_64A7() * _id_64A7();
  var_3 = _id_64A7() * 3 * (_id_64A7() * 3);
  var_4 = 1;

  while(var_4) {
    var_5 = 0;
    var_6 = var_0 scripts\mp\gametypes\control::_id_6A45();
    var_7 = _id_65F7(self.team);
    var_8 = _id_6476(self.team);

    if(scripts\mp\bots\bots_util::_id_2801()) {
      if(var_6 == self.team && var_0._id_37F6 == "none") {
        if(!bot_control_debug_should_capture_all()) {
          var_5 = 1;
        }
      }

      if(var_7 == 2 && var_6 != self.team && !_id_26F9()) {
        if(distancesquared(self.origin, var_0.trigger.origin) > var_2) {
          var_5 = 1;
        }
      }

      foreach(var_10 in var_8) {
        if(var_10 != var_0 && _id_26F8(var_10)) {
          if(isDefined(var_10.trigger) && distancesquared(self.origin, var_10.trigger.origin) < var_3) {
            var_5 = 1;
          }
        }
      }

      if(isDefined(var_0.trigger) && self istouching(var_0.trigger) && var_0._id_FEB1 <= 0) {
        if(self _meth_8042()) {
          var_12 = self _meth_803B();
          var_13 = self _meth_803D();

          if(distancesquared(self.origin, var_12) < _func_0219(var_13)) {
            var_14 = self _meth_815E();

            if(isDefined(var_14)) {
              var_15 = undefined;

              foreach(var_17 in var_0._id_A578) {
                if(!_func_0158(var_17, var_14, 1)) {
                  var_15 = var_17.origin;
                  break;
                }
              }

              if(isDefined(var_15)) {
                self._id_4625 = var_15;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::_id_280B()) {
      if(var_6 != self.team) {
        if(!bot_control_debug_should_protect_all()) {
          var_5 = 1;
        }
      } else if(var_7 == 1 && var_1 > 1)
        var_5 = 1;
    }

    var_1 = var_7;

    if(var_5) {
      self._id_5E5B = 1;
      var_4 = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    var_19 = level scripts\engine\utility::_id_108F7("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    var_20 = isDefined(var_19) && var_19 == "timeout";

    if(!var_20) {
      var_21 = max((3 - self._id_E9FC) * 1.0 + randomfloatrange(-0.5, 0.5), 0);
      wait(var_21);
    }
  }
}

bot_control_get_node_chance(var_0) {
  if(var_0 == self._id_A550) {
    return 1.0;
  }

  if(!isDefined(self._id_416E)) {
    return 1.0;
  }

  var_1 = 0;
  var_2 = _id_64A8(self._id_416E);
  var_3 = _id_6343(self.team);

  foreach(var_5 in var_3) {
    if(var_5 != self._id_416E) {
      var_1 = var_0 scripts\mp\bots\bots_util::_id_A55D(var_2, _id_64A8(var_5));
    }
  }

  if(var_1) {
    return 0.2;
  }

  return 1.0;
}

_id_64A8(var_0) {
  var_1 = "";

  if(isDefined(var_0._id_F035)) {
    var_1 = var_1 + (var_0._id_F035 + "_");
  }

  var_1 = var_1 + ("flag" + var_0._id_A8E1);
  return var_1;
}

_id_6624(var_0, var_1) {
  foreach(var_3 in level._id_A8E8) {
    if(var_3 != var_0 && var_3 != var_1) {
      return var_3;
    }
  }
}

_id_6773(var_0) {
  var_1 = "_" + tolower(var_0);
  return _id_6772(var_1);
}

_id_6772(var_0) {
  foreach(var_2 in level._id_A8E8) {
    if(var_2._id_A8E1 == var_0) {
      return var_2;
    }
  }
}

_id_63DA(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_A8E8) {
    var_5 = distancesquared(var_4.trigger.origin, var_0);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

_id_65F5(var_0, var_1) {
  var_2 = 0;
  var_3 = _id_64A7();

  foreach(var_5 in level._id_AE7C) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(var_5.team == self.team && var_5 != self && scripts\mp\utility\entity::_id_8A94(var_5)) {
      if(isai(var_5)) {
        if(var_5 _id_2802(var_0)) {
          var_2++;
        }

        continue;
      }

      if(!isDefined(var_1) || !var_1) {
        if(var_5 istouching(var_0)) {
          var_2++;
        }
      }
    }
  }

  return var_2;
}

_id_2802(var_0) {
  if(!scripts\mp\bots\bots_util::_id_2801()) {
    return 0;
  }

  return _id_28F5(var_0);
}

_id_280C(var_0) {
  if(!scripts\mp\bots\bots_util::_id_280B()) {
    return 0;
  }

  return _id_28F5(var_0);
}

_id_28F5(var_0) {
  return self._id_416E == var_0;
}

_id_65F7(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_A8E8) {
    var_4 = var_3 scripts\mp\gametypes\control::_id_6A45();

    if(var_4 == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_6476(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    var_4 = var_3 scripts\mp\gametypes\control::_id_6A45();

    if(var_4 == scripts\engine\utility::_id_647F(var_0)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

_id_6343(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    var_4 = var_3 scripts\mp\gametypes\control::_id_6A45();

    if(var_4 == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

_id_28D5(var_0, var_1) {
  var_2 = _id_658F(var_1);
  var_3 = _id_66A1(var_0);
  return var_3.size < var_2;
}

_id_658F(var_0) {
  var_1 = scripts\mp\bots\bots_util::_id_27C9(self.team);

  if(var_0 == 1) {
    return _func_0037(var_1 / 6);
  } else {
    return _func_0037(var_1 / 3);
  }
}

_id_66A1(var_0) {
  var_1 = _id_64A9();
  var_2 = [];

  foreach(var_4 in level._id_AE7C) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(var_4.team == self.team && var_4 != self && scripts\mp\utility\entity::_id_8A94(var_4)) {
      if(isai(var_4)) {
        if(var_4 _id_280C(var_0)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_4);
        }

        continue;
      }

      var_5 = gettime() - var_0._id_8F70[self.team];

      if(var_5 < 10000) {
        continue;
      }
      if(distancesquared(var_0.trigger.origin, var_4.origin) < var_1 * var_1) {
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
      }
    }
  }

  return var_2;
}