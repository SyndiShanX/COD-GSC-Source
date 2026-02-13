/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1969.gsc
*************************************************/

init() {
  _id_8144();
  _id_0AA3::_id_C28D(::onplayerspawned);
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
  _id_8222();
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
    scripts\mp\utility\script::_id_1096C();
  }

  if(!isDefined(level._id_1FCC[var_0])) {
    return;
  }
  _id_7DAF(var_0);

  if(_func_030C("mp", "Awards", var_0)) {
    _id_1091(var_0);
  }

  var_9 = level._id_1FCC[var_0]._id_10FDA;

  if(isDefined(var_9)) {
    if(isDefined(var_2)) {
      var_10 = var_2;
    } else {
      var_10 = scripts\mp\rank::getscoreinfovalue(var_9);
    }

    scripts\mp\rank::giverankxp(var_9, var_10, var_7);
  }

  var_11 = level._id_1FCC[var_0]._id_60E4;

  if(isDefined(var_11)) {
    _id_0A9F::_id_7003(var_11, undefined, var_1, 1, var_4, var_5, var_8);
  }

  scripts\mp\utility\script::_id_2C9F("earned_award_buffered", var_0);

  if(isDefined(self._id_1FCD[var_0])) {
    self._id_1FCD[var_0]++;
  } else {
    self._id_1FCD[var_0] = 1;
  }

  scripts\common\utility::_id_F73A(level._id_9BB1, var_0);
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

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    if(!istrue(var_0) || scripts\mp\utility\player::_id_88C7()) {
      if(!scripts\mp\utility\player::_id_8ACE()) {
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
  if(self _meth_8685() && _id_07D1::_id_60BE("prematch_done")) {
    _id_4021(var_0);
  }

  if(_id_DBBF(var_3)) {
    _id_BED4(var_0);
    return;
  }

  _id_07A9::_id_9763(var_0);
  thread _id_6F83(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
}

_id_4021(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "four":
      self setclientomnvar("nVidiaHighlights_events", 10);
      var_1 = 1;
      break;
    case "one_shot_two_kills":
      self setclientomnvar("nVidiaHighlights_events", 7);
      var_1 = 1;
      break;
    case "grenade_double":
      self setclientomnvar("nVidiaHighlights_events", 13);
      var_1 = 1;
      break;
    case "explosive_stick":
      self setclientomnvar("nVidiaHighlights_events", 14);
      var_1 = 1;
      break;
    case "simultaneous_kill":
      self setclientomnvar("nVidiaHighlights_events", 8);
      var_1 = 1;
      break;
    case "item_impact":
      self setclientomnvar("nVidiaHighlights_events", 9);
      var_1 = 1;
      break;
  }

  if(var_1 == 0) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      switch (var_0) {
        case "double":
          self setclientomnvar("nVidiaHighlights_events", 18);
          break;
        case "triple":
          self setclientomnvar("nVidiaHighlights_events", 19);
          break;
        case "longshot":
          self setclientomnvar("nVidiaHighlights_events", 20);
          break;
        case "revenge":
          self setclientomnvar("nVidiaHighlights_events", 21);
          break;
        case "backstab":
          self setclientomnvar("nVidiaHighlights_events", 22);
          break;
        case "throwingknife_kill":
          self setclientomnvar("nVidiaHighlights_events", 23);
          break;
      }
    } else {
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
        case "six":
          self setclientomnvar("nVidiaHighlights_events", 11);
          break;
        case "multi":
          self setclientomnvar("nVidiaHighlights_events", 12);
          break;
        case "mode_gun_melee_1st_place":
          self setclientomnvar("nVidiaHighlights_events", 15);
          break;
      }
    }
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