/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\matchdata.gsc
*********************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    setmatchdatadef("mp\matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);
    if(level.hardcoremode) {
      var_0 = level.gametype + " hc";
      setmatchdata("commonMatchData", "gametype", var_0);
    } else {
      setmatchdata("commonMatchData", "gametype", level.gametype);
    }

    setmatchdata("commonMatchData", "buildVersion", getbuildversion());
    setmatchdata("commonMatchData", "buildNumber", getbuildnumber());
    setmatchdataid();
    setmatchdata("commonMatchData", "isPrivateMatch", scripts\mp\utility::func_D957());
    setmatchdata("firstOvertimeRoundIndex", -1);
    if(scripts\mp\utility::ismlgmatch()) {
      setmatchdata("codESportsRules", 1);
    }
  }

  level.maxlives = 475;
  level.var_B4B3 = 26;
  level.var_B49F = 250;
  level.var_B4A8 = 64;
  level.var_B4A9 = 64;
  level.maxlogclients = 30;
  level.var_B4B5 = 10;
  level.var_B4B4 = 10;
  level.maxsupersavailable = 50;
  level.maxsupersactivated = 50;
  level.maxsupersexpired = 50;
  level thread gameendlistener();
  level thread func_636A();
}

func_C558() {
  setmatchdata("commonMatchData", "utcStartTimeSeconds", getsystemtime());
  setmatchdata("commonMatchData", "playerCountStart", level.players.size);
}

func_C557() {
  setmatchdata("commonMatchData", "utcEndTimeSeconds", getsystemtime());
  setmatchdata("commonMatchData", "playerCountEnd", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(scripts\mp\rank::func_7ED9()));
  setmatchdata("globalWeaponXpModifier", int(scripts\mp\weaponrank::getglobalweaponrankxpmultiplier()));
}

func_7F93() {
  return getmatchdata("commonMatchData", "utcStartTimeSeconds");
}

gettimefrommatchstart(var_0) {
  var_1 = var_0;
  if(isDefined(level.starttimefrommatchstart)) {
    var_1 = var_1 - level.starttimefrommatchstart;
    if(var_1 < 0) {
      var_1 = 0;
    }
  } else {
    var_1 = 0;
  }

  return var_1;
}

logsupercommoneventdata(var_0, var_1, var_2, var_3) {
  var_4 = gettimefrommatchstart(gettime());
  setmatchdata(var_0, var_1, "lifeIndex", var_2);
  setmatchdata(var_0, var_1, "time_msFromMatchStart", var_4);
  setmatchdata(var_0, var_1, "playerPos", 0, int(var_3[0]));
  setmatchdata(var_0, var_1, "playerPos", 1, int(var_3[1]));
  setmatchdata(var_0, var_1, "playerPos", 2, int(var_3[2]));
}

logsuperavailableevent(var_0, var_1) {
  var_2 = getmatchdata("supersAvailableCount");
  var_3 = var_2 + 1;
  setmatchdata("supersAvailableCount", var_3);
  if(var_2 >= level.maxsupersavailable) {
    return;
  }

  logsupercommoneventdata("supersAvailable", var_2, var_0, var_1);
}

logsuperactivatedevent(var_0, var_1) {
  var_2 = getmatchdata("supersActivatedCount");
  var_3 = var_2 + 1;
  setmatchdata("supersActivatedCount", var_3);
  if(var_2 >= level.maxsupersactivated) {
    return;
  }

  logsupercommoneventdata("supersActivated", var_2, var_0, var_1);
  self.scoreatsuperactivation = self.score;
}

logsuperexpiredevent(var_0, var_1, var_2) {
  var_3 = getmatchdata("supersExpiredCount");
  var_4 = var_3 + 1;
  setmatchdata("supersExpiredCount", var_4);
  if(var_3 >= level.maxsupersexpired) {
    return;
  }

  logsupercommoneventdata("supersExpired", var_3, var_0, var_1);
  setmatchdata("supersExpired", var_3, "expirationThroughDeath", var_2);
  var_5 = 0;
  if(isDefined(self.scoreatsuperactivation)) {
    var_5 = self.score - self.scoreatsuperactivation;
  }

  setmatchdata("supersExpired", var_3, "scoreEarned", var_5);
}

logkillstreakavailableevent(var_0) {
  if(scripts\mp\utility::isgameparticipant(self) == 0) {
    return;
  }

  var_1 = getmatchdata("killstreakAvailableCount");
  var_2 = var_1 + 1;
  setmatchdata("killstreakAvailableCount", var_2);
  if(!canlogclient(self) || var_1 >= level.var_B4A9) {
    return;
  }

  var_3 = gettimefrommatchstart(gettime());
  var_4 = -1;
  if(isDefined(self.matchdatalifeindex)) {
    var_4 = self.matchdatalifeindex;
  }

  setmatchdata("killstreaksAvailable", var_1, "eventType", var_0);
  setmatchdata("killstreaksAvailable", var_1, "playerLifeIndex", var_4);
  setmatchdata("killstreaksAvailable", var_1, "eventTime_msFromMatchStart", var_3);
}

logkillstreakevent(var_0, var_1) {
  if(scripts\mp\utility::isgameparticipant(self) == 0) {
    return;
  }

  var_1 = self.origin;
  var_2 = getmatchdata("killstreakCount");
  var_3 = var_2 + 1;
  setmatchdata("killstreakCount", var_3);
  if(!canlogclient(self) || var_2 >= level.var_B4A8) {
    return;
  }

  var_4 = gettimefrommatchstart(gettime());
  var_5 = -1;
  if(isDefined(self.matchdatalifeindex)) {
    var_5 = self.matchdatalifeindex;
  }

  setmatchdata("killstreaks", var_2, "eventType", var_0);
  setmatchdata("killstreaks", var_2, "playerLifeIndex", var_5);
  setmatchdata("killstreaks", var_2, "eventTime_msFromMatchStart", var_4);
  setmatchdata("killstreaks", var_2, "playerPos", 0, int(var_1[0]));
  setmatchdata("killstreaks", var_2, "playerPos", 1, int(var_1[1]));
  setmatchdata("killstreaks", var_2, "playerPos", 2, int(var_1[2]));
  self.lastmatchdatakillstreakindex = var_2;
}

loggameevent(var_0, var_1) {
  if(isplayer(self) && !canlogclient(self)) {
    return;
  }

  var_2 = getmatchdata("gameEventCount");
  var_3 = var_2 + 1;
  setmatchdata("gameEventCount", var_3);
  if(var_2 >= level.var_B49F) {
    return;
  }

  var_4 = gettimefrommatchstart(gettime());
  var_5 = -1;
  if(scripts\mp\utility::isgameparticipant(self) == 1) {
    if(isDefined(self.matchdatalifeindex)) {
      var_5 = self.matchdatalifeindex;
    }
  }

  setmatchdata("gameEvents", var_2, "eventType", var_0);
  setmatchdata("gameEvents", var_2, "playerLifeIndex", var_5);
  setmatchdata("gameEvents", var_2, "eventTime_msFromMatchStart", var_4);
  setmatchdata("gameEvents", var_2, "eventPos", 0, int(var_1[0]));
  setmatchdata("gameEvents", var_2, "eventPos", 1, int(var_1[1]));
  setmatchdata("gameEvents", var_2, "eventPos", 2, int(var_1[2]));
}

loginitialstats(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }

  setmatchdata("lives", var_0, "modifiers", var_1, 1);
}

func_AFCB(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }

  setmatchdata("lives", var_0, "multikill", var_1);
}

logplayerlife() {
  if(!canlogclient(self)) {
    return level.maxlives - 1;
  }

  var_0 = 0;
  var_1 = (0, 0, 0);
  var_2 = 0;
  var_3 = -1;
  if(isDefined(self.spawntime)) {
    var_0 = self.spawntime;
  }

  if(isDefined(self.spawnpos)) {
    var_1 = self.spawnpos;
  }

  if(isDefined(self.wasti)) {
    var_2 = self.wasti;
  }

  if(isDefined(self.var_AE6D)) {
    var_3 = self.var_AE6D;
  }

  var_4 = gettimefrommatchstart(var_0);
  var_5 = self logmatchdatalife(self.clientid, var_1, var_4, var_2, var_3);
  return var_5;
}

func_AFD7(var_0, var_1) {
  if(!canlogclient(self)) {
    return;
  }

  setmatchdata("players", self.clientid, var_1, var_0);
}

logplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!canlogclient(self)) {
    return;
  }

  if(var_0 >= level.maxlives) {
    return;
  }

  if(var_4 == "agent_mp") {
    var_7 = [];
  } else {
    var_7 = scripts\mp\utility::getweaponattachmentsbasenames(var_5);
    var_7 = scripts\mp\utility::func_249F(var_7);
  }

  var_8 = gettimefrommatchstart(gettime());
  var_9 = undefined;
  var_10 = [];
  if(isDefined(self.var_AA47)) {
    var_9 = self.var_AA47;
    var_10 = scripts\mp\utility::getweaponattachmentsbasenames(var_9);
    var_10 = scripts\mp\utility::func_249F(var_10);
    if(scripts\mp\utility::ispickedupweapon(var_9)) {
      setmatchdata("lives", var_0, "victimCurrentWeaponPickedUp", 1);
    }
  }

  if(isDefined(self.super) && self.super.isinuse) {
    setmatchdata("lives", var_0, "victimSuperActive", 1);
  }

  var_11 = 0;
  if(isDefined(self.var_13905)) {
    var_11 = self.var_13905;
  }

  if(isplayer(var_1) && canlogclient(var_1)) {
    var_12 = var_1 scripts\mp\utility::func_9EE8();
    var_13 = 0.4226;
    var_14 = scripts\engine\utility::within_fov(self.origin, self.angles, var_1.origin, var_13);
    var_15 = scripts\engine\utility::within_fov(var_1.origin, var_1.angles, self.origin, var_13);
    var_10 = -1;
    if(isDefined(var_1.matchdatalifeindex)) {
      var_10 = var_1.matchdatalifeindex;
    }

    if(var_1 scripts\mp\utility::ispickedupweapon(var_4)) {
      setmatchdata("lives", var_0, "attackerWeaponPickedUp", 1);
    }

    if(isDefined(var_1.super) && var_1.super.isinuse && var_3 != "MOD_SUICIDE" && var_1.clientid != self.clientid) {
      setmatchdata("lives", var_0, "attackerSuperActive", 1);
      if(isDefined(var_1.pers["matchdataSuperKills"])) {
        var_1.pers["matchdataSuperKills"]++;
      } else {
        var_1.pers["matchdataSuperKills"] = 1;
      }
    }

    var_11 = scripts\mp\utility::iskillstreakweapon(var_4);
    self logmatchdatadeath(var_0, self.clientid, var_1, var_1.clientid, var_4, var_3, var_11, var_1 scripts\mp\utility::isjuggernaut(), var_7, var_8, var_9, var_10, var_11, var_12, var_15, var_14, var_10);
    if(var_11) {
      if(isDefined(var_1.lastmatchdatakillstreakindex) && var_1.lastmatchdatakillstreakindex != -1) {
        setmatchdata("lives", var_0, "attackerKillstreakIndex", var_1.lastmatchdatakillstreakindex);
      }
    } else {
      setmatchdata("lives", var_0, "attackerKillstreakIndex", -1);
    }

    if(isDefined(level.matchrecording_logevent)) {
      var_12 = gettime();
      [
        [level.matchrecording_logevent]
      ](self.clientid, self.team, "DEATH", self.origin[0], self.origin[1], var_12);
      if(issubstr(tolower(var_3), "bullet") && isDefined(var_4) && !scripts\mp\utility::iskillstreakweapon(var_4)) {
        [[level.matchrecording_logevent]](var_1.clientid, var_1.team, "BULLET", var_1.origin[0], var_1.origin[1], var_12, undefined, self.origin[0], self.origin[1]);
      }
    }
  } else {
    self logmatchdatadeath(var_0, self.clientid, undefined, undefined, var_4, var_3, scripts\mp\utility::iskillstreakweapon(var_4), 0, var_7, var_8, var_9, var_10, var_11, 0, 0, 0, -1);
    setmatchdata("lives", var_0, "attackerKillstreakIndex", -1);
  }

  logxpscoreearnedinlife(var_0);
}

logxpscoreearnedinlife(var_0) {
  var_1 = self.pers["summary"]["xp"];
  var_2 = var_1 - self.pers["xpAtLastDeath"];
  self.pers["xpAtLastDeath"] = var_1;
  var_3 = self.score - self.pers["scoreAtLastDeath"];
  self.pers["scoreAtLastDeath"] = self.score;
  setmatchdata("lives", var_0, "scoreEarned", var_3);
  setmatchdata("lives", var_0, "xpEarned", var_2);
}

logplayerdata() {
  if(!canlogclient(self)) {
    return;
  }

  setmatchdata("players", self.clientid, "score", scripts\mp\utility::getpersstat("score"));
  if(scripts\mp\utility::getpersstat("assists") > 255) {
    setmatchdata("players", self.clientid, "assists", 255);
  } else {
    setmatchdata("players", self.clientid, "assists", scripts\mp\utility::getpersstat("assists"));
  }

  if(scripts\mp\utility::getpersstat("longestStreak") > 255) {
    setmatchdata("players", self.clientid, "longestStreak", 255);
  } else {
    setmatchdata("players", self.clientid, "longestStreak", scripts\mp\utility::getpersstat("longestStreak"));
  }

  if(scripts\mp\utility::getpersstat("validationInfractions") > 255) {
    setmatchdata("players", self.clientid, "validationInfractions", 255);
  } else {
    setmatchdata("players", self.clientid, "validationInfractions", scripts\mp\utility::getpersstat("validationInfractions"));
  }

  setmatchdata("players", self.clientid, "kills", scripts\mp\utility::getpersstat("kills"));
  setmatchdata("players", self.clientid, "deaths", scripts\mp\utility::getpersstat("deaths"));
  self func_8572(self.clientid);
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  foreach(var_4 in self.pers["matchdataWeaponStats"]) {
    setmatchdata("players", self.clientid, "weaponStats", var_2, "weapon", var_4.weapon);
    setmatchdata("players", self.clientid, "weaponStats", var_2, "variantID", var_4.variantid);
    foreach(var_7, var_6 in var_4.var_10E53) {
      setmatchdata("players", self.clientid, "weaponStats", var_2, var_7, int(var_6));
      if(var_7 == "hits") {
        var_0 = var_0 + var_6;
      }

      if(var_7 == "shots") {
        var_1 = var_1 + var_6;
      }
    }

    var_2++;
    if(var_2 >= 20) {
      break;
    }
  }

  self grenade_model(self.clientid, var_1, var_0);
  var_9 = 0;
  if(isDefined(self.pers["matchdataSuperKills"])) {
    var_9 = self.pers["matchdataSuperKills"];
  }

  var_10 = 0;
  if(isDefined(self.pers["matchdataLongshotCount"])) {
    var_10 = self.pers["matchdataLongshotCount"];
  }

  var_11 = 0;
  if(isDefined(self.pers["matchdataDoubleKillsCount"])) {
    var_11 = self.pers["matchdataDoubleKillsCount"];
  }

  self func_85AC(self.clientid, scripts\mp\utility::getpersstat("headshots"), var_10, var_11, var_9);
  foreach(var_8, var_13 in self.pers["matchdataScoreEventCounts"]) {
    setmatchdata("players", self.clientid, "scoreEventCount", var_8, var_13);
  }

  setmatchdata("players", self.clientid, "playerXpModifier", int(scripts\mp\rank::getrankxpmultiplier()));
  if(level.teambased) {
    setmatchdata("players", self.clientid, "teamXpModifier", int(scripts\mp\rank::func_81B6(self.team)));
  }

  setmatchdata("players", self.clientid, "weaponXpModifier", int(scripts\mp\weaponrank::getweaponrankxpmultiplier()));
  level scripts\mp\playerlogic::writesegmentdata(self);
  if(isDefined(self.contracts)) {
    foreach(var_10, var_15 in self.contracts) {
      setmatchdata("players", self.clientid, "contracts", var_15.slot, "challengeID", var_15.id);
      setmatchdata("players", self.clientid, "contracts", var_15.slot, "progress", var_15.progress);
    }
  }
}

func_AFD8(var_0) {
  if(scripts\mp\utility::isgameparticipant(self) == 0) {
    return;
  }

  if(!canlogclient(self)) {
    return;
  }

  if(isDefined(self.pers["matchdataScoreEventCounts"][var_0])) {
    self.pers["matchdataScoreEventCounts"][var_0]++;
    return;
  }

  self.pers["matchdataScoreEventCounts"][var_0] = 1;
}

func_636A() {
  level waittill("game_ended");
  foreach(var_1 in level.players) {
    wait(0.05);
    if(!isDefined(var_1)) {
      continue;
    }

    if(isDefined(var_1.weaponsused)) {
      var_1 doublebubblesort();
      var_2 = 0;
      if(var_1.weaponsused.size > 3) {
        for(var_3 = var_1.weaponsused.size - 1; var_3 > var_1.weaponsused.size - 3; var_3--) {
          var_1 setplayerdata("common", "round", "weaponsUsed", var_2, var_1.weaponsused[var_3]);
          var_1 setplayerdata("common", "round", "weaponXpEarned", var_2, var_1.weaponxpearned[var_3]);
          var_2++;
        }
      } else {
        for(var_3 = var_1.weaponsused.size - 1; var_3 >= 0; var_3--) {
          var_1 setplayerdata("common", "round", "weaponsUsed", var_2, var_1.weaponsused[var_3]);
          var_1 setplayerdata("common", "round", "weaponXpEarned", var_2, var_1.weaponxpearned[var_3]);
          var_2++;
        }
      }
    } else {
      var_1 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var_1 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var_1 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var_1 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var_1 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var_1 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var_1.var_3C30)) {
      var_1 setplayerdata("common", "round", "challengeNumCompleted", var_1.var_3C30.size);
    } else {
      var_1 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var_3 = 0; var_3 < 20; var_3++) {
      if(isDefined(var_1.var_3C30) && isDefined(var_1.var_3C30[var_3]) && var_1.var_3C30[var_3] != "ch_prestige" && !issubstr(var_1.var_3C30[var_3], "_daily") && !issubstr(var_1.var_3C30[var_3], "_weekly")) {
        var_1 setplayerdata("common", "round", "challengesCompleted", var_3, var_1.var_3C30[var_3]);
        continue;
      }

      var_1 setplayerdata("common", "round", "challengesCompleted", var_3, "ch_none");
    }

    var_1 setplayerdata("common", "round", "gameMode", level.gametype);
    var_1 setplayerdata("common", "round", "map", tolower(getdvar("mapname")));
  }
}

doublebubblesort() {
  var_0 = self.weaponxpearned;
  var_1 = self.weaponxpearned.size;
  for(var_2 = var_1 - 1; var_2 > 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(var_0[var_3 - 1] < var_0[var_3]) {
        var_4 = self.weaponsused[var_3];
        self.weaponsused[var_3] = self.weaponsused[var_3 - 1];
        self.weaponsused[var_3 - 1] = var_4;
        var_5 = self.weaponxpearned[var_3];
        self.weaponxpearned[var_3] = self.weaponxpearned[var_3 - 1];
        self.weaponxpearned[var_3 - 1] = var_5;
        var_0 = self.weaponxpearned;
      }
    }
  }
}

gameendlistener() {
  level waittill("game_ended");
  foreach(var_1 in level.players) {
    var_1 logplayerdata();
    if(!isalive(var_1)) {
      continue;
    }
  }
}

canlogclient(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  } else if(isagent(var_0)) {
    return 0;
  } else if(!isplayer(var_0)) {
    return 0;
  }

  return var_0.clientid < level.maxlogclients;
}

canloglife(var_0) {
  return var_0 < level.maxlives;
}

func_AFDC(var_0, var_1, var_2, var_3) {
  if(!canlogclient(self)) {
    return;
  }

  if(scripts\mp\utility::iskillstreakweapon(var_0)) {
    return;
  }

  var_4 = var_0;
  if(isDefined(var_3)) {
    var_4 = var_4 + "+loot" + var_3;
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_4])) {
    self.pers["matchdataWeaponStats"][var_4] = spawnStruct();
    self.pers["matchdataWeaponStats"][var_4].var_10E53 = [];
    self.pers["matchdataWeaponStats"][var_4].weapon = var_0;
    if(isDefined(var_3)) {
      self.pers["matchdataWeaponStats"][var_4].variantid = var_3;
    } else {
      self.pers["matchdataWeaponStats"][var_4].variantid = -1;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_4].var_10E53[var_1])) {
    self.pers["matchdataWeaponStats"][var_4].var_10E53[var_1] = var_2;
    return;
  }

  self.pers["matchdataWeaponStats"][var_4].var_10E53[var_1] = self.pers["matchdataWeaponStats"][var_4].var_10E53[var_1] + var_2;
}

func_AF94(var_0, var_1, var_2) {
  if(!canlogclient(self)) {
    return;
  }

  if(!scripts\mp\utility::func_2490(var_0)) {
    return;
  }

  var_3 = getmatchdata("players", self.clientid, "attachmentsStats", var_0, var_1);
  var_4 = var_3 + var_2;
  setmatchdata("players", self.clientid, "attachmentsStats", var_0, var_1, var_4);
}

func_322A() {
  var_0 = [];
  var_1 = 149;
  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = tablelookup("mp\statstable.csv", 0, var_2, 4);
    if(!issubstr(tablelookup("mp\statsTable.csv", 0, var_2, 2), "weapon_")) {
      continue;
    }

    if(tablelookup("mp\statsTable.csv", 0, var_2, 2) == "weapon_other") {
      continue;
    }

    var_0[var_0.size] = var_3;
  }

  return var_0;
}

func_AF99(var_0, var_1) {
  if(!canlogclient(self)) {
    return;
  }

  if(issubstr(var_0, "_daily") || issubstr(var_0, "_weekly")) {
    return;
  }

  var_2 = getmatchdata("players", self.clientid, "challengeCount");
  if(var_2 < level.var_B4B5) {
    setmatchdata("players", self.clientid, "challenge", var_2, var_0);
    setmatchdata("players", self.clientid, "challengeCount", var_2 + 1);
  }
}

func_AF97(var_0) {
  if(!canlogclient(self)) {
    return;
  }

  var_1 = getmatchdata("players", self.clientid, "awardCount");
  var_2 = var_1 + 1;
  setmatchdata("players", self.clientid, "awardCount", var_2);
  if(var_1 < level.var_B4B4) {
    setmatchdata("players", self.clientid, "awards", var_1, var_0);
  }

  if(var_0 == "double") {
    if(isDefined(self.pers["matchdataDoubleKillsCount"])) {
      self.pers["matchdataDoubleKillsCount"]++;
      return;
    }

    self.pers["matchdataDoubleKillsCount"] = 1;
    return;
  }

  if(var_0 == "longshot") {
    if(isDefined(self.pers["matchdataLongshotCount"])) {
      self.pers["matchdataLongshotCount"]++;
      return;
    }

    self.pers["matchdataLongshotCount"] = 1;
    return;
  }
}

logkillsconfirmed() {
  if(!canlogclient(self)) {
    return;
  }

  setmatchdata("players", self.clientid, "killsConfirmed", self.pers["confirmed"]);
}

logkillsdenied() {
  if(!canlogclient(self)) {
    return;
  }

  setmatchdata("players", self.clientid, "killsDenied", self.pers["denied"]);
}

loginitialspawnposition() {
  if(getdvarint("mdsd") > 0) {
    setmatchdata("players", self.clientid, "startXp", self getplayerdata("mp", "progression", "playerLevel", "xp"));
    setmatchdata("players", self.clientid, "startKills", self getplayerdata("mp", "kills"));
    setmatchdata("players", self.clientid, "startDeaths", self getplayerdata("mp", "deaths"));
    setmatchdata("players", self.clientid, "startWins", self getplayerdata("mp", "wins"));
    setmatchdata("players", self.clientid, "startLosses", self getplayerdata("mp", "losses"));
    setmatchdata("players", self.clientid, "startHits", self getplayerdata("mp", "hits"));
    setmatchdata("players", self.clientid, "startMisses", self getplayerdata("mp", "misses"));
    setmatchdata("players", self.clientid, "startGamesPlayed", self getplayerdata("mp", "gamesPlayed"));
    setmatchdata("players", self.clientid, "startTimePlayedTotal", self getplayerdata("mp", "timePlayedTotal"));
    setmatchdata("players", self.clientid, "startScore", self getplayerdata("mp", "score"));
    setmatchdata("players", self.clientid, "startPrestige", self getplayerdata("mp", "progression", "playerLevel", "prestige"));
  }
}

logfinalstats() {
  if(!self func_8592()) {
    return;
  }

  if(getdvarint("mdsd") > 0) {
    setmatchdata("players", self.clientid, "endXp", self getplayerdata("mp", "progression", "playerLevel", "xp"));
    setmatchdata("players", self.clientid, "endKills", self getplayerdata("mp", "kills"));
    setmatchdata("players", self.clientid, "endDeaths", self getplayerdata("mp", "deaths"));
    setmatchdata("players", self.clientid, "endWins", self getplayerdata("mp", "wins"));
    setmatchdata("players", self.clientid, "endLosses", self getplayerdata("mp", "losses"));
    setmatchdata("players", self.clientid, "endHits", self getplayerdata("mp", "hits"));
    setmatchdata("players", self.clientid, "endMisses", self getplayerdata("mp", "misses"));
    setmatchdata("players", self.clientid, "endGamesPlayed", self getplayerdata("mp", "gamesPlayed"));
    setmatchdata("players", self.clientid, "endTimePlayedTotal", self getplayerdata("mp", "timePlayedTotal"));
    setmatchdata("players", self.clientid, "endScore", self getplayerdata("mp", "score"));
    setmatchdata("players", self.clientid, "endPrestige", self getplayerdata("mp", "progression", "playerLevel", "prestige"));
  }
}