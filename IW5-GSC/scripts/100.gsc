/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\100.gsc
**************************************/

init() {
  foreach(var_1 in level.players) {}
  var_1 initnotifymessage();
}

_id_12A9() {}

challenge_targetval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 6 + (var_2 - 1) * 2);
  return int(var_3);
}

challenge_rewardval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 7 + (var_2 - 1) * 2);
  return int(var_3);
}

getchallengestatus(var_0) {
  if(isDefined(self.challengedata[var_0])) {
    return self.challengedata[var_0];
  } else {
    return 0;
  }
}

ch_getprogress(var_0) {
  return self getplayerdata("challengeProgress", var_0);
}

ch_getstate(var_0) {
  return self getplayerdata("challengeState", var_0);
}

ch_setprogress(var_0, var_1) {
  return self setplayerdata("challengeProgress", var_0, var_1);
}

ch_setstate(var_0, var_1) {
  return self setplayerdata("challengeState", var_0, var_1);
}

ch_gettarget(var_0, var_1) {
  return int(tablelookup("sp/allChallengesTable.csv", 0, var_0, 6 + (var_1 - 1) * 2));
}

buildchallengetableinfo(var_0, var_1) {
  var_2 = 0;
  var_3 = tablelookupbyrow(var_0, 0, 0);

  for(var_4 = 1; var_3 != ""; var_4++) {
    level.challengeinfo[var_3] = [];
    level.challengeinfo[var_3]["targetval"] = [];
    level.challengeinfo[var_3]["reward"] = [];
    level.challengeinfo[var_3]["type"] = var_1;

    for(var_5 = 1; var_5 < 11; var_5++) {
      var_6 = challenge_targetval(var_0, var_3, var_5);
      var_7 = challenge_rewardval(var_0, var_3, var_5);

      if(var_6 == 0) {
        break;
      }

      level.challengeinfo[var_3]["targetval"][var_5] = var_6;
      level.challengeinfo[var_3]["reward"][var_5] = var_7;
      var_2 = var_2 + var_7;
    }

    var_3 = tablelookupbyrow(var_0, var_4, 0);
  }

  return int(var_2);
}

_id_12B5() {
  level.challengeinfo = [];
  var_0 = 0;
  var_0 = var_0 + buildchallengetableinfo("sp/allchallengesTable.csv", 0);
  var_1 = tablelookupbyrow("sp/challengeTable.csv", 0, 4);

  for(var_2 = 1; var_1 != ""; var_2++) {
    var_3 = tablelookupbyrow(var_1, 0, 0);

    for(var_4 = 1; var_3 != ""; var_4++) {
      var_5 = tablelookup(var_1, 0, var_3, 1);

      if(var_5 != "") {
        level.challengeinfo[var_3]["requirement"] = var_5;
      }
      var_3 = tablelookupbyrow(var_1, var_4, 0);
    }

    var_1 = tablelookupbyrow("sp/challengeTable.csv", var_2, 4);
  }
}

challengesplashnotify(var_0) {
  self endon("disconnect");
  waittillframeend;
  wait 0.05;
  var_1 = ch_getstate(var_0) - 1;
  var_2 = ch_gettarget(var_0, var_1);

  if(var_2 == 0) {
    var_2 = 1;
  }
  var_3 = spawnStruct();
  var_3.type = "challenge";
  var_3.optionalnumber = var_2;
  var_3.name = var_0;
  var_3.sound = tablelookup("sp/splashTable.csv", 0, var_3.name, 9);
  var_3.slot = 0;
  thread maps\_rank::actionnotify(var_3);
}

updatechallenges() {
  self.challengedata = [];
  wait 0.05;

  foreach(var_4, var_1 in level.challengeinfo) {
    self.challengedata[var_4] = 0;

    if(!self isitemunlocked(var_4)) {
      continue;
    }
    if(isDefined(var_1["requirement"]) && !self isitemunlocked(var_1["requirement"])) {
      continue;
    }
    var_2 = 0;
    var_3 = var_4;
    var_2 = ch_getstate(var_4);

    if(var_2 == 0) {
      ch_setstate(var_4, 1);
      var_2 = 1;
    }

    self.challengedata[var_4] = var_2;
  }
}

giverankxpafterwait(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  wait 0.25;
  maps\_utility::_id_12BE("challenge", level.challengeinfo[var_0]["reward"][var_1]);
}

processchallenge(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  var_3 = getchallengestatus(var_0);

  if(var_3 == 0) {
    return;
  }
  if(var_3 > level.challengeinfo[var_0]["targetval"].size) {
    return;
  }
  var_4 = ch_getprogress(var_0);

  if(isDefined(var_2) && var_2) {
    var_5 = var_1;
  } else {
    var_5 = var_4 + var_1;
  }
  var_6 = level.challengeinfo[var_0]["targetval"][var_3];

  if(var_5 >= var_6) {
    var_7 = 1;
    var_5 = var_6;
  } else {
    var_7 = 0;
  }
  if(var_4 < var_5) {
    ch_setprogress(var_0, var_5);
  }
  if(var_7) {
    thread giverankxpafterwait(var_0, var_3);
    var_3++;
    ch_setstate(var_0, var_3);
    self.challengedata[var_0] = var_3;
    thread challengesplashnotify(var_0);
  }
}

initnotifymessage() {
  if(maps\_utility::_id_12C1()) {
    var_0 = 2.5;
    var_1 = 1.75;
    var_2 = 24;
    var_3 = "objective";
    var_4 = "TOP";
    var_5 = "BOTTOM";
    var_6 = 30;
    var_7 = 0;
  } else {
    var_0 = 2.5;
    var_1 = 1.75;
    var_2 = 30;
    var_3 = "objective";
    var_4 = "TOP";
    var_5 = "BOTTOM";
    var_6 = 30;
    var_7 = 0;
  }

  self.notifytitle = maps\_hud_util::createserverclientfontstring(var_3, var_0);
  self.notifytitle maps\_hud_util::setpoint(var_4, undefined, var_7, var_6);
  self.notifytitle.glowcolor = (0.2, 0.3, 0.7);
  self.notifytitle.glowalpha = 1;
  self.notifytitle.hidewheninmenu = 1;
  self.notifytitle.archived = 0;
  self.notifytitle.alpha = 0;
  self.notifytext = maps\_hud_util::createserverclientfontstring(var_3, var_1);
  self.notifytext maps\_hud_util::setparent(self.notifytitle);
  self.notifytext maps\_hud_util::setpoint(var_4, var_5, 0, 0);
  self.notifytext.glowcolor = (0.2, 0.3, 0.7);
  self.notifytext.glowalpha = 1;
  self.notifytext.hidewheninmenu = 1;
  self.notifytext.archived = 0;
  self.notifytext.alpha = 0;
  self.notifytext2 = maps\_hud_util::createserverclientfontstring(var_3, var_1);
  self.notifytext2 maps\_hud_util::setparent(self.notifytitle);
  self.notifytext2 maps\_hud_util::setpoint(var_4, var_5, 0, 0);
  self.notifytext2.glowcolor = (0.2, 0.3, 0.7);
  self.notifytext2.glowalpha = 1;
  self.notifytext2.hidewheninmenu = 1;
  self.notifytext2.archived = 0;
  self.notifytext2.alpha = 0;
  self.notifyicon = maps\_hud_util::createclienticon("white", var_2, var_2);
  self.notifyicon maps\_hud_util::setparent(self.notifytext2);
  self.notifyicon maps\_hud_util::setpoint(var_4, var_5, 0, 0);
  self.notifyicon.hidewheninmenu = 1;
  self.notifyicon.archived = 0;
  self.notifyicon.alpha = 0;
  self._id_12C6 = 0;
  self._id_12C7 = [];
  self.doingsplash = [];
  self.doingsplash[0] = undefined;
  self.doingsplash[1] = undefined;
  self.doingsplash[2] = undefined;
  self.doingsplash[3] = undefined;
  self.splashqueue = [];
  self.splashqueue[0] = [];
  self.splashqueue[1] = [];
  self.splashqueue[2] = [];
  self.splashqueue[3] = [];
}