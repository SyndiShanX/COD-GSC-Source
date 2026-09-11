/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\awards.gsc
***********************************************/

function init() {
  initawards();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  thread onplayerconnect();
  thread saveaarawardsonroundswitch();
  level.givemidmatchawardfunc = &givemidmatchaward;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    thread initaarawardlist();
    var0.awardqueue = [];
  }
}

function onplayerspawned() {
  self.awardsthislife = [];
}

function initawards() {
  initmidmatchawards();
}

function initbaseaward(var0, var1) {
  level.awards[var0] = spawnStruct();
  level.awards[var0].type = var1;
  var2 = tablelookup("mp/awardtable.csv", 1, var0, 10);

  if(isDefined(var2) && var2 != "") {
    level.awards[var0].xpscoreevent = var2;
  }

  var3 = tablelookup("mp/awardtable.csv", 1, var0, 11);

  if(isDefined(var3) && var3 != "") {
    level.awards[var0].gamescoreevent = var3;
  }

  var4 = tablelookup("mp/awardtable.csv", 1, var0, 3);

  if(isDefined(var4) && var4 != "") {
    level.awards[var0].category = var4;
  }

  var5 = tablelookup("mp/awardtable.csv", 1, var0, 7);

  if(isDefined(var5) && var5 != "") {
    var6 = randomfloat(1);
    level.awards[var0].aarpriority = float(var5) + var6;
    return;
  }
}

function initbasemidmatchaward(var0, var1) {
  initbaseaward(var0, var1);
}

function initmidmatchaward(var0) {
  initbasemidmatchaward(var0, "midmatch");
}

function initmidmatchawards() {
  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/awardtable.csv", var0, 1);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = tablelookupbyrow("mp/awardtable.csv", var0, 9);

    if(isDefined(var2) && var2 != "") {
      initmidmatchaward(var1);
    }

    level.awards[var1].id = var0;
  }
}

function incplayerrecord(var0) {
  var1 = self getplayerdata("common", "awards", var0);
  self setplayerdata("common", "awards", var0, var1 + 1);
}

function giveaward(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = undefined;

  if(isDefined(var6) && isDefined(var6.streakinfo)) {
    var8 = var6.streakinfo;
  }

  if(!istrue(var3)) {
    self endon("disconnect");
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  if(!isDefined(level.awards[var0])) {
    return;
  }

  if(isenumvaluevalid("mp", "Awards", var0)) {
    addawardtoaarlist(var0);
  }

  var9 = level.awards[var0].xpscoreevent;

  if(isDefined(var9)) {
    if(isDefined(var2)) {
      var10 = var2;
    } else {
      var10 = scripts\mp\rank::getscoreinfovalue(var10);
    }

    scripts\mp\rank::giverankxp(var10, var10, var8);
  }

  var11 = level.awards[var1].gamescoreevent;

  if(isDefined(var11)) {
    scripts\mp\utility\points::giveunifiedpoints(var11, undefined, var2, 1, var5, var6, var9);
  }

  scripts\mp\utility\script::bufferednotify("earned_award_buffered", var1);

  if(isDefined(self.awardsthislife[var1])) {
    self.awardsthislife[var1]++;
  } else {
    self.awardsthislife[var1] = 1;
  }

  scripts\common\utility::ref_13e0a(level.ref_11b27, var1);
}

function queuemidmatchaward(var0) {
  self.awardqueue[self.awardqueue.size] = var0;
  thread flushmidmatchawardqueuewhenable();
}

function flushmidmatchawardqueue() {
  foreach(var1 in self.awardqueue) {
    givemidmatchaward(var1);
  }

  self.awardqueue = [];
}

function flushmidmatchawardqueuewhenable() {
  self endon("disconnect");
  self notify("flushMidMatchAwardQueueWhenAble()");
  self endon("flushMidMatchAwardQueueWhenAble()");

  for(;;) {
    if(!shouldqueuemidmatchaward()) {
      break;
    }

    waitframe();
  }

  thread flushmidmatchawardqueue();
}

function shouldqueuemidmatchaward(var0) {
  if(level.gameended) {
    return false;
  }

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    if(!istrue(var0) || scripts\mp\utility\player::isinkillcam()) {
      if(!scripts\mp\utility\player::isusingremote()) {
        return true;
      }
    }
  }

  return false;
}

function givemidmatchaward(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isPlayer(self)) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(self ispcplayer() && scripts\mp\flags::gameflag("prematch_done")) {
    createnvidiavideo(var0);
  }

  if(shouldqueuemidmatchaward(var3)) {
    queuemidmatchaward(var0);
    return;
  }

  scripts\mp\analyticslog::logevent_awardgained(var0);
  thread giveaward(var0, var1, var2, var4, var5, var6, var7, var8);
}

function createnvidiavideo(var0) {
  var1 = 0;

  switch (var0) {
    case "four":
      self setclientomnvar("nVidiaHighlights_events", 9);
      var1 = 1;
      break;
    case "one_shot_two_kills":
      self setclientomnvar("nVidiaHighlights_events", 7);
      var1 = 1;
      break;
    case "grenade_double":
      self setclientomnvar("nVidiaHighlights_events", 12);
      var1 = 1;
      break;
    case "explosive_stick":
      self setclientomnvar("nVidiaHighlights_events", 13);
      var1 = 1;
      break;
    case "item_impact":
      self setclientomnvar("nVidiaHighlights_events", 8);
      var1 = 1;
      break;
  }

  if(var1 == 0) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      switch (var0) {
        case "double":
          self setclientomnvar("nVidiaHighlights_events", 17);
          break;
        case "triple":
          self setclientomnvar("nVidiaHighlights_events", 18);
          break;
        case "longshot":
          self setclientomnvar("nVidiaHighlights_events", 19);
          break;
        case "revenge":
          self setclientomnvar("nVidiaHighlights_events", 20);
          break;
        case "backstab":
          self setclientomnvar("nVidiaHighlights_events", 21);
          break;
        case "throwingknife_kill":
          self setclientomnvar("nVidiaHighlights_events", 22);
          break;
      }

      return;
    }

    switch (var0) {
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
        self setclientomnvar("nVidiaHighlights_events", 10);
        break;
      case "multi":
        self setclientomnvar("nVidiaHighlights_events", 11);
        break;
      case "mode_gun_melee_1st_place":
        self setclientomnvar("nVidiaHighlights_events", 14);
        break;
    }

    return;
  }
}

function addawardtoaarlist(var0) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(var1 = 0; var1 < 10; var1++) {
      var2 = spawnStruct();
      self.aarawards[var1] = var2;
      var2.ref = "none";
      var2.count = 0;
    }
  }

  foreach(var1, var4 in self.aarawards) {
    if(var4.ref == var0) {
      var4.count++;
      self setplayerdata("common", "round", "awards", var1, "value", var4.count);
      return;
    }
  }

  var5 = level.awards[var0].aarpriority;

  for(var6 = 0; var6 < self.aarawards.size; var6++) {
    var4 = self.aarawards[var6];

    if(var4.ref == "none") {
      break;
    }

    var7 = level.awards[var4.ref].aarpriority;

    if(var5 > var7) {
      break;
    }
  }

  if(var6 >= self.aarawards.size) {
    return;
  }

  for(var8 = self.aarawards.size - 2; var8 >= var6; var8--) {
    var9 = var8 + 1;
    self.aarawards[var9] = self.aarawards[var8];
    var4 = self.aarawards[var9];

    if(var4.ref != "none") {
      self setplayerdata("common", "round", "awards", var9, "award", var4.ref);
      self setplayerdata("common", "round", "awards", var9, "value", var4.count);
    }
  }

  var4 = spawnStruct();
  self.aarawards[var6] = var4;
  var4.ref = var0;
  var4.count = 1;
  self setplayerdata("common", "round", "awards", var6, "award", var4.ref);
  self setplayerdata("common", "round", "awards", var6, "value", var4.count);

  if(self.aarawardcount < 10) {
    self.aarawardcount++;
    self setplayerdata("common", "round", "awardCount", self.aarawardcount);
  }

  if(istrue(self.savedaarawards)) {
    saveaarawards();
    return;
  }
}

function initaarawardlist() {
  self.aarawards = self.pers["aarAwards"];
  self.aarawardcount = self.pers["aarAwardCount"];

  if(isDefined(self.aarawards)) {
    return;
  }

  self setplayerdata("common", "round", "awardCount", 0);

  for(var0 = 0; var0 < 10; var0++) {
    self setplayerdata("common", "round", "awards", var0, "award", "none");
    self setplayerdata("common", "round", "awards", var0, "value", 0);
  }
}

function saveaarawardsonroundswitch() {
  level waittill("game_ended");

  foreach(var1 in level.players) {
    if(isDefined(var1) && !isbot(var1)) {
      saveaarawards(var1);
    }
  }
}

function saveaarawards() {
  self.pers["aarAwards"] = self.aarawards;
  self.pers["aarAwardCount"] = self.aarawardcount;
  self.savedaarawards = 1;
}