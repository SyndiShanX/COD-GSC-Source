/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\awards.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace awards;

function init() {
  initawards();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level thread onplayerconnect();
  level thread saveaarawardsonroundswitch();
}

function onplayerconnect() {
  while(true) {
    level waittill("connected", player);
    player thread initaarawardlist();
    player.awardqueue = [];
  }
}

function onplayerspawned() {
  self.awardsthislife = [];
}

function initawards() {
  initmidmatchawards();
}

function function_6df0786b01ec7028(ref) {
  assert(isDefined(ref));
  aarpriority = tablelookup("mp/awardtable.csv", 0, ref, 1);

  if(isDefined(aarpriority) && aarpriority > 0) {
    randomvalue = randomfloat(1);
    level.var_6d808d6c553c2d9a[ref] = float(aarpriority) + randomvalue;
  }
}

function initmidmatchaward(ref) {
  function_6df0786b01ec7028(ref);
}

function initmidmatchawards() {
  for(row = 0; true; row++) {
    ref = tablelookupbyrow("mp/awardtable.csv", row, 0);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    if(!isxhash(ref)) {
      assertex(1, ref);
      ref = getxhash(ref);
    }

    initmidmatchaward(ref);
  }
}

function incplayerrecord(ref) {
  recordvalue = self getplayerdata("common", "awards", ref);
  self setplayerdata("common", "awards", ref, recordvalue + 1);
}

function giveaward(ref, objweapon, pointsoverride, xpoverride, immediate, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo) {
  if(!istrue(immediate)) {
    self endon("disconnect");
    waitframe();
    waittillslowprocessallowed();
  }

  if(!scripts\mp\rank::function_34294184e90b96c(ref)) {
    assertmsg("<dev string:x1c>" + ref + "<dev string:x37>");
    return;
  }

  if(isenumvaluevalid(level.progressiongroup, "Awards", getxhashhexname(ref))) {
    addawardtoaarlist(ref);
  }

  xp = xpoverride;

  if(!isDefined(xp)) {
    xp = scripts\mp\rank::getscoreinfoxp(ref);
  }

  if(isDefined(xp) && xp > 0) {
    scripts\mp\rank::giverankxp(ref, xp, objweapon, undefined, immediate, undefined, undefined, eventinfo);
  }

  if(!isDefined(pointsoverride)) {
    points = scripts\mp\rank::getscoreinfovalue(ref);
    pointsoverride = default_to(points, 0);
  }

  if(pointsoverride > 0) {
    giveunifiedpoints(ref, objweapon, pointsoverride, -1, victim, cankillchain, streakinfo, undefined, eventinfo);
  }

  bufferednotify("earned_award_buffered", ref);

  if(isDefined(self.awardsthislife[ref])) {
    self.awardsthislife[ref]++;
  } else {
    self.awardsthislife[ref] = 1;
  }

  utility::trycall(level.matchdata_logaward, ref);
}

function queuemidmatchaward(ref, objweapon, pointsoverride, xpoverride, var_51bdae03b05bc75e, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo) {
  awardinfo = spawnStruct();
  awardinfo.ref = [ref, gettime()];
  awardinfo.objweapon = objweapon;
  awardinfo.pointsoverride = pointsoverride;
  awardinfo.xpoverride = xpoverride;
  awardinfo.var_51bdae03b05bc75e = var_51bdae03b05bc75e;
  awardinfo.dontwait = dontwait;
  awardinfo.victim = victim;
  awardinfo.cankillchain = cankillchain;
  awardinfo.streakinfo = streakinfo;
  awardinfo.var_ad8c6c5cc50af10b = var_ad8c6c5cc50af10b;
  awardinfo.eventinfo = eventinfo;
  self.awardqueue[self.awardqueue.size] = awardinfo;
  thread flushmidmatchawardqueuewhenable();
}

function flushmidmatchawardqueue() {
  assertex(!shouldqueuemidmatchaward(), "<dev string:x98>");

  if(isDefined(self)) {
    if(isDefined(self.awardqueue)) {
      foreach(award in self.awardqueue) {
        givemidmatchaward(award.ref, award.objweapon, award.pointsoverride, award.xpoverride, award.var_51bdae03b05bc75e, award.dontwait, award.victim, award.cankillchain, award.streakinfo, award.var_ad8c6c5cc50af10b, award.eventinfo);
      }
    }

    self.awardqueue = [];
  }
}

function flushmidmatchawardqueuewhenable() {
  self endon("disconnect");
  self notify("flushMidMatchAwardQueueWhenAble()");
  self endon("flushMidMatchAwardQueueWhenAble()");

  while(true) {
    if(!shouldqueuemidmatchaward()) {
      break;
    }

    waitframe();
  }

  thread flushmidmatchawardqueue();
}

function shouldqueuemidmatchaward(var_3cda0e0b6a2d1f97) {
  if(level.gameended) {
    return false;
  }

  if(getdvarint(@ "hash_9779e069cc4f5bc8", 0) > 0) {
    level.var_6d05adacfaa6fbb2 = getdvarint(@ "hash_9779e069cc4f5bc8", 0);
    setDvar(@ "hash_9779e069cc4f5bc8", 0);
  }

  if(isDefined(level.var_6d05adacfaa6fbb2)) {
    if(level.var_6d05adacfaa6fbb2 > 0) {
      level.var_6d05adacfaa6fbb2--;
      return true;
    }

    level.var_6d05adacfaa6fbb2 = undefined;
  }

  if(!isreallyalive(self)) {
    if(!istrue(var_3cda0e0b6a2d1f97) || isinkillcam()) {
      if(!isusingremote()) {
        return true;
      }
    }
  }

  return false;
}

function givemidmatchaward(ref, objweapon, pointsoverride, xpoverride, var_51bdae03b05bc75e, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo) {
  if(!isPlayer(self)) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(istrue(level.gameended)) {
    isvalidevent = 0;

    if(isarray(ref)) {
      if(isnumber(level.gameendtime)) {
        if(ref[1] <= level.gameendtime) {
          isvalidevent = 1;
          ref = ref[0];
        }
      }
    } else if(isDefined(ref)) {
      isvalidevent = 1;
    }

    if(!isvalidevent) {
      return;
    }
  } else if(isarray(ref)) {
    ref = ref[0];
  }

  if(!isxhash(ref)) {
    assertex(1, ref);
    ref = getxhash(ref);
  }

  if(self ispcplayer() && scripts\mp\flags::gameflag("prematch_done")) {
    createnvidiavideo(ref);
  }

  if(shouldqueuemidmatchaward(var_51bdae03b05bc75e)) {
    queuemidmatchaward(ref, objweapon, pointsoverride, xpoverride, var_51bdae03b05bc75e, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo);
    return;
  }

  scripts\mp\analyticslog::logevent_awardgained(ref);
  thread giveaward(ref, objweapon, pointsoverride, xpoverride, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo);
}

function createnvidiavideo(ref) {
  var_7861cc7f1384834e = undefined;

  if(ref == #"four") {
    var_7861cc7f1384834e = 9;
  } else if(ref == #"one_shot_two_kills") {
    var_7861cc7f1384834e = 7;
  } else if(ref == #"grenade_double") {
    var_7861cc7f1384834e = 12;
  } else if(ref == #"explosive_stick") {
    var_7861cc7f1384834e = 13;
  } else if(ref == #"item_impact") {
    var_7861cc7f1384834e = 8;
  }

  if(!isDefined(var_7861cc7f1384834e)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(ref == #"double") {
        var_7861cc7f1384834e = 17;
      } else if(ref == #"triple") {
        var_7861cc7f1384834e = 18;
      } else if(ref == #"longshot") {
        var_7861cc7f1384834e = 19;
      } else if(ref == #"revenge") {
        var_7861cc7f1384834e = 20;
      } else if(ref == #"backstab") {
        var_7861cc7f1384834e = 21;
      } else if(ref == #"throwingknife_kill") {
        var_7861cc7f1384834e = 22;
      }
    } else if(ref == #"five") {
      var_7861cc7f1384834e = 1;
    } else if(ref == #"seven") {
      var_7861cc7f1384834e = 2;
    } else if(ref == #"eight") {
      var_7861cc7f1384834e = 3;
    } else if(ref == #"streak_10") {
      var_7861cc7f1384834e = 4;
    } else if(ref == #"streak_20") {
      var_7861cc7f1384834e = 5;
    } else if(ref == #"streak_30") {
      var_7861cc7f1384834e = 6;
    } else if(ref == #"six") {
      var_7861cc7f1384834e = 10;
    } else if(ref == #"multi") {
      var_7861cc7f1384834e = 11;
    } else if(ref == #"hash_fe6243d280c9e5cf") {
      var_7861cc7f1384834e = 14;
    }
  }

  if(isDefined(var_7861cc7f1384834e)) {
    self setclientomnvar("nVidiaHighlights_events", var_7861cc7f1384834e);
  }
}

function addawardtoaarlist(ref) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(awardindex = 0; awardindex < 10; awardindex++) {
      struct = spawnStruct();
      self.aarawards[awardindex] = struct;
      struct.ref = "none";
      struct.count = 0;
    }
  }

  foreach(awardindex, awardinfo in self.aarawards) {
    if(awardinfo.ref == ref) {
      awardinfo.count++;
      self setplayerdata("common", "round", "awards", awardindex, "value", awardinfo.count);
      return;
    }
  }

  newpriority = default_to(level.var_6d808d6c553c2d9a[ref], 0);

  for(insertindex = 0; insertindex < self.aarawards.size; insertindex++) {
    awardinfo = self.aarawards[insertindex];

    if(awardinfo.ref == "none") {
      break;
    }

    otherpriority = default_to(level.var_6d808d6c553c2d9a[awardinfo.ref], 0);

    if(newpriority > otherpriority) {
      break;
    }
  }

  if(insertindex >= self.aarawards.size) {
    return;
  }

  for(listindex = self.aarawards.size - 2; listindex >= insertindex; listindex--) {
    newindex = listindex + 1;
    self.aarawards[newindex] = self.aarawards[listindex];
    awardinfo = self.aarawards[newindex];

    if(awardinfo.ref != "none") {
      self setplayerdata("common", "round", "awards", newindex, "award", getxhashhexname(awardinfo.ref));
      self setplayerdata("common", "round", "awards", newindex, "value", awardinfo.count);
    }
  }

  awardinfo = spawnStruct();
  self.aarawards[insertindex] = awardinfo;
  awardinfo.ref = ref;
  awardinfo.count = 1;
  self setplayerdata("common", "round", "awards", insertindex, "award", getxhashhexname(awardinfo.ref));
  self setplayerdata("common", "round", "awards", insertindex, "value", awardinfo.count);

  if(self.aarawardcount < 10) {
    self.aarawardcount++;
    self setplayerdata("common", "round", "awardCount", self.aarawardcount);
  }

  if(istrue(self.savedaarawards)) {
    saveaarawards();
  }
}

function initaarawardlist() {
  self.aarawards = self.pers["aarAwards"];
  self.aarawardcount = self.pers["aarAwardCount"];

  if(isDefined(self.aarawards)) {
    return;
  }

  self setplayerdata("common", "round", "awardCount", 0);

  for(awardindex = 0; awardindex < 10; awardindex++) {
    self setplayerdata("common", "round", "awards", awardindex, "award", "none");
    self setplayerdata("common", "round", "awards", awardindex, "value", 0);
  }
}

function saveaarawardsonroundswitch() {
  level waittill("game_ended");

  foreach(player in level.players) {
    if(isDefined(player) && !isbot(player)) {
      player saveaarawards();
    }
  }
}

function saveaarawards() {
  self.pers["aarAwards"] = self.aarawards;
  self.pers["aarAwardCount"] = self.aarawardcount;
  self.savedaarawards = 1;
}

function function_c346fd8caa61c2ed() {
  for(awardindex = 0; awardindex < self.aarawards.size; awardindex++) {
    awardinfo = self.aarawards[awardindex];
    pdref = self getplayerdata("<dev string:xde>", "<dev string:xe8>", "<dev string:xf1>", awardindex, "<dev string:xfb>");
    pdcount = self getplayerdata("<dev string:xde>", "<dev string:xe8>", "<dev string:xf1>", awardindex, "<dev string:x104>");
    assert(awardinfo.ref == pdref);
    assert(awardinfo.count == pdcount);
    println("<dev string:x10d>" + awardindex + 1 + "<dev string:x11b>" + awardinfo.ref + "<dev string:x121>" + awardinfo.count);
  }
}

# /