/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gamelogic.gsc
********************************************/

onforfeit(var_0) {
  if(isdefined(level.forfeitinprogress)) {
    return;
  }
  level endon("abort_forfeit");
  level thread forfeitwaitforabort();
  level.forfeitinprogress = 1;

  if(!level.teambased && level.players.size > 1)
    wait 10;
  else
    wait 1.05;

  level.forfeit_aborted = 0;
  var_1 = 20.0;
  matchforfeittimer(var_1);
  var_2 = & "";

  if(!isdefined(var_0)) {
    level.finalkillcam_winner = "none";
    var_2 = game["end_reason"]["players_forfeited"];
    var_3 = level.players[0];
  } else if(var_0 == "axis") {
    level.finalkillcam_winner = "axis";
    var_2 = game["end_reason"]["allies_forfeited"];

    if(level.gametype == "infect")
      var_2 = game["end_reason"]["survivors_forfeited"];

    var_3 = "axis";
  } else if(var_0 == "allies") {
    level.finalkillcam_winner = "allies";
    var_2 = game["end_reason"]["axis_forfeited"];

    if(level.gametype == "infect")
      var_2 = game["end_reason"]["infected_forfeited"];

    var_3 = "allies";
  } else if(level.multiteambased && issubstr(var_0, "team_"))
    var_3 = var_0;
  else {
    level.finalkillcam_winner = "none";
    var_3 = "tie";
  }

  level.forcedend = 1;

  if(isplayer(var_3))
    logstring("forfeit, win: " + var_3 getxuid() + "(" + var_3.name + ")");
  else
    logstring("forfeit, win: " + var_3 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

  thread endgame(var_3, var_2);
}

forfeitwaitforabort() {
  level endon("game_ended");
  level waittill("abort_forfeit");
  level.forfeit_aborted = 1;
  setomnvar("ui_match_countdown", 0);
  setomnvar("ui_match_countdown_title", 0);
  setomnvar("ui_match_countdown_toggle", 0);
}

matchforfeittimer_internal(var_0) {
  waittillframeend;
  level endon("match_forfeit_timer_beginning");
  setomnvar("ui_match_countdown_title", 3);
  setomnvar("ui_match_countdown_toggle", 1);

  while (var_0 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod) {
    setomnvar("ui_match_countdown", var_0);
    wait 1;
    var_0--;
  }
}

matchforfeittimer(var_0) {
  level notify("match_forfeit_timer_beginning");
  var_1 = int(var_0);
  matchforfeittimer_internal(var_1);
  setomnvar("ui_match_countdown", 0);
  setomnvar("ui_match_countdown_title", 0);
  setomnvar("ui_match_countdown_toggle", 0);
}

default_ondeadevent(var_0) {
  level.finalkillcam_winner = "none";

  if(var_0 == "allies") {
    logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level.finalkillcam_winner = "axis";
    thread endgame("axis", game["end_reason"]["allies_eliminated"]);
  } else if(var_0 == "axis") {
    logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level.finalkillcam_winner = "allies";
    thread endgame("allies", game["end_reason"]["axis_eliminated"]);
  } else {
    logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    level.finalkillcam_winner = "none";

    if(level.teambased)
      thread endgame("tie", game["end_reason"]["tie"]);
    else
      thread endgame(undefined, game["end_reason"]["tie"]);
  }
}

default_ononeleftevent(var_0) {
  if(level.teambased) {
    var_1 = maps\mp\_utility::getlastlivingplayer(var_0);
    var_1 thread givelastonteamwarning();
  } else {
    var_1 = maps\mp\_utility::getlastlivingplayer();
    logstring("last one alive, win: " + var_1.name);
    level.finalkillcam_winner = "none";
    thread endgame(var_1, game["end_reason"]["enemies_eliminated"]);
  }

  return 1;
}

default_ontimelimit() {
  var_0 = undefined;
  level.finalkillcam_winner = "none";

  if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
      var_0 = "tie";
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.finalkillcam_winner = "axis";
      var_0 = "axis";
    } else {
      level.finalkillcam_winner = "allies";
      var_0 = "allies";
    }

    logstring("time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_0 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

    if(isdefined(var_0))
      logstring("time limit, win: " + var_0.name);
    else
      logstring("time limit, tie");
  }

  thread endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

default_onhalftime(var_0) {
  var_1 = undefined;
  level.finalkillcam_winner = "none";
  thread endgame("halftime", game["end_reason"][var_0]);
}

forceend() {
  if(level.hostforcedend || level.forcedend) {
    return;
  }
  var_0 = undefined;
  level.finalkillcam_winner = "none";

  if(level.teambased) {
    if(isdefined(level.ishorde))
      var_0 = "axis";
    else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
      var_0 = "tie";
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      level.finalkillcam_winner = "axis";
      var_0 = "axis";
    } else {
      level.finalkillcam_winner = "allies";
      var_0 = "allies";
    }

    logstring("host ended game, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_0 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

    if(isdefined(var_0))
      logstring("host ended game, win: " + var_0.name);
    else
      logstring("host ended game, tie");
  }

  level.forcedend = 1;
  level.hostforcedend = 1;

  if(level.splitscreen)
    var_1 = game["end_reason"]["ended_game"];
  else
    var_1 = game["end_reason"]["host_ended_game"];

  setnojiptime(1);
  thread endgame(var_0, var_1);
}

onscorelimit() {
  var_0 = game["end_reason"]["score_limit_reached"];
  var_1 = undefined;
  level.finalkillcam_winner = "none";

  if(level.multiteambased) {
    var_1 = maps\mp\gametypes\_gamescore::getwinningteam();

    if(var_1 == "none")
      var_1 = "tie";
  } else if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
      var_1 = "tie";
    else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_1 = "axis";
      level.finalkillcam_winner = "axis";
    } else {
      var_1 = "allies";
      level.finalkillcam_winner = "allies";
    }

    logstring("scorelimit, win: " + var_1 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_1 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();

    if(isdefined(var_1))
      logstring("scorelimit, win: " + var_1.name);
    else
      logstring("scorelimit, tie");
  }

  thread endgame(var_1, var_0);
}

updategameevents() {
  if(maps\mp\_utility::matchmakinggame() && !level.ingraceperiod && !getdvarint("force_ranking") && (!isdefined(level.disableforfeit) || !level.disableforfeit) && !maps\mp\_utility::invirtuallobby()) {
    if(level.multiteambased) {
      var_0 = 0;
      var_1 = 0;

      for (var_2 = 0; var_2 < level.teamnamelist.size; var_2++) {
        var_0 = var_0 + level.teamcount[level.teamnamelist[var_2]];

        if(level.teamcount[level.teamnamelist[var_2]])
          var_1 = var_1 + 1;
      }

      for (var_2 = 0; var_2 < level.teamnamelist.size; var_2++) {
        if(var_0 == level.teamcount[level.teamnamelist[var_2]] && game["state"] == "playing") {
          thread onforfeit(level.teamnamelist[var_2]);
          return;
        }
      }

      if(var_1 > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    } else if(level.teambased) {
      if(level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing") {
        thread onforfeit("axis");
        return;
      }

      if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing") {
        thread onforfeit("allies");
        return;
      }

      if(level.teamcount["axis"] > 0 && level.teamcount["allies"] > 0) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    } else {
      if(level.teamcount["allies"] + level.teamcount["axis"] == 1 && game["state"] == "playing") {
        thread onforfeit();
        return;
      }

      if(level.teamcount["axis"] + level.teamcount["allies"] > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(isdefined(level.ongameeventlives))
    self[[level.ongameeventlives]]();
  else {
    if(!maps\mp\_utility::getgametypenumlives() && (!isdefined(level.disablespawning) || !level.disablespawning)) {
      return;
    }
    if(!maps\mp\_utility::gamehasstarted()) {
      return;
    }
    if(level.ingraceperiod) {
      return;
    }
    if(level.multiteambased) {
      return;
    }
    if(level.teambased) {
      var_3["allies"] = level.livescount["allies"];
      var_3["axis"] = level.livescount["axis"];

      if(isdefined(level.disablespawning) && level.disablespawning) {
        var_3["allies"] = 0;
        var_3["axis"] = 0;
      }

      if(!level.alivecount["allies"] && !level.alivecount["axis"] && !var_3["allies"] && !var_3["axis"])
        return [
          [level.ondeadevent]
        ]("all");

      if(!level.alivecount["allies"] && !var_3["allies"])
        return [
          [level.ondeadevent]
        ]("allies");

      if(!level.alivecount["axis"] && !var_3["axis"])
        return [
          [level.ondeadevent]
        ]("axis");

      var_4 = level.alivecount["allies"] == 1 && !var_3["allies"];
      var_5 = level.alivecount["axis"] == 1 && !var_3["axis"];

      if((var_4 || var_5) && !isdefined(level.bot_spawn_from_devgui_in_progress)) {
        var_6 = undefined;

        if(var_4 && !isdefined(level.onelefttime["allies"])) {
          level.onelefttime["allies"] = gettime();
          var_7 = [
            [level.ononeleftevent]
          ]("allies");

          if(isdefined(var_7)) {
            if(!isdefined(var_6))
              var_6 = var_7;

            var_6 = var_6 || var_7;
          }
        }

        if(var_5 && !isdefined(level.onelefttime["axis"])) {
          level.onelefttime["axis"] = gettime();
          var_8 = [
            [level.ononeleftevent]
          ]("axis");

          if(isdefined(var_8)) {
            if(!isdefined(var_6))
              var_6 = var_8;

            var_6 = var_6 || var_8;
          }
        }

        return var_6;
        return;
      }

      return;
    }

    if(!level.alivecount["allies"] && !level.alivecount["axis"] && (!level.livescount["allies"] && !level.livescount["axis"]))
      return [
        [level.ondeadevent]
      ]("all");

    var_9 = maps\mp\_utility::getpotentiallivingplayers();

    if(var_9.size == 1)
      return [
        [level.ononeleftevent]
      ]("all");
  }
}

waittillfinalkillcamdone() {
  if(!isdefined(level.finalkillcam_winner))
    return 0;

  level waittill("final_killcam_done");
  return 1;
}

timelimitclock_intermission(var_0) {
  setgameendtime(gettime() + int(var_0 * 1000));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 hide();

  if(var_0 >= 10.0)
    wait(var_0 - 10.0);

  for (;;) {
    var_1 playsound("ui_mp_timer_countdown");
    wait 1.0;
  }
}

waitforplayers(var_0) {
  var_1 = gettime();
  var_2 = var_1 + var_0 * 1000 - 200;

  if(var_0 > 5)
    var_3 = gettime() + getdvarint("min_wait_for_players") * 1000;
  else
    var_3 = 0;

  if(isdefined(level.iszombiegame) && level.iszombiegame)
    var_4 = level.connectingplayers;
  else
    var_4 = level.connectingplayers / 3;

  var_5 = 0;

  for (;;) {
    if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
      break;
    }

    var_6 = level.maxplayercount;
    var_7 = gettime();

    if(var_6 >= var_4 && var_7 > var_3 || var_7 > var_2) {
      break;
    }

    wait 0.05;
  }
}

prematchperiod() {
  level endon("game_ended");
  level.connectingplayers = getdvarint("party_partyPlayerCountNum");

  if(level.prematchperiod > 0) {
    level.waitingforplayers = 1;
    matchstarttimerwaitforplayers();
    level.waitingforplayers = 0;
  } else
    matchstarttimerskip();

  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] maps\mp\_utility::freezecontrolswrapper(0);
    level.players[var_0] enableweapons();
    level.players[var_0] enableammogeneration();
    var_1 = maps\mp\_utility::getobjectivehinttext(level.players[var_0].pers["team"]);

    if(!isdefined(var_1) || !level.players[var_0].hasspawned) {
      continue;
    }
    level.players[var_0] thread maps\mp\gametypes\_hud_message::hintmessage(var_1);
  }

  if(game["state"] != "playing")
    return;
}

graceperiod() {
  level endon("game_ended");

  if(!isdefined(game["clientActive"])) {
    while (getactiveclientcount() == 0)
      wait 0.05;

    game["clientActive"] = 1;
  }

  while (level.ingraceperiod > 0) {
    wait 1.0;
    level.ingraceperiod--;
  }

  level notify("grace_period_ending");
  wait 0.05;
  maps\mp\_utility::gameflagset("graceperiod_done");
  level.ingraceperiod = 0;

  if(game["state"] != "playing") {
    return;
  }
  level thread updategameevents();
}

sethasdonecombat(var_0, var_1) {
  var_0 notify("hasDoneCombat");
  var_0.hasdonecombat = var_1;

  if(!hasdoneanycombat(var_0) && var_1) {
    var_0.pers["hasDoneAnyCombat"] = 1;

    if(isdefined(var_0.pers["hasMatchLoss"]) && var_0.pers["hasMatchLoss"]) {
      return;
    }
    updatelossstats(var_0);
  }
}

hasdoneanycombat(var_0) {
  return isdefined(var_0.pers["hasDoneAnyCombat"]);
}

updatewinstats(var_0) {
  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(!hasdoneanycombat(var_0) && !(level.gametype == "infect") && !maps\mp\_utility::ishodgepodgeph()) {
    return;
  }
  var_0 maps\mp\gametypes\_persistence::statadd("losses", -1);
  var_0 maps\mp\gametypes\_persistence::statadd("wins", 1);
  var_0 maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
  var_0 maps\mp\gametypes\_persistence::statadd("currentWinStreak", 1);
  var_1 = var_0 maps\mp\gametypes\_persistence::statget("currentWinStreak");

  if(var_1 > var_0 maps\mp\gametypes\_persistence::statget("winStreak"))
    var_0 maps\mp\gametypes\_persistence::statset("winStreak", var_1);

  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "win", 1);
  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
  var_0 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_wins");
  var_0.combatrecordwin = 1;
  var_2 = maps\mp\_utility::getmapname();

  if(var_2 == "mp_crash_snow")
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_wc_wins");
  else if(var_2 == "mp_farm_spring")
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_stpatty_wins");
  else if(var_2 == "mp_bog_summer")
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_summer_wins");

  if(level.players.size > 5) {
    superstarchallenge(var_0);

    switch (level.gametype) {
      case "war":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 20)
          var_0 maps\mp\gametypes\_missions::processchallenge("ch_war_crushing");

        break;
      case "hp":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 70) {

        }

        break;
      case "conf":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 15) {

        }

        break;
      case "ball":
        if(game["teamScores"][var_0.team] >= game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] + 7) {

        }

        break;
      case "infect":
        if(var_0.team == "allies") {
          if(game["teamScores"][var_0.team] >= 4) {

          }

          if(game["teamScores"][maps\mp\_utility::getotherteam(var_0.team)] == 1) {

          }
        }

        break;
      case "dm":
        if(isdefined(level.placement["all"][0])) {
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
      case "gun":
        foreach(var_10 in level.players) {
          if(var_0 == var_10) {
            continue;
          }
          if(var_0.score < var_10.score + 5) {
            break;
          }
        }

        break;
      case "twar":
      case "ctf":
        if(game["shut_out"][var_0.team]) {

        }

        break;
    }
  }
}

superstarchallenge(var_0) {
  var_1 = 0;
  var_2 = 9999;

  foreach(var_4 in level.players) {
    if(var_4.kills > var_1)
      var_1 = var_4.kills;

    if(var_4.deaths < var_2)
      var_2 = var_4.deaths;
  }

  if(var_0.kills >= var_1 && var_0.deaths <= var_2 && var_0.kills > 0 && !isai(var_0))
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_superstar");
}

checkgameendchallenges() {
  if(level.gametype == "dom") {
    foreach(var_1 in level.domflags) {
      if(!isdefined(var_1.ownedtheentireround) || !var_1.ownedtheentireround) {
        continue;
      }
      var_2 = var_1 maps\mp\gametypes\_gameobjects::getownerteam();

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

updatelossstats(var_0) {
  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(!hasdoneanycombat(var_0) && !maps\mp\_utility::ishodgepodgeph()) {
    return;
  }
  var_0.pers["hasMatchLoss"] = 1;
  var_0 maps\mp\gametypes\_persistence::statadd("losses", 1);
  var_0 maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
  var_0 maps\mp\gametypes\_persistence::statadd("gamesPlayed", 1);
  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "loss", 1);
}

updatetiestats(var_0) {
  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(!hasdoneanycombat(var_0) && !maps\mp\_utility::ishodgepodgeph()) {
    return;
  }
  var_0 maps\mp\gametypes\_persistence::statadd("losses", -1);
  var_0 maps\mp\gametypes\_persistence::statadd("ties", 1);
  var_0 maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
  var_0 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
  var_0.combatrecordtie = 1;
}

updatewinlossstats(var_0) {
  if(maps\mp\_utility::privatematch()) {
    return;
  }
  if(!isdefined(var_0) || isdefined(var_0) && isstring(var_0) && var_0 == "tie") {
    foreach(var_2 in level.players) {
      if(isdefined(var_2.connectedpostgame)) {
        continue;
      }
      if(statlossprevention(var_2)) {
        updatestatlossprevention(var_2);
        continue;
      }

      if(level.hostforcedend && var_2 ishost()) {
        var_2 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
        continue;
      }

      updatetiestats(var_2);
    }
  } else if(isplayer(var_0)) {
    var_4[0] = var_0;

    if(level.players.size > 5)
      var_4 = maps\mp\gametypes\_gamescore::gethighestscoringplayersarray(3);

    foreach(var_2 in level.players) {
      if(isdefined(var_2.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && var_2 ishost()) {
        var_2 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
        continue;
      }

      if(common_scripts\utility::array_contains(var_4, var_2)) {
        updatewinstats(var_2);
        continue;
      }

      if(statlossprevention(var_2))
        updatestatlossprevention(var_2);
    }
  } else if(isstring(var_0)) {
    foreach(var_2 in level.players) {
      if(isdefined(var_2.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && var_2 ishost()) {
        var_2 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
        continue;
      }

      if(var_2.pers["team"] == var_0) {
        updatewinstats(var_2);
        continue;
      }

      if(statlossprevention(var_2)) {
        updatestatlossprevention(var_2);
        continue;
      }

      var_2 maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
    }
  }

  if(level.players.size > 5) {
    var_4 = maps\mp\gametypes\_gamescore::gethighestscoringplayersarray(3);

    for (var_9 = 0; var_9 < var_4.size; var_9++) {
      if(var_9 == 0)
        var_4[var_9] maps\mp\gametypes\_missions::processchallenge("ch_mvp");

      var_4[var_9] maps\mp\gametypes\_missions::processchallenge("ch_superior");
    }
  }
}

updatestatlossprevention(var_0) {
  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(!hasdoneanycombat(var_0) && !(level.gametype == "infect") && !maps\mp\_utility::ishodgepodgeph()) {
    return;
  }
  var_0 maps\mp\gametypes\_persistence::statadd("losses", -1);
  var_0.displaystatlossui = 1;
}

statlossprevention(var_0) {
  if(!isdefined(var_0.pers["absoluteJoinTime"]) || !isdefined(game["absoluteStartTime"]))
    return 0;

  var_1 = var_0.pers["absoluteJoinTime"] - game["absoluteStartTime"];
  var_2 = 95;

  if(var_1 >= var_2)
    return 1;

  return 0;
}

freezeplayerforroundend(var_0) {
  self endon("disconnect");
  maps\mp\_utility::clearlowermessages();

  if(!isdefined(var_0))
    var_0 = 0.05;

  self closepopupmenu();
  self closeingamemenu();
  wait(var_0);
  maps\mp\_utility::freezecontrolswrapper(1);
}

updatematchbonusscores(var_0) {
  if(!game["timePassed"]) {
    return;
  }
  if(!maps\mp\_utility::matchmakinggame()) {
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
      setwinningteam(var_1);

    foreach(var_4 in level.players) {
      if(isdefined(var_4.connectedpostgame)) {
        continue;
      }
      if(!var_4 maps\mp\_utility::rankingenabled()) {
        continue;
      }
      if(var_4.timeplayed["total"] < 1 || var_4.pers["participation"] < 1) {
        if(level.gametype != "infect" && level.gametype != "sd")
          continue;
      }

      if(level.hostforcedend && var_4 ishost()) {
        continue;
      }
      if(!hasdoneanycombat(var_4) && !(level.gametype == "infect") && !maps\mp\_utility::ishodgepodgeph()) {
        continue;
      }
      var_5 = 0;

      if(var_1 == "tie") {
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
        var_4.didtie = 1;
        var_4.iswinner = 0;
      } else if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
        var_4.iswinner = 1;
      } else if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_2) {
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
        var_4.iswinner = 0;
      }

      var_4.matchbonus = int(var_5);
    }
  } else {
    foreach(var_4 in level.players) {
      if(isdefined(var_4.connectedpostgame)) {
        continue;
      }
      if(!var_4 maps\mp\_utility::rankingenabled()) {
        continue;
      }
      if(var_4.timeplayed["total"] < 1 || var_4.pers["participation"] < 1) {
        continue;
      }
      if(level.hostforcedend && var_4 ishost()) {
        continue;
      }
      if(!hasdoneanycombat(var_4)) {
        continue;
      }
      var_4.iswinner = 0;

      for (var_8 = 0; var_8 < min(level.placement["all"].size, 3); var_8++) {
        if(level.placement["all"][var_8] != var_4) {
          continue;
        }
        var_4.iswinner = 1;
      }

      var_5 = 0;

      if(var_4.iswinner)
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
      else
        var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");

      var_4.matchbonus = int(var_5);
    }
  }

  foreach(var_4 in level.players) {
    if(!isdefined(var_4)) {
      continue;
    }
    if(!isdefined(var_4.iswinner)) {
      continue;
    }
    var_11 = "loss";

    if(var_4.iswinner)
      var_11 = "win";

    if(isdefined(var_4.didtie) && var_4.didtie)
      var_11 = "tie";

    var_4 thread givematchbonus(var_11, var_4.matchbonus);
  }
}

givematchbonus(var_0, var_1) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  maps\mp\gametypes\_rank::giverankxp(var_0, var_1);
  maps\mp\_utility::logxpgains();
}

setplayerrank(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(var_0.kills) || !isdefined(var_0.deaths)) {
    return;
  }
  var_1 = var_0.timeplayed["total"] / 60.0;
  var_2 = var_1 >= 2.0;

  if(!var_2) {
    return;
  }
  var_3 = var_0.kills;
  var_4 = var_0.deaths;
  var_5 = float(var_3 - var_4) * 1000.0;
  var_6 = int(var_5 / var_1);
  setplayerteamrank(var_0, var_0.clientid, var_6);
}

setxenonranks(var_0) {
  var_1 = level.players;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    setplayerrank(var_3);
  }
}

checktimelimit(var_0) {
  if(isdefined(level.timelimitoverride) && level.timelimitoverride) {
    return;
  }
  if(game["state"] != "playing") {
    setgameendtime(0);
    return;
  }

  if(maps\mp\_utility::gettimelimit() <= 0) {
    if(isdefined(level.starttime))
      setgameendtime(level.starttime);
    else
      setgameendtime(0);

    return;
  }

  if(!maps\mp\_utility::gameflag("prematch_done")) {
    setgameendtime(0);
    return;
  }

  if(!isdefined(level.starttime)) {
    return;
  }
  if(maps\mp\_utility::gettimepassedpercentage() > level.timepercentagecutoff)
    setnojiptime(1);

  var_1 = gettimeremaining();

  if(maps\mp\_utility::gethalftime() && game["status"] != "halftime")
    setgameendtime(gettime() + (int(var_1) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)));
  else
    setgameendtime(gettime() + int(var_1));

  if(var_1 > 0) {
    if(maps\mp\_utility::gethalftime() && checkhalftime(var_0))
      [[level.onhalftime]]("time_limit_reached");

    return;
  }

  [[level.ontimelimit]]();
}

checkhalftimescore() {
  if(!level.halftimeonscorelimit)
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

      if(level.halftimeonscorelimitsettimetobeat)
        game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();

      return 1;
    }
  }

  return 0;
}

checkhalftime(var_0) {
  if(!level.teambased)
    return 0;

  if(game["status"] != "normal")
    return 0;

  if(maps\mp\_utility::gettimelimit()) {
    var_1 = maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5;

    if(maps\mp\_utility::gettimepassed() >= var_1 && var_0 < var_1 && var_0 > 0) {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
      return 1;
    }
  }

  return 0;
}

gettimeremaining() {
  var_0 = maps\mp\_utility::gettimepassed();
  var_1 = maps\mp\_utility::gettimelimit();
  var_2 = var_1 * 60 * 1000;

  if(maps\mp\_utility::gethalftime() && game["status"] == "halftime" && isdefined(level.firsthalftimepassed)) {
    var_3 = var_2 * 0.5;

    if(level.firsthalftimepassed < var_3) {
      if(level.halftimeonscorelimit && level.halftimeonscorelimitsettimetobeat)
        var_0 = var_2 - level.firsthalftimepassed + (var_0 - level.firsthalftimepassed);
      else
        var_0 = var_0 + (var_3 - level.firsthalftimepassed);
    }
  }

  return var_2 - var_0;
}

checkteamscorelimitsoon(var_0) {
  if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::isobjectivebased()) {
    return;
  }
  if(isdefined(level.scorelimitoverride) && level.scorelimitoverride) {
    return;
  }
  if(level.gametype == "conf") {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(maps\mp\_utility::ishodgepodgemm()) {
    return;
  }
  if(maps\mp\_utility::gettimepassed() < 60000) {
    return;
  }
  var_1 = estimatedtimetillscorelimit(var_0);

  if(var_1 < 2)
    level notify("match_ending_soon", "score");
}

checkplayerscorelimitsoon() {
  if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::isobjectivebased()) {
    return;
  }
  if(level.teambased) {
    return;
  }
  if(maps\mp\_utility::gettimepassed() < 60000) {
    return;
  }
  var_0 = estimatedtimetillscorelimit();
  var_1 = 2;

  if(level.gametype == "gun")
    var_1 = 1;

  if(var_0 < var_1)
    level notify("match_ending_soon", "score");
}

checkscorelimit() {
  if(maps\mp\_utility::isobjectivebased()) {
    return;
  }
  if(isdefined(level.scorelimitoverride) && level.scorelimitoverride) {
    return;
  }
  if(game["state"] != "playing") {
    return;
  }
  if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0) {
    return;
  }
  if(maps\mp\_utility::is_true(level.checkscorelimitonframeend)) {
    self notify("checkScoreLimit");
    self endon("checkScoreLimit");
    waittillframeend;
  }

  if(maps\mp\_utility::gethalftime() && checkhalftimescore())
    return [
      [level.onhalftime]
    ]("score_limit_reached");
  else if(level.multiteambased) {
    var_0 = 0;

    for (var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
      if(game["teamScores"][level.teamnamelist[var_1]] >= maps\mp\_utility::getwatcheddvar("scorelimit"))
        var_0 = 1;
    }

    if(!var_0)
      return;
  } else if(level.teambased) {
    if(game["teamScores"]["allies"] < maps\mp\_utility::getwatcheddvar("scorelimit") && game["teamScores"]["axis"] < maps\mp\_utility::getwatcheddvar("scorelimit"))
      return;
  } else {
    if(!isplayer(self)) {
      return;
    }
    var_2 = maps\mp\_utility::getwatcheddvar("scorelimit");

    if(var_2 != 0) {
      var_3 = self.score / var_2 * 100;

      if(var_3 > level.scorepercentagecutoff)
        setnojipscore(1);
    }

    if(self.score < var_2)
      return;
  }

  onscorelimit();
}

updategametypedvars() {
  level endon("game_ended");

  while (game["state"] == "playing") {
    if(isdefined(level.starttime)) {
      if(gettimeremaining() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

matchstarttimerwaitforplayers() {
  level endon("devgui_end_graceperiod");
  setomnvar("ui_match_countdown_title", 6);
  setomnvar("ui_match_countdown_toggle", 0);

  if(level.currentgen)
    setomnvar("ui_cg_world_blur", 1);

  visionsetpostapply("mpIntro", 0);
  waitforplayers(level.prematchperiod);

  if(level.prematchperiodend > 0 && !isdefined(level.hostmigrationtimer))
    matchstarttimer(level.prematchperiodend);
  else
    setomnvar("ui_match_countdown_title", 0);
}

matchstarttimer_internal(var_0) {
  waittillframeend;
  level endon("match_start_timer_beginning");
  setomnvar("ui_match_countdown_title", 1);
  setomnvar("ui_match_countdown_toggle", 1);

  while (var_0 > 0 && !level.gameended) {
    setomnvar("ui_match_countdown", var_0);
    var_0--;

    if(level.currentgen)
      setomnvar("ui_cg_world_blur", 1);

    wait 1;
  }

  if(level.currentgen)
    setomnvar("ui_cg_world_blur_fade_out", 1);

  if(!maps\mp\_utility::privatematch() && !maps\mp\_utility::is_true(level.ishorde) && !maps\mp\_utility::is_true(level.iszombiegame)) {
    if(level.xpscale > 1) {
      foreach(var_2 in level.players)
      var_2 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
    } else if(level.xpscalewithparty > 1) {
      foreach(var_2 in level.players) {
        if(maps\mp\_utility::is_true(var_2.inpartywithotherplayers))
          var_2 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
      }
    }
  }

  setomnvar("ui_match_countdown_toggle", 0);
  setomnvar("ui_match_countdown", 0);
  setomnvar("ui_match_countdown_title", 0);
}

matchstarting() {
  setomnvar("ui_match_countdown_title", 2);
  level endon("match_forfeit_timer_beginning");
  wait 1.5;
  setomnvar("ui_match_countdown_title", 0);
}

matchstarttimer(var_0) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_1 = int(var_0);
  childthread matchstartvisionfadeout(var_1);

  if(var_1 >= 2)
    matchstarttimer_internal(var_1);
  else {
    if(level.currentgen)
      setomnvar("ui_cg_world_blur_fade_out", 1);

    if(!maps\mp\_utility::privatematch() && !maps\mp\_utility::is_true(level.ishorde) && !maps\mp\_utility::is_true(level.iszombiegame)) {
      if(level.xpscale > 1) {
        foreach(var_3 in level.players)
        var_3 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
      } else if(level.xpscalewithparty > 1) {
        foreach(var_3 in level.players) {
          if(maps\mp\_utility::is_true(var_3.inpartywithotherplayers))
            var_3 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
        }
      }
    }
  }
}

matchstartvisionfadeout(var_0) {
  if(var_0 > 2)
    wait(var_0 - 2);

  var_1 = 3.0;

  if(var_0 < 2)
    var_1 = 1.0;

  visionsetnaked("", var_1);
  visionsetpostapply("", var_1);
}

matchstarttimerskip() {
  visionsetnaked("", 0);
  visionsetpostapply("", 0);
}

calculateroundswitchfortiebreakerround() {
  var_0 = getbetterteam();
  var_1 = 0;

  if(isdefined(game["attackerWinCount"]))
    var_1 = game["attackerWinCount"];

  var_2 = 0;

  if(isdefined(game["defenderWinCount"]))
    var_2 = game["defenderWinCount"];

  if(var_1 > 0 || var_2 > 0) {
    if(var_1 > var_2) {
      if(var_0 != game["attackers"])
        game["switchedsides"] = !game["switchedsides"];
    } else if(var_2 > var_1) {
      if(var_0 != game["defenders"])
        game["switchedsides"] = !game["switchedsides"];
    } else if(var_0 != game["defenders"])
      game["switchedsides"] = !game["switchedsides"];
  } else if(var_0 != game["defenders"])
    game["switchedsides"] = !game["switchedsides"];
}

onroundswitch() {
  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  var_0 = maps\mp\_utility::getwatcheddvar("winlimit");

  if(game["roundsWon"]["allies"] == var_0 - 1 && game["roundsWon"]["axis"] == var_0 - 1) {
    calculateroundswitchfortiebreakerround();
    level.halftimetype = "overtime";

    if(var_0 > 1)
      game["tiebreaker"] = 1;

    game["dynamicEvent_Overtime"] = 1;
  } else {
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
  }
}

checkroundswitch() {
  if(!level.teambased)
    return 0;

  if(!isdefined(level.roundswitch) || !level.roundswitch)
    return 0;

  if(game["roundsPlayed"] % level.roundswitch == 0) {
    onroundswitch();
    return 1;
  }

  return 0;
}

timeuntilroundend() {
  if(level.gameended) {
    var_0 = (gettime() - level.gameendtime) / 1000;
    var_1 = level.postroundtime - var_0;

    if(var_1 < 0)
      return 0;

    return var_1;
  }

  if(maps\mp\_utility::gettimelimit() <= 0)
    return undefined;

  if(!isdefined(level.starttime))
    return undefined;

  var_2 = maps\mp\_utility::gettimelimit();
  var_0 = (gettime() - level.starttime) / 1000;
  var_1 = maps\mp\_utility::gettimelimit() * 60 - var_0;

  if(isdefined(level.timepaused))
    var_1 = var_1 + level.timepaused;

  return var_1 + level.postroundtime;
}

freegameplayhudelems() {
  if(isdefined(self.perkicon)) {
    if(isdefined(self.perkicon[0])) {
      self.perkicon[0] maps\mp\gametypes\_hud_util::destroyelem();
      self.perkname[0] maps\mp\gametypes\_hud_util::destroyelem();
    }

    if(isdefined(self.perkicon[1])) {
      self.perkicon[1] maps\mp\gametypes\_hud_util::destroyelem();
      self.perkname[1] maps\mp\gametypes\_hud_util::destroyelem();
    }

    if(isdefined(self.perkicon[2])) {
      self.perkicon[2] maps\mp\gametypes\_hud_util::destroyelem();
      self.perkname[2] maps\mp\gametypes\_hud_util::destroyelem();
    }
  }

  self notify("perks_hidden");
  self.lowermessage maps\mp\gametypes\_hud_util::destroyelem();
  self.lowertimer maps\mp\gametypes\_hud_util::destroyelem();

  if(isdefined(self.proxbar))
    self.proxbar maps\mp\gametypes\_hud_util::destroyelem();

  if(isdefined(self.proxbartext))
    self.proxbartext maps\mp\gametypes\_hud_util::destroyelem();
}

gethostplayer() {
  var_0 = getentarray("player", "classname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost())
      return var_0[var_1];
  }
}

hostidledout() {
  var_0 = gethostplayer();

  if(isdefined(var_0) && !var_0.hasspawned && !isdefined(var_0.selectedclass))
    return 1;

  return 0;
}

roundendwait(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 maps\mp\gametypes\_damage::streamfinalkillcam();

  waitforsplashesdone();

  if(!var_1) {
    wait(var_0);
    var_5 = level.players;

    foreach(var_3 in var_5)
    var_3 setclientomnvar("ui_round_end", 0);

    level notify("round_end_finished");
    return;
  }

  wait(var_0 / 2);
  level notify("give_match_bonus");
  wait(var_0 / 2);
  waitforsplashesdone();
  var_5 = level.players;

  foreach(var_3 in var_5)
  var_3 setclientomnvar("ui_round_end", 0);

  level notify("round_end_finished");
}

waitforsplashesdone() {
  var_0 = 15;
  var_1 = gettime() + var_0 * 1000;
  var_2 = 0;

  while (!var_2 && gettime() < var_1) {
    wait 0.5;
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!var_5 maps\mp\gametypes\_hud_message::isdoingsplash()) {
        continue;
      }
      var_2 = 0;
      break;
    }
  }
}

roundenddof(var_0) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

callback_startgametype() {
  maps\mp\_load::main();
  maps\mp\_utility::levelflaginit("round_over", 0);
  maps\mp\_utility::levelflaginit("game_over", 0);
  maps\mp\_utility::levelflaginit("block_notifies", 0);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
  level.postgamenotifies = 0;
  level.intermission = 0;
  setdvar("bg_compassShowEnemies", getdvar("scr_game_forceuav"));

  if(!isdefined(game["gamestarted"])) {
    game["clientid"] = 0;
    var_0 = getmapcustom("allieschar");

    if(!isdefined(var_0) || var_0 == "") {
      if(!isdefined(game["allies"]))
        var_0 = "marines";
      else
        var_0 = game["allies"];
    }

    var_1 = getmapcustom("axischar");

    if(!isdefined(var_1) || var_1 == "") {
      if(!isdefined(game["axis"]))
        var_1 = "opfor";
      else
        var_1 = game["axis"];
    }

    if(level.multiteambased) {
      var_2 = getmapcustom("allieschar");

      if(!isdefined(var_2) || var_2 == "")
        var_2 = "delta_multicam";

      for (var_3 = 0; var_3 < level.teamnamelist.size; var_3++)
        game[level.teamnamelist[var_3]] = var_2;
    }

    game["allies"] = var_0;
    game["axis"] = var_1;

    if(!isdefined(game["attackers"]) || !isdefined(game["defenders"]))
      thread common_scripts\utility::error("No attackers or defenders team defined in level .gsc.");

    if(!isdefined(game["attackers"]))
      game["attackers"] = "allies";

    if(!isdefined(game["defenders"]))
      game["defenders"] = "axis";

    if(!isdefined(game["state"]))
      game["state"] = "playing";

    if(level.teambased) {
      game["strings"]["waiting_for_teams"] = & "MP_WAITING_FOR_TEAMS";
      game["strings"]["opponent_forfeiting_in"] = & "MP_OPPONENT_FORFEITING_IN";
    } else {
      game["strings"]["waiting_for_teams"] = & "MP_WAITING_FOR_MORE_PLAYERS";
      game["strings"]["opponent_forfeiting_in"] = & "MP_OPPONENT_FORFEITING_IN";
    }

    game["strings"]["press_to_spawn"] = & "PLATFORM_PRESS_TO_SPAWN";
    game["strings"]["match_starting_in"] = & "MP_MATCH_STARTING_IN";
    game["strings"]["match_resuming_in"] = & "MP_MATCH_RESUMING_IN";
    game["strings"]["waiting_for_players"] = & "MP_WAITING_FOR_PLAYERS";
    game["strings"]["spawn_tag_wait"] = & "MP_SPAWN_TAG_WAIT";
    game["strings"]["spawn_next_round"] = & "MP_SPAWN_NEXT_ROUND";
    game["strings"]["waiting_to_spawn"] = & "MP_WAITING_TO_SPAWN";
    game["strings"]["match_starting"] = & "MP_MATCH_STARTING";
    game["strings"]["change_team"] = & "MP_CHANGE_TEAM_NEXT_SPAWN";
    game["strings"]["change_team_cancel"] = & "MP_CHANGE_TEAM_CANCEL";
    game["strings"]["change_team_wait"] = & "MP_CHANGE_TEAM_WAIT";
    game["strings"]["change_class"] = & "MP_CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["change_class_cancel"] = & "MP_CHANGE_CLASS_CANCEL";
    game["strings"]["change_class_wait"] = & "MP_CHANGE_CLASS_WAIT";
    game["strings"]["last_stand"] = & "MPUI_LAST_STAND";
    game["strings"]["final_stand"] = & "MPUI_FINAL_STAND";
    game["strings"]["cowards_way"] = & "PLATFORM_COWARDS_WAY_OUT";
    game["strings"]["tie"] = & "MP_MATCH_TIE";
    game["colors"]["blue"] = (0.25, 0.25, 0.75);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["white"] = (1, 1, 1);
    game["colors"]["black"] = (0, 0, 0);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0);
    game["colors"]["orange"] = (1, 0.45, 0);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);
    game["strings"]["allies_name"] = maps\mp\gametypes\_teams::getteamname("allies");
    game["icons"]["allies"] = maps\mp\gametypes\_teams::getteamicon("allies");
    game["colors"]["allies"] = maps\mp\gametypes\_teams::getteamcolor("allies");
    game["strings"]["axis_name"] = maps\mp\gametypes\_teams::getteamname("axis");
    game["icons"]["axis"] = maps\mp\gametypes\_teams::getteamicon("axis");
    game["colors"]["axis"] = maps\mp\gametypes\_teams::getteamcolor("axis");

    if(game["colors"]["allies"] == (0, 0, 0))
      game["colors"]["allies"] = (0.5, 0.5, 0.5);

    if(game["colors"]["axis"] == (0, 0, 0))
      game["colors"]["axis"] = (0.5, 0.5, 0.5);

    [
      [level.onprecachegametype]
    ]();
    setdvarifuninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        if(isdedicatedserver())
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod_ds");
        else
          level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod");

        level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "matchstarttime");
      }
    } else {
      if(isdedicatedserver())
        level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime_ds");
      else
        level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime");

      level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "matchstarttime");
    }
  } else {
    setdvarifuninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        level.prematchperiod = 5;
        level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "roundstarttime");
      }
    } else {
      level.prematchperiod = 5;
      level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "roundstarttime");
    }
  }

  if(!isdefined(game["status"]))
    game["status"] = "normal";

  if(game["status"] != "overtime" && game["status"] != "halftime" && game["status"] != "overtime_halftime") {
    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;

    if(level.multiteambased) {
      for (var_3 = 0; var_3 < level.teamnamelist.size; var_3++)
        game["teamScores"][level.teamnamelist[var_3]] = 0;
    }
  }

  if(!isdefined(game["timePassed"]))
    game["timePassed"] = 0;

  if(!isdefined(game["roundsPlayed"]))
    game["roundsPlayed"] = 0;

  setomnvar("ui_current_round", game["roundsPlayed"] + 1);

  if(!isdefined(game["roundsWon"]))
    game["roundsWon"] = [];

  if(level.teambased) {
    if(!isdefined(game["roundsWon"]["axis"]))
      game["roundsWon"]["axis"] = 0;

    if(!isdefined(game["roundsWon"]["allies"]))
      game["roundsWon"]["allies"] = 0;

    if(level.multiteambased) {
      for (var_3 = 0; var_3 < level.teamnamelist.size; var_3++) {
        if(!isdefined(game["roundsWon"][level.teamnamelist[var_3]]))
          game["roundsWon"][level.teamnamelist[var_3]] = 0;
      }
    }
  }

  level.gameended = 0;
  level.forcedend = 0;
  level.hostforcedend = 0;
  level.hardcoremode = getdvarint("g_hardcore");

  if(level.hardcoremode)
    logstring("game mode: hardcore");

  level.oldschool = getdvarint("g_oldschool");

  if(level.oldschool)
    logstring("game mode: oldschool");

  level.diehardmode = getdvarint("scr_diehard");

  if(!level.teambased)
    level.diehardmode = 0;

  if(level.diehardmode)
    logstring("game mode: diehard");

  level.killstreakrewards = getdvarint("scr_game_hardpoints");

  if(!isdefined(level.iszombiegame))
    level.iszombiegame = 0;

  level.usestartspawns = 1;
  level.objectivepointsmod = 1;
  level.baseplayermovescale = 1;
  level.maxallowedteamkills = 2;
  thread maps\mp\gametypes\_hodgepodge::init();
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
  thread maps\mp\gametypes\_spawnlogic::init();
  thread maps\mp\gametypes\_oldschool::init();
  thread maps\mp\gametypes\_battlechatter_mp::init();
  thread maps\mp\gametypes\_music_and_dialog::init();
  thread maps\mp\_matchdata::init();
  thread maps\mp\_awards::init();
  thread maps\mp\_skill::init();
  thread maps\mp\_areas::init();
  thread maps\mp\perks\_perks::init();
  thread maps\mp\_events::init();
  thread maps\mp\gametypes\_damage::initfinalkillcam();
  thread maps\mp\_snd_common_mp::init();
  thread maps\mp\_utility::buildattachmentmaps();

  if(level.teambased)
    thread maps\mp\gametypes\_friendicons::init();

  thread maps\mp\gametypes\_hud_message::init();
  thread maps\mp\gametypes\_divisions::init();
  thread maps\mp\gametypes\_hardpoints::init();

  foreach(var_5 in game["strings"])
  precachestring(var_5);

  game["gamestarted"] = 1;

  if(!isdefined(game["absoluteStartTime"]))
    game["absoluteStartTime"] = getsystemtime();

  level.maxplayercount = 0;
  level.wavedelay["allies"] = 0;
  level.wavedelay["axis"] = 0;
  level.lastwave["allies"] = 0;
  level.lastwave["axis"] = 0;
  level.waveplayerspawnindex["allies"] = 0;
  level.waveplayerspawnindex["axis"] = 0;
  level.aliveplayers["allies"] = [];
  level.aliveplayers["axis"] = [];
  level.activeplayers = [];

  if(level.multiteambased) {
    for (var_3 = 0; var_3 < level.teamnamelist.size; var_3++) {
      level._wavedelay[level.teamnamelist[var_3]] = 0;
      level._lastwave[level.teamnamelist[var_3]] = 0;
      level._waveplayerspawnindex[level.teamnamelist[var_3]] = 0;
      level._aliveplayers[level.teamnamelist[var_3]] = [];
    }
  }

  setdvar("ui_scorelimit", 0);
  setdvar("ui_allow_teamchange", 1);

  if(maps\mp\_utility::getgametypenumlives())
    setdvar("g_deadChat", 0);
  else
    setdvar("g_deadChat", 1);

  var_7 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay");

  if(var_7 > 0) {
    level.wavedelay["allies"] = var_7;
    level.wavedelay["axis"] = var_7;
    level.lastwave["allies"] = 0;
    level.lastwave["axis"] = 0;

    if(level.multiteambased) {
      for (var_3 = 0; var_3 < level.teamnamelist.size; var_3++) {
        level._wavedelay[level.teamnamelist[var_3]] = var_7;
        level._lastwave[level.teamnamelist[var_3]] = 0;
      }
    }

    level thread wavespawntimer();
  }

  maps\mp\_utility::gameflaginit("prematch_done", 0);
  level.graceperiod = 15;
  level.ingraceperiod = level.graceperiod;
  maps\mp\_utility::gameflaginit("graceperiod_done", 0);
  level.roundenddelay = 4;
  level.halftimeroundenddelay = 4;
  level.noragdollents = getentarray("noragdoll", "targetname");

  if(level.teambased) {
    maps\mp\gametypes\_gamescore::updateteamscore("axis");
    maps\mp\gametypes\_gamescore::updateteamscore("allies");

    if(level.multiteambased) {
      for (var_3 = 0; var_3 < level.teamnamelist.size; var_3++)
        maps\mp\gametypes\_gamescore::updateteamscore(level.teamnamelist[var_3]);
    }
  } else
    thread maps\mp\gametypes\_gamescore::initialdmscoreupdate();

  thread updateuiscorelimit();
  level notify("update_scorelimit");
  [[level.onstartgametype]]();
  level.scorepercentagecutoff = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off", 80);
  level.timepercentagecutoff = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off", 80);

  if(!level.console && (getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server"))
    thread verifydedicatedconfiguration();

  setattackingteam();
  thread startgame();
  level thread maps\mp\_utility::updatewatcheddvars();
  level thread timelimitthread();
  level thread maps\mp\gametypes\_damage::dofinalkillcam();
}

setattackingteam() {
  if(game["attackers"] == "axis")
    var_0 = 1;
  else if(game["attackers"] == "allies")
    var_0 = 2;
  else
    var_0 = 0;

  setomnvar("ui_attacking_team", var_0);
}

callback_codeendgame() {
  endparty();

  if(!level.gameended)
    level thread forceend();
}

verifydedicatedconfiguration() {
  for (;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!getdvarint("xblive_privatematch"))
      exitlevel(0);

    if(getdvar("dedicated") != "dedicated LAN server" && getdvar("dedicated") != "dedicated internet server")
      exitlevel(0);

    wait 5;
  }
}

timelimitthread() {
  level endon("game_ended");
  var_0 = maps\mp\_utility::gettimepassed();

  while (game["state"] == "playing") {
    thread checktimelimit(var_0);
    var_0 = maps\mp\_utility::gettimepassed();

    if(isdefined(level.starttime)) {
      if(gettimeremaining() < 3000) {
        common_scripts\utility::waittill_notify_or_timeout("updateTimeLimit", 0.1);
        continue;
      }
    }

    common_scripts\utility::waittill_notify_or_timeout("updateTimeLimit", 1);
  }
}

updateuiscorelimit() {
  for (;;) {
    level common_scripts\utility::waittill_either("update_scorelimit", "update_winlimit");

    if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased()) {
      setdvar("ui_scorelimit", maps\mp\_utility::getwatcheddvar("scorelimit"));
      thread checkscorelimit();
      continue;
    }

    setdvar("ui_scorelimit", maps\mp\_utility::getwatcheddvar("winlimit"));
  }
}

timelimitclock() {
  level endon("game_ended");
  wait 0.05;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 hide();

  while (game["state"] == "playing") {
    if(!level.timerstopped && maps\mp\_utility::gettimelimit()) {
      var_1 = gettimeremaining() / 1000;
      var_2 = int(var_1 + 0.5);
      var_3 = int(maps\mp\_utility::gettimelimit() * 60 * 0.5);

      if(maps\mp\_utility::gethalftime() && var_2 > var_3)
        var_2 = var_2 - var_3;

      if(var_2 >= 30 && var_2 <= 60)
        level notify("match_ending_soon", "time");

      if(var_2 <= 10 || var_2 <= 30 && var_2 % 2 == 0) {
        level notify("match_ending_very_soon");

        if(var_2 == 0) {
          break;
        }

        var_0 playsound("ui_mp_timer_countdown");
      }

      if(var_1 - floor(var_1) >= 0.05)
        wait(var_1 - floor(var_1));
    }

    wait 1.0;
  }
}

gametimer() {
  level endon("game_ended");
  level waittill("prematch_over");
  level.starttime = gettime();
  level.discardtime = 0;
  level.matchdurationstarttime = gettime();

  if(isdefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
    level.firsthalftimepassed = game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  var_0 = gettime();

  while (game["state"] == "playing") {
    if(!level.timerstopped)
      game["timePassed"] = game["timePassed"] + (gettime() - var_0);

    var_0 = gettime();
    wait 1.0;
  }
}

updatetimerpausedness() {
  var_0 = level.timerstoppedforgamemode || isdefined(level.hostmigrationtimer);

  if(!maps\mp\_utility::gameflag("prematch_done"))
    var_0 = 0;

  if(!level.timerstopped && var_0) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
  } else if(level.timerstopped && !var_0) {
    level.timerstopped = 0;
    level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
    level notify("updateTimeLimit");
  }
}

pausetimer() {
  level.timerstoppedforgamemode = 1;
  updatetimerpausedness();
}

resumetimer() {
  level.timerstoppedforgamemode = 0;
  updatetimerpausedness();
}

startgame() {
  thread gametimer();
  level.timerstopped = 0;
  level.timerstoppedforgamemode = 0;

  if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
    thread maps\mp\gametypes\_legacyspawnlogic::spawnperframeupdate();

  setdvar("ui_inprematch", 1);
  prematchperiod();
  maps\mp\_utility::gameflagset("prematch_done");
  level notify("prematch_over");
  setdvar("ui_inprematch", 0);
  level.prematch_done_time = gettime();
  updatetimerpausedness();
  thread timelimitclock();
  thread graceperiod();
  thread maps\mp\gametypes\_missions::roundbegin();
  thread maps\mp\_matchdata::matchstarted();
  var_0 = isdefined(level.ishorde) && level.ishorde;
  var_1 = isdefined(level.iszombiegame) && level.iszombiegame;

  if(var_0 || var_1)
    thread updategameduration();

  if(!maps\mp\_utility::invirtuallobby())
    level thread maps\mp\_utility::gameplayactivewatch();

  lootserviceonstartgame();
}

wavespawntimer() {
  level endon("game_ended");

  while (game["state"] == "playing") {
    var_0 = gettime();

    if(var_0 - level.lastwave["allies"] > level.wavedelay["allies"] * 1000) {
      level notify("wave_respawn_allies");
      level.lastwave["allies"] = var_0;
      level.waveplayerspawnindex["allies"] = 0;
    }

    if(var_0 - level.lastwave["axis"] > level.wavedelay["axis"] * 1000) {
      level notify("wave_respawn_axis");
      level.lastwave["axis"] = var_0;
      level.waveplayerspawnindex["axis"] = 0;
    }

    if(level.multiteambased) {
      for (var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
        if(var_0 - level.lastwave[level.teamnamelist[var_1]] > level._wavedelay[level.teamnamelist[var_1]] * 1000) {
          var_2 = "wave_rewpawn_" + level.teamnamelist[var_1];
          level notify(var_2);
          level.lastwave[level.teamnamelist[var_1]] = var_0;
          level.waveplayerspawnindex[level.teamnamelist[var_1]] = 0;
        }
      }
    }

    wait 0.05;
  }
}

getbetterteam() {
  var_0["allies"] = 0;
  var_0["axis"] = 0;
  var_1["allies"] = 0;
  var_1["axis"] = 0;
  var_2["allies"] = 0;
  var_2["axis"] = 0;

  foreach(var_4 in level.players) {
    var_5 = var_4.pers["team"];

    if(isdefined(var_5) && (var_5 == "allies" || var_5 == "axis")) {
      var_0[var_5] = var_0[var_5] + var_4.score;
      var_1[var_5] = var_1[var_5] + var_4.kills;
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

rankedmatchupdates(var_0) {
  if(!maps\mp\_utility::waslastround()) {
    return;
  }
  var_0 = getgamewinner(var_0, 0);

  if(maps\mp\_utility::matchmakinggame()) {
    setxenonranks();

    if(hostidledout()) {
      level.hostforcedend = 1;
      logstring("host idled out");
      endlobby();
    }

    updatematchbonusscores(var_0);
  }

  updatewinlossstats(var_0);
}

outcomenotifytoallplayers(var_0, var_1, var_2, var_3) {
  if(isdefined(level.onoutcomenotify))
    [[level.onoutcomenotify]](var_0, var_1, var_2, var_3);

  foreach(var_5 in level.players) {
    if(isdefined(var_5.connectedpostgame)) {
      continue;
    }
    if(isdefined(var_5.displaystatlossui) && var_5.displaystatlossui)
      var_6 = game["end_reason"]["stat_loss_prevention"];
    else
      var_6 = var_2;

    if(level.teambased) {
      var_5 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_0, var_1, var_6, var_3);
      continue;
    }

    var_5 thread maps\mp\gametypes\_hud_message::outcomenotify(var_0, var_6);
  }
}

displayroundend(var_0, var_1) {
  outcomenotifytoallplayers(var_0, 1, var_1);

  if(!maps\mp\_utility::waslastround())
    level notify("round_win", var_0);

  if(maps\mp\_utility::waslastround())
    roundendwait(level.roundenddelay, 0);
  else
    roundendwait(level.roundenddelay, 1);
}

displaygameend(var_0, var_1) {
  outcomenotifytoallplayers(var_0, 0, var_1, 1);
  level notify("game_win", var_0);
  roundendwait(level.postroundtime, 1);
}

displayroundswitch(var_0) {
  var_1 = level.halftimetype;

  if(var_1 == "halftime") {
    if(maps\mp\_utility::getwatcheddvar("roundlimit")) {
      if(game["roundsPlayed"] * 2 == maps\mp\_utility::getwatcheddvar("roundlimit"))
        var_1 = "halftime";
      else
        var_1 = "intermission";
    } else if(maps\mp\_utility::getwatcheddvar("winlimit")) {
      if(game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
        var_1 = "halftime";
      else
        var_1 = "intermission";
    } else
      var_1 = "intermission";
  }

  level notify("round_switch", var_1);
  var_2 = 0;

  if(var_0 != game["switchedsides"])
    var_2 = game["end_reason"]["switching_sides"];

  outcomenotifytoallplayers(var_1, 1, var_2);
  roundendwait(level.halftimeroundenddelay, 0);
}

arraytostring(var_0) {
  var_1 = "";

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];

    if(var_2 != var_0.size - 1)
      var_1 = var_1 + ",";
  }

  return var_1;
}

recordendgamecomscoreevent(var_0) {
  var_1 = level.players;

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    recordendgamecomscoreeventforplayer(var_1[var_2], var_0);
}

recordendgamecomscoreeventforplayer(var_0, var_1) {
  var_2 = var_1;

  if(isdefined(var_0.team) && var_1 == var_0.team)
    var_2 = "win";
  else if(var_1 == "allies" || var_1 == "axis")
    var_2 = "lose";

  var_3 = "";
  var_4 = "";
  var_5 = "";
  var_6 = "";
  var_7 = "";
  var_8 = "";
  var_9 = "";
  var_10 = "";
  var_11 = var_0.team;
  var_12 = var_0.class;

  if(isdefined(var_11) && isdefined(var_12) && var_12 != "") {
    var_13 = var_0 maps\mp\gametypes\_class::getloadout(var_11, var_12, undefined, undefined, 1);
    var_3 = var_13.primary;
    var_4 = var_13.primaryattachkit;
    var_5 = var_13.secondary;
    var_6 = var_13.secondaryattachkit;
    var_7 = var_13.equipment;
    var_8 = var_13.offhand;
    var_9 = arraytostring(var_13.perks);
    var_10 = "";
  }

  _func_2FC("end_match");
  _func_2FD("game_variant", "mp");
  var_14 = getmatchdata("gametype");
  _func_2FD("game_mode", var_14);
  var_15 = getmatchdata("privateMatch");
  _func_2FD("private_match", var_15);
  var_16 = getmatchdata("map");
  _func_2FD("game_map", var_16);
  _func_2FD("player_xuid", var_0 getxuid());
  var_17 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "kills");
  _func_2FD("match_kills", var_17);
  var_18 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "deaths");
  _func_2FD("match_deaths", var_18);
  var_19 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "totalXp");
  _func_2FD("match_xp", var_19);
  var_20 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "score");
  _func_2FD("match_score", var_20);
  var_21 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "captures");
  _func_2FD("match_captures", var_21);
  var_22 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "defends");
  _func_2FD("match_defends", var_22);
  var_23 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "headshots");
  _func_2FD("match_headshots", var_23);
  var_24 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "plants");
  _func_2FD("match_plants", var_24);
  var_25 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "defuses");
  _func_2FD("match_defuses", var_25);
  var_26 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "returns");
  _func_2FD("match_returns", var_26);
  _func_2FD("prestige_max", var_0.pers["prestige"]);
  _func_2FD("level_max", var_0.pers["rank"]);
  _func_2FD("match_result", var_2);
  var_27 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "timePlayed");
  _func_2FD("match_duration", var_27);

  if(var_0.clientid <= 30 && var_0.clientid != getmatchdata("playerCount")) {
    var_28 = getmatchdata("players", var_0.clientid, "startHits");
    var_29 = getmatchdata("players", var_0.clientid, "endHits");
    var_30 = getmatchdata("players", var_0.clientid, "startMisses");
    var_31 = getmatchdata("players", var_0.clientid, "endMisses");
    var_32 = var_29 + var_31 - (var_28 + var_30);
    var_33 = var_29 - var_28;
    _func_2FD("match_shots", var_32);
    _func_2FD("match_hits", var_33);
  } else {
    _func_2FD("match_shots", 0);
    _func_2FD("match_hits", 0);
  }

  _func_2FD("loadout_perks", var_9);
  _func_2FD("loadout_lethal", var_7);
  _func_2FD("loadout_tactical", var_8);
  _func_2FD("loadout_scorestreaks", var_10);
  _func_2FD("loadout_primary_weapon", var_3);
  _func_2FD("loadout_secondary_weapon", var_5);
  _func_2FD("loadout_primary_attachments", var_4);
  _func_2FD("loadout_secondary_attachments", var_6);
  var_34 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestScore");
  _func_2FD("best_score", common_scripts\utility::tostring(var_34));
  var_35 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestKills");
  _func_2FD("best_kills", common_scripts\utility::tostring(var_35));
  var_36 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "kills");
  _func_2FD("total_kills", var_36);
  var_37 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "deaths");
  _func_2FD("total_deaths", var_37);
  var_38 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "wins");
  _func_2FD("total_wins", var_38);
  var_39 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "experience");
  _func_2FD("total_xp", var_39);
  _func_2FE();
}

freezeallplayers(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = 0;

  foreach(var_3 in level.players) {
    var_3 disableammogeneration();
    var_3 thread freezeplayerforroundend(var_0);
    var_3 thread roundenddof(4.0);
    var_3 freegameplayhudelems();

    if(isdefined(var_1) && var_1) {
      if(level.splitscreen || var_3 issplitscreenplayer())
        var_3 setclientdvars("cg_everyoneHearsEveryone", 1, "cg_fovscale", 0.75);
      else
        var_3 setclientdvars("cg_everyoneHearsEveryone", 1, "cg_fovScale", 1);

      var_3 setclientomnvar("fov_scale", 1);
      continue;
    }

    var_3 setclientdvars("cg_everyoneHearsEveryone", 1);
  }

  if(isdefined(level.agentarray)) {
    foreach(var_6 in level.agentarray)
    var_6 maps\mp\_utility::freezecontrolswrapper(1);
  }
}

endgameovertime(var_0, var_1) {
  setdvar("bg_compassShowEnemies", 0);
  handlekillstreaksonroundswitch(0);
  freezeallplayers(1.0, 1);

  foreach(var_3 in level.players) {
    var_3.pers["stats"] = var_3.stats;
    var_3.pers["segments"] = var_3.segments;
  }

  level notify("round_switch", "overtime");
  var_5 = 0;
  var_6 = 0;
  var_7 = var_0 == "overtime";

  if(level.gametype == "ctf") {
    if(var_0 == "overtime_halftime")
      var_6 = 1;

    var_0 = "tie";
    var_5 = 1;
    var_7 = 1;

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      var_0 = "axis";

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
      var_0 = "allies";
  }

  outcomenotifytoallplayers(var_0, var_5, var_1);
  roundendwait(level.roundenddelay, 0);

  if(level.gametype == "ctf")
    var_0 = "overtime_halftime";

  if(isdefined(level.finalkillcam_winner) && var_7) {
    foreach(var_3 in level.players)
    var_3 notify("reset_outcome");

    level notify("game_cleanup");
    waittillfinalkillcamdone();

    if(level.gametype == "ctf" && !var_6) {
      var_0 = "overtime";
      var_1 = game["end_reason"]["tie"];
    }

    outcomenotifytoallplayers(var_0, 0, var_1);
    roundendwait(level.halftimeroundenddelay, 0);
  }

  game["status"] = var_0;
  level notify("restarting");
  game["state"] = "playing";
  setdvar("ui_game_state", game["state"]);
  map_restart(1);
}

handlekillstreaksonroundswitch(var_0) {
  var_1 = isdefined(level.killcountpersistsoverrounds) && level.killcountpersistsoverrounds != 0;

  if(var_0 && (maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround()))
    var_1 = 0;

  foreach(var_3 in level.players) {
    if(!var_1) {
      var_3.pers["cur_kill_streak"] = 0;
      var_3 setclientomnvar("ks_count1", 0);
      continue;
    }

    var_4 = int(var_3 getclientomnvar("ks_count1"));
    var_3.pers["cur_kill_count"] = var_4;
  }
}

endgamehalftime(var_0) {
  setdvar("bg_compassShowEnemies", 0);
  handlekillstreaksonroundswitch(0);
  var_1 = "halftime";
  var_2 = 1;

  if(isdefined(level.halftime_switch_sides) && !level.halftime_switch_sides)
    var_2 = 0;

  if(var_2) {
    game["switchedsides"] = !game["switchedsides"];
    var_3 = game["end_reason"]["switching_sides"];
  } else
    var_3 = var_0;

  freezeallplayers(1.0, 1);

  if(level.gametype == "ctf") {
    var_3 = var_0;
    var_1 = "tie";

    if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      var_1 = "axis";

    if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
      var_1 = "allies";
  }

  foreach(var_5 in level.players) {
    var_5.pers["stats"] = var_5.stats;
    var_5.pers["segments"] = var_5.segments;
  }

  level notify("round_switch", "halftime");
  outcomenotifytoallplayers(var_1, 1, var_3);
  roundendwait(level.roundenddelay, 0);

  if(isdefined(level.finalkillcam_winner)) {
    foreach(var_5 in level.players)
    var_5 notify("reset_outcome");

    level notify("game_cleanup");
    waittillfinalkillcamdone();
    var_9 = game["end_reason"]["switching_sides"];

    if(!var_2)
      var_9 = var_3;

    outcomenotifytoallplayers("halftime", 1, var_9);
    roundendwait(level.halftimeroundenddelay, 0);
  }

  game["status"] = "halftime";
  level notify("restarting");
  game["state"] = "playing";
  setdvar("ui_game_state", game["state"]);
  map_restart(1);
}

updategameduration() {
  level endon("game_ended");

  for (;;) {
    var_0 = getgameduration();
    setomnvar("ui_game_duration", var_0 * 1000);
    wait 1.0;
  }
}

getgameduration() {
  var_0 = maps\mp\_utility::getgametimepassedseconds();

  if(isdefined(level.ishorde) && level.ishorde)
    var_0 = gamedurationclamp(var_0);

  return var_0;
}

gamedurationclamp(var_0) {
  if(var_0 > 86399)
    return 86399;

  return var_0;
}

endgame(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 0;

  if(game["state"] == "postgame" || level.gameended) {
    return;
  }
  game["state"] = "postgame";
  setdvar("ui_game_state", "postgame");
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level notify("game_ended", var_0);
  maps\mp\_utility::levelflagset("game_over");
  maps\mp\_utility::levelflagset("block_notifies");
  var_3 = getgameduration();
  setomnvar("ui_game_duration", var_3 * 1000);
  maps\mp\_utility::setgameplayactive(0);
  waitframe();
  setgameendtime(0);
  setmatchdata("gameLengthSeconds", var_3);
  setmatchdata("endTimeUTC", getsystemtime());
  checkgameendchallenges();

  if(isdefined(var_0) && isstring(var_0) && maps\mp\_utility::isovertimetext(var_0)) {
    level.finalkillcam_winner = "none";
    level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
    endgameovertime(var_0, var_1);
    return;
  }

  if(isdefined(var_0) && isstring(var_0) && var_0 == "halftime") {
    level.finalkillcam_winner = "none";
    level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
    endgamehalftime(var_1);
    return;
  }

  if(isdefined(level.finalkillcam_winner))
    level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();

  game["roundsPlayed"]++;

  if(level.gametype != "ctf")
    setomnvar("ui_current_round", game["roundsPlayed"]);

  if(level.teambased) {
    if((var_0 == "axis" || var_0 == "allies") && level.gametype != "ctf")
      game["roundsWon"][var_0]++;

    maps\mp\gametypes\_gamescore::updateteamscore("axis");
    maps\mp\gametypes\_gamescore::updateteamscore("allies");
  } else if(isdefined(var_0) && isplayer(var_0))
    game["roundsWon"][var_0.guid]++;

  maps\mp\gametypes\_gamescore::updateplacement();
  rankedmatchupdates(var_0);
  handlekillstreaksonroundswitch(1);

  foreach(var_5 in level.players)
  var_5 setclientdvar("ui_opensummary", 1);

  setdvar("g_deadChat", 1);
  setdvar("ui_allow_teamchange", 0);
  setdvar("bg_compassShowEnemies", 0);
  freezeallplayers(1.0, 1);
  var_7 = game["switchedsides"];

  if(!maps\mp\_utility::wasonlyround() && !var_2) {
    displayroundend(var_0, var_1);

    if(isdefined(level.finalkillcam_winner)) {
      foreach(var_5 in level.players)
      var_5 notify("reset_outcome");

      level notify("game_cleanup");
      waittillfinalkillcamdone();
    }

    if(!maps\mp\_utility::waslastround()) {
      maps\mp\_utility::levelflagclear("block_notifies");

      if(checkroundswitch())
        displayroundswitch(var_7);

      foreach(var_5 in level.players) {
        var_5.pers["stats"] = var_5.stats;
        var_5.pers["segments"] = var_5.segments;
      }

      level notify("restarting");
      game["state"] = "playing";
      setdvar("ui_game_state", "playing");
      map_restart(1);
      return;
    }

    if(!level.forcedend)
      var_1 = updateendreasontext(var_0);
  }

  if(!isdefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp\clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
  }

  maps\mp\gametypes\_missions::roundend(var_0);
  var_0 = getgamewinner(var_0, 1);

  if(level.teambased) {
    setomnvar("ui_game_victor", 0);

    if(var_0 == "allies")
      setomnvar("ui_game_victor", 2);
    else if(var_0 == "axis")
      setomnvar("ui_game_victor", 1);
  }

  displaygameend(var_0, var_1);
  var_12 = gettime();

  if(isdefined(level.finalkillcam_winner) && maps\mp\_utility::wasonlyround()) {
    foreach(var_5 in level.players)
    var_5 notify("reset_outcome");

    level notify("game_cleanup");
    waittillfinalkillcamdone();
  }

  maps\mp\_utility::levelflagclear("block_notifies");
  level.intermission = 1;
  level notify("spawning_intermission");

  foreach(var_5 in level.players) {
    var_5 closepopupmenu();
    var_5 closeingamemenu();
    var_5 notify("reset_outcome");
    var_5 setclientomnvar("ui_toggle_final_scoreboard", 1);
    var_5 thread maps\mp\gametypes\_playerlogic::spawnintermission();
  }

  processlobbydata();
  maps\mp\_skill::process();
  wait 1.0;
  checkforpersonalbests();
  updatecombatrecord();

  if(level.teambased) {
    if(var_0 == "axis" || var_0 == "allies")
      setmatchdata("victor", var_0);
    else
      setmatchdata("victor", "none");

    setmatchdata("alliesScore", game["teamScores"]["allies"]);
    setmatchdata("axisScore", game["teamScores"]["axis"]);
    tournamentreportwinningteam(var_0);
  } else
    setmatchdata("victor", "none");

  level maps\mp\_matchdata::endofgamesummarylogger();

  foreach(var_5 in level.players) {
    if(var_5 maps\mp\_utility::rankingenabled())
      var_5 maps\mp\_matchdata::logfinalstats();

    var_5 maps\mp\gametypes\_playerlogic::logplayerstats();
  }

  setmatchdata("host", maps\mp\gametypes\_playerlogic::truncateplayername(level.hostname));

  if(maps\mp\_utility::matchmakinggame()) {
    setmatchdata("playlistVersion", getplaylistversion());
    setmatchdata("playlistID", getplaylistid());
    setmatchdata("isDedicated", isdedicatedserver());
  }

  setmatchdata("levelMaxClients", level.maxclients);
  sendmatchdata();
  var_19 = getmatchdata("victor");
  recordendgamecomscoreevent(var_19);

  foreach(var_5 in level.players) {
    var_5.pers["stats"] = var_5.stats;
    var_5.pers["segments"] = var_5.segments;
  }

  tournamentreportendofgame();
  var_22 = 0;

  if(isdefined(level.endgamewaitfunc))
    [[level.endgamewaitfunc]](var_2, level.postgamenotifies, var_22, var_0);
  else if(!var_2 && !level.postgamenotifies) {
    if(!maps\mp\_utility::wasonlyround())
      wait(6.0 + var_22);
    else
      wait(min(10.0, 4.0 + var_22 + level.postgamenotifies));
  } else
    wait(min(10.0, 4.0 + var_22 + level.postgamenotifies));

  var_23 = "_gamelogic.gsc";
  var_24 = "all";

  if(level.teambased && isdefined(var_0))
    var_24 = var_0;

  var_25 = "undefined";

  if(isdefined(var_1)) {
    switch (var_1) {
      case 1:
        var_25 = "MP_SCORE_LIMIT_REACHED";
        break;
      case 2:
        var_25 = "MP_TIME_LIMIT_REACHED";
        break;
      case 3:
        var_25 = "MP_PLAYERS_FORFEITED";
        break;
      case 4:
        var_25 = "MP_TARGET_DESTROYED";
        break;
      case 5:
        var_25 = "MP_BOMB_DEFUSED";
        break;
      case 6:
        var_25 = "MP_SAS_ELIMINATED";
        break;
      case 7:
        var_25 = "MP_SPETSNAZ_ELIMINATED";
        break;
      case 8:
        var_25 = "MP_SAS_FORFEITED";
        break;
      case 9:
        var_25 = "MP_SPETSNAZ_FORFEITED";
        break;
      case 10:
        var_25 = "MP_SAS_MISSION_ACCOMPLISHED";
        break;
      case 11:
        var_25 = "MP_SPETSNAZ_MISSION_ACCOMPLISHED";
        break;
      case 12:
        var_25 = "MP_ENEMIES_ELIMINATED";
        break;
      case 13:
        var_25 = "MP_MATCH_TIE";
        break;
      case 14:
        var_25 = "GAME_OBJECTIVECOMPLETED";
        break;
      case 15:
        var_25 = "GAME_OBJECTIVEFAILED";
        break;
      case 16:
        var_25 = "MP_SWITCHING_SIDES";
        break;
      case 17:
        var_25 = "MP_ROUND_LIMIT_REACHED";
        break;
      case 18:
        var_25 = "MP_ENDED_GAME";
        break;
      case 19:
        var_25 = "MP_HOST_ENDED_GAME";
        break;
      case 20:
        var_25 = "MP_PREVENT_STAT_LOSS";
        break;
      default:
        break;
    }
  }

  if(!isdefined(var_12))
    var_12 = -1;

  var_26 = 15;
  var_27 = var_26;
  var_28 = getmatchdata("playerCount");
  var_29 = getmatchdata("lifeCount");

  if(!isdefined(level.matchdata)) {
    var_30 = 0;
    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;
    var_35 = 0;
    var_36 = 0;
  } else {
    if(isdefined(level.matchdata["botJoinCount"]))
      var_30 = level.matchdata["botJoinCount"];
    else
      var_30 = 0;

    if(isdefined(level.matchdata["deathCount"]))
      var_31 = level.matchdata["deathCount"];
    else
      var_31 = 0;

    if(isdefined(level.matchdata["badSpawnDiedTooFastCount"]))
      var_32 = level.matchdata["badSpawnDiedTooFastCount"];
    else
      var_32 = 0;

    if(isdefined(level.matchdata["badSpawnKilledTooFastCount"]))
      var_33 = level.matchdata["badSpawnKilledTooFastCount"];
    else
      var_33 = 0;

    if(isdefined(level.matchdata["badSpawnDmgDealtCount"]))
      var_34 = level.matchdata["badSpawnDmgDealtCount"];
    else
      var_34 = 0;

    if(isdefined(level.matchdata["badSpawnDmgReceivedCount"]))
      var_35 = level.matchdata["badSpawnDmgReceivedCount"];
    else
      var_35 = 0;

    if(isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
      var_36 = level.matchdata["badSpawnByAnyMeansCount"];
    else
      var_36 = 0;
  }

  var_37 = 0;
  reconevent("script_mp_match_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, badSpawnDiedTooFastCount %d, badSpawnKilledTooFastCount %d, badSpawnDmgDealtCount %d, badSpawnDmgReceivedCount %d, badSpawnByAnyMeansCount %d, sightTraceMethodsUsed %d", var_23, var_12, var_24, var_25, var_27, var_28, var_30, var_29, var_31, var_32, var_33, var_34, var_35, var_36, var_37);

  if(isdefined(level.ishorde) && level.ishorde) {
    if(isdefined(level.zombiescompleted) && level.zombiescompleted)
      setdvar("cg_drawCrosshair", 1);
  }

  level notify("exitLevel_called");
  exitlevel(0);
}

clearallnonplayerentities() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0)
  var_2 delete();

  maps\mp\gametypes\_objpoints::deleteallobjpoints();

  if(isdefined(level.turrets)) {
    foreach(var_5 in level.turrets)
    var_5 delete();
  }
}

getgamewinner(var_0, var_1) {
  if(!isstring(var_0))
    return var_0;

  var_2 = var_0;

  if(level.teambased && (maps\mp\_utility::isroundbased() || level.gametype == "ctf") && level.gameended) {
    var_3 = "roundsWon";

    if(isdefined(level.winbycaptures) && level.winbycaptures)
      var_3 = "teamScores";

    if(game[var_3]["allies"] == game[var_3]["axis"])
      var_2 = "tie";
    else if(game[var_3]["axis"] > game[var_3]["allies"])
      var_2 = "axis";
    else
      var_2 = "allies";
  }

  if(var_1 && (var_2 == "allies" || var_2 == "axis"))
    level.finalkillcam_winner = var_2;

  return var_2;
}

updateendreasontext(var_0) {
  if(!level.teambased)
    return 1;

  if(maps\mp\_utility::hitroundlimit())
    return game["end_reason"]["round_limit_reached"];

  if(maps\mp\_utility::hitwinlimit())
    return game["end_reason"]["score_limit_reached"];

  return game["end_reason"]["objective_completed"];
}

estimatedtimetillscorelimit(var_0) {
  var_1 = getscoreperminute(var_0);
  var_2 = getscoreremaining(var_0);
  var_3 = 999999;

  if(var_1)
    var_3 = var_2 / var_1;

  return var_3;
}

getscoreperminute(var_0) {
  var_1 = maps\mp\_utility::getwatcheddvar("scorelimit");
  var_2 = maps\mp\_utility::gettimelimit();
  var_3 = maps\mp\_utility::gettimepassed() / 60000 + 0.0001;

  if(isplayer(self))
    var_4 = self.score / var_3;
  else
    var_4 = getteamscore(var_0) / var_3;

  return var_4;
}

getscoreremaining(var_0) {
  var_1 = maps\mp\_utility::getwatcheddvar("scorelimit");

  if(isplayer(self))
    var_2 = var_1 - self.score;
  else
    var_2 = var_1 - getteamscore(var_0);

  return var_2;
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);

  if(level.multiteambased) {
    foreach(var_1 in level.teamnamelist) {
      if(self.pers["team"] != var_1)
        thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_1);
    }
  } else {
    var_3 = maps\mp\_utility::getotherteam(self.pers["team"]);
    thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_3);
  }

  level notify("last_alive", self);
}

processlobbydata() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isdefined(var_2)) {
      continue;
    }
    var_2.clientmatchdataid = var_0;
    var_0++;

    if(isdefined(level.iszombiegame) && level.iszombiegame)
      var_2.clientmatchdataid = var_2 getentitynumber();

    setclientmatchdata("players", var_2.clientmatchdataid, "name", maps\mp\gametypes\_playerlogic::extractplayername(var_2.name));
    setclientmatchdata("players", var_2.clientmatchdataid, "clanTag", maps\mp\gametypes\_playerlogic::extractclantag(var_2.name));
    setclientmatchdata("players", var_2.clientmatchdataid, "xuid", var_2.xuid);
    var_3 = 0;
    var_4 = 0;

    if(isdefined(var_2.pers["rank"]))
      var_3 = var_2.pers["rank"];

    if(isdefined(var_2.pers["prestige"]))
      var_4 = var_2.pers["prestige"];

    setclientmatchdata("players", var_2.clientmatchdataid, "rank", var_3);
    setclientmatchdata("players", var_2.clientmatchdataid, "prestige", var_4);
  }

  maps\mp\_awards::assignawards();
  maps\mp\_scoreboard::processlobbyscoreboards();
  sendclientmatchdata();
  lootserviceonendgame();
}

trackleaderboarddeathstats(var_0, var_1) {
  thread threadedsetweaponstatbyname(var_0, 1, "deaths");
}

trackattackerleaderboarddeathstats(var_0, var_1, var_2) {
  if(isdefined(self) && isplayer(self)) {
    if(var_1 != "MOD_FALLING") {
      if(maps\mp\_utility::ismeleemod(var_1) && issubstr(var_0, "tactical")) {
        return;
      }
      var_3 = maps\mp\gametypes\_weapons::ismeleeinventoryweapon(var_0);

      if(var_3)
        thread threadedincmeleekill();

      if(maps\mp\_utility::ismeleemod(var_1) && !issubstr(var_0, "riotshield") && !issubstr(var_0, "combatknife") && !var_3) {
        thread threadedincmeleekill();
        return;
      } else if(maps\mp\_utility::isdestructibleweapon(var_0)) {
        thread threadedincdestructiblekill();
        return;
      }

      thread threadedsetweaponstatbyname(var_0, 1, "kills");
      var_4 = 0;

      if(isdefined(var_2) && isdefined(var_2.firedads))
        var_4 = var_2.firedads;
      else
        var_4 = self playerads();

      if(var_4 < 0.2)
        thread threadedsetweaponstatbyname(var_0, 1, "hipfirekills");
    }

    if(var_1 == "MOD_HEAD_SHOT")
      thread threadedsetweaponstatbyname(var_0, 1, "headShots");
  }
}

setweaponstat(var_0, var_1, var_2) {
  if(!var_1) {
    return;
  }
  var_3 = maps\mp\_utility::getweaponclass(var_0);

  if(var_3 == "killstreak" || var_3 == "other") {
    return;
  }
  if(maps\mp\_utility::isenvironmentweapon(var_0)) {
    return;
  }
  if(maps\mp\_utility::isbombsiteweapon(var_0)) {
    return;
  }
  if(var_3 == "weapon_grenade" || var_3 == "weapon_explosive") {
    var_4 = maps\mp\_utility::strip_suffix(var_0, "_lefthand");
    var_4 = maps\mp\_utility::strip_suffix(var_4, "_mp");
    maps\mp\gametypes\_persistence::incrementweaponstat(var_4, var_2, var_1);
    maps\mp\_matchdata::logweaponstat(var_4, var_2, var_1);
    return;
  }

  var_5 = maps\mp\gametypes\_weapons::isprimaryorsecondaryprojectileweapon(var_0);
  var_6 = getsubstr(var_0, 0, 4) == "alt_";
  var_7 = maps\mp\gametypes\_weapons::ismeleeinventoryweapon(var_0);

  if(var_2 != "timeInUse" && var_2 != "deaths" && !var_5 && !var_6 && !var_7) {
    var_8 = var_0;
    var_0 = self getcurrentweapon();

    if(var_0 != var_8 && maps\mp\_utility::iskillstreakweapon(var_0))
      return;
  }

  if(!isdefined(self.trackingweaponname))
    self.trackingweaponname = var_0;

  if(var_0 != self.trackingweaponname) {
    maps\mp\gametypes\_persistence::updateweaponbufferedstats();
    self.trackingweaponname = var_0;
    self.currentfirefightshots = 0;
  }

  switch (var_2) {
    case "shots":
      self.trackingweaponshots++;
      self.currentfirefightshots++;
      break;
    case "hits":
      self.trackingweaponhits++;
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
      self.trackingweaponusetime = self.trackingweaponusetime + var_1;
      break;
  }

  if(var_2 == "deaths") {
    var_9 = maps\mp\_utility::getbaseweaponname(var_0);

    if(!maps\mp\_utility::iscacprimaryweapon(var_9) && !maps\mp\_utility::iscacsecondaryweapon(var_9) && !maps\mp\_utility::iscacmeleeweapon(var_9)) {
      return;
    }
    var_10 = maps\mp\_utility::getweaponattachmentsbasenames(var_0);
    maps\mp\gametypes\_persistence::incrementweaponstat(var_9, var_2, var_1);
    maps\mp\_matchdata::logweaponstat(var_9, "deaths", var_1);

    foreach(var_12 in var_10)
    maps\mp\gametypes\_persistence::incrementattachmentstat(var_12, var_2, var_1);
  }
}

setinflictorstat(var_0, var_1, var_2) {
  if(!isdefined(var_1)) {
    return;
  }
  if(!isdefined(var_0)) {
    var_1 setweaponstat(var_2, 1, "hits");
    return;
  }

  if(!isdefined(var_0.playeraffectedarray))
    var_0.playeraffectedarray = [];

  var_3 = 1;

  for (var_4 = 0; var_4 < var_0.playeraffectedarray.size; var_4++) {
    if(var_0.playeraffectedarray[var_4] == self) {
      var_3 = 0;
      break;
    }
  }

  if(var_3) {
    var_0.playeraffectedarray[var_0.playeraffectedarray.size] = self;
    var_1 setweaponstat(var_2, 1, "hits");
  }
}

threadedsetweaponstatbyname(var_0, var_1, var_2) {
  self endon("disconnect");
  waittillframeend;
  setweaponstat(var_0, var_1, var_2);
}

threadedincmeleekill() {
  self endon("disconnect");
  waittillframeend;
  maps\mp\gametypes\_persistence::incrementmeleestat();
}

threadedincdestructiblekill() {
  self endon("disconnect");
  waittillframeend;
  maps\mp\gametypes\_persistence::incrementdestructiblestat();
}

checkforpersonalbests() {
  foreach(var_1 in level.players) {
    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1 maps\mp\_utility::rankingenabled()) {
      var_2 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "kills");
      var_3 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "deaths");
      var_4 = var_1.pers["summary"]["xp"];
      var_5 = var_1.score;
      var_6 = getroundaccuracy(var_1);
      var_7 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestKills");
      var_8 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mostDeaths");
      var_9 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mostXp");
      var_10 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestScore");
      var_11 = var_1 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestAccuracy");

      if(var_2 > var_7)
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestKills", var_2);

      if(var_4 > var_9)
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mostXp", var_4);

      if(var_3 > var_8)
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mostDeaths", var_3);

      if(var_5 > var_10)
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestScore", var_5);

      if(var_6 > var_11)
        var_1 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestAccuracy", var_6);

      var_1 checkforbestweapon();
      var_1 maps\mp\_matchdata::logplayerxp(var_4, "totalXp");
      var_1 maps\mp\_matchdata::logplayerxp(var_1.pers["summary"]["score"], "scoreXp");
      var_1 maps\mp\_matchdata::logplayerxp(var_1.pers["summary"]["challenge"], "challengeXp");
      var_1 maps\mp\_matchdata::logplayerxp(var_1.pers["summary"]["match"], "matchXp");
      var_1 maps\mp\_matchdata::logplayerxp(var_1.pers["summary"]["misc"], "miscXp");
    }

    if(isdefined(var_1.pers["confirmed"]))
      var_1 maps\mp\_matchdata::logkillsconfirmed();

    if(isdefined(var_1.pers["denied"]))
      var_1 maps\mp\_matchdata::logkillsdenied();
  }
}

getroundaccuracy(var_0) {
  var_1 = float(var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "totalShots") - var_0.pers["previous_shots"]);

  if(var_1 == 0)
    return 0;

  var_2 = float(var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "hits") - var_0.pers["previous_hits"]);
  var_3 = clamp(var_2 / var_1, 0.0, 1.0) * 10000.0;
  return int(var_3);
}

checkforbestweapon() {
  var_0 = maps\mp\_matchdata::buildbaseweaponlist();

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_2 = maps\mp\_utility::getbaseweaponname(var_2);
    var_3 = maps\mp\_utility::getweaponclass(var_2);

    if(!maps\mp\_utility::iskillstreakweapon(var_2) && var_3 != "killstreak" && var_3 != "other") {
      var_4 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestWeapon", "kills");
      var_5 = 0;

      if(isdefined(self.pers["mpWeaponStats"][var_2]) && isdefined(self.pers["mpWeaponStats"][var_2]["kills"])) {
        var_5 = self.pers["mpWeaponStats"][var_2]["kills"];

        if(var_5 > var_4) {
          self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestWeapon", "kills", var_5);
          var_6 = 0;

          if(isdefined(self.pers["mpWeaponStats"][var_2]["shots"]))
            var_6 = self.pers["mpWeaponStats"][var_2]["shots"];

          var_7 = 0;

          if(isdefined(self.pers["mpWeaponStats"][var_2]["headShots"]))
            var_7 = self.pers["mpWeaponStats"][var_2]["headShots"];

          var_8 = 0;

          if(isdefined(self.pers["mpWeaponStats"][var_2]["hits"]))
            var_8 = self.pers["mpWeaponStats"][var_2]["hits"];

          var_9 = 0;

          if(isdefined(self.pers["mpWeaponStats"][var_2]["deaths"]))
            var_9 = self.pers["mpWeaponStats"][var_2]["deaths"];

          self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestWeapon", "shots", var_6);
          self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestWeapon", "headShots", var_7);
          self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestWeapon", "hits", var_8);
          self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestWeapon", "deaths", var_9);
          var_10 = int(tablelookup("mp\statstable.csv", 4, var_2, 0));
          self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "bestWeaponIndex", var_10);
        }
      }
    }
  }
}

updatecombatrecordforplayertrends() {
  var_0 = 5;
  var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "numTrends");
  var_1++;

  if(var_1 > var_0) {
    var_1 = var_0;

    if(var_0 > 1) {
      for (var_2 = 0; var_2 < var_0 - 1; var_2++) {
        var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_2 + 1, "timestamp");
        var_4 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_2 + 1, "kills");
        var_5 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_2 + 1, "deaths");
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_2, "timestamp", var_3);
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_2, "kills", var_4);
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_2, "deaths", var_5);
      }
    }
  }

  var_3 = maps\mp\_utility::gettimeutc_for_stat_recording();
  var_4 = self.kills;
  var_5 = self.deaths;
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_1 - 1, "timestamp", var_3);
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_1 - 1, "kills", var_4);
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "trend", var_1 - 1, "deaths", var_5);
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "numTrends", var_1);
}

updatecombatrecordcommondata() {
  var_0 = maps\mp\_utility::gettimeutc_for_stat_recording();
  setcombatrecordstat("timeStampLastGame", var_0);
  incrementcombatrecordstat("numMatches", 1);
  incrementcombatrecordstat("timePlayed", self.timeplayed["total"]);
  incrementcombatrecordstat("kills", self.kills);
  incrementcombatrecordstat("deaths", self.deaths);
  incrementcombatrecordstat("xpEarned", self.pers["summary"]["xp"]);

  if(isdefined(self.combatrecordwin))
    incrementcombatrecordstat("wins", 1);

  if(isdefined(self.combatrecordtie))
    incrementcombatrecordstat("ties", 1);

  var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", level.gametype, "timeStampFirstGame");

  if(var_1 == 0)
    setcombatrecordstat("timeStampFirstGame", var_0);
}

incrementcombatrecordstat(var_0, var_1) {
  var_2 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", level.gametype, var_0);
  var_2 = var_2 + var_1;
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", level.gametype, var_0, var_2);
}

setcombatrecordstat(var_0, var_1) {
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", level.gametype, var_0, var_1);
}

setcombatrecordstatifgreater(var_0, var_1) {
  var_2 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", level.gametype, var_0);

  if(var_1 > var_2)
    setcombatrecordstat(var_0, var_1);
}

updatecombatrecordforplayergamemodes() {
  if(level.gametype == "war" || level.gametype == "dm") {
    updatecombatrecordcommondata();
    var_0 = self.deaths;

    if(var_0 == 0)
      var_0 = 1;

    var_1 = int(self.kills / var_0) * 1000;
    setcombatrecordstatifgreater("mostkills", self.kills);
    setcombatrecordstatifgreater("bestkdr", var_1);
  } else if(level.gametype == "ctf") {
    updatecombatrecordcommondata();
    var_2 = maps\mp\_utility::getpersstat("captures");
    var_3 = maps\mp\_utility::getpersstat("returns");
    incrementcombatrecordstat("captures", var_2);
    incrementcombatrecordstat("returns", var_3);
    setcombatrecordstatifgreater("mostcaptures", var_2);
    setcombatrecordstatifgreater("mostreturns", var_3);
  } else if(level.gametype == "dom") {
    updatecombatrecordcommondata();
    var_2 = maps\mp\_utility::getpersstat("captures");
    var_4 = maps\mp\_utility::getpersstat("defends");
    incrementcombatrecordstat("captures", var_2);
    incrementcombatrecordstat("defends", var_4);
    setcombatrecordstatifgreater("mostcaptures", var_2);
    setcombatrecordstatifgreater("mostdefends", var_4);
  } else if(level.gametype == "conf") {
    updatecombatrecordcommondata();
    var_5 = maps\mp\_utility::getpersstat("confirmed");
    var_6 = maps\mp\_utility::getpersstat("denied");
    incrementcombatrecordstat("confirms", var_5);
    incrementcombatrecordstat("denies", var_6);
    setcombatrecordstatifgreater("mostconfirms", var_5);
    setcombatrecordstatifgreater("mostdenies", var_6);
  } else if(level.gametype == "sd") {
    updatecombatrecordcommondata();
    var_7 = maps\mp\_utility::getpersstat("plants");
    var_8 = maps\mp\_utility::getpersstat("defuses");
    var_9 = maps\mp\_utility::getpersstat("destructions");
    incrementcombatrecordstat("plants", var_7);
    incrementcombatrecordstat("defuses", var_8);
    incrementcombatrecordstat("detonates", var_9);
    setcombatrecordstatifgreater("mostplants", var_7);
    setcombatrecordstatifgreater("mostdefuses", var_8);
    setcombatrecordstatifgreater("mostdetonates", var_9);
  } else if(level.gametype == "hp") {
    updatecombatrecordcommondata();
    var_2 = maps\mp\_utility::getpersstat("captures");
    var_4 = maps\mp\_utility::getpersstat("defends");
    var_10 = maps\mp\_utility::getpersstat("captureTime");
    incrementcombatrecordstat("captures", var_2);
    incrementcombatrecordstat("defends", var_4);
    incrementcombatrecordstat("captureTime", var_10);
    setcombatrecordstatifgreater("mostcaptures", var_2);
    setcombatrecordstatifgreater("mostdefends", var_4);
    setcombatrecordstatifgreater("mostCaptureTime", var_10);
  } else if(level.gametype == "sr") {
    updatecombatrecordcommondata();
    var_7 = maps\mp\_utility::getpersstat("plants");
    var_8 = maps\mp\_utility::getpersstat("defuses");
    var_9 = maps\mp\_utility::getpersstat("destructions");
    var_5 = maps\mp\_utility::getpersstat("confirmed");
    var_6 = maps\mp\_utility::getpersstat("denied");
    incrementcombatrecordstat("plants", var_7);
    incrementcombatrecordstat("defuses", var_8);
    incrementcombatrecordstat("detonates", var_9);
    incrementcombatrecordstat("confirms", var_5);
    incrementcombatrecordstat("denies", var_6);
    setcombatrecordstatifgreater("mostplants", var_7);
    setcombatrecordstatifgreater("mostdefuses", var_8);
    setcombatrecordstatifgreater("mostdetonates", var_9);
    setcombatrecordstatifgreater("mostconfirms", var_5);
    setcombatrecordstatifgreater("mostdenies", var_6);
  } else if(level.gametype == "infect") {
    updatecombatrecordcommondata();
    var_11 = maps\mp\_utility::getplayerstat("contagious");
    var_12 = self.kills - var_11;
    incrementcombatrecordstat("infectedKills", var_12);
    incrementcombatrecordstat("survivorKills", var_11);
    setcombatrecordstatifgreater("mostInfectedKills", var_12);
    setcombatrecordstatifgreater("mostSurvivorKills", var_11);
  } else if(level.gametype == "gun") {
    updatecombatrecordcommondata();
    var_13 = maps\mp\_utility::getplayerstat("levelup");
    var_14 = maps\mp\_utility::getplayerstat("humiliation");
    incrementcombatrecordstat("gunPromotions", var_13);
    incrementcombatrecordstat("stabs", var_14);
    setcombatrecordstatifgreater("mostGunPromotions", var_13);
    setcombatrecordstatifgreater("mostStabs", var_14);
  } else if(level.gametype == "ball") {
    updatecombatrecordcommondata();
    var_15 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
    var_16 = maps\mp\_utility::getplayerstat("killedBallCarrier");
    incrementcombatrecordstat("pointsScored", var_15);
    incrementcombatrecordstat("killedBallCarrier", var_16);
    setcombatrecordstatifgreater("mostPointsScored", var_15);
    setcombatrecordstatifgreater("mostKilledBallCarrier", var_16);
  } else if(level.gametype == "twar") {
    updatecombatrecordcommondata();
    var_2 = maps\mp\_utility::getpersstat("captures");
    var_17 = maps\mp\_utility::getplayerstat("kill_while_capture");
    incrementcombatrecordstat("captures", var_2);
    incrementcombatrecordstat("killWhileCaptures", var_17);
    setcombatrecordstatifgreater("mostCaptures", var_2);
    setcombatrecordstatifgreater("mostKillWhileCaptures", var_17);
  } else if(level.gametype == "sab") {
    updatecombatrecordcommondata();
    var_7 = maps\mp\_utility::getpersstat("plants");
    var_8 = maps\mp\_utility::getpersstat("defuses");
    var_9 = maps\mp\_utility::getpersstat("destructions");
    incrementcombatrecordstat("plants", var_7);
    incrementcombatrecordstat("defuses", var_8);
    incrementcombatrecordstat("detonates", var_9);
    setcombatrecordstatifgreater("mostplants", var_7);
    setcombatrecordstatifgreater("mostdefuses", var_8);
    setcombatrecordstatifgreater("mostdetonates", var_9);
  } else if(level.gametype == "koth") {
    updatecombatrecordcommondata();
    var_2 = maps\mp\_utility::getpersstat("captures");
    var_4 = maps\mp\_utility::getpersstat("defends");
    incrementcombatrecordstat("captures", var_2);
    incrementcombatrecordstat("defends", var_4);
    setcombatrecordstatifgreater("mostcaptures", var_2);
    setcombatrecordstatifgreater("mostdefends", var_4);
  } else if(level.gametype == "dd") {
    updatecombatrecordcommondata();
    var_7 = maps\mp\_utility::getpersstat("plants");
    var_8 = maps\mp\_utility::getpersstat("defuses");
    var_9 = maps\mp\_utility::getpersstat("destructions");
    incrementcombatrecordstat("plants", var_7);
    incrementcombatrecordstat("defuses", var_8);
    incrementcombatrecordstat("detonates", var_9);
    setcombatrecordstatifgreater("mostplants", var_7);
    setcombatrecordstatifgreater("mostdefuses", var_8);
    setcombatrecordstatifgreater("mostdetonates", var_9);
  }
}

updatecombatrecordforplayer() {
  updatecombatrecordforplayertrends();
  updatecombatrecordforplayergamemodes();
}

updatecombatrecord() {
  foreach(var_1 in level.players) {
    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1 maps\mp\_utility::rankingenabled())
      var_1 updatecombatrecordforplayer();

    level maps\mp\gametypes\_playerlogic::writesegmentdata(var_1);
  }
}