/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1867.gsc
*************************************************/

init() {
  level._id_ACE9 = 0;
  level._id_ACD7 = [];
  level._id_ACEA = [];
  level thread _id_ACC4();
  level thread _id_ACF4();
  level thread _id_ACEB();
}

_id_ACD3(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0._id_ACFE)) {
    var_0._id_ACFE = [];
  }

  var_6 = spawnStruct();
  var_6._id_8800 = 0;
  var_6._id_BD27 = var_3;
  var_6._id_B7EB = var_1;
  var_6._id_B7EC = [];
  var_6._id_7B8A = var_2;
  var_6.type = var_4;

  if(var_4 == "TEAM") {
    var_6.team = var_5;
  }

  var_7 = _id_ACDC();
  var_0._id_ACFE[var_7] = var_6;
  _id_ACC2(var_0);
  var_8 = [];

  foreach(var_10 in var_6._id_B7EB) {
    if(!_id_31A6(var_10)) {
      var_6._id_B7EC[var_6._id_B7EC.size] = var_10;
      level._id_ACEA[var_7] = var_0;
      continue;
    }

    var_11 = _id_ACDD(var_0, var_10);

    if(!isDefined(var_11) || var_11 == var_6 || var_11._id_BD27 == var_6._id_BD27) {
      var_8[var_8.size] = var_10;
    }
  }

  if(var_8.size > 0) {
    var_0 _id_0C2C(var_8, var_6._id_7B8A);
  }

  return var_7;
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

_id_ACC4() {
  for(;;) {
    level waittill("connected", var_0);
    level thread _id_ACF1(var_0);
  }
}

_id_ACF1(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  _id_ACFD(var_0);
  _id_ACCC(var_0);
}

_id_ACF4() {
  for(;;) {
    level waittill("joined_team", var_0);

    if(!isDefined(var_0.team) || var_0.team == "spectator") {
      continue;
    }
    thread _id_ACF5(var_0);
  }
}

_id_ACF5(var_0) {
  var_0 notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_0 endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  _id_ACFD(var_0);
  _id_ACCC(var_0);
  _id_ACC1(var_0);
}

_id_ACFD(var_0) {
  level._id_ACD7 = scripts\engine\utility::_id_1BD1(level._id_ACD7);

  foreach(var_2 in level._id_ACD7) {
    var_3 = 0;

    foreach(var_5 in var_2._id_ACFE) {
      var_5._id_B7EB = scripts\engine\utility::_id_1BD1(var_5._id_B7EB);

      if(isDefined(var_0) && scripts\engine\utility::array_contains(var_5._id_B7EB, var_0)) {
        var_5._id_B7EB = scripts\engine\utility::array_remove(var_5._id_B7EB, var_0);
        var_3 = 1;
      }
    }

    if(var_3 && isDefined(var_2) && isDefined(var_0)) {
      var_2 _meth_81AE(var_0);
    }
  }
}

_id_ACC1(var_0) {
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

      if(isDefined(var_5)) {
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
  self _meth_81B1(var_0, var_1);
}

_id_0C2C(var_0, var_1) {
  self _meth_81B2(var_0, var_1);
}

_id_ACCF(var_0, var_1, var_2) {
  var_3 = level.players;
  var_4 = _id_ACF8(var_2);
  return _id_ACD3(var_0, var_3, var_1, var_4, "ALL");
}

_id_ACD2(var_0, var_1, var_2, var_3) {
  var_4 = _id_6DCA(var_1, "players");
  var_5 = _id_ACF8(var_3);
  return _id_ACD3(var_0, var_4, var_2, var_5, "TEAM", var_1);
}

outlineenableforplayer(var_0, var_1, var_2, var_3) {
  var_4 = _id_ACF8(var_3);

  if(isagent(var_1)) {
    return _id_ACDC();
  }

  return _id_ACD3(var_0, [var_1], var_2, var_4, "ENTITY");
}

outlinedisable(var_0, var_1) {
  _id_ACCB(var_0, var_1);
}

_id_ACF9(var_0) {
  _id_ACFA(var_0);
}

_id_824E() {
  level._id_ACEE = [];
  level._id_ACEF = 0;
}

_id_110A(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_033E = var_0;
  var_2._id_0359 = var_1;
  var_3 = level._id_ACEF;
  level._id_ACEE[var_3] = var_2;
  level._id_ACEF++;
  return var_3;
}

_id_C4FA(var_0) {
  level._id_ACEE[var_0] = undefined;
}

_id_ACED(var_0, var_1) {
  foreach(var_3 in level._id_ACEE) {
    if(!isDefined(var_3) || !isDefined(var_3._id_033E) || !isDefined(var_3._id_0359)) {
      continue;
    }
    if(scripts\engine\math::_id_D031(var_0, var_1, var_3._id_033E, var_3._id_0359)) {
      return 1;
    }
  }

  return 0;
}

_id_0C2D() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self _meth_81B4();
}

_id_0C2E(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1 && !scripts\cp_mp\utility\player_utility::_isalive()) {}

  if(var_1 && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread _id_7B8F(var_0);
    return;
  }

  self _meth_81B3(var_0);
}

_id_7B8F(var_0) {
  level endon("game_ended");
  self waittill("spawned");

  if(!isDefined(self)) {
    return;
  }
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self _meth_81B3(var_0);
}

_id_6DCA(var_0, var_1) {
  return level._id_EF6A[var_0][var_1];
}