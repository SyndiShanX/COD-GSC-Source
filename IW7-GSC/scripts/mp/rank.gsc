/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\rank.gsc
*********************************************/

init() {
  level.scoreinfo = [];
  var_0 = getdvarint("online_mp_xpscale");
  if(var_0 > 4 || var_0 < 0) {
    exitlevel(0);
  }

  addglobalrankxpmultiplier(var_0, "online_mp_xpscale");
  level.ranktable = [];
  level.weaponranktable = [];
  level.maxrank = int(tablelookup("mp\rankTable.csv", 0, "maxrank", 1));
  for(var_1 = 0; var_1 <= level.maxrank; var_1++) {
    level.ranktable[var_1]["minXP"] = tablelookup("mp\rankTable.csv", 0, var_1, 2);
    level.ranktable[var_1]["xpToNext"] = tablelookup("mp\rankTable.csv", 0, var_1, 3);
    level.ranktable[var_1]["maxXP"] = tablelookup("mp\rankTable.csv", 0, var_1, 7);
    level.ranktable[var_1]["splash"] = tablelookup("mp\rankTable.csv", 0, var_1, 15);
  }

  scripts\mp\weaponrank::init();
  scripts\mp\missions::func_31D7();
  level.prestigeextras = [];
  var_2 = 0;
  for(;;) {
    var_3 = tablelookupbyrow("mp\unlocks\prestigeExtrasUnlocks.csv", var_2, 0);
    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    level.prestigeextras[var_3] = 1;
    var_2++;
  }

  level thread onplayerconnect();
}

isregisteredevent(var_0) {
  if(isDefined(level.scoreinfo[var_0])) {
    return 1;
  }

  return 0;
}

registerscoreinfo(var_0, var_1, var_2) {
  level.scoreinfo[var_0][var_1] = var_2;
  if(var_0 == "kill" && var_1 == "value") {
    setomnvar("ui_game_type_kill_value", int(var_2));
  }
}

getscoreinfovalue(var_0) {
  var_1 = "scr_" + level.gametype + "_score_" + var_0;
  if(getdvar(var_1) != "") {
    return getdvarint(var_1);
  }

  return level.scoreinfo[var_0]["value"];
}

getscoreinfocategory(var_0, var_1) {
  switch (var_1) {
    case "value":
      var_2 = "scr_" + level.gametype + "_score_" + var_0;
      if(getdvar(var_2) != "") {
        return getdvarint(var_2);
      } else {
        return level.scoreinfo[var_0]["value"];
      }

      break;

    default:
      return level.scoreinfo[var_0][var_1];
  }
}

getrankinfominxp(var_0) {
  return int(level.ranktable[var_0]["minXP"]);
}

getrankinfoxpamt(var_0) {
  return int(level.ranktable[var_0]["xpToNext"]);
}

getrankinfomaxxp(var_0) {
  return int(level.ranktable[var_0]["maxXP"]);
}

func_80D0(var_0) {
  var_1 = getdvarint("scr_beta_max_level", 0);
  if(var_1 > 0 && var_0 + 1 >= var_1) {
    return "ranked_up_beta_max";
  }

  return level.ranktable[var_0]["splash"];
}

getrankinfofull(var_0) {
  return tablelookupistring("mp\rankTable.csv", 0, var_0, 16);
}

getrankinfoicon(var_0, var_1) {
  return tablelookup("mp\rankIconTable.csv", 0, var_0, var_1 + 1);
}

getrankinfolevel(var_0) {
  return int(tablelookup("mp\rankTable.csv", 0, var_0, 13));
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    if(!isai(var_0)) {
      if(var_0 scripts\mp\utility::rankingenabled()) {
        var_0.pers["rankxp"] = var_0 getplayerdata("mp", "progression", "playerLevel", "xp");
        var_1 = var_0 getplayerdata("mp", "progression", "playerLevel", "prestige");
        if(!isDefined(var_0.pers["xpEarnedThisMatch"])) {
          var_0.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        var_1 = 0;
        var_0.pers["rankxp"] = 0;
      }
    } else {
      var_1 = 0;
      var_0.pers["rankxp"] = 0;
    }

    var_0.pers["prestige"] = var_1;
    if(var_0.pers["rankxp"] < 0) {
      var_0.pers["rankxp"] = 0;
    }

    var_2 = var_0 getrankforxp(var_0 getrankxp());
    var_0.pers["rank"] = var_2;
    var_0 setrank(var_2, var_1);
    if(var_0.clientid < level.maxlogclients) {
      setmatchdata("players", var_0.clientid, "rank", var_2);
      setmatchdata("players", var_0.clientid, "Prestige", var_1);
      if(!isai(var_0) && scripts\mp\utility::func_D957() || scripts\mp\utility::matchmakinggame()) {
        setmatchdata("players", var_0.clientid, "isSplitscreen", var_0 issplitscreenplayer());
      }
    }

    var_0.pers["participation"] = 0;
    var_0.var_EC53 = 0;
    var_0.scorepointsqueue = 0;
    var_0.scoreeventqueue = [];
    var_0.var_D702 = 0;
    var_0 setclientdvar("ui_promotion", 0);
    if(!isDefined(var_0.pers["summary"])) {
      var_0.pers["summary"] = [];
      var_0.pers["summary"]["xp"] = 0;
      var_0.pers["summary"]["score"] = 0;
      var_0.pers["summary"]["challenge"] = 0;
      var_0.pers["summary"]["match"] = 0;
      var_0.pers["summary"]["misc"] = 0;
      var_0.pers["summary"]["medal"] = 0;
      var_0.pers["summary"]["bonusXP"] = 0;
    }

    var_0 setclientdvar("ui_opensummary", 0);
    var_0 thread scripts\mp\missions::func_12E71();
    var_0 thread onplayerspawned();
    var_0 thread func_C575();
    if(var_0 scripts\mp\utility::rankingenabled()) {
      var_3 = getdvarint("online_mp_party_xpscale");
      var_4 = var_0 func_85BE() > 1;
      if(var_4) {
        var_0 addrankxpmultiplier(var_3, "online_mp_party_xpscale");
      }

      if(var_0 getplayerdata("mp", "prestigeDoubleWeaponXp")) {
        var_0.var_D882 = 1;
      } else {
        var_0.var_D882 = 0;
      }
    }

    var_0.scoreeventcount = 0;
    var_0.scoreeventlistindex = 0;
    var_0 setclientomnvar("ui_score_event_control", -1);
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    if(isai(self)) {
      self.pers["rankxp"] = scripts\mp\utility::get_rank_xp_for_bot();
    } else if(!level.rankedmatch) {
      self.pers["rankxp"] = 0;
    }

    playerupdaterank();
  }
}

playerupdaterank() {
  if(self.pers["rankxp"] < 0) {
    self.pers["rankxp"] = 0;
  }

  var_0 = getrankforxp(getrankxp());
  self.pers["rank"] = var_0;
  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.rankedmatch && isDefined(self.bufferedstats)) {
      var_1 = detachshieldmodel();
    } else {
      var_1 = 0;
    }

    self setrank(var_0, var_1);
    self.pers["prestige"] = var_1;
  }

  if(isDefined(self.clientid) && self.clientid < level.maxlogclients) {
    setmatchdata("players", self.clientid, "rank", var_0);
    setmatchdata("players", self.clientid, "Prestige", self.pers["prestige"]);
  }
}

func_C575() {
  self endon("disconnect");
  for(;;) {
    scripts\engine\utility::waittill_any_3("giveLoadout", "changed_kit");
    if(issubstr(self.class, "custom")) {
      if(!level.rankedmatch) {
        self.pers["rankxp"] = 0;
        continue;
      }

      if(isai(self)) {
        self.pers["rankxp"] = 0;
        continue;
      }
    }
  }
}

giverankxp(var_0, var_1, var_2) {
  self endon("disconnect");
  if(isDefined(self.triggerportableradarping) && !isbot(self)) {
    self.triggerportableradarping giverankxp(var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isplayer(self)) {
    return;
  }

  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }

  var_3 = getscoreinfocategory(var_0, "group");
  if(!isDefined(var_2)) {
    if(var_3 == "medal" || var_3 == "kill_killstreak") {
      var_2 = self getcurrentweapon();
    }
  }

  if(!isDefined(level.var_72DA) || !level.var_72DA) {
    if(level.teambased && !level.teamcount["allies"] || !level.teamcount["axis"]) {
      return;
    } else if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2) {
      return;
    }
  }

  var_4 = getscoreinfocategory(var_0, "allowBonus");
  var_5 = 1;
  var_6 = var_1;
  var_7 = 0;
  if(scripts\mp\utility::istrue(var_4)) {
    var_5 = func_80D4();
    var_6 = int(var_1 * var_5);
    var_7 = int(max(var_6 - var_1, 0));
  }

  var_8 = getrankxp();
  func_93E3(var_6);
  if(func_12EFA(var_8)) {
    thread func_12EFB();
  }

  func_11390();
  if(isDefined(var_2) && scripts\mp\weaponrank::func_13CCA(var_2)) {
    thread scripts\mp\weaponrank::func_8394(var_2, var_0, var_1);
  }

  func_DDF7(var_0, var_1, var_7);
  var_9 = detachshieldmodel();
  var_0A = getrank();
  thread scripts\mp\analyticslog::logevent_giveplayerxp(var_9, var_0A, var_1, var_0);
}

func_DDF7(var_0, var_1, var_2) {
  var_3 = var_1 + var_2;
  var_4 = getscoreinfocategory(var_0, "group");
  if(!isDefined(var_4) || var_4 == "") {
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_1;
    self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
    return;
  }

  switch (var_4) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;

    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;

    case "medal":
      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;

    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_1;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + var_2;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_3;
      break;
  }
}

func_12EFA(var_0) {
  var_1 = getrank();
  if(var_1 == self.pers["rank"] || self.pers["rank"] == level.maxrank) {
    return 0;
  }

  var_2 = self.pers["rank"];
  self.pers["rank"] = var_1;
  self setrank(var_1);
  return 1;
}

func_12EFB() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_0 = self.pers["team"];
  if(!isDefined(var_0)) {
    return;
  }

  if(!scripts\mp\utility::levelflag("game_over")) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var_1 = self.pers["rank"];
  var_2 = func_80D0(var_1);
  if(isDefined(var_2) && var_2 != "") {
    thread scripts\mp\hud_message::showsplash(var_2, var_1 + 1);
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];
    var_5 = var_4.pers["team"];
    if(isDefined(var_5) && var_5 == var_0) {
      var_4 iprintln(&"RANK_PLAYER_WAS_PROMOTED", self, var_1 + 1);
    }
  }
}

queuescorepointspopup(var_0) {
  self.scorepointsqueue = self.scorepointsqueue + var_0;
}

flushscorepointspopupqueue() {
  scorepointspopup(self.scorepointsqueue);
  self.scorepointsqueue = 0;
}

func_6F79() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScorePointsPopupQueueOnspawn()");
  self endon("flushScorePointsPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait(0.1);
  flushscorepointspopupqueue();
}

scorepointspopup(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  if(var_0 == 0) {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self) && !self ismlgspectator()) {
    if(!scripts\mp\utility::istrue(var_1) || scripts\mp\utility::isinkillcam()) {
      queuescorepointspopup(var_0);
      thread func_6F79();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self.var_EC53 = self.var_EC53 + var_0;
  self setclientomnvar("ui_points_popup", self.var_EC53);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait(1);
  self.var_EC53 = 0;
}

func_C16F() {
  scripts\engine\utility::waitframe();
  level notify("update_player_score", self, self.var_EC53);
}

queuescoreeventpopup(var_0) {
  self.scoreeventqueue[self.scoreeventqueue.size] = var_0;
}

flushscoreeventpopupqueue() {
  foreach(var_1 in self.scoreeventqueue) {
    scoreeventpopup(var_1);
  }

  self.scoreeventqueue = [];
}

flushscoreeventpopupqueueonspawn() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self notify("flushScoreEventPopupQueueOnspawn()");
  self endon("flushScoreEventPopupQueueOnspawn()");
  self waittill("spawned_player");
  wait(0.1);
  flushscoreeventpopupqueue();
}

scoreeventpopup(var_0) {
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping scoreeventpopup(var_0);
  }

  if(!isplayer(self)) {
    return;
  }

  var_1 = getscoreinfocategory(var_0, "eventID");
  var_2 = getscoreinfocategory(var_0, "text");
  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "") {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self) && !self ismlgspectator()) {
    queuescoreeventpopup(var_0);
    thread flushscoreeventpopupqueueonspawn();
    return;
  }

  if(!isDefined(self.scoreeventlistsize)) {
    self.scoreeventlistsize = 1;
    thread clearscoreeventlistafterwait();
  } else {
    self.scoreeventlistsize++;
    if(self.scoreeventlistsize > 8) {
      self.scoreeventlistsize = 8;
      return;
    }
  }

  self setclientomnvar("ui_score_event_list_" + self.scoreeventlistindex, var_1);
  self setclientomnvar("ui_score_event_control", self.scoreeventcount % 16);
  self.scoreeventlistindex++;
  self.scoreeventlistindex = self.scoreeventlistindex % 8;
  self.scoreeventcount++;
}

clearscoreeventlistafterwait() {
  self endon("disconnect");
  self notify("clearScoreEventListAfterWait()");
  self endon("clearScoreEventListAfterWait()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);
  self.scoreeventlistsize = undefined;
}

getrank() {
  var_0 = self.pers["rankxp"];
  var_1 = self.pers["rank"];
  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
    return var_1;
  }

  return getrankforxp(var_0);
}

getrankforxp(var_0) {
  for(var_1 = level.maxrank; var_1 > 0; var_1--) {
    if(var_0 >= getrankinfominxp(var_1) && var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
      return var_1;
    }
  }

  return var_1;
}

getmatchbonusspm() {
  var_0 = getrank() + 1;
  return 3 + var_0 * 0.5 * 10;
}

detachshieldmodel() {
  if(isai(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  }

  return self getplayerdata("mp", "progression", "playerLevel", "prestige");
}

getrankxp() {
  return self.pers["rankxp"];
}

func_93E3(var_0) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var_1 = getdvarint("scr_beta_max_level", 0);
  if(var_1 > 0 && getrank() + 1 >= var_1) {
    var_0 = 0;
  }

  var_2 = getrankxp();
  var_3 = int(min(var_2 + var_0, getrankinfomaxxp(level.maxrank) - 1));
  if(self.pers["rank"] == level.maxrank && var_3 >= getrankinfomaxxp(level.maxrank)) {
    var_3 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + var_0;
  self.pers["rankxp"] = var_3;
}

func_11390() {
  var_0 = getrankxp();
  self setplayerdata("mp", "progression", "playerLevel", "xp", var_0);
}

delayplayerscorepopup(var_0, var_1, var_2) {
  wait(var_0);
  thread scripts\mp\utility::giveunifiedpoints(var_1);
}

addglobalrankxpmultiplier(var_0, var_1) {
  level addrankxpmultiplier(var_0, var_1);
}

func_7ED9() {
  var_0 = level getrankxpmultiplier();
  if(var_0 > 4 || var_0 < 0) {
    exitlevel(0);
  }

  return var_0;
}

addrankxpmultiplier(var_0, var_1) {
  if(!isDefined(self.rankxpmultipliers)) {
    self.rankxpmultipliers = [];
  }

  if(isDefined(self.rankxpmultipliers[var_1])) {
    self.rankxpmultipliers[var_1] = max(self.rankxpmultipliers[var_1], var_0);
    return;
  }

  self.rankxpmultipliers[var_1] = var_0;
}

getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers)) {
    return 1;
  }

  var_0 = 1;
  foreach(var_2 in self.rankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_0 = var_0 * var_2;
  }

  return var_0;
}

removeglobalrankxpmultiplier(var_0) {
  level removerankxpmultiplier(var_0);
}

removerankxpmultiplier(var_0) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers[var_0])) {
    return;
  }

  self.rankxpmultipliers[var_0] = undefined;
}

addteamrankxpmultiplier(var_0, var_1, var_2) {
  if(!level.teambased) {
    var_1 = "all";
  }

  if(!isDefined(self.teamrankxpmultipliers)) {
    level.teamrankxpmultipliers = [];
  }

  if(!isDefined(level.teamrankxpmultipliers[var_1])) {
    level.teamrankxpmultipliers[var_1] = [];
  }

  if(isDefined(level.teamrankxpmultipliers[var_1][var_2])) {
    level.teamrankxpmultipliers[var_1][var_2] = max(self.teamrankxpmultipliers[var_1][var_2], var_0);
    return;
  }

  level.teamrankxpmultipliers[var_1][var_2] = var_0;
}

removeteamrankxpmultiplier(var_0, var_1) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var_0])) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[var_0][var_1])) {
    return;
  }

  level.teamrankxpmultipliers[var_0][var_1] = undefined;
}

func_81B6(var_0) {
  if(!level.teambased) {
    var_0 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[var_0])) {
    return 1;
  }

  var_1 = 1;
  foreach(var_3 in level.teamrankxpmultipliers[var_0]) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_1 = var_1 * var_3;
  }

  return var_1;
}

func_80D4() {
  var_0 = getrankxpmultiplier();
  var_1 = func_7ED9();
  var_2 = func_81B6(self.team);
  return var_0 * var_1 * var_2;
}