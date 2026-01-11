/*******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\rank.gsc
*******************************/

init() {
  level.scoreinfo = [];
  var_00 = getdvarint("online_mp_xpscale");
  if(var_00 > 4 || var_00 < 0) {
    exitlevel(0);
  }

  addglobalrankxpmultiplier(var_00, "online_mp_xpscale");
  level.ranktable = [];
  level.weaponranktable = [];
  level.maxrank = int(tablelookup("mp\rankTable.csv", 0, "maxrank", 1));
  for(var_01 = 0; var_01 <= level.maxrank; var_01++) {
    level.ranktable[var_01]["minXP"] = tablelookup("mp\rankTable.csv", 0, var_01, 2);
    level.ranktable[var_01]["xpToNext"] = tablelookup("mp\rankTable.csv", 0, var_01, 3);
    level.ranktable[var_01]["maxXP"] = tablelookup("mp\rankTable.csv", 0, var_01, 7);
    level.ranktable[var_01]["splash"] = tablelookup("mp\rankTable.csv", 0, var_01, 15);
  }

  scripts\mp\weaponrank::init();
  scripts\mp\missions::func_31D7();
  level.prestigeextras = [];
  var_02 = 0;
  for(;;) {
    var_03 = tablelookupbyrow("mp\unlocks\prestigeExtrasUnlocks.csv", var_02, 0);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    level.prestigeextras[var_03] = 1;
    var_02++;
  }

  level thread onplayerconnect();
}

isregisteredevent(param_00) {
  if(isDefined(level.scoreinfo[param_00])) {
    return 1;
  }

  return 0;
}

registerscoreinfo(param_00, param_01, param_02) {
  level.scoreinfo[param_00][param_01] = param_02;
  if(param_00 == "kill" && param_01 == "value") {
    setomnvar("ui_game_type_kill_value", int(param_02));
  }
}

getscoreinfovalue(param_00) {
  var_01 = "scr_" + level.gametype + "_score_" + param_00;
  if(getdvar(var_01) != "") {
    return getdvarint(var_01);
  }

  return level.scoreinfo[param_00]["value"];
}

getscoreinfocategory(param_00, param_01) {
  switch (param_01) {
    case "value":
      var_02 = "scr_" + level.gametype + "_score_" + param_00;
      if(getdvar(var_02) != "") {
        return getdvarint(var_02);
      } else {
        return level.scoreinfo[param_00]["value"];
      }

      break;

    default:
      return level.scoreinfo[param_00][param_01];
  }
}

getrankinfominxp(param_00) {
  return int(level.ranktable[param_00]["minXP"]);
}

getrankinfoxpamt(param_00) {
  return int(level.ranktable[param_00]["xpToNext"]);
}

getrankinfomaxxp(param_00) {
  return int(level.ranktable[param_00]["maxXP"]);
}

_meth_80D0(param_00) {
  var_01 = getdvarint("scr_beta_max_level", 0);
  if(var_01 > 0 && param_00 + 1 >= var_01) {
    return "ranked_up_beta_max";
  }

  return level.ranktable[param_00]["splash"];
}

getrankinfofull(param_00) {
  return tablelookupistring("mp\rankTable.csv", 0, param_00, 16);
}

getrankinfoicon(param_00, param_01) {
  return tablelookup("mp\rankIconTable.csv", 0, param_00, param_01 + 1);
}

getrankinfolevel(param_00) {
  return int(tablelookup("mp\rankTable.csv", 0, param_00, 13));
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00)) {
      if(var_00 scripts\mp\utility::rankingenabled()) {
        var_00.pers["rankxp"] = var_00 getplayerdata("mp", "progression", "playerLevel", "xp");
        var_01 = var_00 getplayerdata("mp", "progression", "playerLevel", "prestige");
        if(!isDefined(var_00.pers["xpEarnedThisMatch"])) {
          var_00.pers["xpEarnedThisMatch"] = 0;
        }
      } else {
        var_01 = 0;
        var_00.pers["rankxp"] = 0;
      }
    } else {
      var_01 = 0;
      var_00.pers["rankxp"] = 0;
    }

    var_00.pers["prestige"] = var_01;
    if(var_00.pers["rankxp"] < 0) {
      var_00.pers["rankxp"] = 0;
    }

    var_02 = var_00 getrankforxp(var_00 getrankxp());
    var_00.pers["rank"] = var_02;
    var_00 setrank(var_02, var_01);
    if(var_00.clientid < level.maxlogclients) {
      setmatchdata("players", var_00.clientid, "rank", var_02);
      setmatchdata("players", var_00.clientid, "Prestige", var_01);
      if(!isai(var_00) && scripts\mp\utility::func_D957() || scripts\mp\utility::matchmakinggame()) {
        setmatchdata("players", var_00.clientid, "isSplitscreen", var_00 issplitscreenplayer());
      }
    }

    var_00.pers["participation"] = 0;
    var_00.var_EC53 = 0;
    var_00.scorepointsqueue = 0;
    var_00.scoreeventqueue = [];
    var_00.var_D702 = 0;
    var_00 setclientdvar("ui_promotion", 0);
    if(!isDefined(var_00.pers["summary"])) {
      var_00.pers["summary"] = [];
      var_00.pers["summary"]["xp"] = 0;
      var_00.pers["summary"]["score"] = 0;
      var_00.pers["summary"]["challenge"] = 0;
      var_00.pers["summary"]["match"] = 0;
      var_00.pers["summary"]["misc"] = 0;
      var_00.pers["summary"]["medal"] = 0;
      var_00.pers["summary"]["bonusXP"] = 0;
    }

    var_00 setclientdvar("ui_opensummary", 0);
    var_00 thread scripts\mp\missions::func_12E71();
    var_00 thread onplayerspawned();
    var_00 thread func_C575();
    if(var_00 scripts\mp\utility::rankingenabled()) {
      var_03 = getdvarint("online_mp_party_xpscale");
      var_04 = var_00 _meth_85BE() > 1;
      if(var_04) {
        var_00 addrankxpmultiplier(var_03, "online_mp_party_xpscale");
      }

      if(var_00 getplayerdata("mp", "prestigeDoubleWeaponXp")) {
        var_00.var_D882 = 1;
      } else {
        var_00.var_D882 = 0;
      }
    }

    var_00.scoreeventcount = 0;
    var_00.scoreeventlistindex = 0;
    var_00 setclientomnvar("ui_score_event_control", -1);
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    if(isai(self)) {
      self.pers["rankxp"] = ::scripts\mp\utility::get_rank_xp_for_bot();
    } else if(!level.rankedmatch) {
      self.pers["rankxp"] = 0;
    } else {}

    playerupdaterank();
  }
}

playerupdaterank() {
  if(self.pers["rankxp"] < 0) {
    self.pers["rankxp"] = 0;
  }

  var_00 = getrankforxp(getrankxp());
  self.pers["rank"] = var_00;
  if(isai(self) || !isDefined(self.pers["prestige"])) {
    if(level.rankedmatch && isDefined(self.bufferedstats)) {
      var_01 = detachshieldmodel();
    } else {
      var_01 = 0;
    }

    self setrank(var_00, var_01);
    self.pers["prestige"] = var_01;
  }

  if(isDefined(self.clientid) && self.clientid < level.maxlogclients) {
    setmatchdata("players", self.clientid, "rank", var_00);
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

giverankxp(param_00, param_01, param_02) {
  self endon("disconnect");
  if(isDefined(self.triggerportableradarping) && !isbot(self)) {
    self.triggerportableradarping giverankxp(param_00, param_01, param_02);
    return;
  }

  if(isai(self) || !isplayer(self)) {
    return;
  }

  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(!isDefined(param_01) || param_01 == 0) {
    return;
  }

  var_03 = getscoreinfocategory(param_00, "group");
  if(!isDefined(param_02)) {
    if(var_03 == "medal" || var_03 == "kill_killstreak") {
      param_02 = self getcurrentweapon();
    }
  }

  if(!isDefined(level.var_72DA) || !level.var_72DA) {
    if(level.teambased && !level.teamcount["allies"] || !level.teamcount["axis"]) {
      return;
    } else if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2) {
      return;
    }
  }

  var_04 = getscoreinfocategory(param_00, "allowBonus");
  var_05 = 1;
  var_06 = param_01;
  var_07 = 0;
  if(scripts\mp\utility::istrue(var_04)) {
    var_05 = _meth_80D4();
    var_06 = int(param_01 * var_05);
    var_07 = int(max(var_06 - param_01, 0));
  }

  var_08 = getrankxp();
  func_93E3(var_06);
  if(func_12EFA(var_08)) {
    thread func_12EFB();
  }

  func_11390();
  if(isDefined(param_02) && scripts\mp\weaponrank::func_13CCA(param_02)) {
    thread scripts\mp\weaponrank::_meth_8394(param_02, param_00, param_01);
  }

  func_DDF7(param_00, param_01, var_07);
  var_09 = detachshieldmodel();
  var_0A = getrank();
  thread scripts\mp\analyticslog::logevent_giveplayerxp(var_09, var_0A, param_01, param_00);
}

func_DDF7(param_00, param_01, param_02) {
  var_03 = param_01 + param_02;
  var_04 = getscoreinfocategory(param_00, "group");
  if(!isDefined(var_04) || var_04 == "") {
    self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + param_01;
    self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
    return;
  }

  switch (var_04) {
    case "match_bonus":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + param_01;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
      break;

    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + param_01;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
      break;

    case "medal":
      self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + param_01;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
      break;

    default:
      self.pers["summary"]["score"] = self.pers["summary"]["score"] + param_01;
      self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
      self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
      break;
  }
}

func_12EFA(param_00) {
  var_01 = getrank();
  if(var_01 == self.pers["rank"] || self.pers["rank"] == level.maxrank) {
    return 0;
  }

  var_02 = self.pers["rank"];
  self.pers["rank"] = var_01;
  self setrank(var_01);
  return 1;
}

func_12EFB() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_00 = self.pers["team"];
  if(!isDefined(var_00)) {
    return;
  }

  if(!scripts\mp\utility::levelflag("game_over")) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var_01 = self.pers["rank"];
  var_02 = _meth_80D0(var_01);
  if(isDefined(var_02) && var_02 != "") {
    thread scripts\mp\hud_message::showsplash(var_02, var_01 + 1);
  }

  for(var_03 = 0; var_03 < level.players.size; var_03++) {
    var_04 = level.players[var_03];
    var_05 = var_04.pers["team"];
    if(isDefined(var_05) && var_05 == var_00) {
      var_04 iprintln(&"RANK_PLAYER_WAS_PROMOTED", self, var_01 + 1);
    }
  }
}

queuescorepointspopup(param_00) {
  self.scorepointsqueue = self.scorepointsqueue + param_00;
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

scorepointspopup(param_00, param_01) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  if(param_00 == 0) {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self) && !self ismlgspectator()) {
    if(!scripts\mp\utility::istrue(param_01) || scripts\mp\utility::isinkillcam()) {
      queuescorepointspopup(param_00);
      thread func_6F79();
      return;
    }
  }

  self notify("scorePointsPopup");
  self endon("scorePointsPopup");
  self.var_EC53 = self.var_EC53 + param_00;
  self setclientomnvar("ui_points_popup", self.var_EC53);
  self setclientomnvar("ui_points_popup_notify", gettime());
  wait(1);
  self.var_EC53 = 0;
}

func_C16F() {
  scripts\engine\utility::waitframe();
  level notify("update_player_score", self, self.var_EC53);
}

queuescoreeventpopup(param_00) {
  self.scoreeventqueue[self.scoreeventqueue.size] = param_00;
}

flushscoreeventpopupqueue() {
  foreach(var_01 in self.scoreeventqueue) {
    scoreeventpopup(var_01);
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

scoreeventpopup(param_00) {
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping scoreeventpopup(param_00);
  }

  if(!isplayer(self)) {
    return;
  }

  var_01 = getscoreinfocategory(param_00, "eventID");
  var_02 = getscoreinfocategory(param_00, "text");
  if(!isDefined(var_01) || var_01 < 0 || !isDefined(var_02) || var_02 == "") {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self) && !self ismlgspectator()) {
    queuescoreeventpopup(param_00);
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

  self setclientomnvar("ui_score_event_list_" + self.scoreeventlistindex, var_01);
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
  var_00 = self.pers["rankxp"];
  var_01 = self.pers["rank"];
  if(var_00 < getrankinfominxp(var_01) + getrankinfoxpamt(var_01)) {
    return var_01;
  }

  return getrankforxp(var_00);
}

getrankforxp(param_00) {
  for(var_01 = level.maxrank; var_01 > 0; var_01--) {
    if(param_00 >= getrankinfominxp(var_01) && param_00 < getrankinfominxp(var_01) + getrankinfoxpamt(var_01)) {
      return var_01;
    }
  }

  return var_01;
}

getmatchbonusspm() {
  var_00 = getrank() + 1;
  return 3 + var_00 * 0.5 * 10;
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

func_93E3(param_00) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(isai(self)) {
    return;
  }

  var_01 = getdvarint("scr_beta_max_level", 0);
  if(var_01 > 0 && getrank() + 1 >= var_01) {
    param_00 = 0;
  }

  var_02 = getrankxp();
  var_03 = int(min(var_02 + param_00, getrankinfomaxxp(level.maxrank) - 1));
  if(self.pers["rank"] == level.maxrank && var_03 >= getrankinfomaxxp(level.maxrank)) {
    var_03 = getrankinfomaxxp(level.maxrank);
  }

  self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + param_00;
  self.pers["rankxp"] = var_03;
}

func_11390() {
  var_00 = getrankxp();
  self setplayerdata("mp", "progression", "playerLevel", "xp", var_00);
}

delayplayerscorepopup(param_00, param_01, param_02) {
  wait(param_00);
  thread scripts\mp\utility::giveunifiedpoints(param_01);
}

addglobalrankxpmultiplier(param_00, param_01) {
  level addrankxpmultiplier(param_00, param_01);
}

func_7ED9() {
  var_00 = level getrankxpmultiplier();
  if(var_00 > 4 || var_00 < 0) {
    exitlevel(0);
  }

  return var_00;
}

addrankxpmultiplier(param_00, param_01) {
  if(!isDefined(self.rankxpmultipliers)) {
    self.rankxpmultipliers = [];
  }

  if(isDefined(self.rankxpmultipliers[param_01])) {
    self.rankxpmultipliers[param_01] = max(self.rankxpmultipliers[param_01], param_00);
    return;
  }

  self.rankxpmultipliers[param_01] = param_00;
}

getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers)) {
    return 1;
  }

  var_00 = 1;
  foreach(var_02 in self.rankxpmultipliers) {
    if(!isDefined(var_02)) {
      continue;
    }

    var_00 = var_00 * var_02;
  }

  return var_00;
}

removeglobalrankxpmultiplier(param_00) {
  level removerankxpmultiplier(param_00);
}

removerankxpmultiplier(param_00) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }

  if(!isDefined(self.rankxpmultipliers[param_00])) {
    return;
  }

  self.rankxpmultipliers[param_00] = undefined;
}

addteamrankxpmultiplier(param_00, param_01, param_02) {
  if(!level.teambased) {
    param_01 = "all";
  }

  if(!isDefined(self.teamrankxpmultipliers)) {
    level.teamrankxpmultipliers = [];
  }

  if(!isDefined(level.teamrankxpmultipliers[param_01])) {
    level.teamrankxpmultipliers[param_01] = [];
  }

  if(isDefined(level.teamrankxpmultipliers[param_01][param_02])) {
    level.teamrankxpmultipliers[param_01][param_02] = max(self.teamrankxpmultipliers[param_01][param_02], param_00);
    return;
  }

  level.teamrankxpmultipliers[param_01][param_02] = param_00;
}

removeteamrankxpmultiplier(param_00, param_01) {
  if(!level.teambased) {
    param_00 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[param_00])) {
    return;
  }

  if(!isDefined(level.teamrankxpmultipliers[param_00][param_01])) {
    return;
  }

  level.teamrankxpmultipliers[param_00][param_01] = undefined;
}

_meth_81B6(param_00) {
  if(!level.teambased) {
    param_00 = "all";
  }

  if(!isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[param_00])) {
    return 1;
  }

  var_01 = 1;
  foreach(var_03 in level.teamrankxpmultipliers[param_00]) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_01 = var_01 * var_03;
  }

  return var_01;
}

_meth_80D4() {
  var_00 = getrankxpmultiplier();
  var_01 = func_7ED9();
  var_02 = _meth_81B6(self.team);
  return var_00 * var_01 * var_02;
}