/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\leagueplay.gsc
*************************************************/

init() {
  if(!level.leagueplaymatch) {
    return;
  }
  level.leagueplayprematchcancellingtimeout = getdvarint("#x3402089f9112227c5", 0);
  level.leagueplaymatchcancellingtimeout = getdvarint("#x3335a9c8c9cff6e6c", 0);
  var_0 = getmatchrulesdata("commonOption", "squadSize");
  level._id_C587 = 1;
  level._id_C586["allies"] = var_0;
  level._id_C586["axis"] = var_0;
  level thread onconnect();
  _id_0A8E::_id_C285(::_id_AAB6);
  level thread ongameplaying();
  var_1 = int(_func_0222("mp/leagueplay_config.csv", 0, "ladderPointsPlacement", 1));
  level.leagueplayseason = _func_048A();
  _func_047C(var_1);

  if(!_id_07D1::_id_60BE("prematch_done") && (!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0)) {
    setomnvar("ui_mp_extended_load_screen", 1);
  }

  disablejoininprogress();
}

onconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);

    if(istrue(level.leagueplaymatchcancelled)) {
      return;
    }
    if(!isPlayer(var_0) || isbot(var_0)) {
      return;
    }
    var_1 = var_0 getxuid();

    if(_func_048B(var_1)) {
      _func_048C(var_1);
      _func_048F(var_1, "");
      var_2 = get_league_season_for_match();

      if(var_2 > -1) {
        var_0 reportchallengeuserevent("144115188075856039", [6, 0, 7, _func_048D(), 12, var_2]);
      } else {
        var_0 reportchallengeuserevent("144115188075856039", [6, 0, 7, _func_048D()]);
      }

      continue;
    }

    var_0 initializematchforplayer();
  }
}

_id_AAB6(var_0) {
  if(istrue(level.leagueplaymatchcompleted) || istrue(level.leagueplaymatchcancelled)) {
    return;
  }
  if(!isPlayer(var_0) || isbot(var_0)) {
    return;
  }
  if(!isDefined(var_0) || !isDefined(var_0.team)) {
    return;
  }
  if(!isDefined(var_0.pers["leaguePlayInit"]) || var_0.pers["leaguePlayInit"] == 0) {
    return;
  }
  var_1 = 0;
  var_2 = 0;
  var_3 = int(_func_0222("mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1));
  var_4 = 0;
  var_5 = scripts\mp\teams::_id_3DA8();
  var_6 = var_0 getxuid();

  if(isDefined(var_5) && isDefined(var_5[var_0.team]) && var_5[var_0.team] == 3) {
    var_2 = int(_func_0222("mp/leagueplay_config.csv", 0, "ladderPenaltyFirstLeave", 1));
    var_4 = 1;
    _func_048F(var_6, "first_quit");
    var_1 = _func_0492("first_quit");
  } else {
    var_2 = int(_func_0222("mp/leagueplay_config.csv", 0, "ladderPenaltyAdditionalLeave", 1));
    var_4 = 2;
    _func_048F(var_6, "additional_quit");
    var_1 = _func_0492("additional_quit");
  }

  if(isDefined(var_0.hitffkicklimit) && istrue(var_0.hitffkicklimit)) {
    var_4 = 3;
  }

  _func_0482(var_6, var_2, 1);

  if(isDefined(var_0.team)) {
    _func_0486(var_6, 0, var_0.team);
  }

  var_7 = get_league_season_for_match();

  if(var_7 > -1) {
    var_0 reportchallengeuserevent("144115188075856039", [6, 1, 7, _func_048D(), 9, var_4, 10, -1 * (var_3 + var_2), 11, var_1, 12, var_7]);
  } else {
    var_0 reportchallengeuserevent("144115188075856039", [6, 1, 7, _func_048D(), 9, var_4, 10, -1 * (var_3 + var_2), 11, var_1]);
  }
}

ongameplaying() {
  level endon("game_ended");

  if(!_id_07D1::_id_60BE("prematch_done")) {
    _id_07D1::_id_60C2("prematch_done");
  }

  _func_047E();

  if(!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::_id_885C()) {
    level thread match_cancelling();
  }
}

prematch_cancelling() {
  if(!isDefined(level.leagueplayprematchcancellingtimeout) || level.leagueplayprematchcancellingtimeout <= 0) {
    return;
  }
  level endon("game_ended");
  level endon("leaguePlayLoadingComplete");
  level waittill("prematch_started");
  wait(level.leagueplayprematchcancellingtimeout);
  cancel_match();
}

match_cancelling() {
  if(!isDefined(level.leagueplaymatchcancellingtimeout) || level.leagueplaymatchcancellingtimeout <= 0) {
    return;
  }
  level endon("game_ended");
  wait(level.leagueplaymatchcancellingtimeout);
  disablejoininprogress();
  var_0 = level._id_EF6A["allies"]["players"].size;
  var_1 = level._id_EF6A["axis"]["players"].size;

  if(!isDefined(var_0) || !isDefined(var_1) || var_0 != var_1 || var_0 == 0) {
    cancel_match();
    return;
  }
}

disablejoininprogress() {
  _func_01E6(1, 1);
  _func_01E7(1, 1);
  level._id_A593 = 1;
}

initializematchforplayer() {
  var_0 = self;

  if(!isPlayer(var_0) || isbot(var_0)) {
    return;
  }
  if(isDefined(var_0.pers["leaguePlayInit"]) && var_0.pers["leaguePlayInit"] == 1) {
    return;
  }
  var_1 = var_0 getxuid();
  var_2 = _func_0481();

  if(var_2 != "") {
    var_0.pers["leaguePlayLeagueID"] = var_2;
  }

  var_3 = 0;
  var_4 = 0;
  var_0.pers["leaguePlayOnLadder"] = 0;

  if(get_league_season_for_match() > -1) {
    var_4 = var_0 getplayerdata(level.progressiongroup, "leaguePlayData", "season", level.leagueplayseason, "pmatches") == getdvarint("#x3f92161f7dd269767", 5) - 1;
    var_5 = var_0 getplayerdata(level.progressiongroup, "leaguePlayData", "season", level.leagueplayseason, "pmatches") >= getdvarint("#x3f92161f7dd269767", 5);
    var_0.pers["leaguePlayOnLadder"] = var_0 getplayerdata(level.progressiongroup, "leaguePlayData", "league_id") == var_2;

    if(var_5 && !var_0.pers["leaguePlayOnLadder"]) {
      var_3 = 1;
    }
  }

  _func_047D(var_1, var_3, var_0.pers["leaguePlayOnLadder"], var_4);
  var_0.pers["leaguePlayInit"] = 1;
}

cancel_match() {
  level.leagueplaymatchcancelled = 1;
  level._id_A2AD = 0;

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level notify("exitLevel_called");
    exitlevel(0);
  } else
    level thread scripts\mp\gamelogic::forceend();
}

get_league_season_for_match() {
  if(isDefined(level.leagueplayseason) && level.leagueplayseason >= 0) {
    return level.leagueplayseason;
  }

  return -1;
}

get_match_result(var_0) {
  var_1 = self;

  if(level.teambased) {
    if(scripts\mp\utility\teams::_id_8878(var_0)) {
      if(isDefined(var_1.team)) {
        if(var_1.team == var_0) {
          return 3;
        } else {
          return 1;
        }
      }
    } else if(!isDefined(var_0) || isDefined(var_0) && _func_0121(var_0) && var_0 == "tie")
      return 2;
  }

  return undefined;
}

get_bonus_pool_reward(var_0) {
  var_1 = self;
  var_2 = var_1 getplayerdata(level.progressiongroup, "leaguePlayData", "bonuspool");
  var_3 = var_2 - var_0;

  if(var_3 >= 0) {
    var_1 setplayerdata(level.progressiongroup, "leaguePlayData", "bonuspool", var_3);
    return var_0;
  }

  return 0;
}

match_end(var_0) {
  level.leagueplaymatchcompleted = 1;
  var_1 = istrue(level.leagueplaymatchcancelled);
  var_2 = int(_func_0222("mp/leagueplay_config.csv", 0, "ladderPointsWin", 1));
  var_3 = int(_func_0222("mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1));
  var_4 = int(_func_0222("mp/leagueplay_config.csv", 0, "ladderPointsBonusPoolStep", 1));
  var_5 = get_league_season_for_match();

  foreach(var_7 in level.players) {
    if(!isDefined(var_7.pers["leaguePlayInit"]) || var_7.pers["leaguePlayInit"] == 0) {
      continue;
    }
    if(!isPlayer(var_7) || isbot(var_7)) {
      continue;
    }
    var_8 = var_7 getxuid();
    var_9 = var_7 get_match_result(var_0);
    var_10 = _func_0491(var_8);
    var_11 = 0;
    var_12 = _func_0485(var_8);
    var_13 = isDefined(var_7.pers["leaguePlayOnLadder"]) && var_7.pers["leaguePlayOnLadder"];

    if(var_13 || var_12) {
      var_11 = _func_048E(var_10);
    }

    if(var_1) {
      var_9 = 0;
    } else if(isDefined(var_9) && (var_13 || var_12)) {
      if(var_9 == 3) {
        var_14 = 0;

        if(var_13) {
          var_14 = var_7 get_bonus_pool_reward(var_4);
        }

        _func_0482(var_8, var_2 + var_14);
      } else if(var_9 == 1)
        _func_0482(var_8, var_3);
      else {}
    }

    if(isDefined(var_7.pers["leaguePlayLeagueID"]) && isDefined(var_9) && var_5 > -1) {
      if(var_10 > 0) {
        var_7 reportchallengeuserevent("144115188075856026", [0, var_7.pers["leaguePlayLeagueID"], 1, var_9, 2, var_10, 3, var_11, 8, var_12, 13, var_13, 12, var_5]);
      } else {
        var_7 reportchallengeuserevent("144115188075856026", [0, var_7.pers["leaguePlayLeagueID"], 1, var_9, 3, var_11, 8, var_12, 13, var_13, 12, var_5]);
      }
    }

    if(isDefined(var_7.team)) {
      var_15 = 0;

      if(!var_1 && isDefined(var_7.pers["score"])) {
        var_15 = var_7.pers["score"];
      }

      _func_0486(var_8, var_15, var_7.team);
    }
  }

  for(var_17 = 0; var_17 < level._id_EF89.size; var_17++) {
    var_18 = 0;

    if(!var_1) {
      var_18 = scripts\mp\gamescore::_id_0C0F(level._id_EF89[var_17]);
    }

    _func_0487(level._id_EF89[var_17], var_18);
  }

  _func_047F(var_1);
}