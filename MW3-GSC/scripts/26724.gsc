/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26724.gsc
**************************************/

_id_49DB(var_0, var_1, var_2) {
  if(!isDefined(level._id_49DC)) {
    thread _id_49EE();

  }
  var_3 = spawnStruct();
  level._id_49DC[var_0] = var_3;
  var_3._id_49DD = var_1;

  if(isarray(var_1)) {
    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_3._id_49DE[var_4] = 0;
    }
  } else {
    var_3._id_49DE = 0;

  }
  var_3._id_49DF = spawnStruct();
  var_3._id_49E0 = spawnStruct();
  var_3._id_49E1 = var_2;
  var_3.index = 0;
}

_id_49E2(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_0._id_49E3)) {
    for(var_0 = var_0._id_49E3; isDefined(var_0); var_0 = var_0._id_49E4) {
      if(!isDefined(var_1) || var_0.class == var_1) {
        var_2++;
      }
    }
  }

  return var_2;
}

_id_49E5() {}

_id_49E6(var_0, var_1) {
  if(var_0.priority >= 100) {
    return 1;

  }
  if(isarray(var_1._id_49DD)) {
    for(var_2 = 0; var_2 < var_1._id_49DD.size; var_2++) {
      if(var_0._id_3EC1[var_2] + var_1._id_49DE[var_2] > var_1._id_49DD[var_2]) {
        return 0;
      }
    }
  } else if(var_0._id_3EC1 + var_1._id_49DE > var_1._id_49DD) {
    return 0;

  }
  return 1;
}

_id_49E7(var_0, var_1) {
  if(isarray(var_1._id_49DD)) {
    for(var_2 = 0; var_2 < var_1._id_49DD.size; var_2++) {
      var_1._id_49DE[var_2] = var_1._id_49DE[var_2] + var_0._id_3EC1[var_2];
    }
  } else {
    var_1._id_49DE = var_1._id_49DE + var_0._id_3EC1;
  }
}

_id_49E8(var_0, var_1) {
  if(isarray(var_1._id_49DD)) {
    for(var_2 = 0; var_2 < var_1._id_49DD.size; var_2++) {
      var_1._id_49DE[var_2] = var_1._id_49DE[var_2] - var_0._id_3EC1[var_2];
    }
  } else {
    var_1._id_49DE = var_1._id_49DE - var_0._id_3EC1;
  }
}

_id_49E9(var_0, var_1) {
  if(isDefined(var_1._id_49DF._id_49E3)) {
    var_2 = var_1._id_49DF._id_49E3;

    if(_id_49E6(var_2, var_1)) {
      var_1._id_49DF._id_49E3 = var_2._id_49E4;

      if(isDefined(var_1._id_49DF._id_49E3)) {
        var_1._id_49DF._id_49E3._id_49EA = undefined;
      } else {
        var_1._id_49DF._id_49EB = undefined;

      }
      var_2._id_49E4 = undefined;

      if(isDefined(var_1._id_49E0._id_49EB)) {
        var_1._id_49E0._id_49EB._id_49E4 = var_2;
        var_2._id_49EA = var_1._id_49E0._id_49EB;
        var_1._id_49E0._id_49EB = var_2;
      } else {
        var_1._id_49E0._id_49E3 = var_2;
        var_1._id_49E0._id_49EB = var_2;
      }

      var_2._id_49EC = 1;
      _id_49E7(var_2, var_1);

      if(isDefined(var_2._id_49ED)) {
        thread[[var_2._id_49ED]](var_2);
      }
    }
  }
}

_id_49EE() {
  for(;;) {
    if(isDefined(level._id_49DC)) {
      foreach(var_2, var_1 in level._id_49DC) {}
      _id_49E9(var_2, var_1);
    }

    wait 0.05;
  }
}

_id_49EF(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.priority = var_1;
  var_3.class = var_2;
  var_3._id_3EC1 = var_0;
  var_3._id_49EC = 0;
  return var_3;
}

_id_49F0(var_0, var_1) {
  var_2 = level._id_49DC[var_0];
  var_1._id_49F1 = var_2;
  var_1._id_49F2 = var_2.index;
  var_2.index++;
  var_7 = var_2._id_49DF._id_49E3;
  var_8 = undefined;

  while(isDefined(var_7)) {
    if(var_1.priority > var_7.priority) {
      if(isDefined(var_8)) {
        var_8._id_49E4 = var_1;
        var_1._id_49EA = var_8;
      } else {
        var_2._id_49DF._id_49E3 = var_1;

      }
      var_1._id_49E4 = var_7;
      var_7._id_49EA = var_1;
      break;
    } else {
      var_8 = var_7;
      var_7 = var_7._id_49E4;
    }
  }

  if(!isDefined(var_7)) {
    if(isDefined(var_8)) {
      var_8._id_49E4 = var_1;
      var_1._id_49EA = var_8;
    } else {
      var_2._id_49DF._id_49E3 = var_1;
    }
  }

  if(!isDefined(var_1._id_49E4)) {
    var_2._id_49DF._id_49EB = var_1;
  }
}

_id_49F3(var_0, var_1) {
  var_2 = var_1._id_49EA;
  var_3 = var_1._id_49E4;

  if(isDefined(var_2)) {
    var_2._id_49E4 = var_3;
  } else {
    var_0._id_49E3 = var_1._id_49E4;

  }
  if(isDefined(var_3)) {
    var_3._id_49EA = var_2;
  } else {
    var_0._id_49EB = var_1._id_49EA;

  }
  var_1._id_49EA = undefined;
  var_1._id_49E4 = undefined;
  var_1._id_49EC = -1;
}

_id_49F4(var_0, var_1, var_2) {
  if(var_2 && isDefined(var_1._id_49F5)) {
    [[var_1._id_49F5]](var_1);

  }
  _id_49E8(var_1, var_0);
  _id_49F3(var_0._id_49E0, var_1);
  var_1 notify("killed");
}

_id_49F6(var_0, var_1, var_2) {
  if(var_2 && isDefined(var_1._id_49F7)) {
    [[var_1._id_49F7]](var_1);

  }
  _id_49F3(var_0._id_49DF, var_1);
}

_id_49F8(var_0, var_1) {
  var_2 = level._id_49DC[var_0];

  for(var_3 = var_2._id_49DF._id_49E3; isDefined(var_3); var_3 = var_4) {
    var_4 = var_3._id_49E4;

    if(isarray(var_1)) {
      foreach(var_6 in var_1) {
        if(var_3.class == var_6) {
          _id_49F6(var_2, var_3, 1);
          break;
        }
      }

      continue;
    }

    if(var_3.class == var_1) {
      _id_49F6(var_2, var_3, 1);
    }
  }

  for(var_3 = var_2._id_49E0._id_49E3; isDefined(var_3); var_3 = var_4) {
    var_4 = var_3._id_49E4;

    if(isarray(var_1)) {
      foreach(var_6 in var_1) {
        if(var_3.class == var_6) {
          _id_49F4(var_2, var_3, 1);
          break;
        }
      }

      continue;
    }

    if(var_3.class == var_1) {
      _id_49F4(var_2, var_3, 1);
    }
  }
}

_id_49F9(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);

  }
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0._id_49EC < 0) {
    return;
  }
  var_2 = var_0._id_49F1;

  if(var_0._id_49EC) {
    _id_49F4(var_2, var_0, 0);
  } else {
    _id_49F6(var_2, var_0, 0);
  }
}

_id_49FA(var_0, var_1) {
  if(isDefined(var_0)) {
    while(isDefined(var_0)) {
      if(isDefined(var_0.name) && var_0.name == var_1) {
        break;
      }

      var_0 = var_0._id_49E4;
    }
  }

  return var_0;
}

_id_49FB(var_0, var_1) {
  var_2 = level._id_49DC[var_0];
  var_3 = var_2._id_49DF._id_49E3;
  return _id_49FA(var_3, var_1);
}

_id_49FC(var_0, var_1) {
  var_2 = level._id_49DC[var_0];
  var_3 = var_2._id_49E0._id_49E3;
  return _id_49FA(var_3, var_1);
}

_id_49FD(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    while(isDefined(var_0)) {
      if(isDefined(var_0.name) && var_0.name == var_1) {
        var_2++;

      }
      var_0 = var_0._id_49E4;
    }
  }

  return var_2;
}

_id_49FE(var_0, var_1) {
  var_2 = level._id_49DC[var_0];
  var_3 = var_2._id_49DF._id_49E3;
  return _id_49FD(var_3, var_1);
}

_id_49FF(var_0, var_1) {
  var_2 = level._id_49DC[var_0];
  var_3 = var_2._id_49E0._id_49E3;
  return _id_49FD(var_3, var_1);
}

_id_4A00(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = -1;

  }
  var_5 = _id_4A03(var_2, var_3, var_4);
  var_5._id_4A01 = var_0;
  var_5._id_4A02 = var_1;
  return var_5;
}

_id_4A03(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 100;

  }
  if(!isDefined(var_1)) {
    var_1 = 100;

  }
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  var_3 = _id_49EF(var_0, var_1, var_2);
  var_3._id_49ED = ::_id_4A04;
  var_3._id_49F7 = ::_id_4A05;
  var_3._id_49F5 = ::_id_4A06;
  _id_49F0("fx", var_3);
  return var_3;
}

_id_4A04(var_0) {
  var_0 endon("killed");
}

_id_4A05(var_0) {}

_id_4A06(var_0) {}

_id_4A07(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = -1;

  }
  var_5 = _id_4A09(var_2, var_3, var_4);
  var_5._id_4A08 = var_0;
  var_5._id_4A02 = var_1;
}

_id_4A09(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 100;

  }
  if(!isDefined(var_1)) {
    var_1 = 100;

  }
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  var_3 = _id_49EF(var_0, var_1, var_2);
  var_3._id_49ED = ::_id_4A0A;
  var_3._id_49F5 = ::_id_4A0C;
  _id_49F0("fx", var_3);
  return var_3;
}

_id_4A0A(var_0) {
  var_0 endon("killed");
  common_scripts\utility::exploder(var_0._id_4A0B);

  if(isDefined(var_0._id_4A02)) {
    if(var_0._id_4A02 == 0) {
      _id_49F9("fx", var_0);
    } else if(var_0._id_4A02 > 0) {
      wait(var_0._id_4A02);
      _id_49F9("fx", var_0);
    }
  }
}

_id_4A0C(var_0) {}

_id_4A0D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _id_49EF(var_4, var_5, var_6);
  var_8._id_4A0E = var_1;
  var_8._id_4A0F = var_2;
  var_8._id_4A10 = var_3;
  var_8._id_49ED = ::_id_4A13;
  var_8._id_49F7 = ::_id_4A14;
  var_8._id_49F5 = ::_id_4A15;
  var_8.name = var_7;
  _id_49F0(var_0, var_8);
  return var_8;
}

_id_4A11(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _id_4A0D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  var_8 waittill(var_1);
  return var_8;
}

_id_4A12(var_0, var_1) {
  var_0 notify(var_1);

  if(isDefined(var_0._id_14B9)) {
    var_0._id_14B9 notify(var_1);
  }
}

_id_4A13(var_0) {
  _id_4A12(var_0, var_0._id_4A0E);
}

_id_4A14(var_0) {
  _id_4A12(var_0, var_0._id_4A0F);
}

_id_4A15(var_0) {
  _id_4A12(var_0, var_0._id_4A10);
}

_id_4A16(var_0, var_1, var_2, var_3, var_4, var_5) {
  return _id_4A0D("fx", var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_4A17(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return _id_4A11("fx", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_4A18(var_0, var_1, var_2, var_3) {
  var_4 = _id_49EF(var_1, var_2, var_3);
  _id_49F0(var_0, var_4);
}