/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1801.gsc
*************************************************/

init() {
  _id_8144();
  _id_0961::_id_C28D(::onplayerspawned);
  level thread onplayerconnect();
  level thread _id_CB3E();
  level._id_6FBA = ::_id_6FB9;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_8129();
    var_0._id_1FCB = [];
  }
}

onplayerspawned() {
  self._id_1FCD = [];
}

_id_8144() {
  scripts\engine\utility::_id_5C11("cp_operator_unlock_ids_initted");
  _id_8222();
  _id_824D();
  scripts\engine\utility::_id_5C1B("cp_operator_unlock_ids_initted");
}

_id_824D() {
  level._id_AC3C = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("cp_reward_ids.csv", var_0, 2);

    if(isDefined(var_1) && var_1 != "") {
      var_2 = spawnStruct();
      var_3 = _func_0222("cp_reward_ids.csv", 2, var_1, 1);
      var_4 = _func_0222("cp_reward_ids.csv", 2, var_1, 0);
      var_2._id_AC3B = int(var_3);
      var_2._id_7C8C = int(var_4);
      level._id_AC3C[var_1] = var_2;
      var_0++;
    } else
      break;

    waitframe();
  }

  level._id_8C52 = 0;
}

_id_8146(var_0, var_1) {
  level._id_1FCC[var_0] = spawnStruct();
  level._id_1FCC[var_0].type = var_1;
  var_2 = _func_0222("mp/awardtable.csv", 1, var_0, 10);

  if(isDefined(var_2) && var_2 != "") {
    level._id_1FCC[var_0]._id_10FDA = var_2;
  }

  var_3 = _func_0222("mp/awardtable.csv", 1, var_0, 11);

  if(isDefined(var_3) && var_3 != "") {
    level._id_1FCC[var_0]._id_60E4 = var_3;
  }

  var_4 = _func_0222("mp/awardtable.csv", 1, var_0, 3);

  if(isDefined(var_4) && var_4 != "") {
    level._id_1FCC[var_0]._id_332F = var_4;
  }

  var_5 = _func_0222("mp/awardtable.csv", 1, var_0, 7);

  if(isDefined(var_5) && var_5 != "") {
    var_6 = randomfloat(1.0);
    level._id_1FCC[var_0]._id_0DFF = float(var_5) + var_6;
  }
}

_id_8148(var_0, var_1) {
  _id_8146(var_0, var_1);
}

_id_8221(var_0) {
  _id_8148(var_0, "midmatch");
}

_id_8222() {
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/awardtable.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/awardtable.csv", var_0, 9);

    if(isDefined(var_2) && var_2 != "") {
      _id_8221(var_1);
    }

    level._id_1FCC[var_1]._id_7C8C = var_0;
    var_0++;
  }
}

_id_7DAF(var_0) {
  var_1 = self getplayerdata("common", "awards", var_0);
  self setplayerdata("common", "awards", var_0, var_1 + 1);
}

_id_6F83(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;

  if(isDefined(var_6) && isDefined(var_6.streakinfo)) {
    var_8 = var_6.streakinfo;
  }

  if(!istrue(var_3)) {
    self endon("disconnect");
    waitframe();
  }

  if(!isDefined(level._id_1FCC[var_0])) {
    return;
  }
  if(!_func_030C("mp", "Awards", var_0)) {
    return;
  }
  _id_1091(var_0);
  var_9 = level._id_1FCC[var_0]._id_10FDA;

  if(isDefined(var_9)) {
    if(isDefined(var_2)) {
      var_10 = var_2;
    } else {
      var_10 = _id_0756::_id_6D0C(var_9, "xp");
    }

    _id_0756::giverankxp(var_9, var_10, var_7);
  }

  var_11 = level._id_1FCC[var_0]._id_60E4;

  if(isDefined(var_11)) {
    _id_0752::_id_7003(var_11, undefined, var_1, 1, var_4, var_5);
  }

  self notify("earned_award_buffered", var_0);

  if(isDefined(self._id_1FCD[var_0])) {
    self._id_1FCD[var_0]++;
  } else {
    self._id_1FCD[var_0] = 1;
  }

  _id_0740::_id_9759(var_0);
}

_id_BED4(var_0) {
  self._id_1FCB[self._id_1FCB.size] = var_0;
  thread _id_5D24();
}

_id_5D23() {
  foreach(var_1 in self._id_1FCB) {
    _id_6FB9(var_1);
  }

  self._id_1FCB = [];
}

_id_5D24() {
  self endon("disconnect");
  self notify("flushMidMatchAwardQueueWhenAble()");
  self endon("flushMidMatchAwardQueueWhenAble()");

  for(;;) {
    if(!_id_DBBF()) {
      break;
    }

    waitframe();
  }

  thread _id_5D23();
}

_id_DBBF(var_0) {
  if(level.gameended) {
    return 0;
  }

  if(!scripts\cp\utility\player::isreallyalive(self)) {
    if(!istrue(var_0) || scripts\cp\utility\player::_id_88C7()) {
      if(!scripts\cp\utility\player::_id_8ACE()) {
        return 1;
      }
    }
  }

  return 0;
}

_id_6FB9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isPlayer(self)) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(self _meth_8685()) {
    _id_4021(var_0);
  }

  if(_id_DBBF(var_3)) {
    _id_BED4(var_0);
    return;
  }

  thread _id_6F83(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
}

_id_4021(var_0) {
  switch (var_0) {
    case "five":
      self setclientomnvar("nVidiaHighlights_events", 1);
      break;
    case "seven":
      self setclientomnvar("nVidiaHighlights_events", 2);
      break;
    case "eight":
      self setclientomnvar("nVidiaHighlights_events", 3);
      break;
    case "streak_10":
      self setclientomnvar("nVidiaHighlights_events", 4);
      break;
    case "streak_20":
      self setclientomnvar("nVidiaHighlights_events", 5);
      break;
    case "streak_30":
      self setclientomnvar("nVidiaHighlights_events", 6);
      break;
    case "one_shot_two_kills":
      self setclientomnvar("nVidiaHighlights_events", 7);
      break;
    case "simultaneous_kill":
      self setclientomnvar("nVidiaHighlights_events", 8);
      break;
    case "item_impact":
      self setclientomnvar("nVidiaHighlights_events", 9);
      break;
  }
}

_id_1091(var_0) {
  if(!isDefined(self._id_0DFE)) {
    self._id_0DFE = [];
    self._id_0DFD = 0;

    for(var_1 = 0; var_1 < 10; var_1++) {
      var_2 = spawnStruct();
      self._id_0DFE[var_1] = var_2;
      var_2._id_C189 = "none";
      var_2._id_011A = 0;
    }
  }

  foreach(var_1, var_4 in self._id_0DFE) {
    if(var_4._id_C189 == var_0) {
      var_4._id_011A++;
      self setplayerdata("common", "round", "awards", var_1, "value", var_4._id_011A);
      return;
    }
  }

  var_5 = level._id_1FCC[var_0]._id_0DFF;

  for(var_6 = 0; var_6 < self._id_0DFE.size; var_6++) {
    var_4 = self._id_0DFE[var_6];

    if(var_4._id_C189 == "none") {
      break;
    }

    var_7 = level._id_1FCC[var_4._id_C189]._id_0DFF;

    if(var_5 > var_7) {
      break;
    }
  }

  if(var_6 >= self._id_0DFE.size) {
    return;
  }
  for(var_8 = self._id_0DFE.size - 2; var_8 >= var_6; var_8--) {
    var_9 = var_8 + 1;
    self._id_0DFE[var_9] = self._id_0DFE[var_8];
    var_4 = self._id_0DFE[var_9];

    if(var_4._id_C189 != "none") {
      self setplayerdata("common", "round", "awards", var_9, "award", var_4._id_C189);
      self setplayerdata("common", "round", "awards", var_9, "value", var_4._id_011A);
    }
  }

  var_4 = spawnStruct();
  self._id_0DFE[var_6] = var_4;
  var_4._id_C189 = var_0;
  var_4._id_011A = 1;
  self setplayerdata("common", "round", "awards", var_6, "award", var_4._id_C189);
  self setplayerdata("common", "round", "awards", var_6, "value", var_4._id_011A);

  if(self._id_0DFD < 10) {
    self._id_0DFD++;
    self setplayerdata("common", "round", "awardCount", self._id_0DFD);
  }

  if(istrue(self._id_CB48)) {
    _id_CB3D();
  }
}

_id_8129() {
  self._id_0DFE = self.pers["aarAwards"];
  self._id_0DFD = self.pers["aarAwardCount"];

  if(isDefined(self._id_0DFE)) {
    return;
  }
  self setplayerdata("common", "round", "awardCount", 0);

  for(var_0 = 0; var_0 < 10; var_0++) {
    self setplayerdata("common", "round", "awards", var_0, "award", "none");
    self setplayerdata("common", "round", "awards", var_0, "value", 0);
  }
}

_id_CB3E() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && !isbot(var_1)) {
      var_1 _id_CB3D();
    }
  }
}

_id_CB3D() {
  self.pers["aarAwards"] = self._id_0DFE;
  self.pers["aarAwardCount"] = self._id_0DFD;
  self._id_CB48 = 1;
}

_id_6F20(var_0) {
  scripts\engine\utility::_id_5C24("cp_operator_unlock_ids_initted");

  if(!isDefined(var_0) || !_func_0121(var_0)) {
    return;
  }
  var_1 = int(_id_6502(var_0));

  switch (var_0) {
    case "crosswind":
    case "juggernauts":
    case "headhunter":
    case "kuvalda":
    case "all_operations":
    case "paladin":
      self reportchallengeuserevent_iw8("cp_complete", var_1);
      break;
    default:
      break;
  }
}

_id_6F46(var_0) {
  scripts\engine\utility::_id_5C24("cp_operator_unlock_ids_initted");

  if(!isDefined(var_0) || !_func_0121(var_0)) {
    return;
  }
  var_1 = int(_id_6502(var_0));

  switch (var_0) {
    case "downtown_1":
    case "downtown_3":
    case "downtown_2":
    case "idontknow":
    case "milehigh":
    case "downtown_4":
    case "milehigh_3":
    case "milehigh_2":
    case "smuggler":
    case "armsdealer":
      self reportchallengeuserevent_iw8("cp_complete", var_1);
      break;
    default:
      break;
  }
}

_id_6502(var_0) {
  var_1 = level._id_AC3C[var_0]._id_7C8C;
  return var_1;
}

_id_33BA() {
  if(istrue(level._id_8C70)) {
    return;
  }
  foreach(var_1 in level.players) {
    var_1 thread _id_0752::_id_7003("kill_juggernaut");
  }

  level._id_8C52++;

  if(level._id_8C52 >= 5) {
    foreach(var_1 in level.players) {
      var_1 thread _id_6F20("juggernauts");
    }

    level._id_8C70 = 1;
  }
}