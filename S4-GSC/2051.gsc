/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2051.gsc
*************************************************/

init() {
  if(!level.onlinestatsenabled) {
    return;
  }
  level._id_B7E2 = spawnStruct();
  var_0 = level._id_B7E2;
  var_0._id_E762 = [];
  var_0._id_4AAC = [];
  var_0._id_523F = 1;
  var_0._id_035F = 0;
  var_0._id_C04A = [];
  var_0._id_C049 = [];
  var_0._id_4AA6 = [];
  _id_0804::_id_C29D(["combatStats", "kdRatio"], ["combatStats", "kills"], ["combatStats", "deaths"]);
  _id_0804::_id_C29D(["combatStats", "accuracy"], ["combatStats", "hits"], ["combatStats", "totalShots"]);
  _id_0804::_id_C29D(["matchStats", "winLossRatio"], ["matchStats", "wins"], ["matchStats", "losses"]);
  _id_1171("kdr", "combatStats", "kills");
  _id_1171("kdr", "combatStats", "deaths");
  _id_1171("kdr", "combatStats", "kdRatio");
  _id_1171("winLoss", "matchStats", "wins");
  _id_1171("winLoss", "matchStats", "losses");
  _id_1171("winLoss", "matchStats", "winLossRatio");
  _id_1171("winLoss", "matchStats", "winStreak");
  _id_1171("winLoss", "matchStats", "ties");
  _id_1171("losses", "matchStats", "losses");
}

_id_825B() {
  if(!level.onlinestatsenabled) {
    return;
  }
  if(isDefined(self.pers["playerstats"])) {
    self._id_B7E2 = self.pers["playerstats"];
  } else {
    self._id_B7E2 = spawnStruct();
    var_0 = self._id_B7E2;
    self._id_B7E2._id_FF6E = [];
    self._id_B7E2._id_AEE4 = [];
    self._id_B7E2._id_2CA1 = [];
  }

  if(!scripts\mp\utility\game::_id_CA4B()) {
    thread _id_2CA3();
  }
}

_id_2CA3() {
  self endon("disconnect");

  while(!_id_07D1::_id_9351("game_over")) {
    _id_10FC3();
    wait 2.0;
  }

  _id_10FC3();
}

_id_10FC3() {
  if(isai(self)) {
    return;
  }
  foreach(var_4, var_1 in self._id_B7E2._id_2CA1) {
    var_2 = self._id_B7E2._id_AEE4[var_4];
    var_3 = self._id_B7E2._id_FF6E[var_4];
    _id_10FC9(var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
  }

  self._id_B7E2._id_2CA1 = [];
}

_id_6C65(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "";

  if(isDefined(var_4)) {
    var_5 = var_0 + "." + var_1 + "." + var_2 + "." + var_3 + "." + var_4;
  } else if(isDefined(var_3)) {
    var_5 = var_0 + "." + var_1 + "." + var_2 + "." + var_3;
  } else if(isDefined(var_2)) {
    var_5 = var_0 + "." + var_1 + "." + var_2;
  } else if(isDefined(var_1)) {
    var_5 = var_0 + "." + var_1;
  } else if(isDefined(var_0)) {
    var_5 = var_0;
  }

  return var_5;
}

_id_10FC9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    self setplayerdata(level.progressiongroup, "playerStats", var_1, var_2, var_3, var_4, var_5, var_0);
  } else if(isDefined(var_4)) {
    self setplayerdata(level.progressiongroup, "playerStats", var_1, var_2, var_3, var_4, var_0);
  } else if(isDefined(var_3)) {
    self setplayerdata(level.progressiongroup, "playerStats", var_1, var_2, var_3, var_0);
  } else if(isDefined(var_2)) {
    self setplayerdata(level.progressiongroup, "playerStats", var_1, var_2, var_0);
  } else if(isDefined(var_1)) {
    self setplayerdata(level.progressiongroup, "playerStats", var_1, var_0);
  }
}

_id_C0A6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    return self getplayerdata(level.progressiongroup, "playerStats", var_0, var_1, var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    return self getplayerdata(level.progressiongroup, "playerStats", var_0, var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    return self getplayerdata(level.progressiongroup, "playerStats", var_0, var_1, var_2);
  } else if(isDefined(var_1)) {
    return self getplayerdata(level.progressiongroup, "playerStats", var_0, var_1);
  } else if(isDefined(var_0)) {
    return self getplayerdata(level.progressiongroup, "playerStats", var_0);
  }
}

_id_5C48(var_0) {
  var_1 = level._id_B7E2;

  if(_id_07D1::_id_9351("game_over")) {
    var_2 = self._id_B7E2._id_AEE4[var_0];
    var_3 = self._id_B7E2._id_FF6E[var_0];
    _id_10FC9(var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
    return;
  }

  self._id_B7E2._id_2CA1[var_0] = 1;
}

_id_D673(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [var_2];
  var_7[var_7.size] = var_3;
  var_7[var_7.size] = var_4;
  var_7[var_7.size] = var_5;
  var_7[var_7.size] = var_6;
  self._id_B7E2._id_FF6E[var_1] = var_0;
  self._id_B7E2._id_AEE4[var_1] = var_7;
}

_id_116B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [var_2];
  var_7[var_7.size] = var_3;
  var_7[var_7.size] = var_4;
  var_7[var_7.size] = var_5;
  var_7[var_7.size] = var_6;

  if(!isDefined(self._id_B7E2._id_AEE4[var_1])) {
    var_8 = _id_C0A6(var_2, var_3, var_4, var_5, var_6);
    self._id_B7E2._id_FF6E[var_1] = var_8 + var_0;
    self._id_B7E2._id_AEE4[var_1] = var_7;
  } else
    self._id_B7E2._id_FF6E[var_1] = self._id_B7E2._id_FF6E[var_1] + var_0;
}

_id_A00E(var_0, var_1) {
  var_2 = level._id_B7E2;

  if(var_1) {
    var_2._id_4AAC[var_0]--;

    if(var_2._id_4AAC[var_0] <= 0) {
      var_2._id_4AAC[var_0] = undefined;
    }
  } else if(!isDefined(var_2._id_4AAC[var_0]))
    var_2._id_4AAC[var_0] = 1;
  else {
    var_2._id_4AAC[var_0]++;
  }
}

_id_8A64(var_0) {
  return !_id_0804::_id_1B0B() && !isDefined(level._id_B7E2._id_4AAC[var_0]);
}

_id_1171(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_B7E2;
  var_7 = _id_6C65(var_1, var_2, var_3, var_4, var_5);

  if(!isDefined(var_6._id_E762[var_0])) {
    var_6._id_E762[var_0] = [];
  }

  var_6._id_E762[var_0][var_6._id_E762[var_0].size] = var_7;
}

_id_A00D(var_0, var_1) {
  var_2 = level._id_B7E2;

  foreach(var_4 in var_2._id_E762[var_0]) {
    _id_A00E(var_4, var_1);
  }
}

_id_2EF2(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_0804::_id_1B0A()) {
    return undefined;
  }

  var_5 = level._id_B7E2;
  var_6 = _id_6C65(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_5._id_C04A[var_6])) {}

  if(!_id_8A64(var_6)) {
    return;
  }
  var_7 = var_5._id_C04A[var_6]["numerator"];
  var_8 = var_5._id_C04A[var_6]["denominator"];
  var_9 = _id_0804::_id_6C64(var_7[0], var_7[1], var_7[2], var_7[3], var_7[4]);
  var_10 = _id_0804::_id_6C64(var_8[0], var_8[1], var_8[2], var_8[3], var_8[4]);

  if(var_10 == 0) {
    var_10 = 1;
  }

  return var_9 / var_10;
}

_id_FD03(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_2EF2(var_0, var_1, var_2, var_3, var_4);
  _id_0804::_id_D672(var_5, var_0, var_1, var_2, var_3, var_4);
}

_id_FD04(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_2EF2(var_0, var_1, var_2, var_3, var_4);
  _id_0804::_id_D674(var_5, var_0, var_1, var_2, var_3, var_4);
}

_id_FCE9(var_0) {
  var_1 = level._id_B7E2;

  if(!isDefined(var_1._id_C049[var_0])) {
    return;
  }
  foreach(var_3 in var_1._id_C049[var_0]) {
    _id_FD03(var_3[0], var_3[1], var_3[2], var_3[3], var_3[4]);
  }
}

_id_FCEA(var_0) {
  var_1 = level._id_B7E2;

  if(!isDefined(var_1._id_C049[var_0])) {
    return;
  }
  foreach(var_3 in var_1._id_C049[var_0]) {
    _id_FD04(var_3[0], var_3[1], var_3[2], var_3[3], var_3[4]);
  }
}