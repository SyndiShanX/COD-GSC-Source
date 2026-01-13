/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2699.gsc
***************************************/

init() {
  initawards();
  level thread onplayerconnect();
  level.givemidmatchawardfunc = ::givemidmatchaward;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread initaarawardlist();
    var_0.awardqueue = [];
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.awardsthislife = [];
  }
}

initawards() {
  initmidmatchawards();
}

initbaseaward(var_0, var_1) {
  level.awards[var_0] = spawnStruct();
  level.awards[var_0].type = var_1;
  var_2 = tablelookup("mp\awardtable.csv", 1, var_0, 10);

  if(isDefined(var_2) && var_2 != "") {
    level.awards[var_0].xpscoreevent = var_2;
  }

  var_3 = tablelookup("mp\awardtable.csv", 1, var_0, 11);

  if(isDefined(var_3) && var_3 != "") {
    level.awards[var_0].gamescoreevent = var_3;
  }

  var_4 = tablelookup("mp\awardtable.csv", 1, var_0, 3);

  if(isDefined(var_4) && var_4 != "") {
    level.awards[var_0].category = var_4;
  }

  var_5 = tablelookup("mp\awardtable.csv", 1, var_0, 7);

  if(isDefined(var_5) && var_5 != "") {
    var_6 = randomfloat(1.0);
    level.awards[var_0].aarpriority = float(var_5) + var_6;
  }
}

initbasemidmatchaward(var_0, var_1) {
  initbaseaward(var_0, var_1);
}

initmidmatchaward(var_0) {
  initbasemidmatchaward(var_0, "midmatch");
}

initmidmatchawards() {
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp\awardtable.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }
    var_2 = tablelookupbyrow("mp\awardtable.csv", var_0, 9);

    if(isDefined(var_2) && var_2 != "") {
      initmidmatchaward(var_1);
    }

    level.awards[var_1].id = var_0;
    var_0++;
  }
}

incplayerrecord(var_0) {
  var_1 = self getrankedplayerdata("common", "awards", var_0);
  self setrankedplayerdata("common", "awards", var_0, var_1 + 1);
}

giveaward(var_0, var_1, var_2) {
  if(!isDefined(level.awards[var_0])) {
    return;
  }
  if(!isenumvaluevalid("mp", "Awards", var_0)) {
    return;
  }
  incplayerrecord(var_0);
  addawardtoaarlist(var_0);
  var_3 = level.awards[var_0].xpscoreevent;

  if(isDefined(var_3)) {
    if(isDefined(var_2)) {
      var_4 = var_2;
    } else {
      var_4 = scripts\mp\rank::getscoreinfovalue(var_3);
    }

    scripts\mp\rank::giverankxp(var_3, var_4);
  }

  var_5 = level.awards[var_0].gamescoreevent;

  if(isDefined(var_5)) {
    scripts\mp\utility\game::giveunifiedpoints(var_5, undefined, var_1, undefined, undefined, 1);
  }

  scripts\mp\utility\game::bufferednotify("earned_award_buffered", var_0);

  if(isDefined(self.awardsthislife[var_0])) {
    self.awardsthislife[var_0]++;
  } else {
    self.awardsthislife[var_0] = 1;
  }

  scripts\mp\matchdata::func_AF97(var_0);
  scripts\mp\missions::func_D98F(var_0);
}

queuemidmatchaward(var_0) {
  self.awardqueue[self.awardqueue.size] = var_0;
  thread flushmidmatchawardqueuewhenable();
}

flushmidmatchawardqueue() {
  foreach(var_1 in self.awardqueue) {
    givemidmatchaward(var_1);
  }

  self.awardqueue = [];
}

flushmidmatchawardqueuewhenable() {
  self endon("disconnect");
  self notify("flushMidMatchAwardQueueWhenAble()");
  self endon("flushMidMatchAwardQueueWhenAble()");

  for(;;) {
    if(!shouldqueuemidmatchaward()) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  thread flushmidmatchawardqueue();
}

shouldqueuemidmatchaward(var_0) {
  if(level.gameended) {
    return 0;
  }

  if(!scripts\mp\utility\game::isreallyalive(self)) {
    if(!scripts\mp\utility\game::istrue(var_0) || scripts\mp\utility\game::isinkillcam()) {
      if(!scripts\mp\utility\game::isusingremote()) {
        return 1;
      }
    }
  }

  return 0;
}

func_B8E6(var_0) {
  if(!isDefined(var_0) || !isDefined(level.awards) || !isDefined(level.awards[var_0])) {
    return;
  }
  if(!isDefined(self.var_1097C) || !isDefined(self.var_D8B1)) {
    self.var_1097C = 0;
    self.var_D8B1 = 0;
  }

  var_1 = level.awards[var_0].id;

  if(var_1 > 255) {
    scripts\engine\utility::error("awardID can't be larger than 255! Must increased bit size for award id stored in ui_spectating_award_event_bitfield");
  }

  var_2 = self.var_D8B1;
  var_3 = 8 * (self.var_1097C % 4);
  var_4 = ~(255 << var_3);
  var_2 = var_2 &var_4;
  var_5 = var_1 << var_3;
  var_2 = var_2 | var_5;
  self setclientomnvar("ui_spectating_award_event_bitfield", var_2);
  self setclientomnvar("ui_spectating_award_event_index", self.var_1097C);
  self.var_D8B1 = var_2;
  self.var_1097C++;

  if(self.var_1097C > 99) {
    self.var_1097C = 0;
  }
}

givemidmatchaward(var_0, var_1, var_2, var_3) {
  if(!isplayer(self)) {
    return;
  }
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    foreach(var_5 in level.players) {
      if(var_5 ismlgspectator()) {
        var_6 = var_5 getspectatingplayer();

        if(isDefined(var_6)) {
          var_7 = var_6 getentitynumber();
          var_8 = self getentitynumber();

          if(var_7 == var_8) {
            var_5 func_B8E6(var_0);
          }
        }
      }
    }
  }

  if(isai(self)) {
    return;
  }
  if(shouldqueuemidmatchaward(var_3)) {
    queuemidmatchaward(var_0);
    return;
  }

  scripts\mp\analyticslog::logevent_awardgained(var_0);
  giveaward(var_0, var_1, var_2);
}

addawardtoaarlist(var_0) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(var_1 = 0; var_1 < 10; var_1++) {
      var_2 = spawnStruct();
      self.aarawards[var_1] = var_2;
      var_2.ref = "none";
      var_2.count = 0;
    }
  }

  foreach(var_1, var_4 in self.aarawards) {
    if(var_4.ref == var_0) {
      var_4.count++;
      self setrankedplayerdata("common", "round", "awards", var_1, "value", var_4.count);
      return;
    }
  }

  var_5 = level.awards[var_0].aarpriority;

  for(var_6 = 0; var_6 < self.aarawards.size; var_6++) {
    var_4 = self.aarawards[var_6];

    if(var_4.ref == "none") {
      break;
    }
    var_7 = level.awards[var_4.ref].aarpriority;

    if(var_5 > var_7) {
      break;
    }
  }

  if(var_6 >= self.aarawards.size) {
    return;
  }
  for(var_8 = self.aarawards.size - 2; var_8 >= var_6; var_8--) {
    var_9 = var_8 + 1;
    self.aarawards[var_9] = self.aarawards[var_8];
    var_4 = self.aarawards[var_9];

    if(var_4.ref != "none") {
      self setrankedplayerdata("common", "round", "awards", var_9, "award", var_4.ref);
      self setrankedplayerdata("common", "round", "awards", var_9, "value", var_4.count);
    }
  }

  var_4 = spawnStruct();
  self.aarawards[var_6] = var_4;
  var_4.ref = var_0;
  var_4.count = 1;
  self setrankedplayerdata("common", "round", "awards", var_6, "award", var_4.ref);
  self setrankedplayerdata("common", "round", "awards", var_6, "value", var_4.count);

  if(self.aarawardcount < 10) {
    self.aarawardcount++;
    self setrankedplayerdata("common", "round", "awardCount", self.aarawardcount);
  }

  if(scripts\mp\utility\game::istrue(self.savedaarawards)) {
    saveaarawards();
  }
}

initaarawardlist() {
  self.aarawards = self.pers["aarAwards"];
  self.aarawardcount = self.pers["aarAwardCount"];
  thread saveaarawardsonroundswitch();

  if(isDefined(self.aarawards)) {
    return;
  }
  self setrankedplayerdata("common", "round", "awardCount", 0);

  for(var_0 = 0; var_0 < 10; var_0++) {
    self setrankedplayerdata("common", "round", "awards", var_0, "award", "none");
    self setrankedplayerdata("common", "round", "awards", var_0, "value", 0);
  }
}

saveaarawardsonroundswitch() {
  self endon("disconnect");
  level waittill("game_ended");
  saveaarawards();
}

saveaarawards() {
  self.pers["aarAwards"] = self.aarawards;
  self.pers["aarAwardCount"] = self.aarawardcount;
  self.savedaarawards = 1;
}