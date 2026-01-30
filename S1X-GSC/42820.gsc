/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42820.gsc
**************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    setmatchdatadef("mp/matchdata.def");
    setmatchdata("map", level.script);

    if(level.hardcoremode) {
      var_0 = level.gametype + " hc";
      setmatchdata("gametype", var_0);
    } else {
      setmatchdata("gametype", level.gametype);
    }

    setmatchdata("buildVersion", getbuildversion());
    setmatchdata("buildNumber", getbuildnumber());
    setmatchdataid();
  }

  level.maxlives = 490;
  level.maxevents = 150;
  level.maxkillstreaks = 64;
  level.maxlogclients = 30;
  level.maxnumchallengesperplayer = 5;
  level.maxnumawardsperplayer = 10;
  level.maxloadouts = 10;
  level thread gameendlistener();

  if(getdvar("virtualLobbyActive") != "1") {
    level thread reconlogplayerinfo();
  }
}

matchstarted() {
  if(getdvar("virtualLobbyActive") == "1") {
    return;
  }
  if(getdvar("mapname") == getdvar("virtualLobbyMap")) {
    return;
  }
  sysprint("MatchStarted: Completed");
  var_0 = getplaylistname();
  setmatchdata("playlistName", var_0);
  var_1 = getlocaltimestring();
  setmatchdata("localTimeStringAtMatchStart", var_1);

  if(getmatchstarttimeutc() == 0) {
    setmatchdata("startTimeUTC", getsystemtime());
  }

  setmatchdata("iseSports", maps\mp\_utility::ismlgmatch());

  if(maps\mp\_utility::privatematch()) {
    setmatchdata("privateMatch", 1);
  }

  if(maps\mp\_utility::practiceroundgame()) {
    setmatchdata("practiceRound", 1);
  }

  if(!maps\mp\_utility::isaugmentedgamemode()) {
    setmatchdata("classicMode", 1);
  }

  if(maps\mp\_utility::isdivisionmode()) {
    setmatchdata("divisionMode", 1);
  }

  var_2 = 0;

  if(isDefined(level.iszombiegame) && level.iszombiegame && isDefined(game["start_in_zmb_hard_mode"]) && game["start_in_zmb_hard_mode"]) {
    var_2 = 1;
  }

  setmatchdata("isHardMode", var_2);
  thread logbreadcrumbdata();
  thread accumulateplayerpingdata();
}

logbreadcrumbdata() {
  level endon("game_ended");

  for(;;) {
    var_0 = maps\mp\_utility::getgametimepassedseconds();

    foreach(var_2 in level.players) {
      if(isbot(var_2) || istestclient(var_2)) {
        continue;
      }
      if(maps\mp\_utility::isreallyalive(var_2) && isDefined(var_2.lifeid) && canloglife(var_2.lifeid)) {
        var_3 = 31;

        if(isDefined(var_2.lastshotby)) {
          var_3 = var_2.lastshotby;
        }

        recordbreadcrumbdataforplayer(var_2, var_2.lifeid, var_0, var_3);
        var_2.lastshotby = undefined;
      }
    }

    if(isDefined(level.iszombiegame) && level.iszombiegame) {
      wait 5;
      continue;
    }

    wait 2;
  }
}

accumulateplayerpingdata() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isbot(var_1) || istestclient(var_1)) {
        continue;
      }
      if(!isDefined(var_1.pers["pingAccumulation"]) || !isDefined(var_1.pers["minPing"]) || !isDefined(var_1.pers["maxPing"]) || !isDefined(var_1.pers["pingSampleCount"])) {
        continue;
      }
      var_2 = var_1 getcurrentping();
      var_1.pers["pingAccumulation"] = var_1.pers["pingAccumulation"] + var_2;
      var_1.pers["pingSampleCount"]++;

      if(var_1.pers["pingSampleCount"] > 5 && var_2 > 0) {
        if(var_2 > var_1.pers["maxPing"]) {
          var_1.pers["maxPing"] = var_2;
        }

        if(var_2 < var_1.pers["minPing"]) {
          var_1.pers["minPing"] = var_2;
        }
      }
    }

    wait 2;
  }
}

getmatchstarttimeutc() {
  return getmatchdata("startTimeUTC");
}

logkillstreakevent(var_0, var_1) {
  if(!canlogclient(self) || !canlogkillstreak()) {
    return;
  }
  var_2 = getmatchdata("killstreakCount");
  setmatchdata("killstreakCount", var_2 + 1);
  setmatchdata("killstreaks", var_2, "eventType", var_0);
  setmatchdata("killstreaks", var_2, "player", self.clientid);
  setmatchdata("killstreaks", var_2, "eventStartTimeDeciSecondsFromMatchStart", maps\mp\_utility::gettimepasseddeciseconds());
  setmatchdata("killstreaks", var_2, "eventPos", 0, int(var_1[0]));
  setmatchdata("killstreaks", var_2, "eventPos", 1, int(var_1[1]));
  setmatchdata("killstreaks", var_2, "eventPos", 2, int(var_1[2]));
  setmatchdata("killstreaks", var_2, "index", var_2);
  setmatchdata("killstreaks", var_2, "coopPlayerIndex", 255);
  self.currentkillstreakindex = var_2;
  reconspatialevent(var_1, "script_mp_killstreak: eventType %s, player_name %s, player %d, gameTime %d", var_0, self.name, self.clientid, gettime());
}

loggameevent(var_0, var_1) {
  if(!canlogclient(self) || !canlogevent()) {
    return;
  }
  var_2 = getmatchdata("eventCount");
  setmatchdata("eventCount", var_2 + 1);
  setmatchdata("events", var_2, "eventType", var_0);
  setmatchdata("events", var_2, "player", self.clientid);
  setmatchdata("events", var_2, "eventTimeDeciSecondsFromMatchStart", maps\mp\_utility::gettimepasseddeciseconds());
  setmatchdata("events", var_2, "eventPos", 0, int(var_1[0]));
  setmatchdata("events", var_2, "eventPos", 1, int(var_1[1]));
  setmatchdata("events", var_2, "eventPos", 2, int(var_1[2]));
  reconspatialevent(var_1, "script_mp_event: event_type %s, player_name %s, player %d, gameTime %d", var_0, self.name, self.clientid, gettime());
}

logkillevent(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  setmatchdata("lives", var_0, "modifiers", var_1, 1);
}

logmultikill(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  setmatchdata("lives", var_0, "multikill", var_1);
}

logplayerlife(var_0) {
  if(!canlogclient(self) || !canloglife(self.lifeid)) {
    return;
  }
  var_1 = gettime() - self.spawntime;
  self.totallifetime = self.totallifetime + var_1;
  var_2 = maps\mp\_utility::convertmillisecondstodecisecondsandclamptoshort(var_1);
  setmatchdata("lives", self.lifeid, "player", self.clientid);
  setmatchdata("lives", self.lifeid, "spawnPos", 0, int(self.spawnpos[0]));
  setmatchdata("lives", self.lifeid, "spawnPos", 1, int(self.spawnpos[1]));
  setmatchdata("lives", self.lifeid, "spawnPos", 2, int(self.spawnpos[2]));
  setmatchdata("lives", self.lifeid, "wasTacticalInsertion", self.wasti);
  setmatchdata("lives", self.lifeid, "team", self.team);

  if(isDefined(self.spawntimedecisecondsfrommatchstart)) {
    setmatchdata("lives", self.lifeid, "spawnTimeDeciSecondsFromMatchStart", self.spawntimedecisecondsfrommatchstart);
  } else {
    setmatchdata("lives", self.lifeid, "spawnTimeDeciSecondsFromMatchStart", -1);
  }

  setmatchdata("lives", self.lifeid, "durationDeciSeconds", var_2);
  var_3 = logloadout();
  setmatchdata("lives", self.lifeid, "loadoutIndex", var_3);
  var_4 = maps\mp\_utility::clamptoshort(self.pers["score"] - self.scoreatlifestart);
  setmatchdata("lives", self.lifeid, "scoreEarnedDuringThisLife", var_4);

  if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["xp"])) {
    if(isDefined(self.xpatlifestart)) {
      var_5 = maps\mp\_utility::clamptoshort(self.pers["summary"]["xp"] - self.xpatlifestart);
      setmatchdata("lives", self.lifeid, "xpEarnedDuringThisLife", var_5);
    }
  }
}

logplayerxp(var_0, var_1) {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, var_1, var_0);
}

logcompletedchallenge(var_0) {
  if(!isplayer(self) || !canlogclient(self) || isbot(self)) {
    return;
  }
  var_1 = getmatchdata("players", self.clientid, "challengeCount");

  if(var_1 < level.maxnumchallengesperplayer) {
    setmatchdata("players", self.clientid, "challenges", var_1, var_0);
    setmatchdata("players", self.clientid, "challengeCount", var_1 + 1);
  }
}

logloadout() {
  var_0 = 255;

  if(!canlogclient(self) || !canloglife(self.lifeid) || self.curclass == "gamemode") {
    return var_0;
  }

  var_1 = self.curclass;
  var_2 = 0;

  for(var_2 = 0; var_2 < level.maxloadouts; var_2++) {
    var_3 = getmatchdata("players", self.clientid, "loadouts", var_2, "slotUsed");

    if(!var_3) {
      break;
    } else {
      var_4 = getmatchdata("players", self.clientid, "loadouts", var_2, "className");

      if(var_1 == var_4) {
        return var_2;
      }
    }
  }

  if(var_2 == level.maxloadouts) {
    return var_0;
  }

  setmatchdata("players", self.clientid, "loadouts", var_2, "slotUsed", 1);
  setmatchdata("players", self.clientid, "loadouts", var_2, "className", var_1);
  var_5 = "";
  var_6 = "";
  var_7 = "";
  var_8 = "";
  var_9 = [];
  var_10 = [];
  var_11 = "";
  var_12 = 0;
  var_13 = "";
  var_14 = "";
  var_15 = 0;

  if(var_1 == "copycat") {
    var_16 = self.pers["copyCatLoadout"];
    var_17 = var_16["loadoutPrimary"];
    var_18 = var_16["loadoutPrimaryAttachment"];
    var_19 = var_16["loadoutPrimaryAttachment2"];
    var_20 = var_16["loadoutPrimaryAttachment3"];
    var_21 = var_16["loadoutPrimaryCamo"];
    var_22 = var_16["loadoutPrimaryReticle"];
    var_23 = var_16["loadoutSecondary"];
    var_24 = var_16["loadoutSecondaryAttachment"];
    var_25 = var_16["loadoutSecondaryAttachment2"];
    var_26 = var_16["loadoutSecondaryCamo"];
    var_27 = var_16["loadoutSecondaryReticle"];
    var_11 = var_16["loadoutEquipment"];
    var_12 = var_16["loadoutEquipmentExtra"];
    var_13 = var_16["loadoutOffhand"];
    var_15 = var_16["loadoutOffhandExtra"];

    for(var_28 = 0; var_28 < 6; var_28++) {
      var_9[var_28] = var_16["loadoutPerks"][var_28];
    }

    for(var_28 = 0; var_28 < 3; var_28++) {
      var_10[var_28] = var_16["loadoutWildcards"][var_28];
    }

    var_5 = var_16["loadoutKillstreaks"][0];
    var_29 = var_16["loadoutKillstreakModules"][0][0];
    var_30 = var_16["loadoutKillstreakModules"][0][1];
    var_31 = var_16["loadoutKillstreakModules"][0][2];
    var_6 = var_16["loadoutKillstreaks"][1];
    var_32 = var_16["loadoutKillstreakModules"][1][0];
    var_33 = var_16["loadoutKillstreakModules"][1][1];
    var_34 = var_16["loadoutKillstreakModules"][1][2];
    var_7 = var_16["loadoutKillstreaks"][2];
    var_35 = var_16["loadoutKillstreakModules"][2][0];
    var_36 = var_16["loadoutKillstreakModules"][2][1];
    var_37 = var_16["loadoutKillstreakModules"][2][2];
    var_8 = var_16["loadoutKillstreaks"][3];
    var_38 = var_16["loadoutKillstreakModules"][3][0];
    var_39 = var_16["loadoutKillstreakModules"][3][1];
    var_40 = var_16["loadoutKillstreakModules"][3][2];
  } else if(issubstr(var_1, "custom")) {
    var_41 = maps\mp\_utility::getclassindex(var_1);
    var_17 = maps\mp\gametypes\_class::cac_getweapon(var_41, 0);
    var_18 = maps\mp\gametypes\_class::cac_getweaponattachment(var_41, 0);
    var_19 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo(var_41, 0);
    var_20 = maps\mp\gametypes\_class::cac_getweaponattachmentthree(var_41, 0);
    var_21 = maps\mp\gametypes\_class::cac_getweaponcamo(var_41, 0);

    for(var_28 = 0; var_28 < 6; var_28++) {
      var_9[var_28] = maps\mp\gametypes\_class::cac_getperk(var_41, var_28);
    }

    for(var_28 = 0; var_28 < 3; var_28++) {
      var_10[var_28] = maps\mp\gametypes\_class::cac_getwildcard(var_41, var_28);
    }

    var_23 = maps\mp\gametypes\_class::cac_getweapon(var_41, 1);
    var_24 = maps\mp\gametypes\_class::cac_getweaponattachment(var_41, 1);
    var_25 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo(var_41, 1);
    var_26 = maps\mp\gametypes\_class::cac_getweaponcamo(var_41, 1);
    var_11 = maps\mp\gametypes\_class::cac_getequipment(var_41, 0);
    var_12 = maps\mp\gametypes\_class::cac_getequipmentextra(var_41, 0);
    var_13 = maps\mp\gametypes\_class::cac_getoffhand(var_41);
    var_5 = maps\mp\gametypes\_class::cac_getkillstreak(var_41, 0);
    var_29 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 0, 0);
    var_30 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 0, 1);
    var_31 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 0, 2);
    var_6 = maps\mp\gametypes\_class::cac_getkillstreak(var_41, 1);
    var_32 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 1, 0);
    var_33 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 1, 1);
    var_34 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 1, 2);
    var_7 = maps\mp\gametypes\_class::cac_getkillstreak(var_41, 2);
    var_35 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 2, 0);
    var_36 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 2, 1);
    var_37 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 2, 2);
    var_8 = maps\mp\gametypes\_class::cac_getkillstreak(var_41, 3);
    var_38 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 3, 0);
    var_39 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 3, 1);
    var_40 = maps\mp\gametypes\_class::cac_getkillstreakmodule(var_41, 3, 2);
  } else if(issubstr(var_1, "practice")) {
    var_41 = maps\mp\_utility::getclassindex(var_1);
    var_41 = self.pers["practiceRoundClasses"][var_41];
    var_17 = maps\mp\gametypes\_class::table_getweapon(level.practiceroundclasstablename, var_41, 0);
    var_18 = maps\mp\gametypes\_class::table_getweaponattachment(level.practiceroundclasstablename, var_41, 0, 0);
    var_19 = maps\mp\gametypes\_class::table_getweaponattachment(level.practiceroundclasstablename, var_41, 0, 1);
    var_20 = maps\mp\gametypes\_class::table_getweaponattachment(level.practiceroundclasstablename, var_41, 0, 2);
    var_21 = maps\mp\gametypes\_class::table_getweaponcamo(level.practiceroundclasstablename, var_41, 0);
    var_23 = maps\mp\gametypes\_class::table_getweapon(level.practiceroundclasstablename, var_41, 1);
    var_24 = maps\mp\gametypes\_class::table_getweaponattachment(level.practiceroundclasstablename, var_41, 1, 0);
    var_25 = maps\mp\gametypes\_class::table_getweaponattachment(level.practiceroundclasstablename, var_41, 1, 1);
    var_26 = maps\mp\gametypes\_class::table_getweaponcamo(level.practiceroundclasstablename, var_41, 1);
    var_11 = maps\mp\gametypes\_class::table_getequipment(level.practiceroundclasstablename, var_41);
    var_12 = maps\mp\gametypes\_class::table_getequipmentextra(level.practiceroundclasstablename, var_41);
    var_13 = maps\mp\gametypes\_class::table_getoffhand(level.practiceroundclasstablename, var_41);

    for(var_28 = 0; var_28 < 6; var_28++) {
      var_9[var_28] = maps\mp\gametypes\_class::table_getperk(level.practiceroundclasstablename, var_41, var_28);
    }

    for(var_28 = 0; var_28 < 3; var_28++) {
      var_10[var_28] = maps\mp\gametypes\_class::table_getwildcard(level.practiceroundclasstablename, var_41, var_28);
    }

    var_5 = maps\mp\gametypes\_class::table_getkillstreak(level.practiceroundclasstablename, var_41, 0);
    var_29 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 0, 0);
    var_30 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 0, 1);
    var_31 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 0, 2);
    var_6 = maps\mp\gametypes\_class::table_getkillstreak(level.practiceroundclasstablename, var_41, 1);
    var_32 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 1, 0);
    var_33 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 1, 1);
    var_34 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 1, 2);
    var_7 = maps\mp\gametypes\_class::table_getkillstreak(level.practiceroundclasstablename, var_41, 2);
    var_35 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 2, 0);
    var_36 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 2, 1);
    var_37 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 2, 2);
    var_8 = maps\mp\gametypes\_class::table_getkillstreak(level.practiceroundclasstablename, var_41, 3);
    var_38 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 3, 0);
    var_39 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 3, 1);
    var_40 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.practiceroundclasstablename, var_41, 3, 2);
  } else {
    var_41 = maps\mp\_utility::getclassindex(var_1);
    var_17 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_41, 0);
    var_18 = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_41, 0, 0);
    var_19 = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_41, 0, 1);
    var_20 = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_41, 0, 2);
    var_21 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_41, 0);

    for(var_28 = 0; var_28 < 6; var_28++) {
      var_9[var_28] = maps\mp\gametypes\_class::table_getperk(level.classtablename, var_41, var_28);
    }

    for(var_28 = 0; var_28 < 3; var_28++) {
      var_10[var_28] = maps\mp\gametypes\_class::table_getwildcard(level.classtablename, var_41, var_28);
    }

    var_23 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_41, 1);
    var_24 = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_41, 1, 0);
    var_25 = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, var_41, 1, 1);
    var_26 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_41, 1);
    var_11 = maps\mp\gametypes\_class::table_getequipment(level.classtablename, var_41);
    var_12 = maps\mp\gametypes\_class::table_getequipmentextra(level.classtablename, var_41);
    var_13 = maps\mp\gametypes\_class::table_getoffhand(level.classtablename, var_41);
    var_5 = maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_41, 0);
    var_29 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 0, 0);
    var_30 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 0, 1);
    var_31 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 0, 2);
    var_6 = maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_41, 1);
    var_32 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 1, 0);
    var_33 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 1, 1);
    var_34 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 1, 2);
    var_7 = maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_41, 2);
    var_35 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 2, 0);
    var_36 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 2, 1);
    var_37 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 2, 2);
    var_8 = maps\mp\gametypes\_class::table_getkillstreak(level.classtablename, var_41, 3);
    var_38 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 3, 0);
    var_39 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 3, 1);
    var_40 = maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename, var_41, 3, 2);
  }

  var_18 = maps\mp\_utility::attachmentmap_tobase(var_18);
  var_19 = maps\mp\_utility::attachmentmap_tobase(var_19);
  var_20 = maps\mp\_utility::attachmentmap_tobase(var_20);
  var_24 = maps\mp\_utility::attachmentmap_tobase(var_24);
  var_25 = maps\mp\_utility::attachmentmap_tobase(var_25);
  setmatchdata("players", self.clientid, "loadouts", var_2, "primaryWeapon", var_17);
  setmatchdata("players", self.clientid, "loadouts", var_2, "primaryAttachments", 0, var_18);
  setmatchdata("players", self.clientid, "loadouts", var_2, "primaryAttachments", 1, var_19);
  setmatchdata("players", self.clientid, "loadouts", var_2, "primaryAttachments", 2, var_20);

  for(var_28 = 0; var_28 < 6; var_28++) {
    setmatchdata("players", self.clientid, "loadouts", var_2, "perkSlots", var_28, var_9[var_28]);
  }

  for(var_28 = 0; var_28 < 3; var_28++) {
    setmatchdata("players", self.clientid, "loadouts", var_2, "wildcardSlots", var_28, var_10[var_28]);
  }

  setmatchdata("players", self.clientid, "loadouts", var_2, "secondaryWeapon", var_23);
  setmatchdata("players", self.clientid, "loadouts", var_2, "secondaryAttachments", 0, var_24);
  setmatchdata("players", self.clientid, "loadouts", var_2, "secondaryAttachments", 1, var_25);
  setmatchdata("players", self.clientid, "loadouts", var_2, "offhandWeapon", var_13);
  setmatchdata("players", self.clientid, "loadouts", var_2, "equipment", var_11);
  setmatchdata("players", self.clientid, "loadouts", var_2, "equipmentWeaponExtra", var_12);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 0, "streak", var_5);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 0, "modules", 0, var_29);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 0, "modules", 1, var_30);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 0, "modules", 2, var_31);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 1, "streak", var_6);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 1, "modules", 0, var_32);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 1, "modules", 1, var_33);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 1, "modules", 2, var_34);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 2, "streak", var_7);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 2, "modules", 0, var_35);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 2, "modules", 1, var_36);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 2, "modules", 2, var_37);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 3, "streak", var_8);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 3, "modules", 0, var_38);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 3, "modules", 1, var_39);
  setmatchdata("players", self.clientid, "loadouts", var_2, "assaultStreaks", 3, "modules", 2, var_40);
  thread recon_log_loadout(self, var_17, var_18, var_19, var_20, var_21, var_23, var_24, var_25, var_26, var_11, var_12, var_13, var_9[0], var_9[1], var_9[2], var_9[3], var_9[4], var_9[5], var_10[0], var_10[1], var_10[2], var_5, var_29, var_30, var_31, var_6, var_32, var_33, var_34, var_7, var_35, var_36, var_37, var_8, var_38, var_39, var_40);
  return var_2;
}

recon_log_loadout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31, var_32, var_33, var_34, var_35, var_36, var_37) {
  var_38 = isbot(var_0) || istestclient(var_0);
  var_39 = "_matchdata.gsc";
  var_40 = var_0.spawntime;
  var_41 = var_0.curclass;
  var_42 = var_0.name;
  reconevent("script_mp_loadout_gear: script_file %s, gameTime %d, player_name %s, is_bot %b, class %s, primary_weapon %s, primary_attach_1 %s, primary_attach_2 %s, primary_attach_3 %s, primary_camo %s, secondary_weapon %s, secondary_attach_1 %s, secondary_attach_2 %s, secondary_camo %s, equipment %s, equipment_extra %b, exo_ability %s", var_39, var_40, var_42, var_38, var_41, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  reconevent("script_mp_loadout_perks: script_file %s, gameTime %d, player_name %s, perk_1 %s, perk_2 %s, perk_3 %s, perk_4 %s, perk_5 %s, perk_6 %s, wildcard_1 %s, wildcard_2 %s, wildcard_3 %s", var_39, var_40, var_42, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21);
  reconevent("script_mp_loadout_killstreaks: script_file %s, gameTime %d, player_name %s, killstreak_1 %s, killstreak_1_module_a %s, killstreak_1_module_b %s, killstreak_1_module_c %s, killstreak_2 %s, killstreak_2_module_a %s, killstreak_2_module_b %s, killstreak_2_module_c %s, killstreak_3 %s, killstreak_3_module_a %s, killstreak_3_module_b %s, killstreak_3_module_c %s, killstreak_4 %s, killstreak_4_module_a %s, killstreak_4_module_b %s, killstreak_4_module_c %s", var_39, var_40, var_42, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31, var_32, var_33, var_34, var_35, var_36, var_37);
}

logplayerandkillerexomovedata(var_0, var_1) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  var_2 = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();

  if(isDefined(self.exocount["exo_boost"]) && isDefined(self.exomostrecenttimedeciseconds["exo_boost"])) {
    var_3 = maps\mp\_utility::clamptobyte(self.exocount["exo_boost"]);
    setmatchdata("lives", var_0, "numberOfBoosts", var_3);
    var_4 = maps\mp\_utility::clamptobyte(var_2 - self.exomostrecenttimedeciseconds["exo_boost"]);
    setmatchdata("lives", var_0, "victimDeciSecondsSinceLastBoost", var_4);
  }

  if(isDefined(self.exocount["ground_slam"]) && isDefined(self.exomostrecenttimedeciseconds["ground_slam"])) {
    var_3 = maps\mp\_utility::clamptobyte(self.exocount["ground_slam"]);
    setmatchdata("lives", var_0, "numberOfBoostsSlams", var_3);
    var_4 = maps\mp\_utility::clamptobyte(var_2 - self.exomostrecenttimedeciseconds["ground_slam"]);
    setmatchdata("lives", var_0, "victimDeciSecondsSinceLastBoostSlam", var_4);
  }

  if(isDefined(self.exocount["exo_dodge"]) && isDefined(self.exomostrecenttimedeciseconds["exo_dodge"])) {
    var_3 = maps\mp\_utility::clamptobyte(self.exocount["exo_dodge"]);
    setmatchdata("lives", var_0, "numberOfDodges", var_3);
    var_4 = maps\mp\_utility::clamptobyte(var_2 - self.exomostrecenttimedeciseconds["exo_dodge"]);
    setmatchdata("lives", var_0, "victimDeciSecondsSinceLastDodge", var_4);
  }

  if(isDefined(self.exocount["exo_slide"])) {
    var_3 = maps\mp\_utility::clamptobyte(self.exocount["exo_slide"]);
    setmatchdata("lives", var_0, "numberOfKneeSlides", var_3);
  }

  if(isplayer(var_1)) {
    if(!isDefined(var_1.exomostrecenttimedeciseconds)) {
      return;
    }
    if(isDefined(var_1.exomostrecenttimedeciseconds["exo_boost"])) {
      var_4 = maps\mp\_utility::clamptobyte(var_2 - var_1.exomostrecenttimedeciseconds["exo_boost"]);
      setmatchdata("lives", var_0, "killerDeciSecondsSinceLastBoost", var_4);
    }

    if(isDefined(var_1.exomostrecenttimedeciseconds["ground_slam"])) {
      var_4 = maps\mp\_utility::clamptobyte(var_2 - var_1.exomostrecenttimedeciseconds["ground_slam"]);
      setmatchdata("lives", var_0, "killerDeciSecondsSinceLastBoostSlam", var_4);
    }

    if(isDefined(var_1.exomostrecenttimedeciseconds["exo_dodge"])) {
      var_4 = maps\mp\_utility::clamptobyte(var_2 - var_1.exomostrecenttimedeciseconds["exo_dodge"]);
      setmatchdata("lives", var_0, "killerDeciSecondsSinceLastDodge", var_4);
    }
  }
}

logplayerandkilleradsandfov(var_0, var_1) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  if(isplayer(var_1)) {
    if(var_1 playerads() > 0.5) {
      setmatchdata("lives", var_0, "killerWasADS", 1);
    }

    var_2 = var_1 getEye();

    if(common_scripts\utility::within_fov(var_2, var_1.angles, self.origin, cos(getdvarfloat("cg_fov")))) {
      setmatchdata("lives", var_0, "victimWasInKillersFOV", 1);
    }

    var_3 = self getEye();

    if(common_scripts\utility::within_fov(var_3, self.angles, var_1.origin, cos(getdvarfloat("cg_fov")))) {
      setmatchdata("lives", var_0, "killerWasInVictimsFOV", 1);
    }
  }

  if(self playerads() > 0.5) {
    setmatchdata("lives", var_0, "victimWasADS", 1);
  }
}

logplayerandkillershieldcloakhoveractive(var_0, var_1) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  if(isDefined(self.exo_shield_on) && self.exo_shield_on) {
    setmatchdata("lives", var_0, "victimShieldActive", 1);
  }

  if(isDefined(self.exo_hover_on) && self.exo_hover_on) {
    setmatchdata("lives", var_0, "victimHoverActive", 1);
  }

  if(self iscloaked()) {
    setmatchdata("lives", var_0, "victimCloakingActive", 1);
  }

  if(isplayer(var_1)) {
    if(isDefined(var_1.exo_shield_on) && var_1.exo_shield_on) {
      setmatchdata("lives", var_0, "killerShieldActive", 1);
    }

    if(isDefined(var_1.exo_hover_on) && var_1.exo_hover_on) {
      setmatchdata("lives", var_0, "killerHoverActive", 1);
    }

    if(var_1 iscloaked()) {
      setmatchdata("lives", var_0, "killerCloakingActive", 1);
    }
  }
}

determineweaponnameandattachments(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(var_0 == "none") {
    var_2 = "none";
    var_3 = "none";
  } else {
    var_2 = weaponinventorytype(var_0);
    var_3 = weaponclass(var_0);
  }

  if(issubstr(var_0, "destructible")) {
    var_0 = "destructible";
  }

  var_4 = [];
  var_4[0] = "None";
  var_4[1] = "None";
  var_4[2] = "None";
  var_5 = "";

  if(isDefined(var_2) && (var_2 == "primary" || var_2 == "altmode") && (var_3 == "pistol" || var_3 == "smg" || var_3 == "rifle" || var_3 == "spread" || var_3 == "mg" || var_3 == "grenade" || var_3 == "rocketlauncher" || var_3 == "sniper" || var_3 == "cone" || var_3 == "beam" || var_3 == "shield")) {
    if(var_2 == "altmode") {
      if(isDefined(var_1)) {
        var_0 = var_1;
      }
    }

    var_6 = maps\mp\_utility::getweaponnametokens(var_0);
    var_5 = maps\mp\_utility::getbaseweaponname(var_0);

    if(var_6[0] == "iw5" || var_6[0] == "iw6") {
      var_7 = getweaponattachments(var_0);
      var_8 = 0;

      foreach(var_10 in var_7) {
        if(!maps\mp\_utility::isattachment(var_10)) {
          continue;
        }
        var_11 = maps\mp\_utility::attachmentmap_tobase(var_10);

        if(var_8 <= 2) {
          var_4[var_8] = var_11;
          var_8++;
          continue;
        }

        break;
      }
    } else if(var_6[0] == "alt") {
      var_13 = var_6[1] + "_" + var_6[2];
      var_5 = var_13;

      if(isDefined(var_6[4]) && maps\mp\_utility::isattachment(var_6[4])) {
        var_11 = maps\mp\_utility::attachmentmap_tobase(var_6[4]);
        var_4[0] = var_11;
      }

      if(isDefined(var_6[5]) && maps\mp\_utility::isattachment(var_6[5])) {
        var_11 = maps\mp\_utility::attachmentmap_tobase(var_6[5]);
        var_4[1] = var_11;
      }
    } else {
      var_6[var_6.size - 1] = undefined;

      if(isDefined(var_6[1]) && var_2 != "altmode") {
        var_11 = maps\mp\_utility::attachmentmap_tobase(var_6[1]);
        var_4[0] = var_11;
      }

      if(isDefined(var_6[2]) && var_2 != "altmode") {
        var_11 = maps\mp\_utility::attachmentmap_tobase(var_6[2]);
        var_4[1] = var_11;
      }
    }
  } else if(var_2 == "item" || var_2 == "offhand") {
    var_5 = maps\mp\_utility::strip_suffix(var_0, "_lefthand");
    var_5 = maps\mp\_utility::strip_suffix(var_5, "_mp");
  } else {
    var_5 = var_0;
  }

  var_14 = spawnStruct();
  var_14.weaponname = var_5;
  var_14.attachments = var_4;
  var_14.weapontype = var_2;
  var_14.weaponclass = var_3;
  var_14.weaponnamefull = var_0;
  return var_14;
}

logfirefightshotshits(var_0, var_1) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(!isplayer(var_1)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  if(self.currentfirefightshots > 0) {
    setmatchdata("lives", var_0, "shots", maps\mp\_utility::clamptobyte(self.currentfirefightshots));
  }

  if(isDefined(var_1.enemyhitcounts) && isDefined(var_1.enemyhitcounts[self.guid]) && var_1.enemyhitcounts[self.guid] > 0) {
    setmatchdata("lives", var_0, "hits", maps\mp\_utility::clamptobyte(var_1.enemyhitcounts[self.guid]));
  }

  if(var_1.currentfirefightshots > 0) {
    setmatchdata("lives", var_0, "killerShots", maps\mp\_utility::clamptobyte(var_1.currentfirefightshots));
  }

  if(isDefined(self.enemyhitcounts) && isDefined(self.enemyhitcounts[var_1.guid]) && self.enemyhitcounts[var_1.guid] > 0) {
    setmatchdata("lives", var_0, "killerHits", maps\mp\_utility::clamptobyte(self.enemyhitcounts[var_1.guid]));
  }
}

logplayerandkillerstanceandmotionstate(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  if(isplayer(self) && canlogclient(self)) {
    var_2 = getstanceandmotionstateforplayer(self);
    setmatchdata("lives", var_0, "victimStanceAndMotionState", var_2);
  }

  if(isplayer(var_1) && canlogclient(var_1)) {
    var_2 = getstanceandmotionstateforplayer(var_1);
    setmatchdata("lives", var_0, "killerStanceAndMotionState", var_2);
  }
}

logassists(var_0, var_1) {
  if(!canloglife(var_0)) {
    return;
  }
  if(isplayer(self) && canlogclient(self)) {
    if(isDefined(self.attackerdata)) {
      var_2 = 0;

      foreach(var_4 in self.attackerdata) {
        if(isplayer(var_4.attackerent)) {
          if(var_4.attackerent != var_1) {
            setmatchdata("lives", var_0, "assists", var_2, "assistingPlayerIndex", var_4.attackerent.clientid);
            setmatchdata("lives", var_0, "assists", var_2, "damage", maps\mp\_utility::clamptobyte(var_4.damage));
            var_2++;

            if(var_2 == 5) {
              break;
            }
          }
        }
      }

      if(var_2 < 5) {
        for(var_6 = var_2; var_6 < 5; var_6++) {
          setmatchdata("lives", var_0, "assists", var_6, "assistingPlayerIndex", 255);
        }
      }
    }
  }
}

logspecialassists(var_0, var_1) {
  if(!isplayer(self) || !canlogclient(self)) {
    return;
  }
  if(!isplayer(var_0) || !canlogclient(var_0)) {
    return;
  }
  var_2 = self.lifeid;

  if(!canloglife(var_2)) {
    return;
  }
  if(var_1 == "assist_emp" || var_1 == "assist_uav" || var_1 == "assist_uav_plus" || var_1 == "assist_riot_shield") {
    for(var_3 = 0; var_3 < 5; var_3++) {
      var_4 = getmatchdata("lives", var_2, "assists", var_3, "assistingPlayerIndex");

      if(var_4 == var_0.clientid || var_4 == 255) {
        if(var_4 == 255) {
          setmatchdata("lives", var_2, "assists", var_3, "assistingPlayerIndex", var_0.clientid);
        }

        if(var_1 == "assist_emp") {
          setmatchdata("lives", var_2, "assists", var_3, "assistEMP", 1);
        } else if(var_1 == "assist_uav") {
          setmatchdata("lives", var_2, "assists", var_3, "assistUAV", 1);
        } else if(var_1 == "assist_uav_plus") {
          setmatchdata("lives", var_2, "assists", var_3, "assistUAVPlus", 1);
        } else if(var_1 == "assist_riot_shield") {
          setmatchdata("lives", var_2, "assists", var_3, "assistRiotShield", 1);
        } else {}

        break;
      }
    }
  }
}

logplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!canlogclient(self) || isplayer(var_1) && !canlogclient(var_1) || !canloglife(var_0)) {
    return;
  }
  if(var_0 >= level.maxlives) {
    return;
  }
  if(level.iszombiegame) {
    return;
  }
  if(isDefined(level.ishorde) && level.ishorde) {
    return;
  }
  logplayerandkillerexomovedata(var_0, var_1);
  logplayerandkilleradsandfov(var_0, var_1);
  logplayerandkillershieldcloakhoveractive(var_0, var_1);
  logfirefightshotshits(var_0, var_1);
  logplayerandkillerstanceandmotionstate(var_0, var_1);
  logassists(var_0, var_1);
  var_8 = determineweaponnameandattachments(var_4, var_5);

  for(var_9 = 0; var_9 < 3; var_9++) {
    if(isDefined(var_8.attachments[var_9]) && var_8.attachments[var_9] != "None") {
      setmatchdata("lives", var_0, "killersWeaponAttachments", var_9, var_8.attachments[var_9]);
    }
  }

  if(var_8.weapontype != "exclusive") {
    setmatchdata("lives", var_0, "killersWeapon", var_8.weaponname);
  }

  if(var_8.weaponnamefull == "altmode") {
    setmatchdata("lives", var_0, "killersWeaponAltMode", 1);
  }

  if(maps\mp\_utility::iskillstreakweapon(var_8.weaponnamefull)) {
    setmatchdata("lives", var_0, "modifiers", "killstreak", 1);

    if(isDefined(var_1.currentkillstreakindex)) {
      var_10 = getmatchdata("killstreaks", var_1.currentkillstreakindex, "killsTotal");
      var_10++;
      setmatchdata("killstreaks", var_1.currentkillstreakindex, "killsTotal", maps\mp\_utility::clamptoshort(var_10));
      setmatchdata("lives", var_0, "killerKillstreakIndex", var_1.currentkillstreakindex);
    }
  } else {
    setmatchdata("lives", var_0, "killerKillstreakIndex", 255);
  }

  var_11 = determineweaponnameandattachments(var_7, undefined);

  for(var_9 = 0; var_9 < 3; var_9++) {
    if(isDefined(var_11.attachments[var_9]) && var_11.attachments[var_9] != "None") {
      setmatchdata("lives", var_0, "victimCurrentWeaponAtDeathAttachments", var_9, var_11.attachments[var_9]);
    }
  }

  if(var_11.weapontype != "exclusive") {
    if(maps\mp\_utility::iskillstreakweapon(var_11.weaponname)) {
      if(isDefined(self.primaryweapon)) {
        var_12 = maps\mp\_utility::getbaseweaponname(self.primaryweapon);
        setmatchdata("lives", var_0, "victimCurrentWeaponAtDeath", var_12);
      }
    } else {
      setmatchdata("lives", var_0, "victimCurrentWeaponAtDeath", var_11.weaponname);
    }
  }

  if(isDefined(self.pickedupweaponfrom) && isDefined(self.pickedupweaponfrom[var_11.weaponnamefull])) {
    setmatchdata("lives", var_0, "victimCurrentWeaponPickedUp", 1);
  }

  setmatchdata("lives", var_0, "meansOfDeath", var_3);
  var_13 = 2;

  if(isplayer(var_1)) {
    setmatchdata("lives", var_0, "killer", var_1.clientid);
    setmatchdata("lives", var_0, "killerLifeIndex", var_1.lifeid);
    setmatchdata("lives", var_0, "killerPos", 0, int(var_1.origin[0]));
    setmatchdata("lives", var_0, "killerPos", 1, int(var_1.origin[1]));
    setmatchdata("lives", var_0, "killerPos", 2, int(var_1.origin[2]));
    setmatchdata("lives", var_0, "killerAngles", 0, int(var_1.angles[0]));
    setmatchdata("lives", var_0, "killerAngles", 1, int(var_1.angles[1]));
    setmatchdata("lives", var_0, "killerAngles", 2, int(var_1.angles[2]));
    var_14 = anglesToForward((0, self.angles[1], 0));
    var_15 = self.origin - var_1.origin;
    var_15 = vectornormalize((var_15[0], var_15[1], 0));
    var_13 = vectordot(var_14, var_15);
    setmatchdata("lives", var_0, "dotOfDeath", var_13);

    if(var_1 maps\mp\_utility::isjuggernaut()) {
      setmatchdata("lives", var_0, "killerIsJuggernaut", 1);
    }

    if(isDefined(var_1.pickedupweaponfrom) && isDefined(var_1.pickedupweaponfrom[var_8.weaponnamefull])) {
      setmatchdata("lives", var_0, "killerCurrentWeaponPickedUp", 1);
    }
  } else {
    setmatchdata("lives", var_0, "killer", 255);
    setmatchdata("lives", var_0, "killerLifeIndex", 65535);
    setmatchdata("lives", var_0, "killerPos", 0, int(self.origin[0]));
    setmatchdata("lives", var_0, "killerPos", 1, int(self.origin[1]));
    setmatchdata("lives", var_0, "killerPos", 2, int(self.origin[2]));
    setmatchdata("lives", var_0, "killerAngles", 0, int(self.angles[0]));
    setmatchdata("lives", var_0, "killerAngles", 1, int(self.angles[1]));
    setmatchdata("lives", var_0, "killerAngles", 2, int(self.angles[2]));
  }

  setmatchdata("lives", var_0, "player", self.clientid);
  setmatchdata("lives", var_0, "victimPos", 0, int(self.origin[0]));
  setmatchdata("lives", var_0, "victimPos", 1, int(self.origin[1]));
  setmatchdata("lives", var_0, "victimPos", 2, int(self.origin[2]));
  setmatchdata("lives", var_0, "victimAngles", 0, int(self.angles[0]));
  setmatchdata("lives", var_0, "victimAngles", 1, int(self.angles[1]));
  setmatchdata("lives", var_0, "victimAngles", 2, int(self.angles[2]));
  var_16 = "world";

  if(isplayer(var_1)) {
    var_16 = var_1.name;
  }

  var_17 = 1;
  var_18 = 0;
  var_19 = maps\mp\_utility::isaiteamparticipant(self);
  var_20 = 0;

  if(isplayer(var_1)) {
    var_20 = maps\mp\_utility::isaiteamparticipant(var_1);
  }

  var_21 = length(self.origin - var_1.origin);
  var_22 = 0;
  var_23 = 0.0;
  var_24 = -1;
  var_25 = -1;
  var_26 = gettime();

  if(isplayer(var_1)) {
    var_23 = var_1 playerads();
  }

  var_27 = var_1.clientid;

  if(!isDefined(var_27)) {
    var_27 = -1;
  }

  var_28 = var_1.lifeid;

  if(!isDefined(var_28)) {
    var_28 = -1;
  }

  var_29 = 0.1;

  if(self.damage_info.size > 1) {
    var_17 = 0;
  }

  if(isDefined(self.damage_info[var_1 getentitynumber()])) {
    var_18 = self.damage_info[var_1 getentitynumber()].num_shots;
  }

  var_30 = self.pers["primaryWeapon"] + "_mp";
  var_31 = weaponclass(var_30);

  if(issubstr(var_8.weaponname, "loot")) {
    var_22 = 1;
  }

  if(isDefined(self.spawninfo) && isDefined(self.spawninfo.spawntime)) {
    var_24 = (var_26 - self.spawninfo.spawntime) / 1000.0;
  }

  if(isDefined(var_1.spawninfo) && isDefined(var_1.spawninfo.spawntime) && isplayer(var_1)) {
    var_25 = (var_26 - var_1.spawninfo.spawntime) / 1000.0;
  }

  reconspatialevent(self.origin, "script_mp_playerdeath: player_name %s, life_id %d, angles %v, death_dot %f, is_jugg %b, is_killstreak %b, mod %s, gameTime %d, spawnToDeathTime %f, attackerAliveTime %f, attacker_life_id %d", self.name, self.lifeid, self.angles, var_13, var_1 maps\mp\_utility::isjuggernaut(), maps\mp\_utility::iskillstreakweapon(var_8.weaponnamefull), var_3, var_26, var_24, var_25, var_28);
  reconspatialevent(self.origin, "script_mp_weaponinfo: player_name %s, life_id %d, isbot %b, attacker_name %s, attacker %d, attacker_pos %v, distance %f, ads_fraction %f, is_jugg %b, is_killstreak %b, weapon_type %s, weapon_class %s, weapon_name %s, isLoot %b, attachment0 %s, attachment1 %s, attachment2 %s, numShots %d, soleAttacker %b, gameTime %d", self.name, self.lifeid, var_19, var_16, var_27, var_1.origin, var_21, var_23, var_1 maps\mp\_utility::isjuggernaut(), maps\mp\_utility::iskillstreakweapon(var_8.weaponnamefull), var_8.weapontype, var_8.weaponclass, var_8.weaponname, var_22, var_8.attachments[0], var_8.attachments[1], var_8.attachments[2], var_18, var_17, var_26);
  reconspatialevent(self.origin, "script_mp_weaponinfo_ext: player_name %s, life_id %d, gametime %d, version %f, victimWeapon %s, victimWeaponClass %s, killerIsBot %b", self.name, self.lifeid, var_26, var_29, var_30, var_31, var_20);

  if(!isDefined(level.matchdata)) {
    level.matchdata = [];
  }

  if(!isDefined(level.matchdata["deathCount"])) {
    level.matchdata["deathCount"] = 1;
  } else {
    level.matchdata["deathCount"]++;
  }

  if(var_24 <= 3.0) {
    if(!isDefined(level.matchdata["badSpawnDiedTooFastCount"])) {
      level.matchdata["badSpawnDiedTooFastCount"] = 1;
    } else {
      level.matchdata["badSpawnDiedTooFastCount"]++;
    }

    if(self.spawninfo.badspawn == 0) {
      if(!isDefined(level.matchdata["badSpawnByAnyMeansCount"])) {
        level.matchdata["badSpawnByAnyMeansCount"] = 1;
      } else {
        level.matchdata["badSpawnByAnyMeansCount"]++;
      }

      self.spawninfo.badspawn = 1;
    }
  }

  if(isplayer(var_1) && var_25 <= 3.0 && !(var_8.weaponname == "sentry_minigun_mp")) {
    if(!isDefined(level.matchdata["badSpawnKilledTooFastCount"])) {
      level.matchdata["badSpawnKilledTooFastCount"] = 1;
    } else {
      level.matchdata["badSpawnKilledTooFastCount"]++;
    }

    if(var_1.spawninfo.badspawn == 0) {
      if(!isDefined(level.matchdata["badSpawnByAnyMeansCount"])) {
        level.matchdata["badSpawnByAnyMeansCount"] = 1;
      } else {
        level.matchdata["badSpawnByAnyMeansCount"]++;
      }

      var_1.spawninfo.badspawn = 1;
    }
  }
}

logplayerdata() {
  if(!canlogclient(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "score", maps\mp\_utility::getpersstat("score"));

  if(maps\mp\_utility::getpersstat("assists") > 255) {
    setmatchdata("players", self.clientid, "assists", 255);
  } else {
    setmatchdata("players", self.clientid, "assists", maps\mp\_utility::getpersstat("assists"));
  }

  if(maps\mp\_utility::getpersstat("longestStreak") > 255) {
    setmatchdata("players", self.clientid, "longestStreak", 255);
  } else {
    setmatchdata("players", self.clientid, "longestStreak", maps\mp\_utility::getpersstat("longestStreak"));
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    if(maps\mp\_utility::getpersstat("validationInfractions") > 255) {
      setmatchdata("players", self.clientid, "validationInfractions", 255);
    } else {
      setmatchdata("players", self.clientid, "validationInfractions", maps\mp\_utility::getpersstat("validationInfractions"));
    }
  }
}

endofgamesummarylogger() {
  foreach(var_1 in level.players) {
    wait 0.05;

    if(!isDefined(var_1)) {
      continue;
    }
    logplayerping(var_1);

    if(isDefined(var_1.detectedexploit) && var_1.detectedexploit && var_1 maps\mp\_utility::rankingenabled()) {
      var_1 setrankedplayerdata("restXPGoal", var_1.detectedexploit);
    }

    var_2 = undefined;
    var_3 = 0;

    if(isDefined(game["challengeStruct"]) && isDefined(game["challengeStruct"]["challengesCompleted"]) && isDefined(game["challengeStruct"]["challengesCompleted"][var_1.guid])) {
      var_3 = 1;
    }

    if(var_3) {
      var_2 = game["challengeStruct"]["challengesCompleted"][var_1.guid];

      if(var_2.size > 0) {
        var_1 setcommonplayerdata("round", "challengeNumCompleted", var_2.size);
        var_4 = maps\mp\_utility::clamptobyte(var_2.size);
        setmatchdata("players", var_1.clientid, "challengesCompleted", var_4);
      } else {
        var_1 setcommonplayerdata("round", "challengeNumCompleted", 0);
      }
    } else {
      var_1 setcommonplayerdata("round", "challengeNumCompleted", 0);
    }

    for(var_5 = 0; var_5 < 20; var_5++) {
      if(isDefined(var_2) && isDefined(var_2[var_5]) && var_2[var_5] != 8000) {
        var_1 setcommonplayerdata("round", "challengesCompleted", var_5, var_2[var_5]);
        continue;
      }

      var_1 setcommonplayerdata("round", "challengesCompleted", var_5, 0);
    }

    var_1 setcommonplayerdata("round", "gameMode", level.gametype);
    var_1 setcommonplayerdata("round", "map", tolower(getdvar("mapname")));
  }
}

logplayerping(var_0) {
  if(!isDefined(var_0.pers["maxPing"]) || !isDefined(var_0.pers["minPing"]) || !isDefined(var_0.pers["pingAccumulation"]) || !isDefined(var_0.pers["pingSampleCount"])) {
    return;
  }
  if(var_0.pers["pingSampleCount"] > 0 && var_0.pers["maxPing"] > 0) {
    var_1 = maps\mp\_utility::clamptoshort(var_0.pers["pingAccumulation"] / var_0.pers["pingSampleCount"]);
    setmatchdata("players", var_0.clientid, "averagePing", var_1);
    setmatchdata("players", var_0.clientid, "maxPing", maps\mp\_utility::clamptoshort(var_0.pers["maxPing"]));
    setmatchdata("players", var_0.clientid, "minPing", maps\mp\_utility::clamptoshort(var_0.pers["minPing"]));
  }
}

gameendlistener() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    var_1 logplayerdata();

    if(!isalive(var_1)) {
      continue;
    }
    var_1 logplayerlife(0);
  }

  foreach(var_1 in level.players) {
    if(var_1.totallifetime > 0) {
      var_4 = var_1 maps\mp\_utility::getpersstat("score") / (var_1.totallifetime / 60000);
      tournamentreportplayerspm(var_1.xuid, var_4, var_1.team);
    }

    var_1.totallifetime = 0;
  }
}

canlogclient(var_0) {
  if(isagent(var_0)) {
    return 0;
  }

  var_1 = var_0.code_classname;

  if(!isDefined(var_1)) {
    var_1 = "undefined";
  }

  return var_0.clientid < level.maxlogclients;
}

canlogevent() {
  return getmatchdata("eventCount") < level.maxevents;
}

canlogkillstreak() {
  return getmatchdata("killstreakCount") < level.maxkillstreaks;
}

canloglife(var_0) {
  return getmatchdata("lifeCount") < level.maxlives;
}

logweaponstat(var_0, var_1, var_2) {
  if(!canlogclient(self)) {
    return;
  }
  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return;
  }
  if(!isDefined(self.pers["mpWeaponStats"][var_0])) {
    self.pers["mpWeaponStats"][var_0] = [];
  }

  if(!isDefined(self.pers["mpWeaponStats"][var_0][var_1])) {
    self.pers["mpWeaponStats"][var_0][var_1] = 0;
  }

  var_3 = self.pers["mpWeaponStats"][var_0][var_1];
  var_3 = var_3 + var_2;
  self.pers["mpWeaponStats"][var_0][var_1] = var_3;
}

buildbaseweaponlist() {
  var_0 = [];
  var_1 = 149;

  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = tablelookup("mp/statstable.csv", 0, var_2, 4);

    if(var_3 == "") {
      continue;
    }
    if(!issubstr(tablelookup("mp/statsTable.csv", 0, var_2, 2), "weapon_")) {
      continue;
    }
    if(tablelookup("mp/statsTable.csv", 0, var_2, 2) == "weapon_other") {
      continue;
    }
    if(tablelookup("mp/statsTable.csv", 0, var_2, 51) != "") {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
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

loginitialstats() {
  if(getdvarint("mdsd") > 0) {
    var_0 = self getrankedplayerdata("experience");
    setmatchdata("players", self.clientid, "startXp", var_0);
    setmatchdata("players", self.clientid, "startKills", self getrankedplayerdata("kills"));
    setmatchdata("players", self.clientid, "startDeaths", self getrankedplayerdata("deaths"));
    setmatchdata("players", self.clientid, "startWins", self getrankedplayerdata("wins"));
    setmatchdata("players", self.clientid, "startLosses", self getrankedplayerdata("losses"));
    setmatchdata("players", self.clientid, "startHits", self getrankedplayerdata("hits"));
    setmatchdata("players", self.clientid, "startMisses", self getrankedplayerdata("misses"));
    setmatchdata("players", self.clientid, "startGamesPlayed", self getrankedplayerdata("gamesPlayed"));
    setmatchdata("players", self.clientid, "startScore", self getrankedplayerdata("score"));
    setmatchdata("players", self.clientid, "startUnlockPoints", self getrankedplayerdata("unlockPoints"));
    setmatchdata("players", self.clientid, "startPrestige", self getrankedplayerdata("prestige"));
    setmatchdata("players", self.clientid, "startDP", self getrankedplayerdata("division"));
    var_1 = self getrankedplayerdata("mmr");
    setmatchdata("players", self.clientid, "startMMR", var_1);
  }
}

logfinalstats() {
  if(getdvarint("mdsd") > 0) {
    var_0 = self getrankedplayerdata("experience");
    setmatchdata("players", self.clientid, "endXp", var_0);
    setmatchdata("players", self.clientid, "endKills", self getrankedplayerdata("kills"));
    setmatchdata("players", self.clientid, "endDeaths", self getrankedplayerdata("deaths"));
    setmatchdata("players", self.clientid, "endWins", self getrankedplayerdata("wins"));
    setmatchdata("players", self.clientid, "endLosses", self getrankedplayerdata("losses"));
    setmatchdata("players", self.clientid, "endHits", self getrankedplayerdata("hits"));
    setmatchdata("players", self.clientid, "endMisses", self getrankedplayerdata("misses"));
    setmatchdata("players", self.clientid, "endGamesPlayed", self getrankedplayerdata("gamesPlayed"));
    setmatchdata("players", self.clientid, "endScore", self getrankedplayerdata("score"));
    setmatchdata("players", self.clientid, "endUnlockPoints", self getrankedplayerdata("unlockPoints"));
    setmatchdata("players", self.clientid, "endPrestige", self getrankedplayerdata("prestige"));
    var_1 = self getrankedplayerdata("mmr");
    setmatchdata("players", self.clientid, "endMMR", var_1);

    if(isDefined(self.pers["rank"])) {
      var_3 = maps\mp\_utility::clamptobyte(maps\mp\gametypes\_rank::getrank());
      setmatchdata("players", self.clientid, "rankAtEnd", var_3);
    }
  }
}

reconlogplayerinfo() {
  for(;;) {
    if(getdvarint("cl_freemove") == 0) {
      foreach(var_1 in level.players) {
        var_2 = 0;

        if(maps\mp\_utility::isreallyalive(var_1)) {
          var_2 = 1;
        }

        if(istestclient(var_1)) {
          continue;
        }
        if(!isDefined(var_1.origin)) {
          continue;
        }
        var_3 = "disconnected?";

        if(isDefined(var_1.name)) {
          var_3 = var_1.name;
        }

        var_4 = -1;

        if(isDefined(var_1.clientid)) {
          var_4 = var_1.clientid;
        }

        var_5 = (-999, -999, -999);

        if(isDefined(var_1.angles)) {
          var_5 = var_1.angles;
        }

        var_6 = "undefined";

        if(isDefined(var_1.team)) {
          var_6 = var_1.team;
        }

        var_7 = gettime();
        reconspatialevent(var_1.origin, "script_mp_playerpos: player_name %s, angles %v, gameTime %d, playerTeam %s, is_alive %b", var_3, var_5, var_7, var_6, var_2);
      }
    }

    wait 0.2;
  }
}