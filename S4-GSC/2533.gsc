/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2533.gsc
*************************************************/

_spawnvehicle(var_0, var_1) {
  if(!istrue(var_0._id_E728)) {
    if(!_id_31E1()) {
      if(isDefined(var_1)) {
        var_1._id_58CA = "total_limit_exceeded";
      }

      return undefined;
    }
  }

  var_2 = undefined;

  if(isDefined(var_0._id_81FA)) {
    var_2 = _func_0216(var_0.modelname, var_0._id_0481, var_0._id_04DE, var_0.origin, var_0.angles, var_0.owner, var_0._id_81FA);
  } else {
    var_2 = _func_0216(var_0.modelname, var_0._id_0481, var_0._id_04DE, var_0.origin, var_0.angles, var_0.owner);
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1)) {
      var_1._id_58CA = "total_limit_exceeded";
    }

    return undefined;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_tracking", "vehicle_spawned")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_tracking", "vehicle_spawned")]](var_2);
  }

  var_2._id_E293 = var_0;
  level._id_102F3++;
  var_0._id_31A0 = 1;

  if(!istrue(var_0._id_31A0)) {
    if(istrue(var_0._id_E728)) {
      _id_0D8B(var_2);
    } else {
      thread _id_10C27(var_2, 3);
    }
  } else
    _id_102EF(var_2, 1);

  return var_2;
}

_id_0D7D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_6 = spawnStruct();
  var_6.modelname = var_4;
  var_6._id_04DE = var_3;
  var_6.origin = var_1;
  var_6.angles = var_2;
  var_6.owner = var_0;

  if(!_id_31E1()) {
    if(isDefined(var_5)) {
      var_5._id_58CA = "total_limit_exceeded";
    }

    return undefined;
  }

  var_7 = spawnhelicopter(var_6.owner, var_6.origin, var_6.angles, var_6._id_04DE, var_6.modelname);

  if(!isDefined(var_7)) {
    if(isDefined(var_5)) {
      var_5._id_58CA = "code";
    }

    return undefined;
  }

  level._id_102F3++;
  return var_7;
}

_id_0BB8(var_0) {
  var_0 notify("vehicle_deleted");
  level._id_102F3--;

  if(istrue(var_0._id_8A84)) {
    level._id_EBE4--;
    level._id_EBE5[var_0 getentitynumber()] = undefined;
  }

  var_0 delete();
  return 1;
}

_id_0D8B(var_0) {
  if(isDefined(var_0._id_31A0)) {
    return 0;
  }

  var_0 notify("vehicle_wake_up_or_suspend");

  if(!istrue(var_0._id_8A84)) {
    var_0._id_8A84 = 1;
    level._id_EBE4++;
    level._id_EBE5[var_0 getentitynumber()] = var_0;

    if(!var_0 _meth_8104()) {
      var_0 _meth_8102();
    }
  }

  return 1;
}

_id_0DCA(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 3;
  }

  if(!istrue(var_0._id_8A84)) {
    return 1;
  }

  var_0 notify("vehicle_wake_up_or_suspend");

  if(!_id_320C()) {
    if(istrue(var_1)) {
      thread _id_BEDB(var_0, var_2, var_3);
    }

    return 0;
  } else {
    var_0._id_8A84 = undefined;
    level._id_EBE4--;
    level._id_EBE5[var_0 getentitynumber()] = undefined;

    if(var_0 _meth_8104()) {
      var_0 _meth_8103();
    }

    if(istrue(var_2)) {
      thread _id_10C27(var_0, var_3);
    }
  }

  return 1;
}

_id_BEDB(var_0, var_1, var_2) {
  var_0 endon("vehicle_deleted");
  var_0 endon("vehicle_wake_up_or_suspend");

  for(;;) {
    if(_id_320C()) {
      thread _id_0DCA(var_0, undefined, var_1, var_2);
      return;
    }

    waitframe();
  }
}

_id_10C27(var_0, var_1) {
  var_0 endon("vehicle_deleted");
  var_0 endon("vehicle_wake_up_or_suspend");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = undefined;
  var_3 = undefined;
  var_4 = 0;

  for(;;) {
    wait 0.05;

    if(!var_0 _id_102ED()) {
      return;
    }
    if(isDefined(var_2)) {
      var_3 = var_2;
    }

    var_2 = var_0 _meth_842E();

    if(isDefined(var_3) && abs(var_2 - var_3) / 0.05 > 3) {
      var_4 = 0;
      continue;
    }

    var_4 = var_4 + 0.05;

    if(var_4 >= 3) {
      thread _id_0D8B(var_0);
      return;
    }
  }
}

_id_102EF(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_0._id_31A0)) {
      var_0._id_31A0 = 0;
    }

    var_0._id_31A0++;

    if(istrue(var_0._id_8A84)) {
      return _id_0DCA(var_0, var_2, 0);
    }
  } else {
    if(!isDefined(var_0._id_31A0)) {
      return;
    }
    var_0._id_31A0--;

    if(var_0._id_31A0 == 0) {
      var_0._id_31A0 = undefined;
    }

    if(!isDefined(var_0._id_31A0)) {
      thread _id_10C27(var_0);
    }
  }

  return 1;
}

_id_31E1() {
  return level._id_102F3 - level._id_EBE4 < level._id_9CB8;
}

_id_320C() {
  return _id_31E1();
}

_id_102ED() {
  return !isDefined(self._id_31A0);
}

_id_0C41() {
  return istrue(self._id_8A84);
}

_id_6E3C() {
  return level._id_102F3;
}

_id_6DAA() {
  return level._id_EBE4;
}

_id_C59B(var_0) {
  if(_id_31E1()) {
    if(!isDefined(var_0)) {
      level._id_102F3++;
      return 1;
    }

    var_1 = level._id_9CB8 - (level._id_102F3 - level._id_EBE4);

    if(var_0 <= var_1) {
      level._id_102F3 = level._id_102F3 + var_0;
      return 1;
    }
  }

  return 0;
}

_id_3992(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level._id_102F3 = level._id_102F3 - var_0;
  level._id_102F3 = int(max(0, level._id_102F3));
}

_id_6E3F(var_0) {
  return var_0._id_E293;
}

_id_3D67(var_0, var_1) {
  var_1.modelname = var_0.modelname;
  var_1._id_0481 = var_0._id_0481;
  var_1._id_04DE = var_0._id_04DE;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.owner = var_0.owner;
  var_1._id_81FA = var_0._id_81FA;
  var_1._id_31A0 = var_0._id_31A0;
  var_1._id_E728 = var_0._id_E728;
  var_1.spawntype = var_0.spawntype;
  var_1.team = var_0.team;
  var_1._id_FE22 = var_0._id_FE22;
}

_id_102C5(var_0, var_1, var_2) {
  _id_102BB(var_0);
  level.vehicle._id_8300[var_0._id_1031E][var_0 getentitynumber()] = var_0;
  var_0._id_10323 = undefined;

  if(isDefined(var_1)) {
    var_0._id_10323 = var_1;
  }

  var_0._id_10356 = undefined;

  if(isDefined(var_2)) {
    var_0._id_10356 = var_2;
  }
}

_id_102BB(var_0) {
  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle._id_8300)) {
    return;
  }
  if(!isDefined(level.vehicle._id_8300[var_0._id_1031E])) {
    return;
  }
  level.vehicle._id_8300[var_0._id_1031E][var_0 getentitynumber()] = undefined;

  if(level.vehicle._id_8300[var_0._id_1031E].size <= 0) {
    level.vehicle._id_8300[var_0._id_1031E] = undefined;
  }

  var_0._id_10323 = undefined;
  var_0._id_10356 = undefined;
}

_id_102C2(var_0, var_1, var_2) {
  level.vehicle._id_82FF[var_0] = var_1;
  level.vehicle._id_82FE[var_0] = var_2;
}

_id_102C3(var_0, var_1, var_2) {
  level.vehicle._id_ADA6[var_0] = var_1;
  level.vehicle._id_ADA5[var_0] = var_2;
}

_id_102C4(var_0, var_1, var_2) {
  level.vehicle._id_EF7E[var_0] = var_1;
  level.vehicle._id_EF7D[var_0] = var_2;
}

_id_102B9(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle._id_8300[var_0])) {
    return 0;
  }

  var_4 = level.vehicle._id_82FF[var_0];

  if(isDefined(var_4)) {
    if(isDefined(level.vehicle._id_8300[var_0]) && level.vehicle._id_8300[var_0].size >= var_4) {
      return 1;
    }
  }

  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_5 = level.vehicle._id_ADA6[var_0];
    var_6 = 0;
  }

  var_7 = undefined;
  var_8 = undefined;

  if(isDefined(var_2)) {
    var_7 = level.vehicle._id_EF7E[var_0];
    var_8 = 0;
  }

  if(!isDefined(var_5) && !isDefined(var_7)) {
    return 0;
  }

  foreach(var_10 in level.vehicle._id_8300[var_0]) {
    if(isDefined(var_5) && isDefined(var_10._id_10323) && var_10._id_10323 == var_1) {
      var_6++;

      if(var_6 >= var_5) {
        return 1;
      }
    }

    if(isDefined(var_7) && isDefined(var_10._id_10356) && var_10._id_10356 == var_2) {
      var_8++;

      if(var_8 >= var_7) {
        return 1;
      }
    }
  }

  return 0;
}

_id_102BC(var_0) {
  if(!isDefined(level.vehicle._id_8300[var_0])) {
    return [];
  }

  return level.vehicle._id_8300[var_0];
}

_id_102BE(var_0, var_1) {
  if(!isDefined(level.vehicle._id_8300[var_0])) {
    return [];
  }

  var_2 = [];

  foreach(var_4 in level.vehicle._id_8300[var_0]) {
    if(isDefined(var_4._id_10323) && var_4._id_10323 == var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_102BF(var_0, var_1) {
  if(!isDefined(level.vehicle._id_8300[var_0])) {
    return [];
  }

  var_2 = [];

  foreach(var_4 in level.vehicle._id_8300[var_0]) {
    if(isDefined(var_4._id_10356) && var_4._id_10356 == var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_102BD() {
  if(!isDefined(level.vehicle._id_8300)) {
    return [];
  }

  var_0 = [];

  foreach(var_2 in level.vehicle._id_8300) {
    foreach(var_4 in var_2) {
      var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

_id_102C1(var_0) {
  if(isDefined(level.vehicle._id_82FF[var_0])) {
    return 1;
  }

  if(isDefined(level.vehicle._id_ADA6[var_0])) {
    return 1;
  }

  if(isDefined(level.vehicle._id_EF7E[var_0])) {
    return 1;
  }

  return 0;
}

_id_102C0() {
  level.vehicle._id_8300 = [];
  level.vehicle._id_82FF = [];
  level.vehicle._id_ADA6 = [];
  level.vehicle._id_EF7E = [];
  level.vehicle._id_82FE = [];
  level.vehicle._id_ADA5 = [];
  level.vehicle._id_EF7D = [];
  level._id_102F3 = 0;
  level._id_EBE4 = 0;
  level._id_9CB8 = getdvarint("#x3bb16a582733f712", 128);
  level._id_EBE5 = [];
}