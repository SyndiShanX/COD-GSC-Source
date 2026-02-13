/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 23.gsc
*************************************************/

_id_129C(var_0, var_1) {
  self._id_24BD = var_0;
  _id_0009::_id_1C78();
  _id_0008::_id_00AC();
  _id_06BE::_id_1C77(var_1, self._id_189C);

  if(self _meth_85EC()) {
    thread _id_06BE::_id_F4E9();
  }
}

_id_7450(var_0, var_1, var_2) {
  if(isDefined(anim._id_A64F[var_0])) {
    return [[anim._id_A64F[var_0]]](var_0, var_1);
  }

  return undefined;
}

_id_0304(var_0, var_1) {
  if(isDefined(self._id_AAC5)) {
    self[[self._id_AAC5]](var_0, var_1);
  }
}

_id_0303() {
  self notify("killanimscript");
  self notify("terminate_ai_threads");
}

_id_B35A(var_0, var_1, var_2, var_3) {
  _id_B356(var_0, 0, var_1, var_2, var_3);
}

_id_B356(var_0, var_1, var_2, var_3, var_4) {
  self _meth_82E6(var_0, var_1);

  if(!isDefined(var_3)) {
    var_3 = "end";
  }

  _id_10980(var_2, var_3, var_0, var_1, var_4);
}

_id_B353(var_0, var_1, var_2, var_3, var_4, var_5) {
  self _meth_82E6(var_0, var_1, var_2);

  if(!isDefined(var_4)) {
    var_4 = "end";
  }

  _id_10980(var_3, var_4, var_0, var_1, var_5);
}

_id_1097F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;

  if(isDefined(var_5)) {
    var_7 = (gettime() - var_6) * 0.001 / var_5;
  }

  _id_7450(var_0, var_2, var_4);

  if(isDefined(var_2) && isDefined(self._id_1C30)) {
    _id_06BE::_id_1C71(var_0, var_2, var_3, var_7);
  }

  if(!isDefined(var_5) || var_7 > 0) {
    if(var_0 == var_1 || var_0 == "end" || var_0 == "finish") {
      return 1;
    } else if(var_0 == "anim_will_finish") {
      if(istrue(level.validate_anim_will_finish)) {
        if(isDefined(var_5) && var_5 - var_7 < level._id_5F3A) {
          return 1;
        }
      } else
        return 1;
    }
  }

  if(isDefined(var_4)) {
    [[var_4]](var_0, var_2, var_3, var_7);
  }

  return 0;
}

_id_10980(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();
  var_6 = undefined;

  if(isDefined(var_2) && isDefined(var_3)) {
    var_6 = _func_0079(self _meth_810C(var_2, var_3));
  }

  var_7 = 0;

  while(!var_7) {
    self waittill(var_0, var_8);

    if(_func_0107(var_8)) {
      foreach(var_10 in var_8) {
        if(_id_1097F(var_10, var_1, var_2, var_3, var_4, var_6, var_5)) {
          var_7 = 1;
        }
      }

      continue;
    }

    var_7 = _id_1097F(var_8, var_1, var_2, var_3, var_4, var_6, var_5);
  }
}

_id_B351(var_0, var_1) {
  _id_B355(var_0, 0, var_1);
}

_id_B355(var_0, var_1, var_2) {
  self _meth_82E6(var_0, var_1);
  wait(var_2);
}

_id_B358(var_0, var_1, var_2, var_3, var_4) {
  self _meth_82E6(var_0, var_1);
  thread _id_B359(var_0, var_1, var_2, var_4);
  wait(var_3);
  self notify(var_0 + var_1);
}

_id_B359(var_0, var_1, var_2, var_3) {
  self notify(var_0 + var_1);
  self endon(var_0 + var_1);
  var_4 = 0;
  var_5 = self _meth_810C(var_0, var_1);
  var_6 = _func_0079(var_5);
  var_7 = gettime();

  while(!var_4) {
    self waittill(var_2, var_8);

    if(!_func_0107(var_8)) {
      var_8 = [var_8];
    }

    foreach(var_10 in var_8) {
      if(_id_1097F(var_10, "end", var_0, var_1, var_3, var_6, var_7)) {
        var_4 = 1;
      }
    }
  }
}

_id_B352(var_0, var_1, var_2, var_3) {
  self _meth_82E6(var_0, var_1, var_2);
  wait(var_3);
}

_id_68C5(var_0, var_1, var_2) {
  var_3 = _func_0133(var_0);
  var_4 = var_0[2];
  var_5 = _func_0133(var_1);
  var_6 = var_1[2];
  var_7 = 1;
  var_8 = 1;

  if(isDefined(var_2) && var_2) {
    var_9 = (var_1[0], var_1[1], 0);
    var_10 = vectornormalize(var_9);

    if(vectordot(var_10, var_0) < 0) {
      var_7 = 0;
    } else if(var_5 > 0) {
      var_7 = var_3 / var_5;
    }
  } else if(var_5 > 0)
    var_7 = var_3 / var_5;

  if(abs(var_6) > 0.001 && var_6 * var_4 >= 0) {
    var_8 = var_4 / var_6;
  }

  var_11 = spawnStruct();
  var_11._id_10FDD = var_7;
  var_11._id_050C = var_8;
  return var_11;
}

_id_6E32(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return self _meth_8008(var_4, var_5, self._id_0359 + 4, self.height - var_2, 1);
}

_id_6D01(var_0) {
  var_1 = _func_00B0(var_0);
  var_2 = self _meth_8216(var_1);
  var_3 = _id_6E32(self.origin, var_2);
  var_4 = distance(self.origin, var_3);
  var_5 = distance(self.origin, var_2);
  return min(1.0, var_4 / var_5);
}

_id_CAE5(var_0, var_1, var_2, var_3) {
  var_4 = _id_6CBA(var_0);
  _id_CAE4(var_0, var_4, var_1, var_2, var_3);
}

_id_CAE2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_6CBA(var_0);
  _id_CAE3(var_0, var_5, var_1, var_2, var_3, var_4);
}

_id_CAE3(var_0, var_1, var_2, var_3, var_4, var_5) {
  self _meth_82E6(var_0, var_1, var_2);
  _id_CAE4(var_0, var_1, var_3, var_4, var_5);
}

_id_CAE4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self _meth_810C(var_0, var_1);
  var_6 = _id_6D01(var_5);

  if(self _meth_85EC()) {
    self _meth_82BA(var_6, 1.0);
  }

  _id_B356(var_0, var_1, var_2, var_3, var_4);

  if(self _meth_85EC()) {
    self _meth_82BA(1.0, 1.0);
  }
}

_id_6CBA(var_0) {
  var_1 = self _meth_810F(var_0);
  return randomint(var_1);
}

_id_68BD(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = _func_000B(var_1[1] - self.angles[1]);
  return _func_0326(var_2);
}

_id_D14E(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self _meth_82E6(var_0, var_1, var_2);
  } else if(isDefined(var_1)) {
    self _meth_82E6(var_0, var_1);
  } else {
    self _meth_82E6(var_0);
  }
}

_id_8A63() {
  if(!isDefined(self._id_0406)) {
    return 0;
  }

  return self._id_0406;
}

_id_D6EC(var_0, var_1) {
  self._id_0406 = var_0;
}

_id_B357(var_0, var_1, var_2, var_3, var_4) {
  _id_B354(var_0, var_1, 1.0, var_2, var_3, var_4);
}

_id_10981(var_0, var_1, var_2) {
  self endon("death_or_disconnect");

  if(isDefined(var_2)) {
    childthread _id_A608(var_0, var_2, var_1);
  }

  _id_10980(var_0, var_1);
  self notify("Notetrack_Timeout");
}

_id_B354(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death_or_disconnect");

  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_6 = _func_0079(self _meth_810C(var_0, var_1));
    } else {
      var_6 = _func_0079(self _meth_810C(var_0, 0));
    }

    var_7 = var_6 / max(0.01, var_2);
    childthread _id_A608(var_3, var_7, var_4);
  }

  _id_B353(var_0, var_1, var_2, var_3, var_4, var_5);
  self notify("Notetrack_Timeout");
}

_id_A608(var_0, var_1, var_2) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  var_1 = max(0.05, var_1);
  wait(var_1);

  if(isDefined(var_2)) {
    self notify(var_0, var_2);
  } else {
    self notify(var_0, "end");
  }
}

_id_4E88(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_4 != "highest_point") {
    _id_B356(var_0, var_1, var_3, var_4, var_7);
  }

  if(var_6) {
    var_8 = self._id_532D;
    var_9 = 1;
  } else {
    var_8 = scripts\engine\utility::getstruct(self._id_532B.target, "targetname");
    var_8 = var_8.origin;
    var_10 = _func_00BB(var_2, "highest_point");
    var_9 = var_10[0];
  }

  _id_4E89(var_0, var_1, var_3, var_2, var_4, var_5, var_8, var_9, var_7);
}

_id_4E89(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = abs(self.origin[2] - var_6[2]);
  var_10 = _func_00BB(var_3, var_4);
  var_11 = var_10[0];
  var_12 = var_11;
  var_13 = _func_00BB(var_3, var_5);
  var_14 = var_13[0];
  var_7 = var_14;
  var_15 = "flex_height_up_top";
  var_16 = _func_00BB(var_3, var_15);
  var_17 = "flex_height_down_top";
  var_18 = _func_00BB(var_3, var_17);
  var_19 = "flex_height_down_bottom";
  var_20 = _func_00BB(var_3, var_19);

  if(var_4 == "flex_height_up_start" && var_16.size > 0) {
    var_7 = var_16[0];
  }

  if(var_4 == "flex_height_down_start") {
    if(var_18.size > 0) {
      var_12 = var_16[0];
    }

    if(var_20.size > 0) {
      var_7 = var_20[0];
    }
  }

  var_21 = _func_00B0(var_3, var_12, var_7);
  var_22 = abs(var_21[2]);
  var_24 = _func_00B0(var_3, var_11, var_14);
  var_25 = abs(var_24[2]);

  if(var_25 < 1) {
    var_26 = 1;
  } else {
    var_27 = var_22 - var_25;

    if(var_9 <= var_27) {
      var_26 = (var_27 - var_9) / var_25;
    } else {
      var_26 = (var_9 - var_27) / var_25;
    }
  }

  var_28 = clamp(1 / var_26, 0.33, 3.0);

  if(self _meth_85EC()) {
    self _meth_82BA(1.0, var_26);
  }

  _id_B353(var_0, var_1, var_28, var_2, var_5, var_8);
}