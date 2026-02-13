/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1947.gsc
*************************************************/

init() {
  level._id_0F63 = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerOnPlayerSpawnCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerOnPlayerSpawnCallback")]](::_id_EED8);
  }
}

_id_EEDF(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(level._id_0F63.size >= 50) {
    return;
  }
  if(_id_EED9(var_3) >= 2) {
    return;
  }
  var_7 = _func_0366(var_0);

  if(_id_EEE7(var_7)) {
    return;
  }
  _id_1142(var_7, var_1, var_2, var_3, var_4, var_5, var_6);
  return var_7;
}

_id_EEDE(var_0) {
  if(!_id_EEE7(var_0)) {
    return;
  }
  _id_C52F(var_0);
  _func_0367(var_0);
}

_id_1142(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7._id_9B52 = var_0;
  var_7._id_9B55 = var_3;
  var_7._id_5FB7 = var_4;
  var_7._id_DCCC = [];
  var_7._id_DCCD = [];
  var_7._id_9B3A = [];
  var_7._id_9B3B = [];
  level._id_0F63[level._id_0F63.size] = var_7;
  level thread _id_EEDA(var_7, var_0);

  if(isDefined(var_1)) {
    if(_func_0107(var_1)) {
      foreach(var_9 in var_1) {
        if(isPlayer(var_9)) {
          var_7._id_DCCC[var_7._id_DCCC.size] = var_9;
          _func_036C(var_0, var_9);
          continue;
        }

        if(_id_8A91(var_9)) {
          var_7._id_DCCD[var_7._id_DCCD.size] = var_9;
          _func_036D(var_0, var_9);
        }
      }
    } else if(isPlayer(var_1)) {
      var_7._id_DCCC[var_7._id_DCCC.size] = var_1;
      _func_036C(var_0, var_1);
    } else if(_id_8A91(var_1)) {
      var_7._id_DCCD[var_7._id_DCCD.size] = var_1;
      _func_036D(var_0, var_1);
    }
  }

  if(isDefined(var_2)) {
    if(_func_0107(var_2)) {
      foreach(var_12 in var_2) {
        _id_EEDC(var_12, var_0, var_6);
      }
    } else
      _id_EEDC(var_2, var_0, var_6);
  }

  if(istrue(var_5)) {
    level thread _id_EEE6(var_0, var_6);
  }

  if(istrue(var_6)) {
    level thread _id_EEE3(var_0);
    level thread _id_EEE4(var_0);
  }
}

_id_C52F(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in level._id_0F63) {
    if(var_4._id_9B52 == var_0) {
      var_1 = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  if(isDefined(var_1)) {
    var_1 = undefined;
  }

  level._id_0F63 = var_2;
  level notify("removed_targetMarkerGroup_" + var_0);
}

_id_EEE7(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_0F63) {
    if(var_3._id_9B52 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_6DBF(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_0F63) {
    if(var_3._id_9B52 == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_EEE6(var_0, var_1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var_0);

  for(;;) {
    level waittill("player_spawned", var_2);

    if(_id_314A(var_0, var_2)) {
      _id_EEDC(var_2, var_0, var_1);
    }
  }
}

_id_EEE4(var_0) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var_0);

  for(;;) {
    level waittill("unset_noscopeoutline", var_1);

    if(_id_314A(var_0, var_1)) {
      _id_EEDC(var_1, var_0);
    }
  }
}

_id_EEE3(var_0) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var_0);

  for(;;) {
    level waittill("set_noscopeoutline", var_1);

    if(_id_314A(var_0, var_1)) {
      var_2 = var_1 getentitynumber();
      _id_EEE2(var_1, var_2, var_0);
    }
  }
}

_id_EEDC(var_0, var_1, var_2) {
  var_3 = _id_6DBF(var_1);
  var_4 = var_0 getentitynumber();

  if(var_3._id_9B3A.size >= 20) {
    var_0 _id_EED7(var_3, var_1);
    return;
  }

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(istrue(var_2)) {
      var_5 = var_3._id_9B55;
      var_6 = isDefined(var_3._id_5FB7);
      var_7 = istrue(var_3._id_5FB7);

      if(var_6) {
        if(!var_7) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
            if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
              return;
            }
          }
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          return;
        }
      }
    }
  }

  if(!isDefined(var_3._id_9B3A[var_4])) {
    var_3._id_9B3A[var_4] = 1;
    _func_0368(var_1, var_0);

    if(isPlayer(var_0)) {
      var_0 thread _id_EEE0("death", var_3);
      var_0 thread _id_EEE0("disconnect", var_3);
      var_0 thread _id_EEE0("joined_team", var_3);
    } else
      var_0 thread _id_EEE0("death", var_3);
  }
}

_id_EEE0(var_0, var_1) {
  var_2 = self getentitynumber();
  var_1 endon("ent_removed_" + var_2);
  level endon("removed_targetMarkerGroup_" + var_1._id_9B52);
  self waittill(var_0);
  _id_EEE2(self, var_2, var_1._id_9B52);
}

_id_EED7(var_0, var_1) {
  if(!_id_EEE7(var_1)) {
    return;
  }
  var_0._id_9B3B[var_0._id_9B3B.size] = self;
  thread _id_EEDB(var_0, var_1);
}

_id_EEDB(var_0, var_1) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + var_1);
  self waittill("disconnect");
  _id_EEE1(var_0, var_1);
}

_id_EEE1(var_0, var_1) {
  if(!_id_EEE7(var_1)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in var_0._id_9B3B) {
    if(var_4 == self) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  var_0._id_9B3B = var_2;
}

_id_EEDA(var_0, var_1) {
  level endon("game_ended");
  level endon("removed_targetMarkerGroup_" + var_1);

  while(_id_EEE7(var_1)) {
    level waittill("ent_removed_from_marker_group", var_2);

    if(var_2 != var_0) {
      continue;
    }
    if(var_0._id_9B3B.size == 0) {
      continue;
    }
    var_3 = undefined;

    if(!isDefined(var_0._id_9B3B[0])) {
      continue;
    } else {
      var_3 = var_0._id_9B3B[0];
    }

    var_4 = var_3 getentitynumber();

    if(!isDefined(var_0._id_9B3A[var_4])) {
      var_0._id_9B3A[var_4] = 1;
      var_3 _id_EEE1(var_0, var_1);
      _id_EEDC(var_3, var_1);
    }
  }
}

_id_EEE2(var_0, var_1, var_2) {
  var_3 = _id_6DBF(var_2);

  if(isDefined(var_3) && isDefined(var_3._id_9B3A[var_1])) {
    var_3._id_9B3A[var_1] = undefined;

    if(isDefined(var_0)) {
      _func_0369(var_2, var_0);
    }

    var_3 notify("ent_removed_" + var_1);
    level notify("ent_removed_from_marker_group", var_3);
  }
}

_id_EED9(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_0F63) {
    if(var_3._id_9B55 == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_EED8() {
  self setclientomnvar("ui_clear_target_markers", gettime());
}

_id_8A91(var_0) {
  if(var_0 == "spectator") {
    return 1;
  }

  foreach(var_2 in level._id_EF89) {
    if(var_0 == var_2) {
      return 1;
    }
  }

  return 0;
}

_id_314A(var_0, var_1) {
  var_2 = 0;
  var_3 = _id_6DBF(var_0);
  var_4 = var_3._id_9B55;
  var_5 = istrue(level.teambased) && isDefined(var_3._id_5FB7);
  var_6 = istrue(var_3._id_5FB7);

  if(!isDefined(var_4)) {
    return var_2;
  }

  if(var_5) {
    if(var_6) {
      if(var_1.team == var_4.team) {
        var_2 = 1;
      }
    } else if(var_1.team != var_4.team)
      var_2 = 1;
  } else if(var_6) {
    if(isPlayer(var_1) && var_1 == var_4) {
      var_2 = 1;
    }
  } else
    var_2 = 1;

  return var_2;
}