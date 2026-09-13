/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gamescore.gsc
***********************************************/

gethighestscoringteam() {
  _id_C7761B0132ABCFA7 = 0;
  _id_01FF67BA127220E2 = undefined;
  _id_CA17ACB9EA3FA61D = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_929A6DF466DC4F22 = game["teamScores"][_id_F90358454413407F];

    if(!isDefined(_id_01FF67BA127220E2) || _id_929A6DF466DC4F22 > _id_C7761B0132ABCFA7) {
      _id_C7761B0132ABCFA7 = _id_929A6DF466DC4F22;
      _id_01FF67BA127220E2 = _id_F90358454413407F;
      _id_CA17ACB9EA3FA61D = 0;
      continue;
    }

    if(_id_929A6DF466DC4F22 == _id_C7761B0132ABCFA7)
      _id_CA17ACB9EA3FA61D = 1;
  }

  if(_id_CA17ACB9EA3FA61D)
    return "tie";
  else
    return _id_01FF67BA127220E2;
}

gethighestscore(_id_21AEBAA767023F1E) {
  _id_C7761B0132ABCFA7 = 0;
  _id_01FF67BA127220E2 = undefined;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(_id_21AEBAA767023F1E) && _id_F90358454413407F == _id_21AEBAA767023F1E) {
      continue;
    }
    _id_929A6DF466DC4F22 = game["teamScores"][_id_F90358454413407F];

    if(!isDefined(_id_01FF67BA127220E2) || _id_929A6DF466DC4F22 > _id_C7761B0132ABCFA7) {
      _id_C7761B0132ABCFA7 = _id_929A6DF466DC4F22;
      _id_01FF67BA127220E2 = _id_F90358454413407F;
    }
  }

  return [_id_01FF67BA127220E2, game["teamScores"][_id_01FF67BA127220E2]];
}

updateteamscoreplacements() {
  level notify("updateTeamScorePlacement");
  level endon("updateTeamScorePlacement");
  waittillframeend;
  _id_2E2DD5105CE091DC = tablesort(game["teamScores"], "down");
  _id_4F7F0599B533DA3C = undefined;
  _id_E6D7DE89AE05A160 = 0;

  foreach(team in _id_2E2DD5105CE091DC) {
    score = game["teamScores"][team];

    if(!isDefined(_id_4F7F0599B533DA3C) || score < _id_4F7F0599B533DA3C) {
      _id_4F7F0599B533DA3C = score;
      _id_E6D7DE89AE05A160++;
    }

    game["teamPlacements"][team] = _id_E6D7DE89AE05A160;
  }
}

getteamscoreplacements() {
  return game["teamPlacements"];
}

compareteamscores(left, right) {
  return left.score > right.score;
}

gethighestscoringplayer() {
  updateplacement();

  if(!level.placement["all"].size)
    return undefined;
  else
    return level.placement["all"][0];
}

ishighestscoringplayertied() {
  if(level.placement["all"].size > 1) {
    _id_EAACD90D8890A4D5 = _getplayerscore(level.placement["all"][0]);
    _id_3331C4C617629161 = _getplayerscore(level.placement["all"][1]);
    return _id_EAACD90D8890A4D5 == _id_3331C4C617629161;
  }

  return 0;
}

getlosingplayers() {
  updateplacement();
  players = level.placement["all"];
  _id_15030F107E796007 = [];

  foreach(player in players) {
    if(player == level.placement["all"][0]) {
      continue;
    }
    _id_15030F107E796007[_id_15030F107E796007.size] = player;
  }

  return _id_15030F107E796007;
}

giveplayerscore(event, points, victim, _id_7EC7671A1E0C788F) {
  if(istrue(level.gameended)) {
    isvalidevent = 0;

    if(isarray(event)) {
      if(isnumber(level.gameendtime)) {
        if(event[1] <= level.gameendtime) {
          isvalidevent = 1;
          event = event[0];
        }
      }
    } else if(isDefined(event))
      isvalidevent = 1;

    if(!isvalidevent)
      return;
  } else if(isarray(event))
    event = event[0];

  if(istrue(level.ignorescoring)) {
    _id_587EB1F4E11A34F3 = 1;
    _id_E7A7E20EC68138E3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done");

    if(_id_E7A7E20EC68138E3)
      _id_587EB1F4E11A34F3 = 0;

    if(_id_587EB1F4E11A34F3)
      return;
  }

  if(!level.teambased) {
    foreach(player in level.players) {
      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(player != self) {
          continue;
        }
        if(level.roundscorelimit > 1 && player.pers["score"] >= level.roundscorelimit)
          return;
      } else if(level.roundscorelimit > 1 && player.pers["score"] >= level.roundscorelimit)
        return;
    }
  }

  player = self;

  if(isDefined(self.owner) && !isbot(self))
    player = self.owner;

  if(!isPlayer(player)) {
    return;
  }
  _id_353F1E80E9476419 = points;

  if(isDefined(level.onplayerscore))
    points = [[level.onplayerscore]](event, player, points, victim, _id_7EC7671A1E0C788F);

  if(points == 0) {
    return;
  }
  scripts\cp_mp\challenges::_id_CF995E658AB79867(player, points);
  player.pers["score"] = int(max(player.pers["score"] + points, 0));

  if(level._id_27DCAF9644646944 == "stat_44B6AC7B2928D30C")
    player scripts\mp\utility\points::displayscoreeventpoints(_id_353F1E80E9476419, event);

  player scripts\mp\playerstats_interface::addtoplayerstat(int(_id_353F1E80E9476419), "matchStats", "score");

  if(player.pers["score"] >= 65000)
    player.pers["score"] = 65000;

  player.score = player.pers["score"];
  _id_67686728E255208B = player.score;
  player scripts\mp\persistence::statsetchild("round", "score", _id_67686728E255208B);
  player scripts\mp\gamelogic::checkplayerscorelimitsoon();
  player thread scripts\mp\gamelogic::checkscorelimit();
  player scripts\mp\utility\script::bufferednotify("earned_score_buffered", points);
  scripts\mp\analyticslog::logevent_reportgamescore(points, gettime(), scripts\mp\rank::getscoreinfocategory(event, "stat_EC3B335BB0B2F752"));
  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = player;
  _id_7E2C53B0BCF117D9._id_F0FA3B7B27926553 = event;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_score_event", _id_7E2C53B0BCF117D9);
  player scripts\cp_mp\pet_watch::addobjectivescorecharge(event, int(_id_353F1E80E9476419), _id_7EC7671A1E0C788F);
  player _id_4C770A9A4AD7659C::callback("onPlayerScore_TacticianBonus", event);
}

_setplayerscore(player, score) {
  if(score == player.pers["score"]) {
    return;
  }
  if(score < 0) {
    return;
  }
  player.pers["score"] = score;
  player.score = player.pers["score"];
  player thread scripts\mp\gamelogic::checkscorelimit();
}

_getplayerscore(player) {
  if(!isDefined(player))
    player = self;

  return player.pers["score"];
}

_id_6E6350A3296633F4(team) {
  _id_DFDD438871090D04 = [];

  if(level.teambased) {
    players = level.teamdata[team]["players"];
    _id_DFDD438871090D04 = scripts\engine\utility::array_sort_with_func(players, ::_id_B5D9E47AD1993406);
  } else {
    players = level.players;
    _id_DFDD438871090D04 = scripts\engine\utility::array_sort_with_func(players, ::_id_B5D9E47AD1993406);
  }

  return _id_DFDD438871090D04;
}

_id_B5D9E47AD1993406(_id_472D4F042B732E8A, _id_CB730D03142C3F30) {
  return _getplayerscore(_id_472D4F042B732E8A) > _getplayerscore(_id_CB730D03142C3F30);
}

checkffascorejip() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(istrue(level.nojip)) {
    return;
  }
  if(level.roundscorelimit > 0) {
    _id_F8B48024445E7359 = self.score / level.roundscorelimit * 100;

    if(_id_F8B48024445E7359 > level.scorepercentagecutoff) {
      setnojipscore(1, 1);
      level.nojip = 1;
    }
  }
}

giveteamscoreforobjective(team, score, _id_6E5149EF941C9008, _id_F0FA3B7B27926553, _id_1A07B7DEE983726E, _id_C6544E2C82D62DFB) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill())
    _id_6E5149EF941C9008 = 1;

  if(!isDefined(_id_6E5149EF941C9008))
    _id_6E5149EF941C9008 = 0;

  if(istrue(level.gameended) && !_id_6E5149EF941C9008) {
    return;
  }
  if(istrue(level.ignorescoring)) {
    return;
  }
  if(!scripts\mp\utility\teams::isgameplayteam(team)) {
    return;
  }
  if(istrue(level.dontendonscore) && _getteamscore(team) >= level.scorelimit) {
    return;
  }
  if(_id_6E5149EF941C9008) {
    if(level.roundscorelimit > 1 && game["teamScores"][team] >= level.roundscorelimit)
      return;
  } else if(level.roundscorelimit > 1 && !istrue(level.dontendonscore)) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(game["teamScores"][_id_F90358454413407F] >= level.roundscorelimit)
        return;
    }
  }

  _setteamscore(team, _getteamscore(team) + score, _id_6E5149EF941C9008);
  level notify("update_team_score", team, _getteamscore(team));

  if(isDefined(level.onteamscore))
    [[level.onteamscore]](team, _getteamscore(team), _id_F0FA3B7B27926553);

  if(isDefined(_id_C6544E2C82D62DFB))
    _id_EC15CE3E7A9D1D86 = _id_C6544E2C82D62DFB;
  else
    _id_EC15CE3E7A9D1D86 = calculatewinningteam(_id_6E5149EF941C9008);

  if(!istrue(_id_1A07B7DEE983726E))
    playscorestatusdialog(_id_EC15CE3E7A9D1D86, _id_6E5149EF941C9008, level.waswinning);

  if(_id_EC15CE3E7A9D1D86 != "none" && _id_EC15CE3E7A9D1D86 != "tie") {
    level.waswinning = _id_EC15CE3E7A9D1D86;
    _id_929A6DF466DC4F22 = _getteamscore(_id_EC15CE3E7A9D1D86);
    scorelimit = level.roundscorelimit;

    if(_id_929A6DF466DC4F22 == 0 || scorelimit == 0) {
      return;
    }
    _id_F8B48024445E7359 = _id_929A6DF466DC4F22 / scorelimit * 100;

    if(!scripts\mp\utility\game::isroundbased() && isDefined(level.nojip) && !level.nojip) {
      if(_id_F8B48024445E7359 > level.scorepercentagecutoff) {
        setnojipscore(1, 1);
        level.nojip = 1;
      }
    }
  }

  if(!level.onlinegame)
    loggamescore();
}

playscorestatusdialog(_id_EC15CE3E7A9D1D86, _id_6E5149EF941C9008, waswinning) {
  if(!level.splitscreen && _id_EC15CE3E7A9D1D86 != "none" && _id_EC15CE3E7A9D1D86 != waswinning && gettime() - level.lastscorestatustime > 5000 && scripts\mp\utility\game::getscorelimit() != 1) {
    if(isDefined(level.delayleadtakendialog))
      level thread playleadtakendialog(_id_6E5149EF941C9008);
    else if(_id_EC15CE3E7A9D1D86 == "none" && waswinning != "none") {
      foreach(team in level.teamnamelist)
      scripts\mp\utility\dialog::leaderdialog("lead_tied", team, "status");
    } else {
      level.lastscorestatustime = gettime();
      scripts\mp\utility\dialog::leaderdialog("lead_taken", _id_EC15CE3E7A9D1D86, "status");

      if(waswinning != "none")
        scripts\mp\utility\dialog::leaderdialog("lead_lost", waswinning, "status");
    }
  }
}

playleadtakendialog(_id_6E5149EF941C9008) {
  wait(level.delayleadtakendialog);
  level.lastscorestatustime = gettime();
  _id_EC15CE3E7A9D1D86 = calculatewinningteam(_id_6E5149EF941C9008);

  if(_id_EC15CE3E7A9D1D86 == "none" && level.waswinning != "none") {
    foreach(team in level.teamnamelist)
    scripts\mp\utility\dialog::leaderdialog("lead_tied", team, "status");
  } else {
    scripts\mp\utility\dialog::leaderdialog("lead_taken", _id_EC15CE3E7A9D1D86, "status");

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(_id_F90358454413407F != _id_EC15CE3E7A9D1D86)
        scripts\mp\utility\dialog::leaderdialog("lead_lost", _id_F90358454413407F, "status");
    }
  }
}

calculatewinningteam(_id_6E5149EF941C9008) {
  _id_CE7974FF3997EF6E = level.teamnamelist;

  if(!isDefined(level.waswinning))
    level.waswinning = "none";

  _id_0AA81B2C7E0A29A1 = "none";
  _id_081F7C7498314CEA = 0;

  if(level.waswinning != "none") {
    _id_0AA81B2C7E0A29A1 = level.waswinning;
    _id_081F7C7498314CEA = game["teamScores"][level.waswinning];
  }

  _id_2EC641B1E117731E = 1;

  foreach(_id_FABF84450735DD93 in _id_CE7974FF3997EF6E) {
    if(_id_FABF84450735DD93 == level.waswinning) {
      continue;
    }
    if(game["teamScores"][_id_FABF84450735DD93] > _id_081F7C7498314CEA) {
      _id_0AA81B2C7E0A29A1 = _id_FABF84450735DD93;
      _id_081F7C7498314CEA = game["teamScores"][_id_FABF84450735DD93];
      _id_2EC641B1E117731E = 1;
      continue;
    }

    if(game["teamScores"][_id_FABF84450735DD93] == _id_081F7C7498314CEA) {
      _id_2EC641B1E117731E = _id_2EC641B1E117731E + 1;
      _id_0AA81B2C7E0A29A1 = "none";
    }
  }

  return _id_0AA81B2C7E0A29A1;
}

_setteamscore(team, _id_929A6DF466DC4F22, _id_6E5149EF941C9008) {
  if(_id_929A6DF466DC4F22 < 0)
    _id_929A6DF466DC4F22 = 0;

  if(_id_929A6DF466DC4F22 == game["teamScores"][team]) {
    return;
  }
  game["teamScores"][team] = _id_929A6DF466DC4F22;
  updateteamscore(team);

  if(!istrue(level.dontendonscore))
    thread scripts\mp\gamelogic::roundend_checkscorelimit(team, _id_6E5149EF941C9008);
}

updateteamscore(team) {
  _id_929A6DF466DC4F22 = 0;

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame())
    _id_929A6DF466DC4F22 = _getteamscore(team);
  else
    _id_929A6DF466DC4F22 = game["roundsWon"][team];

  setteamscore(team, int(_id_929A6DF466DC4F22));
  level thread updateteamscoreplacements();
}

updatetotalteamscore(team) {
  if(!isDefined(game["totalScore"])) {
    game["totalScore"] = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    game["totalScore"][_id_F90358454413407F] = 0;
  }

  wingamebytype = scripts\mp\utility\game::getwingamebytype();

  switch (wingamebytype) {
    case "roundsWon":
      game["teamScores"][team] = game["roundsWon"][team];
      break;
    case "teamScores":
      if(scripts\mp\utility\game::inovertime())
        game["teamScores"][team] = game["preOvertimeScore"][team] + game["overtimeScore"][team] + game["teamScores"][team];
      else if(scripts\mp\utility\game::resetscoreonroundstart()) {
        game["totalScore"][team] = game["totalScore"][team] + game["teamScores"][team];
        game["teamScores"][team] = game["totalScore"][team];
      }

      break;
  }

  setteamscore(team, int(game["teamScores"][team]));
}

updateovertimescore() {
  if(game["overtimeRoundsPlayed"] == 0) {
    if(!isDefined(game["preOvertimeScore"])) {
      game["preOvertimeScore"] = [];

      foreach(_id_F90358454413407F in level.teamnamelist)
      game["preOvertimeScore"][_id_F90358454413407F] = 0;
    }

    foreach(_id_F90358454413407F in level.teamnamelist)
    game["preOvertimeScore"][_id_F90358454413407F] = game["teamScores"][_id_F90358454413407F] + game["totalScore"][_id_F90358454413407F];
  }

  if(!isDefined(game["overtimeScore"])) {
    game["overtimeScore"] = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    game["overtimeScore"][_id_F90358454413407F] = 0;
  }

  foreach(_id_F90358454413407F in level.teamnamelist)
  game["overtimeScore"][_id_F90358454413407F] = game["overtimeScore"][_id_F90358454413407F] + (game["teamScores"][_id_F90358454413407F] - game["preOvertimeScore"][_id_F90358454413407F]);

  if(!scripts\mp\utility\game::iswinbytworulegametype()) {
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);

    if(scripts\mp\utility\game::istimetobeatvalid() && game["timeToBeatTeam"] == game["attackers"]) {
      game["teamScores"][game["attackers"]] = game["timeToBeatScore"];
      updateteamscore(game["attackers"]);
      game["overtimeScore"][game["attackers"]] = game["overtimeScore"][game["attackers"]] - game["timeToBeatScore"];
    }

    if(scripts\mp\utility\game::istimetobeatvalid() && game["timeToBeatTeam"] == game["defenders"]) {
      game["teamScores"][game["defenders"]] = game["timeToBeatScore"];
      updateteamscore(game["defenders"]);
      game["overtimeScore"][game["defenders"]] = game["overtimeScore"][game["defenders"]] - game["timeToBeatScore"];
    }
  }
}

_getteamscore(team) {
  return int(game["teamScores"][team]);
}

removedisconnectedplayerfromplacement() {
  if(!isDefined(level.placement) || !isDefined(level.placement["all"])) {
    return;
  }
  offset = 0;
  numplayers = level.placement["all"].size;
  found = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numplayers; _id_AC0E594AC96AA3A8++) {
    if(level.placement["all"][_id_AC0E594AC96AA3A8] == self)
      found = 1;

    if(found)
      level.placement["all"][_id_AC0E594AC96AA3A8] = level.placement["all"][_id_AC0E594AC96AA3A8 + 1];
  }

  if(!found) {
    return;
  }
  level.placement["all"][numplayers - 1] = undefined;

  if(level.teambased)
    updateteamplacement();
}

updateplacement() {
  _id_9D07C99F6D74BD4F = [];

  foreach(player in level.players) {
    if(isDefined(player.connectedpostgame)) {
      continue;
    }
    if(player.pers["team"] == "spectator" || player.pers["team"] == "codcaster" || player.pers["team"] == "none") {
      continue;
    }
    _id_9D07C99F6D74BD4F[_id_9D07C99F6D74BD4F.size] = player;
  }

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_9D07C99F6D74BD4F.size; _id_AC0E594AC96AA3A8++) {
    player = _id_9D07C99F6D74BD4F[_id_AC0E594AC96AA3A8];
    _id_663572CC85C027C6 = player.score;

    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 - 1; _id_AC0E5C4AC96AAA41 >= 0 && getbetterplayer(player, _id_9D07C99F6D74BD4F[_id_AC0E5C4AC96AAA41]) == player; _id_AC0E5C4AC96AAA41--)
      _id_9D07C99F6D74BD4F[_id_AC0E5C4AC96AAA41 + 1] = _id_9D07C99F6D74BD4F[_id_AC0E5C4AC96AAA41];

    _id_9D07C99F6D74BD4F[_id_AC0E5C4AC96AAA41 + 1] = player;
  }

  level.placement["all"] = _id_9D07C99F6D74BD4F;

  if(level.teambased)
    updateteamplacement();
}

getbetterplayer(_id_52A4B2A164977F87, _id_52A4B3A1649781BA) {
  if(isDefined(level.lastplayerwins))
    return level.lastplayerwins;

  if(_id_52A4B2A164977F87.score > _id_52A4B3A1649781BA.score)
    return _id_52A4B2A164977F87;

  if(_id_52A4B3A1649781BA.score > _id_52A4B2A164977F87.score)
    return _id_52A4B3A1649781BA;

  if(_id_52A4B2A164977F87.deaths < _id_52A4B3A1649781BA.deaths)
    return _id_52A4B2A164977F87;

  if(_id_52A4B3A1649781BA.deaths < _id_52A4B2A164977F87.deaths)
    return _id_52A4B3A1649781BA;

  if(scripts\engine\utility::cointoss())
    return _id_52A4B2A164977F87;
  else
    return _id_52A4B3A1649781BA;
}

updateteamplacement() {
  _id_9D07C99F6D74BD4F = level.placement["all"];
  placement = [];

  foreach(player in _id_9D07C99F6D74BD4F) {
    team = player.pers["team"];

    if(!isDefined(placement[team]))
      placement[team] = [];

    placement[team][placement[team].size] = player;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(placement[_id_F90358454413407F])) {
      level.placement[_id_F90358454413407F] = placement[_id_F90358454413407F];
      continue;
    }

    level.placement[_id_F90358454413407F] = [];
  }
}

processassist(killedplayer, objweapon, _id_54351D786449EE9E) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  processassist_regularmp(killedplayer, objweapon, _id_54351D786449EE9E);
}

processassist_regularmp(killedplayer, objweapon, _id_54351D786449EE9E) {
  self endon("disconnect");
  killedplayer endon("disconnect");

  if(isagent(self)) {
    return;
  }
  if(isDefined(objweapon) && objweapon.basename == "white_phosphorus_proj_mp") {
    return;
  }
  if(!isDefined(_id_54351D786449EE9E))
    _id_54351D786449EE9E = 0;

  _id_77E7DEBAB7FD1A02 = gettime();
  _id_4928D7738EBE2222 = isagent(killedplayer);
  victimteam = undefined;

  if(_id_4928D7738EBE2222)
    victimteam = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(killedplayer, "team");
  else
    victimteam = killedplayer.pers["team"];

  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();
  _id_B47248E0C4294FA4 = self.pers["team"];

  if(!scripts\mp\utility\teams::isgameplayteam(_id_B47248E0C4294FA4)) {
    return;
  }
  if(isDefined(victimteam) && _id_B47248E0C4294FA4 == victimteam && level.teambased) {
    return;
  }
  _id_91185FF4A2E16A72 = undefined;
  event = "stat_8FCF8BBD78A0502E";

  if(!level.teambased)
    event = "stat_FE68DFA78D19874E";

  points = scripts\mp\rank::getscoreinfovalue(event);

  if(!level.teambased) {
    _id_91185FF4A2E16A72 = points + points * _id_54351D786449EE9E;
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FE68DFA78D19874E", objweapon, _id_91185FF4A2E16A72);
  } else {
    _id_91185FF4A2E16A72 = points + points * _id_54351D786449EE9E;
    thread scripts\mp\utility\points::_id_0366980B6A8796AE(["stat_8FCF8BBD78A0502E", _id_77E7DEBAB7FD1A02], objweapon, _id_91185FF4A2E16A72);
  }

  if(level.teambased) {
    _id_EF269077A28646EB = scripts\common\utility::playersinsphere(self.origin, 300);

    foreach(player in _id_EF269077A28646EB) {
      if(self.team != player.team || self == player) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(player)) {
        continue;
      }
      self.modifiers["buddy_kill"] = 1;
      break;
    }
  }

  if(!_id_4928D7738EBE2222) {
    _id_5A48DE6E3FB64115();
    scripts\mp\utility\script::bufferednotify("assist_buffered", self.modifiers);
    thread scripts\cp_mp\challenges::_id_247BA07507F78AC2(killedplayer, self);

    if(isDefined(level._id_561ADDF876799987))
      self[[level._id_561ADDF876799987]]("assist");
  }
}

_id_5A48DE6E3FB64115() {
  _id_715D1AC74D3BA31A = self;
  _id_715D1AC74D3BA31A scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "assists");

  if(isDefined(_id_715D1AC74D3BA31A.pers) && isDefined(_id_715D1AC74D3BA31A.pers["assists"]) && _id_715D1AC74D3BA31A.pers["assists"] < 999) {
    _id_715D1AC74D3BA31A scripts\mp\utility\stats::incpersstat("assists", 1);
    _id_715D1AC74D3BA31A.assists = _id_715D1AC74D3BA31A scripts\mp\utility\stats::getpersstat("assists");
    _id_715D1AC74D3BA31A scripts\mp\persistence::statsetchild("round", "assists", _id_715D1AC74D3BA31A.assists);
  }
}

processshieldassist(killedplayer) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  processshieldassist_regularmp(killedplayer);
}

processshieldassist_regularmp(killedplayer) {
  self endon("disconnect");
  killedplayer endon("disconnect");
  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();

  if(!scripts\mp\utility\teams::isgameplayteam(self.pers["team"])) {
    return;
  }
  if(self.pers["team"] == killedplayer.pers["team"]) {
    return;
  }
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E3569AEC4686A8D6");
  scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "assists");

  if(self.pers["assists"] < 998) {
    scripts\mp\utility\stats::incpersstat("assists", 1);
    self.assists = scripts\mp\utility\stats::getpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", self.assists);
  }

  thread scripts\cp_mp\challenges::_id_247BA07507F78AC2(killedplayer, self);

  if(isDefined(level._id_561ADDF876799987))
    self[[level._id_561ADDF876799987]]("assist");
}

initassisttrackers() {
  self notify("initAssistTrackers");
  self.buffedbyplayers = [];
  self.debuffedbyplayers = [];
}

trackdebuffassist(attacker, victim, weapon) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(!isDefined(victim.debuffedbyplayers[weapon]))
    victim.debuffedbyplayers[weapon] = [];

  if(!isDefined(victim.debuffedbyplayers[weapon][attacker getentitynumber()]))
    victim.debuffedbyplayers[weapon][attacker getentitynumber()] = 0;

  victim.debuffedbyplayers[weapon][attacker getentitynumber()]++;
}

untrackdebuffassist(attacker, victim, weapon) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(isDefined(attacker)) {
    if(isDefined(victim.debuffedbyplayers[weapon]) && isDefined(victim.debuffedbyplayers[weapon][attacker getentitynumber()])) {
      victim.debuffedbyplayers[weapon][attacker getentitynumber()]--;
      _id_F95D20ECCE7501B1 = 1;

      foreach(_id_F90358454413407F, value in victim.debuffedbyplayers[weapon]) {
        if(value > 0) {
          _id_F95D20ECCE7501B1 = 0;
          break;
        }
      }

      if(_id_F95D20ECCE7501B1 && isDefined(weapon) && isDefined(victim.debuffedbyplayers)) {
        victim.debuffedbyplayers[weapon] = undefined;
        return;
      }
    } else {}
  }
}

trackdebuffassistfortime(attacker, victim, weapon, duration) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  victim endon("initAssistTrackers");
  victim endon("disconnect");
  attacker endon("disconnect");
  level endon("game_ended");
  trackdebuffassist(attacker, victim, weapon);
  wait(duration);
  untrackdebuffassist(attacker, victim, weapon);
}

isdebuffedbyweapon(victim, weapon) {
  if(scripts\mp\utility\game::runleanthreadmode())
    return 0;

  if(isDefined(victim.debuffedbyplayers[weapon])) {
    foreach(_id_2F5764B74AD4A6C6, _id_5AEC7759028B3ADA in victim.debuffedbyplayers[weapon]) {
      if(_id_5AEC7759028B3ADA <= 0) {
        continue;
      }
      if(!isDefined(level.playersbyentitynumber[_id_2F5764B74AD4A6C6])) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

isdebuffedbyweaponandplayer(attacker, victim, weapon) {
  if(scripts\mp\utility\game::runleanthreadmode())
    return 0;

  if(!isDefined(victim.debuffedbyplayers[weapon]))
    return 0;

  if(!isDefined(victim.debuffedbyplayers[weapon][attacker getentitynumber()]))
    return 0;

  if(victim.debuffedbyplayers[weapon][attacker getentitynumber()] <= 0)
    return 0;

  return 1;
}

getdebuffattackersbyweapon(victim, weapon) {
  if(scripts\mp\utility\game::runleanthreadmode())
    return undefined;

  _id_A676DF5D3D80A259 = [];

  if(isPlayer(victim)) {
    if(isDefined(victim.debuffedbyplayers[weapon])) {
      foreach(_id_2F5764B74AD4A6C6, _id_5AEC7759028B3ADA in victim.debuffedbyplayers[weapon]) {
        if(_id_5AEC7759028B3ADA <= 0) {
          continue;
        }
        if(!isDefined(level.playersbyentitynumber[_id_2F5764B74AD4A6C6])) {
          continue;
        }
        _id_A676DF5D3D80A259[_id_A676DF5D3D80A259.size] = level.playersbyentitynumber[_id_2F5764B74AD4A6C6];
      }
    }
  }

  return _id_A676DF5D3D80A259;
}

trackbuffassist(player, _id_F0EA4030349A33D5, weapon) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(player != _id_F0EA4030349A33D5) {
    if(!isDefined(_id_F0EA4030349A33D5.buffedbyplayers[weapon]))
      _id_F0EA4030349A33D5.buffedbyplayers[weapon] = [];

    if(!isDefined(_id_F0EA4030349A33D5.buffedbyplayers[weapon][player getentitynumber()]))
      _id_F0EA4030349A33D5.buffedbyplayers[weapon][player getentitynumber()] = 0;

    _id_F0EA4030349A33D5.buffedbyplayers[weapon][player getentitynumber()]++;
  }
}

untrackbuffassist(player, _id_F0EA4030349A33D5, weapon) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(isDefined(_id_F0EA4030349A33D5)) {
    if(isDefined(_id_F0EA4030349A33D5.buffedbyplayers[weapon]) && isDefined(_id_F0EA4030349A33D5.buffedbyplayers[weapon][player getentitynumber()]))
      _id_F0EA4030349A33D5.buffedbyplayers[weapon][player getentitynumber()]--;
    else {}
  }
}

trackbuffassistfortime(player, _id_F0EA4030349A33D5, weapon, duration) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  _id_F0EA4030349A33D5 endon("initAssistTrackers");
  _id_F0EA4030349A33D5 endon("disconnect");
  player endon("disconnect");
  level endon("game_ended");
  trackbuffassist(player, _id_F0EA4030349A33D5, weapon);
  wait(duration);
  untrackbuffassist(player, _id_F0EA4030349A33D5, weapon);
}

awardbuffdebuffassists(attacker, victim) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  _id_63669AE0C61D1484 = [];

  foreach(weaponname, weaponlist in victim.debuffedbyplayers) {
    foreach(_id_2F5764B74AD4A6C6, _id_5AEC7759028B3ADA in weaponlist) {
      if(_id_5AEC7759028B3ADA <= 0) {
        continue;
      }
      player = level.playersbyentitynumber[_id_2F5764B74AD4A6C6];

      if(isDefined(player) && player.team != "spectator" && player.team != "codcaster" && player scripts\cp_mp\utility\player_utility::isenemy(victim)) {
        index = player.guid;

        if(!isDefined(_id_63669AE0C61D1484[index]))
          _id_63669AE0C61D1484[index] = player;
      }
    }
  }

  foreach(weaponlist in attacker.buffedbyplayers) {
    foreach(_id_2F5764B74AD4A6C6, _id_9E629822ACFBC29F in weaponlist) {
      if(_id_9E629822ACFBC29F <= 0) {
        continue;
      }
      player = level.playersbyentitynumber[_id_2F5764B74AD4A6C6];

      if(isDefined(player) && player.team != "spectator" && player.team != "codcaster" && player scripts\cp_mp\utility\player_utility::isenemy(victim)) {
        index = player.guid;

        if(!isDefined(_id_63669AE0C61D1484[index]))
          _id_63669AE0C61D1484[index] = player;
      }
    }
  }

  foreach(index, player in _id_63669AE0C61D1484) {
    if(!isDefined(victim.attackerdata) || !isDefined(victim.attackerdata[player.guid]))
      scripts\mp\damage::addattacker(victim, player, undefined, nullweapon(), 0, undefined, undefined, undefined, undefined, undefined);
  }
}

_id_6251F7723BE2F90C(victim, _id_10F37E0E73FD3A4C) {
  attacker = self;

  if(isDefined(attacker.team) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    _id_1321C1081173DFC4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](attacker.team, "alivePlayers");

    if(isDefined(_id_10F37E0E73FD3A4C)) {
      if(!isarray(_id_10F37E0E73FD3A4C))
        _id_10F37E0E73FD3A4C = [_id_10F37E0E73FD3A4C];

      _id_1321C1081173DFC4 = scripts\engine\utility::array_remove_array(_id_1321C1081173DFC4, _id_10F37E0E73FD3A4C);
    }

    foreach(_id_8F7040E569EC9E98 in _id_1321C1081173DFC4) {
      if(istrue(_id_8F7040E569EC9E98._id_632BAD3EDB4E449E) && istrue(level._id_3DA7CF812433FD50)) {
        continue;
      }
      _id_8F7040E569EC9E98 _id_5A687B65C904B197(attacker, victim);
    }
  }
}

_id_5A687B65C904B197(attacker, victim, team) {
  _id_A7BCC27D58860046 = self;

  if(_id_A7BCC27D58860046 != attacker) {
    if(isDefined(team) && _id_A7BCC27D58860046.team != team) {
      return;
    }
    _id_A7BCC27D58860046 thread scripts\cp_mp\challenges::_id_817629C461EA3540(victim, _id_A7BCC27D58860046, attacker);

    if(isDefined(level._id_561ADDF876799987))
      _id_A7BCC27D58860046[[level._id_561ADDF876799987]]("unassisted", victim);
  }
}

gamemodeusesdeathmatchscoring(mode) {
  return mode == "dm" || mode == "sotf_ffa";
}

loggamescore() {
  _id_A90D85CEDB766B46 = level.teamnamelist[0];
  _id_A90D84CEDB766913 = level.teamnamelist[1];
  _id_45EEE37E3681E6C9 = getteamscore(_id_A90D85CEDB766B46);
  _id_45EEE07E3681E030 = getteamscore(_id_A90D84CEDB766913);
  dlog_recordevent("dlog_event_score_change", ["team_1_name", _id_A90D85CEDB766B46, "team_2_name", _id_A90D84CEDB766913, "team_1_score", _id_45EEE37E3681E6C9, "team_2_score", _id_45EEE07E3681E030]);
}