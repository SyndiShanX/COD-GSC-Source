/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2529.gsc
*************************************************/

_id_100EF(var_0, var_1, var_2) {
  var_3 = _id_100EE();
  var_4 = var_3._id_102F6[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3._id_102F6[var_0] = var_4;
      var_4._id_CFC0 = [];
    } else {}
  }

  return var_4;
}

_id_100ED(var_0, var_1, var_2) {
  var_3 = _id_100EF(var_0._id_1031E, var_1, var_2);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_0 _meth_86EB())) {
    return undefined;
  }

  var_4 = var_0._id_834C;

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_0._id_834C = var_4;
      var_4._id_4A92 = 0;
      var_4._id_B9B6 = [];

      foreach(var_7, var_6 in var_3._id_CFC0) {
        var_4._id_B9B6[var_7] = _id_100EC(var_0, var_7, var_1, var_2);
      }

      var_4._id_49CE = 1;
      var_4._id_4A88 = undefined;
      var_4._id_1F96 = undefined;
    } else {}
  }

  return var_4;
}

_id_10107(var_0) {
  _id_100ED(var_0, 1);
  _id_100FA(var_0);
  var_1 = _id_100EE();
  var_1._id_1032B[var_0 getentitynumber()] = var_0;
}

_id_100EA(var_0) {
  var_1 = _id_100EE();

  if(isDefined(var_1._id_1032B[var_0 getentitynumber()])) {
    _id_100F9(var_0);
  }

  var_1._id_1032B[var_0 getentitynumber()] = undefined;
  var_0._id_834C = undefined;
}

_id_100F8(var_0) {
  return isDefined(var_0._id_834C);
}

_id_100E6(var_0) {
  var_1 = _id_100EE();

  if(!isDefined(var_1._id_1032B)) {
    return;
  }
  if(!var_0) {
    var_1._id_4A92++;

    if(var_1._id_4A92 == 1) {
      foreach(var_3 in var_1._id_1032B) {
        _id_1010F(var_3);
        _id_10112(var_3);
      }
    }
  } else {
    var_1._id_4A92--;

    if(var_1._id_4A92 == 0) {
      foreach(var_3 in var_1._id_1032B) {
        _id_1010F(var_3);
        _id_10112(var_3);
      }
    }
  }
}

_id_100E5(var_0, var_1) {
  var_2 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  if(!var_1) {
    var_2._id_4A92++;

    if(var_2._id_4A92 == 1) {
      _id_1010F(var_0);
      _id_10112(var_0);
    }
  } else {
    var_2._id_4A92--;

    if(var_2._id_4A92 == 0) {
      _id_1010F(var_0);
      _id_10112(var_0);
    }
  }
}

_id_100F6() {
  var_0 = spawnStruct();
  level.vehicle._id_832C = var_0;
  var_0._id_102F6 = [];
  var_0._id_4A92 = 0;
  _id_07A1::_id_CECB(::_id_10109);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_interact", "init")]]();
}

_id_10109(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_2 == "vehicle_use") {
    var_6 = var_0 _meth_86EC();
    var_7 = var_1;

    if(_id_10101(var_3)) {
      if(istrue(_id_10116(var_6))) {
        if(_id_10100(var_3, var_6)) {
          if(_id_10104(var_6, var_7)) {
            var_8 = _id_100EC(var_6, var_7);
            var_9 = var_8._id_1F94;
            thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_6, var_9, var_3);
          }
        }
      }
    }
  }
}

_id_10111(var_0, var_1) {
  var_2 = _id_100EE();

  if(!_id_10101(var_0)) {
    foreach(var_4 in var_1) {
      var_4 _meth_86A8(var_0);
    }

    return;
  }

  foreach(var_4 in var_1) {
    if(istrue(_id_10116(var_4)) && _id_10100(var_0, var_4)) {
      var_4 _meth_86A7(var_0);
      continue;
    }

    var_4 _meth_86A8(var_0);
  }
}

_id_100FB(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("update_vehicle_usability", var_1);
    _id_10111(var_0, var_1);
  }
}

_id_100EE() {
  return level.vehicle._id_832C;
}

_id_10101(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(!var_0 scripts\common\utility::_id_8710()) {
    return 0;
  }

  if(var_0 _meth_86B8() || var_0 isskydiving()) {
    return 0;
  }

  if(var_0 _meth_86C8() || var_0 _meth_86C9()) {
    return 0;
  }

  return 1;
}

_id_10116(var_0) {
  var_1 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(var_1._id_49CE) {
    _id_100E8(var_0);
  }

  return !var_1._id_4A88;
}

_id_10104(var_0, var_1) {
  var_2 = _id_100EC(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2._id_49CE) {
    _id_100E7(var_0, var_1);
  }

  return !var_2._id_4A88;
}

_id_10100(var_0, var_1) {
  if(level.teambased) {
    var_2 = _id_100F5(var_1);

    if(isDefined(var_2) && var_2 != var_0.team) {
      return 0;
    }
  } else {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A8(var_1);

    if(isDefined(var_3) && var_3 != var_0) {
      return 0;
    }
  }

  return 1;
}

_id_100F5(var_0) {
  var_1 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(var_1._id_49CE) {
    _id_100E8(var_0);
  }

  return var_1._id_1F96;
}

_id_1010F(var_0) {
  var_1 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  var_1._id_49CE = 1;
}

_id_100E8(var_0) {
  var_1 = _id_100EE();
  var_2 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  if(level.teambased) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AD(var_0);

    if(isDefined(var_3)) {
      var_2._id_1F96 = var_3;
    } else {
      var_4 = undefined;
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AA(var_0);

      foreach(var_7 in var_5) {
        if(isDefined(var_7)) {
          var_4 = var_7.team;
          break;
        }
      }

      var_2._id_1F96 = var_4;
    }
  }

  if(var_1._id_4A92 > 0) {
    var_2._id_4A88 = 1;
  } else if(var_2._id_4A92 > 0) {
    var_2._id_4A88 = 1;
  } else {
    var_2._id_4A88 = 0;
  }

  var_2._id_49CE = 0;
}

_id_100EC(var_0, var_1, var_2, var_3) {
  var_4 = _id_100ED(var_0, var_2, var_3);

  if(!isDefined(var_4)) {
    return undefined;
  }

  var_5 = var_4._id_B9B6[var_1];

  if(!isDefined(var_5) && isDefined(var_2)) {
    if(istrue(var_2)) {
      var_5 = spawnStruct();
      var_4._id_B9B6[var_1] = var_5;
      var_5._id_49CE = 1;
      var_5._id_4A88 = undefined;
      var_5._id_1F94 = undefined;
    } else {}
  }

  return var_5;
}

_id_10105(var_0, var_1) {
  var_2 = _id_100EC(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2._id_49CE) {
    _id_100E7(var_0, var_1);
  }

  return var_2._id_4A88;
}

_id_10103(var_0, var_1) {
  var_2 = _id_100EC(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2._id_49CE) {
    _id_100E7(var_0, var_1);
  }

  return var_2._id_1F94;
}

_id_1010B(var_0, var_1) {
  var_2 = _id_100EC(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2._id_49CE = 1;
}

_id_1010C(var_0) {
  var_1 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1._id_B9B6) {
    var_3._id_49CE = 1;
  }

  var_1._id_49CE = 1;
}

_id_100E7(var_0, var_1) {
  var_2 = _id_100EC(var_0, var_1, undefined, 1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = _id_100EF(var_0._id_1031E);
  var_4 = var_3._id_CFC0[var_1];
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101F8(var_0, var_7)) {
      var_5 = var_7;
      break;
    }
  }

  var_2._id_4A88 = !isDefined(var_5);
  var_2._id_1F94 = var_5;
  var_2._id_49CE = 0;
}

_id_100FA(var_0) {
  _id_10112(var_0);
}

_id_100F9(var_0) {
  var_1 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getarraykeys(var_1._id_B9B6);

  foreach(var_4 in var_2) {
    var_0 setscriptablepartstate(var_4, "vehicle_unusable");
  }
}

_id_10112(var_0) {
  var_1 = _id_100ED(var_0, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1._id_49CE) {
    _id_100E8(var_0);
  }

  if(var_1._id_4A88) {
    _id_100F9(var_0);
    return;
  }

  foreach(var_4, var_3 in var_1._id_B9B6) {
    if(var_3._id_49CE) {
      _id_100E7(var_0, var_4);
    }

    if(var_3._id_4A88) {
      var_0 setscriptablepartstate(var_4, "vehicle_unusable");
      continue;
    }

    var_0 setscriptablepartstate(var_4, "vehicle_use");
  }
}

_id_100F7() {
  var_0 = setdvarifuninitialized("#x3ca02f50c1c81b766", 0);
}