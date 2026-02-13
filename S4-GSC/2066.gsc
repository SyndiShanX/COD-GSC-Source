/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2066.gsc
*************************************************/

init() {
  _func_004D("Tactical_Static");
  _func_004D("Tactical_Moving");
  _func_004D("Lethal_Static");
  _func_004D("Lethal_Moving");
  _func_004D("Level_Vehicle");
  _func_004D("Killstreak_Static");
  _func_004D("Killstreak_Air");
  _func_004D("Killstreak_Ground");
  _func_01DB("Killstreak_Ground", "Killstreak_Ground");
  _func_01DB("Killstreak_Air", "Killstreak_Ground");
  _func_01DB("Killstreak_Air", "Killstreak_Air");
  _func_01DB("Killstreak_Ground", "Killstreak_Air");
  level._id_D0CC = [];
  level._id_D0CC[level._id_D0CC.size] = "Tactical_Static";
  level._id_D0CC[level._id_D0CC.size] = "Tactical_Moving";
  level._id_D0CC[level._id_D0CC.size] = "Lethal_Static";
  level._id_D0CC[level._id_D0CC.size] = "Lethal_Moving";
  level._id_D0CC[level._id_D0CC.size] = "Level_Vehicle";
  level._id_D0CC[level._id_D0CC.size] = "Killstreak_Static";
  level._id_D0CC[level._id_D0CC.size] = "Killstreak_Air";
  level._id_D0CC[level._id_D0CC.size] = "Killstreak_Ground";
  level._id_0F5C = [];

  for(var_0 = 0; var_0 < level._id_D0CC.size; var_0++) {
    level._id_0F5C[level._id_D0CC[var_0]] = [];
  }
}

_id_C2B2(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = -1;

  for(var_7 = 0; var_7 < level._id_D0CC.size; var_7++) {
    if(level._id_D0CC[var_7] == var_0) {
      var_6 = var_7;
      break;
    }
  }

  if(var_6 == -1) {
    return;
  }
  if(isDefined(self._id_D0CA)) {
    return;
  }
  var_8 = _func_03F3();
  var_9 = _func_03F4();

  if(var_8["other"] + var_8["expendable"] >= var_9["other"]) {
    var_10 = level _id_C479(var_6);

    if(!var_10) {
      return;
    }
  }

  self._id_D0CA = var_0;
  self._id_D0C8 = gettime();
  self._id_D0CB = self getentitynumber();
  var_11 = undefined;

  if(_func_0121(var_1)) {
    var_11 = var_1;
  } else if(isPlayer(var_1)) {
    var_11 = var_1.team;
  }

  var_12 = undefined;

  if(isDefined(var_11) && !isagent(self)) {
    var_12 = self _meth_8220(var_11, undefined, var_4, var_5);
  }

  if(istrue(var_12)) {
    self _meth_8390(var_0);

    if(istrue(var_2)) {
      self _meth_821F();
    }

    level._id_0F5C[var_0][self._id_D0CB] = self;
    thread _id_A13A(var_3);
  }
}

_id_A13A(var_0) {
  level endon("game_ended");
  var_1 = self._id_D0CA;
  var_2 = self._id_D0CB;

  if(isDefined(var_0)) {
    scripts\engine\utility::waittill_any_3("death", "remove_sentient", var_0);
  } else {
    scripts\engine\utility::_id_108C5("death", "remove_sentient");
  }

  _id_F9A3(var_1, var_2);
}

_id_C479(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 <= var_0; var_2++) {
    var_1 = _id_6914(level._id_D0CC[var_2]);

    if(isDefined(var_1)) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  var_1 _id_F9A3(var_1._id_D0CA, var_1._id_D0CB);
  return 1;
}

_id_6914(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_0F5C[var_0]) {
    if(!isDefined(var_2) || var_4._id_D0C8 < var_2) {
      var_2 = var_4._id_D0C8;
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_F9A3(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level._id_0F5C[var_0][var_1] = undefined;

  if(isDefined(self)) {
    self._id_D0CA = undefined;
    self._id_D0CB = undefined;

    if(!isagent(self)) {
      self _meth_8100();
    }
  }
}