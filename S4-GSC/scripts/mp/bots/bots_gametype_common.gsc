/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_common.gsc
****************************************************/

_id_270F() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level._id_A8E8) {
    var_0[var_2] = ::scripts\engine\utility::random(var_4._id_2952).origin;
    var_1[var_2] = "zone" + var_4._id_A8E1;
    var_2++;
  }

  _id_270E(var_0, var_1);
}

_id_2711(var_0, var_1, var_2, var_3) {
  wait 1.0;
  var_4 = [];
  var_5 = [];
  var_6 = 0;

  foreach(var_8 in var_0) {
    var_9 = var_8.trigger;

    if(isDefined(var_9._id_2951)) {
      var_4[var_6] = var_9._id_2951.origin;
    } else {
      var_9._id_A3F8 = _func_0080(var_9.origin);

      if(!isDefined(var_9._id_A3F8) || var_9._id_A3F8 _meth_824A()) {
        var_10 = _func_00B5(var_9.origin, 256, 0);

        if(var_10.size > 0) {
          var_9._id_A3F8 = var_10[0];
        }
      }

      if(!isDefined(var_9._id_A3F8)) {
        continue;
      }
      if(distance(var_9._id_A3F8.origin, var_9.origin) > 170) {
        var_9._id_A3F8 = undefined;
        continue;
      }

      var_4[var_6] = var_9._id_A3F8.origin;
    }

    var_5[var_6] = var_1 + var_8._id_A8E1;
    var_6++;
  }

  _id_270E(var_4, var_5, var_2, var_3);
}

_id_270E(var_0, var_1, var_2, var_3) {
  var_4 = !isDefined(var_2) || !var_2;
  var_5 = isDefined(var_3) && var_3;
  wait 0.1;

  if(var_5 && var_4) {
    var_6 = _func_0075();

    foreach(var_8 in var_6) {
      var_8._id_AA5B = undefined;
    }
  }

  var_10 = [];

  for(var_11 = 0; var_11 < var_0.size; var_11++) {
    var_12 = var_1[var_11];
    var_10[var_12] = _func_0066(var_0[var_11]);
    wait 0.05;

    for(var_13 = 0; var_13 < var_10[var_12].size; var_13++) {
      var_14 = var_10[var_12][var_13];
      var_14._id_8686 = 1;
      var_14._id_BDAC[var_12] = ::scripts\mp\bots\bots_util::_id_5520(var_14.origin, var_0[var_11], "prone");
      wait 0.05;
      var_14._id_40A1[var_12] = ::scripts\mp\bots\bots_util::_id_5520(var_14.origin, var_0[var_11], "crouch");
      wait 0.05;
    }
  }

  var_15 = [];

  if(var_4) {
    for(var_11 = 0; var_11 < var_0.size; var_11++) {
      for(var_13 = var_11 + 1; var_13 < var_0.size; var_13++) {
        var_16 = scripts\mp\bots\bots_util::_id_6497(var_0[var_11], var_0[var_13]);

        foreach(var_8 in var_16) {
          var_8._id_AA5B[var_1[var_11]][var_1[var_13]] = 1;
        }
      }
    }
  }

  if(!isDefined(level._id_551C)) {
    level._id_551C = [];
  }

  if(!isDefined(level._id_551A)) {
    level._id_551A = [];
  }

  if(!isDefined(level._id_551D)) {
    level._id_551D = [];
  }

  if(var_5) {
    level._id_551C = var_0;
    level._id_551A = var_1;
    level._id_551D = var_10;
  } else {
    level._id_551C = scripts\engine\utility::array_combine(level._id_551C, var_0);
    level._id_551A = scripts\engine\utility::array_combine(level._id_551A, var_1);
    level._id_551D = scripts\engine\utility::_id_1B9C(level._id_551D, var_10);
  }

  level._id_551E = 1;
}

_id_26F2(var_0, var_1) {
  if(var_1.classname == "trigger_radius") {
    var_2 = _func_00B4(var_1.origin, var_1._id_0359, 0, 100);
    var_3 = scripts\engine\utility::_id_1BBF(var_2, var_0);

    if(var_3.size > 0) {
      var_0 = scripts\engine\utility::array_combine(var_0, var_3);
    }
  } else if(var_1.classname == "trigger_multiple" || var_1.classname == "trigger_use_touch") {
    var_4[0] = var_1 _meth_8174(1, 1, 1);
    var_4[1] = var_1 _meth_8174(1, 1, -1);
    var_4[2] = var_1 _meth_8174(1, -1, 1);
    var_4[3] = var_1 _meth_8174(1, -1, -1);
    var_4[4] = var_1 _meth_8174(-1, 1, 1);
    var_4[5] = var_1 _meth_8174(-1, 1, -1);
    var_4[6] = var_1 _meth_8174(-1, -1, 1);
    var_4[7] = var_1 _meth_8174(-1, -1, -1);
    var_5 = 0;

    foreach(var_7 in var_4) {
      var_8 = distance(var_7, var_1.origin);

      if(var_8 > var_5) {
        var_5 = var_8;
      }
    }

    var_2 = _func_00B4(var_1.origin, var_5, 0, 200);

    foreach(var_11 in var_2) {
      if(!_func_011A(var_11.origin, var_1)) {
        if(_func_011A(var_11.origin + (0, 0, 40), var_1) || _func_011A(var_11.origin + (0, 0, 80), var_1) || _func_011A(var_11.origin + (0, 0, 120), var_1)) {
          var_0 = scripts\engine\utility::array_add(var_0, var_11);
        }
      }
    }
  }

  return var_0;
}

_id_28D0() {
  wait 1.0;
  _id_28CD(level._id_A8E8);
  level._id_28C7 = 1;
}

_id_28CD(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_2952)) {
      var_2._id_2952 = _id_27D8(var_2.trigger);
    }
  }
}

_id_27A9(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_AE7C) {
    if(scripts\mp\utility\entity::_id_8A94(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_27A7(var_0, var_1, var_2) {
  var_3 = _id_27AA("attacker", var_0);

  foreach(var_5 in level.players) {
    if(!isai(var_5) && isDefined(var_5.team) && var_5.team == var_0) {
      if(var_5 _id_27AC() || distancesquared(var_1, var_5.origin) > _func_0219(var_2)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  return var_3;
}

_id_27A8(var_0, var_1, var_2) {
  var_3 = _id_27AA("defender", var_0);

  foreach(var_5 in level.players) {
    if(!isai(var_5) && isDefined(var_5.team) && var_5.team == var_0) {
      if(var_5 _id_27AD() || distancesquared(var_1, var_5.origin) <= _func_0219(var_2)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  return var_3;
}

_id_27AC() {
  if(isDefined(level._id_27AB)) {
    return self[[level._id_27AB]]();
  }

  return 0;
}

_id_27AD() {
  if(isDefined(level._id_27AE)) {
    return self[[level._id_27AE]]();
  }

  return 0;
}

_id_27B2(var_0) {
  self._id_C8C5 = var_0;
  self _meth_802B();
  _id_09F9::_id_2766();
}

_id_27AA(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_AE7C) {
    if(isDefined(var_4.team) && isalive(var_4) && scripts\mp\utility\entity::_id_8A94(var_4) && var_4.team == var_1 && isDefined(var_4._id_C8C5) && var_4._id_C8C5 == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_27AF() {
  var_0 = [[level._id_279E]](self.team);
  var_1 = [[level._id_279F]](self.team);
  var_2 = [[level._id_27A3]](self.team);
  var_3 = [[level._id_27A6]](self.team);
  var_4 = level._id_2884[self._id_B023];

  if(var_4 == "active") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level._id_2884[var_7._id_B023] == "stationary" && var_7 _id_271E()) {
          var_7._id_C8C5 = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        _id_27B2("attacker");
        return;
      }

      _id_27B2("defender");
      return;
    } else
      _id_27B2("attacker");
  } else if(var_4 == "stationary") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level._id_2884[var_10._id_B023] == "active" && var_10 _id_271D()) {
          var_10._id_C8C5 = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        _id_27B2("defender");
        return;
      }

      _id_27B2("attacker");
      return;
    } else
      _id_27B2("defender");
  }
}

_id_27A2() {
  level notify("bot_gametype_attacker_defender_ai_director_update");
  level endon("bot_gametype_attacker_defender_ai_director_update");
  level endon("game_ended");
  var_0 = ["allies", "axis"];
  var_1 = gettime() + 2000;

  for(;;) {
    if(gettime() > var_1) {
      var_1 = gettime() + 1000;

      foreach(var_3 in var_0) {
        var_4 = [[level._id_279E]](var_3);
        var_5 = [[level._id_279F]](var_3);
        var_6 = [[level._id_27A3]](var_3);
        var_7 = [[level._id_27A6]](var_3);

        if(var_4.size > var_6) {
          var_8 = [];
          var_9 = 0;

          foreach(var_11 in var_4) {
            if(isai(var_11) && var_11 _id_271E()) {
              if(level._id_2884[var_11._id_B023] == "stationary") {
                var_11 _id_27B2("defender");
                var_9 = 1;
                break;
              } else
                var_8 = scripts\engine\utility::array_add(var_8, var_11);
            }
          }

          if(!var_9 && var_8.size > 0) {
            scripts\engine\utility::random(var_8) _id_27B2("defender");
          }
        }

        if(var_5.size > var_7) {
          var_13 = [];
          var_14 = 0;

          foreach(var_16 in var_5) {
            if(isai(var_16) && var_16 _id_271D()) {
              if(level._id_2884[var_16._id_B023] == "active") {
                var_16 _id_27B2("attacker");
                var_14 = 1;
                break;
              } else
                var_13 = scripts\engine\utility::array_add(var_13, var_16);
            }
          }

          if(!var_14 && var_13.size > 0) {
            scripts\engine\utility::random(var_13) _id_27B2("attacker");
          }
        }
      }
    }

    wait 0.05;
  }
}

_id_271D() {
  if(isDefined(level._id_27A0)) {
    return self[[level._id_27A0]]();
  }

  return 1;
}

_id_271E() {
  if(isDefined(level._id_27A1)) {
    return self[[level._id_27A1]]();
  }

  return 1;
}

_id_2917(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_A8E8) {}

  if(!var_1) {
    _id_270F();
  }

  return !var_1;
}

_id_27D8(var_0) {
  var_1 = _func_00B6(var_0, 1);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!var_4 _meth_824A() && !scripts\engine\utility::_id_8942(var_4) && var_4.type != "Begin" && var_4.type != "End") {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_2714(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = 0;
    var_5._id_551A = [];
    var_5._id_110D0 = _id_2EDC(var_5);
    var_5._id_338B = _id_110D1(var_5, 0, 0);
    var_7 = [(0, 0, 0), (1, 1, 0), (1, -1, 0), (-1, 1, 0), (-1, -1, 0)];

    foreach(var_9 in var_7) {
      var_10 = _id_110D1(var_5, var_9[0], var_9[1]);
      var_1[var_3] = var_10.origin;
      var_11 = var_5._id_A8E1 + "_" + var_6;
      var_2[var_3] = var_11;
      var_5._id_551A[var_5._id_551A.size] = var_11;
      var_3++;
      var_6++;
    }
  }

  _id_270E(var_1, var_2, 1);
}

_id_2EDC(var_0) {
  var_1 = spawnStruct();
  var_1._id_9EA3 = (999999, 999999, 999999);
  var_1._id_9C2E = (-999999, -999999, -999999);

  foreach(var_3 in var_0._id_A578) {
    var_1._id_9EA3 = (min(var_3.origin[0], var_1._id_9EA3[0]), min(var_3.origin[1], var_1._id_9EA3[1]), min(var_3.origin[2], var_1._id_9EA3[2]));
    var_1._id_9C2E = (max(var_3.origin[0], var_1._id_9C2E[0]), max(var_3.origin[1], var_1._id_9C2E[1]), max(var_3.origin[2], var_1._id_9C2E[2]));
  }

  var_1._id_3385 = ((var_1._id_9EA3[0] + var_1._id_9C2E[0]) / 2, (var_1._id_9EA3[1] + var_1._id_9C2E[1]) / 2, (var_1._id_9EA3[2] + var_1._id_9C2E[2]) / 2);
  var_1._id_73B7 = (var_1._id_9C2E[0] - var_1._id_3385[0], var_1._id_9C2E[1] - var_1._id_3385[1], var_1._id_9C2E[2] - var_1._id_3385[2]);
  var_1._id_0359 = max(var_1._id_73B7[0], var_1._id_73B7[1]);
  return var_1;
}

_id_110D1(var_0, var_1, var_2) {
  var_3 = (var_0._id_110D0._id_3385[0] + var_1 * var_0._id_110D0._id_73B7[0], var_0._id_110D0._id_3385[1] + var_2 * var_0._id_110D0._id_73B7[1], 0);
  var_4 = undefined;
  var_5 = 9999999;

  foreach(var_7 in var_0._id_A578) {
    var_8 = distance2dsquared(var_7.origin, var_3);

    if(var_8 < var_5) {
      var_5 = var_8;
      var_4 = var_7;
    }
  }

  return var_4;
}

_id_A0F0() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = self.origin;

  if(!isDefined(var_0)) {
    var_0 = self._id_4140;
  }

  var_1 = _func_00F5(var_0);

  for(;;) {
    var_2 = "none";

    if(isDefined(self._id_60D8)) {
      var_2 = self._id_60D8 _id_07D6::_id_6C02();
    }

    if(var_2 == "neutral" || var_2 == "none") {
      _func_002C(var_1, "free");
    } else {
      _func_002C(var_1, var_2);
    }

    wait 1.0;
  }
}

_id_A0BF() {
  self notify("monitor_bombzone_control");
  self endon("monitor_bombzone_control");
  self endon("death");
  level endon("game_ended");
  var_0 = _func_00F5(self._id_4140);

  for(;;) {
    if(self._id_2663) {
      var_1 = scripts\engine\utility::_id_647F(self._id_ADAE);
    } else {
      var_1 = self._id_ADAE;
    }

    if(var_1 == "neutral" || var_1 == "any") {
      var_1 = "free";
    }

    _func_002C(var_0, var_1);
    wait 1.0;
  }
}

_id_5ABA(var_0) {
  var_1 = undefined;
  var_2 = 999999999;

  foreach(var_4 in level._id_A8E8) {
    var_5 = distancesquared(var_4._id_4140, var_0.origin);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

_id_656A(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_AE7C) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(var_4) && scripts\mp\utility\entity::_id_8A94(var_4) && var_4.team == var_0) {
      if(!isDefined(var_1) || var_1 && isai(var_4) && isDefined(var_4._id_C8C5)) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_639E(var_0, var_1) {
  if(var_0._id_2952.size >= 2) {
    if(var_1) {
      var_2 = self _meth_804B(var_0._id_2952, "node_exposed");
    } else {
      var_2 = self _meth_804B(var_0._id_2952, "node_hide_anywhere", "ignore_occupancy");
    }

    var_3 = self _meth_8030("strategyLevel") * 0.3;
    var_4 = (self _meth_8030("strategyLevel") + 1) * 0.15;
    var_5 = scripts\engine\utility::array_randomize(var_0._id_2952);

    foreach(var_7 in var_5) {
      if(!scripts\engine\utility::array_contains(var_2, var_7)) {
        var_2[var_2.size] = var_7;
      }
    }

    if(randomfloat(1.0) < var_3) {
      return var_2[0];
      return;
    }

    if(randomfloat(1.0) < var_4) {
      return var_2[1];
      return;
    }

    return scripts\engine\utility::random(var_2);
    return;
    return;
  } else
    return var_0._id_2952[0];
}

_id_639D(var_0) {
  var_1 = self _meth_804B(var_0._id_2952, "node_hide_anywhere", "ignore_occupancy");
  var_2 = self _meth_8030("strategyLevel") * 0.3;
  var_3 = (self _meth_8030("strategyLevel") + 1) * 0.15;
  var_4 = scripts\engine\utility::array_randomize(var_0._id_2952);

  foreach(var_6 in var_4) {
    if(!scripts\engine\utility::array_contains(var_1, var_6)) {
      var_1[var_1.size] = var_6;
    }
  }

  if(randomfloat(1.0) < var_2) {
    return var_1[0];
  } else if(randomfloat(1.0) < var_3) {
    return var_1[1];
  } else {
    return scripts\engine\utility::random(var_1);
  }
}

_id_2693(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self _meth_8030("strategyLevel") == 1) {
    var_4 = 40;
  } else if(self _meth_8030("strategyLevel") >= 2) {
    var_4 = 80;
  }

  if(randomint(100) < var_4 && !(isDefined(var_3) && var_3)) {
    self _meth_805B("prone");
    wait 0.2;
  }

  if(self _meth_8030("strategyLevel") > 0 && !var_2) {
    childthread _id_A67F();
    childthread _id_A67E();
  }

  self _meth_804E("use", var_0);
  var_5 = scripts\mp\bots\bots_util::_id_290E(var_0, var_1, "use_interrupted");
  self _meth_805B("none");
  self _meth_8029("use");
  var_6 = var_5 == var_1;
  return var_6;
}

_id_A67F() {
  self endon("stop_usebutton_watcher");
  var_0 = _id_5ABA(self);
  self waittill("bulletwhizby", var_1);

  if(!isDefined(var_1.team) || var_1.team != self.team) {
    var_2 = var_0._id_FEE7 - var_0._id_4143;

    if(var_2 > 1000) {
      self notify("use_interrupted");
    }
  }
}

_id_A67E() {
  self endon("stop_usebutton_watcher");
  self waittill("damage", var_0, var_1);

  if(!isDefined(var_1.team) || var_1.team != self.team) {
    self notify("use_interrupted");
  }
}

_id_6310(var_0) {
  var_1 = [];

  if(!istrue(level._id_DD44)) {
    var_2 = _id_656A(scripts\engine\utility::_id_647F(self.team));

    foreach(var_4 in var_2) {
      if(!isai(var_4)) {
        continue;
      }
      var_5 = 0;

      if(var_0 == "plant") {
        var_5 = 300 + var_4 _meth_8030("strategyLevel") * 100;
      } else if(var_0 == "defuse") {
        var_5 = 500 + var_4 _meth_8030("strategyLevel") * 500;
      }

      if(distancesquared(var_4.origin, self.origin) < _func_0219(var_5)) {
        var_1[var_1.size] = var_4;
      }
    }
  }

  return var_1;
}