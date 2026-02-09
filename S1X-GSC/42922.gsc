/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42922.gsc
**************************************/

init() {
  level.xpscale = getxpscale();
  level.xpeventinfo = [];
  level.ranktable = [];
  level.maxrank = int(tablelookup("mp/rankTable.csv", 0, "maxrank", 1));
  level.masterprestige = int(tablelookup("mp/rankIconTable.csv", 0, "masterPrestige", 1));
  level.grandmasterprestige = int(tablelookup("mp/rankIconTable.csv", 0, "grandMasterPrestige", 1));
  var_0 = 0;

  for(var_1 = tablelookup("mp/rankTable.csv", 0, var_0, 1); isDefined(var_1) && var_1 != ""; var_1 = tablelookup("mp/rankTable.csv", 0, var_0, 1)) {
    level.ranktable[var_0][1] = tablelookup("mp/rankTable.csv", 0, var_0, 1);
    level.ranktable[var_0][2] = tablelookup("mp/rankTable.csv", 0, var_0, 2);
    level.ranktable[var_0][3] = tablelookup("mp/rankTable.csv", 0, var_0, 3);
    level.ranktable[var_0][7] = tablelookup("mp/rankTable.csv", 0, var_0, 7);
    var_0++;
  }

  maps\mp\gametypes\_missions::buildchallegeinfo();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0) && var_0 maps\mp\_utility::rankingenabled()) {
      var_1 = var_0 getprestigelevel();
      var_2 = var_0 maps\mp\gametypes\_persistence::statget("experience");

      if(var_2 < 0) {
        var_2 = 0;
      }

      var_3 = var_0 gettotalmpxp() - var_2;
      var_4 = var_0 gettotalmpxp();

      if(!maps\mp\_utility::invirtuallobby() && (!isDefined(var_0.pers["gamesPlayedSet"]) || !var_0.pers["gamesPlayedSet"])) {
        var_0 maps\mp\gametypes\_persistence::statadd("gamesPlayed", 1);
        var_0.pers["gamesPlayedSet"] = 1;
      }
    } else if(isai(var_0)) {
      var_0 maps\mp\_utility::set_rank_xp_and_prestige_for_bot();
      var_2 = var_0.pers["rankxp"];
      var_1 = var_0.pers["prestige"];
      var_3 = 0;
      var_4 = var_2;
    } else {
      var_1 = 0;
      var_2 = 0;
      var_3 = 0;
      var_4 = var_2;
    }

    var_0.pers["rankxp"] = var_2;
    var_0.pers["redeemedxp"] = var_3;
    var_0.pers["prestige"] = var_1;

    if(!isDefined(var_0.pers["participation"])) {
      var_0.pers["participation"] = 0;
    }

    var_5 = var_0 getrankforxp(var_0 gettotalxp());
    var_0.pers["rank"] = var_5;
    var_0.xpupdatetotal = 0;
    var_0.postgamepromotion = 0;
    var_0.explosivekills[0] = 0;
    var_0 setrank(var_5, var_1);
    var_0 processprestigemastery(var_1, var_2);

    if(var_0.clientid < level.maxlogclients) {
      setmatchdata("players", var_0.clientid, "Prestige", var_1);
      setmatchdata("players", var_0.clientid, "rankAtStart", maps\mp\_utility::clamptobyte(var_0.pers["rank"]));
    }

    if(!isDefined(var_0.pers["postGameChallenges"])) {
      var_0 setclientdvars("ui_challenge_1_ref", "", "ui_challenge_2_ref", "", "ui_challenge_3_ref", "", "ui_challenge_4_ref", "", "ui_challenge_5_ref", "", "ui_challenge_6_ref", "", "ui_challenge_7_ref", "");
    }

    var_0 setclientdvar("ui_promotion", 0);

    if(!isDefined(var_0.pers["summary"])) {
      var_0.pers["summary"] = [];
      var_0.pers["summary"]["xp"] = 0;
      var_0.pers["summary"]["score"] = 0;
      var_0.pers["summary"]["challenge"] = 0;
      var_0.pers["summary"]["match"] = 0;
      var_0.pers["summary"]["misc"] = 0;
      var_0.pers["summary"]["entitlementXP"] = 0;
      var_0.pers["summary"]["clanWarsXP"] = 0;
      var_0.pers["summary"]["matchStartXp"] = var_4;
    }

    if(getDvar("virtualLobbyActive") != "1") {
      var_0 setclientdvar("ui_opensummary", 0);
      var_0 thread maps\mp\gametypes\_missions::updatechallenges();
    }

    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
  }
}

getxpscale() {
  var_0 = getdvarint("scr_xpscale");

  if(var_0 > 4 || var_0 < 0) {
    exitlevel(0);
  }

  return var_0;
}

isregisteredevent(var_0) {
  if(isDefined(level.xpeventinfo[var_0])) {
    return 1;
  } else {
    return 0;
  }
}

registerxpeventinfo(var_0, var_1, var_2, var_3) {
  level.xpeventinfo[var_0]["value"] = var_1;
  level.xpeventinfo[var_0]["allowPlayerScore"] = 0;
  level.xpeventinfo[var_0]["playSplash"] = 0;

  if(isDefined(var_2) && var_2) {
    level.xpeventinfo[var_0]["allowPlayerScore"] = 1;
  }

  if(isDefined(var_3) && var_3) {
    level.xpeventinfo[var_0]["playSplash"] = 1;
  }
}

allowplayerscore(var_0) {
  return level.xpeventinfo[var_0]["allowPlayerScore"];
}

shouldplaysplash(var_0) {
  return level.xpeventinfo[var_0]["playSplash"];
}

getscoreinfovalue(var_0) {
  var_1 = "scr_" + level.gametype + "_score_" + var_0;

  if(getDvar(var_1) != "") {
    return getdvarint(var_1);
  }

  return level.xpeventinfo[var_0]["value"];
}

getrankinfominxp(var_0) {
  return int(level.ranktable[var_0][2]);
}

getrankinfoxpamt(var_0) {
  return int(level.ranktable[var_0][3]);
}

getrankinfomaxxp(var_0) {
  return int(level.ranktable[var_0][7]);
}

getrankinfofull(var_0) {
  return tablelookupistring("mp/rankTable.csv", 0, var_0, 16);
}

getrankinfolevel(var_0) {
  return int(tablelookup("mp/rankTable.csv", 0, var_0, 13));
}

awardgameevent(var_0, var_1, var_2, var_3, var_4) {
  if(maps\mp\_utility::invirtuallobby()) {
    return;
  }
  if(shouldplaysplash(var_0)) {
    var_1 thread maps\mp\gametypes\_hud_message::splashnotify(var_0);
  }

  var_1 giverankxp(var_0, undefined, var_2, var_4, undefined, var_3);

  if(allowplayerscore(var_0)) {
    var_1 maps\mp\gametypes\_gamescore::giveplayerscore(var_0, var_1, var_3);
  }
}

giverankxp(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");

  if(isDefined(self.owner) && !isbot(self)) {
    self.owner giverankxp(var_0, var_1, var_2, var_3, var_4, var_5);
    return;
  }

  if(isai(self)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(level.teambased && (!level.teamcount["allies"] || !level.teamcount["axis"]) && var_0 != "win") {
    return;
  }
  if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2) {
    return;
  }
  if(isDefined(level.disableranking) && level.disableranking) {
    return;
  }
  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = getscoreinfovalue(var_0);
  }

  if(var_1 == 0) {
    return;
  }
  if(var_1 > 0 && !isDefined(self.lootplaytimevalidated)) {
    self.lootplaytimevalidated = 1;
    lootservicevalidateplaytime(self.xuid);
  }

  var_6 = var_1;
  var_7 = 0;

  switch (var_0) {
    case "loss":
    case "win":
    case "tie":
    case "challenge":
      break;
    default:
      if(maps\mp\_utility::getgametypenumlives() > 0 && var_0 != "shield_damage") {
        var_8 = max(1, int(10 / maps\mp\_utility::getgametypenumlives()));

        if(level.gametype == "sr") {
          var_8 = max(1, int(5 / maps\mp\_utility::getgametypenumlives()));
        }

        var_6 = int(var_6 * var_8);
      }

      if(level.xpscale > 1) {
        var_6 = int(var_6 * level.xpscale);
      }

      if(self getrankedplayerdata("hasDoubleXPItem")) {
        var_6 = int(var_6 * 2);
      }

      if(isDefined(level.nukedetonated) && level.nukedetonated) {
        if(level.teambased && level.nukeinfo.team == self.team) {
          var_6 = var_6 * level.nukeinfo.xpscalar;
        } else if(!level.teambased && level.nukeinfo.player == self) {
          var_6 = var_6 * level.nukeinfo.xpscalar;
        }

        var_6 = int(var_6);
      }

      if(isDefined(self.costumebonus) && isDefined(self.costumebonus["xp"])) {
        var_9 = int(var_6 + var_1 * self.costumebonus["xp"]["bonusTotal"]);
        var_6 = var_9;
      }

      var_7 = self getclanwarsbonus();
      break;
  }

  var_10 = int(var_6 * var_7);
  var_11 = getrankxp();
  incrankxp(var_6 + var_10);

  if(maps\mp\_utility::rankingenabled() && updaterank(var_11)) {
    thread updaterankannouncehud();
  }

  syncxpstat();
  var_12 = maps\mp\gametypes\_missions::isweaponchallenge(var_4);

  if(var_12) {
    var_2 = self getcurrentweapon();
  }

  if(var_0 == "shield_damage") {
    var_2 = self getcurrentweapon();
    var_3 = "MOD_MELEE";
  }

  self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_10;
  self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + (var_6 + var_10);

  switch (var_0) {
    case "loss":
    case "win":
    case "tie":
      self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_6;
      break;
    case "challenge":
      self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_6;
      break;
    default:
      if(isregisteredevent(var_0)) {
        self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_6;
      } else {
        self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_6;
      }

      break;
  }
}

updaterank(var_0) {
  var_1 = getrank();

  if(var_1 == self.pers["rank"]) {
    return 0;
  }

  var_2 = self.pers["rank"];
  self.pers["rank"] = var_1;
  self setrank(var_1);
  return 1;
}

updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_0 = self.pers["team"];

  if(!isDefined(var_0)) {
    return;
  }
  if(!maps\mp\_utility::levelflag("game_over")) {
    level common_scripts\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var_1 = getrankinfofull(self.pers["rank"]);
  var_2 = level.ranktable[self.pers["rank"]][1];
  var_3 = int(var_2[var_2.size - 1]);
  thread maps\mp\gametypes\_hud_message::rankupsplashnotify("ranked_up", self.pers["rank"], self.pers["prestige"]);

  if(var_3 > 1) {
    return;
  }
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = level.players[var_4];
    var_6 = var_5.pers["team"];

    if(isDefined(var_6) && var_5 != self) {
      if(var_6 == var_0) {
        var_5 iprintln(&"RANK_PLAYER_WAS_PROMOTED", self, var_1);
      }
    }
  }
}

xppointspopup(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(var_1 == 0) {
    return;
  }
  self notify("xpPointsPopup");
  self endon("xpPointsPopup");
  self.xpupdatetotal = self.xpupdatetotal + var_1;
  self setclientomnvar("ui_points_popup", self.xpupdatetotal);
  var_2 = tablelookuprownum("mp/xp_event_table.csv", 0, var_0);

  if(!isDefined(var_2) || isDefined(var_2) && var_2 == -1) {} else {
    self setclientomnvar("ui_points_popup_event", var_2);
  }

  wait 1;
  self.xpupdatetotal = 0;
}

getrank() {
  var_0 = gettotalxp();
  var_1 = self.pers["rank"];

  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
    return var_1;
  } else {
    return getrankforxp(var_0);
  }
}

getrankforxp(var_0) {
  var_1 = 0;
  var_2 = level.ranktable[var_1][1];

  while(isDefined(var_2) && var_2 != "") {
    if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
      return var_1;
    }

    var_1++;

    if(isDefined(level.ranktable[var_1])) {
      var_2 = level.ranktable[var_1][1];
      continue;
    }

    var_2 = undefined;
  }

  var_1--;
  return var_1;
}

getprestigelevel() {
  if(isai(self) && isDefined(self.pers["prestige_fake"])) {
    return self.pers["prestige_fake"];
  } else {
    return maps\mp\gametypes\_persistence::statget("prestige");
  }
}

getrankxp() {
  if(isDefined(self.pers["rankxp"])) {
    return self.pers["rankxp"];
  } else {
    return 0;
  }
}

getredeemedxp() {
  if(isDefined(self.pers["redeemedxp"])) {
    return self.pers["redeemedxp"];
  } else {
    return 0;
  }
}

gettotalxp() {
  return getrankxp() + getredeemedxp();
}

incrankxp(var_0) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_1 = getrankxp();
  var_2 = self.pers["prestige"];
  var_3 = getrankinfomaxxp(level.maxrank) - getredeemedxp();
  var_4 = int(min(var_1, var_3)) + var_0;

  if(var_4 > var_3) {
    var_4 = var_3;
  }

  self.pers["rankxp"] = var_4;
  processprestigemastery(var_2, var_4);
}

processprestigemastery(var_0, var_1) {
  var_2 = getrankinfomaxxp(level.maxrank) - getredeemedxp();

  if(var_0 == level.masterprestige && var_1 >= var_2 && !isDefined(self.pers["prestigeMaster"])) {
    self.pers["prestigeMaster"] = self setprestigemastery();

    if(isDefined(self.pers["prestigeMaster"])) {
      thread maps\mp\gametypes\_hud_message::splashnotifyurgent("prestigeMaster");
    }
  }

  if(var_0 == level.grandmasterprestige && var_1 >= var_2 && !isDefined(self.pers["prestigeGrandMaster"])) {
    self.pers["prestigeGrandMaster"] = self setprestigemastery();

    if(isDefined(self.pers["prestigeGrandMaster"])) {
      thread maps\mp\gametypes\_hud_message::splashnotifyurgent("prestigeGrandMaster");
    }
  }
}

syncxpstat() {
  var_0 = getrankxp();
  maps\mp\gametypes\_persistence::statset("experience", var_0);
}