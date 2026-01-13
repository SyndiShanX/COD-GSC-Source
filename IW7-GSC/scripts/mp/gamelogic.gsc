/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\gamelogic.gsc
**************************************/

func_C530(var_0) {
  if(isDefined(level.var_72F2)) {
    return;
  }
  level endon("abort_forfeit");
  level thread func_72F3();
  level.var_72F2 = 1;

  if(!level.teambased && level.players.size > 1) {
    wait 10;
  } else {
    wait 1.05;
  }

  level.var_72F1 = 0;
  var_1 = 20.0;
  matchforfeittimer(var_1);
  var_2 = &"";

  if(!isDefined(var_0)) {
    var_2 = game["end_reason"]["players_forfeited"];
    var_3 = level.players[0];
  } else if(var_0 == "axis") {
    var_2 = game["end_reason"]["allies_forfeited"];
    var_3 = "axis";
  } else if(var_0 == "allies") {
    var_2 = game["end_reason"]["axis_forfeited"];
    var_3 = "allies";
  } else if(level.multiteambased && issubstr(var_0, "team_"))
    var_3 = var_0;
  else {
    var_3 = "tie";
  }

  level.var_72B3 = 1;

  if(isplayer(var_3)) {
    logstring("forfeit, win: " + var_3 getxuid() + "(" + var_3.name + ")");
  } else {
    logstring("forfeit, win: " + var_3 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  }

  thread endgame(var_3, var_2);
}

func_72F3() {
  level endon("game_ended");
  level waittill("abort_forfeit");
  level.var_72F1 = 1;
  setomnvar("ui_match_start_countdown", 0);
}

matchforfeittimer_internal(var_0) {
  waittillframeend;
  level endon("match_forfeit_timer_beginning");

  while(var_0 > 0 && !level.gameended && !level.var_72F1 && !level.ingraceperiod) {
    setomnvar("ui_match_start_countdown", var_0);
    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  setomnvar("ui_match_start_countdown", 0);
}

matchforfeittimer(var_0) {
  level notify("match_forfeit_timer_beginning");
  var_1 = int(var_0);
  setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  matchforfeittimer_internal(var_1);
}

func_5007(var_0) {
  if(var_0 == "allies") {
    iprintln(&"MP_FACTION_UNSA_ELIMINATED");
    logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    thread endgame("axis", game["end_reason"]["allies_eliminated"]);
  } else if(var_0 == "axis") {
    iprintln(&"MP_FACTION_SDF_ELIMINATED");
    logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    thread endgame("allies", game["end_reason"]["axis_eliminated"]);
  } else {
    logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);

    if(level.teambased) {
      thread endgame("tie", game["end_reason"]["tie"]);
    } else {
      thread endgame(undefined, game["end_reason"]["tie"]);
    }
  }
}

default_ononeleftevent(var_0) {
  if(level.teambased) {
    var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);

    if(isDefined(var_1)) {
      var_1 thread givelastonteamwarning();
    }
  } else {
    var_1 = scripts\mp\utility\game::getlastlivingplayer();
    logstring("last one alive, win: " + var_1.name);
    thread endgame(var_1, game["end_reason"]["enemies_eliminated"]);
  }

  return 1;
}

func_E75E(var_0, var_1) {
  func_3E53(var_0);

  if(scripts\mp\utility\game::istrue(var_1)) {
    level notify("roundEnd_CheckScoreLimit");
    level endon("roundEnd_CheckScoreLimit");
    scripts\engine\utility::waitframe();
  }

  var_2 = scripts\mp\utility\game::getwingamebytype();

  if(scripts\mp\utility\game::inovertime()) {
    if(scripts\mp\utility\game::istimetobeatrulegametype()) {
      if(scripts\mp\utility\game::settimetobeat(var_0)) {
        foreach(var_4 in level.players) {
          var_4 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_4.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_4 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_4.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        thread endgame(var_0, game["end_reason"]["score_limit_reached"]);
      }
    } else
      thread endgame(var_0, game["end_reason"]["score_limit_reached"]);
  } else {
    var_6 = game["teamScores"]["allies"];
    var_7 = game["teamScores"]["axis"];
    var_8 = var_6 >= level.roundscorelimit;
    var_9 = var_7 >= level.roundscorelimit;

    if(level.roundscorelimit > 0) {
      if(var_8 && var_9) {
        if(var_6 == var_7) {
          thread endgame("tie", game["end_reason"]["score_limit_reached"]);
        } else if(var_6 > var_7) {
          thread endgame("allies", game["end_reason"]["score_limit_reached"]);
        } else {
          thread endgame("axis", game["end_reason"]["score_limit_reached"]);
        }
      } else if(var_8)
        thread endgame("allies", game["end_reason"]["score_limit_reached"]);
      else if(var_9) {
        thread endgame("axis", game["end_reason"]["score_limit_reached"]);
      }
    }
  }
}

default_ontimelimit() {
  var_0 = "tie";

  if(level.teambased) {
    if(scripts\mp\utility\game::inovertime()) {
      if(scripts\mp\utility\game::istimetobeatvalid()) {
        var_0 = game["timeToBeatTeam"];
      }
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      var_0 = "axis";
    else if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      var_0 = "allies";
    }

    logstring("time limit, win: " + var_0 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_0 = scripts\mp\gamescore::gethighestscoringplayer();

    if(scripts\mp\gamescore::ishighestscoringplayertied()) {
      var_0 = "tie";
    }

    if(isDefined(var_0) && isplayer(var_0)) {
      logstring("time limit, win: " + var_0.name);
    } else {
      logstring("time limit, tie");
    }
  }

  thread endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

default_onhalftime() {
  var_0 = undefined;
  thread endgame("halftime", game["end_reason"]["time_limit_reached"]);
}

forceend(var_0) {
  if(level.hostforcedend || level.var_72B3) {
    return;
  }
  scripts\mp\gamescore::updateplacement();

  if(level.teambased) {
    scripts\mp\gamescore::func_12F4A("axis");
    scripts\mp\gamescore::func_12F4A("allies");
  }

  var_1 = undefined;

  if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      var_1 = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_1 = "axis";
    } else {
      var_1 = "allies";
    }

    logstring("host ended game, win: " + var_1 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_1 = scripts\mp\gamescore::gethighestscoringplayer();

    if(isDefined(var_1)) {
      logstring("host ended game, win: " + var_1.name);
    } else {
      logstring("host ended game, tie");
    }
  }

  level.var_72B3 = 1;
  level.hostforcedend = 1;

  if(level.splitscreen) {
    var_2 = game["end_reason"]["ended_game"];
  } else {
    var_2 = game["end_reason"]["host_ended_game"];
  }

  if(isDefined(var_0) && var_0 == 2) {
    var_2 = game["end_reason"]["allies_forfeited"];
  }

  level notify("force_end");
  thread endgame(var_1, var_2);
}

func_C587(var_0) {
  var_1 = game["end_reason"]["score_limit_reached"];
  var_2 = "tie";

  if(level.multiteambased) {
    var_2 = scripts\mp\gamescore::playlocalsound();

    if(var_2 == "none") {
      var_2 = "tie";
    }
  } else if(level.teambased) {
    if(game["teamScores"]["axis"] != game["teamScores"]["allies"]) {
      if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
        var_2 = "axis";
      } else {
        var_2 = "allies";
      }
    }

    logstring("scorelimit, win: " + var_2 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_2 = scripts\mp\gamescore::gethighestscoringplayer();

    if(scripts\mp\utility\game::istrue(var_0) && scripts\mp\gamescore::ishighestscoringplayertied()) {
      var_2 = "tie";
    }

    if(isDefined(var_2) && isplayer(var_2)) {
      logstring("scorelimit, win: " + var_2.name);
    } else {
      logstring("scorelimit, tie");
    }
  }

  thread endgame(var_2, var_1);
  return 1;
}

updategameevents() {
  if(scripts\mp\utility\game::matchmakinggame() && !level.ingraceperiod && (!isDefined(level.disableforfeit) || !level.disableforfeit)) {
    if(level.multiteambased) {
      var_0 = 0;
      var_1 = 0;

      for(var_2 = 0; var_2 < level.teamnamelist.size; var_2++) {
        var_0 = var_0 + level.teamcount[level.teamnamelist[var_2]];

        if(level.teamcount[level.teamnamelist[var_2]]) {
          var_1 = var_1 + 1;
        }
      }

      for(var_2 = 0; var_2 < level.teamnamelist.size; var_2++) {
        if(var_0 == level.teamcount[level.teamnamelist[var_2]] && game["state"] == "playing") {
          thread func_C530(level.teamnamelist[var_2]);
          return;
        }
      }

      if(var_1 > 1) {
        level.var_72F2 = undefined;
        level notify("abort_forfeit");
      }
    } else if(level.teambased) {
      if(level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing") {
        thread func_C530("axis");
        return;
      }

      if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing") {
        thread func_C530("allies");
        return;
      }

      if(level.teamcount["axis"] > 0 && level.teamcount["allies"] > 0) {
        level.var_72F2 = undefined;
        level notify("abort_forfeit");
      }
    } else {
      if(level.teamcount["allies"] + level.teamcount["axis"] == 1 && level.maxplayercount > 1) {
        thread func_C530();
        return;
      }

      if(level.teamcount["axis"] + level.teamcount["allies"] > 1) {
        level.var_72F2 = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(!scripts\mp\utility\game::getgametypenumlives() && (!isDefined(level.disablespawning) || !level.disablespawning)) {
    return;
  }
  if(!scripts\mp\utility\game::gamehasstarted()) {
    return;
  }
  if(level.ingraceperiod) {
    return;
  }
  if(level.multiteambased) {
    return;
  }
  if(level.teambased) {
    var_3["allies"] = 0;
    var_3["axis"] = 0;

    foreach(var_5 in level.players) {
      if(var_5.team == "spectator" || !isDefined(var_5.hasspawned) || isDefined(var_5.hasspawned) && !var_5.hasspawned) {
        continue;
      }
      var_3[var_5.team] = var_3[var_5.team] + var_5.pers["lives"];
    }

    if(scripts\mp\utility\game::istrue(level.disablespawning)) {
      var_3["allies"] = 0;
      var_3["axis"] = 0;
    }

    if(!level.alivecount["allies"] && !level.alivecount["axis"] && !var_3["allies"] && !var_3["axis"]) {
      return [
        }
        [level.ondeadevent]]("all");

    if(!level.alivecount["allies"] && !var_3["allies"]) {
      return [
        }
        [level.ondeadevent]]("allies");

    if(!level.alivecount["axis"] && !var_3["axis"]) {
      return [
        }
        [level.ondeadevent]]("axis");

    var_7 = level.alivecount["allies"] == 1;
    var_8 = level.alivecount["axis"] == 1;

    if(var_7 || var_8) {
      var_9 = 0;
      var_10 = undefined;

      if(var_7) {
        foreach(var_5 in level.players) {
          if(var_5.team == "allies") {
            if(!isalive(var_5)) {
              var_9 = var_9 + var_5.pers["lives"];
            }
          }
        }

        if(var_9 == 0) {
          if(!isDefined(level.var_C50B["allies"]) || gettime() > level.var_C50B["allies"] + 5000) {
            level.var_C50B["allies"] = gettime();
            var_13 = [
              [level.ononeleftevent]
            ]("allies");

            if(isDefined(var_13)) {
              if(!isDefined(var_10)) {
                var_10 = var_13;
              }

              var_10 = var_10 || var_13;
            }
          }
        }
      }

      if(var_8) {
        foreach(var_5 in level.players) {
          if(var_5.team == "axis") {
            if(!isalive(var_5)) {
              var_9 = var_9 + var_5.pers["lives"];
            }
          }
        }

        if(var_9 == 0) {
          if(!isDefined(level.var_C50B["axis"]) || gettime() > level.var_C50B["axis"] + 5000) {
            level.var_C50B["axis"] = gettime();
            var_16 = [
              [level.ononeleftevent]
            ]("axis");

            if(isDefined(var_16)) {
              if(!isDefined(var_10)) {
                var_10 = var_16;
              }

              var_10 = var_10 || var_16;
            }
          }
        }
      }

      return var_10;
      return;
    }
  } else {
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(var_5.team == "spectator") {
        continue;
      }
      var_3 = var_3 + var_5.pers["lives"];
    }

    if(!level.alivecount["allies"] && !level.alivecount["axis"] && !var_3) {
      return [
        }
        [level.ondeadevent]]("all");

    var_19 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(var_19.size == 1) {
      return [
        }
        [level.ononeleftevent]]("all");
  }
}

waittillend_of_anim_set_walk() {
  if(!isDefined(level.finalkillcam_winner)) {
    return 0;
  }

  level waittill("final_killcam_done");
  return 1;
}

timelimitclock_intermission(var_0) {
  setgameendtime(gettime() + int(var_0 * 1000));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 hide();

  if(var_0 >= 10.0) {
    wait(var_0 - 10.0);
  }

  for(;;) {
    var_1 playSound("ui_mp_timer_countdown");
    wait 1.0;
  }
}

waitforplayers(var_0) {
  var_1 = gettime();
  var_2 = var_1 + var_0 * 1000 - 200;

  if(var_0 > 5) {
    var_3 = gettime() + getdvarint("min_wait_for_players") * 1000;
  } else {
    var_3 = 0;
  }

  var_4 = level.connectingPlayers / 3;

  for(;;) {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
      break;
    }
    var_5 = level.maxplayercount;
    var_6 = gettime();

    if(var_5 >= var_4 && var_6 > var_3 || var_6 > var_2) {
      break;
    }
    wait 0.05;
  }
}

prematchperiod() {
  level endon("game_ended");
  level.connectingPlayers = getdvarint("party_partyPlayerCountNum");

  if(level.prematchperiod > 0) {
    func_B415();
  } else {
    func_B414();
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();

  foreach(var_1 in level.players) {
    scripts\mp\playerlogic::clearprematchlook(var_1);
    var_1 scripts\mp\utility\game::freezecontrolswrapper(0, 1);

    if(!isDefined(var_1.pers["team"])) {
      continue;
    }
    var_2 = var_1.pers["team"];
    var_3 = scripts\mp\utility\game::getobjectivehinttext(var_2);

    if(!isDefined(var_3) || !var_1.hasspawned) {
      continue;
    }
    var_4 = 0;

    if(game["defenders"] == var_2) {
      var_4 = 1;
    }

    var_1 setclientomnvar("ui_objective_text", var_4);
  }

  if(game["state"] != "playing") {
    return;
  }
}

_meth_8487() {
  level endon("game_ended");

  if(!isDefined(game["clientActive"])) {
    while(getactiveclientcount() == 0) {
      wait 0.05;
    }

    game["clientActive"] = 1;
  }

  while(level.ingraceperiod > 0) {
    wait 1.0;
    level.ingraceperiod--;
  }

  level notify("grace_period_ending");
  wait 0.05;
  scripts\mp\utility\game::gameflagset("graceperiod_done");
  level.ingraceperiod = 0;

  if(game["state"] != "playing") {
    return;
  }
  if(scripts\mp\utility\game::getgametypenumlives()) {
    var_0 = level.players;

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(!var_2.hasspawned && var_2.sessionteam != "spectator" && !isalive(var_2)) {
        var_2.statusicon = "hud_status_dead";
      }
    }
  }

  level thread updategameevents();
}

sethasdonecombat(var_0, var_1) {
  var_0.hasdonecombat = var_1;
  var_2 = !scripts\mp\utility\game::istrue(var_0.pers["hasDoneAnyCombat"]);

  if(var_2 && var_1) {
    var_0.pers["hasDoneAnyCombat"] = 1;

    if(isDefined(var_0.pers["hasMatchLoss"]) && var_0.pers["hasMatchLoss"]) {
      return;
    }
    func_12EC3(var_0);
  }
}

func_12F66(var_0) {
  if(!var_0 scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(!scripts\mp\utility\game::istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }
  if(scripts\mp\utility\game::istrue(var_0.pers["recordedLoss"])) {
    var_0 scripts\mp\persistence::statadd("losses", -1);
  }

  var_0 scripts\mp\persistence::statadd("wins", 1);
  var_0 scripts\mp\utility\game::updatepersratio("winLossRatio", "wins", "losses");
  var_0 scripts\mp\persistence::statadd("currentWinStreak", 1);
  var_1 = var_0 scripts\mp\persistence::statget("currentWinStreak");

  if(var_1 > var_0 scripts\mp\persistence::statget("winStreak")) {
    var_0 scripts\mp\persistence::func_10E54("winStreak", var_1);
  }

  var_0 scripts\mp\persistence::statsetchild("round", "win", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

func_12EC3(var_0) {
  if(!var_0 scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(!scripts\mp\utility\game::istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }
  var_0.pers["hasMatchLoss"] = 1;

  if(!scripts\mp\utility\game::istrue(self.joinedinprogress)) {
    var_0 scripts\mp\persistence::statadd("losses", 1);
    var_0 scripts\mp\utility\game::updatepersratio("winLossRatio", "wins", "losses");
    var_0.pers["recordedLoss"] = 1;
  }

  var_0 scripts\mp\persistence::statadd("gamesPlayed", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "loss", 1);
}

func_12F42(var_0) {
  if(!var_0 scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(!scripts\mp\utility\game::istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }
  if(scripts\mp\utility\game::istrue(var_0.pers["recordedLoss"])) {
    var_0 scripts\mp\persistence::statadd("losses", -1);
    var_0 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
  }

  var_0 scripts\mp\persistence::statadd("ties", 1);
  var_0 scripts\mp\utility\game::updatepersratio("winLossRatio", "wins", "losses");
  var_0 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

updatewinlossstats(var_0) {
  if(scripts\mp\utility\game::func_D957()) {
    return;
  }
  if(!scripts\mp\utility\game::waslastround()) {
    return;
  }
  level.processedwinloss = 1;
  var_1 = level.players;
  func_12EF0();

  if(!isDefined(var_0) || isDefined(var_0) && isstring(var_0) && var_0 == "tie") {
    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && var_3 ishost()) {
        var_3 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
        continue;
      }

      func_12F42(var_3);
    }
  } else if(isplayer(var_0)) {
    if(level.hostforcedend && var_0 ishost()) {
      var_0 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
      return;
    }

    for(var_5 = 0; var_5 < min(level.placement["all"].size, 3); var_5++) {
      func_12F66(level.placement["all"][var_5]);
    }
  } else if(isstring(var_0)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(level.hostforcedend && var_3 ishost()) {
        var_3 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
        continue;
      }

      if(var_0 == "tie") {
        func_12F42(var_3);
        continue;
      }

      if(var_3.pers["team"] == var_0) {
        func_12F66(var_3);
        continue;
      }

      if(scripts\mp\utility\game::istrue(var_3.pers["recordedLoss"])) {
        var_3 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
      }
    }
  }

  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !var_3 scripts\mp\utility\game::rankingenabled()) {
      continue;
    }
    if(isai(var_3)) {
      continue;
    }
    var_9 = var_3 getrankedplayerdata("mp", "wins");

    if(var_9 >= 5) {
      var_3 giveachievement("MP_ACHIEVEMENT_1");
    }
  }
}

func_12EF0() {
  if(level.gametype != "infect") {
    return;
  }
  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "spectator" && !var_1.spectatekillcam) {
      continue;
    } else if(scripts\mp\utility\game::istrue(var_1.pers["hasDoneAnyCombat"])) {
      continue;
    } else if(var_1.team == "axis") {
      continue;
    } else {
      var_1 sethasdonecombat(var_1, 1);
    }
  }
}

freezeplayerforroundend(var_0) {
  self endon("disconnect");
  scripts\mp\utility\game::clearlowermessages();

  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  wait(var_0);
  scripts\mp\utility\game::freezecontrolswrapper(1);
}

updatematchbonusscores(var_0) {
  if(!game["timePassed"]) {
    return;
  }
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(!scripts\mp\utility\game::gettimelimit() || level.var_72B3) {
    var_1 = scripts\mp\utility\game::gettimepassed() / 1000;
    var_1 = min(var_1, 1200);
  } else
    var_1 = scripts\mp\utility\game::gettimelimit() * 60;

  if(level.teambased) {
    if(var_0 == "allies") {
      var_2 = "allies";
      var_3 = "axis";
    } else if(var_0 == "axis") {
      var_2 = "axis";
      var_3 = "allies";
    } else {
      var_2 = "tie";
      var_3 = "tie";
    }

    if(var_2 != "tie") {
      setwinningteam(var_2);
    }

    foreach(var_5 in level.players) {
      if(isDefined(var_5.connectedpostgame)) {
        continue;
      }
      if(!var_5 scripts\mp\utility\game::rankingenabled()) {
        continue;
      }
      if(var_5.timeplayed["total"] < 1 || var_5.pers["participation"] < 1) {
        continue;
      }
      if(level.hostforcedend && var_5 ishost()) {
        continue;
      }
      if(!scripts\mp\utility\game::istrue(var_5.pers["hasDoneAnyCombat"])) {
        continue;
      }
      if(var_2 == "tie") {
        var_6 = var_5 func_3716("tie", var_1);
        var_5 thread shootstopsound("tie", var_6);
        var_5.var_B3DD = var_6;
        continue;
      }

      if(isDefined(var_5.pers["team"]) && var_5.pers["team"] == var_2) {
        var_6 = var_5 func_3716("win", var_1);
        var_5 thread shootstopsound("win", var_6);
        var_5.var_B3DD = var_6;
        continue;
      }

      if(isDefined(var_5.pers["team"]) && var_5.pers["team"] == var_3) {
        var_6 = var_5 func_3716("loss", var_1);
        var_5 thread shootstopsound("loss", var_6);
        var_5.var_B3DD = var_6;
      }
    }
  } else {
    var_8 = "win";
    var_9 = "loss";

    if(!isDefined(var_0)) {
      var_8 = "tie";
      var_9 = "tie";
    }

    foreach(var_5 in level.players) {
      if(isDefined(var_5.connectedpostgame)) {
        continue;
      }
      if(var_5.timeplayed["total"] < 1 || var_5.pers["participation"] < 1) {
        continue;
      }
      if(!scripts\mp\utility\game::istrue(var_5.pers["hasDoneAnyCombat"])) {
        continue;
      }
      var_11 = 0;

      for(var_12 = 0; var_12 < min(level.placement["all"].size, 3); var_12++) {
        if(level.placement["all"][var_12] != var_5) {
          continue;
        }
        var_11 = 1;
      }

      if(var_11) {
        var_6 = var_5 func_3716(var_8, var_1);
        var_5 thread shootstopsound("win", var_6);
        var_5.var_B3DD = var_6;
        continue;
      }

      var_6 = var_5 func_3716(var_9, var_1);
      var_5 thread shootstopsound("loss", var_6);
      var_5.var_B3DD = var_6;
    }
  }
}

func_3716(var_0, var_1) {
  var_2 = scripts\mp\rank::getscoreinfovalue(var_0);
  var_3 = scripts\mp\rank::getmatchbonusspm();
  var_4 = var_1 / 60 * var_3;
  var_5 = self.timeplayed["total"] / var_1;
  var_6 = int(var_2 * var_4 * var_5);
  return var_6;
}

shootstopsound(var_0, var_1) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  scripts\mp\rank::giverankxp(var_0, var_1);

  if(scripts\mp\utility\game::waslastround()) {
    if(var_0 == "win") {
      thread scripts\mp\awards::givemidmatchaward("match_complete_win");
    } else {
      thread scripts\mp\awards::givemidmatchaward("match_complete");
    }
  }
}

setxenonranks(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.score) || !isDefined(var_3.pers["team"])) {
      continue;
    }
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.kills) || !isDefined(var_3.deaths)) {
      continue;
    }
    if(120 > var_3.timeplayed["total"]) {
      continue;
    }
    var_4 = (var_3.kills - var_3.deaths) / (var_3.timeplayed["total"] / 60);
    setplayerteamrank(var_3, var_3.clientid, var_4);
  }
}

func_3E54(var_0) {
  if(isDefined(level.timelimitoverride) && level.timelimitoverride) {
    return;
  }
  if(game["state"] != "playing") {
    setgameendtime(0);
    return;
  }

  runjiprules();

  if(scripts\mp\utility\game::gettimelimit() <= 0) {
    if(isDefined(level.starttime)) {
      setgameendtime(level.starttime);
    } else {
      setgameendtime(0);
    }

    return;
  }

  if(!scripts\mp\utility\game::gameflag("prematch_done")) {
    setgameendtime(0);
    return;
  }

  if(!isDefined(level.starttime)) {
    return;
  }
  var_1 = gettimeremaining();
  setgameendtime(gettime() + int(var_1));

  if(var_1 > 0) {
    return;
  }
  [[level.ontimelimit]]();
}

runjiprules() {
  if(!isDefined(level.nojip)) {
    level.nojip = 0;
  }

  if(!level.nojip) {
    if(scripts\mp\utility\game::isroundbased() && !level.nojip) {
      switch (level.gametype) {
        case "dom":
        case "front":
          var_0 = checkdomjiprules();
          break;
        case "siege":
        case "sd":
        case "sr":
          var_0 = checksdjiprules();
          break;
        case "ctf":
          var_0 = checkctfjiprules();
          break;
        case "ball":
          var_0 = checkballjiprules();
          break;
        case "dd":
          var_0 = checkddjiprules();
          break;
        default:
          var_0 = checkdefaultjiprules();
          break;
      }

      if(var_0) {
        setnojiptime(1);
        level.nojip = 1;
        return;
      }
    } else if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      setnojiptime(1);
      level.nojip = 1;
    }
  }
}

checkdomjiprules() {
  if(!scripts\mp\utility\game::func_9DF6()) {
    if(getteamscoreint("axis") > 150 || getteamscoreint("allies") > 150) {
      return 1;
    }

    if(scripts\mp\utility\game::gettimepassedpercentage() > 75) {
      return 1;
    }
  }

  return 0;
}

checksdjiprules() {
  var_0 = scripts\mp\utility\game::getroundswon("axis");
  var_1 = scripts\mp\utility\game::getroundswon("allies");
  var_2 = 3;

  if(scripts\mp\utility\game::isanymlgmatch()) {
    var_2 = 5;
  }

  if(var_0 >= var_2 || var_1 >= var_2) {
    return 1;
  }

  return 0;
}

checkctfjiprules() {
  if(!scripts\mp\utility\game::func_9DF6()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      return 1;
    }
  }

  var_0 = abs(getteamscoreint("axis") - getteamscoreint("allies"));

  if(var_0 > 10) {
    return 1;
  }

  return 0;
}

checkballjiprules() {
  if(!scripts\mp\utility\game::func_9DF6()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      return 1;
    }
  }

  var_0 = abs(getteamscoreint("axis") - getteamscoreint("allies"));

  if(var_0 > 15) {
    return 1;
  }

  return 0;
}

checkddjiprules() {
  var_0 = scripts\mp\utility\game::getroundswon("axis");
  var_1 = scripts\mp\utility\game::getroundswon("allies");

  if(var_0 + var_1 >= 3) {
    return 1;
  }

  return 0;
}

checkdefaultjiprules() {
  if(scripts\mp\utility\game::nextroundisfinalround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      return 1;
    }
  }

  return 0;
}

getteamscoreint(var_0) {
  return int(game["teamScores"][var_0]);
}

gettimeremaining() {
  return scripts\mp\utility\game::gettimelimit() * 60 * 1000 - scripts\mp\utility\game::gettimepassed();
}

gettimeremainingpercentage() {
  var_0 = scripts\mp\utility\game::gettimelimit() * 60 * 1000;
  return (var_0 - scripts\mp\utility\game::gettimepassed()) / var_0;
}

func_3E53(var_0) {
  if(level.roundscorelimit <= 0 || scripts\mp\utility\game::isobjectivebased()) {
    return;
  }
  if(isDefined(level.var_EC3C) && level.var_EC3C) {
    return;
  }
  if(level.gametype == "conf" || level.gametype == "jugg") {
    return;
  }
  if(!level.teambased) {
    return;
  }
  level.var_CF33 = 0;
  var_1 = 0;

  if(level.gametype == "dom" || level.gametype == "tdef") {
    var_1 = func_42AC(var_0);
  } else if(scripts\mp\utility\game::gettimepassed() > 60000) {
    var_1 = estimatedtimetillscorelimit(var_0) < 1;
  }

  if(!level.var_CF33 && var_1) {
    level.var_CF33 = 1;
    level notify("match_ending_soon", "score");
  }

  if(!level.var_CF33 && scripts\mp\utility\game::func_38F3()) {
    if(getteamscore(var_0) >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      scripts\mp\utility\game::leaderdialog("halfway_friendly_boost", var_0, "status");
      scripts\mp\utility\game::leaderdialog("halfway_enemy_boost", scripts\mp\utility\game::getotherteam(var_0), "status");
      level.didhalfscorevoboost = 1;
    }
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
  if(level.gametype == "gun") {
    if(self.score == 14) {
      level notify("match_ending_soon", "score");
    }
  } else {
    var_0 = estimatedtimetillscorelimit();

    if(var_0 < 2) {
      level notify("match_ending_soon", "score");
    }
  }
}

checkscorelimit(var_0) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill()) {
    var_0 = 1;
  }

  if(scripts\mp\utility\game::istrue(var_0)) {
    level notify("checkScoreLimit");
    level endon("checkScoreLimit");
    scripts\engine\utility::waitframe();
  }

  if(scripts\mp\utility\game::isobjectivebased()) {
    return 0;
  }

  if(isDefined(level.var_EC3C) && level.var_EC3C) {
    return 0;
  }

  if(game["state"] != "playing") {
    return 0;
  }

  if(level.roundscorelimit <= 0) {
    return 0;
  }

  var_1 = 0;

  if(level.teambased) {
    for(var_2 = 0; var_2 < level.teamnamelist.size; var_2++) {
      if(game["teamScores"][level.teamnamelist[var_2]] >= level.roundscorelimit) {
        var_1 = 1;
        break;
      }
    }
  } else {
    foreach(var_4 in level.players) {
      if(var_4.score >= level.roundscorelimit) {
        var_1 = 1;
        break;
      }
    }
  }

  if(!var_1) {
    return 0;
  }

  return func_C587(var_0);
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

func_B415() {
  thread matchstarttimer("match_starting_in", level.prematchperiod + level.var_D84E);
  waitforplayers(level.prematchperiod);

  if(level.var_D84E > 0 && !isDefined(level.hostmigrationtimer)) {
    var_0 = level.var_D84E;

    if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::func_9DF6() || scripts\mp\utility\game::ismlgmatch()) {
      var_0 = level.prematchperiod;
    }

    level notify("match_start_real_countdown", var_0);
    matchstarttimer("match_starting_in", var_0);
  }
}

matchstarttimer_internal(var_0) {
  waittillframeend;
  level endon("match_start_timer_beginning");

  while(var_0 > 0 && !level.gameended) {
    setomnvar("ui_match_start_countdown", var_0);

    if(var_0 == 0) {
      visionsetnaked("", 0);
    }

    var_0--;
    wait 1.0;
  }

  setomnvar("ui_match_start_countdown", 0);
}

matchstarttimer(var_0, var_1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_2 = int(var_1);

  if(var_2 >= 2) {
    setomnvar("ui_match_start_text", var_0);
    matchstarttimer_internal(var_2);
  }

  visionsetnaked("", 0.0);
}

func_B414() {
  visionsetnaked("", 0);
}

func_C585(var_0) {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(var_0) {
    level.var_8865 = "overtime";

    if(scripts\mp\utility\game::islastwinbytwo()) {
      var_1 = func_7E07();

      if(var_1 != game["defenders"]) {
        game["switchedsides"] = !game["switchedsides"];
        level.var_11374 = 1;
        return;
      }

      level.var_11374 = undefined;
      return;
    } else {
      game["switchedsides"] = !game["switchedsides"];
      level.var_11374 = 1;
    }
  } else {
    level.var_8865 = "halftime";
    game["switchedsides"] = !game["switchedsides"];
    level.var_11374 = 1;
  }
}

func_3E43(var_0) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(level.var_E765) || !level.var_E765) {
    return 0;
  }

  if(game["roundsPlayed"] % level.var_E765 == 0 || var_0) {
    func_C585(var_0);
    return 1;
  }

  return 0;
}

func_11939() {
  if(level.gameended) {
    var_0 = (gettime() - level.gameendtime) / 1000;
    var_1 = level.var_D706 - var_0;

    if(var_1 < 0) {
      return 0;
    }

    return var_1;
  }

  if(scripts\mp\utility\game::gettimelimit() <= 0) {
    return undefined;
  }

  if(!isDefined(level.starttime)) {
    return undefined;
  }

  var_2 = scripts\mp\utility\game::gettimelimit();
  var_0 = (gettime() - level.starttime) / 1000;
  var_1 = level.var_561F / 1000 + scripts\mp\utility\game::gettimelimit() * 60 - var_0;

  if(isDefined(level.timepaused)) {
    var_1 = var_1 + level.timepaused;
  }

  return var_1 + level.var_D706;
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

  if(isDefined(self.proxbar)) {
    self.proxbar scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self.proxbartext)) {
    self.proxbartext scripts\mp\hud_util::destroyelem();
  }
}

gethostplayer() {
  var_0 = getEntArray("player", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost()) {
      return var_0[var_1];
    }
  }
}

hostidledout() {
  var_0 = gethostplayer();

  if(isDefined(var_0) && !var_0.hasspawned && !isDefined(var_0.selectedclass)) {
    return 1;
  }

  return 0;
}

func_E761(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!var_5 scripts\mp\hud_message::isdoingsplash()) {
        continue;
      }
      var_2 = 0;
    }

    wait 0.5;
  }

  if(!level.doeomcombat) {
    setomnvarforallclients("post_game_state", 2);
  }

  foreach(var_5 in level.players) {
    var_5 thread scripts\mp\utility\game::setuipostgamefade(0.0);
  }

  if(!var_1) {
    wait(var_0);
  } else {
    wait(var_0 / 2);
    level notify("give_match_bonus");
    wait(var_0 / 2);
    var_2 = 0;

    while(!var_2) {
      var_3 = level.players;
      var_2 = 1;

      foreach(var_5 in var_3) {
        if(!var_5 scripts\mp\hud_message::isdoingsplash()) {
          continue;
        }
        var_2 = 0;
      }

      wait 0.5;
    }
  }

  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

func_E760(var_0) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

initwaypointbackgrounds() {
  level.waypointcolors["koth_enemy"] = "enemy";
  level.waypointbgtype["koth_enemy"] = 2;
  level.waypointcolors["koth_friendly"] = "friendly";
  level.waypointbgtype["koth_friendly"] = 2;
  level.waypointcolors["koth_neutral"] = "neutral";
  level.waypointbgtype["koth_neutral"] = 2;
  level.waypointcolors["waypoint_hardpoint_contested"] = "contest";
  level.waypointbgtype["waypoint_hardpoint_contested"] = 2;
  level.waypointcolors["waypoint_hardpoint_losing"] = "contest";
  level.waypointbgtype["waypoint_hardpoint_losing"] = 2;
  level.waypointcolors["waypoint_hardpoint_target"] = "neutral";
  level.waypointbgtype["waypoint_hardpoint_target"] = 2;
  level.waypointcolors["waypoint_taking_chevron"] = "contest";
  level.waypointbgtype["waypoint_taking_chevron"] = 2;
  level.waypointcolors["waypoint_ball_download"] = "neutral";
  level.waypointbgtype["waypoint_ball_download"] = 1;
  level.waypointcolors["waypoint_ball_pass"] = "friendly";
  level.waypointbgtype["waypoint_ball_pass"] = 1;
  level.waypointcolors["waypoint_ball_upload"] = "neutral";
  level.waypointbgtype["waypoint_ball_upload"] = 1;
  level.waypointcolors["waypoint_neutral_ball"] = "neutral";
  level.waypointbgtype["waypoint_neutral_ball"] = 1;
  level.waypointcolors["waypoint_capture_a"] = "enemy";
  level.waypointbgtype["waypoint_capture_a"] = 2;
  level.waypointcolors["waypoint_capture_b"] = "enemy";
  level.waypointbgtype["waypoint_capture_b"] = 2;
  level.waypointcolors["waypoint_capture_c"] = "enemy";
  level.waypointbgtype["waypoint_capture_c"] = 2;
  level.waypointcolors["waypoint_defend_a"] = "friendly";
  level.waypointbgtype["waypoint_defend_a"] = 2;
  level.waypointcolors["waypoint_defend_b"] = "friendly";
  level.waypointbgtype["waypoint_defend_b"] = 2;
  level.waypointcolors["waypoint_defend_c"] = "friendly";
  level.waypointbgtype["waypoint_defend_c"] = 2;
  level.waypointcolors["waypoint_losing_a"] = "contest";
  level.waypointbgtype["waypoint_losing_a"] = 2;
  level.waypointcolors["waypoint_losing_b"] = "contest";
  level.waypointbgtype["waypoint_losing_b"] = 2;
  level.waypointcolors["waypoint_losing_c"] = "contest";
  level.waypointbgtype["waypoint_losing_c"] = 2;
  level.waypointcolors["waypoint_bomb"] = "neutral";
  level.waypointbgtype["waypoint_bomb"] = 2;
  level.waypointcolors["waypoint_bomb_defusing"] = "contest";
  level.waypointbgtype["waypoint_bomb_defusing"] = 2;
  level.waypointcolors["waypoint_bomb_planting"] = "contest";
  level.waypointbgtype["waypoint_bomb_planting"] = 2;
  level.waypointcolors["waypoint_defuse_a"] = "enemy";
  level.waypointbgtype["waypoint_defuse_a"] = 2;
  level.waypointcolors["waypoint_defuse_b"] = "enemy";
  level.waypointbgtype["waypoint_defuse_b"] = 2;
  level.waypointcolors["waypoint_bank_a"] = "neutral";
  level.waypointbgtype["waypoint_bank_a"] = 2;
  level.waypointcolors["waypoint_bank_b"] = "neutral";
  level.waypointbgtype["waypoint_bank_b"] = 2;
  level.waypointcolors["waypoint_blitz_defend"] = "friendly";
  level.waypointbgtype["waypoint_blitz_defend"] = 2;
  level.waypointcolors["waypoint_blitz_defend_round"] = "friendly";
  level.waypointbgtype["waypoint_blitz_defend_round"] = 1;
  level.waypointcolors["waypoint_defend_round"] = "friendly";
  level.waypointbgtype["waypoint_defend_round"] = 1;
  level.waypointcolors["waypoint_blitz_goal"] = "enemy";
  level.waypointbgtype["waypoint_blitz_goal"] = 2;
  level.waypointcolors["waypoint_uplink_contested"] = "contest";
  level.waypointbgtype["waypoint_uplink_contested"] = 2;
  level.waypointcolors["waypoint_dogtags"] = "enemy";
  level.waypointcolors["waypoint_dogtags_friendlys"] = "friendly";
  level.waypointcolors["waypoint_taking_flag"] = "contest";
  level.waypointbgtype["waypoint_taking_flag"] = 2;
  level.waypointcolors["waypoint_capture_kill"] = "enemy";
  level.waypointbgtype["waypoint_capture_kill"] = 2;
  level.waypointcolors["waypoint_capture_kill_round"] = "enemy";
  level.waypointbgtype["waypoint_capture_kill_round"] = 1;
  level.waypointcolors["waypoint_capture_recover"] = "friendly";
  level.waypointbgtype["waypoint_capture_recover"] = 2;
  level.waypointcolors["waypoint_capture_take"] = "enemy";
  level.waypointbgtype["waypoint_capture_take"] = 2;
  level.waypointcolors["waypoint_captureneutral_a"] = "neutral";
  level.waypointbgtype["waypoint_captureneutral_a"] = 2;
  level.waypointcolors["waypoint_captureneutral_b"] = "neutral";
  level.waypointbgtype["waypoint_captureneutral_b"] = 2;
  level.waypointcolors["waypoint_captureneutral_c"] = "neutral";
  level.waypointbgtype["waypoint_captureneutral_c"] = 2;
  level.waypointcolors["waypoint_contested_a"] = "contest";
  level.waypointbgtype["waypoint_contested_a"] = 2;
  level.waypointcolors["waypoint_contested_b"] = "contest";
  level.waypointbgtype["waypoint_contested_b"] = 2;
  level.waypointcolors["waypoint_contested_c"] = "contest";
  level.waypointbgtype["waypoint_contested_c"] = 2;
  level.waypointcolors["waypoint_escort"] = "friendly";
  level.waypointbgtype["waypoint_escort"] = 1;
  level.waypointcolors["waypoint_reset_marker"] = "contest";
  level.waypointbgtype["waypoint_reset_marker"] = 2;
  level.waypointcolors["waypoint_returning_flag"] = "contest";
  level.waypointbgtype["waypoint_returning_flag"] = 2;
  level.waypointcolors["waypoint_scoring_foe_a"] = "enemy";
  level.waypointbgtype["waypoint_scoring_foe_a"] = 2;
  level.waypointcolors["waypoint_scoring_foe_b"] = "enemy";
  level.waypointbgtype["waypoint_scoring_foe_b"] = 2;
  level.waypointcolors["waypoint_scoring_friend_a"] = "friendly";
  level.waypointbgtype["waypoint_scoring_friend_a"] = 2;
  level.waypointcolors["waypoint_scoring_friend_b"] = "friendly";
  level.waypointbgtype["waypoint_scoring_friend_b"] = 2;
  level.waypointcolors["waypoint_taking_a"] = "contest";
  level.waypointbgtype["waypoint_taking_a"] = 2;
  level.waypointcolors["waypoint_taking_b"] = "contest";
  level.waypointbgtype["waypoint_taking_b"] = 2;
  level.waypointcolors["waypoint_taking_c"] = "contest";
  level.waypointbgtype["waypoint_taking_c"] = 2;
  level.waypointcolors["waypoint_target_a"] = "enemy";
  level.waypointbgtype["waypoint_target_a"] = 2;
  level.waypointcolors["waypoint_target_b"] = "enemy";
  level.waypointbgtype["waypoint_target_b"] = 2;
}

callback_startgametype() {
  scripts\mp\load::main();
  scripts\mp\utility\game::levelflaginit("round_over", 0);
  scripts\mp\utility\game::levelflaginit("game_over", 0);
  scripts\mp\utility\game::levelflaginit("block_notifies", 0);
  scripts\mp\utility\game::levelflaginit("post_game_level_event_active", 0);
  level.prematchperiod = 0;
  level.var_D84E = 0;
  level.var_D701 = 0;
  level.intermission = 0;
  setdvar("bg_compassShowEnemies", getdvar("scr_game_forceuav"));

  if(scripts\mp\utility\game::matchmakinggame()) {
    setdvar("isMatchMakingGame", 1);
  } else {
    setdvar("isMatchMakingGame", 0);
  }

  if(level.multiteambased) {
    setdvar("ui_numteams", level.var_C246);
  }

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    game["truncated_killcams"] = 0;

    if(!isDefined(game["attackers"]) || !isDefined(game["defenders"])) {
      thread scripts\engine\utility::error("No attackers or defenders team defined in level .gsc.");
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

    game["allies"] = "UNSA";
    game["axis"] = "SDF";
    game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
    game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
    game["strings"]["spawn_flag_wait"] = &"MP_SPAWN_FLAG_WAIT";
    game["strings"]["spawn_point_capture_wait"] = &"MP_SPAWN_POINT_CAPTURE_WAIT";
    game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
    game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
    game["strings"]["waiting_to_safespawn"] = &"MP_WAITING_TO_SAFESPAWN";
    game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
    game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["change_rig"] = &"LUA_MENU_MP_CHANGE_RIG_NEXT_SPAWN";
    game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
    game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
    game["strings"]["c4_death"] = &"MPUI_C4_DEATH";
    game["strings"]["must_select_loadout_to_spawn"] = &"MP_INGAME_ONLY_SELECT_LOADOUT_TO_SPAWN";
    game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
    game["colors"]["black"] = (0, 0, 0);
    game["colors"]["white"] = (1, 1, 1);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);
    game["colors"]["orange"] = (0.9, 0.6, 0);
    game["colors"]["blue"] = (0.2, 0.3, 0.7);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0);
    game["strings"]["allies_name"] = scripts\mp\teams::isonladder("allies");
    game["icons"]["allies"] = scripts\mp\teams::_meth_81B2("allies");
    game["colors"]["allies"] = scripts\mp\teams::_meth_81A4("allies");
    game["strings"]["axis_name"] = scripts\mp\teams::isonladder("axis");
    game["icons"]["axis"] = scripts\mp\teams::_meth_81B2("axis");
    game["colors"]["axis"] = scripts\mp\teams::_meth_81A4("axis");
    game["colors"]["friendly"] = (0.258824, 0.639216, 0.87451);
    game["colors"]["enemy"] = (0.929412, 0.231373, 0.141176);
    game["colors"]["contest"] = (1, 0.858824, 0);
    game["colors"]["neutral"] = (1, 1, 1);
    initwaypointbackgrounds();

    if(game["colors"]["allies"] == game["colors"]["black"]) {
      game["colors"]["allies"] = game["colors"]["grey"];
    }

    if(game["colors"]["axis"] == game["colors"]["black"]) {
      game["colors"]["axis"] = game["colors"]["grey"];
    }

    [[level.onprecachegametype]]();
    setdvarifuninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        if(scripts\mp\utility\game::ismlgmatch() || isdedicatedserver()) {
          level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "graceperiod_comp");
        } else {
          level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
        }

        level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
      }
    } else {
      if(scripts\mp\utility\game::ismlgmatch() || isdedicatedserver()) {
        level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "playerwaittime_comp");
      } else {
        level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "playerwaittime");
      }

      level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
    }

    setnojipscore(0);
    setnojiptime(0);
  } else {
    setdvarifuninitialized("min_wait_for_players", 5);

    if(level.console) {
      if(!level.splitscreen) {
        level.prematchperiod = 5;
        level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
      }
    } else {
      level.prematchperiod = 5;
      level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
    }
  }

  if(!isDefined(game["status"])) {
    game["status"] = "normal";
  }

  setdvar("ui_overtime", scripts\mp\utility\game::inovertime());

  if(game["status"] != "overtime" && game["status"] != "halftime") {
    if(!(isDefined(game["switchedsides"]) && game["switchedsides"] == 1 && scripts\mp\utility\game::ismoddedroundgame())) {
      game["teamScores"]["allies"] = 0;
      game["teamScores"]["axis"] = 0;
    }

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        game["teamScores"][level.teamnamelist[var_0]] = 0;
      }
    }
  }

  if(!isDefined(game["timePassed"])) {
    game["timePassed"] = 0;
  }

  if(!isDefined(game["roundsPlayed"])) {
    game["roundsPlayed"] = 0;
  }

  if(!isDefined(game["overtimeRoundsPlayed"])) {
    game["overtimeRoundsPlayed"] = 0;
  }

  if(!isDefined(game["finalRound"])) {
    game["finalRound"] = 0;
  }

  setomnvar("ui_last_round", game["finalRound"]);

  if(!isDefined(game["roundsWon"])) {
    game["roundsWon"] = [];
  }

  if(!isDefined(game["timeToBeat"])) {
    game["timeToBeat"] = 0;
  }

  if(!isDefined(game["timeToBeatOld"])) {
    game["timeToBeatOld"] = 0;
  }

  if(!isDefined(game["timeToBeatTeam"])) {
    game["timeToBeatTeam"] = "none";
  }

  if(!isDefined(game["timeToBeatScore"])) {
    game["timeToBeatScore"] = 0;
  }

  if(level.teambased) {
    if(!isDefined(game["roundsWon"]["axis"])) {
      game["roundsWon"]["axis"] = 0;
    }

    if(!isDefined(game["roundsWon"]["allies"])) {
      game["roundsWon"]["allies"] = 0;
    }

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        if(!isDefined(game["roundsWon"][level.teamnamelist[var_0]])) {
          game["roundsWon"][level.teamnamelist[var_0]] = 0;
        }
      }
    }
  }

  level.gameended = 0;
  level.var_72B3 = 0;
  level.hostforcedend = 0;
  level.hardcoremode = getdvarint("g_hardcore");
  level.tactical = scripts\mp\utility\game::matchmakinggame() && getdvarint("scr_tactical") || getdvarint("scr_game_tacticalmode");
  var_1 = scripts\mp\utility\game::isanymlgmatch() || level.tactical;
  setdvar("disable_energy_bullet_ricochet", var_1);

  if(level.tactical) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
    setdvar("jump_slowdownEnable", 1);
    setdvar("sprintLeap_enabled", 0);
    setdvar("scr_" + level.gametype + "_doubleJump", 1);
    setdvar("scr_game_doubleJump", 1);
    level.supportdoublejump_MAYBE = 1;
  }

  if(level.hardcoremode) {
    logstring("game mode: hardcore");
  }

  level.diehardmode = getdvarint("scr_diehard");
  level.var_3B1E = getdvarint("scr_game_casualScoreStreaks");

  if(!isDefined(level.crankedbombtimer)) {
    level.crankedbombtimer = getdvarint("scr_" + level.gametype + "_crankedBombTimer", 0);
  }

  level.supportcranked = scripts\engine\utility::ter_op(getdvarint("scr_" + level.gametype + "_crankedBombTimer") > 0, 1, 0);

  if(!level.teambased) {
    level.diehardmode = 0;
  }

  if(level.diehardmode) {
    logstring("game mode: diehard");
  }

  level.allowkillstreaks = scripts\mp\utility\game::botgetworldsize("scr_" + level.gametype + "_allowKillstreaks", "scr_game_allowKillstreaks");
  level.allowperks = scripts\mp\utility\game::botgetworldsize("scr_" + level.gametype + "_allowPerks", "scr_game_allowPerks");
  level.allowsupers = scripts\mp\utility\game::botgetworldsize("scr_" + level.gametype + "_allowSupers", "scr_game_allowSupers");
  level.var_11260 = scripts\mp\utility\game::botgetworldsize("scr_" + level.gametype + "_superFastChargeRate", "scr_game_superFastChargeRate");
  level.superpointsmod = scripts\mp\utility\game::botgetworldclosestedge("scr_" + level.gametype + "_superPointsMod", "scr_game_superPointsMod");

  if(!level.tactical) {
    level.supportdoublejump_MAYBE = scripts\mp\utility\game::botgetworldsize("scr_" + level.gametype + "_doubleJump", "scr_game_doubleJump");
  }

  level.supportwallrun_MAYBE = scripts\mp\utility\game::botgetworldsize("scr_" + level.gametype + "_wallRun", "scr_game_wallRun");
  level.spawnprotectiontimer = scripts\mp\utility\game::botgetworldclosestedge("scr_" + level.gametype + "_spawnProtectionTimer", "scr_game_spawnProtectionTimer");
  level.scoremod = [];
  level.scoremod["kill"] = getdvarint("scr_" + level.gametype + "_pointsPerKill");
  level.scoremod["death"] = getdvarint("scr_" + level.gametype + "_pointsPerDeath");
  level.scoremod["headshot"] = getdvarint("scr_" + level.gametype + "_pointsHeadshotBonus");
  level.var_B4A1 = 5;
  level.var_B4A0 = 32;
  level.usestartspawns = 1;
  level.maxallowedteamkills = scripts\mp\utility\game::botgetworldsize("scr_" + level.gametype + "_ffPunishLimit", "scr_game_ffPunishLimit");
  thread scripts\mp\powerloot::init();
  thread scripts\mp\healthoverlay::init();
  thread scripts\mp\killcam::init();
  thread scripts\mp\finalkillcam::func_9807();
  thread scripts\mp\battlechatter_mp::init();
  thread scripts\mp\music_and_dialog::init();
  thread[[level.var_9994]]();
  thread scripts\mp\class::init();
  thread scripts\mp\persistence::init();
  thread scripts\mp\missions::init();
  thread scripts\mp\rank::init();
  thread scripts\mp\playercards::init();
  thread scripts\mp\menus::init();
  thread scripts\mp\hud::init();
  thread scripts\mp\serversettings::init();
  thread scripts\mp\teams::init();
  thread scripts\mp\weapons::init();
  thread scripts\mp\outline::init();
  thread scripts\mp\shellshock::init();
  thread scripts\mp\deathicons::init();
  thread scripts\mp\damagefeedback::init();
  thread scripts\mp\lightarmor::init();
  thread scripts\mp\killstreaks\chill_common::chill_init();
  thread scripts\mp\objpoints::init();
  thread scripts\mp\gameobjects::init();
  thread scripts\mp\spectating::init();
  thread scripts\mp\spawnlogic::init();
  thread scripts\mp\matchdata::init();
  thread scripts\mp\clientmatchdata::init();
  thread scripts\mp\awards::init();
  thread scripts\mp\areas::init();
  thread scripts\mp\func_0A83::init();
  thread scripts\mp\killstreak_loot::init();
  thread[[level.var_A6A2]]();
  thread scripts\mp\passives::init();
  thread scripts\mp\perks::init();
  thread scripts\mp\events::init();
  thread scripts\mp\defcon::init();
  thread[[level.var_B3E7]]();
  thread scripts\mp\zipline::init();
  thread scripts\mp\archetypes\archcommon::init();
  thread scripts\mp\powers::init();
  thread scripts\mp\drone::init();
  thread scripts\mp\whizby::init();
  thread scripts\mp\analyticslog::init();
  thread scripts\mp\loot::init();
  thread scripts\mp\supers::init();
  thread scripts\mp\callouts::init();
  thread func_1C74();
  thread ismp_init();
  thread scripts\mp\weapons::func_13AB2();
  thread scripts\mp\supers::func_13B6B();
  thread scripts\mp\gestures::init();
  thread scripts\mp\sentientpoolmanager::init();
  thread scripts\mp\objidpoolmanager::init();
  thread scripts\mp\contracts::init();
  thread scripts\mp\utility\game::initarbitraryuptriggers();
  thread scripts\mp\broshot::initbroshotfx();

  if(level.teambased) {
    thread scripts\mp\friendicons::init();
  }

  thread scripts\mp\hud_message::init();

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    thread scripts\mp\codcasterclientmatchdata::init();
  }

  game["gamestarted"] = 1;
  level.currentround = game["roundsPlayed"] + 1;
  level.maxplayercount = 0;
  level.wavedelay["allies"] = 0;
  level.wavedelay["axis"] = 0;
  level.lastwave["allies"] = 0;
  level.lastwave["axis"] = 0;
  level.waveplayerspawnindex["allies"] = 0;
  level.waveplayerspawnindex["axis"] = 0;
  level.var_1BE7["allies"] = [];
  level.var_1BE7["axis"] = [];
  level.var_1659 = [];

  if(level.multiteambased) {
    for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
      level.var_1461[level.teamnamelist[var_0]] = 0;
      level.var_1301[level.teamnamelist[var_0]] = 0;
      level.var_1462[level.teamnamelist[var_0]] = 0;
      level.var_1168[level.teamnamelist[var_0]] = [];
    }
  }

  setomnvar("ui_scorelimit", 0);
  setdvar("ui_allow_teamchange", 1);
  setomnvar("ui_round_hint_override_attackers", 0);
  setomnvar("ui_round_hint_override_defenders", 0);

  if(scripts\mp\utility\game::getgametypenumlives()) {
    setdvar("g_deadChat", 0);
  } else {
    setdvar("g_deadChat", 1);
  }

  var_2 = getdvarint("scr_" + level.gametype + "_waverespawndelay");

  if(var_2) {
    level.wavedelay["allies"] = var_2;
    level.wavedelay["axis"] = var_2;
    level.lastwave["allies"] = 0;
    level.lastwave["axis"] = 0;

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        level.var_1461[level.teamnamelist[var_0]] = var_2;
        level.var_1301[level.teamnamelist[var_0]] = 0;
      }
    }

    level thread func_13BE6();
  }

  scripts\mp\utility\game::gameflaginit("prematch_done", 0);
  level._meth_8487 = 15;
  level.ingraceperiod = level._meth_8487;
  scripts\mp\utility\game::gameflaginit("graceperiod_done", 0);
  level.playovertime = 0;
  level.var_E75F = 6.0;
  level.var_6C71 = 3;
  level.var_8864 = 3;
  level.noragdollents = getEntArray("noragdoll", "targetname");
  level.scorelimit = scripts\mp\utility\game::getwatcheddvar("scorelimit");
  level.roundlimit = scripts\mp\utility\game::getwatcheddvar("roundlimit");
  level.winlimit = scripts\mp\utility\game::getwatcheddvar("winlimit");

  if(level.roundlimit != 1) {
    setomnvar("ui_current_round", level.currentround);
  }

  if(level.scorelimit == 1) {
    level.roundscorelimit = 1;
    level.totalscorelimit = level.winlimit;
  } else {
    level.roundscorelimit = level.scorelimit * (game["roundsPlayed"] + 1);
    level.totalscorelimit = level.scorelimit * level.roundlimit;
  }

  if(scripts\mp\utility\game::func_E269()) {
    level.roundscorelimit = level.scorelimit;
    level.totalscorelimit = level.scorelimit;
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
  }

  if(scripts\mp\utility\game::func_9ECF() && scripts\mp\utility\game::inovertime()) {
    scripts\mp\gamescore::func_12EE5();
  }

  if(level.teambased) {
    scripts\mp\gamescore::updateteamscore("axis");
    scripts\mp\gamescore::updateteamscore("allies");

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        scripts\mp\gamescore::updateteamscore(level.teamnamelist[var_0]);
      }
    }
  }

  thread func_12F54();
  level notify("update_scorelimit");

  if(isDefined(level.matchrecording_init)) {
    level thread[[level.matchrecording_init]]();
  }

  [[level.onstartgametype]]();
  level.var_EC3F = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off", 80);
  level.timepercentagecutoff = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off", 80);

  if(!level.console && (getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server")) {
    thread func_132A3();
  }

  thread func_10D9F();
  level thread scripts\mp\utility\game::func_12F5B();
  level thread timelimitthread();
  level thread scripts\mp\finalkillcam::func_5853();
  level thread updateleaderboardstatscontinuous();
}

func_132A3() {
  for(;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!getdvarint("xblive_privatematch")) {
      exitlevel(0);
    }

    if(getdvar("dedicated") != "dedicated LAN server" && getdvar("dedicated") != "dedicated internet server") {
      exitlevel(0);
    }

    wait 5;
  }
}

timelimitthread() {
  level endon("game_ended");
  var_0 = scripts\mp\utility\game::gettimepassed();

  while(game["state"] == "playing") {
    thread func_3E54(var_0);
    var_0 = scripts\mp\utility\game::gettimepassed();

    if(isDefined(level.starttime)) {
      if(gettimeremaining() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

func_12F54() {
  for(;;) {
    level scripts\engine\utility::waittill_either("update_scorelimit", "update_winlimit");

    if(scripts\mp\utility\game::inovertime()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        foreach(var_1 in level.players) {
          var_1 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_1.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_1 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_1.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::iswinbytworulegametype()) {
        var_3 = game["roundsWon"][game["defenders"]];
        var_4 = game["roundsWon"][game["attackers"]];
        var_5 = 0;

        if(var_3 == var_4) {
          var_5 = var_3 + 2;
        } else if(var_3 > var_4) {
          var_5 = var_3 + 1;
        } else {
          var_5 = var_4 + 1;
        }

        setomnvar("ui_scorelimit", var_5);
      } else
        usenormalscorelimit();

      continue;
    }

    usenormalscorelimit();
  }
}

usenormalscorelimit() {
  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    setomnvar("ui_scorelimit", level.totalscorelimit);
    thread checkscorelimit();
  } else
    setomnvar("ui_scorelimit", level.winlimit);
}

playtickingsound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  var_0 = level.bombtimer;

  for(;;) {
    self playSound("ui_mp_suitcasebomb_timer");

    if(var_0 > 10) {
      var_0 = var_0 - 1;
      wait 1;
    } else if(var_0 > 4) {
      var_0 = var_0 - 0.5;
      wait 0.5;
    } else if(var_0 > 1) {
      var_0 = var_0 - 0.4;
      wait 0.4;
    } else {
      var_0 = var_0 - 0.3;
      wait 0.3;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

stoptickingsound() {
  self notify("stop_ticking");
}

func_118F7() {
  level endon("game_ended");
  wait 0.05;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 hide();
  var_1 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["state"] == "playing") {
    if(!level.var_1191F && scripts\mp\utility\game::gettimelimit()) {
      var_2 = gettimeremaining() / 1000;
      var_3 = int(var_2 + 0.5);

      if(var_3 >= 30 && var_3 <= 60) {
        level notify("match_ending_soon", "time");
      }

      if(var_3 <= 10 || var_3 <= 30 && var_3 % var_1 == 0) {
        level notify("match_ending_very_soon");

        if(var_3 == 0) {
          break;
        }
        var_0 playSound("ui_mp_timer_countdown");
      }

      if(var_2 - floor(var_2) >= 0.05) {
        wait(var_2 - floor(var_2));
      }
    }

    wait 1.0;
  }
}

func_7687() {
  level endon("game_ended");

  if(isDefined(game["startTimeFromMatchStart"])) {
    level.starttimefrommatchstart = game["startTimeFromMatchStart"];
  }

  level waittill("prematch_over");
  level.starttime = gettime();
  level.var_561F = 0;

  if(!isDefined(game["startTimeFromMatchStart"])) {
    game["startTimeFromMatchStart"] = gettime();
    level.starttimefrommatchstart = gettime();
    scripts\mp\matchdata::func_C558();
  }

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundStartTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  var_0 = gettime();

  while(game["state"] == "playing") {
    if(!level.var_1191F) {
      game["timePassed"] = game["timePassed"] + (gettime() - var_0);
    }

    var_0 = gettime();
    wait 1.0;
  }
}

func_12F45(var_0) {
  var_1 = level.timerstoppedforgamemode || isDefined(level.hostmigrationtimer);

  if(!scripts\mp\utility\game::gameflag("prematch_done")) {
    var_1 = 0;
  }

  if(!level.var_1191F && var_1) {
    level.var_1191F = 1;
    level.var_1191E = gettime();
    var_2 = gettimeremaining();

    if(isDefined(var_0)) {
      setgameendtime(var_0);
    } else {
      setgameendtime(gettime() + int(var_2));
    }

    setomnvar("ui_match_timer_stopped", 1);
  } else if(level.var_1191F && !var_1) {
    level.var_1191F = 0;
    level.var_561F = level.var_561F + (gettime() - level.var_1191E);
    var_2 = gettimeremaining();

    if(isDefined(var_0)) {
      setgameendtime(var_0);
    } else {
      setgameendtime(gettime() + int(var_2));
    }

    setomnvar("ui_match_timer_stopped", 0);
  }
}

pausetimer(var_0) {
  level.timerstoppedforgamemode = 1;
  func_12F45(var_0);
}

resumetimer(var_0) {
  level.timerstoppedforgamemode = 0;
  func_12F45(var_0);
}

func_10D9F() {
  setslowmotion(1, 1, 0);
  thread func_7687();
  level.var_1191F = 0;
  level.timerstoppedforgamemode = 0;
  setomnvar("ui_prematch_period", 1);
  prematchperiod();
  _sysprint("MatchStarted: Completed");
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();
  scripts\mp\utility\game::gameflagset("prematch_done");
  level notify("prematch_over");
  setomnvar("ui_prematch_period", 0);
  func_12F45();

  if(scripts\mp\utility\game::gettimelimit() > 0) {
    setomnvar("ui_match_timer_hidden", 0);
  } else {
    setomnvar("ui_match_timer_hidden", 1);
  }

  thread func_118F7();
  thread _meth_8487();
  thread scripts\mp\missions::func_E75B();
}

func_13BE6() {
  level endon("game_ended");

  while(game["state"] == "playing") {
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
      for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
        if(var_0 - level.lastwave[level.teamnamelist[var_1]] > level.var_1461[level.teamnamelist[var_1]] * 1000) {
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

func_7E07() {
  var_0["allies"] = 0;
  var_0["axis"] = 0;
  var_1["allies"] = 0;
  var_1["axis"] = 0;

  foreach(var_3 in level.players) {
    var_4 = var_3.pers["team"];

    if(isDefined(var_4) && (var_4 == "allies" || var_4 == "axis")) {
      var_0[var_4] = var_0[var_4] + var_3.kills;
      var_1[var_4] = var_1[var_4] + var_3.deaths;
    }
  }

  if(var_0["allies"] > var_0["axis"]) {
    return "allies";
  } else if(var_0["axis"] > var_0["allies"]) {
    return "axis";
  }

  if(var_1["allies"] < var_1["axis"]) {
    return "allies";
  } else if(var_1["axis"] < var_1["allies"]) {
    return "axis";
  }

  if(randomint(2) == 0) {
    return "allies";
  }

  return "axis";
}

rankedmatchupdates(var_0) {
  if(scripts\mp\utility\game::matchmakinggame()) {
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

func_56E0(var_0, var_1) {
  if(level.var_8865 == "halftime" && level.roundlimit && game["roundsPlayed"] * 2 == level.roundlimit) {
    foreach(var_3 in level.players) {
      var_3 setplayermusicstate("mus_mp_halftime");
    }
  } else if(level.playovertime) {
    foreach(var_3 in level.players) {
      var_3 setplayermusicstate("mus_mp_halftime");
    }
  } else if(level.var_8865 == "halftime" && !level.roundlimit) {
    foreach(var_3 in level.players) {
      var_3 setplayermusicstate("mus_mp_halftime");
    }
  }

  if(!level.doeomcombat && scripts\mp\utility\game::ismoddedroundgame() && game["finalRound"] == 0) {
    var_0 = "roundend";
  }

  foreach(var_3 in level.players) {
    if(level.teambased) {
      var_3 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 1, var_1);
      continue;
    }

    var_3 thread scripts\mp\hud_message::func_C752(var_0, var_1);
  }
}

func_56DA(var_0, var_1) {
  setomnvar("ui_match_over", 1);

  foreach(var_3 in level.players) {
    if(level.teambased) {
      var_3 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 0, var_1);
      continue;
    }

    var_3 thread scripts\mp\hud_message::func_C752(var_0, var_1);
  }

  level notify("game_win", var_0);
}

func_56E1() {
  level notify("spawning_intermission");

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\playerlogic::spawnintermission();
  }

  var_3 = level.var_8865;

  if(var_3 == "halftime") {
    if(level.roundlimit) {
      if(game["roundsPlayed"] * 2 == level.roundlimit) {
        var_3 = "halftime";
      } else {
        var_3 = "intermission";
      }
    } else
      var_3 = "intermission";
  }

  level notify("round_switch", var_3);

  if(game["finalRound"] == 1) {
    var_3 = "finalround";
  }

  var_4 = 0;

  if(isDefined(level.var_11374)) {
    var_4 = game["end_reason"]["switching_sides"];
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\hud_message::teamoutcomenotify(var_3, 1, var_4);
  }

  func_E761(level.var_8864, 0);
}

func_7384(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(var_0 > 0 && var_3) {
    thread slowmotionendofgame(var_0);
  }

  if(var_0 > 1 && !scripts\mp\utility\game::istrue(level.nukegameover)) {
    thread func_636B(var_0);
  }

  thread sendgameendedfrozennotify(var_0);

  foreach(var_5 in level.players) {
    var_5 thread freezeplayerforroundend(var_0);
    var_5 thread func_E760(4.0);
    var_5 freegameplayhudelems();
    var_5 setclientdvars("cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0);

    if(isDefined(var_1) && isDefined(var_2)) {
      if(var_1 == "cg_fovScale" && var_5 issplitscreenplayer()) {
        var_5 setclientdvars(var_1, 0.75);
      }

      var_5 setclientdvars(var_1, var_2);
    }
  }

  foreach(var_8 in level.agentarray) {
    var_8 scripts\mp\utility\game::freezecontrolswrapper(1);
  }
}

func_636B(var_0) {
  var_1 = var_0 * 1.3;
  visionsetfadetoblack("bw", var_1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);
}

slowmotionendofgame(var_0) {
  setslowmotion(1.0, 0.4, var_0);
  setendofroundsoundtimescalefactor();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  setslowmotion(1.0, 1, 0);
  resetsoundtimescalefactor();
}

setendofroundsoundtimescalefactor() {
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("voice_air_3d", 0);
  soundsettimescalefactor("voice_radio_3d", 0);
  soundsettimescalefactor("voice_radio_2d", 0);
  soundsettimescalefactor("voice_narration_2d", 0);
  soundsettimescalefactor("voice_special_2d", 0);
  soundsettimescalefactor("voice_bchatter_1_3d", 0);
  soundsettimescalefactor("plr_ui_ingame_unres_2d", 0);
  soundsettimescalefactor("hurt_nofilter_2d", 0.15);
  soundsettimescalefactor("amb_bed_2d", 0.25);
  soundsettimescalefactor("amb_elm_ext_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_int_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_unres_3d", 0.25);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.25);
  soundsettimescalefactor("reload_plr_res_2d", 0.3);
  soundsettimescalefactor("reload_plr_unres_2d", 0.3);
  soundsettimescalefactor("scn_fx_unres_3d", 0.25);
  soundsettimescalefactor("scn_fx_unres_2d", 0.25);
  soundsettimescalefactor("scn_lfe_unres_2d", 0);
  soundsettimescalefactor("scn_lfe_unres_3d", 0);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0.25);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0.25);
  soundsettimescalefactor("weap_npc_main_3d", 0.25);
  soundsettimescalefactor("weap_npc_mech_3d", 0.25);
  soundsettimescalefactor("weap_npc_mid_3d", 0.25);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.25);
  soundsettimescalefactor("weap_npc_lo_3d", 0.25);
  soundsettimescalefactor("melee_npc_3d", 0.25);
  soundsettimescalefactor("melee_plr_2d", 0.25);
  soundsettimescalefactor("special_hi_unres_1_3d", 0.25);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.25);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0.3);
  soundsettimescalefactor("scn_fx_unres_2d_lim", 0.3);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("shock1_nofilter_3d", 0.25);
  soundsettimescalefactor("equip_use_unres_3d", 0.3);
  soundsettimescalefactor("explo_1_3d", 0.3);
  soundsettimescalefactor("explo_2_3d", 0.3);
  soundsettimescalefactor("explo_3_3d", 0.3);
  soundsettimescalefactor("explo_4_3d", 0.3);
  soundsettimescalefactor("explo_5_3d", 0.3);
  soundsettimescalefactor("explo_lfe_3d", 0.3);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0.3);
  soundsettimescalefactor("projectile_loop_close", 0.3);
  soundsettimescalefactor("projectile_loop_mid", 0.3);
  soundsettimescalefactor("projectile_loop_dist", 0.3);
}

resetsoundtimescalefactor() {
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
  soundsettimescalefactor("scn_fx_unres_2d", 0);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0);
  soundsettimescalefactor("weap_npc_main_3d", 0);
  soundsettimescalefactor("weap_npc_mech_3d", 0);
  soundsettimescalefactor("weap_npc_mid_3d", 0);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0);
  soundsettimescalefactor("weap_npc_lo_3d", 0);
  soundsettimescalefactor("melee_npc_3d", 0);
  soundsettimescalefactor("melee_plr_2d", 0);
  soundsettimescalefactor("special_hi_unres_1_3d", 0);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0);
  soundsettimescalefactor("scn_fx_unres_2d_lim", 0);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("equip_use_unres_3d", 0);
  soundsettimescalefactor("explo_1_3d", 0);
  soundsettimescalefactor("explo_2_3d", 0);
  soundsettimescalefactor("explo_3_3d", 0);
  soundsettimescalefactor("explo_4_3d", 0);
  soundsettimescalefactor("explo_5_3d", 0);
  soundsettimescalefactor("explo_lfe_3d", 0);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0);
  soundsettimescalefactor("projectile_loop_close", 0);
  soundsettimescalefactor("projectile_loop_mid", 0);
  soundsettimescalefactor("projectile_loop_dist", 0);
}

sendgameendedfrozennotify(var_0) {
  wait(var_0);
  level notify("game_ended_frozen");
}

func_E2A9() {
  setomnvarforallclients("post_game_state", 0);
  level notify("restarting");
  game["state"] = "playing";
  map_restart(1);
}

endgame(var_0, var_1, var_2) {
  if(isDefined(level.endgame)) {
    [[level.endgame]](var_0, var_1);
  } else {
    func_6322(var_0, var_1, var_2);
  }
}

func_6322(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(level.gameended) {
    return;
  }
  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundEndTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  scripts\mp\matchdata::func_C557();
  var_3 = 0;

  if(level.hostforcedend || level.var_72B3) {
    var_3 = 1;
  }

  if(scripts\mp\utility\game::inovertime()) {
    if(game["overtimeRoundsPlayed"] == 0) {
      setmatchdata("firstOvertimeRoundIndex", game["roundsPlayed"]);
    }

    if(!var_3) {
      game["overtimeRoundsPlayed"]++;
    }
  }

  if(level.teambased) {
    if(var_0 == "axis" || var_0 == "allies") {
      if(!var_3) {
        game["roundsWon"][var_0]++;
      }

      if(!isDefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = var_0;
      }
    } else if(!isDefined(level.finalkillcam_winner))
      level.finalkillcam_winner = "none";

    scripts\mp\gamescore::updateteamscore("axis");
    scripts\mp\gamescore::updateteamscore("allies");

    if(scripts\mp\utility\game::isroundbased() && game["roundsPlayed"] < 24 && level.gametype != "koth") {
      setmatchdata("alliesRoundScore", game["roundsPlayed"], getteamscore("allies"));
      setmatchdata("axisRoundScore", game["roundsPlayed"], getteamscore("axis"));
    }
  } else {
    if(isDefined(var_0) && isplayer(var_0) && !var_3) {
      game["roundsWon"][var_0.guid]++;
    }

    if(!isDefined(level.finalkillcam_winner)) {
      if(isstring(var_0) && var_0 == "tie") {
        level.finalkillcam_winner = "none";
      } else {
        level.finalkillcam_winner = var_0.guid;
      }
    }
  }

  scripts\mp\gamescore::updateplacement();

  if(!var_3) {
    game["roundsPlayed"]++;
  }

  level.playovertime = scripts\mp\utility\game::func_1004B();

  if(scripts\mp\utility\game::nextroundisfinalround()) {
    game["finalRound"] = 1;
  }

  if(scripts\mp\utility\game::waslastround()) {
    var_0 = checkmodeoverridetie(var_0);
  }

  var_4 = func_6321(var_0, var_1, var_2);

  if(var_4 && scripts\mp\utility\game::waslastround()) {
    func_6320(var_0, var_1, var_2);
  }
}

checkmodeoverridetie(var_0) {
  if(level.gametype == "ctf" && var_0 == "tie" && !level.winrule) {
    scripts\mp\gamescore::func_12F4A("axis");
    scripts\mp\gamescore::func_12F4A("allies");
    var_1 = getteamscore("allies");
    var_2 = getteamscore("axis");

    if(var_1 != var_2) {
      var_0 = scripts\engine\utility::ter_op(var_1 > var_2, "allies", "axis");
    }
  }

  return var_0;
}

func_6323() {
  if(isDefined(level.finalkillcam_winner)) {
    level.finalkillcam_timegameended[level.finalkillcam_winner] = scripts\mp\utility\game::getsecondspassed();
    level notify("game_cleanup");
    level waittill("final_killcam_done");
  }
}

func_6321(var_0, var_1, var_2) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;

  if(getdvarint("scr_eom_combat")) {
    if(scripts\mp\utility\game::waslastround()) {
      level.doeomcombat = 1;
    }
  }

  scripts\engine\utility::waitframe();
  scripts\mp\gamescore::updateplacement();
  level.recordfinalkillcam = 0;
  level.ignorescoring = 1;
  level.var_561D = 1;
  scripts\mp\finalkillcam::preloadfinalkillcam();

  if(scripts\mp\utility\game::waslastround()) {
    level notify("round_end_music", var_0);
  }

  if(level.doeomcombat) {
    setomnvarforallclients("post_game_state", 1);
    setomnvarforallclients("post_game_state", 2);

    foreach(var_4 in level.players) {
      if(level.teambased) {
        var_4 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 0, var_1);
        continue;
      }

      var_4 thread scripts\mp\hud_message::func_C752(var_0, var_1);
    }

    func_7384(3, "cg_fovScale", 1, 1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
    game["state"] = "postgame";
    level notify("game_ended", var_0);
    scripts\mp\utility\game::func_ABF4("game_over");
    scripts\mp\utility\game::func_ABF4("block_notifies");
    scripts\engine\utility::waitframe();

    foreach(var_4 in level.players) {
      var_4 setclientdvar("ui_opensummary", 1);

      if(scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) {
        var_4 scripts\mp\killstreaks\killstreaks::func_41C0();
      }
    }
  } else {
    setomnvarforallclients("post_game_state", 1);
    game["state"] = "postgame";
    level notify("game_ended", var_0);
    scripts\mp\utility\game::func_ABF4("game_over");
    scripts\mp\utility\game::func_ABF4("block_notifies");
    scripts\engine\utility::waitframe();

    foreach(var_4 in level.players) {
      var_4 setclientdvar("ui_opensummary", 1);

      if(scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) {
        var_4 scripts\mp\killstreaks\killstreaks::func_41C0();
      }
    }

    func_7384(1.0, "cg_fovScale", 1, 0);
  }

  setgameendtime(0);
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();
  scripts\mp\playerlogic::printpredictedspawnpointcorrectness();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled()) {
    scripts\mp\analyticslog::analyticsstorespawndata();
  }

  if(isDefined(level.matchrecording_dump)) {
    [[level.matchrecording_dump]]();
  }

  rankedmatchupdates(var_0);
  setdvar("g_deadChat", 1);
  setdvar("ui_allow_teamchange", 0);
  setdvar("bg_compassShowEnemies", 0);
  func_56E0(var_0, var_1);

  if(!scripts\mp\utility\game::waslastround()) {
    level notify("round_win", var_0);
    func_E761(level.var_E75F, 1);
  } else
    func_E761(0, 1);

  func_6323();
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();

  if(level.teambased) {
    scripts\mp\gamescore::func_12F4A("axis");
    scripts\mp\gamescore::func_12F4A("allies");
  }

  if(!scripts\mp\utility\game::wasonlyround() && !var_2) {
    if(!scripts\mp\utility\game::waslastround()) {
      if(level.playovertime) {
        var_0 = "overtime";
        game["status"] = "overtime";
      }

      scripts\mp\utility\game::levelflagclear("block_notifies");

      if(func_3E43(level.playovertime)) {
        func_56E1();
      }

      foreach(var_4 in level.players) {
        var_4.pers["stats"] = var_4.var_10E53;
      }

      func_E2A9();
      return 0;
    }

    if(!level.var_72B3) {
      var_1 = updateroundendreasontext(var_0);
    }
  }

  return 1;
}

func_6320(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::istrue(level.processedwinloss) && (scripts\mp\utility\game::istrue(level.var_72F2) || level.var_72B3)) {
    updatewinlossstats(var_0);
  }

  scripts\mp\missions::func_E75D(var_0);
  scripts\mp\intel::updatemissionteamperformancestats();
  func_3E16();
  func_12F23();
  scripts\mp\persistence::writebestscores();
  level notify("stop_leaderboard_stats");
  updateleaderboardstats();
  level.doingbroshot = scripts\mp\broshot::initbroshot(var_0);

  if(!level.doingbroshot) {
    level notify("spawning_intermission");

    foreach(var_4 in level.players) {
      var_4 thread scripts\mp\utility\game::setuipostgamefade(0.0);
      var_4 thread scripts\mp\playerlogic::spawnintermission();
    }
  }

  if(scripts\mp\utility\game::istrue(var_2) && !scripts\mp\utility\game::istrue(level.var_C1B2)) {
    scripts\mp\utility\game::_visionsetnaked(level.var_C1D0, 0);
    visionsetfadetoblack("", 0.75);
  } else {
    scripts\mp\utility\game::_visionsetnaked("", 0);
    visionsetfadetoblack("", 0.75);
  }

  func_56DA(var_0, var_1);
  scripts\mp\utility\game::levelflagclear("block_notifies");
  level.intermission = 1;

  if(!level.doingbroshot) {
    setomnvarforallclients("post_game_state", 4);
    func_E761(level.var_D706, 1);
  }

  func_D9AA();

  if(level.doingbroshot) {
    setomnvarforallclients("post_game_state", 6);
    wait 0.1;
    var_6 = scripts\mp\broshot::startbroshot(var_0);
    var_7 = undefined;

    foreach(var_4 in level.players) {
      if(var_4 ishost()) {
        var_7 = var_4;
        break;
      }
    }

    if(isDefined(var_7)) {
      var_7 scripts\engine\utility::waittill_notify_or_timeout("dev_skip_broshot", var_6);
    } else {
      wait(var_6);
    }

    scripts\mp\broshot::endbroshot();
  }

  if(level.teambased) {
    if(var_0 == "axis" || var_0 == "allies") {
      setmatchdata("victor", var_0);
    } else {
      setmatchdata("victor", "none");
    }

    setmatchdata("alliesScore", getteamscore("allies"));
    setmatchdata("axisScore", getteamscore("axis"));
  } else
    setmatchdata("victor", "none");

  foreach(var_4 in level.players) {
    var_4 setrankedplayerdata("common", "round", "endReasonTextIndex", var_1);

    if(var_4 scripts\mp\utility\game::rankingenabled()) {
      var_4 scripts\mp\matchdata::logfinalstats();
    }

    if(isalive(var_4) && isDefined(var_4.matchdatalifeindex)) {
      var_4 scripts\mp\matchdata::logxpscoreearnedinlife(var_4.matchdatalifeindex);
    }

    if(level.teambased) {
      if(var_0 == "axis" || var_0 == "allies") {
        if(isDefined(var_4.team)) {
          if(var_4.team == var_0) {
            var_4 logplayerendmatchdatamatchresult(var_4.clientid, "win");
          } else {
            var_4 logplayerendmatchdatamatchresult(var_4.clientid, "loss");
          }
        } else
          var_4 logplayerendmatchdatamatchresult(var_4.clientid, "none");
      } else if(getteamscore("allies") == getteamscore("axis"))
        var_4 logplayerendmatchdatamatchresult(var_4.clientid, "draw");
      else {
        var_4 logplayerendmatchdatamatchresult(var_4.clientid, "none");
      }

      continue;
    }

    if(isplayer(var_0) && var_0.clientid == var_4.clientid) {
      var_4 logplayerendmatchdatamatchresult(var_4.clientid, "win");
      continue;
    }

    var_4 logplayerendmatchdatamatchresult(var_4.clientid, "loss");
  }

  setmatchdata("host", level.var_90AE);

  if(scripts\mp\utility\game::matchmakinggame()) {
    setmatchdata("playlistVersion", getplaylistversion());
    setmatchdata("playlistID", getplaylistid());
    setmatchdata("isDedicated", isdedicatedserver());
  }

  sendmatchdata();

  foreach(var_4 in level.players) {
    var_4.pers["stats"] = var_4.var_10E53;
  }

  if(!var_2 && !level.var_D701) {
    if(!level.doingbroshot) {
      if(!scripts\mp\utility\game::wasonlyround()) {
        wait 6.0;
      } else {
        wait(min(5.0, 4.0 + level.var_D701));
      }
    }
  } else
    wait(min(10.0, 4.0 + level.var_D701));

  if(isgamebattlematch()) {
    for(var_14 = _getgamebattlematchreportstate(); var_14 != 3 && var_14 != 4; var_14 = _getgamebattlematchreportstate()) {
      wait 1;
    }

    setomnvarforallclients("post_game_state", 5);
    wait 5;
  }

  setomnvarforallclients("post_game_state", 1);
  scripts\mp\utility\game::func_ABF6("post_game_level_event_active");
  setnojipscore(0);
  setnojiptime(0);
  level notify("exitLevel_called");
  exitlevel(0);
}

updateroundendreasontext(var_0) {
  if(!level.teambased) {
    return 1;
  }

  if(scripts\mp\utility\game::ismoddedroundgame()) {
    if(scripts\mp\utility\game::hitscorelimit()) {
      return game["end_reason"]["score_limit_reached"];
    }

    if(scripts\mp\utility\game::hittimelimit()) {
      return game["end_reason"]["time_limit_reached"];
    }
  } else if(scripts\mp\utility\game::hitroundlimit())
    return game["end_reason"]["round_limit_reached"];

  if(scripts\mp\utility\game::hitwinlimit()) {
    return game["end_reason"]["score_limit_reached"];
  }

  return game["end_reason"]["objective_completed"];
}

estimatedtimetillscorelimit(var_0) {
  if(!scripts\mp\utility\game::ismoddedroundgame()) {
    var_1 = getscoreperminute(var_0);
    var_2 = getscoreremaining(var_0);
    var_3 = 999999;

    if(var_1) {
      var_3 = var_2 / var_1;
    }

    return var_3;
  } else {
    var_1 = getscoreperminute(var_0);
    var_2 = getscoreperminute(var_0);
    var_3 = 999999;

    if(var_1) {
      var_3 = var_2 / var_1;
    }

    return var_3;
  }
}

func_42AC(var_0) {
  var_1 = 10;
  var_2 = 20;

  if(level.gametype == "tdef") {
    var_1 = 20;
  }

  if(level.gametype == "dom") {
    var_2 = 20;
  }

  var_3 = level.roundscorelimit;
  var_4 = getteamscore(var_0);
  var_5 = var_3 - var_4;

  if(var_5 <= scripts\engine\utility::ter_op(scripts\mp\utility\game::istrue(game["finalRound"]), var_2, var_1)) {
    return 1;
  }

  return 0;
}

getscoreperminute(var_0) {
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;

  if(isplayer(self)) {
    var_2 = self.score / var_1;
  } else {
    var_2 = getteamscore(var_0) / var_1;
  }

  return var_2;
}

getscoreremaining(var_0) {
  var_1 = level.roundscorelimit;

  if(isplayer(self)) {
    var_2 = var_1 - self.score;
  } else {
    var_2 = var_1 - getteamscore(var_0);
  }

  return var_2;
}

getscoreperminuteroundbased(var_0) {
  var_1 = level.roundscorelimit;

  if(!game["switchedsides"]) {
    var_1 = var_1 / 2;
    var_2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var_3 = getteamscore(var_0) / var_2;
  } else {
    var_1 = int(var_1 / 2);
    var_2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var_4 = getteamscore(var_0);

    if(var_4 >= var_1) {
      var_3 = (var_4 - var_1) / var_2;
    } else {
      return 0;
    }
  }

  return var_3;
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility\game::waittillrecoveredhealth(3);
  thread scripts\mp\utility\game::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);

  foreach(var_1 in level.teamnamelist) {
    if(self.pers["team"] != var_1) {
      thread scripts\mp\utility\game::teamplayercardsplash("callout_lastenemyalive", self, var_1);
    }
  }

  scripts\mp\music_and_dialog::func_C54B(self);
}

func_D9AA() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2.clientmatchdataid = var_0;
    var_0++;

    if(level.var_DADB && var_2.name.size > level.var_B4B3) {
      var_3 = "";

      for(var_4 = 0; var_4 < level.var_B4B3 - 3; var_4++) {
        var_3 = var_3 + var_2.name[var_4];
      }

      var_3 = var_3 + "...";
    } else
      var_3 = var_2.name;

    setclientmatchdata("players", var_2.clientmatchdataid, "username", var_3);
    setclientmatchdata("players", var_2.clientmatchdataid, "clanTag", var_2 getclantag());
    setclientmatchdata("players", var_2.clientmatchdataid, "xuidHigh", var_2 _meth_8565());
    setclientmatchdata("players", var_2.clientmatchdataid, "xuidLow", var_2 _meth_8566());
    setclientmatchdata("players", var_2.clientmatchdataid, "isBot", isbot(var_2));
    setclientmatchdata("players", var_2.clientmatchdataid, "uniqueClientId", var_2.clientid);
    var_2 setrankedplayerdata("common", "round", "clientMatchIndex", var_2.clientmatchdataid);
  }

  scripts\mp\scoreboard::func_D9AB();
  sendclientmatchdata();

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    thread scripts\mp\codcasterclientmatchdata::sendcodcastermatchdata();
  }
}

func_11AF7(var_0, var_1) {
  thread threadedsetweaponstatbyname(var_0, 1, "deaths");
}

func_11AC8(var_0, var_1) {
  if(isDefined(self) && isplayer(self)) {
    if(var_1 != "MOD_FALLING") {
      if(var_1 == "MOD_MELEE" && issubstr(var_0, "tactical")) {
        scripts\mp\matchdata::func_AF94("tactical", "kills", 1);
        scripts\mp\matchdata::func_AF94("tactical", "hits", 1);
        scripts\mp\persistence::func_93F9("tactical", "kills", 1);
        scripts\mp\persistence::func_93F9("tactical", "hits", 1);
        return;
      }

      if(var_1 == "MOD_MELEE" && !scripts\mp\weapons::isriotshield(var_0) && !scripts\mp\weapons::isknifeonly(var_0) && !scripts\mp\weapons::isaxeweapon(var_0)) {
        scripts\mp\matchdata::func_AF94("none", "kills", 1);
        scripts\mp\matchdata::func_AF94("none", "hits", 1);
        scripts\mp\persistence::func_93F9("none", "kills", 1);
        scripts\mp\persistence::func_93F9("none", "hits", 1);
        return;
      }

      thread threadedsetweaponstatbyname(var_0, 1, "kills");
    }

    if(var_1 == "MOD_HEAD_SHOT") {
      thread threadedsetweaponstatbyname(var_0, 1, "headShots");
    }
  }
}

setweaponstat(var_0, var_1, var_2) {
  if(!var_1) {
    return;
  }
  var_3 = scripts\mp\utility\game::getweapongroup(var_0);
  var_4 = getweaponvariantindex(var_0);

  if(var_3 == "killstreak" || var_3 == "other" && var_0 != "trophy_mp" || var_3 == "other" && var_0 != "player_trophy_system_mp" || var_3 == "other" && var_0 != "super_trophy_mp") {
    return;
  }
  if(scripts\mp\utility\game::isenvironmentweapon(var_0)) {
    return;
  }
  if(var_3 == "weapon_grenade" || var_3 == "weapon_explosive" || var_0 == "trophy_mp" || var_0 == "adrenaline_mist_mp" || var_0 == "domeshield_mp" || var_0 == "copycat_grenade_mp" || var_0 == "speed_strip_mp" || var_0 == "forcepush_mp" || var_0 == "portal_generator_mp") {
    var_5 = scripts\mp\utility\game::strip_suffix(var_0, "_mp");
    scripts\mp\persistence::func_93FC(var_5, var_2, var_1);
    scripts\mp\matchdata::func_AFDC(var_5, var_2, var_1, var_4);
    return;
  }

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = var_0;
  }

  if(var_0 != self.trackingweapon) {
    scripts\mp\persistence::func_12F5E();
    self.trackingweapon = var_0;
  }

  switch (var_2) {
    case "shots":
      self.trackingweaponshots++;
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
  }

  if(var_2 == "deaths") {
    var_6 = undefined;
    var_7 = scripts\mp\utility\game::getweaponrootname(var_0);

    if(!scripts\mp\utility\game::iscacprimaryweapon(var_7) && !scripts\mp\utility\game::iscacsecondaryweapon(var_7)) {
      return;
    }
    var_8 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0);
    scripts\mp\persistence::func_93FC(var_7, var_2, var_1);
    scripts\mp\matchdata::func_AFDC(var_7, "deaths", var_1, var_4);

    foreach(var_10 in var_8) {
      scripts\mp\persistence::func_93F9(var_10, var_2, var_1);
      scripts\mp\matchdata::func_AF94(var_10, var_2, var_1);
    }
  }
}

setinflictorstat(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 setweaponstat(var_2, 1, "hits");
    return;
  }

  if(!isDefined(var_0.playeraffectedarray)) {
    var_0.playeraffectedarray = [];
  }

  var_3 = 1;

  for(var_4 = 0; var_4 < var_0.playeraffectedarray.size; var_4++) {
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

func_12F23() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::rankingenabled()) {
      var_2 = getmatchspm(var_1);
      var_3 = var_1 getrankedplayerdata("mp", "globalSPM");
      var_4 = var_1 getrankedplayerdata("mp", "gamesPlayed");
      var_5 = var_1 getrankedplayerdata("mp", "dlcEggStatus");

      if(var_5 > 0) {
        var_4 = int(max(var_4 - var_5, 1));
      }

      var_3 = var_3 * (var_4 - 1);
      var_6 = var_2;

      if(var_4 > 0) {
        var_6 = (var_3 + var_2) / var_4;
      }

      var_1 setrankedplayerdata("mp", "globalSPM", int(var_6));
      var_7 = _getgametypeindex(level.gametype);

      if(var_7 >= 0 && var_7 < level.var_B4A0) {
        var_8 = var_1 getrankedplayerdata("mp", "gameModeScoreHistory", var_7, "index");
        var_1 setrankedplayerdata("mp", "gameModeScoreHistory", var_7, "scores", var_8, int(var_2));
        var_8 = (var_8 + 1) % level.var_B4A1;
        var_1 setrankedplayerdata("mp", "gameModeScoreHistory", var_7, "index", var_8);
      }
    }
  }
}

func_3E16() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::rankingenabled()) {
      var_2 = var_1 getrankedplayerdata("common", "round", "kills");
      var_3 = var_1 getrankedplayerdata("common", "round", "deaths");
      var_4 = var_1.pers["summary"]["xp"];
      var_5 = var_1 getrankedplayerdata("mp", "bestKills");
      var_6 = var_1 getrankedplayerdata("mp", "mostDeaths");
      var_7 = var_1 getrankedplayerdata("mp", "mostXp");
      var_8 = var_1 getrankedplayerdata("mp", "bestSPM", "score");
      var_9 = var_1 getrankedplayerdata("mp", "bestKD", "score");

      if(var_2 > var_5) {
        var_1 setrankedplayerdata("mp", "bestKills", var_2);
      }

      if(var_4 > var_7) {
        var_1 setrankedplayerdata("mp", "mostXp", var_4);
      }

      if(var_3 > var_6) {
        var_1 setrankedplayerdata("mp", "mostDeaths", var_3);
      }

      var_10 = var_2;

      if(var_3 > 1) {
        var_10 = var_10 / var_3;
      }

      var_10 = int(var_10 * 1000);

      if(var_10 > var_9) {
        var_1 setrankedplayerdata("mp", "bestKD", "score", var_10);
        var_1 setrankedplayerdata("mp", "bestKD", "time", getsystemtime());
      }

      var_11 = getmatchspm(var_1);

      if(var_11 > var_8) {
        var_1 setrankedplayerdata("mp", "bestSPM", "score", int(var_11));
        var_1 setrankedplayerdata("mp", "bestSPM", "time", getsystemtime());
      }

      var_1 func_3E0C();
      var_1 scripts\mp\matchdata::func_AFD7(var_4, "totalXp");
      var_1 scripts\mp\matchdata::func_AFD7(var_1.pers["summary"]["score"], "scoreXp");
      var_1 scripts\mp\matchdata::func_AFD7(var_1.pers["summary"]["challenge"], "challengeXp");
      var_1 scripts\mp\matchdata::func_AFD7(var_1.pers["summary"]["match"], "matchXp");
      var_1 scripts\mp\matchdata::func_AFD7(var_1.pers["summary"]["misc"], "miscXp");
      var_1 scripts\mp\matchdata::func_AFD7(var_1.pers["summary"]["medal"], "medalXp");
      var_1 scripts\mp\matchdata::func_AFD7(var_1.pers["summary"]["bonusXP"], "bonusXp");
    }

    if(isDefined(var_1.pers["confirmed"])) {
      var_1 scripts\mp\matchdata::logkillsconfirmed();
    }

    if(isDefined(var_1.pers["denied"])) {
      var_1 scripts\mp\matchdata::logkillsdenied();
    }
  }
}

updateleaderboardstatscontinuous() {
  level endon("game_ended");
  level endon("stop_leaderboard_stats");
  var_0 = 0;

  for(;;) {
    while(!isDefined(level.players) || level.players.size == 0) {
      scripts\engine\utility::waitframe();
    }

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    var_1 = level.players[var_0];

    if(!isDefined(var_1) || isai(var_1)) {
      scripts\engine\utility::waitframe();
    } else {
      if(var_1 scripts\mp\utility\game::rankingenabled()) {
        var_1 updateplayerleaderboardstats();
      }

      wait 0.1;
    }

    var_0++;
  }
}

updateleaderboardstats() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1) || isai(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::rankingenabled()) {
      var_1 updateplayerleaderboardstats();
    }
  }
}

updateplayerleaderboardstats() {
  var_0 = undefined;

  if(level.hardcoremode) {
    var_0 = "hc";
  } else {
    var_0 = "";
  }

  var_0 = var_0 + level.gametype;
  var_1 = scripts\engine\utility::ter_op(level.teambased, self.score, self.pers["gamemodeScore"]);
  incrementleaderboardstat(var_0 + "Score", var_1);
  var_2 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  incrementleaderboardstat(var_0 + "TimePlayed", var_2);
  incrementleaderboardstat(var_0 + "Kills", self.pers["kills"]);
  incrementleaderboardstat(var_0 + "Deaths", self.pers["deaths"]);

  switch (level.gametype) {
    case "war":
      incrementleaderboardstat(var_0 + "Assists", self.pers["assists"]);
      break;
    case "front":
      incrementleaderboardstat(var_0 + "Assists", self.pers["assists"]);
      break;
    case "dm":
      updateleaderboardstatmaximum(var_0 + "Streak", self.pers["killChains"]);
      break;
    case "dom":
      incrementleaderboardstat(var_0 + "Captures", self.pers["captures"]);
      incrementleaderboardstat(var_0 + "Defends", self.pers["defends"]);
      break;
    case "sd":
      incrementleaderboardstat(var_0 + "Plants", self.pers["plants"]);
      incrementleaderboardstat(var_0 + "Defuses", self.pers["defuses"]);
      break;
    case "conf":
      incrementleaderboardstat(var_0 + "Confirms", self.pers["confirmed"]);
      incrementleaderboardstat(var_0 + "Denies", self.pers["denied"]);
      break;
    case "koth":
      incrementleaderboardstat(var_0 + "ObjTime", self.pers["objTime"]);
      incrementleaderboardstat(var_0 + "Defends", self.pers["defends"]);
      break;
    case "tdef":
      incrementleaderboardstat(var_0 + "ObjTime", self.pers["objTime"]);
      incrementleaderboardstat(var_0 + "Captures", self.pers["defends"]);
      break;
    case "ball":
      incrementleaderboardstat(var_0 + "Throws", self.pers["fieldgoals"]);
      incrementleaderboardstat(var_0 + "Carries", self.pers["touchdowns"]);
      break;
    case "ctf":
      incrementleaderboardstat(var_0 + "Captures", self.pers["captures"]);
      incrementleaderboardstat(var_0 + "Returns", self.pers["returns"]);
      break;
    case "sr":
      incrementleaderboardstat(var_0 + "Plants", self.pers["plants"]);
      incrementleaderboardstat(var_0 + "Rescues", self.pers["rescues"]);
      break;
    case "siege":
      incrementleaderboardstat(var_0 + "Captures", self.pers["captures"]);
      incrementleaderboardstat(var_0 + "Revives", self.pers["rescues"]);
      break;
    case "grind":
      incrementleaderboardstat(var_0 + "Banks", self.pers["confirmed"]);
      incrementleaderboardstat(var_0 + "Denies", self.pers["denied"]);
      break;
    case "infect":
      incrementleaderboardstat(var_0 + "Time", scripts\mp\utility\game::getpersstat("extrascore0"));
      incrementleaderboardstat(var_0 + "Infected", self.pers["killsAsInfected"]);
      break;
    case "gun":
      incrementleaderboardstat(var_0 + "Stabs", self.pers["stabs"]);
      incrementleaderboardstat(var_0 + "SetBacks", self.pers["setbacks"]);
      break;
    case "grnd":
      incrementleaderboardstat(var_0 + "ObjTime", self.pers["objTime"]);
      incrementleaderboardstat(var_0 + "Defends", self.pers["defends"]);
      break;
  }
}

incrementleaderboardstat(var_0, var_1) {
  if(!isDefined(self.leaderboardstartvalues)) {
    self.leaderboardstartvalues = [];
  }

  if(!isDefined(self.leaderboardstartvalues[var_0])) {
    self.leaderboardstartvalues[var_0] = self getrankedplayerdata("mp", "leaderBoardData", var_0);
  }

  var_2 = int(max(self.leaderboardstartvalues[var_0] + var_1, self.leaderboardstartvalues[var_0]));
  self setrankedplayerdata("mp", "leaderBoardData", var_0, var_2);
}

updateleaderboardstatmaximum(var_0, var_1) {
  var_2 = self getrankedplayerdata("mp", "leaderBoardData", var_0);

  if(var_1 > var_2) {
    self setrankedplayerdata("mp", "leaderBoardData", var_0, var_1);
  }
}

getmatchspm(var_0) {
  var_1 = scripts\engine\utility::ter_op(level.teambased, var_0.score, var_0.pers["gamemodeScore"]);
  var_2 = var_0 scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

  if(isDefined(var_2) && var_2 > 0) {
    var_3 = var_2 / 60;
    var_1 = var_1 / var_3;
  }

  return var_1;
}

isvalidbestweapon(var_0) {
  var_1 = scripts\mp\utility\game::getweapongroup(var_0);
  return isDefined(var_0) && var_0 != "" && !scripts\mp\utility\game::iskillstreakweapon(var_0) && var_1 != "killstreak" && var_1 != "other";
}

func_3E0C() {
  var_0 = scripts\mp\matchdata::func_322A();
  var_1 = "";
  var_2 = -1;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_4 = scripts\mp\utility\game::getweaponrootname(var_4);

    if(isvalidbestweapon(var_4)) {
      var_5 = self getrankedplayerdata("mp", "weaponStats", var_4, "kills");

      if(var_5 > var_2) {
        var_1 = var_4;
        var_2 = var_5;
      }
    }
  }

  var_6 = self getrankedplayerdata("mp", "weaponStats", var_1, "shots");
  var_7 = self getrankedplayerdata("mp", "weaponStats", var_1, "headShots");
  var_8 = self getrankedplayerdata("mp", "weaponStats", var_1, "hits");
  var_9 = self getrankedplayerdata("mp", "weaponStats", var_1, "deaths");
  var_10 = 0;
  self setrankedplayerdata("mp", "bestWeapon", "kills", var_2);
  self setrankedplayerdata("mp", "bestWeapon", "shots", var_6);
  self setrankedplayerdata("mp", "bestWeapon", "headShots", var_7);
  self setrankedplayerdata("mp", "bestWeapon", "hits", var_8);
  self setrankedplayerdata("mp", "bestWeapon", "deaths", var_9);
  self setrankedplayerdata("mp", "bestWeaponXP", var_10);
  var_11 = int(tablelookup("mp\statstable.csv", 4, var_1, 0));
  self setrankedplayerdata("mp", "bestWeaponIndex", var_11);
}

allow_weapon_func(var_0) {
  self notify("allow_weapon_mp()");

  if(var_0) {
    if(isDefined(self.allowweaponcache) && !self hasweapon(self.allowweaponcache)) {
      scripts\mp\utility\game::func_1136C(self.lastdroppableweaponobj);
    }

    self.allowweaponcache = undefined;
  } else {
    self.allowweaponcache = self getcurrentprimaryweapon();
    thread watchinvalidweaponswitchduringdisableweapon();
  }
}

func_1C74() {
  level.allow_weapon_func = ::allow_weapon_func;
}

watchinvalidweaponswitchduringdisableweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("allow_weapon_mp()");

  for(;;) {
    self waittill("weapon_switch_invalid", var_0);
    self.allowweaponcache = var_0;
  }
}

ismp_init() {
  level.ismp = 1;
}