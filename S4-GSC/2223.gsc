/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2223.gsc
*************************************************/

_id_81A6(var_0) {
  if(!isDefined(level._id_0408._id_7225)) {
    level._id_0408._id_7225 = spawnStruct();
  }

  var_1 = level._id_0408._id_7225;

  if(!isDefined(var_1._id_722F)) {
    var_1._id_722F = [];
  }

  var_2 = var_1._id_722F[var_0];

  if(!isDefined(var_2)) {
    var_2 = spawnStruct();
    var_1._id_722F[var_0] = var_2;
    var_2.name = var_0;
    var_2._id_9DB5 = [];
    var_2._id_B992 = [];
  }

  level._id_0408._id_7225 notify(var_0);
}

_id_115D(var_0, var_1) {
  if(!isDefined(level._id_0408._id_7225) || !isDefined(level._id_0408._id_7225._id_722F) || !isDefined(level._id_0408._id_7225._id_722F[var_0])) {
    _id_81A6(var_0);
  }

  var_2 = level._id_0408._id_7225._id_722F[var_0];
  var_2._id_9DB5[var_2._id_9DB5.size] = var_1;
  var_2 thread _id_7224(var_1);
}

_id_7224(var_0) {
  var_0 waittill("death");
  var_0 thread _id_08AC::_id_43AF();
  _id_7219(self, var_0);
  var_1 = self._id_9DB5.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(self._id_9DB5[var_2] == var_0) {
      var_3 = self._id_9DB5.size - 1;
      self._id_9DB5[var_2] = self._id_9DB5[var_3];
      self._id_9DB5[var_3] = undefined;
      break;
    }
  }

  if(isDefined(var_0._id_0408) && isDefined(var_0._id_0408._id_3936)) {
    var_4 = var_0._id_0408._id_3936._id_414A;
    var_0 _id_08A9::_id_7BE1(var_4);
  }
}

_id_391E() {
  if(!isDefined(level._id_0408._id_7225)) {
    return;
  }
  if(!isDefined(level._id_0408._id_7225._id_722F)) {
    return;
  }
  level._id_0408._id_7225._id_722F = undefined;
}

_id_6A80(var_0) {
  return level._id_0408._id_7225._id_722F[var_0];
}

_id_99FB(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_E747 = var_1;
  var_3.origin = var_2;
  var_3._id_9DB5 = [];
  var_3._id_AE5B = var_0;
  var_0._id_B992[var_0._id_B992.size] = var_3;
  return var_3;
}

_id_116D(var_0, var_1) {
  var_0._id_9DB5[var_0._id_9DB5.size] = var_1;
}

_id_721D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 65536;

  foreach(var_7 in var_0._id_B992) {
    if(isDefined(var_1) && var_1 == var_7) {
      continue;
    }
    if(var_7._id_E747 == var_2) {
      if(distancesquared(var_4, var_7.origin) < var_5) {
        _id_7219(var_0, var_3);
        _id_116D(var_7, var_3);
        return var_7;
      }
    }
  }
}

_id_71FB(var_0, var_1, var_2) {
  var_3 = 65536;
  var_4 = _id_721D(var_0, undefined, 1, var_1, var_2);

  if(isDefined(var_4)) {
    if(!isDefined(var_4._id_8526)) {
      var_4 _id_B990(var_1, var_2);
    }

    return 0;
  }

  _id_7219(var_0, var_1);
  var_5 = _id_99FB(var_0, 1, var_2);
  _id_116D(var_5, var_1);
  var_5._id_8526 = var_1;
  _id_7212(var_5, var_1._id_CE6E, var_2);
  var_6 = level._id_0408._id_851E[self._id_CE6E];

  if(isDefined(var_6)) {
    var_5._id_106A1 = var_6;
    var_5._id_26C5 = _func_011A(var_2, var_6);
  }

  return 1;
}

_id_71FA(var_0, var_1, var_2, var_3) {
  _id_7219(var_0, var_1);

  foreach(var_5 in var_0._id_B992) {
    if(var_5._id_E747 == 2) {
      if(!isDefined(var_1._id_0192) || !isDefined(var_5.target) || var_5.target == var_1._id_0192) {
        _id_116D(var_5, var_1);

        if(!isDefined(var_5.target)) {
          var_5.target = var_1._id_0192;

          if(isDefined(var_2)) {
            var_5.origin = var_2;
          }
        }

        return;
      }
    }
  }

  if(!isDefined(var_2)) {
    var_2 = var_1.origin;
  }

  var_7 = _id_99FB(var_0, 2, var_2);
  _id_116D(var_7, var_1);
  var_7.target = var_1._id_0192;
  _id_7212(var_7, var_1._id_CE6E, var_2);
  var_8 = level._id_0408._id_7BCA[self._id_CE6E];

  if(isDefined(var_8)) {
    var_7._id_106A1 = var_8;
    var_7._id_26C5 = _func_011A(var_2, var_8);
  }

  var_7._id_8F8B = gettime();
  level thread _id_B98A();
  var_7 thread _id_B989();
  var_7 thread _id_B987();
}

_id_7219(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = _id_6A80(var_1._id_CE6E);
  }

  var_2 = _id_7208(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_2._id_9DB5.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_2._id_9DB5[var_4] == var_1) {
      var_5 = var_2._id_9DB5.size - 1;
      var_2._id_9DB5[var_4] = var_2._id_9DB5[var_5];
      var_2._id_9DB5[var_5] = undefined;
      break;
    }
  }

  if(var_2._id_9DB5.size == 0) {
    var_2 _id_B984();
  }
}

_id_7209(var_0, var_1) {
  var_2 = 2304;
  var_3 = undefined;
  var_4 = 2359296;
  var_5 = [];

  foreach(var_7 in level._id_0408._id_7225._id_722F) {
    if(var_7.name == var_1) {
      continue;
    }
    var_8 = level._id_0408._id_851E[var_7.name];

    if(isDefined(var_8) && !_func_011A(var_0, var_8)) {
      continue;
    }
    foreach(var_10 in var_7._id_B992) {
      if(var_10._id_E747 == 1 && distance2dsquared(var_10.origin, var_0) < var_2) {
        return undefined;
      }
    }

    foreach(var_13 in var_7._id_9DB5) {
      if([[self._id_5D9A]]()) {
        var_14 = distancesquared(var_13.origin, var_0);

        if(var_14 < var_4) {
          var_5[var_5.size] = var_13;

          if(var_5.size > 8) {
            break;
          }
        }
      }
    }
  }

  if(var_5.size > 0) {
    var_3 = _func_034C(var_5, var_0);
  }

  return var_3;
}

_id_71FD(var_0) {
  var_1 = level._id_0408._id_851E[self._id_CE6E];

  if(isDefined(var_1)) {
    if(!_func_011A(var_0._id_8512, var_1)) {
      var_2 = _id_7209(var_0._id_8512, self._id_CE6E);

      if(isDefined(var_2)) {
        var_2 _meth_8523("seek_backup", self, var_0._id_8512);
        return 1;
      }
    }
  }

  return 0;
}

_id_7206(var_0, var_1, var_2) {
  var_3 = _id_6A80(var_0);
  var_4 = _id_71FB(var_3, var_1, var_2._id_8512);

  if(var_4) {
    var_1 thread _id_7215(var_2);
  }
}

_id_7215(var_0) {
  self endon("death");
  self endon("start_context_melee");
  waitframe();
  _id_71FD(var_0);
  waitframe();
  var_1 = _id_6A80(self._id_CE6E);
  var_2 = _id_7208(var_1, self);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2._id_9DB5.size == 1) {
    var_3 = var_1._id_9DB5.size;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_1._id_9DB5[var_4];

      if(var_5._id_0408._id_2C56 == 0 && distancesquared(var_5.origin, self.origin) < 10000) {
        var_5 _meth_819E(self);
      }
    }
  }
}

_id_7212(var_0, var_1, var_2) {
  var_3 = _id_6A80(var_1);
  var_4 = 1000000;
  var_5 = [];
  var_6 = _func_00B3("seek_patrol", "targetname");
  var_7 = scripts\engine\utility::getstructarray("seek_patrol", "targetname");
  var_6 = scripts\engine\utility::array_combine(var_6, var_7);
  var_8 = 0;

  while(var_8 < var_6.size) {
    var_9 = 0;
    var_10 = var_6[var_8];

    if(distancesquared(var_10.origin, var_2) > var_4) {
      var_9 = 1;
    } else if(isDefined(var_10._id_CE6E)) {
      if(var_10._id_CE6E == var_1) {
        var_5[var_5.size] = var_10;
      }

      var_9 = 1;
    }

    if(var_9) {
      var_11 = var_6.size - 1;
      var_6[var_8] = var_6[var_11];
      var_6[var_11] = undefined;
      continue;
    }

    var_8++;
  }

  var_5 = _func_0204(var_5, var_2);
  var_6 = _func_0204(var_6, var_2);
  var_0._id_8527 = scripts\engine\utility::array_combine(var_5, var_6);
}

_id_7208(var_0, var_1) {
  if(isDefined(var_0._id_B992)) {
    var_2 = var_0._id_B992.size;

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = var_0._id_B992[var_3];
      var_5 = var_4._id_9DB5.size;

      for(var_6 = 0; var_6 < var_5; var_6++) {
        if(var_4._id_9DB5[var_6] == var_1) {
          return var_4;
        }
      }
    }
  }
}

_id_B980(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0._id_FE54[var_0._id_FE54.size] = var_1;
    var_0._id_FE55[var_0._id_FE55.size] = gettime() + 5000;
  }
}

_id_B981(var_0) {
  if(isDefined(var_0)) {
    var_1 = gettime();
    var_2 = 0;

    while(var_2 < var_0._id_FE55.size) {
      if(var_1 >= var_0._id_FE55[var_2]) {
        var_3 = var_0._id_FE55.size - 1;
        var_0._id_FE55[var_2] = var_0._id_FE55[var_3];
        var_0._id_FE55[var_3] = undefined;
        var_0._id_FE54[var_2] = var_0._id_FE54[var_3];
        var_0._id_FE54[var_3] = undefined;
        continue;
      }

      var_2++;
    }
  }
}

_id_7213(var_0, var_1) {
  var_2 = _id_6A80(var_0._id_CE6E);
  var_3 = _id_7208(var_2, var_0);

  if(!isDefined(var_3._id_FE54)) {
    var_3._id_FE54 = [];
    var_3._id_FE55 = [];
  }

  _id_B981(var_3);
  var_4 = undefined;
  var_5 = [];

  foreach(var_7 in var_3._id_9DB5) {
    var_8 = spawnStruct();
    var_8._id_7321 = var_7;
    var_9 = var_7.origin - var_3.origin;
    var_8._id_1784 = _func_0261(var_9);
    var_5[var_5.size] = var_8;

    if(var_7 == var_0) {
      var_4 = var_8._id_1784;
    }
  }

  var_11 = 0;

  foreach(var_13 in var_5) {
    if(var_13._id_1784 < var_4) {
      var_11++;
    }
  }

  var_9 = var_0.origin - var_3.origin;
  var_15 = length(var_9);
  var_16 = 768;
  var_17 = 512;
  var_18 = 256;
  var_19 = -128;
  var_20 = 64;
  var_21 = 360 / var_5.size;
  var_22 = var_11 * var_21;

  foreach(var_24 in var_3._id_8527) {
    if(isDefined(var_24._id_8FF8)) {
      continue;
    }
    if(_id_89B6(var_24, var_3, var_22, var_21, var_15, var_18)) {
      var_24._id_8FF8 = gettime();
      return var_24.origin;
    }
  }

  var_26 = var_15;

  if(var_15 > var_16) {
    var_26 = max(60, randomfloatrange(var_15 - var_18 * 2, var_15 - var_18));
  } else if(var_15 > var_17) {
    var_26 = randomfloatrange(var_15 + var_19, var_15 + var_18);
  } else {
    var_26 = randomfloatrange(var_15, var_15 + var_18);
  }

  var_27 = (0.5 + var_11 + randomfloatrange(-0.5, 0.5)) * var_21;
  var_28 = (cos(var_27), sin(var_27), 0);
  var_29 = var_3.origin + var_26 * var_28;
  var_30 = _id_0843::_id_6916(var_29, var_3._id_106A1, 256);

  if(isDefined(var_30)) {
    self._id_1C30._id_426A._id_1C02 = var_30.angles;
    _id_0843::_id_D6CD(var_30);
    _id_B980(var_3, var_30.origin);
    return var_30.origin;
  }

  var_31 = var_3._id_FE54;
  var_31[var_31.size] = self.origin;
  var_32 = 96;

  if(var_31.size > var_32) {
    var_33 = var_31.size;

    for(var_34 = var_32; var_34 < var_33; var_34++) {
      var_31[var_34] = undefined;
    }

    var_3._id_FE54 = var_31;
  }

  if(isDefined(var_3._id_106A1)) {
    var_35 = _func_034D(var_3._id_106A1, var_0.origin, var_29, var_31, 48);

    if(isDefined(var_35)) {
      _id_B980(var_3, var_35);
      return var_35;
    }
  } else if(var_0._id_0201 > 64 && isDefined(var_0._id_03B2)) {
    var_35 = _func_034E(var_0._id_03B2, var_0._id_0201, var_0.origin, var_29, var_31, 48);

    if(isDefined(var_35)) {
      _id_B980(var_3, var_35);
      return var_35;
    }
  }

  var_36 = _func_02AB(var_29, self);
  var_37 = undefined;

  if(isDefined(var_3._id_106A1)) {
    var_37 = self _meth_861B(var_36, var_3._id_106A1);

    if(!isDefined(var_37)) {
      var_37 = _func_02A9(var_3.origin, var_20, self);
    }
  }

  if(!isDefined(var_37)) {
    var_37 = _func_02A9(var_36, var_20, self);
  }

  if(!isDefined(var_37)) {
    var_37 = _func_02AB(var_3.origin, self);
  }

  return var_37;
}

_id_89B6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.origin - var_1.origin;
  var_7 = length(var_6);
  var_8 = _func_0261(var_6);
  var_9 = var_8 - var_2;

  if(var_9 >= 0 && var_9 <= var_3) {
    if(var_4 + var_5 > var_7) {
      return 1;
    }
  }

  return 0;
}

_id_7204(var_0, var_1, var_2) {
  var_3 = _id_6A80(var_0);
  var_3 thread _id_7201(var_1);
  var_4 = _id_71FB(var_3, var_1, var_2._id_8512);

  if(var_4) {
    thread _id_71FE(var_3, var_2);
  }
}

_id_7201(var_0) {
  wait 2;

  if(isDefined(var_0) && isalive(var_0)) {
    self._id_243B = 1;
  }
}

_id_71FE(var_0, var_1) {
  self endon("death");
  self endon("start_context_melee");
  waitframe();
  var_2 = _id_7208(var_0, self);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2._id_9DB5.size == 1) {
    var_3 = var_0._id_9DB5.size;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_0._id_9DB5[var_4];

      if(var_5 != self && var_5._id_0408._id_2C56 == 0 && distancesquared(var_5.origin, self.origin) < 10000) {
        var_5 _meth_819E(self);
      }
    }
  }

  if(_id_71FD(var_1)) {
    return;
  }
  if(var_0._id_9DB5.size > 1) {
    var_2 = _id_7208(var_0, self);

    if(isDefined(var_2) && var_2._id_E747 == 1 && var_2._id_9DB5.size == 1 && (!isDefined(var_2._id_26C5) || var_2._id_26C5)) {
      thread _id_08B5::_id_10AC("stealth", "announce2", "seek_backup", 2.0, undefined, 1);
    }
  }
}

_id_B990(var_0, var_1) {
  self.origin = var_1;

  if(!isDefined(self._id_A416)) {
    self._id_A416 = [];
  }

  self._id_8526 = var_0;
  self._id_A416[self._id_A416.size] = var_0;
}

_id_7205(var_0, var_1) {
  var_2 = _id_6A80(var_0);
  var_3 = self.origin;
  var_4 = 0;

  if(isDefined(var_1._id_0192)) {
    var_3 = var_1 _meth_8204(var_1._id_0192);
    var_4 = var_1 _meth_8205(var_1._id_0192);
    var_3 = _func_02AB(var_3, self);
  }

  _id_7219(var_2, var_1);
  _id_71FA(var_2, var_1, var_3, var_4);
}

_id_7220(var_0, var_1) {
  var_2 = _id_6A80(var_0._id_CE6E);
  var_3 = _id_7208(var_2, var_0);
  var_3.origin = _func_02AB(var_1, var_0);
  var_3._id_26C4 = undefined;

  if(isDefined(var_3._id_106A1)) {
    var_3._id_26C5 = _func_011A(var_1, var_3._id_106A1);
  }

  return var_3.origin;
}

_id_B989() {
  self endon("state_change");
  thread _id_B988();

  if(isDefined(level._id_0408._id_7BDE) && level._id_0408._id_7BDE[self._id_CE6E]) {
    var_0 = level._id_0408._id_7BDE[self._id_CE6E];
    wait(var_0);
    thread _id_B98F();
  } else
    return;
}

_id_B988() {
  self endon("state_change");

  for(;;) {
    var_0 = isDefined(self._id_106A1) && !istrue(self._id_26C5);

    if(var_0) {
      if(!isDefined(self._id_7B9F)) {
        self._id_7B9F = gettime();
        self._id_24FD = 1;
      } else if(istrue(self._id_24FD) && gettime() > self._id_7B9F + 20000)
        self._id_24FD = undefined;
    } else {
      self._id_24FD = undefined;
      self._id_7B9F = undefined;
    }

    waitframe();
  }
}

_id_B987() {
  self endon("state_change");
  wait 3;
  var_0 = self._id_AE5B;

  foreach(var_2 in var_0._id_9DB5) {
    if(var_2[[var_2._id_5D9A]]() || var_2[[var_2._id_5D9C]]()) {
      var_3 = 1;

      if(isDefined(var_2._id_0408._id_6035) && isDefined(var_2._id_0408._id_6035["should_hunt"])) {
        var_3 = var_2[[var_2._id_0408._id_6035["should_hunt"]]]();
      }

      if(var_3) {
        var_2 _id_08AC::_id_2C64("hunt", undefined);
      }
    }
  }
}

_id_B98A() {
  if(!isDefined(level._id_2453)) {
    level._id_2453 = 1;
  } else {
    return;
  }

  var_0 = undefined;

  for(;;) {
    var_1 = [];

    foreach(var_3 in level._id_0408._id_7225._id_722F) {
      if(isDefined(var_3._id_B992)) {
        foreach(var_5 in var_3._id_B992) {
          if(isDefined(var_5._id_E747) && var_5._id_E747 == 2) {
            foreach(var_7 in var_5._id_9DB5) {
              var_1 = scripts\engine\utility::array_add(var_1, var_7);
            }
          }
        }
      }
    }

    if(var_1.size < 1) {
      break;
    }

    if(var_1.size > 1) {
      var_1 = _func_0204(var_1, level.player.origin);
      var_1[0]._id_2359._id_426E = var_1;
      var_1[0] thread _id_08B5::_id_10AC("stealth", "hunt", "teaminquiry", undefined, undefined, 1);
      var_11 = var_1[0];
      var_1 = scripts\engine\utility::array_remove(var_1, var_11);
      wait(randomfloatrange(2, 2.5));
      var_1 = scripts\engine\utility::_id_1BCC(var_1);
      var_1 = _func_0204(var_1, level.player.origin);
      var_7 = undefined;

      switch (var_1.size) {
        case 0:
          break;
        case 3:
        case 2:
        case 1:
          var_7 = var_1[randomint(var_1.size)];
          break;
        default:
          var_7 = var_1[randomint(3)];
          break;
      }

      if(!isDefined(var_7)) {
        break;
      }

      var_1 = scripts\engine\utility::array_add(var_1, var_11);
      var_7._id_2359._id_426E = var_1;
      var_7 thread _id_08B5::_id_10AC("stealth", "hunt", "lost_sight", undefined, undefined, 1);
    } else {
      var_7 = var_1[0];

      if(!isDefined(var_0)) {
        var_0 = 1;
        var_7 thread _id_08B5::_id_10AC("stealth", "hunt", "first_lost");
      } else
        var_7 thread _id_08B5::_id_10AC("stealth", "hunt", "lost_sight");
    }

    wait(randomintrange(10, 15));
  }

  level._id_2453 = undefined;
}

_id_71F9(var_0, var_1) {
  _id_7219(var_0, var_1);

  foreach(var_3 in var_0._id_B992) {
    if(var_3._id_E747 == 3) {
      _id_116D(var_3, var_1);
      return 0;
    }
  }

  var_5 = _id_99FB(var_0, 3, undefined);
  _id_116D(var_5, var_1);
  var_5 thread _id_B983();
  var_5 thread _id_B982();
  return 1;
}

_id_71F8(var_0) {
  var_1 = _id_6A80(var_0);

  foreach(var_3 in var_1._id_B992) {
    if(var_3._id_E747 == 3) {
      return 1;
    }
  }

  return 0;
}

_id_7203(var_0, var_1, var_2) {
  var_3 = _id_6A80(var_0);
  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = var_2.origin;
  }

  var_5 = _id_7208(var_3, var_1);
  _id_71F9(var_3, var_1);
  var_3 thread _id_71FF(2.0, var_1, var_2, var_4);
  var_3 thread _id_7200(3.0, var_1, var_2, var_4);
}

_id_7200(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  wait(var_0);

  if(!isDefined(var_1) || !isalive(var_1) || istrue(var_1._id_0232)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  var_4 = 65536;

  foreach(var_6 in level._id_0408._id_7225._id_722F) {
    foreach(var_8 in var_6._id_9DB5) {
      if(var_1 == var_8) {
        continue;
      }
      var_9 = _id_7208(var_6, var_8);

      if(!isDefined(var_9)) {
        continue;
      }
      if(var_9._id_E747 == 1 || var_9._id_E747 == 2 && isDefined(var_9.target) && var_9.target == var_2) {
        if(var_1._id_CE6E == var_8._id_CE6E || distancesquared(var_1.origin, var_8.origin) < var_4) {
          var_8 _meth_812E(var_2);
          var_8 _meth_8523("combat", var_2, var_3);
        }
      }
    }
  }
}

_id_71FF(var_0, var_1, var_2, var_3) {
  wait(var_0);
  var_4 = 16384;

  if(!isDefined(var_1) || !isalive(var_1) || istrue(var_1._id_0232)) {
    return;
  }
  self._id_243B = 1;
  level notify("cover_blown");

  foreach(var_6 in level._id_0408._id_7225._id_722F) {
    foreach(var_8 in var_6._id_9DB5) {
      if(var_1 == var_8) {
        continue;
      }
      var_9 = 0;
      var_10 = 0;
      var_11 = _id_7208(var_6, var_8);

      if(isDefined(var_11) && var_11._id_E747 == 3) {
        continue;
      }
      if(isDefined(var_2)) {
        if(var_8 _meth_8067(var_2)) {
          var_9 = 1;
          var_10 = 1;
        }
      }

      if(!var_9 && var_8 _meth_8067(var_1)) {
        var_9 = 1;
      }

      if(!var_9 && distancesquared(var_8.origin, var_1.origin) < var_4 && var_8 _meth_861A(var_1)) {
        var_9 = 1;

        if(isDefined(var_2)) {
          var_10 = 1;
        }
      }

      if(var_10) {
        var_8 _meth_812E(var_2);
      }

      if(var_9) {
        if(isDefined(var_2)) {
          var_8 _meth_8523("combat", var_2, var_3);
          continue;
        }

        var_8 _meth_8523("combat", var_1, var_1.origin);
      }
    }
  }
}

_id_B98D(var_0, var_1) {
  var_2 = self._id_9DB5;

  foreach(var_4 in var_2) {
    if(var_0) {
      var_4 _meth_812E(var_1);
    }

    var_4 _meth_8523("combat", var_1, var_1.origin);
  }
}

_id_7230() {
  level notify("cancel_group_combat_checklosttarget");
  level endon("cancel_group_combat_checklosttarget");
  waitframe();

  while(!isDefined(level._id_0408._id_2C5B)) {
    var_0 = [];
    var_1 = 1;

    foreach(var_3 in level._id_0408._id_7225._id_722F) {
      foreach(var_5 in var_3._id_B992) {
        if(var_5._id_E747 == 3) {
          var_0[var_0.size] = var_5;

          if(!isDefined(var_5._id_242F) || !var_5 _id_B986()) {
            var_1 = 0;
            break;
          }
        }
      }

      if(!var_1) {
        break;
      }
    }

    if(var_1) {
      foreach(var_9 in var_0) {
        var_9 _id_B98E();
      }

      return;
    }

    wait 2;
  }
}

_id_B983() {
  self endon("state_change");
  wait 5;

  if(!_id_B986() && isDefined(level._id_0408._id_6035) && isDefined(level._id_0408._id_6035["call_backup"])) {
    self thread[[level._id_0408._id_6035["call_backup"]]]();
  }

  if(isDefined(level._id_0408._id_2C5B)) {
    return;
  }
  self._id_242F = 1;
  level thread _id_7230();
}

_id_B986() {
  var_0 = 10000;
  var_1 = 15000;
  var_2 = 50625;
  var_3 = gettime();
  var_4 = undefined;

  foreach(var_6 in self._id_9DB5) {
    if(isDefined(var_6._id_0408._id_6035) && isDefined(var_6._id_0408._id_6035["has_lost_enemy"])) {
      return var_6[[var_6._id_0408._id_6035["has_lost_enemy"]]]();
    }

    var_7 = var_6._id_0192;

    if(isDefined(var_7) && _func_011D(var_7) && isalive(var_7)) {
      if(var_7.team != "allies") {
        return 0;
      }

      var_8 = var_6 _meth_8205(var_7);

      if(var_3 < var_8 + var_0) {
        return 0;
      }

      var_9 = var_6 _meth_8204(var_7);

      if(var_8 > 0 && distancesquared(var_7.origin, var_9) < var_2) {
        return 0;
      }

      if(var_3 < var_8 + var_1 && var_7 _meth_861A(var_9)) {
        return 0;
      }

      if(isDefined(self._id_24CB)) {
        return 0;
      }

      continue;
    }

    if(!isDefined(var_6._id_0192) && var_6 scripts\engine\utility::_id_5472("in_the_dark") && var_6 scripts\engine\utility::_id_546E("in_the_dark") && var_3 - var_6._id_8FCD < var_0) {
      return 0;
    }
  }

  return 1;
}

_id_B98B(var_0, var_1, var_2) {
  if(!var_2) {
    var_2 = 0;
  }

  var_3 = var_1 * var_1;

  foreach(var_5 in self._id_9DB5) {
    if(distancesquared(var_0.origin, var_5.origin) > var_3) {
      continue;
    }
    if(var_2 && !var_0 _meth_861A(var_5)) {
      continue;
    }
    return 1;
  }

  return 0;
}

_id_B982() {
  self endon("state_change");
  var_0 = 1;
  var_1 = 384;
  wait(var_0);

  for(;;) {
    foreach(var_3 in level._id_0408._id_7225._id_722F) {
      foreach(var_5 in var_3._id_9DB5) {
        if(var_5._id_0408._id_2C56 == 3 || var_5._id_0408._id_2C56 == 2) {
          continue;
        }
        if(_id_B98B(var_5, var_1, 1)) {
          var_5 _meth_8523("combat", var_5, var_5.origin);
        }
      }
    }

    wait(var_0);
  }
}

_id_B98E() {
  var_0 = self._id_9DB5;

  foreach(var_2 in var_0) {
    var_3 = 1;

    if(isDefined(var_2._id_0408._id_6035) && isDefined(var_2._id_0408._id_6035["should_hunt"])) {
      var_3 = var_2[[var_2._id_0408._id_6035["should_hunt"]]]();
    }

    if(!var_3) {
      var_2 _id_08AC::_id_2C64("idle", undefined);
      continue;
    }

    var_2 _id_08AC::_id_2C64("hunt", undefined);
  }
}

_id_B98F() {
  foreach(var_1 in self._id_9DB5) {
    var_1 _meth_8523("reset", var_1, var_1.origin);
  }
}

_id_B98C(var_0) {
  var_1 = _id_6A80(var_0._id_CE6E);
  var_2 = _id_7208(var_1, var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  return var_2._id_9DB5[0] == var_0;
}

_id_B985(var_0) {
  var_1 = undefined;
  var_2 = 99999999;

  foreach(var_4 in self._id_9DB5) {
    var_5 = distancesquared(var_4.origin, var_0);

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

_id_B984() {
  self notify("state_change");
  var_0 = self._id_AE5B;
  var_1 = var_0._id_B992.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(var_0._id_B992[var_2] == self) {
      var_3 = var_0._id_B992.size - 1;
      var_0._id_B992[var_2] = var_0._id_B992[var_3];
      var_0._id_B992[var_3] = undefined;
      break;
    }
  }
}