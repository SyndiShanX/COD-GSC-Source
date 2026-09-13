/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gamelogic.gsc
***********************************************/

onforfeit(team) {
  if(isDefined(level.forfeitinprogress)) {
    return;
  }
  level endon("abort_forfeit");
  level thread forfeitwaitforabort();
  level.forfeitinprogress = 1;
  level.canprocessot = 0;

  if(!level.teambased && level.players.size > 1)
    wait 10;
  else
    wait 1.05;

  level.forfeit_aborted = 0;
  _id_84362872E75BCC9C = 20.0;
  matchforfeittimer(_id_84362872E75BCC9C);
  _id_1EA736D378B0D412 = &"";

  if(!isDefined(team)) {
    _id_1EA736D378B0D412 = game["end_reason"]["players_forfeited"];
    winner = level.players[0];
  } else {
    if(team == "allies")
      _id_1EA736D378B0D412 = game["end_reason"]["spetsnaz_forfeited"];
    else
      _id_1EA736D378B0D412 = game["end_reason"]["marines_forfeited"];

    winner = team;

    if(istrue(level._id_EC2FB549B15AD827)) {
      _id_FAA1B667D8025C6D = scripts\engine\utility::ter_op(winner == "allies", "axis", "allies");
      game["roundsWon"][winner] = scripts\engine\utility::ter_op(scripts\mp\utility\game::isroundbased(), scripts\mp\utility\game::getscorelimit(), 1);
      game["roundsWon"][_id_FAA1B667D8025C6D] = 0;
      game["teamScores"][winner] = scripts\mp\utility\game::getscorelimit();
      game["teamScores"][_id_FAA1B667D8025C6D] = 0;
      setteamscore(winner, 1);
      setteamscore(_id_FAA1B667D8025C6D, 0);
    }
  }

  level.forcedend = 1;

  if(isPlayer(winner))
    logstring("forfeit, win: " + winner getxuid() + "(" + winner.name + ")");
  else {
    logstring("forfeit, win: " + winner);

    foreach(_id_F90358454413407F in level.teamnamelist)
    logstring(_id_F90358454413407F + ":" + game["teamScores"][_id_F90358454413407F]);
  }

  thread endgame(winner, _id_1EA736D378B0D412);
}

forfeitwaitforabort() {
  level endon("game_ended");

  if(getdvarfloat("dvar_739BBD49F9779978") == 1) {
    level.disableforfeit = 1;
    level notify("abort_forfeit");
  } else
    level waittill("abort_forfeit");

  level.forfeit_aborted = 1;
  level.canprocessot = 1;

  foreach(_id_AC0E424AC96A7113 in level.players) {
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", 0);
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 1);
  }
}

matchforfeittimer_internal(_id_B710552E5D79A601) {
  waittillframeend;
  level endon("match_forfeit_timer_beginning");

  while(_id_B710552E5D79A601 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod) {
    foreach(_id_AC0E424AC96A7113 in level.players) {
      _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", _id_B710552E5D79A601);
      _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 0);
    }

    _id_B710552E5D79A601--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  foreach(_id_AC0E424AC96A7113 in level.players) {
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", 0);
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 1);
  }
}

matchforfeittimer(duration) {
  level notify("match_forfeit_timer_beginning");
  _id_B710552E5D79A601 = int(duration);
  setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  matchforfeittimer_internal(_id_B710552E5D79A601);
}

default_ondeadevent(team) {
  logstring("team eliminated: " + team);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      result = undefined;

      if(istrue(player.pers["hasDoneAnyCombat"]) || istrue(player.pers["participation"]))
        result = "eliminated";

      player scripts\cp_mp\utility\game_utility::stopkeyearning(result);
    }

    _func_EB1A045A6D299C6A();
    _func_53F71C9DBFE19CE9(team);
  }

  if(team == "all") {
    logstring("tie");

    foreach(_id_F90358454413407F in level.teamnamelist)
    logstring(_id_F90358454413407F + ": " + game["teamScores"][_id_F90358454413407F]);

    if(level.teambased) {
      thread endgame("tie", game["end_reason"]["tie"]);
      return;
    }

    thread endgame(undefined, game["end_reason"]["tie"]);
    return;
  } else {
    _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(team);
    livescount = [];

    foreach(_id_F90358454413407F in _id_B0C33D224B825287)
    livescount[_id_F90358454413407F] = 0;

    if(!istrue(level.disablespawning)) {
      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        foreach(player in scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players")) {
          if(!istrue(player.hasspawned)) {
            continue;
          }
          livescount[_id_F90358454413407F] = livescount[_id_F90358454413407F] + player.pers["lives"];
        }
      }
    }

    _id_A9CEB9B39C78FB07 = [];

    foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
      _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");
      _id_E1E65E11F75F9CBB = 0;

      if(isDefined(level._id_7B37B2193F163B9B))
        _id_E1E65E11F75F9CBB = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "UIBotCount");

      if(_id_BCE4EFC75EB01319 > 0 || _id_E1E65E11F75F9CBB > 0 || livescount[_id_F90358454413407F])
        _id_A9CEB9B39C78FB07[_id_A9CEB9B39C78FB07.size] = _id_F90358454413407F;
    }

    _id_947925F5FC6939A3 = 1;

    if(isDefined(level._id_947925F5FC6939A3))
      _id_947925F5FC6939A3 = [[level._id_947925F5FC6939A3]]();

    if(_id_A9CEB9B39C78FB07.size == 1 && !_id_1E4A61DB11011446::_id_A587B0B0998C6D13() && _id_947925F5FC6939A3)
      thread endgame(_id_A9CEB9B39C78FB07[0], game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
  }
}

default_ononeleftevent(team) {
  if(level.teambased) {
    _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer(team);

    if(isDefined(_id_B0DFD912BE32D040))
      _id_B0DFD912BE32D040 thread givelastonteamwarning();
  } else {
    _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer();
    logstring("last one alive, win: " + _id_B0DFD912BE32D040.name);
    thread endgame(_id_B0DFD912BE32D040, game["end_reason"]["enemies_eliminated"]);
  }

  return 1;
}

roundend_checkscorelimit(team, _id_6E5149EF941C9008) {
  checkteamscorelimitsoon(team);
  _id_745E98AA8EB3EB8F = "score_limit_reached";

  if(isDefined(level._id_4817BAC75A8B9EFF))
    _id_745E98AA8EB3EB8F = level._id_4817BAC75A8B9EFF;

  if(istrue(_id_6E5149EF941C9008)) {
    level notify("roundEnd_CheckScoreLimit");
    level endon("roundEnd_CheckScoreLimit");
    waitframe();
  }

  wingamebytype = scripts\mp\utility\game::getwingamebytype();

  if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
    if(scripts\mp\utility\game::istimetobeatrulegametype()) {
      if(scripts\mp\utility\game::settimetobeat(team)) {
        foreach(player in level.players) {
          player setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(player.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          player setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(player.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        thread endgame(team, game["end_reason"][_id_745E98AA8EB3EB8F]);
      }
    } else {
      if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        return;
      }
      thread endgame(team, game["end_reason"][_id_745E98AA8EB3EB8F]);
      return;
    }
  } else if(level.roundscorelimit > 0) {
    _id_FD63D90025D110ED = [];

    if(scripts\mp\utility\game::getgametype() == "ballmode")
      _id_FD63D90025D110ED[0] = team;
    else {
      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(game["teamScores"][_id_F90358454413407F] >= level.roundscorelimit)
          _id_FD63D90025D110ED[_id_FD63D90025D110ED.size] = _id_F90358454413407F;
      }
    }

    if(_id_FD63D90025D110ED.size > 0) {
      if(_id_FD63D90025D110ED.size > 1) {
        _id_C7761B0132ABCFA7 = 0;
        _id_01FF67BA127220E2 = undefined;
        _id_CA17ACB9EA3FA61D = 0;

        foreach(_id_F90358454413407F in _id_FD63D90025D110ED) {
          _id_929A6DF466DC4F22 = game["teamScores"][_id_F90358454413407F];

          if(!isDefined(_id_01FF67BA127220E2)) {
            _id_C7761B0132ABCFA7 = _id_929A6DF466DC4F22;
            _id_01FF67BA127220E2 = _id_F90358454413407F;
            _id_CA17ACB9EA3FA61D = 0;
            continue;
          }

          if(_id_929A6DF466DC4F22 > _id_C7761B0132ABCFA7) {
            _id_C7761B0132ABCFA7 = _id_929A6DF466DC4F22;
            _id_01FF67BA127220E2 = _id_F90358454413407F;
            _id_CA17ACB9EA3FA61D = 0;
            continue;
          }

          if(_id_929A6DF466DC4F22 == _id_C7761B0132ABCFA7)
            _id_CA17ACB9EA3FA61D = 1;
        }

        if(_id_CA17ACB9EA3FA61D) {
          if(isDefined(level.onscorelimit))
            [[level.onscorelimit]]("tie");

          thread endgame("tie", game["end_reason"][_id_745E98AA8EB3EB8F]);
          return;
        }

        if(isDefined(level.onscorelimit))
          [[level.onscorelimit]](_id_01FF67BA127220E2);

        thread endgame(_id_01FF67BA127220E2, game["end_reason"][_id_745E98AA8EB3EB8F]);
        return;
      } else {
        if(isDefined(level.onscorelimit))
          [[level.onscorelimit]](_id_FD63D90025D110ED[0]);

        thread endgame(_id_FD63D90025D110ED[0], game["end_reason"][_id_745E98AA8EB3EB8F]);
      }
    }
  }
}

default_ontimelimit() {
  winner = "tie";

  if(level.teambased) {
    if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
      if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        score = game["overtimeProgress"] + game["overtimeProgressFrac"];
        winner = scripts\mp\utility\game::setscoretobeat(game["attackers"], score * 60.0);
      } else if(scripts\mp\utility\game::istimetobeatvalid())
        winner = game["timeToBeatTeam"];
    } else
      winner = scripts\mp\gamescore::gethighestscoringteam();

    logstring("time limit, win: " + winner);

    foreach(_id_F90358454413407F in level.teamnamelist)
    logstring(_id_F90358454413407F + ":" + game["teamScores"][_id_F90358454413407F]);
  } else {
    winner = scripts\mp\gamescore::gethighestscoringplayer();

    if(scripts\mp\gamescore::ishighestscoringplayertied())
      winner = "tie";

    if(isDefined(winner) && isPlayer(winner))
      logstring("time limit, win: " + winner.name);
    else
      logstring("time limit, tie");
  }

  thread endgame(winner, game["end_reason"]["time_limit_reached"]);
}

default_onhalftime() {
  winner = undefined;
  thread endgame("halftime", game["end_reason"]["time_limit_reached"]);
}

_id_9F9E27BF69291E6D() {
  level endon("game_ended");
  _id_315D33BCB2364D51();

  for(;;) {
    _id_8BAA6CFD8698560C = 0;

    foreach(player in level.players) {
      if(isDefined(player) && !isai(player)) {
        _id_8BAA6CFD8698560C = 1;
        break;
      }
    }

    if(_id_8BAA6CFD8698560C) {
      wait 1;
      continue;
    }

    if(isDefined(level._id_7B37B2193F163B9B))
      level._id_7B37B2193F163B9B._id_B871280CBDC11CAF = 1;

    _id_575CD615EEA97FF5 = -1;
    _id_401C3A2E68AAB0FD = "Force end game due to no human player exists";
    logstring("[KEY_MOMENT] forceEndGameWhenNoHumanThread. endGameMethod=" + _id_575CD615EEA97FF5 + " reason=" + _id_401C3A2E68AAB0FD);
    _id_72AF5A878A9D3397::_id_873C0BE4897BD6C8(_id_575CD615EEA97FF5);
    thread forceend();
    return;
  }
}

_id_315D33BCB2364D51() {
  foreach(player in level.players) {
    if(isDefined(player) && !isai(player))
      return;
  }

  for(;;) {
    level waittill("player_spawned", player);

    if(!isai(player))
      return;
  }
}

forceend(_id_401C3A2E68AAB0FD) {
  if(level.hostforcedend || level.forcedend) {
    return;
  }
  scripts\mp\gamescore::updateplacement();

  if(level.teambased) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\gamescore::updatetotalteamscore(_id_F90358454413407F);
  }

  winner = undefined;

  if(level.teambased) {
    winner = scripts\mp\gamescore::gethighestscoringteam();
    logstring("host ended game, win: " + winner);

    foreach(_id_F90358454413407F in level.teamnamelist)
    logstring(_id_F90358454413407F + ":" + game["teamScores"][_id_F90358454413407F]);
  } else {
    winner = scripts\mp\gamescore::gethighestscoringplayer();

    if(isDefined(winner))
      logstring("host ended game, win: " + winner.name);
    else
      logstring("host ended game, tie");
  }

  level.forcedend = 1;
  level.hostforcedend = 1;

  if(level.splitscreen)
    _id_0CD73FF319D57C07 = game["end_reason"]["ended_game"];
  else
    _id_0CD73FF319D57C07 = game["end_reason"]["host_ended_game"];

  if(isDefined(_id_401C3A2E68AAB0FD) && _id_401C3A2E68AAB0FD == 2) {
    if(level.teambased) {
      if(winner == "allies")
        _id_1EA736D378B0D412 = game["end_reason"]["spetsnaz_forfeited"];
      else
        _id_1EA736D378B0D412 = game["end_reason"]["marines_forfeited"];
    } else
      _id_1EA736D378B0D412 = game["end_reason"]["players_forfeited"];
  } else if(istrue(level._id_EC2FB549B15AD827) && istrue(level._id_15C7D73680EA5496)) {
    winner = "tie";
    _id_0CD73FF319D57C07 = game["end_reason"]["lp_match_cancelled"];
  }

  level notify("force_end");
  thread endgame(winner, _id_0CD73FF319D57C07);
}

onscorelimit(_id_6E5149EF941C9008) {
  _id_A138E6484A996BDA = game["end_reason"]["score_limit_reached"];
  winner = "tie";

  if(level.teambased) {
    winner = scripts\mp\gamescore::calculatewinningteam();

    if(winner == "none")
      winner = "tie";

    logstring("scorelimit, win: " + winner);

    foreach(_id_F90358454413407F in level.teamnamelist)
    logstring(_id_F90358454413407F + ":" + game["teamScores"][_id_F90358454413407F]);
  } else {
    winner = scripts\mp\gamescore::gethighestscoringplayer();

    if(istrue(_id_6E5149EF941C9008) && scripts\mp\gamescore::ishighestscoringplayertied())
      winner = "tie";

    if(isDefined(winner) && isPlayer(winner))
      logstring("scorelimit, win: " + winner.name);
    else
      logstring("scorelimit, tie");

    _id_F3ADC82C7B8B4249 = winner scripts\mp\killstreaks\killstreaks::calcstreakcost("nuke");

    if(scripts\mp\utility\game::getscorelimit() == _id_F3ADC82C7B8B4249 && winner.pers["cur_kill_streak"] == _id_F3ADC82C7B8B4249) {
      level.modescorewinner = winner;
      _id_EB5F2CFFBF051614 = scripts\mp\utility\dvars::_id_3514AE5D09F47ED2("timeLimit");
      level.starttime = gettime();
      level.discardtime = 0;
      level.timerpausetime = 0;
      level.watchdvars[_id_EB5F2CFFBF051614].value = 30;
      level.overridewatchdvars[_id_EB5F2CFFBF051614] = 30;
      level.dontendonscore = 1;
      return;
    }
  }

  if(isDefined(level.onscorelimit))
    [[level.onscorelimit]](winner);

  thread endgame(winner, _id_A138E6484A996BDA);
  return 1;
}

updategameevents() {
  totalplayers = 0;
  level.teamswithplayers = [];

  foreach(team in level.teamnamelist) {
    _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(team, "teamCount");
    totalplayers = totalplayers + _id_652F47620AC4713F;

    if(_id_652F47620AC4713F)
      level.teamswithplayers[level.teamswithplayers.size] = team;
  }

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  if(scripts\mp\utility\game::matchmakinggame() && !level.ingraceperiod && (!isDefined(level.disableforfeit) || !level.disableforfeit)) {
    if(level.teambased) {
      if(level.teamswithplayers.size == 1 && game["state"] == "playing") {
        thread onforfeit(level.teamswithplayers[0]);
        return;
      }

      if(level.teamswithplayers.size > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    } else {
      _id_D12A341B40354143 = 0;

      foreach(_id_F90358454413407F in level.teamnamelist)
      _id_D12A341B40354143 = _id_D12A341B40354143 + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "teamCount");

      if(_id_D12A341B40354143 == 1 && level.maxplayercount > 1) {
        thread onforfeit();
        return;
      }

      if(_id_D12A341B40354143 > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(level.teamswithplayers.size == 1 && (istrue(level.br_debugsolotest) || !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())) {
    return;
  }
  if(!scripts\mp\utility\game::getgametypenumlives() && (!isDefined(level.disablespawning) || !level.disablespawning)) {
    return;
  }
  if(!scripts\mp\utility\game::gamehasstarted()) {
    return;
  }
  if(level.ingraceperiod && !isDefined(level.overrideingraceperiod)) {
    return;
  }
  if(level.teambased) {
    livescount = [];

    foreach(_id_F90358454413407F in level.teamnamelist)
    livescount[_id_F90358454413407F] = 0;

    foreach(player in level.players) {
      if(!istrue(player.hasspawned) || player.team == "spectator" || player.team == "codcaster" || player.team == "free") {
        continue;
      }
      livescount[player.team] = livescount[player.team] + player.pers["lives"];
    }

    if(istrue(level.disablespawning)) {
      foreach(_id_F90358454413407F in level.teamnamelist)
      livescount[_id_F90358454413407F] = 0;
    }

    _id_4351D3695CBE4FD7 = 0;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount")) {
        _id_4351D3695CBE4FD7 = 1;
        break;
      }
    }

    _id_3ED276C562480671 = 0;

    foreach(count in livescount) {
      if(count) {
        _id_3ED276C562480671 = 1;
        break;
      }
    }

    if(!_id_4351D3695CBE4FD7 && !_id_3ED276C562480671) {
      if(istrue(level.postgameexfil) && level.gameended)
        level notify("exfil_continue_game_end");

      if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
        return;
      }
      if(shouldmodelognotify() && game["roundsPlayed"] == 0)
        logstring("IWH-315293: GIBBERFISH: onDeadEvent - all");

      return [[level.ondeadevent]]("all");
    }

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount") && !livescount[_id_F90358454413407F]) {
        if(istrue(level.postgameexfil) && level.gameended)
          level notify("exfil_continue_game_end");

        if(!istrue(level.skipondeadevent)) {
          if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
            return;
          }
          if(level.multiteambased) {
            if(!scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "deathEvent") && scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "hasSpawned")) {
              if(shouldmodelognotify() && game["roundsPlayed"] == 0)
                logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry MultiteamBased");

              scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "deathEvent", 1);
              [[level.ondeadevent]](_id_F90358454413407F);
            }

            continue;
          }

          if(shouldmodelognotify() && game["roundsPlayed"] == 0)
            logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry Team based");

          return [[level.ondeadevent]](_id_F90358454413407F);
        }
      }
    }

    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_A27052041BC3242B = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");

      if(_id_A27052041BC3242B == 1 || _id_A27052041BC3242B == 2 || scripts\mp\utility\game::getgametype() == "control") {
        _id_91595DB4CCF80384 = 0;
        _id_43E4262D6EA97013 = undefined;
        players = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players");
        aliveplayers = [];

        foreach(player in players) {
          if(!isalive(player)) {
            _id_91595DB4CCF80384 = _id_91595DB4CCF80384 + player.pers["lives"];
            continue;
          }

          aliveplayers[aliveplayers.size] = player;
        }

        if(_id_A27052041BC3242B != 1)
          scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeft", 0);

        _id_129CCB16298EA627 = 0;

        if(scripts\mp\utility\game::getgametype() == "control") {
          livescount = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "livesCount");
          _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");
          _id_AE75A4D0DCB50F69 = livescount + _id_BCE4EFC75EB01319;

          if(_id_AE75A4D0DCB50F69 == 1 && level._id_23D874371501C40D != 0)
            _id_129CCB16298EA627 = 1;
        } else if(_id_91595DB4CCF80384 == 0)
          _id_129CCB16298EA627 = 1;

        if(_id_129CCB16298EA627) {
          if(_id_A27052041BC3242B == 1 && !scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "oneLeft") && gettime() > scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "oneLeftTime") + 5000) {
            scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeftTime", gettime());
            scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeft", 1);

            if(players.size > 1)
              [[level.ononeleftevent]](_id_F90358454413407F);
          }
        }

        continue;
      }

      scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeft", 0);
    }
  } else {
    livescount = 0;

    foreach(player in level.players) {
      if(player.team == "spectator" || player.team == "codcaster") {
        continue;
      }
      livescount = livescount + player.pers["lives"];
    }

    _id_1F7BCAA53CA6D399 = 0;

    foreach(_id_F90358454413407F in level.teamnamelist)
    _id_1F7BCAA53CA6D399 = _id_1F7BCAA53CA6D399 + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");

    if(!_id_1F7BCAA53CA6D399 && !livescount) {
      if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
        return;
      }
      return [[level.ondeadevent]]("all");
    }

    _id_677AE66DF2125F53 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(_id_677AE66DF2125F53.size == 1)
      return [[level.ononeleftevent]]("all");
  }
}

timelimitclock_intermission(waittime) {
  setgameendtime(gettime() + int(waittime * 1000));
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();

  if(waittime >= 10.0)
    wait(waittime - 10.0);

  for(;;) {
    _id_FC7BD6576D8C85BE playSound("ui_mp_timer_countdown");
    wait 1.0;
  }
}

waitforplayers(maxtime, _id_C8C8535645D45985, _id_4670FD6135253C34) {
  starttime = gettime();

  if(istrue(game["isLaunchChunk"]))
    mintime = 0;
  else if(maxtime > 5)
    mintime = gettime() + getdvarint("min_wait_for_players") * 1000;
  else
    mintime = 0;

  if(_id_4670FD6135253C34)
    _id_26CD2FE9D9C7396A = max(1, level.connectingplayers);
  else
    _id_26CD2FE9D9C7396A = max(1, level.connectingplayers / 2);

  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm")
    _id_26CD2FE9D9C7396A = level.connectingplayers;

  scripts\mp\flags::gameflagwait("infil_setup_complete");
  _id_7D3C76F0163532BD = 0;
  _id_DC74B0012AF15741 = 0;

  for(;;) {
    if(istrue(game["roundsPlayed"])) {
      break;
    }

    _id_D2A0F17E8E173E01 = level.maxplayercount;
    _id_B7652EEA48AE3D62 = getstreamedinplayercount();

    if(!_id_7D3C76F0163532BD) {
      if(_id_B7652EEA48AE3D62 > 0) {
        starttime = gettime();
        _id_7D3C76F0163532BD = 1;
      } else {
        waitframe();
        continue;
      }
    }

    _id_6B7BEE46F2C6DA28 = gettime();
    _id_54AB13AC8F1A59CD = _id_D2A0F17E8E173E01 >= _id_26CD2FE9D9C7396A;
    _id_FD915E8BD20B6D09 = 0;

    if(isDefined(level._id_FD915E8BD20B6D09))
      _id_FD915E8BD20B6D09 = [[level._id_FD915E8BD20B6D09]]();
    else
      _id_FD915E8BD20B6D09 = _id_B7652EEA48AE3D62 >= _id_26CD2FE9D9C7396A;

    if(_id_FD915E8BD20B6D09) {
      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(!checkrequiredteamcount(_id_F90358454413407F)) {
          _id_54AB13AC8F1A59CD = 0;
          break;
        }
      }
    }

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(!checkrequiredteamstreamcount(_id_F90358454413407F)) {
        if(scripts\mp\utility\game::getgametype() == "arena" && !_id_DC74B0012AF15741)
          setomnvar("ui_match_start_text", "waiting_for_teams");

        _id_FD915E8BD20B6D09 = 0;
        break;
      }
    }

    endtime = starttime + level.prematchperiod * 1000 - 200;

    if(scripts\mp\flags::gameflag("infil_will_run") || istrue(_id_C8C8535645D45985)) {
      if(_id_FD915E8BD20B6D09 && _id_6B7BEE46F2C6DA28 > mintime || _id_6B7BEE46F2C6DA28 > endtime) {
        break;
      }
    } else if(_id_FD915E8BD20B6D09 && _id_54AB13AC8F1A59CD && _id_6B7BEE46F2C6DA28 > mintime || _id_6B7BEE46F2C6DA28 > endtime) {
      break;
    }

    waitframe();
  }
}

_id_0D084AF239C9A23C(duration, _id_C8C8535645D45985) {
  if(istrue(game["roundsPlayed"])) {
    return;
  }
  starttime = gettime();
  endtime = starttime + duration * 1000;
  mintime = gettime() + getdvarint("min_wait_for_players") * 1000;
  _id_26CD2FE9D9C7396A = level.requiredplayercount["allies"] + level.requiredplayercount["axis"];
  _id_7D3C76F0163532BD = 0;
  _id_A11AEE8DA78E2638 = 0;
  _id_6591C2949D00EE51 = 0;
  _id_37BC68C6B6E75DE1 = 0;

  if(getdvarint("dvar_E7FD1773DCD3056B", 0) && _id_C8C8535645D45985)
    _id_26CD2FE9D9C7396A = _id_26CD2FE9D9C7396A - getdvarint("dvar_E7FD1773DCD3056B", 0);

  for(;;) {
    _id_6B7BEE46F2C6DA28 = gettime();
    _id_D2A0F17E8E173E01 = level.maxplayercount;
    _id_B7652EEA48AE3D62 = getstreamedinplayercount();

    if(!_id_7D3C76F0163532BD) {
      if(_id_B7652EEA48AE3D62 > 0) {
        starttime = gettime();
        _id_7D3C76F0163532BD = 1;

        if(getdvarint("dvar_5886DF61B04D3129", 0)) {
          break;
        }
      } else {
        waitframe();
        continue;
      }
    }

    _id_54AB13AC8F1A59CD = _id_D2A0F17E8E173E01 >= _id_26CD2FE9D9C7396A;
    _id_93E3FE0E5693889B = _id_B7652EEA48AE3D62 >= _id_26CD2FE9D9C7396A;

    if(_id_93E3FE0E5693889B) {
      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(!checkrequiredteamcount(_id_F90358454413407F)) {
          _id_54AB13AC8F1A59CD = 0;
          break;
        }
      }
    }

    if(istrue(_id_C8C8535645D45985) && _id_93E3FE0E5693889B && _id_6B7BEE46F2C6DA28 > mintime) {
      break;
    } else if(_id_54AB13AC8F1A59CD && _id_6B7BEE46F2C6DA28 > mintime) {
      break;
    }

    if(!_id_C8C8535645D45985 && getdvarint("dvar_5886DF61B04D3129", 0) == 0 && !istrue(level._id_60F7D8BD0181980F) && getactiveclientcount(1) < _id_26CD2FE9D9C7396A) {
      level._id_60F7D8BD0181980F = 1;
      setomnvarforallclients("ui_leagueplay_allow_quit", 1);
      thread _id_46EB417B582D5179(endtime - _id_6B7BEE46F2C6DA28);
    }

    if(_id_6B7BEE46F2C6DA28 > endtime) {
      _id_A11AEE8DA78E2638 = 1;
      break;
    }

    if(!_id_C8C8535645D45985 && !_id_6591C2949D00EE51 && _id_6B7BEE46F2C6DA28 + level.prematchperiodend * 1000 > endtime) {
      foreach(player in level.players) {
        if(istrue(player.waitingtoselectclass)) {
          _id_ED6036C19A695CD2 = player getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
          _id_235C2A26E9117E24 = scripts\engine\utility::ter_op(isDefined(_id_ED6036C19A695CD2), _id_ED6036C19A695CD2, 0);
          player notify("loadout_class_selected", _id_235C2A26E9117E24);
          player setclientomnvar("ui_options_menu", 0);
        }
      }

      _id_6591C2949D00EE51 = 1;
    }

    waitframe();
  }

  if(getdvarint("dvar_0C03A546C561F9EF", 0) || _id_C8C8535645D45985) {
    return;
  }
  if(_id_A11AEE8DA78E2638)
    _id_629A97C763E17711::_id_DC56B195BBF80D31();
}

getstreamedinplayercount() {
  count = 0;

  foreach(player in level.players) {
    if(istrue(player.pers["streamSyncComplete"]))
      count++;
  }

  return count;
}

checkrequiredteamcount(team) {
  return scripts\mp\utility\teams::getteamdata(team, "hasSpawned") >= level.requiredplayercount[team];
}

checkrequiredteamstreamcount(team) {
  count = 0;

  foreach(player in level.players) {
    if(isDefined(player.team) && player.team == team && istrue(player.pers["streamSyncComplete"]))
      count++;
  }

  return count >= level.requiredplayercount[team];
}

prematchperiod() {
  level endon("game_ended");
  level.connectingplayers = getdvarint("party_partyPlayerCountNum");

  if(getdvarint("scr_live_lobby", 0) == 1 && !istrue(level.skipprematch)) {
    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {}

    game["inLiveLobby"] = 1;

    if(getdvarint("dvar_466714DAD346A907", 0) == 1)
      level thread watchdevoverridematchstart();

    level thread watchforlowpopmatchstart(1);
    level thread watchforminplayersmatchstart();
    level waittill("start_prematch");

    if(level._id_77907D733ABE8B63) {
      level thread _id_697B7AE06BA9B28C::_id_562F080949959CFC();
      level thread _id_697B7AE06BA9B28C::_id_D794D8A20E142EFA();
    }

    setDvar("scr_live_lobby", 0);
    game["inLiveLobby"] = 0;
    game["liveLobbyCompleted"] = 1;
    _id_AE27DE936BAB61AD = 30;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      _id_AE27DE936BAB61AD = getdvarint("dvar_4B1B60F2EF1E4767", 60);

    level.allowprematchdamage = 0;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(scripts\mp\utility\game::getsubgametype() != "dmz")
        level.allowprematchdamage = 1;

      level thread _id_2CEDCC356F1B9FC8::br_delaynojip();
    }

    level livelobbymatchstarttimer("match_starting_in", _id_AE27DE936BAB61AD);
    level notify("start_prematch");
    level.prematchperiod = 0;
    game["blockJIP"] = 1;

    if(!scripts\mp\utility\game::privatematch()) {
      if(getdvarint("dvar_022EDDF44003BAF9", 0) != 0 && _func_7EDA3128313BB227()) {
        setDvar("dvar_925F7DCEB8E6205E", 1);
        _id_04CDABCD91A92977::_id_C5728699E6B79552(1);
      } else
        setDvar("dvar_925F7DCEB8E6205E", 0);
    } else if(getdvarint("dvar_022EDDF44003BAF9", 0) != 0 && getdvarint("dvar_8AF519063CE59CE9", 0) != 0) {
      setDvar("dvar_15DC0D6798E4BDD8", 1);
      setDvar("dvar_925F7DCEB8E6205E", 1);
      _id_04CDABCD91A92977::_id_C5728699E6B79552(1);
    }
  } else if(!istrue(level.skipprematch)) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm") {
      _id_AED019C0E09D9E8B = getdvarint("br_minplayers");

      if(_id_AED019C0E09D9E8B != 0) {
        level thread watchforlowpopmatchstart();
        level thread brwatchforminplayersmatchstart();
        level waittill("start_prematch");

        if(level._id_77907D733ABE8B63) {
          level thread _id_697B7AE06BA9B28C::_id_562F080949959CFC();
          level thread _id_697B7AE06BA9B28C::_id_D794D8A20E142EFA();
        }
      }

      _id_AE27DE936BAB61AD = 15;
      level.allowprematchdamage = 0;

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz")
        level.allowprematchdamage = 1;

      level livelobbymatchstarttimer("match_starting_in", _id_AE27DE936BAB61AD);
    }
  }

  if(istrue(level.skipprematch)) {
    while(!level.players.size)
      waitframe();

    if(scripts\mp\utility\game::matchmakinggame() && scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
      _id_1580CB21313FB11C = 2000;
      _id_2C5E9BEB8228E58A = gettime() + _id_1580CB21313FB11C;
      _id_458C943D98A7ED1A = _id_FE94AAEDD1047D50();

      while(gettime() < _id_2C5E9BEB8228E58A && _id_E48DEB3D75AB2E92() < _id_458C943D98A7ED1A)
        waitframe();
    }
  }

  if(istrue(game["matchStartRequiresInput"]))
    level waittill("pressToStartMatch");

  if(istrue(game["blockJIP"])) {
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    level.nojip = 1;
  }

  if(istrue(level._id_15C7D73680EA5496)) {
    return;
  }
  level notify("prematch_started");

  if(istrue(level._id_66113AA6FC12BE57))
    level.parachuterestoreweaponscb = _id_1E4A61DB11011446::nakeddrop;

  if(shouldmodelognotify() && game["roundsPlayed"] == 0)
    logstring("IWH-315293: CEPHALOPOD: prematch_started notified");

  updatetournamentroundtime(gettimeremaining(), 2);
  level.prematchstarted = 1;

  if(level.prematchperiodend > 0)
    matchstarttimerwaitforplayers();
  else
    matchstarttimerskip();

  scripts\mp\hostmigration::waittillhostmigrationdone();
  updatetournamentroundtime(gettimeremaining(), 0);

  if(game["state"] != "playing")
    return;
}

_id_1147BBC93EA9B83C() {
  return !istrue(level.skipprematch) && !scripts\mp\flags::gameflag("prematch_done");
}

givebmodevloadouts() {
  wait 3;

  if(isDefined(level.parachuterestoreweaponscb)) {
    foreach(player in level.players) {
      if(scripts\mp\utility\player::isreallyalive(player))
        player[[level.parachuterestoreweaponscb]]();
    }
  }
}

graceperiod() {
  level endon("game_ended");

  if(!isDefined(game["clientActive"])) {
    while(getactiveclientcount() == 0)
      waitframe();

    game["clientActive"] = 1;
  }

  while(level.ingraceperiod > 0) {
    wait 1.0;
    level.ingraceperiod--;
  }

  level notify("grace_period_ending");
  waitframe();
  scripts\mp\flags::gameflagset("graceperiod_done");
  level.ingraceperiod = 0;

  if(game["state"] != "playing") {
    if(shouldmodelognotify() && game["roundsPlayed"] == 0)
      logstring("IWH-315293: FROGFISH: game[ state ] != playing");

    return;
  }

  if(scripts\mp\utility\game::getgametypenumlives()) {
    players = level.players;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
      player = players[_id_AC0E594AC96AA3A8];

      if(!player.hasspawned && player.sessionteam != "spectator" && !isalive(player))
        player.statusicon = "hud_status_dead";
    }
  }

  level thread[[level.updategameevents]]();
}

sethasdonecombat(player, _id_0D6FB9FB787EB9CF) {
  if(_id_0D6FB9FB787EB9CF && !istrue(player.hasdonecombat))
    scripts\mp\class::disableclassswapallowed();

  player.hasdonecombat = _id_0D6FB9FB787EB9CF;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  if(_id_0D6FB9FB787EB9CF && !istrue(player.pers["hasDoneAnyCombat"])) {
    player.pers["hasDoneAnyCombat"] = 1;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      player scripts\mp\utility\stats::incpersstat("gamesPlayed", 1);

    if(isDefined(player.pers["hasMatchLoss"]) && player.pers["hasMatchLoss"]) {
      return;
    }
    updatelossstats(player);
  }
}

updatewinstats(winner) {
  if(!winner scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(winner.pers["hasDoneAnyCombat"])) {
    return;
  }
  if(istrue(winner.pers["recordedLoss"]))
    winner scripts\mp\playerstats_interface::addtoplayerstat(-1, "matchStats", "losses");

  winner scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "wins");
  winner scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "currentWinStreak");
  winner scripts\mp\playerstats_interface::addtoplayerstat(1, "modeRecords", scripts\mp\utility\game::getgametype());
  _id_B3AA3F46B2B65977 = winner scripts\mp\playerstats_interface::getplayerstat("matchStats", "currentWinStreak");

  if(_id_B3AA3F46B2B65977 > winner scripts\mp\playerstats_interface::getplayerstat("bestStats", "longestWinStreak"))
    winner scripts\mp\playerstats_interface::setplayerstat(_id_B3AA3F46B2B65977, "bestStats", "longestWinStreak");

  winner scripts\mp\persistence::statsetchild("round", "win", 1);
  winner scripts\mp\persistence::statsetchild("round", "loss", 0);
}

updatelossstats(_id_CB981323A7D441EA) {
  if(!_id_CB981323A7D441EA scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(_id_CB981323A7D441EA.pers["hasDoneAnyCombat"])) {
    return;
  }
  _id_CB981323A7D441EA.pers["hasMatchLoss"] = 1;

  if(!istrue(self.joinedinprogress)) {
    _id_CB981323A7D441EA scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "losses");
    _id_CB981323A7D441EA.pers["recordedLoss"] = 1;
  }

  _id_CB981323A7D441EA scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "gamesPlayed");
  _id_CB981323A7D441EA scripts\mp\persistence::statsetchild("round", "loss", 1);
}

updatetiestats(_id_CB981323A7D441EA) {
  if(!_id_CB981323A7D441EA scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(_id_CB981323A7D441EA.pers["hasDoneAnyCombat"])) {
    return;
  }
  if(istrue(_id_CB981323A7D441EA.pers["recordedLoss"])) {
    _id_CB981323A7D441EA scripts\mp\playerstats_interface::addtoplayerstat(-1, "matchStats", "losses");
    _id_CB981323A7D441EA scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
  }

  _id_CB981323A7D441EA scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "ties");
  _id_CB981323A7D441EA scripts\mp\persistence::statsetchild("round", "loss", 0);
}

updatewinlossstats(winner) {
  if(scripts\mp\utility\game::privatematch()) {
    return;
  }
  if(!scripts\mp\utility\game::waslastround()) {
    return;
  }
  level.processedwinloss = 1;
  players = level.players;
  updateplayercombatstatus();

  if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie") {
    foreach(player in level.players) {
      if(isDefined(player.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && player ishost()) {
        player scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      updatetiestats(player);
    }
  } else if(isPlayer(winner)) {
    if(level.hostforcedend && winner ishost()) {
      winner scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
      return;
    }

    if(isDefined(level.lastplayerwins) || players.size <= 3)
      updatewinstats(level.placement["all"][0]);
    else {
      for(_id_3EB36C9F2F1A8E92 = 0; _id_3EB36C9F2F1A8E92 < min(level.placement["all"].size, 3); _id_3EB36C9F2F1A8E92++)
        updatewinstats(level.placement["all"][_id_3EB36C9F2F1A8E92]);
    }
  } else if(isstring(winner)) {
    foreach(player in level.players) {
      if(isDefined(player.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && player ishost()) {
        player scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      if(winner == "tie") {
        updatetiestats(player);
        continue;
      }

      if(player.pers["team"] == winner) {
        updatewinstats(player);
        continue;
      }

      if(istrue(player.pers["recordedLoss"]))
        player scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
    }
  }

  foreach(player in level.players) {
    if(!isDefined(player) || !player scripts\mp\utility\game::onlinestatsenabled()) {
      continue;
    }
    if(isai(player)) {
      continue;
    }
    _id_19EE74143D56B46A = player scripts\mp\playerstats_interface::getplayerstat("matchStats", "wins");

    if(_id_19EE74143D56B46A >= 5)
      player giveachievement("MP_ACHIEVEMENT_1");
  }
}

updateplayercombatstatus() {
  if(scripts\mp\utility\game::getgametype() != "infect") {
    return;
  }
  foreach(player in level.players) {
    if(player.sessionstate == "spectator" && !player.spectatekillcam)
      continue;
    else if(istrue(player.pers["hasDoneAnyCombat"]))
      continue;
    else if(player.team == "axis")
      continue;
    else
      player sethasdonecombat(player, 1);
  }
}

freezeplayerforroundend(delay) {
  self endon("disconnect");
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\utility\lower_message::clearlowermessages();

  if(!isDefined(delay))
    delay = level.framedurationseconds;

  wait(delay);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("gameEndFreeze", 0);

  if(self isonground() || self isonladder())
    self allowmovement(0);
  else
    thread gameendfreezemovement();
}

gameendfreezemovement() {
  self endon("disconnect");
  _id_8A5D258252579930 = 0.0;

  while(_id_8A5D258252579930 < 1) {
    if(!self isonground())
      _id_8A5D258252579930 = _id_8A5D258252579930 + level.framedurationseconds;
    else {
      self allowmovement(0);
      break;
    }

    wait(level.framedurationseconds);
  }

  self allowmovement(0);
}

updatematchbonusscores(winner) {
  if(!game["timePassed"]) {
    return;
  }
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(!scripts\mp\utility\game::gettimelimit() || level.forcedend) {
    _id_7DB9C25FC83CDED3 = scripts\mp\utility\game::gettimepassed() / 1000;
    _id_7DB9C25FC83CDED3 = min(_id_7DB9C25FC83CDED3, 1200);
  } else
    _id_7DB9C25FC83CDED3 = int(floor(scripts\mp\utility\game::_id_1236E61C6E2C58F1() / 1000));

  if(level.teambased) {
    if(isDefined(winner) && scripts\mp\utility\teams::isgameplayteam(winner) && winner != "tie")
      setwinningteam(winner);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "kingslayer" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
      return;
    }
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(player.connectedpostgame)) {
        continue;
      }
      if(!player scripts\mp\utility\game::rankingenabled()) {
        continue;
      }
      if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
        continue;
      }
      if(level.hostforcedend && player ishost()) {
        continue;
      }
      if(!istrue(player.pers["hasDoneAnyCombat"])) {
        continue;
      }
      if(winner == "tie") {
        _id_663572CC85C027C6 = player calculatematchbonus("tie", _id_7DB9C25FC83CDED3);
        player givematchbonus("tie", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] == winner) {
        _id_663572CC85C027C6 = player calculatematchbonus("win", _id_7DB9C25FC83CDED3);
        player givematchbonus("win", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      } else if(isDefined(player.pers["team"]) && scripts\mp\utility\teams::isgameplayteam(player.pers["team"]) && player.pers["team"] != winner) {
        _id_663572CC85C027C6 = player calculatematchbonus("loss", _id_7DB9C25FC83CDED3);
        player givematchbonus("loss", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      }

      player calculateweaponmatchbonus(_id_7DB9C25FC83CDED3);
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "kingslayer" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
      return;
    }
    _id_DBBFD0E462584B9B = "win";
    _id_0B1EFC8448D0E3B3 = "loss";

    if(!isDefined(winner)) {
      _id_DBBFD0E462584B9B = "tie";
      _id_0B1EFC8448D0E3B3 = "tie";
    }

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(player.connectedpostgame)) {
        continue;
      }
      if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
        continue;
      }
      if(!istrue(player.pers["hasDoneAnyCombat"])) {
        continue;
      }
      _id_7C6311737CB7A0B2 = 0;

      for(_id_3EB36C9F2F1A8E92 = 0; _id_3EB36C9F2F1A8E92 < min(level.placement["all"].size, 3); _id_3EB36C9F2F1A8E92++) {
        if(level.placement["all"][_id_3EB36C9F2F1A8E92] != player) {
          continue;
        }
        _id_7C6311737CB7A0B2 = 1;
      }

      if(_id_7C6311737CB7A0B2) {
        _id_663572CC85C027C6 = player calculatematchbonus(_id_DBBFD0E462584B9B, _id_7DB9C25FC83CDED3);
        player givematchbonus("win", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      } else {
        _id_663572CC85C027C6 = player calculatematchbonus(_id_0B1EFC8448D0E3B3, _id_7DB9C25FC83CDED3);
        player givematchbonus("loss", _id_663572CC85C027C6);
        player.matchbonus = _id_663572CC85C027C6;
      }

      player calculateweaponmatchbonus(_id_7DB9C25FC83CDED3);
    }
  }

  level notify("give_match_bonus");
}

calculatematchbonus(_id_E8F096C8BFC6C153, _id_7DB9C25FC83CDED3) {
  _id_ACD7DFF57C94292A = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_matchbonus_baseline"), 250);
  _id_F5C150745DB5BF66 = _id_7DB9C25FC83CDED3 / 60;
  _id_030FB07C2CA202FF = scripts\mp\rank::_id_6D17F84162F0D8F0(_id_E8F096C8BFC6C153);
  _id_4335FE32113AC6CB = self.timeplayed["total"] / _id_7DB9C25FC83CDED3;
  _id_C1495B0F54D34DD6 = scripts\mp\rank::getgametypexpmultiplier();
  matchbonus = int(_id_ACD7DFF57C94292A * _id_030FB07C2CA202FF * _id_F5C150745DB5BF66 * _id_4335FE32113AC6CB * _id_C1495B0F54D34DD6);
  matchbonus = int(min(matchbonus, 16384));
  return matchbonus;
}

givematchbonus(_id_69CB334822EBE431, score) {
  if(getdvarint("dvar_1F9E52C91272C80D", 1) == 0) {
    return;
  }
  thread scripts\mp\rank::giverankxp(_func_1823FF50BB28148D(_id_69CB334822EBE431), score, undefined, 1, 1, 1);

  if(_id_69CB334822EBE431 == "win")
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FE606101A22E3E79", undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined, undefined, undefined, 1);
  else
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_DC98011722824BD8", undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined, undefined, undefined, 1);
}

calculateweaponmatchbonus(_id_7DB9C25FC83CDED3) {
  if(getdvarint("dvar_F80C5403193B015F", 1) == 0) {
    return;
  }
  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }
  _id_011865501DE9083D = scripts\mp\weaponrank::getgametypekillsperhouravg() / 60;
  _id_F5C150745DB5BF66 = _id_7DB9C25FC83CDED3 / 60;
  _id_162A122A3E3CCE1A = int(_id_011865501DE9083D * _id_F5C150745DB5BF66);
  _id_63F737A3357B557E = int(50.0);
  _id_4335FE32113AC6CB = self.timeplayed["total"] / _id_7DB9C25FC83CDED3;
  _id_9BF173C2AA7EB966 = _id_63F737A3357B557E * _id_4335FE32113AC6CB;
  _id_4B7CF89ACAABDCAC = int(_id_162A122A3E3CCE1A * _id_9BF173C2AA7EB966);
  _id_4B7CF89ACAABDCAC = _id_4B7CF89ACAABDCAC - int(self.pers["weaponMatchBonusKills"] * _id_9BF173C2AA7EB966);

  if(_id_4B7CF89ACAABDCAC <= 0) {
    return;
  }
  _id_CE22C9B0708CAF7E = 0;

  foreach(data in self.pers["killsPerWeapon"])
  _id_CE22C9B0708CAF7E = _id_CE22C9B0708CAF7E + (_id_162A122A3E3CCE1A - data.killcount);

  if(_id_CE22C9B0708CAF7E <= 0) {
    return;
  }
  foreach(_id_5DC27A5BF459C504, data in self.pers["killsPerWeapon"]) {
    _id_6C8D21B2E54B2478 = (_id_162A122A3E3CCE1A - data.killcount) / _id_CE22C9B0708CAF7E;
    _id_C01EE836EF4A7E4A = int(_id_4B7CF89ACAABDCAC * _id_6C8D21B2E54B2478);
    scripts\mp\rank::incrankxp(0, data, _id_C01EE836EF4A7E4A, _func_1823FF50BB28148D("WeaponMatchBonus"));

    foreach(_id_10CA4BF7AA9C3ED2, _id_5842E592DDCEF384 in self.pers["weaponStats"]) {
      if(issubstr(_id_10CA4BF7AA9C3ED2, _id_5DC27A5BF459C504)) {
        if(isDefined(_id_5842E592DDCEF384.stats["kills"]) && data.killcount > 0) {
          _id_C40AA4F6F34FFDC4 = _id_6C8D21B2E54B2478 * (_id_5842E592DDCEF384.stats["kills"] / data.killcount);
          _id_C01EE836EF4A7E4A = int(_id_4B7CF89ACAABDCAC * _id_C40AA4F6F34FFDC4);

          if(isDefined(_id_5842E592DDCEF384.stats["xp_earned"]))
            _id_5842E592DDCEF384.stats["xp_earned"] = _id_5842E592DDCEF384.stats["xp_earned"] + _id_C01EE836EF4A7E4A;
          else
            _id_5842E592DDCEF384.stats["xp_earned"] = _id_C01EE836EF4A7E4A;
        }
      }
    }
  }
}

setxenonranks(winner) {
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(!isDefined(player.score) || !isDefined(player.pers["team"]))
      continue;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];
    _setplayerteamrank(player);
  }
}

_setplayerteamrank(player, teamplacement) {
  if(!isDefined(player)) {
    return;
  }
  if(istrue(player.pers["xenonRankSet"])) {
    return;
  }
  if(!isDefined(player.kills) || !isDefined(player.deaths)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(1 > player.timeplayed["total"]) {
      return;
    }
    if(!isDefined(player.arenadamage)) {
      return;
    }
    damage = player.arenadamage;
    setplayerteamrank(player, player.clientid, damage);
    player.pers["xenonRankSet"] = 1;
  } else if(scripts\mp\utility\game::isteamplacementsbmmmode()) {
    if(!isDefined(teamplacement))
      teamplacement = scripts\engine\utility::_id_53C4C53197386572(player.teamplacement, 0);

    _id_663572CC85C027C6 = 1000 - teamplacement;
    setplayerteamrank(player, player.clientid, _id_663572CC85C027C6);
    player.pers["xenonRankSet"] = 1;
  } else if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    _id_32EA0136E9AFCD9A = scripts\engine\utility::_id_53C4C53197386572(player.kills, 0);
    _id_2B00EAA34070C8F7 = scripts\engine\utility::_id_53C4C53197386572(player._id_2B00EAA34070C8F7, 0);
    _id_1AA1F0FB85AA2F76 = scripts\engine\utility::_id_53C4C53197386572(player.pers["downs"], 0);
    deaths = scripts\engine\utility::_id_53C4C53197386572(player.deaths, 0);
    _id_05E5C27FCED1B958 = scripts\engine\utility::_id_53C4C53197386572(player scripts\mp\utility\stats::getpersstat("suicides"), 0);
    _id_8D738248E5C26CF9 = scripts\engine\utility::_id_53C4C53197386572(player scripts\mp\teams::_id_19300ABFBB10928B() / 60, 1);

    if(_id_8D738248E5C26CF9 == 0)
      _id_8D738248E5C26CF9 = 1;

    _id_F7AD089E7173EF76 = (_id_32EA0136E9AFCD9A - (_id_1AA1F0FB85AA2F76 + deaths - _id_05E5C27FCED1B958)) / _id_8D738248E5C26CF9;
    _id_9A98108BC0622435 = (_id_2B00EAA34070C8F7 - (_id_1AA1F0FB85AA2F76 + deaths - _id_05E5C27FCED1B958)) / _id_8D738248E5C26CF9;
    _id_BA0BEA5B319C5B2D = getdvarfloat("dvar_9CDADF8CF57F485E", 0.75);
    _id_AF48040F4E0CE6F2 = getdvarfloat("dvar_F4A4D4DF91CF9F67", 0.25);
    _id_00AE17C5A8B1BC1B = _id_F7AD089E7173EF76 * _id_BA0BEA5B319C5B2D + _id_9A98108BC0622435 * _id_AF48040F4E0CE6F2;
    setplayerteamrank(player, player.clientid, _id_00AE17C5A8B1BC1B);
    player.pers["xenonRankSet"] = 1;
  } else {
    if(120 > player.timeplayed["total"]) {
      return;
    }
    _id_05E5C27FCED1B958 = 0;

    if(getdvarint("dvar_8613EE8086B0E0F6") == 1)
      _id_05E5C27FCED1B958 = player scripts\mp\utility\stats::getpersstat("suicides");

    _id_CE3B2F78F590611E = (player.kills - (player.deaths - _id_05E5C27FCED1B958)) / (player.timeplayed["total"] / 60);
    setplayerteamrank(player, player.clientid, _id_CE3B2F78F590611E);
    player.pers["xenonRankSet"] = 1;
  }
}

checktimelimit(_id_F177BC3F3B9E94B1) {
  if(isDefined(level.timelimitoverride) && level.timelimitoverride) {
    return;
  }
  if(game["state"] != "playing") {
    setgameendtime(0);
    return;
  }

  runjiprules();

  if(scripts\mp\utility\game::gettimelimit() <= 0) {
    if(isDefined(level.starttime))
      setgameendtime(level.starttime);
    else
      setgameendtime(0);

    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    setgameendtime(0);
    return;
  }

  if(!isDefined(level.starttime)) {
    return;
  }
  if(istrue(level.timerstopped)) {
    return;
  }
  _id_8DD9F2EB8215A139 = gettimeremaining();
  setgameendtime(gettime() + int(_id_8DD9F2EB8215A139));
  _id_83AF6C8B7CEE31C8 = istrue(level.ontimelimitgraceperiod);

  if(_id_8DD9F2EB8215A139 > 0 && !isDefined(level.forceotlogictorun)) {
    if(_id_83AF6C8B7CEE31C8) {
      if(istrue(level.setallclientomnvarot))
        setomnvarforallclients("ui_overtime_timer_show", 0);
      else
        setomnvar("ui_overtime_timer_show", 0);
    }

    return;
  }

  if(_id_83AF6C8B7CEE31C8) {
    scripts\mp\flags::gameflagset("overtime_started");

    if(!isDefined(level.overtimetotal))
      level.overtimetotal = 0;
    else
      level.overtimetotal = level.overtimetotal + level.frameduration;

    if(isDefined(level.ontimelimitot)) {
      [[level.ontimelimitot]]();
      level.ontimelimitot = undefined;
    }

    if(istrue(level.canprocessot))
      level.currenttimelimitdelay = level.currenttimelimitdelay + level.framedurationseconds;
    else
      level.currenttimelimitdelay = 0;

    progress = clamp(1.0 - level.currenttimelimitdelay / level.ontimelimitgraceperiod, 0.0, 1.0);

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      if(istrue(level.setallclientomnvarot)) {
        if(!isDefined(level.forcehideottimer))
          setomnvarforallclients("ui_overtime_timer_show", 1);

        setomnvarforallclients("ui_overtime_timer", progress);
      } else {
        setomnvar("ui_overtime_timer_show", 1);
        setomnvar("ui_overtime_timer", progress);
      }

      if(scripts\mp\utility\game::getsubgametype() == "champion")
        setomnvar("ui_overtime_time", gettime() + (level.ontimelimitgraceperiod - level.currenttimelimitdelay) * 1000);
      else
        setomnvar("ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000);
    } else {
      if(istrue(level.setallclientomnvarot)) {
        setomnvarforallclients("ui_overtime_timer_show", 0);
        setomnvarforallclients("ui_overtime_timer", progress);
      } else {
        setomnvar("ui_overtime_timer_show", 0);
        setomnvar("ui_overtime_timer", progress);
      }

      if(scripts\mp\utility\game::getsubgametype() == "champion")
        setomnvar("ui_overtime_time", gettime());
      else
        setomnvar("ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000);
    }

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod)
      return;
  }

  [[level.ontimelimit]]();
}

enableovertimegameplay() {
  level.ontimelimitgraceperiod = 5.0;
  level.currenttimelimitdelay = 0.0;
}

runjiprules() {
  if(!level.matchmakingmatch) {
    return;
  }
  if(!isDefined(level.nojip))
    level.nojip = 0;

  if(!level.nojip) {
    if(scripts\mp\utility\game::isroundbased() && !level.nojip) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "dom":
        case "front":
          _id_0310CAAF87186CD6 = checkdomjiprules();
          break;
        case "rugby":
        case "ko":
        case "cyber":
        case "siege":
        case "sr":
        case "sd":
        case "arena":
          _id_0310CAAF87186CD6 = _id_8E22BFD7B2FC9DDA();
          break;
        case "ctf":
          _id_0310CAAF87186CD6 = checkctfjiprules();
          break;
        case "ball":
          _id_0310CAAF87186CD6 = checkballjiprules();
          break;
        case "dd":
          _id_0310CAAF87186CD6 = checkddjiprules();
          break;
        default:
          _id_0310CAAF87186CD6 = checkdefaultjiprules();
          break;
      }

      if(_id_0310CAAF87186CD6) {
        setnojipscore(1, 1);
        setnojiptime(1, 1);
        level.nojip = 1;
        return;
      }
    } else if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      setnojiptime(1, 1);
      level.nojip = 1;
    }
  }
}

checkdomjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(getteamscoreint(_id_F90358454413407F) > 150)
        return 1;
    }

    if(scripts\mp\utility\game::gettimepassedpercentage() > 75)
      return 1;
  }

  return 0;
}

_id_8E22BFD7B2FC9DDA() {
  _id_BDB5DE4F9346B298 = 3;

  switch (scripts\mp\utility\game::getgametype()) {
    case "sr":
    case "sd":
      _id_BDB5DE4F9346B298 = 3;
      break;
    case "siege":
      _id_BDB5DE4F9346B298 = 2;
      break;
    case "cyber":
      _id_BDB5DE4F9346B298 = 3;
      break;
    case "arena":
      _id_BDB5DE4F9346B298 = 3;
      break;
    case "ko":
      _id_BDB5DE4F9346B298 = 3;
      break;
    case "rugby":
      _id_BDB5DE4F9346B298 = 2;
      break;
    default:
      _id_BDB5DE4F9346B298 = 3;
      break;
  }

  if(scripts\mp\utility\game::isanymlgmatch())
    _id_BDB5DE4F9346B298 = 5;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\mp\utility\game::getroundswon(_id_F90358454413407F) >= _id_BDB5DE4F9346B298)
      return 1;
  }

  return 0;
}

checkctfjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff)
      return 1;
  }

  _id_4244662178FA8083 = undefined;
  _id_C7761B0132ABCFA7 = undefined;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_929A6DF466DC4F22 = getteamscoreint(_id_F90358454413407F);

    if(!isDefined(_id_4244662178FA8083) || _id_929A6DF466DC4F22 < _id_4244662178FA8083)
      _id_4244662178FA8083 = _id_929A6DF466DC4F22;

    if(!isDefined(_id_C7761B0132ABCFA7) || _id_929A6DF466DC4F22 > _id_C7761B0132ABCFA7)
      _id_C7761B0132ABCFA7 = _id_929A6DF466DC4F22;
  }

  _id_3777ECE6A73EADA5 = abs(_id_C7761B0132ABCFA7 - _id_4244662178FA8083);

  if(_id_3777ECE6A73EADA5 > 10)
    return 1;

  return 0;
}

checkballjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff)
      return 1;
  }

  _id_4244662178FA8083 = undefined;
  _id_C7761B0132ABCFA7 = undefined;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_929A6DF466DC4F22 = getteamscoreint(_id_F90358454413407F);

    if(!isDefined(_id_4244662178FA8083) || _id_929A6DF466DC4F22 < _id_4244662178FA8083)
      _id_4244662178FA8083 = _id_929A6DF466DC4F22;

    if(!isDefined(_id_C7761B0132ABCFA7) || _id_929A6DF466DC4F22 > _id_C7761B0132ABCFA7)
      _id_C7761B0132ABCFA7 = _id_929A6DF466DC4F22;
  }

  _id_3777ECE6A73EADA5 = abs(_id_C7761B0132ABCFA7 - _id_4244662178FA8083);

  if(_id_3777ECE6A73EADA5 > 15)
    return 1;

  return 0;
}

checkddjiprules() {
  _id_743180D464FC06D1 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist)
  _id_743180D464FC06D1 = _id_743180D464FC06D1 + scripts\mp\utility\game::getroundswon(_id_F90358454413407F);

  if(_id_743180D464FC06D1 >= 2)
    return 1;

  return 0;
}

checkdefaultjiprules() {
  if(scripts\mp\utility\game::nextroundisfinalround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff)
      return 1;
  }

  return 0;
}

getteamscoreint(team) {
  return int(game["teamScores"][team]);
}

gettimeremaining() {
  _id_CC683B074A559F27 = 0;

  if(isDefined(level._id_CC683B074A559F27))
    _id_CC683B074A559F27 = level._id_CC683B074A559F27;

  return scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed() - _id_CC683B074A559F27;
}

gettimeremainingpercentage() {
  timelimit = scripts\mp\utility\game::gettimelimit() * 1000;
  return (timelimit - scripts\mp\utility\game::gettimepassed()) / timelimit;
}

checkteamscorelimitsoon(team) {
  if(level.roundscorelimit <= 0 || scripts\mp\utility\game::isobjectivebased()) {
    return;
  }
  if(isDefined(level.scorelimitoverride) && level.scorelimitoverride) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "jugg") {
    return;
  }
  if(!level.teambased) {
    return;
  }
  _id_0D68C5A87FF60523 = 0;

  if(shouldcheckcustomclosetoscorelimit())
    _id_0D68C5A87FF60523 = closetoscorelimit(team);
  else if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
    _id_389A5F5663132900 = closetoscorelimit(team);
    _id_77C63F5CD9656BDB = gettimeremaining() < scripts\mp\utility\game::gettimelimit() * 0.075;
    _id_0D68C5A87FF60523 = _id_389A5F5663132900 || _id_77C63F5CD9656BDB;
  } else if(scripts\mp\utility\game::gettimepassed() > 45000)
    _id_0D68C5A87FF60523 = estimatedtimetillscorelimit(team) < 0.5;

  if(!isDefined(level.playedmatchendingsoon))
    level.playedmatchendingsoon = 0;

  if(!level.playedmatchendingsoon && _id_0D68C5A87FF60523) {
    level.playedmatchendingsoon = 1;
    level notify("match_ending_soon", "score");
  }

  if(!level.playedmatchendingsoon && scripts\mp\utility\game::canplayhalfwayvo()) {
    if(getteamscore(team) >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      scripts\mp\utility\dialog::leaderdialog("halfway_friendly_score", team, "status");
      thread scripts\mp\music_and_dialog::midpoint_music(team);
      _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(team);

      foreach(_id_F90358454413407F in _id_B0C33D224B825287)
      scripts\mp\utility\dialog::leaderdialog("halfway_enemy_score", _id_F90358454413407F, "status");

      level.didhalfscorevoboost = 1;
    }
  }
}

shouldcheckcustomclosetoscorelimit() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "conf":
    case "tdef":
    case "conflict":
    case "dom":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

checkplayerscorelimitsoon() {
  if(level.roundscorelimit <= 0 || scripts\mp\utility\game::isobjectivebased()) {
    return;
  }
  if(level.teambased) {
    return;
  }
  if(scripts\mp\utility\game::gettimepassed() < 60000) {
    return;
  }
  scripts\mp\gamescore::checkffascorejip();

  if(scripts\mp\utility\game::getgametype() == "gun") {
    if(self.score == 14)
      level notify("match_ending_soon", "score");
  } else {
    _id_8DD9F2EB8215A139 = estimatedtimetillscorelimit();

    if(_id_8DD9F2EB8215A139 < 2)
      level notify("match_ending_soon", "score");
  }
}

checkscorelimit(_id_6E5149EF941C9008) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill())
    _id_6E5149EF941C9008 = 1;

  if(istrue(_id_6E5149EF941C9008)) {
    if(isPlayer(self) && !level.teambased && self.score >= level.roundscorelimit)
      level.scorelimitreached = 1;

    level notify("checkScoreLimit");
    level endon("checkScoreLimit");
    waitframe();
  }

  if(scripts\mp\utility\game::isobjectivebased())
    return 0;

  if(isDefined(level.scorelimitoverride) && level.scorelimitoverride)
    return 0;

  if(game["state"] != "playing")
    return 0;

  if(level.roundscorelimit <= 0)
    return 0;

  if(level.teambased) {
    _id_BB9DC32B46AC2C1A = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
      if(game["teamScores"][level.teamnamelist[_id_AC0E594AC96AA3A8]] >= level.roundscorelimit)
        _id_BB9DC32B46AC2C1A = 1;
    }

    if(!_id_BB9DC32B46AC2C1A)
      return 0;
  } else {
    if(!isPlayer(self))
      return 0;

    if(self.score < level.roundscorelimit && !istrue(level.scorelimitreached))
      return 0;
  }

  if(!istrue(level.dontendonscore))
    return onscorelimit(_id_6E5149EF941C9008);
}

updategametypedvars() {
  level endon("game_ended");

  while(game["state"] == "playing") {
    if(isDefined(level.starttime)) {
      if(gettimeremaining() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

matchstarttimerwaitforplayers() {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("infilSequence")) {
    if(!istrue(level._id_72E1667D06AB98DB))
      setomnvar("ui_in_infil", 3);
  }

  if(istrue(level._id_EC2FB549B15AD827)) {
    _id_0D084AF239C9A23C(level._id_C8001F5313A05589, 1);
    level thread prematchcountdownnotify();
  } else {
    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      thread matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);

    level thread prematchcountdownnotify();
    waitforplayers(level.prematchperiod, 0, 0);
  }

  if(level.prematchperiodend > 0 && !isDefined(level.hostmigrationtimer)) {
    _id_3142592A7F2064F5 = level.prematchperiodend;
    level notify("match_start_real_countdown", _id_3142592A7F2064F5);

    if(istrue(level._id_EC2FB549B15AD827)) {
      _id_3B0D320C2BE79893 = level.prematchperiod * 2 + _id_3142592A7F2064F5;
      level._id_90C77DED0370DBE9 = 1;
      level notify("leaguePlayLoadingComplete");
      setomnvar("ui_mp_extended_load_screen", 0);
      setomnvar("ui_match_start_text", "waiting_for_players");
      _id_0D084AF239C9A23C(_id_3B0D320C2BE79893, 0);
      level._id_60F7D8BD0181980F = 0;
    }

    if(!scripts\mp\flags::gameflag("infil_will_run") && game["roundsPlayed"] == 0 && !scripts\cp_mp\utility\game_utility::isarenamap() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm")
      level thread showmapchyron();

    thread matchstarttimer("match_starting_in", _id_3142592A7F2064F5);
    thread prematchcountdownnotify(_id_3142592A7F2064F5);
    level waittill("matchStartTimer_done");
  }
}

showmapchyron() {
  setomnvar("ui_in_infil", 1);
  level scripts\engine\utility::waittill_notify_or_timeout("matchStartTimer_done", 8.0);
  setomnvar("ui_in_infil", -1);
}

prematchcountdownnotify(_id_38A6B48A5F70C0B8) {
  level notify("prematchCountdownNotify");
  level endon("prematchCountdownNotify");

  if(isDefined(_id_38A6B48A5F70C0B8))
    wait(max(_id_38A6B48A5F70C0B8 - 5, 0));
  else
    wait(max(level.prematchperiod + level.prematchperiodend - 5, 0));

  scripts\mp\flags::gameflagset("prematch_countdown");
}

startmodeobjidnotify(time) {
  self notify("startOBJID");
  self endon("startOBJID");

  if(scripts\mp\utility\game::getgametype() == "sd")
    _id_258E7B3DFB914A71 = 6;
  else
    _id_258E7B3DFB914A71 = 5;

  if(time > _id_258E7B3DFB914A71) {
    time = time - _id_258E7B3DFB914A71;
    max(time, 0);
    wait(time);
  } else
    wait 0.5;

  level notify("start_mode_setup");
}

matchstarttimer(type, duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  _id_B710552E5D79A601 = int(duration);
  level thread startmodeobjidnotify(_id_B710552E5D79A601);

  if(_id_B710552E5D79A601 >= 2) {
    setomnvar("ui_match_start_text", type);
    matchstarttimerperplayer_internal(_id_B710552E5D79A601);
  }

  visionsetnaked("", 0.0);
  level notify("matchStartTimer_done");

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924() || istrue(level.testrandomrealismclients)) {
    foreach(player in level.players) {
      if(istrue(level.testrandomrealismclients)) {
        if(!isDefined(player.isrealismenabled)) {
          if(scripts\engine\utility::cointoss()) {
            player setclientomnvar("ui_realism_hud", 0);
            player setclientomnvar("ui_realism_hud", 1);
            player.isrealismenabled = 1;
          }
        }

        continue;
      }

      player setclientomnvar("ui_realism_hud", 0);
      player setclientomnvar("ui_realism_hud", 1);
    }
  }
}

matchstarttimerperplayer_internal(_id_B710552E5D79A601) {
  waittillframeend;
  level endon("match_start_timer_beginning");
  level endon("match_cancel_timer_beginning");
  _id_C835A7183D47607B = int(_id_B710552E5D79A601);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm")
    thread _id_2CEDCC356F1B9FC8::applyprematchplotarmor(_id_C835A7183D47607B);

  foreach(_id_F90358454413407F in level.teamnamelist)
  childthread teamstarttimer(_id_F90358454413407F, _id_C835A7183D47607B);

  _id_F246834464C55D65 = ["spectator", "codcaster"];

  foreach(_id_F90358454413407F in _id_F246834464C55D65)
  childthread teamstarttimer(_id_F90358454413407F, _id_C835A7183D47607B);

  childthread clearvisionsettimer(_id_C835A7183D47607B);
  wait(_id_C835A7183D47607B);
}

teamstarttimer(team, _id_B710552E5D79A601) {
  level endon("match_start_timer_beginning");
  level endon("match_cancel_timer_beginning");
  level.matchcountdowntime = _id_B710552E5D79A601;

  if(!level.gameended) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      thread _id_2CEDCC356F1B9FC8::prematchmusic(team);
      thread _id_2CEDCC356F1B9FC8::prematchdialog(team);
    }

    while(_id_B710552E5D79A601 > 0 && !level.gameended) {
      _id_5A9CFC3686B1FD8D = scripts\mp\utility\teams::getteamdata(team, "players");

      foreach(player in _id_5A9CFC3686B1FD8D) {
        if(_id_B710552E5D79A601 <= 80) {
          player setclientomnvar("ui_match_start_countdown", _id_B710552E5D79A601);
          player setclientomnvar("ui_match_in_progress", 0);
        }
      }

      _id_B710552E5D79A601--;
      level.matchcountdowntime = _id_B710552E5D79A601;

      if(_id_B710552E5D79A601 <= 4 && !isDefined(level.playedstartingmusic))
        level notify("prematch_music");

      wait 1.0;
      _id_BB0D1BA749AC56DD = _id_548072087C9FD504::_id_6FC852802774B304(1, _id_B710552E5D79A601 * 1000);

      if(_id_BB0D1BA749AC56DD > 0 && _id_B710552E5D79A601 <= 10) {
        if(!scripts\mp\flags::gameflag("prematch_done"))
          _id_BB0D1BA749AC56DD = 10;

        _id_B710552E5D79A601 = _id_BB0D1BA749AC56DD;
      }
    }

    _id_548072087C9FD504::_id_07A921EB7B2CBB5D();
    level.matchcountdowntime = undefined;
    _id_5A9CFC3686B1FD8D = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in _id_5A9CFC3686B1FD8D) {
      scripts\mp\playerlogic::clearprematchlook(player);
      player scripts\mp\utility\player::_freezecontrols(0, 1);
      player setclientomnvar("ui_match_start_countdown", -1);
      player setclientomnvar("ui_match_in_progress", 1);
    }

    scripts\mp\flags::gameflagset("prematch_values_reset");
  }
}

_id_46EB417B582D5179(_id_05AB9EA557C8B0A4, _id_4C918B514697B434) {
  level notify("match_cancel_timer_beginning");
  level endon("match_cancel_timer_beginning");
  _id_3B49A6B4425C3BDF = "match_cancelling_in";

  if(isDefined(_id_4C918B514697B434))
    _id_3B49A6B4425C3BDF = _id_4C918B514697B434;

  setomnvar("ui_match_start_text", _id_3B49A6B4425C3BDF);
  _id_B710552E5D79A601 = int(_id_05AB9EA557C8B0A4 / 1000);
  waittillframeend;

  while(_id_B710552E5D79A601 > 0 && level._id_60F7D8BD0181980F) {
    foreach(_id_AC0E424AC96A7113 in level.players) {
      _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", _id_B710552E5D79A601);
      _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 0);
    }

    _id_B710552E5D79A601--;
    wait 1;
  }
}

clearvisionsettimer(_id_B710552E5D79A601) {
  while(_id_B710552E5D79A601 > 0 && !level.gameended) {
    _id_B710552E5D79A601--;
    wait 1.0;
  }

  visionsetnaked("", 0);
}

matchstarttimerskip() {
  visionsetnaked("", 0);
}

onroundswitch(overtime) {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(overtime) {
    level.halftimetype = "overtime";

    if(scripts\mp\utility\game::islastwinbytwo()) {
      _id_9F9016BD756FAB23 = getbetterteam();

      if(_id_9F9016BD756FAB23 != game["defenders"]) {
        game["switchedsides"] = !game["switchedsides"];
        level.switchedsides = 1;
        return;
      }

      level.switchedsides = undefined;
      return;
    } else {
      game["switchedsides"] = !game["switchedsides"];
      level.switchedsides = 1;
    }
  } else if(istrue(level.skipdefendersadvantage)) {
    game["switchedsides"] = !game["switchedsides"];
    level.switchedsides = 1;
  } else if(shouldgivedefendersadvantage()) {
    _id_9F9016BD756FAB23 = getbetterteam();

    if(_id_9F9016BD756FAB23 != game["defenders"]) {
      game["switchedsides"] = !game["switchedsides"];
      level.switchedsides = 1;
      return;
    }

    level.switchedsides = undefined;
    return;
  } else {
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
    level.switchedsides = 1;
  }
}

shouldgivedefendersadvantage() {
  return game["roundsWon"]["allies"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1;
}

checkroundswitch(overtime) {
  if(!level.teambased)
    return 0;

  if(!isDefined(level.roundswitch) || !level.roundswitch)
    return 0;

  if(_id_AC027009283233C6()) {
    if(_id_E3058EFBDB62A578())
      return 1;
  } else if(game["roundsPlayed"] % level.roundswitch == 0 || overtime)
    return 1;

  return 0;
}

_id_AC027009283233C6() {
  switch (level.gametype) {
    case "arena":
      if(level.roundswitch == 2 && getdvarint("scr_arena_loadoutchangeround", 2) == 2)
        return 1;

      return 0;
    default:
      return 0;
  }
}

_id_E3058EFBDB62A578() {
  switch (level.gametype) {
    case "arena":
      if(game["roundsPlayed"] % level.roundswitch == 1)
        return 1;

      return 0;
    default:
      return 0;
  }
}

timeuntilroundend() {
  if(level.gameended) {
    _id_3B5803E733581858 = (gettime() - level.gameendtime) / 1000;
    timeremaining = level.postroundtime - _id_3B5803E733581858;

    if(timeremaining < 0)
      return 0;

    return timeremaining;
  }

  if(scripts\mp\utility\game::gettimelimit() <= 0)
    return undefined;

  if(!isDefined(level.starttime))
    return undefined;

  _id_CDDE4978F529A4A9 = scripts\mp\utility\game::gettimelimit();
  _id_3B5803E733581858 = (gettime() - level.starttime) / 1000;
  timeremaining = level.discardtime / 1000 + scripts\mp\utility\game::gettimelimit() - _id_3B5803E733581858;

  if(isDefined(level.timepaused))
    timeremaining = timeremaining + level.timepaused;

  return timeremaining + level.postroundtime;
}

freegameplayhudelems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] scripts\mp\hud_util::destroyelem();
      self.perkname[0] scripts\mp\hud_util::destroyelem();
    }

    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] scripts\mp\hud_util::destroyelem();
      self.perkname[1] scripts\mp\hud_util::destroyelem();
    }

    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] scripts\mp\hud_util::destroyelem();
      self.perkname[2] scripts\mp\hud_util::destroyelem();
    }
  }

  self notify("perks_hidden");

  if(!level.doeomcombat) {
    self.lowermessage scripts\mp\hud_util::destroyelem();
    self.lowertimer scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.proxbar))
    self.proxbar scripts\mp\hud_util::destroyelem();

  if(isDefined(self.proxbartext))
    self.proxbartext scripts\mp\hud_util::destroyelem();
}

gethostplayer() {
  players = getEntArray("player", "classname");

  for(index = 0; index < players.size; index++) {
    if(players[index] ishost())
      return players[index];
  }
}

_id_8464FD951B451534() {
  foreach(player in level.players) {
    if(!isbot(player))
      return 1;
  }

  return 0;
}

hostidledout() {
  _id_9D709D44ADD4A33A = gethostplayer();

  if(isDefined(_id_9D709D44ADD4A33A) && !_id_9D709D44ADD4A33A.hasspawned && !isDefined(_id_9D709D44ADD4A33A.selectedclass))
    return 1;

  return 0;
}

roundendwait(_id_5EF4D54BB701E295) {
  if(!level.doeomcombat) {
    wait(level.postgamehitmarkerwaittime + 0.1);
    setomnvarforallclients("post_game_state", 2);
  }

  _id_8D539C1577794D34 = 0;

  foreach(player in level.players) {
    player thread scripts\mp\utility\game::setuipostgamefade(0);

    if(player _meth_8420670EAFC8D391())
      _id_8D539C1577794D34 = level._id_7210BB7B0BFBCFDB;
  }

  wait(_id_5EF4D54BB701E295);
  wait(_id_8D539C1577794D34);
  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

roundenddof(time) {
  scripts\mp\utility\player::setdof_spectator();
}

setwaypointiconinfo(name, _id_96D1603BEEEFA4EA, _id_673B3CDBD1F53958, string, icon, _id_B50E35D9C370899B, _id_A3EC0E7732B1EDF1) {
  level.waypointcolors[name] = _id_673B3CDBD1F53958;
  level.waypointbgtype[name] = _id_96D1603BEEEFA4EA;
  level.waypointstring[name] = string;
  level.waypointshader[name] = icon;
  level.waypointpulses[name] = _id_B50E35D9C370899B;
  level._id_ED9ACFB4A79FB6BE[name] = _id_A3EC0E7732B1EDF1;
}

initwaypointbackgrounds() {
  _id_A443300A7CC92EF0 = 0;

  switch (scripts\mp\utility\game::getgametype()) {
    case "trial":
    case "pill":
    case "mtmc":
    case "bigctf":
    case "conflict":
    case "siege":
    case "dom":
    case "control":
    case "arm":
      setwaypointiconinfo("icon_waypoint_dom_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("icon_waypoint_dom_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("icon_waypoint_dom_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("icon_waypoint_dom_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_taking_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_taking_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_taking_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_taking_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_taking_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_taking_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_taking_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_taking_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_taking_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_capture_a", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_capture_b", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_capture_c", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_capture_d", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_capture_e", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_capture_f", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_capture_g", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_capture_h", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_capture_i", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_defend_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defend_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defend_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defend_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defend_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defend_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defend_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_defend_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_defend_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_defending_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defending_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defending_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defending_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defending_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defending_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defending_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_defending_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_defending_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_blocking_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_blocking_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_blocking_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_blocking_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_blocked_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_blocked_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_blocked_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_losing_a", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_losing_b", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_losing_c", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_losing_d", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_losing_e", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_losing_f", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_losing_g", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_losing_h", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_losing_i", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_captureneutral_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_captureneutral_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_captureneutral_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_captureneutral_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_contested_a", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_contested_b", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_contested_c", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_contested_d", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_contested_e", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_contested_f", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_contested_g", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_contested_h", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_contested_i", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_dom_target_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_dom_target_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_dom_target_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_dom_target_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_clearing_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_clearing_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_clearing_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_clearing_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_reinforcing_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_reinforcing_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_reinforcing_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_locked_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 3);
      setwaypointiconinfo("waypoint_locked_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 5);
      setwaypointiconinfo("waypoint_locked_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 7);
      setwaypointiconinfo("waypoint_locked_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_captured", _id_A443300A7CC92EF0, "codcaster", "", "esports_codcaster_minimap_checkmark", 0, 11);
      break;
    case "dd":
    case "sd":
      setwaypointiconinfo("waypoint_bomb", 2, "friendly", "MP_INGAME_ONLY/OBJ_BOMB_CAPS", "icon_waypoint_bomb", 1, 15);
      setwaypointiconinfo("icon_waypoint_escort_bomb", 2, "neutral", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_bomb", 0, 10);
      setwaypointiconinfo("codcaster_enemy_escort_bomb", 1, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_bomb", 0, 10);
      setwaypointiconinfo("waypoint_target_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_target_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_bomb_defusing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_bomb_defusing_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_b", 0, 6);
      setwaypointiconinfo("waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 4);
      setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 6);
      setwaypointiconinfo("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 4);
      setwaypointiconinfo("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 6);
      setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defend_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, 8);
      setwaypointiconinfo("waypoint_defend_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, 9);
      setwaypointiconinfo("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0, 4);
      setwaypointiconinfo("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0, 6);
      setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0, 4);
      setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0, 6);
      break;
    case "gwbomb":
      setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_defend_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defend_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defend_f", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_target_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_target_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_target_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_target_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_target_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_target_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_f", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_c", 0, "enemy", "", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_d", 0, "enemy", "", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_e", 0, "enemy", "", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_f", 0, "enemy", "", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_c", 0, "friendly", "", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_d", 0, "friendly", "", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_e", 0, "friendly", "", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_f", 0, "friendly", "", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_locked_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_locked_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_locked_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_locked_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_locked_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_locked_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_f", 0, undefined);
      break;
    case "btm":
    case "gwai":
    case "hq":
      setwaypointiconinfo("hq_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_DESTROY_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2);
      setwaypointiconinfo("hq_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_hq", 0, 1);
    case "gwtdm":
      setwaypointiconinfo("carepackage_incoming", 1, "neutral", "MP_INGAME_ONLY/INCOMING_OBJ_CAPS", "hud_icon_killstreak_carepackage", 0, undefined);
      setwaypointiconinfo("carepackage", 1, "neutral", "", "hud_icon_killstreak_carepackage", 0, undefined);
      break;
    default:
      break;
  }

  setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", _id_1CEA1B70A5AAD392::_id_BB30BF75EAFD434C(), 0, 15);
  setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", _id_1CEA1B70A5AAD392::_id_BB30BF75EAFD434C(), 0, 15);
  setwaypointiconinfo("icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, undefined);
  setwaypointiconinfo("waypoint_capture_kill", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined);
  setwaypointiconinfo("waypoint_escort", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort", 0, undefined);
}

_id_1765528A2562EBF8(_id_74D54B1C99B011DB) {
  if(isDefined(_id_74D54B1C99B011DB)) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      _id_7676221CCA996819 = player getentitynumber();
      _id_B0435C622CE575D5 = player;

      if(_id_7676221CCA996819 == _id_74D54B1C99B011DB) {
        _id_BAB0D10E51188531 = scripts\mp\utility\teams::getteamdata(player.team, "players");

        if(player issplitscreenplayer() && !player issplitscreenplayerprimary())
          _id_B0435C622CE575D5 = player getothersplitscreenplayer();

        if(isDefined(_id_B0435C622CE575D5._id_A111E3EABE27D512))
          _id_B0435C622CE575D5._id_A111E3EABE27D512 = !_id_B0435C622CE575D5._id_A111E3EABE27D512;
        else
          _id_B0435C622CE575D5._id_A111E3EABE27D512 = 1;

        _id_68E089F99ECB68B9 = scripts\mp\utility\teams::getteamdata(player.team, "playagainHostXuid");
        _id_CCF0A6B6BA756356 = _id_B0435C622CE575D5 getxuid();

        if(_id_B0435C622CE575D5._id_A111E3EABE27D512) {
          if(_id_68E089F99ECB68B9 == "0")
            scripts\mp\utility\teams::setteamdata(player.team, "playagainHostXuid", _id_CCF0A6B6BA756356);
        } else if(_id_68E089F99ECB68B9 == _id_CCF0A6B6BA756356) {
          _id_F7795A328AC962D5 = "0";

          foreach(_id_F0EA4030349A33D5 in _id_BAB0D10E51188531) {
            if(isDefined(_id_F0EA4030349A33D5) && !isbot(_id_F0EA4030349A33D5) && _id_F0EA4030349A33D5 issplitscreenplayerprimary()) {
              _id_F7795A328AC962D5 = _id_F0EA4030349A33D5 getxuid();
              break;
            }
          }

          scripts\mp\utility\teams::setteamdata(player.team, "playagainHostXuid", _id_F7795A328AC962D5);
        }

        if(istrue(scripts\mp\utility\game::matchmakinggame())) {
          if(isDefined(player) && player isfireteamleader()) {
            _id_8015767BDDC80D67 = player getfireteammembers();

            foreach(_id_80EF668C09FFB70F in _id_8015767BDDC80D67) {
              if(!isDefined(_id_80EF668C09FFB70F)) {
                continue;
              }
              _id_CA55D7EFEBC143E0 = _id_80EF668C09FFB70F getentitynumber();

              if(_id_CA55D7EFEBC143E0 != _id_7676221CCA996819) {
                if(isDefined(_id_80EF668C09FFB70F._id_A111E3EABE27D512))
                  _id_80EF668C09FFB70F._id_A111E3EABE27D512 = !_id_80EF668C09FFB70F._id_A111E3EABE27D512;
                else
                  _id_80EF668C09FFB70F._id_A111E3EABE27D512 = 1;

                foreach(_id_F0EA4030349A33D5 in _id_BAB0D10E51188531) {
                  if(isDefined(_id_F0EA4030349A33D5)) {}
                }
              }
            }
          }
        }

        break;
      }
    }
  }

  return;
}

_id_C3365E6CF89ADA44() {
  _id_F9C8FADCB7DACF3A = 0;

  if(!scripts\mp\utility\game::privatematch() && !_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    _id_2FD13845453E50E8 = [];

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(player._id_A111E3EABE27D512) && player._id_A111E3EABE27D512) {
        playerteam = player.team;
        _id_FF74EEB3AEA4D0BE = 0;
        _id_DA0ACA95052AD7D2 = _id_2FD13845453E50E8.size;

        for(index = 0; index < _id_DA0ACA95052AD7D2; index++) {
          if(_id_2FD13845453E50E8[index] == playerteam)
            _id_FF74EEB3AEA4D0BE = 1;
        }

        if(!_id_FF74EEB3AEA4D0BE) {
          _id_2FD13845453E50E8[_id_DA0ACA95052AD7D2] = playerteam;
          _id_5A9CFC3686B1FD8D = scripts\mp\utility\teams::getteamdata(playerteam, "players");
          _id_6D13F1BF72D13931 = [];
          _id_820358930FA25F8D = scripts\mp\utility\teams::getteamdata(playerteam, "playagainHostXuid");

          foreach(player in _id_5A9CFC3686B1FD8D) {
            if(!isDefined(player)) {
              continue;
            }
            if(isDefined(player._id_A111E3EABE27D512) && player._id_A111E3EABE27D512)
              _id_6D13F1BF72D13931[_id_6D13F1BF72D13931.size] = player;
          }

          _func_C36E3161B08CC355(_id_6D13F1BF72D13931, _id_820358930FA25F8D);
          waitframe();
        }
      }
    }
  }
}

_id_B782E1EA0877F735() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  _id_920886B23146CDBF = 0;

  for(;;) {
    _id_5BF95B9AFFE746B3 = getdvarint("dvar_4F6750C34BE606EE");

    if(isDefined(level.players[0]))
      _id_920886B23146CDBF = level.players[0] getclientomnvar("ui_br_player_position");

    switch (_id_5BF95B9AFFE746B3) {
      case 1:
        if(_id_920886B23146CDBF != 1) {
          level.players[0] setclientomnvar("ui_br_player_position", 1);
          wait 8.0;
          level.players[0] setclientomnvar("ui_br_player_position", 150);
        }

        break;
      case 2:
        if(_id_920886B23146CDBF != 4) {
          level.players[0] setclientomnvar("ui_br_player_position", 4);
          wait 8.0;
          level.players[0] setclientomnvar("ui_br_player_position", 5);
        }

        break;
      case 3:
        if(_id_920886B23146CDBF != 22) {
          level.players[0] setclientomnvar("ui_br_player_position", 22);
          wait 8.0;
          level.players[0] setclientomnvar("ui_br_player_position", 150);
        }

        break;
      case 4:
        if(_id_920886B23146CDBF != 15) {
          level.players[0] setclientomnvar("ui_br_player_position", 15);
          wait 8.0;
          level.players[0] setclientomnvar("ui_br_player_position", 150);
        }

        break;
      default:
        break;
    }

    waitframe();
  }
}

callback_startgametype() {
  scripts\mp\load::main();

  if(!isDefined(game["roundsPlayed"])) {
    if(analyticsstreamerislogfilestreamingenabled())
      analyticsstreamerlogfilestartstream();

    game["matchHasMoreThan1Player"] = 0;
    game["numPlayersConsideredPlaying"] = 0;
  }

  scripts\mp\flags::gameflaginit("prematch_done", 0);
  scripts\mp\flags::gameflaginit("prematch_fade_done", 0);
  scripts\mp\flags::gameflaginit("prematch_countdown", 0);
  scripts\mp\flags::gameflaginit("graceperiod_done", 0);
  scripts\mp\flags::gameflaginit("prematch_values_reset", 0);
  scripts\mp\flags::gameflaginit("infil_setup_complete", 0);
  scripts\mp\flags::gameflaginit("infil_will_run", 0);
  scripts\mp\flags::gameflaginit("infil_started", 0);
  scripts\mp\flags::gameflaginit("infil_animatic_complete", 0);
  scripts\mp\flags::gameflaginit("overtime_started", 0);
  scripts\mp\flags::levelflaginit("round_over", 0);
  scripts\mp\flags::levelflaginit("game_over", 0);
  scripts\mp\flags::levelflaginit("block_notifies", 0);
  scripts\mp\flags::levelflaginit("post_game_level_event_active", 0);
  scripts\mp\flags::levelflaginit("final_killcam_preloaded", 0);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
  level.postgamenotifies = 0;
  level.intermission = 0;
  level._id_7210BB7B0BFBCFDB = getdvarfloat("dvar_CBA7D6083C9553B8");
  setDvar("bg_compassShowEnemies", getdvarint("scr_game_forceuav") == 1);
  setDvar("bg_bulletsUseMaxDamageMinRange", istrue(level.noweaponfalloff));
  setDvar("bg_piggybackArmorOnNVG", istrue(level.armoronweaponswitchlongpress));
  setDvar("dvar_C23516DD70102AA8", 0);
  setDvar("dvar_4F7E433CE6EACBE8", 0);

  if(scripts\mp\utility\game::matchmakinggame())
    setDvar("ismatchmakinggame", 1);
  else
    setDvar("ismatchmakinggame", 0);

  level thread initwaypointbackgrounds();

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    game["truncated_killcams"] = 0;
    game["life_count"] = 0;

    if(!isDefined(game["attackers"]) || !isDefined(game["defenders"]))
      thread scripts\engine\utility::error("No attackers or defenders team defined in level .gsc.");

    if(!isDefined(game["attackers"]))
      game["attackers"] = "allies";

    if(!isDefined(game["defenders"]))
      game["defenders"] = "axis";

    if(!isDefined(game["state"]))
      game["state"] = "playing";

    game["strings"]["press_to_spawn"] = &"MP/PRESS_TO_SPAWN";
    game["strings"]["spawn_next_round"] = &"MP/SPAWN_NEXT_ROUND";
    game["strings"]["spawn_flag_wait"] = &"MP/SPAWN_FLAG_WAIT";
    game["strings"]["spawn_point_capture_wait"] = &"MP/SPAWN_POINT_CAPTURE_WAIT";
    game["strings"]["spawn_revive_wait"] = &"MP/SPAWN_REVIVE_WAIT";
    game["strings"]["spawn_revive_wait_bleedout"] = &"MP/SPAWN_REVIVE_WAIT_BLEEDOUT";
    game["strings"]["spawn_revive_remote"] = &"MP/SPAWN_REVIVE_REMOTE";
    game["strings"]["spawn_tag_wait"] = &"MP/SPAWN_TAG_WAIT";
    game["strings"]["waiting_to_spawn"] = &"MP/WAITING_TO_SPAWN";
    game["strings"]["next_team_spawn"] = &"MP/NEXT_TEAM_SPAWN";
    game["strings"]["match_starting"] = &"MP/MATCH_STARTING";
    game["strings"]["change_class"] = &"MP/CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["revive_class"] = &"MP/CHANGE_CLASS_NEXT_ROUND";
    game["strings"]["change_rig"] = &"LUA_MENU_MP/CHANGE_RIG_NEXT_SPAWN";
    game["strings"]["must_select_loadout_to_spawn"] = &"MP_INGAME_ONLY/SELECT_LOADOUT_TO_SPAWN";
    game["strings"]["select_spawn"] = &"MP/SELECT_SPAWN";
    game["strings"]["down_give_up"] = &"MP/DOWN_GIVE_UP";
    level scripts\mp\utility\lower_message::_id_05A98C45A6252B4A();
    game["colors"]["black"] = (0, 0, 0);
    game["colors"]["white"] = (1, 1, 1);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);
    game["colors"]["orange"] = (0.9, 0.6, 0);
    game["colors"]["blue"] = (0.2, 0.3, 0.7);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0);
    game["colors"]["friendly"] = (0.258824, 0.639216, 0.87451);
    game["colors"]["enemy"] = (0.929412, 0.231373, 0.141176);
    game["colors"]["contest"] = (1, 0.858824, 0);
    game["colors"]["neutral"] = (1, 1, 1);
    [[level.onprecachegametype]]();
    setdvarifuninitialized("min_wait_for_players", 5);

    if(!level.splitscreen) {
      level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
      level.prematchperiodend = getdvarint("scr_game_matchstarttime", 15);
    }

    if(_func_1EB7D2791D3C536F()) {
      setnojipscore(1, 1);
      setnojiptime(1, 1);
    } else {
      setnojipscore(0, 1);
      setnojiptime(0, 1);
    }
  } else {
    setdvarifuninitialized("min_wait_for_players", 5);

    if(!level.splitscreen) {
      scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
      level.prematchperiodend = getdvarint("scr_game_roundstarttime", 5);
    }
  }

  if(!isDefined(game["allies"]))
    game["allies"] = "SAS";

  if(!isDefined(game["axis"]))
    game["axis"] = "RUSF";

  if(!isDefined(game["team_three"]))
    game["team_three"] = "USMC";

  if(!isDefined(game["team_four"]))
    game["team_four"] = "ZVIR";

  if(!isDefined(game["team_five"]))
    game["team_five"] = "ICORPS";

  if(!isDefined(game["team_six"]))
    game["team_six"] = "GRP9";

  if(!isDefined(game["status"]))
    game["status"] = "normal";

  setDvar("ui_overtime", scripts\mp\utility\game::inovertime());

  if(!isDefined(game["timePassed"]))
    game["timePassed"] = 0;

  if(!isDefined(game["roundsPlayed"]))
    game["roundsPlayed"] = 0;

  if(!isDefined(game["overtimeRoundsPlayed"]))
    game["overtimeRoundsPlayed"] = 0;

  if(!isDefined(game["matchPoint"]))
    game["matchPoint"] = 0;

  if(!isDefined(game["finalRound"]))
    game["finalRound"] = 0;

  if(!isDefined(game["previousWinningTeam"]))
    game["previousWinningTeam"] = "";

  setomnvar("ui_last_round", game["finalRound"]);

  if(!isDefined(game["roundsWon"]))
    game["roundsWon"] = [];

  if(!isDefined(game["teamScores"]))
    game["teamScores"] = [];

  if(!isDefined(game["timeToBeat"]))
    game["timeToBeat"] = 0;

  if(!isDefined(game["timeToBeatOld"]))
    game["timeToBeatOld"] = 0;

  if(!isDefined(game["timeToBeatTeam"]))
    game["timeToBeatTeam"] = "none";

  if(!isDefined(game["timeToBeatScore"]))
    game["timeToBeatScore"] = 0;

  if(!isDefined(game["timeToBeatScoreOld"]))
    game["timeToBeatScoreOld"] = 0;

  level.currentclientmatchdataid = 0;
  level.gameended = 0;
  level.forcedend = 0;
  level.hostforcedend = 0;
  setdvarifuninitialized("dvar_B66208719C6BAE6A", 0);
  setdvarifuninitialized("dvar_E32EBDBB97A1EC4E", 0);
  level.disablepersonalnuke = scripts\mp\utility\game::isanymlgmatch();

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    logstring("game modifier: tier 1 mode");
  else if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    logstring("game modifier: hardcore mode");

  level._id_DC65C33DFDD9EFE8 = getdvarint("scr_thirdperson");
  level.diehardmode = getdvarint("scr_diehard");
  level.casualscorestreaks = getdvarint("scr_game_casualScoreStreaks");
  level._id_7DFAD9748480C388 = getdvarint("dvar_614165A37AC2DB61");

  if(!isDefined(level.crankedbombtimer))
    level.crankedbombtimer = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_crankedBombTimer"), 0);

  level.supportcranked = scripts\engine\utility::ter_op(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_crankedBombTimer")) > 0, 1, 0);

  if(!level.teambased)
    level.diehardmode = 0;

  if(level.diehardmode)
    logstring("game mode: diehard");

  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_vampirism"), "scr_game_vampirism");

  if(level.matchrules_vampirism)
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;

  level.finalkillcamtype = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_killcamType"), "scr_game_killcamType");

  if(level.finalkillcamtype == 2)
    level.skipfinalkillcam = 1;

  if(level.finalkillcamtype == 1 && getdvarint("dvar_6625C2CB0DE90A41", 0) == 0)
    level.finalkillcamtype = 0;

  level.allowkillstreaks = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_allowKillstreaks"), "scr_game_allowkillstreaks");
  level.roundretainstreaks = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_roundRetainStreaks"), "scr_game_roundRetainStreaks");
  level.roundretainstreakprog = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_roundRetainStreakProg"), "scr_game_roundRetainStreakProg");
  level.deathretainstreaks = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_deathRetainStreaks"), "scr_game_deathRetainStreaks");
  level.allowperks = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_allowPerks"), "scr_game_allowperks");
  level.allowsupers = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_allowSupers"), "scr_game_allowsupers");
  level.superfastchargerate = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_superFastChargeRate"), "scr_game_superFastChargeRate");
  level.superpointsmod = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_superPointsMod"), "scr_game_superPointsMod");
  level.spawnprotectiontimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_spawnProtectionTimer"), "scr_game_spawnprotectiontimer");
  level.lethaldelay = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_lethalDelay"), "scr_game_lethalDelay");
  level.equipmentmatchstartshieldms = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_equipmentMSProtect"), "scr_game_equipmentMSProtect") * 1000;
  level.magcount = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_magcount"), "scr_game_magcount");

  if(!isDefined(level.practiceround))
    level.practiceround = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_practiceRound"), "scr_game_practiceRound");

  level.postgameexfil = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_postGameExfil"), "dvar_D2DE59939486BD5A");
  level.exfilactivetimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_exfilActiveTimer"), "dvar_645019BC959FFAF9");
  level.exfilextracttimer = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_exfilExtractTimer"), "dvar_96DD663F32DBA868");
  level.useammorestocklocs = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_useAmmoRestockLocs"), "scr_game_useAmmoRestockLocs");
  level._id_0F1F253AEE175FF4 = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_agent_kills_killstreak_count"), "dvar_46EAAD837C804540");
  level.spectate3rdallowed = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_allow3rdspectate"), "scr_game_allow3rdspectate");
  setDvar("camera_allow3rdspectate", level.spectate3rdallowed);
  level._id_7EBAD80A50484A39 = getdvarint("dvar_8D427BCE0148AF0E", 0);
  scripts\mp\teamrevive::init();

  if(scripts\mp\utility\game::issubgametype())
    checkforsubgametypeoverrides();

  level.minimaponbydefault = (getdvarint("scr_game_enableMinimap") != 0 || getdvarint("dvar_BC802DEB1FF2A842") != 0) && !istrue(game["isLaunchChunk"]) && !scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19();
  _id_074E69087B1755CC = scripts\mp\utility\game::getgametype();
  level.radarhideshots = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", _id_074E69087B1755CC, "_radarHidePings"), "scr_game_radarHidePings");
  setomnvar("ui_compass_hide_weapon_pings_minimap", level.radarhideshots);
  level.navbarhideshots = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", _id_074E69087B1755CC, "_navBarHidePings"), "scr_game_navBarHidePings");
  setomnvar("ui_compass_hide_weapon_pings_navbar", level.navbarhideshots);
  level.navbarhideenemies = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", _id_074E69087B1755CC, "_navBarHideEnemy"), "scr_game_navBarHideEnemy");
  setomnvar("ui_compass_hide_enemy_navbar", level.navbarhideenemies);
  level.disablesupersprint = getdvarint("scr_player_disableSuperSprint");
  level.disablemount = getdvarint("scr_player_disableMount");
  level.disablebattlechatter = getdvarint("scr_game_disableBattleChatter");
  level.disableannouncer = getdvarint("scr_game_disableAnnouncer");
  level.scoremod = [];
  level.scoremod["kill"] = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsPerKill"));
  level.scoremod["death"] = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsPerDeath"));
  level.scoremod["headshot"] = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsHeadshotBonus"));
  level.scoremod["kskill"] = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_pointsPerKSKill"));

  if(level.practiceround && !isDefined(game["practiceRound"])) {
    game["practiceRound"] = 1;
    level.roundretainstreaks = 0;
    level.roundretainstreakprog = 0;
    level.ignorescoring = 1;
    game["dialog"]["offense_obj"] = "gamestate_practice";
    game["dialog"]["defense_obj"] = "gamestate_practice";
  }

  if(!isDefined(game["gameLength"]))
    game["gameLength"] = 0;

  if(getdvarint("dvar_AC31997B109B6BC5", 0) == 1) {
    game["attackers"] = "axis";
    game["defenders"] = "allies";
  }

  setomnvar("ui_match_timer_hidden", 1);
  isarenamap = scripts\cp_mp\utility\game_utility::isarenamap();

  if(isarenamap) {
    level.allowkillstreaks = 0;
    level.allowsupers = 0;
    setomnvar("ui_disable_killstreaks", 1);
    setomnvar("ui_disable_fieldupgrades", 1);
  } else {
    setomnvar("ui_disable_killstreaks", 0);
    setomnvar("ui_disable_fieldupgrades", 0);
  }

  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  scripts\cp_mp\utility\game_utility::getlocaleid();
  level.usestartspawns = 1;
  level thread scripts\mp\infilexfil\infilexfil::infil_init();
  scripts\mp\utility\spawn_event_aggregator::init();
  scripts\mp\utility\lui_game_event_aggregator::init();
  _id_451A1A9BD9613164::init();
  scripts\mp\utility\player_frame_update_aggregator::init();
  _id_436ADD9DE781CDFB::init();
  _id_15DE7DC4D21F1DA3::init();
  scripts\cp_mp\ent_manager::init();
  scripts\mp\playerlogic::init();
  scripts\cp_mp\utility\game_utility::initchallengeandeventglobals();
  gametype = scripts\mp\utility\game::getgametype();
  level._id_6706AAD138CBC31D = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_ffPunishDamageLimit"), "dvar_03B51BF9ADF9C599");
  level._id_843399BEE19793FE = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_ffKickDamageLimit"), "dvar_BD496F8D66908CB0");
  level.maxallowedteamkills = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_ffPunishLimit"), "scr_game_ffpunishlimit");
  thread scripts\mp\init_cp_mp::init();
  thread scripts\mp\teams::init();
  _id_554B8EE714D13AFB::_id_A92ED2F4C44E5FFA();
  _id_76CC264B397DB9CB::init();
  scripts\cp_mp\utility\player_utility::initdismembermentlist();
  _id_3B64EB40368C1450::_id_20EB90F5B8963388();
  scripts\cp_mp\utility\game_utility::_id_EA9801BFF6CCF12A();
  thread scripts\cp_mp\utility\shellshock_utility::shellshock_utility_init();
  thread scripts\cp_mp\utility\game_utility::game_utility_init();
  thread _id_65A96EA484CF876D::init();
  thread scripts\mp\killcam::init();
  thread scripts\mp\final_killcam::initfinalkillcam();
  thread scripts\cp_mp\challenges::init();
  _id_0CBB0697DE4C5728::_id_3B59B4D385A202E6();
  scripts\mp\utility\dialog::initstatusdialog();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    thread scripts\mp\battlechatter_mp::init();
  else if(!scripts\mp\utility\game::runleanthreadmode())
    thread scripts\mp\battlechatter_mp::init();
  else
    level.battlechatterenabled = 0;

  thread scripts\mp\music_and_dialog::init();
  thread scripts\mp\class::init();

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread scripts\mp\persistence::init();

  thread scripts\mp\rank::init();
  thread scripts\mp\playercards::init();
  thread scripts\mp\menus::init();
  thread scripts\mp\hud::init();
  thread scripts\mp\serversettings::init();
  thread scripts\mp\weapons::init();
  thread scripts\mp\outline::init();
  thread scripts\mp\shellshock::init();
  thread scripts\mp\deathicons::init();
  thread _id_5762AC2F22202BA2::_id_6B5E33C2F005F4A6();
  thread scripts\mp\lightarmor::init();
  thread scripts\mp\gameobjects::init();
  thread scripts\mp\spectating::init();
  thread scripts\mp\spawnlogic::init();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    thread scripts\mp\brmatchdata::init();
    thread scripts\mp\brclientmatchdata::init();
  } else {
    thread scripts\mp\matchdata::init();
    thread scripts\mp\clientmatchdata::init();
  }

  thread scripts\mp\awards::init();
  thread scripts\mp\utility\points::_id_8E9B2E8BA0328E3C();
  thread scripts\mp\playerlogic::initsegmentstats();

  if(!scripts\mp\utility\game::runleanthreadmode())
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(scripts\cp_mp\utility\player_utility::updateinputtypewatcher);

  scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(scripts\mp\weapons::grenadehealthatdeathframeupdatecallback);
  _id_04CDABCD91A92977::main();

  if(level._id_EC2FB549B15AD827)
    _id_629A97C763E17711::init();

  if(level._id_77907D733ABE8B63)
    _id_697B7AE06BA9B28C::init();

  thread scripts\mp\passives::init();
  thread scripts\mp\perks\perks::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
    thread _id_4BAC13D511590220::_id_7DCAD89B9C0264A6();
    thread scripts\cp_mp\killstreaks\init::init();
    thread scripts\mp\perks\perks::initspecialistkillstreaks();
  }

  thread scripts\mp\events::_id_6E80B5DDDED67C23();
  thread scripts\mp\archetypes\archcommon::init();

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_509A21C5F4CEA6AE::init();

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread scripts\mp\whizby::init();

  thread _id_4192352A88553D67::init();
  thread scripts\mp\analyticslog::init();
  thread _id_45F403E1732217D3::init();
  thread _id_180407B61054C278::init();
  thread _id_0404F1AEF8AEA990::init();
  level _id_07C40FA80892A721::init();

  if(!istrue(game["isLaunchChunk"])) {
    if(istrue(level._id_36304CC9071BF738))
      thread _id_600B944A95C3A7BF::init();

    thread scripts\mp\loot::init();
    thread scripts\mp\supers::init();
    thread scripts\mp\supers::watchsuperdelay();
  }

  thread scripts\mp\callouts::init();
  thread scripts\mp\bounty::init();
  thread allow_weapon_mp_init();
  thread ismp_init();
  level.players thread _id_B782E1EA0877F735();
  thread scripts\cp_mp\gestures::init();
  thread scripts\mp\gestures_mp::init_mp();
  thread scripts\cp_mp\execution::execution_init();
  thread scripts\mp\sentientpoolmanager::init();
  thread scripts\mp\objidpoolmanager::init();
  thread scripts\mp\arbitrary_up::initarbitraryuptriggers();

  if(!istrue(game["isLaunchChunk"]))
    thread scripts\mp\turret::init();

  thread _id_2B264B25C7DA0B12::init();
  thread scripts\mp\laststand::init();
  thread scripts\mp\equipment::init();
  thread scripts\mp\matchstats::init();
  thread scripts\mp\playerstats::init();

  if(getdvarint("dvar_81A618A6E6973ED3", 0) == 1)
    thread _id_1070BE3357C9454C::init();

  thread _id_6DEA01CBA2381958::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\cp_mp\auto_ascender::init();
    thread scripts\cp_mp\auto_ascender_solo::init();
    thread scripts\mp\outofbounds::initoob();
    thread scripts\cp_mp\targetmarkergroups::init();
  }

  thread scripts\mp\potg::init();
  thread scripts\mp\utility\trigger::triggerutilityinit();
  thread scripts\cp_mp\entityheadicons::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\mp\spawnselection::init();
    thread scripts\mp\spawncamera::init();
    thread scripts\mp\juggernaut::init();
    thread scripts\mp\door::door_dynamic_setup();
    thread scripts\mp\flashpoint::init();
    thread scripts\cp_mp\emp_debuff::emp_debuff_init();
  }

  thread scripts\mp\hud_message::init();
  thread _id_3FA1BF21E3FC7B80::init();
  level.allowreviveweapons = getdvarint("dvar_DF1AE5A11F519AB5", 0);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("reviveShoot", ["weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("gameEndFreeze", ["usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "stance_change", "melee"]);
  thread scripts\mp\accolades::init();
  thread scripts\mp\ammorestock::init();

  if(getdvarint("dvar_8A1945C94D5092C2") == 1) {
    _id_7E52B56769FA7774::br_pickups_init();
    _id_6AFF3948CF4CCA03::init();
  }

  level _id_1F97A44D1761C919::init();
  level scripts\mp\bots\bots_loadout::init();
  level _id_44B8991C2B01716A::init();

  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(!isDefined(game["roundsWon"][team]))
        game["roundsWon"][team] = 0;

      if(!isDefined(game["teamScores"][team]))
        game["teamScores"][team] = 0;
    }
  }

  if(game["status"] != "overtime" && game["status"] != "halftime") {
    if(!(game["roundsPlayed"] > 0 && scripts\mp\utility\game::ismoddedroundgame())) {
      game["teamScores"]["allies"] = 0;
      game["teamScores"]["axis"] = 0;
    }
  }

  setomnvar("ui_in_overtime_round", game["status"] == "overtime");
  game["gamestarted"] = 1;
  level.currentround = game["roundsPlayed"] + 1;
  level.maxplayercount = 0;
  level.activeplayers = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    level.wavedelay[_id_F90358454413407F] = 0;
    level.lastwave[_id_F90358454413407F] = 0;
    level.waveplayerspawnindex[_id_F90358454413407F] = 0;
    level.aliveplayers[_id_F90358454413407F] = [];

    if(!istrue(level.requiredplayercountoveride))
      level.requiredplayercount[_id_F90358454413407F] = 0;
  }

  setomnvar("ui_scorelimit", 0);
  setDvar("ui_allow_teamchange", 1);

  if(!istrue(game["isLaunchChunk"])) {
    setomnvar("ui_round_hint_override_attackers", 0);
    setomnvar("ui_round_hint_override_defenders", 0);
  }

  if(scripts\mp\utility\game::getgametypenumlives())
    setDvar("g_deadChat", 0);
  else
    setDvar("g_deadChat", 1);

  updatewavespawndelay();
  level.graceperiod = 15;
  level.ingraceperiod = level.graceperiod;

  if(!isDefined(level.roundenddelay))
    level.roundenddelay = 6;

  level.playovertime = 0;
  level.finalroundenddelay = 3;
  level.halftimeroundenddelay = 3;
  level.postgamehitmarkerwaittime = 0.25;
  level.scorelimit = scripts\mp\utility\dvars::getwatcheddvar("scorelimit");
  level.roundlimit = scripts\mp\utility\dvars::getwatcheddvar("roundlimit");
  level.winlimit = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

  if(istrue(game["isLaunchChunk"]))
    setomnvar("ui_current_round", level.currentround);
  else if(level.roundlimit != 1)
    setomnvar("ui_current_round", level.currentround);

  if(level.scorelimit == 1) {
    level.roundscorelimit = 1;
    level.totalscorelimit = level.winlimit;
  } else {
    level.roundscorelimit = level.scorelimit * (game["roundsPlayed"] + 1);
    level.totalscorelimit = level.scorelimit * level.roundlimit;
  }

  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 1)
    _id_60DD02BEC5783ECD::_id_BC001C2EBD383FFF();

  if(scripts\mp\utility\game::resetscoreonroundstart()) {
    level.roundscorelimit = level.scorelimit;
    level.totalscorelimit = level.scorelimit;
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
  }

  if(scripts\mp\utility\game::isovertimesupportedgametype() && scripts\mp\utility\game::inovertime())
    scripts\mp\gamescore::updateovertimescore();

  if(level.teambased) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\gamescore::updateteamscore(_id_F90358454413407F);
  }

  thread updateuiscorelimit();
  level notify("update_scorelimit");

  if(isDefined(level.matchrecording_init))
    level thread[[level.matchrecording_init]]();

  if(getdvarint("scr_allow_custom_loadouts", 0) == 0 || scripts\mp\utility\game::_id_1E098780C33853F2())
    setomnvar("ui_only_default_loadouts", 1);

  _id_0FD32F08E72B657F::_id_3149B2E03CE13DD9();
  [[level.onstartgametype]]();
  level scripts\engine\utility::flag_set("onStartGameTypeFinished");

  if(isDefined(level._id_0952BD6E10104D8A)) {
    if(getdvarint("dvar_7A6C6EE4D8DB3BBD", 0) == 0)
      [[level._id_0952BD6E10104D8A]]();
  }

  _id_75092AD1FF9DA748();
  level thread _id_0FD32F08E72B657F::onplayerconnectcommon();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(_id_0FD32F08E72B657F::onplayerdisconnectcommon);
  level.scorepercentagecutoff = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_score_percentage_cut_off"), 70);
  level.timepercentagecutoff = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_time_percentage_cut_off"), 70);
  level thread _id_285752B1F53ED9F1::_id_9030FF462F3DAA1A();

  if(getDvar("dvar_08588CA386DBFF67") == "dedicated LAN server" || getDvar("dvar_08588CA386DBFF67") == "dedicated internet server")
    thread verifydedicatedconfiguration();

  _id_548072087C9FD504::_id_6FC852802774B304(0, 0);
  thread startgame();
  level thread scripts\mp\utility\dvars::updatewatcheddvars();

  if(!istrue(level.istacops))
    level thread timelimitthread();

  level thread updateleaderboardstatscontinuous();
  level thread removepatchablecollision_delayed();
  level scripts\engine\utility::flag_set("StartGameTypeCallbackFinished");

  if(scripts\mp\utility\game::isfirstround())
    level thread _id_0236FB1C819BCD1F();
}

_id_0236FB1C819BCD1F() {
  if(getdvarint("dvar_830D682C147B23BB", 0) > 0)
    level waittill("telemetry_init");

  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_server_start");
}

updatewavespawndelay(_id_932972EBB2DFEF2B, _id_AB1E2D0BC30658B0) {
  if(isDefined(_id_932972EBB2DFEF2B))
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay"), _id_932972EBB2DFEF2B);

  if(isDefined(_id_AB1E2D0BC30658B0))
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay_alt"), _id_AB1E2D0BC30658B0);

  wavedelay = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay"));
  _id_4A995B19CB008113 = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay_alt"));

  if(wavedelay) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      level.wavedelay[_id_F90358454413407F] = wavedelay;
      level.lastwave[_id_F90358454413407F] = 0;
    }

    level thread wavespawntimer();
  }
}

verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!getdvarint("xblive_privatematch"))
      exitlevel(0);

    if(getDvar("dvar_08588CA386DBFF67") != "dedicated LAN server" && getDvar("dvar_08588CA386DBFF67") != "dedicated internet server")
      exitlevel(0);

    wait 5;
  }
}

timelimitthread() {
  level endon("game_ended");
  _id_F177BC3F3B9E94B1 = scripts\mp\utility\game::gettimepassed();

  while(game["state"] == "playing") {
    waittillframeend;
    thread checktimelimit(_id_F177BC3F3B9E94B1);
    _id_F177BC3F3B9E94B1 = scripts\mp\utility\game::gettimepassed();

    if(isDefined(level.starttime)) {
      if(gettimeremaining() < 3000 || istrue(level.forceotlogictorun)) {
        waitframe();
        continue;
      }
    }

    wait 1;
  }
}

updateuiscorelimit() {
  for(;;) {
    level scripts\engine\utility::waittill_either("update_scorelimit", "update_winlimit");

    if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        foreach(player in level.players) {
          player setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(player.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          player setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(player.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        foreach(player in level.players) {
          player setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(player.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          player setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(player.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::iswinbytworulegametype()) {
        _id_A7F1A64A712BC7CC = game["roundsWon"][game["defenders"]];
        _id_2A6A46646C25A5A8 = game["roundsWon"][game["attackers"]];
        _id_882B7AD682FF97CE = 0;

        if(_id_A7F1A64A712BC7CC == _id_2A6A46646C25A5A8)
          _id_882B7AD682FF97CE = _id_A7F1A64A712BC7CC + 2;
        else if(_id_A7F1A64A712BC7CC > _id_2A6A46646C25A5A8)
          _id_882B7AD682FF97CE = _id_A7F1A64A712BC7CC + 1;
        else
          _id_882B7AD682FF97CE = _id_2A6A46646C25A5A8 + 1;

        setomnvar("ui_scorelimit", _id_882B7AD682FF97CE);
      } else
        usenormalscorelimit();

      continue;
    }

    usenormalscorelimit();
  }
}

usenormalscorelimit() {
  if((!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) && scripts\mp\utility\game::getgametype() != "rescue" && scripts\mp\utility\game::getgametype() != "ballmode") {
    setomnvar("ui_scorelimit", level.totalscorelimit);
    thread checkscorelimit();
  } else
    setomnvar("ui_scorelimit", level.winlimit);
}

playtickingsound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  time = level.bombtimer;

  if(isDefined(level.defusetime))
    _id_E5C7562119F14DC3 = level.defusetime + 1;
  else
    _id_E5C7562119F14DC3 = 6;

  for(;;) {
    if(time > 15) {
      self playSound("ui_mp_suitcasebomb_timer");
      time = time - 1;
      wait 1;
    } else if(time > _id_E5C7562119F14DC3) {
      self playSound("ui_mp_suitcasebomb_timer_urgent");
      time = time - 1;
      wait 1;
    } else {
      self playSound("ui_mp_timer_countdown_half_sec");
      time = time - 0.5;
      wait 0.5;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

stoptickingsound() {
  self notify("stop_ticking");
}

getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139) {
  if(_id_8DD9F2EB8215A139 > 20)
    return "ui_mp_timer_countdown";
  else if(_id_8DD9F2EB8215A139 > 10)
    return "ui_mp_timer_countdown_10";
  else if(_id_8DD9F2EB8215A139 > 5)
    return "ui_mp_timer_countdown_half_sec";
  else if(_id_8DD9F2EB8215A139 > 1.5)
    return "ui_mp_timer_countdown_quarter_sec";
  else
    return "ui_mp_timer_countdown_1";
}

timelimitclock() {
  level endon("cancel_announcer_dialog");
  waitframe();

  if(scripts\mp\utility\game::gettimelimit() == 0) {
    return;
  }
  if(istrue(level._id_92B187A00D3DD091)) {
    return;
  }
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();
  _id_98F7893E84443025 = 0;
  _id_3117F65F501D4162 = 0;
  _id_DD0B8FE8F045AA9F = 0;
  _id_70E5D40612C9C78A = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["state"] == "playing") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit() && !istrue(level.bombsplanted) && !istrue(level._id_423B7147B1256ABD)) {
      _id_8DD9F2EB8215A139 = gettimeremaining() / 1000;
      _id_F8912399577F51CA = int(_id_8DD9F2EB8215A139 + 0.5);
      _id_A8088865FD3EFD6D = 0;

      if(_id_70E5D40612C9C78A == 2 && _id_F8912399577F51CA % 2 == 1)
        _id_A8088865FD3EFD6D = 1;

      if(!_id_98F7893E84443025 && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == 61 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_sixty");
        level notify("match_ending_soon", "time");
        _id_98F7893E84443025 = 1;
      } else if(!_id_3117F65F501D4162 && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == 31 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_thirty");
        level notify("match_ending_soon", "time");
        _id_3117F65F501D4162 = 1;
      } else if(!_id_DD0B8FE8F045AA9F) {
        if(_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == 11 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == 10) {
          level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_ten");
          _id_DD0B8FE8F045AA9F = 1;
        } else if(_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA <= 2 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA <= 1) {
          level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
          _id_DD0B8FE8F045AA9F = 1;
        }
      }

      if(_id_F8912399577F51CA <= 10 || _id_F8912399577F51CA <= 30 && _id_F8912399577F51CA % _id_70E5D40612C9C78A == _id_A8088865FD3EFD6D) {
        level notify("match_ending_very_soon");

        if(_id_F8912399577F51CA == 0) {
          break;
        }

        if(!isDefined(level.overridetimelimitclock) || level.overridetimelimitclock >= _id_F8912399577F51CA) {
          _id_14CCD6E81FCE3BD4 = getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139);
          _id_FC7BD6576D8C85BE playSound(_id_14CCD6E81FCE3BD4);
        }
      }

      if(_id_8DD9F2EB8215A139 - floor(_id_8DD9F2EB8215A139) >= 0.05) {
        wait(_id_8DD9F2EB8215A139 - floor(_id_8DD9F2EB8215A139));
        continue;
      }
    }

    wait 1.0;
  }
}

shouldmodelognotify() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "cyber":
    case "sd":
    case "arena":
      return 1;
    default:
      return 0;
  }
}

gametimer() {
  level endon("game_ended");

  if(isDefined(game["startTimeFromMatchStart"]))
    level.starttimefrommatchstart = game["startTimeFromMatchStart"];

  if(_func_03B6961B424A382F() && getdvarint("dvar_49BBEACAA2E89DEB", 0) != 0)
    level.discardtime = 0;

  level waittill("prematch_over");
  level.starttime = gettime();
  level.discardtime = 0;
  level.overtimetotal = 0;

  if(!isDefined(game["startTimeFromMatchStart"])) {
    game["startTimeFromMatchStart"] = gettime();
    level.starttimefrommatchstart = gettime();
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_match_start");
  }

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  if(game["roundsPlayed"] < 24)
    setmatchdata("utcRoundStartTimeSeconds", game["roundsPlayed"], getsystemtime());

  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_round_start");

  if(_id_4A6760982B403BAD::_id_9CE94B15EE6758EE("callback_player_round_start")) {
    foreach(player in level.players)
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_round_start", player);
  }

  _id_B1EA6E95CD5257DD = gettime();

  while(game["state"] == "playing") {
    if(!level.timerstopped)
      game["timePassed"] = game["timePassed"] + (gettime() - _id_B1EA6E95CD5257DD);

    _id_B1EA6E95CD5257DD = gettime();
    wait 1.0;
  }
}

updatetimerpausedness(_id_5A6706A7DED54BDA) {
  _id_94A402AC046FD810 = level.timerstoppedforgamemode || isDefined(level.hostmigrationtimer);

  if(!level.timerstopped && _id_94A402AC046FD810) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
    _id_8DD9F2EB8215A139 = gettimeremaining();

    if(isDefined(_id_5A6706A7DED54BDA))
      setgameendtime(int(_id_5A6706A7DED54BDA));
    else
      setgameendtime(gettime() + int(_id_8DD9F2EB8215A139));

    setomnvar("ui_match_timer_stopped", 1);
  } else if(level.timerstopped && !_id_94A402AC046FD810) {
    level.timerstopped = 0;
    level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
    _id_8DD9F2EB8215A139 = gettimeremaining();

    if(isDefined(_id_5A6706A7DED54BDA))
      setgameendtime(int(_id_5A6706A7DED54BDA));
    else
      setgameendtime(gettime() + int(_id_8DD9F2EB8215A139));

    setomnvar("ui_match_timer_stopped", 0);
  }
}

pausetimer(_id_E0968D887A942520) {
  if(!level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 1;
    updatetimerpausedness(_id_E0968D887A942520);
  }
}

resumetimer(_id_E0968D887A942520) {
  if(level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 0;
    updatetimerpausedness(_id_E0968D887A942520);
  }
}

startgame() {
  level endon("game_ended");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    thread _id_9F9E27BF69291E6D();

  setslowmotion(1, 1, 0);
  thread gametimer();
  level.timerstopped = 0;
  level.timerstoppedforgamemode = 0;
  setomnvar("ui_prematch_period", 1);
  prematchperiod();
  sysprint("Ready for Compass");
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_prematch_over");
  scripts\mp\flags::gameflagset("prematch_done");
  level notify("prematch_over");
  setomnvar("ui_prematch_period", 0);
  level._id_5FBDCF40B68612A5 = gettime();

  foreach(player in level.players)
  player scripts\mp\damage::resetattackerlist();

  if(shouldmodelognotify() && game["roundsPlayed"] == 0)
    logstring("IWH-315293: ELECTRICEEL: Prematch done");

  updatetimerpausedness();
  timelimit = scripts\mp\utility\game::gettimelimit();

  if(timelimit > 0 && !scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    level thread waitthenshowtimer();
  else
    setomnvar("ui_match_timer_hidden", 1);

  cleanpatchablecollision();
  thread timelimitclock();
  thread graceperiod();
  thread scripts\cp_mp\challenges::roundbegin();

  if(getdvarint("party_maxplayers", 0) > 30)
    setDvar("voice_proximity_team", 1);

  thread scripts\mp\analyticslog::recordbreadcrumbdata();

  if(getdvarint("dvar_2745598E35A47913") == 1)
    thread _id_548072087C9FD504::_id_B6FD5F72A2973C10();
}

waitthenshowtimer() {
  setomnvar("ui_match_timer_hidden", 1);
  wait 0.25;
  setomnvar("ui_match_timer_hidden", 0);
}

cleanpatchablecollision() {
  _id_5996E55B74173B55 = [];
  _id_5996E55B74173B55[0] = getEnt("clip32x32x8", "targetname");
  _id_5996E55B74173B55[1] = getEnt("clip32x32x128", "targetname");
  _id_5996E55B74173B55[2] = getEnt("clip64x64x256", "targetname");
  _id_5996E55B74173B55[3] = getEnt("clip32x32x32", "targetname");
  _id_5996E55B74173B55[4] = getEnt("clip64x64x128", "targetname");
  _id_5996E55B74173B55[5] = getEnt("clip64x64x64", "targetname");
  _id_5996E55B74173B55[6] = getEnt("clip64x64x8", "targetname");
  _id_5996E55B74173B55[7] = getEnt("clip128x128x256", "targetname");
  _id_5996E55B74173B55[8] = getEnt("clip128x128x128", "targetname");
  _id_5996E55B74173B55[9] = getEnt("clip128x128x8", "targetname");
  _id_5996E55B74173B55[10] = getEnt("clip256x256x256", "targetname");
  _id_5996E55B74173B55[11] = getEnt("clip256x256x128", "targetname");
  _id_5996E55B74173B55[12] = getEnt("clip256x256x8", "targetname");
  _id_5996E55B74173B55[13] = getEnt("clip512x512x8", "targetname");
  _id_5996E55B74173B55[14] = getEnt("clip32x32x256", "targetname");
  _id_5996E55B74173B55[15] = getEnt("player32x32x8", "targetname");
  _id_5996E55B74173B55[16] = getEnt("player32x32x32", "targetname");
  _id_5996E55B74173B55[17] = getEnt("player32x32x128", "targetname");
  _id_5996E55B74173B55[18] = getEnt("player32x32x256", "targetname");
  _id_5996E55B74173B55[19] = getEnt("player64x64x256", "targetname");
  _id_5996E55B74173B55[20] = getEnt("player64x64x128", "targetname");
  _id_5996E55B74173B55[21] = getEnt("player64x64x64", "targetname");
  _id_5996E55B74173B55[22] = getEnt("player64x64x8", "targetname");
  _id_5996E55B74173B55[23] = getEnt("player128x128x256", "targetname");
  _id_5996E55B74173B55[24] = getEnt("player128x128x128", "targetname");
  _id_5996E55B74173B55[25] = getEnt("player128x128x8", "targetname");
  _id_5996E55B74173B55[26] = getEnt("player256x256x256", "targetname");
  _id_5996E55B74173B55[27] = getEnt("player256x256x128", "targetname");
  _id_5996E55B74173B55[28] = getEnt("player256x256x8", "targetname");
  _id_5996E55B74173B55[29] = getEnt("player512x512x8", "targetname");

  foreach(_id_AC0E424AC96A7113 in _id_5996E55B74173B55) {
    if(isDefined(_id_AC0E424AC96A7113))
      _id_AC0E424AC96A7113 delete();
  }
}

wavespawntimer() {
  level endon("game_ended");
  level notify("waveSpawnTimer");
  level endon("waveSpawnTimer");

  while(game["state"] == "playing") {
    time = gettime();

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(time - level.lastwave[_id_F90358454413407F] > level.wavedelay[_id_F90358454413407F] * 1000) {
        level notify("wave_respawn_" + _id_F90358454413407F);
        level.lastwave[_id_F90358454413407F] = time;
        level.waveplayerspawnindex[_id_F90358454413407F] = 0;
      }
    }

    waitframe();
  }
}

wavetimerwatcher() {
  level endon("waveSpawnTimer");

  for(;;) {
    scripts\engine\utility::waittill_any_2("wave_respawn_allies", "wave_respawn_axis");
    setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.wavedelay["allies"]);
  }
}

getbetterteam() {
  kills = [];
  deaths = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    kills[_id_F90358454413407F] = 0;
    deaths[_id_F90358454413407F] = 0;
  }

  foreach(player in level.players) {
    team = player.pers["team"];

    if(isDefined(team) && scripts\mp\utility\teams::isgameplayteam(team)) {
      kills[team] = kills[team] + player.kills;
      deaths[team] = deaths[team] + player.deaths;
    }
  }

  _id_54401FF0F381643A = undefined;
  _id_26DAB44600E577C2 = undefined;
  _id_EEF1F945D8B0C9FD = 0;
  _id_08A05EAA536FB112 = undefined;
  _id_08637B9EEDA41C9A = undefined;
  _id_B788609F6E686A95 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    killcount = kills[_id_F90358454413407F];

    if(!isDefined(_id_54401FF0F381643A) || killcount > _id_54401FF0F381643A) {
      _id_54401FF0F381643A = killcount;
      _id_26DAB44600E577C2 = _id_F90358454413407F;
      _id_EEF1F945D8B0C9FD = 0;
    } else if(_id_54401FF0F381643A == killcount)
      _id_EEF1F945D8B0C9FD = 1;

    _id_65899BBA16B4AC70 = deaths[_id_F90358454413407F];

    if(!isDefined(_id_08A05EAA536FB112) || _id_65899BBA16B4AC70 < _id_08A05EAA536FB112) {
      _id_08A05EAA536FB112 = _id_65899BBA16B4AC70;
      _id_08637B9EEDA41C9A = _id_F90358454413407F;
      _id_B788609F6E686A95 = 0;
      continue;
    }

    if(_id_08A05EAA536FB112 == _id_65899BBA16B4AC70)
      _id_B788609F6E686A95 = 1;
  }

  if(!_id_EEF1F945D8B0C9FD)
    return _id_26DAB44600E577C2;

  if(!_id_B788609F6E686A95)
    return _id_08637B9EEDA41C9A;

  _id_7BE710153F5D3671 = randomint(level.teamnamelist.size);
  return level.teamnamelist[_id_7BE710153F5D3671];
}

rankedmatchupdates(winner) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    setxenonranks();

    if(hostidledout()) {
      level.hostforcedend = 1;
      logstring("host idled out");
      endlobby();
    }
  }

  updatewinlossstats(winner);
}

displayroundend(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE) {
  thread scripts\mp\music_and_dialog::round_end_music(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);

  if(!level.doeomcombat && scripts\mp\utility\game::ismoddedroundgame() && game["finalRound"] == 0)
    winner = "roundend";

  level.roundendextramessage = 0;

  if(!scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::getgametype() == "arena" && !istrue(game["practiceRound"])) {
    if(checkroundswitch(level.playovertime))
      level.roundendextramessage = game["round_end_exmsg"]["switching_sides"];
  }

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::_id_2F1B2A4A64257BEA()) {
    winner = "tie";
    _id_F0500919D8C387B9 = game["end_reason"]["win_by_two_tie"];
    _id_656B99FC50E799AE = game["end_reason"]["win_by_two_tie"];
  }

  foreach(player in level.players) {
    if(isalive(player))
      player thread scripts\mp\weapons::savealtstates();

    if(level.teambased) {
      player thread scripts\mp\hud_message::teamoutcomenotify(winner, 1, _id_F0500919D8C387B9, _id_656B99FC50E799AE, level.roundendextramessage);
      continue;
    }

    player thread scripts\mp\hud_message::outcomenotify(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
  }
}

displaygameend(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE) {
  setomnvar("ui_match_over", 1);

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::_id_2F1B2A4A64257BEA()) {
    winner = "tie";
    _id_F0500919D8C387B9 = game["end_reason"]["win_by_two_tie"];
    _id_656B99FC50E799AE = game["end_reason"]["win_by_two_tie"];
  }

  foreach(player in level.players) {
    if(level.teambased) {
      player thread scripts\mp\hud_message::teamoutcomenotify(winner, 0, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
      continue;
    }

    player thread scripts\mp\hud_message::outcomenotify(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
  }
}

displayroundswitch() {
  level notify("spawning_intermission");
  _id_D8CB902EBFC7B2A2 = getintermissionspawnpointoverride();

  foreach(player in level.players)
  player thread scripts\mp\playerlogic::spawnintermission(_id_D8CB902EBFC7B2A2);

  _id_90DDDF3DEA480715 = level.halftimetype;

  if(_id_90DDDF3DEA480715 == "halftime") {
    if(level.roundlimit) {
      if(game["roundsPlayed"] * 2 == level.roundlimit)
        _id_90DDDF3DEA480715 = "halftime";
      else
        _id_90DDDF3DEA480715 = "intermission";
    } else
      _id_90DDDF3DEA480715 = "intermission";
  }

  level notify("round_switch", _id_90DDDF3DEA480715);
  _id_1EA736D378B0D412 = 0;

  if(game["finalRound"] == 1)
    _id_90DDDF3DEA480715 = "final_round";
  else if(game["matchPoint"] == 1) {
    _id_90DDDF3DEA480715 = "match_point";

    if(scripts\mp\utility\game::iswinbytworulegametype() && game["roundsWon"]["allies"] == game["roundsWon"]["axis"])
      _id_90DDDF3DEA480715 = "win_by_two";
  }

  if(isDefined(level.switchedsides)) {
    _id_1EA736D378B0D412 = game["end_reason"]["switching_sides"];
    level.roundendextramessage = 0;

    if(_id_90DDDF3DEA480715 != "final_round" && _id_90DDDF3DEA480715 != "match_point")
      _id_90DDDF3DEA480715 = "switching_sides";
  }

  foreach(player in level.players)
  player thread scripts\mp\hud_message::teamoutcomenotify(_id_90DDDF3DEA480715, 1, _id_1EA736D378B0D412, _id_1EA736D378B0D412, level.roundendextramessage);

  if(_id_90DDDF3DEA480715 == "final_round" && scripts\mp\utility\game::getgametype() == "control") {
    roundendwait(level.roundenddelay);
    wait(level.postgamehitmarkerwaittime);
    [_id_2E912ABC2C41E4DA, _id_401C3A2E68AAB0FD] = _id_108FAF3DABBC3E99::_id_287623BBB15154BE();
    _id_516ADD8DE56DD7C4 = scripts\engine\utility::ter_op(_id_2E912ABC2C41E4DA == "axis", 1, 0);
    setomnvar("ui_control_axis_defending", _id_516ADD8DE56DD7C4);

    foreach(player in level.players)
    player thread scripts\mp\hud_message::teamoutcomenotify("switching_sides", 1, _id_401C3A2E68AAB0FD, _id_401C3A2E68AAB0FD, 0);
  }

  roundendwait(level.halftimeroundenddelay);
}

freezeallplayers(delay, _id_8C7CA5DE1B4ED9A8, _id_7E99EC33D27A716E, _id_0A977282059392B6) {
  if(!isDefined(delay))
    delay = 0;

  if(!isDefined(_id_0A977282059392B6))
    _id_0A977282059392B6 = 0;

  if(delay > 0 && _id_0A977282059392B6)
    thread slowmotionendofgame(delay);

  thread sendgameendedfrozennotify(delay);

  foreach(player in level.players) {
    player enableplayerbreathsystem(0);
    player thread freezeplayerforroundend(delay);
    player thread roundenddof(4.0);
    player freegameplayhudelems();
    player setclientdvars("cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0);

    if(isDefined(_id_8C7CA5DE1B4ED9A8) && isDefined(_id_7E99EC33D27A716E)) {
      if(_id_8C7CA5DE1B4ED9A8 == "cg_fovScale" && player issplitscreenplayer())
        player setclientdvars(_id_8C7CA5DE1B4ED9A8, 0.75);

      player setclientdvars(_id_8C7CA5DE1B4ED9A8, _id_7E99EC33D27A716E);
    }
  }

  if(isDefined(level.agentarray)) {
    foreach(agent in level.agentarray)
    agent scripts\mp\utility\player::_freezecontrols(1, undefined, "freezeAllPlayers");
  }
}

endofroundvisionset(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  visionsetfadetoblack("bw", 0.75);
}

slowmotionendofgame(delay) {
  setslowmotion(1.0, 0.4, delay);
  setendofroundsoundtimescalefactor();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(delay);
  setslowmotion(1.0, 1, 0);
  resetsoundtimescalefactor();
}

setendofroundsoundtimescalefactor() {
  if(!isDefined(level.endround_timescalefactor)) {
    soundsettimescalefactorfromtable("end_of_round");
    level.endround_timescalefactor = 1;
    level.reset_timescalefactor = undefined;
  }
}

resetsoundtimescalefactor() {
  if(!isDefined(level.reset_timescalefactor)) {
    soundsettimescalefactorfromtable("reset");
    level.endround_timescalefactor = undefined;
    level.nukeinfo._id_6D77C28B2DBED93D = undefined;
    level.reset_timescalefactor = 1;
  }
}

sendgameendedfrozennotify(delay) {
  wait(delay);
  level notify("game_ended_frozen");
}

restart() {
  foreach(player in level.players)
  player thread scripts\mp\utility\game::setuipostgamefade(1);

  wait 0.5;

  if(isDefined(level.onmaprestart))
    [[level.onmaprestart]]();

  level notify("restarting");
  game["state"] = "playing";
  map_restart(1);
}

_id_52DDE37B8FCF63FF() {
  if(!_func_6B9F8406E6153597()) {
    return;
  }
  _id_046B02357D890F0F = spawnStruct();
  _id_046B02357D890F0F._id_20698198296B24AE = scripts\mp\utility\game::gettimepassed();
  _func_7A37F9BAB9677061(_id_046B02357D890F0F);

  foreach(player in level.players) {
    if(!isPlayer(player) || isbot(player)) {
      continue;
    }
    playerstats = scripts\mp\playerlogic::_id_358A3AE71B7D1935(player);

    if(!isDefined(playerstats)) {
      continue;
    }
    player _meth_FE84F716B4611373(playerstats);
  }
}

endgame(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B) {
  if(isDefined(level._id_DBF03354F99EBAB2)) {
    _id_8E75E25718ADEE6D = [[level._id_DBF03354F99EBAB2]]();

    if(istrue(_id_8E75E25718ADEE6D))
      return;
  }

  level notify("start_game_ended");
  level._id_3940D363B8FB58C3 = winner;

  if(isDefined(level.modescorewinner))
    winner = level.modescorewinner;

  if(getdvarint("dvar_D87F39111295023C", 0)) {
    if(scripts\mp\utility\game::waslastround()) {
      foreach(player in level.players)
      _id_4A6760982B403BAD::_id_766155419D15C501(player);

      if(!istrue(level._id_854CA65A80F62C31)) {
        level._id_854CA65A80F62C31 = 1;
        _id_7E2C53B0BCF117D9 = spawnStruct();
        _id_7E2C53B0BCF117D9.winner = winner;
        _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_match_end", _id_7E2C53B0BCF117D9);
      }
    }
  }

  if(isDefined(level.endgame))
    [[level.endgame]](winner, _id_F0500919D8C387B9, nukedetonated);
  else
    endgame_regularmp(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B);
}

endgame_regularmp(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B, _id_2F96189808D67A6B, _id_9A56ADF739D1BD4E) {
  if(!isDefined(nukedetonated))
    nukedetonated = 0;

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && level.gameended) {
    return;
  }
  if(game["roundsPlayed"] < 24)
    setmatchdata("utcRoundEndTimeSeconds", game["roundsPlayed"], getsystemtime());

  scripts\common\utility::trycall(level.matchdata_onroundend);
  level._id_0CC2C79DE99DB62C = 1;
  _id_24B6A4267AACB19F = 0;

  if(level.hostforcedend || level.forcedend)
    _id_24B6A4267AACB19F = 1;

  if(scripts\mp\utility\game::inovertime()) {
    if(game["overtimeRoundsPlayed"] == 0)
      setmatchdata("firstOvertimeRoundIndex", game["roundsPlayed"]);

    if(!_id_24B6A4267AACB19F)
      game["overtimeRoundsPlayed"]++;
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(winner)) {
      if(!_id_24B6A4267AACB19F) {
        if(isDefined(_id_8E4A26ED257A393B))
          game["roundsWon"][winner] = game["roundsWon"][winner] + _id_8E4A26ED257A393B;
        else
          game["roundsWon"][winner]++;
      }

      if(!isDefined(level.finalkillcam_winner))
        level.finalkillcam_winner = winner;
    } else {
      if(!_id_24B6A4267AACB19F && isDefined(winner) && winner == "tie" && shouldmodescoreonties()) {
        foreach(_id_F90358454413407F in level.teamnamelist) {
          if(isDefined(_id_2F96189808D67A6B) && isarray(_id_2F96189808D67A6B) && isDefined(_id_2F96189808D67A6B[_id_F90358454413407F])) {
            game["roundsWon"][_id_F90358454413407F] = game["roundsWon"][_id_F90358454413407F] + _id_2F96189808D67A6B[_id_F90358454413407F];
            continue;
          }

          game["roundsWon"][_id_F90358454413407F]++;
        }
      }

      if(!isDefined(level.finalkillcam_winner))
        level.finalkillcam_winner = "none";
    }

    if(!istrue(game["practiceRound"])) {
      foreach(_id_F90358454413407F in level.teamnamelist)
      scripts\mp\gamescore::updateteamscore(_id_F90358454413407F);

      if(scripts\mp\utility\game::isroundbased() && game["roundsPlayed"] < 24 && scripts\mp\utility\game::getgametype() != "koth") {
        setmatchdata("alliesRoundScore", game["roundsPlayed"], getteamscore("allies"));
        setmatchdata("axisRoundScore", game["roundsPlayed"], getteamscore("axis"));
      }
    }
  } else {
    if(isDefined(winner) && isPlayer(winner) && !_id_24B6A4267AACB19F)
      game["roundsWon"][winner.guid]++;

    if(!isDefined(level.finalkillcam_winner)) {
      if(!isDefined(winner) || isstring(winner) && winner == "tie")
        level.finalkillcam_winner = "none";
      else
        level.finalkillcam_winner = winner.guid;
    }
  }

  scripts\mp\gamescore::updateplacement();

  if(!_id_24B6A4267AACB19F)
    game["roundsPlayed"]++;

  level.playovertime = scripts\mp\utility\game::shouldplayovertime();

  if(scripts\mp\utility\game::nextroundisfinalround())
    game["finalRound"] = 1;
  else if(scripts\mp\utility\game::nextroundismatchpoint())
    game["matchPoint"] = 1;

  if(isDefined(winner) && scripts\mp\utility\game::waslastround())
    winner = checkmodeoverridetie(winner);

  level.ctfnukeended = istrue(nukedetonated) && scripts\mp\utility\game::getgametype() == "ctf";

  if(isDefined(winner) && level.ctfnukeended) {
    otherteam = scripts\engine\utility::ter_op(winner == "allies", "axis", "allies");
    game["roundsWon"][winner] = 1;
    game["roundsWon"][otherteam] = 0;
    game["teamScores"][winner] = 1;
    game["teamScores"][otherteam] = 0;
    setteamscore(winner, 1);
    setteamscore(otherteam, 0);
  }

  updatematchbonusscores(winner);

  if(scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) {
    foreach(player in level.players) {
      _id_C7346A50495FAB33(player, winner);
      player scripts\cp_mp\utility\game_utility::stopkeyearning(winner);
    }
  }

  _id_FB23F88E5B048669 = endgame_endround(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated);

  foreach(player in level.players) {
    if(!isbot(player) && isDefined(player.team) && player.team != "spectator" && player.team != "codcaster")
      logendofround(player);
  }

  if(_id_FB23F88E5B048669 && scripts\mp\utility\game::waslastround())
    endgame_endgame(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_9A56ADF739D1BD4E);
}

_id_C7346A50495FAB33(player, winner) {
  if(isstring(winner)) {
    if(player.team == winner && player.deaths == 0)
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "no_death_win", 1);
  } else if(isDefined(winner.name)) {
    if(player.team == winner.name && player.deaths == 0)
      scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "no_death_win", 1);
  }
}

shouldmodescoreonties() {
  return istrue(game["canScoreOnTie"]);
}

checkmodeoverridetie(winner) {
  _id_E0800C286F7F2D30 = shouldmodescoreonties() && winner == "tie";
  _id_088189C9B48DAC5E = scripts\mp\utility\game::getgametype() == "ctf" && winner == "tie" && !level.winrule;

  if(_id_E0800C286F7F2D30 || _id_088189C9B48DAC5E) {
    scripts\mp\gamescore::updatetotalteamscore("axis");
    scripts\mp\gamescore::updatetotalteamscore("allies");
    _id_43A41488C3C487DF = getteamscore("allies");
    _id_18A3FAB290E780C2 = getteamscore("axis");

    if(_id_43A41488C3C487DF != _id_18A3FAB290E780C2)
      winner = scripts\engine\utility::ter_op(_id_43A41488C3C487DF > _id_18A3FAB290E780C2, "allies", "axis");
  }

  return winner;
}

endgame_showkillcam() {
  if(istrue(level.nukeinfo._id_AD590A75663898F3)) {
    return;
  }
  if(istrue(level.brdisablefinalkillcam)) {
    return;
  }
  if(getdvarint("dvar_166B51BF7450FC22", 0) == 1) {
    return;
  }
  if(istrue(level.skipfinalkillcam)) {
    return;
  }
  scripts\mp\flags::levelflagwait("final_killcam_preloaded");

  if(level.finalkillcamenabled) {
    _id_1CF6FD3396DCE827 = 0;

    if(isDefined(level.finalkillcam_winner))
      _id_1CF6FD3396DCE827 = 1;

    if(_id_1CF6FD3396DCE827)
      _id_1CF6FD3396DCE827 = level scripts\mp\final_killcam::dofinalkillcam();

    if(isDefined(_id_1CF6FD3396DCE827) && !_id_1CF6FD3396DCE827) {
      postroundfadenokillcam();
      return;
    }
  } else if(level.potgenabled) {
    _id_CC46931E59A508D3 = scripts\mp\potg::getcurpotgscene();

    if(isDefined(_id_CC46931E59A508D3.primaryentity)) {
      level scripts\mp\final_killcam::dopotgkillcam();
      return;
    }

    level.finalkillcamenabled = 1;
    _id_1CF6FD3396DCE827 = level scripts\mp\final_killcam::dofinalkillcam();

    if(isDefined(_id_1CF6FD3396DCE827) && !_id_1CF6FD3396DCE827) {
      postroundfadenokillcam();
      return;
    }

    return;
  } else {}
}

postroundfadenokillcam() {
  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }
    if(level.gametype == "ballmode") {
      if(scripts\mp\utility\game::waslastround())
        player setclientomnvar("post_game_state", 2);
    } else if(level.gametype == "arena")
      player setclientomnvar("post_game_state", 1);
    else
      player setclientomnvar("post_game_state", 2);

    player thread predictandclearintermissionstreaming();
  }

  wait 0.5;
}

predictandclearintermissionstreaming() {
  self endon("disconnect");
  _id_BAF0448298AA5C79 = scripts\mp\playerlogic::getspectatepoint();
  self _meth_BC667001F9DD3808(_id_BAF0448298AA5C79.origin);

  while(self.sessionstate != "intermission")
    waitframe();

  waitframe();
  self clearpredictedstreampos();
}

setgameendflagsandnotifies(winner) {
  game["state"] = "postgame";
  level notify("game_ended", winner);
  scripts\mp\flags::levelflagset("game_over");
  scripts\mp\flags::levelflagset("block_notifies");
}

endgame_luidecisionreceived(value) {
  if(isDefined(value)) {
    if(value == 1 || value == 2) {
      level._waitforlui = 0;
      level._luidecision = value;
      level notify("madeLUIDecision");
    }
  }
}

endgame_endround(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;

  if(!isDefined(winner)) {
    if(scripts\mp\utility\game::isroundbased()) {
      logstring("IWH-315293: HALIBUT: winner undefined, related to CL 7682409 where wasLastRound() would not be set in round based mode");
      level.forcedend = 1;
    }

    return 1;
  }

  _id_189B67B2735B981D::_id_27FE46449778A3E3(winner);

  if(getdvarint("scr_eom_combat")) {
    if(scripts\mp\utility\game::getgametype() == "ballmode" || scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::getgametype() != "arena")
      level.doeomcombat = 1;
  }

  updateleaderboardstats();
  waitframe();
  scripts\mp\gamescore::updateplacement();
  level.recordfinalkillcam = 0;
  level.ignorescoring = 1;
  thread scripts\mp\potg::onroundended(winner);
  thread scripts\mp\final_killcam::preloadfinalkillcam();
  level notify("cancel_announcer_dialog");

  if(scripts\mp\utility\game::isteamreviveenabled())
    thread scripts\mp\teamrevive::cleanuprevivetriggericons();

  if(scripts\mp\utility\game::waslastround()) {
    if(scripts\mp\utility\game::getgametype() == "arena") {
      if(scripts\mp\utility\teams::isgameplayteam(winner))
        topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(winner, "players"), ::compare_player_score);
      else
        topplayers = level.placement["all"];

      _id_5145219FE86AF824 = int(min(3, topplayers.size));

      foreach(player in level.players) {
        _id_F2440D5D88DEB7DF = 0;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5145219FE86AF824; _id_AC0E594AC96AA3A8++) {
          if(player == topplayers[_id_AC0E594AC96AA3A8])
            _id_F2440D5D88DEB7DF = 1;
        }

        if(_id_F2440D5D88DEB7DF) {
          if(player == topplayers[0])
            player scripts\cp_mp\pet_watch::addwatch2v2topscore();
        }
      }
    }

    level notify("start_game_win_audio", winner);

    if(istrue(level.postgameexfil) && !level.forcedend) {
      if(winner != "tie")
        level waittill("exfil_continue_game_end");
    }
  } else
    level notify("round_end_music", winner);

  if(level.doeomcombat) {
    if(istrue(level.docmdoutro)) {
      thread waitforhitmarkerspostgame();
      setgameendflagsandnotifies(winner);
      level waittill("cmd_continue_game_end");
      setomnvarforallclients("post_game_state", 2);

      foreach(player in level.players) {
        if(level.teambased) {
          player thread scripts\mp\hud_message::teamoutcomenotify(winner, 0, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
          continue;
        }

        player thread scripts\mp\hud_message::outcomenotify(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
      }

      freezeallplayers(3, "cg_fovScale", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
    } else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
      game["state"] = "postgame";
      level notify("game_ended", winner);
      scripts\mp\flags::levelflagset("game_over");
      scripts\mp\flags::levelflagset("block_notifies");
      waitframe();
    } else if(scripts\mp\utility\game::getgametype() == "ballmode") {
      level notify("game_ended", winner);

      if(scripts\mp\utility\game::waslastround() || level.playovertime) {
        if(level.playovertime)
          winner = "overtime";

        thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      setgameendflagsandnotifies(winner);
      waitframe();
    } else {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
      freezeallplayers(2.5, "cg_fovScale", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      setgameendflagsandnotifies(winner);
      waitframe();
    }

    foreach(player in level.players) {
      player setclientdvar("ui_opensummary", 1);

      if(scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) {
        player scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        player scripts\mp\bounty::playerresetbountystreak();
      }

      player setclientomnvar("ui_match_in_progress", 0);
    }
  } else {
    thread waitforhitmarkerspostgame();
    setgameendflagsandnotifies(winner);
    waitframe();

    foreach(player in level.players) {
      player setclientdvar("ui_opensummary", 1);

      if((scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) && !istrue(game["isLaunchChunk"])) {
        player scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        player scripts\mp\bounty::playerresetbountystreak();
      }

      player setclientomnvar("ui_match_in_progress", 0);
    }

    freezeallplayers(1.0, "cg_fovScale", 1, 0);
  }

  setgameendtime(0);
  game["gameLength"] = game["gameLength"] + scripts\mp\utility\game::_id_1236E61C6E2C58F1();
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled())
    scripts\mp\analyticslog::analyticsstorespawndata();

  if(scripts\mp\utility\game::waslastround())
    level _id_4C770A9A4AD7659C::callback("game_ended");

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9._id_C7C58523552F1A6F = _id_F0500919D8C387B9;
  _id_7E2C53B0BCF117D9.winner = winner;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_round_end", _id_7E2C53B0BCF117D9);

  if(_id_4A6760982B403BAD::_id_9CE94B15EE6758EE("callback_player_round_end")) {
    foreach(player in level.players) {
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.player = player;
      _id_7E2C53B0BCF117D9.winner = winner;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_round_end", _id_7E2C53B0BCF117D9);
    }
  }

  clearmatchhasmorethan1playervariablesonroundend();

  if(isDefined(level.matchrecording_dump))
    [[level.matchrecording_dump]]();

  rankedmatchupdates(winner);
  setDvar("g_deadChat", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("bg_compassShowEnemies", 0);

  foreach(player in level.players) {
    player scripts\mp\class::loadout_clearperks();
    player.deathsdoor = 0;
  }

  if(istrue(game["practiceRound"]) && !istrue(level.forcedend)) {
    game["roundsPlayed"] = 0;

    foreach(team in level.teamnamelist) {
      game["roundsWon"][team] = 0;
      game["teamScores"][team] = 0;
    }

    winner = "tie";
    _id_F0500919D8C387B9 = game["end_reason"]["practice_round_over"];
  }

  _id_C58F71396BB03715 = 1;

  if(scripts\mp\utility\game::getgametype() == "ballmode")
    _id_C58F71396BB03715 = scripts\mp\utility\game::waslastround() || level.playovertime;

  if(_id_C58F71396BB03715) {
    displayroundend(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
    level thread endofroundvisionset(level.roundenddelay - 1.0);
  }

  if(!scripts\mp\utility\game::waslastround()) {
    level notify("round_win", winner);
    roundendwait(level.roundenddelay);
  } else {
    if(!getdvarint("dvar_D87F39111295023C", 0)) {
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.winner = winner;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_match_end", _id_7E2C53B0BCF117D9);
    }

    if(!istrue(level._id_A5C9FCD81C474AB0))
      roundendwait(level.roundenddelay);
  }

  level notify("game_cleanup");
  endgame_showkillcam();
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();

  if(istrue(game["practiceRound"]) && !istrue(level.forcedend)) {
    game["practiceRound"] = 0;

    if(level.allowsupers && !scripts\mp\utility\game::runleanthreadmode()) {
      foreach(player in level.players) {
        player scripts\mp\supers::clearsuper();
        player scripts\mp\perks\perkpackage::perkpackage_reset();
      }
    }

    scripts\mp\flags::levelflagclear("block_notifies");
    restart();
    return 0;
  } else {
    if(level.teambased) {
      foreach(_id_F90358454413407F in level.teamnamelist)
      scripts\mp\gamescore::updatetotalteamscore(_id_F90358454413407F);
    }

    if(!scripts\mp\utility\game::wasonlyround()) {
      if(!scripts\mp\utility\game::waslastround()) {
        if(level.playovertime) {
          winner = "overtime";
          game["status"] = "overtime";
        }

        scripts\mp\flags::levelflagclear("block_notifies");
        _id_FD4901C8A1A1CF9A = checkroundswitch(level.playovertime);

        if(_id_FD4901C8A1A1CF9A)
          onroundswitch(level.playovertime);

        if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
          game["shouldDisplayRoundSwitch"] = _id_FD4901C8A1A1CF9A;

        if(_id_FD4901C8A1A1CF9A || game["finalRound"] == 1 || game["matchPoint"] == 1) {
          _id_FF9FAEF41A741A40 = 1;

          if(scripts\mp\utility\game::getgametype() == "arena") {
            if(scripts\mp\utility\game::shouldplaywinbytwo()) {} else if(game["matchPoint"] == 1 && !istrue(game["displayedMatchPoint"]))
              game["displayedMatchPoint"] = 1;
            else if(game["finalRound"] != 1)
              _id_FF9FAEF41A741A40 = 0;
          } else if(scripts\mp\utility\game::getgametype() == "ballmode")
            _id_FF9FAEF41A741A40 = 0;

          if(_id_FF9FAEF41A741A40)
            displayroundswitch();
        }

        foreach(player in level.players) {
          player.pers["stats"] = player.stats;

          if(scripts\mp\utility\player::isreallyalive(player) && isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680)) {
            _id_642470E1ABC1BBF9 = spawnStruct();
            _id_642470E1ABC1BBF9.victim = player;
            _id_642470E1ABC1BBF9.attacker = undefined;
            _id_642470E1ABC1BBF9.meansofdeath = "MOD_ROUND_ENDED";
            _id_642470E1ABC1BBF9.weaponfullstring = "none";
            _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_death", _id_642470E1ABC1BBF9);
          }
        }

        restart();
        return 0;
      }

      if(!level.forcedend)
        _id_F0500919D8C387B9 = updateroundendreasontext(winner);
    }
  }

  return 1;
}

tacopsroundendwait(_id_5EF4D54BB701E295) {
  _id_E41A0047B2421A2C = 0;

  while(!_id_E41A0047B2421A2C) {
    players = level.players;
    _id_E41A0047B2421A2C = 1;

    foreach(player in players) {
      if(!player scripts\mp\hud_message::isdoingsplash()) {
        continue;
      }
      _id_E41A0047B2421A2C = 0;
    }

    wait 0.5;
  }

  _id_8D539C1577794D34 = 0;

  foreach(player in level.players) {
    player thread scripts\mp\utility\game::setuipostgamefade(0);

    if(player _meth_8420670EAFC8D391())
      _id_8D539C1577794D34 = level._id_7210BB7B0BFBCFDB;
  }

  wait(_id_5EF4D54BB701E295 + _id_8D539C1577794D34);
  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

compare_player_score(left, right) {
  return left.score >= right.score;
}

endgame_endgame(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_22791848E6E9FBCA) {
  canceljoins();
  setnojipscore(1, 1);
  setnojiptime(1, 1);

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !level.forcedend) {
    level._waitforlui = 1;
    level scripts\common\ui::lui_registercallback("exit_squad_eliminated", ::endgame_luidecisionreceived);
  }

  if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("iw9_menu_soundbank");

  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level.shouldgamelobbyremainintact) && [[level.shouldgamelobbyremainintact]]())
    requestgamelobbyremainintact();

  if(!istrue(level.processedwinloss) && (istrue(level.forfeitinprogress) || level.forcedend))
    updatewinlossstats(winner);

  scripts\cp_mp\challenges::roundend(winner);
  checkforpersonalbests();
  updatespmstats();
  scripts\mp\persistence::writebestscores();
  level notify("stop_leaderboard_stats");
  updateleaderboardstats();
  level scripts\mp\accolades::evaluateallaccolades();
  level.doingbroshot = scripts\mp\broshot::initbroshot(winner);

  if(!level.doingbroshot) {
    if(!istrue(level._id_A5C9FCD81C474AB0)) {
      level notify("spawning_intermission");
      _id_D8CB902EBFC7B2A2 = getintermissionspawnpointoverride();

      foreach(player in level.players) {
        player thread scripts\mp\utility\game::setuipostgamefade(0);

        if(!isDefined(level.modespawnendofgame) || !player[[level.modespawnendofgame]]())
          player thread scripts\mp\playerlogic::spawnintermission(_id_D8CB902EBFC7B2A2);
      }
    }
  }

  if(istrue(nukedetonated) && isDefined(level.nukeinfo._id_FC0043E95242D5CB) && !istrue(level.nukeinfo.cancelled)) {
    scripts\mp\utility\player::_visionsetnaked(level.nukeinfo._id_FC0043E95242D5CB, 0);
    visionsetfadetoblack("", 0.75);
  } else {
    scripts\mp\utility\player::_visionsetnaked("", 0);
    visionsetfadetoblack("", 0.75);
  }

  displaygameend(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
  scripts\mp\flags::levelflagclear("block_notifies");
  _id_04CDABCD91A92977::_id_4064A2271DE12B97();

  if(level._id_EC2FB549B15AD827)
    _id_629A97C763E17711::_id_D1092FECB16D3B3C(winner);

  level.intermission = 1;

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(winner)) {
      setmatchdata("victor", winner);
      topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(winner, "players"), ::compare_player_score);
    } else {
      setmatchdata("victor", "none");
      topplayers = level.placement["all"];
    }

    setmatchdata("alliesScore", getteamscore("allies"));
    setmatchdata("axisScore", getteamscore("axis"));
  } else {
    setmatchdata("victor", "none");
    topplayers = level.placement["all"];
  }

  _func_EB1A045A6D299C6A();

  foreach(player in level.players) {
    _id_4A6760982B403BAD::_id_766155419D15C501(player);
    player setplayerdata("common", "round", "endReasonTextIndex", _id_F0500919D8C387B9);

    if(isalive(player) && isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680)) {
      _id_642470E1ABC1BBF9 = spawnStruct();
      _id_642470E1ABC1BBF9.victim = player;
      _id_642470E1ABC1BBF9.attacker = undefined;
      _id_642470E1ABC1BBF9.meansofdeath = "MOD_GAME_ENDED";
      _id_642470E1ABC1BBF9.weaponfullstring = "none";
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_player_death", _id_642470E1ABC1BBF9);
    }

    _id_5145219FE86AF824 = int(min(3, topplayers.size));
    _id_F2440D5D88DEB7DF = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5145219FE86AF824; _id_AC0E594AC96AA3A8++) {
      if(player == topplayers[_id_AC0E594AC96AA3A8])
        _id_F2440D5D88DEB7DF = 1;
    }

    if(_id_F2440D5D88DEB7DF)
      player scripts\cp_mp\pet_watch::addwatchchargewintop3();

    if(level.teambased) {
      if(scripts\mp\utility\teams::isgameplayteam(winner)) {
        if(isDefined(player.team)) {
          if(player.team == winner) {
            player scripts\cp_mp\pet_watch::addwatchchargewin();
            player.pers["match_outcome"] = "win";
          } else
            player.pers["match_outcome"] = "loss";
        }
      } else if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie")
        player.pers["match_outcome"] = "tie";
    } else if(isPlayer(winner)) {
      if(isDefined(level.lastplayerwins)) {
        if(player == level.placement["all"][0]) {
          player scripts\cp_mp\pet_watch::addwatchchargewin();
          player.pers["match_outcome"] = "win";
        } else
          player.pers["match_outcome"] = "loss";
      } else if(_id_F2440D5D88DEB7DF) {
        player scripts\cp_mp\pet_watch::addwatchchargewin();
        player.pers["match_outcome"] = "win";
      } else
        player.pers["match_outcome"] = "loss";
    } else if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie")
      player.pers["match_outcome"] = "tie";

    if(player scripts\mp\utility\game::onlinestatsenabled()) {
      player setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "comparisonSeason", getdvarint("current_season"));
      _id_E0BA1A2E8FFB8E1E = int(scripts\mp\utility\game::getsecondspassed());

      foreach(scope in ["lifetimeStats", "seasonalStats"]) {
        _id_9DD650BC2F7C8A01 = 0;

        if(player hasplayerdata(level._id_5D69837CF4DB0407, "playerStats", scope, scripts\mp\utility\game::_id_F6BAD1D33AD22078(), "timeSpent"))
          _id_9DD650BC2F7C8A01 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", scope, scripts\mp\utility\game::_id_F6BAD1D33AD22078(), "timeSpent");

        player setplayerdata(level._id_5D69837CF4DB0407, "playerStats", scope, scripts\mp\utility\game::_id_F6BAD1D33AD22078(), "timeSpent", _id_9DD650BC2F7C8A01 + _id_E0BA1A2E8FFB8E1E);
      }
    }

    player scripts\common\utility::trycall(level.matchdata_logplayerdata);
  }

  if(!level.doingbroshot) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_2695A20D4011076D::hidedangercircle();
      setomnvarforallclients("ui_br_transition_type", 0);

      if(_id_7C386B2DB63D6FB6()) {
        if(istrue(level._id_A5C9FCD81C474AB0)) {
          if(isDefined(_id_22791848E6E9FBCA) && !_func_96D228FA8E72A818(_id_22791848E6E9FBCA))
            _id_22791848E6E9FBCA setclientomnvar("post_game_state", 14);
        } else
          setomnvarforallclients("post_game_state", 14);
      }

      if(!_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
        wait_time = getdvarint("dvar_54481201F477F78F", 120);

        if(getdvarint("lui_ingame_play_again_enabled") == 1) {
          if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
            wait(wait_time);
          else
            wait 25;
        } else if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
          wait(wait_time);
        else if(getdvarfloat("dvar_E94E38873C94B670", 0) > 0)
          waitframe();
        else
          wait 25;
      } else {
        if(istrue(level._waitforlui))
          level waittill("madeLUIDecision");

        level.postroundtime = 0;
      }
    }

    if(_id_9243D6BCFD2F6B49()) {
      if(istrue(level._id_A5C9FCD81C474AB0)) {
        if(isDefined(_id_22791848E6E9FBCA) && !_func_96D228FA8E72A818(_id_22791848E6E9FBCA))
          _id_22791848E6E9FBCA setclientomnvar("post_game_state", 5);
      } else
        setomnvarforallclients("post_game_state", 5);
    }

    if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E()) {
      _id_EA7F26521AA24E5F = getdvarint("dvar_61991422D0DC9399", 120);
      wait(_id_EA7F26521AA24E5F);
    }

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      roundendwait(level.postroundtime);
  }

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" || scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "kingslayer" || scripts\mp\utility\game::isprophuntgametype() || scripts\mp\utility\game::getsubgametype() == "rumble_mgl")
    processlobbydata();

  if(level.doingbroshot) {
    setomnvarforallclients("post_game_state", 6);
    wait 0.1;
    scripts\mp\broshot::startbroshot(winner);
    level waittill("taunts_timed_out");
    scripts\mp\broshot::endbroshot();
  }

  if(istrue(level._id_A5C9FCD81C474AB0)) {
    if(isDefined(_id_22791848E6E9FBCA) && !_func_96D228FA8E72A818(_id_22791848E6E9FBCA)) {
      data = spawnStruct();
      data.player = _id_22791848E6E9FBCA;
      _id_4A6760982B403BAD::_id_766155419D15C501(data.player);
      _id_22791848E6E9FBCA thread _id_45F403E1732217D3::_id_6447F24ADDC0137E(data);
    }
  } else
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_server_exit_level");

  scripts\common\utility::trycall(level.matchdata_recordrecentlyplayeddata);
  onmatchend();
  sendendofmatchdata();
  _func_85F0E7ABCA18AD51();

  foreach(player in level.players)
  player.pers["stats"] = player.stats;

  _id_52DDE37B8FCF63FF();

  if(istrue(game["isLaunchChunk"]))
    wait 1;
  else if(!nukedetonated && !level.postgamenotifies) {
    if(!level.doingbroshot) {
      if(!scripts\mp\utility\game::wasonlyround())
        wait 6.0;
      else if(getdvarfloat("dvar_E94E38873C94B670", 0) > 0)
        wait 1;
      else if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\cp_mp\utility\game_utility::_id_22CD3D64FDB05892() && level.matchmakingmatch) {
        setomnvarforallclients("post_game_state", 15);
        _id_053804DBEED3DA40 = getdvarint("dvar_B6AE6A9D61D4326A", 0);
        wait(_id_053804DBEED3DA40);
      } else
        wait(min(5.0, 4.0 + level.postgamenotifies));
    }
  } else
    wait(min(10.0, 4.0 + level.postgamenotifies));

  settournamentwinner(winner);

  if(istrue(level._id_A5C9FCD81C474AB0)) {
    if(isDefined(_id_22791848E6E9FBCA) && !_func_96D228FA8E72A818(_id_22791848E6E9FBCA))
      _id_22791848E6E9FBCA setclientomnvar("post_game_state", 1);
  } else
    setomnvarforallclients("post_game_state", 1);

  wait 1;
  _func_A30E6BFA5C581E40();
  _id_0306456CBE503C21 = getdvarint("dvar_CC01D3876A5302BD", 1);
  wait(_id_0306456CBE503C21);
  scripts\mp\flags::levelflagwaitopen("post_game_level_event_active");

  if(istrue(game["isLaunchChunk"])) {
    scripts\mp\flags::levelflagclear("block_notifies");
    game["launchChunkWinner"] = 1;
    game["timePassed"] = 0;
    game["roundsPlayed"] = 0;
    game["overtimeRoundsPlayed"] = 0;
    game["matchPoint"] = 0;
    game["finalRound"] = 0;
    game["gamestarted"] = undefined;
    game["previousWinningTeam"] = "";

    foreach(team in level.teamnamelist) {
      game["roundsWon"][team] = 0;
      game["teamScores"][team] = 0;
      setteamscore(team, int(0));
    }

    if(game["launchChunkRuleSet"] == 3) {
      if(isDefined(level.droplaunchchunkbots))
        level[[level.droplaunchchunkbots]]();

      wait 1;
    }

    if(!level.hostforcedend && !level.forcedend) {
      restart();
      return 0;
    }
  }

  if(!istrue(level._id_A5C9FCD81C474AB0))
    level notify("exitLevel_called");

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && isDefined(level._luidecision) && level._luidecision == 2) {
    scripts\mp\bots\bots::drop_bots(1, level.player.team);
    restart();
  } else if(istrue(level._id_A5C9FCD81C474AB0)) {
    _id_1668C0537A253B15 = getdvarfloat("dvar_7FDA7FC9AE065797", 30);
    wait(_id_1668C0537A253B15);
    level notify("exitLevel_called");
    exitlevel(0);
  } else
    exitlevel(0);
}

_id_34AF0DDF175D84E3(nukedetonated) {
  self endon("disconnect");

  if(_id_7C386B2DB63D6FB6())
    self setclientomnvar("post_game_state", 14);

  if(!_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    wait_time = getdvarint("dvar_54481201F477F78F", 120);

    if(getdvarint("lui_ingame_play_again_enabled") == 1) {
      if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
        wait(wait_time);
      else
        wait 25;
    } else if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      wait(wait_time);
    else
      wait 25;
  }

  if(_id_9243D6BCFD2F6B49())
    self setclientomnvar("post_game_state", 5);

  data = spawnStruct();
  data.player = self;
  _id_4A6760982B403BAD::_id_766155419D15C501(data.player);
  thread _id_45F403E1732217D3::_id_6447F24ADDC0137E(data);

  if(istrue(game["isLaunchChunk"]))
    wait 1;
  else if(!istrue(nukedetonated) && !level.postgamenotifies) {
    if(!level.doingbroshot) {
      if(!scripts\mp\utility\game::wasonlyround())
        wait 6.0;
      else
        wait(min(5.0, 4.0 + level.postgamenotifies));
    }
  } else
    wait(min(10.0, 4.0 + level.postgamenotifies));

  self setclientomnvar("post_game_state", 1);
}

_id_7C386B2DB63D6FB6() {
  return !_id_52A79582296D478F() || !_id_0E2DBE7460083C35();
}

_id_9243D6BCFD2F6B49() {
  return !_id_52A79582296D478F() || !_id_0E2DBE7460083C35();
}

_id_52A79582296D478F() {
  return getdvarint("dvar_05AD0894B28995C4", 0) == 1;
}

_id_0E2DBE7460083C35() {
  return getDvar("dvar_12E53040D5281856", "") == "scripted";
}

sendendofmatchdata() {
  if(!isDefined(level.endofmatchdatasent)) {
    if(getdvarint("online_matchdata_enabled") != 0) {
      setmatchdata("host", level.hostname);

      if(scripts\mp\utility\game::matchmakinggame()) {
        setmatchdata("playlistVersion", getplaylistversion());
        setmatchdata("playlistID", getplaylistid());
        setmatchdata("playlist_name", getplaylistname());
        setmatchdata("isDedicated", isdedicatedserver());
        setmatchdata("party_maxplayers", getdvarint("party_maxplayers", 0));
      }

      _func_9D1E19C311CBE199();
      sendmatchdata();
    }
  }

  level.endofmatchdatasent = 1;
}

settournamentwinner(winner) {
  if(!isDefined(winner)) {
    return;
  }
  if(!level.teambased) {
    dotournamentendgame(winner);
    return;
  } else if(winner != "allies" && winner != "axis") {
    _id_C555969542795B85 = scripts\mp\utility\teams::getteamdata("allies", "players");
    _id_95A21B6ABCA6B0CA = scripts\mp\utility\teams::getteamdata("axis", "players");

    if(_id_C555969542795B85.size == 0)
      winner = "axis";
    else if(_id_95A21B6ABCA6B0CA.size == 0)
      winner = "allies";
    else
      winner = getbetterteam();
  }

  dotournamentendgame(winner);
}

waitforhitmarkerspostgame() {
  wait(level.postgamehitmarkerwaittime);
  level notify("post_game_ui_start");
  setomnvarforallclients("post_game_state", 1);
}

eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE) {
  wait(level.postgamehitmarkerwaittime);
  level notify("post_game_ui_start");

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    setomnvarforallclients("post_game_state", 2);

  foreach(player in level.players) {
    if(level.teambased) {
      player thread scripts\mp\hud_message::teamoutcomenotify(winner, 0, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
      continue;
    }

    player thread scripts\mp\hud_message::outcomenotify(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE);
  }
}

getintermissionspawnpointoverride() {
  spawnpoint = undefined;

  switch (level.mapname) {
    case "mp_village2":
      spawnpoint = spawnStruct();
      spawnpoint.origin = (1478, -3039, 981);
      spawnpoint.angles = (388.74, 144.97, 0);
      break;
    case "mp_backlot2":
      spawnpoint = spawnStruct();
      spawnpoint.origin = (1835, 1347, 749);
      spawnpoint.angles = (361, 224, 0);
      break;
    case "mp_hideout":
      spawnpoint = spawnStruct();
      spawnpoint.origin = (-871, -1578, 458);
      spawnpoint.angles = (6, 65, 0);
      break;
  }

  if(scripts\mp\utility\game::getgametype() == "brtdm" || scripts\mp\utility\game::getgametype() == "brtdm_mgl") {
    spawnpoint = spawnStruct();
    spawnpoint.origin = level.brtdm_config.spectatepoint.origin;
    spawnpoint.angles = level.brtdm_config.spectatepoint.angles;
  }

  return spawnpoint;
}

eomcamerapullout(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    player _id_3B64EB40368C1450::set("eomCameraPullOut", "ads", 0);
    startpos = player getEye() + (0, 0, 100) + anglesToForward(player.angles) * -100;
    cameraent = spawn("script_model", startpos);
    cameraent setModel("tag_origin");
    cameraent.angles = player.angles;
    player.spawncameraent = cameraent;
    targetpos = player getEye();
    targetangles = player.angles;
    _id_4158F3E6AF3FC2E7 = startpos + (0, 0, 5000);
    _id_4158F3E6AF3FC2E7 = _id_4158F3E6AF3FC2E7 + anglesToForward(targetangles) * -100;
    player cameralinkTo(player.spawncameraent, "tag_origin", 1, 1);
    player.spawncameraent moveTo(_id_4158F3E6AF3FC2E7, 5.0, 4.0, 0.1);
    fwd = vectorNormalize(targetpos - cameraent.origin);
    _id_8003B0D4F9FBEE0E = scripts\mp\utility\script::vectortoanglessafe(fwd, (0, 0, 1));
    player.spawncameraent.angles = _id_8003B0D4F9FBEE0E;
    player thread lookatplayerupdate(targetangles);
    wait 2.0;
    player visionsetnakedforplayer("respawn_camera", 2.0);
  }
}

lookatplayerupdate(_id_0FE0C08DDC602E96) {
  self endon("disconnect");
  self endon("lookAtPlayerUpdate_stop");

  for(;;) {
    targetpos = self getEye();
    fwd = vectorNormalize(targetpos - self.spawncameraent.origin);
    _id_8003B0D4F9FBEE0E = scripts\mp\utility\script::vectortoanglessafe(fwd, (0, 0, 1));
    self.spawncameraent rotateTo(_id_8003B0D4F9FBEE0E, 0.75);
    waitframe();
  }
}

updateroundendreasontext(winner) {
  if(!level.teambased)
    return 1;

  if(scripts\mp\utility\game::ismoddedroundgame()) {
    if(scripts\mp\utility\game::hitscorelimit())
      return game["end_reason"]["score_limit_reached"];

    if(scripts\mp\utility\game::hittimelimit())
      return game["end_reason"]["time_limit_reached"];
  } else if(scripts\mp\utility\game::hitroundlimit())
    return game["end_reason"]["round_limit_reached"];

  if(scripts\mp\utility\game::hitwinlimit())
    return game["end_reason"]["score_limit_reached"];

  return game["end_reason"]["objective_completed"];
}

estimatedtimetillscorelimit(team) {
  if(!scripts\mp\utility\game::ismoddedroundgame()) {
    _id_CF9361AB200AF730 = getscoreperminute(team);
    _id_40FD7B61694E3BF7 = getscoreremaining(team);
    _id_E415364DE8D3892D = 999999;

    if(_id_CF9361AB200AF730)
      _id_E415364DE8D3892D = _id_40FD7B61694E3BF7 / _id_CF9361AB200AF730;

    return _id_E415364DE8D3892D;
  } else {
    _id_CF9361AB200AF730 = getscoreperminute(team);
    _id_40FD7B61694E3BF7 = getscoreperminute(team);
    _id_E415364DE8D3892D = 999999;

    if(_id_CF9361AB200AF730)
      _id_E415364DE8D3892D = _id_40FD7B61694E3BF7 / _id_CF9361AB200AF730;

    return _id_E415364DE8D3892D;
  }
}

closetoscorelimit(team) {
  _id_394D614159379768 = 10;
  _id_616BEAC13FEDFF48 = 20;
  scorelimit = level.roundscorelimit;

  switch (scripts\mp\utility\game::getgametype()) {
    case "tdef":
    case "dom":
      _id_616BEAC13FEDFF48 = 20;
      break;
    case "conf":
      _id_616BEAC13FEDFF48 = 10;
    case "conflict":
    case "arm":
      _id_616BEAC13FEDFF48 = scorelimit * 0.1;
      break;
    default:
      break;
  }

  _id_929A6DF466DC4F22 = getteamscore(team);
  _id_6D82488E12C4B8B0 = scorelimit - _id_929A6DF466DC4F22;

  if(_id_6D82488E12C4B8B0 <= scripts\engine\utility::ter_op(istrue(game["finalRound"]), _id_616BEAC13FEDFF48, _id_394D614159379768))
    return 1;

  return 0;
}

getscoreperminute(team) {
  _id_F40250902CCEBE1A = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;

  if(isPlayer(self))
    _id_CF9361AB200AF730 = self.score / _id_F40250902CCEBE1A;
  else
    _id_CF9361AB200AF730 = getteamscore(team) / _id_F40250902CCEBE1A;

  return _id_CF9361AB200AF730;
}

getscoreremaining(team) {
  scorelimit = level.roundscorelimit;

  if(isPlayer(self))
    _id_40FD7B61694E3BF7 = scorelimit - self.score;
  else
    _id_40FD7B61694E3BF7 = scorelimit - getteamscore(team);

  return _id_40FD7B61694E3BF7;
}

getscoreperminuteroundbased(team) {
  scorelimit = level.roundscorelimit;

  if(!game["switchedsides"]) {
    scorelimit = scorelimit / 2;
    _id_F40250902CCEBE1A = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    _id_CF9361AB200AF730 = getteamscore(team) / _id_F40250902CCEBE1A;
  } else {
    scorelimit = int(scorelimit / 2);
    _id_F40250902CCEBE1A = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    _id_929A6DF466DC4F22 = getteamscore(team);

    if(_id_929A6DF466DC4F22 >= scorelimit)
      _id_CF9361AB200AF730 = (_id_929A6DF466DC4F22 - scorelimit) / _id_F40250902CCEBE1A;
    else
      return 0;
  }

  return _id_CF9361AB200AF730;
}

givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_915F01BAA2419C9F");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(self.pers["team"] != _id_FABF84450735DD93)
      thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, _id_FABF84450735DD93);
  }

  level notify("last_alive", self);
}

processlobbydata() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    processlobbydataforclient(player);
  }

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch())
      setclientmatchdata("isPublicMatch", 1);
    else
      setclientmatchdata("isPublicMatch", 0);
  }

  scripts\mp\scoreboard::processlobbyscoreboards();

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0)
    sendclientmatchdata();
}

assignclientmatchdataid(player) {
  if(isDefined(player) && !isDefined(player.clientmatchdataid)) {
    player.clientmatchdataid = level.currentclientmatchdataid;
    level.currentclientmatchdataid++;
  }
}

processlobbydataforclient(player) {
  if(istrue(player.processlobbydataforclient)) {
    return;
  }
  player.processlobbydataforclient = 1;
  assignclientmatchdataid(player);
  _id_81A6DCF8641471F7 = player.name;

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
    setclientmatchdata("players", player.clientmatchdataid, "clanTag", player getclantag());
    setclientmatchdata("players", player.clientmatchdataid, "xuidHigh", player getxuidhigh());
    setclientmatchdata("players", player.clientmatchdataid, "xuidLow", player getxuidlow());
    setclientmatchdata("players", player.clientmatchdataid, "isBot", isbot(player));
    setclientmatchdata("players", player.clientmatchdataid, "uniqueClientId", player.clientid);
    setclientmatchdata("players", player.clientmatchdataid, "username", _id_81A6DCF8641471F7);

    if(player isps4player())
      setclientmatchdata("players", player.clientmatchdataid, "platform", "ps4");
    else if(player isxb3player())
      setclientmatchdata("players", player.clientmatchdataid, "platform", "xb3");
    else if(player ispcplayer())
      setclientmatchdata("players", player.clientmatchdataid, "platform", "bnet");
    else
      setclientmatchdata("players", player.clientmatchdataid, "platform", "none");
  }

  player setplayerdata("common", "round", "clientMatchIndex", player.clientmatchdataid);
  player scripts\mp\scoreboard::setplayerscoreboardinfo();
}

trackleaderboarddeathstats(attacker, victim, sweapon, smeansofdeath) {
  if(isDefined(victim._id_F08DA114FFD85042) && victim._id_F08DA114FFD85042 == victim.lifeid) {
    return;
  }
  victim thread threadedsetweaponstatbyname(sweapon, 1, "deaths", attacker);
  victim thread threadedsetweaponstatbyname(sweapon, distancesquared(attacker.origin, victim.origin), "cumulative_death_distance_sq");
}

trackattackerleaderboarddeathstats(attacker, victim, sweapon, smeansofdeath) {
  if(isDefined(attacker) && isPlayer(attacker)) {
    if(isDefined(smeansofdeath) && smeansofdeath.size > 0) {
      if(isDefined(sweapon) && sweapon.size > 0) {
        if(isDefined(victim)) {
          if(isDefined(attacker)) {
            if(smeansofdeath != "MOD_FALLING") {
              if(istrue(attacker.modifiers["ads"]))
                attacker thread threadedsetweaponstatbyname(sweapon, 1, "ads_kills", victim);

              attacker thread threadedsetweaponstatbyname(sweapon, 1, "kills");
              attacker thread threadedsetweaponstatbyname(sweapon, distancesquared(attacker.origin, victim.origin), "cumulative_kill_distance_sq");
            }

            if(smeansofdeath == "MOD_HEAD_SHOT")
              attacker thread threadedsetweaponstatbyname(sweapon, 1, "headShots", victim);
          } else {}
        } else {}
      } else {}
    } else {}
  }
}

setweaponstat(weapon, _id_A1D4E7D5EF9DA660, _id_629757F5C9E770D8, _id_AE9ACDDA1C693FA6) {
  if(!_id_A1D4E7D5EF9DA660) {
    return;
  }
  if(getdvarint("dvar_1B5ABAF35DFDB4E4", 1) == 1 && istrue(game["inLiveLobby"])) {
    return;
  }
  objweapon = undefined;

  if(isweapon(weapon))
    objweapon = weapon;
  else
    objweapon = makeweaponfromstring(weapon);

  objweapon = scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);

  if(!isDefined(objweapon)) {
    return;
  }
  weaponname = objweapon.basename;
  _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon);
  variantid = getweaponvariantindex(objweapon);
  _id_11D2F075E9A0E643 = scripts\mp\utility\weapon::getequipmenttype(weapon);

  if(isDefined(_id_11D2F075E9A0E643) && _id_11D2F075E9A0E643 == "lethal") {
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(objweapon);
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = _id_629757F5C9E770D8;
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = _id_A1D4E7D5EF9DA660;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_7E2C53B0BCF117D9.weaponobj = objweapon;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
    return;
  }

  if(_id_CF4209C200F8BBF4 == "super") {
    shouldtracksuperweaponstats = scripts\mp\supers::shouldtracksuperweaponstats(objweapon);

    if(isDefined(shouldtracksuperweaponstats) && !shouldtracksuperweaponstats)
      return;
  }

  if(_id_CF4209C200F8BBF4 == "killstreak" || _id_CF4209C200F8BBF4 == "other" && weaponname != "trophy_mp" || _id_CF4209C200F8BBF4 == "other" && weaponname != "player_trophy_system_mp" || _id_CF4209C200F8BBF4 == "other" && weaponname != "super_trophy_mp") {
    return;
  }
  if(scripts\mp\utility\weapon::isenvironmentweapon(objweapon)) {
    return;
  }
  if(_id_CF4209C200F8BBF4 == "weapon_grenade" || _id_CF4209C200F8BBF4 == "weapon_explosive" || weaponname == "trophy_mp" || weaponname == "forcepush_mp") {
    weaponname = scripts\mp\utility\script::strip_suffix(weaponname, "_mp");
    scripts\mp\persistence::incrementweaponstat(weaponname, _id_629757F5C9E770D8, _id_A1D4E7D5EF9DA660);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(objweapon);
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = _id_629757F5C9E770D8;
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = _id_A1D4E7D5EF9DA660;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_7E2C53B0BCF117D9.weaponobj = objweapon;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
    return;
  }

  if(!isDefined(self.trackingweapon))
    self.trackingweapon = objweapon;

  if(objweapon != self.trackingweapon) {
    scripts\mp\persistence::updateweaponbufferedstats();
    self.trackingweapon = objweapon;
  }

  switch (_id_629757F5C9E770D8) {
    case "shots":
      if(!isDefined(self.trackingweaponshots))
        self.trackingweaponshots = 0;

      self.trackingweaponshots = self.trackingweaponshots + _id_A1D4E7D5EF9DA660;
      break;
    case "hits":
      if(!isDefined(self.trackingweaponhits))
        self.trackingweaponhits = 0;

      self.trackingweaponhits = self.trackingweaponhits + _id_A1D4E7D5EF9DA660;
      break;
    case "ai_hits":
      if(!isDefined(self._id_A00EDDCF879BDBC3))
        self._id_A00EDDCF879BDBC3 = 0;

      self._id_A00EDDCF879BDBC3 = self._id_A00EDDCF879BDBC3 + _id_A1D4E7D5EF9DA660;
      break;
    case "player_hits":
      if(!isDefined(self._id_CA6E0D389C0CA0A7))
        self._id_CA6E0D389C0CA0A7 = 0;

      self._id_CA6E0D389C0CA0A7 = self._id_CA6E0D389C0CA0A7 + _id_A1D4E7D5EF9DA660;
      break;
    case "headShots":
      if(!isDefined(self.trackingweaponheadshots))
        self.trackingweaponheadshots = 0;

      self.trackingweaponheadshots = self.trackingweaponheadshots + _id_A1D4E7D5EF9DA660;

      if(_id_2E31277709B9F493(_id_AE9ACDDA1C693FA6)) {
        if(!isDefined(self._id_5FAC5778FE3FDC1C))
          self._id_5FAC5778FE3FDC1C = 0;

        self._id_5FAC5778FE3FDC1C = self._id_5FAC5778FE3FDC1C + _id_A1D4E7D5EF9DA660;
      }

      break;
    case "ai_headshots":
      if(!isDefined(self._id_9A2FD6F8771F2E58))
        self._id_9A2FD6F8771F2E58 = 0;

      self._id_9A2FD6F8771F2E58 = self._id_9A2FD6F8771F2E58 + _id_A1D4E7D5EF9DA660;
      break;
    case "player_headshots":
      if(!isDefined(self._id_5FAC5778FE3FDC1C))
        self._id_5FAC5778FE3FDC1C = 0;

      self._id_5FAC5778FE3FDC1C = self._id_5FAC5778FE3FDC1C + _id_A1D4E7D5EF9DA660;
      break;
    case "kills":
      if(!isDefined(self.trackingweaponkills))
        self.trackingweaponkills = 0;

      self.trackingweaponkills = self.trackingweaponkills + _id_A1D4E7D5EF9DA660;
      break;
    case "ads_kills":
      if(!isDefined(self._id_E16D751A51153A7B))
        self._id_E16D751A51153A7B = 0;

      self._id_E16D751A51153A7B = self._id_E16D751A51153A7B + _id_A1D4E7D5EF9DA660;

      if(_id_2E31277709B9F493(_id_AE9ACDDA1C693FA6)) {
        if(!isDefined(self._id_1FE884779E5F4DBE))
          self._id_1FE884779E5F4DBE = 0;

        self._id_1FE884779E5F4DBE = self._id_1FE884779E5F4DBE + _id_A1D4E7D5EF9DA660;
      }

      break;
    case "ai_ads_kills":
      if(!isDefined(self._id_2BF7B072E416002A))
        self._id_2BF7B072E416002A = 0;

      self._id_2BF7B072E416002A = self._id_2BF7B072E416002A + _id_A1D4E7D5EF9DA660;
      break;
    case "player_ads_kills":
      if(!isDefined(self._id_1FE884779E5F4DBE))
        self._id_1FE884779E5F4DBE = 0;

      self._id_1FE884779E5F4DBE = self._id_1FE884779E5F4DBE + _id_A1D4E7D5EF9DA660;
      break;
    case "deaths":
      if(_id_2B8D709C5B78BBEF(_id_AE9ACDDA1C693FA6)) {
        if(!isDefined(self._id_F00517AA8F668932))
          self._id_F00517AA8F668932 = 0;

        self._id_F00517AA8F668932 = self._id_F00517AA8F668932 + _id_A1D4E7D5EF9DA660;
      } else if(_id_2E31277709B9F493(_id_AE9ACDDA1C693FA6)) {
        if(!isDefined(self._id_14CEC2BA65099256))
          self._id_14CEC2BA65099256 = 0;

        self._id_14CEC2BA65099256 = self._id_14CEC2BA65099256 + _id_A1D4E7D5EF9DA660;
      }

      break;
    case "damage":
      if(!isDefined(self._id_883957B1C1EF6745))
        self._id_883957B1C1EF6745 = 0;

      self._id_883957B1C1EF6745 = self._id_883957B1C1EF6745 + _id_A1D4E7D5EF9DA660;

      if(_id_2B8D709C5B78BBEF(_id_AE9ACDDA1C693FA6)) {
        if(!isDefined(self._id_7B522BF6F7AECA98))
          self._id_7B522BF6F7AECA98 = 0;

        self._id_7B522BF6F7AECA98 = self._id_7B522BF6F7AECA98 + _id_A1D4E7D5EF9DA660;
      } else if(_id_2E31277709B9F493(_id_AE9ACDDA1C693FA6)) {
        if(!isDefined(self._id_BF617879DEF40524))
          self._id_BF617879DEF40524 = 0;

        self._id_BF617879DEF40524 = self._id_BF617879DEF40524 + _id_A1D4E7D5EF9DA660;
      }

      break;
  }

  if(_id_629757F5C9E770D8 == "deaths") {
    _id_EFD23879FFB610BD = undefined;
    _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);

    if(!scripts\mp\utility\weapon::iscacprimaryweapon(_id_49E6EF3EDADD524E) && !scripts\mp\utility\weapon::iscacsecondaryweapon(_id_49E6EF3EDADD524E)) {
      return;
    }
    attachments = getweaponattachments(objweapon);
    scripts\mp\persistence::incrementweaponstat(_id_49E6EF3EDADD524E, _id_629757F5C9E770D8, _id_A1D4E7D5EF9DA660);
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.weaponname = _id_49E6EF3EDADD524E;
    _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(objweapon);
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "deaths";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = _id_A1D4E7D5EF9DA660;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_7E2C53B0BCF117D9.weaponobj = objweapon;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);

    foreach(attachment in attachments) {
      scripts\mp\persistence::incrementattachmentstat(attachment, _id_629757F5C9E770D8, _id_A1D4E7D5EF9DA660, objweapon);
      scripts\common\utility::trycall(level.matchdata_logattachmentstat, attachment, _id_629757F5C9E770D8, _id_A1D4E7D5EF9DA660, objweapon);
    }
  }
}

setinflictorstat(einflictor, eattacker, sweapon) {
  if(!isDefined(eattacker)) {
    return;
  }
  if(!isDefined(einflictor)) {
    eattacker setweaponstat(sweapon, 1, "hits");
    return;
  }

  if(!isDefined(einflictor.playeraffectedarray))
    einflictor.playeraffectedarray = [];

  _id_7B77D51F10AE425A = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < einflictor.playeraffectedarray.size; _id_AC0E594AC96AA3A8++) {
    if(einflictor.playeraffectedarray[_id_AC0E594AC96AA3A8] == self) {
      _id_7B77D51F10AE425A = 0;
      break;
    }
  }

  if(_id_7B77D51F10AE425A) {
    einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
    eattacker setweaponstat(sweapon, 1, "hits");
  }
}

threadedsetweaponstatbyname(name, _id_A1D4E7D5EF9DA660, _id_629757F5C9E770D8, _id_AE9ACDDA1C693FA6) {
  self endon("disconnect");
  waittillframeend;
  setweaponstat(name, _id_A1D4E7D5EF9DA660, _id_629757F5C9E770D8, _id_AE9ACDDA1C693FA6);
}

_id_A3F0B7ABA215EF11(_id_AE9ACDDA1C693FA6) {
  if(!isDefined(_id_AE9ACDDA1C693FA6))
    return 0;

  if(isagent(_id_AE9ACDDA1C693FA6))
    return 2;
  else if(isPlayer(_id_AE9ACDDA1C693FA6))
    return 1;

  return 0;
}

_id_2B8D709C5B78BBEF(ent) {
  type = _id_A3F0B7ABA215EF11(ent);
  return isDefined(type) && type == 2;
}

_id_2E31277709B9F493(ent) {
  type = _id_A3F0B7ABA215EF11(ent);
  return isDefined(type) && type == 1;
}

updatespmstats() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player scripts\mp\utility\game::onlinestatsenabled()) {
      _id_BE73E2030B336DDD = getmatchspm(player);
      _id_3BB40B75EECB6F17 = scripts\engine\utility::ter_op(level.teambased, player.score, player.pers["gamemodeScore"]);
      _id_DCD3AECD83289824 = player getplayerdata(level._id_5D69837CF4DB0407, "globalSPM");
      _id_19FD2738F64F68AB = player scripts\mp\playerstats_interface::getplayerstat("matchStats", "gamesPlayed");
      _id_DCD3AECD83289824 = _id_DCD3AECD83289824 * (_id_19FD2738F64F68AB - 1);
      _id_CFF58B2C41422F10 = _id_BE73E2030B336DDD;

      if(_id_19FD2738F64F68AB > 0)
        _id_CFF58B2C41422F10 = (_id_DCD3AECD83289824 + _id_BE73E2030B336DDD) / _id_19FD2738F64F68AB;

      player setplayerdata(level._id_5D69837CF4DB0407, "globalSPM", int(_id_CFF58B2C41422F10));
      _id_4C1B06F2836318D9 = getgametypeindex(scripts\mp\utility\game::getgametype());
      maxgamemodescorehistory = 5;
      maxgamemodes = 32;

      if(_id_4C1B06F2836318D9 >= 0 && _id_4C1B06F2836318D9 < maxgamemodes) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
          _id_D4145D9E255225DC = player getplayerdata(level._id_5D69837CF4DB0407, "gameModeHistory", _id_AC0E594AC96AA3A8 + 1);
          player setplayerdata(level._id_5D69837CF4DB0407, "gameModeHistory", _id_AC0E594AC96AA3A8, _id_D4145D9E255225DC);
        }

        player setplayerdata(level._id_5D69837CF4DB0407, "gameModeHistory", 4, scripts\mp\utility\game::getgametype());
        _id_D5999635907B7EEF = player getplayerdata(level._id_5D69837CF4DB0407, "gameModeScoreHistory", _id_4C1B06F2836318D9, "index");
        player setplayerdata(level._id_5D69837CF4DB0407, "gameModeScoreHistory", _id_4C1B06F2836318D9, "scores", _id_D5999635907B7EEF, int(_id_BE73E2030B336DDD));
        player setplayerdata(level._id_5D69837CF4DB0407, "gameModeScoreHistory", _id_4C1B06F2836318D9, "actualScores", _id_D5999635907B7EEF, int(_id_3BB40B75EECB6F17));
        player setplayerdata(level._id_5D69837CF4DB0407, "gameModeScoreHistory", _id_4C1B06F2836318D9, "gameMode", scripts\mp\utility\game::getgametype());
        _id_D5999635907B7EEF = (_id_D5999635907B7EEF + 1) % maxgamemodescorehistory;
        player setplayerdata(level._id_5D69837CF4DB0407, "gameModeScoreHistory", _id_4C1B06F2836318D9, "index", _id_D5999635907B7EEF);
      }
    }
  }
}

checkforpersonalbests() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player scripts\mp\utility\game::onlinestatsenabled()) {
      _id_7269C381EAF9B5D4 = player getplayerdata("common", "round", "kills");
      _id_B25C6BCD4FD1F8F0 = player getplayerdata("common", "round", "deaths");
      _id_C36875D4BEA155CF = player.pers["summary"]["xp"];
      _id_D2EE14B9A6A5C2C0 = player scripts\mp\playerstats_interface::getplayerstat("bestStats", "killsInAMatch");
      _id_A6E0FB465F2CE5C5 = player scripts\mp\playerstats_interface::getplayerstat("bestStats", "deathsInAMatch");
      _id_04E7118FDE602D1E = player scripts\mp\playerstats_interface::getplayerstat("bestStats", "xpInAMatch");
      _id_F6D2208B3825E747 = player getplayerdata(level._id_5D69837CF4DB0407, "bestSPM", "score");
      _id_94BAAD62773A1AE4 = player getplayerdata(level._id_5D69837CF4DB0407, "bestKD", "score");

      if(_id_7269C381EAF9B5D4 > _id_D2EE14B9A6A5C2C0)
        player scripts\mp\playerstats_interface::setplayerstat(_id_7269C381EAF9B5D4, "bestStats", "killsInAMatch");

      if(_id_C36875D4BEA155CF > _id_04E7118FDE602D1E)
        player scripts\mp\playerstats_interface::setplayerstat(_id_C36875D4BEA155CF, "bestStats", "xpInAMatch");

      if(_id_B25C6BCD4FD1F8F0 > _id_A6E0FB465F2CE5C5)
        player scripts\mp\playerstats_interface::setplayerstat(_id_B25C6BCD4FD1F8F0, "bestStats", "deathsInAMatch");

      _id_CE3B2F78F590611E = _id_7269C381EAF9B5D4;

      if(_id_B25C6BCD4FD1F8F0 > 1)
        _id_CE3B2F78F590611E = _id_CE3B2F78F590611E / _id_B25C6BCD4FD1F8F0;

      _id_CE3B2F78F590611E = int(_id_CE3B2F78F590611E * 1000);

      if(_id_CE3B2F78F590611E > _id_94BAAD62773A1AE4) {
        player setplayerdata(level._id_5D69837CF4DB0407, "bestKD", "score", _id_CE3B2F78F590611E);
        player setplayerdata(level._id_5D69837CF4DB0407, "bestKD", "time", getsystemtime());
      }

      _id_BE73E2030B336DDD = getmatchspm(player);

      if(_id_BE73E2030B336DDD > _id_F6D2208B3825E747) {
        player setplayerdata(level._id_5D69837CF4DB0407, "bestSPM", "score", int(_id_BE73E2030B336DDD));
        player setplayerdata(level._id_5D69837CF4DB0407, "bestSPM", "time", getsystemtime());
      }

      player checkforbestweapon();
    }
  }
}

allowleaderboardstatsupdates() {
  return level.onlinestatsenabled && isleaderboardsupportedmode();
}

updateleaderboardstatscontinuous() {
  level endon("game_ended");
  level endon("stop_leaderboard_stats");

  if(!allowleaderboardstatsupdates()) {
    return;
  }
  _id_EF50426720E1DBB8 = 0;

  for(;;) {
    while(!isDefined(level.players) || level.players.size == 0)
      waitframe();

    if(_id_EF50426720E1DBB8 >= level.players.size)
      _id_EF50426720E1DBB8 = 0;

    player = level.players[_id_EF50426720E1DBB8];

    if(!isDefined(player) || isai(player))
      waitframe();
    else {
      player updateplayerleaderboardstatsinternal();
      wait 0.1;
    }

    _id_EF50426720E1DBB8++;
  }
}

updateleaderboardstats() {
  if(!allowleaderboardstatsupdates()) {
    return;
  }
  foreach(player in level.players) {
    if(!isDefined(player) || isai(player)) {
      continue;
    }
    player updateplayerleaderboardstatsinternal();
  }
}

updateplayerleaderboardstats() {
  if(!allowleaderboardstatsupdates()) {
    return;
  }
  if(!isDefined(self) || isai(self)) {
    return;
  }
  updateplayerleaderboardstatsinternal();
}

isleaderboardsupportedmode() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 1;

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    _id_50DF43417B876C9F = "hc_";
  else
    _id_50DF43417B876C9F = "";

  _id_50DF43417B876C9F = _id_50DF43417B876C9F + scripts\mp\utility\game::getgametype();

  switch (_id_50DF43417B876C9F) {
    case "hc_arm":
    case "hc_cyber":
    case "hc_hq":
    case "hc_arena":
    case "hc_tdef":
    case "hc_dm":
    case "hc_conf":
    case "hc_sd":
    case "hc_dom":
    case "hc_war":
    case "cmd":
    case "grnd":
    case "grind":
    case "dm":
    case "war":
    case "koth":
    case "hq":
    case "pill":
    case "gun":
    case "conf":
    case "conflict":
    case "dd":
    case "ctf":
    case "cyber":
    case "siege":
    case "sr":
    case "sd":
    case "dom":
    case "infect":
    case "arena":
    case "arm":
      return 1;
    default:
      return 0;
  }

  return 0;
}

_id_8F54DEEC605690D1(type) {
  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    return 1;

  return isDefined(type) && (type == "dmz" || type == "exgm" || type == "plunder" || type == "risk" || type == "kingslayer");
}

updateplayerleaderboardstatsinternal() {
  _id_50DF43417B876C9F = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19())
    _id_50DF43417B876C9F = "hc_";
  else
    _id_50DF43417B876C9F = "";

  _id_50DF43417B876C9F = _id_50DF43417B876C9F + scripts\mp\utility\game::getgametype();

  if(isDefined(level.brgametype) && isDefined(level.brgametype.name)) {
    switch (level.brgametype.name) {
      case "gxp":
      case "resurgence_mgl":
      case "zonecontrol":
      case "resurgence":
      case "mini_mgl":
      case "mini":
      case "sandbox":
      case "evac":
      case "extract":
      case "champion":
      case "kingslayer":
      case "dmz":
        _id_50DF43417B876C9F = _id_50DF43417B876C9F + ("_" + level.brgametype.name);
        break;
      case "exgm":
        _id_50DF43417B876C9F = _id_50DF43417B876C9F + "_dmz";
        break;
      case "aladdin":
      case "":
        break;
      default:
        return;
    }
  }

  _id_438D6FDE6AB2875C = scripts\engine\utility::ter_op(level.teambased, self.score, self.leaderboarddata["gamemodeScore"]);
  incrementleaderboardstat("score", _id_50DF43417B876C9F, _id_438D6FDE6AB2875C);
  timeplayed = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  incrementleaderboardstat("timePlayed", _id_50DF43417B876C9F, timeplayed);
  incrementleaderboardstat("kills", _id_50DF43417B876C9F, self.leaderboarddata["kills"]);
  incrementleaderboardstat("deaths", _id_50DF43417B876C9F, self.leaderboarddata["deaths"]);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    incrementleaderboardstat("downs", _id_50DF43417B876C9F, self.leaderboarddata["downs"]);
    incrementleaderboardstat("contracts", _id_50DF43417B876C9F, self.leaderboarddata["contracts"]);
    incrementleaderboardstat("wins", _id_50DF43417B876C9F, self.leaderboarddata["wins"]);
    incrementleaderboardstat("topFive", _id_50DF43417B876C9F, self.leaderboarddata["topFive"]);
    incrementleaderboardstat("topTen", _id_50DF43417B876C9F, self.leaderboarddata["topTen"]);
    incrementleaderboardstat("topTwentyFive", _id_50DF43417B876C9F, self.leaderboarddata["topTwentyFive"]);
    incrementleaderboardstat("gamesPlayed", _id_50DF43417B876C9F, self.leaderboarddata["gamesPlayed"]);
    incrementleaderboardstat("revives", _id_50DF43417B876C9F, self.leaderboarddata["rescues"]);
    incrementleaderboardstat("cash", _id_50DF43417B876C9F, self.leaderboarddata["cash"]);
    incrementleaderboardstat("eliteStarted", _id_50DF43417B876C9F, self.leaderboarddata["eliteStarted"]);
    incrementleaderboardstat("eliteCompleted", _id_50DF43417B876C9F, self.leaderboarddata["eliteCompleted"]);
    incrementleaderboardstat("eliteBlocked", _id_50DF43417B876C9F, self.leaderboarddata["eliteBlocked"]);
  } else {
    switch (scripts\mp\utility\game::getgametype()) {
      case "war":
        incrementleaderboardstat("assists", _id_50DF43417B876C9F, self.leaderboarddata["assists"]);
        break;
      case "arena":
        incrementleaderboardstat("damage", _id_50DF43417B876C9F, self.leaderboarddata["damage"]);
        incrementleaderboardstat("assists", _id_50DF43417B876C9F, self.leaderboarddata["assists"]);
        break;
      case "bounty":
        incrementleaderboardstat("assists", _id_50DF43417B876C9F, self.leaderboarddata["assists"]);
        incrementleaderboardstat("hvtKills", _id_50DF43417B876C9F, self.leaderboarddata["hvtKills"]);
      case "conflict":
      case "arm":
        incrementleaderboardstat("captures", _id_50DF43417B876C9F, self.leaderboarddata["captures"]);
        incrementleaderboardstat("defends", _id_50DF43417B876C9F, self.leaderboarddata["defends"]);
        break;
      case "cyber":
        incrementleaderboardstat("revives", _id_50DF43417B876C9F, self.leaderboarddata["rescues"]);
        incrementleaderboardstat("plants", _id_50DF43417B876C9F, self.leaderboarddata["plants"]);
        break;
      case "dm":
        updateleaderboardstatmaximum("streak", _id_50DF43417B876C9F, self.leaderboarddata["killChains"]);
        break;
      case "dom":
        incrementleaderboardstat("captures", _id_50DF43417B876C9F, self.leaderboarddata["captures"]);
        incrementleaderboardstat("defends", _id_50DF43417B876C9F, self.leaderboarddata["defends"]);
        break;
      case "sd":
        incrementleaderboardstat("plants", _id_50DF43417B876C9F, self.leaderboarddata["plants"]);
        incrementleaderboardstat("defuses", _id_50DF43417B876C9F, self.leaderboarddata["defuses"]);
        break;
      case "conf":
        incrementleaderboardstat("confirms", _id_50DF43417B876C9F, self.leaderboarddata["confirmed"]);
        incrementleaderboardstat("denies", _id_50DF43417B876C9F, self.leaderboarddata["denied"]);
        break;
      case "hq":
        incrementleaderboardstat("captures", _id_50DF43417B876C9F, self.leaderboarddata["captures"]);
        incrementleaderboardstat("defends", _id_50DF43417B876C9F, self.leaderboarddata["defends"]);
        break;
      case "koth":
        incrementleaderboardstat("objTime", _id_50DF43417B876C9F, self.leaderboarddata["objTime"]);
        incrementleaderboardstat("defends", _id_50DF43417B876C9F, self.leaderboarddata["defends"]);
        break;
      case "ctf":
        incrementleaderboardstat("captures", _id_50DF43417B876C9F, self.leaderboarddata["captures"]);
        incrementleaderboardstat("returns", _id_50DF43417B876C9F, self.leaderboarddata["returns"]);
        break;
      case "sr":
        incrementleaderboardstat("plants", _id_50DF43417B876C9F, self.leaderboarddata["plants"]);
        incrementleaderboardstat("rescues", _id_50DF43417B876C9F, self.leaderboarddata["rescues"]);
        break;
      case "siege":
        incrementleaderboardstat("captures", _id_50DF43417B876C9F, self.leaderboarddata["captures"]);
        incrementleaderboardstat("revives", _id_50DF43417B876C9F, self.leaderboarddata["rescues"]);
        break;
      case "grind":
        incrementleaderboardstat("banks", _id_50DF43417B876C9F, self.leaderboarddata["confirmed"]);
        incrementleaderboardstat("denies", _id_50DF43417B876C9F, self.leaderboarddata["denied"]);
        break;
      case "infect":
        incrementleaderboardstat("time", _id_50DF43417B876C9F, scripts\mp\utility\stats::getpersstat("extrascore0"));
        incrementleaderboardstat("infected", _id_50DF43417B876C9F, self.leaderboarddata["killsAsInfected"]);
        break;
      case "gun":
        incrementleaderboardstat("stabs", _id_50DF43417B876C9F, self.leaderboarddata["stabs"]);
        incrementleaderboardstat("setBacks", _id_50DF43417B876C9F, self.leaderboarddata["setbacks"]);
        break;
      case "grnd":
        incrementleaderboardstat("objTime", _id_50DF43417B876C9F, self.leaderboarddata["objTime"]);
        incrementleaderboardstat("defends", _id_50DF43417B876C9F, self.leaderboarddata["defends"]);
        break;
      case "cmd":
        incrementleaderboardstat("assists", _id_50DF43417B876C9F, self.leaderboarddata["assists"]);
        incrementleaderboardstat("captures", _id_50DF43417B876C9F, self.leaderboarddata["captures"]);
        incrementleaderboardstat("defends", _id_50DF43417B876C9F, self.leaderboarddata["defends"]);
        break;
      case "pill":
        incrementleaderboardstat("banks", _id_50DF43417B876C9F, self.leaderboarddata["confirmed"]);
        incrementleaderboardstat("denies", _id_50DF43417B876C9F, self.leaderboarddata["denied"]);
        break;
    }
  }
}

incrementleaderboardstat(_id_D0F001B1761FBF53, _id_50DF43417B876C9F, _id_41EA0C22879B01D3) {
  if(!isDefined(self.leaderboardstartvalues))
    self.leaderboardstartvalues = [];

  if(!isDefined(self.leaderboardstartvalues[_id_D0F001B1761FBF53]))
    self.leaderboardstartvalues[_id_D0F001B1761FBF53] = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "modeStats", _id_50DF43417B876C9F, _id_D0F001B1761FBF53);

  _id_D1044CF8EF47F871 = int(max(self.leaderboardstartvalues[_id_D0F001B1761FBF53] + _id_41EA0C22879B01D3, self.leaderboardstartvalues[_id_D0F001B1761FBF53]));
  self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "modeStats", _id_50DF43417B876C9F, _id_D0F001B1761FBF53, _id_D1044CF8EF47F871);
}

updateleaderboardstatmaximum(_id_D0F001B1761FBF53, _id_50DF43417B876C9F, _id_A775792B5F1AA47C) {
  _id_AFDFAD231E44E710 = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "modeStats", _id_50DF43417B876C9F, _id_D0F001B1761FBF53);

  if(_id_A775792B5F1AA47C > _id_AFDFAD231E44E710)
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "modeStats", _id_50DF43417B876C9F, _id_D0F001B1761FBF53, _id_A775792B5F1AA47C);
}

getmatchspm(player) {
  _id_BE73E2030B336DDD = scripts\engine\utility::ter_op(level.teambased, player.score, player.pers["gamemodeScore"]);
  _id_CC748B6D457627FE = player scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

  if(isDefined(_id_CC748B6D457627FE) && _id_CC748B6D457627FE > 0) {
    _id_6C681AD49BE4496A = _id_CC748B6D457627FE / 60;
    _id_BE73E2030B336DDD = _id_BE73E2030B336DDD / _id_6C681AD49BE4496A;
  }

  return _id_BE73E2030B336DDD;
}

isvalidbestweapon(_id_AB501F397D3CD312) {
  group = scripts\mp\utility\weapon::getweapongroup(_id_AB501F397D3CD312);
  return isDefined(_id_AB501F397D3CD312) && _id_AB501F397D3CD312 != "" && !_id_2669878CF5A1B6BC::iskillstreakweapon(_id_AB501F397D3CD312) && group != "killstreak" && group != "other";
}

checkforbestweapon() {
  _id_4099730BCFEBA731 = scripts\common\utility::trycall(level.matchdata_buildweaponrootlist);
  _id_312EE165E8200728 = "";
  _id_F58A5057A72BA410 = -1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4099730BCFEBA731.size; _id_AC0E594AC96AA3A8++) {
    weaponname = _id_4099730BCFEBA731[_id_AC0E594AC96AA3A8];
    weaponname = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);

    if(isvalidbestweapon(weaponname)) {
      if(!isenumvaluevalid(level._id_5D69837CF4DB0407, "WeaponStats", weaponname)) {
        continue;
      }
      weaponkills = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "weaponStats", weaponname, "kills");

      if(weaponkills > _id_F58A5057A72BA410) {
        _id_312EE165E8200728 = weaponname;
        _id_F58A5057A72BA410 = weaponkills;
      }
    }
  }

  _id_6662868EE2BC382A = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "weaponStats", _id_312EE165E8200728, "shots");
  _id_ECD73324545CD738 = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "weaponStats", _id_312EE165E8200728, "headShots");
  _id_76087327B8E72023 = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "weaponStats", _id_312EE165E8200728, "hits");
  _id_4C6269C801C04292 = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "weaponStats", _id_312EE165E8200728, "deaths");
  _id_CC603E175ABFEF2D = 0;
  self setplayerdata(level._id_5D69837CF4DB0407, "bestWeapon", "kills", _id_F58A5057A72BA410);
  self setplayerdata(level._id_5D69837CF4DB0407, "bestWeapon", "shots", _id_6662868EE2BC382A);
  self setplayerdata(level._id_5D69837CF4DB0407, "bestWeapon", "headShots", _id_ECD73324545CD738);
  self setplayerdata(level._id_5D69837CF4DB0407, "bestWeapon", "hits", _id_76087327B8E72023);
  self setplayerdata(level._id_5D69837CF4DB0407, "bestWeapon", "deaths", _id_4C6269C801C04292);
  self setplayerdata(level._id_5D69837CF4DB0407, "bestWeaponXP", _id_CC603E175ABFEF2D);
}

allow_weapon_mp(_id_E3108E412AFB3811) {
  self notify("allow_weapon_mp()");

  if(_id_E3108E412AFB3811) {
    if(isDefined(self.allowweaponcache) && !self hasweapon(self.allowweaponcache) && !scripts\mp\utility\killstreak::isjuggernaut())
      scripts\mp\utility\inventory::switchtolastweapon();

    self.allowweaponcache = undefined;
  } else {
    self.allowweaponcache = self.lastnormalweaponobj;
    thread watchinvalidweaponswitchduringdisableweapon();
  }
}

allow_weapon_mp_init() {
  level.allow_weapon_mp = ::allow_weapon_mp;
}

watchinvalidweaponswitchduringdisableweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("allow_weapon_mp()");

  for(;;) {
    self waittill("weapon_switch_invalid", _id_DDF65301F7D23098);
    self.allowweaponcache = _id_DDF65301F7D23098;
  }
}

ismp_init() {
  level.ismp = 1;
}

watchforlowpopmatchstart(_id_EB2B338EC4671678) {
  if(!istrue(level.lowpopcheck)) {
    return;
  }
  if(!isDefined(_id_EB2B338EC4671678))
    _id_EB2B338EC4671678 = 0;

  level endon("start_prematch");
  _id_80593585EB825BA2 = getdvarint("dvar_05E1370F70979F8B", 1);
  _id_B81ADEF81193B335 = -1;
  starttime = gettime();

  for(;;) {
    _id_490292ACB7F40A1E = getdvarint("dvar_40D1FE46F9D6F48E", 50);
    _id_5F5B788D766145C0 = getdvarfloat("dvar_6EF3783F07957A9B", 300) * 1000;
    _id_D12A341B40354143 = scripts\engine\utility::ter_op(_id_EB2B338EC4671678, getactiveclientcount(_id_80593585EB825BA2), level.players.size);

    if(_id_B81ADEF81193B335 >= 0) {
      _id_A28594C1B7CC010C = _id_B81ADEF81193B335 + _id_5F5B788D766145C0;

      if(_id_D12A341B40354143 >= _id_490292ACB7F40A1E && gettime() >= _id_A28594C1B7CC010C && !istrue(level.devoverridematchstart)) {
        break;
      }
    } else if(_id_D12A341B40354143 >= _id_490292ACB7F40A1E)
      _id_B81ADEF81193B335 = gettime();

    waitframe();
  }

  _id_5DDC7308BABF9834 = getdvarint("dvar_40AEF046F9B08E0C", 100);
  _id_D12A341B40354143 = scripts\engine\utility::ter_op(_id_EB2B338EC4671678, getactiveclientcount(_id_80593585EB825BA2), level.players.size);

  if(_id_D12A341B40354143 <= _id_5DDC7308BABF9834) {
    level.lowpopstart = 1;
    waittime = gettime() - starttime;
    _id_2AACACC9B90E191D = getdvarfloat("dvar_6EF3783F07957A9B", 300);
    dlog_recordevent("dlog_event_low_pop_start", ["start_players", _id_D12A341B40354143, "wait_time_ms", waittime, "active_client_count", _id_EB2B338EC4671678, "lowpop_min", _id_490292ACB7F40A1E, "lowpop_max", _id_5DDC7308BABF9834, "lowpop_time", _id_2AACACC9B90E191D]);

    if(isDefined(level.onlowpopstart))
      [[level.onlowpopstart]]();
  }

  waitframe();
  level notify("start_prematch");
}

watchforminplayersmatchstart() {
  level endon("start_prematch");
  _id_80593585EB825BA2 = getdvarint("dvar_05E1370F70979F8B", 1);
  _id_428422CF7B2EB8AC = gettime();
  _id_0E5EAE91657533F2 = _id_428422CF7B2EB8AC;
  _id_AED019C0E09D9E8B = getdvarint("live_lobby_minplayers_start");
  _id_7CC9D575418D740E = getdvarint("dvar_961774A7C9CF5B66", 0);

  if(_id_AED019C0E09D9E8B != 0) {
    for(;;) {
      if(istrue(level.devoverridematchstart)) {
        break;
      }

      if(getdvarint("dvar_51AA9C88BB0C1224", 1) == 1 && level._id_77907D733ABE8B63) {
        level waittill("leagueplay_br_backfill_closed");
        break;
      }

      _id_AC0F8BE89FA21057 = (_id_0E5EAE91657533F2 - _id_428422CF7B2EB8AC) / 1000;
      _id_A37E3649CFB19F73 = getdvarint("dvar_F79CD84983250EDA", 300);

      if(_id_A37E3649CFB19F73 > 0 && _id_AC0F8BE89FA21057 >= _id_A37E3649CFB19F73) {
        if(_id_7CC9D575418D740E == 0 || _id_7CC9D575418D740E <= getactiveclientcount(_id_80593585EB825BA2)) {
          break;
        }
      }

      if(_id_AC0F8BE89FA21057 <= getdvarint("dvar_738A4F27BFAC1D24", 15)) {
        if(getactiveclientcount(0) >= getdvarint("live_lobby_minplayers_start")) {
          break;
        }
      } else if(getactiveclientcount(_id_80593585EB825BA2) >= getdvarint("live_lobby_minplayers_start")) {
        break;
      }

      if(isDefined(level._id_CB87DB3F189CF3F1))
        [[level._id_CB87DB3F189CF3F1]](_id_A37E3649CFB19F73, _id_AC0F8BE89FA21057);

      waitframe();
      _id_0E5EAE91657533F2 = gettime();
    }
  }

  waitframe();
  level notify("start_prematch");
}

brwatchforminplayersmatchstart() {
  level endon("start_prematch");

  while(level.players.size < getdvarint("br_minplayers") || istrue(level.devoverridematchstart))
    waitframe();

  waitframe();
  level notify("start_prematch");
}

watchdevoverridematchstart() {
  level.startbuttons = [];
  _id_8811D5121BA0A25A = getEntArray("start_lobby_trigger", "targetname");
  level thread waitforoverridematchstartdvar();
  level thread waitforoverridematchstartnotify();

  if(_id_8811D5121BA0A25A.size == 0)
    level thread waitforinitialplayerloadspawnflag();
  else {
    foreach(trigger in _id_8811D5121BA0A25A) {
      if(isDefined(trigger.target))
        visuals[0] = getEnt(trigger.target, "targetname");
      else {
        visuals[0] = spawn("script_model", trigger.origin);
        visuals[0].angles = trigger.angles;
      }

      _id_241255DAED14734B = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 64), undefined, 1);
      _id_241255DAED14734B scripts\mp\gameobjects::allowuse("any");
      _id_241255DAED14734B.id = "use";
      _id_241255DAED14734B.trigger setuseprioritymax();
      _id_241255DAED14734B scripts\mp\gameobjects::setusetime(3);
      _id_241255DAED14734B scripts\mp\gameobjects::setusehinttext(&"MP_INGAME_ONLY/HOLD_TO_START_GAME");
      _id_241255DAED14734B.onuse = ::startbutton_onuse;
      level.startbuttons[level.startbuttons.size] = _id_241255DAED14734B;
    }
  }
}

waitforinitialplayerloadspawnflag() {
  level endon("game_ended");
  level endon("start_prematch");
  level waittill("connected", player);
  player waittill("giveLoadout");
  waitframe();
  visuals[0] = spawn("script_model", player.origin);
  trigger = visuals[0];
  visuals[0] setModel("tag_origin");
  useteam = "any";
  usetime = 3;
  org = (31983, -35229, -458);
  trigger.team = "neutral";
  level.startbuttons[0] = scripts\mp\gameobjects::createholduseobject(useteam, trigger, visuals, (0, 0, 0));
  level.startbuttons[0].curorigin = org;
  level.startbuttons[0].trigger.origin = org;
  level.startbuttons[0].visuals[0].origin = org;
  level.startbuttons[0].trigger makeusable();
  level.startbuttons[0].ownerteam = trigger.team;
  level.startbuttons[0].trigger.owner = level.players[0];
  level.startbuttons[0].interactteam = "any";
  level.startbuttons[0].curprogress = 0;
  level.startbuttons[0].userate = 1;
  level.startbuttons[0].id = "use";
  level.startbuttons[0].exclusiveuse = 0;
  level.startbuttons[0].exclusiveclaim = 1;
  level.startbuttons[0].skiptouching = 1;
  level.startbuttons[0].skipminimapids = 1;
  level.startbuttons[0].trigger setCursorHint("HINT_NOICON");
  level.startbuttons[0].trigger setusehideprogressbar(1);
  level.startbuttons[0].trigger setHintString(&"MP_INGAME_ONLY/HOLD_TO_START_GAME");
  level.startbuttons[0].trigger setuseprioritymax();
  level.startbuttons[0].onuse = ::startbutton_onuse;
  level.startbuttons[0].flagmodel = spawn("script_model", org);
  level.startbuttons[0].flagmodel setModel("prop_flag_neutral");
  level.startbuttons[0].usabilitytrigger = spawn("trigger_radius", org, 0, 32, 128);
  level.startbuttons[0] scripts\mp\gameobjects::setusetime(usetime);
}

waitforoverridematchstartdvar() {
  level endon("game_ended");
  level endon("dev_force_start_completed");

  for(;;) {
    if(getdvarint("dvar_0A2AAA37F176AA49", 0)) {
      dev_forcelivelobbystart();
      break;
    }

    wait 0.5;
  }
}

waitforoverridematchstartnotify() {
  level endon("game_ended");
  level endon("dev_force_start_completed");
  level waittill("forcematchstart");
  dev_forcelivelobbystart();
}

startbutton_onuse(player) {
  player setclientomnvar("ui_securing", 0);
  dev_forcelivelobbystart();
}

dev_forcelivelobbystart() {
  level thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured");

  foreach(team in level.teamnamelist)
  scripts\mp\utility\print::teamhudtutorialmessage("MP_INGAME_ONLY/GAME_FORCE_STARTED", team, 10);

  setDvar("br_minplayers", 1);
  setDvar("live_lobby_minplayers_start", 1);
  level notify("start_prematch");

  foreach(button in level.startbuttons) {
    button scripts\mp\gameobjects::allowuse("none");
    button.trigger = undefined;
    button.visibleteam = "none";
    button.flagmodel delete();
    button notify("deleted");
  }

  level notify("dev_force_start_completed");
}

livelobbyrestart() {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;
  game["blockJIP"] = 1;
  waitframe();
  setgameendflagsandnotifies(undefined);
  waitframe();
  setgameendtime(0);
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled())
    scripts\mp\analyticslog::analyticsstorespawndata();

  if(isDefined(level.matchrecording_dump))
    [[level.matchrecording_dump]]();

  setDvar("g_deadChat", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("bg_compassShowEnemies", 0);
  livelobbyroundendwait(1);
  level notify("game_cleanup");
  setslowmotion(1.0, 0.4, 3);
  resetsoundtimescalefactor();
  scripts\mp\flags::levelflagclear("block_notifies");
  restart();
}

livelobbyroundendwait(_id_5EF4D54BB701E295) {
  _id_8D539C1577794D34 = 0;

  foreach(player in level.players) {
    player thread scripts\mp\utility\game::setuipostgamefade(0);

    if(player _meth_8420670EAFC8D391())
      _id_8D539C1577794D34 = level._id_7210BB7B0BFBCFDB;
  }

  wait(_id_5EF4D54BB701E295 + _id_8D539C1577794D34);
  level notify("round_end_finished");
}

livelobbymatchstarttimer(type, duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level endon("match_cancel_timer_beginning");
  level notify("match_start_timer_beginning");

  if(istrue(level._id_60F7D8BD0181980F)) {
    return;
  }
  _id_B710552E5D79A601 = int(duration);

  if(_id_B710552E5D79A601 >= 2) {
    setomnvar("ui_match_start_text", type);
    matchstarttimerperplayer_internal(_id_B710552E5D79A601);
  }

  visionsetnaked("", 0.0);
}

clearmatchhasmorethan1playervariablesonroundend() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

updatematchhasmorethan1playeromnvaronplayersfirstspawn() {
  _id_2D9482A14615CC39 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1)
      game["matchHasMoreThan1Player"] = 1;
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!_id_2D9482A14615CC39) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
        level.players[_id_AC0E594AC96AA3A8] setclientomnvar("match_has_more_than_1_player", 1);
    } else
      self setclientomnvar("match_has_more_than_1_player", 1);
  }
}

updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  _id_2D9482A14615CC39 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]--;

  if(game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] <= 1)
      game["matchHasMoreThan1Player"] = 0;
  }

  if(!game["matchHasMoreThan1Player"]) {
    if(_id_2D9482A14615CC39) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
        level.players[_id_AC0E594AC96AA3A8] setclientomnvar("match_has_more_than_1_player", 0);
    }
  }
}

removepatchablecollision_delayed() {
  wait 10;
  _id_5C2C9D034EBE9DCD = [];
  _id_5C2C9D034EBE9DCD[1] = "tactical_ladder_col";
  _id_5C2C9D034EBE9DCD[2] = "clip8x8x256";
  _id_5C2C9D034EBE9DCD[3] = "player8x8x256";
  _id_5C2C9D034EBE9DCD[4] = "ladderMetal264";
  _id_5C2C9D034EBE9DCD[5] = "ladderWood192";
  _id_5C2C9D034EBE9DCD[6] = "ladderMetal192";
  _id_5C2C9D034EBE9DCD[7] = "mount128";
  _id_5C2C9D034EBE9DCD[8] = "mount64";
  _id_5C2C9D034EBE9DCD[9] = "mount32";
  _id_5C2C9D034EBE9DCD[10] = "mount256";
  _id_5C2C9D034EBE9DCD[11] = "ladderWood264";
  _id_5C2C9D034EBE9DCD[12] = "nosight256x256x8";
  _id_5C2C9D034EBE9DCD[13] = "nosight128x128x8";
  _id_5C2C9D034EBE9DCD[14] = "mountCorner128";
  _id_5C2C9D034EBE9DCD[15] = "mantle256";
  _id_5C2C9D034EBE9DCD[16] = "mantle128";
  _id_5C2C9D034EBE9DCD[17] = "mantle64";
  _id_5C2C9D034EBE9DCD[18] = "mantle32";
  _id_5C2C9D034EBE9DCD[19] = "stairsHalfFlight128";
  _id_5C2C9D034EBE9DCD[20] = "stairsFullFlight128";

  foreach(name in _id_5C2C9D034EBE9DCD)
  scripts\cp_mp\utility\game_utility::removematchingents_bykey(name, "targetname");
}

getbrendsplashpostgamestate() {
  return 8;
}

checkforsubgametypeoverrides() {
  level.allowsupers = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getsubgametype(), "_allowSupers"), level.allowsupers);
}

logendofround(player) {
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }
  if(!istrue(level.teambased) || istrue(level.multiteambased)) {
    return;
  }
  _id_C11C25D130348314 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  playerteam = player.team;
  enemyteam = level.teamnamelist[0];

  if(playerteam == enemyteam)
    enemyteam = level.teamnamelist[1];

  _id_F7F56E673C9F849D = getteamscore(playerteam);
  _id_83FDDF5A1089E6DC = getteamscore(enemyteam);
  _id_400E97CC26B2638E = 0;

  if(isDefined(player.damagethisround))
    _id_400E97CC26B2638E = player.damagethisround;

  player dlog_recordplayerevent("dlog_event_end_of_round", ["time_from_match_start", _id_C11C25D130348314, "player_team_name", playerteam, "enemy_team_name", enemyteam, "player_team_score", _id_F7F56E673C9F849D, "enemy_team_score", _id_83FDDF5A1089E6DC, "damage_this_round", _id_400E97CC26B2638E]);
}

_id_FE94AAEDD1047D50() {
  _id_DF6674BBD4C24DF5 = 0;
  _id_786F842D5771CDB6 = _func_538E92208B641725();

  foreach(_id_E72DFDB2A9343F1B in _id_786F842D5771CDB6) {
    if(!_id_E72DFDB2A9343F1B.isai)
      _id_DF6674BBD4C24DF5++;
  }

  return _id_DF6674BBD4C24DF5;
}

_id_E48DEB3D75AB2E92() {
  _id_DF6674BBD4C24DF5 = 0;

  foreach(player in level.players) {
    if(!isai(player))
      _id_DF6674BBD4C24DF5++;
  }

  return _id_DF6674BBD4C24DF5;
}

_id_75092AD1FF9DA748() {
  if(!isDefined(game["attackers"]))
    setomnvar("ui_attacking_team", 0);

  if(game["attackers"] == "axis")
    setomnvar("ui_attacking_team", 1);
  else if(game["attackers"] == "allies")
    setomnvar("ui_attacking_team", 2);
  else
    setomnvar("ui_attacking_team", 0);
}