/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_matchdata.gsc
***********************************************/

init() {
  if(getdvarint("online_matchdata_enabled") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdata("commonMatchData", "map", level.script);

    if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19()) {
      _id_E97B68032A8F5332 = scripts\cp\utility::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", _id_E97B68032A8F5332);
    } else
      setmatchdata("commonMatchData", "gametype", scripts\cp\utility::getgametype());

    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "is_private_match", scripts\cp\utility::privatematch());
  }

  if(getdvarint("online_matchdata_enabled") != 0)
    level.maxlogclients = 30;
  else if(level.gametype != "dungeons")
    level.maxlogclients = 0;

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
  level.matchdata_logaward = ::logaward;
  level.matchdataattachmentstatsenabled = 0;
  level thread endofgamesummarylogger();
}

onmatchstart() {
  setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
  setmatchdata("commonMatchData", "player_count_start", level.players.size);
}

onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("commonMatchData", "utc_end_time_s", level.endtimeutcseconds);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(_id_187A04151C40FB72::getglobalrankxpmultiplier()));
  setmatchdata("globalWeaponXpModifier", int(scripts\cp\cp_weaponrank::getglobalweaponrankxpmultiplier()));
}

logplayerdata(_id_934DC135AAF6F953) {
  if(!_id_4A6760982B403BAD::_id_0892570944F6B6A2(self)) {
    return;
  }
  self sendclientnetworktelemetry();
}

endofgamesummarylogger() {
  level waittill("game_ended", winner);

  foreach(player in level.players) {
    wait 0.05;

    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(winner))
      player scripts\cp_mp\utility\game_utility::stopkeyearning(winner);

    if(isDefined(player.challengescompleted))
      player setplayerdata("common", "round", "challengeNumCompleted", player.challengescompleted.size);
    else
      player setplayerdata("common", "round", "challengeNumCompleted", 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 20; _id_AC0E594AC96AA3A8++) {
      if(isDefined(player.challengescompleted) && isDefined(player.challengescompleted[_id_AC0E594AC96AA3A8]) && player.challengescompleted[_id_AC0E594AC96AA3A8] != "ch_prestige" && !issubstr(player.challengescompleted[_id_AC0E594AC96AA3A8], "_daily") && !issubstr(player.challengescompleted[_id_AC0E594AC96AA3A8], "_weekly")) {
        player setplayerdata("common", "round", "challengesCompleted", _id_AC0E594AC96AA3A8, player.challengescompleted[_id_AC0E594AC96AA3A8]);
        continue;
      }

      player setplayerdata("common", "round", "challengesCompleted", _id_AC0E594AC96AA3A8, "ch_none");
    }

    _id_10D864DD73F88213 = tolower(getDvar("g_mapname"));
    player setplayerdata("common", "round", "gameMode", scripts\cp\utility::getgametype());
    player setplayerdata("common", "round", "map", _id_10D864DD73F88213);

    if(istrue(level.matchmakingmatch)) {
      _id_D5685B7BAEE6505E = 0;
      add = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
        _id_365929041E4386ED = player getplayerdata("mp", "mapsPlayed", _id_AC0E594AC96AA3A8);

        if(_id_365929041E4386ED == "") {
          _id_D5685B7BAEE6505E = _id_AC0E594AC96AA3A8;
          add = 1;
          break;
        }

        if(_id_365929041E4386ED == _id_10D864DD73F88213) {
          _id_D5685B7BAEE6505E = _id_AC0E594AC96AA3A8;
          add = 0;
          break;
        }
      }

      if(add == 1)
        player setplayerdata("mp", "mapsPlayed", _id_D5685B7BAEE6505E, _id_10D864DD73F88213);
      else {
        index = _id_D5685B7BAEE6505E;

        for(_id_AC0E594AC96AA3A8 = _id_D5685B7BAEE6505E; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
          index = _id_AC0E594AC96AA3A8 + 1;
          _id_365929041E4386ED = player getplayerdata("mp", "mapsPlayed", _id_AC0E594AC96AA3A8 + 1);
          player setplayerdata("mp", "mapsPlayed", _id_AC0E594AC96AA3A8, _id_365929041E4386ED);

          if(_id_365929041E4386ED == "") {
            index = _id_AC0E594AC96AA3A8;
            break;
          }
        }

        player setplayerdata("mp", "mapsPlayed", index, _id_10D864DD73F88213);
      }
    }
  }
}

logattachmentstat(_id_FF180C307F2BAFD3, _id_629757F5C9E770D8, _id_A1D4E7D5EF9DA660, weapon) {
  if(!level.matchdataattachmentstatsenabled)
    return;
}

logkillstreakevent(event, position) {}

logattackerkillevent(lifeid, eventref) {}

logvictimkillevent(lifeid, eventref) {}

logmultikill(lifeid, _id_5FD73D74128A5E31) {}

logchallenge(_id_33BE63BF54F72FA9, tier) {}

_id_0FF48D255C865806(_id_2C6CA80E296FED3A) {
  if(_id_4A6760982B403BAD::_id_0892570944F6B6A2(_id_2C6CA80E296FED3A))
    return _id_2C6CA80E296FED3A.clientid < level.maxlogclients;
  else
    return 0;
}

initpersstat(_id_B03F67117DA3F61A) {
  if(!isDefined(self.pers[_id_B03F67117DA3F61A]))
    self.pers[_id_B03F67117DA3F61A] = 0;
}

getpersstat(_id_B03F67117DA3F61A) {
  return self.pers[_id_B03F67117DA3F61A];
}

incpersstat(_id_B03F67117DA3F61A, _id_2F977E27FA739602) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[_id_B03F67117DA3F61A]))
    self.pers[_id_B03F67117DA3F61A] = self.pers[_id_B03F67117DA3F61A] + _id_2F977E27FA739602;
}

setextrascore0(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore0 = _id_8F617FFD000EB682;
  self.pers["extrascore0"] = _id_8F617FFD000EB682;
}

setextrascore1(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore1 = _id_8F617FFD000EB682;
  self.pers["extrascore1"] = _id_8F617FFD000EB682;
}

setextrascore2(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore2 = _id_8F617FFD000EB682;
  self.pers["extrascore2"] = _id_8F617FFD000EB682;
}

setextrascore3(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore3 = _id_8F617FFD000EB682;
  self.pers["extrascore3"] = _id_8F617FFD000EB682;
}

getplayerdataloadoutgroup() {
  return "cploadouts";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "infect";
}

getstreakrecordtype(streakname) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", streakname))
    return "lethalScorestreakStats";

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", streakname))
    return "supportScorestreakStats";

  return undefined;
}

logaward(_id_84EA5CF2793332C1) {}