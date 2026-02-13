/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2043.gsc
*************************************************/

init() {
  level._id_ACE9 = 0;
  level._id_ACD7 = [];
  level._id_ACEA = [];
  _id_0A8E::_id_C285(::_id_ACF1);
  _id_0A97::_id_C28A(::_id_ACF4);
  _id_0A96::_id_C289(::_id_ACF2);
  level thread _id_ACEB();
}

_id_ACD3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0._id_ACFE)) {
    var_0._id_ACFE = [];
  }

  var_7 = spawnStruct();
  var_7._id_8800 = 0;
  var_7._id_BD27 = var_3;
  var_7._id_B7EB = var_1;
  var_7._id_B7EC = [];
  var_7._id_7B8A = var_2;
  var_7.type = var_4;
  var_7.team = var_5;
  var_7._id_E496 = var_6;
  var_8 = _id_ACDC();
  var_0._id_ACFE[var_8] = var_7;
  _id_ACC2(var_0);
  var_9 = [];

  foreach(var_11 in var_7._id_B7EB) {
    if(!_id_31A6(var_11)) {
      var_7._id_B7EC[var_7._id_B7EC.size] = var_11;
      level._id_ACEA[var_8] = var_0;
      continue;
    }

    var_12 = _id_ACDD(var_0, var_11);

    if(!isDefined(var_12) || var_12 == var_7 || var_12._id_BD27 == var_7._id_BD27) {
      var_9[var_9.size] = var_11;
    }
  }

  if(var_9.size > 0) {
    var_0 _id_0C2C(var_9, var_7._id_7B8A);
  }

  return var_8;
}

_id_ACCB(var_0, var_1) {
  if(!isDefined(var_1)) {
    level._id_ACD7 = scripts\engine\utility::_id_1BD1(level._id_ACD7);
    return;
  } else if(!isDefined(var_1._id_ACFE)) {
    _id_ACFC(var_1);
    return;
  }

  var_2 = var_1._id_ACFE[var_0];

  if(!isDefined(var_2) || var_2._id_8800) {
    return;
  }
  var_2._id_8800 = 1;

  foreach(var_4 in var_2._id_B7EB) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!_id_31A6(var_4)) {
      var_2._id_B7EC[var_2._id_B7EC.size] = var_4;
      level._id_ACEA[var_0] = var_1;
      continue;
    }

    var_5 = _id_ACDD(var_1, var_4);

    if(isDefined(var_5)) {
      if(var_5._id_BD27 <= var_2._id_BD27) {
        var_1 _id_0C2B(var_4, var_5._id_7B8A);
      }

      continue;
    }

    var_1 _meth_81AE(var_4);
  }

  if(var_2._id_B7EC.size == 0) {
    var_1._id_ACFE[var_0] = undefined;

    if(var_1._id_ACFE.size == 0) {
      _id_ACFC(var_1);
    }
  }
}

_id_ACFA(var_0) {
  if(!isDefined(var_0._id_ACFE) || var_0._id_ACFE.size == 0) {
    return;
  }
  foreach(var_7, var_2 in var_0._id_ACFE) {
    if(!isDefined(var_2) || var_2._id_8800) {
      continue;
    }
    foreach(var_4 in var_2._id_B7EB) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = _id_ACDD(var_0, var_4);

      if(isDefined(var_5)) {
        var_0 _id_0C2B(var_4, var_5._id_7B8A);
      }
    }
  }
}

_id_ACF1(var_0) {
  _id_ACFD(var_0);
  _id_ACCC(var_0);
}

_id_ACF4(var_0) {
  if(!isDefined(var_0.team) || var_0.team == "spectator" || var_0.team == "follower") {
    return;
  }
  thread _id_ACF5(var_0);
}

_id_ACF5(var_0) {
  var_0 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_0 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  _id_ACFD(var_0);
  _id_ACCC(var_0);
  _id_ACBF(var_0);
}

_id_ACF2(var_0) {
  thread _id_ACF3(var_0);
}

_id_ACF3(var_0) {
  var_0 notify("outlineOnPlayerJoinedSquad_onFirstSpawn");
  var_0 endon("outlineOnPlayerJoinedSquad_onFirstSpawn");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  _id_ACFD(var_0, 1);
  _id_ACC0(var_0);
}

_id_ACFD(var_0, var_1) {
  level._id_ACD7 = scripts\engine\utility::_id_1BD1(level._id_ACD7);

  foreach(var_3 in level._id_ACD7) {
    var_4 = 0;

    foreach(var_6 in var_3._id_ACFE) {
      if(istrue(var_1)) {
        if(var_6.type != "SQUAD") {
          continue;
        }
      }

      var_6._id_B7EB = scripts\engine\utility::_id_1BD1(var_6._id_B7EB);

      if(isDefined(var_0)) {
        if(scripts\engine\utility::array_contains(var_6._id_B7EB, var_0)) {
          var_6._id_B7EB = scripts\engine\utility::array_remove(var_6._id_B7EB, var_0);
          var_4 = 1;
        }

        if(scripts\engine\utility::array_contains(var_6._id_B7EC, var_0)) {
          var_6._id_B7EC = scripts\engine\utility::array_remove(var_6._id_B7EC, var_0);
        }
      }
    }

    if(var_4 && isDefined(var_3) && isDefined(var_0)) {
      var_3 _meth_81AE(var_0);
    }
  }
}

_id_ACBF(var_0) {
  foreach(var_2 in level._id_ACD7) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = undefined;

    foreach(var_5 in var_2._id_ACFE) {
      if(var_5.type == "ALL" || var_5.type == "TEAM" && var_5.team == var_0.team) {
        if(!scripts\engine\utility::array_contains(var_5._id_B7EB, var_0)) {
          var_5._id_B7EB[var_5._id_B7EB.size] = var_0;
        } else {}

        if(!isDefined(var_3) || var_5._id_BD27 > var_3._id_BD27) {
          var_3 = var_5;
        }
      }
    }

    if(isDefined(var_3)) {
      var_2 _id_0C2B(var_0, var_3._id_7B8A);
    }
  }
}

_id_ACC0(var_0) {
  if(!isDefined(var_0._id_E496)) {}

  foreach(var_2 in level._id_ACD7) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = undefined;

    foreach(var_5 in var_2._id_ACFE) {
      if(var_5.type == "SQUAD" && var_5.team == var_0.team && isDefined(var_5._id_E496) && var_5._id_E496 == var_0._id_E496) {
        if(!scripts\engine\utility::array_contains(var_5._id_B7EB, var_0)) {
          var_5._id_B7EB[var_5._id_B7EB.size] = var_0;
        } else {}

        if(!isDefined(var_3) || var_5._id_BD27 > var_3._id_BD27) {
          var_3 = var_5;
        }
      }
    }

    if(isDefined(var_3)) {
      var_2 _id_0C2B(var_0, var_3._id_7B8A);
    }
  }
}

_id_ACCC(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_ACFE) || var_0._id_ACFE.size == 0) {
    return;
  }
  foreach(var_3, var_2 in var_0._id_ACFE) {
    _id_ACCB(var_3, var_0);
  }
}

_id_ACC2(var_0) {
  if(!scripts\engine\utility::array_contains(level._id_ACD7, var_0)) {
    level._id_ACD7[level._id_ACD7.size] = var_0;
  }
}

_id_ACFC(var_0) {
  level._id_ACD7 = scripts\engine\utility::array_remove(level._id_ACD7, var_0);
}

_id_ACDE(var_0) {
  var_1 = -1;

  if(!isDefined(var_0._id_ACFE) || var_0.size == 0) {
    return var_1;
  }

  var_2 = undefined;

  foreach(var_5, var_4 in var_0._id_ACFE) {
    if(!isDefined(var_4) || var_4._id_8800) {
      continue;
    }
    if(!isDefined(var_2) || var_4._id_BD27 > var_2._id_BD27) {
      var_2 = var_4;
      var_1 = var_5;
    }
  }

  return var_1;
}

_id_ACDD(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0._id_ACFE) || var_0.size == 0) {
    return var_2;
  }

  foreach(var_5, var_4 in var_0._id_ACFE) {
    if(!isDefined(var_4) || var_4._id_8800) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_4._id_B7EB, var_1) && (!isDefined(var_2) || var_4._id_BD27 > var_2._id_BD27)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

_id_ACDC() {
  level._id_ACE9++;
  return level._id_ACE9;
}

_id_ACF8(var_0) {
  var_0 = tolower(var_0);
  var_1 = undefined;

  switch (var_0) {
    case "lowest":
      var_1 = 0;
      break;
    case "level_script":
      var_1 = 1;
      break;
    case "equipment":
      var_1 = 2;
      break;
    case "perk":
      var_1 = 3;
      break;
    case "perk_superior":
      var_1 = 4;
      break;
    case "killstreak":
      var_1 = 5;
      break;
    case "killstreak_personal":
      var_1 = 6;
      break;
    case "laststand":
      var_1 = 7;
      break;
    case "top":
      var_1 = 8;
      break;
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}

_id_ACE6() {
  foreach(var_3, var_1 in level._id_ACEA) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1._id_ACFE)) {
      continue;
    }
    var_2 = var_1._id_ACFE[var_3];

    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2._id_B7EC.size > 0) {
      if(_id_ACFB(var_1, var_3)) {
        level._id_ACEA[var_3] = undefined;
      }
    }
  }
}

_id_ACEB() {
  for(;;) {
    waittillframeend;
    _id_ACE6();
    waitframe();
  }
}

_id_ACFB(var_0, var_1) {
  var_2 = var_0._id_ACFE[var_1];

  foreach(var_6, var_4 in var_2._id_B7EC) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(_id_31A6(var_4)) {
      var_5 = _id_ACDD(var_0, var_4);

      if(isDefined(var_5) && var_5._id_7B8A != "invisible") {
        var_0 _meth_81B1(var_4, var_5._id_7B8A);
      } else {
        var_0 _meth_81AE(var_4);
      }

      var_2._id_B7EC[var_6] = undefined;
    }
  }

  var_2._id_B7EC = scripts\engine\utility::_id_1BD1(var_2._id_B7EC);

  if(var_2._id_B7EC.size == 0) {
    if(var_2._id_8800) {
      var_0._id_ACFE[var_1] = undefined;
    }

    if(var_0._id_ACFE.size == 0) {
      _id_ACFC(var_0);
    }

    return 1;
  }

  return 0;
}

_id_31A6(var_0) {
  return var_0.sessionstate != "spectator";
}

_id_0C2B(var_0, var_1) {
  if(var_1 == "invisible") {
    self _meth_81AE(var_0);
  } else {
    self _meth_81B1(var_0, var_1);
  }
}

_id_0C2C(var_0, var_1) {
  if(var_1 == "invisible") {
    self _meth_81AF(var_0);
  } else {
    self _meth_81B2(var_0, var_1);
  }
}