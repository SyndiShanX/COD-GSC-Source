/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1728.gsc
*************************************************/

_id_12CF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1000;
  }

  _id_12D0(var_0, var_1, var_2, var_3);
}

_id_1242() {
  if(!isDefined(self._id_0B67._id_62ED)) {
    return;
  }
  if(isDefined(self._id_0B67._id_62ED._id_A6A6)) {
    self notify(self._id_0B67._id_62ED._id_A6A6, "gesture_cancel");
  }

  self._id_0B67._id_62ED = undefined;
}

_id_744F(var_0) {
  self waittill(var_0, var_1);

  if(!isDefined(var_1)) {
    var_1 = ["undefined"];
  }

  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4 == "start_gundown") {
      self._id_0213 = undefined;
      continue;
    } else if(var_4 == "finish_early") {
      self._id_0B67._id_AE7B = undefined;
      continue;
    } else
      var_5 = [[self._id_5D5D]](var_4, var_0);

    if(isDefined(var_5)) {
      var_2 = var_5;
    }
  }

  return var_2;
}

_id_62E7(var_0) {
  self endon("gesture_timeout");
  thread _id_62EC(var_0);

  for(;;) {
    var_1 = _id_744F("gesture");

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  self notify("gesture_finished");
}

_id_62EC(var_0) {
  self endon("gesture_finished");
  wait(var_0);
  self notify("gesture_timeout");
}

_id_62AA(var_0) {
  self endon("asm_terminated");
  self endon("death");

  for(;;) {
    if(!isDefined(self._id_0B67._id_62ED)) {
      self waittill("gesture_requested");
    }

    for(;;) {
      if(!isDefined(self._id_0B67._id_62ED)) {
        break;
      }

      if(self._id_0B67._id_62ED._id_F232 < gettime()) {
        _id_1242();
        break;
      }

      if(_id_06BD::_id_23E5()) {
        var_1 = self _meth_864B();

        if(!istrue(self._id_15D0) && var_1 > 135) {
          wait 0.1;
          continue;
        }

        if(self _meth_8473() < var_1 * 2.5) {
          wait 0.1;
          continue;
        }
      }

      self._id_0B67._id_62ED._id_90D4 = _id_64C7(self._id_0B67._id_62ED._id_62AA, self._id_0B67._id_62ED.target);
      var_2 = self _meth_8676(self._id_0B67._id_62ED._id_90D4);

      if(!isDefined(var_2)) {
        wait 0.1;
        continue;
      }

      self._id_0213 = "disable";
      self._id_0086 = 0;

      if(self._id_0B67._id_62ED._id_4AC6) {
        self._id_0166 = 1;
        self stoplookat();
      }

      var_4 = self._id_0B67._id_62ED._id_A6A6;
      self._id_0B67._id_62ED = undefined;
      self._id_0B67._id_AE7B = 1;
      _id_62E7(_func_0079(var_2));
      self._id_0B67._id_AE7B = undefined;

      if(isDefined(var_4)) {
        self notify(var_4, "gesture_finish");
      }

      self._id_0166 = 0;
      self._id_0213 = undefined;
      self _meth_8677();
      wait 0.4;
    }
  }
}

_id_62DD(var_0) {
  var_1 = ["casual_point", "military_point", "beckon", "nvg_on", "nvg_off"];

  if(isDefined(self._id_0B67._id_37B1) && var_0 == "beckon") {
    return 0;
  }

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 1;
  }

  return 0;
}

_id_12D0(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_0B67._id_62ED)) {
    _id_1242();
  }

  self._id_0B67._id_62ED = spawnStruct();
  self._id_0B67._id_62ED._id_62AA = var_0;
  self._id_0B67._id_62ED.target = var_1;
  self._id_0B67._id_62ED._id_F232 = gettime() + var_2;
  self._id_0B67._id_62ED._id_A6A6 = var_3;
  self._id_0B67._id_62ED._id_4AC6 = _id_62DD(var_0);
  self notify("gesture_requested");
}

_id_37C9() {
  return self._id_0B67._id_37B5 == 3;
}

_id_37CA() {
  return self._id_0B67._id_37B5 == 4;
}

_id_64C7(var_0, var_1) {
  if(isDefined(self._id_0B67._id_37B1)) {
    if(var_0 == "beckon") {
      var_2 = randomint(3) + 1;

      if(_id_37C9()) {
        var_0 = var_0 + "_" + var_2 + "_l";
      } else if(_id_37CA()) {
        var_0 = var_0 + "_" + var_2 + "_r";
      }
    } else if(var_0 == "glance") {
      var_2 = randomint(2) + 1;

      if(_id_37C9()) {
        var_0 = var_0 + "_" + var_2 + "_l";
      } else if(_id_37CA()) {
        var_0 = var_0 + "_" + var_2 + "_r";
      }
    }
  }

  if(isDefined(var_1) && (var_0 == "casual_point" || var_0 == "military_point" || var_0 == "beckon" || var_0 == "stop" || var_0 == "look" || var_0 == "hide")) {
    var_3 = _func_0261(var_1.origin - self.origin);
    var_4 = _func_000B(var_3 - self.angles[1]);
    var_5 = _func_0326(var_4, 22.5);
    var_5 = _id_08F1::_id_9AA5(var_5);
    return var_0 + var_5;
  }

  return var_0;
}

_id_126A() {
  if(isDefined(self._id_0B67._id_62ED._id_A6A6)) {
    self notify(self._id_0B67._id_62ED._id_A6A6, "gesture_finished");
  }

  self._id_0B67._id_62ED = undefined;
}

_id_35AF(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C7D(var_1, self._id_0B67._id_62ED._id_90D4);
  return var_3;
}

_id_B373(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_0B67._id_0F42 = self._id_0B67._id_62ED._id_A6A6;
  childthread _id_08F1::_id_D8CE(var_1, 0.2);
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_8251("face current");

  if(_id_0009::_id_1C43(var_0, "notetrackAim")) {
    var_5 = _func_0077(var_4, 0.0, 1.0);
    self._id_E83A = self.angles[1] + var_5;
  }

  self._id_0B67._id_62ED = undefined;
  self _meth_85ED(var_1, var_3);
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  self _meth_8251("face current");

  if(isDefined(self._id_0B67._id_0F42)) {
    self notify(self._id_0B67._id_0F42, "gesture_finished");
    self._id_0B67._id_0F42 = undefined;
  }
}

_id_3942(var_0, var_1, var_2) {
  if(isDefined(self._id_0B67._id_0F42)) {
    self notify(self._id_0B67._id_0F42, "gesture_cancel");
    self._id_0B67._id_0F42 = undefined;
  }
}

_id_62BC(var_0, var_1, var_2, var_3) {
  if(_id_06BD::_id_23E5() && istrue(self._id_62EA)) {
    if(isDefined(self._id_62EB)) {
      if(distancesquared(self.origin, level.player.origin) < self._id_62EB * self._id_62EB) {
        return 1;
      }
    } else
      return 1;
  }

  return _id_0009::_id_1C50(var_0, "finish_early") && _id_06BD::_id_23E5();
}