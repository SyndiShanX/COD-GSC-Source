/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2041.gsc
*************************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_0026 = [];
  var_0._id_C112 = [];
  var_0._id_C598 = [];
  var_0.index = 0;
  var_0._id_94D4 = _func_03F0();
  level._id_A8DC = var_0;
}

_id_C581(var_0) {
  var_1 = spawnStruct();
  var_1._id_A906 = var_0;
  level._id_A8DC._id_0026[var_0] = var_1;
  level._id_A8DC.index++;
  level._id_A8DC._id_C598[level._id_A8DC._id_C598.size] = var_0;
  return var_0;
}

_id_C57D(var_0) {
  var_1 = _id_6B89(var_0);

  if(var_1 == -1) {
    return -1;
  }

  var_2 = spawnStruct();
  var_2._id_BD27 = var_0;
  var_2._id_C582 = gettime();
  var_2._id_A906 = var_1;
  level._id_A8DC._id_0026[var_1] = var_2;
  return var_1;
}

_id_C478(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8DC._id_0026) {
    if(var_3._id_BD27 <= var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  scripts\engine\utility::_id_1BD6(var_1, ::_id_3AFC);
  return _id_C799(var_1[0]._id_A906);
}

_id_3AFC(var_0, var_1) {
  if(var_0._id_BD27 == var_1._id_BD27) {
    return var_0._id_C582 < var_1._id_C582;
  } else {
    return var_0._id_BD27 < var_1._id_BD27;
  }
}

_id_6B89(var_0) {
  if(!level._id_A8DC._id_C112.size) {
    if(level._id_A8DC.index == level._id_A8DC._id_94D4) {
      return -1;
    } else {
      var_1 = level._id_A8DC.index;
      level._id_A8DC.index++;
    }
  } else {
    var_1 = level._id_A8DC._id_C112[level._id_A8DC._id_C112.size - 1];
    level._id_A8DC._id_C112[level._id_A8DC._id_C112.size - 1] = undefined;
  }

  return var_1;
}

_id_C799(var_0) {
  if(!isDefined(var_0) || var_0 == -1) {
    return 0;
  }

  for(var_1 = 0; var_1 < level._id_A8DC._id_C112.size; var_1++) {
    if(var_0 == level._id_A8DC._id_C112[var_1]) {
      return 0;
    }
  }

  level._id_A8DC._id_0026[var_0] = undefined;
  _func_015C(var_0);
  level._id_A8DC._id_C112[level._id_A8DC._id_C112.size] = var_0;
  return 1;
}

_id_C79D(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == -1) {
    return 0;
  }

  if(istrue(var_1)) {
    level._id_A8DC._id_0026[var_0] = undefined;
  }

  _func_015C(var_0);
  return 1;
}

_id_A864(var_0, var_1, var_2, var_3, var_4) {
  _func_015C(var_0);

  if(isDefined(var_1)) {
    _func_016B(var_0, var_1);
  }

  if(isDefined(var_2)) {
    _func_0163(var_0, var_2);
  }

  if(isDefined(var_3)) {
    _func_015D(var_0, var_3);
  }

  if(isDefined(var_4)) {
    _func_0179(var_0, var_4);
  }
}

_id_A867(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }
  _id_A864(var_0, var_1, var_2, var_3, var_4);
}

_id_FB96(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0182(var_0, var_1);
}

_id_FB95(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0181(var_0, var_1);
}

_id_FB9B(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0174(var_0, var_1);
}

_id_FB9A(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0168(var_0, var_1);
}

_id_FB99(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0169(var_0, var_1);
}

_id_FB9C(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016A(var_0, var_1);
}

_id_FB9E(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016B(var_0, var_1);
}

_id_FB97(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0163(var_0, var_1);
}

_id_FB8F(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_015D(var_0, var_1);
}

update_codcaster_objective(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }
  _func_015E(var_0, var_1, var_2, var_3, var_4);
}

_id_FB98(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017A(var_0, var_1);
}

update_objective_showbounds(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0470(var_0, var_1);
}

update_objective_setboundsrotation(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0471(var_0, var_1);
}

_id_FB93(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0160(var_0, var_1);
}

_id_FB94(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0160(var_0, var_1);
  _func_0177(var_0, 1);
}

_id_FB9D(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0161(var_0, var_1);
}

_id_A8A5(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);
  _func_0185(var_0, var_1);
  _func_018C(var_0);
}

_id_A8CA(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);
  _func_0187(var_0, var_1);
  _func_018C(var_0);
}

_id_A89F(var_0) {
  if(var_0 == -1) {
    return;
  }
  _func_0188(var_0);
  _func_018D(var_0);
}

_id_A8A0(var_0) {
  if(var_0 == -1) {
    return;
  }
  _func_0186(var_0);
  _func_018D(var_0);
}

_id_A8A1(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0186(var_0);
  _func_0189(var_0, var_1);
  _func_018D(var_0);
}

_id_A89E(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0189(var_0, var_1);
  _func_018C(var_0);
}

_id_A89D(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018C(var_0);
  _func_0185(var_0, var_1);
}

_id_A8A2(var_0) {
  if(var_0 == -1) {
    return;
  }
  _func_0188(var_0);
  _func_018C(var_0);
}

_id_A8A3(var_0) {
  if(var_0 == -1) {
    return;
  }
  _func_0186(var_0);
  _func_018C(var_0);
}

_id_A8A4(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0186(var_0);
  _func_0189(var_0, var_1);
  _func_018C(var_0);
}

objective_playermask_showtoclientlist(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      _func_0185(var_0, var_3);
    }
  }

  _func_018C(var_0);
}

_id_A88D(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);

  if(level.teambased) {
    _func_0187(var_0, var_1.team);
  } else {
    _func_0185(var_0, var_1);
  }

  _func_018C(var_0);
}

_id_A88C(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018B(var_0);

  if(level.teambased) {
    _func_0187(var_0, var_1.team);
  } else {
    _func_0185(var_0, var_1);
  }

  _func_018D(var_0);
}

_id_A8C8(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0187(var_0, var_1);
  _func_018C(var_0);
}

_id_A8C9(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_018A(var_0, var_1);
  _func_018C(var_0);
}

_id_A89A(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016C(var_0, var_1);
}

_id_A89C(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016F(var_0, var_1);
}

_id_A8D0(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0170(var_0, var_1);
}

_id_A89B(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_016D(var_0, var_1);
}

_id_A8CF(var_0, var_1, var_2) {
  if(var_0 == -1) {
    return;
  }
  _func_016E(var_0, var_1);
}

_id_A8BE(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0176(var_0, var_1);
}

_id_A8BF(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0469(var_0, var_1);
}

_id_A876(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_046A(var_0, var_1);
}

_id_A8C0(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_046B(var_0, var_1);
}

_id_A877(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_046C(var_0, var_1);
}

_id_A8C4(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017B(var_0, var_1);
}

_id_A8C5(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017E(var_0, var_1);
}

_id_A87B(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017F(var_0, var_1);
}

_id_A8C3(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017C(var_0, var_1);
}

_id_A87A(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_017D(var_0, var_1);
}

_id_A8B4(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0180(var_0, var_1);
}

_id_A8B6(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0184(var_0, var_1);
}

objective_set_claiming_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0413(var_0, var_1);
}

_id_A8B5(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0183(var_0, var_1);
}

_id_A8B1(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0172(var_0, var_1);
}

_id_A8B2(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0173(var_0, var_1);
}

_id_A8B7(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0175(var_0, var_1);
}

_id_A8BA(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0473(var_0, var_1);
}

_id_A878(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0411(var_0, var_1);
}

_id_A8C1(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0412(var_0, var_1);
}

objective_set_hide_on_minimap_when_clipped(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0449(var_0, var_1);
}

_id_4022(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_C57D(10);

  if(var_5 == -1) {
    return -1;
  }

  _id_A867(var_5, "invisible", (0, 0, 0));

  if(!isDefined(self _meth_8151()) && !istrue(var_3)) {
    _id_FB97(var_5, self.origin);
  } else if(istrue(var_3) && istrue(var_4)) {
    _id_FB94(var_5, self);
  } else {
    _id_FB93(var_5, self);
  }

  _id_FB9E(var_5, "active");
  _id_FB8F(var_5, var_0);
  _id_FB98(var_5, 1);

  if(level.teambased) {
    if(isDefined(var_1)) {
      _id_FB96(var_5, var_1);
    } else {
      _id_A8A2(var_5);
    }
  } else if(isDefined(self.owner))
    _id_FB95(var_5, self.owner);

  if(isDefined(level._id_A91D)) {
    [[level._id_A91D]](var_5);
  }

  return var_5;
}

_id_4023(var_0, var_1, var_2) {
  var_3 = _id_C57D(10);

  if(var_3 == -1) {
    return -1;
  }

  _id_A867(var_3, "invisible", (0, 0, 0));

  if(!isDefined(self _meth_8151()) && !istrue(var_1)) {
    _id_FB97(var_3, self.origin);
  } else if(istrue(var_1) && istrue(var_2)) {
    _id_FB94(var_3, self);
  } else {
    _id_FB93(var_3, self);
  }

  _id_FB9E(var_3, "active");
  _id_FB8F(var_3, var_0);
  _id_FB98(var_3, 1);
  _id_FB96(var_3, self.team);
  _id_A89F(var_3);
  return var_3;
}