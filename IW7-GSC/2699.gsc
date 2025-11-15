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
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
    var_00 thread initaarawardlist();
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

initbaseaward(var_00, var_01) {
  level.awards[var_00] = spawnStruct();
  level.awards[var_00].type = var_01;
  var_02 = tablelookup("mp\awardtable.csv", 1, var_00, 10);

  if(isDefined(var_02) && var_02 != "")
    level.awards[var_00].xpscoreevent = var_02;

  var_03 = tablelookup("mp\awardtable.csv", 1, var_00, 11);

  if(isDefined(var_03) && var_03 != "")
    level.awards[var_00].gamescoreevent = var_03;

  var_04 = tablelookup("mp\awardtable.csv", 1, var_00, 3);

  if(isDefined(var_04) && var_04 != "")
    level.awards[var_00].category = var_04;

  var_05 = tablelookup("mp\awardtable.csv", 1, var_00, 7);

  if(isDefined(var_05) && var_05 != "") {
    var_06 = randomfloat(1.0);
    level.awards[var_00].aarpriority = float(var_05) + var_06;
  }
}

initbasemidmatchaward(var_00, var_01) {
  initbaseaward(var_00, var_01);
}

initmidmatchaward(var_00) {
  initbasemidmatchaward(var_00, "midmatch");
}

initmidmatchawards() {
  var_00 = 0;

  for(;;) {
    var_01 = tablelookupbyrow("mp\awardtable.csv", var_00, 1);

    if(!isDefined(var_01) || var_01 == "") {
      break;
    }
    var_02 = tablelookupbyrow("mp\awardtable.csv", var_00, 9);

    if(isDefined(var_02) && var_02 != "")
      initmidmatchaward(var_01);

    level.awards[var_01].id = var_00;
    var_0++;
  }
}

incplayerrecord(var_00) {
  var_01 = self getrankedplayerdata("common", "awards", var_00);
  self setrankedplayerdata("common", "awards", var_00, var_01 + 1);
}

giveaward(var_00, var_01, var_02) {
  if(!isDefined(level.awards[var_00])) {
    return;
  }
  if(!isenumvaluevalid("mp", "Awards", var_00)) {
    return;
  }
  incplayerrecord(var_00);
  addawardtoaarlist(var_00);
  var_03 = level.awards[var_00].xpscoreevent;

  if(isDefined(var_03)) {
    if(isDefined(var_02))
      var_04 = var_02;
    else
      var_04 = scripts\mp\rank::getscoreinfovalue(var_03);

    scripts\mp\rank::giverankxp(var_03, var_04);
  }

  var_05 = level.awards[var_00].gamescoreevent;

  if(isDefined(var_05))
    scripts\mp\utility\game::giveunifiedpoints(var_05, undefined, var_01, undefined, undefined, 1);

  scripts\mp\utility\game::bufferednotify("earned_award_buffered", var_00);

  if(isDefined(self.awardsthislife[var_00]))
    self.awardsthislife[var_00]++;
  else
    self.awardsthislife[var_00] = 1;

  scripts\mp\matchdata::func_AF97(var_00);
  scripts\mp\missions::func_D98F(var_00);
}

queuemidmatchaward(var_00) {
  self.awardqueue[self.awardqueue.size] = var_00;
  thread flushmidmatchawardqueuewhenable();
}

flushmidmatchawardqueue() {
  foreach(var_01 in self.awardqueue)
  givemidmatchaward(var_01);

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

shouldqueuemidmatchaward(var_00) {
  if(level.gameended)
    return 0;

  if(!scripts\mp\utility\game::isreallyalive(self)) {
    if(!scripts\mp\utility\game::istrue(var_00) || scripts\mp\utility\game::isinkillcam()) {
      if(!scripts\mp\utility\game::isusingremote())
        return 1;
    }
  }

  return 0;
}

func_B8E6(var_00) {
  if(!isDefined(var_00) || !isDefined(level.awards) || !isDefined(level.awards[var_00])) {
    return;
  }
  if(!isDefined(self.func_1097C) || !isDefined(self.func_D8B1)) {
    self.func_1097C = 0;
    self.func_D8B1 = 0;
  }

  var_01 = level.awards[var_00].id;

  if(var_01 > 255)
    scripts\engine\utility::error("awardID can't be larger than 255! Must increased bit size for award id stored in ui_spectating_award_event_bitfield");

  var_02 = self.func_D8B1;
  var_03 = 8 * (self.func_1097C % 4);
  var_04 = ~(255 << var_03);
  var_02 = var_02 & var_04;
  var_05 = var_01 << var_03;
  var_02 = var_02 | var_05;
  self setclientomnvar("ui_spectating_award_event_bitfield", var_02);
  self setclientomnvar("ui_spectating_award_event_index", self.func_1097C);
  self.func_D8B1 = var_02;
  self.func_1097C++;

  if(self.func_1097C > 99)
    self.func_1097C = 0;
}

givemidmatchaward(var_00, var_01, var_02, var_03) {
  if(!isplayer(self)) {
    return;
  }
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    foreach(var_05 in level.players) {
      if(var_05 ismlgspectator()) {
        var_06 = var_05 getspectatingplayer();

        if(isDefined(var_06)) {
          var_07 = var_06 getentitynumber();
          var_08 = self getentitynumber();

          if(var_07 == var_08)
            var_05 func_B8E6(var_00);
        }
      }
    }
  }

  if(isai(self)) {
    return;
  }
  if(shouldqueuemidmatchaward(var_03)) {
    queuemidmatchaward(var_00);
    return;
  }

  scripts\mp\analyticslog::logevent_awardgained(var_00);
  giveaward(var_00, var_01, var_02);
}

addawardtoaarlist(var_00) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(var_01 = 0; var_01 < 10; var_1++) {
      var_02 = spawnStruct();
      self.aarawards[var_01] = var_02;
      var_2.ref = "none";
      var_2.count = 0;
    }
  }

  foreach(var_01, var_04 in self.aarawards) {
    if(var_4.ref == var_00) {
      var_4.count++;
      self setrankedplayerdata("common", "round", "awards", var_01, "value", var_4.count);
      return;
    }
  }

  var_05 = level.awards[var_00].aarpriority;

  for(var_06 = 0; var_06 < self.aarawards.size; var_6++) {
    var_04 = self.aarawards[var_06];

    if(var_4.ref == "none") {
      break;
    }
    var_07 = level.awards[var_4.ref].aarpriority;

    if(var_05 > var_07) {
      break;
    }
  }

  if(var_06 >= self.aarawards.size) {
    return;
  }
  for(var_08 = self.aarawards.size - 2; var_08 >= var_06; var_8--) {
    var_09 = var_08 + 1;
    self.aarawards[var_09] = self.aarawards[var_08];
    var_04 = self.aarawards[var_09];

    if(var_4.ref != "none") {
      self setrankedplayerdata("common", "round", "awards", var_09, "award", var_4.ref);
      self setrankedplayerdata("common", "round", "awards", var_09, "value", var_4.count);
    }
  }

  var_04 = spawnStruct();
  self.aarawards[var_06] = var_04;
  var_4.ref = var_00;
  var_4.count = 1;
  self setrankedplayerdata("common", "round", "awards", var_06, "award", var_4.ref);
  self setrankedplayerdata("common", "round", "awards", var_06, "value", var_4.count);

  if(self.aarawardcount < 10) {
    self.aarawardcount++;
    self setrankedplayerdata("common", "round", "awardCount", self.aarawardcount);
  }

  if(scripts\mp\utility\game::istrue(self.savedaarawards))
    saveaarawards();
}

initaarawardlist() {
  self.aarawards = self.pers["aarAwards"];
  self.aarawardcount = self.pers["aarAwardCount"];
  thread saveaarawardsonroundswitch();

  if(isDefined(self.aarawards)) {
    return;
  }
  self setrankedplayerdata("common", "round", "awardCount", 0);

  for(var_00 = 0; var_00 < 10; var_0++) {
    self setrankedplayerdata("common", "round", "awards", var_00, "award", "none");
    self setrankedplayerdata("common", "round", "awards", var_00, "value", 0);
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