/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_dom.gsc
*************************************************/

main() {
  if(scripts\common\utility::_id_862F()) {
    return;
  }
  level._id_27F6 = 0;
  _id_D795();
  _id_D770(3, 5);
  level thread scripts\mp\bots\bots_util::_id_285A(scripts\mp\bots\bots_util::_id_290F);
}

_id_D795() {
  level._id_279D["crate_can_use"] = ::_id_3E6F;
  level._id_279D["gametype_think"] = ::_id_277D;
  level._id_279D["should_start_cautious_approach"] = ::_id_DADC;
  level._id_279D["leader_dialog"] = ::_id_277B;

  if(!level._id_27F6) {
    level._id_279D["get_watch_node_chance"] = ::_id_277A;
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
    var_0 = scripts\mp\gametypes\dom::_id_6A45();

    if(var_0 != "neutral") {
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
  var_0 = scripts\mp\gametypes\dom::_id_6A45();

  for(;;) {
    var_1 = scripts\mp\gametypes\dom::_id_6A45();

    if(var_1 != var_0) {
      level notify("flag_changed_ownership");
    }

    var_0 = var_1;
    wait 0.05;
  }
}

_id_D770(var_0, var_1) {
  scripts\mp\bots\bots_util::_id_291B();
  var_2 = _id_27B5();

  if(var_2.size > 3) {
    while(!isDefined(level._id_F021)) {
      wait 0.05;
    }

    var_3 = [];

    foreach(var_5 in var_2) {
      if(!isDefined(var_3[var_5._id_F035])) {
        var_3[var_5._id_F035] = [];
      }

      var_3[var_5._id_F035] = ::scripts\engine\utility::array_add(var_3[var_5._id_F035], var_5);
    }

    foreach(var_9, var_8 in var_3) {
      level._id_551E = 0;
      _id_2715(var_8);
      scripts\mp\bots\bots_gametype_common::_id_2711(var_8, var_9 + "_flag", level._id_27F6);
    }
  } else {
    scripts\mp\bots\bots_gametype_common::_id_2711(var_2, "flag", level._id_27F6);
    _id_2715(var_2);
    thread _id_291A(var_2);
  }

  foreach(var_5 in var_2) {
    var_5 thread _id_A0CD();
    var_5 thread _id_A0CE();

    if(var_5._id_A8E1 != "_a" && var_5._id_A8E1 != "_b" && var_5._id_A8E1 != "_c") {}

    var_5._id_A578 = scripts\mp\bots\bots_gametype_common::_id_27D8(var_5.trigger);
    var_5._id_8F70["allies"] = 0;
    var_5._id_8F70["axis"] = 0;
  }

  level._id_277C = [];
  level._id_277C["axis"] = [];
  level._id_277C["allies"] = [];
  level._id_27B0 = 1;
}

_id_291A(var_0) {
  level endon("game_ended");
  level waittill("dom_flags_moved");
  scripts\mp\bots\bots_gametype_common::_id_2711(var_0, "flag", level._id_27F6, 1);
  _id_2715(var_0);

  foreach(var_2 in var_0) {
    var_2._id_A578 = scripts\mp\bots\bots_gametype_common::_id_27D8(var_2);
  }

  foreach(var_5 in level._id_AE7C) {
    if(scripts\mp\utility\entity::_id_8744(var_5)) {
      var_5._id_5E5B = 1;
    }
  }
}

_id_27B5() {
  if(isDefined(level._id_1469)) {
    return level._id_1469;
  } else {
    return level._id_A8E8;
  }
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

_id_DADC(var_0) {
  if(var_0) {
    if(self._id_416E scripts\mp\gametypes\dom::_id_6A45() == "neutral" && _id_5C10(self._id_416E)) {
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

_id_2778() {
  return 0;
}

_id_2779() {
  return 0;
}

_id_277D() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
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

_id_DA81() {
  if(self._id_5E5B) {
    return 0;
  }

  if(!scripts\mp\bots\bots_util::_id_2801()) {
    return 0;
  }

  if(self._id_416E scripts\mp\gametypes\dom::_id_6A45() == self.team) {
    return 0;
  }

  var_0 = _id_64A7();

  if(distancesquared(self.origin, self._id_416E.trigger.origin) < var_0 * 2 * (var_0 * 2)) {
    var_1 = _id_6343(self.team);

    if(var_1.size == 2 && !scripts\engine\utility::array_contains(var_1, self._id_416E) && !_id_26F9()) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_6631() {
  return level._id_277C[self.team];
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
  var_1 = [];
  var_2 = [];
  var_3 = !istrue(level._id_BB6F);
  var_4 = _id_6631();

  if(var_4.size > 0) {
    var_5 = var_4;
  } else {
    var_5 = level._id_A8E8;
  }

  foreach(var_0 in var_5) {
    var_7 = var_0 scripts\mp\gametypes\dom::_id_6A45();

    if(var_3) {
      if(_id_5C0F(var_0)) {
        var_3 = 0;
      } else {}
    }

    if(var_7 != self.team) {
      var_1[var_1.size] = var_0;
      continue;
    }

    var_2[var_2.size] = var_0;
  }

  var_9 = undefined;

  if(var_1.size == 3) {
    var_9 = 1;
  } else if(var_1.size == 2) {
    if(var_2.size == 1) {
      if(!_id_28D5(var_2[0], 1)) {
        var_9 = 1;
      } else {
        var_9 = !_id_28D4(0.34);
      }

      if(scripts\mp\bots\bots_util::_id_27C9(self.team) == 1) {
        var_9 = 1;
      }
    } else if(var_2.size == 0)
      var_9 = 1;
  } else if(var_1.size == 1) {
    if(var_2.size == 2) {
      if(_id_26F9()) {
        if(!_id_28D5(var_2[0], 2) && !_id_28D5(var_2[1], 2)) {
          var_9 = 1;
        } else if(self._id_E9FC == 0) {
          var_9 = !_id_28D4(0.34);
        } else {
          var_9 = !_id_28D4(0.5);
        }
      } else
        var_9 = 0;
    } else if(var_2.size == 1) {
      if(!_id_28D5(var_2[0], 1)) {
        var_9 = 1;
      } else {
        var_9 = !_id_28D4(0.34);
      }
    } else if(var_2.size == 0)
      var_9 = 1;
  } else if(var_1.size == 0)
    var_9 = 0;

  if(var_9) {
    if(var_1.size > 1) {
      var_10 = [];

      foreach(var_12 in var_1) {
        var_10[var_10.size] = var_12.trigger;
      }

      var_14 = scripts\engine\utility::_id_6369(self.origin, var_10);
      var_15 = [];

      foreach(var_17 in var_14) {
        foreach(var_19 in level._id_A8E8) {
          if(var_19.trigger == var_17) {
            var_15[var_15.size] = var_19;
          }
        }
      }

      var_14 = var_15;
    } else
      var_14 = var_1;

    if(var_3 && !_id_7509()) {
      var_22 = _id_65F5(var_14[0], 1);

      if(var_22 < _id_9EA2()) {
        var_23 = 0;
      } else {
        var_24 = 20;
        var_25 = 65;
        var_26 = 15;

        if(self._id_E9FC == 0) {
          var_24 = 50;
          var_25 = 25;
          var_26 = 25;
        } else if(self._id_E9FC == 1) {
          var_24 = 40;
          var_25 = 40;
          var_26 = 20;
        }

        var_27 = randomint(100);

        if(var_27 < var_24) {
          var_23 = 0;
        } else if(var_27 < var_24 + var_25) {
          var_23 = 1;
        } else {
          var_23 = 2;
        }
      }

      var_28 = undefined;

      if(var_23 == 0) {
        var_28 = "critical";
      }

      _id_3221(var_14[var_23], var_28);
      return;
    }

    if(var_14.size == 1) {
      var_0 = var_14[0];
    } else if(distancesquared(var_14[0].trigger.origin, self.origin) < 102400) {
      var_0 = var_14[0];
    } else {
      var_29 = [];
      var_30 = [];

      for(var_31 = 0; var_31 < var_14.size; var_31++) {
        var_32 = distance(var_14[var_31].trigger.origin, self.origin);
        var_30[var_31] = var_32;
        var_29[var_31] = var_32;
      }

      if(var_2.size == 1) {
        var_33 = 1.5;

        for(var_31 = 0; var_31 < var_29.size; var_31++) {
          var_29[var_31] = var_29[var_31] + level._id_5C0A[_id_64A8(var_14[var_31])][_id_64A8(var_2[0])] * var_33;
        }
      }

      if(self._id_E9FC == 0) {
        var_27 = randomint(100);

        if(var_27 < 50) {
          var_0 = var_14[0];
        } else if(var_27 < 50 + 50 / (var_14.size - 1)) {
          var_0 = var_14[1];
        } else {
          var_0 = var_14[2];
        }
      } else if(var_29.size == 2) {
        var_34[0] = 50;
        var_34[1] = 50;

        for(var_31 = 0; var_31 < var_14.size; var_31++) {
          if(var_29[var_31] < var_29[1 - var_31]) {
            var_34[var_31] = var_34[var_31] + 20;
            var_34[1 - var_31] = var_34[1 - var_31] - 20;
          }

          if(var_30[var_31] < 640) {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[1 - var_31] = var_34[1 - var_31] - 15;
          }

          if(var_14[var_31] scripts\mp\gametypes\dom::_id_6A45() == "neutral") {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[1 - var_31] = var_34[1 - var_31] - 15;
          }
        }

        var_27 = randomint(100);

        if(var_27 < var_34[0]) {
          var_0 = var_14[0];
        } else {
          var_0 = var_14[1];
        }
      } else if(var_29.size == 3) {
        var_34[0] = 34;
        var_34[1] = 33;
        var_34[2] = 33;

        for(var_31 = 0; var_31 < var_14.size; var_31++) {
          var_35 = (var_31 + 1) % 3;
          var_36 = (var_31 + 2) % 3;

          if(var_29[var_31] < var_29[var_35] && var_29[var_31] < var_29[var_36]) {
            var_34[var_31] = var_34[var_31] + 36;
            var_34[var_35] = var_34[var_35] - 18;
            var_34[var_36] = var_34[var_36] - 18;
          }

          if(var_30[var_31] < 640) {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[var_35] = var_34[var_35] - 7;
            var_34[var_36] = var_34[var_36] - 8;
          }

          if(var_14[var_31] scripts\mp\gametypes\dom::_id_6A45() == "neutral") {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[var_35] = var_34[var_35] - 7;
            var_34[var_36] = var_34[var_36] - 8;
          }
        }

        var_27 = randomint(100);

        if(var_27 < var_34[0]) {
          var_0 = var_14[0];
        } else if(var_27 < var_34[0] + var_34[1]) {
          var_0 = var_14[1];
        } else {
          var_0 = var_14[2];
        }
      }
    }
  } else {
    if(var_2.size > 1) {
      var_10 = [];

      foreach(var_38 in var_2) {
        var_10[var_10.size] = var_38.trigger;
      }

      var_40 = scripts\engine\utility::_id_6369(self.origin, var_10);
      var_15 = [];

      foreach(var_17 in var_40) {
        foreach(var_19 in level._id_A8E8) {
          if(var_19.trigger == var_17) {
            var_15[var_15.size] = var_19;
          }
        }
      }

      var_40 = var_15;
    } else
      var_40 = var_2;

    foreach(var_46 in var_40) {
      if(_id_28D5(var_46, var_2.size)) {
        var_0 = var_46;
        break;
      }
    }

    if(!isDefined(var_0)) {
      if(self._id_E9FC == 0) {
        var_0 = var_2[0];
      } else if(var_40.size == 2) {
        var_48 = _id_6624(var_40[0], var_40[1]);
        var_10 = [];

        foreach(var_50 in var_40) {
          var_10[var_10.size] = var_50.trigger;
        }

        var_52 = scripts\engine\utility::_id_6369(var_48.trigger.origin, var_10);
        var_15 = [];

        foreach(var_17 in var_52) {
          foreach(var_19 in level._id_A8E8) {
            if(var_19.trigger == var_17) {
              var_15[var_15.size] = var_19;
            }
          }
        }

        var_52 = var_15;
        var_27 = randomint(100);

        if(var_27 < 70) {
          var_0 = var_52[0];
        } else {
          var_0 = var_52[1];
        }
      } else
        var_0 = var_40[0];
    }
  }

  if(var_9) {
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

  if(_id_2779()) {
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

  if(_id_2778()) {
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

_id_277B(var_0, var_1) {
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
    var_6 = var_0 scripts\mp\gametypes\dom::_id_6A45();
    var_7 = _id_65F7(self.team);
    var_8 = _id_6476(self.team);

    if(scripts\mp\bots\bots_util::_id_2801()) {
      if(var_6 == self.team && var_0._id_37F6 == "none") {
        if(!_id_2778()) {
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
          if(distancesquared(self.origin, var_10.trigger.origin) < var_3) {
            var_5 = 1;
          }
        }
      }

      if(self istouching(var_0.trigger) && var_0._id_FEB1 <= 0) {
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
        if(!_id_2779()) {
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

_id_277A(var_0) {
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

      if(var_1) {
        var_6 = _id_6624(self._id_416E, var_5);
        var_7 = var_6 scripts\mp\gametypes\dom::_id_6A45();

        if(var_7 != self.team) {
          if(var_0 scripts\mp\bots\bots_util::_id_A55D(var_2, _id_64A8(var_6))) {
            var_1 = 0;
          }
        }
      }
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
    var_4 = var_3 scripts\mp\gametypes\dom::_id_6A45();

    if(var_4 == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_6476(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    var_4 = var_3 scripts\mp\gametypes\dom::_id_6A45();

    if(var_4 == scripts\engine\utility::_id_647F(var_0)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

_id_6343(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    var_4 = var_3 scripts\mp\gametypes\dom::_id_6A45();

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