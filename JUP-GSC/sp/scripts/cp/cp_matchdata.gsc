/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_matchdata.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace cp_matchdata;

function init() {
  if(getdvarint(@ "online_matchdata_enabled") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdata("commonMatchData", "map", level.script);

    if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
      tmp = scripts\cp\utility::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", tmp);
    } else {
      setmatchdata("commonMatchData", "gametype", scripts\cp\utility::getgametype());
    }

    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "is_private_match", scripts\cp\utility::privatematch());
  }

  if(getdvarint(@ "online_matchdata_enabled") != 0) {
    level.maxlogclients = 30;
  } else if(level.gametype != "dungeons") {
    level.maxlogclients = 0;
  }

  level.maxlives = 475;
  level.maxnamelength = 26;
  level.maxgameevents = 250;
  level.maxkillstreaks = 64;
  level.maxkillstreaksavailable = 64;
  level.maxnumchallengesperplayer = 10;
  level.maxnumawardsperplayer = 10;
  level.maxsupersavailable = 50;
  level.maxsupersactivated = 50;
  level.maxsupersexpired = 50;
  level.matchdata_logaward = &logaward;
  level.matchdataattachmentstatsenabled = 0;
  level thread endofgamesummarylogger();
}

function onmatchstart() {
  setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
  setmatchdata("commonMatchData", "player_count_start", level.players.size);
}

function onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("commonMatchData", "utc_end_time_s", level.endtimeutcseconds);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);

  if(!function_ccf98e6391dd38b9()) {
    setmatchdata("globalPlayerXpModifier", int(scripts\cp\rank::getglobalrankxpmultiplier()));
    setmatchdata("globalWeaponXpModifier", int(scripts\cp\cp_weaponrank::getglobalweaponrankxpmultiplier()));
  }
}

function logplayerdata(disconnectreason) {
  if(!namespace_de6e6777b0937bd7::function_892570944f6b6a2(self)) {
    return;
  }

  self sendclientnetworktelemetry();
}

function endofgamesummarylogger() {
  level waittill("game_ended");

  if(level.gametype == "dungeons") {
    current_map = tolower(getDvar(@ "g_mapname"));
    level.players[0] setplayerdata("common", "round", "gameMode", scripts\cp\utility::getgametype());
    level.players[0] setplayerdata("common", "round", "map", current_map);
    return;
  }

  foreach(player in level.players) {
    wait 0.05;

    if(!isDefined(player)) {
      continue;
    }

    player scripts\cp_mp\utility\game_utility::stopkeyearning();

    if(isDefined(player.challengescompleted)) {
      player setplayerdata("common", "round", "challengeNumCompleted", player.challengescompleted.size);
    } else {
      player setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(i = 0; i < 20; i++) {
      if(isDefined(player.challengescompleted) && isDefined(player.challengescompleted[i]) && player.challengescompleted[i] != "ch_prestige" && !issubstr(player.challengescompleted[i], "_daily") && !issubstr(player.challengescompleted[i], "_weekly")) {
        player setplayerdata("common", "round", "challengesCompleted", i, player.challengescompleted[i]);
        continue;
      }

      player setplayerdata("common", "round", "challengesCompleted", i, "ch_none");
    }

    current_map = tolower(getDvar(@ "g_mapname"));
    player setplayerdata("common", "round", "gameMode", scripts\cp\utility::getgametype());
    player setplayerdata("common", "round", "map", current_map);

    if(istrue(level.matchmakingmatch)) {
      start_pos = 0;
      add = 0;

      for(i = 0; i < 5; i++) {
        map = player getplayerdata("mp", "mapsPlayed", i);

        if(map == "") {
          start_pos = i;
          add = 1;
          break;
        }

        if(map == current_map) {
          start_pos = i;
          add = 0;
          break;
        }
      }

      if(add == 1) {
        player setplayerdata("mp", "mapsPlayed", start_pos, current_map);
        continue;
      }

      index = start_pos;

      for(i = start_pos; i < 4; i++) {
        index = i + 1;
        map = player getplayerdata("mp", "mapsPlayed", i + 1);
        player setplayerdata("mp", "mapsPlayed", i, map);

        if(map == "") {
          index = i;
          break;
        }
      }

      player setplayerdata("mp", "mapsPlayed", index, current_map);
    }
  }
}

function logattachmentstat(attachname, statname, incvalue, weapon) {
  if(!level.matchdataattachmentstatsenabled) {
    return;
  }

  println("<dev string:x1c>");
}

function logkillstreakevent(event, position) {
  println("<dev string:x44>");
}

function logattackerkillevent(lifeid, eventref) {
  println("<dev string:x91>");
}

function logvictimkillevent(lifeid, eventref) {
  println("<dev string:xfc>");
}

function logmultikill(lifeid, multikillcount) {
  println("<dev string:x165>");
}

function logchallenge(challengename, tier) {
  println("<dev string:x188>");
}

function function_ff48d255c865806(client) {
  if(namespace_de6e6777b0937bd7::function_892570944f6b6a2(client)) {
    return (client.clientid < level.maxlogclients);
  }

  return 0;
}

function initpersstat(dataname) {
  if(!isDefined(self.pers[dataname])) {
    self.pers[dataname] = 0;
  }
}

function getpersstat(dataname) {
  return self.pers[dataname];
}

function incpersstat(dataname, increment) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[dataname])) {
    self.pers[dataname] += increment;
  }
}

function setextrascore0(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore0 = newvalue;
  self.pers["extrascore0"] = newvalue;
}

function setextrascore1(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore1 = newvalue;
  self.pers["extrascore1"] = newvalue;
}

function setextrascore2(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore2 = newvalue;
  self.pers["extrascore2"] = newvalue;
}

function setextrascore3(newvalue) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore3 = newvalue;
  self.pers["extrascore3"] = newvalue;
}

function getplayerdataloadoutgroup() {
  return "cploadouts";
}

function setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

function canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "infect";
}

function getstreakrecordtype(streakname) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", streakname)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", streakname)) {
    return "supportScorestreakStats";
  }

  return undefined;
}

function logaward(awardname) {}