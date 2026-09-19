/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_binoculars.gsc
*******************************************/

_id_175E() {
  thread _id_93AD();
  thread _id_93AC();
}

_id_93AD() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self._id_93AB = spawnStruct();
  self._id_93AB._id_5E6C = [];
  self._id_93AB._id_5E74 = 0;
  var_0 = 0;

  for(;;) {
    if(issubstr(self getcurrentweapon(), "binoculars") && self _meth_8345() > 0.99) {
      var_0 = 1;

      if(self._id_93AB._id_5E6C.size > 0)
        _id_7C96();

      self._id_93AB._id_5E6C = _id_0F95(common_scripts\utility::_id_0FA0(self._id_93AB._id_5E6C));

      if(isDefined(self._id_93AB._id_5E72)) {
        if(!_id_5E73(self._id_93AB._id_5E72)) {
          self._id_93AB._id_5E72 = undefined;
          self notify("stop_javelin_locking_feedback");
        }
      }

      if(isDefined(self._id_93AB._id_5E72))
        self._id_93AB._id_5E74 = self._id_93AB._id_5E74 + 0.05;
      else {
        self._id_93AB._id_5E74 = 0;

        if(self._id_93AB._id_5E6C.size < 1) {
          self._id_93AB._id_5E72 = _id_40CB();

          if(isDefined(self._id_93AB._id_5E72))
            thread _id_5E71();
        }
      }

      if(self._id_93AB._id_5E74 >= 1 && isDefined(self._id_93AB._id_5E72) && self._id_93AB._id_5E6C.size < 1) {
        self notify("stop_javelin_locking_feedback");
        self._id_93AB._id_5E6C[self._id_93AB._id_5E6C.size] = self._id_93AB._id_5E72;
        thread _id_5E6B();
        self._id_93AB._id_5E72 = undefined;
      }

      if(self._id_93AB._id_5E6C.size > 0)
        self _meth_82EA(self._id_93AB._id_5E6C[0]);
      else {
        self _meth_82EB();
        self notify("stop_javelin_locked_feedback");
      }
    } else if(var_0 == 1) {
      var_0 = 0;
      self _meth_82EB();
      self notify("stop_javelin_locking_feedback");
      self notify("stop_javelin_locked_feedback");
      self._id_93AB._id_5E6C = [];

      if(isDefined(self._id_93AB._id_5E72))
        self._id_93AB._id_5E72 = undefined;

      self._id_93AB._id_5E74 = 0;
    }

    waitframe();
  }
}

_id_93AC() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(issubstr(var_1, "binoculars"))
      thread _id_93A6(self, var_0, var_1);
  }
}

_id_93A6(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_3 = var_1.origin;
    var_4 = var_1.angles;
    var_1 delete();
  } else
    return;

  var_0._id_93AB._id_5E6C = _id_0F95(common_scripts\utility::_id_0FA0(self._id_93AB._id_5E6C));
  var_5 = [];

  for(var_6 = 0; var_6 < 1; var_6++) {
    var_7 = var_4 + _id_7A43(20, 20, 20);
    var_8 = anglesToForward(var_7);
    var_9 = _func_1B5(var_2, var_3, var_3 + var_8, var_0);
    var_9._id_0117 = var_0;

    if(var_0._id_93AB._id_5E6C.size > 0) {
      var_10 = undefined;

      if(var_6 < var_0._id_93AB._id_5E6C.size)
        var_10 = var_0._id_93AB._id_5E6C[var_6];
      else
        var_10 = var_0._id_93AB._id_5E6C[randomint(var_0._id_93AB._id_5E6C.size)];

      var_9 _meth_81D9(var_10, _id_93A9(var_10));
      var_9._id_5E70 = var_10;
    }

    var_5[var_5.size] = var_9;
  }

  level notify("stinger_fired", var_0, var_5);
  thread _id_49F2(var_5[0]._id_5E70, var_5[0]);
  var_0 setweaponammoclip(var_2, 0);
}

_id_49F2(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 endon("death");
  var_2 = "orbitalsupport_exp_40mm";
  wait(_func_0A5(0.5, 1.0));

  while(1 && isDefined(var_0)) {
    var_3 = _func_0A4(-50, 50);
    var_4 = _func_0A4(-100, 100);
    var_5 = _func_0A4(-200, 200);

    foreach(var_7 in level.players) {
      var_7 _meth_82E6(common_scripts\utility::_id_44F5("flak_gun_explosion"), var_0.origin + (var_3, var_4, var_5));
      var_7 playSound(var_2);
    }

    wait(_func_0A5(0.05, 1.0));
  }
}

_id_0F12(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_5E70) && var_3._id_5E70 == var_1)
      return 1;
  }

  return 0;
}

_id_40CB() {
  var_0 = maps\mp\_utility::getotherteam(self.team);
  var_1 = [];

  if(0) {
    foreach(var_3 in level.players) {
      if(level.teambased && var_3.team == self.team) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_3)) {
        continue;
      }
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = _func_1E1();
  var_6 = [];

  foreach(var_8 in var_5) {
    if(!isDefined(var_8._id_0117)) {
      continue;
    }
    if(level.teambased && var_8._id_0117.team == self.team) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  var_10 = _id_051E::_id_4405(var_0);
  var_11 = common_scripts\utility::_id_0F73(var_1, var_6);
  var_11 = common_scripts\utility::_id_0F73(var_11, var_10);

  if(isDefined(level._id_93A8))
    var_11 = common_scripts\utility::_id_0F73(var_11, [[level._id_93A8]](self));

  var_12 = self getEye();
  var_13 = anglesToForward(self getplayerangles());
  var_14 = undefined;
  var_15 = _func_0A7(5);

  foreach(var_17 in var_11) {
    if(!common_scripts\utility::_id_0F79(self._id_93AB._id_5E6C, var_17)) {
      var_18 = _id_93AA(var_17);
      var_19 = vectordot(vectorNormalize(var_18 - var_12), var_13);

      if(var_19 > var_15) {
        var_20 = undefined;
        var_21 = !1;

        if(!var_21) {
          var_22 = _func_07E(var_12, var_18, 0, var_17);

          if(var_22)
            var_21 = 1;
        }

        if(var_21) {
          var_14 = var_17;
          var_15 = var_19;
        }
      }
    }
  }

  return var_14;
}

_id_5E73(var_0) {
  var_1 = self getEye();
  var_2 = anglesToForward(self getplayerangles());
  var_3 = _id_93AA(var_0);

  if((isPlayer(var_0) || isbot(var_0)) && !maps\mp\_utility::isreallyalive(var_0))
    return 0;

  if(vectordot(vectorNormalize(var_3 - var_1), var_2) > _func_0A7(5)) {
    if(!1 || _func_07E(var_1, var_3, 0, var_0))
      return 1;
  }

  return 0;
}

_id_7C96() {
  for(var_0 = 0; var_0 <= self._id_93AB._id_5E6C.size; var_0++) {
    if(isDefined(self._id_93AB._id_5E6C[var_0]) && isDefined(self._id_93AB._id_5E6C[var_0].origin)) {
      if(!isDefined(self._id_93AB._id_5E6C[var_0]._id_8C44))
        self._id_93AB._id_5E6C[var_0]._id_8C44 = -1;

      var_1 = (0, 0, 0);

      if(isPlayer(self._id_93AB._id_5E6C[var_0]) || isbot(self._id_93AB._id_5E6C[var_0]))
        var_1 = (0, 0, 64);

      if(self _meth_8215(self._id_93AB._id_5E6C[var_0].origin + var_1, 50, 400, 200)) {
        if(_func_07E(self getEye(), self._id_93AB._id_5E6C[var_0].origin + var_1, 0, self._id_93AB._id_5E6C[var_0])) {
          self._id_93AB._id_5E6C[var_0]._id_8C44 = -1;
          continue;
        }
      }

      if(self._id_93AB._id_5E6C[var_0]._id_8C44 == -1) {
        self._id_93AB._id_5E6C[var_0]._id_8C44 = gettime();
        continue;
      }

      if(gettime() - self._id_93AB._id_5E6C[var_0]._id_8C44 >= 500) {
        self._id_93AB._id_5E6C[var_0]._id_8C44 = -1;
        self._id_93AB._id_5E6C[var_0] = undefined;
      }
    }
  }
}

_id_93AA(var_0) {
  if(isDefined(var_0._id_46B0))
    return var_0[[var_0._id_46B0]]();

  return var_0 _meth_8216(0, 0, 0);
}

_id_93A9(var_0) {
  return _id_93AA(var_0) - var_0.origin;
}

_id_5E71() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level._id_9047)) {
      foreach(var_1 in level._id_9047) {
        if(isDefined(var_1._id_0117) && isDefined(var_1.player) && isDefined(self._id_93AB._id_5E72) && self._id_93AB._id_5E72 == var_1)
          var_1._id_0117 playlocalsound("wpn_stingerm7_enemy_locked");
      }
    }

    if(isDefined(level._id_6C24) && isDefined(self._id_93AB._id_5E72) && self._id_93AB._id_5E72 == level._id_6C23)
      level._id_6C24 playlocalsound("wpn_stingerm7_enemy_locked");

    self playlocalsound("wpn_stingerm7_locking");
    self _meth_809F("heavygun_fire");
    wait 0.6;
  }
}

_id_5E6B() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("stop_javelin_locked_feedback");

  for(;;) {
    if(isDefined(level._id_9047)) {
      foreach(var_1 in level._id_9047) {
        if(isDefined(var_1._id_0117) && isDefined(var_1.player) && isDefined(self._id_93AB._id_5E6C) && _id_5718(self._id_93AB._id_5E6C, var_1))
          var_1._id_0117 playlocalsound("wpn_stingerm7_enemy_locked");
      }
    }

    if(isDefined(level._id_6C24) && isDefined(self._id_93AB._id_5E6C) && _id_5718(self._id_93AB._id_5E6C, level._id_6C23))
      level._id_6C24 playlocalsound("wpn_stingerm7_enemy_locked");

    self playlocalsound("wpn_stingerm7_locked");
    self _meth_809F("heavygun_fire");
    wait 0.25;
  }
}

_id_0F95(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_7A43(var_0, var_1, var_2) {
  return (_func_0A3(var_0) - var_0 * 0.5, _func_0A3(var_1) - var_1 * 0.5, _func_0A3(var_2) - var_2 * 0.5);
}

_id_5718(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(var_3 == var_1)
        return 1;
    }
  }

  return 0;
}