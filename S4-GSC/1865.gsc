/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1865.gsc
*************************************************/

init() {
  level._id_5693 = spawnStruct();
  level._id_5693._id_C254 = [];

  if(!isDefined(level._id_7047)) {
    level._id_7047 = [];
  }
}

_id_C1E3(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_E5E6 = var_1;
  var_4._id_E89C = var_2;
  var_4._id_7F8B = var_3;
  var_4._id_1F84 = 1;
  var_4._id_0026 = 0;
  scripts\engine\utility::_id_5C11("event_" + var_0 + "_completed");
  level._id_5693._id_C254[var_0] = var_4;
}

_id_037E(var_0) {
  if(getdvarint("#x34bfc8a57c9e9c6a7", 0) != 0) {
    return;
  }
  level thread _id_E5D6(var_0);
}

_id_E5D6(var_0) {
  level endon("game_ended");
  var_1 = 1;
  level._id_56AE = var_0;

  for(var_2 = int(_func_0222(var_0, 0, "maxid", 1)); var_1 <= var_2; var_1++) {
    var_3 = _func_0222(var_0, 0, var_1 + "", 5);
    var_4 = _func_0222(var_0, 0, var_1 + "", 2);
    var_5 = spawnStruct();
    var_5.index = int(0);
    var_5._id_C958 = var_1;
    var_5._id_C189 = _func_0222(var_0, 0, var_1 + "", 2);
    var_5._id_0F01 = _func_0222(var_0, 0, var_1 + "", 7);
    var_5._id_A902 = _func_0222(var_0, 0, var_1 + "", 8);
    var_5.label = _func_0222(var_0, 0, var_1 + "", 9);

    if(isDefined(level._id_A8F6[var_5._id_C189]) && isDefined(level._id_A8F6[var_5._id_C189]._id_BEBD)) {
      var_5._id_BEBD = level._id_A8F6[var_5._id_C189]._id_BEBD;
    } else {
      var_5._id_BEBD = "global";
    }

    var_5._id_F246 = int(_func_0222(var_0, 0, var_1 + "", 11));
    var_5._id_F247 = int(_func_0222(var_0, 0, var_1 + "", 12));
    var_5._id_F248 = int(_func_0222(var_0, 0, var_1 + "", 13));
    var_5._id_DCCF = int(_func_0222(var_0, 0, var_1 + "", 14));
    var_5._id_B9BE = int(_func_0222(var_0, 0, var_1 + "", 15));
    var_5._id_F1F9 = _func_0222(var_0, 0, var_1 + "", 1);
    var_5._id_1D32 = var_0;
    var_5._id_56AF = var_3;
    var_6 = _func_0222(var_0, 0, var_1 + "", 3);
    var_5._id_C550 = var_6;
    _id_1CFD(var_5);
    var_5._id_DCD0 = var_5._id_DCCF;

    if(var_5._id_0F01 == "") {
      var_5._id_0F01 = undefined;
    }

    if(!isDefined(var_5._id_0F01) && !isDefined(var_5._id_A902) && !isDefined(var_5._id_7C7B)) {
      var_5._id_A5B5 = 1;
    }

    level._id_7047[level._id_7047.size] = var_5;
    level._id_A8F6[var_4] = var_5;
    level._id_5693._id_56BC[var_4] = var_5;
    _id_C202(var_4);
  }

  level thread _id_448A();
  level thread _id_4494();
  level thread _id_449E();
}

_id_1CFD(var_0) {
  var_1 = _func_0222(var_0._id_1D32, 0, var_0._id_C958 + "", 10);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = strtok(var_1, ",");
  var_3 = undefined;

  if(var_2.size == 3) {
    var_3 = (int(var_2[0]), int(var_2[1]), int(var_2[2]));
  } else if(var_2.size == 2) {
    var_3 = scripts\engine\utility::getStructArray(var_2[0], var_2[1]);

    if(!isDefined(var_3)) {
      var_3 = getEntArray(var_1, var_2[1]);
    }

    if(!isDefined(var_3) || var_3.size == 0) {
      var_3 = getEntArray(var_2[0], var_2[1]);
    }
  }

  if(isDefined(var_3)) {
    if(isvector(var_3)) {
      var_0._id_7C7B = var_3;
    } else if(_func_0107(var_3)) {
      var_0._id_7C7B = [];

      foreach(var_5 in var_3) {
        var_0._id_7C7B[var_0._id_7C7B.size] = var_5.origin;
        var_0._id_8395 = var_5;
        var_5._id_A8F8 = var_0;
      }
    } else
      var_0._id_7C7B = var_3.origin;
  } else
    var_0._id_7C7B = var_3;
}

_id_472B(var_0) {
  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");

  if(isDefined(var_1)) {
    if(scripts\engine\utility::array_contains(level._id_EA70["targetname"][var_0], var_1)) {
      level._id_EA70["targetname"][var_0] = ::scripts\engine\utility::array_remove(level._id_EA70["targetname"][var_0], var_1);
    }

    var_1 = undefined;
  }
}

_id_C202(var_0) {
  if(!isDefined(level._id_5693._id_C254)) {
    return;
  }
  if(!isDefined(level._id_5693._id_C254[var_0])) {
    return;
  }
  var_1 = level._id_5693._id_C254[var_0]._id_E5E6;
  var_2 = level._id_5693._id_C254[var_0]._id_5299;
  _id_0748::_id_C281(var_0, undefined, var_1, var_2);
}

_id_CA09() {
  if(getdvarint("#x3f6bab114f343f811", 0) != 0) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level._id_5693._id_56BC) {
    if(isDefined(var_2._id_F1F9) && var_2._id_F1F9 != "") {
      level thread _id_F12E(var_0, var_2);
    }
  }
}

_id_F12E(var_0, var_1) {
  if(_id_1091B(var_0, var_1._id_F1F9)) {
    _id_F722(var_1._id_C189, var_1._id_1D32, var_1._id_C958);
  }
}

_id_F722(var_0, var_1, var_2) {
  if(var_0 == "") {
    return;
  }
  if(getDvar("#x39396569cba90186e", "") != "") {
    if(getDvar("#x39396569cba90186e", "") != level._id_A8F6[var_0]._id_C189) {
      return;
    }
  }

  if(getdvarint("#x34bfc8a57c9e9c6a7", 0) != 0) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = level._id_56AE;
  }

  var_3 = level._id_A8F6[var_0];
  var_4 = var_3._id_C550;

  if(!isDefined(var_2)) {
    var_2 = var_3._id_C958;
  }

  _id_F733(var_0, var_4);

  if(_id_85C0(var_0)) {
    return;
  }
  _id_9B14(var_0, 1);
  _id_F71C(var_0);
  var_5 = _func_0222(var_1, 0, var_2 + "", 4);

  if(var_5 != "") {
    level thread _id_34B0(var_0, var_5, var_4);
  } else {
    level thread _id_E5D5(var_0, var_4);
  }
}

_id_F71C(var_0) {
  level endon("stop_repeating_event_" + var_0);
  var_1 = level._id_A8F6[var_0];
  var_2 = _id_6513(var_0);

  if(isDefined(var_2)) {
    level[[var_2]](var_1);
  }
}

_id_F733(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == "") {
    return;
  }
  var_2 = strtok(var_1, ",");
  var_3 = int(var_2[0]);
  var_4 = int(var_2[1]);
  _id_FBE8(var_0, var_3, var_4);
}

_id_FBE8(var_0, var_1, var_2) {
  if(!isDefined(level._id_10741)) {
    level._id_10741 = [];
  }

  var_3 = spawnStruct();
  var_3._id_9EAD = var_1;
  var_3._id_9C3F = var_2;
  level._id_10741[var_0] = var_3;
}

_id_E892(var_0) {
  if(var_0 == "") {
    return;
  }
  if(!_id_85C0(var_0)) {
    return;
  }
  _id_4468("^6 STOP EVENT " + var_0);
  _id_9B14(var_0, 0);
  var_1 = _id_6791(var_0);
  var_2 = level._id_A8F6[var_0];

  if(_id_85C1(var_0)) {
    if(isDefined(var_2._id_B9BE) && var_2._id_B9BE > 0) {
      foreach(var_4 in level.players) {
        var_4 _id_074E::_id_6F28(var_2._id_B9BE, "large");
      }
    }
  }

  var_6 = var_2._id_C550;
  var_2 = level._id_A8F6[var_0];
  level thread _id_0748::_id_45AA(var_2);
  level notify("debug_beat_" + var_2._id_C189 + "_objective");

  if(isDefined(var_1)) {
    level thread[[var_1]]();
  }
}

_id_4A40(var_0) {
  level notify("stop_repeating_event_" + var_0);
}

_id_34B0(var_0, var_1, var_2) {
  level endon("game_ended");
  _id_1073E(var_1);
  _id_E5D5(var_0, var_2);
}

_id_E5D5(var_0, var_1) {
  if(var_0 == "") {
    return;
  }
  if(getdvarint("#x3ff39b51e5b747661", 0) != 0) {
    var_1 = "";
  }

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = level._id_A8F6[var_0];

  if(_id_85C0(var_2._id_56AF)) {
    _id_E892(var_2._id_56AF);
  }

  var_3 = _id_6785(var_0);

  if(!isDefined(var_3)) {}

  _id_1CFD(var_2);

  if(_id_85C2(var_1)) {
    level thread _id_C9F5(var_0, var_3);
  } else {
    _id_4468("^6 EVENT" + var_0 + "^6RUN");
    level thread _id_0748::_id_C9E7(var_0, "global");
  }
}

_id_85C2(var_0) {
  return !(var_0 == "");
}

_id_C9F5(var_0, var_1) {
  level endon("stop_repeating_event_" + var_0);
  var_2 = level._id_A8F6[var_0];

  for(;;) {
    _id_1CFD(var_2);
    level thread _id_0748::_id_C9E7(var_0, "global");
    _id_4468("^6 REPEATING EVENT" + var_0 + "^6RUN");
    var_3 = _id_682A(var_0);
    var_4 = randomintrange(var_3._id_9EAD, var_3._id_9C3F);
    var_5 = 0;

    while(var_5 < var_4) {
      var_5 = var_5 + 1;

      if(getdvarint("#x3415efa79103544a5", 0) != 0) {
        var_5 = var_4;
      }

      wait 1;
    }

    level thread _id_0748::_id_45AA(var_2);
    level notify("debug_beat_" + var_2._id_C189 + "_objective");
    wait 5;
  }
}

_id_682A(var_0) {
  return level._id_10741[var_0];
}

_id_9B14(var_0, var_1) {
  level._id_5693._id_C254[var_0]._id_0026 = var_1;
}

_id_85C0(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = level._id_5693._id_C254[var_0];

  if(isDefined(var_1)) {
    return istrue(var_1._id_0026);
  } else {
    return 0;
  }
}

_id_9B15(var_0) {
  scripts\engine\utility::_id_5C1B("event_" + var_0 + "_completed");
}

_id_85C1(var_0) {
  return scripts\engine\utility::_id_5C00("event_" + var_0 + "_completed");
}

_id_1070B(var_0) {
  scripts\engine\utility::_id_5C24("event_" + var_0 + "_completed");
}

_id_6513(var_0) {
  return level._id_5693._id_C254[var_0]._id_7F8B;
}

_id_6785(var_0) {
  return level._id_5693._id_C254[var_0]._id_E5E6;
}

_id_6791(var_0) {
  return level._id_5693._id_C254[var_0]._id_E89C;
}

_id_648A(var_0) {
  return level._id_5693._id_C254[var_0]._id_96CF;
}

_id_1091B(var_0, var_1) {
  var_2 = _id_3C7D(var_1);
  var_3 = var_2 - var_0;
  wait(var_3);
  return var_0 + var_3;
}

_id_3C7D(var_0) {
  var_1 = strtok(var_0, ":");
  var_2 = int(var_1[0]);
  var_3 = int(var_1[1]);
  return 60 * var_2 + var_3;
}

_id_1073E(var_0) {
  var_1 = strtok(var_0, ",");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_1[0])) {
    var_2 = "event_" + var_1[0] + "_completed";
  }

  if(isDefined(var_1[1])) {
    var_3 = "event_" + var_1[1] + "_completed";
  }

  if(isDefined(var_1[2])) {
    var_4 = "event_" + var_1[2] + "_completed";
  }

  if(isDefined(var_1[3])) {
    var_5 = "event_" + var_1[3] + "_completed";
  }

  scripts\engine\utility::_id_5C25(var_2, var_3, var_4, var_5);
}

_id_4468(var_0) {
  if(getdvarint("#x330594e5ee086704", 0) != 0) {
    return;
  }
}

_id_448A() {
  wait 5;

  for(;;) {
    if(getdvarint("#x3e99fe03db4041b87", 0) == 0) {
      wait 3;
      continue;
    }

    var_0 = "";

    foreach(var_2 in level._id_5693._id_56BC) {
      if(istrue(level._id_5693._id_C254[var_2._id_C189]._id_0026)) {
        var_0 = var_0 + (", " + var_2._id_C958);
      }
    }

    if(isDefined(var_0) && var_0 != "") {
      _id_4468(var_0);
    }

    wait 0.5;
  }
}

_id_4494() {
  wait 3;

  for(;;) {
    if(getDvar("#x32e4cecf8320c2758", "") == "") {
      wait 3;
      continue;
    } else {
      var_0 = getDvar("#x32e4cecf8320c2758", "");
      var_1 = level._id_A8F6[var_0];

      if(!isDefined(var_1)) {
        _id_4468("Invalid Event Name: " + var_0);
        setDvar("#x32e4cecf8320c2758", "");
        continue;
      }

      if(_id_85C0(var_0)) {
        _id_4468(var_0 + " is active already");
        setDvar("#x32e4cecf8320c2758", "");
        continue;
      }

      _id_5E6E(var_0);
      setDvar("#x32e4cecf8320c2758", "");
    }
  }
}

_id_5E6E(var_0) {
  if(_id_85C0(var_0)) {
    return;
  }
  var_1 = level._id_A8F6[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  _id_9B14(var_0, 1);
  var_2 = _id_6513(var_0);

  if(isDefined(var_2)) {
    level[[var_2]](var_1);
  }

  _id_E5D5(var_0, "");
}

_id_449E() {
  wait 3;

  for(;;) {
    if(getDvar("#x3dcfe0dc67cc83989", "") == "") {
      wait 3;
      continue;
    } else {
      var_0 = getDvar("#x3dcfe0dc67cc83989", "");
      var_1 = level._id_A8F6[var_0];

      if(!isDefined(var_1)) {
        _id_4468("Invalid Event Name: " + var_0);
        setDvar("#x3dcfe0dc67cc83989", "");
        continue;
      }

      if(!_id_85C0(var_0)) {
        _id_4468(var_0 + " is not running");
        setDvar("#x3dcfe0dc67cc83989", "");
        continue;
      }

      _id_E892(var_0);
      setDvar("#x3dcfe0dc67cc83989", "");
    }
  }
}