/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2715.gsc
*************************************************/

_id_ACCF(var_0, var_1, var_2) {
  var_3 = level.players;
  var_4 = _id_07FB::_id_ACF8(var_2);
  return _id_07FB::_id_ACD3(var_0, var_3, var_1, var_4, "ALL");
}

_id_ACD2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");

  if(isDefined(var_4) && isDefined(var_4.team) && var_4.team == var_1) {
    var_5 = scripts\engine\utility::array_remove(var_5, var_4);
  }

  var_6 = _id_07FB::_id_ACF8(var_3);
  return _id_07FB::_id_ACD3(var_0, var_5, var_2, var_6, "TEAM", var_1);
}

outlineenableforteam_vehicle(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");

  if(isDefined(var_4) && _func_0107(var_4) && var_4.size > 0) {
    foreach(var_7 in var_4) {
      if(isDefined(var_7.team) && var_7.team == var_1) {
        var_5 = scripts\engine\utility::array_remove(var_5, var_7);
      }
    }
  }

  var_9 = _id_07FB::_id_ACF8(var_3);
  return _id_07FB::_id_ACD3(var_0, var_5, var_2, var_9, "TEAM", var_1);
}

_id_ACD1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level._id_E48E[self.team][self._id_E496].players;
  var_6 = _id_07FB::_id_ACF8(var_4);
  return _id_07FB::_id_ACD3(var_0, var_5, var_3, var_6, "SQUAD", var_1, var_2);
}

outlineenableforplayer(var_0, var_1, var_2, var_3) {
  var_4 = _id_07FB::_id_ACF8(var_3);

  if(isagent(var_1)) {
    return _id_07FB::_id_ACDC();
  }

  return _id_07FB::_id_ACD3(var_0, [var_1], var_2, var_4, "ENTITY");
}

outlinedisable(var_0, var_1) {
  _id_07FB::_id_ACCB(var_0, var_1);
}

_id_ACF9(var_0) {
  _id_07FB::_id_ACFA(var_0);
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

  if(!isPlayer(self)) {}

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
  if(!isPlayer(self)) {
    return;
  }
  self _meth_81B3(var_0);
}