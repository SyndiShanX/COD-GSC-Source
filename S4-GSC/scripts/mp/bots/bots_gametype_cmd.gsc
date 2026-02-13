/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cmd.gsc
*************************************************/

main() {
  _id_D795();
  _id_D7C3();
}

_id_D7C3() {
  scripts\mp\bots\bots_util::_id_291B(1);
  thread _id_27E9();
  level._id_BDBF = 128;
  level._id_AF2D = 800;
  level._id_27B0 = 1;
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_27EA;
}

_id_81D6() {
  var_0 = _id_633E(self.team);
  var_1 = _id_633F(self.team);
  var_2 = _id_2704(self.team);
  var_3 = _id_2768(self.team);
  var_4 = level._id_2884[self._id_B023];

  if(var_4 == "active") {
    if(var_0.size >= var_2) {
      var_5 = 0;

      foreach(var_7 in var_0) {
        if(isai(var_7) && level._id_2884[var_7._id_B023] == "stationary") {
          var_7._id_C8C5 = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        _id_28C9("attacker");
        return;
      }

      _id_28C9("defender");
      return;
    } else
      _id_28C9("attacker");
  } else if(var_4 == "stationary") {
    if(var_1.size >= var_3) {
      var_5 = 0;

      foreach(var_10 in var_1) {
        if(isai(var_10) && level._id_2884[var_10._id_B023] == "active") {
          var_10._id_C8C5 = undefined;
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        _id_28C9("defender");
        return;
      }

      _id_28C9("attacker");
      return;
    } else
      _id_28C9("defender");
  }
}

_id_27EA() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self _meth_802B();

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(level._id_41DC)) {
      continue;
    }
    if(_id_09F9::_id_27ED()) {
      continue;
    }
    if(!isDefined(self._id_C8C5)) {
      _id_81D6();
    }

    if(!istrue(self._id_2769)) {
      var_0 = undefined;
      var_1 = undefined;
    }

    if(self._id_C8C5 == "attacker") {
      var_2 = 0;
      var_1 = undefined;

      if(!isDefined(var_0)) {
        var_2 = 1;
      } else if(isDefined(level._id_41DC.trigger)) {
        if(var_0 != level._id_41DC.trigger) {
          var_2 = 1;
        }
      }

      if(var_2) {
        var_3 = _func_02AB(level._id_41DC.trigger.origin, self);
        var_4["min_goal_time"] = 1;
        var_4["max_goal_time"] = 4;
        _id_09F9::_id_287A(var_3, level._id_AF2D, var_4);
        var_0 = level._id_41DC.trigger;
      }

      continue;
    }

    if(self._id_C8C5 == "defender") {
      var_0 = undefined;
      var_5 = 0;

      if(!isDefined(var_1)) {
        var_5 = 1;
      } else if(isDefined(level._id_41DC.trigger)) {
        if(var_1 != level._id_41DC.trigger) {
          var_5 = 1;
        }
      }

      if(var_5) {
        var_6 = _func_00B6(level._id_41DC.trigger);

        if(var_6.size > 0) {
          var_4["min_goal_time"] = 3;
          var_4["max_goal_time"] = 6;
          _id_09F9::_id_272A(level._id_41DC.trigger.origin, var_6, level._id_41DC.trigger, var_4);
          var_1 = level._id_41DC.trigger;
        }
      }
    }
  }
}

_id_2704(var_0) {
  var_1 = _id_6601(var_0);
  return int(int(var_1) / 2) + 1 + int(var_1) % 2;
}

_id_2768(var_0) {
  var_1 = _id_6601(var_0);
  return max(int(int(var_1) / 2) - 1, 0);
}

_id_6601(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_AE7C) {
    if(scripts\mp\utility\entity::_id_8A94(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_633E(var_0) {
  var_1 = _id_66A0("attacker", var_0);

  if(isDefined(level._id_41DC.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(!var_3 istouching(level._id_41DC.trigger)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

_id_633F(var_0) {
  var_1 = _id_66A0("defender", var_0);

  if(isDefined(level._id_41DC.trigger)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(var_3 istouching(level._id_41DC.trigger)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

_id_66A0(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_AE7C) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(isalive(var_4) && scripts\mp\utility\entity::_id_8A94(var_4) && var_4.team == var_1 && isDefined(var_4._id_C8C5) && var_4._id_C8C5 == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_28C9(var_0) {
  self._id_C8C5 = var_0;
  self _meth_802B();
  _id_09F9::_id_2766();
}

_id_8563(var_0, var_1) {
  var_2 = var_0 istouching(level._id_41DC.trigger);
  var_3 = var_1 istouching(level._id_41DC.trigger);

  if(var_2 != var_3) {
    if(var_2) {
      return 0;
    }

    return 1;
  }

  if(var_2) {
    if(var_0._id_C8C5 != var_1._id_C8C5) {
      if(var_1._id_C8C5 == "defender") {
        return 1;
      }

      return 0;
    }
  }

  var_4 = distance2dsquared(var_0.origin, level._id_41DC.trigger.origin);
  var_5 = distance2dsquared(var_1.origin, level._id_41DC.trigger.origin);

  if(var_4 < var_5) {
    return 1;
  }

  return 0;
}

_id_27E9() {
  level notify("bot_hardpoint_ai_director_update");
  level endon("bot_hardpoint_ai_director_update");
  level endon("game_ended");
  var_0[0] = "allies";
  var_0[1] = "axis";
  var_1["allies"] = 0;
  var_1["axis"] = 0;

  for(;;) {
    var_2 = "neutral";

    if(!isDefined(level._id_41DC)) {
      wait 1.0;
      continue;
    }

    if(isDefined(level._id_41DC.trigger)) {
      var_2 = level._id_41DC _id_07D6::_id_6C02();
    }

    foreach(var_4 in var_0) {
      var_5 = [];
      var_6 = [];

      if(var_4 != var_2) {
        var_1[var_4] = 0;

        foreach(var_8 in level._id_AE7C) {
          if(scripts\mp\utility\entity::_id_8A94(var_8) && isDefined(var_8.team) && var_8.team == var_4) {
            if(isbot(var_8) && (!isDefined(var_8._id_C8C5) || var_8._id_C8C5 != "defender")) {
              var_8 _id_28C9("defender");
            }
          }
        }

        continue;
      }

      var_10 = _id_2704(var_4);
      var_11 = _id_2768(var_4);

      if(!var_1[var_4]) {
        var_1[var_4] = 1;
        var_12 = [];

        foreach(var_8 in level._id_AE7C) {
          if(scripts\mp\utility\entity::_id_8A94(var_8) && isDefined(var_8.team) && var_8.team == var_4) {
            if(isbot(var_8)) {
              var_12[var_12.size] = var_8;
            }
          }
        }

        var_15 = scripts\engine\utility::_id_1BD6(var_12, ::_id_8563);

        if(var_12.size < var_11) {
          var_11 = var_12.size;
        }

        var_11 = int(var_11);

        for(var_16 = 0; var_16 < var_11; var_16++) {
          var_12[var_16] _id_28C9("defender");
        }

        for(var_16 = var_11; var_16 < var_12.size; var_16++) {
          var_12[var_16] _id_28C9("attacker");
        }

        wait 1;
        continue;
      }

      var_17 = _id_633E(var_4);
      var_18 = _id_633F(var_4);

      if(var_17.size > var_10) {
        var_19 = 0;

        foreach(var_21 in var_17) {
          if(isai(var_21)) {
            if(level._id_2884[var_21._id_B023] == "stationary") {
              var_21 _id_28C9("defender");
              var_19 = 1;
              break;
            } else
              var_5 = scripts\engine\utility::array_add(var_5, var_21);
          }
        }

        if(!var_19 && var_5.size > 0) {
          scripts\engine\utility::random(var_5) _id_28C9("defender");
        }
      }

      if(var_18.size > var_11) {
        var_23 = 0;

        foreach(var_25 in var_18) {
          if(isai(var_25)) {
            if(level._id_2884[var_25._id_B023] == "active") {
              var_25 _id_28C9("attacker");
              var_23 = 1;
              break;
            } else
              var_6 = scripts\engine\utility::array_add(var_6, var_25);
          }
        }

        if(!var_23 && var_6.size > 0) {
          scripts\engine\utility::random(var_6) _id_28C9("attacker");
        }
      }

      if(var_18.size == 0) {
        var_27 = _id_66A0("attacker", var_4);

        if(var_27.size > 0) {
          scripts\engine\utility::random(var_27) _id_28C9("defender");
        }
      }
    }

    wait 1.0;
  }
}

_id_3E6F(var_0) {
  if(isagent(self) && !isDefined(var_0._id_2991)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !_id_09F4::_id_2809(var_0.cratetype)) {
    return 0;
  }

  return !scripts\mp\bots\bots_util::_id_2805() || scripts\mp\bots\bots_util::_id_280B();
}

_id_D777() {
  scripts\mp\bots\bots_util::_id_291B();

  while(!isDefined(level._id_A8E8)) {
    wait 0.05;
  }

  scripts\mp\bots\bots_gametype_common::_id_28D0();

  foreach(var_1 in level._id_A8E8) {
    var_1 thread scripts\mp\bots\bots_gametype_common::_id_A0F0();
  }

  scripts\mp\bots\bots_gametype_common::_id_2711(level._id_A8E8, "radio", level._id_27F6);
  level._id_27B0 = 1;
}

_id_27EE() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("grenade_objectives", 1);
  _id_7F0A();

  for(;;) {
    var_0 = randomintrange(1, 11) * 0.05;
    wait(var_0);

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_BF37)) {
      if(scripts\mp\bots\bots_util::_id_2805()) {
        _id_09F9::_id_2766();
      }

      var_1 = 1;

      if(self _meth_803E() != "none") {
        var_2 = distancesquared(self _meth_803B(), self.origin);
        var_3 = self _meth_803D();

        if(var_2 > var_3 * var_3) {
          var_1 = 0;
        }
      }

      if(var_1) {
        var_4 = self _meth_802C();

        if(isDefined(var_4)) {
          self _meth_8058(var_4, 128, "hunt");
        }
      }

      continue;
    }

    var_5 = level._id_BF37 _id_07D6::_id_6C02();

    if(self.team != var_5) {
      if(!_id_856A()) {
        var_6 = _id_65F4();
        var_7 = _id_5ABF()._id_2864.size;

        if(var_6 < var_7) {
          _id_3220();
        } else if(!_id_868C()) {
          _id_BDBE();
        }
      }
    } else if(!_id_868C()) {
      wait(randomfloat(2));

      if(isDefined(level._id_BF37)) {
        _id_BDBE();
      }
    }
  }
}

_id_5ABF() {
  foreach(var_1 in level._id_BF38) {
    if(var_1._id_F587 == level._id_BF37.trigger) {
      return var_1;
    }
  }
}

_id_856A() {
  return scripts\mp\bots\bots_util::_id_2801();
}

_id_65F4() {
  var_0 = 0;

  foreach(var_2 in level._id_AE7C) {
    if(isai(var_2) && var_2.health > 0 && var_2.team == self.team && var_2 _id_856A()) {
      var_0++;
    }
  }

  return var_0;
}

_id_3220() {
  var_0 = _id_5ABF();
  var_1["entrance_points_index"] = "radio" + var_0._id_A8E1;
  _id_09F9::_id_272A(var_0.origin, var_0._id_2864, undefined, var_1);
}

_id_868C() {
  return scripts\mp\bots\bots_util::_id_280B();
}

_id_BDBE() {
  var_0 = self _meth_8041();
  var_1 = (var_0[0] + var_0[1]) / 2;
  var_2 = min(1000, var_1 / 4);
  _id_09F9::_id_2899(_id_5ABF().origin, var_2);
}

_id_7F0A() {
  if(isDefined(level._id_2945) && level._id_2945) {
    return;
  }
  level._id_2945 = 1;

  foreach(var_1 in level._id_BF38) {
    var_1._id_2864 = _func_00B6(var_1._id_F587);
  }
}