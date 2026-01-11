/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2766.gsc
***************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    setmatchdatadef("mp\matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);

    if(level.hardcoremode) {
      var_00 = level.gametype + " hc";
      setmatchdata("commonMatchData", "gametype", var_00);
    } else
      setmatchdata("commonMatchData", "gametype", level.gametype);

    setmatchdata("commonMatchData", "buildVersion", getbuildversion());
    setmatchdata("commonMatchData", "buildNumber", getbuildnumber());
    setmatchdataid();
    setmatchdata("commonMatchData", "isPrivateMatch", scripts\mp\utility\game::func_D957());
    setmatchdata("firstOvertimeRoundIndex", -1);

    if(scripts\mp\utility\game::ismlgmatch()) {
      setmatchdata("codESportsRules", 1);
    }
  }

  level.maxlives = 475;
  level.func_B4B3 = 26;
  level.func_B49F = 250;
  level.func_B4A8 = 64;
  level.func_B4A9 = 64;
  level.maxlogclients = 30;
  level.func_B4B5 = 10;
  level.func_B4B4 = 10;
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
  return _getmatchdata("commonMatchData", "utcStartTimeSeconds");
}

gettimefrommatchstart(var_00) {
  var_01 = var_00;

  if(isDefined(level.starttimefrommatchstart)) {
    var_01 = var_01 - level.starttimefrommatchstart;

    if(var_01 < 0) {
      var_01 = 0;
    }
  } else
    var_01 = 0;

  return var_01;
}

logsupercommoneventdata(var_00, var_01, var_02, var_03) {
  var_04 = gettimefrommatchstart(gettime());
  setmatchdata(var_00, var_01, "lifeIndex", var_02);
  setmatchdata(var_00, var_01, "time_msFromMatchStart", var_04);
  setmatchdata(var_00, var_01, "playerPos", 0, int(var_3[0]));
  setmatchdata(var_00, var_01, "playerPos", 1, int(var_3[1]));
  setmatchdata(var_00, var_01, "playerPos", 2, int(var_3[2]));
}

logsuperavailableevent(var_00, var_01) {
  var_02 = _getmatchdata("supersAvailableCount");
  var_03 = var_02 + 1;
  setmatchdata("supersAvailableCount", var_03);

  if(var_02 >= level.maxsupersavailable) {
    return;
  }
  logsupercommoneventdata("supersAvailable", var_02, var_00, var_01);
}

logsuperactivatedevent(var_00, var_01) {
  var_02 = _getmatchdata("supersActivatedCount");
  var_03 = var_02 + 1;
  setmatchdata("supersActivatedCount", var_03);

  if(var_02 >= level.maxsupersactivated) {
    return;
  }
  logsupercommoneventdata("supersActivated", var_02, var_00, var_01);
  self.scoreatsuperactivation = self.score;
}

logsuperexpiredevent(var_00, var_01, var_02) {
  var_03 = _getmatchdata("supersExpiredCount");
  var_04 = var_03 + 1;
  setmatchdata("supersExpiredCount", var_04);

  if(var_03 >= level.maxsupersexpired) {
    return;
  }
  logsupercommoneventdata("supersExpired", var_03, var_00, var_01);
  setmatchdata("supersExpired", var_03, "expirationThroughDeath", var_02);
  var_05 = 0;

  if(isDefined(self.scoreatsuperactivation)) {
    var_05 = self.score - self.scoreatsuperactivation;
  }

  setmatchdata("supersExpired", var_03, "scoreEarned", var_05);
}

logkillstreakavailableevent(var_00) {
  if(scripts\mp\utility\game::isgameparticipant(self) == 0) {
    return;
  }
  var_01 = _getmatchdata("killstreakAvailableCount");
  var_02 = var_01 + 1;
  setmatchdata("killstreakAvailableCount", var_02);

  if(!canlogclient(self) || var_01 >= level.func_B4A9) {
    return;
  }
  var_03 = gettimefrommatchstart(gettime());
  var_04 = -1;

  if(isDefined(self.matchdatalifeindex)) {
    var_04 = self.matchdatalifeindex;
  }

  setmatchdata("killstreaksAvailable", var_01, "eventType", var_00);
  setmatchdata("killstreaksAvailable", var_01, "playerLifeIndex", var_04);
  setmatchdata("killstreaksAvailable", var_01, "eventTime_msFromMatchStart", var_03);
}

logkillstreakevent(var_00, var_01) {
  if(scripts\mp\utility\game::isgameparticipant(self) == 0) {
    return;
  }
  var_01 = self.origin;
  var_02 = _getmatchdata("killstreakCount");
  var_03 = var_02 + 1;
  setmatchdata("killstreakCount", var_03);

  if(!canlogclient(self) || var_02 >= level.func_B4A8) {
    return;
  }
  var_04 = gettimefrommatchstart(gettime());
  var_05 = -1;

  if(isDefined(self.matchdatalifeindex)) {
    var_05 = self.matchdatalifeindex;
  }

  setmatchdata("killstreaks", var_02, "eventType", var_00);
  setmatchdata("killstreaks", var_02, "playerLifeIndex", var_05);
  setmatchdata("killstreaks", var_02, "eventTime_msFromMatchStart", var_04);
  setmatchdata("killstreaks", var_02, "playerPos", 0, int(var_1[0]));
  setmatchdata("killstreaks", var_02, "playerPos", 1, int(var_1[1]));
  setmatchdata("killstreaks", var_02, "playerPos", 2, int(var_1[2]));
  self.lastmatchdatakillstreakindex = var_02;
}

loggameevent(var_00, var_01) {
  if(isplayer(self) && !canlogclient(self)) {
    return;
  }
  var_02 = _getmatchdata("gameEventCount");
  var_03 = var_02 + 1;
  setmatchdata("gameEventCount", var_03);

  if(var_02 >= level.func_B49F) {
    return;
  }
  var_04 = gettimefrommatchstart(gettime());
  var_05 = -1;

  if(scripts\mp\utility\game::isgameparticipant(self) == 1) {
    if(isDefined(self.matchdatalifeindex)) {
      var_05 = self.matchdatalifeindex;
    }
  }

  setmatchdata("gameEvents", var_02, "eventType", var_00);
  setmatchdata("gameEvents", var_02, "playerLifeIndex", var_05);
  setmatchdata("gameEvents", var_02, "eventTime_msFromMatchStart", var_04);
  setmatchdata("gameEvents", var_02, "eventPos", 0, int(var_1[0]));
  setmatchdata("gameEvents", var_02, "eventPos", 1, int(var_1[1]));
  setmatchdata("gameEvents", var_02, "eventPos", 2, int(var_1[2]));
}

loginitialstats(var_00, var_01) {
  if(!canloglife(var_00)) {
    return;
  }
  setmatchdata("lives", var_00, "modifiers", var_01, 1);
}

func_AFCB(var_00, var_01) {
  if(!canloglife(var_00)) {
    return;
  }
  setmatchdata("lives", var_00, "multikill", var_01);
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

  if(isDefined(self.func_AE6D)) {
    var_03 = self.func_AE6D;
  }

  var_04 = gettimefrommatchstart(var_00);
  var_05 = self _meth_81EB(self.clientid, var_01, var_04, var_02, var_03);
  return var_05;
}

func_AFD7(var_00, var_01) {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, var_01, var_00);
}

logplayerdeath(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!canlogclient(self)) {
    return;
  }
  if(var_00 >= level.maxlives) {
    return;
  }
  if(var_04 == "agent_mp") {
    var_07 = [];
  }
  else {
    var_07 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_04);
    var_07 = scripts\mp\utility\game::func_249F(var_07);
  }

  var_08 = gettimefrommatchstart(gettime());
  var_09 = undefined;
  var_10 = [];

  if(isDefined(self.func_AA47)) {
    var_09 = self.func_AA47;
    var_10 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_09);
    var_10 = scripts\mp\utility\game::func_249F(var_10);

    if(scripts\mp\utility\game::ispickedupweapon(var_09)) {
      setmatchdata("lives", var_00, "victimCurrentWeaponPickedUp", 1);
    }
  }

  if(isDefined(self.super) && self.super.isinuse) {
    setmatchdata("lives", var_00, "victimSuperActive", 1);
  }

  var_11 = 0;

  if(isDefined(self.func_13905)) {
    var_11 = self.func_13905;
  }

  if(isplayer(var_01) && canlogclient(var_01)) {
    var_12 = var_01 scripts\mp\utility\game::func_9EE8();
    var_13 = 0.4226;
    var_14 = scripts\engine\utility::within_fov(self.origin, self.angles, var_1.origin, var_13);
    var_15 = scripts\engine\utility::within_fov(var_1.origin, var_1.angles, self.origin, var_13);
    var_16 = -1;

    if(isDefined(var_1.matchdatalifeindex)) {
      var_16 = var_1.matchdatalifeindex;
    }

    if(var_01 scripts\mp\utility\game::ispickedupweapon(var_04)) {
      setmatchdata("lives", var_00, "attackerWeaponPickedUp", 1);
    }

    if(isDefined(var_1.super) && var_1.super.isinuse && var_03 != "MOD_SUICIDE" && var_1.clientid != self.clientid) {
      setmatchdata("lives", var_00, "attackerSuperActive", 1);

      if(isDefined(var_1.pers["matchdataSuperKills"])) {
        var_1.pers["matchdataSuperKills"]++;
      }
      else {
        var_1.pers["matchdataSuperKills"] = 1;
      }
    }

    var_17 = scripts\mp\utility\game::iskillstreakweapon(var_04);
    self _meth_81E8(var_00, self.clientid, var_01, var_1.clientid, var_04, var_03, var_17, var_01 scripts\mp\utility\game::isjuggernaut(), var_07, var_08, var_09, var_10, var_11, var_12, var_15, var_14, var_16);

    if(var_17) {
      if(isDefined(var_1.lastmatchdatakillstreakindex) && var_1.lastmatchdatakillstreakindex != -1) {
        setmatchdata("lives", var_00, "attackerKillstreakIndex", var_1.lastmatchdatakillstreakindex);
      }
    } else
      setmatchdata("lives", var_00, "attackerKillstreakIndex", -1);

    if(isDefined(level.matchrecording_logevent)) {
      var_18 = gettime();
      [
        [level.matchrecording_logevent]
      ](self.clientid, self.team, "DEATH", self.origin[0], self.origin[1], var_18);

      if(issubstr(tolower(var_03), "bullet") && isDefined(var_04) && !scripts\mp\utility\game::iskillstreakweapon(var_04)) {
        [[level.matchrecording_logevent]](var_1.clientid, var_1.team, "BULLET", var_1.origin[0], var_1.origin[1], var_18, undefined, self.origin[0], self.origin[1]);
      }
    }
  } else {
    self _meth_81E8(var_00, self.clientid, undefined, undefined, var_04, var_03, scripts\mp\utility\game::iskillstreakweapon(var_04), 0, var_07, var_08, var_09, var_10, var_11, 0, 0, 0, -1);
    setmatchdata("lives", var_00, "attackerKillstreakIndex", -1);
  }

  logxpscoreearnedinlife(var_00);
}

logxpscoreearnedinlife(var_00) {
  var_01 = self.pers["summary"]["xp"];
  var_02 = var_01 - self.pers["xpAtLastDeath"];
  self.pers["xpAtLastDeath"] = var_01;
  var_03 = self.score - self.pers["scoreAtLastDeath"];
  self.pers["scoreAtLastDeath"] = self.score;
  setmatchdata("lives", var_00, "scoreEarned", var_03);
  setmatchdata("lives", var_00, "xpEarned", var_02);
}

logplayerdata() {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "score", scripts\mp\utility\game::getpersstat("score"));

  if(scripts\mp\utility\game::getpersstat("assists") > 255) {
    setmatchdata("players", self.clientid, "assists", 255);
  }
  else {
    setmatchdata("players", self.clientid, "assists", scripts\mp\utility\game::getpersstat("assists"));
  }

  if(scripts\mp\utility\game::getpersstat("longestStreak") > 255) {
    setmatchdata("players", self.clientid, "longestStreak", 255);
  }
  else {
    setmatchdata("players", self.clientid, "longestStreak", scripts\mp\utility\game::getpersstat("longestStreak"));
  }

  if(scripts\mp\utility\game::getpersstat("validationInfractions") > 255) {
    setmatchdata("players", self.clientid, "validationInfractions", 255);
  }
  else {
    setmatchdata("players", self.clientid, "validationInfractions", scripts\mp\utility\game::getpersstat("validationInfractions"));
  }

  setmatchdata("players", self.clientid, "kills", scripts\mp\utility\game::getpersstat("kills"));
  setmatchdata("players", self.clientid, "deaths", scripts\mp\utility\game::getpersstat("deaths"));
  self _meth_8572(self.clientid);
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;

  foreach(var_08, var_04 in self.pers["matchdataWeaponStats"]) {
    setmatchdata("players", self.clientid, "weaponStats", var_02, "weapon", var_4.weapon);
    setmatchdata("players", self.clientid, "weaponStats", var_02, "variantID", var_4.variantid);

    foreach(var_07, var_06 in var_4.func_10E53) {
      setmatchdata("players", self.clientid, "weaponStats", var_02, var_07, int(var_06));

      if(var_07 == "hits") {
        var_00 = var_00 + var_06;
      }

      if(var_07 == "shots") {
        var_01 = var_01 + var_06;
      }
    }

    var_2++;

    if(var_02 >= 20) {
      break;
    }
  }

  self grenade_model(self.clientid, var_01, var_00);
  var_09 = 0;

  if(isDefined(self.pers["matchdataSuperKills"])) {
    var_09 = self.pers["matchdataSuperKills"];
  }

  var_10 = 0;

  if(isDefined(self.pers["matchdataLongshotCount"])) {
    var_10 = self.pers["matchdataLongshotCount"];
  }

  var_11 = 0;

  if(isDefined(self.pers["matchdataDoubleKillsCount"])) {
    var_11 = self.pers["matchdataDoubleKillsCount"];
  }

  self _meth_85AC(self.clientid, scripts\mp\utility\game::getpersstat("headshots"), var_10, var_11, var_09);

  foreach(var_08, var_13 in self.pers["matchdataScoreEventCounts"]) {
  setmatchdata("players", self.clientid, "scoreEventCount", var_08, var_13);
  }

  setmatchdata("players", self.clientid, "playerXpModifier", int(scripts\mp\rank::getrankxpmultiplier()));

  if(level.teambased) {
    setmatchdata("players", self.clientid, "teamXpModifier", int(scripts\mp\rank::_meth_81B6(self.team)));
  }

  setmatchdata("players", self.clientid, "weaponXpModifier", int(scripts\mp\weaponrank::getweaponrankxpmultiplier()));
  level scripts\mp\playerlogic::writesegmentdata(self);

  if(isDefined(self.contracts)) {
    foreach(var_15 in self.contracts) {
      setmatchdata("players", self.clientid, "contracts", var_15.slot, "challengeID", var_15.id);
      setmatchdata("players", self.clientid, "contracts", var_15.slot, "progress", var_15.progress);
    }
  }
}

func_AFD8(var_00) {
  if(scripts\mp\utility\game::isgameparticipant(self) == 0) {
    return;
  }
  if(!canlogclient(self)) {
    return;
  }
  if(isDefined(self.pers["matchdataScoreEventCounts"][var_00])) {
    self.pers["matchdataScoreEventCounts"][var_00]++;
  }
  else {
    self.pers["matchdataScoreEventCounts"][var_00] = 1;
  }
}

func_636A() {
  level waittill("game_ended");

  foreach(var_01 in level.players) {
    wait 0.05;

    if(!isDefined(var_01)) {
      continue;
    }
    if(isDefined(var_1.weaponsused)) {
      var_01 doublebubblesort();
      var_02 = 0;

      if(var_1.weaponsused.size > 3) {
        for(var_03 = var_1.weaponsused.size - 1; var_03 > var_1.weaponsused.size - 3; var_3--) {
          var_01 setrankedplayerdata("common", "round", "weaponsUsed", var_02, var_1.weaponsused[var_03]);
          var_01 setrankedplayerdata("common", "round", "weaponXpEarned", var_02, var_1.weaponxpearned[var_03]);
          var_2++;
        }
      } else {
        for(var_03 = var_1.weaponsused.size - 1; var_03 >= 0; var_3--) {
          var_01 setrankedplayerdata("common", "round", "weaponsUsed", var_02, var_1.weaponsused[var_03]);
          var_01 setrankedplayerdata("common", "round", "weaponXpEarned", var_02, var_1.weaponxpearned[var_03]);
          var_2++;
        }
      }
    } else {
      var_01 setrankedplayerdata("common", "round", "weaponsUsed", 0, "none");
      var_01 setrankedplayerdata("common", "round", "weaponsUsed", 1, "none");
      var_01 setrankedplayerdata("common", "round", "weaponsUsed", 2, "none");
      var_01 setrankedplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var_01 setrankedplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var_01 setrankedplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var_1.func_3C30)) {
      var_01 setrankedplayerdata("common", "round", "challengeNumCompleted", var_1.func_3C30.size);
    }
    else {
      var_01 setrankedplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var_03 = 0; var_03 < 20; var_3++) {
      if(isDefined(var_1.func_3C30) && isDefined(var_1.func_3C30[var_03]) && var_1.func_3C30[var_03] != "ch_prestige" && !issubstr(var_1.func_3C30[var_03], "_daily") && !issubstr(var_1.func_3C30[var_03], "_weekly")) {
        var_01 setrankedplayerdata("common", "round", "challengesCompleted", var_03, var_1.func_3C30[var_03]);
        continue;
      }

      var_01 setrankedplayerdata("common", "round", "challengesCompleted", var_03, "ch_none");
    }

    var_01 setrankedplayerdata("common", "round", "gameMode", level.gametype);
    var_01 setrankedplayerdata("common", "round", "map", tolower(getdvar("mapname")));
  }
}

doublebubblesort() {
  var_00 = self.weaponxpearned;
  var_01 = self.weaponxpearned.size;

  for(var_02 = var_01 - 1; var_02 > 0; var_2--) {
    for(var_03 = 1; var_03 <= var_02; var_3++) {
      if(var_0[var_03 - 1] < var_0[var_03]) {
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

canlogclient(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }
  else if(isagent(var_00)) {
    return 0;
  }
  else if(!isplayer(var_00)) {
    return 0;
  }

  return var_0.clientid < level.maxlogclients;
}

canloglife(var_00) {
  return var_00 < level.maxlives;
}

func_AFDC(var_00, var_01, var_02, var_03) {
  if(!canlogclient(self)) {
    return;
  }
  if(scripts\mp\utility\game::iskillstreakweapon(var_00)) {
    return;
  }
  var_04 = var_00;

  if(isDefined(var_03)) {
    var_04 = var_04 + "+loot" + var_03;
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_04])) {
    self.pers["matchdataWeaponStats"][var_04] = spawnStruct();
    self.pers["matchdataWeaponStats"][var_04].func_10E53 = [];
    self.pers["matchdataWeaponStats"][var_04].weapon = var_00;

    if(isDefined(var_03)) {
      self.pers["matchdataWeaponStats"][var_04].variantid = var_03;
    }
    else {
      self.pers["matchdataWeaponStats"][var_04].variantid = -1;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_04].func_10E53[var_01])) {
    self.pers["matchdataWeaponStats"][var_04].func_10E53[var_01] = var_02;
  }
  else {
    self.pers["matchdataWeaponStats"][var_04].func_10E53[var_01] = self.pers["matchdataWeaponStats"][var_04].func_10E53[var_01] + var_02;
  }
}

func_AF94(var_00, var_01, var_02) {
  if(!canlogclient(self)) {
    return;
  }
  if(!scripts\mp\utility\game::func_2490(var_00)) {
    return;
  }
  var_03 = _getmatchdata("players", self.clientid, "attachmentsStats", var_00, var_01);
  var_04 = var_03 + var_02;
  setmatchdata("players", self.clientid, "attachmentsStats", var_00, var_01, var_04);
}

func_322A() {
  var_00 = [];
  var_01 = 149;

  for(var_02 = 0; var_02 <= var_01; var_2++) {
    var_03 = tablelookup("mp\statstable.csv", 0, var_02, 4);

    if(!issubstr(tablelookup("mp\statsTable.csv", 0, var_02, 2), "weapon_")) {
      continue;
    }
    if(tablelookup("mp\statsTable.csv", 0, var_02, 2) == "weapon_other") {
      continue;
    }
    var_0[var_0.size] = var_03;
  }

  return var_00;
}

func_AF99(var_00, var_01) {
  if(!canlogclient(self)) {
    return;
  }
  if(issubstr(var_00, "_daily") || issubstr(var_00, "_weekly")) {
    return;
  }
  var_02 = _getmatchdata("players", self.clientid, "challengeCount");

  if(var_02 < level.func_B4B5) {
    setmatchdata("players", self.clientid, "challenge", var_02, var_00);
    setmatchdata("players", self.clientid, "challengeCount", var_02 + 1);
  }
}

func_AF97(var_00) {
  if(!canlogclient(self)) {
    return;
  }
  var_01 = _getmatchdata("players", self.clientid, "awardCount");
  var_02 = var_01 + 1;
  setmatchdata("players", self.clientid, "awardCount", var_02);

  if(var_01 < level.func_B4B4) {
    setmatchdata("players", self.clientid, "awards", var_01, var_00);
  }

  if(var_00 == "double") {
    if(isDefined(self.pers["matchdataDoubleKillsCount"])) {
      self.pers["matchdataDoubleKillsCount"]++;
    }
    else {
      self.pers["matchdataDoubleKillsCount"] = 1;
    }
  } else if(var_00 == "longshot") {
    if(isDefined(self.pers["matchdataLongshotCount"])) {
      self.pers["matchdataLongshotCount"]++;
    }
    else {
      self.pers["matchdataLongshotCount"] = 1;
    }
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
    setmatchdata("players", self.clientid, "startXp", self getrankedplayerdata("mp", "progression", "playerLevel", "xp"));
    setmatchdata("players", self.clientid, "startKills", self getrankedplayerdata("mp", "kills"));
    setmatchdata("players", self.clientid, "startDeaths", self getrankedplayerdata("mp", "deaths"));
    setmatchdata("players", self.clientid, "startWins", self getrankedplayerdata("mp", "wins"));
    setmatchdata("players", self.clientid, "startLosses", self getrankedplayerdata("mp", "losses"));
    setmatchdata("players", self.clientid, "startHits", self getrankedplayerdata("mp", "hits"));
    setmatchdata("players", self.clientid, "startMisses", self getrankedplayerdata("mp", "misses"));
    setmatchdata("players", self.clientid, "startGamesPlayed", self getrankedplayerdata("mp", "gamesPlayed"));
    setmatchdata("players", self.clientid, "startTimePlayedTotal", self getrankedplayerdata("mp", "timePlayedTotal"));
    setmatchdata("players", self.clientid, "startScore", self getrankedplayerdata("mp", "score"));
    setmatchdata("players", self.clientid, "startPrestige", self getrankedplayerdata("mp", "progression", "playerLevel", "prestige"));
  }
}

logfinalstats() {
  if(!self _meth_8592()) {
    return;
  }
  if(getdvarint("mdsd") > 0) {
    setmatchdata("players", self.clientid, "endXp", self getrankedplayerdata("mp", "progression", "playerLevel", "xp"));
    setmatchdata("players", self.clientid, "endKills", self getrankedplayerdata("mp", "kills"));
    setmatchdata("players", self.clientid, "endDeaths", self getrankedplayerdata("mp", "deaths"));
    setmatchdata("players", self.clientid, "endWins", self getrankedplayerdata("mp", "wins"));
    setmatchdata("players", self.clientid, "endLosses", self getrankedplayerdata("mp", "losses"));
    setmatchdata("players", self.clientid, "endHits", self getrankedplayerdata("mp", "hits"));
    setmatchdata("players", self.clientid, "endMisses", self getrankedplayerdata("mp", "misses"));
    setmatchdata("players", self.clientid, "endGamesPlayed", self getrankedplayerdata("mp", "gamesPlayed"));
    setmatchdata("players", self.clientid, "endTimePlayedTotal", self getrankedplayerdata("mp", "timePlayedTotal"));
    setmatchdata("players", self.clientid, "endScore", self getrankedplayerdata("mp", "score"));
    setmatchdata("players", self.clientid, "endPrestige", self getrankedplayerdata("mp", "progression", "playerLevel", "prestige"));
  }
}