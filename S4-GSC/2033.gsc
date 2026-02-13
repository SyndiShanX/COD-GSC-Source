/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2033.gsc
*************************************************/

init() {
  if(!level.rankedmatch) {
    return;
  }
  level.matchstats = spawnStruct();
  level.matchstats._id_4362 = 0;
  _id_9616();
  thread _id_10BD4();
  thread _id_10B64();
  level.matchstats._id_523F = 1;
}

_id_9616() {
  var_0 = tablelookuprownum("mp/gameModeMatchStats.csv", 0, level.gametype);
  var_1 = level.matchstats;

  if(!isDefined(var_0) || var_0 < 0) {
    var_1._id_9FF3 = 0;
    return;
  }

  var_1._id_9FF3 = 1;
  var_1._id_9FF2 = [];

  for(var_2 = 1; var_2 < 7; var_2++) {
    var_3 = tablelookupbyrow("mp/gameModeMatchStats.csv", var_0, var_2);

    if(!isDefined(var_3) || var_3 == "") {
      continue;
    }
    var_1._id_9FF2[var_3] = var_2 - 1;
  }
}

_id_10BD4() {
  for(;;) {
    level waittill("connected", var_0);

    if(isai(var_0)) {
      continue;
    }
    var_0 thread _id_825B();
  }
}

_id_825B() {
  if(isDefined(self.pers["matchstats"])) {
    self.matchstats = self.pers["matchstats"];
  } else {
    self.matchstats = spawnStruct();
    var_0 = self.matchstats;
    self.matchstats._id_FF6E = [];
    self.matchstats._id_AEE4 = [];
  }
}

_id_10B64() {
  _id_07D1::_id_9356("game_over");
  var_0 = level.players;

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 _id_10FC7();
    waitframe();
  }

  level.matchstats._id_4362 = 1;
}

_id_10FC7() {
  var_0 = self.matchstats;

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_4, var_2 in var_0._id_FF6E) {
    var_3 = var_0._id_AEE4[var_4];

    switch (var_3.size) {
      case 1:
        self setplayerdata(level.progressiongroup, "matchStats", var_3[0], var_2);
        break;
      case 2:
        self setplayerdata(level.progressiongroup, "matchStats", var_3[0], var_3[1], var_2);
        break;
      case 3:
        self setplayerdata(level.progressiongroup, "matchStats", var_3[0], var_3[1], var_3[2], var_2);
        break;
      case 4:
        self setplayerdata(level.progressiongroup, "matchStats", var_3[0], var_3[1], var_3[2], var_3[3], var_2);
        break;
      case 5:
        self setplayerdata(level.progressiongroup, "matchStats", var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_2);
        break;
    }
  }
}

_id_6B37(var_0) {
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2])) {
      var_1 = var_1 + (var_0[var_2] + ".");
    }
  }

  return var_1;
}

_id_D5F5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!_id_1A5B()) {
    return;
  }
  var_6 = [var_1];

  if(isDefined(var_2)) {
    var_6[var_6.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6[var_6.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6[var_6.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6[var_6.size] = var_5;
  }

  var_7 = _id_6B37(var_6);
  self.matchstats._id_FF6E[var_7] = var_0;
  self.matchstats._id_AEE4[var_7] = var_6;
}

_id_1164(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!_id_1A5B()) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_6 = [var_1];

  if(isDefined(var_2)) {
    var_6[var_6.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_6[var_6.size] = var_3;
  }

  if(isDefined(var_4)) {
    var_6[var_6.size] = var_4;
  }

  if(isDefined(var_5)) {
    var_6[var_6.size] = var_5;
  }

  var_7 = _id_6B37(var_6);

  if(!isDefined(self.matchstats._id_AEE4[var_7])) {
    self.matchstats._id_FF6E[var_7] = var_0;
    self.matchstats._id_AEE4[var_7] = var_6;
  } else
    self.matchstats._id_FF6E[var_7] = self.matchstats._id_FF6E[var_7] + var_0;
}

_id_6B36(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1A5B()) {
    return undefined;
  }

  var_5 = [var_0, var_1, var_2, var_3, var_4];
  var_6 = _id_6B37(var_5);

  if(!isDefined(self.matchstats._id_FF6E[var_6])) {
    return 0;
  }

  return self.matchstats._id_FF6E[var_6];
}

_id_6B65(var_0) {
  var_1 = level.matchstats;

  if(!isDefined(var_1._id_9FF3)) {
    return undefined;
  }

  return var_1._id_9FF2[var_0];
}

_id_D573(var_0, var_1) {
  if(!_id_1A5B()) {
    return;
  }
  var_2 = _id_6B65(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  _id_D5F5(var_1, "modeStats", var_2);
}

_id_115C(var_0, var_1) {
  if(!_id_1A5B()) {
    return;
  }
  var_2 = _id_6B65(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  _id_1164(var_1, "modeStats", var_2);
}

_id_6A60(var_0) {
  if(!_id_1A5B()) {
    return;
  }
  var_1 = _id_6B65(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  return _id_6B36("modeStats", var_1);
}

_id_1A5B() {
  return isDefined(level.matchstats) && istrue(level.matchstats._id_523F);
}