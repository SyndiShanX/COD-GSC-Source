/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_gamelogic.gsc
****************************************************/

_id_6B3C(var_0) {
  if(isDefined(level._id_3E39)) {
    return;
  }
  level endon("abort_forfeit");
  level thread _id_3E3A();
  level._id_3E39 = 1;

  if(!level.teambased && level.players.size > 1)
    wait 10;
  else
    wait 1.05;

  level._id_3E38 = 0;
  var_1 = 20.0;
  _id_6029(var_1);
  _func_247(1);
  var_2 = &"";

  if(!isDefined(var_0)) {
    level._id_3B5C = "none";
    var_2 = game["end_reason"]["players_forfeited"];
    var_3 = level.players[0];
  } else if(var_0 == "axis") {
    level._id_3B5C = "axis";

    if(maps\mp\_utility::_id_579B() && game["switchedsides"])
      var_2 = game["end_reason"]["axis_forfeited"];
    else
      var_2 = game["end_reason"]["allies_forfeited"];

    if(level.gametype == "infect")
      var_2 = game["end_reason"]["survivors_forfeited"];

    var_3 = "axis";
  } else if(var_0 == "allies") {
    level._id_3B5C = "allies";

    if(maps\mp\_utility::_id_579B() && game["switchedsides"])
      var_2 = game["end_reason"]["allies_forfeited"];
    else
      var_2 = game["end_reason"]["axis_forfeited"];

    if(level.gametype == "infect")
      var_2 = game["end_reason"]["infected_forfeited"];

    var_3 = "allies";
  } else if(level._id_6520 && issubstr(var_0, "team_"))
    var_3 = var_0;
  else {
    level._id_3B5C = "none";
    var_3 = "tie";
  }

  level._id_3E16 = 1;

  if(isPlayer(var_3))
    _func_18D("forfeit, win: " + var_3 _meth_8299() + "(" + var_3.name + ")");
  else
    _func_18D("forfeit, win: " + var_3 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

  thread _id_36B9(var_3, var_2);
}

_id_3E3A() {
  level endon("game_ended");
  level waittill("abort_forfeit");
  level._id_3E38 = 1;
  _func_032("ui_match_countdown", 0);
  _func_032("ui_match_countdown_title", 0);
  _func_032("ui_match_countdown_toggle", 0);
}

_id_602A(var_0) {
  waittillframeend;
  level endon("match_forfeit_timer_beginning");
  _func_032("ui_match_countdown_title", 3);
  _func_032("ui_match_countdown_toggle", 1);

  while(var_0 > 0 && !level.gameended && !level._id_3E38 && !level._id_5139) {
    _func_032("ui_match_countdown", var_0);
    wait 1;
    var_0--;
  }
}

_id_6029(var_0) {
  level notify("match_forfeit_timer_beginning");
  var_1 = int(var_0);
  _id_602A(var_1);
  _func_032("ui_match_countdown", 0);
  _func_032("ui_match_countdown_title", 0);
  _func_032("ui_match_countdown_toggle", 0);
}

_id_2BAD(var_0) {
  level._id_3B5C = "none";

  if(var_0 == "allies") {
    _func_18D("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level._id_3B5C = "axis";
    thread _id_36B9("axis", game["end_reason"]["allies_eliminated"]);
  } else if(var_0 == "axis") {
    _func_18D("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level._id_3B5C = "allies";
    thread _id_36B9("allies", game["end_reason"]["axis_eliminated"]);
  } else {
    _func_18D("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level._id_3B5C = "none";

    if(level.teambased)
      thread _id_36B9("tie", game["end_reason"]["tie"]);
    else
      thread _id_36B9(undefined, game["end_reason"]["tie"]);
  }
}

_id_2BAF(var_0) {
  if(level.teambased) {
    var_1 = maps\mp\_utility::getlastlivingplayer(var_0);
    var_1 thread _id_478F();
  } else {
    var_1 = maps\mp\_utility::getlastlivingplayer();
    _func_18D("last one alive, win: " + var_1.name);
    level._id_3B5C = "none";
    thread _id_36B9(var_1, game["end_reason"]["enemies_eliminated"]);
  }

  return 1;
}

_id_2BB0() {
  var_0 = undefined;
  level._id_3B5C = "none";

  if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      if(_func_37E())
        var_0 = "overtime";
      else
        var_0 = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level._id_3B5C = "axis";
      var_0 = "axis";
    } else {
      level._id_3B5C = "allies";
      var_0 = "allies";
    }

    if(maps\mp\_utility::_id_761E())
      var_0 = "none";

    _func_18D("time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_0 = _id_04D2::_id_450A();

    if(isDefined(var_0))
      _func_18D("time limit, win: " + var_0.name);
    else
      _func_18D("time limit, tie");
  }

  thread _id_36B9(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_2BAE(var_0) {
  var_1 = undefined;
  level._id_3B5C = "none";
  thread _id_36B9("halftime", game["end_reason"][var_0]);
}

_id_3E1A() {
  if(level._id_4DFE || level._id_3E16) {
    return;
  }
  _func_247(1);
  var_0 = undefined;
  level._id_3B5C = "none";

  if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
      var_0 = "tie";
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level._id_3B5C = "axis";
      var_0 = "axis";
    } else {
      level._id_3B5C = "allies";
      var_0 = "allies";
    }

    _func_18D("host ended game, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_0 = _id_04D2::_id_450A();

    if(isDefined(var_0))
      _func_18D("host ended game, win: " + var_0.name);
    else
      _func_18D("host ended game, tie");
  }

  level._id_3E16 = 1;
  level._id_4DFE = 1;

  if(level.splitscreen)
    var_1 = game["end_reason"]["ended_game"];
  else
    var_1 = game["end_reason"]["host_ended_game"];

  thread _id_36B9(var_0, var_1);
}

_id_6B9B() {
  var_0 = game["end_reason"]["score_limit_reached"];
  var_1 = undefined;
  level._id_3B5C = "none";

  if(level._id_6520) {
    var_1 = _id_04D2::_id_473F();

    if(var_1 == "none")
      var_1 = "tie";
  } else if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
      var_1 = "tie";
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_1 = "axis";
      level._id_3B5C = "axis";
    } else {
      var_1 = "allies";
      level._id_3B5C = "allies";
    }

    _func_18D("scorelimit, win: " + var_1 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_1 = _id_04D2::_id_450A();

    if(isDefined(var_1))
      _func_18D("scorelimit, win: " + var_1.name);
    else
      _func_18D("scorelimit, tie");
  }

  thread _id_36B9(var_1, var_0);
  return 1;
}

_id_A11E() {
  if(maps\mp\_utility::matchmakinggame() && !level._id_5139 && !getdvarint("850") && !getdvarint("5357") && (!isDefined(level._id_2F85) || !level._id_2F85)) {
    if(level._id_6520) {
      var_0 = 0;
      var_1 = 0;

      for(var_2 = 0; var_2 < level._id_985B.size; var_2++) {
        var_0 = var_0 + level.teamcount[level._id_985B[var_2]];

        if(level.teamcount[level._id_985B[var_2]])
          var_1 = var_1 + 1;
      }

      for(var_2 = 0; var_2 < level._id_985B.size; var_2++) {
        if(var_0 == level.teamcount[level._id_985B[var_2]] && game["state"] == "playing") {
          thread _id_6B3C(level._id_985B[var_2]);
          return;
        }
      }

      if(var_1 > 1) {
        level._id_3E39 = undefined;
        level notify("abort_forfeit");
      }
    } else if(level.teambased) {
      if(level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing") {
        thread _id_6B3C("axis");
        return;
      }

      if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing") {
        thread _id_6B3C("allies");
        return;
      }

      if(level.teamcount["axis"] > 0 && level.teamcount["allies"] > 0) {
        level._id_3E39 = undefined;
        level notify("abort_forfeit");
      }
    } else {
      var_3 = level.teamcount["allies"] + level.teamcount["axis"];

      if(var_3 == 1 && game["state"] == "playing") {
        thread _id_6B3C();
        return;
      }

      if(level.teamcount["axis"] + level.teamcount["allies"] > 1) {
        level._id_3E39 = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(!maps\mp\_utility::getgametypenumlives() && (!isDefined(level._id_2F9F) || !level._id_2F9F)) {
    return;
  }
  if(!maps\mp\_utility::gamehasstarted()) {
    return;
  }
  if(level._id_5139) {
    return;
  }
  if(level._id_6520) {
    return;
  }
  if(level.teambased) {
    var_4["allies"] = level._id_5DDB["allies"];
    var_4["axis"] = level._id_5DDB["axis"];

    if(isDefined(level._id_2F9F) && level._id_2F9F) {
      var_4["allies"] = 0;
      var_4["axis"] = 0;
    }

    if(!level._id_0BC3["allies"] && !level._id_0BC3["axis"] && !var_4["allies"] && !var_4["axis"])
      return [[level._id_6AE2]]("all");

    if(!level._id_0BC3["allies"] && !var_4["allies"])
      return [[level._id_6AE2]]("allies");

    if(!level._id_0BC3["axis"] && !var_4["axis"])
      return [[level._id_6AE2]]("axis");

    var_5 = level._id_0BC3["allies"] == 1 && !var_4["allies"];
    var_6 = level._id_0BC3["axis"] == 1 && !var_4["axis"];

    if((var_5 || var_6) && !isDefined(level._id_1AED)) {
      var_7 = undefined;

      if(var_5 && !isDefined(level._id_6AF5["allies"])) {
        level._id_6AF5["allies"] = gettime();
        var_8 = [[level._id_6B5E]]("allies");

        if(isDefined(var_8)) {
          if(!isDefined(var_7))
            var_7 = var_8;

          var_7 = var_7 || var_8;
        }
      }

      if(var_6 && !isDefined(level._id_6AF5["axis"])) {
        level._id_6AF5["axis"] = gettime();
        var_9 = [[level._id_6B5E]]("axis");

        if(isDefined(var_9)) {
          if(!isDefined(var_7))
            var_7 = var_9;

          var_7 = var_7 || var_9;
        }
      }

      return var_7;
      return;
    }
  } else {
    if(!level._id_0BC3["allies"] && !level._id_0BC3["axis"] && (!level._id_5DDB["allies"] && !level._id_5DDB["axis"]))
      return [[level._id_6AE2]]("all");

    var_10 = maps\mp\_utility::getpotentiallivingplayers();

    if(var_10.size == 1)
      return [[level._id_6B5E]]("all");
  }
}

_id_A77D() {
  if(!isDefined(level._id_3B5C))
    return 0;

  level waittill("final_killcam_done");
  return 1;
}

_id_99F4(var_0) {
  _func_137(gettime() + int(var_0 * 1000));

  if(var_0 >= 10.0)
    wait(var_0 - 10.0);

  for(;;) {
    _id_0380::_id_2888("ui_timer_countdown");
    wait 1.0;
  }
}

_id_A6BA(var_0) {
  var_1 = gettime();
  var_2 = var_1 + var_0 * 1000 - 200;

  if(var_0 > 5)
    var_3 = gettime() + getdvarint("min_wait_for_players") * 1000;
  else
    var_3 = 0;

  if(isDefined(level._id_585D) && level._id_585D)
    var_4 = level._id_2584;
  else if(_func_3AF())
    var_4 = level._id_2584;
  else
    var_4 = level._id_2584 / 3;

  for(;;) {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
      break;
    }

    var_5 = level.maxplayercount;
    var_6 = gettime();

    if(var_5 >= var_4 && var_6 > var_3 || var_6 > var_2) {
      break;
    }

    waitframe();
  }
}

_id_7691() {
  level endon("game_ended");
  level._id_2584 = getdvarint("5458");
  level thread _id_92C3();

  if(level._id_7691 > 0) {
    level._id_A6EB = 1;
    _id_603A();
    level._id_A6EB = 0;
  } else
    _id_6039();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] maps\mp\_utility::_id_3E8F(1);
    level.players[var_0] _meth_8323();
    level.players[var_0] _meth_800E();
    var_2 = maps\mp\_utility::getobjectivehinttext(level.players[var_0].pers["team"]);

    if(!isDefined(var_2) || !level.players[var_0].hasspawned)
      continue;
  }

  if(game["state"] != "playing")
    return;
}

_id_483A() {
  level endon("game_ended");

  if(!isDefined(game["clientActive"])) {
    while(_func_266() == 0)
      waitframe();

    game["clientActive"] = 1;
  }

  while(level._id_5139 > 0) {
    wait 1.0;
    level._id_5139--;
  }

  level notify("grace_period_ending");
  waitframe();
  maps\mp\_utility::gameflagset("graceperiod_done");
  level._id_5139 = 0;

  if(game["state"] != "playing") {
    return;
  }
  level thread _id_A11E();
}

_id_869D(var_0, var_1) {
  var_0._id_4B62 = var_1;
  var_0 notify("hasDoneCombat");
  var_2 = !isDefined(var_0._id_4B61) || !var_0._id_4B61;

  if(var_2 && var_1 && !_func_367()) {
    var_0._id_4B61 = 1;

    if(isDefined(var_0.pers["hasMatchLoss"]) && var_0.pers["hasMatchLoss"]) {
      return;
    }
    _id_A130(var_0);
  }
}

_id_A199(var_0) {
  if(_func_3AF()) {
    return;
  }
  if(isDefined(level.disablewinlossstats) && level.disablewinlossstats || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  if((!isDefined(var_0._id_4B61) || !var_0._id_4B61) && !(level.gametype == "infect") && !maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  if(isDefined(var_0.pers["recordedLoss"]) && var_0.pers["recordedLoss"])
    var_0 maps\mp\gametypes\_persistence::statadd("losses", -1);

  var_1 = 1;

  if(maps\mp\_utility::_id_579B() && isDefined(game["game_one_winner"]) && var_0.team == game["game_one_winner"])
    var_1 = 2;

  var_0 maps\mp\gametypes\_persistence::statadd("wins", 1);
  var_0 maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
  var_0 maps\mp\gametypes\_persistence::statadd("currentWinStreak", var_1);
  var_2 = var_0 maps\mp\gametypes\_persistence::statget("currentWinStreak");

  if(var_2 > var_0 maps\mp\gametypes\_persistence::statget("winStreak"))
    var_0 maps\mp\gametypes\_persistence::statset("winStreak", var_2);

  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "win", 1);
  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
  var_0 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_wins");
  var_0 maps\mp\gametypes\_missions::processchallenge("ch_victories_careerwins");
  var_0._id_2533 = 1;
  var_0.pers["combatRecordLoss"] = undefined;

  if(level.players.size > 5) {
    switch (level.gametype) {
      case "war":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 20)
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_war_crushing");

        break;
      case "hp":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 70)
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_hp_crushing");

        break;
      case "conf":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 15)
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_conf_crushing");

        break;
      case "ball":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 7)
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_ball_crushing");

        break;
      case "dm":
        if(isDefined(level.placement["all"][0])) {
          var_3 = level.placement["all"][0];
          var_4 = 9999;

          if(var_0 == var_3) {
            foreach(var_6 in level.players) {
              if(var_0 == var_6) {
                continue;
              }
              var_7 = var_0.score - var_6.score;

              if(var_7 < var_4)
                var_4 = var_7;
            }

            if(var_4 >= 7)
              var_0 maps\mp\gametypes\_missions::processchallenge("ch_dm_crushing");
          }
        }

        break;
      case "ctf":
        if(game["shut_out"][var_0.team])
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_crushing");

        break;
    }
  }

  var_0 thread rankedwinchallengeupdate();
}

rankedwinchallengeupdate() {
  if(_func_3AF()) {
    var_0 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_wins_in_a_row");

    if(var_0 < 255)
      var_0++;

    self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_wins_in_a_row", var_0);

    if(self _meth_86B4(1) == 1) {
      var_1 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_wins_in_a_row_solo");

      if(var_1 < 255)
        var_1++;

      self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_wins_in_a_row_solo", var_1);
    }
  }
}

rankedlosschallengeupdate() {
  if(_func_3AF()) {
    self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_wins_in_a_row", 0);

    if(self _meth_86B4(1) == 1)
      self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_wins_in_a_row_solo", 0);
  }
}

_id_94F0(var_0) {
  var_1 = 0;
  var_2 = 9999;

  foreach(var_4 in level.players) {
    if(var_4._id_00E3 > var_1)
      var_1 = var_4._id_00E3;
    else if(maps\mp\_utility::_id_579B() && isDefined(var_4._id_79A2) && var_4._id_79A2 > var_1)
      var_1 = var_4._id_79A2;

    if(var_4.deaths < var_2)
      var_2 = var_4.deaths;
  }

  if(isPlayer(var_0))
    var_6 = _id_04D2::_id_450B(3);
  else
    var_6 = level.players;

  foreach(var_4 in var_6) {
    if(isPlayer(var_0) || var_4.team == var_0) {
      var_8 = var_4._id_00E3;

      if(maps\mp\_utility::_id_579B() && isDefined(var_4._id_79A2))
        var_8 = var_4._id_79A2;

      if(var_8 >= var_1 && var_4.deaths <= var_2 && var_8 > 0 && !_func_0C1(var_4)) {
        var_4 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_star");
        var_4 maps\mp\gametypes\_missions::processchallenge("ch_heroics_superstar");
      }
    }
  }
}

_id_21C1() {
  if(level.gametype == "dom") {
    foreach(var_1 in level._id_3211) {
      if(!isDefined(var_1._id_6DA9) || !var_1._id_6DA9) {
        continue;
      }
      var_2 = var_1 _id_04D1::_id_45F7();

      foreach(var_4 in level.players) {
        if(var_4.team != var_2) {
          continue;
        }
        switch (var_1.label) {
          case "_a":
            var_4 maps\mp\gametypes\_missions::processchallenge("ch_dom_alphalock");
            break;
          case "_b":
            var_4 maps\mp\gametypes\_missions::processchallenge("ch_dom_bravolock");
            break;
          case "_c":
            var_4 maps\mp\gametypes\_missions::processchallenge("ch_dom_charlielock");
            break;
        }
      }
    }
  }
}

_id_A130(var_0) {
  if(_func_3AF()) {
    return;
  }
  if(isDefined(level.disablewinlossstats) && level.disablewinlossstats || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  if((!isDefined(var_0._id_4B61) || !var_0._id_4B61) && !maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  var_0.pers["hasMatchLoss"] = 1;

  if(!isDefined(var_0._id_5969) || !var_0._id_5969) {
    var_1 = 1;

    if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(game["switchedsides"]))
      var_1 = 0;

    if(var_1) {
      var_2 = 1;

      if(maps\mp\_utility::_id_579B())
        var_2 = 2;

      var_0 maps\mp\gametypes\_persistence::statadd("losses", var_2);
      var_0 maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
      var_0.pers["recordedLoss"] = 1;
      var_0.pers["combatRecordLoss"] = 1;
    }
  }

  var_0 maps\mp\gametypes\_persistence::statadd("gamesPlayed", 1);
  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "loss", 1);
}

_id_A178(var_0) {
  if(_func_3AF()) {
    return;
  }
  if(isDefined(level.disablewinlossstats) && level.disablewinlossstats || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  if((!isDefined(var_0._id_4B61) || !var_0._id_4B61) && !maps\mp\_utility::isprophuntgametype()) {
    return;
  }
  if(isDefined(var_0.pers["recordedLoss"]) && var_0.pers["recordedLoss"]) {
    var_0 maps\mp\gametypes\_persistence::statadd("losses", -1);
    var_0 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
  }

  var_0 maps\mp\gametypes\_persistence::statadd("ties", 1);
  var_0 maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
  var_0._id_2532 = 1;
  var_0.pers["combatRecordLoss"] = undefined;
  var_0 thread rankedlosschallengeupdate();
}

_id_86FD(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  self setplayerdata(common_scripts\utility::_id_46AE(), "killsHistory", var_3, var_0);
  self setplayerdata(common_scripts\utility::_id_46AE(), "deathsHistory", var_3, var_1);
  self setplayerdata(common_scripts\utility::_id_46AE(), "lobbyPositionHistory", var_3, var_2);
}

_id_50E3(var_0, var_1) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), var_0);
  var_3 = var_2 + var_1;
  self setplayerdata(common_scripts\utility::_id_46AE(), var_0, var_3);
  return var_3;
}

_id_255B(var_0, var_1) {
  return !isDefined(var_1) || isDefined(var_0) && var_0.score > var_1.score;
}

_id_A152(var_0) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  var_1 = _func_363();
  var_2 = self._id_00E3;
  var_3 = self.deaths;
  var_4 = self getplayerdata(common_scripts\utility::_id_46AE(), "lastSessionID");

  if(var_4 != var_1) {
    _id_86FD(var_2, var_3, var_0, 0);
    _id_86FD(-1, -1, -1, 1);
    self setplayerdata(common_scripts\utility::_id_46AE(), "matchStreakInLobby", 1);

    if(var_3 == 0)
      var_3 = 1;

    self setplayerdata(common_scripts\utility::_id_46AE(), "kdRatioPerSession", int(var_2 * 1000 / var_3));
    self setplayerdata(common_scripts\utility::_id_46AE(), "killsPerSession", var_2);
    self setplayerdata(common_scripts\utility::_id_46AE(), "deathsPerSession", var_3);
  } else {
    var_5 = self getplayerdata(common_scripts\utility::_id_46AE(), "killsHistory", 0);
    var_6 = self getplayerdata(common_scripts\utility::_id_46AE(), "deathsHistory", 0);
    var_7 = self getplayerdata(common_scripts\utility::_id_46AE(), "lobbyPositionHistory", 0);
    _id_86FD(var_2, var_3, var_0, 0);
    _id_86FD(var_5, var_6, var_7, 1);
    _id_50E3("matchStreakInLobby", 1);
    var_8 = _id_50E3("deathsPerSession", var_3);
    var_9 = _id_50E3("killsPerSession", var_2);

    if(var_8 == 0)
      var_8 = 1;

    self setplayerdata(common_scripts\utility::_id_46AE(), "kdRatioPerSession", int(var_9 * 1000 / var_8));
  }

  self setplayerdata(common_scripts\utility::_id_46AE(), "lastSessionID", var_1);
}

didplayerjipgametwo(var_0) {
  if(!common_scripts\utility::_id_562E(var_0.pers["jip_game_one"]) && common_scripts\utility::_id_562E(var_0._id_5969))
    return 1;

  return 0;
}

updategameonewinners() {
  foreach(var_1 in level.players) {
    if(didplayerjipgametwo(var_1)) {
      continue;
    }
    if(var_1.team == game["game_one_winner"]) {
      var_1 maps\mp\gametypes\_persistence::statadd("wins", 1);

      if(isDefined(var_1.pers["recordedLoss"]) && var_1.pers["recordedLoss"])
        var_1 maps\mp\gametypes\_persistence::statadd("losses", -1);

      continue;
    }

    if(!isDefined(var_1._id_5969) || !var_1._id_5969) {
      var_1 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
      var_1 thread rankedlosschallengeupdate();
    }
  }
}

_id_A198(var_0) {
  if(maps\mp\_utility::privatematch()) {
    return;
  }
  if(maps\mp\_utility::_id_761E()) {
    return;
  }
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  var_1 = 1;

  if(maps\mp\_utility::_id_579B() && !common_scripts\utility::_id_562E(game["switchedsides"]))
    var_1 = 0;

  if(var_1) {
    if(!isDefined(var_0) || isDefined(var_0) && _func_031(var_0) && var_0 == "tie") {
      foreach(var_3 in level.players) {
        if(isDefined(var_3._id_2583)) {
          continue;
        }
        if(level._id_4DFE && var_3 _meth_829E()) {
          var_3 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
          var_3 thread rankedlosschallengeupdate();
          continue;
        }

        _id_A178(var_3);
      }
    } else if(isPlayer(var_0)) {
      var_5[0] = var_0;

      if(level.players.size > 5)
        var_5 = _id_04D2::_id_450B(3);

      var_6 = _id_04D2::gettiedplayerarray(2);

      if(var_6.size > 0)
        var_5 = maps\mp\_utility::array_combine_no_dupes(var_5, var_6);

      foreach(var_3 in var_5) {
        if(isDefined(var_3._id_2583)) {
          continue;
        }
        if(level._id_4DFE && var_3 _meth_829E()) {
          var_3 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
          var_3 thread rankedlosschallengeupdate();
          continue;
        }

        _id_A199(var_3);
      }
    } else if(_func_031(var_0)) {
      if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(game["switchedsides"]))
        updategameonewinners();

      foreach(var_3 in level.players) {
        if(isDefined(var_3._id_2583)) {
          continue;
        }
        if(level._id_4DFE && var_3 _meth_829E()) {
          var_3 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
          var_3 thread rankedlosschallengeupdate();
          continue;
        }

        if(var_0 == "tie") {
          _id_A178(var_3);
          continue;
        }

        if(var_3.pers["team"] == var_0) {
          _id_A199(var_3);
          continue;
        }

        if(isDefined(var_3.pers["recordedLoss"]) && var_3.pers["recordedLoss"])
          var_3 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);

        var_3 thread rankedlosschallengeupdate();
      }
    }
  }

  level._id_8F26 = common_scripts\utility::_id_0FA5(level.players, ::_id_255B);
  var_11 = 1;

  foreach(var_3 in level._id_8F26) {
    if(isDefined(var_3._id_2583)) {
      continue;
    }
    var_3 _id_A152(var_11);
    var_11++;
  }

  if(level.players.size > 5) {
    _id_94F0(var_0);
    var_5 = _id_04D2::_id_450B(3);

    for(var_14 = 0; var_14 < var_5.size; var_14++) {
      if(var_14 == 0) {
        var_5[var_14] maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_mvp");
        var_5[var_14] maps\mp\gametypes\_missions::processchallenge("ch_heroics_topdog");
      }

      var_5[var_14] maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_superior");
      var_5[var_14] maps\mp\gametypes\_missions::processchallenge("ch_heroics_topscorer");
    }
  }
}

_id_9412(var_0) {
  self endon("disconnect");
  maps\mp\_utility::clearlowermessages();

  if(!isDefined(var_0))
    var_0 = 0.05;

  self _meth_832C();
  self _meth_8267();
  wait(var_0);
  self _meth_84CB();
  self _meth_8324();
  self _meth_8546(0);
  self _meth_8305(0);
  self _meth_812C(0);
  self _meth_812B(0);
  self _meth_8309(0);
  self _meth_850D(0);
  self _meth_8326();
  self _meth_8115(0);
  self _meth_8304(0);
  self _meth_812A(0);
  self _meth_85BF(0);
  self.controlsfrozen = 1;
}

_id_A133(var_0) {
  if(!game["timePassed"]) {
    return;
  }
  if(!maps\mp\_utility::matchmakinggame()) {
    return;
  }
  if(maps\mp\_utility::_id_761E()) {
    return;
  }
  if(level.teambased) {
    if(var_0 == "allies") {
      var_1 = "allies";
      var_2 = "axis";
    } else if(var_0 == "axis") {
      var_1 = "axis";
      var_2 = "allies";
    } else {
      var_1 = "tie";
      var_2 = "tie";
    }

    if(var_1 != "tie")
      _func_150(var_1);

    foreach(var_4 in level.players) {
      if(isDefined(var_4._id_2583)) {
        continue;
      }
      if(!var_4 maps\mp\_utility::rankingenabled()) {
        continue;
      }
      if(var_4._id_9A06["total"] < 1 || var_4.pers["participation"] < 1) {
        continue;
      }
      if(level._id_4DFE && var_4 _meth_829E()) {
        continue;
      }
      if((!isDefined(var_4._id_4B61) || !var_4._id_4B61) && !maps\mp\_utility::isprophuntgametype()) {
        continue;
      }
      var_5 = 0;

      if(var_1 == "tie") {
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
        var_4._id_2EEB = 1;
        var_4._id_5858 = 0;
      } else if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
        var_4._id_5858 = 1;
      } else if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_2) {
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
        var_4._id_5858 = 0;
      }

      var_4._id_6024 = int(var_5);
    }
  } else {
    foreach(var_4 in level.players) {
      if(isDefined(var_4._id_2583)) {
        continue;
      }
      if(!var_4 maps\mp\_utility::rankingenabled()) {
        continue;
      }
      if(var_4._id_9A06["total"] < 1 || var_4.pers["participation"] < 1) {
        continue;
      }
      if(level._id_4DFE && var_4 _meth_829E()) {
        continue;
      }
      if(!isDefined(var_4._id_4B61) || !var_4._id_4B61) {
        continue;
      }
      var_4._id_5858 = 0;

      for(var_8 = 0; var_8 < _func_0AF(level.placement["all"].size, 3); var_8++) {
        if(level.placement["all"][var_8] != var_4) {
          continue;
        }
        var_4._id_5858 = 1;
      }

      var_5 = 0;

      if(var_4._id_5858)
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
      else
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");

      var_4._id_6024 = int(var_5);
    }
  }

  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isDefined(var_4._id_5858)) {
      continue;
    }
    var_11 = "loss";

    if(var_4._id_5858)
      var_11 = "win";

    if(isDefined(var_4._id_2EEB) && var_4._id_2EEB)
      var_11 = "tie";

    var_4 thread _id_4795(var_11, var_4._id_6024);
    var_4 thread maps\mp\gametypes\_rank::givexpfromactiveboosts();
  }

  if(isDefined(level._id_2F98) && !level._id_2F98) {
    foreach(var_4 in level.players) {
      if(!var_4 maps\mp\_utility::rankingenabled()) {
        continue;
      }
      var_14 = var_4 getplayerdata(common_scripts\utility::_id_46AE(), "matchesCompleted");

      if(var_14 == 0)
        var_4 maps\mp\gametypes\_rank::_id_099C();

      var_4 setplayerdata(common_scripts\utility::_id_46AE(), "matchesCompleted", var_14 + 1);
    }
  }
}

_id_4795(var_0, var_1) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  maps\mp\gametypes\_rank::giverankxp(var_0, var_1);
  maps\mp\_utility::_id_5EB0();
}

_id_8700(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_00E3) || !isDefined(var_0.deaths)) {
    return;
  }
  if(_func_3AF()) {
    return;
  }
  var_1 = var_0._id_9A06["total"] / 60.0;

  if(var_1 < 2.0) {
    return;
  }
  var_2 = var_0._id_00E3;
  var_3 = var_0.deaths;
  var_4 = _func_0AD(var_2 - var_3) * 1000.0;
  var_5 = int(var_4 / var_1);
  _func_16E(var_0, var_0.clientid, var_5);
}

_id_8A6A(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    _id_8700(var_3);
  }
}

_id_21EC(var_0) {
  if(isDefined(level._id_99F5) && level._id_99F5) {
    return;
  }
  if(game["state"] != "playing") {
    _func_137(0);
    return;
  }

  if(level.gametype == "hub") {
    return;
  }
  if(maps\mp\_utility::gettimelimit() <= 0) {
    if(isDefined(level.starttime))
      _func_137(level.starttime);
    else
      _func_137(0);

    return;
  }

  if(!maps\mp\_utility::gameflag("prematch_done")) {
    _func_137(0);
    return;
  }

  if(!isDefined(level.starttime)) {
    return;
  }
  if(isDefined(level._id_21ED))
    [[level._id_21ED]]();
  else if(maps\mp\_utility::_id_46E4() > level._id_9A05)
    _func_247(1);

  var_1 = _id_46E5();

  if(maps\mp\_utility::gethalftime() && game["status"] != "halftime")
    _func_137(gettime() + (int(var_1) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)));
  else
    _func_137(gettime() + int(var_1));

  if(var_1 > 0) {
    if(maps\mp\_utility::gethalftime() && _id_21C2(var_0))
      [[level._id_6B42]]("time_limit_reached");

    return;
  }

  [[level._id_6BB6]]();
}

_id_21C3() {
  if(!level._id_4959)
    return 0;

  if(!level.teambased)
    return 0;

  if(game["status"] != "normal")
    return 0;

  var_0 = maps\mp\_utility::getwatcheddvar("scorelimit");

  if(var_0) {
    if(game["teamScores"]["allies"] >= var_0 || game["teamScores"]["axis"] >= var_0)
      return 0;

    var_1 = int(var_0 / 2 + 0.5);

    if(game["teamScores"]["allies"] >= var_1 || game["teamScores"]["axis"] >= var_1) {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
      game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
      return 1;
    }
  }

  return 0;
}

_id_21C2(var_0) {
  if(!level.teambased)
    return 0;

  if(game["status"] != "normal")
    return 0;

  if(maps\mp\_utility::gettimelimit()) {
    var_1 = maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5;

    if(maps\mp\_utility::gettimepassed() >= var_1 && var_0 < var_1 && var_0 > 0) {
      if(isDefined(level._id_2D64) && level._id_2D64 == 1 && isDefined(level._id_18EE) && level._id_18EE == 1 && isDefined(level._id_3992))
        game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed() - level._id_3992 * 60 * 1000;
      else if(level.gametype == "ctf" && isDefined(level._id_289F) && level._id_289F && isDefined(level._id_3992))
        game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed() - level._id_3992 * 60 * 1000;
      else
        game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();

      return 1;
    }
  }

  return 0;
}

_id_46E5() {
  var_0 = maps\mp\_utility::gettimepassed();
  var_1 = maps\mp\_utility::gettimelimit() * 60 * 1000;

  if(maps\mp\_utility::gethalftime() && game["status"] == "halftime" && isDefined(level._id_3C68)) {
    var_2 = var_1 * 0.5;

    if(level._id_3C68 < var_2) {
      if(level.halftimestopwatch)
        var_0 = var_1 - level._id_3C68 + (var_0 - level._id_3C68);
      else
        var_0 = var_0 + (var_2 - level._id_3C68);
    }
  }

  return var_1 - var_0;
}

_id_21EA(var_0) {
  if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::isobjectivebased()) {
    return;
  }
  if(isDefined(level._id_80AB) && level._id_80AB) {
    return;
  }
  if(level.gametype == "conf" || level.gametype == "sd" || level.gametype == "hp" || level.gametype == "ctf" || level.gametype == "gun" || level.gametype == "infect" || level.gametype == "undead" || level.gametype == "relic") {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(maps\mp\_utility::gettimepassed() < 60000) {
    return;
  }
  var_1 = _id_3878(var_0);

  if(var_1 < 0.7)
    level notify("match_ending_soon", "score");
}

_id_21D2() {
  if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::isobjectivebased()) {
    return;
  }
  if(level.teambased) {
    return;
  }
  if(maps\mp\_utility::gettimepassed() < 60000) {
    return;
  }
  var_0 = _id_3878();

  if(var_0 < 0.7)
    level notify("match_ending_soon", "score");
}

_id_21E3() {
  if(maps\mp\_utility::isobjectivebased())
    return 0;

  if(isDefined(level._id_80AB) && level._id_80AB)
    return 0;

  if(game["state"] != "playing")
    return 0;

  if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0)
    return 0;

  if(maps\mp\_utility::gethalftime() && _id_21C3())
    return [[level._id_6B42]]("score_limit_reached");
  else if(level._id_6520) {
    var_0 = 0;

    for(var_1 = 0; var_1 < level._id_985B.size; var_1++) {
      if(game["teamScores"][level._id_985B[var_1]] >= maps\mp\_utility::getwatcheddvar("scorelimit"))
        var_0 = 1;
    }

    if(!var_0)
      return 0;
  } else if(level.teambased) {
    if(game["teamScores"]["allies"] < maps\mp\_utility::getwatcheddvar("scorelimit") && game["teamScores"]["axis"] < maps\mp\_utility::getwatcheddvar("scorelimit"))
      return 0;
  } else {
    if(!isPlayer(self))
      return 0;

    if(self.score < maps\mp\_utility::getwatcheddvar("scorelimit"))
      return 0;
  }

  if(issubstr(level.gametype, "dom")) {
    if(game["teamScores"]["allies"] > maps\mp\_utility::getwatcheddvar("scorelimit") && game["teamScores"]["axis"] < maps\mp\_utility::getwatcheddvar("scorelimit"))
      game["teamScores"]["allies"] = maps\mp\_utility::getwatcheddvar("scorelimit");
    else if(game["teamScores"]["axis"] > maps\mp\_utility::getwatcheddvar("scorelimit") && game["teamScores"]["allies"] > maps\mp\_utility::getwatcheddvar("scorelimit"))
      game["teamScores"]["axis"] = maps\mp\_utility::getwatcheddvar("scorelimit");
  }

  return _id_6B9B();
}

_id_A121() {
  level endon("game_ended");

  while(game["state"] == "playing") {
    if(isDefined(level.starttime)) {
      if(_id_46E5() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

_id_603A() {
  _func_032("ui_match_countdown_title", 6);
  _func_032("ui_match_countdown_toggle", 0);

  if(level._id_7692 > 0) {
    level._id_245A = undefined;
    maps\mp\_utility::gameflagset("useCountdownClut");
  }

  _id_A6BA(level._id_7691);

  if(isDefined(level._id_A6BC))
    [[level._id_A6BC]]();

  maps\mp\_utility::gameflagset("prematch_waitforplayers_done");

  if(level._id_7692 > 0 && !isDefined(level.hostmigrationtimer))
    _id_6037(level._id_7692);
}

_id_6038(var_0) {
  waittillframeend;
  level endon("match_start_timer_beginning");
  _func_032("ui_match_countdown_title", 1);
  _func_032("ui_match_countdown_toggle", 1);

  while(var_0 > 0 && !level.gameended) {
    _func_032("ui_match_countdown", var_0);
    var_0--;
    wait 1;
  }

  if(_func_3AF() && getdvarint("scr_rankedplay_void_time_enabled", 1) == 1 && _func_3C0() < level._id_2584) {
    level._id_3B5C = "none";
    level._id_3E16 = 1;
    var_1 = game["end_reason"]["ranked_play_void_match"];
    var_2 = "tie";
    _id_36B9(var_2, var_1);
    return;
  }

  if(!maps\mp\_utility::privatematch() && !maps\mp\_utility::_id_761E() && !(isDefined(level._id_585D) && level._id_585D)) {
    foreach(var_4 in level.players) {
      if(!isDefined(var_4.pers["hasSeenDoubleXPSplashes"]) || !var_4.pers["hasSeenDoubleXPSplashes"]) {
        if(level.rankscale > 2)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("quad_rank_xp");
        else if(level.rankscale > 1)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("double_rank_xp");

        if(level.divisionrankscale > 2)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("quad_division_xp");
        else if(level.divisionrankscale > 1)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("double_division_xp");

        if(level.weaponrankscale > 2)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("quad_weapon_xp");
        else if(level.weaponrankscale > 1)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("double_weapon_xp");

        if(level._id_5F0C > 2)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("quad_loot");
        else if(level._id_5F0C > 1)
          var_4 thread maps\mp\gametypes\_hud_message::_id_9102("double_loot");

        var_4.pers["hasSeenDoubleXPSplashes"] = 1;
      }
    }
  }

  _func_032("ui_match_countdown_toggle", 0);
  _func_032("ui_match_countdown", 0);
  _func_032("ui_match_countdown_title", 2);
  level endon("match_forfeit_timer_beginning");
  wait 1.5;
  _func_032("ui_match_countdown_title", 0);
}

_id_6037(var_0) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  level._id_245A = undefined;
  maps\mp\_utility::gameflagset("useCountdownClut");
  var_1 = int(var_0);

  if(var_1 >= 3.0) {
    thread _id_6038(var_1);
    wait(var_1 - 3.0);
    maps\mp\_utility::gameflagclear("useCountdownClut");
    level._id_245A = gettime() + 3000;
    level notify("countdownClut_fadeup");
    wait 3.0;
  } else {
    if(!maps\mp\_utility::privatematch() && !maps\mp\_utility::_id_761E() && !(isDefined(level._id_585D) && level._id_585D)) {
      foreach(var_3 in level.players) {
        if(level.rankscale > 2)
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("quad_rank_xp");
        else if(level.rankscale > 1)
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("double_rank_xp");

        if(level.divisionrankscale > 2)
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("quad_division_xp");
        else if(level.divisionrankscale > 1)
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("double_division_xp");

        if(level.weaponrankscale > 2)
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("quad_weapon_xp");
        else if(level.weaponrankscale > 1)
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("double_weapon_xp");

        if(level._id_5F0C > 2) {
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("quad_loot");
          continue;
        }

        if(level._id_5F0C > 1)
          var_3 thread maps\mp\gametypes\_hud_message::_id_9102("double_loot");
      }
    }

    maps\mp\_utility::gameflagclear("useCountdownClut");
    level._id_245A = gettime() + 1000;
    level notify("countdownClut_fadeup");
  }

  level thread onplayerconnect();
}

_id_6039() {
  maps\mp\_utility::gameflagset("prematch_waitforplayers_done");
  level thread onplayerconnect();
}

_id_5FCA() {
  self endon("disconnect");
  level endon("game_ended");
  self _meth_849C(0);
  var_0 = undefined;

  for(;;) {
    if(!maps\mp\_utility::gameflag("useCountdownClut"))
      maps\mp\_utility::gameflagwait("useCountdownClut");

    self _meth_866F(3, 0, 0);
    self _meth_8483("mp_countdown", 0, 1);
    self _meth_849B("clut_mp_blackout", 0);
    wait 0.7;
    self _meth_849B("clut_mp_countdown", 2);

    while(!isDefined(level._id_245A))
      level waittill("countdownClut_fadeup");

    var_1 = level._id_245A - gettime();

    if(var_1 < 0)
      var_1 = 0;

    self _meth_849C(var_1 / 1000.0);
    self _meth_8483("", var_1 / 1000.0, 1);

    if(isDefined(level._id_6465))
      var_0 = level._id_6465;

    if(isDefined(var_0)) {
      self _meth_866F(var_0["velocityscaler"], var_0["cameraRotationInfluence"], var_0["cameraTranslationInfluence"]);
      continue;
    }

    self _meth_866F(0, 0, 0);
  }
}

_id_92C3() {
  level endon("game_ended");
  maps\mp\_utility::gameflaginit("useCountdownClut", 0);

  if(getdvarint("trailer_disable_intro_filter", 0) != 0) {
    return;
  }
  if(maps\mp\_utility::_id_579B()) {
    return;
  }
  if(isDefined(level.players)) {
    foreach(var_1 in level.players)
    var_1 thread _id_5FCA();
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 thread _id_5FCA();
  }
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);

    if(isDefined(var_0) && isDefined(var_0.clientid) && var_0 maps\mp\_utility::rankingenabled() && !_func_367())
      setmatchdata("players", var_0.clientid, "playermatchtime_start_ms", gettime());

    resetplayerdataonstartgameorconnect(var_0);
  }
}

_id_6B99() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1) {
    var_0 = _id_4439();

    if(var_0 != game["defenders"])
      game["switchedsides"] = !game["switchedsides"];

    level._id_495B = "overtime";
    game["dynamicEvent_Overtime"] = 1;
  } else {
    level._id_495B = "halftime";
    game["switchedsides"] = !game["switchedsides"];
  }
}

_id_21E1() {
  if(!level.teambased)
    return 0;

  if(!isDefined(level.roundswitch) || !level.roundswitch)
    return 0;

  if(game["roundsPlayed"] % level.roundswitch == 0) {
    _id_6B99();
    return 1;
  }

  return 0;
}

_id_9A1B() {
  if(level.gameended) {
    var_0 = (gettime() - level._id_3F9F) / 1000;
    var_1 = level._id_75EE - var_0;

    if(var_1 < 0)
      return 0;

    return var_1;
  }

  if(maps\mp\_utility::gettimelimit() <= 0)
    return undefined;

  if(!isDefined(level.starttime))
    return undefined;

  var_2 = maps\mp\_utility::gettimelimit();
  var_0 = (gettime() - level.starttime) / 1000;
  var_1 = maps\mp\_utility::gettimelimit() * 60 - var_0;

  if(isDefined(level.discardtime))
    var_1 = var_1 + level.discardtime;

  return var_1 + level._id_75EE;
}

_id_3E89() {
  if(isDefined(self._id_6F5B)) {
    if(isDefined(self._id_6F5B[0])) {
      self._id_6F5B[0] maps\mp\gametypes\_hud_util::destroyelem();
      self._id_6F63[0] maps\mp\gametypes\_hud_util::destroyelem();
    }

    if(isDefined(self._id_6F5B[1])) {
      self._id_6F5B[1] maps\mp\gametypes\_hud_util::destroyelem();
      self._id_6F63[1] maps\mp\gametypes\_hud_util::destroyelem();
    }

    if(isDefined(self._id_6F5B[2])) {
      self._id_6F5B[2] maps\mp\gametypes\_hud_util::destroyelem();
      self._id_6F63[2] maps\mp\gametypes\_hud_util::destroyelem();
    }
  }

  self notify("perks_hidden");
  self.lowermessage maps\mp\gametypes\_hud_util::destroyelem();
  self.lowertimer maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(self._id_7794))
    self._id_7794 maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(self._id_7795))
    self._id_7795 maps\mp\gametypes\_hud_util::destroyelem();
}

_id_4514() {
  var_0 = getEntArray("player", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] _meth_829E())
      return var_0[var_1];
  }
}

_id_4DFF() {
  var_0 = _id_4514();

  if(isDefined(var_0) && !var_0.hasspawned && !isDefined(var_0._id_83A7))
    return 1;

  return 0;
}

_id_A792() {
  waittillframeend;
  var_0 = 0;

  while(!var_0) {
    var_1 = level.players;
    var_0 = 1;

    foreach(var_3 in var_1) {
      if(!isDefined(var_3.doingsplash)) {
        continue;
      }
      if(!var_3 maps\mp\gametypes\_hud_message::isdoingsplash()) {
        continue;
      }
      var_0 = 0;
    }

    wait 0.5;
  }
}

_id_7F19(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 _id_04CE::_id_9456();

  if(isDefined(level._id_36C1))
    [[level._id_36C1]]();

  _id_A792();

  if(!var_1) {
    wait(var_0);
    var_5 = level.players;

    foreach(var_3 in var_5)
    var_3 _meth_82FF("ui_round_end", 0);

    level notify("round_end_finished");
    return;
  }

  wait(var_0 / 2);
  level notify("give_match_bonus");
  wait(var_0 / 2);
  _id_A792();
  var_5 = level.players;

  foreach(var_3 in var_5)
  var_3 _meth_82FF("ui_round_end", 0);

  level notify("round_end_finished");
}

_id_7F17(var_0) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

_id_5367() {
  if(level.gametype == "relic")
    level._id_A992["waypoint_ball"] = "waypoint_relic_icon";
  else
    level._id_A992["waypoint_ball"] = "waypoint_ball_icon";

  level._id_A990["waypoint_ball"] = "friendly";

  if(level.gametype == "relic")
    level._id_A98F["waypoint_ball"] = "";
  else
    level._id_A98F["waypoint_ball"] = "waypoint_empty_icon";

  if(level.gametype == "relic")
    level._id_A992["waypoint_ball_friendly"] = "waypoint_small_relic_icon";
  else
    level._id_A992["waypoint_ball_friendly"] = "waypoint_small_ball_icon";

  level._id_A990["waypoint_ball_friendly"] = "friendly";
  level._id_A98F["waypoint_ball_friendly"] = "waypoint_background_shield";
  level._id_A992["waypoint_ball_enemy"] = "waypoint_attack";
  level._id_A990["waypoint_ball_enemy"] = "enemy";
  level._id_A98F["waypoint_ball_enemy"] = "waypoint_background_diamond";
  level._id_A992["waypoint_ball_goal"] = "waypoint_small_triangle_down";
  level._id_A990["waypoint_ball_goal"] = "enemy";
  level._id_A98F["waypoint_ball_goal"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_ball_defend"] = "waypoint_small_triangle_up";
  level._id_A990["waypoint_ball_defend"] = "friendly";
  level._id_A98F["waypoint_ball_defend"] = "waypoint_background_triangle_up";

  if(level.gametype == "relic")
    level._id_A992["waypoint_caster_neutral_ball"] = "waypoint_relic_icon";
  else
    level._id_A992["waypoint_caster_neutral_ball"] = "waypoint_ball_icon";

  level._id_A990["waypoint_caster_neutral_ball"] = "neutral";
  level._id_A98F["waypoint_caster_neutral_ball"] = "waypoint_empty_icon";

  if(level.gametype == "relic")
    level._id_A992["waypoint_caster_held_ball"] = "waypoint_small_relic_icon";
  else
    level._id_A992["waypoint_caster_held_ball"] = "waypoint_small_ball_icon";

  level._id_A990["waypoint_caster_held_ball"] = "neutral";
  level._id_A98F["waypoint_caster_held_ball"] = "waypoint_background_diamond";
  level._id_A992["waypoint_caster_friendly_goal"] = "waypoint_small_triangle_up";
  level._id_A990["waypoint_caster_friendly_goal"] = "neutral";
  level._id_A98F["waypoint_caster_friendly_goal"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_caster_enemy_goal"] = "waypoint_small_triangle_down";
  level._id_A990["waypoint_caster_enemy_goal"] = "enemy";
  level._id_A98F["waypoint_caster_enemy_goal"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_allies_flag_friendly"] = "waypoint_faction_allies_icon";
  level._id_A990["waypoint_allies_flag_friendly"] = "friendly";
  level._id_A98F["waypoint_allies_flag_friendly"] = "waypoint_flag_icon";
  level._id_A992["waypoint_allies_flag_enemy"] = "waypoint_faction_allies_icon";
  level._id_A990["waypoint_allies_flag_enemy"] = "enemy";
  level._id_A98F["waypoint_allies_flag_enemy"] = "waypoint_flag_icon";
  level._id_A992["waypoint_axis_flag_friendly"] = "waypoint_faction_axis_icon";
  level._id_A990["waypoint_axis_flag_friendly"] = "friendly";
  level._id_A98F["waypoint_axis_flag_friendly"] = "waypoint_flag_icon";
  level._id_A992["waypoint_axis_flag_enemy"] = "waypoint_faction_axis_icon";
  level._id_A990["waypoint_axis_flag_enemy"] = "enemy";
  level._id_A98F["waypoint_axis_flag_enemy"] = "waypoint_flag_icon";
  level._id_A992["waypoint_return_flag"] = "waypoint_flag_return";
  level._id_A990["waypoint_return_flag"] = "friendly";
  level._id_A98F["waypoint_return_flag"] = "waypoint_flag_icon";
  level._id_A992["waypoint_escort_flag"] = "waypoint_flag_defend";
  level._id_A990["waypoint_escort_flag"] = "friendly";
  level._id_A98F["waypoint_escort_flag"] = "waypoint_background_shield";
  level._id_A992["waypoint_kill"] = "waypoint_attack";
  level._id_A990["waypoint_kill"] = "enemy";
  level._id_A98F["waypoint_kill"] = "waypoint_background_diamond";
  level._id_A992["waypoint_waitfor_flag"] = "waypoint_empty_icon";
  level._id_A990["waypoint_waitfor_flag"] = "friendly";
  level._id_A98F["waypoint_waitfor_flag"] = "waypoint_flag_missing_icon";
  level._id_A992["waypoint_caster_flag"] = "waypoint_empty_icon";
  level._id_A990["waypoint_caster_flag"] = "neutral";
  level._id_A98F["waypoint_caster_flag"] = "waypoint_flag_icon";
  level._id_A992["waypoint_caster_flag_missing"] = "waypoint_empty_icon";
  level._id_A990["waypoint_caster_flag_missing"] = "neutral";
  level._id_A98F["waypoint_caster_flag_missing"] = "waypoint_flag_missing_icon";
  level._id_A992["waypoint_caster_flag_taken"] = "waypoint_empty_icon";
  level._id_A990["waypoint_caster_flag_taken"] = "neutral";
  level._id_A98F["waypoint_caster_flag_taken"] = "waypoint_flag_icon";
  level._id_A992["waypoint_caster_flag_dropped"] = "waypoint_flag_return";
  level._id_A990["waypoint_caster_flag_dropped"] = "neutral";
  level._id_A98F["waypoint_caster_flag_dropped"] = "waypoint_flag_icon";
  level._id_A992["waypoint_bomb"] = "waypoint_empty_icon";
  level._id_A990["waypoint_bomb"] = "friendly";
  level._id_A98F["waypoint_bomb"] = "waypoint_bomb_icon";
  level._id_A992["waypoint_defuse"] = "waypoint_bomb_timer_icon";
  level._id_A990["waypoint_defuse"] = "enemy";
  level._id_A98F["waypoint_defuse"] = "waypoint_bomb_icon";
  level._id_A992["waypoint_defuse_a"] = "waypoint_a";
  level._id_A990["waypoint_defuse_a"] = "enemy";
  level._id_A98F["waypoint_defuse_a"] = "waypoint_bomb_icon";
  level._id_A992["waypoint_defuse_b"] = "waypoint_b";
  level._id_A990["waypoint_defuse_b"] = "enemy";
  level._id_A98F["waypoint_defuse_b"] = "waypoint_bomb_icon";
  level._id_A992["waypoint_escort"] = "waypoint_small_bomb_icon";
  level._id_A990["waypoint_escort"] = "friendly";
  level._id_A98F["waypoint_escort"] = "waypoint_background_shield";
  level._id_A992["waypoint_target_a"] = "waypoint_a";
  level._id_A990["waypoint_target_a"] = "enemy";
  level._id_A98F["waypoint_target_a"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_target_b"] = "waypoint_b";
  level._id_A990["waypoint_target_b"] = "enemy";
  level._id_A98F["waypoint_target_b"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_defend_a"] = "waypoint_a";
  level._id_A990["waypoint_defend_a"] = "friendly";
  level._id_A98F["waypoint_defend_a"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_defend_b"] = "waypoint_b";
  level._id_A990["waypoint_defend_b"] = "friendly";
  level._id_A98F["waypoint_defend_b"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_caster_bomb"] = "waypoint_empty_icon";
  level._id_A990["waypoint_caster_bomb"] = "enemy";
  level._id_A98F["waypoint_caster_bomb"] = "waypoint_bomb_icon";
  level._id_A992["waypoint_caster_defuse"] = "waypoint_bomb_timer_icon";
  level._id_A990["waypoint_caster_defuse"] = "enemy";
  level._id_A98F["waypoint_caster_defuse"] = "waypoint_bomb_icon";
  level._id_A992["waypoint_caster_target_a"] = "waypoint_a";
  level._id_A990["waypoint_caster_target_a"] = "enemy";
  level._id_A98F["waypoint_caster_target_a"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_caster_target_b"] = "waypoint_b";
  level._id_A990["waypoint_caster_target_b"] = "enemy";
  level._id_A98F["waypoint_caster_target_b"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_capture"] = "waypoint_small_triangle_down";
  level._id_A990["waypoint_capture"] = "enemy";
  level._id_A98F["waypoint_capture"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_defend"] = "waypoint_small_triangle_up";
  level._id_A990["waypoint_defend"] = "friendly";
  level._id_A98F["waypoint_defend"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_captureneutral"] = "waypoint_small_triangle_up";
  level._id_A990["waypoint_captureneutral"] = "neutral";
  level._id_A98F["waypoint_captureneutral"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_contested"] = "waypoint_small_triangle_down";
  level._id_A990["waypoint_contested"] = "contest";
  level._id_A98F["waypoint_contested"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_waitfor_flag_neutral"] = "waypoint_small_triangle_up";
  level._id_A990["waypoint_waitfor_flag_neutral"] = "neutral";
  level._id_A98F["waypoint_waitfor_flag_neutral"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_capture_a"] = "waypoint_a";
  level._id_A990["waypoint_capture_a"] = "enemy";
  level._id_A98F["waypoint_capture_a"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_capture_b"] = "waypoint_b";
  level._id_A990["waypoint_capture_b"] = "enemy";
  level._id_A98F["waypoint_capture_b"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_capture_c"] = "waypoint_c";
  level._id_A990["waypoint_capture_c"] = "enemy";
  level._id_A98F["waypoint_capture_c"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_defend_a"] = "waypoint_a";
  level._id_A990["waypoint_defend_a"] = "friendly";
  level._id_A98F["waypoint_defend_a"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_defend_b"] = "waypoint_b";
  level._id_A990["waypoint_defend_b"] = "friendly";
  level._id_A98F["waypoint_defend_b"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_defend_c"] = "waypoint_c";
  level._id_A990["waypoint_defend_c"] = "friendly";
  level._id_A98F["waypoint_defend_c"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_losing_a"] = "waypoint_a";
  level._id_A990["waypoint_losing_a"] = "friendly";
  level._id_A98F["waypoint_losing_a"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_losing_a"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_losing_a"] = "enemy";
  level._id_A992["waypoint_losing_b"] = "waypoint_b";
  level._id_A990["waypoint_losing_b"] = "friendly";
  level._id_A98F["waypoint_losing_b"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_losing_b"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_losing_b"] = "enemy";
  level._id_A992["waypoint_losing_c"] = "waypoint_c";
  level._id_A990["waypoint_losing_c"] = "friendly";
  level._id_A98F["waypoint_losing_c"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_losing_c"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_losing_c"] = "enemy";
  level._id_A992["waypoint_captureneutral_a"] = "waypoint_a";
  level._id_A990["waypoint_captureneutral_a"] = "neutral";
  level._id_A98F["waypoint_captureneutral_a"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_captureneutral_b"] = "waypoint_b";
  level._id_A990["waypoint_captureneutral_b"] = "neutral";
  level._id_A98F["waypoint_captureneutral_b"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_captureneutral_c"] = "waypoint_c";
  level._id_A990["waypoint_captureneutral_c"] = "neutral";
  level._id_A98F["waypoint_captureneutral_c"] = "waypoint_background_triangle_up";
  level._id_A992["waypoint_contested_a"] = "waypoint_a";
  level._id_A990["waypoint_contested_a"] = "contest";
  level._id_A98F["waypoint_contested_a"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_contested_b"] = "waypoint_b";
  level._id_A990["waypoint_contested_b"] = "contest";
  level._id_A98F["waypoint_contested_b"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_contested_c"] = "waypoint_c";
  level._id_A990["waypoint_contested_c"] = "contest";
  level._id_A98F["waypoint_contested_c"] = "waypoint_background_triangle_down";
  level._id_A992["waypoint_taking_a"] = "waypoint_a";
  level._id_A990["waypoint_taking_a"] = "enemy";
  level._id_A98F["waypoint_taking_a"] = "waypoint_background_triangle_down";
  level._id_A994["waypoint_taking_a"] = "waypoint_secondary_triangle_down";
  level._id_A993["waypoint_taking_a"] = "friendly";
  level._id_A992["waypoint_taking_b"] = "waypoint_b";
  level._id_A990["waypoint_taking_b"] = "enemy";
  level._id_A98F["waypoint_taking_b"] = "waypoint_background_triangle_down";
  level._id_A994["waypoint_taking_b"] = "waypoint_secondary_triangle_down";
  level._id_A993["waypoint_taking_b"] = "friendly";
  level._id_A992["waypoint_taking_c"] = "waypoint_c";
  level._id_A990["waypoint_taking_c"] = "enemy";
  level._id_A98F["waypoint_taking_c"] = "waypoint_background_triangle_down";
  level._id_A994["waypoint_taking_c"] = "waypoint_secondary_triangle_down";
  level._id_A993["waypoint_taking_c"] = "friendly";
  level._id_A992["waypoint_taking_neutral_a"] = "waypoint_a";
  level._id_A990["waypoint_taking_neutral_a"] = "neutral";
  level._id_A98F["waypoint_taking_neutral_a"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_taking_neutral_a"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_taking_neutral_a"] = "friendly";
  level._id_A992["waypoint_taking_neutral_b"] = "waypoint_b";
  level._id_A990["waypoint_taking_neutral_b"] = "neutral";
  level._id_A98F["waypoint_taking_neutral_b"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_taking_neutral_b"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_taking_neutral_b"] = "friendly";
  level._id_A992["waypoint_taking_neutral_c"] = "waypoint_c";
  level._id_A990["waypoint_taking_neutral_c"] = "neutral";
  level._id_A98F["waypoint_taking_neutral_c"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_taking_neutral_c"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_taking_neutral_c"] = "friendly";
  level._id_A992["waypoint_losing_neutral_a"] = "waypoint_a";
  level._id_A990["waypoint_losing_neutral_a"] = "neutral";
  level._id_A98F["waypoint_losing_neutral_a"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_losing_neutral_a"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_losing_neutral_a"] = "enemy";
  level._id_A992["waypoint_losing_neutral_b"] = "waypoint_b";
  level._id_A990["waypoint_losing_neutral_b"] = "neutral";
  level._id_A98F["waypoint_losing_neutral_b"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_losing_neutral_b"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_losing_neutral_b"] = "enemy";
  level._id_A992["waypoint_losing_neutral_c"] = "waypoint_c";
  level._id_A990["waypoint_losing_neutral_c"] = "neutral";
  level._id_A98F["waypoint_losing_neutral_c"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_losing_neutral_c"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_losing_neutral_c"] = "enemy";
  level._id_A992["waypoint_caster_friendly_taking_a"] = "waypoint_a";
  level._id_A990["waypoint_caster_friendly_taking_a"] = "neutral";
  level._id_A98F["waypoint_caster_friendly_taking_a"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_caster_friendly_taking_a"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_caster_friendly_taking_a"] = "friendly";
  level._id_A992["waypoint_caster_friendly_taking_b"] = "waypoint_b";
  level._id_A990["waypoint_caster_friendly_taking_b"] = "neutral";
  level._id_A98F["waypoint_caster_friendly_taking_b"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_caster_friendly_taking_b"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_caster_friendly_taking_b"] = "friendly";
  level._id_A992["waypoint_caster_friendly_taking_c"] = "waypoint_c";
  level._id_A990["waypoint_caster_friendly_taking_c"] = "neutral";
  level._id_A98F["waypoint_caster_friendly_taking_c"] = "waypoint_background_triangle_up";
  level._id_A994["waypoint_caster_friendly_taking_c"] = "waypoint_secondary_triangle_up";
  level._id_A993["waypoint_caster_friendly_taking_c"] = "friendly";
  level._id_A992["waypoint_caster_enemy_taking_a"] = "waypoint_a";
  level._id_A990["waypoint_caster_enemy_taking_a"] = "neutral";
  level._id_A98F["waypoint_caster_enemy_taking_a"] = "waypoint_background_triangle_down";
  level._id_A994["waypoint_caster_enemy_taking_a"] = "waypoint_secondary_triangle_down";
  level._id_A993["waypoint_caster_enemy_taking_a"] = "enemy";
  level._id_A992["waypoint_caster_enemy_taking_b"] = "waypoint_b";
  level._id_A990["waypoint_caster_enemy_taking_b"] = "neutral";
  level._id_A98F["waypoint_caster_enemy_taking_b"] = "waypoint_background_triangle_down";
  level._id_A994["waypoint_caster_enemy_taking_b"] = "waypoint_secondary_triangle_down";
  level._id_A993["waypoint_caster_enemy_taking_b"] = "enemy";
  level._id_A992["waypoint_caster_enemy_taking_c"] = "waypoint_c";
  level._id_A990["waypoint_caster_enemy_taking_c"] = "neutral";
  level._id_A98F["waypoint_caster_enemy_taking_c"] = "waypoint_background_triangle_down";
  level._id_A994["waypoint_caster_enemy_taking_c"] = "waypoint_secondary_triangle_down";
  level._id_A993["waypoint_caster_enemy_taking_c"] = "enemy";
}

callback_startgametype() {
  _id_0483::main();
  maps\mp\_utility::levelflaginit("round_over", 0);
  maps\mp\_utility::levelflaginit("game_over", 0);
  maps\mp\_utility::levelflaginit("block_notifies", 0);
  level._id_7691 = 0;
  level._id_7692 = 0;
  level._id_75E4 = 0;
  level._id_541D = 0;
  setDvar("4899", getDvar("scr_game_forceuav"));
  setDvar("4648", getDvar("scr_game_compassRadarUpdateTime"));

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    var_0 = _func_0EE("allieschar");

    if(!isDefined(var_0) || var_0 == "") {
      if(!isDefined(game["allies"]))
        var_0 = "allies";
      else
        var_0 = game["allies"];
    }

    var_1 = _func_0EE("axischar");

    if(!isDefined(var_1) || var_1 == "") {
      if(!isDefined(game["axis"]))
        var_1 = "axis";
      else
        var_1 = game["axis"];
    }

    if(level._id_6520) {
      var_2 = _func_0EE("allieschar");

      if(!isDefined(var_2) || var_2 == "")
        var_2 = "delta_multicam";

      for(var_3 = 0; var_3 < level._id_985B.size; var_3++)
        game[level._id_985B[var_3]] = var_2;
    }

    game["allies"] = var_0;
    game["axis"] = var_1;

    if(!isDefined(game["attackers"]) || !isDefined(game["defenders"]))
      thread common_scripts\utility::_id_3809("No attackers or defenders team defined in level .gsc.");

    if(!isDefined(game["attackers"]))
      game["attackers"] = "allies";

    if(!isDefined(game["defenders"]))
      game["defenders"] = "axis";

    if(!isDefined(game["state"]))
      game["state"] = "playing";

    if(level.teambased) {
      game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_TEAMS";
      game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
    } else {
      game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_MORE_PLAYERS";
      game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
    }

    game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
    game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
    game["strings"]["match_resuming_in"] = &"MP_MATCH_RESUMING_IN";
    game["strings"]["waiting_for_players"] = &"MP_WAITING_FOR_PLAYERS";
    game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
    game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
    game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
    game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
    game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["change_class_cancel"] = &"MP_CHANGE_CLASS_CANCEL";
    game["strings"]["change_class_wait"] = &"MP_CHANGE_CLASS_WAIT";
    game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
    game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
    game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
    game["colors"]["blue"] = (0.25, 0.25, 0.75);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["white"] = (1, 1, 1);
    game["colors"]["black"] = (0, 0, 0);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0);
    game["colors"]["orange"] = (1, 0.45, 0);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);
    game["strings"]["allies_name"] = _id_0510::_id_46D5("allies");
    game["icons"]["allies"] = _id_0510::_id_46D3("allies");
    game["colors"]["allies"] = _id_0510::_id_46C5("allies");
    game["strings"]["axis_name"] = _id_0510::_id_46D5("axis");
    game["icons"]["axis"] = _id_0510::_id_46D3("axis");
    game["colors"]["axis"] = _id_0510::_id_46C5("axis");
    game["dvar_color_names"]["friendly"] = (0.251, 0.58, 0.537);
    game["dvar_color_names"]["enemy"] = (0.698, 0.224, 0.114);
    game["dvar_color_names"]["contest"] = (0.659, 0.463, 0.255);
    game["dvar_color_names"]["neutral"] = (0.604, 0.584, 0.5098);
    game["dvar_color_names"]["plaintext"] = (0.906, 0.878, 0.769);
    _id_5367();

    if(game["colors"]["allies"] == (0, 0, 0))
      game["colors"]["allies"] = (0.5, 0.5, 0.5);

    if(game["colors"]["axis"] == (0, 0, 0))
      game["colors"]["axis"] = (0.5, 0.5, 0.5);

    [[level._id_6B86]]();
    setdvarifuninitialized("min_wait_for_players", 5);

    if(level._id_258F) {
      if(!level.splitscreen) {
        if(_func_25F()) {
          if(maps\mp\_utility::_id_579B())
            level._id_7691 = _id_0511::_id_46F7("game", "graceperiod_raid_ds");
          else if(_func_3AF())
            level._id_7691 = _id_0511::_id_46F7("game", "graceperiod_ranked_ds");
          else
            level._id_7691 = _id_0511::_id_46F7("game", "graceperiod_ds");
        } else
          level._id_7691 = _id_0511::_id_46F7("game", "graceperiod");

        level._id_7692 = _id_0511::_id_46F7("game", "matchstarttime");
      }
    } else {
      if(_func_25F()) {
        if(maps\mp\_utility::_id_579B())
          level._id_7691 = _id_0511::_id_46F7("game", "playerwaittime_raid_ds");
        else if(_func_3AF())
          level._id_7691 = _id_0511::_id_46F7("game", "playerwaittime_ranked_ds");
        else
          level._id_7691 = _id_0511::_id_46F7("game", "playerwaittime_ds");
      } else
        level._id_7691 = _id_0511::_id_46F7("game", "playerwaittime");

      level._id_7692 = _id_0511::_id_46F7("game", "matchstarttime");
    }

    if(_func_154() == "hub") {
      level._id_7691 = 1;
      level._id_7692 = 1;
    }
  } else {
    setdvarifuninitialized("min_wait_for_players", 5);

    if(level._id_258F) {
      if(!level.splitscreen) {
        level._id_7691 = 5;
        level._id_7692 = _id_0511::_id_46F7("game", "roundstarttime");

        if(maps\mp\_utility::_id_579B()) {
          if(_func_25F())
            level._id_7691 = _id_0511::_id_46F7("game", "graceperiod_raid_ds");
          else
            level._id_7691 = _id_0511::_id_46F7("game", "graceperiod");

          level._id_7692 = _id_0511::_id_46F7("game", "matchstarttime");
        }
      }
    } else {
      level._id_7691 = 5;
      level._id_7692 = _id_0511::_id_46F7("game", "roundstarttime");

      if(maps\mp\_utility::_id_579B()) {
        if(_func_25F())
          level._id_7691 = _id_0511::_id_46F7("game", "playerwaittime_raid_ds");
        else
          level._id_7691 = _id_0511::_id_46F7("game", "playerwaittime");

        level._id_7692 = _id_0511::_id_46F7("game", "matchstarttime");
      }
    }
  }

  if(!isDefined(game["status"]))
    game["status"] = "normal";

  if(game["status"] != "overtime" && game["status"] != "halftime" && game["status"] != "overtime_halftime") {
    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;

    if(level._id_6520) {
      for(var_3 = 0; var_3 < level._id_985B.size; var_3++)
        game["teamScores"][level._id_985B[var_3]] = 0;
    }
  }

  if(!isDefined(game["timePassed"]))
    game["timePassed"] = 0;

  if(!isDefined(game["roundsPlayed"]))
    game["roundsPlayed"] = 0;

  _func_032("ui_current_round", game["roundsPlayed"] + 1);
  _func_032("ui_last_round", maps\mp\_utility::islastround());

  if(!isDefined(game["roundsWon"]))
    game["roundsWon"] = [];

  if(level.teambased) {
    if(!isDefined(game["roundsWon"]["axis"]))
      game["roundsWon"]["axis"] = 0;

    if(!isDefined(game["roundsWon"]["allies"]))
      game["roundsWon"]["allies"] = 0;

    if(level._id_6520) {
      for(var_3 = 0; var_3 < level._id_985B.size; var_3++) {
        if(!isDefined(game["roundsWon"][level._id_985B[var_3]]))
          game["roundsWon"][level._id_985B[var_3]] = 0;
      }
    }
  }

  level.gameended = 0;
  level._id_3E16 = 0;
  level._id_4DFE = 0;
  level.hardcoremode = getdvarint("2043");

  if(level.hardcoremode)
    _func_18D("game mode: hardcore");

  level._id_2EF3 = getdvarint("scr_diehard");

  if(!level.teambased)
    level._id_2EF3 = 0;

  if(level._id_2EF3)
    _func_18D("game mode: diehard");

  level._id_5A6F = getdvarint("scr_game_hardpoints");

  if(!isDefined(level._id_585D))
    level._id_585D = 0;

  if(maps\mp\_utility::_id_56B1() || _func_3AF() || isDefined(level.mgnestsdisabled) && level.mgnestsdisabled)
    maps\mp\_utility::removemgnestsfromlevel();

  level._id_A239 = 1;
  level._id_696A = 1;
  level._id_162E = 1;
  level._id_6072 = 2;
  thread _id_0492::main();
  thread maps\mp\gametypes\_persistence::init();
  thread _id_04E8::init();
  thread _id_04E3::init();
  thread _id_0509::init();
  thread _id_0510::init();
  thread _id_0513::init();
  thread _id_04E6::init();
  thread _id_050A::init();
  thread _id_04C8::init();
  thread _id_04C7::init();
  thread _id_04D6::init();
  thread _id_050F::init();
  thread _id_04EC::init();
  thread _id_04D1::init();
  thread _id_050D::init();
  thread _id_04C2::init();
  thread _id_0508::init();
  thread _id_0487::init();
  thread _id_04EA::init();
  thread _id_0485::init();
  thread _id_050B::init();
  thread maps\mp\_leprechauns::init();

  if(isDefined(level._id_585D) && level._id_585D) {
    if(isDefined(level._id_0788))
      thread[[level._id_0788]]();
  } else
    thread _id_0471::init();

  thread _id_046D::init();
  thread _id_048D::init();
  thread _id_046E::init();

  if(!maps\mp\_utility::_id_551F() && getDvar("1924") != "hub") {
    thread _id_051F::init();
    thread _id_0533::init();
  }

  thread _id_052D::init();
  thread _id_047A::init();
  thread _id_04CE::_id_52B8();

  if(!isDefined(level._id_1152))
    thread maps\mp\_utility::_id_1D3E();

  if(level.teambased)
    thread _id_04CF::init();

  thread maps\mp\gametypes\_hud_message::init();
  thread _id_04CA::init();

  foreach(var_5 in game["strings"])
  precachestring(var_5);

  foreach(var_8 in game["icons"])
  _func_13F(var_8);

  game["gamestarted"] = 1;
  level.maxplayercount = 0;
  level._id_A982["allies"] = 0;
  level._id_A982["axis"] = 0;
  level._id_5C0F["allies"] = 0;
  level._id_5C0F["axis"] = 0;
  level._id_A987["allies"] = 0;
  level._id_A987["axis"] = 0;
  level._id_0BC4["allies"] = [];
  level._id_0BC4["axis"] = [];
  level._id_08DC = [];

  if(level._id_6520) {
    for(var_3 = 0; var_3 < level._id_985B.size; var_3++) {
      level._id_077C[level._id_985B[var_3]] = 0;
      level._id_066E[level._id_985B[var_3]] = 0;
      level._id_077D[level._id_985B[var_3]] = 0;
      level._id_0598[level._id_985B[var_3]] = [];
    }
  }

  setDvar("ui_scorelimit", 0);
  setDvar("ui_allow_teamchange", 1);

  if(maps\mp\_utility::getgametypenumlives() && !maps\mp\_utility::_id_585F())
    setDvar("2335", 0);
  else
    setDvar("2335", 1);

  var_10 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay");
  var_11 = isDefined(level._id_7DB3) && level._id_7DB3 == 2;

  if(var_10 > 0 || var_11) {
    if(var_11) {
      if(!common_scripts\utility::_id_562E(game["switchedsides"])) {
        level._id_A982[game["attackers"]] = level.attackersrespawndelay;
        level._id_A982[game["defenders"]] = level.defendersrespawndelay;
      } else {
        level._id_A982[game["attackers"]] = level.defendersrespawndelay;
        level._id_A982[game["defenders"]] = level.attackersrespawndelay;
      }
    } else {
      level._id_A982["allies"] = var_10;
      level._id_A982["axis"] = var_10;
    }

    level._id_5C0F["allies"] = 0;
    level._id_5C0F["axis"] = 0;

    if(level._id_6520) {
      for(var_3 = 0; var_3 < level._id_985B.size; var_3++) {
        level._id_077C[level._id_985B[var_3]] = var_10;
        level._id_066E[level._id_985B[var_3]] = 0;
      }
    }

    level thread _id_A98B();
  }

  maps\mp\_utility::gameflaginit("prematch_done", 0);
  maps\mp\_utility::gameflaginit("prematch_waitforplayers_done", 0);
  maps\mp\_utility::gameflaginit("team_collision_on", 0);

  if(!isDefined(level._id_483A))
    level._id_483A = 15;

  if(_func_154() == "hub" || level.gametype == "onevone")
    level._id_483A = 1;

  level._id_5139 = level._id_483A;
  maps\mp\_utility::gameflaginit("graceperiod_done", 0);
  level._id_7F16 = 4;
  level._id_495A = 4;
  level._id_6738 = getEntArray("noragdoll", "targetname");

  if(level.teambased) {
    _id_04D2::_id_A174("axis");
    _id_04D2::_id_A174("allies");

    if(level._id_6520) {
      for(var_3 = 0; var_3 < level._id_985B.size; var_3++)
        _id_04D2::_id_A174(level._id_985B[var_3]);
    }
  } else
    thread _id_04D2::_id_52DA();

  if(!_func_367()) {
    thread _id_A18B();
    level notify("update_scorelimit");
  }

  [[level._id_6BAF]]();
  level._id_80AC = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off", 80);
  level._id_9A05 = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off", 80);
  level._id_7F20 = getdvarint("scr_" + level.gametype + "_round_num_cut_off", 4);

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun))
    level._id_7F20 = 1;

  var_12 = getdvarint("ds_bot_test");

  if(var_12 == 0) {}

  if(!level._id_258F && (getDvar("dedicated") == "dedicated LAN server" || getDvar("dedicated") == "dedicated internet server"))
    thread _id_A415();

  _id_8633();

  if(!_func_367()) {
    thread _id_92DA();
    level thread maps\mp\_utility::updatewatcheddvars();
    level thread _id_99F6();

    if(!isDefined(level._id_53C7) || !level._id_53C7)
      level thread _id_04CE::_id_318C();
  } else {
    _func_29E("MatchStarted: Completed");
    setDvar("ui_inprematch", 1);
    maps\mp\_utility::gameflagset("prematch_done");
    level notify("prematch_over");
    setDvar("ui_inprematch", 0);
  }
}

_id_8633() {
  if(game["attackers"] == "axis")
    var_0 = 1;
  else if(game["attackers"] == "allies")
    var_0 = 2;
  else
    var_0 = 0;

  _func_032("ui_attacking_team", var_0);
}

callback_codeendgame() {
  _func_16F();

  if(!level.gameended)
    level thread _id_3E1A();
}

_id_A415() {
  for(;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!_func_371())
      exitlevel(0);

    if(getDvar("dedicated") != "dedicated LAN server" && getDvar("dedicated") != "dedicated internet server")
      exitlevel(0);

    wait 5;
  }
}

_id_99F6() {
  level endon("game_ended");
  var_0 = maps\mp\_utility::gettimepassed();

  while(game["state"] == "playing") {
    thread _id_21EC(var_0);
    var_0 = maps\mp\_utility::gettimepassed();

    if(isDefined(level.starttime)) {
      if(_id_46E5() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

_id_A18B() {
  for(;;) {
    level common_scripts\utility::_id_A732("update_scorelimit", "update_winlimit");

    if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased()) {
      setDvar("ui_scorelimit", maps\mp\_utility::getwatcheddvar("scorelimit"));
      thread _id_21E3();
      continue;
    }

    setDvar("ui_scorelimit", maps\mp\_utility::getwatcheddvar("winlimit"));
  }
}

_id_74E5() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  var_0 = level._id_1909;

  for(;;) {
    self playSound("mp_s2_obj_timer_tick_1s");

    if(var_0 > 10) {
      var_0 = var_0 - 1;
      wait 1;
    } else if(var_0 > 4) {
      var_0 = var_0 - 0.5;
      wait 0.5;
    } else {
      var_0 = var_0 - 0.25;
      wait 0.25;
    }

    maps\mp\gametypes\_hostmigration::_id_A782();
  }
}

_id_9415() {
  self notify("stop_ticking");
}

_id_99F3() {
  level endon("game_ended");
  waitframe();

  while(game["state"] == "playing") {
    if(!level.timerstopped && maps\mp\_utility::gettimelimit()) {
      var_0 = _id_46E5() / 1000;
      var_1 = int(var_0 + 0.5);
      var_2 = int(maps\mp\_utility::gettimelimit() * 60 * 0.5);

      if(maps\mp\_utility::gethalftime() && var_1 > var_2)
        var_1 = var_1 - var_2;

      if(var_1 >= 30 && var_1 <= 60 && (level.gametype != "sd" && level.gametype != "hp" && level.gametype != "undead" && level.gametype != "relic"))
        level notify("match_ending_soon", "time");

      if(var_1 <= 10 || var_1 <= 30 && var_1 % 2 == 0) {
        level notify("match_ending_very_soon");

        if(var_1 == 0) {
          break;
        }
      }

      if(var_0 - _func_0D4(var_0) >= 0.05)
        wait(var_0 - _func_0D4(var_0));
    }

    wait 1.0;
  }
}

_id_3FD8() {
  level endon("game_ended");
  level waittill("prematch_over");
  level.starttime = gettime();
  level.discardtime = 0;
  level._id_6027 = gettime();

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
    level._id_3C68 = game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  var_0 = gettime();

  while(game["state"] == "playing") {
    if(!level.timerstopped)
      game["timePassed"] = game["timePassed"] + (gettime() - var_0);

    var_0 = gettime();
    wait 1.0;
  }
}

_id_A17B() {
  var_0 = level._id_9A13 || isDefined(level.hostmigrationtimer);

  if(!maps\mp\_utility::gameflag("prematch_done"))
    var_0 = 0;

  if(!level.timerstopped && var_0) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
  } else if(level.timerstopped && !var_0) {
    level.timerstopped = 0;
    level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
  }
}

_id_6F27() {
  level._id_9A13 = 1;
  _id_A17B();
}

_id_7DFC() {
  level._id_9A13 = 0;
  _id_A17B();
}

resetplayerdataonstartgameorconnect(var_0) {
  if(!_func_367()) {
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "challengeNumCompleted", 0);
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", 0, "none");
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", 1, "none");
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", 2, "none");
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", 0, 0);
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", 1, 0);
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", 2, 0);

    for(var_1 = 0; var_1 <= 10; var_1++) {
      if(var_1 != 5) {
        var_2 = var_0 _id_04CA::_id_44A0(var_1);
        var_0 setplayerdata(common_scripts\utility::_id_46A7(), "round", "divisionMatchExperience", var_2, 0);
      }
    }

    var_0 _meth_85EF(&"ui_player_set_match_start_time", 1, gettime());
  }
}

_id_92DA() {
  thread _id_3FD8();

  if(!isDefined(level.timerstopped)) {
    level.timerstopped = 0;
    level._id_9A13 = 0;
  }

  setDvar("ui_inprematch", 1);
  _id_7691();
  maps\mp\_utility::gameflagset("prematch_done");
  level notify("prematch_over");
  setDvar("ui_inprematch", 0);
  level._id_7690 = gettime();
  maps\mp\_utility::_id_2CED(8, maps\mp\_utility::gameflagset, "team_collision_on");

  foreach(var_1 in level.players) {
    if(!_func_367())
      setmatchdata("players", var_1.clientid, "playermatchtime_start_ms", gettime());

    if(_func_033("ui_current_round") == 1)
      resetplayerdataonstartgameorconnect(var_1);
  }

  _id_A17B();
  thread _id_99F3();
  thread _id_483A();
  thread maps\mp\gametypes\_missions::_id_7F13();
  thread _id_0485::_id_6036();
  thread _id_050B::_id_5EAC();
  var_3 = isDefined(level._id_585D) && level._id_585D;

  if(var_3)
    thread _id_A11D();

  if(!_func_367())
    _func_227();
}

_id_A98B() {
  level endon("game_ended");

  while(game["state"] == "playing") {
    var_0 = gettime();

    if(var_0 - level._id_5C0F["allies"] > level._id_A982["allies"] * 1000) {
      level notify("wave_respawn_allies");
      level._id_5C0F["allies"] = var_0;
      level._id_A987["allies"] = 0;
    }

    if(var_0 - level._id_5C0F["axis"] > level._id_A982["axis"] * 1000) {
      level notify("wave_respawn_axis");
      level._id_5C0F["axis"] = var_0;
      level._id_A987["axis"] = 0;
    }

    if(level._id_6520) {
      for(var_1 = 0; var_1 < level._id_985B.size; var_1++) {
        if(var_0 - level._id_5C0F[level._id_985B[var_1]] > level._id_077C[level._id_985B[var_1]] * 1000) {
          var_2 = "wave_rewpawn_" + level._id_985B[var_1];
          level notify(var_2);
          level._id_5C0F[level._id_985B[var_1]] = var_0;
          level._id_A987[level._id_985B[var_1]] = 0;
        }
      }
    }

    waitframe();
  }
}

_id_4439() {
  var_0["allies"] = 0;
  var_0["axis"] = 0;
  var_1["allies"] = 0;
  var_1["axis"] = 0;
  var_2["allies"] = 0;
  var_2["axis"] = 0;

  foreach(var_4 in level.players) {
    var_5 = var_4.pers["team"];

    if(isDefined(var_5) && (var_5 == "allies" || var_5 == "axis")) {
      var_0[var_5] = var_0[var_5] + var_4.score;
      var_1[var_5] = var_1[var_5] + var_4._id_00E3;
      var_2[var_5] = var_2[var_5] + var_4.deaths;
    }
  }

  if(var_0["allies"] > var_0["axis"])
    return "allies";
  else if(var_0["axis"] > var_0["allies"])
    return "axis";

  if(var_1["allies"] > var_1["axis"])
    return "allies";
  else if(var_1["axis"] > var_1["allies"])
    return "axis";

  if(var_2["allies"] < var_2["axis"])
    return "allies";
  else if(var_2["axis"] < var_2["allies"])
    return "axis";

  if(randomint(2) == 0)
    return "allies";

  return "axis";
}

_id_7A68(var_0, var_1) {
  if(!maps\mp\_utility::waslastround()) {
    return;
  }
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(var_1 == game["end_reason"]["ranked_play_void_match"]) {
    _id_0508::onmatchvoid(var_0);
    return;
  }

  var_0 = _id_44FD(var_0, 0);

  if(maps\mp\_utility::matchmakinggame()) {
    if(_func_3AF())
      _id_0508::_id_6B56(var_0);
    else
      _id_8A6A();

    if(_id_4DFF()) {
      level._id_4DFE = 1;
      _func_18D("host idled out");
      _func_0ED();
    }

    _id_A133(var_0);
  }

  _id_A198(var_0);
}

_id_3015(var_0, var_1) {
  if(!maps\mp\_utility::_id_761E()) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_2583) || var_3.pers["team"] == "spectator" && !var_3 _meth_8436()) {
        continue;
      }
      if(level.teambased) {
        var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_0, 1, var_1);
        continue;
      }

      var_3 thread maps\mp\gametypes\_hud_message::outcomenotify(var_0, var_1);
    }
  }

  if(!maps\mp\_utility::waslastround())
    level notify("round_win", var_0);

  if(maps\mp\_utility::waslastround())
    _id_7F19(level._id_7F16, 0);
  else
    _id_7F19(level._id_7F16, 1);
}

_id_300B(var_0, var_1) {
  if(isDefined(level._id_300C))
    return [[level._id_300C]](var_0, var_1);

  if(!maps\mp\_utility::_id_761E()) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_2583) || var_3.pers["team"] == "spectator" && !var_3 _meth_8436()) {
        var_3 _meth_82FF("ui_round_end_spectator", 1);
        continue;
      }

      if(level.teambased) {
        var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_0, 0, var_1, 1);
        continue;
      }

      var_3 thread maps\mp\gametypes\_hud_message::outcomenotify(var_0, var_1);
    }
  }

  level notify("game_win", var_0);
  _id_7F19(level._id_75EE, 1);
}

_id_3016() {
  var_0 = level._id_495B;

  if(var_0 == "halftime") {
    if(maps\mp\_utility::getwatcheddvar("roundlimit")) {
      if(game["roundsPlayed"] * 2 == maps\mp\_utility::getwatcheddvar("roundlimit"))
        var_0 = "halftime";
      else
        var_0 = "intermission";
    } else if(maps\mp\_utility::getwatcheddvar("winlimit")) {
      if(game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
        var_0 = "halftime";
      else
        var_0 = "intermission";
    } else
      var_0 = "intermission";
  }

  level notify("round_switch", var_0);

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_2583) || var_2.pers["team"] == "spectator" && !var_2 _meth_8436()) {
      continue;
    }
    var_2 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_0, 1, game["end_reason"]["switching_sides"]);
  }

  _id_7F19(level._id_495A, 0);
}

_id_3E8C(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  foreach(var_3 in level.players) {
    var_3 _meth_800F();
    var_3 thread _id_9412(var_0);
    var_3 thread _id_7F17(4.0);
    var_3 _id_3E89();

    if(isDefined(var_1) && var_1) {
      var_3 setclientdvars("3724", 1, "3078", 1);
      var_3 _meth_82FF("fov_scale", 1);
      continue;
    }

    var_3 setclientdvars("3724", 1);
  }

  if(isDefined(level._id_0A4E)) {
    foreach(var_6 in level._id_0A4E)
    var_6 maps\mp\_utility::freezecontrolswrapper(1);
  }
}

_id_36BF(var_0, var_1) {
  setDvar("4899", 0);
  _id_3E8C(1.0, 1);

  foreach(var_3 in level.players) {
    var_3.pers["stats"] = var_3.stats;
    var_3.pers["segments"] = var_3._id_838A;
  }

  level notify("round_switch", "overtime");
  var_5 = 0;
  var_6 = var_0 == "overtime";

  if(level.gametype == "ctf") {
    var_0 = "tie";
    var_5 = 1;

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      var_0 = "axis";

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
      var_0 = "allies";
  }

  foreach(var_3 in level.players) {
    if(isDefined(var_3._id_2583) || var_3.pers["team"] == "spectator" && !var_3 _meth_8436()) {
      continue;
    }
    if(level.teambased) {
      var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_0, var_5, var_1);
      continue;
    }

    var_3 thread maps\mp\gametypes\_hud_message::outcomenotify(var_0, var_1);
  }

  _id_7F19(level._id_7F16, 0);

  if(level.gametype == "ctf")
    var_0 = "overtime_halftime";

  if(isDefined(level._id_3B5C) && var_6) {
    level._id_3B57[level._id_3B5C] = maps\mp\_utility::getsecondspassed();

    foreach(var_3 in level.players)
    var_3 notify("reset_outcome");

    level notify("game_cleanup");
    level notify("nuke_cancelled");
    _id_A77D();

    if(level.gametype == "ctf") {
      var_0 = "overtime";
      var_1 = game["end_reason"]["tie"];
    }

    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_2583) || var_3.pers["team"] == "spectator" && !var_3 _meth_8436()) {
        continue;
      }
      if(level.teambased) {
        var_3 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_0, 0, var_1);
        continue;
      }

      var_3 thread maps\mp\gametypes\_hud_message::outcomenotify(var_0, var_1);
    }

    _id_7F19(level._id_495A, 0);
  }

  game["status"] = var_0;
  level notify("restarting");
  game["state"] = "playing";
  setDvar("2523", game["state"]);
  _func_163(1);
}

_id_36BC(var_0) {
  setDvar("4899", 0);
  var_1 = "halftime";
  var_2 = 1;

  if(isDefined(level._id_4958) && !level._id_4958)
    var_2 = 0;

  if(var_2) {
    game["switchedsides"] = !game["switchedsides"];
    var_3 = game["end_reason"]["switching_sides"];
  } else
    var_3 = var_0;

  _id_3E8C(1.0, 1);

  if(level.gametype == "ctf") {
    var_3 = var_0;
    var_1 = "tie";

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      var_1 = "axis";

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
      var_1 = "allies";
  } else if(maps\mp\_utility::_id_579B()) {
    var_3 = var_0;
    var_4 = game["attackers"];
    var_5 = game["defenders"];

    if(_func_033("ui_war_attacker_flipped") == 1) {
      var_4 = game["defenders"];
      var_5 = game["attackers"];
    }

    if(var_0 == game["end_reason"]["time_limit_reached"])
      _func_032("ui_game_victor", maps\mp\_utility::_id_46D4(var_5));
    else
      _func_032("ui_game_victor", maps\mp\_utility::_id_46D4(var_4));
  }

  foreach(var_7 in level.players) {
    var_7.pers["stats"] = var_7.stats;
    var_7.pers["segments"] = var_7._id_838A;
  }

  level notify("round_switch", "halftime");

  foreach(var_7 in level.players) {
    if(isDefined(var_7._id_2583) || var_7.pers["team"] == "spectator" && !var_7 _meth_8436()) {
      continue;
    }
    var_7 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_1, 1, var_3);
  }

  _id_7F19(level._id_7F16, 0);

  if(isDefined(level._id_3B5C)) {
    level._id_3B57[level._id_3B5C] = maps\mp\_utility::getsecondspassed();

    foreach(var_7 in level.players)
    var_7 notify("reset_outcome");

    level notify("game_cleanup");
    level notify("nuke_cancelled");
    _id_A77D();

    if(isDefined(level._id_495C))
      [[level._id_495C]]();
    else {
      var_13 = game["end_reason"]["switching_sides"];

      if(!var_2)
        var_13 = var_3;

      foreach(var_7 in level.players) {
        if(isDefined(var_7._id_2583) || var_7.pers["team"] == "spectator" && !var_7 _meth_8436()) {
          continue;
        }
        var_7 thread maps\mp\gametypes\_hud_message::teamoutcomenotify("halftime", 1, var_13);
      }

      _id_7F19(level._id_495A, 0);
    }
  }

  game["status"] = "halftime";
  level notify("restarting");
  game["state"] = "playing";
  setDvar("2523", game["state"]);
  _func_163(1);
}

_id_A11D() {
  level endon("game_ended");

  for(;;) {
    var_0 = _id_44F8();
    _func_032("ui_game_duration", var_0 * 1000);
    wait 1.0;
  }
}

_id_44F8() {
  var_0 = maps\mp\_utility::_id_44FB();
  return var_0;
}

_id_3F9C(var_0) {
  if(var_0 > 86399)
    return 86399;

  return var_0;
}

_id_6028(var_0, var_1, var_2) {
  var_3 = gettime();
  var_4 = "_gamelogic.gsc";
  var_5 = "all";

  if(level.teambased && isDefined(var_0))
    var_5 = var_0;

  var_6 = "undefined";

  if(isDefined(var_1)) {
    switch (var_1) {
      case 1:
        var_6 = "MP_SCORE_LIMIT_REACHED";
        break;
      case 2:
        var_6 = "MP_TIME_LIMIT_REACHED";
        break;
      case 3:
        var_6 = "MP_PLAYERS_FORFEITED";
        break;
      case 4:
        var_6 = "MP_TARGET_DESTROYED";
        break;
      case 5:
        var_6 = "MP_BOMB_DEFUSED";
        break;
      case 6:
        var_6 = "MP_GHOSTS_ELIMINATED";
        break;
      case 7:
        var_6 = "MP_FEDERATION_ELIMINATED";
        break;
      case 8:
        var_6 = "MP_GHOSTS_FORFEITED";
        break;
      case 9:
        var_6 = "MP_FEDERATION_FORFEITED";
        break;
      case 10:
        var_6 = "MP_ENEMIES_ELIMINATED";
        break;
      case 11:
        var_6 = "MP_MATCH_TIE";
        break;
      case 12:
        var_6 = "GAME_OBJECTIVECOMPLETED";
        break;
      case 13:
        var_6 = "GAME_OBJECTIVEFAILED";
        break;
      case 14:
        var_6 = "MP_SWITCHING_SIDES";
        break;
      case 15:
        var_6 = "MP_ROUND_LIMIT_REACHED";
        break;
      case 16:
        var_6 = "MP_ENDED_GAME";
        break;
      case 17:
        var_6 = "MP_HOST_ENDED_GAME";
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_3))
    var_3 = -1;

  var_7 = 18;
  var_8 = var_7;
  var_9 = getmatchdata("match_common", "player_count");
  var_10 = getmatchdata("match_common", "life_count");
  var_11 = getmatchdata("match_common", "playlist_name");
  var_12 = 0;

  if(isDefined(var_11)) {
    if(issubstr(var_11, "QA"))
      var_12 = 1;
  }

  if(!isDefined(level._id_6026)) {
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
  } else {
    if(isDefined(game["botJoinCount"]))
      var_13 = game["botJoinCount"];
    else
      var_13 = 0;

    if(isDefined(game["deathCount"]))
      var_14 = game["deathCount"];
    else
      var_14 = 0;

    if(isDefined(game["trapSpawnDiedTooFastCount"]))
      var_15 = game["trapSpawnDiedTooFastCount"];
    else
      var_15 = 0;

    if(isDefined(game["trapSpawnKilledTooFastCount"]))
      var_16 = game["trapSpawnKilledTooFastCount"];
    else
      var_16 = 0;

    if(isDefined(game["trapSpawnDmgDealtCount"]))
      var_17 = game["trapSpawnDmgDealtCount"];
    else
      var_17 = 0;

    if(isDefined(game["trapSpawnDmgReceivedCount"]))
      var_18 = game["trapSpawnDmgReceivedCount"];
    else
      var_18 = 0;

    if(isDefined(game["trapSpawnByAnyMeansCount"]))
      var_19 = game["trapSpawnByAnyMeansCount"];
    else
      var_19 = 0;

    if(isDefined(game["spawnClaimFlipCount"]))
      var_20 = game["spawnClaimFlipCount"];
    else
      var_20 = 0;
  }

  if(var_2)
    _func_0F5("script_mp_match_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, trapSpawnDiedTooFastCount %d, trapSpawnKilledTooFastCount %d, trapSpawnDmgDealtCount %d, trapSpawnDmgReceivedCount %d, trapSpawnByAnyMeansCount %d, spawnFlipCount %d, qaPlayList %d", var_4, var_3, var_5, var_6, var_8, var_9, var_13, var_10, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_12);
  else
    _func_0F5("script_mp_round_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, trapSpawnDiedTooFastCount %d, trapSpawnKilledTooFastCount %d, trapSpawnDmgDealtCount %d, trapSpawnDmgReceivedCount %d, trapSpawnByAnyMeansCount %d, spawnFlipCount %d, qaPlayList %d", var_4, var_3, var_5, var_6, var_8, var_9, var_13, var_10, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_12);
}

_id_36B9(var_0, var_1, var_2) {
  if(isDefined(level._id_36BA))
    return [[level._id_36BA]](var_0, var_1, var_2);

  if(!isDefined(var_2))
    var_2 = 0;

  if(game["state"] == "postgame" || level.gameended) {
    return;
  }
  game["state"] = "postgame";
  setDvar("2523", "postgame");
  level._id_3F9F = gettime();
  level.gameended = 1;
  level._id_5139 = 0;
  level notify("game_ended", var_0);
  maps\mp\_utility::levelflagset("game_over");
  maps\mp\_utility::levelflagset("block_notifies");
  var_3 = _id_44F8();
  var_4 = game["roundsPlayed"];
  _func_032("ui_game_duration", var_3 * 1000);
  waitframe();
  _func_137(0);
  var_5 = _func_131();
  setmatchdata("match_common", "game_length_seconds", var_3);
  setmatchdata("match_common", "utc_end_time", var_5);
  setmatchdata("match_common", "player_count_end", level.players.size);

  if(!_func_367()) {
    foreach(var_7 in level.players) {
      var_8 = getmatchdata("players", var_7.clientid, "playermatchtime_start_ms");
      var_9 = getmatchdata("players", var_7.clientid, "playermatchtime_total_ms");
      var_9 = var_9 + (level._id_3F9F - var_8);
      setmatchdata("players", var_7.clientid, "playermatchtime_total_ms", var_9);
      setmatchdata("players", var_7.clientid, "utc_disconnect_time_s", var_5);
      setmatchdata("players", var_7.clientid, "disconnect_reason", "EXE_MATCHENDED");

      if(!isDefined(var_7.has_recently_done_damage)) {
        if(isDefined(var_7.pers["rounds_without_damage"])) {
          var_7.pers["rounds_without_damage"]++;
          continue;
        }

        var_7.pers["rounds_without_damage"] = 1;
      }
    }
  }

  _id_21C1();
  game["roundsPlayed"]++;

  if(isDefined(var_0) && _func_031(var_0) && maps\mp\_utility::_id_576C(var_0)) {
    level._id_3B5C = "none";
    _id_6028(var_0, var_1, 0);
    _id_0485::_id_5E91(var_4, _func_155("axis"), _func_155("allies"));
    _id_050B::_id_5E90();
    _id_36BF(var_0, var_1);
  } else {
    if(isDefined(var_0) && _func_031(var_0) && var_0 == "halftime") {
      level._id_3B5C = "none";
      _id_6028(var_0, var_1, 0);
      _id_0485::_id_5E91(var_4, _func_155("axis"), _func_155("allies"));
      _id_050B::_id_5E90();
      _id_36BC(var_1);
      return;
    }

    if(isDefined(level._id_3B5C))
      level._id_3B57[level._id_3B5C] = maps\mp\_utility::getsecondspassed();

    if(level.gametype != "raid")
      _func_032("ui_current_round", game["roundsPlayed"]);

    if(level.teambased) {
      if((var_0 == "axis" || var_0 == "allies") && level.gametype != "ctf")
        game["roundsWon"][var_0]++;

      _id_04D2::_id_A174("axis");
      _id_04D2::_id_A174("allies");
    } else if(isDefined(var_0) && isPlayer(var_0))
      game["roundsWon"][var_0.guid]++;

    _id_04D2::_id_A14D();

    foreach(var_7 in level.players) {
      var_7 setclientdvar("3635", 1);

      if(maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround()) {
        var_7 _id_051E::_id_2400(1);
        var_7.pers["supportStreaksEarned"] = undefined;
      }
    }

    setDvar("2335", 1);
    setDvar("ui_allow_teamchange", 0);
    setDvar("4899", 0);
    _id_3E8C(1.0, 1);
    var_13 = isDefined(level._id_585D) && level._id_585D;

    if(var_13) {
      var_14 = 0;

      if(isDefined(level.zmb_shotgun_game_won))
        var_14 = common_scripts\utility::_id_562E(level.zmb_shotgun_game_won);
      else
        var_14 = var_1 == game["end_reason"]["zombies_completed"];

      if(var_14) {
        foreach(var_7 in level.players)[[level.zmb_events_on_map_won]](var_7);
      }
    } else
      _id_0485::_id_5E91(var_4, _func_155("axis"), _func_155("allies"));

    if(!maps\mp\_utility::wasonlyround() && !var_2 && !level._id_3E16) {
      _id_3015(var_0, var_1);

      if(isDefined(level._id_3B5C)) {
        foreach(var_7 in level.players)
        var_7 notify("reset_outcome");

        level notify("game_cleanup");
        level notify("nuke_cancelled");
        _id_A77D();
      }

      if(!maps\mp\_utility::waslastround()) {
        maps\mp\_utility::_id_5CBB("block_notifies");

        if(_id_21E1())
          _id_3016();

        foreach(var_7 in level.players) {
          var_7.pers["stats"] = var_7.stats;
          var_7.pers["segments"] = var_7._id_838A;
        }

        level notify("restarting");
        game["state"] = "playing";
        setDvar("2523", "playing");
        _id_6028(var_0, var_1, 0);
        _id_050B::_id_5E90();

        foreach(var_7 in level.players)
        game["firstbloodcount"][var_7.guid] = var_7._id_0097;

        _func_163(1);
        return;
      }

      if(!level._id_3E16)
        var_1 = _id_A10C(var_0);
    }

    if(!isDefined(game["clientMatchDataDef"])) {
      game["clientMatchDataDef"] = "mp/ddl/clientmatchdata.ddl";
      _func_12D(game["clientMatchDataDef"]);
    }

    _id_7A68(var_0, var_1);
    maps\mp\gametypes\_missions::_id_7F15(var_0);
    var_0 = _id_44FD(var_0, 1);

    if(level.teambased) {
      _func_032("ui_game_victor", 0);

      if(var_0 == "allies")
        _func_032("ui_game_victor", 2);
      else if(var_0 == "axis")
        _func_032("ui_game_victor", 1);
    }

    _id_300B(var_0, var_1);

    if(isDefined(level._id_3B5C) && maps\mp\_utility::wasonlyround()) {
      foreach(var_7 in level.players)
      var_7 notify("reset_outcome");

      level notify("game_cleanup");
      level notify("nuke_cancelled");
      _id_A77D();
    }

    if(isDefined(level._id_75E7))
      [[level._id_75E7]]();

    maps\mp\_utility::_id_5CBB("block_notifies");
    level._id_541D = 1;
    level notify("spawning_intermission");

    foreach(var_7 in level.players) {
      if(_func_2A3() && !_func_371() && (!isDefined(level._id_585D) || !level._id_585D))
        var_7 maps\mp\gametypes\_class::_id_1FA2(common_scripts\utility::_id_46AF());

      var_7 _meth_832C();
      var_7 _meth_8267();
      var_7 notify("reset_outcome");
      var_7 thread maps\mp\gametypes\_playerlogic::_id_9073();
    }

    _id_7758();
    _id_048D::_id_7743();
    _id_21BC();
    _id_A0F8(var_0);

    if(!level._id_585D) {
      if(level.teambased) {
        if(var_0 == "axis" || var_0 == "allies")
          setmatchdata("victor", var_0);
        else {
          setmatchdata("victor", "none");

          if(var_0 == "tie")
            setmatchdata("is_draw", 1);
        }

        _func_229(var_0);
      } else
        setmatchdata("victor", "none");
    }

    level _id_0485::_id_36DB();
    var_27 = _id_04D2::_id_450B(3);

    foreach(var_7 in level.players) {
      if(var_7 maps\mp\_utility::rankingenabled()) {
        var_7 _id_0485::_id_5E92();
        var_7 _id_0468::_id_0A1E(var_7._id_00E3, var_7.deaths, level.gametype, var_0);
      }

      var_7 maps\mp\gametypes\_playerlogic::_id_5EA9();

      if(!level._id_585D && !_func_367()) {
        if(level.teambased) {
          if(var_0 == "tie")
            setmatchdata("players", var_7.clientid, "match_result", "draw");
          else if(var_0 == "axis" || var_0 == "allies") {
            if(isDefined(var_7.team)) {
              if(var_7.team == var_0)
                setmatchdata("players", var_7.clientid, "match_result", "win");
              else
                setmatchdata("players", var_7.clientid, "match_result", "loss");
            }
          }

          continue;
        }

        if(isPlayer(var_0)) {
          setmatchdata("players", var_7.clientid, "match_result", "loss");

          if(level.players.size > 5) {
            foreach(var_30 in var_27) {
              if(var_7.clientid == var_30.clientid)
                setmatchdata("players", var_7.clientid, "match_result", "win");
            }

            continue;
          }

          if(var_7.clientid == var_0.clientid)
            setmatchdata("players", var_7.clientid, "match_result", "win");
        }
      }
    }

    setmatchdata("match_common", "host", maps\mp\gametypes\_playerlogic::_id_9E05(level._id_4E0E));

    if(maps\mp\_utility::matchmakinggame()) {
      setmatchdata("match_common", "playlist_version", _func_260());
      setmatchdata("match_common", "playlist_id", _func_261());
      setmatchdata("match_common", "isDedicated", _func_25F());
    }

    setmatchdata("match_common", "levelMaxClients", level._id_6079);

    if(isDefined(game["trapSpawnDiedTooFastCount"]) && isDefined(game["trapSpawnKilledTooFastCount"]))
      var_33 = game["trapSpawnDiedTooFastCount"] + game["trapSpawnKilledTooFastCount"];
    else
      var_33 = -1;

    if(isDefined(game["trapSpawnDmgDealtCount"]) && isDefined(game["trapSpawnDmgReceivedCount"]))
      var_34 = game["trapSpawnDmgDealtCount"] + game["trapSpawnDmgReceivedCount"];
    else
      var_34 = -1;

    if(isDefined(game["trapSpawnByAnyMeansCount"]))
      var_35 = game["trapSpawnByAnyMeansCount"];
    else
      var_35 = -1;

    if(isDefined(game["objectiveFlipCount"]))
      var_36 = game["objectiveFlipCount"];
    else
      var_36 = -1;

    setmatchdata("match_common", "spawnTuningVersion", common_scripts\utility::_id_9AAD(level._id_90B4));
    setmatchdata("match_common", "victimSpawnCount", var_33);
    setmatchdata("match_common", "immediateActionCount", var_34);
    setmatchdata("match_common", "badSpawnByAnyMeansCount", var_35);
    setmatchdata("match_common", "objectiveFlipCount", var_36);
    _func_38D();
    _func_125();
    _func_376();

    if(_id_050B::_id_57DC(level.gametype) && isDefined(level._id_903C))
      _func_379();

    _func_37D();

    foreach(var_7 in level.players) {
      var_7.pers["stats"] = var_7.stats;
      var_7.pers["segments"] = var_7._id_838A;
    }

    _func_22A();
    var_39 = 0;

    if(maps\mp\_utility::_id_761E())
      var_39 = 5.0;

    if(isDefined(level._id_36C3))
      [[level._id_36C3]](var_2, level._id_75E4, var_39, var_0);

    if(_func_3A9()) {
      while(!_func_3AA())
        wait 0.25;

      wait 1.0;
    }

    _id_6028(var_0, var_1, 1);
    _id_050B::_id_5E90();

    if(!common_scripts\utility::_id_562E(level._id_3E16) && maps\mp\_utility::_id_579B() && isDefined(game["switchedsides"]) && !game["switchedsides"]) {
      if(isDefined(level._id_36C0))
        [[level._id_36C0]]();

      game["game_one_winner"] = var_0;
      game["roundsPlayed"] = 0;
      game["switchedsides"] = 1;
      game["state"] = "playing";
      setDvar("2523", game["state"]);
      _func_163(1);
      return;
    }

    if(common_scripts\utility::_id_562E(level._id_7DD2)) {
      _func_163(0);
      return;
    }

    level notify("exitLevel_called");
    exitlevel(0);
  }
}

_id_44FD(var_0, var_1) {
  if(isDefined(level.getgamewinnerfunc))
    return [[level.getgamewinnerfunc]](var_0, var_1);

  if(!_func_031(var_0))
    return var_0;

  var_2 = var_0;

  if(level.teambased && (maps\mp\_utility::isroundbased() || level.gametype == "ctf") && level.gameended && !isDefined(level._id_3E39)) {
    var_3 = "roundsWon";

    if(isDefined(level._id_AA24) && level._id_AA24)
      var_3 = "teamScores";

    if(game[var_3]["allies"] == game[var_3]["axis"])
      var_2 = "tie";
    else if(game[var_3]["axis"] > game[var_3]["allies"])
      var_2 = "axis";
    else
      var_2 = "allies";
  }

  if(var_1 && (var_2 == "allies" || var_2 == "axis"))
    level._id_3B5C = var_2;

  return var_2;
}

_id_A10C(var_0) {
  if(!level.teambased)
    return 1;

  if(maps\mp\_utility::hitroundlimit())
    return game["end_reason"]["round_limit_reached"];

  if(maps\mp\_utility::hitwinlimit())
    return game["end_reason"]["score_limit_reached"];

  return game["end_reason"]["objective_completed"];
}

_id_3878(var_0) {
  var_1 = _id_4673(var_0);
  var_2 = _id_4674(var_0);
  var_3 = 999999;

  if(var_1)
    var_3 = var_2 / var_1;

  return var_3;
}

_id_4673(var_0) {
  var_1 = maps\mp\_utility::getwatcheddvar("scorelimit");
  var_2 = maps\mp\_utility::gettimelimit();
  var_3 = maps\mp\_utility::gettimepassed() / 60000 + 0.0001;

  if(isPlayer(self))
    var_4 = self.score / var_3;
  else
    var_4 = _func_155(var_0) / var_3;

  return var_4;
}

_id_4674(var_0) {
  var_1 = maps\mp\_utility::getwatcheddvar("scorelimit");

  if(isPlayer(self))
    var_2 = var_1 - self.score;
  else
    var_2 = var_1 - _func_155(var_0);

  return var_2;
}

_id_478F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);

  if(level._id_6520) {
    foreach(var_1 in level._id_985B) {
      if(self.pers["team"] != var_1)
        thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_1);
    }
  } else {
    var_3 = maps\mp\_utility::getotherteam(self.pers["team"]);
    thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_3);
  }

  level notify("last_alive", self);
}

_id_7758() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2._id_241A = var_0;
    var_0++;

    if(isDefined(level._id_585D) && level._id_585D)
      var_2._id_241A = var_2 getentitynumber();

    _func_12B("players", var_2._id_241A, "name", maps\mp\gametypes\_playerlogic::_id_9E05(var_2.name));
    _func_12B("players", var_2._id_241A, "xuid", var_2._id_01D6);
  }

  _id_046D::_id_10DD();
  _id_048B::_id_7759();
  _func_12E();

  if(!_func_367())
    _func_225();
}

_id_9BC0(var_0, var_1) {
  thread _id_996D(var_0, 1, "deaths");
}

_id_9BA0(var_0, var_1, var_2) {
  if(isDefined(self) && isPlayer(self)) {
    if(var_1 != "MOD_FALLING") {
      thread _id_996D(var_0, 1, "kills");

      if(maps\mp\_utility::_id_5755(var_1) && issubstr(var_0, "tactical")) {
        return;
      }
      if(maps\mp\_utility::_id_5755(var_1) && !issubstr(var_0, "riotshield") && !issubstr(var_0, "combatknife")) {
        return;
      }
      var_3 = 0;

      if(isDefined(var_2) && isDefined(var_2._id_3BE0))
        var_3 = var_2._id_3BE0;
      else
        var_3 = self _meth_8345();

      if(var_3 < 0.2) {
        thread _id_996D(var_0, 1, "hipfirekills");

        if(isDefined(self._id_0079) && self._id_0079 == 7) {}
      }
    }

    if(var_1 == "MOD_HEAD_SHOT")
      thread _id_996D(var_0, 1, "headShots");
  }
}

_id_8A67(var_0, var_1, var_2) {
  if(_func_367()) {
    return;
  }
  if(!var_1) {
    return;
  }
  var_3 = maps\mp\_utility::getweaponclass(var_0);

  if(var_3 == "killstreak" || var_3 == "other") {
    return;
  }
  if(maps\mp\_utility::_id_56DF(var_0)) {
    return;
  }
  if(maps\mp\_utility::_id_568F(var_0) || maps\mp\_utility::isuseweapon(var_0)) {
    return;
  }
  if(var_3 == "weapon_grenade" || var_3 == "weapon_explosive") {
    if(var_0 == "frag_grenade_german_mp")
      var_0 = "frag_grenade_mp";

    if(var_0 == "signal_flare_expeditionary_mp")
      var_0 = "signal_flare_mp";

    maps\mp\gametypes\_persistence::_id_50FF(var_0, var_2, var_1);
    _id_0485::_id_5EAF(var_0, var_2, var_1, var_0);
    return;
  }

  var_4 = _id_0513::_id_5794(var_0);

  if(var_2 != "timeInUse" && var_2 != "deaths" && !var_4) {
    var_5 = var_0;
    var_6 = self getcurrentweapon();

    if(_func_1A9(var_5) == "melee" || _func_1A9(var_6) == "melee") {
      if(var_2 == "kills") {
        maps\mp\gametypes\_persistence::_id_A195();
        self._id_9BBB = var_5;
        self._id_9BBA++;
        maps\mp\gametypes\_persistence::_id_A195();

        if(!maps\mp\_utility::privatematch()) {
          var_7 = maps\mp\_utility::_id_45B5(var_5);

          if(maps\mp\_utility::iscacprimaryweapon(var_7) || maps\mp\_utility::iscacsecondaryweapon(var_7)) {
            var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_7, "kills");
            self _meth_82A2(var_8);
          }
        }

        return;
      }
    }

    if(var_5 != var_6) {
      if(maps\mp\_utility::iskillstreakweapon(var_6)) {
        return;
      }
      var_0 = var_6;
    }
  }

  if(!isDefined(self._id_9BBB))
    self._id_9BBB = var_0;

  if(var_0 != self._id_9BBB) {
    maps\mp\gametypes\_persistence::_id_A195();
    self._id_9BBB = var_0;
  }

  switch (var_2) {
    case "shots":
      self._id_9BBC++;
      break;
    case "hits":
      self._id_9BB9++;
      break;
    case "headShots":
      self._id_9BB7++;
      break;
    case "kills":
      self._id_9BBA++;
      break;
    case "hipfirekills":
      self._id_9BB8++;
      break;
    case "timeInUse":
      self._id_9BBD = self._id_9BBD + var_1;
      break;
    case "assists":
      self.trackingweaponassists++;
      break;
    case "multikills":
      self.trackingweaponmultikills++;
      break;
  }

  if(isDefined(var_0) && var_0 != "none" && var_2 == "kills" && !maps\mp\_utility::privatematch()) {
    var_7 = maps\mp\_utility::_id_45B5(var_0);

    if(maps\mp\_utility::iscacprimaryweapon(var_7) || maps\mp\_utility::iscacsecondaryweapon(var_7)) {
      var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_7, "kills");
      var_8 = var_8 + self._id_9BBA;
      self _meth_82A2(var_8);
    }
  }

  if(var_2 == "deaths") {
    var_9 = maps\mp\_utility::_id_4431(var_0);

    if(!maps\mp\_utility::iscacprimaryweapon(var_9) && !maps\mp\_utility::iscacsecondaryweapon(var_9)) {
      return;
    }
    var_10 = maps\mp\_utility::_id_4725(var_0);
    maps\mp\gametypes\_persistence::_id_50FF(var_9, var_2, var_1);
    _id_0485::_id_5EAF(var_9, "deaths", var_1, var_0);

    foreach(var_12 in var_10)
    maps\mp\gametypes\_persistence::_id_50F9(var_12, var_2, var_1);
  }
}

_id_86B0(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 _id_8A67(var_2, 1, "hits");
    return;
  }

  if(!isDefined(var_0._id_73AE))
    var_0._id_73AE = [];

  var_3 = 1;

  for(var_4 = 0; var_4 < var_0._id_73AE.size; var_4++) {
    if(var_0._id_73AE[var_4] == self) {
      var_3 = 0;
      break;
    }
  }

  if(var_3) {
    var_0._id_73AE[var_0._id_73AE.size] = self;
    var_1 _id_8A67(var_2, 1, "hits");
  }
}

_id_996D(var_0, var_1, var_2) {
  self endon("disconnect");
  waittillframeend;
  _id_8A67(var_0, var_1, var_2);
}

_id_21BC() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 maps\mp\_utility::rankingenabled()) {
      var_2 = var_1.pers["summary"]["xp"];

      if(!isDefined(level.disableallplayerstats) || !level.disableallplayerstats) {
        var_3 = getmatchdata("players", var_1.clientid, "playermatchtime_total_ms");
        var_4 = var_1 getplayerdata(common_scripts\utility::_id_46A7(), "round", "kills");
        var_5 = var_1 getplayerdata(common_scripts\utility::_id_46A7(), "round", "deaths");
        var_6 = var_1.score;
        var_7 = 0;

        if(var_3 > 0)
          var_7 = var_6 / (var_3 / 3600);

        var_8 = _id_4668(var_1);
        var_9 = var_1 getplayerdata(common_scripts\utility::_id_46AE(), "bestKills");
        var_10 = var_1 getplayerdata(common_scripts\utility::_id_46AE(), "mostDeaths");
        var_11 = var_1 getplayerdata(common_scripts\utility::_id_46AE(), "mostXp");
        var_12 = var_1 getplayerdata(common_scripts\utility::_id_46AE(), "bestScore");
        var_13 = var_1 getplayerdata(common_scripts\utility::_id_46AE(), "bestSPM");
        var_14 = var_1 getplayerdata(common_scripts\utility::_id_46AE(), "bestAccuracy");

        if(var_4 > var_9) {
          var_1 setplayerdata(common_scripts\utility::_id_46AE(), "bestKills", var_4);
          setmatchdata("players", var_1.clientid, "best_kills", 1);
        }

        if(var_2 > var_11)
          var_1 setplayerdata(common_scripts\utility::_id_46AE(), "mostXp", var_2);

        if(var_5 > var_10)
          var_1 setplayerdata(common_scripts\utility::_id_46AE(), "mostDeaths", var_5);

        if(var_6 > var_12) {
          var_1 setplayerdata(common_scripts\utility::_id_46AE(), "bestScore", var_6);
          setmatchdata("players", var_1.clientid, "best_score", 1);
        }

        if(var_7 > var_13)
          var_1 setplayerdata(common_scripts\utility::_id_46AE(), "bestSPM", var_7);

        if(var_8 > var_14)
          var_1 setplayerdata(common_scripts\utility::_id_46AE(), "bestAccuracy", var_8);

        var_1 _id_21B4();
      }

      var_1 _id_0485::_id_5EAA(var_2, "total_xp");
      var_1 _id_0485::_id_5EAA(var_1.pers["summary"]["score"], "score_xp");
      var_1 _id_0485::_id_5EAA(var_1.pers["summary"]["challenge"], "challenge_xp");
      var_1 _id_0485::_id_5EAA(var_1.pers["summary"]["match"], "bonus_xp");
      var_1 _id_0485::_id_5EAA(var_1.pers["summary"]["misc"] + var_1.pers["summary"]["entitlementXP"] + var_1.pers["summary"]["doubleXp"], "misc_xp");
    }

    if(isDefined(var_1.pers["confirmed"]))
      var_1 _id_0485::_id_5E97();

    if(isDefined(var_1.pers["denied"]))
      var_1 _id_0485::_id_5E98();
  }
}

_id_4668(var_0) {
  var_1 = _func_0AD(var_0 getplayerdata(common_scripts\utility::_id_46AE(), "totalShots") - var_0.pers["previous_shots"]);

  if(var_1 == 0)
    return 0;

  var_2 = _func_0AD(var_0 getplayerdata(common_scripts\utility::_id_46AE(), "hits") - var_0.pers["previous_hits"]);
  var_3 = clamp(var_2 / var_1, 0.0, 1.0) * 10000.0;
  return int(var_3);
}

_id_21B4() {
  var_0 = _id_0485::_id_1D40();
  var_1 = self getplayerdata(common_scripts\utility::_id_46AE(), "bestWeapon", "kills");
  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "bestWeaponID");
  var_3 = var_1;
  var_4 = "";

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    var_6 = maps\mp\_utility::_id_4431(var_6);

    if(!_func_367() && maps\mp\_utility::_id_5716(var_6)) {
      continue;
    }
    if(issubstr(var_6, "riotshield_mp") || issubstr(var_6, "war_super_soldier_syrum_")) {
      continue;
    }
    var_7 = maps\mp\_utility::getweaponclass(var_6);

    if(!maps\mp\_utility::iskillstreakweapon(var_6) && var_7 != "killstreak" && var_7 != "other") {
      var_8 = 0;

      if(isDefined(self.pers["mpWeaponStats"][var_6]) && isDefined(self.pers["mpWeaponStats"][var_6]["kills"])) {
        var_8 = self.pers["mpWeaponStats"][var_6]["kills"];

        if(var_8 > var_3) {
          var_3 = var_8;
          var_4 = var_6;
        }
      }
    }
  }

  if(var_3 > var_1) {
    self setplayerdata(common_scripts\utility::_id_46AE(), "bestWeapon", "kills", var_3);
    var_9 = 0;

    if(isDefined(self.pers["mpWeaponStats"][var_4]["shots"]))
      var_9 = self.pers["mpWeaponStats"][var_4]["shots"];

    var_10 = 0;

    if(isDefined(self.pers["mpWeaponStats"][var_4]["headShots"]))
      var_10 = self.pers["mpWeaponStats"][var_4]["headShots"];

    var_11 = 0;

    if(isDefined(self.pers["mpWeaponStats"][var_4]["hits"]))
      var_11 = self.pers["mpWeaponStats"][var_4]["hits"];

    var_12 = 0;

    if(isDefined(self.pers["mpWeaponStats"][var_4]["deaths"]))
      var_12 = self.pers["mpWeaponStats"][var_4]["deaths"];

    var_13 = 0;

    if(isDefined(self.pers["mpWeaponStats"][var_4]["assists"]))
      var_13 = self.pers["mpWeaponStats"][var_4]["assists"];

    self setplayerdata(common_scripts\utility::_id_46AE(), "bestWeapon", "shots", var_9);
    self setplayerdata(common_scripts\utility::_id_46AE(), "bestWeapon", "headShots", var_10);
    self setplayerdata(common_scripts\utility::_id_46AE(), "bestWeapon", "hits", var_11);
    self setplayerdata(common_scripts\utility::_id_46AE(), "bestWeapon", "deaths", var_12);
    self setplayerdata(common_scripts\utility::_id_46AE(), "bestWeapon", "assists", var_13);
    var_14 = maps\mp\_utility::_id_452A(var_4);
    self setplayerdata(common_scripts\utility::_id_46AE(), "bestWeaponID", var_14);
  }
}

_id_A0FC() {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_0 = 5;
  var_1 = var_0 * 2;
  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "numTrends");
  var_2++;
  var_3 = var_2;

  if(var_2 > var_0) {
    if(var_2 > var_1)
      var_2 = var_0 + 1;

    var_3 = var_2 - var_0;
  }

  var_4 = maps\mp\_utility::_id_46E7();

  if(isDefined(self._id_00E3))
    var_5 = self._id_00E3;
  else
    var_5 = 0;

  if(isDefined(self.deaths))
    var_6 = self.deaths;
  else
    var_6 = 0;

  if(isDefined(self.score))
    var_7 = self.score;
  else
    var_7 = 0;

  var_8 = maps\mp\_utility::getpersstat("headshots");
  var_9 = getmatchdata("players", self.clientid, "playermatchtime_total_ms");
  var_10 = getmatchdata("players", self.clientid, "total_xp");
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "timestamp", var_4);
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "kills", var_5);
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "deaths", var_6);
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "score", var_7);
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "headshots", var_8);
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "timeplayed", var_9);
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "totalXp", var_10);

  if(level.gametype == "ctf" || level.gametype == "dom") {
    var_11 = maps\mp\_utility::getpersstat("captures");
    self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "trend", var_3 - 1, "captures", var_11);
  }

  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "numTrends", var_2);
}

updatecombatrecordforplayertrendszombies() {
  var_0 = 5;
  var_1 = var_0 * 2;
  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "numTrends");
  var_2++;
  var_3 = var_2;

  if(var_2 > var_0) {
    if(var_2 > var_1)
      var_2 = var_0 + 1;

    var_3 = var_2 - var_0;
  }

  if(isDefined(self._id_00E3))
    var_4 = self._id_00E3;
  else
    var_4 = 0;

  var_5 = maps\mp\_utility::_id_46E7();
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = _func_12C("alliesScore");
  self setplayerdata(common_scripts\utility::_id_46A8(), "combatRecord", "trend", var_3 - 1, "timestamp", var_5);
  self setplayerdata(common_scripts\utility::_id_46A8(), "combatRecord", "trend", var_3 - 1, "timeplayed", var_7);
  self setplayerdata(common_scripts\utility::_id_46A8(), "combatRecord", "trend", var_3 - 1, "totalXp", var_8);
  self setplayerdata(common_scripts\utility::_id_46A8(), "combatRecord", "trend", var_3 - 1, "kills", var_4);
  self setplayerdata(common_scripts\utility::_id_46A8(), "combatRecord", "trend", var_3 - 1, "headshots", var_6);
  self setplayerdata(common_scripts\utility::_id_46A8(), "combatRecord", "trend", var_3 - 1, "waveReached", var_9);
  self setplayerdata(common_scripts\utility::_id_46A8(), "combatRecord", "numTrends", var_2);
}

updaterankedplaydata() {
  if(!_func_3AF()) {
    return;
  }
  if(isDefined(self._id_00E3))
    var_0 = self._id_00E3;
  else
    var_0 = 0;

  if(isDefined(self.deaths))
    var_1 = self.deaths;
  else
    var_1 = 0;

  var_2 = maps\mp\_utility::getpersstat("headshots");
  var_3 = int(getmatchdata("players", self.clientid, "playermatchtime_total_ms") / 1000.0);
  var_4 = _func_3B5();
  var_5 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "kills");
  var_6 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "deaths");
  var_7 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "headshots");
  var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "timeplayed");
  self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "kills", var_5 + var_0);
  self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "deaths", var_6 + var_1);
  self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "headshots", var_7 + var_2);
  self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_4, "timeplayed", var_8 + var_3);
  _id_0508::giverankadvancerewards(var_4);
}

updatecombatrecordraiddata() {
  var_0 = maps\mp\_utility::_id_46E7();
  _id_8651("timeStampLastGame", var_0);
  _id_50FB("timePlayed", self._id_9A06["total"]);
  _id_50FB("xpEarned", self.pers["summary"]["xp"]);

  if(isDefined(self.score) && self.score > 0)
    _id_50FB("score", self.score);

  if(game["switchedsides"]) {
    var_1 = 0;
    var_2 = 0;

    if(isDefined(self._id_2533)) {
      var_1++;
      var_2--;
    }

    if(isDefined(game["game_one_winner"]) && self.team == game["game_one_winner"] && !didplayerjipgametwo(self)) {
      var_1++;
      var_2--;
    }

    if(common_scripts\utility::_id_562E(self._id_5969) && !common_scripts\utility::_id_562E(self.pers["recordedLoss"]))
      var_2 = 0;

    if(var_1 > 0)
      _id_50FB("wins", var_1);

    if(var_2 != 0)
      _id_50FB("losses", var_2);

    if(didplayerjipgametwo(self))
      _id_50FB("numMatches", 1);
  } else {
    _id_50FB("numMatches", 2);

    if(!common_scripts\utility::_id_562E(self._id_5969))
      _id_50FB("losses", 2);
  }

  var_3 = level.gametype;

  if(isDefined(level.hardcoremode) && level.hardcoremode)
    var_3 = var_3 + "_hc";

  var_4 = self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_3, "timeStampFirstGame");

  if(var_4 == 0)
    _id_8651("timeStampFirstGame", var_0);
}

_id_A0F9() {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_0 = maps\mp\_utility::_id_46E7();
  _id_8651("timeStampLastGame", var_0);
  _id_50FB("numMatches", 1);
  _id_50FB("timePlayed", self._id_9A06["total"]);
  _id_50FB("kills", self._id_00E3);
  _id_50FB("deaths", self.deaths);
  _id_50FB("xpEarned", self.pers["summary"]["xp"]);

  if(isDefined(self._id_2533))
    _id_50FB("wins", 1);

  if(isDefined(self._id_2532))
    _id_50FB("ties", 1);

  if(isDefined(self.pers["combatRecordLoss"]))
    _id_50FB("losses", 1);

  if(isDefined(self.score) && self.score > 0)
    _id_50FB("score", self.score);

  var_1 = level.gametype;

  if(isDefined(level.hardcoremode) && level.hardcoremode)
    var_1 = var_1 + "_hc";

  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_1, "timeStampFirstGame");

  if(var_2 == 0)
    _id_8651("timeStampFirstGame", var_0);

  if(isDefined(self.pers["badSpawnByAnyMeansCount"]))
    _id_50FE("badSpawnByAnyMeansCount", self.pers["badSpawnByAnyMeansCount"]);

  if(isDefined(self.pers["immediateActionSpawnCount"]))
    _id_50FE("immediateActionSpawnCount", self.pers["immediateActionSpawnCount"]);

  if(isDefined(self.pers["victimSpawnCount"]))
    _id_50FE("victimSpawnCount", self.pers["victimSpawnCount"]);

  if(isDefined(self.pers["causedBadSpawnByAnyMeansCount"]))
    _id_50FE("causedBadSpawnByAnyMeansCount", self.pers["causedBadSpawnByAnyMeansCount"]);

  if(isDefined(self.pers["causedImmediateActionSpawnCount"]))
    _id_50FE("causedImmediateActionSpawnCount", self.pers["causedImmediateActionSpawnCount"]);

  if(isDefined(self.pers["causedVictimSpawnCount"]))
    _id_50FE("causedVictimSpawnCount", self.pers["causedVictimSpawnCount"]);
}

_id_50FE(var_0, var_1) {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), var_0);
  var_2 = var_2 + var_1;
  self setplayerdata(common_scripts\utility::_id_46AE(), var_0, var_2);
}

_id_50FB(var_0, var_1) {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_2 = level.gametype;

  if(isDefined(level.hardcoremode) && level.hardcoremode)
    var_2 = var_2 + "_hc";

  var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_2, var_0);
  var_3 = var_3 + var_1;
  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_2, var_0, var_3);
}

_id_8651(var_0, var_1) {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_2 = level.gametype;

  if(isDefined(level.hardcoremode) && level.hardcoremode)
    var_2 = var_2 + "_hc";

  self setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_2, var_0, var_1);
}

_id_446D(var_0) {
  var_1 = level.gametype;

  if(isDefined(level.hardcoremode) && level.hardcoremode)
    var_1 = var_1 + "_hc";

  return self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_1, var_0);
}

_id_8652(var_0, var_1) {
  var_2 = level.gametype;

  if(isDefined(level.hardcoremode) && level.hardcoremode)
    var_2 = var_2 + "_hc";

  var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_2, var_0);

  if(var_1 > var_3)
    _id_8651(var_0, var_1);
}

setcombatrecordstatifgreaterflagmatchdata(var_0, var_1, var_2) {
  var_3 = level.gametype;

  if(isDefined(level.hardcoremode) && level.hardcoremode)
    var_3 = var_3 + "_hc";

  var_4 = self getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", var_3, var_0);

  if(var_1 > var_4) {
    _id_8651(var_0, var_1);
    setmatchdata("players", self.clientid, var_2, 1);
  }
}

_id_A0FB(var_0) {
  if(level.gametype == "war" || level.gametype == "dm" || level.gametype == "onevone") {
    _id_A0F9();
    var_1 = self.deaths;

    if(var_1 == 0)
      var_1 = 1;

    var_2 = int(self._id_00E3 / var_1) * 1000;

    if(level.gametype == "war" || level.gametype == "dm") {
      var_3 = maps\mp\_utility::getpersstat("headshots");
      _id_50FB("headshots", var_3);
      _id_50FB("assists", self._id_0021);
    }

    setcombatrecordstatifgreaterflagmatchdata("mostkills", self._id_00E3, "best_kills");
    setcombatrecordstatifgreaterflagmatchdata("bestkdr", var_2, "best_kdr");
  } else if(level.gametype == "ctf") {
    _id_A0F9();
    var_4 = maps\mp\_utility::getpersstat("captures");
    var_5 = maps\mp\_utility::getpersstat("returns");
    _id_50FB("captures", var_4);
    _id_50FB("returns", var_5);
    _id_8652("mostcaptures", var_4);
    _id_8652("mostreturns", var_5);
  } else if(level.gametype == "dom" || level.gametype == "control") {
    _id_A0F9();
    var_4 = maps\mp\_utility::getpersstat("captures");
    var_6 = maps\mp\_utility::getpersstat("defends");
    _id_50FB("captures", var_4);
    _id_50FB("defends", var_6);
    _id_8652("mostcaptures", var_4);
    _id_8652("mostdefends", var_6);
  } else if(level.gametype == "conf") {
    _id_A0F9();
    var_7 = maps\mp\_utility::getpersstat("confirmed");
    var_8 = maps\mp\_utility::getpersstat("denied");
    _id_50FB("confirms", var_7);
    _id_50FB("denies", var_8);
    _id_8652("mostconfirms", var_7);
    _id_8652("mostdenies", var_8);
  } else if(level.gametype == "sd" || level.gametype == "demo") {
    _id_A0F9();
    var_9 = maps\mp\_utility::getpersstat("plants");
    var_10 = maps\mp\_utility::getpersstat("defuses");
    var_11 = maps\mp\_utility::getpersstat("destructions");
    _id_50FB("plants", var_9);
    _id_50FB("defuses", var_10);
    _id_50FB("detonates", var_11);
    _id_8652("mostplants", var_9);
    _id_8652("mostdefuses", var_10);
    _id_8652("mostdetonates", var_11);
  } else if(level.gametype == "hp") {
    _id_A0F9();
    var_4 = maps\mp\_utility::getpersstat("captures");
    var_6 = maps\mp\_utility::getpersstat("defends");
    var_12 = maps\mp\_utility::getpersstat("time");
    _id_50FB("totalHPTime", var_12);
    _id_50FB("captures", var_4);
    _id_50FB("defends", var_6);
    _id_8652("mostcaptures", var_4);
    _id_8652("mostdefends", var_6);
  } else if(level.gametype == "sr") {
    _id_A0F9();
    var_9 = maps\mp\_utility::getpersstat("plants");
    var_10 = maps\mp\_utility::getpersstat("defuses");
    var_11 = maps\mp\_utility::getpersstat("destructions");
    var_7 = maps\mp\_utility::getpersstat("confirmed");
    var_8 = maps\mp\_utility::getpersstat("denied");
    _id_50FB("plants", var_9);
    _id_50FB("defuses", var_10);
    _id_50FB("detonates", var_11);
    _id_50FB("confirms", var_7);
    _id_50FB("denies", var_8);
    _id_8652("mostplants", var_9);
    _id_8652("mostdefuses", var_10);
    _id_8652("mostdetonates", var_11);
    _id_8652("mostconfirms", var_7);
    _id_8652("mostdenies", var_8);
  } else if(level.gametype == "infect") {
    _id_A0F9();
    var_13 = maps\mp\_utility::getplayerstat("contagious");
    var_14 = self._id_00E3 - var_13;
    _id_50FB("infectedKills", var_14);
    _id_50FB("survivorKills", var_13);
    _id_8652("mostInfectedKills", var_14);
    _id_8652("mostSurvivorKills", var_13);
  } else if(level.gametype == "gun") {
    _id_A0F9();
    var_15 = maps\mp\_utility::getplayerstat("levelup");
    var_16 = maps\mp\_utility::getplayerstat("humiliation");
    _id_50FB("gunPromotions", var_15);
    _id_50FB("stabs", var_16);
    _id_8652("mostGunPromotions", var_15);
    _id_8652("mostStabs", var_16);
  } else if(level.gametype == "ball") {
    _id_A0F9();
    var_17 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
    var_18 = maps\mp\_utility::getplayerstat("killedBallCarrier");
    var_19 = 0;

    if(isDefined(self._id_200D))
      var_19 = self._id_200D;

    _id_50FB("carries", var_19);
    _id_50FB("pointsScored", var_17);
    _id_50FB("killedBallCarrier", var_18);
    _id_8652("mostPointsScored", var_17);
    _id_8652("mostKilledBallCarrier", var_18);
  } else if(level.gametype == "twar") {
    _id_A0F9();
    var_4 = maps\mp\_utility::getpersstat("captures");
    var_20 = maps\mp\_utility::getplayerstat("kill_while_capture");
    _id_50FB("captures", var_4);
    _id_50FB("killWhileCaptures", var_20);
    _id_8652("mostCaptures", var_4);
    _id_8652("mostKillWhileCaptures", var_20);
  } else if(level.gametype == "lockdown") {
    _id_A0F9();
    var_4 = maps\mp\_utility::getpersstat("captures");
    var_6 = maps\mp\_utility::getpersstat("defends");
    _id_50FB("captures", var_4);
    _id_50FB("defends", var_6);
    _id_8652("mostcaptures", var_4);
    _id_8652("mostdefends", var_6);
  } else if(level.gametype == "blades") {
    _id_A0F9();
    var_21 = maps\mp\_utility::getpersstat("throwingKnifeKills");
    var_22 = maps\mp\_utility::getpersstat("meleeKnifeKills");
    _id_50FB("throwingKnifeKills", var_21);
    _id_50FB("meleeKnifeKills", var_22);
    _id_8652("mostThrowingKnifeKillss", var_21);
    _id_8652("mostMeleeKnifeKills", var_22);
  } else if(level.gametype == "scorestreak_training") {
    _id_A0F9();
    var_23 = maps\mp\_utility::getpersstat("scorestreaksCalled");
    var_24 = maps\mp\_utility::getpersstat("scorestreaksDowned");
    _id_50FB("scorestreaksCalled", var_23);
    _id_50FB("scorestreaksDowned", var_24);
    _id_8652("mostScorestreaksCalled", var_23);
    _id_8652("mostScorestreaksDowned", var_24);
  } else if(level.gametype == "raid") {
    updatecombatrecordraiddata();
    _id_633D(var_0);
    var_25 = maps\mp\_utility::getpersstat("raidKillz");
    var_6 = maps\mp\_utility::getpersstat("defends");
    var_26 = maps\mp\_utility::getpersstat("constructs");
    var_27 = maps\mp\_utility::getpersstat("destructs");
    _id_50FB("kills", var_25);
    _id_50FB("defends", var_6);
    _id_50FB("constructs", var_26);
    _id_50FB("destructs", var_27);
    _id_8652("mostDefends", var_6);
    _id_8652("mostConstructs", var_26);
    _id_8652("mostDestructs", var_27);
  }
}

_id_633D(var_0) {
  if(isDefined(var_0) && !(self.team == var_0)) {
    return;
  }
  var_1 = _id_446D("wins");

  if(var_1 >= 10) {
    return;
  }
  if(!game["switchedsides"] && isDefined(var_0) && self.team == var_0)
    var_1++;

  if(maps\mp\_utility::rankingenabled() && level.gametype == "raid" && var_1 >= 5)
    self _meth_80F0("MP_WAR_5");
}

_id_A0FA(var_0) {
  if(_func_3AF())
    updaterankedplaydata();
  else {
    _id_A0FC();
    _id_A0FB(var_0);
  }
}

updatecombatrecordforplayerzombies(var_0) {
  updatecombatrecordforplayertrendszombies();
}

_id_A0F8(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2) || !isDefined(var_2._id_2582) || !var_2._id_2582) {
      continue;
    }
    if(var_2 maps\mp\_utility::rankingenabled())
      var_2 _id_A0FA(var_0);

    if(!(isDefined(level._id_585D) && level._id_585D))
      level maps\mp\gametypes\_playerlogic::_id_AABB(var_2);

    if(maps\mp\_utility::_id_761E())
      level maps\mp\gametypes\_playerlogic::_id_21DF(var_2);

    if(isDefined(level._id_585D) && level._id_585D)
      var_2 updatecombatrecordforplayerzombies(var_0);
  }
}

getweaponlevelingtablename() {
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled())
    return "mp/weaponLevelingDivisionsOverhaul.csv";
  else
    return "mp/weaponLeveling.csv";
}

_id_47C6(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(isDefined(level._id_2FAA) && level._id_2FAA) {
    return;
  }
  if(!(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::_id_761E())) {
    return;
  }
  if(_func_3AF()) {
    return;
  }
  if(level.gametype == "gun" || level.gametype == "blades" || level.gametype == "infect" || level.gametype == "prop" || level.gametype == "br" || level.gametype == "aon" || level.gametype == "oitc" || getdvarint("scr_oneShot", 0) == 1) {
    return;
  }
  if(!isDefined(self.class) || !issubstr(self.class, "custom")) {
    return;
  }
  var_3 = maps\mp\_utility::_id_4431(var_0);

  if(maps\mp\_utility::_id_5856(var_3))
    var_3 = maps\mp\gametypes\_class::_id_4432(var_3);

  if(!self isitemunlocked2(var_3)) {
    return;
  }
  if(maps\mp\_utility::iskillstreakweapon(var_3)) {
    return;
  }
  if(var_0 == "teslagunmtx_mp") {
    return;
  }
  if(!_id_0513::_id_5795(var_3) && !_id_0513::_id_5756(var_3)) {
    return;
  }
  switch (level.gametype) {
    case "war":
      var_4 = 1;
      break;
    case "dom":
      var_4 = 2;
      break;
    case "undead":
    case "hp":
      var_4 = 3;
      break;
    case "ctf":
      var_4 = 4;
      break;
    case "conf":
      var_4 = 5;
      break;
    case "sd":
      var_4 = 6;
      break;
    case "sr":
      var_4 = 7;
      break;
    case "dm":
      var_4 = 8;
      break;
    case "ball":
      var_4 = 9;
      break;
    case "demo":
      var_4 = 10;
      break;
    case "raid":
      var_4 = 11;
      break;
    case "gun":
      var_4 = 12;
      break;
    case "br":
      var_4 = 13;
      break;
    case "prop":
      var_4 = 14;
      break;
    case "spy":
      var_4 = 15;
      break;
    case "relic":
      var_4 = 16;
      break;
    default:
      var_4 = 1;
      break;
  }

  var_5 = int(tablelookup(getweaponlevelingtablename(), 0, var_1, var_4));

  if(!isDefined(self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_3])) {
    self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_3]["xp"] = 0;
    self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_3]["weaponName"] = var_3;
  }

  self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_3]["xp"] = self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_3]["xp"] + var_5;

  if(var_5 > 0)
    thread _id_47C3(var_0, var_5);
}

_id_47C3(var_0, var_1) {
  var_2 = maps\mp\_utility::_id_4431(var_0);

  if(maps\mp\_utility::_id_5856(var_2))
    var_2 = maps\mp\gametypes\_class::_id_4432(var_2);

  var_3 = _func_1B1(getweaponlevelingtablename(), 0, var_2);
  var_4 = int(_func_1AE(getweaponlevelingtablename(), var_3, 1));
  var_5 = int(_func_1AE(getweaponlevelingtablename(), var_3 + var_4, 1));
  var_6 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_2, "level");
  var_6 = var_6 + 1;
  var_7 = var_6;
  var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_2, "experience");
  var_9 = var_8 + var_1;
  var_9 = int(_func_0AF(var_5, var_9));
  var_1 = var_9 - var_8;

  if(!isDefined(self.pers["weaponsUsed"])) {
    self.pers["weaponsUsed"] = [];
    self.pers["weaponXpEarned"] = [];
  }

  var_10 = 0;
  var_11 = 999;

  for(var_12 = 0; var_12 < self.pers["weaponsUsed"].size; var_12++) {
    if(self.pers["weaponsUsed"][var_12] == var_2) {
      var_10 = 1;
      var_11 = var_12;
    }
  }

  if(var_10)
    self.pers["weaponXpEarned"][var_11] = self.pers["weaponXpEarned"][var_11] + var_1;
  else {
    self.pers["weaponsUsed"][self.pers["weaponsUsed"].size] = var_2;
    self.pers["weaponXpEarned"][self.pers["weaponXpEarned"].size] = var_1;
  }

  var_13 = 1;

  while(var_13) {
    var_13 = 0;

    if(var_6 <= var_4) {
      var_14 = var_3 + var_6;
      var_15 = int(_func_1AE(getweaponlevelingtablename(), var_14, 1));

      if(var_9 >= var_15) {
        var_16 = int(_func_1AE(getweaponlevelingtablename(), var_14, 3));
        thread maps\mp\gametypes\_rank::giverankxp("weaponLevel", var_16);
        var_6 = var_6 + 1;
        self setplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_2, "level", var_6 - 1);
        _id_0485::_id_5EAF(var_2, "level", 1, var_0);
        var_17 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_2, "timeInUse");

        if(!isDefined(var_17))
          var_17 = -1;

        _func_0F5("script_mp_rankup_weapon: playerName %s, weaponName %s, oldLevel %d, newLevel %d, xpGain %d, timeInUse %d", self.name, var_2, var_7, var_6, var_1, var_17);
        thread _id_A9DE(var_2, var_6);

        if(var_6 > var_4)
          var_9 = var_15 + 1;
        else
          var_13 = 1;
      }

      self setplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_2, "experience", var_9);
      _id_0485::_id_5EAF(var_2, "experience", var_1, var_0);
    }
  }
}

_id_A9DE(var_0, var_1) {
  var_2 = _func_1B1("mp/statstable.csv", 2, var_0);
  thread maps\mp\gametypes\_hud_message::_id_A9DD("ranked_up_weapon_" + var_0, "", var_1);
}