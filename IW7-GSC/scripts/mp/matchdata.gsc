/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\matchdata.gsc
************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    setmatchdatadef("mp\matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);
    if(level.hardcoremode) {
      var_00 = level.gametype + " hc";
      setmatchdata("commonMatchData", "gametype", var_00);
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

gettimefrommatchstart(param_00) {
  var_01 = param_00;
  if(isDefined(level.starttimefrommatchstart)) {
    var_01 = var_01 - level.starttimefrommatchstart;
    if(var_01 < 0) {
      var_01 = 0;
    }
  } else {
    var_01 = 0;
  }

  return var_01;
}

logsupercommoneventdata(param_00, param_01, param_02, param_03) {
  var_04 = gettimefrommatchstart(gettime());
  setmatchdata(param_00, param_01, "lifeIndex", param_02);
  setmatchdata(param_00, param_01, "time_msFromMatchStart", var_04);
  setmatchdata(param_00, param_01, "playerPos", 0, int(param_03[0]));
  setmatchdata(param_00, param_01, "playerPos", 1, int(param_03[1]));
  setmatchdata(param_00, param_01, "playerPos", 2, int(param_03[2]));
}

logsuperavailableevent(param_00, param_01) {
  var_02 = getmatchdata("supersAvailableCount");
  var_03 = var_02 + 1;
  setmatchdata("supersAvailableCount", var_03);
  if(var_02 >= level.maxsupersavailable) {
    return;
  }

  logsupercommoneventdata("supersAvailable", var_02, param_00, param_01);
}

logsuperactivatedevent(param_00, param_01) {
  var_02 = getmatchdata("supersActivatedCount");
  var_03 = var_02 + 1;
  setmatchdata("supersActivatedCount", var_03);
  if(var_02 >= level.maxsupersactivated) {
    return;
  }

  logsupercommoneventdata("supersActivated", var_02, param_00, param_01);
  self.scoreatsuperactivation = self.destroynavrepulsor;
}

logsuperexpiredevent(param_00, param_01, param_02) {
  var_03 = getmatchdata("supersExpiredCount");
  var_04 = var_03 + 1;
  setmatchdata("supersExpiredCount", var_04);
  if(var_03 >= level.maxsupersexpired) {
    return;
  }

  logsupercommoneventdata("supersExpired", var_03, param_00, param_01);
  setmatchdata("supersExpired", var_03, "expirationThroughDeath", param_02);
  var_05 = 0;
  if(isDefined(self.scoreatsuperactivation)) {
    var_05 = self.destroynavrepulsor - self.scoreatsuperactivation;
  }

  setmatchdata("supersExpired", var_03, "scoreEarned", var_05);
}

logkillstreakavailableevent(param_00) {
  if(scripts\mp\utility::isgameparticipant(self) == 0) {
    return;
  }

  var_01 = getmatchdata("killstreakAvailableCount");
  var_02 = var_01 + 1;
  setmatchdata("killstreakAvailableCount", var_02);
  if(!canlogclient(self) || var_01 >= level.var_B4A9) {
    return;
  }

  var_03 = gettimefrommatchstart(gettime());
  var_04 = -1;
  if(isDefined(self.matchdatalifeindex)) {
    var_04 = self.matchdatalifeindex;
  }

  setmatchdata("killstreaksAvailable", var_01, "eventType", param_00);
  setmatchdata("killstreaksAvailable", var_01, "playerLifeIndex", var_04);
  setmatchdata("killstreaksAvailable", var_01, "eventTime_msFromMatchStart", var_03);
}

logkillstreakevent(param_00, param_01) {
  if(scripts\mp\utility::isgameparticipant(self) == 0) {
    return;
  }

  param_01 = self.origin;
  var_02 = getmatchdata("killstreakCount");
  var_03 = var_02 + 1;
  setmatchdata("killstreakCount", var_03);
  if(!canlogclient(self) || var_02 >= level.var_B4A8) {
    return;
  }

  var_04 = gettimefrommatchstart(gettime());
  var_05 = -1;
  if(isDefined(self.matchdatalifeindex)) {
    var_05 = self.matchdatalifeindex;
  }

  setmatchdata("killstreaks", var_02, "eventType", param_00);
  setmatchdata("killstreaks", var_02, "playerLifeIndex", var_05);
  setmatchdata("killstreaks", var_02, "eventTime_msFromMatchStart", var_04);
  setmatchdata("killstreaks", var_02, "playerPos", 0, int(param_01[0]));
  setmatchdata("killstreaks", var_02, "playerPos", 1, int(param_01[1]));
  setmatchdata("killstreaks", var_02, "playerPos", 2, int(param_01[2]));
  self.lastmatchdatakillstreakindex = var_02;
}

loggameevent(param_00, param_01) {
  if(isplayer(self) && !canlogclient(self)) {
    return;
  }

  var_02 = getmatchdata("gameEventCount");
  var_03 = var_02 + 1;
  setmatchdata("gameEventCount", var_03);
  if(var_02 >= level.var_B49F) {
    return;
  }

  var_04 = gettimefrommatchstart(gettime());
  var_05 = -1;
  if(scripts\mp\utility::isgameparticipant(self) == 1) {
    if(isDefined(self.matchdatalifeindex)) {
      var_05 = self.matchdatalifeindex;
    }
  }

  setmatchdata("gameEvents", var_02, "eventType", param_00);
  setmatchdata("gameEvents", var_02, "playerLifeIndex", var_05);
  setmatchdata("gameEvents", var_02, "eventTime_msFromMatchStart", var_04);
  setmatchdata("gameEvents", var_02, "eventPos", 0, int(param_01[0]));
  setmatchdata("gameEvents", var_02, "eventPos", 1, int(param_01[1]));
  setmatchdata("gameEvents", var_02, "eventPos", 2, int(param_01[2]));
}

loginitialstats(param_00, param_01) {
  if(!canloglife(param_00)) {
    return;
  }

  setmatchdata("lives", param_00, "modifiers", param_01, 1);
}

func_AFCB(param_00, param_01) {
  if(!canloglife(param_00)) {
    return;
  }

  setmatchdata("lives", param_00, "multikill", param_01);
}

logplayerlife() {
  if(!canlogclient(self)) {
    return level.maxlives - 1;
  }

  var_00 = 0;
  var_01 = (0, 0, 0);
  var_02 = 0;
  var_03 = -1;
  if(isDefined(self.spawntime)) {
    var_00 = self.spawntime;
  }

  if(isDefined(self.spawnpos)) {
    var_01 = self.spawnpos;
  }

  if(isDefined(self.wasti)) {
    var_02 = self.wasti;
  }

  if(isDefined(self.var_AE6D)) {
    var_03 = self.var_AE6D;
  }

  var_04 = gettimefrommatchstart(var_00);
  var_05 = self logmatchdatalife(self.clientid, var_01, var_04, var_02, var_03);
  return var_05;
}

func_AFD7(param_00, param_01) {
  if(!canlogclient(self)) {
    return;
  }

  setmatchdata("players", self.clientid, param_01, param_00);
}

logplayerdeath(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!canlogclient(self)) {
    return;
  }

  if(param_00 >= level.maxlives) {
    return;
  }

  if(param_04 == "agent_mp") {
    var_07 = [];
  } else {
    var_07 = scripts\mp\utility::getweaponattachmentsbasenames(param_05);
    var_07 = scripts\mp\utility::func_249F(var_07);
  }

  var_08 = gettimefrommatchstart(gettime());
  var_09 = undefined;
  var_0A = [];
  if(isDefined(self.var_AA47)) {
    var_09 = self.var_AA47;
    var_0A = scripts\mp\utility::getweaponattachmentsbasenames(var_09);
    var_0A = scripts\mp\utility::func_249F(var_0A);
    if(scripts\mp\utility::ispickedupweapon(var_09)) {
      setmatchdata("lives", param_00, "victimCurrentWeaponPickedUp", 1);
    }
  }

  if(isDefined(self.super) && self.super.isinuse) {
    setmatchdata("lives", param_00, "victimSuperActive", 1);
  }

  var_0B = 0;
  if(isDefined(self.var_13905)) {
    var_0B = self.var_13905;
  }

  if(isplayer(param_01) && canlogclient(param_01)) {
    var_0C = param_01 scripts\mp\utility::func_9EE8();
    var_0D = 0.4226;
    var_0E = scripts\engine\utility::within_fov(self.origin, self.angles, param_01.origin, var_0D);
    var_0F = scripts\engine\utility::within_fov(param_01.origin, param_01.angles, self.origin, var_0D);
    var_10 = -1;
    if(isDefined(param_01.matchdatalifeindex)) {
      var_10 = param_01.matchdatalifeindex;
    }

    if(param_01 scripts\mp\utility::ispickedupweapon(param_04)) {
      setmatchdata("lives", param_00, "attackerWeaponPickedUp", 1);
    }

    if(isDefined(param_01.super) && param_01.super.isinuse && param_03 != "MOD_SUICIDE" && param_01.clientid != self.clientid) {
      setmatchdata("lives", param_00, "attackerSuperActive", 1);
      if(isDefined(param_01.pers["matchdataSuperKills"])) {
        param_01.pers["matchdataSuperKills"]++;
      } else {
        param_01.pers["matchdataSuperKills"] = 1;
      }
    }

    var_11 = scripts\mp\utility::iskillstreakweapon(param_04);
    self logmatchdatadeath(param_00, self.clientid, param_01, param_01.clientid, param_04, param_03, var_11, param_01 scripts\mp\utility::isjuggernaut(), var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0F, var_0E, var_10);
    if(var_11) {
      if(isDefined(param_01.lastmatchdatakillstreakindex) && param_01.lastmatchdatakillstreakindex != -1) {
        setmatchdata("lives", param_00, "attackerKillstreakIndex", param_01.lastmatchdatakillstreakindex);
      }
    } else {
      setmatchdata("lives", param_00, "attackerKillstreakIndex", -1);
    }

    if(isDefined(level.matchrecording_logevent)) {
      var_12 = gettime();
      [
        [level.matchrecording_logevent]
      ](self.clientid, self.team, "DEATH", self.origin[0], self.origin[1], var_12);
      if(issubstr(tolower(param_03), "bullet") && isDefined(param_04) && !scripts\mp\utility::iskillstreakweapon(param_04)) {
        [[level.matchrecording_logevent]](param_01.clientid, param_01.team, "BULLET", param_01.origin[0], param_01.origin[1], var_12, undefined, self.origin[0], self.origin[1]);
      }
    }
  } else {
    self logmatchdatadeath(param_00, self.clientid, undefined, undefined, param_04, param_03, scripts\mp\utility::iskillstreakweapon(param_04), 0, var_07, var_08, var_09, var_0A, var_0B, 0, 0, 0, -1);
    setmatchdata("lives", param_00, "attackerKillstreakIndex", -1);
  }

  logxpscoreearnedinlife(param_00);
}

logxpscoreearnedinlife(param_00) {
  var_01 = self.pers["summary"]["xp"];
  var_02 = var_01 - self.pers["xpAtLastDeath"];
  self.pers["xpAtLastDeath"] = var_01;
  var_03 = self.destroynavrepulsor - self.pers["scoreAtLastDeath"];
  self.pers["scoreAtLastDeath"] = self.destroynavrepulsor;
  setmatchdata("lives", param_00, "scoreEarned", var_03);
  setmatchdata("lives", param_00, "xpEarned", var_02);
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
  self _meth_8572(self.clientid);
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  foreach(var_04 in self.pers["matchdataWeaponStats"]) {
    setmatchdata("players", self.clientid, "weaponStats", var_02, "weapon", var_04.var_394);
    setmatchdata("players", self.clientid, "weaponStats", var_02, "variantID", var_04.variantid);
    foreach(var_07, var_06 in var_04.var_10E53) {
      setmatchdata("players", self.clientid, "weaponStats", var_02, var_07, int(var_06));
      if(var_07 == "hits") {
        var_00 = var_00 + var_06;
      }

      if(var_07 == "shots") {
        var_01 = var_01 + var_06;
      }
    }

    var_02++;
    if(var_02 >= 20) {
      break;
    }
  }

  self grenade_model(self.clientid, var_01, var_00);
  var_09 = 0;
  if(isDefined(self.pers["matchdataSuperKills"])) {
    var_09 = self.pers["matchdataSuperKills"];
  }

  var_0A = 0;
  if(isDefined(self.pers["matchdataLongshotCount"])) {
    var_0A = self.pers["matchdataLongshotCount"];
  }

  var_0B = 0;
  if(isDefined(self.pers["matchdataDoubleKillsCount"])) {
    var_0B = self.pers["matchdataDoubleKillsCount"];
  }

  self _meth_85AC(self.clientid, scripts\mp\utility::getpersstat("headshots"), var_0A, var_0B, var_09);
  foreach(var_08, var_0D in self.pers["matchdataScoreEventCounts"]) {
    setmatchdata("players", self.clientid, "scoreEventCount", var_08, var_0D);
  }

  setmatchdata("players", self.clientid, "playerXpModifier", int(scripts\mp\rank::getrankxpmultiplier()));
  if(level.teambased) {
    setmatchdata("players", self.clientid, "teamXpModifier", int(scripts\mp\rank::_meth_81B6(self.team)));
  }

  setmatchdata("players", self.clientid, "weaponXpModifier", int(scripts\mp\weaponrank::getweaponrankxpmultiplier()));
  level scripts\mp\playerlogic::writesegmentdata(self);
  if(isDefined(self.contracts)) {
    foreach(var_10, var_0F in self.contracts) {
      setmatchdata("players", self.clientid, "contracts", var_0F.slot, "challengeID", var_0F.id);
      setmatchdata("players", self.clientid, "contracts", var_0F.slot, "progress", var_0F.progress);
    }
  }
}

func_AFD8(param_00) {
  if(scripts\mp\utility::isgameparticipant(self) == 0) {
    return;
  }

  if(!canlogclient(self)) {
    return;
  }

  if(isDefined(self.pers["matchdataScoreEventCounts"][param_00])) {
    self.pers["matchdataScoreEventCounts"][param_00]++;
    return;
  }

  self.pers["matchdataScoreEventCounts"][param_00] = 1;
}

func_636A() {
  level waittill("game_ended");
  foreach(var_01 in level.players) {
    wait(0.05);
    if(!isDefined(var_01)) {
      continue;
    }

    if(isDefined(var_01.weaponsused)) {
      var_01 doublebubblesort();
      var_02 = 0;
      if(var_01.weaponsused.size > 3) {
        for(var_03 = var_01.weaponsused.size - 1; var_03 > var_01.weaponsused.size - 3; var_03--) {
          var_01 setplayerdata("common", "round", "weaponsUsed", var_02, var_01.weaponsused[var_03]);
          var_01 setplayerdata("common", "round", "weaponXpEarned", var_02, var_01.weaponxpearned[var_03]);
          var_02++;
        }
      } else {
        for(var_03 = var_01.weaponsused.size - 1; var_03 >= 0; var_03--) {
          var_01 setplayerdata("common", "round", "weaponsUsed", var_02, var_01.weaponsused[var_03]);
          var_01 setplayerdata("common", "round", "weaponXpEarned", var_02, var_01.weaponxpearned[var_03]);
          var_02++;
        }
      }
    } else {
      var_01 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var_01 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var_01 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var_01 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var_01 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var_01 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var_01.var_3C30)) {
      var_01 setplayerdata("common", "round", "challengeNumCompleted", var_01.var_3C30.size);
    } else {
      var_01 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var_03 = 0; var_03 < 20; var_03++) {
      if(isDefined(var_01.var_3C30) && isDefined(var_01.var_3C30[var_03]) && var_01.var_3C30[var_03] != "ch_prestige" && !issubstr(var_01.var_3C30[var_03], "_daily") && !issubstr(var_01.var_3C30[var_03], "_weekly")) {
        var_01 setplayerdata("common", "round", "challengesCompleted", var_03, var_01.var_3C30[var_03]);
        continue;
      }

      var_01 setplayerdata("common", "round", "challengesCompleted", var_03, "ch_none");
    }

    var_01 setplayerdata("common", "round", "gameMode", level.gametype);
    var_01 setplayerdata("common", "round", "map", tolower(getdvar("mapname")));
  }
}

doublebubblesort() {
  var_00 = self.weaponxpearned;
  var_01 = self.weaponxpearned.size;
  for(var_02 = var_01 - 1; var_02 > 0; var_02--) {
    for(var_03 = 1; var_03 <= var_02; var_03++) {
      if(var_00[var_03 - 1] < var_00[var_03]) {
        var_04 = self.weaponsused[var_03];
        self.weaponsused[var_03] = self.weaponsused[var_03 - 1];
        self.weaponsused[var_03 - 1] = var_04;
        var_05 = self.weaponxpearned[var_03];
        self.weaponxpearned[var_03] = self.weaponxpearned[var_03 - 1];
        self.weaponxpearned[var_03 - 1] = var_05;
        var_00 = self.weaponxpearned;
      }
    }
  }
}

gameendlistener() {
  level waittill("game_ended");
  foreach(var_01 in level.players) {
    var_01 logplayerdata();
    if(!isalive(var_01)) {
      continue;
    }
  }
}

canlogclient(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  } else if(isagent(param_00)) {
    return 0;
  } else if(!isplayer(param_00)) {
    return 0;
  }

  return param_00.clientid < level.maxlogclients;
}

canloglife(param_00) {
  return param_00 < level.maxlives;
}

func_AFDC(param_00, param_01, param_02, param_03) {
  if(!canlogclient(self)) {
    return;
  }

  if(scripts\mp\utility::iskillstreakweapon(param_00)) {
    return;
  }

  var_04 = param_00;
  if(isDefined(param_03)) {
    var_04 = var_04 + "+loot" + param_03;
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_04])) {
    self.pers["matchdataWeaponStats"][var_04] = spawnStruct();
    self.pers["matchdataWeaponStats"][var_04].var_10E53 = [];
    self.pers["matchdataWeaponStats"][var_04].var_394 = param_00;
    if(isDefined(param_03)) {
      self.pers["matchdataWeaponStats"][var_04].variantid = param_03;
    } else {
      self.pers["matchdataWeaponStats"][var_04].variantid = -1;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01])) {
    self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01] = param_02;
    return;
  }

  self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01] = self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01] + param_02;
}

func_AF94(param_00, param_01, param_02) {
  if(!canlogclient(self)) {
    return;
  }

  if(!scripts\mp\utility::func_2490(param_00)) {
    return;
  }

  var_03 = getmatchdata("players", self.clientid, "attachmentsStats", param_00, param_01);
  var_04 = var_03 + param_02;
  setmatchdata("players", self.clientid, "attachmentsStats", param_00, param_01, var_04);
}

func_322A() {
  var_00 = [];
  var_01 = 149;
  for(var_02 = 0; var_02 <= var_01; var_02++) {
    var_03 = tablelookup("mp\statstable.csv", 0, var_02, 4);
    if(!issubstr(tablelookup("mp\statsTable.csv", 0, var_02, 2), "weapon_")) {
      continue;
    }

    if(tablelookup("mp\statsTable.csv", 0, var_02, 2) == "weapon_other") {
      continue;
    }

    var_00[var_00.size] = var_03;
  }

  return var_00;
}

func_AF99(param_00, param_01) {
  if(!canlogclient(self)) {
    return;
  }

  if(issubstr(param_00, "_daily") || issubstr(param_00, "_weekly")) {
    return;
  }

  var_02 = getmatchdata("players", self.clientid, "challengeCount");
  if(var_02 < level.var_B4B5) {
    setmatchdata("players", self.clientid, "challenge", var_02, param_00);
    setmatchdata("players", self.clientid, "challengeCount", var_02 + 1);
  }
}

func_AF97(param_00) {
  if(!canlogclient(self)) {
    return;
  }

  var_01 = getmatchdata("players", self.clientid, "awardCount");
  var_02 = var_01 + 1;
  setmatchdata("players", self.clientid, "awardCount", var_02);
  if(var_01 < level.var_B4B4) {
    setmatchdata("players", self.clientid, "awards", var_01, param_00);
  }

  if(param_00 == "double") {
    if(isDefined(self.pers["matchdataDoubleKillsCount"])) {
      self.pers["matchdataDoubleKillsCount"]++;
      return;
    }

    self.pers["matchdataDoubleKillsCount"] = 1;
    return;
  }

  if(param_00 == "longshot") {
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
  if(!self _meth_8592()) {
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