/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gamelogic.gsc
*********************************************/

func_6B3C(param_00) {
  if(isDefined(level.var_3E39)) {
    return;
  }

  level endon("abort_forfeit");
  level thread func_3E3A();
  level.var_3E39 = 1;
  if(!level.teambased && level.players.size > 1) {
    wait(10);
  } else {
    wait(1.05);
  }

  level.var_3E38 = 0;
  var_01 = 20;
  func_6029(var_01);
  setnojiptime(1);
  var_02 = &"";
  if(!isDefined(param_00)) {
    level.var_3B5C = "none";
    var_02 = game["end_reason"]["players_forfeited"];
    var_03 = level.players[0];
  } else if(var_01 == "axis") {
    level.var_3B5C = "axis";
    if(maps\mp\_utility::func_579B() && game["switchedsides"]) {
      var_03 = game["end_reason"]["axis_forfeited"];
    } else {
      var_03 = game["end_reason"]["allies_forfeited"];
    }

    if(level.gametype == "infect") {
      var_03 = game["end_reason"]["survivors_forfeited"];
    }

    var_03 = "axis";
  } else if(var_01 == "allies") {
    level.var_3B5C = "allies";
    if(maps\mp\_utility::func_579B() && game["switchedsides"]) {
      var_03 = game["end_reason"]["allies_forfeited"];
    } else {
      var_03 = game["end_reason"]["axis_forfeited"];
    }

    if(level.gametype == "infect") {
      var_03 = game["end_reason"]["infected_forfeited"];
    }

    var_03 = "allies";
  } else if(level.multiteambased && issubstr(var_01, "team_")) {
    var_03 = var_01;
  } else {
    level.var_3B5C = "none";
    var_03 = "tie";
  }

  level.forcedend = 1;
  if(isPlayer(var_03)) {
    logstring("forfeit, win: " + var_03 getxuid() + "(" + var_03.name + ")");
  } else {
    logstring("forfeit, win: " + var_03 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  }

  thread endgame(var_03, var_02);
}

func_3E3A() {
  level endon("game_ended");
  level waittill("abort_forfeit");
  level.var_3E38 = 1;
  setomnvar("ui_match_countdown", 0);
  setomnvar("ui_match_countdown_title", 0);
  setomnvar("ui_match_countdown_toggle", 0);
}

func_602A(param_00) {
  waittillframeend;
  level endon("match_forfeit_timer_beginning");
  setomnvar("ui_match_countdown_title", 3);
  setomnvar("ui_match_countdown_toggle", 1);
  while(param_00 > 0 && !level.gameended && !level.var_3E38 && !level.var_5139) {
    setomnvar("ui_match_countdown", param_00);
    wait(1);
    param_00--;
  }
}

func_6029(param_00) {
  level notify("match_forfeit_timer_beginning");
  var_01 = int(param_00);
  func_602A(var_01);
  setomnvar("ui_match_countdown", 0);
  setomnvar("ui_match_countdown_title", 0);
  setomnvar("ui_match_countdown_toggle", 0);
}

func_2BAD(param_00) {
  level.var_3B5C = "none";
  if(param_00 == "allies") {
    logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level.var_3B5C = "axis";
    thread endgame("axis", game["end_reason"]["allies_eliminated"]);
    return;
  }

  if(param_00 == "axis") {
    logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level.var_3B5C = "allies";
    thread endgame("allies", game["end_reason"]["axis_eliminated"]);
    return;
  }

  logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  level.var_3B5C = "none";
  if(level.teambased) {
    thread endgame("tie", game["end_reason"]["tie"]);
    return;
  }

  thread endgame(undefined, game["end_reason"]["tie"]);
}

func_2BAF(param_00) {
  if(level.teambased) {
    var_01 = maps\mp\_utility::func_454F(param_00);
    var_01 thread func_478F();
  } else {
    var_01 = maps\mp\_utility::func_454F();
    logstring("last one alive, win: " + var_01.name);
    level.var_3B5C = "none";
    thread endgame(var_01, game["end_reason"]["enemies_eliminated"]);
  }

  return 1;
}

func_2BB0() {
  var_00 = undefined;
  level.var_3B5C = "none";
  if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      if(function_037E()) {
        var_00 = "overtime";
      } else {
        var_00 = "tie";
      }
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.var_3B5C = "axis";
      var_00 = "axis";
    } else {
      level.var_3B5C = "allies";
      var_00 = "allies";
    }

    if(maps\mp\_utility::practiceroundgame()) {
      var_00 = "none";
    }

    logstring("time limit, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_00 = maps\mp\gametypes\_gamescore::func_450A();
    if(isDefined(var_00)) {
      logstring("time limit, win: " + var_00.name);
    } else {
      logstring("time limit, tie");
    }
  }

  thread endgame(var_00, game["end_reason"]["time_limit_reached"]);
}

func_2BAE(param_00) {
  var_01 = undefined;
  level.var_3B5C = "none";
  thread endgame("halftime", game["end_reason"][param_00]);
}

func_3E1A() {
  if(level.hostforcedend || level.forcedend) {
    return;
  }

  setnojiptime(1);
  var_00 = undefined;
  level.var_3B5C = "none";
  if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      var_00 = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.var_3B5C = "axis";
      var_00 = "axis";
    } else {
      level.var_3B5C = "allies";
      var_00 = "allies";
    }

    logstring("host ended game, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_00 = maps\mp\gametypes\_gamescore::func_450A();
    if(isDefined(var_00)) {
      logstring("host ended game, win: " + var_00.name);
    } else {
      logstring("host ended game, tie");
    }
  }

  level.forcedend = 1;
  level.hostforcedend = 1;
  if(level.splitscreen) {
    var_01 = game["end_reason"]["ended_game"];
  } else {
    var_01 = game["end_reason"]["host_ended_game"];
  }

  thread endgame(var_00, var_01);
}

func_6B9B() {
  var_00 = game["end_reason"]["score_limit_reached"];
  var_01 = undefined;
  level.var_3B5C = "none";
  if(level.multiteambased) {
    var_01 = maps\mp\gametypes\_gamescore::func_473F();
    if(var_01 == "none") {
      var_01 = "tie";
    }
  } else if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      var_01 = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_01 = "axis";
      level.var_3B5C = "axis";
    } else {
      var_01 = "allies";
      level.var_3B5C = "allies";
    }

    logstring("scorelimit, win: " + var_01 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_01 = maps\mp\gametypes\_gamescore::func_450A();
    if(isDefined(var_01)) {
      logstring("scorelimit, win: " + var_01.name);
    } else {
      logstring("scorelimit, tie");
    }
  }

  thread endgame(var_01, var_00);
  return 1;
}

updategameevents() {
  if(maps\mp\_utility::func_602B() && !level.var_5139 && !getdvarint("850") && !getdvarint("5357") && !isDefined(level.var_2F85) || !level.var_2F85) {
    if(level.multiteambased) {
      var_00 = 0;
      var_01 = 0;
      for(var_02 = 0; var_02 < level.teamnamelist.size; var_02++) {
        var_00 = var_00 + level.teamcount[level.teamnamelist[var_02]];
        if(level.teamcount[level.teamnamelist[var_02]]) {
          var_01 = var_01 + 1;
        }
      }

      for(var_02 = 0; var_02 < level.teamnamelist.size; var_02++) {
        if(var_00 == level.teamcount[level.teamnamelist[var_02]] && game["state"] == "playing") {
          thread func_6B3C(level.teamnamelist[var_02]);
          return;
        }
      }

      if(var_01 > 1) {
        level.var_3E39 = undefined;
        level notify("abort_forfeit");
      }
    } else if(level.teambased) {
      if(level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing") {
        thread func_6B3C("axis");
        return;
      }

      if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing") {
        thread func_6B3C("allies");
        return;
      }

      if(level.teamcount["axis"] > 0 && level.teamcount["allies"] > 0) {
        level.var_3E39 = undefined;
        level notify("abort_forfeit");
      }
    } else {
      var_03 = level.teamcount["allies"] + level.teamcount["axis"];
      if(var_03 == 1 && game["state"] == "playing") {
        thread func_6B3C();
        return;
      }

      if(level.teamcount["axis"] + level.teamcount["allies"] > 1) {
        level.var_3E39 = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(!maps\mp\_utility::func_44FC() && !isDefined(level.var_2F9F) || !level.var_2F9F) {
    return;
  }

  if(!maps\mp\_utility::func_3FA6()) {
    return;
  }

  if(level.var_5139) {
    return;
  }

  if(level.multiteambased) {
    return;
  }

  if(level.teambased) {
    var_04["allies"] = level.var_5DDB["allies"];
    var_04["axis"] = level.var_5DDB["axis"];
    if(isDefined(level.var_2F9F) && level.var_2F9F) {
      var_04["allies"] = 0;
      var_04["axis"] = 0;
    }

    if(!level.var_BC3["allies"] && !level.var_BC3["axis"] && !var_04["allies"] && !var_04["axis"]) {
      return [[level.var_6AE2]]("all");
    }

    if(!level.var_BC3["allies"] && !var_04["allies"]) {
      return [[level.var_6AE2]]("allies");
    }

    if(!level.var_BC3["axis"] && !var_04["axis"]) {
      return [[level.var_6AE2]]("axis");
    }

    var_05 = level.var_BC3["allies"] == 1 && !var_04["allies"];
    var_06 = level.var_BC3["axis"] == 1 && !var_04["axis"];
    if((var_05 || var_06) && !isDefined(level.var_1AED)) {
      var_07 = undefined;
      if(var_05 && !isDefined(level.onelefttime["allies"])) {
        level.onelefttime["allies"] = gettime();
        var_08 = [[level.var_6B5E]]("allies");
        if(isDefined(var_08)) {
          if(!isDefined(var_07)) {
            var_07 = var_08;
          }

          var_07 = var_07 || var_08;
        }
      }

      if(var_06 && !isDefined(level.onelefttime["axis"])) {
        level.onelefttime["axis"] = gettime();
        var_09 = [[level.var_6B5E]]("axis");
        if(isDefined(var_09)) {
          if(!isDefined(var_07)) {
            var_07 = var_09;
          }

          var_07 = var_07 || var_09;
        }
      }

      return var_07;
    }

    return;
  }

  if(!level.var_BC3["allies"] && !level.var_BC3["axis"] && !level.var_5DDB["allies"] && !level.var_5DDB["axis"]) {
    return [[level.var_6AE2]]("all");
  }

  var_0A = maps\mp\_utility::func_4630();
  if(var_0A.size == 1) {
    return [[level.var_6B5E]]("all");
  }
}

func_A77D() {
  if(!isDefined(level.var_3B5C)) {
    return 0;
  }

  level waittill("final_killcam_done");
  return 1;
}

func_99F4(param_00) {
  setgameendtime(gettime() + int(param_00 * 1000));
  if(param_00 >= 10) {
    wait(param_00 - 10);
  }

  for(;;) {
    lib_0380::func_2888("ui_timer_countdown");
    wait(1);
  }
}

waitforplayers(param_00) {
  var_01 = gettime();
  var_02 = var_01 + param_00 * 1000 - 200;
  if(param_00 > 5) {
    var_03 = gettime() + getdvarint("min_wait_for_players") * 1000;
  } else {
    var_03 = 0;
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    var_04 = level.connectingplayers;
  } else if(function_03AF()) {
    var_04 = level.connectingplayers;
  } else {
    var_04 = level.connectingplayers / 3;
  }

  for(;;) {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
      break;
    }

    var_05 = level.maxplayercount;
    var_06 = gettime();
    if((var_05 >= var_04 && var_06 > var_03) || var_06 > var_02) {
      break;
    }

    wait 0.05;
  }
}

prematchperiod() {
  level endon("game_ended");
  level.connectingplayers = getdvarint("5458");
  level thread func_92C3();
  if(level.prematchperiod > 0) {
    level.var_A6EB = 1;
    func_603A();
    level.var_A6EB = 0;
  } else {
    func_6039();
  }

  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    level.players[var_00] maps\mp\_utility::func_3E8F(1);
    level.players[var_00] enableweapons();
    level.players[var_00] method_800E();
    var_02 = maps\mp\_utility::func_45CD(level.players[var_00].pers["team"]);
    if(!isDefined(var_02) || !level.players[var_00].hasspawned) {
      continue;
    }
  }

  if(game["state"] != "playing") {}
}

func_483A() {
  level endon("game_ended");
  if(!isDefined(game["clientActive"])) {
    while(function_0266() == 0) {
      wait 0.05;
    }

    game["clientActive"] = 1;
  }

  while(level.var_5139 > 0) {
    wait(1);
    level.var_5139--;
  }

  level notify("grace_period_ending");
  wait 0.05;
  maps\mp\_utility::func_3FA4("graceperiod_done");
  level.var_5139 = 0;
  if(game["state"] != "playing") {
    return;
  }

  level thread updategameevents();
}

func_869D(param_00, param_01) {
  param_00.var_4B62 = param_01;
  param_00 notify("hasDoneCombat");
  var_02 = !isDefined(param_00.var_4B61) || !param_00.var_4B61;
  if(var_02 && param_01 && !function_0367()) {
    param_00.var_4B61 = 1;
    if(isDefined(param_00.pers["hasMatchLoss"]) && param_00.pers["hasMatchLoss"]) {
      return;
    }

    func_A130(param_00);
  }
}

func_A199(param_00) {
  if(function_03AF()) {
    return;
  }

  if((isDefined(level.disablewinlossstats) && level.disablewinlossstats) || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(!param_00 maps\mp\_utility::rankingenabled()) {
    return;
  }

  if((!isDefined(param_00.var_4B61) || !param_00.var_4B61) && !level.gametype == "infect" && !maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  if(isDefined(param_00.pers["recordedLoss"]) && param_00.pers["recordedLoss"]) {
    param_00 maps\mp\gametypes\_persistence::func_9314("losses", -1);
  }

  var_01 = 1;
  if(maps\mp\_utility::func_579B() && isDefined(game["game_one_winner"]) && param_00.team == game["game_one_winner"]) {
    var_01 = 2;
  }

  param_00 maps\mp\gametypes\_persistence::func_9314("wins", 1);
  param_00 maps\mp\_utility::func_A14B("winLossRatio", "wins", "losses");
  param_00 maps\mp\gametypes\_persistence::func_9314("currentWinStreak", var_01);
  var_02 = param_00 maps\mp\gametypes\_persistence::func_932F("currentWinStreak");
  if(var_02 > param_00 maps\mp\gametypes\_persistence::func_932F("winStreak")) {
    param_00 maps\mp\gametypes\_persistence::statset("winStreak", var_02);
  }

  param_00 maps\mp\gametypes\_persistence::statsetchild("round", "win", 1);
  param_00 maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
  param_00 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_wins");
  param_00 maps\mp\gametypes\_missions::processchallenge("ch_victories_careerwins");
  param_00.var_2533 = 1;
  param_00.pers["combatRecordLoss"] = undefined;
  if(level.players.size > 5) {
    switch (level.gametype) {
      case "war":
        if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::func_45DE(param_00.team)] + 20) {
          param_00 maps\mp\gametypes\_missions::processchallenge("ch_war_crushing");
        }
        break;

      case "hp":
        if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::func_45DE(param_00.team)] + 70) {
          param_00 maps\mp\gametypes\_missions::processchallenge("ch_hp_crushing");
        }
        break;

      case "conf":
        if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::func_45DE(param_00.team)] + 15) {
          param_00 maps\mp\gametypes\_missions::processchallenge("ch_conf_crushing");
        }
        break;

      case "ball":
        if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::func_45DE(param_00.team)] + 7) {
          param_00 maps\mp\gametypes\_missions::processchallenge("ch_ball_crushing");
        }
        break;

      case "dm":
        if(isDefined(level.placement["all"][0])) {
          var_03 = level.placement["all"][0];
          var_04 = 9999;
          if(param_00 == var_03) {
            foreach(var_06 in level.players) {
              if(param_00 == var_06) {
                continue;
              }

              var_07 = param_00.score - var_06.score;
              if(var_07 < var_04) {
                var_04 = var_07;
              }
            }

            if(var_04 >= 7) {
              param_00 maps\mp\gametypes\_missions::processchallenge("ch_dm_crushing");
            }
          }
        }
        break;

      case "ctf":
        if(game["shut_out"][param_00.team]) {
          param_00 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_crushing");
        }
        break;
    }
  }

  param_00 thread rankedwinchallengeupdate();
}

rankedwinchallengeupdate() {
  if(function_03AF()) {
    var_00 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_wins_in_a_row");
    if(var_00 < 255) {
      var_00++;
    }

    self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_wins_in_a_row", var_00);
    if(self method_86B4(1) == 1) {
      var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_wins_in_a_row_solo");
      if(var_01 < 255) {
        var_01++;
      }

      self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_wins_in_a_row_solo", var_01);
    }
  }
}

rankedlosschallengeupdate() {
  if(function_03AF()) {
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_wins_in_a_row", 0);
    if(self method_86B4(1) == 1) {
      self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_wins_in_a_row_solo", 0);
    }
  }
}

func_94F0(param_00) {
  var_01 = 0;
  var_02 = 9999;
  foreach(var_04 in level.players) {
    if(var_04.kills > var_01) {
      var_01 = var_04.kills;
    } else if(maps\mp\_utility::func_579B() && isDefined(var_04.var_79A2) && var_04.var_79A2 > var_01) {
      var_01 = var_04.var_79A2;
    }

    if(var_04.deaths < var_02) {
      var_02 = var_04.deaths;
    }
  }

  if(isPlayer(param_00)) {
    var_06 = maps\mp\gametypes\_gamescore::func_450B(3);
  } else {
    var_06 = level.players;
  }

  foreach(var_04 in var_06) {
    if(isPlayer(param_00) || var_04.team == param_00) {
      var_08 = var_04.kills;
      if(maps\mp\_utility::func_579B() && isDefined(var_04.var_79A2)) {
        var_08 = var_04.var_79A2;
      }

      if(var_08 >= var_01 && var_04.deaths <= var_02 && var_08 > 0 && !isai(var_04)) {
        var_04 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_star");
        var_04 maps\mp\gametypes\_missions::processchallenge("ch_heroics_superstar");
      }
    }
  }
}

func_21C1() {
  if(level.gametype == "dom") {
    foreach(var_01 in level.var_3211) {
      if(!isDefined(var_01.var_6DA9) || !var_01.var_6DA9) {
        continue;
      }

      var_02 = var_01 maps\mp\gametypes\_gameobjects::func_45F7();
      foreach(var_04 in level.players) {
        if(var_04.team != var_02) {
          continue;
        }

        switch (var_01.label) {
          case "_a":
            var_04 maps\mp\gametypes\_missions::processchallenge("ch_dom_alphalock");
            break;

          case "_b":
            var_04 maps\mp\gametypes\_missions::processchallenge("ch_dom_bravolock");
            break;

          case "_c":
            var_04 maps\mp\gametypes\_missions::processchallenge("ch_dom_charlielock");
            break;
        }
      }
    }
  }
}

func_A130(param_00) {
  if(function_03AF()) {
    return;
  }

  if((isDefined(level.disablewinlossstats) && level.disablewinlossstats) || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(!param_00 maps\mp\_utility::rankingenabled()) {
    return;
  }

  if((!isDefined(param_00.var_4B61) || !param_00.var_4B61) && !maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  param_00.pers["hasMatchLoss"] = 1;
  if(!isDefined(param_00.var_5969) || !param_00.var_5969) {
    var_01 = 1;
    if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(game["switchedsides"])) {
      var_01 = 0;
    }

    if(var_01) {
      var_02 = 1;
      if(maps\mp\_utility::func_579B()) {
        var_02 = 2;
      }

      param_00 maps\mp\gametypes\_persistence::func_9314("losses", var_02);
      param_00 maps\mp\_utility::func_A14B("winLossRatio", "wins", "losses");
      param_00.pers["recordedLoss"] = 1;
      param_00.pers["combatRecordLoss"] = 1;
    }
  }

  param_00 maps\mp\gametypes\_persistence::func_9314("gamesPlayed", 1);
  param_00 maps\mp\gametypes\_persistence::statsetchild("round", "loss", 1);
}

func_A178(param_00) {
  if(function_03AF()) {
    return;
  }

  if((isDefined(level.disablewinlossstats) && level.disablewinlossstats) || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  if(!param_00 maps\mp\_utility::rankingenabled()) {
    return;
  }

  if((!isDefined(param_00.var_4B61) || !param_00.var_4B61) && !maps\mp\_utility::isprophuntgametype()) {
    return;
  }

  if(isDefined(param_00.pers["recordedLoss"]) && param_00.pers["recordedLoss"]) {
    param_00 maps\mp\gametypes\_persistence::func_9314("losses", -1);
    param_00 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
  }

  param_00 maps\mp\gametypes\_persistence::func_9314("ties", 1);
  param_00 maps\mp\_utility::func_A14B("winLossRatio", "wins", "losses");
  param_00.var_2532 = 1;
  param_00.pers["combatRecordLoss"] = undefined;
  param_00 thread rankedlosschallengeupdate();
}

func_86FD(param_00, param_01, param_02, param_03) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), "killsHistory", param_03, param_00);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), "deathsHistory", param_03, param_01);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), "lobbyPositionHistory", param_03, param_02);
}

func_50E3(param_00, param_01) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00);
  var_03 = var_02 + param_01;
  self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, var_03);
  return var_03;
}

func_255B(param_00, param_01) {
  return !isDefined(param_01) || isDefined(param_00) && param_00.score > param_01.score;
}

func_A152(param_00) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  var_01 = function_0363();
  var_02 = self.kills;
  var_03 = self.deaths;
  var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "lastSessionID");
  if(var_04 != var_01) {
    func_86FD(var_02, var_03, param_00, 0);
    func_86FD(-1, -1, -1, 1);
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "matchStreakInLobby", 1);
    if(var_03 == 0) {
      var_03 = 1;
    }

    self setrankedplayerdata(common_scripts\utility::func_46AE(), "kdRatioPerSession", int(var_02 * 1000 / var_03));
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "killsPerSession", var_02);
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "deathsPerSession", var_03);
  } else {
    var_05 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "killsHistory", 0);
    var_06 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "deathsHistory", 0);
    var_07 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "lobbyPositionHistory", 0);
    func_86FD(var_02, var_03, param_00, 0);
    func_86FD(var_05, var_06, var_07, 1);
    func_50E3("matchStreakInLobby", 1);
    var_08 = func_50E3("deathsPerSession", var_03);
    var_09 = func_50E3("killsPerSession", var_02);
    if(var_08 == 0) {
      var_08 = 1;
    }

    self setrankedplayerdata(common_scripts\utility::func_46AE(), "kdRatioPerSession", int(var_09 * 1000 / var_08));
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), "lastSessionID", var_01);
}

didplayerjipgametwo(param_00) {
  if(!common_scripts\utility::func_562E(param_00.pers["jip_game_one"]) && common_scripts\utility::func_562E(param_00.var_5969)) {
    return 1;
  }

  return 0;
}

updategameonewinners() {
  foreach(var_01 in level.players) {
    if(didplayerjipgametwo(var_01)) {
      continue;
    }

    if(var_01.team == game["game_one_winner"]) {
      var_01 maps\mp\gametypes\_persistence::func_9314("wins", 1);
      if(isDefined(var_01.pers["recordedLoss"]) && var_01.pers["recordedLoss"]) {
        var_01 maps\mp\gametypes\_persistence::func_9314("losses", -1);
      }

      continue;
    }

    if(!isDefined(var_01.var_5969) || !var_01.var_5969) {
      var_01 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
      var_01 thread rankedlosschallengeupdate();
    }
  }
}

func_A198(param_00) {
  if(maps\mp\_utility::func_773F()) {
    return;
  }

  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }

  var_01 = 1;
  if(maps\mp\_utility::func_579B() && !common_scripts\utility::func_562E(game["switchedsides"])) {
    var_01 = 0;
  }

  if(var_01) {
    if(!isDefined(param_00) || isDefined(param_00) && isstring(param_00) && param_00 == "tie") {
      foreach(var_03 in level.players) {
        if(isDefined(var_03.var_2583)) {
          continue;
        }

        if(level.hostforcedend && var_03 ishost()) {
          var_03 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
          var_03 thread rankedlosschallengeupdate();
          continue;
        }

        func_A178(var_03);
      }
    } else if(isPlayer(param_00)) {
      var_05[0] = param_00;
      if(level.players.size > 5) {
        var_05 = maps\mp\gametypes\_gamescore::func_450B(3);
      }

      var_06 = maps\mp\gametypes\_gamescore::gettiedplayerarray(2);
      if(var_06.size > 0) {
        var_05 = maps\mp\_utility::array_combine_no_dupes(var_05, var_06);
      }

      foreach(var_03 in var_05) {
        if(isDefined(var_03.var_2583)) {
          continue;
        }

        if(level.hostforcedend && var_03 ishost()) {
          var_03 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
          var_03 thread rankedlosschallengeupdate();
          continue;
        }

        func_A199(var_03);
      }
    } else if(isstring(param_00)) {
      if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(game["switchedsides"])) {
        updategameonewinners();
      }

      foreach(var_03 in level.players) {
        if(isDefined(var_03.var_2583)) {
          continue;
        }

        if(level.hostforcedend && var_03 ishost()) {
          var_03 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
          var_03 thread rankedlosschallengeupdate();
          continue;
        }

        if(param_00 == "tie") {
          func_A178(var_03);
          continue;
        }

        if(var_03.pers["team"] == param_00) {
          func_A199(var_03);
          continue;
        }

        if(isDefined(var_03.pers["recordedLoss"]) && var_03.pers["recordedLoss"]) {
          var_03 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
        }

        var_03 thread rankedlosschallengeupdate();
      }
    }
  }

  level.var_8F26 = common_scripts\utility::func_FA5(level.players, ::func_255B);
  var_0B = 1;
  foreach(var_03 in level.var_8F26) {
    if(isDefined(var_03.var_2583)) {
      continue;
    }

    var_03 func_A152(var_0B);
    var_0B++;
  }

  if(level.players.size > 5) {
    func_94F0(param_00);
    var_05 = maps\mp\gametypes\_gamescore::func_450B(3);
    for(var_0E = 0; var_0E < var_05.size; var_0E++) {
      if(var_0E == 0) {
        var_05[var_0E] maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_mvp");
        var_05[var_0E] maps\mp\gametypes\_missions::processchallenge("ch_heroics_topdog");
      }

      var_05[var_0E] maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_superior");
      var_05[var_0E] maps\mp\gametypes\_missions::processchallenge("ch_heroics_topscorer");
    }
  }
}

func_9412(param_00) {
  self endon("disconnect");
  maps\mp\_utility::func_2402();
  if(!isDefined(param_00)) {
    param_00 = 0.05;
  }

  self closepopupmenu();
  self closeingamemenu();
  wait(param_00);
  self method_84CB();
  self disableoffhandweapons();
  self allowmovement(0);
  self allowjump(0);
  self method_812C(0);
  self method_812B(0);
  self method_8309(0);
  self method_850D(0);
  self disableweaponswitch();
  self allowlook(0);
  self allowads(0);
  self method_812A(0);
  self method_85BF(0);
  self.var_260C = 1;
}

func_A133(param_00) {
  if(!game["timePassed"]) {
    return;
  }

  if(!maps\mp\_utility::func_602B()) {
    return;
  }

  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }

  if(level.teambased) {
    if(param_00 == "allies") {
      var_01 = "allies";
      var_02 = "axis";
    } else if(var_02 == "axis") {
      var_01 = "axis";
      var_02 = "allies";
    } else {
      var_01 = "tie";
      var_02 = "tie";
    }

    if(var_01 != "tie") {
      setwinningteam(var_01);
    }

    foreach(var_04 in level.players) {
      if(isDefined(var_04.var_2583)) {
        continue;
      }

      if(!var_04 maps\mp\_utility::rankingenabled()) {
        continue;
      }

      if(var_04.timeplayed["total"] < 1 || var_04.pers["participation"] < 1) {
        continue;
      }

      if(level.hostforcedend && var_04 ishost()) {
        continue;
      }

      if((!isDefined(var_04.var_4B61) || !var_04.var_4B61) && !maps\mp\_utility::isprophuntgametype()) {
        continue;
      }

      var_05 = 0;
      if(var_01 == "tie") {
        var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
        var_04.var_2EEB = 1;
        var_04.var_5858 = 0;
      } else if(isDefined(var_04.pers["team"]) && var_04.pers["team"] == var_01) {
        var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
        var_04.var_5858 = 1;
      } else if(isDefined(var_04.pers["team"]) && var_04.pers["team"] == var_02) {
        var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
        var_04.var_5858 = 0;
      }

      var_04.matchbonus = int(var_05);
    }
  } else {
    foreach(var_04 in level.players) {
      if(isDefined(var_04.var_2583)) {
        continue;
      }

      if(!var_04 maps\mp\_utility::rankingenabled()) {
        continue;
      }

      if(var_04.timeplayed["total"] < 1 || var_04.pers["participation"] < 1) {
        continue;
      }

      if(level.hostforcedend && var_04 ishost()) {
        continue;
      }

      if(!isDefined(var_04.var_4B61) || !var_04.var_4B61) {
        continue;
      }

      var_04.var_5858 = 0;
      for(var_08 = 0; var_08 < min(level.placement["all"].size, 3); var_08++) {
        if(level.placement["all"][var_08] != var_04) {
          continue;
        }

        var_04.var_5858 = 1;
      }

      var_05 = 0;
      if(var_04.var_5858) {
        var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
      } else {
        var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
      }

      var_04.matchbonus = int(var_05);
    }
  }

  foreach(var_04 in level.players) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(!isDefined(var_04.var_5858)) {
      continue;
    }

    var_0B = "loss";
    if(var_04.var_5858) {
      var_0B = "win";
    }

    if(isDefined(var_04.var_2EEB) && var_04.var_2EEB) {
      var_0B = "tie";
    }

    var_04 thread func_4795(var_0B, var_04.matchbonus);
    var_04 thread maps\mp\gametypes\_rank::givexpfromactiveboosts();
  }

  if(isDefined(level.var_2F98) && !level.var_2F98) {
    foreach(var_04 in level.players) {
      if(!var_04 maps\mp\_utility::rankingenabled()) {
        continue;
      }

      var_0E = var_04 getrankedplayerdata(common_scripts\utility::func_46AE(), "matchesCompleted");
      if(var_0E == 0) {
        var_04 maps\mp\gametypes\_rank::setsize();
      }

      var_04 setrankedplayerdata(common_scripts\utility::func_46AE(), "matchesCompleted", var_0E + 1);
    }
  }
}

func_4795(param_00, param_01) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  maps\mp\gametypes\_rank::giverankxp(param_00, param_01);
  maps\mp\_utility::func_5EB0();
}

func_8700(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_00.kills) || !isDefined(param_00.deaths)) {
    return;
  }

  if(function_03AF()) {
    return;
  }

  var_01 = param_00.timeplayed["total"] / 60;
  if(var_01 < 2) {
    return;
  }

  var_02 = param_00.kills;
  var_03 = param_00.deaths;
  var_04 = float(var_02 - var_03) * 1000;
  var_05 = int(var_04 / var_01);
  setplayerteamrank(param_00, param_00.var_2418, var_05);
}

func_8A6A(param_00) {
  var_01 = level.players;
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    func_8700(var_03);
  }
}

func_21EC(param_00) {
  if(isDefined(level.var_99F5) && level.var_99F5) {
    return;
  }

  if(game["state"] != "playing") {
    setgameendtime(0);
    return;
  }

  if(level.gametype == "hub") {
    return;
  }

  if(maps\mp\_utility::func_46E2() <= 0) {
    if(isDefined(level.var_9309)) {
      setgameendtime(level.var_9309);
    } else {
      setgameendtime(0);
    }

    return;
  }

  if(!maps\mp\_utility::func_3FA0("prematch_done")) {
    setgameendtime(0);
    return;
  }

  if(!isDefined(level.var_9309)) {
    return;
  }

  if(isDefined(level.var_21ED)) {
    [[level.var_21ED]]();
  } else if(maps\mp\_utility::func_46E4() > level.var_9A05) {
    setnojiptime(1);
  }

  var_01 = func_46E5();
  if(maps\mp\_utility::func_4502() && game["status"] != "halftime") {
    setgameendtime(gettime() + int(var_01) - int(maps\mp\_utility::func_46E2() * 60 * 1000 * 0.5));
  } else {
    setgameendtime(gettime() + int(var_01));
  }

  if(var_01 > 0) {
    if(maps\mp\_utility::func_4502() && func_21C2(param_00)) {
      [[level.var_6B42]]("time_limit_reached");
    }

    return;
  }

  [[level.var_6BB6]]();
}

func_21C3() {
  if(!level.var_4959) {
    return 0;
  }

  if(!level.teambased) {
    return 0;
  }

  if(game["status"] != "normal") {
    return 0;
  }

  var_00 = maps\mp\_utility::func_471A("scorelimit");
  if(var_00) {
    if(game["teamScores"]["allies"] >= var_00 || game["teamScores"]["axis"] >= var_00) {
      return 0;
    }

    var_01 = int(var_00 / 2 + 0.5);
    if(game["teamScores"]["allies"] >= var_01 || game["teamScores"]["axis"] >= var_01) {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
      game["round_time_to_beat"] = maps\mp\_utility::func_4589();
      return 1;
    }
  }

  return 0;
}

func_21C2(param_00) {
  if(!level.teambased) {
    return 0;
  }

  if(game["status"] != "normal") {
    return 0;
  }

  if(maps\mp\_utility::func_46E2()) {
    var_01 = maps\mp\_utility::func_46E2() * 60 * 1000 * 0.5;
    if(maps\mp\_utility::gettimepassed() >= var_01 && param_00 < var_01 && param_00 > 0) {
      if(isDefined(level.var_2D64) && level.var_2D64 == 1 && isDefined(level.var_18EE) && level.var_18EE == 1 && isDefined(level.var_3992)) {
        game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed() - level.var_3992 * 60 * 1000;
      } else if(level.gametype == "ctf" && isDefined(level.var_289F) && level.var_289F && isDefined(level.var_3992)) {
        game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed() - level.var_3992 * 60 * 1000;
      } else {
        game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
      }

      return 1;
    }
  }

  return 0;
}

func_46E5() {
  var_00 = maps\mp\_utility::gettimepassed();
  var_01 = maps\mp\_utility::func_46E2() * 60 * 1000;
  if(maps\mp\_utility::func_4502() && game["status"] == "halftime" && isDefined(level.var_3C68)) {
    var_02 = var_01 * 0.5;
    if(level.var_3C68 < var_02) {
      if(level.halftimestopwatch) {
        var_00 = var_01 - level.var_3C68 + var_00 - level.var_3C68;
      } else {
        var_00 = var_00 + var_02 - level.var_3C68;
      }
    }
  }

  return var_01 - var_00;
}

func_21EA(param_00) {
  if(maps\mp\_utility::func_471A("scorelimit") <= 0 || maps\mp\_utility::func_5760()) {
    return;
  }

  if(isDefined(level.var_80AB) && level.var_80AB) {
    return;
  }

  if(level.gametype == "conf" || level.gametype == "sd" || level.gametype == "hp" || level.gametype == "ctf" || level.gametype == "gun" || level.gametype == "infect" || level.gametype == "undead" || level.gametype == "relic") {
    return;
  }

  if(!level.teambased) {
    return;
  }

  if(maps\mp\_utility::gettimepassed() < -5536) {
    return;
  }

  var_01 = func_3878(param_00);
  if(var_01 < 0.7) {
    level notify("match_ending_soon", "score");
  }
}

func_21D2() {
  if(maps\mp\_utility::func_471A("scorelimit") <= 0 || maps\mp\_utility::func_5760()) {
    return;
  }

  if(level.teambased) {
    return;
  }

  if(maps\mp\_utility::gettimepassed() < -5536) {
    return;
  }

  var_00 = func_3878();
  if(var_00 < 0.7) {
    level notify("match_ending_soon", "score");
  }
}

func_21E3() {
  if(maps\mp\_utility::func_5760()) {
    return 0;
  }

  if(isDefined(level.var_80AB) && level.var_80AB) {
    return 0;
  }

  if(game["state"] != "playing") {
    return 0;
  }

  if(maps\mp\_utility::func_471A("scorelimit") <= 0) {
    return 0;
  }

  if(maps\mp\_utility::func_4502() && func_21C3()) {
    return [[level.var_6B42]]("score_limit_reached");
  } else if(level.multiteambased) {
    var_00 = 0;
    for(var_01 = 0; var_01 < level.teamnamelist.size; var_01++) {
      if(game["teamScores"][level.teamnamelist[var_01]] >= maps\mp\_utility::func_471A("scorelimit")) {
        var_00 = 1;
      }
    }

    if(!var_00) {
      return 0;
    }
  } else if(level.teambased) {
    if(game["teamScores"]["allies"] < maps\mp\_utility::func_471A("scorelimit") && game["teamScores"]["axis"] < maps\mp\_utility::func_471A("scorelimit")) {
      return 0;
    }
  } else {
    if(!isPlayer(self)) {
      return 0;
    }

    if(self.score < maps\mp\_utility::func_471A("scorelimit")) {
      return 0;
    }
  }

  if(issubstr(level.gametype, "dom")) {
    if(game["teamScores"]["allies"] > maps\mp\_utility::func_471A("scorelimit") && game["teamScores"]["axis"] < maps\mp\_utility::func_471A("scorelimit")) {
      game["teamScores"]["allies"] = maps\mp\_utility::func_471A("scorelimit");
    } else if(game["teamScores"]["axis"] > maps\mp\_utility::func_471A("scorelimit") && game["teamScores"]["allies"] > maps\mp\_utility::func_471A("scorelimit")) {
      game["teamScores"]["axis"] = maps\mp\_utility::func_471A("scorelimit");
    }
  }

  return func_6B9B();
}

func_A121() {
  level endon("game_ended");
  while(game["state"] == "playing") {
    if(isDefined(level.var_9309)) {
      if(func_46E5() < 3000) {
        wait(0.1);
        continue;
      }
    }

    wait(1);
  }
}

func_603A() {
  setomnvar("ui_match_countdown_title", 6);
  setomnvar("ui_match_countdown_toggle", 0);
  if(level.prematchperiodend > 0) {
    level.var_245A = undefined;
    maps\mp\_utility::func_3FA4("useCountdownClut");
  }

  waitforplayers(level.prematchperiod);
  if(isDefined(level.var_A6BC)) {
    [[level.var_A6BC]]();
  }

  maps\mp\_utility::func_3FA4("prematch_waitforplayers_done");
  if(level.prematchperiodend > 0 && !isDefined(level.var_4E09)) {
    func_6037(level.prematchperiodend);
  }
}

func_6038(param_00) {
  waittillframeend;
  level endon("match_start_timer_beginning");
  setomnvar("ui_match_countdown_title", 1);
  setomnvar("ui_match_countdown_toggle", 1);
  while(param_00 > 0 && !level.gameended) {
    setomnvar("ui_match_countdown", param_00);
    param_00--;
    wait(1);
  }

  if(function_03AF() && getdvarint("scr_rankedplay_void_time_enabled", 1) == 1 && function_03C0() < level.connectingplayers) {
    level.var_3B5C = "none";
    level.forcedend = 1;
    var_01 = game["end_reason"]["ranked_play_void_match"];
    var_02 = "tie";
    endgame(var_02, var_01);
    return;
  }

  if(!maps\mp\_utility::func_773F() && !maps\mp\_utility::practiceroundgame() && !isDefined(level.iszombiegame) && level.iszombiegame) {
    foreach(var_04 in level.players) {
      if(!isDefined(var_04.pers["hasSeenDoubleXPSplashes"]) || !var_04.pers["hasSeenDoubleXPSplashes"]) {
        if(level.var_7A6E > 2) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("quad_rank_xp");
        } else if(level.var_7A6E > 1) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("double_rank_xp");
        }

        if(level.var_305B > 2) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("quad_division_xp");
        } else if(level.var_305B > 1) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("double_division_xp");
        }

        if(level.var_A9FA > 2) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("quad_weapon_xp");
        } else if(level.var_A9FA > 1) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("double_weapon_xp");
        }

        if(level.var_5F0C > 2) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("quad_loot");
        } else if(level.var_5F0C > 1) {
          var_04 thread maps\mp\gametypes\_hud_message::func_9102("double_loot");
        }

        var_04.pers["hasSeenDoubleXPSplashes"] = 1;
      }
    }
  }

  setomnvar("ui_match_countdown_toggle", 0);
  setomnvar("ui_match_countdown", 0);
  setomnvar("ui_match_countdown_title", 2);
  level endon("match_forfeit_timer_beginning");
  wait(1.5);
  setomnvar("ui_match_countdown_title", 0);
}

func_6037(param_00) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  level.var_245A = undefined;
  maps\mp\_utility::func_3FA4("useCountdownClut");
  var_01 = int(param_00);
  if(var_01 >= 3) {
    thread func_6038(var_01);
    wait(var_01 - 3);
    maps\mp\_utility::func_3FA1("useCountdownClut");
    level.var_245A = gettime() + 3000;
    level notify("countdownClut_fadeup");
    wait(3);
  } else {
    if(!maps\mp\_utility::func_773F() && !maps\mp\_utility::practiceroundgame() && !isDefined(level.iszombiegame) && level.iszombiegame) {
      foreach(var_03 in level.players) {
        if(level.var_7A6E > 2) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("quad_rank_xp");
        } else if(level.var_7A6E > 1) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("double_rank_xp");
        }

        if(level.var_305B > 2) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("quad_division_xp");
        } else if(level.var_305B > 1) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("double_division_xp");
        }

        if(level.var_A9FA > 2) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("quad_weapon_xp");
        } else if(level.var_A9FA > 1) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("double_weapon_xp");
        }

        if(level.var_5F0C > 2) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("quad_loot");
          continue;
        }

        if(level.var_5F0C > 1) {
          var_03 thread maps\mp\gametypes\_hud_message::func_9102("double_loot");
        }
      }
    }

    maps\mp\_utility::func_3FA1("useCountdownClut");
    level.var_245A = gettime() + 1000;
    level notify("countdownClut_fadeup");
  }

  level thread onplayerconnect();
}

func_6039() {
  maps\mp\_utility::func_3FA4("prematch_waitforplayers_done");
  level thread onplayerconnect();
}

func_5FCA() {
  self endon("disconnect");
  level endon("game_ended");
  self setclutoverridedisableforplayer(0);
  var_00 = undefined;
  for(;;) {
    if(!maps\mp\_utility::func_3FA0("useCountdownClut")) {
      maps\mp\_utility::func_3FA5("useCountdownClut");
    }

    self setscriptmotionblurparams(3, 0, 0);
    self method_8483("mp_countdown", 0, 1);
    self setclutoverrideenableforplayer("clut_mp_blackout", 0);
    wait(0.7);
    self setclutoverrideenableforplayer("clut_mp_countdown", 2);
    while(!isDefined(level.var_245A)) {
      level waittill("countdownClut_fadeup");
    }

    var_01 = level.var_245A - gettime();
    if(var_01 < 0) {
      var_01 = 0;
    }

    self setclutoverridedisableforplayer(var_01 / 1000);
    self method_8483("", var_01 / 1000, 1);
    if(isDefined(level.var_6465)) {
      var_00 = level.var_6465;
    }

    if(isDefined(var_00)) {
      self setscriptmotionblurparams(var_00["velocityscaler"], var_00["cameraRotationInfluence"], var_00["cameraTranslationInfluence"]);
      continue;
    }

    self setscriptmotionblurparams(0, 0, 0);
  }
}

func_92C3() {
  level endon("game_ended");
  maps\mp\_utility::func_3FA3("useCountdownClut", 0);
  if(getdvarint("trailer_disable_intro_filter", 0) != 0) {
    return;
  }

  if(maps\mp\_utility::func_579B()) {
    return;
  }

  if(isDefined(level.players)) {
    foreach(var_01 in level.players) {
      var_01 thread func_5FCA();
    }
  }

  for(;;) {
    level waittill("connected", var_01);
    var_01 thread func_5FCA();
  }
}

onplayerconnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    if(isDefined(var_00) && isDefined(var_00.var_2418) && var_00 maps\mp\_utility::rankingenabled() && !function_0367()) {
      setmatchdata("players", var_00.var_2418, "playermatchtime_start_ms", gettime());
    }

    resetplayerdataonstartgameorconnect(var_00);
  }
}

func_6B99() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["roundsWon"]["allies"] == maps\mp\_utility::func_471A("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::func_471A("winlimit") - 1) {
    var_00 = func_4439();
    if(var_00 != game["defenders"]) {
      game["switchedsides"] = !game["switchedsides"];
    }

    level.var_495B = "overtime";
    game["dynamicEvent_Overtime"] = 1;
    return;
  }

  level.var_495B = "halftime";
  game["switchedsides"] = !game["switchedsides"];
}

func_21E1() {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(level.var_7F26) || !level.var_7F26) {
    return 0;
  }

  if(game["roundsPlayed"] % level.var_7F26 == 0) {
    func_6B99();
    return 1;
  }

  return 0;
}

func_9A1B() {
  if(level.gameended) {
    var_00 = gettime() - level.var_3F9F / 1000;
    var_01 = level.var_75EE - var_00;
    if(var_01 < 0) {
      return 0;
    }

    return var_01;
  }

  if(maps\mp\_utility::func_46E2() <= 0) {
    return undefined;
  }

  if(!isDefined(level.var_9309)) {
    return undefined;
  }

  var_02 = maps\mp\_utility::func_46E2();
  var_00 = gettime() - level.var_9309 / 1000;
  var_01 = maps\mp\_utility::func_46E2() * 60 - var_02;
  if(isDefined(level.var_2FB1)) {
    var_02 = var_02 + level.var_2FB1;
  }

  return var_02 + level.var_75EE;
}

func_3E89() {
  if(isDefined(self.var_6F5B)) {
    if(isDefined(self.var_6F5B[0])) {
      self.var_6F5B[0] maps\mp\gametypes\_hud_util::destroyelem();
      self.var_6F63[0] maps\mp\gametypes\_hud_util::destroyelem();
    }

    if(isDefined(self.var_6F5B[1])) {
      self.var_6F5B[1] maps\mp\gametypes\_hud_util::destroyelem();
      self.var_6F63[1] maps\mp\gametypes\_hud_util::destroyelem();
    }

    if(isDefined(self.var_6F5B[2])) {
      self.var_6F5B[2] maps\mp\gametypes\_hud_util::destroyelem();
      self.var_6F63[2] maps\mp\gametypes\_hud_util::destroyelem();
    }
  }

  self notify("perks_hidden");
  self.var_5F29 maps\mp\gametypes\_hud_util::destroyelem();
  self.var_5F30 maps\mp\gametypes\_hud_util::destroyelem();
  if(isDefined(self.var_7794)) {
    self.var_7794 maps\mp\gametypes\_hud_util::destroyelem();
  }

  if(isDefined(self.var_7795)) {
    self.var_7795 maps\mp\gametypes\_hud_util::destroyelem();
  }
}

func_4514() {
  var_00 = getEntArray("player", "classname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(var_00[var_01] ishost()) {
      return var_00[var_01];
    }
  }
}

func_4DFF() {
  var_00 = func_4514();
  if(isDefined(var_00) && !var_00.hasspawned && !isDefined(var_00.var_83A7)) {
    return 1;
  }

  return 0;
}

func_A792() {
  waittillframeend;
  var_00 = 0;
  while(!var_00) {
    var_01 = level.players;
    var_00 = 1;
    foreach(var_03 in var_01) {
      if(!isDefined(var_03.var_3202)) {
        continue;
      }

      if(!var_03 maps\mp\gametypes\_hud_message::func_56CE()) {
        continue;
      }

      var_00 = 0;
    }

    wait(0.5);
  }
}

func_7F19(param_00, param_01) {
  foreach(var_03 in level.players) {
    var_03 maps\mp\gametypes\_final_killcam::func_9456();
  }

  if(isDefined(level.var_36C1)) {
    [[level.var_36C1]]();
  }

  func_A792();
  if(!param_01) {
    wait(param_00);
    var_05 = level.players;
    foreach(var_03 in var_05) {
      var_03 setclientomnvar("ui_round_end", 0);
    }

    level notify("round_end_finished");
    return;
  }

  wait(var_03 / 2);
  level notify("give_match_bonus");
  wait(var_03 / 2);
  func_A792();
  var_05 = level.players;
  foreach(var_05 in var_07) {
    var_05 setclientomnvar("ui_round_end", 0);
  }

  level notify("round_end_finished");
}

func_7F17(param_00) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

func_5367() {
  if(level.gametype == "relic") {
    level.var_A992["waypoint_ball"] = "waypoint_relic_icon";
  } else {
    level.var_A992["waypoint_ball"] = "waypoint_ball_icon";
  }

  level.var_A990["waypoint_ball"] = "friendly";
  if(level.gametype == "relic") {
    level.var_A98F["waypoint_ball"] = "";
  } else {
    level.var_A98F["waypoint_ball"] = "waypoint_empty_icon";
  }

  if(level.gametype == "relic") {
    level.var_A992["waypoint_ball_friendly"] = "waypoint_small_relic_icon";
  } else {
    level.var_A992["waypoint_ball_friendly"] = "waypoint_small_ball_icon";
  }

  level.var_A990["waypoint_ball_friendly"] = "friendly";
  level.var_A98F["waypoint_ball_friendly"] = "waypoint_background_shield";
  level.var_A992["waypoint_ball_enemy"] = "waypoint_attack";
  level.var_A990["waypoint_ball_enemy"] = "enemy";
  level.var_A98F["waypoint_ball_enemy"] = "waypoint_background_diamond";
  level.var_A992["waypoint_ball_goal"] = "waypoint_small_triangle_down";
  level.var_A990["waypoint_ball_goal"] = "enemy";
  level.var_A98F["waypoint_ball_goal"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_ball_defend"] = "waypoint_small_triangle_up";
  level.var_A990["waypoint_ball_defend"] = "friendly";
  level.var_A98F["waypoint_ball_defend"] = "waypoint_background_triangle_up";
  if(level.gametype == "relic") {
    level.var_A992["waypoint_caster_neutral_ball"] = "waypoint_relic_icon";
  } else {
    level.var_A992["waypoint_caster_neutral_ball"] = "waypoint_ball_icon";
  }

  level.var_A990["waypoint_caster_neutral_ball"] = "neutral";
  level.var_A98F["waypoint_caster_neutral_ball"] = "waypoint_empty_icon";
  if(level.gametype == "relic") {
    level.var_A992["waypoint_caster_held_ball"] = "waypoint_small_relic_icon";
  } else {
    level.var_A992["waypoint_caster_held_ball"] = "waypoint_small_ball_icon";
  }

  level.var_A990["waypoint_caster_held_ball"] = "neutral";
  level.var_A98F["waypoint_caster_held_ball"] = "waypoint_background_diamond";
  level.var_A992["waypoint_caster_friendly_goal"] = "waypoint_small_triangle_up";
  level.var_A990["waypoint_caster_friendly_goal"] = "neutral";
  level.var_A98F["waypoint_caster_friendly_goal"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_caster_enemy_goal"] = "waypoint_small_triangle_down";
  level.var_A990["waypoint_caster_enemy_goal"] = "enemy";
  level.var_A98F["waypoint_caster_enemy_goal"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_allies_flag_friendly"] = "waypoint_faction_allies_icon";
  level.var_A990["waypoint_allies_flag_friendly"] = "friendly";
  level.var_A98F["waypoint_allies_flag_friendly"] = "waypoint_flag_icon";
  level.var_A992["waypoint_allies_flag_enemy"] = "waypoint_faction_allies_icon";
  level.var_A990["waypoint_allies_flag_enemy"] = "enemy";
  level.var_A98F["waypoint_allies_flag_enemy"] = "waypoint_flag_icon";
  level.var_A992["waypoint_axis_flag_friendly"] = "waypoint_faction_axis_icon";
  level.var_A990["waypoint_axis_flag_friendly"] = "friendly";
  level.var_A98F["waypoint_axis_flag_friendly"] = "waypoint_flag_icon";
  level.var_A992["waypoint_axis_flag_enemy"] = "waypoint_faction_axis_icon";
  level.var_A990["waypoint_axis_flag_enemy"] = "enemy";
  level.var_A98F["waypoint_axis_flag_enemy"] = "waypoint_flag_icon";
  level.var_A992["waypoint_return_flag"] = "waypoint_flag_return";
  level.var_A990["waypoint_return_flag"] = "friendly";
  level.var_A98F["waypoint_return_flag"] = "waypoint_flag_icon";
  level.var_A992["waypoint_escort_flag"] = "waypoint_flag_defend";
  level.var_A990["waypoint_escort_flag"] = "friendly";
  level.var_A98F["waypoint_escort_flag"] = "waypoint_background_shield";
  level.var_A992["waypoint_kill"] = "waypoint_attack";
  level.var_A990["waypoint_kill"] = "enemy";
  level.var_A98F["waypoint_kill"] = "waypoint_background_diamond";
  level.var_A992["waypoint_waitfor_flag"] = "waypoint_empty_icon";
  level.var_A990["waypoint_waitfor_flag"] = "friendly";
  level.var_A98F["waypoint_waitfor_flag"] = "waypoint_flag_missing_icon";
  level.var_A992["waypoint_caster_flag"] = "waypoint_empty_icon";
  level.var_A990["waypoint_caster_flag"] = "neutral";
  level.var_A98F["waypoint_caster_flag"] = "waypoint_flag_icon";
  level.var_A992["waypoint_caster_flag_missing"] = "waypoint_empty_icon";
  level.var_A990["waypoint_caster_flag_missing"] = "neutral";
  level.var_A98F["waypoint_caster_flag_missing"] = "waypoint_flag_missing_icon";
  level.var_A992["waypoint_caster_flag_taken"] = "waypoint_empty_icon";
  level.var_A990["waypoint_caster_flag_taken"] = "neutral";
  level.var_A98F["waypoint_caster_flag_taken"] = "waypoint_flag_icon";
  level.var_A992["waypoint_caster_flag_dropped"] = "waypoint_flag_return";
  level.var_A990["waypoint_caster_flag_dropped"] = "neutral";
  level.var_A98F["waypoint_caster_flag_dropped"] = "waypoint_flag_icon";
  level.var_A992["waypoint_bomb"] = "waypoint_empty_icon";
  level.var_A990["waypoint_bomb"] = "friendly";
  level.var_A98F["waypoint_bomb"] = "waypoint_bomb_icon";
  level.var_A992["waypoint_defuse"] = "waypoint_bomb_timer_icon";
  level.var_A990["waypoint_defuse"] = "enemy";
  level.var_A98F["waypoint_defuse"] = "waypoint_bomb_icon";
  level.var_A992["waypoint_defuse_a"] = "waypoint_a";
  level.var_A990["waypoint_defuse_a"] = "enemy";
  level.var_A98F["waypoint_defuse_a"] = "waypoint_bomb_icon";
  level.var_A992["waypoint_defuse_b"] = "waypoint_b";
  level.var_A990["waypoint_defuse_b"] = "enemy";
  level.var_A98F["waypoint_defuse_b"] = "waypoint_bomb_icon";
  level.var_A992["waypoint_escort"] = "waypoint_small_bomb_icon";
  level.var_A990["waypoint_escort"] = "friendly";
  level.var_A98F["waypoint_escort"] = "waypoint_background_shield";
  level.var_A992["waypoint_target_a"] = "waypoint_a";
  level.var_A990["waypoint_target_a"] = "enemy";
  level.var_A98F["waypoint_target_a"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_target_b"] = "waypoint_b";
  level.var_A990["waypoint_target_b"] = "enemy";
  level.var_A98F["waypoint_target_b"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_defend_a"] = "waypoint_a";
  level.var_A990["waypoint_defend_a"] = "friendly";
  level.var_A98F["waypoint_defend_a"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_defend_b"] = "waypoint_b";
  level.var_A990["waypoint_defend_b"] = "friendly";
  level.var_A98F["waypoint_defend_b"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_caster_bomb"] = "waypoint_empty_icon";
  level.var_A990["waypoint_caster_bomb"] = "enemy";
  level.var_A98F["waypoint_caster_bomb"] = "waypoint_bomb_icon";
  level.var_A992["waypoint_caster_defuse"] = "waypoint_bomb_timer_icon";
  level.var_A990["waypoint_caster_defuse"] = "enemy";
  level.var_A98F["waypoint_caster_defuse"] = "waypoint_bomb_icon";
  level.var_A992["waypoint_caster_target_a"] = "waypoint_a";
  level.var_A990["waypoint_caster_target_a"] = "enemy";
  level.var_A98F["waypoint_caster_target_a"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_caster_target_b"] = "waypoint_b";
  level.var_A990["waypoint_caster_target_b"] = "enemy";
  level.var_A98F["waypoint_caster_target_b"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_capture"] = "waypoint_small_triangle_down";
  level.var_A990["waypoint_capture"] = "enemy";
  level.var_A98F["waypoint_capture"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_defend"] = "waypoint_small_triangle_up";
  level.var_A990["waypoint_defend"] = "friendly";
  level.var_A98F["waypoint_defend"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_captureneutral"] = "waypoint_small_triangle_up";
  level.var_A990["waypoint_captureneutral"] = "neutral";
  level.var_A98F["waypoint_captureneutral"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_contested"] = "waypoint_small_triangle_down";
  level.var_A990["waypoint_contested"] = "contest";
  level.var_A98F["waypoint_contested"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_waitfor_flag_neutral"] = "waypoint_small_triangle_up";
  level.var_A990["waypoint_waitfor_flag_neutral"] = "neutral";
  level.var_A98F["waypoint_waitfor_flag_neutral"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_capture_a"] = "waypoint_a";
  level.var_A990["waypoint_capture_a"] = "enemy";
  level.var_A98F["waypoint_capture_a"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_capture_b"] = "waypoint_b";
  level.var_A990["waypoint_capture_b"] = "enemy";
  level.var_A98F["waypoint_capture_b"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_capture_c"] = "waypoint_c";
  level.var_A990["waypoint_capture_c"] = "enemy";
  level.var_A98F["waypoint_capture_c"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_defend_a"] = "waypoint_a";
  level.var_A990["waypoint_defend_a"] = "friendly";
  level.var_A98F["waypoint_defend_a"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_defend_b"] = "waypoint_b";
  level.var_A990["waypoint_defend_b"] = "friendly";
  level.var_A98F["waypoint_defend_b"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_defend_c"] = "waypoint_c";
  level.var_A990["waypoint_defend_c"] = "friendly";
  level.var_A98F["waypoint_defend_c"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_losing_a"] = "waypoint_a";
  level.var_A990["waypoint_losing_a"] = "friendly";
  level.var_A98F["waypoint_losing_a"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_losing_a"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_losing_a"] = "enemy";
  level.var_A992["waypoint_losing_b"] = "waypoint_b";
  level.var_A990["waypoint_losing_b"] = "friendly";
  level.var_A98F["waypoint_losing_b"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_losing_b"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_losing_b"] = "enemy";
  level.var_A992["waypoint_losing_c"] = "waypoint_c";
  level.var_A990["waypoint_losing_c"] = "friendly";
  level.var_A98F["waypoint_losing_c"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_losing_c"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_losing_c"] = "enemy";
  level.var_A992["waypoint_captureneutral_a"] = "waypoint_a";
  level.var_A990["waypoint_captureneutral_a"] = "neutral";
  level.var_A98F["waypoint_captureneutral_a"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_captureneutral_b"] = "waypoint_b";
  level.var_A990["waypoint_captureneutral_b"] = "neutral";
  level.var_A98F["waypoint_captureneutral_b"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_captureneutral_c"] = "waypoint_c";
  level.var_A990["waypoint_captureneutral_c"] = "neutral";
  level.var_A98F["waypoint_captureneutral_c"] = "waypoint_background_triangle_up";
  level.var_A992["waypoint_contested_a"] = "waypoint_a";
  level.var_A990["waypoint_contested_a"] = "contest";
  level.var_A98F["waypoint_contested_a"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_contested_b"] = "waypoint_b";
  level.var_A990["waypoint_contested_b"] = "contest";
  level.var_A98F["waypoint_contested_b"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_contested_c"] = "waypoint_c";
  level.var_A990["waypoint_contested_c"] = "contest";
  level.var_A98F["waypoint_contested_c"] = "waypoint_background_triangle_down";
  level.var_A992["waypoint_taking_a"] = "waypoint_a";
  level.var_A990["waypoint_taking_a"] = "enemy";
  level.var_A98F["waypoint_taking_a"] = "waypoint_background_triangle_down";
  level.var_A994["waypoint_taking_a"] = "waypoint_secondary_triangle_down";
  level.var_A993["waypoint_taking_a"] = "friendly";
  level.var_A992["waypoint_taking_b"] = "waypoint_b";
  level.var_A990["waypoint_taking_b"] = "enemy";
  level.var_A98F["waypoint_taking_b"] = "waypoint_background_triangle_down";
  level.var_A994["waypoint_taking_b"] = "waypoint_secondary_triangle_down";
  level.var_A993["waypoint_taking_b"] = "friendly";
  level.var_A992["waypoint_taking_c"] = "waypoint_c";
  level.var_A990["waypoint_taking_c"] = "enemy";
  level.var_A98F["waypoint_taking_c"] = "waypoint_background_triangle_down";
  level.var_A994["waypoint_taking_c"] = "waypoint_secondary_triangle_down";
  level.var_A993["waypoint_taking_c"] = "friendly";
  level.var_A992["waypoint_taking_neutral_a"] = "waypoint_a";
  level.var_A990["waypoint_taking_neutral_a"] = "neutral";
  level.var_A98F["waypoint_taking_neutral_a"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_taking_neutral_a"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_taking_neutral_a"] = "friendly";
  level.var_A992["waypoint_taking_neutral_b"] = "waypoint_b";
  level.var_A990["waypoint_taking_neutral_b"] = "neutral";
  level.var_A98F["waypoint_taking_neutral_b"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_taking_neutral_b"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_taking_neutral_b"] = "friendly";
  level.var_A992["waypoint_taking_neutral_c"] = "waypoint_c";
  level.var_A990["waypoint_taking_neutral_c"] = "neutral";
  level.var_A98F["waypoint_taking_neutral_c"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_taking_neutral_c"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_taking_neutral_c"] = "friendly";
  level.var_A992["waypoint_losing_neutral_a"] = "waypoint_a";
  level.var_A990["waypoint_losing_neutral_a"] = "neutral";
  level.var_A98F["waypoint_losing_neutral_a"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_losing_neutral_a"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_losing_neutral_a"] = "enemy";
  level.var_A992["waypoint_losing_neutral_b"] = "waypoint_b";
  level.var_A990["waypoint_losing_neutral_b"] = "neutral";
  level.var_A98F["waypoint_losing_neutral_b"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_losing_neutral_b"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_losing_neutral_b"] = "enemy";
  level.var_A992["waypoint_losing_neutral_c"] = "waypoint_c";
  level.var_A990["waypoint_losing_neutral_c"] = "neutral";
  level.var_A98F["waypoint_losing_neutral_c"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_losing_neutral_c"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_losing_neutral_c"] = "enemy";
  level.var_A992["waypoint_caster_friendly_taking_a"] = "waypoint_a";
  level.var_A990["waypoint_caster_friendly_taking_a"] = "neutral";
  level.var_A98F["waypoint_caster_friendly_taking_a"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_caster_friendly_taking_a"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_caster_friendly_taking_a"] = "friendly";
  level.var_A992["waypoint_caster_friendly_taking_b"] = "waypoint_b";
  level.var_A990["waypoint_caster_friendly_taking_b"] = "neutral";
  level.var_A98F["waypoint_caster_friendly_taking_b"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_caster_friendly_taking_b"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_caster_friendly_taking_b"] = "friendly";
  level.var_A992["waypoint_caster_friendly_taking_c"] = "waypoint_c";
  level.var_A990["waypoint_caster_friendly_taking_c"] = "neutral";
  level.var_A98F["waypoint_caster_friendly_taking_c"] = "waypoint_background_triangle_up";
  level.var_A994["waypoint_caster_friendly_taking_c"] = "waypoint_secondary_triangle_up";
  level.var_A993["waypoint_caster_friendly_taking_c"] = "friendly";
  level.var_A992["waypoint_caster_enemy_taking_a"] = "waypoint_a";
  level.var_A990["waypoint_caster_enemy_taking_a"] = "neutral";
  level.var_A98F["waypoint_caster_enemy_taking_a"] = "waypoint_background_triangle_down";
  level.var_A994["waypoint_caster_enemy_taking_a"] = "waypoint_secondary_triangle_down";
  level.var_A993["waypoint_caster_enemy_taking_a"] = "enemy";
  level.var_A992["waypoint_caster_enemy_taking_b"] = "waypoint_b";
  level.var_A990["waypoint_caster_enemy_taking_b"] = "neutral";
  level.var_A98F["waypoint_caster_enemy_taking_b"] = "waypoint_background_triangle_down";
  level.var_A994["waypoint_caster_enemy_taking_b"] = "waypoint_secondary_triangle_down";
  level.var_A993["waypoint_caster_enemy_taking_b"] = "enemy";
  level.var_A992["waypoint_caster_enemy_taking_c"] = "waypoint_c";
  level.var_A990["waypoint_caster_enemy_taking_c"] = "neutral";
  level.var_A98F["waypoint_caster_enemy_taking_c"] = "waypoint_background_triangle_down";
  level.var_A994["waypoint_caster_enemy_taking_c"] = "waypoint_secondary_triangle_down";
  level.var_A993["waypoint_caster_enemy_taking_c"] = "enemy";
}

func_1E70() {
  maps\mp\_load::main();
  maps\mp\_utility::func_5CBC("round_over", 0);
  maps\mp\_utility::func_5CBC("game_over", 0);
  maps\mp\_utility::func_5CBC("block_notifies", 0);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
  level.var_75E4 = 0;
  level.var_541D = 0;
  setDvar("4899", getDvar("scr_game_forceuav"));
  setDvar("4648", getDvar("scr_game_compassRadarUpdateTime"));
  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    var_00 = getmapcustom("allieschar");
    if(!isDefined(var_00) || var_00 == "") {
      if(!isDefined(game["allies"])) {
        var_00 = "allies";
      } else {
        var_00 = game["allies"];
      }
    }

    var_01 = getmapcustom("axischar");
    if(!isDefined(var_01) || var_01 == "") {
      if(!isDefined(game["axis"])) {
        var_01 = "axis";
      } else {
        var_01 = game["axis"];
      }
    }

    if(level.multiteambased) {
      var_02 = getmapcustom("allieschar");
      if(!isDefined(var_02) || var_02 == "") {
        var_02 = "delta_multicam";
      }

      for(var_03 = 0; var_03 < level.teamnamelist.size; var_03++) {
        game[level.teamnamelist[var_03]] = var_02;
      }
    }

    game["allies"] = var_00;
    game["axis"] = var_01;
    if(!isDefined(game["attackers"]) || !isDefined(game["defenders"])) {
      thread common_scripts\utility::func_3809("No attackers or defenders team defined in level .gsc.");
    }

    if(!isDefined(game["attackers"])) {
      game["attackers"] = "allies";
    }

    if(!isDefined(game["defenders"])) {
      game["defenders"] = "axis";
    }

    if(!isDefined(game["state"])) {
      game["state"] = "playing";
    }

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
    game["strings"]["allies_name"] = maps\mp\gametypes\_teams::func_46D5("allies");
    game["icons"]["allies"] = maps\mp\gametypes\_teams::func_46D3("allies");
    game["colors"]["allies"] = maps\mp\gametypes\_teams::func_46C5("allies");
    game["strings"]["axis_name"] = maps\mp\gametypes\_teams::func_46D5("axis");
    game["icons"]["axis"] = maps\mp\gametypes\_teams::func_46D3("axis");
    game["colors"]["axis"] = maps\mp\gametypes\_teams::func_46C5("axis");
    game["dvar_color_names"]["friendly"] = (0.251, 0.58, 0.537);
    game["dvar_color_names"]["enemy"] = (0.698, 0.224, 0.114);
    game["dvar_color_names"]["contest"] = (0.659, 0.463, 0.255);
    game["dvar_color_names"]["neutral"] = (0.604, 0.584, 0.5098);
    game["dvar_color_names"]["plaintext"] = (0.906, 0.878, 0.769);
    func_5367();
    if(game["colors"]["allies"] == (0, 0, 0)) {
      game["colors"]["allies"] = (0.5, 0.5, 0.5);
    }

    if(game["colors"]["axis"] == (0, 0, 0)) {
      game["colors"]["axis"] = (0.5, 0.5, 0.5);
    }

    [[level.var_6B86]]();
    setdvarifuninitialized("min_wait_for_players", 5);
    if(level.console) {
      if(!level.splitscreen) {
        if(isdedicatedserver()) {
          if(maps\mp\_utility::func_579B()) {
            level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod_raid_ds");
          } else if(function_03AF()) {
            level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod_ranked_ds");
          } else {
            level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod_ds");
          }
        } else {
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod");
        }

        level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "matchstarttime");
      }
    } else {
      if(isdedicatedserver()) {
        if(maps\mp\_utility::func_579B()) {
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime_raid_ds");
        } else if(function_03AF()) {
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime_ranked_ds");
        } else {
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime_ds");
        }
      } else {
        level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime");
      }

      level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "matchstarttime");
    }

    if(function_0154() == "hub") {
      level.prematchperiod = 1;
      level.prematchperiodend = 1;
    }
  } else {
    setdvarifuninitialized("min_wait_for_players", 5);
    if(level.console) {
      if(!level.splitscreen) {
        level.prematchperiod = 5;
        level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "roundstarttime");
        if(maps\mp\_utility::func_579B()) {
          if(isdedicatedserver()) {
            level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod_raid_ds");
          } else {
            level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod");
          }

          level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "matchstarttime");
        }
      }
    } else {
      level.prematchperiod = 5;
      level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "roundstarttime");
      if(maps\mp\_utility::func_579B()) {
        if(isdedicatedserver()) {
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime_raid_ds");
        } else {
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime");
        }

        level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "matchstarttime");
      }
    }
  }

  if(!isDefined(game["status"])) {
    game["status"] = "normal";
  }

  if(game["status"] != "overtime" && game["status"] != "halftime" && game["status"] != "overtime_halftime") {
    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;
    if(level.multiteambased) {
      for(var_03 = 0; var_03 < level.teamnamelist.size; var_03++) {
        game["teamScores"][level.teamnamelist[var_03]] = 0;
      }
    }
  }

  if(!isDefined(game["timePassed"])) {
    game["timePassed"] = 0;
  }

  if(!isDefined(game["roundsPlayed"])) {
    game["roundsPlayed"] = 0;
  }

  setomnvar("ui_current_round", game["roundsPlayed"] + 1);
  setomnvar("ui_last_round", maps\mp\_utility::func_5743());
  if(!isDefined(game["roundsWon"])) {
    game["roundsWon"] = [];
  }

  if(level.teambased) {
    if(!isDefined(game["roundsWon"]["axis"])) {
      game["roundsWon"]["axis"] = 0;
    }

    if(!isDefined(game["roundsWon"]["allies"])) {
      game["roundsWon"]["allies"] = 0;
    }

    if(level.multiteambased) {
      for(var_03 = 0; var_03 < level.teamnamelist.size; var_03++) {
        if(!isDefined(game["roundsWon"][level.teamnamelist[var_03]])) {
          game["roundsWon"][level.teamnamelist[var_03]] = 0;
        }
      }
    }
  }

  level.gameended = 0;
  level.forcedend = 0;
  level.hostforcedend = 0;
  level.hardcoremode = getdvarint("2043");
  if(level.hardcoremode) {
    logstring("game mode: hardcore");
  }

  level.diehardmode = getdvarint("scr_diehard");
  if(!level.teambased) {
    level.diehardmode = 0;
  }

  if(level.diehardmode) {
    logstring("game mode: diehard");
  }

  level.killstreakrewards = getdvarint("scr_game_hardpoints");
  if(!isDefined(level.iszombiegame)) {
    level.iszombiegame = 0;
  }

  if(maps\mp\_utility::func_56B1() || function_03AF() || isDefined(level.mgnestsdisabled) && level.mgnestsdisabled) {
    maps\mp\_utility::removemgnestsfromlevel();
  }

  level.usestartspawns = 1;
  level.objectivepointsmod = 1;
  level.baseplayermovescale = 1;
  level.maxallowedteamkills = 2;
  thread maps\mp\_teleport::main();
  thread maps\mp\gametypes\_persistence::init();
  thread maps\mp\gametypes\_menus::init();
  thread maps\mp\gametypes\_hud::init();
  thread maps\mp\gametypes\_serversettings::init();
  thread maps\mp\gametypes\_teams::init();
  thread maps\mp\gametypes\_weapons::init();
  thread maps\mp\gametypes\_killcam::init();
  thread maps\mp\gametypes\_shellshock::init();
  thread maps\mp\gametypes\_deathicons::init();
  thread maps\mp\gametypes\_damagefeedback::init();
  thread maps\mp\gametypes\_healthoverlay::init();
  thread maps\mp\gametypes\_spectating::init();
  thread maps\mp\gametypes\_objpoints::init();
  thread maps\mp\gametypes\_gameobjects::init();
  thread lib_050D::init();
  thread maps\mp\gametypes\_battlechatter_mp::init();
  thread maps\mp\gametypes\_ranked_play::init();
  thread maps\mp\_minimap_location_callout::init();
  thread maps\mp\gametypes\_music_and_dialog::init();
  thread maps\mp\_matchdata::init();
  thread maps\mp\gametypes\_spawnscoring::init();
  thread maps / mp / _leprechauns::init();
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    if(isDefined(level.var_788)) {
      thread[[level.var_788]]();
    }
  } else {
    thread maps\mp\_breadcrumbdata::init();
  }

  thread maps\mp\_awards::init();
  thread maps\mp\_skill::init();
  thread maps\mp\_battlecry::init();
  if(!maps\mp\_utility::func_551F() && getDvar("1924") != "hub") {
    thread maps\mp\killstreaks\_killstreaks_init::init();
    thread lib_0533::init();
  }

  thread maps\mp\perks\_perks::init();
  thread maps\mp\_events::init();
  thread maps\mp\gametypes\_final_killcam::func_52B8();
  if(!isDefined(level.var_1152)) {
    thread maps\mp\_utility::func_1D3E();
  }

  if(level.teambased) {
    thread maps\mp\gametypes\_friendicons::init();
  }

  thread maps\mp\gametypes\_hud_message::init();
  thread maps\mp\gametypes\_divisions::init();
  foreach(var_05 in game["strings"]) {
    precachestring(var_05);
  }

  foreach(var_08 in game["icons"]) {
    precacheshader(var_08);
  }

  game["gamestarted"] = 1;
  level.maxplayercount = 0;
  level.var_A982["allies"] = 0;
  level.var_A982["axis"] = 0;
  level.var_5C0F["allies"] = 0;
  level.var_5C0F["axis"] = 0;
  level.var_A987["allies"] = 0;
  level.var_A987["axis"] = 0;
  level.var_BC4["allies"] = [];
  level.var_BC4["axis"] = [];
  level.var_8DC = [];
  if(level.multiteambased) {
    for(var_03 = 0; var_03 < level.teamnamelist.size; var_03++) {
      level.var_77C[level.teamnamelist[var_03]] = 0;
      level.var_66E[level.teamnamelist[var_03]] = 0;
      level.var_77D[level.teamnamelist[var_03]] = 0;
      level.var_598[level.teamnamelist[var_03]] = [];
    }
  }

  setDvar("ui_scorelimit", 0);
  setDvar("ui_allow_teamchange", 1);
  if(maps\mp\_utility::func_44FC() && !maps\mp\_utility::func_585F()) {
    setDvar("2335", 0);
  } else {
    setDvar("2335", 1);
  }

  var_0A = getdvarfloat("scr_" + level.gametype + "_waverespawndelay");
  var_0B = isDefined(level.var_7DB3) && level.var_7DB3 == 2;
  if(var_0A > 0 || var_0B) {
    if(var_0B) {
      if(!common_scripts\utility::func_562E(game["switchedsides"])) {
        level.var_A982[game["attackers"]] = level.attackersrespawndelay;
        level.var_A982[game["defenders"]] = level.defendersrespawndelay;
      } else {
        level.var_A982[game["attackers"]] = level.defendersrespawndelay;
        level.var_A982[game["defenders"]] = level.attackersrespawndelay;
      }
    } else {
      level.var_A982["allies"] = var_0A;
      level.var_A982["axis"] = var_0A;
    }

    level.var_5C0F["allies"] = 0;
    level.var_5C0F["axis"] = 0;
    if(level.multiteambased) {
      for(var_03 = 0; var_03 < level.teamnamelist.size; var_03++) {
        level.var_77C[level.teamnamelist[var_03]] = var_0A;
        level.var_66E[level.teamnamelist[var_03]] = 0;
      }
    }

    level thread func_A98B();
  }

  maps\mp\_utility::func_3FA3("prematch_done", 0);
  maps\mp\_utility::func_3FA3("prematch_waitforplayers_done", 0);
  maps\mp\_utility::func_3FA3("team_collision_on", 0);
  if(!isDefined(level.var_483A)) {
    level.var_483A = 15;
  }

  if(function_0154() == "hub" || level.gametype == "onevone") {
    level.var_483A = 1;
  }

  level.var_5139 = level.var_483A;
  maps\mp\_utility::func_3FA3("graceperiod_done", 0);
  level.var_7F16 = 4;
  level.var_495A = 4;
  level.var_6738 = getEntArray("noragdoll", "targetname");
  if(level.teambased) {
    maps\mp\gametypes\_gamescore::func_A174("axis");
    maps\mp\gametypes\_gamescore::func_A174("allies");
    if(level.multiteambased) {
      for(var_03 = 0; var_03 < level.teamnamelist.size; var_03++) {
        maps\mp\gametypes\_gamescore::func_A174(level.teamnamelist[var_03]);
      }
    }
  } else {
    thread maps\mp\gametypes\_gamescore::func_52DA();
  }

  if(!function_0367()) {
    thread func_A18B();
    level notify("update_scorelimit");
  }

  [[level.var_6BAF]]();
  level.var_80AC = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off", 80);
  level.var_9A05 = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off", 80);
  level.var_7F20 = getdvarint("scr_" + level.gametype + "_round_num_cut_off", 4);
  if(common_scripts\utility::func_562E(level.iszombiesshotgun)) {
    level.var_7F20 = 1;
  }

  var_0C = getdvarint("ds_bot_test");
  if(var_0C == 0) {}

  if(!level.console && getDvar("dedicated") == "dedicated LAN server" || getDvar("dedicated") == "dedicated internet server") {
    thread func_A415();
  }

  func_8633();
  if(!function_0367()) {
    thread func_92DA();
    level thread maps\mp\_utility::func_A194();
    level thread func_99F6();
    if(!isDefined(level.var_53C7) || !level.var_53C7) {
      level thread maps\mp\gametypes\_final_killcam::func_318C();
      return;
    }

    return;
  }

  print("MatchStarted: Completed");
  setDvar("ui_inprematch", 1);
  maps\mp\_utility::func_3FA4("prematch_done");
  level notify("prematch_over");
  setDvar("ui_inprematch", 0);
}

func_8633() {
  if(game["attackers"] == "axis") {
    var_00 = 1;
  } else if(game["attackers"] == "allies") {
    var_00 = 2;
  } else {
    var_00 = 0;
  }

  setomnvar("ui_attacking_team", var_00);
}

func_1E62() {
  function_016F();
  if(!level.gameended) {
    level thread func_3E1A();
  }
}

func_A415() {
  for(;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!function_0371()) {
      exitlevel(0);
    }

    if(getDvar("dedicated") != "dedicated LAN server" && getDvar("dedicated") != "dedicated internet server") {
      exitlevel(0);
    }

    wait(5);
  }
}

func_99F6() {
  level endon("game_ended");
  var_00 = maps\mp\_utility::gettimepassed();
  while(game["state"] == "playing") {
    thread func_21EC(var_00);
    var_00 = maps\mp\_utility::gettimepassed();
    if(isDefined(level.var_9309)) {
      if(func_46E5() < 3000) {
        wait(0.1);
        continue;
      }
    }

    wait(1);
  }
}

func_A18B() {
  for(;;) {
    level common_scripts\utility::func_A732("update_scorelimit", "update_winlimit");
    if(!maps\mp\_utility::func_57B2() || !maps\mp\_utility::func_5760()) {
      setDvar("ui_scorelimit", maps\mp\_utility::func_471A("scorelimit"));
      thread func_21E3();
      continue;
    }

    setDvar("ui_scorelimit", maps\mp\_utility::func_471A("winlimit"));
  }
}

func_74E5() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  var_00 = level.var_1909;
  for(;;) {
    self playSound("mp_s2_obj_timer_tick_1s");
    if(var_00 > 10) {
      var_00 = var_00 - 1;
      wait(1);
    } else if(var_00 > 4) {
      var_00 = var_00 - 0.5;
      wait(0.5);
    } else {
      var_00 = var_00 - 0.25;
      wait(0.25);
    }

    maps\mp\gametypes\_hostmigration::func_A782();
  }
}

func_9415() {
  self notify("stop_ticking");
}

func_99F3() {
  level endon("game_ended");
  wait 0.05;
  while(game["state"] == "playing") {
    if(!level.var_9A12 && maps\mp\_utility::func_46E2()) {
      var_00 = func_46E5() / 1000;
      var_01 = int(var_00 + 0.5);
      var_02 = int(maps\mp\_utility::func_46E2() * 60 * 0.5);
      if(maps\mp\_utility::func_4502() && var_01 > var_02) {
        var_01 = var_01 - var_02;
      }

      if(var_01 >= 30 && var_01 <= 60 && level.gametype != "sd" && level.gametype != "hp" && level.gametype != "undead" && level.gametype != "relic") {
        level notify("match_ending_soon", "time");
      }

      if(var_01 <= 10 || var_01 <= 30 && var_01 % 2 == 0) {
        level notify("match_ending_very_soon");
        if(var_01 == 0) {
          break;
        }
      }

      if(var_00 - floor(var_00) >= 0.05) {
        wait(var_00 - floor(var_00));
      }
    }

    wait(1);
  }
}

func_3FD8() {
  level endon("game_ended");
  level waittill("prematch_over");
  level.var_9309 = gettime();
  level.var_2FB1 = 0;
  level.var_6027 = gettime();
  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.var_9309 = level.var_9309 - game["roundMillisecondsAlreadyPassed"];
    level.var_3C68 = game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  var_00 = gettime();
  while(game["state"] == "playing") {
    if(!level.var_9A12) {
      game["timePassed"] = game["timePassed"] + gettime() - var_00;
    }

    var_00 = gettime();
    wait(1);
  }
}

func_A17B() {
  var_00 = level.var_9A13 || isDefined(level.var_4E09);
  if(!maps\mp\_utility::func_3FA0("prematch_done")) {
    var_00 = 0;
  }

  if(!level.var_9A12 && var_00) {
    level.var_9A12 = 1;
    level.var_9A11 = gettime();
    return;
  }

  if(level.var_9A12 && !var_00) {
    level.var_9A12 = 0;
    level.var_2FB1 = level.var_2FB1 + gettime() - level.var_9A11;
  }
}

func_6F27() {
  level.var_9A13 = 1;
  func_A17B();
}

func_7DFC() {
  level.var_9A13 = 0;
  func_A17B();
}

resetplayerdataonstartgameorconnect(param_00) {
  if(!function_0367()) {
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "challengeNumCompleted", 0);
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", 0, "none");
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", 1, "none");
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", 2, "none");
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", 0, 0);
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", 1, 0);
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", 2, 0);
    for(var_01 = 0; var_01 <= 10; var_01++) {
      if(var_01 != 5) {
        var_02 = param_00 maps\mp\gametypes\_divisions::func_44A0(var_01);
        param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "divisionMatchExperience", var_02, 0);
      }
    }

    param_00 luinotifyevent(&"ui_player_set_match_start_time", 1, gettime());
  }
}

func_92DA() {
  thread func_3FD8();
  if(!isDefined(level.var_9A12)) {
    level.var_9A12 = 0;
    level.var_9A13 = 0;
  }

  setDvar("ui_inprematch", 1);
  prematchperiod();
  maps\mp\_utility::func_3FA4("prematch_done");
  level notify("prematch_over");
  setDvar("ui_inprematch", 0);
  level.var_7690 = gettime();
  maps\mp\_utility::func_2CED(8, ::maps\mp\_utility::func_3FA4, "team_collision_on");
  foreach(var_01 in level.players) {
    if(!function_0367()) {
      setmatchdata("players", var_01.var_2418, "playermatchtime_start_ms", gettime());
    }

    if(getomnvar("ui_current_round") == 1) {
      resetplayerdataonstartgameorconnect(var_01);
    }
  }

  func_A17B();
  thread func_99F3();
  thread func_483A();
  thread maps\mp\gametypes\_missions::roundbegin();
  thread maps\mp\_matchdata::func_6036();
  thread maps\mp\gametypes\_spawnscoring::func_5EAC();
  var_03 = isDefined(level.iszombiegame) && level.iszombiegame;
  if(var_03) {
    thread func_A11D();
  }

  if(!function_0367()) {
    function_0227();
  }
}

func_A98B() {
  level endon("game_ended");
  while(game["state"] == "playing") {
    var_00 = gettime();
    if(var_00 - level.var_5C0F["allies"] > level.var_A982["allies"] * 1000) {
      level notify("wave_respawn_allies");
      level.var_5C0F["allies"] = var_00;
      level.var_A987["allies"] = 0;
    }

    if(var_00 - level.var_5C0F["axis"] > level.var_A982["axis"] * 1000) {
      level notify("wave_respawn_axis");
      level.var_5C0F["axis"] = var_00;
      level.var_A987["axis"] = 0;
    }

    if(level.multiteambased) {
      for(var_01 = 0; var_01 < level.teamnamelist.size; var_01++) {
        if(var_00 - level.var_5C0F[level.teamnamelist[var_01]] > level.var_77C[level.teamnamelist[var_01]] * 1000) {
          var_02 = "wave_rewpawn_" + level.teamnamelist[var_01];
          level notify(var_02);
          level.var_5C0F[level.teamnamelist[var_01]] = var_00;
          level.var_A987[level.teamnamelist[var_01]] = 0;
        }
      }
    }

    wait 0.05;
  }
}

func_4439() {
  var_00["allies"] = 0;
  var_00["axis"] = 0;
  var_01["allies"] = 0;
  var_01["axis"] = 0;
  var_02["allies"] = 0;
  var_02["axis"] = 0;
  foreach(var_04 in level.players) {
    var_05 = var_04.pers["team"];
    if(isDefined(var_05) && var_05 == "allies" || var_05 == "axis") {
      var_00[var_05] = var_00[var_05] + var_04.score;
      var_01[var_05] = var_01[var_05] + var_04.kills;
      var_02[var_05] = var_02[var_05] + var_04.deaths;
    }
  }

  if(var_00["allies"] > var_00["axis"]) {
    return "allies";
  } else if(var_00["axis"] > var_00["allies"]) {
    return "axis";
  }

  if(var_01["allies"] > var_01["axis"]) {
    return "allies";
  } else if(var_01["axis"] > var_01["allies"]) {
    return "axis";
  }

  if(var_02["allies"] < var_02["axis"]) {
    return "allies";
  } else if(var_02["axis"] < var_02["allies"]) {
    return "axis";
  }

  if(randomint(2) == 0) {
    return "allies";
  }

  return "axis";
}

func_7A68(param_00, param_01) {
  if(!maps\mp\_utility::func_A872()) {
    return;
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }

  if(param_01 == game["end_reason"]["ranked_play_void_match"]) {
    maps\mp\gametypes\_ranked_play::onmatchvoid(param_00);
    return;
  }

  param_00 = func_44FD(param_00, 0);
  if(maps\mp\_utility::func_602B()) {
    if(function_03AF()) {
      maps\mp\gametypes\_ranked_play::func_6B56(param_00);
    } else {
      func_8A6A();
    }

    if(func_4DFF()) {
      level.hostforcedend = 1;
      logstring("host idled out");
      function_00ED();
    }

    func_A133(param_00);
  }

  func_A198(param_00);
}

func_3015(param_00, param_01) {
  if(!maps\mp\_utility::practiceroundgame()) {
    foreach(var_03 in level.players) {
      if(isDefined(var_03.var_2583) || var_03.pers["team"] == "spectator" && !var_03 method_8436()) {
        continue;
      }

      if(level.teambased) {
        var_03 thread maps\mp\gametypes\_hud_message::func_985C(param_00, 1, param_01);
        continue;
      }

      var_03 thread maps\mp\gametypes\_hud_message::func_6C65(param_00, param_01);
    }
  }

  if(!maps\mp\_utility::func_A872()) {
    level notify("round_win", param_00);
  }

  if(maps\mp\_utility::func_A872()) {
    func_7F19(level.var_7F16, 0);
    return;
  }

  func_7F19(level.var_7F16, 1);
}

func_300B(param_00, param_01) {
  if(isDefined(level.var_300C)) {
    return [[level.var_300C]](param_00, param_01);
  }

  if(!maps\mp\_utility::practiceroundgame()) {
    foreach(var_03 in level.players) {
      if(isDefined(var_03.var_2583) || var_03.pers["team"] == "spectator" && !var_03 method_8436()) {
        var_03 setclientomnvar("ui_round_end_spectator", 1);
        continue;
      }

      if(level.teambased) {
        var_03 thread maps\mp\gametypes\_hud_message::func_985C(param_00, 0, param_01, 1);
        continue;
      }

      var_03 thread maps\mp\gametypes\_hud_message::func_6C65(param_00, param_01);
    }
  }

  level notify("game_win", param_00);
  func_7F19(level.var_75EE, 1);
}

func_3016() {
  var_00 = level.var_495B;
  if(var_00 == "halftime") {
    if(maps\mp\_utility::func_471A("roundlimit")) {
      if(game["roundsPlayed"] * 2 == maps\mp\_utility::func_471A("roundlimit")) {
        var_00 = "halftime";
      } else {
        var_00 = "intermission";
      }
    } else if(maps\mp\_utility::func_471A("winlimit")) {
      if(game["roundsPlayed"] == maps\mp\_utility::func_471A("winlimit") - 1) {
        var_00 = "halftime";
      } else {
        var_00 = "intermission";
      }
    } else {
      var_00 = "intermission";
    }
  }

  level notify("round_switch", var_00);
  foreach(var_02 in level.players) {
    if(isDefined(var_02.var_2583) || var_02.pers["team"] == "spectator" && !var_02 method_8436()) {
      continue;
    }

    var_02 thread maps\mp\gametypes\_hud_message::func_985C(var_00, 1, game["end_reason"]["switching_sides"]);
  }

  func_7F19(level.var_495A, 0);
}

func_3E8C(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  foreach(var_03 in level.players) {
    var_03 method_800F();
    var_03 thread func_9412(param_00);
    var_03 thread func_7F17(4);
    var_03 func_3E89();
    if(isDefined(param_01) && param_01) {
      var_03 setclientdvars("3724", 1, "3078", 1);
      var_03 setclientomnvar("fov_scale", 1);
      continue;
    }

    var_03 setclientdvars("3724", 1);
  }

  if(isDefined(level.var_A4E)) {
    foreach(var_06 in level.var_A4E) {
      var_06 maps\mp\_utility::func_3E8E(1);
    }
  }
}

func_36BF(param_00, param_01) {
  setDvar("4899", 0);
  func_3E8C(1, 1);
  foreach(var_03 in level.players) {
    var_03.pers["stats"] = var_03.stats;
    var_03.pers["segments"] = var_03.var_838A;
  }

  level notify("round_switch", "overtime");
  var_05 = 0;
  var_06 = param_00 == "overtime";
  if(level.gametype == "ctf") {
    param_00 = "tie";
    var_05 = 1;
    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      param_00 = "axis";
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      param_00 = "allies";
    }
  }

  foreach(var_03 in level.players) {
    if(isDefined(var_03.var_2583) || var_03.pers["team"] == "spectator" && !var_03 method_8436()) {
      continue;
    }

    if(level.teambased) {
      var_03 thread maps\mp\gametypes\_hud_message::func_985C(param_00, var_05, param_01);
      continue;
    }

    var_03 thread maps\mp\gametypes\_hud_message::func_6C65(param_00, param_01);
  }

  func_7F19(level.var_7F16, 0);
  if(level.gametype == "ctf") {
    param_00 = "overtime_halftime";
  }

  if(isDefined(level.var_3B5C) && var_06) {
    level.var_3B57[level.var_3B5C] = maps\mp\_utility::func_467B();
    foreach(var_03 in level.players) {
      var_03 notify("reset_outcome");
    }

    level notify("game_cleanup");
    level notify("nuke_cancelled");
    func_A77D();
    if(level.gametype == "ctf") {
      param_00 = "overtime";
      param_01 = game["end_reason"]["tie"];
    }

    foreach(var_03 in level.players) {
      if(isDefined(var_03.var_2583) || var_03.pers["team"] == "spectator" && !var_03 method_8436()) {
        continue;
      }

      if(level.teambased) {
        var_03 thread maps\mp\gametypes\_hud_message::func_985C(param_00, 0, param_01);
        continue;
      }

      var_03 thread maps\mp\gametypes\_hud_message::func_6C65(param_00, param_01);
    }

    func_7F19(level.var_495A, 0);
  }

  game["status"] = param_00;
  level notify("restarting");
  game["state"] = "playing";
  setDvar("2523", game["state"]);
  map_restart(1);
}

func_36BC(param_00) {
  setDvar("4899", 0);
  var_01 = "halftime";
  var_02 = 1;
  if(isDefined(level.var_4958) && !level.var_4958) {
    var_02 = 0;
  }

  if(var_02) {
    game["switchedsides"] = !game["switchedsides"];
    var_03 = game["end_reason"]["switching_sides"];
  } else {
    var_03 = var_01;
  }

  func_3E8C(1, 1);
  if(level.gametype == "ctf") {
    var_03 = param_00;
    var_01 = "tie";
    if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_01 = "axis";
    }

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      var_01 = "allies";
    }
  } else if(maps\mp\_utility::func_579B()) {
    var_03 = param_00;
    var_04 = game["attackers"];
    var_05 = game["defenders"];
    if(getomnvar("ui_war_attacker_flipped") == 1) {
      var_04 = game["defenders"];
      var_05 = game["attackers"];
    }

    if(param_00 == game["end_reason"]["time_limit_reached"]) {
      setomnvar("ui_game_victor", maps\mp\_utility::func_46D4(var_05));
    } else {
      setomnvar("ui_game_victor", maps\mp\_utility::func_46D4(var_04));
    }
  }

  foreach(var_07 in level.players) {
    var_07.pers["stats"] = var_07.stats;
    var_07.pers["segments"] = var_07.var_838A;
  }

  level notify("round_switch", "halftime");
  foreach(var_07 in level.players) {
    if(isDefined(var_07.var_2583) || var_07.pers["team"] == "spectator" && !var_07 method_8436()) {
      continue;
    }

    var_07 thread maps\mp\gametypes\_hud_message::func_985C(var_01, 1, var_03);
  }

  func_7F19(level.var_7F16, 0);
  if(isDefined(level.var_3B5C)) {
    level.var_3B57[level.var_3B5C] = maps\mp\_utility::func_467B();
    foreach(var_07 in level.players) {
      var_07 notify("reset_outcome");
    }

    level notify("game_cleanup");
    level notify("nuke_cancelled");
    func_A77D();
    if(isDefined(level.var_495C)) {
      [[level.var_495C]]();
    } else {
      var_0D = game["end_reason"]["switching_sides"];
      if(!var_02) {
        var_0D = var_03;
      }

      foreach(var_07 in level.players) {
        if(isDefined(var_07.var_2583) || var_07.pers["team"] == "spectator" && !var_07 method_8436()) {
          continue;
        }

        var_07 thread maps\mp\gametypes\_hud_message::func_985C("halftime", 1, var_0D);
      }

      func_7F19(level.var_495A, 0);
    }
  }

  game["status"] = "halftime";
  level notify("restarting");
  game["state"] = "playing";
  setDvar("2523", game["state"]);
  map_restart(1);
}

func_A11D() {
  level endon("game_ended");
  for(;;) {
    var_00 = func_44F8();
    setomnvar("ui_game_duration", var_00 * 1000);
    wait(1);
  }
}

func_44F8() {
  var_00 = maps\mp\_utility::func_44FB();
  return var_00;
}

func_3F9C(param_00) {
  if(param_00 > 86399) {
    return 86399;
  }

  return param_00;
}

func_6028(param_00, param_01, param_02) {
    var_03 = gettime();
    var_04 = "_gamelogic.gsc";
    var_05 = "all";
    if(level.teambased && isDefined(param_00)) {
      var_05 = param_00;
    }

    var_06 = "undefined";
    if(isDefined(param_01)) {
      switch (param_01) {
        case 1:
          var_06 = "MP_SCORE_LIMIT_REACHED";
          break;

        case 2:
          var_06 = "MP_TIME_LIMIT_REACHED";
          break;

        case 3:
          var_06 = "MP_PLAYERS_FORFEITED";
          break;

        case 4:
          var_06 = "MP_TARGET_DESTROYED";
          break;

        case 5:
          var_06 = "MP_BOMB_DEFUSED";
          break;

        case 6:
          var_06 = "MP_GHOSTS_ELIMINATED";
          break;

        case 7:
          var_06 = "MP_FEDERATION_ELIMINATED";
          break;

        case 8:
          var_06 = "MP_GHOSTS_FORFEITED";
          break;

        case 9:
          var_06 = "MP_FEDERATION_FORFEITED";
          break;

        case 10:
          var_06 = "MP_ENEMIES_ELIMINATED";
          break;

        case 11:
          var_06 = "MP_MATCH_TIE";
          break;

        case 12:
          var_06 = "GAME_OBJECTIVECOMPLETED";
          break;

        case 13:
          var_06 = "GAME_OBJECTIVEFAILED";
          break;

        case 14:
          var_06 = "MP_SWITCHING_SIDES";
          break;

        case 15:
          var_06 = "MP_ROUND_LIMIT_REACHED";
          break;

        case 16:
          var_06 = "MP_ENDED_GAME";
          break;

        case 17:
          var_06 = "MP_HOST_ENDED_GAME";
          break;

        default:
          break;
      }
    }

    if(!isDefined(var_03)) {
      var_03 = -1;
    }

    var_07 = 18;
    var_08 = var_07;
    var_09 = getmatchdata("match_common", "player_count");
    var_0A = getmatchdata("match_common", "life_count");
    var_0B = getmatchdata("match_common", "playlist_name");
    var_0C = 0;
    if(isDefined(var_0B)) {
      if(issubstr(var_0B, "QA")) {
        var_0C = 1;
      }
    }

    if(!isDefined(level.var_6026)) {
      var_0D = 0;
      var_0E = 0;
      var_0F = 0;
      var_10 = 0;
      var_11 = 0;
      var_12 = 0;
      var_13 = 0;
      var_14 = 0;
    } else {
      if(isDefined(game["botJoinCount"])) {
        var_0D = game["botJoinCount"];
      } else {
        var_0D = 0;
      }

      if(isDefined(game["deathCount"])) {
        var_0E = game["deathCount"];
      } else {
        var_0E = 0;
      }

      if(isDefined(game["trapSpawnDiedTooFastCount"])) {
        var_0F = game["trapSpawnDiedTooFastCount"];
      } else {
        var_0F = 0;
      }

      if(isDefined(game["trapSpawnKilledTooFastCount"])) {
        var_10 = game["trapSpawnKilledTooFastCount"];
      } else {
        var_10 = 0;
      }

      if(isDefined(game["trapSpawnDmgDealtCount"])) {
        var_11 = game["trapSpawnDmgDealtCount"];
      } else {
        var_11 = 0;
      }

      if(isDefined(game["trapSpawnDmgReceivedCount"])) {
        var_12 = game["trapSpawnDmgReceivedCount"];
      } else {
        var_12 = 0;
      }

      if(isDefined(game["trapSpawnByAnyMeansCount"])) {
        var_13 = game["trapSpawnByAnyMeansCount"];
      } else {
        var_13 = 0;
      }

      if(isDefined(game["spawnClaimFlipCount"])) {
        var_14 = game["spawnClaimFlipCount"];
      } else {
        var_14 = 0;
      }
    }

    if(param_02) {
      function_00F5("@"script_mp_match_end: script_file % s, gameTime % d, match_winner % s, win_reason % s, version % d, joinCount % d, botJoinCount % d, spawnCount % d, deathCount % d, trapSpawnDiedTooFastCount % d, trapSpawnKilledTooFastCount % d, trapSpawnDmgDealtCount % d, trapSpawnDmgReceivedCount % d, trapSpawnByAnyMeansCount % d, spawnFlipCount % d, qaPlayList % d ",var_04,var_03,var_05,var_06,var_08,var_09,var_0D,var_0A,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_0C);
        return;
      }

      function_00F5("@"script_mp_round_end: script_file % s, gameTime % d, match_winner % s, win_reason % s, version % d, joinCount % d, botJoinCount % d, spawnCount % d, deathCount % d, trapSpawnDiedTooFastCount % d, trapSpawnKilledTooFastCount % d, trapSpawnDmgDealtCount % d, trapSpawnDmgReceivedCount % d, trapSpawnByAnyMeansCount % d, spawnFlipCount % d, qaPlayList % d ",var_04,var_03,var_05,var_06,var_08,var_09,var_0D,var_0A,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_0C);
      }

      endgame(param_00, param_01, param_02) {
        if(isDefined(level.var_36BA)) {
          return [[level.var_36BA]](param_00, param_01, param_02);
        }

        if(!isDefined(param_02)) {
          param_02 = 0;
        }

        if(game["state"] == "postgame" || level.gameended) {
          return;
        }

        game["state"] = "postgame";
        setDvar("2523", "postgame");
        level.var_3F9F = gettime();
        level.gameended = 1;
        level.var_5139 = 0;
        level notify("game_ended", param_00);
        maps\mp\_utility::func_5CBE("game_over");
        maps\mp\_utility::func_5CBE("block_notifies");
        var_03 = func_44F8();
        var_04 = game["roundsPlayed"];
        setomnvar("ui_game_duration", var_03 * 1000);
        wait 0.05;
        setgameendtime(0);
        var_05 = getsystemtime();
        setmatchdata("match_common", "game_length_seconds", var_03);
        setmatchdata("match_common", "utc_end_time", var_05);
        setmatchdata("match_common", "player_count_end", level.players.size);
        if(!function_0367()) {
          foreach(var_07 in level.players) {
            var_08 = getmatchdata("players", var_07.var_2418, "playermatchtime_start_ms");
            var_09 = getmatchdata("players", var_07.var_2418, "playermatchtime_total_ms");
            var_09 = var_09 + level.var_3F9F - var_08;
            setmatchdata("players", var_07.var_2418, "playermatchtime_total_ms", var_09);
            setmatchdata("players", var_07.var_2418, "utc_disconnect_time_s", var_05);
            setmatchdata("players", var_07.var_2418, "disconnect_reason", "EXE_MATCHENDED");
            if(!isDefined(var_07.has_recently_done_damage)) {
              if(isDefined(var_07.pers["rounds_without_damage"])) {
                var_07.pers["rounds_without_damage"]++;
                continue;
              }

              var_07.pers["rounds_without_damage"] = 1;
            }
          }
        }

        func_21C1();
        game["roundsPlayed"]++;
        if(isDefined(param_00) && isstring(param_00) && maps\mp\_utility::func_576C(param_00)) {
          level.var_3B5C = "none";
          func_6028(param_00, param_01, 0);
          maps\mp\_matchdata::func_5E91(var_04, getteamscore("axis"), getteamscore("allies"));
          maps\mp\gametypes\_spawnscoring::func_5E90();
          func_36BF(param_00, param_01);
          return;
        }

        if(isDefined(param_00) && isstring(param_00) && param_00 == "halftime") {
          level.var_3B5C = "none";
          func_6028(param_00, param_01, 0);
          maps\mp\_matchdata::func_5E91(var_04, getteamscore("axis"), getteamscore("allies"));
          maps\mp\gametypes\_spawnscoring::func_5E90();
          func_36BC(param_01);
          return;
        }

        if(isDefined(level.var_3B5C)) {
          level.var_3B57[level.var_3B5C] = maps\mp\_utility::func_467B();
        }

        if(level.gametype != "raid") {
          setomnvar("ui_current_round", game["roundsPlayed"]);
        }

        if(level.teambased) {
          if((param_00 == "axis" || param_00 == "allies") && level.gametype != "ctf") {
            game["roundsWon"][param_00]++;
          }

          maps\mp\gametypes\_gamescore::func_A174("axis");
          maps\mp\gametypes\_gamescore::func_A174("allies");
        } else if(isDefined(param_00) && isPlayer(param_00)) {
          game["roundsWon"][param_00.guid]++;
        }

        maps\mp\gametypes\_gamescore::func_A14D();
        foreach(var_07 in level.players) {
          var_07 setclientdvar("3635", 1);
          if(maps\mp\_utility::func_A875() || maps\mp\_utility::func_A872()) {
            var_07 maps\mp\killstreaks\_killstreaks::func_2400(1);
            var_07.pers["supportStreaksEarned"] = undefined;
          }
        }

        setDvar("2335", 1);
        setDvar("ui_allow_teamchange", 0);
        setDvar("4899", 0);
        func_3E8C(1, 1);
        var_0D = isDefined(level.iszombiegame) && level.iszombiegame;
        if(var_0D) {
          var_0E = 0;
          if(isDefined(level.zmb_shotgun_game_won)) {
            var_0E = common_scripts\utility::func_562E(level.zmb_shotgun_game_won);
          } else {
            var_0E = param_01 == game["end_reason"]["zombies_completed"];
          }

          if(var_0E) {
            foreach(var_07 in level.players) {
              [[level.zmb_events_on_map_won]](var_07);
            }
          }
        } else {
          maps\mp\_matchdata::func_5E91(var_04, getteamscore("axis"), getteamscore("allies"));
        }

        if(!maps\mp\_utility::func_A875() && !param_02 && !level.forcedend) {
          func_3015(param_00, param_01);
          if(isDefined(level.var_3B5C)) {
            foreach(var_07 in level.players) {
              var_07 notify("reset_outcome");
            }

            level notify("game_cleanup");
            level notify("nuke_cancelled");
            func_A77D();
          }

          if(!maps\mp\_utility::func_A872()) {
            maps\mp\_utility::func_5CBB("block_notifies");
            if(func_21E1()) {
              func_3016();
            }

            foreach(var_07 in level.players) {
              var_07.pers["stats"] = var_07.stats;
              var_07.pers["segments"] = var_07.var_838A;
            }

            level notify("restarting");
            game["state"] = "playing";
            setDvar("2523", "playing");
            func_6028(param_00, param_01, 0);
            maps\mp\gametypes\_spawnscoring::func_5E90();
            foreach(var_07 in level.players) {
              game["firstbloodcount"][var_07.guid] = var_07.firstbloodcount;
            }

            map_restart(1);
            return;
          }

          if(!level.forcedend) {
            var_05 = func_A10C(var_04);
          }
        }

        if(!isDefined(game["clientMatchDataDef"])) {
          game["clientMatchDataDef"] = "mp/ddl/clientmatchdata.ddl";
          setclientmatchdatadef(game["clientMatchDataDef"]);
        }

        func_7A68(var_04, var_05);
        maps\mp\gametypes\_missions::roundend(var_04);
        var_04 = func_44FD(var_04, 1);
        if(level.teambased) {
          setomnvar("ui_game_victor", 0);
          if(var_04 == "allies") {
            setomnvar("ui_game_victor", 2);
          } else if(var_04 == "axis") {
            setomnvar("ui_game_victor", 1);
          }
        }

        func_300B(var_04, var_05);
        if(isDefined(level.var_3B5C) && maps\mp\_utility::func_A875()) {
          foreach(var_14 in level.players) {
            var_14 notify("reset_outcome");
          }

          level notify("game_cleanup");
          level notify("nuke_cancelled");
          func_A77D();
        }

        if(isDefined(level.var_75E7)) {
          [[level.var_75E7]]();
        }

        maps\mp\_utility::func_5CBB("block_notifies");
        level.var_541D = 1;
        level notify("spawning_intermission");
        foreach(var_14 in level.players) {
          if(function_02A3() && !function_0371() && !isDefined(level.iszombiegame) || !level.iszombiegame) {
            var_14 maps\mp\gametypes\_class::func_1FA2(common_scripts\utility::func_46AF());
          }

          var_14 closepopupmenu();
          var_14 closeingamemenu();
          var_14 notify("reset_outcome");
          var_14 thread maps\mp\gametypes\_playerlogic::func_9073();
        }

        func_7758();
        maps\mp\_skill::process();
        func_21BC();
        func_A0F8(var_04);
        if(!level.iszombiegame) {
          if(level.teambased) {
            if(var_04 == "axis" || var_04 == "allies") {
              setmatchdata("victor", var_04);
            } else {
              setmatchdata("victor", "none");
              if(var_04 == "tie") {
                setmatchdata("is_draw", 1);
              }
            }

            function_0229(var_04);
          } else {
            setmatchdata("victor", "none");
          }
        }

        level maps\mp\_matchdata::func_36DB();
        var_1B = maps\mp\gametypes\_gamescore::func_450B(3);
        foreach(var_14 in level.players) {
          if(var_14 maps\mp\_utility::rankingenabled()) {
            var_14 maps\mp\_matchdata::func_5E92();
            var_14 lib_0468::func_A1E(var_14.kills, var_14.deaths, level.gametype, var_04);
          }

          var_14 maps\mp\gametypes\_playerlogic::func_5EA9();
          if(!level.iszombiegame && !function_0367()) {
            if(level.teambased) {
              if(var_04 == "tie") {
                setmatchdata("players", var_14.var_2418, "match_result", "draw");
              } else if(var_04 == "axis" || var_04 == "allies") {
                if(isDefined(var_14.team)) {
                  if(var_14.team == var_04) {
                    setmatchdata("players", var_14.var_2418, "match_result", "win");
                  } else {
                    setmatchdata("players", var_14.var_2418, "match_result", "loss");
                  }
                }
              }

              continue;
            }

            if(isPlayer(var_04)) {
              setmatchdata("players", var_14.var_2418, "match_result", "loss");
              if(level.players.size > 5) {
                foreach(var_1E in var_1B) {
                  if(var_14.var_2418 == var_1E.var_2418) {
                    setmatchdata("players", var_14.var_2418, "match_result", "win");
                  }
                }

                continue;
              }

              if(var_14.var_2418 == var_04.var_2418) {
                setmatchdata("players", var_14.var_2418, "match_result", "win");
              }
            }
          }
        }

        setmatchdata("match_common", "host", maps\mp\gametypes\_playerlogic::func_9E05(level.var_4E0E));
        if(maps\mp\_utility::func_602B()) {
          setmatchdata("match_common", "playlist_version", function_0260());
          setmatchdata("match_common", "playlist_id", function_0261());
          setmatchdata("match_common", "isDedicated", isdedicatedserver());
        }

        setmatchdata("match_common", "levelMaxClients", level.var_6079);
        if(isDefined(game["trapSpawnDiedTooFastCount"]) && isDefined(game["trapSpawnKilledTooFastCount"])) {
          var_21 = game["trapSpawnDiedTooFastCount"] + game["trapSpawnKilledTooFastCount"];
        } else {
          var_21 = -1;
        }

        if(isDefined(game["trapSpawnDmgDealtCount"]) && isDefined(game["trapSpawnDmgReceivedCount"])) {
          var_22 = game["trapSpawnDmgDealtCount"] + game["trapSpawnDmgReceivedCount"];
        } else {
          var_22 = -1;
        }

        if(isDefined(game["trapSpawnByAnyMeansCount"])) {
          var_23 = game["trapSpawnByAnyMeansCount"];
        } else {
          var_23 = -1;
        }

        if(isDefined(game["objectiveFlipCount"])) {
          var_24 = game["objectiveFlipCount"];
        } else {
          var_24 = -1;
        }

        setmatchdata("match_common", "spawnTuningVersion", common_scripts\utility::func_9AAD(level.var_90B4));
        setmatchdata("match_common", "victimSpawnCount", var_21);
        setmatchdata("match_common", "immediateActionCount", var_22);
        setmatchdata("match_common", "badSpawnByAnyMeansCount", var_23);
        setmatchdata("match_common", "objectiveFlipCount", var_24);
        function_038D();
        function_0125();
        function_0376();
        if(maps\mp\gametypes\_spawnscoring::func_57DC(level.gametype) && isDefined(level.var_903C)) {
          function_0379();
        }

        function_037D();
        foreach(var_14 in level.players) {
          var_14.pers["stats"] = var_14.stats;
          var_14.pers["segments"] = var_14.var_838A;
        }

        function_022A();
        var_27 = 0;
        if(maps\mp\_utility::practiceroundgame()) {
          var_27 = 5;
        }

        if(isDefined(level.var_36C3)) {
          [[level.var_36C3]](var_0B, level.var_75E4, var_27, var_04);
        }

        if(function_03A9()) {
          while(!function_03AA()) {
            wait(0.25);
          }

          wait(1);
        }

        func_6028(var_04, var_05, 1);
        maps\mp\gametypes\_spawnscoring::func_5E90();
        if(!common_scripts\utility::func_562E(level.forcedend) && maps\mp\_utility::func_579B() && isDefined(game["switchedsides"]) && !game["switchedsides"]) {
          if(isDefined(level.var_36C0)) {
            [[level.var_36C0]]();
          }

          game["game_one_winner"] = var_04;
          game["roundsPlayed"] = 0;
          game["switchedsides"] = 1;
          game["state"] = "playing";
          setDvar("2523", game["state"]);
          map_restart(1);
          return;
        }

        if(common_scripts\utility::func_562E(level.var_7DD2)) {
          map_restart(0);
          return;
        }

        level notify("exitLevel_called");
        exitlevel(0);
      }

      func_44FD(param_00, param_01) {
        if(isDefined(level.getgamewinnerfunc)) {
          return [[level.getgamewinnerfunc]](param_00, param_01);
        }

        if(!isstring(param_00)) {
          return param_00;
        }

        var_02 = param_00;
        if(level.teambased && (maps\mp\_utility::func_57B2() || level.gametype == "ctf") && level.gameended && !isDefined(level.var_3E39)) {
          var_03 = "roundsWon";
          if(isDefined(level.var_AA24) && level.var_AA24) {
            var_03 = "teamScores";
          }

          if(game[var_03]["allies"] == game[var_03]["axis"]) {
            var_02 = "tie";
          } else if(game[var_03]["axis"] > game[var_03]["allies"]) {
            var_02 = "axis";
          } else {
            var_02 = "allies";
          }
        }

        if(param_01 && var_02 == "allies" || var_02 == "axis") {
          level.var_3B5C = var_02;
        }

        return var_02;
      }

      func_A10C(param_00) {
        if(!level.teambased) {
          return 1;
        }

        if(maps\mp\_utility::func_4DDD()) {
          return game["end_reason"]["round_limit_reached"];
        }

        if(maps\mp\_utility::func_4DE7()) {
          return game["end_reason"]["score_limit_reached"];
        }

        return game["end_reason"]["objective_completed"];
      }

      func_3878(param_00) {
        var_01 = func_4673(param_00);
        var_02 = func_4674(param_00);
        var_03 = 999999;
        if(var_01) {
          var_03 = var_02 / var_01;
        }

        return var_03;
      }

      func_4673(param_00) {
        var_01 = maps\mp\_utility::func_471A("scorelimit");
        var_02 = maps\mp\_utility::func_46E2();
        var_03 = maps\mp\_utility::gettimepassed() / -5536 + 0.0001;
        if(isPlayer(self)) {
          var_04 = self.score / var_03;
        } else {
          var_04 = getteamscore(var_01) / var_04;
        }

        return var_04;
      }

      func_4674(param_00) {
        var_01 = maps\mp\_utility::func_471A("scorelimit");
        if(isPlayer(self)) {
          var_02 = var_01 - self.score;
        } else {
          var_02 = var_02 - getteamscore(var_01);
        }

        return var_02;
      }

      func_478F() {
        self endon("death");
        self endon("disconnect");
        level endon("game_ended");
        maps\mp\_utility::func_A78E(3);
        thread maps\mp\_utility::func_9863("callout_lastteammemberalive", self, self.pers["team"]);
        if(level.multiteambased) {
          foreach(var_01 in level.teamnamelist) {
            if(self.pers["team"] != var_01) {
              thread maps\mp\_utility::func_9863("callout_lastenemyalive", self, var_01);
            }
          }
        } else {
          var_03 = maps\mp\_utility::func_45DE(self.pers["team"]);
          thread maps\mp\_utility::func_9863("callout_lastenemyalive", self, var_03);
        }

        level notify("last_alive", self);
      }

      func_7758() {
        var_00 = 0;
        foreach(var_02 in level.players) {
          if(!isDefined(var_02)) {
            continue;
          }

          var_02.var_241A = var_00;
          var_00++;
          if(isDefined(level.iszombiegame) && level.iszombiegame) {
            var_02.var_241A = var_02 getentitynumber();
          }

          setclientmatchdata("players", var_02.var_241A, "name", maps\mp\gametypes\_playerlogic::func_9E05(var_02.name));
          setclientmatchdata("players", var_02.var_241A, "xuid", var_02.var_1D6);
        }

        maps\mp\_awards::assignawards();
        maps\mp\_scoreboard::func_7759();
        sendclientmatchdata();
        if(!function_0367()) {
          function_0225();
        }
      }

      func_9BC0(param_00, param_01) {
        thread func_996D(param_00, 1, "deaths");
      }

      func_9BA0(param_00, param_01, param_02) {
        if(isDefined(self) && isPlayer(self)) {
          if(param_01 != "MOD_FALLING") {
            thread func_996D(param_00, 1, "kills");
            if(maps\mp\_utility::ismeleemod(param_01) && issubstr(param_00, "tactical")) {
              return;
            }

            if(maps\mp\_utility::ismeleemod(param_01) && !issubstr(param_00, "riotshield") && !issubstr(param_00, "combatknife")) {
              return;
            }

            var_03 = 0;
            if(isDefined(param_02) && isDefined(param_02.firedads)) {
              var_03 = param_02.firedads;
            } else {
              var_03 = self playerads();
            }

            if(var_03 < 0.2) {
              thread func_996D(param_00, 1, "hipfirekills");
              if(isDefined(self.var_79) && self.var_79 == 7) {}
            }
          }

          if(param_01 == "MOD_HEAD_SHOT") {
            thread func_996D(param_00, 1, "headShots");
          }
        }
      }

      func_8A67(param_00, param_01, param_02) {
        if(function_0367()) {
          return;
        }

        if(!param_01) {
          return;
        }

        var_03 = maps\mp\_utility::getweaponclass(param_00);
        if(var_03 == "killstreak" || var_03 == "other") {
          return;
        }

        if(maps\mp\_utility::isenvironmentweapon(param_00)) {
          return;
        }

        if(maps\mp\_utility::func_568F(param_00) || maps\mp\_utility::isuseweapon(param_00)) {
          return;
        }

        if(var_03 == "weapon_grenade" || var_03 == "weapon_explosive") {
          if(param_00 == "frag_grenade_german_mp") {
            param_00 = "frag_grenade_mp";
          }

          if(param_00 == "signal_flare_expeditionary_mp") {
            param_00 = "signal_flare_mp";
          }

          maps\mp\gametypes\_persistence::func_50FF(param_00, param_02, param_01);
          maps\mp\_matchdata::func_5EAF(param_00, param_02, param_01, param_00);
          return;
        }

        var_04 = maps\mp\gametypes\_weapons::func_5794(param_00);
        if(param_02 != "timeInUse" && param_02 != "deaths" && !var_04) {
          var_05 = param_00;
          var_06 = self getcurrentweapon();
          if(function_01A9(var_05) == "melee" || function_01A9(var_06) == "melee") {
            if(param_02 == "kills") {
              maps\mp\gametypes\_persistence::func_A195();
              self.var_9BBB = var_05;
              self.trackingweaponkills++;
              maps\mp\gametypes\_persistence::func_A195();
              if(!maps\mp\_utility::func_773F()) {
                var_07 = maps\mp\_utility::func_45B5(var_05);
                if(maps\mp\_utility::func_5699(var_07) || maps\mp\_utility::iscacsecondaryweapon(var_07)) {
                  var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_07, "kills");
                  self setcurrentweaponkillcount(var_08);
                }
              }

              return;
            }
          }

          if(var_05 != var_06) {
            if(maps\mp\_utility::iskillstreakweapon(var_06)) {
              return;
            }

            param_00 = var_06;
          }
        }

        if(!isDefined(self.var_9BBB)) {
          self.var_9BBB = param_00;
        }

        if(param_00 != self.var_9BBB) {
          maps\mp\gametypes\_persistence::func_A195();
          self.var_9BBB = param_00;
        }

        switch (param_02) {
          case "shots":
            self.var_9BBC++;
            break;

          case "hits":
            self.var_9BB9++;
            break;

          case "headShots":
            self.trackingweaponheadshots++;
            break;

          case "kills":
            self.trackingweaponkills++;
            break;

          case "hipfirekills":
            self.trackingweaponhipfirekills++;
            break;

          case "timeInUse":
            self.var_9BBD = self.var_9BBD + param_01;
            break;

          case "assists":
            self.trackingweaponassists++;
            break;

          case "multikills":
            self.trackingweaponmultikills++;
            break;
        }

        if(isDefined(param_00) && param_00 != "none" && param_02 == "kills" && !maps\mp\_utility::func_773F()) {
          var_07 = maps\mp\_utility::func_45B5(param_00);
          if(maps\mp\_utility::func_5699(var_07) || maps\mp\_utility::iscacsecondaryweapon(var_07)) {
            var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_07, "kills");
            var_08 = var_08 + self.trackingweaponkills;
            self setcurrentweaponkillcount(var_08);
          }
        }

        if(param_02 == "deaths") {
          var_09 = maps\mp\_utility::getbaseweaponname(param_00);
          if(!maps\mp\_utility::func_5699(var_09) && !maps\mp\_utility::iscacsecondaryweapon(var_09)) {
            return;
          }

          var_0A = maps\mp\_utility::func_4725(param_00);
          maps\mp\gametypes\_persistence::func_50FF(var_09, param_02, param_01);
          maps\mp\_matchdata::func_5EAF(var_09, "deaths", param_01, param_00);
          foreach(var_0C in var_0A) {
            maps\mp\gametypes\_persistence::func_50F9(var_0C, param_02, param_01);
          }
        }
      }

      func_86B0(param_00, param_01, param_02) {
        if(!isDefined(param_01)) {
          return;
        }

        if(!isDefined(param_00)) {
          param_01 func_8A67(param_02, 1, "hits");
          return;
        }

        if(!isDefined(param_00.var_73AE)) {
          param_00.var_73AE = [];
        }

        var_03 = 1;
        for(var_04 = 0; var_04 < param_00.var_73AE.size; var_04++) {
          if(param_00.var_73AE[var_04] == self) {
            var_03 = 0;
            break;
          }
        }

        if(var_03) {
          param_00.var_73AE[param_00.var_73AE.size] = self;
          param_01 func_8A67(param_02, 1, "hits");
        }
      }

      func_996D(param_00, param_01, param_02) {
        self endon("disconnect");
        waittillframeend;
        func_8A67(param_00, param_01, param_02);
      }

      func_21BC() {
        foreach(var_01 in level.players) {
          if(!isDefined(var_01)) {
            continue;
          }

          if(var_01 maps\mp\_utility::rankingenabled()) {
            var_02 = var_01.pers["summary"]["xp"];
            if(!isDefined(level.disableallplayerstats) || !level.disableallplayerstats) {
              var_03 = getmatchdata("players", var_01.var_2418, "playermatchtime_total_ms");
              var_04 = var_01 getrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "kills");
              var_05 = var_01 getrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "deaths");
              var_06 = var_01.score;
              var_07 = 0;
              if(var_03 > 0) {
                var_07 = var_06 / var_03 / 3600;
              }

              var_08 = func_4668(var_01);
              var_09 = var_01 getrankedplayerdata(common_scripts\utility::func_46AE(), "bestKills");
              var_0A = var_01 getrankedplayerdata(common_scripts\utility::func_46AE(), "mostDeaths");
              var_0B = var_01 getrankedplayerdata(common_scripts\utility::func_46AE(), "mostXp");
              var_0C = var_01 getrankedplayerdata(common_scripts\utility::func_46AE(), "bestScore");
              var_0D = var_01 getrankedplayerdata(common_scripts\utility::func_46AE(), "bestSPM");
              var_0E = var_01 getrankedplayerdata(common_scripts\utility::func_46AE(), "bestAccuracy");
              if(var_04 > var_09) {
                var_01 setrankedplayerdata(common_scripts\utility::func_46AE(), "bestKills", var_04);
                setmatchdata("players", var_01.var_2418, "best_kills", 1);
              }

              if(var_02 > var_0B) {
                var_01 setrankedplayerdata(common_scripts\utility::func_46AE(), "mostXp", var_02);
              }

              if(var_05 > var_0A) {
                var_01 setrankedplayerdata(common_scripts\utility::func_46AE(), "mostDeaths", var_05);
              }

              if(var_06 > var_0C) {
                var_01 setrankedplayerdata(common_scripts\utility::func_46AE(), "bestScore", var_06);
                setmatchdata("players", var_01.var_2418, "best_score", 1);
              }

              if(var_07 > var_0D) {
                var_01 setrankedplayerdata(common_scripts\utility::func_46AE(), "bestSPM", var_07);
              }

              if(var_08 > var_0E) {
                var_01 setrankedplayerdata(common_scripts\utility::func_46AE(), "bestAccuracy", var_08);
              }

              var_01 func_21B4();
            }

            var_01 maps\mp\_matchdata::func_5EAA(var_02, "total_xp");
            var_01 maps\mp\_matchdata::func_5EAA(var_01.pers["summary"]["score"], "score_xp");
            var_01 maps\mp\_matchdata::func_5EAA(var_01.pers["summary"]["challenge"], "challenge_xp");
            var_01 maps\mp\_matchdata::func_5EAA(var_01.pers["summary"]["match"], "bonus_xp");
            var_01 maps\mp\_matchdata::func_5EAA(var_01.pers["summary"]["misc"] + var_01.pers["summary"]["entitlementXP"] + var_01.pers["summary"]["doubleXp"], "misc_xp");
          }

          if(isDefined(var_01.pers["confirmed"])) {
            var_01 maps\mp\_matchdata::func_5E97();
          }

          if(isDefined(var_01.pers["denied"])) {
            var_01 maps\mp\_matchdata::func_5E98();
          }
        }
      }

      func_4668(param_00) {
        var_01 = float(param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "totalShots") - param_00.pers["previous_shots"]);
        if(var_01 == 0) {
          return 0;
        }

        var_02 = float(param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "hits") - param_00.pers["previous_hits"]);
        var_03 = clamp(var_02 / var_01, 0, 1) * 10000;
        return int(var_03);
      }

      func_21B4() {
        var_00 = maps\mp\_matchdata::func_1D40();
        var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeapon", "kills");
        var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeaponID");
        var_03 = var_01;
        var_04 = "";
        for(var_05 = 0; var_05 < var_00.size; var_05++) {
          var_06 = var_00[var_05];
          var_06 = maps\mp\_utility::getbaseweaponname(var_06);
          if(!function_0367() && maps\mp\_utility::func_5716(var_06)) {
            continue;
          }

          if(issubstr(var_06, "riotshield_mp") || issubstr(var_06, "war_super_soldier_syrum_")) {
            continue;
          }

          var_07 = maps\mp\_utility::getweaponclass(var_06);
          if(!maps\mp\_utility::iskillstreakweapon(var_06) && var_07 != "killstreak" && var_07 != "other") {
            var_08 = 0;
            if(isDefined(self.pers["mpWeaponStats"][var_06]) && isDefined(self.pers["mpWeaponStats"][var_06]["kills"])) {
              var_08 = self.pers["mpWeaponStats"][var_06]["kills"];
              if(var_08 > var_03) {
                var_03 = var_08;
                var_04 = var_06;
              }
            }
          }
        }

        if(var_03 > var_01) {
          self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeapon", "kills", var_03);
          var_09 = 0;
          if(isDefined(self.pers["mpWeaponStats"][var_04]["shots"])) {
            var_09 = self.pers["mpWeaponStats"][var_04]["shots"];
          }

          var_0A = 0;
          if(isDefined(self.pers["mpWeaponStats"][var_04]["headShots"])) {
            var_0A = self.pers["mpWeaponStats"][var_04]["headShots"];
          }

          var_0B = 0;
          if(isDefined(self.pers["mpWeaponStats"][var_04]["hits"])) {
            var_0B = self.pers["mpWeaponStats"][var_04]["hits"];
          }

          var_0C = 0;
          if(isDefined(self.pers["mpWeaponStats"][var_04]["deaths"])) {
            var_0C = self.pers["mpWeaponStats"][var_04]["deaths"];
          }

          var_0D = 0;
          if(isDefined(self.pers["mpWeaponStats"][var_04]["assists"])) {
            var_0D = self.pers["mpWeaponStats"][var_04]["assists"];
          }

          self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeapon", "shots", var_09);
          self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeapon", "headShots", var_0A);
          self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeapon", "hits", var_0B);
          self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeapon", "deaths", var_0C);
          self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeapon", "assists", var_0D);
          var_0E = maps\mp\_utility::func_452A(var_04);
          self setrankedplayerdata(common_scripts\utility::func_46AE(), "bestWeaponID", var_0E);
        }
      }

      func_A0FC() {
        if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
          return;
        }

        var_00 = 5;
        var_01 = var_00 * 2;
        var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "numTrends");
        var_02++;
        var_03 = var_02;
        if(var_02 > var_00) {
          if(var_02 > var_01) {
            var_02 = var_00 + 1;
          }

          var_03 = var_02 - var_00;
        }

        var_04 = maps\mp\_utility::func_46E7();
        if(isDefined(self.kills)) {
          var_05 = self.kills;
        } else {
          var_05 = 0;
        }

        if(isDefined(self.deaths)) {
          var_06 = self.deaths;
        } else {
          var_06 = 0;
        }

        if(isDefined(self.score)) {
          var_07 = self.score;
        } else {
          var_07 = 0;
        }

        var_08 = maps\mp\_utility::getpersstat("headshots");
        var_09 = getmatchdata("players", self.var_2418, "playermatchtime_total_ms");
        var_0A = getmatchdata("players", self.var_2418, "total_xp");
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "timestamp", var_04);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "kills", var_05);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "deaths", var_06);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "score", var_07);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "headshots", var_08);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "timeplayed", var_09);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "totalXp", var_0A);
        if(level.gametype == "ctf" || level.gametype == "dom") {
          var_0B = maps\mp\_utility::getpersstat("captures");
          self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "trend", var_03 - 1, "captures", var_0B);
        }

        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "numTrends", var_02);
      }

      updatecombatrecordforplayertrendszombies() {
        var_00 = 5;
        var_01 = var_00 * 2;
        var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "numTrends");
        var_02++;
        var_03 = var_02;
        if(var_02 > var_00) {
          if(var_02 > var_01) {
            var_02 = var_00 + 1;
          }

          var_03 = var_02 - var_00;
        }

        if(isDefined(self.kills)) {
          var_04 = self.kills;
        } else {
          var_04 = 0;
        }

        var_05 = maps\mp\_utility::func_46E7();
        var_06 = 0;
        var_07 = 0;
        var_08 = 0;
        var_09 = getclientmatchdata("alliesScore");
        self setrankedplayerdata(common_scripts\utility::func_46A8(), "combatRecord", "trend", var_03 - 1, "timestamp", var_05);
        self setrankedplayerdata(common_scripts\utility::func_46A8(), "combatRecord", "trend", var_03 - 1, "timeplayed", var_07);
        self setrankedplayerdata(common_scripts\utility::func_46A8(), "combatRecord", "trend", var_03 - 1, "totalXp", var_08);
        self setrankedplayerdata(common_scripts\utility::func_46A8(), "combatRecord", "trend", var_03 - 1, "kills", var_04);
        self setrankedplayerdata(common_scripts\utility::func_46A8(), "combatRecord", "trend", var_03 - 1, "headshots", var_06);
        self setrankedplayerdata(common_scripts\utility::func_46A8(), "combatRecord", "trend", var_03 - 1, "waveReached", var_09);
        self setrankedplayerdata(common_scripts\utility::func_46A8(), "combatRecord", "numTrends", var_02);
      }

      updaterankedplaydata() {
        if(!function_03AF()) {
          return;
        }

        if(isDefined(self.kills)) {
          var_00 = self.kills;
        } else {
          var_00 = 0;
        }

        if(isDefined(self.deaths)) {
          var_01 = self.deaths;
        } else {
          var_01 = 0;
        }

        var_02 = maps\mp\_utility::getpersstat("headshots");
        var_03 = int(getmatchdata("players", self.var_2418, "playermatchtime_total_ms") / 1000);
        var_04 = function_03B5();
        var_05 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "kills");
        var_06 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "deaths");
        var_07 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "headshots");
        var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "timeplayed");
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "kills", var_05 + var_00);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "deaths", var_06 + var_01);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "headshots", var_07 + var_02);
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_04, "timeplayed", var_08 + var_03);
        maps\mp\gametypes\_ranked_play::giverankadvancerewards(var_04);
      }

      updatecombatrecordraiddata() {
        var_00 = maps\mp\_utility::func_46E7();
        func_8651("timeStampLastGame", var_00);
        func_50FB("timePlayed", self.timeplayed["total"]);
        func_50FB("xpEarned", self.pers["summary"]["xp"]);
        if(isDefined(self.score) && self.score > 0) {
          func_50FB("score", self.score);
        }

        if(game["switchedsides"]) {
          var_01 = 0;
          var_02 = 0;
          if(isDefined(self.var_2533)) {
            var_01++;
            var_02--;
          }

          if(isDefined(game["game_one_winner"]) && self.team == game["game_one_winner"] && !didplayerjipgametwo(self)) {
            var_01++;
            var_02--;
          }

          if(common_scripts\utility::func_562E(self.var_5969) && !common_scripts\utility::func_562E(self.pers["recordedLoss"])) {
            var_02 = 0;
          }

          if(var_01 > 0) {
            func_50FB("wins", var_01);
          }

          if(var_02 != 0) {
            func_50FB("losses", var_02);
          }

          if(didplayerjipgametwo(self)) {
            func_50FB("numMatches", 1);
          }
        } else {
          func_50FB("numMatches", 2);
          if(!common_scripts\utility::func_562E(self.var_5969)) {
            func_50FB("losses", 2);
          }
        }

        var_03 = level.gametype;
        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          var_03 = var_03 + "_hc";
        }

        var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_03, "timeStampFirstGame");
        if(var_04 == 0) {
          func_8651("timeStampFirstGame", var_00);
        }
      }

      func_A0F9() {
        if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
          return;
        }

        var_00 = maps\mp\_utility::func_46E7();
        func_8651("timeStampLastGame", var_00);
        func_50FB("numMatches", 1);
        func_50FB("timePlayed", self.timeplayed["total"]);
        func_50FB("kills", self.kills);
        func_50FB("deaths", self.deaths);
        func_50FB("xpEarned", self.pers["summary"]["xp"]);
        if(isDefined(self.var_2533)) {
          func_50FB("wins", 1);
        }

        if(isDefined(self.var_2532)) {
          func_50FB("ties", 1);
        }

        if(isDefined(self.pers["combatRecordLoss"])) {
          func_50FB("losses", 1);
        }

        if(isDefined(self.score) && self.score > 0) {
          func_50FB("score", self.score);
        }

        var_01 = level.gametype;
        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          var_01 = var_01 + "_hc";
        }

        var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_01, "timeStampFirstGame");
        if(var_02 == 0) {
          func_8651("timeStampFirstGame", var_00);
        }

        if(isDefined(self.pers["badSpawnByAnyMeansCount"])) {
          func_50FE("badSpawnByAnyMeansCount", self.pers["badSpawnByAnyMeansCount"]);
        }

        if(isDefined(self.pers["immediateActionSpawnCount"])) {
          func_50FE("immediateActionSpawnCount", self.pers["immediateActionSpawnCount"]);
        }

        if(isDefined(self.pers["victimSpawnCount"])) {
          func_50FE("victimSpawnCount", self.pers["victimSpawnCount"]);
        }

        if(isDefined(self.pers["causedBadSpawnByAnyMeansCount"])) {
          func_50FE("causedBadSpawnByAnyMeansCount", self.pers["causedBadSpawnByAnyMeansCount"]);
        }

        if(isDefined(self.pers["causedImmediateActionSpawnCount"])) {
          func_50FE("causedImmediateActionSpawnCount", self.pers["causedImmediateActionSpawnCount"]);
        }

        if(isDefined(self.pers["causedVictimSpawnCount"])) {
          func_50FE("causedVictimSpawnCount", self.pers["causedVictimSpawnCount"]);
        }
      }

      func_50FE(param_00, param_01) {
        if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
          return;
        }

        var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), param_00);
        var_02 = var_02 + param_01;
        self setrankedplayerdata(common_scripts\utility::func_46AE(), param_00, var_02);
      }

      func_50FB(param_00, param_01) {
        if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
          return;
        }

        var_02 = level.gametype;
        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          var_02 = var_02 + "_hc";
        }

        var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_02, param_00);
        var_03 = var_03 + param_01;
        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_02, param_00, var_03);
      }

      func_8651(param_00, param_01) {
        if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
          return;
        }

        var_02 = level.gametype;
        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          var_02 = var_02 + "_hc";
        }

        self setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_02, param_00, param_01);
      }

      func_446D(param_00) {
        var_01 = level.gametype;
        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          var_01 = var_01 + "_hc";
        }

        return self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_01, param_00);
      }

      func_8652(param_00, param_01) {
        var_02 = level.gametype;
        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          var_02 = var_02 + "_hc";
        }

        var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_02, param_00);
        if(param_01 > var_03) {
          func_8651(param_00, param_01);
        }
      }

      setcombatrecordstatifgreaterflagmatchdata(param_00, param_01, param_02) {
        var_03 = level.gametype;
        if(isDefined(level.hardcoremode) && level.hardcoremode) {
          var_03 = var_03 + "_hc";
        }

        var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", var_03, param_00);
        if(param_01 > var_04) {
          func_8651(param_00, param_01);
          setmatchdata("players", self.var_2418, param_02, 1);
        }
      }

      func_A0FB(param_00) {
        if(level.gametype == "war" || level.gametype == "dm" || level.gametype == "onevone") {
          func_A0F9();
          var_01 = self.deaths;
          if(var_01 == 0) {
            var_01 = 1;
          }

          var_02 = int(self.kills / var_01) * 1000;
          if(level.gametype == "war" || level.gametype == "dm") {
            var_03 = maps\mp\_utility::getpersstat("headshots");
            func_50FB("headshots", var_03);
            func_50FB("assists", self.assists);
          }

          setcombatrecordstatifgreaterflagmatchdata("mostkills", self.kills, "best_kills");
          setcombatrecordstatifgreaterflagmatchdata("bestkdr", var_02, "best_kdr");
          return;
        }

        if(level.gametype == "ctf") {
          func_A0F9();
          var_04 = maps\mp\_utility::getpersstat("captures");
          var_05 = maps\mp\_utility::getpersstat("returns");
          func_50FB("captures", var_04);
          func_50FB("returns", var_05);
          func_8652("mostcaptures", var_04);
          func_8652("mostreturns", var_05);
          return;
        }

        if(level.gametype == "dom" || level.gametype == "control") {
          func_A0F9();
          var_04 = maps\mp\_utility::getpersstat("captures");
          var_06 = maps\mp\_utility::getpersstat("defends");
          func_50FB("captures", var_04);
          func_50FB("defends", var_06);
          func_8652("mostcaptures", var_04);
          func_8652("mostdefends", var_06);
          return;
        }

        if(level.gametype == "conf") {
          func_A0F9();
          var_07 = maps\mp\_utility::getpersstat("confirmed");
          var_08 = maps\mp\_utility::getpersstat("denied");
          func_50FB("confirms", var_07);
          func_50FB("denies", var_08);
          func_8652("mostconfirms", var_07);
          func_8652("mostdenies", var_08);
          return;
        }

        if(level.gametype == "sd" || level.gametype == "demo") {
          func_A0F9();
          var_09 = maps\mp\_utility::getpersstat("plants");
          var_0A = maps\mp\_utility::getpersstat("defuses");
          var_0B = maps\mp\_utility::getpersstat("destructions");
          func_50FB("plants", var_09);
          func_50FB("defuses", var_0A);
          func_50FB("detonates", var_0B);
          func_8652("mostplants", var_09);
          func_8652("mostdefuses", var_0A);
          func_8652("mostdetonates", var_0B);
          return;
        }

        if(level.gametype == "hp") {
          func_A0F9();
          var_04 = maps\mp\_utility::getpersstat("captures");
          var_06 = maps\mp\_utility::getpersstat("defends");
          var_0C = maps\mp\_utility::getpersstat("time");
          func_50FB("totalHPTime", var_0C);
          func_50FB("captures", var_04);
          func_50FB("defends", var_06);
          func_8652("mostcaptures", var_04);
          func_8652("mostdefends", var_06);
          return;
        }

        if(level.gametype == "sr") {
          func_A0F9();
          var_09 = maps\mp\_utility::getpersstat("plants");
          var_0A = maps\mp\_utility::getpersstat("defuses");
          var_0B = maps\mp\_utility::getpersstat("destructions");
          var_07 = maps\mp\_utility::getpersstat("confirmed");
          var_08 = maps\mp\_utility::getpersstat("denied");
          func_50FB("plants", var_09);
          func_50FB("defuses", var_0A);
          func_50FB("detonates", var_0B);
          func_50FB("confirms", var_07);
          func_50FB("denies", var_08);
          func_8652("mostplants", var_09);
          func_8652("mostdefuses", var_0A);
          func_8652("mostdetonates", var_0B);
          func_8652("mostconfirms", var_07);
          func_8652("mostdenies", var_08);
          return;
        }

        if(level.gametype == "infect") {
          func_A0F9();
          var_0D = maps\mp\_utility::getplayerstat("contagious");
          var_0E = self.kills - var_0D;
          func_50FB("infectedKills", var_0E);
          func_50FB("survivorKills", var_0D);
          func_8652("mostInfectedKills", var_0E);
          func_8652("mostSurvivorKills", var_0D);
          return;
        }

        if(level.gametype == "gun") {
          func_A0F9();
          var_0F = maps\mp\_utility::getplayerstat("levelup");
          var_10 = maps\mp\_utility::getplayerstat("humiliation");
          func_50FB("gunPromotions", var_0F);
          func_50FB("stabs", var_10);
          func_8652("mostGunPromotions", var_0F);
          func_8652("mostStabs", var_10);
          return;
        }

        if(level.gametype == "ball") {
          func_A0F9();
          var_11 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
          var_12 = maps\mp\_utility::getplayerstat("killedBallCarrier");
          var_13 = 0;
          if(isDefined(self.var_200D)) {
            var_13 = self.var_200D;
          }

          func_50FB("carries", var_13);
          func_50FB("pointsScored", var_11);
          func_50FB("killedBallCarrier", var_12);
          func_8652("mostPointsScored", var_11);
          func_8652("mostKilledBallCarrier", var_12);
          return;
        }

        if(level.gametype == "twar") {
          func_A0F9();
          var_04 = maps\mp\_utility::getpersstat("captures");
          var_14 = maps\mp\_utility::getplayerstat("kill_while_capture");
          func_50FB("captures", var_04);
          func_50FB("killWhileCaptures", var_14);
          func_8652("mostCaptures", var_04);
          func_8652("mostKillWhileCaptures", var_14);
          return;
        }

        if(level.gametype == "lockdown") {
          func_A0F9();
          var_04 = maps\mp\_utility::getpersstat("captures");
          var_06 = maps\mp\_utility::getpersstat("defends");
          func_50FB("captures", var_04);
          func_50FB("defends", var_06);
          func_8652("mostcaptures", var_04);
          func_8652("mostdefends", var_06);
          return;
        }

        if(level.gametype == "blades") {
          func_A0F9();
          var_15 = maps\mp\_utility::getpersstat("throwingKnifeKills");
          var_16 = maps\mp\_utility::getpersstat("meleeKnifeKills");
          func_50FB("throwingKnifeKills", var_15);
          func_50FB("meleeKnifeKills", var_16);
          func_8652("mostThrowingKnifeKillss", var_15);
          func_8652("mostMeleeKnifeKills", var_16);
          return;
        }

        if(level.gametype == "scorestreak_training") {
          func_A0F9();
          var_17 = maps\mp\_utility::getpersstat("scorestreaksCalled");
          var_18 = maps\mp\_utility::getpersstat("scorestreaksDowned");
          func_50FB("scorestreaksCalled", var_17);
          func_50FB("scorestreaksDowned", var_18);
          func_8652("mostScorestreaksCalled", var_17);
          func_8652("mostScorestreaksDowned", var_18);
          return;
        }

        if(level.gametype == "raid") {
          updatecombatrecordraiddata();
          func_633D(param_00);
          var_19 = maps\mp\_utility::getpersstat("raidKillz");
          var_06 = maps\mp\_utility::getpersstat("defends");
          var_1A = maps\mp\_utility::getpersstat("constructs");
          var_1B = maps\mp\_utility::getpersstat("destructs");
          func_50FB("kills", var_19);
          func_50FB("defends", var_06);
          func_50FB("constructs", var_1A);
          func_50FB("destructs", var_1B);
          func_8652("mostDefends", var_06);
          func_8652("mostConstructs", var_1A);
          func_8652("mostDestructs", var_1B);
          return;
        }
      }

      func_633D(param_00) {
        if(isDefined(param_00) && !self.team == param_00) {
          return;
        }

        var_01 = func_446D("wins");
        if(var_01 >= 10) {
          return;
        }

        if(!game["switchedsides"] && isDefined(param_00) && self.team == param_00) {
          var_01++;
        }

        if(maps\mp\_utility::rankingenabled() && level.gametype == "raid" && var_01 >= 5) {
          self giveachievement("MP_WAR_5");
        }
      }

      func_A0FA(param_00) {
        if(function_03AF()) {
          updaterankedplaydata();
          return;
        }

        func_A0FC();
        func_A0FB(param_00);
      }

      updatecombatrecordforplayerzombies(param_00) {
        updatecombatrecordforplayertrendszombies();
      }

      func_A0F8(param_00) {
        foreach(var_02 in level.players) {
          if(!isDefined(var_02) || !isDefined(var_02.var_2582) || !var_02.var_2582) {
            continue;
          }

          if(var_02 maps\mp\_utility::rankingenabled()) {
            var_02 func_A0FA(param_00);
          }

          if(!isDefined(level.iszombiegame) && level.iszombiegame) {
            level maps\mp\gametypes\_playerlogic::func_AABB(var_02);
          }

          if(maps\mp\_utility::practiceroundgame()) {
            level maps\mp\gametypes\_playerlogic::func_21DF(var_02);
          }

          if(isDefined(level.iszombiegame) && level.iszombiegame) {
            var_02 updatecombatrecordforplayerzombies(param_00);
          }
        }
      }

      getweaponlevelingtablename() {
        if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
          return "mp/weaponLevelingDivisionsOverhaul.csv";
        }

        return "mp/weaponLeveling.csv";
      }

      func_47C6(param_00, param_01, param_02) {
        if(!isDefined(param_00)) {
          return;
        }

        if(isDefined(level.iszombiegame) && level.iszombiegame) {
          return;
        }

        if(isDefined(level.var_2FAA) && level.var_2FAA) {
          return;
        }

        if(!maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame()) {
          return;
        }

        if(function_03AF()) {
          return;
        }

        if(level.gametype == "gun" || level.gametype == "blades" || level.gametype == "infect" || level.gametype == "prop" || level.gametype == "br" || level.gametype == "aon" || level.gametype == "oitc" || getdvarint("scr_oneShot", 0) == 1) {
          return;
        }

        if(!isDefined(self.var_2319) || !issubstr(self.var_2319, "custom")) {
          return;
        }

        var_03 = maps\mp\_utility::getbaseweaponname(param_00);
        if(maps\mp\_utility::islootweapon(var_03)) {
          var_03 = maps\mp\gametypes\_class::getbasefromlootversion(var_03);
        }

        if(!self isitemunlocked(var_03)) {
          return;
        }

        if(maps\mp\_utility::iskillstreakweapon(var_03)) {
          return;
        }

        if(param_00 == "teslagunmtx_mp") {
          return;
        }

        if(!maps\mp\gametypes\_weapons::func_5795(var_03) && !maps\mp\gametypes\_weapons::func_5756(var_03)) {
          return;
        }

        switch (level.gametype) {
          case "war":
            var_04 = 1;
            break;

          case "dom":
            var_04 = 2;
            break;

          case "undead":
          case "hp":
            var_04 = 3;
            break;

          case "ctf":
            var_04 = 4;
            break;

          case "conf":
            var_04 = 5;
            break;

          case "sd":
            var_04 = 6;
            break;

          case "sr":
            var_04 = 7;
            break;

          case "dm":
            var_04 = 8;
            break;

          case "ball":
            var_04 = 9;
            break;

          case "demo":
            var_04 = 10;
            break;

          case "raid":
            var_04 = 11;
            break;

          case "gun":
            var_04 = 12;
            break;

          case "br":
            var_04 = 13;
            break;

          case "prop":
            var_04 = 14;
            break;

          case "spy":
            var_04 = 15;
            break;

          case "relic":
            var_04 = 16;
            break;

          default:
            var_04 = 1;
            break;
        }

        var_05 = int(tablelookup(getweaponlevelingtablename(), 0, param_01, var_04));
        if(!isDefined(self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_03])) {
          self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_03]["xp"] = 0;
          self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_03]["weaponName"] = var_03;
        }

        self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_03]["xp"] = self.pers["summary"]["weaponXpToScaleWithActiveBoosts"][var_03]["xp"] + var_05;
        if(var_05 > 0) {
          thread func_47C3(param_00, var_05);
        }
      }

      func_47C3(param_00, param_01) {
        var_02 = maps\mp\_utility::getbaseweaponname(param_00);
        if(maps\mp\_utility::islootweapon(var_02)) {
          var_02 = maps\mp\gametypes\_class::getbasefromlootversion(var_02);
        }

        var_03 = tablelookuprownum(getweaponlevelingtablename(), 0, var_02);
        var_04 = int(tablelookupbyrow(getweaponlevelingtablename(), var_03, 1));
        var_05 = int(tablelookupbyrow(getweaponlevelingtablename(), var_03 + var_04, 1));
        var_06 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_02, "level");
        var_06 = var_06 + 1;
        var_07 = var_06;
        var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_02, "experience");
        var_09 = var_08 + param_01;
        var_09 = int(min(var_05, var_09));
        param_01 = var_09 - var_08;
        if(!isDefined(self.pers["weaponsUsed"])) {
          self.pers["weaponsUsed"] = [];
          self.pers["weaponXpEarned"] = [];
        }

        var_0A = 0;
        var_0B = 999;
        for(var_0C = 0; var_0C < self.pers["weaponsUsed"].size; var_0C++) {
          if(self.pers["weaponsUsed"][var_0C] == var_02) {
            var_0A = 1;
            var_0B = var_0C;
          }
        }

        if(var_0A) {
          self.pers["weaponXpEarned"][var_0B] = self.pers["weaponXpEarned"][var_0B] + param_01;
        } else {
          self.pers["weaponsUsed"][self.pers["weaponsUsed"].size] = var_02;
          self.pers["weaponXpEarned"][self.pers["weaponXpEarned"].size] = param_01;
        }

        var_0D = 1;
        while(var_0D) {
          var_0D = 0;
          if(var_06 <= var_04) {
            var_0E = var_03 + var_06;
            var_0F = int(tablelookupbyrow(getweaponlevelingtablename(), var_0E, 1));
            if(var_09 >= var_0F) {
              var_10 = int(tablelookupbyrow(getweaponlevelingtablename(), var_0E, 3));
              thread maps\mp\gametypes\_rank::giverankxp("weaponLevel", var_10);
              var_06 = var_06 + 1;
              self setrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_02, "level", var_06 - 1);
              maps\mp\_matchdata::func_5EAF(var_02, "level", 1, param_00);
              var_11 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_02, "timeInUse");
              if(!isDefined(var_11)) {
                var_11 = -1;
              }

              function_00F5("script_mp_rankup_weapon: playerName %s, weaponName %s, oldLevel %d, newLevel %d, xpGain %d, timeInUse %d", self.name, var_02, var_07, var_06, param_01, var_11);
              thread func_A9DE(var_02, var_06);
              if(var_06 > var_04) {
                var_09 = var_0F + 1;
              } else {
                var_0D = 1;
              }
            }

            self setrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_02, "experience", var_09);
            maps\mp\_matchdata::func_5EAF(var_02, "experience", param_01, param_00);
          }
        }
      }

      func_A9DE(param_00, param_01) {
        var_02 = tablelookuprownum("mp/statstable.csv", 2, param_00);
        thread maps\mp\gametypes\_hud_message::func_A9DD("ranked_up_weapon_" + param_00, "", param_01);
      }