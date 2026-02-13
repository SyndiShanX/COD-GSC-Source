/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_ball.gsc
**************************************************/

main() {
  _id_D795();
  _id_D765();
  thread _id_A0BE();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_2707;
}

_id_D765() {
  scripts\mp\bots\bots_util::_id_291B(1);
  level._id_BDBF = 600;
  level._id_25DE = 400;
  thread _id_2706();
  level._id_27B0 = 1;
}

_id_27B8() {
  foreach(var_1 in level._id_21B2) {
    if(isDefined(var_1._id_32D5)) {
      continue;
    }
    if(istrue(var_1._id_7D6B)) {
      continue;
    }
    if(istrue(var_1._id_89FF)) {
      continue;
    }
    return var_1;
  }

  return undefined;
}

_id_27B9() {
  foreach(var_1 in level._id_21B2) {
    if(isDefined(var_1._id_32D5)) {
      return var_1._id_32D5;
    }
  }

  return undefined;
}

_id_2777() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self _meth_805B("stand");

  for(var_0 = 0; var_0 < 5; var_0++) {
    self _meth_804E("jump");
    waitframe();
  }

  waitframe();
  waitframe();

  for(var_0 = 0; var_0 < 60; var_0++) {
    self _meth_804E("jump");
    waitframe();

    if(!isDefined(self._id_32EC)) {
      break;
    }
  }
}

_id_2905() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(var_0 = 0; var_0 < 5; var_0++) {
    self _meth_804E("attack");
    waitframe();
  }
}

_id_27BC() {
  if(self.team == "allies") {
    return "axis";
  }

  return "allies";
}

_id_2707() {
  self notify("bot_ball_think");
  self endon("bot_ball_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    if(!isDefined(self._id_C8C5)) {
      _id_81C9();
      var_0 = undefined;
    }

    if(_id_09F9::_id_27ED()) {
      var_0 = undefined;
      continue;
    }

    if(self._id_C8C5 != "carrier" && isDefined(self._id_32EC)) {
      var_0 = undefined;
      _id_2153("carrier");
    }

    if(self._id_C8C5 == "carrier") {
      if(isDefined(self._id_32EC)) {
        self _meth_8054("disable_attack", 1);
        var_2 = 0;

        if(isDefined(self._id_0192)) {
          var_2 = distancesquared(self._id_0192.origin, self.origin);
        }

        if(isDefined(self._id_0192) && var_2 < 9216) {
          self _meth_8054("disable_attack", 0);
          self _meth_8054("prefer_melee", 1);
        } else {
          self _meth_8054("prefer_melee", 0);
          self _meth_8054("disable_attack", 1);
        }

        if(isDefined(level._id_212E)) {
          var_3 = level._id_212E[_id_27BC()].origin;

          if(!isDefined(var_0)) {
            var_0 = _func_02AB(var_3, self);

            if(distance2dsquared(var_0, var_3) > 256) {
              var_4 = (var_3[0], var_3[1], var_3[2] - 90);
              var_0 = _func_02AB(var_4, self);
            }
          }

          self _meth_8058(var_0, 16, "critical");
          var_5 = distance2dsquared(self.origin, var_3);

          if(var_5 < 30625) {
            var_6 = self getEye();
            var_7 = var_3;

            if(scripts\engine\trace::ray_trace_passed(var_6, var_7, self)) {
              if(var_5 < 256) {
                self _meth_8058(self.origin, 16, "critical");
                wait 0.25;
              }

              _id_2777();
              wait 0.2;

              if(!isDefined(self._id_32EC)) {
                self _meth_802B();
              }
            }
          }
        } else {
          self _meth_802B();

          if(!isDefined(var_1)) {
            var_1 = gettime() + randomintrange(500, 1000);
          }

          if(gettime() > var_1) {
            var_1 = gettime() + randomintrange(500, 1000);

            if(isDefined(self._id_0192)) {
              if(self _meth_8028(self._id_0192)) {
                var_8 = anglesToForward(self.angles);
                var_9 = self._id_0192.origin - self.origin;
                var_10 = vectornormalize((var_9[0], var_9[1], 0));
                var_11 = vectordot(var_8, var_10);

                if(var_11 > 0.707) {
                  if(var_2 < 57600 && var_2 > 9216) {
                    _id_2905();
                  }
                }
              }
            }
          }
        }
      } else {
        self _meth_8054("disable_attack", 0);
        self _meth_8054("prefer_melee", 0);
        var_12 = _id_27B8();

        if(!isDefined(var_12)) {
          var_13 = _id_27B9();

          if(isDefined(var_13) && var_13 != self) {
            _id_81C9();
          }
        } else {
          self _meth_8058(var_12._id_4140, 16, "objective");
          continue;
        }
      }
    } else
      var_0 = undefined;

    if(self._id_C8C5 == "attacker") {
      self _meth_8054("disable_attack", 0);
      self _meth_8054("prefer_melee", 0);
      var_12 = _id_27B8();

      if(!isDefined(var_12)) {
        var_13 = _id_27B9();

        if(isDefined(var_13)) {
          if(!scripts\mp\bots\bots_util::_id_2807(var_13)) {
            _id_09F9::_id_27E3(var_13, level._id_25DE);
          }
        }
      } else if(!istrue(var_12._id_89FF) && !istrue(var_12._id_7D6B)) {
        var_14 = _func_02AB(var_12._id_4140);

        if(!scripts\mp\bots\bots_util::_id_2806(var_14)) {
          _id_09F9::_id_2899(var_14, level._id_BDBF);
        }
      }

      continue;
    }

    if(self._id_C8C5 == "defender") {
      self _meth_8054("disable_attack", 0);
      self _meth_8054("prefer_melee", 0);
      var_15 = level._id_212E[self.team];
      var_3 = var_15.origin;

      if(!scripts\mp\bots\bots_util::_id_2806(var_3)) {
        _id_09F9::_id_2899(var_3, level._id_BDBF);
      }
    }
  }
}

_id_81C9() {
  var_0 = _id_633E(self.team);
  var_1 = _id_633F(self.team);
  var_2 = _id_210D(self.team);
  var_3 = _id_210E(self.team);
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
        _id_2153("attacker");
        return;
      }

      _id_2153("defender");
      return;
    } else
      _id_2153("attacker");
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
        _id_2153("defender");
        return;
      }

      _id_2153("attacker");
      return;
    } else
      _id_2153("defender");
  }
}

_id_2706() {
  level notify("bot_ball_ai_director_update");
  level endon("bot_ball_ai_director_update");
  level endon("game_ended");
  var_0[0] = "allies";
  var_0[1] = "axis";
  var_1 = [];

  for(;;) {
    foreach(var_3 in var_0) {
      var_4 = _id_210D(var_3);
      var_5 = _id_210E(var_3);
      var_6 = _id_633E(var_3);
      var_7 = _id_633F(var_3);

      if(var_6.size > var_4) {
        var_8 = [];
        var_9 = 0;

        foreach(var_11 in var_6) {
          if(isai(var_11)) {
            if(level._id_2884[var_11._id_B023] == "stationary") {
              var_11 _id_2153("defender");
              var_9 = 1;
              break;
            } else
              var_8 = scripts\engine\utility::array_add(var_8, var_11);
          }
        }

        if(!var_9 && var_8.size > 0) {
          scripts\engine\utility::random(var_8) _id_2153("defender");
        }
      }

      if(var_7.size > var_5) {
        var_13 = [];
        var_14 = 0;

        foreach(var_16 in var_7) {
          if(isai(var_16)) {
            if(level._id_2884[var_16._id_B023] == "active") {
              var_16 _id_2153("attacker");
              var_14 = 1;
              break;
            } else
              var_13 = scripts\engine\utility::array_add(var_13, var_16);
          }
        }

        if(!var_14 && var_13.size > 0) {
          scripts\engine\utility::random(var_13) _id_2153("attacker");
        }
      }

      var_18 = _id_27B8();

      if(isDefined(var_18)) {
        var_19 = _id_B05C(var_3, var_18);

        if(isDefined(var_19) && isDefined(var_19._id_C8C5) && var_19._id_C8C5 != "carrier") {
          if(!isDefined(var_19._id_32EC)) {
            var_20 = var_1[var_3];

            if(isDefined(var_20)) {
              var_20 _id_2153(undefined);
            }

            var_19 _id_2153("carrier");
            var_1[var_19.team] = var_19;
          }
        }
      }
    }

    wait 1.0;
  }
}

_id_210D(var_0) {
  var_1 = _id_2124(var_0);

  if(!isDefined(level._id_212E)) {
    return var_1;
  }

  return int(int(var_1) / 2) + 1 + int(var_1) % 2;
}

_id_210E(var_0) {
  if(!isDefined(level._id_212E)) {
    return 0;
  }

  var_1 = _id_2124(var_0);
  return max(int(int(var_1) / 2) - 1, 0);
}

_id_2124(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_AE7C) {
    if(scripts\mp\utility\entity::_id_8A94(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_B05C(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_AE7C) {
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
    if(isDefined(var_5._id_C8C5) && var_5._id_C8C5 == "defender") {
      continue;
    }
    var_6 = distancesquared(var_5.origin, var_1._id_4140);

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

_id_633E(var_0) {
  var_1 = _id_66A0("attacker", var_0);

  if(isDefined(level._id_212E)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(distancesquared(level._id_212E[var_0].origin, var_3.origin) > level._id_BDBF * level._id_BDBF) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

_id_633F(var_0) {
  var_1 = _id_66A0("defender", var_0);

  if(isDefined(level._id_212E)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
        if(distancesquared(level._id_212E[var_0].origin, var_3.origin) <= level._id_BDBF * level._id_BDBF) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        }
      }
    }
  }

  return var_1;
}

_id_2153(var_0) {
  self._id_C8C5 = var_0;
  self _meth_802B();
  _id_09F9::_id_2766();
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

_id_A0BE() {
  level endon("game_ended");
  var_0 = undefined;

  for(;;) {
    var_1 = _id_27B9();

    if(!isDefined(var_0) || !isDefined(var_1) || var_1 != var_0) {
      if(isDefined(var_0) && var_0._id_048A == 505) {
        var_0._id_048A = 0;
      }

      var_0 = var_1;
    }

    if(isDefined(var_1) && var_1._id_048A == 0) {
      var_1._id_048A = 505;
    }

    wait 0.05;
  }
}