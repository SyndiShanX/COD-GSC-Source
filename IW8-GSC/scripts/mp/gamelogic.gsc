/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gamelogic.gsc
***********************************************/

function onforfeit(var_0) {
  if(isDefined(level.forfeitinprogress)) {
    return;
  }

  level endon("abort_forfeit");
  thread forfeitwaitforabort();
  level.forfeitinprogress = 1;
  level.canprocessot = 0;

  if(!level.teambased && level.players.size > 1) {
    wait 10;
  } else {
    wait 1.05;
  }

  level.forfeit_aborted = 0;
  var_1 = 20;
  matchforfeittimer(var_1);
  var_2 = &"";

  if(!isDefined(var_0)) {
    var_2 = game["end_reason"]["players_forfeited"];
    var_3 = level.players[0];
  } else {
    if(var_1 == "allies") {
      var_3 = game["end_reason"]["spetsnaz_forfeited"];
    } else {
      var_3 = game["end_reason"]["marines_forfeited"];
    }

    var_3 = var_1;
  }

  level.forcedend = 1;

  if(isPlayer(var_3)) {
    logstring("[KEY_MOMENT] forfeit, win: " + var_3 getxuid() + "(" + var_3.name + ")");
  } else {
    logstring("[KEY_MOMENT] forfeit, win: " + var_3);
  }

  thread endgame(var_3, var_3);
}

function forfeitwaitforabort() {
  level endon("game_ended");

  if(getdvarfloat("scr_disable_forfeit_ship") == 1) {
    level.disableforfeit = 1;
    level notify("abort_forfeit");
  } else {
    level waittill("abort_forfeit");
  }

  level.forfeit_aborted = 1;
  level.canprocessot = 1;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_match_start_countdown", 0);
    var_1 setclientomnvar("ui_match_in_progress", 1);
  }
}

function matchforfeittimer_internal(var_0) {
  waittillframeend();
  level endon("match_forfeit_timer_beginning");

  while(var_0 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("ui_match_start_countdown", var_0);
      var_2 setclientomnvar("ui_match_in_progress", 0);
    }

    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_match_start_countdown", 0);
    var_2 setclientomnvar("ui_match_in_progress", 1);
  }
}

function matchforfeittimer(var_0) {
  level notify("match_forfeit_timer_beginning");
  var_1 = int(var_0);
  setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  matchforfeittimer_internal(var_1);
}

function default_ondeadevent(var_0) {
  logstring("team eliminated: " + var_0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0, "players")) {
      var_3 = undefined;

      if(istrue(var_2.pers["hasDoneAnyCombat"]) || istrue(var_2.pers["participation"])) {
        var_3 = "eliminated";
      }

      var_2 scripts\cp_mp\utility\game_utility::stopkeyearning(var_3);
    }
  }

  if(var_0 == "all") {
    logstring("[KEY_MOMENT] tie");

    if(level.teambased) {
      thread endgame("tie", game["end_reason"]["tie"]);
      return;
    }

    thread endgame(undefined, game["end_reason"]["tie"]);
    return;
  }

  var_8 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_9 = [];

  foreach(var_6 in var_8) {
    var_9 = 0;
  }

  if(!istrue(level.disablespawning)) {
    foreach(var_6 in var_8) {
      foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_6, "players")) {
        if(!istrue(var_2.hasspawned)) {
          continue;
        }

        var_9 = var_9[var_6] + var_2.pers["lives"];
      }
    }
  }

  var_16 = [];

  foreach(var_6 in var_8) {
    if(scripts\mp\utility\teams::getteamdata(var_6, "aliveCount") || var_9[var_6]) {
      var_16 = var_6;
    }
  }

  if(var_16.size == 1) {
    thread endgame(var_16[0], game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
    return;
  }
}

function default_ononeleftevent(var_0) {
  if(level.teambased) {
    var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);

    if(isDefined(var_1)) {
      thread givelastonteamwarning();
    }
  } else {
    var_1 = scripts\mp\utility\game::getlastlivingplayer();
    logstring("[KEY_MOMENT] last one alive, win: " + var_1.name);
    thread endgame(var_1, game["end_reason"]["enemies_eliminated"]);
  }

  return true;
}

function roundend_checkscorelimit(var_0, var_1) {
  checkteamscorelimitsoon(var_0);

  if(istrue(var_1)) {
    level notify("roundEnd_CheckScoreLimit");
    level endon("roundEnd_CheckScoreLimit");
    waitframe();
  }

  var_2 = scripts\mp\utility\game::getwingamebytype();

  if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
    if(scripts\mp\utility\game::istimetobeatrulegametype()) {
      if(scripts\mp\utility\game::settimetobeat(var_0)) {
        foreach(var_4 in level.players) {
          var_4 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_4.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_4 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_4.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        thread endgame(var_0, game["end_reason"]["score_limit_reached"]);
        return;
      }

      return;
    }

    if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
      return;
    }

    thread endgame(var_3, game["end_reason"]["score_limit_reached"]);
    return;
  }

  if(level.roundscorelimit > 0) {
    var_6 = [];

    foreach(var_8 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_8)) {
        continue;
      }

      if(game["teamScores"][var_8] >= level.roundscorelimit) {
        var_6 = var_8;
      }
    }

    if(var_6.size > 0) {
      if(var_6.size > 1) {
        var_10 = 0;
        var_11 = undefined;
        var_12 = 0;

        foreach(var_8 in var_6) {
          var_14 = game["teamScores"][var_8];

          if(!isDefined(var_11)) {
            var_10 = var_14;
            var_11 = var_8;
            var_12 = 0;
            continue;
          }

          if(var_14 > var_10) {
            var_10 = var_14;
            var_11 = var_8;
            var_12 = 0;
            continue;
          }

          if(var_14 == var_10) {
            var_12 = 1;
          }
        }

        if(var_12) {
          thread endgame("tie", game["end_reason"]["score_limit_reached"]);
          return;
        }

        thread endgame(var_11, game["end_reason"]["score_limit_reached"]);
        return;
      }

      thread endgame(var_6[0], game["end_reason"]["score_limit_reached"]);
      return;
    }

    return;
  }
}

function default_ontimelimit() {
  var_0 = "tie";

  if(level.teambased) {
    if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
      if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        var_1 = game["overtimeProgress"] + game["overtimeProgressFrac"];
        var_0 = scripts\mp\utility\game::setscoretobeat(game["attackers"], var_1 * 60);
      } else if(scripts\mp\utility\game::istimetobeatvalid()) {
        var_0 = game["timeToBeatTeam"];
      }
    } else {
      var_0 = scripts\mp\gamescore::gethighestscoringteam();
    }

    logstring("[KEY_MOMENT] time limit, win: " + var_0);
  } else {
    var_0 = scripts\mp\gamescore::gethighestscoringplayer();

    if(scripts\mp\gamescore::ishighestscoringplayertied()) {
      var_0 = "tie";
    }

    if(isDefined(var_0) && isPlayer(var_0)) {
      logstring("[KEY_MOMENT] time limit, win: " + var_0.name);
    } else {
      logstring("[KEY_MOMENT] time limit, tie");
    }
  }

  thread endgame(var_0, game["end_reason"]["time_limit_reached"]);
}

function default_onhalftime() {
  var_0 = undefined;
  thread endgame("halftime", game["end_reason"]["time_limit_reached"]);
}

function forceend(var_0) {
  if(level.hostforcedend || level.forcedend) {
    return;
  }

  scripts\mp\gamescore::updateplacement();

  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_2)) {
        continue;
      }

      scripts\mp\gamescore::updatetotalteamscore(var_2);
    }
  }

  var_4 = undefined;

  if(level.teambased) {
    var_4 = scripts\mp\gamescore::gethighestscoringteam();
    logstring("[KEY_MOMENT] host ended game, win: " + var_4);
  } else {
    var_4 = scripts\mp\gamescore::gethighestscoringplayer();

    if(isDefined(var_4)) {
      logstring("[KEY_MOMENT] host ended game, win: " + var_4.name);
    } else {
      logstring("[KEY_MOMENT] host ended game, tie");
    }
  }

  level.forcedend = 1;
  level.hostforcedend = 1;

  if(level.splitscreen) {
    var_7 = game["end_reason"]["ended_game"];
  } else {
    var_7 = game["end_reason"]["host_ended_game"];
  }

  if(isDefined(var_4) && var_4 == 2) {
    if(level.teambased) {
      if(var_7 == "allies") {
        var_8 = game["end_reason"]["spetsnaz_forfeited"];
      } else {
        var_8 = game["end_reason"]["marines_forfeited"];
      }
    } else {
      var_8 = game["end_reason"]["players_forfeited"];
    }
  }

  level notify("force_end");
  thread endgame(var_8, var_8);
}

function onscorelimit(var_0) {
  var_1 = game["end_reason"]["score_limit_reached"];
  var_2 = "tie";

  if(level.teambased) {
    var_2 = scripts\mp\gamescore::freight_lift_door_switch();

    if(var_2 == "none") {
      var_2 = "tie";
    }

    logstring("[KEY_MOMENT] scorelimit, win: " + var_2);
  } else {
    var_2 = scripts\mp\gamescore::gethighestscoringplayer();

    if(istrue(var_0) && scripts\mp\gamescore::ishighestscoringplayertied()) {
      var_2 = "tie";
    }

    if(isDefined(var_2) && isPlayer(var_2)) {
      logstring("[KEY_MOMENT] scorelimit, win: " + var_2.name);
    } else {
      logstring("[KEY_MOMENT] scorelimit, tie");
    }

    var_6 = var_2 scripts\mp\killstreaks\killstreaks::calcstreakcost("nuke");

    if(scripts\mp\utility\game::getscorelimit() == var_6 && var_2.pers["cur_kill_streak"] == var_6) {
      level.ref_11c81 = var_2;
      level.starttime = gettime();
      level.discardtime = 0;
      level.timerpausetime = 0;
      var_7 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
      level.watchdvars[var_7].value = 30;
      level.overridewatchdvars[var_7] = 30;
      level.dontendonscore = 1;
      return;
    }
  }

  thread endgame(var_6, var_2);
  return 1;
}

function updategameevents() {
  var_0 = 0;
  level.teamswithplayers = [];

  foreach(var_2 in level.teamnamelist) {
    var_3 = scripts\mp\utility\teams::getteamdata(var_2, "teamCount");
    var_0 += var_3;

    if(var_3) {
      level.teamswithplayers[level.teamswithplayers.size] = var_2;
    }
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
      var_5 = 0;

      foreach(var_7 in level.teamnamelist) {
        var_5 += scripts\mp\utility\teams::getteamdata(var_7, "teamCount");
      }

      if(var_5 == 1 && level.maxplayercount > 1) {
        thread onforfeit();
        return;
      }

      if(var_5 > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(level.teamswithplayers.size == 1 && (istrue(level.br_debugsolotest) || scripts\mp\utility\game::getgametype() != "br")) {
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
    var_9 = [];

    foreach(var_7 in level.teamnamelist) {
      var_9 = 0;
    }

    foreach(var_13 in level.players) {
      if(!istrue(var_13.hasspawned) || var_13.team == "spectator" || var_13.team == "follower" || var_13.team == "free") {
        continue;
      }

      var_9 = var_9[var_13.team] + var_13.pers["lives"];
    }

    if(istrue(level.disablespawning)) {
      foreach(var_7 in level.teamnamelist) {
        var_9 = 0;
      }
    }

    var_17 = 0;

    foreach(var_7 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_7, "aliveCount")) {
        var_17 = 1;
        break;
      }
    }

    var_20 = 0;

    foreach(var_22 in var_9) {
      if(var_22) {
        var_20 = 1;
        break;
      }
    }

    if(!var_17 && !var_20) {
      if(istrue(level.postgameexfil) && level.gameended) {
        level notify("exfil_continue_game_end");
      }

      if(istrue(level.nukeincoming)) {
        return;
      }

      if(ref_1330a() && game["roundsPlayed"] == 0) {
        logstring("IWH-315293: GIBBERFISH: onDeadEvent - all");
      }

      return [[level.ondeadevent]]("all");
    }

    foreach(var_7 in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(var_7, "aliveCount") && !var_9[var_7]) {
        if(istrue(level.postgameexfil) && level.gameended) {
          level notify("exfil_continue_game_end");
        }

        if(!istrue(level.skipondeadevent)) {
          if(istrue(level.nukeincoming)) {
            return;
          }

          if(level.multiteambased) {
            if(!scripts\mp\utility\teams::getteamdata(var_7, "deathEvent") && scripts\mp\utility\teams::getteamdata(var_7, "hasSpawned")) {
              if(ref_1330a() && game["roundsPlayed"] == 0) {
                logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry MultiteamBased");
              }

              scripts\mp\utility\teams::setteamdata(var_7, "deathEvent", 1);
              [[level.ondeadevent]](var_7);
            }

            continue;
          }

          if(ref_1330a() && game["roundsPlayed"] == 0) {
            logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry Team based");
          }

          return [[level.ondeadevent]](var_7);
        }
      }
    }

    foreach(var_7 in level.teamnamelist) {
      var_27 = scripts\mp\utility\teams::getteamdata(var_7, "aliveCount");

      if(var_27 == 1 || var_27 == 2) {
        var_28 = 0;
        var_29 = undefined;
        var_30 = scripts\mp\utility\teams::getteamdata(var_7, "players");
        var_31 = [];

        foreach(var_13 in var_30) {
          if(!isalive(var_13)) {
            var_28 += var_13.pers["lives"];
            continue;
          }

          var_31 = var_13;
        }

        if(var_27 != 1) {
          scripts\mp\utility\teams::setteamdata(var_7, "oneLeft", 0);
        }

        if(var_28 == 0) {
          if(var_27 == 1 && !scripts\mp\utility\teams::getteamdata(var_7, "oneLeft") && gettime() > scripts\mp\utility\teams::getteamdata(var_7, "oneLeftTime") + 5000) {
            scripts\mp\utility\teams::setteamdata(var_7, "oneLeftTime", gettime());
            scripts\mp\utility\teams::setteamdata(var_7, "oneLeft", 1);

            if(var_30.size > 1) {
              [[level.ononeleftevent]](var_7);
            }
          } else if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "kingslayer" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "gold_war" && var_27 == 2 && var_30.size > 2) {
            var_34 = scripts\engine\utility::random(var_31);
            level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_34, "inform_last_two");
          }
        }

        continue;
      }

      scripts\mp\utility\teams::setteamdata(var_7, "oneLeft", 0);
    }

    return;
  }

  var_9 = 0;

  foreach(var_13 in level.players) {
    if(var_13.team == "spectator" || var_13.team == "follower") {
      continue;
    }

    var_9 += var_13.pers["lives"];
  }

  var_38 = 0;

  foreach(var_7 in level.teamnamelist) {
    var_38 += scripts\mp\utility\teams::getteamdata(var_7, "aliveCount");
  }

  if(!var_38 && !var_9) {
    if(istrue(level.nukeincoming)) {
      return;
    }

    return [[level.ondeadevent]]("all");
  }

  var_41 = scripts\mp\utility\game::getpotentiallivingplayers();

  if(var_41.size == 1) {
    return [[level.ononeleftevent]]("all");
  }
}

function timelimitclock_intermission(var_0) {
  setgameendtime(gettime() + int(var_0 * 1000));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 hide();

  if(var_0 >= 10) {
    wait var_0 - 10;
  }

  for(;;) {
    var_1 playSound("ui_mp_timer_countdown");
    wait 1;
  }
}

function waitforplayers(var_0) {
  var_1 = gettime();

  if(istrue(game["isLaunchChunk"])) {
    var_2 = 0;
  } else if(var_1 > 5) {
    var_2 = gettime() + getdvarint("MSKKKKOPKS") * 1000;
  } else {
    var_2 = 0;
  }

  var_3 = max(1, level.connectingplayers / 2);
  scripts\mp\flags::gameflagwait("infil_setup_complete");
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    if(istrue(game["roundsPlayed"])) {
      break;
    }

    var_6 = level.maxplayercount;
    var_7 = round_spawn_vehicles();

    if(!var_4) {
      if(var_7 > 0) {
        var_2 = gettime();
        var_4 = 1;
      } else {
        waitframe();
        continue;
      }
    }

    var_8 = gettime();
    var_9 = var_6 >= var_3;
    var_10 = var_7 >= var_3;

    if(var_10) {
      foreach(var_12 in level.teamnamelist) {
        if(!checkrequiredteamcount(var_12)) {
          var_9 = 0;
          break;
        }
      }
    }

    foreach(var_12 in level.teamnamelist) {
      if(!getquestxprewardinstance(var_12)) {
        if(level.gametype == "arena" && !var_5) {
          setomnvar("ui_match_start_text", "waiting_for_teams");
        }

        var_10 = 0;
        break;
      }
    }

    var_16 = var_2 + level.prematchperiod * 1000 - 200;

    if(scripts\mp\flags::gameflag("infil_will_run")) {
      if(var_10 && var_8 > var_2 || var_8 > var_16) {
        break;
      }
    } else if(var_10 && var_9 && var_8 > var_2 || var_8 > var_16) {
      break;
    }

    waitframe();
  }
}

function round_spawn_vehicles() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(istrue(var_2.pers["streamSyncComplete"])) {
      var_0++;
    }
  }

  return var_0;
}

function checkrequiredteamcount(var_0) {
  return scripts\mp\utility\teams::getteamdata(var_0, "hasSpawned") >= level.requiredplayercount[var_0];
}

function getquestxprewardinstance(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(isDefined(var_3.team) && var_3.team == var_0 && istrue(var_3.pers["streamSyncComplete"])) {
      var_1++;
    }
  }

  return var_1 >= level.requiredplayercount[var_0];
}

function prematchperiod() {
  level endon("game_ended");

  if(isDefined(level.ref_1285f) && [[level.ref_1285f]]()) {
    return;
  }

  level.connectingplayers = getdvarint("NKSQNMMRRQ");

  if(getdvarint("scr_live_lobby", 0) == 1 && !istrue(level.ref_133e0)) {
    if(scripts\mp\utility\game::getgametype() != "br") {
      logstring("IWH-315293: BELUGA: Gametype:" + scripts\mp\utility\game::getgametype() + " inLiveLobby, we shouldn't be");
    }

    game["inLiveLobby"] = 1;

    if(getdvarint("scr_enable_dev_livelobby_overrides", 0) == 1) {
      thread watchdevoverridematchstart();
    }

    thread ref_144bf(level);
    thread watchforminplayersmatchstart();
    level waittill("start_prematch");

    if(scripts\mp\utility\game::getgametype() != "br") {
      setDvar("scr_live_lobby", 0);
    }

    game["inLiveLobby"] = 0;
    game["liveLobbyCompleted"] = 1;
    var_0 = 30;

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 = getdvarint("scr_br_match_timer", 60);
    }

    if(scripts\mp\utility\game::getgametype() == "br" && istrue(level.infilcanusemap)) {
      var_0 = getdvarint("scr_br_match_timer", 25);
    }

    level.allowprematchdamage = 0;

    if(scripts\mp\utility\game::getgametype() == "br") {
      level.allowprematchdamage = 1;
      level thread scripts\mp\gametypes\br_public::defend_wave_1();

      if(scripts\mp\gametypes\br_public::isusinginfilselection()) {
        scripts\mp\gametypes\br_public::handleinfilspawnselectstart();
      }
    }

    livelobbymatchstarttimer(level, "match_starting_in", var_0);

    if(scripts\mp\utility\game::getgametype() == "br") {
      if(scripts\mp\gametypes\br_public::isusinginfilselection()) {
        scripts\mp\gametypes\br_public::handleinfilspawnselectend();
      }

      var_2 = 0;
      var_3 = 0;
      var_4 = 0;

      foreach(var_6 in level.players) {
        if(isbot(var_6) || initmaxspeedforpathlengthtable(var_6)) {
          var_3 += 1;
          continue;
        }

        if(var_6 calloutmarkerping_getEnt()) {
          var_4 += 1;
          continue;
        }

        var_2 += 1;
        LOC_000001b5:
      }

      logstring("[KEY_MOMENT] Prematch");
      logstring("=============================================");
      logstring("matchDelay = " + var_0);
      logstring("bots = " + var_3);
      logstring("headless = " + var_4);
      logstring("humans = " + var_2);
      logstring("=============================================");
    }

    level notify("start_prematch");
    level.prematchperiod = 0;

    if(!istrue(level.brkillchainchance)) {
      game["blockJIP"] = 1;
    }
  } else if(!istrue(level.ref_133e0)) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var_8 = getdvarint("br_minplayers");

      if(var_8 != 0) {
        thread ref_144bf();
        thread enemy_move_up_and_ignore();
        level waittill("start_prematch");
      }

      var_0 = 15;

      if(scripts\mp\gametypes\br_public::isusinginfilselection()) {
        scripts\mp\gametypes\br_public::handleinfilspawnselectstart();
      }

      level.allowprematchdamage = 0;

      if(scripts\mp\utility\game::getgametype() == "br") {
        level.allowprematchdamage = 1;

        if(istrue(level.infilcanusemap)) {
          var_0 = getdvarint("scr_br_match_timer", 25);
        }
      }

      livelobbymatchstarttimer(level, "match_starting_in", var_0);

      if(scripts\mp\gametypes\br_public::isusinginfilselection()) {
        scripts\mp\gametypes\br_public::handleinfilspawnselectend();
      }
    }
  }

  if(istrue(level.ref_133e0)) {
    while(!level.players.size) {
      waitframe();
    }
  }

  if(istrue(game["matchStartRequiresInput"])) {
    level waittill("pressToStartMatch");
  }

  if(istrue(game["blockJIP"])) {
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    level.nojip = 1;
  }

  level notify("prematch_started");

  if(istrue(level.debug_show2dvotext)) {
    level.parachuterestoreweaponscb = &scripts\mp\gametypes\br::nakeddrop;
  }

  if(ref_1330a() && game["roundsPlayed"] == 0) {
    logstring("IWH-315293: CEPHALOPOD: prematch_started notified");
  }

  physics_raycastents(gettimeremaining(), 2);
  level.prematchstarted = 1;

  if(level.prematchperiodend > 0) {
    matchstarttimerwaitforplayers();
  } else {
    matchstarttimerskip();
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();
  physics_raycastents(gettimeremaining(), 0);

  if(game["state"] != "playing") {
    return;
  }
}

function scriptablesstartid() {
  wait 3;

  if(isDefined(level.parachuterestoreweaponscb)) {
    foreach(var_1 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_1)) {
        var_1[[level.parachuterestoreweaponscb]]();
      }
    }

    return;
  }
}

function graceperiod() {
  level endon("game_ended");

  if(!isDefined(game["clientActive"])) {
    while(getactiveclientcount() == 0) {
      waitframe();
    }

    game["clientActive"] = 1;
  }

  while(level.ingraceperiod > 0) {
    wait 1;
    level.ingraceperiod--;
  }

  level notify("grace_period_ending");
  waitframe();
  scripts\mp\flags::gameflagset("graceperiod_done");
  level.ingraceperiod = 0;

  if(game["state"] != "playing") {
    if(ref_1330a() && game["roundsPlayed"] == 0) {
      logstring("IWH-315293: FROGFISH: game[ state ] != playing");
    }

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

  level thread[[level.updategameevents]]();
}

function sethasdonecombat(var_0, var_1) {
  if(var_1 && !istrue(var_0.hasdonecombat)) {
    scripts\mp\class::disableclassswapallowed();
  }

  var_0.hasdonecombat = var_1;

  if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(var_1 && !istrue(var_0.pers["hasDoneAnyCombat"])) {
    var_0.pers["hasDoneAnyCombat"] = 1;

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 scripts\mp\utility\stats::incpersstat("gamesPlayed", 1);
    }

    if(isDefined(var_0.pers["hasMatchLoss"]) && var_0.pers["hasMatchLoss"]) {
      return;
    }

    updatelossstats(var_0);
    return;
  }
}

function updatewinstats(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(!istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }

  if(istrue(var_0.pers["recordedLoss"])) {
    var_0 scripts\mp\playerstats_interface::addtoplayerstat(-1, "matchStats", "losses");
  }

  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "wins");
  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "currentWinStreak");
  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "modeRecords", scripts\mp\utility\game::getgametype());
  var_1 = var_0 scripts\mp\playerstats_interface::getplayerstat("matchStats", "currentWinStreak");

  if(var_1 > var_0 scripts\mp\playerstats_interface::getplayerstat("bestStats", "longestWinStreak")) {
    var_0 scripts\mp\playerstats_interface::setplayerstat(var_1, "bestStats", "longestWinStreak");
  }

  var_0 scripts\mp\persistence::statsetchild("round", "win", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

function updatelossstats(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(!istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }

  var_0.pers["hasMatchLoss"] = 1;

  if(!istrue(self.joinedinprogress)) {
    var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "losses");
    var_0.pers["recordedLoss"] = 1;
  }

  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "gamesPlayed");
  var_0 scripts\mp\persistence::statsetchild("round", "loss", 1);
}

function updatetiestats(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(!istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }

  if(istrue(var_0.pers["recordedLoss"])) {
    var_0 scripts\mp\playerstats_interface::addtoplayerstat(-1, "matchStats", "losses");
    var_0 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
  }

  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "ties");
  var_0 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

function updatewinlossstats(var_0) {
  if(scripts\mp\utility\game::privatematch()) {
    return;
  }

  if(!scripts\mp\utility\game::waslastround()) {
    return;
  }

  level.processedwinloss = 1;
  var_1 = level.players;
  updateplayercombatstatus();

  if(!isDefined(var_0) || isDefined(var_0) && isstring(var_0) && var_0 == "tie") {
    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }

      if(level.hostforcedend && var_3 ishost()) {
        var_3 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      updatetiestats(var_3);
    }
  } else if(isPlayer(var_0)) {
    if(level.hostforcedend && var_0 ishost()) {
      var_0 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
      return;
    }

    if(isDefined(level.lastplayerwins)) {
      updatewinstats(level.placement["all"][0]);
    } else {
      for(var_5 = 0; var_5 < min(level.placement["all"].size, 3); var_5++) {
        updatewinstats(level.placement["all"][var_5]);
      }
    }
  } else if(isstring(var_0)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }

      if(level.hostforcedend && var_3 ishost()) {
        var_3 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      if(var_0 == "tie") {
        updatetiestats(var_3);
        continue;
      }

      if(var_3.pers["team"] == var_0) {
        updatewinstats(var_3);
        continue;
      }

      if(istrue(var_3.pers["recordedLoss"])) {
        var_3 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
      }
    }
  }

  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !var_3 scripts\mp\utility\game::onlinestatsenabled()) {
      continue;
    }

    if(isai(var_3)) {
      continue;
    }

    var_9 = var_3 scripts\mp\playerstats_interface::getplayerstat("matchStats", "wins");

    if(var_9 >= 5) {
      var_3 giveachievement("MP_ACHIEVEMENT_1");
    }
  }
}

function updateplayercombatstatus() {
  if(scripts\mp\utility\game::getgametype() != "infect") {
    return;
  }

  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "spectator" && !var_1.spectatekillcam) {
      continue;
    }

    if(istrue(var_1.pers["hasDoneAnyCombat"])) {
      continue;
    }

    if(var_1.team == "axis") {
      continue;
    }

    sethasdonecombat(var_1, var_1, 1);
  }
}

function freezeplayerforroundend(var_0) {
  self endon("disconnect");
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\lower_message::clearlowermessages();

  if(!isDefined(var_0)) {
    var_0 = level.framedurationseconds;
  }

  wait var_0;
  scripts\mp\playeractions::allowactionset("gameEndFreeze", 0);

  if(self isonground() || self isonladder()) {
    self allowmovement(0);
    return;
  }

  thread playerzombiesupersprint();
}

function playerzombiesupersprint() {
  self endon("disconnect");
  var_0 = 0;

  while(var_0 < 1) {
    if(!isDefined(self)) {
      return;
    }

    if(!self isonground()) {
      var_0 += level.framedurationseconds;
    } else {
      self allowmovement(0);
      break;
    }

    wait level.framedurationseconds;
  }

  self allowmovement(0);
}

function updatematchbonusscores(var_0) {
  if(!game["timePassed"]) {
    return;
  }

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  if(!scripts\mp\utility\game::gettimelimit() || level.forcedend) {
    var_1 = scripts\mp\utility\game::gettimepassed() / 1000;
    var_1 = min(var_1, 1200);
  } else {
    var_1 = scripts\mp\utility\game::gettimelimit();
  }

  jumpiffalse(level.teambased) LOC_000001e0;
  jumpiffalse(var_1 != "tie") LOC_0000005b;
  setwinningteam(var_1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3.connectedpostgame)) {
      continue;
    }

    if(!var_3 scripts\mp\utility\game::rankingenabled()) {
      continue;
    }

    if(var_3.timeplayed["total"] < 1 || var_3.pers["participation"] < 1) {
      continue;
    }

    if(level.hostforcedend && var_3 ishost()) {
      continue;
    }

    if(!istrue(var_3.pers["hasDoneAnyCombat"])) {
      continue;
    }

    if(var_1 == "tie") {
      var_4 = calculatematchbonus(var_3, "tie", var_1);
      thread givematchbonus(var_3, "tie");
      var_3.matchbonus = var_4;
    } else if(isDefined(var_3.pers["team"]) && var_3.pers["team"] == var_1) {
      var_4 = calculatematchbonus(var_3, "win", var_1);
      thread givematchbonus(var_3, "win");
      var_3.matchbonus = var_4;
    } else if(isDefined(var_3.pers["team"]) && scripts\mp\utility\teams::isgameplayteam(var_3.pers["team"]) && var_3.pers["team"] != var_1) {
      var_4 = calculatematchbonus(var_3, "loss", var_1);
      thread givematchbonus(var_3, "loss");
      var_3.matchbonus = var_4;
    }

    freight_lift_button_activation(var_3, var_1);
  }

  return;
}

function calculatematchbonus(var_0, var_1) {
  var_2 = getdvarint("scr_xp_matchBonusBaseline", 250);
  var_3 = var_1 / 60;
  var_4 = scripts\mp\rank::getscoreinfovalue(var_0);
  var_5 = self.timeplayed["total"] / var_1;
  var_6 = scripts\mp\rank::getgametypexpmultiplier();
  var_7 = int(var_2 * var_4 * var_3 * var_5 * var_6);
  var_7 = int(min(var_7, 16384));
  return var_7;
}

function givematchbonus(var_0, var_1) {
  self endon("disconnect");

  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
    return;
  }

  level waittill("give_match_bonus");
  scripts\mp\rank::giverankxp(var_0, var_1, undefined, 1, 1);

  if(var_0 == "win") {
    thread scripts\mp\awards::givemidmatchaward("match_complete_win");
    return;
  }

  thread scripts\mp\awards::givemidmatchaward("match_complete");
}

function freight_lift_button_activation(var_0) {
  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }

  var_1 = scripts\mp\weaponrank::reload_handle_hintstring() / 60;
  var_2 = var_0 / 60;
  var_3 = int(var_1 * var_2);
  var_4 = int(50);
  var_5 = self.timeplayed["total"] / var_0;
  var_6 = var_4 * var_5;
  var_7 = int(var_3 * var_6);
  var_7 -= int(self.pers["weaponMatchBonusKills"] * var_6);

  if(var_7 <= 0) {
    return;
  }

  var_8 = 0;

  foreach(var_10 in self.pers["killsPerWeapon"]) {
    var_8 += var_3 - var_10.killcount;
  }

  if(var_8 <= 0) {
    return;
  }

  foreach(var_10 in self.pers["killsPerWeapon"]) {
    var_13 = (var_3 - var_10.killcount) / var_8;
    var_14 = int(var_7 * var_13);
    scripts\mp\rank::incrankxp(0, var_10, var_14, "WeaponMatchBonus");

    foreach(var_16 in self.pers["matchdataWeaponStats"]) {
      if(issubstr(var_18, var_19)) {
        if(isDefined(var_16.stats["kills"]) && var_10.killcount > 0) {
          var_17 = var_13 * var_16.stats["kills"] / var_10.killcount;
          var_14 = int(var_7 * var_17);

          if(isDefined(var_16.stats["xp_earned"])) {
            var_16.stats["xp_earned"] = var_16.stats["xp_earned"] + var_14;
          } else {
            var_16.stats["xp_earned"] = var_14;
          }
        }
      }
    }
  }
}

function setxenonranks(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3.score) || !isDefined(var_3.pers["team"])) {}
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    ammobox_onplayerholduse(var_3);
  }
}

function ammobox_onplayerholduse(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(istrue(var_0.pers["xenonRankSet"])) {
    return;
  }

  if(!isDefined(var_0.kills) || !isDefined(var_0.deaths)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(1 > var_0.timeplayed["total"]) {
      return;
    }

    if(!isDefined(var_0.arenadamage)) {
      return;
    }

    var_2 = var_0.arenadamage;
    setplayerteamrank(var_0, var_0.clientid, var_2);
    var_0.pers["xenonRankSet"] = 1;
    return;
  }

  if(scripts\mp\utility\game::validate_track()) {
    var_3 = 1000 - var_1;
    setplayerteamrank(var_0, var_0.clientid, var_3);
    var_0.pers["xenonRankSet"] = 1;
    return;
  }

  if(120 > var_0.timeplayed["total"]) {
    return;
  }

  var_4 = 0;

  if(getdvarint("scr_game_subtract_suicides_from_rank") == 1) {
    var_4 = var_0 scripts\mp\utility\stats::getpersstat("suicides");
  }

  var_5 = (var_0.kills - var_0.deaths - var_4) / var_0.timeplayed["total"] / 60;
  setplayerteamrank(var_0, var_0.clientid, var_5);
  var_0.pers["xenonRankSet"] = 1;
}

function checktimelimit(var_0) {
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
      return;
    }

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

  var_1 = gettimeremaining();
  setgameendtime(gettime() + int(var_1));
  var_2 = istrue(level.ontimelimitgraceperiod);

  if(var_1 > 0 && !isDefined(level.playerplaygestureweaponanim)) {
    if(var_2) {
      if(istrue(level.ref_13124)) {
        setomnvarforallclients("ui_overtime_timer_show", 0);
        return;
      }

      setomnvar("ui_overtime_timer_show", 0);
    }

    return;
  }

  if(var_2) {
    scripts\mp\flags::gameflagset("overtime_started");

    if(!isDefined(level.overtimetotal)) {
      level.overtimetotal = 0;
    } else {
      level.overtimetotal += level.frameduration;
    }

    if(isDefined(level.ontimelimitot)) {
      [[level.ontimelimitot]]();
      level.ontimelimitot = undefined;
    }

    if(istrue(level.canprocessot)) {
      level.currenttimelimitdelay += level.framedurationseconds;
    } else {
      level.currenttimelimitdelay = 0;
    }

    var_3 = clamp(1 - level.currenttimelimitdelay / level.ontimelimitgraceperiod, 0, 1);

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      if(istrue(level.ref_13124)) {
        if(!isDefined(level.playerparachutedetachresetomnvars)) {
          setomnvarforallclients("ui_overtime_timer_show", 1);
        }

        setomnvarforallclients("ui_overtime_timer", var_3);
      } else {
        setomnvar("ui_overtime_timer_show", 1);
        setomnvar("ui_overtime_timer", var_3);
      }

      setomnvar("ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000);
    } else {
      if(istrue(level.ref_13124)) {
        setomnvarforallclients("ui_overtime_timer_show", 0);
        setomnvarforallclients("ui_overtime_timer", var_3);
      } else {
        setomnvar("ui_overtime_timer_show", 0);
        setomnvar("ui_overtime_timer", var_3);
      }

      setomnvar("ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000);
    }

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      return;
    }
  }

  [[level.ontimelimit]]();
}

function enableovertimegameplay() {
  level.ontimelimitgraceperiod = 5;
  level.currenttimelimitdelay = 0;
}

function runjiprules() {
  if(!level.matchmakingmatch) {
    return;
  }

  if(!isDefined(level.nojip)) {
    level.nojip = 0;
  }

  if(!level.nojip) {
    if(scripts\mp\utility\game::isroundbased() && !level.nojip) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "dom":
        case "front":
          var_0 = checkdomjiprules();
          break;
        case "cyber":
        case "siege":
        case "sr":
        case "sd":
        case "arena":
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
        case "br":
          var_0 = getfilterformodifier();
          break;
        default:
          var_0 = checkdefaultjiprules();
          break;
      }

      if(var_0) {
        setnojipscore(1, 1);
        setnojiptime(1, 1);
        level.nojip = 1;
        return;
      }

      return;
    }

    if(!istrue(level.brkillchainchance) && scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      setnojiptime(1, 1);
      level.nojip = 1;
      return;
    }

    return;
  }
}

function checkdomjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    foreach(var_1 in level.teamnamelist) {
      if(getteamscoreint(var_1) > 150) {
        return true;
      }
    }

    if(scripts\mp\utility\game::gettimepassedpercentage() > 75) {
      return true;
    }
  }

  return false;
}

function checksdjiprules() {
  var_0 = 3;

  switch (scripts\mp\utility\game::getgametype()) {
    case "sr":
    case "sd":
      var_0 = 3;
      break;
    case "siege":
      var_0 = 2;
      break;
    case "cyber":
      var_0 = 2;
      break;
    case "arena":
      var_0 = 3;
      break;
    default:
      var_0 = 3;
      break;
  }

  if(scripts\mp\utility\game::isanymlgmatch()) {
    var_0 = 5;
  }

  foreach(var_2 in level.teamnamelist) {
    if(scripts\mp\utility\game::getroundswon(var_2) >= var_0) {
      return true;
    }
  }

  return false;
}

function checkctfjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      return true;
    }
  }

  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    var_4 = getteamscoreint(var_3);

    if(!isDefined(var_0) || var_4 < var_0) {
      var_0 = var_4;
    }

    if(!isDefined(var_1) || var_4 > var_1) {
      var_1 = var_4;
    }
  }

  var_6 = abs(var_1 - var_0);

  if(var_6 > 10) {
    return true;
  }

  return false;
}

function checkballjiprules() {
  if(!scripts\mp\utility\game::isfirstround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      return true;
    }
  }

  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    var_4 = getteamscoreint(var_3);

    if(!isDefined(var_0) || var_4 < var_0) {
      var_0 = var_4;
    }

    if(!isDefined(var_1) || var_4 > var_1) {
      var_1 = var_4;
    }
  }

  var_6 = abs(var_1 - var_0);

  if(var_6 > 15) {
    return true;
  }

  return false;
}

function checkddjiprules() {
  var_0 = 0;

  foreach(var_2 in level.teamnamelist) {
    var_0 += scripts\mp\utility\game::getroundswon(var_2);
  }

  if(var_0 >= 2) {
    return true;
  }

  return false;
}

function checkdefaultjiprules() {
  if(scripts\mp\utility\game::nextroundisfinalround()) {
    if(scripts\mp\utility\game::gettimepassedpercentage() > level.timepercentagecutoff) {
      return true;
    }
  }

  return false;
}

function getfilterformodifier() {
  return !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("allowLateJoiners");
}

function getteamscoreint(var_0) {
  return int(game["teamScores"][var_0]);
}

function gettimeremaining() {
  return scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();
}

function gettimeremainingpercentage() {
  var_0 = scripts\mp\utility\game::gettimelimit() * 1000;
  return (var_0 - scripts\mp\utility\game::gettimepassed()) / var_0;
}

function checkteamscorelimitsoon(var_0) {
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

  var_1 = 0;

  if(ref_132ed()) {
    var_1 = closetoscorelimit(var_0);
  } else if(scripts\mp\utility\game::getgametype() == "arm") {
    var_2 = closetoscorelimit(var_0);
    var_3 = gettimeremaining() < scripts\mp\utility\game::gettimelimit() * 0.075;
    var_1 = var_2 || var_3;
  } else if(scripts\mp\utility\game::gettimepassed() > 45000) {
    var_1 = estimatedtimetillscorelimit(var_0) < 0.5;
  }

  if(!isDefined(level.playedmatchendingsoon)) {
    level.playedmatchendingsoon = 0;
  }

  if(!level.playedmatchendingsoon && var_1) {
    level.playedmatchendingsoon = 1;
    level notify("match_ending_soon", "score");
  }

  if(!level.playedmatchendingsoon && scripts\mp\utility\game::canplayhalfwayvo()) {
    if(getteamscore(var_0) >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      scripts\mp\utility\dialog::leaderdialog("halfway_friendly_score", var_0, "status");
      thread scripts\mp\music_and_dialog::ref_11bdd(var_0);
      var_4 = scripts\mp\utility\teams::getenemyteams(var_0);

      foreach(var_6 in var_4) {
        scripts\mp\utility\dialog::leaderdialog("halfway_enemy_score", var_6, "status");
      }

      level.didhalfscorevoboost = 1;
      return;
    }

    return;
  }
}

function ref_132ed() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "conf":
    case "tdef":
    case "dom":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

function checkplayerscorelimitsoon() {
  if(level.roundscorelimit <= 0 || scripts\mp\utility\game::isobjectivebased()) {
    return;
  }

  if(level.teambased) {
    return;
  }

  if(scripts\mp\utility\game::gettimepassed() < 60000) {
    return;
  }

  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level.nojip) && !level.nojip && scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\gamescore::checkffascorejip();
  }

  if(scripts\mp\utility\game::getgametype() == "gun") {
    if(self.score == 14) {
      level notify("match_ending_soon", "score");
      return;
    }

    return;
  }

  var_0 = estimatedtimetillscorelimit();

  if(var_0 < 2) {
    level notify("match_ending_soon", "score");
    return;
  }
}

function checkscorelimit(var_0) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill()) {
    var_0 = 1;
  }

  if(istrue(var_0)) {
    if(isPlayer(self) && !level.teambased && self.score >= level.roundscorelimit) {
      level.ref_12f0f = 1;
    }

    level notify("checkScoreLimit");
    level endon("checkScoreLimit");
    waitframe();
  }

  if(scripts\mp\utility\game::isobjectivebased()) {
    return 0;
  }

  if(isDefined(level.scorelimitoverride) && level.scorelimitoverride) {
    return 0;
  }

  if(game["state"] != "playing") {
    return 0;
  }

  if(level.roundscorelimit <= 0) {
    return 0;
  }

  if(level.teambased) {
    var_1 = 0;

    for(var_2 = 0; var_2 < level.teamnamelist.size; var_2++) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(level.teamnamelist[var_2])) {
        continue;
      }

      if(game["teamScores"][level.teamnamelist[var_2]] >= level.roundscorelimit) {
        var_1 = 1;
      }
    }

    if(!var_1) {
      return 0;
    }
  } else {
    if(!isPlayer(self)) {
      return 0;
    }

    if(self.score < level.roundscorelimit && !istrue(level.ref_12f0f)) {
      return 0;
    }
  }

  if(!istrue(level.dontendonscore)) {
    return onscorelimit(var_0);
  }
}

function updategametypedvars() {
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

function matchstarttimerwaitforplayers() {
  thread matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);
  thread prematchcountdownnotify();
  waitforplayers(level.prematchperiod);

  if(level.prematchperiodend > 0 && !isDefined(level.hostmigrationtimer)) {
    var_0 = level.prematchperiodend;
    level notify("match_start_real_countdown", var_0);

    if(!scripts\mp\flags::gameflag("infil_will_run") && game["roundsPlayed"] == 0 && !scripts\cp_mp\utility\game_utility::isarenamap()) {
      thread ref_1335d();
    }

    thread matchstarttimer("match_starting_in", var_0);
    thread prematchcountdownnotify(var_0);
    level waittill("matchStartTimer_done");
    return;
  }
}

function ref_1335d() {
  setomnvar("ui_in_infil", 1);
  level scripts\engine\utility::waittill_notify_or_timeout("matchStartTimer_done", 8);
  setomnvar("ui_in_infil", -1);
}

function prematchcountdownnotify(var_0) {
  level notify("prematchCountdownNotify");
  level endon("prematchCountdownNotify");

  if(isDefined(var_0)) {
    wait max(var_0 - 5, 0);
  } else {
    wait max(level.prematchperiod + level.prematchperiodend - 5, 0);
  }

  scripts\mp\flags::gameflagset("prematch_countdown");
}

function startmodeobjidnotify(var_0) {
  self notify("startOBJID");
  self endon("startOBJID");

  if(scripts\mp\utility\game::getgametype() == "sd") {
    var_1 = 6;
  } else {
    var_1 = 5;
  }

  if(var_1 > var_1) {
    var_1 -= var_1;
    max(var_1, 0);
    wait var_1;
  } else {
    wait 0.5;
  }

  level notify("start_mode_setup");
}

function matchstarttimer(var_0, var_1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_2 = int(var_1);
  thread startmodeobjidnotify(level);

  if(var_2 >= 2) {
    setomnvar("ui_match_start_text", var_0);
    var_3 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";
    matchstarttimerperplayer_internal(var_2, var_3);
  }

  visionsetnaked("", 0);
  level notify("matchStartTimer_done");

  if(scripts\cp_mp\utility\game_utility::isrealismenabled() || istrue(level.testrandomrealismclients)) {
    foreach(var_5 in level.players) {
      if(istrue(level.testrandomrealismclients)) {
        if(!isDefined(var_5.isrealismenabled)) {
          if(scripts\engine\utility::cointoss()) {
            var_5 setclientomnvar("ui_realism_hud", 0);
            var_5 setclientomnvar("ui_realism_hud", 1);
            var_5.isrealismenabled = 1;
          }
        }

        continue;
      }

      var_5 setclientomnvar("ui_realism_hud", 0);
      var_5 setclientomnvar("ui_realism_hud", 1);
    }

    return;
  }
}

function matchstarttimerperplayer_internal(var_0, var_1) {
  waittillframeend();
  level endon("match_start_timer_beginning");
  var_1 = istrue(var_1);
  var_2 = int(var_0);

  if(var_1) {
    GscBinSkip4(0x35, var_2);
  }

  var_3 = level.teamnamelist;
  var_5 = getfirstarraykey(var_3);

  if(isDefined(var_5)) {
    var_4 = var_3[var_5];
    GscBinSkip4(0x35, var_4, var_2, var_1);
  }

  var_3 = undefined;
  var_5 = undefined;
  var_6 = ["spectator", "follower"];
  var_7 = var_6;
  var_8 = getfirstarraykey(var_7);

  if(isDefined(var_8)) {
    var_4 = var_7[var_8];
    GscBinSkip4(0x35, var_4, var_2, var_1);
  }

  var_7 = undefined;
  var_8 = undefined;
  GscBinSkip4(0x35, var_2);
}

function ref_11b42(var_0) {
  level endon("match_start_timer_beginning");

  if(!isDefined(level.heli_arrived)) {
    level.heli_arrived = spawn("script_origin", (0, 0, 0));
    level.heli_arrived hide();
  }

  level.matchcountdowntime = var_0;

  while(var_0 > 0 && !level.gameended) {
    if(var_0 < 6) {
      var_1 = scripts\engine\utility::ter_op(var_0 < 4, "match_start_tick_in3", "match_start_tick_in5");
      level.heli_arrived playSound(var_1);
    }

    level.matchcountdowntime = var_0;
    var_0--;
    wait 1;
  }

  level.matchcountdowntime = undefined;
  level.heli_arrived delete();
}

function teamstarttimer(var_0, var_1, var_2) {
  level endon("match_start_timer_beginning");
  var_3 = !istrue(var_2);
  var_4 = undefined;

  if(var_3) {
    var_4 = spawn("script_origin", (0, 0, 0));
    var_4 hide();
    level.matchcountdowntime = var_1;
  }

  if(!level.gameended) {
    jumpiffalse(scripts\mp\utility\game::getgametype() == "br") LOC_00000062;
    thread scripts\mp\gametypes\br_public::ref_1285e(var_0);
    thread scripts\mp\gametypes\br_public::ref_12854(var_0);
    thread scripts\mp\gametypes\br_public::calculateeventstarttime();

    while(var_1 > 0 && !level.gameended) {
      if(var_3 && var_1 < 6) {
        if(var_1 < 4) {
          var_4 playSound("match_start_tick_in3");
        } else {
          var_4 playSound("match_start_tick_in5");
        }
      }

      var_5 = scripts\mp\utility\teams::getteamdata(var_0, "players");

      foreach(var_7 in var_5) {
        if(var_1 <= 80) {
          var_7 setclientomnvar("ui_match_start_countdown", var_1);
          var_7 setclientomnvar("ui_match_in_progress", 0);
        }
      }

      var_1--;

      if(var_3) {
        level.matchcountdowntime = var_1;
      }

      wait 1;
    }

    if(var_3) {
      level.matchcountdowntime = undefined;
      var_4 delete();
    }

    if(getdvarint("scr_game_updated_prematch_allows", 1) == 0) {
      var_5 = scripts\mp\utility\teams::getteamdata(var_0, "players");

      foreach(var_7 in var_5) {
        scripts\mp\playerlogic::clearprematchlook(var_7);
        var_7 scripts\mp\utility\player::_freezecontrols(0, 1);
        var_7 setclientomnvar("ui_match_start_countdown", -1);
        var_7 setclientomnvar("ui_match_in_progress", 1);
      }

      return;
    }

    return;
  }
}

function clearvisionsettimer(var_0) {
  while(var_0 > 0 && !level.gameended) {
    var_0--;
    wait 1;
  }

  visionsetnaked("", 0);
}

function matchstarttimerskip() {
  visionsetnaked("", 0);
}

function onroundswitch(var_0) {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(var_0) {
    level.halftimetype = "overtime";

    if(scripts\mp\utility\game::islastwinbytwo()) {
      var_1 = getbetterteam();

      if(var_1 != game["defenders"]) {
        game["switchedsides"] = !game["switchedsides"];
        level.switchedsides = 1;
        return;
      }

      level.switchedsides = undefined;
      return;
    }

    game["switchedsides"] = !game["switchedsides"];
    level.switchedsides = 1;
    return;
  }

  if(istrue(level.skipdefendersadvantage)) {
    game["switchedsides"] = !game["switchedsides"];
    level.switchedsides = 1;
    return;
  }

  if(shouldgivedefendersadvantage()) {
    var_1 = getbetterteam();

    if(var_1 != game["defenders"]) {
      game["switchedsides"] = !game["switchedsides"];
      level.switchedsides = 1;
      return;
    }

    level.switchedsides = undefined;
    return;
  }

  level.halftimetype = "halftime";
  game["switchedsides"] = !game["switchedsides"];
  level.switchedsides = 1;
}

function shouldgivedefendersadvantage() {
  return game["roundsWon"]["allies"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1;
}

function checkroundswitch(var_0) {
  if(!level.teambased) {
    return false;
  }

  if(!isDefined(level.roundswitch) || !level.roundswitch) {
    return false;
  }

  if(losqueuehighindex()) {
    if(ref_12dbb()) {
      return true;
    }
  } else if(game["roundsPlayed"] % level.roundswitch == 0 || var_0) {
    return true;
  }

  return false;
}

function losqueuehighindex() {
  switch (level.gametype) {
    case "arena":
      if(level.roundswitch == 2 && getdvarint("scr_arena_loadoutChangeRound", 2) == 2) {
        return 1;
      }

      return 0;
    default:
      return 0;
  }
}

function ref_12dbb() {
  switch (level.gametype) {
    case "arena":
      if(game["roundsPlayed"] % level.roundswitch == 1) {
        return 1;
      }

      return 0;
    default:
      return 0;
  }
}

function timeuntilroundend() {
  if(level.gameended) {
    var_0 = (gettime() - level.gameendtime) / 1000;
    var_1 = level.postroundtime - var_0;

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
  var_1 = level.discardtime / 1000 + scripts\mp\utility\game::gettimelimit() - var_0;

  if(isDefined(level.timepaused)) {
    var_1 += level.timepaused;
  }

  return var_1 + level.postroundtime;
}

function freegameplayhudelems() {
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
    return;
  }
}

function gethostplayer() {
  var_0 = getEntArray("player", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost()) {
      return var_0[var_1];
    }
  }
}

function hostidledout() {
  var_0 = gethostplayer();

  if(isDefined(var_0) && !var_0.hasspawned && !isDefined(var_0.selectedclass)) {
    return true;
  }

  return false;
}

function roundendwait(var_0, var_1) {
  if(isDefined(level.ref_12db7)) {
    level[[level.ref_12db7]](var_0, var_1);
    return;
  }

  if(!level.doeomcombat) {
    wait level.ref_127fe + 0.1;
    setomnvarforallclients("post_game_state", 2);
  }

  foreach(var_3 in level.players) {
    var_3 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  if(!var_1) {
    wait var_0;
  } else {
    wait var_0 / 2;
    level notify("give_match_bonus");
    wait var_0 / 2;
  }

  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

function roundenddof(var_0) {
  scripts\mp\utility\player::setdof_spectator();
}

function setwaypointiconinfo(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.waypointcolors[var_0] = var_2;
  level.waypointbgtype[var_0] = var_1;
  level.waypointstring[var_0] = var_3;
  level.waypointshader[var_0] = var_4;
  level.waypointpulses[var_0] = var_5;
}

function initwaypointbackgrounds() {
  var_0 = 0;

  switch (scripts\mp\utility\game::getgametype()) {
    case "trial":
    case "pill":
    case "mtmc":
    case "siege":
    case "dom":
    case "arm":
      setwaypointiconinfo("icon_waypoint_dom_a", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("icon_waypoint_dom_b", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("icon_waypoint_dom_c", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("icon_waypoint_dom_d", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("icon_waypoint_dom_e", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_taking_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_taking_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_taking_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_taking_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_taking_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_capture_a", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_capture_b", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_capture_c", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_capture_d", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_capture_e", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_defend_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_defend_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_defend_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_defend_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_defend_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_defending_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_defending_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_defending_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_defending_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_defending_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_blocking_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_blocking_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_blocking_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_blocking_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_blocking_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_blocked_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_blocked_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_blocked_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_blocked_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_blocked_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_losing_a", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_losing_b", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_losing_c", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_losing_d", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_losing_e", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_captureneutral_a", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_captureneutral_b", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_captureneutral_c", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_captureneutral_d", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_captureneutral_e", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_contested_a", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_contested_b", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_contested_c", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_contested_d", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_contested_e", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_dom_target_a", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_dom_target_b", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_dom_target_c", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_dom_target_d", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_dom_target_e", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0);
      break;
    case "dd":
    case "sd":
      setwaypointiconinfo("waypoint_bomb", 2, "neutral", "MP_INGAME_ONLY/OBJ_BOMB_CAPS", "icon_waypoint_bomb", 1);
      setwaypointiconinfo("icon_waypoint_escort_bomb", 1, "neutral", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_target_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_target_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_bomb_defusing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_bomb_defusing_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_defend_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_defend_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_bomb", 0);
      setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_bomb", 0);
      break;
    case "btm":
    case "hq":
      setwaypointiconinfo("hq_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_DESTROY_CAPS", "icon_waypoint_hq", 0);
      setwaypointiconinfo("hq_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq", 0);
      setwaypointiconinfo("hq_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq", 0);
      setwaypointiconinfo("hq_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq", 0);
      setwaypointiconinfo("hq_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq", 0);
      setwaypointiconinfo("hq_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_hq", 0);
      setwaypointiconinfo("hq_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
      setwaypointiconinfo("hq_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_hq", 0);
    default:
      break;
  }

  setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "icon_minimap_dogtag", 0);
  setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "icon_minimap_dogtag", 0);
  setwaypointiconinfo("waypoint_dogtags_skull", 1, "enemy", "", "icon_minimap_dogtag_skull", 0);
  setwaypointiconinfo("waypoint_dogtags_skull_fr", 1, "friendly", "", "icon_minimap_dogtag_skull", 0);
  setwaypointiconinfo("icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0);
  setwaypointiconinfo("waypoint_capture_kill", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  setwaypointiconinfo("waypoint_escort", 0, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort", 0);
}

function ref_12443(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }

      var_3 = var_2 getentitynumber();

      if(var_3 == var_0) {
        if(scripts\mp\utility\game::getgametype() == "br") {
          var_4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_2.team, var_2.squadindex);
        } else {
          var_4 = scripts\mp\utility\teams::getteamdata(var_3.team, "players");
        }

        if(isDefined(var_3.ref_12444)) {
          var_3.ref_12444 = !var_3.ref_12444;
        } else {
          var_3.ref_12444 = 1;
        }

        foreach(var_6 in var_4) {
          if(isDefined(var_6)) {
            var_6 setclientomnvar("ui_br_rocket_ammo", var_1);
            waitframe();
          }
        }

        if(istrue(scripts\mp\utility\game::matchmakinggame())) {
          if(isDefined(var_3) && var_3 isfireteamleader()) {
            var_8 = var_3 getfireteammembers();

            foreach(var_10 in var_8) {
              if(!isDefined(var_10)) {
                continue;
              }

              var_11 = var_10 getentitynumber();

              if(var_11 != var_15) {
                if(isDefined(var_10.ref_12444)) {
                  var_10.ref_12444 = !var_10.ref_12444;
                } else {
                  var_10.ref_12444 = 1;
                }

                foreach(var_6 in var_4) {
                  if(isDefined(var_6)) {
                    var_6 setclientomnvar("ui_br_rocket_ammo", var_11);
                    waitframe();
                  }
                }
              }
            }
          }
        }

        break;
      }
    }

    var_2 = undefined;
    var_4 = undefined;
  }
}

function setupelevatordoor() {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(!scripts\mp\utility\game::privatematch() && !scripts\mp\gametypes\br_public::tutorial_playSound()) {
      var_0 = [];

      foreach(var_2 in level.players) {
        if(!isDefined(var_2)) {
          continue;
        }

        if(isDefined(var_2.ref_12444) && var_2.ref_12444) {
          var_3 = var_2.team;
          var_4 = 0;
          var_5 = var_0.size;

          for(var_6 = 0; var_6 < var_5; var_6++) {
            if(var_0[var_6] == var_3) {
              var_4 = 1;
            }
          }

          if(!var_4) {
            var_0 = var_3;
            var_7 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_2.team, var_2.squadindex);
            var_8 = [];

            foreach(var_2 in var_7) {
              if(!isDefined(var_2)) {
                continue;
              }

              if(isDefined(var_2.ref_12444) && var_2.ref_12444) {
                var_8 = var_2;
              }
            }

            function_0427(var_8);
            waitframe();
          }
        }
      }

      return;
    }

    return;
  }
}

function callback_startgametype() {
  scripts\mp\load::main();

  if(!isDefined(game["roundsPlayed"])) {
    if(drawentitybounds()) {
      analyticsstreamerlogfilewritetobuffer();
    }

    game["matchHasMoreThan1Player"] = 0;
    game["numPlayersConsideredPlaying"] = 0;
  }

  scripts\mp\flags::gameflaginit("prematch_done", 0);
  scripts\mp\flags::gameflaginit("prematch_fade_done", 0);
  scripts\mp\flags::gameflaginit("prematch_countdown", 0);
  scripts\mp\flags::gameflaginit("graceperiod_done", 0);
  scripts\mp\flags::gameflaginit("infil_setup_complete", 0);
  scripts\mp\flags::gameflaginit("infil_will_run", 0);
  scripts\mp\flags::gameflaginit("infil_started", 0);
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
  setDvar("MPOKQNLPRM", getdvarint("scr_game_forceuav") == 1);
  setDvar("LSTLQNTLPP", istrue(level.noweaponfalloff));
  setDvar("MMLMSSTNSP", istrue(level.armoronweaponswitchlongpress));

  if(scripts\mp\utility\game::matchmakinggame()) {
    setDvar("isMatchMakingGame", 1);
  } else {
    setDvar("isMatchMakingGame", 0);
  }

  thread initwaypointbackgrounds();

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    game["truncated_killcams"] = 0;
    game["life_count"] = 0;

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
    game["strings"]["cowards_way"] = &"MP/COWARDS_WAY_OUT";
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
    setdvarifuninitialized("MSKKKKOPKS", 5);

    if(!level.splitscreen) {
      level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
      level.prematchperiodend = getdvarint("scr_game_matchstarttime", 15);
    }

    if(function_0426()) {
      setnojipscore(1, 1);
      setnojiptime(1, 1);
    } else {
      setnojipscore(0, 1);
      setnojiptime(0, 1);
    }
  } else {
    setdvarifuninitialized("MSKKKKOPKS", 5);

    if(!level.splitscreen) {
      scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
      level.prematchperiodend = getdvarint("scr_game_roundstarttime", 5);
    }
  }

  if(!isDefined(game["allies"])) {
    game["allies"] = "SAS";
  }

  if(!isDefined(game["axis"])) {
    game["axis"] = "RUSF";
  }

  if(!isDefined(game["team_three"])) {
    game["team_three"] = "USMC";
  }

  if(!isDefined(game["team_four"])) {
    game["team_four"] = "SABF";
  }

  if(!isDefined(game["team_five"])) {
    game["team_five"] = "SAS";
  }

  if(!isDefined(game["team_six"])) {
    game["team_six"] = "RUSF";
  }

  if(!isDefined(game["status"])) {
    game["status"] = "normal";
  }

  setDvar("ui_overtime", scripts\mp\utility\game::inovertime());

  if(!isDefined(game["timePassed"])) {
    game["timePassed"] = 0;
  }

  if(!isDefined(game["roundsPlayed"])) {
    game["roundsPlayed"] = 0;
  }

  if(!isDefined(game["overtimeRoundsPlayed"])) {
    game["overtimeRoundsPlayed"] = 0;
  }

  if(!isDefined(game["matchPoint"])) {
    game["matchPoint"] = 0;
  }

  if(!isDefined(game["finalRound"])) {
    game["finalRound"] = 0;
  }

  if(!isDefined(game["previousWinningTeam"])) {
    game["previousWinningTeam"] = "";
  }

  setomnvar("ui_last_round", game["finalRound"]);

  if(!isDefined(game["roundsWon"])) {
    game["roundsWon"] = [];
  }

  if(!isDefined(game["teamScores"])) {
    game["teamScores"] = [];
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

  if(!isDefined(game["timeToBeatScoreOld"])) {
    game["timeToBeatScoreOld"] = 0;
  }

  level.initship = 0;
  level.gameended = 0;
  level.forcedend = 0;
  level.hostforcedend = 0;
  level.hardcoremode = getdvarint("OSMSLRTOP");
  setdvarifuninitialized("debug_stopAFKCheck", 0);
  setdvarifuninitialized("debug_GLSpectate", 0);
  level.testrandomrealismclients = getdvarint("scr_random_realism_hud", 0) == 1;
  level.get_wave_max_count = getdvarint("scr_game_cdltuning", 0);
  level.loadout_updateclassdefault_weapons = scripts\mp\utility\game::isanymlgmatch();
  level.tacticalmode = scripts\mp\utility\game::matchmakinggame() && getdvarint("scr_tactical") || getdvarint("scr_game_tacticalmode");

  if(level.tacticalmode) {
    setomnvar("ui_realism_mode", 1);
  }

  if(level.tacticalmode) {
    if(scripts\mp\utility\game::getgametype() != "br") {
      level.modifyplayerdamage = &scripts\mp\damage::gamemodemodifyplayerdamage;
    }

    setDvar("LNOKTQPLKO", 1);
    setDvar("sprintLeap_enabled", 0);
  }

  if(level.hardcoremode) {
    logstring("game mode: hardcore");
  }

  level.diehardmode = getdvarint("scr_diehard");
  level.casualscorestreaks = getdvarint("scr_game_casualScoreStreaks");
  level.ref_145ec = getdvarint("scr_game_wrapKillstreaks");

  if(!isDefined(level.crankedbombtimer)) {
    level.crankedbombtimer = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_crankedBombTimer", 0);
  }

  level.supportcranked = scripts\engine\utility::ter_op(getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_crankedBombTimer") > 0, 1, 0);

  if(!level.teambased) {
    level.diehardmode = 0;
  }

  if(level.diehardmode) {
    logstring("game mode: diehard");
  }

  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_vampirism", "scr_game_vampirism");

  if(level.matchrules_vampirism) {
    level.modifyplayerdamage = &scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  level.finalkillcamtype = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_killcamType", "scr_game_killcamType");

  if(level.finalkillcamtype == 2) {
    level.skipfinalkillcam = 1;
  }

  level.allowkillstreaks = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_allowKillstreaks", "scr_game_allowKillstreaks");
  level.roundretainstreaks = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_roundRetainStreaks", "scr_game_roundRetainStreaks");
  level.roundretainstreakprog = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_roundRetainStreakProg", "scr_game_roundRetainStreakProg");
  level.deathretainstreaks = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_deathRetainStreaks", "scr_game_deathRetainStreaks");
  level.allowperks = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_allowPerks", "scr_game_allowPerks");
  level.allowsupers = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_allowSupers", "scr_game_allowSupers");
  level.superfastchargerate = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_superFastChargeRate", "scr_game_superFastChargeRate");
  level.superpointsmod = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_superPointsMod", "scr_game_superPointsMod");
  level.spawnprotectiontimer = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_spawnProtectionTimer", "scr_game_spawnProtectionTimer");
  level.lethaldelay = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_lethalDelay", "scr_game_lethalDelay");
  level.equipmentmatchstartshieldms = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_equipmentMSProtect", "scr_game_equipmentMSProtect") * 1000;
  level.magcount = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_magcount", "scr_game_magcount");

  if(!isDefined(level.practiceround)) {
    level.practiceround = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_practiceRound", "scr_game_practiceRound");
  }

  level.postgameexfil = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_postGameExfil", "scr_game_postGameExfil");
  level.exfilactivetimer = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_exfilActiveTimer", "scr_game_exfilActiveTimer");
  level.exfilextracttimer = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_exfilExtractTimer", "scr_game_exfilExtractTimer");
  level.useammorestocklocs = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_useAmmoRestockLocs", "scr_game_useAmmoRestockLocs");
  level.ref_136d8 = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_allow3rdspectate", "scr_game_allow3rdspectate");
  setDvar("LKNNQKNTS", level.ref_136d8);
  level.laststand = scripts\mp\tweakables::gettweakablevalue("player", "laststand");
  setomnvar("ui_last_stand_type", level.laststand);

  if(scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\teamrevive::init();
  }

  if(scripts\mp\utility\game::usingfallback()) {
    getintorzero();
  }

  level.minimaponbydefault = (getdvarint("scr_game_enableMinimap") != 0 || getdvarint("scr_showDefaultMinimap") != 0) && !istrue(game["isLaunchChunk"]);
  var_0 = scripts\mp\utility\game::getgametype();
  level.radarhideshots = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + var_0 + "_radarHidePings", "scr_game_radarHidePings");
  setomnvar("ui_compass_hide_weapon_pings_minimap", level.radarhideshots);
  level.navbarhideshots = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + var_0 + "_navBarHidePings", "scr_game_navBarHidePings");
  setomnvar("ui_compass_hide_weapon_pings_navbar", level.navbarhideshots);
  level.navbarhideenemies = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + var_0 + "_navBarHideEnemy", "scr_game_navBarHideEnemy");
  setomnvar("ui_compass_hide_enemy_navbar", level.navbarhideenemies);
  level.disablesupersprint = getdvarint("scr_player_disableSuperSprint");
  level.loadout_updateammo = getdvarint("scr_player_disableMount");
  level.disablebattlechatter = getdvarint("scr_game_disableBattleChatter");
  level.little_bird_mg_mp_init = getdvarint("scr_game_disableAnnouncer");
  level.scoremod = [];
  level.scoremod["kill"] = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_pointsPerKill");
  level.scoremod["death"] = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_pointsPerDeath");
  level.scoremod["headshot"] = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_pointsHeadshotBonus");
  level.scoremod["kskill"] = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_pointsPerKSKill");

  if(level.practiceround && !isDefined(game["practiceRound"])) {
    game["practiceRound"] = 1;
    level.roundretainstreaks = 0;
    level.roundretainstreakprog = 0;
    level.ignorescoring = 1;
    game["dialog"]["offense_obj"] = "gamestate_practice";
    game["dialog"]["defense_obj"] = "gamestate_practice";
  }

  setomnvar("ui_match_timer_hidden", 1);

  if(scripts\cp_mp\utility\game_utility::isarenamap()) {
    if(scripts\mp\utility\game_utility_mp::ref_11c7f()) {
      level.allowkillstreaks = 0;
      setomnvar("ui_disable_killstreaks", 1);
    } else {
      setomnvar("ui_disable_killstreaks", 0);
    }
  } else {
    setomnvar("ui_disable_killstreaks", 0);
    setomnvar("ui_disable_fieldupgrades", 0);
  }

  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  scripts\cp_mp\utility\game_utility::getlocaleid();
  logstring("[KEY_MOMENT] StartGameType");
  logstring("=====================================");
  logstring("Map: " + level.script);
  logstring("Script:" + scripts\mp\utility\game::getgametype());
  logstring("HardCore:" + level.hardcoremode);
  logstring("Diehard: " + level.diehardmode);
  logstring("3rd Person:" + getdvarint("NOSLRNTRKL"));
  logstring("Round: " + game["roundsPlayed"]);
  logstring("scr_" + scripts\mp\utility\game::getgametype() + "_scorelimit " + getDvar("scr_" + scripts\mp\utility\game::getgametype() + "_scorelimit"));
  logstring("scr_" + scripts\mp\utility\game::getgametype() + "_roundlimit " + getDvar("scr_" + scripts\mp\utility\game::getgametype() + "_roundlimit"));
  logstring("scr_" + scripts\mp\utility\game::getgametype() + "_winlimit " + getDvar("scr_" + scripts\mp\utility\game::getgametype() + "_winlimit"));
  logstring("scr_" + scripts\mp\utility\game::getgametype() + "_timelimit " + getDvar("scr_" + scripts\mp\utility\game::getgametype() + "_timelimit"));
  logstring("scr_" + scripts\mp\utility\game::getgametype() + "_numlives " + getDvar("scr_" + scripts\mp\utility\game::getgametype() + "_numlives"));
  logstring("scr_" + scripts\mp\utility\game::getgametype() + "_halftime " + getDvar("scr_" + scripts\mp\utility\game::getgametype() + "_halftime"));
  logstring("scr_" + scripts\mp\utility\game::getgametype() + "_roundswitch " + getDvar("scr_" + scripts\mp\utility\game::getgametype() + "_roundswitch"));
  logstring("=====================================");
  level.usestartspawns = 1;
  level thread scripts\mp\infilexfil\infilexfil::infil_init();
  scripts\mp\utility\spawn_event_aggregator::init();
  scripts\mp\utility\lui_game_event_aggregator::init();
  scripts\mp\utility\disconnect_event_aggregator::init();
  scripts\mp\utility\player_frame_update_aggregator::init();
  scripts\cp_mp\ent_manager::init();
  scripts\mp\playerlogic::init();
  scripts\cp_mp\utility\game_utility::teamwipedobituary();
  level.maxallowedteamkills = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_ffPunishLimit", "scr_game_ffPunishLimit");
  thread scripts\mp\init_cp_mp::init();
  thread scripts\mp\teams::init();
  _calloutmarkerping_handleluinotify_cleared::ref_13a9e();
  scripts\cp_mp\utility\player_utility::temp_debug_wait_and_stop_music_loop();
  thread scripts\common\utility::allow_init();
  thread scripts\cp_mp\utility\shellshock_utility::shellshock_utility_init();
  thread scripts\cp_mp\utility\game_utility::game_utility_init();
  thread scripts\mp\playeractions::init();
  thread scripts\mp\healthoverlay::init();
  thread scripts\mp\killcam::init();
  thread scripts\mp\final_killcam::initfinalkillcam();
  thread scripts\cp\vehicles\vehicle_compass_cp::init();
  thread scripts\mp\equipment\fulton::init();
  scripts\mp\utility\dialog::initstatusdialog();

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread scripts\mp\battlechatter_mp::init();
  } else if(!scripts\mp\utility\game::runleanthreadmode()) {
    thread scripts\mp\battlechatter_mp::init();
  } else {
    level.battlechatterenabled = 0;
  }

  thread scripts\mp\music_and_dialog::init();
  thread scripts\mp\class::init();

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    thread scripts\mp\persistence::init();
  }

  thread scripts\mp\rank::init();
  thread scripts\mp\playercards::init();
  thread scripts\mp\menus::init();
  thread scripts\mp\hud::init();
  thread scripts\mp\serversettings::init();
  thread scripts\mp\weapons::init();
  thread scripts\mp\outline::init();
  thread scripts\mp\shellshock::init();
  thread scripts\mp\deathicons::init();
  thread scripts\mp\damagefeedback::init();
  thread scripts\mp\lightarmor::init();
  thread scripts\mp\gameobjects::init();
  thread scripts\mp\spectating::init();
  thread scripts\mp\spawnlogic::init();

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread scripts\cp_mp\vehicles\vehicle_collision::init();
    thread scripts\cp_mp\vehicles\little_bird_mg::init();
  } else {
    thread scripts\mp\matchdata::init();
    thread scripts\mp\clientmatchdata::init();
  }

  thread scripts\mp\awards::init();
  thread scripts\mp\playerlogic::initsegmentstats();

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&scripts\mp\playerlogic::updateinputtypewatcher);
  }

  scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&scripts\mp\weapons::set_cp_vehicle_health_values);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch()) {
    level scripts\common\ui::lui_registercallback("play_again_squad_request", &ref_12443);
  }

  thread scripts\mp\passives::init();
  thread scripts\mp\perks\perks::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
    thread scripts\cp_mp\killstreaks\init::init();
    thread scripts\mp\perks\perks::initspecialistkillstreaks();
  }

  thread scripts\mp\events::init();
  thread scripts\mp\archetypes\archcommon::init();

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    thread scripts\mp\whizby::init();
  }

  thread scripts\mp\analyticslog::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\mp\loot::init();
    thread scripts\mp\supers::init();
    thread scripts\mp\supers::watchsuperdelay();
  }

  thread scripts\mp\callouts::init();
  thread scripts\mp\bounty::init();
  thread allow_weapon_mp_init();
  thread ismp_init();
  thread scripts\cp_mp\gestures::init();
  thread scripts\mp\gestures_mp::init_mp();
  thread scripts\mp\accessories::init();
  thread scripts\cp_mp\execution::execution_init();
  thread scripts\mp\sentientpoolmanager::init();
  thread scripts\mp\objidpoolmanager::init();
  thread scripts\mp\arbitrary_up::initarbitraryuptriggers();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\mp\turret::init();
  }

  thread scripts\mp\laststand::init();
  thread scripts\mp\equipment::init();
  thread scripts\mp\matchstats::init();
  thread scripts\mp\playerstats::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\cp_mp\auto_ascender::init();
    thread scripts\cp\utility\script::init();
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
  level.allowreviveweapons = getdvarint("scr_player_reviveuseweapon", 0);
  scripts\mp\playeractions::registeractionset("reviveShoot", ["weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload"]);
  scripts\mp\playeractions::registeractionset("gameEndFreeze", ["usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "crouch", "prone", "melee"]);

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    thread scripts\mp\codcasterclientmatchdata::init();
  }

  thread scripts\mp\accolades::init();
  thread scripts\cp_mp\utility\train_utility::init();
  scripts\common\utility::allow_add("equipment", &scripts\mp\equipment::allow_equipment);
  scripts\common\utility::allow_add("gesture", &scripts\mp\utility\player::allow_gesture);
  scripts\common\utility::allow_add("supers", &scripts\common\utility::allow_supers);
  scripts\common\utility::allow_add("health_regen", &scripts\mp\utility\player::allow_health_regen);
  scripts\common\utility::allow_add("one_hit_melee_victim", &scripts\mp\utility\player::allow_one_hit_melee_victim);
  scripts\common\utility::allow_add("flashed", &scripts\mp\utility\player::allow_flashed);
  scripts\common\utility::allow_add("stunned", &scripts\mp\utility\player::allow_stunned);
  scripts\common\utility::allow_add("stick_kill", &scripts\mp\utility\player::allow_stick_kill);

  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      if(!isDefined(game["roundsWon"][var_2])) {
        game["roundsWon"][var_2] = 0;
      }

      if(!isDefined(game["teamScores"][var_2])) {
        game["teamScores"][var_2] = 0;
      }
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

  foreach(var_5 in level.teamnamelist) {
    level.wavedelay[var_5] = 0;
    level.lastwave[var_5] = 0;
    level.waveplayerspawnindex[var_5] = 0;
    level.aliveplayers[var_5] = [];

    if(!istrue(level.ref_12c49)) {
      level.requiredplayercount[var_5] = 0;
    }
  }

  setomnvar("ui_scorelimit", 0);
  setDvar("ui_allow_teamchange", 1);

  if(!istrue(game["isLaunchChunk"])) {
    setomnvar("ui_round_hint_override_attackers", 0);
    setomnvar("ui_round_hint_override_defenders", 0);
  }

  if(scripts\mp\utility\game::getgametypenumlives()) {
    setDvar("SLLNLPRON", 0);
  } else {
    setDvar("SLLNLPRON", 1);
  }

  updatewavespawndelay();
  level.graceperiod = 15;
  level.ingraceperiod = level.graceperiod;

  if(!isDefined(level.roundenddelay)) {
    level.roundenddelay = 6;
  }

  level.playovertime = 0;
  level.finalroundenddelay = 3;
  level.halftimeroundenddelay = 3;
  level.ref_127fe = 0.25;
  level.scorelimit = scripts\mp\utility\dvars::getwatcheddvar("scorelimit");
  level.roundlimit = scripts\mp\utility\dvars::getwatcheddvar("roundlimit");
  level.winlimit = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

  if(istrue(game["isLaunchChunk"])) {
    setomnvar("ui_current_round", level.currentround);
  } else if(level.roundlimit != 1) {
    setomnvar("ui_current_round", level.currentround);
  }

  if(level.scorelimit == 1) {
    level.roundscorelimit = 1;
    level.totalscorelimit = level.winlimit;
  } else {
    level.roundscorelimit = level.scorelimit * (game["roundsPlayed"] + 1);
    level.totalscorelimit = level.scorelimit * level.roundlimit;
  }

  if(scripts\mp\utility\game::resetscoreonroundstart()) {
    level.roundscorelimit = level.scorelimit;
    level.totalscorelimit = level.scorelimit;
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
  }

  if(scripts\mp\utility\game::isovertimesupportedgametype() && scripts\mp\utility\game::inovertime()) {
    scripts\mp\gamescore::updateovertimescore();
  }

  if(level.teambased) {
    foreach(var_5 in level.teamnamelist) {
      scripts\mp\gamescore::updateteamscore(var_5);
    }
  }

  thread updateuiscorelimit();
  level notify("update_scorelimit");

  if(isDefined(level.matchrecording_init)) {
    level thread[[level.matchrecording_init]]();
  }

  if(getdvarint("scr_allow_custom_loadouts", 0) == 0 || scripts\mp\utility\game::tv_station_intro_camera()) {
    setomnvar("ui_only_default_loadouts", 1);
  }

  [[level.onstartgametype]]();
  level thread scripts\mp\gametypes\common::onplayerconnectcommon();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&scripts\mp\gametypes\common::onplayerdisconnectcommon);
  level.scorepercentagecutoff = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_score_percentage_cut_off", 70);
  level.timepercentagecutoff = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_time_percentage_cut_off", 70);

  if(getDvar("dedicated") == "dedicated LAN server" || getDvar("dedicated") == "dedicated internet server") {
    thread verifydedicatedconfiguration();
  }

  thread startgame();
  level thread scripts\mp\utility\dvars::updatewatcheddvars();

  if(!istrue(level.istacops)) {
    thread timelimitthread();
  }

  thread updateleaderboardstatscontinuous();
  level thread scripts\mp\playerlogic::updateplayerwindmaterial();
  thread ref_12c14();
}

function updatewavespawndelay(var_0, var_1) {
  if(isDefined(var_0)) {
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay", var_0);
  }

  if(isDefined(var_1)) {
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay_alt", var_1);
  }

  var_2 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay");
  var_3 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay_alt");

  if(var_2) {
    foreach(var_5 in level.teamnamelist) {
      level.wavedelay[var_5] = var_2;
      level.lastwave[var_5] = 0;
    }

    thread wavespawntimer();
    return;
  }
}

function verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!getdvarint("LSTLQTSSRM")) {
      exitlevel(0);
    }

    if(getDvar("dedicated") != "dedicated LAN server" && getDvar("dedicated") != "dedicated internet server") {
      exitlevel(0);
    }

    wait 5;
  }
}

function timelimitthread() {
  level endon("game_ended");
  var_0 = scripts\mp\utility\game::gettimepassed();

  while(game["state"] == "playing") {
    waittillframeend();
    thread checktimelimit(var_0);
    var_0 = scripts\mp\utility\game::gettimepassed();

    if(isDefined(level.starttime)) {
      if(gettimeremaining() < 3000 || istrue(level.playerplaygestureweaponanim)) {
        waitframe();
        continue;
      }
    }

    wait 1;
  }
}

function updateuiscorelimit() {
  for(;;) {
    level scripts\engine\utility::waittill_either("update_scorelimit", "update_winlimit");

    if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        foreach(var_1 in level.players) {
          var_1 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_1.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_1 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_1.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        foreach(var_1 in level.players) {
          var_1 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_1.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_1 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_1.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::iswinbytworulegametype()) {
        var_5 = game["roundsWon"][game["defenders"]];
        var_6 = game["roundsWon"][game["attackers"]];
        var_7 = 0;

        if(var_5 == var_6) {
          var_7 = var_5 + 2;
        } else if(var_5 > var_6) {
          var_7 = var_5 + 1;
        } else {
          var_7 = var_6 + 1;
        }

        setomnvar("ui_scorelimit", var_7);
      } else {
        usenormalscorelimit();
      }

      continue;
    }

    usenormalscorelimit();
  }
}

function usenormalscorelimit() {
  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    setomnvar("ui_scorelimit", level.totalscorelimit);
    thread checkscorelimit();
    return;
  }

  setomnvar("ui_scorelimit", level.winlimit);
}

function playtickingsound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  var_0 = level.bombtimer;

  for(;;) {
    self playSound("ui_mp_suitcasebomb_timer");

    if(var_0 > 5) {
      var_0 -= 1;
      wait 1;
    } else {
      var_0 -= 0.5;
      wait 0.5;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function stoptickingsound() {
  self notify("stop_ticking");
}

function relic_bang_and_boom_dropfunc(var_0) {
  if(var_0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var_0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var_0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var_0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function timelimitclock() {
  level endon("cancel_announcer_dialog");
  waitframe();

  if(isDefined(level.ref_13b7e)) {
    GscBinSkip1(0x74, level.ref_13b7e);
  }

  if(scripts\mp\utility\game::gettimelimit() == 0) {
    return;
  }

  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 hide();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["state"] == "playing") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit() && !istrue(level.bombsplanted)) {
      var_5 = gettimeremaining() / 1000;
      var_6 = int(var_5 + 0.5);
      var_7 = 0;

      if(var_4 == 2 && var_6 % 2 == 1) {
        var_7 = 1;
      }

      if(!var_1 && (var_7 == 1 && var_6 == 61 || var_7 == 0 && var_6 == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_sixty");
        level notify("match_ending_soon", "time");
        var_1 = 1;
      } else if(!var_2 && (var_7 == 1 && var_6 == 31 || var_7 == 0 && var_6 == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_thirty");
        var_3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
        level notify("match_ending_soon", "time");
        var_2 = 1;
      } else if(!var_1 && !var_2 && !var_3 && var_6 >= 30 && var_6 <= 45) {
        var_3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
        level notify("match_ending_soon", "time");
      }

      if(var_6 <= 10 || var_6 <= 30 && var_6 % var_4 == var_7) {
        if(!var_3 && var_6 <= 10) {
          var_3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup", var_6);
        }

        level notify("match_ending_very_soon");
        var_8 = 1;

        if(var_6 == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < var_5) {
          var_7 = 0;
        }

        if(var_7) {
          var_9 = relic_bang_and_boom_dropfunc(var_4); <
          error > playSound(var_9);
        }
      }

      if(var_4 - floor(var_4) >= 0.05) {
        wait var_4 - floor(var_4);
        continue;
      }
    }

    wait 1;
  }
}

function ref_1330a() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "cyber":
    case "sd":
    case "arena":
      return 1;
    default:
      return 0;
  }
}

function gametimer() {
  level endon("game_ended");

  if(isDefined(game["startTimeFromMatchStart"])) {
    level.starttimefrommatchstart = game["startTimeFromMatchStart"];
  }

  level waittill("prematch_over");
  level.starttime = gettime();
  level.discardtime = 0;
  level.overtimetotal = 0;

  if(!isDefined(game["startTimeFromMatchStart"])) {
    game["startTimeFromMatchStart"] = gettime();
    level.starttimefrommatchstart = gettime();
    scripts\common\utility::ref_13e0a(level.ref_11b33);
  }

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime -= game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundStartTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  var_0 = gettime();

  while(game["state"] == "playing") {
    if(!level.timerstopped) {
      game["timePassed"] = game["timePassed"] + gettime() - var_0;
    }

    var_0 = gettime();
    wait 1;
  }
}

function updatetimerpausedness(var_0) {
  var_1 = level.timerstoppedforgamemode || isDefined(level.hostmigrationtimer);

  if(!level.timerstopped && var_1) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
    var_2 = gettimeremaining();

    if(isDefined(var_0)) {
      setgameendtime(var_0);
    } else {
      setgameendtime(gettime() + int(var_2));
    }

    setomnvar("ui_match_timer_stopped", 1);
    return;
  }

  if(level.timerstopped && !var_1) {
    level.timerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
    var_2 = gettimeremaining();

    if(isDefined(var_0)) {
      setgameendtime(var_0);
    } else {
      setgameendtime(gettime() + int(var_2));
    }

    setomnvar("ui_match_timer_stopped", 0);
    return;
  }
}

function pausetimer(var_0) {
  if(!level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 1;
    updatetimerpausedness(var_0);
    return;
  }
}

function resumetimer(var_0) {
  if(level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 0;
    updatetimerpausedness(var_0);
    return;
  }
}

function startgame() {
  setslowmotion(1, 1, 0);
  thread gametimer();
  level.timerstopped = 0;
  level.timerstoppedforgamemode = 0;
  setomnvar("ui_prematch_period", 1);
  prematchperiod();
  sysprint("Ready for Compass");
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(getdvarint("scr_game_updated_prematch_allows", 1) == 1) {
    foreach(var_1 in level.players) {
      scripts\mp\playerlogic::clearprematchlook(var_1);
      var_1 scripts\mp\utility\player::_freezecontrols(0, 1);
      var_1 setclientomnvar("ui_match_start_countdown", -1);
      var_1 setclientomnvar("ui_match_in_progress", 1);
      var_1 setmoverantilagged();

      if(scripts\mp\utility\game::getgametype() == "br") {
        var_1 scripts\mp\persistence::touchedmovingplatform();
      }
    }
  }

  scripts\mp\flags::gameflagset("prematch_done");
  level notify("prematch_over");
  setomnvar("ui_prematch_period", 0);

  if(ref_1330a() && game["roundsPlayed"] == 0) {
    logstring("IWH-315293: ELECTRICEEL: Prematch done");
  }

  updatetimerpausedness();
  var_3 = scripts\mp\utility\game::gettimelimit();

  if(var_3 > 0) {
    thread waitthenshowtimer();
  } else {
    setomnvar("ui_match_timer_hidden", 1);
  }

  cleanpatchablecollision();
  thread timelimitclock();
  thread graceperiod();
  thread scripts\cp\vehicles\vehicle_compass_cp::roundbegin();

  if(getdvarint("OOTQKOTRM", 0) > 30 && !istrue(level.multiteambased)) {
    setDvar("LKTPRPKPMR", 1);
  }

  thread scripts\mp\analyticslog::recordbreadcrumbdata();

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    thread ref_119ae();
    return;
  }
}

function waitthenshowtimer() {
  setomnvar("ui_match_timer_hidden", 1);
  wait 0.25;
  setomnvar("ui_match_timer_hidden", 0);
}

function cleanpatchablecollision() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, getEnt("clip32x32x8", "targetname"));
}

function ref_12c4c(var_0) {
  if(istrue(level.ref_121f1)) {
    return;
  }

  if(!isDefined(level.ref_121f2)) {
    level.ref_121f2 = [];
  }

  level.ref_121f2[var_0] = 1;
}

function wavespawntimer() {
  level endon("game_ended");
  level notify("waveSpawnTimer");
  level endon("waveSpawnTimer");
  jumpiffalse(isDefined(level.tacopssublevel)) LOC_00000026;
  thread wavetimerwatcher();

  while(game["state"] == "playing") {
    var_0 = gettime();

    foreach(var_2 in level.teamnamelist) {
      if(var_0 - level.lastwave[var_2] > level.wavedelay[var_2] * 1000) {
        level notify("wave_respawn_" + var_2);
        level.lastwave[var_2] = var_0;
        level.waveplayerspawnindex[var_2] = 0;
      }
    }

    waitframe();
  }
}

function wavetimerwatcher() {
  level endon("waveSpawnTimer");

  for(;;) {
    scripts\engine\utility::ref_143a5("wave_respawn_allies", "wave_respawn_axis");
    setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.wavedelay["allies"]);
  }
}

function getbetterteam() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.teamnamelist) {
    var_0 = 0;
    var_1 = 0;
  }

  foreach(var_6 in level.players) {
    var_7 = var_6.pers["team"];

    if(isDefined(var_7) && scripts\mp\utility\teams::isgameplayteam(var_7)) {
      var_0 = var_0[var_7] + var_6.kills;
      var_1 = var_1[var_7] + var_6.deaths;
    }
  }

  var_9 = undefined;
  var_10 = undefined;
  var_11 = 0;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = 0;

  foreach(var_3 in level.teamnamelist) {
    var_16 = var_0[var_3];

    if(!isDefined(var_9) || var_16 > var_9) {
      var_9 = var_16;
      var_10 = var_3;
      var_11 = 0;
    } else if(var_9 == var_16) {
      var_11 = 1;
    }

    var_17 = var_1[var_3];

    if(!isDefined(var_12) || var_17 < var_12) {
      var_12 = var_17;
      var_13 = var_3;
      var_14 = 0;
      continue;
    }

    if(var_12 == var_17) {
      var_14 = 1;
    }
  }

  if(!var_11) {
    return var_10;
  }

  if(!var_14) {
    return var_13;
  }

  var_19 = randomint(level.teamnamelist.size);
  return level.teamnamelist[var_19];
}

function rankedmatchupdates(var_0) {
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

function displayroundend(var_0, var_1, var_2) {
  thread scripts\mp\music_and_dialog::round_end_music(var_0, var_1, var_2);

  if(!level.doeomcombat && scripts\mp\utility\game::ismoddedroundgame() && game["finalRound"] == 0) {
    var_0 = "roundend";
  }

  level.roundendextramessage = 0;

  if(!scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::getgametype() == "arena" && !istrue(game["practiceRound"])) {
    if(checkroundswitch(level.playovertime)) {
      level.roundendextramessage = game["round_end_exmsg"]["switching_sides"];
    }
  }

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::ref_1332b()) {
    var_0 = "tie";
    var_1 = game["end_reason"]["win_by_two_tie"];
    var_2 = game["end_reason"]["win_by_two_tie"];
  }

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 1, var_1, var_2, level.roundendextramessage);
      continue;
    }

    var_4 thread scripts\mp\hud_message::outcomenotify(var_0, var_1, var_2);
  }
}

function displaygameend(var_0, var_1, var_2) {
  setomnvar("ui_match_over", 1);

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::ref_1332b()) {
    var_0 = "tie";
    var_1 = game["end_reason"]["win_by_two_tie"];
    var_2 = game["end_reason"]["win_by_two_tie"];
  }

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 0, var_1, var_2);
      continue;
    }

    var_4 thread scripts\mp\hud_message::outcomenotify(var_0, var_1, var_2);
  }
}

function displayroundswitch() {
  level notify("spawning_intermission");

  if(isDefined(level.ref_11c68)) {
    [[level.ref_11c68]]();
  }

  var_0 = remove_player_from_focus_fire_attacker_list();

  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\playerlogic::spawnintermission(var_0);
  }

  var_4 = level.halftimetype;

  if(var_4 == "halftime") {
    if(level.roundlimit) {
      if(game["roundsPlayed"] * 2 == level.roundlimit) {
        var_4 = "halftime";
      } else {
        var_4 = "intermission";
      }
    } else {
      var_4 = "intermission";
    }
  }

  level notify("round_switch", var_4);
  var_5 = 0;

  if(game["finalRound"] == 1) {
    var_4 = "final_round";
  } else if(game["matchPoint"] == 1) {
    var_4 = "match_point";

    if(scripts\mp\utility\game::iswinbytworulegametype() && game["roundsWon"]["allies"] == game["roundsWon"]["axis"]) {
      var_4 = "win_by_two";
    }
  }

  if(isDefined(level.switchedsides)) {
    var_5 = game["end_reason"]["switching_sides"];
    level.roundendextramessage = 0;

    if(var_4 != "final_round" && var_4 != "match_point") {
      var_4 = "switching_sides";
    }
  }

  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\hud_message::teamoutcomenotify(var_4, 1, var_5, var_5, level.roundendextramessage);
  }

  roundendwait(level.halftimeroundenddelay, 0);
}

function freezeallplayers(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(var_0 > 0 && var_3) {
    thread slowmotionendofgame(var_0);
  }

  thread sendgameendedfrozennotify(var_0);
  var_4 = scripts\mp\utility\game::updatetextongamepadchange();

  foreach(var_6 in level.players) {
    var_6 enableplayerbreathsystem(0);
    thread freezeplayerforroundend(var_6);
    thread roundenddof(var_6);
    freegameplayhudelems(var_6);
    var_6 setclientdvars("LQKPQMPRQN", var_4, "cg_drawSpectatorMessages", 0);

    if(isDefined(var_1) && isDefined(var_2)) {
      if(var_1 == "NSSLSNKPN" && var_6 issplitscreenplayer()) {
        var_6 setclientdvars(var_1, 0.75);
      }

      var_6 setclientdvars(var_1, var_2);
    }
  }

  if(isDefined(level.agentarray)) {
    foreach(var_9 in level.agentarray) {
      var_9 scripts\mp\utility\player::_freezecontrols(1, undefined, "freezeAllPlayers");
    }

    return;
  }
}

function endofroundvisionset(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  visionsetfadetoblack("bw", 0.75);
}

function slowmotionendofgame(var_0) {
  setslowmotion(1, 0.4, var_0);
  setendofroundsoundtimescalefactor();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();
}

function setendofroundsoundtimescalefactor() {
  if(!isDefined(level.never_kill_off_after_stealth)) {
    createheadiconatorigin("end_of_round");
    level.never_kill_off_after_stealth = 1;
    level.ref_12c62 = undefined;
    return;
  }
}

function resetsoundtimescalefactor() {
  if(!isDefined(level.ref_12c62)) {
    createheadiconatorigin("reset");
    level.never_kill_off_after_stealth = undefined;
    level.ref_11ef8 = undefined;
    level.ref_12c62 = 1;
    return;
  }
}

function sendgameendedfrozennotify(var_0) {
  wait var_0;
  level notify("game_ended_frozen");
}

function restart() {
  if(isDefined(level.ref_12059)) {
    [[level.ref_12059]]();
  }

  level notify("restarting");
  game["state"] = "playing";
  map_restart(1);
}

function endgame(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1)) {
    logstring("[KEY_MOMENT] EndGame " + var_1);
  } else {
    logstring("[KEY_MOMENT] EndGame");
  }

  if(isDefined(level.ref_11c81)) {
    var_0 = level.ref_11c81;
  }

  if(isDefined(level.endgame)) {
    [[level.endgame]](var_0, var_1, undefined, var_5);
    return;
  }

  endgame_regularmp(var_0, var_1, var_2, var_3, var_4);
}

function endgame_regularmp(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(scripts\mp\utility\game::getgametype() != "br" && level.gameended) {
    return;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundEndTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  scripts\common\utility::ref_13e0a(level.ref_11b34);
  var_5 = 0;

  if(level.hostforcedend || level.forcedend) {
    var_5 = 1;
  }

  if(scripts\mp\utility\game::inovertime()) {
    if(game["overtimeRoundsPlayed"] == 0) {
      setmatchdata("firstOvertimeRoundIndex", game["roundsPlayed"]);
    }

    if(!var_5) {
      game["overtimeRoundsPlayed"]++;
    }
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
      if(!var_5) {
        if(isDefined(var_4)) {
          game["roundsWon"][var_0] = game["roundsWon"][var_0] + var_4;
        } else {
          game["roundsWon"][var_0]++;
        }
      }

      if(!isDefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = var_0;
      }
    } else {
      if(isDefined(var_0) && var_0 == "tie" && shouldmodescoreonties()) {
        foreach(var_7 in level.teamnamelist) {
          game["roundsWon"][var_7]++;
        }
      }

      if(!isDefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = "none";
      }
    }

    if(!istrue(game["practiceRound"])) {
      foreach(var_7 in level.teamnamelist) {
        scripts\mp\gamescore::updateteamscore(var_7);
      }

      if(scripts\mp\utility\game::isroundbased() && game["roundsPlayed"] < 24 && scripts\mp\utility\game::getgametype() != "koth") {
        setmatchdata("alliesRoundScore", game["roundsPlayed"], getteamscore("allies"));
        setmatchdata("axisRoundScore", game["roundsPlayed"], getteamscore("axis"));
      }
    }
  } else {
    if(isDefined(var_0) && isPlayer(var_0) && !var_5) {
      game["roundsWon"][var_0.guid]++;
    }

    if(!isDefined(level.finalkillcam_winner)) {
      if(!isDefined(var_0) || isstring(var_0) && var_0 == "tie") {
        level.finalkillcam_winner = "none";
      } else {
        level.finalkillcam_winner = var_0.guid;
      }
    }
  }

  scripts\mp\gamescore::updateplacement();

  if(!var_5) {
    game["roundsPlayed"]++;
  }

  level.playovertime = scripts\mp\utility\game::shouldplayovertime();

  if(scripts\mp\utility\game::nextroundisfinalround()) {
    game["finalRound"] = 1;
  } else if(scripts\mp\utility\game::nextroundismatchpoint()) {
    game["matchPoint"] = 1;
  }

  if(isDefined(var_0) && scripts\mp\utility\game::waslastround()) {
    var_0 = checkmodeoverridetie(var_0);
  }

  level.initcircuitbreakers = istrue(var_3) && scripts\mp\utility\game::getgametype() == "ctf";

  if(isDefined(var_0) && level.initcircuitbreakers) {
    var_11 = scripts\engine\utility::ter_op(var_0 == "allies", "axis", "allies");
    game["roundsWon"][var_0] = 1;
    game["roundsWon"][var_11] = 0;
    game["teamScores"][var_0] = 1;
    game["teamScores"][var_11] = 0;
    setteamscore(var_0, 1);
    setteamscore(var_11, 0);
  }

  var_12 = endgame_endround(var_0, var_1, var_2, var_3);

  foreach(var_14 in level.players) {
    if(!isbot(var_14) && isDefined(var_14.team) && var_14.team != "spectator" && var_14.team != "follower") {
      ref_119af(var_14);
    }
  }

  if(var_12 && scripts\mp\utility\game::waslastround()) {
    endgame_endgame(var_0, var_1, var_2, var_3);
    return;
  }
}

function shouldmodescoreonties() {
  return istrue(game["canScoreOnTie"]);
}

function checkmodeoverridetie(var_0) {
  var_1 = shouldmodescoreonties() && var_0 == "tie";
  var_2 = scripts\mp\utility\game::getgametype() == "ctf" && var_0 == "tie" && !level.winrule;

  if(var_1 || var_2) {
    scripts\mp\gamescore::updatetotalteamscore("axis");
    scripts\mp\gamescore::updatetotalteamscore("allies");
    var_3 = getteamscore("allies");
    var_4 = getteamscore("axis");

    if(var_3 != var_4) {
      var_0 = scripts\engine\utility::ter_op(var_3 > var_4, "allies", "axis");
    }
  }

  return var_0;
}

function endgame_showkillcam() {
  if(istrue(level.nukedetonated)) {
    return;
  }

  if(istrue(level.disable_back_light)) {
    return;
  }

  if(getdvarint("scr_game_skip_final_killcam", 0) == 1) {
    return;
  }

  if(istrue(level.skipfinalkillcam)) {
    return;
  }

  scripts\mp\flags::levelflagwait("final_killcam_preloaded");

  if(level.finalkillcamenabled) {
    var_0 = 0;

    if(isDefined(level.finalkillcam_winner)) {
      var_0 = 1;
    }

    if(var_0) {
      var_0 = level scripts\mp\final_killcam::dofinalkillcam();
    }

    if(isDefined(var_0) && !var_0) {
      postroundfadenokillcam();
      return;
    }

    return;
  }

  if(level.potgenabled) {
    var_1 = scripts\mp\potg::getcurpotgscene();

    if(isDefined(var_1.primaryentity)) {
      level scripts\mp\final_killcam::dopotgkillcam();
      return;
    }

    level.finalkillcamenabled = 1;
    var_0 = level scripts\mp\final_killcam::dofinalkillcam();

    if(isDefined(var_0) && !var_0) {
      postroundfadenokillcam();
      return;
    }

    return;
  }
}

function postroundfadenokillcam() {
  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      continue;
    }

    var_1 thread scripts\mp\utility\game::setuipostgamefade(1, 0.1);

    if(level.gametype == "arena") {
      var_1 setclientomnvar("post_game_state", 1);
    } else {
      var_1 setclientomnvar("post_game_state", 2);
    }

    thread ref_1284e();
  }

  wait 0.5;
}

function ref_1284e() {
  self endon("disconnect");
  var_0 = scripts\mp\playerlogic::getspectatepoint();
  self predictstreampos(var_0.origin, 1);

  while(self.sessionstate != "intermission") {
    waitframe();
  }

  waitframe();
  self clearpredictedstreampos();
}

function ref_13153(var_0) {
  game["state"] = "postgame";
  level notify("game_ended", var_0);
  scripts\mp\flags::levelflagset("game_over");
  scripts\mp\flags::levelflagset("block_notifies");
}

function mp_vacant_patch_thread(var_0) {
  if(isDefined(var_0)) {
    if(var_0 == 1 || var_0 == 2) {
      level.apc_rus_monitordriverturretreload = 0;
      level.allow_momentum = var_0;
      level notify("madeLUIDecision");
      return;
    }

    return;
  }
}

function endgame_endround(var_0, var_1, var_2, var_3) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;

  if(!isDefined(var_0)) {
    if(scripts\mp\utility\game::isroundbased()) {
      logstring("IWH-315293: HALIBUT: winner undefined, related to CL 7682409 where wasLastRound() would not be set in round based mode");
      level.forcedend = 1;
    }

    return true;
  }

  if(getdvarint("scr_eom_combat")) {
    if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::getgametype() != "arena" && scripts\mp\utility\game::getgametype() != "br") {
      level.doeomcombat = 1;
    }
  }

  updateleaderboardstats();
  waitframe();
  scripts\mp\gamescore::updateplacement();
  level.recordfinalkillcam = 0;
  level.ignorescoring = 1;
  thread scripts\mp\potg::onroundended(var_0);
  thread scripts\mp\final_killcam::preloadfinalkillcam();
  level notify("cancel_announcer_dialog");

  if(scripts\mp\utility\game::isteamreviveenabled()) {
    thread scripts\mp\teamrevive::cleanuprevivetriggericons();
  }

  if(scripts\mp\utility\game::waslastround()) {
    if(scripts\mp\utility\game::getgametype() == "arena") {
      if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
        var_4 = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_0, "players"), &compare_player_score);
      } else {
        var_4 = level.placement["all"];
      }

      var_5 = int(min(3, var_4.size));

      foreach(var_7 in level.players) {
        var_8 = 0;

        for(var_9 = 0; var_9 < var_5; var_9++) {
          if(var_7 == var_4[var_9]) {
            var_8 = 1;
          }
        }

        if(var_8) {
          if(var_7 == var_4[0]) {
            var_7 scripts\cp_mp\pet_watch::bhasthermitestucktoshield();
          }
        }
      }
    }

    level notify("start_game_win_audio", var_1);

    if(istrue(level.postgameexfil) && !level.forcedend) {
      if(var_1 != "tie") {
        level waittill("exfil_continue_game_end");
      }
    }
  } else {
    level notify("round_end_music", var_1);
  }

  if(level.doeomcombat) {
    if(istrue(level.docmdoutro)) {
      thread waitforhitmarkerspostgame();
      ref_13153(var_1);
      level waittill("cmd_continue_game_end");
      setomnvarforallclients("post_game_state", 2);

      foreach(var_7 in level.players) {
        if(level.teambased) {
          var_7 thread scripts\mp\hud_message::teamoutcomenotify(var_1, 0, var_2, var_3);
          continue;
        }

        var_7 thread scripts\mp\hud_message::outcomenotify(var_1, var_2, var_3);
      }

      freezeallplayers(3, "NSSLSNKPN", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
      goto LOC_000002c1;
    }

    if(level.gametype == "br") {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(var_1, var_2, var_3);
      game["state"] = "postgame";
      level notify("game_ended", var_1);
      scripts\mp\flags::levelflagset("game_over");
      scripts\mp\flags::levelflagset("block_notifies");
      waitframe();
      goto LOC_000002c1;
    }

    jumpiftrue(level.gametype == "tac_ops" && isDefined(level.tacopssublevel)) LOC_000002c1;
    thread eomcombatwaitforhitmarkersanddelaystartpostgameui(var_1, var_2, var_3);
    freezeallplayers(2.5, "NSSLSNKPN", 1, 1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
    ref_13153(var_1);
    waitframe();

    foreach(var_7 in level.players) {
      var_7 setclientdvar("MQNNLTKNTS", 1);

      if(scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) {
        var_7 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        var_7 scripts\mp\bounty::playerresetbountystreak();
      }

      var_7 setclientomnvar("ui_match_in_progress", 0);
    }
  } else {
    if(!(level.gametype == "tac_ops" && isDefined(level.tacopssublevel)) && scripts\mp\utility\game::getgametype() != "br") {
      thread waitforhitmarkerspostgame();
      ref_13153(var_2);
    }

    waitframe();

    foreach(var_7 in level.players) {
      var_7 setclientdvar("MQNNLTKNTS", 1);

      if((scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) && !istrue(game["isLaunchChunk"])) {
        var_7 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        var_7 scripts\mp\bounty::playerresetbountystreak();
      }

      var_7 setclientomnvar("ui_match_in_progress", 0);
    }

    freezeallplayers(1, "NSSLSNKPN", 1, 0);
  }

  setgameendtime(0);
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled()) {
    scripts\mp\analyticslog::analyticsstorespawndata();
  }

  clearmatchhasmorethan1playervariablesonroundend();

  if(isDefined(level.matchrecording_dump)) {
    [[level.matchrecording_dump]]();
  }

  rankedmatchupdates(var_2);
  setDvar("SLLNLPRON", scripts\mp\utility\game::updatetextongamepadchange());
  setDvar("ui_allow_teamchange", 0);
  setDvar("MPOKQNLPRM", 0);

  foreach(var_7 in level.players) {
    var_7 scripts\mp\class::loadout_clearperks();
  }

  if(istrue(game["practiceRound"]) && !istrue(level.forcedend)) {
    game["roundsPlayed"] = 0;

    foreach(var_20 in level.teamnamelist) {
      game["roundsWon"][var_20] = 0;
      game["teamScores"][var_20] = 0;
    }

    var_2 = "tie";
    var_3 = game["end_reason"]["practice_round_over"];
  }

  displayroundend(var_2, var_3, var_4);
  thread endofroundvisionset(level);

  if(!scripts\mp\utility\game::waslastround()) {
    level notify("round_win", var_2);
    roundendwait(level.roundenddelay, 1);
  } else {
    roundendwait(level.roundenddelay, 1);
  }

  level notify("game_cleanup");
  endgame_showkillcam();
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();

  if(istrue(game["practiceRound"]) && !istrue(level.forcedend)) {
    game["practiceRound"] = 0;

    if(level.allowsupers && !scripts\mp\utility\game::runleanthreadmode()) {
      foreach(var_7 in level.players) {
        var_7 scripts\mp\supers::clearsuper();
        var_7 scripts\mp\perks\perkpackage::perkpackage_reset();
      }
    }

    scripts\mp\flags::levelflagclear("block_notifies");
    restart();
    return false;
  } else {
    if(level.teambased) {
      foreach(var_25 in level.teamnamelist) {
        scripts\mp\gamescore::updatetotalteamscore(var_25);
        LOC_000005d4:
      }
    }

    if(!scripts\mp\utility\game::wasonlyround()) {
      if(!scripts\mp\utility\game::waslastround()) {
        if(level.playovertime) {
          var_2 = "overtime";
          game["status"] = "overtime";
        }

        scripts\mp\flags::levelflagclear("block_notifies");
        var_27 = checkroundswitch(level.playovertime);

        if(var_27) {
          onroundswitch(level.playovertime);
        }

        if(var_27 || game["finalRound"] == 1 || game["matchPoint"] == 1) {
          var_28 = 1;

          if(scripts\mp\utility\game::getgametype() == "arena") {
            if(game["matchPoint"] == 1 && !istrue(game["displayedMatchPoint"])) {
              game["displayedMatchPoint"] = 1;
            } else if(game["finalRound"] != 1) {
              var_28 = 0;
              LOC_000006a4:
            }
            LOC_000006a4:
          }

          LOC_000006a4:
            if(var_28) {
              displayroundswitch();
            }
        }

        foreach(var_7 in level.players) {
          var_7.pers["stats"] = var_7.stats;

          if(isalive(var_7) && isDefined(var_7.matchdatalifeindex)) {
            var_7 scripts\common\utility::ref_13e0a(level.ref_11b2d, var_7.matchdatalifeindex, undefined, undefined, "MOD_ROUND_ENDED", "none", undefined, undefined, undefined);
          }
        }

        restart();
        return false;
      }

      if(!level.forcedend) {
        var_7 = updateroundendreasontext(var_7);
      }
    }
  }

  return true;
}

function tacopsroundendwait(var_0, var_1) {
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

  foreach(var_5 in level.players) {
    var_5 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  wait var_0;
  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

function compare_player_score(var_0, var_1) {
  return var_0.score >= var_1.score;
}

function endgame_endgame(var_0, var_1, var_2, var_3) {
  spawnscriptable();
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.music_timer_10seconds = var_0;

  if(scripts\mp\gametypes\br_public::tutorial_playSound() && !level.forcedend) {
    level.apc_rus_monitordriverturretreload = 1;
    level scripts\common\ui::lui_registercallback("exit_squad_eliminated", &mp_vacant_patch_thread);
  }

  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level.ref_132fe) && [[level.ref_132fe]]()) {
    createnavobstaclebyshape();
  }

  if(!istrue(level.processedwinloss) && (istrue(level.forfeitinprogress) || level.forcedend)) {
    updatewinlossstats(var_0);
  }

  scripts\cp\vehicles\vehicle_compass_cp::roundend(var_0);
  checkforpersonalbests();
  updatespmstats();
  scripts\mp\persistence::writebestscores();
  level notify("stop_leaderboard_stats");
  updateleaderboardstats();
  level scripts\mp\accolades::obj_riverbed();
  level.doingbroshot = scripts\mp\broshot::initbroshot(var_0);
  var_4 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("endGameIntermission");

  if(!level.doingbroshot && istrue(var_4)) {
    level notify("spawning_intermission");
    var_5 = remove_player_from_focus_fire_attacker_list();

    foreach(var_7 in level.players) {
      var_7 thread scripts\mp\utility\game::setuipostgamefade(0);

      if(!isDefined(level.ref_11c85) || !var_7[[level.ref_11c85]]()) {
        var_7 thread scripts\mp\playerlogic::spawnintermission(var_5);
      }
    }
  }

  if(istrue(var_3) && !istrue(level.nukecancel)) {
    scripts\mp\utility\player::_visionsetnaked(level.nukevisionset, 0);
    visionsetfadetoblack("", 0.75);
  } else {
    scripts\mp\utility\player::_visionsetnaked("", 0);
    visionsetfadetoblack("", 0.75);
  }

  displaygameend(var_0, var_1, var_2);
  scripts\mp\flags::levelflagclear("block_notifies");
  level.intermission = 1;

  if(!level.doingbroshot) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();

      if(isDefined(level.multieventdebug)) {
        foreach(var_7 in level.players) {
          if(!isDefined(var_7)) {
            continue;
          }

          thread ref_12465();
        }
      } else {
        setomnvarforallclients("ui_br_transition_type", 0);
        setomnvarforallclients("post_game_state", 14);
      }

      if(getdvarint("post_game_play_again_enabled", 1) == 1) {
        if(!scripts\mp\gametypes\br_public::tutorial_playSound()) {
          if(isDefined(level.multieventdebug)) {
            wait level.multieventdebug.ref_142ae;
          } else if(getdvarint("LPRKRTSPQT") == 1) {
            wait 20;
          } else if(scripts\mp\utility\game::privatematch()) {
            wait 6;
          } else {
            wait 20;
          }
        } else {
          if(istrue(level.apc_rus_monitordriverturretreload)) {
            level waittill("madeLUIDecision");
          }

          level.postroundtime = 0;
        }

        setupelevatordoor();
        wait 10;
      }
    }

    setomnvarforallclients("post_game_state", 5);

    if(scripts\mp\utility\game::getgametype() != "br") {
      roundendwait(level.postroundtime, 1);
    }
  }

  if(scripts\mp\utility\game::getgametype() != "br" || scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "kingslayer" || scripts\mp\utility\game::round_vehicle_logic() == "rumble" || scripts\mp\utility\game::updatex1stashhud() || scripts\mp\utility\game::round_vehicle_logic() == "gold_war") {
    processlobbydata();
  }

  if(level.doingbroshot) {
    setomnvarforallclients("post_game_state", 7);
    wait 0.1;
    scripts\mp\broshot::startbroshot(var_0);
    level waittill("taunts_timed_out");
    scripts\mp\broshot::endbroshot();
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
      setmatchdata("victor", var_0);
      var_11 = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var_0, "players"), &compare_player_score);
    } else {
      setmatchdata("victor", "none");
      var_11 = level.placement["all"];
    }

    setmatchdata("alliesScore", getteamscore("allies"));
    setmatchdata("axisScore", getteamscore("axis"));
  } else {
    setmatchdata("victor", "none");
    var_11 = level.placement["all"];
  }

  foreach(var_7 in level.players) {
    var_7 setplayerdata("common", "round", "endReasonTextIndex", var_3);
    var_7 scripts\cp_mp\utility\game_utility::stopkeyearning(var_2);

    if(isalive(var_7) && isDefined(var_7.matchdatalifeindex)) {
      var_7 scripts\common\utility::ref_13e0a(level.ref_11b2d, var_7.matchdatalifeindex, undefined, undefined, "MOD_GAME_ENDED", "none", undefined, undefined, undefined);
    }

    var_13 = int(min(3, var_11.size));
    var_14 = 0;

    for(var_15 = 0; var_15 < var_13; var_15++) {
      if(var_7 == var_11[var_15]) {
        var_14 = 1;
      }
    }

    if(var_14) {
      var_7 scripts\cp_mp\pet_watch::addwatchchargewintop3();
    }

    if(level.teambased) {
      if(scripts\mp\utility\teams::isgameplayteam(var_2)) {
        if(isDefined(var_7.team)) {
          if(var_7.team == var_2) {
            var_7 logplayerendmatchdatamatchresult(var_7.clientid, "win");
            var_7 scripts\cp_mp\pet_watch::addwatchchargewin();
          } else {
            var_7 logplayerendmatchdatamatchresult(var_7.clientid, "loss");
          }
        } else {
          var_7 logplayerendmatchdatamatchresult(var_7.clientid, "none");
        }
      } else if(scripts\mp\utility\game::allteamstied()) {
        var_7 logplayerendmatchdatamatchresult(var_7.clientid, "draw");
      } else {
        var_7 logplayerendmatchdatamatchresult(var_7.clientid, "none");
      }
    } else if(isPlayer(var_2) && var_2.clientid == var_7.clientid) {
      var_7 logplayerendmatchdatamatchresult(var_7.clientid, "win");
      var_7 scripts\cp_mp\pet_watch::addwatchchargewin();
    } else {
      var_7 logplayerendmatchdatamatchresult(var_7.clientid, "loss");
    }

    var_7 scripts\common\utility::ref_13e0a(level.ref_11b2c);
  }

  scripts\common\utility::ref_13e0a(level.ref_11b35);

  if(getdvarint("TLRPKRKMS") != 0) {
    if(isgamebattlematch()) {
      foreach(var_7 in level.players) {
        var_18 = var_7 getxuid();
        var_19 = var_7.team;
        var_20 = var_7 scripts\mp\utility\stats::getpersstat("score");
        setgamebattlematchstats(var_18, var_19, var_20);
      }

      var_22 = level.mapname;
      var_23 = scripts\mp\utility\game::getgametype();
      var_24 = getmatchdata("victor");
      var_25 = getteamscore("allies");
      var_26 = getteamscore("axis");
      var_27 = scripts\mp\matchdata::getmatchstarttimeutc();
      var_28 = scripts\mp\matchdata::getmatchendtimeutc();
      requestgamelobbyremainintact(var_22, var_23, var_24, var_25, var_26, var_27, var_28);
    }
  }

  ref_1301f();
  function_042a();

  foreach(var_7 in level.players) {
    var_7.pers["stats"] = var_7.stats;
  }

  if(getdvarint("post_game_play_again_enabled", 1) == 0) {
    wait 1;
  } else if(istrue(game["isLaunchChunk"])) {
    wait 1;
  } else if(!var_11 && !level.postgamenotifies) {
    if(!level.doingbroshot) {
      if(!scripts\mp\utility\game::wasonlyround()) {
        wait 6;
      } else {
        wait min(5, 4 + level.postgamenotifies);
      }
    }
  } else {
    wait min(10, 4 + level.postgamenotifies);
  }

  settournamentwinner(var_2);
  setomnvarforallclients("post_game_state", 1);
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

    foreach(var_19 in level.teamnamelist) {
      game["roundsWon"][var_19] = 0;
      game["teamScores"][var_19] = 0;
      setteamscore(var_19, int(0));
    }

    if(game["launchChunkRuleSet"] == 3) {
      if(isDefined(level.droplaunchchunkbots)) {
        level[[level.droplaunchchunkbots]]();
      }

      wait 1;
    }

    if(!level.hostforcedend && !level.forcedend) {
      restart();
      return 0;
    }
  }

  level notify("exitLevel_called");

  if(scripts\mp\gametypes\br_public::tutorial_playSound() && isDefined(level.allow_momentum) && level.allow_momentum == 2) {
    scripts\mp\bots\bots::drop_bots(1, level.player.team);
    restart();
    return;
  }

  exitlevel(0);
}

function ref_1301f() {
  if(!isDefined(level.needs_power)) {
    getentitylessscriptablearray("dlog_event_server_match_end", ["utc_start_time_s", scripts\mp\matchdata::getmatchstarttimeutc(), "utc_end_time_s", scripts\mp\matchdata::getmatchendtimeutc()]);

    if(getdvarint("TLRPKRKMS") != 0) {
      setmatchdata("host", level.hostname);

      if(scripts\mp\utility\game::matchmakinggame()) {
        setmatchdata("playlistVersion", getplaylistversion());
        setmatchdata("playlistID", getplaylistid());
        setmatchdata("playlist_name", function_041f());
        setmatchdata("isDedicated", isdedicatedserver());
        setmatchdata("party_maxplayers", getdvarint("OOTQKOTRM", 0));
      }

      isalliedsentient();
      sendmatchdata();
    }
  }

  level.needs_power = 1;
}

function settournamentwinner(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!level.teambased) {
    logtournamentdeath(var_0);
    return;
  } else if(var_0 != "allies" && var_0 != "axis") {
    var_1 = scripts\mp\utility\teams::getteamdata("allies", "players");
    var_2 = scripts\mp\utility\teams::getteamdata("axis", "players");

    if(var_1.size == 0) {
      var_0 = "axis";
    } else if(var_2.size == 0) {
      var_0 = "allies";
    } else {
      var_0 = getbetterteam();
    }
  }

  logtournamentdeath(var_0);
}

function waitforhitmarkerspostgame() {
  wait level.ref_127fe;
  level notify("post_game_ui_start");
  setomnvarforallclients("post_game_state", 1);
}

function eomcombatwaitforhitmarkersanddelaystartpostgameui(var_0, var_1, var_2) {
  wait level.ref_127fe;
  level notify("post_game_ui_start");

  if(scripts\mp\utility\game::getgametype() != "br") {
    setomnvarforallclients("post_game_state", 2);
  }

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::teamoutcomenotify(var_0, 0, var_1, var_2);
      continue;
    }

    var_4 thread scripts\mp\hud_message::outcomenotify(var_0, var_1, var_2);
  }
}

function remove_player_from_focus_fire_attacker_list() {
  var_0 = undefined;

  switch (level.mapname) {
    case "mp_village2":
      var_0 = spawnStruct();
      var_0.origin = (1478, -3039, 981);
      var_0.angles = (388.74, 144.97, 0);
      break;
    case "mp_backlot2":
      var_0 = spawnStruct();
      var_0.origin = (1835, 1347, 749);
      var_0.angles = (361, 224, 0);
      break;
    case "mp_hideout":
      var_0 = spawnStruct();
      var_0.origin = (-871, -1578, 458);
      var_0.angles = (6, 65, 0);
      break;
  }

  if(scripts\mp\utility\game::getgametype() == "brtdm") {
    var_0 = spawnStruct();
    var_0.origin = level.endsuperdisableweaponbr.ref_136dc.origin;
    var_0.angles = level.endsuperdisableweaponbr.ref_136dc.angles;
  }

  return var_0;
}

function eomcamerapullout(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var_2 scripts\common\utility::allow_ads(0);
    var_3 = var_2 getEye() + (0, 0, 100) + anglesToForward(var_2.angles) * -100;
    var_4 = spawn("script_model", var_3);
    var_4 setModel("tag_origin");
    var_4.angles = var_2.angles;
    var_2.spawncameraent = var_4;
    var_5 = var_2 getEye();
    var_6 = var_2.angles;
    var_7 = var_3 + (0, 0, 5000);
    var_7 += anglesToForward(var_6) * -100;
    var_2 cameralinkTo(var_2.spawncameraent, "tag_origin", 1, 1);
    var_2.spawncameraent moveTo(var_7, 5, 4, 0.1);
    var_8 = vectorNormalize(var_5 - var_4.origin);
    var_9 = scripts\mp\utility\script::vectortoanglessafe(var_8, (0, 0, 1));
    var_2.spawncameraent.angles = var_9;
    thread lookatplayerupdate(var_2);
    wait 2;
    var_2 visionsetnakedforplayer("respawn_camera", 2);
  }
}

function lookatplayerupdate(var_0) {
  self endon("disconnect");
  self endon("lookAtPlayerUpdate_stop");

  for(;;) {
    var_1 = self getEye();
    var_2 = vectorNormalize(var_1 - self.spawncameraent.origin);
    var_3 = scripts\mp\utility\script::vectortoanglessafe(var_2, (0, 0, 1));
    self.spawncameraent rotateTo(var_3, 0.75);
    waitframe();
  }
}

function updateroundendreasontext(var_0) {
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
  } else if(scripts\mp\utility\game::hitroundlimit()) {
    return game["end_reason"]["round_limit_reached"];
  }

  if(scripts\mp\utility\game::hitwinlimit()) {
    return game["end_reason"]["score_limit_reached"];
  }

  return game["end_reason"]["objective_completed"];
}

function estimatedtimetillscorelimit(var_0) {
  if(!scripts\mp\utility\game::ismoddedroundgame()) {
    var_1 = getscoreperminute(var_0);
    var_2 = getscoreremaining(var_0);
    var_3 = 999999;

    if(var_1) {
      var_3 = var_2 / var_1;
    }

    return var_3;
  }

  var_1 = getscoreperminute(var_3);
  var_2 = getscoreperminute(var_3);
  var_3 = 999999;

  if(var_1) {
    var_3 = var_2 / var_1;
  }

  return var_3;
}

function closetoscorelimit(var_0) {
  var_1 = 10;
  var_2 = 20;
  var_3 = level.roundscorelimit;

  switch (scripts\mp\utility\game::getgametype()) {
    case "tdef":
    case "dom":
      var_2 = 20;
      break;
    case "conf":
      var_2 = 10;
    case "arm":
      var_2 = var_3 * 0.1;
      break;
    default:
      break;
  }

  var_4 = getteamscore(var_0);
  var_5 = var_3 - var_4;

  if(var_5 <= scripts\engine\utility::ter_op(istrue(game["finalRound"]), var_2, var_1)) {
    return true;
  }

  return false;
}

function getscoreperminute(var_0) {
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;

  if(isPlayer(self)) {
    var_2 = self.score / var_1;
  } else {
    var_2 = getteamscore(var_1) / var_2;
  }

  return var_2;
}

function getscoreremaining(var_0) {
  var_1 = level.roundscorelimit;

  if(isPlayer(self)) {
    var_2 = var_1 - self.score;
  } else {
    var_2 -= getteamscore(var_1);
  }

  return var_2;
}

function getscoreperminuteroundbased(var_0) {
  var_1 = level.roundscorelimit;

  if(!game["switchedsides"]) {
    var_1 /= 2;
    var_2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var_3 = getteamscore(var_0) / var_2;
  } else {
    var_3 = int(var_3 / 2);
    var_2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var_4 = getteamscore(var_2);

    if(var_4 >= var_3) {
      var_3 = (var_4 - var_3) / var_2;
    } else {
      return 0;
    }
  }

  return var_3;
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "inform_last_one");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);

  foreach(var_1 in level.teamnamelist) {
    if(self.pers["team"] != var_1) {
      thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var_1);
    }
  }

  level notify("last_alive", self);
}

function processlobbydata() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    ref_128af(var_1);
  }

  if(getdvarint("MTKSQRQLKN") != 0) {
    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch()) {
      setclientmatchdata("isPublicMatch", 1);
    } else {
      setclientmatchdata("isPublicMatch", 0);
    }
  }

  scripts\mp\scoreboard::processlobbyscoreboards();

  if(getdvarint("MTKSQRQLKN") != 0) {
    sendclientmatchdata();
  }

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    thread scripts\mp\codcasterclientmatchdata::sendcodcastermatchdata();
    return;
  }
}

function cargo_truck_mg_explode(var_0) {
  if(isDefined(var_0) && !isDefined(var_0.clientmatchdataid)) {
    var_0.clientmatchdataid = level.initship;
    level.initship++;
    return;
  }
}

function ref_128af(var_0) {
  if(istrue(var_0.ref_128af)) {
    return;
  }

  var_0.ref_128af = 1;
  cargo_truck_mg_explode(var_0);
  var_1 = var_0.name;

  if(getdvarint("MTKSQRQLKN") != 0) {
    setclientmatchdata("players", var_0.clientmatchdataid, "clanTag", var_0 getclantag());
    setclientmatchdata("players", var_0.clientmatchdataid, "xuidHigh", var_0 getxuidhigh());
    setclientmatchdata("players", var_0.clientmatchdataid, "xuidLow", var_0 getxuidlow());
    setclientmatchdata("players", var_0.clientmatchdataid, "isBot", isbot(var_0));
    setclientmatchdata("players", var_0.clientmatchdataid, "uniqueClientId", var_0.clientid);
    setclientmatchdata("players", var_0.clientmatchdataid, "username", var_1);
    setclientmatchdata("players", var_0.clientmatchdataid, "nameSuffix", var_0 method_87d2());

    if(var_0 isps4player()) {
      setclientmatchdata("players", var_0.clientmatchdataid, "platform", "ps4");
    } else if(var_0 isxb3player()) {
      setclientmatchdata("players", var_0.clientmatchdataid, "platform", "xb3");
    } else if(var_0 ispcplayer()) {
      setclientmatchdata("players", var_0.clientmatchdataid, "platform", "bnet");
    } else {
      setclientmatchdata("players", var_0.clientmatchdataid, "platform", "none");
    }
  }

  var_0 setplayerdata("common", "round", "clientMatchIndex", var_0.clientmatchdataid);
  var_0 scripts\mp\scoreboard::setplayerscoreboardinfo();
  var_2 = tolower(getDvar("mapname"));
  var_0 setplayerdata("common", "round", "gameMode", scripts\mp\utility\game::getgametype());
  var_0 setplayerdata("common", "round", "map", var_2);
  scripts\mp\matchdata::ref_13154(var_0);
}

function trackleaderboarddeathstats(var_0, var_1, var_2, var_3) {
  thread threadedsetweaponstatbyname(var_1, var_2, 1);
  thread threadedsetweaponstatbyname(var_1, var_2, distancesquared(var_0.origin, var_1.origin));
}

function trackattackerleaderboarddeathstats(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    if(var_3 != "MOD_FALLING") {
      if(var_3 == "MOD_MELEE" && issubstr(var_2, "tactical")) {
        var_0 scripts\common\utility::ref_13e0a(level.ref_11b25, "tactical", "kills", 1, var_2);
        var_0 scripts\common\utility::ref_13e0a(level.ref_11b25, "tactical", "hits", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("tactical", "kills", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("tactical", "hits", 1, var_2);
        return;
      }

      if(var_3 == "MOD_MELEE" && !scripts\mp\riotshield::isriotshield(var_2) && !scripts\mp\utility\weapon::isknifeonly(var_2) && !scripts\mp\utility\weapon::turret_aimed_at_last_known(var_2) && !scripts\mp\utility\weapon::isaxeweapon(var_2)) {
        var_0 scripts\common\utility::ref_13e0a(level.ref_11b25, "none", "kills", 1, var_2);
        var_0 scripts\common\utility::ref_13e0a(level.ref_11b25, "none", "hits", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("none", "kills", 1, var_2);
        var_0 scripts\mp\persistence::incrementattachmentstat("none", "hits", 1, var_2);
        return;
      }

      thread threadedsetweaponstatbyname(var_0, var_2, 1);
      thread threadedsetweaponstatbyname(var_0, var_2, distancesquared(var_0.origin, var_1.origin));
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      thread threadedsetweaponstatbyname(var_0, var_2, 1);
      return;
    }

    return;
  }
}

function setweaponstat(var_0, var_1, var_2) {
  if(!var_1) {
    return;
  }

  var_3 = undefined;

  if(issameweapon(var_0)) {
    var_3 = var_0;
  } else {
    var_3 = asmdevgetallstates(var_0);
  }

  if(isDefined(var_3.ref_121d9)) {
    var_3 = var_3.ref_121d9;
  }

  if(!isDefined(level.get_audio_approved_length_extender_for_non_english_vo)) {
    level.get_audio_approved_length_extender_for_non_english_vo = scripts\mp\utility\game::getgametype() == "br" && getdvarint("scr_track_picked_up_weapon_stats", 1) == 1;
  }

  if(scripts\mp\utility\weapon::ispickedupweapon(var_3) && !istrue(level.get_audio_approved_length_extender_for_non_english_vo)) {
    return;
  }

  var_4 = var_3.basename;
  var_5 = scripts\mp\utility\weapon::getweapongroup(var_3);
  var_6 = getweaponvariantindex(var_3);

  if(var_5 == "super") {
    var_7 = scripts\mp\supers::shouldtracksuperweaponstats(var_3);

    if(isDefined(var_7) && !var_7) {
      return;
    }
  }

  if(var_5 == "killstreak" || var_5 == "other" && var_4 != "trophy_mp" || var_5 == "other" && var_4 != "player_trophy_system_mp" || var_5 == "other" && var_4 != "super_trophy_mp") {
    return;
  }

  if(scripts\mp\utility\weapon::isenvironmentweapon(var_3)) {
    return;
  }

  if(var_5 == "weapon_grenade" || var_5 == "weapon_explosive" || var_4 == "trophy_mp" || var_4 == "forcepush_mp") {
    var_4 = scripts\mp\utility\script::strip_suffix(var_4, "_mp");
    scripts\mp\persistence::incrementweaponstat(var_4, var_2, var_1);
    scripts\common\utility::ref_13e0a(level.ref_11b31, var_4, var_2, var_1, var_6, var_3);
    return;
  }

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = var_3;
  }

  if(var_3 != self.trackingweapon) {
    scripts\mp\persistence::updateweaponbufferedstats(var_3);
    self.trackingweapon = var_3;
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
    var_8 = undefined;
    var_9 = scripts\mp\utility\weapon::getweaponrootname(var_3);

    if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_9) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_9)) {
      return;
    }

    var_10 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_3);
    scripts\mp\persistence::incrementweaponstat(var_9, var_2, var_1);
    scripts\common\utility::ref_13e0a(level.ref_11b31, var_9, "deaths", var_1, var_6, var_3);

    foreach(var_12 in var_10) {
      scripts\mp\persistence::incrementattachmentstat(var_12, var_2, var_1, var_3);
      scripts\common\utility::ref_13e0a(level.ref_11b25, var_12, var_2, var_1, var_3);
    }

    return;
  }
}

function setinflictorstat(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(var_0)) {
    setweaponstat(var_1, var_2, 1, "hits");
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
    setweaponstat(var_1, var_2, 1, "hits");
    return;
  }
}

function threadedsetweaponstatbyname(var_0, var_1, var_2) {
  self endon("disconnect");

  if(!isPlayer(self) && !isagent(self)) {
    return;
  }

  waittillframeend();
  setweaponstat(var_0, var_1, var_2);
}

function updatespmstats() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = getmatchspm(var_1);
      var_3 = scripts\engine\utility::ter_op(level.teambased, var_1.score, var_1.pers["gamemodeScore"]);
      var_4 = var_1 getplayerdata("mp", "globalSPM");
      var_5 = var_1 scripts\mp\playerstats_interface::getplayerstat("matchStats", "gamesPlayed");
      var_4 *= var_5 - 1;
      var_6 = var_2;

      if(var_5 > 0) {
        var_6 = (var_4 + var_2) / var_5;
      }

      var_1 setplayerdata("mp", "globalSPM", int(var_6));
      var_7 = getgametypeindex(scripts\mp\utility\game::getgametype());
      var_8 = 5;
      var_9 = 32;

      if(var_7 >= 0 && var_7 < var_9) {
        for(var_10 = 0; var_10 < 4; var_10++) {
          var_11 = var_1 getplayerdata("mp", "gameModeHistory", var_10 + 1);
          var_1 setplayerdata("mp", "gameModeHistory", var_10, var_11);
        }

        var_1 setplayerdata("mp", "gameModeHistory", 4, scripts\mp\utility\game::getgametype());
        var_12 = var_1 getplayerdata("mp", "gameModeScoreHistory", var_7, "index");
        var_1 setplayerdata("mp", "gameModeScoreHistory", var_7, "scores", var_12, int(var_2));
        var_1 setplayerdata("mp", "gameModeScoreHistory", var_7, "actualScores", var_12, int(var_3));
        var_1 setplayerdata("mp", "gameModeScoreHistory", var_7, "gameMode", scripts\mp\utility\game::getgametype());
        var_12 = (var_12 + 1) % var_8;
        var_1 setplayerdata("mp", "gameModeScoreHistory", var_7, "index", var_12);
      }
    }
  }
}

function checkforpersonalbests() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = var_1 getplayerdata("common", "round", "kills");
      var_3 = var_1 getplayerdata("common", "round", "deaths");
      var_4 = var_1.pers["summary"]["xp"];
      var_5 = var_1 scripts\mp\playerstats_interface::getplayerstat("bestStats", "killsInAMatch");
      var_6 = var_1 scripts\mp\playerstats_interface::getplayerstat("bestStats", "deathsInAMatch");
      var_7 = var_1 scripts\mp\playerstats_interface::getplayerstat("bestStats", "xpInAMatch");
      var_8 = var_1 getplayerdata("mp", "bestSPM", "score");
      var_9 = var_1 getplayerdata("mp", "bestKD", "score");

      if(var_2 > var_5) {
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_2, "bestStats", "killsInAMatch");
      }

      if(var_4 > var_7) {
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_4, "bestStats", "xpInAMatch");
      }

      if(var_3 > var_6) {
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_3, "bestStats", "deathsInAMatch");
      }

      var_10 = var_2;

      if(var_3 > 1) {
        var_10 /= var_3;
      }

      var_10 = int(var_10 * 1000);

      if(var_10 > var_9) {
        var_1 setplayerdata("mp", "bestKD", "score", var_10);
        var_1 setplayerdata("mp", "bestKD", "time", getsystemtime());
      }

      var_11 = getmatchspm(var_1);

      if(var_11 > var_8) {
        var_1 setplayerdata("mp", "bestSPM", "score", int(var_11));
        var_1 setplayerdata("mp", "bestSPM", "time", getsystemtime());
      }

      checkforbestweapon(var_1);
    }
  }
}

function brking_addtoc130infil() {
  return level.onlinestatsenabled && isleaderboardsupportedmode();
}

function updateleaderboardstatscontinuous() {
  level endon("game_ended");
  level endon("stop_leaderboard_stats");

  if(!brking_addtoc130infil()) {
    return;
  }

  for(var_0 = 0;; var_0++) {
    while(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
    }

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    var_1 = level.players[var_0];

    if(!isDefined(var_1) || isai(var_1)) {
      waitframe();
      continue;
    }

    ref_14008(var_1);
    wait 0.1;
  }
}

function updateleaderboardstats() {
  if(!brking_addtoc130infil()) {
    return;
  }

  foreach(var_1 in level.players) {
    if(!isDefined(var_1) || isai(var_1)) {
      continue;
    }

    ref_14008(var_1);
  }
}

function updateplayerleaderboardstats() {
  if(!brking_addtoc130infil()) {
    return;
  }

  if(!isDefined(self) || isai(self)) {
    return;
  }

  ref_14008();
}

function isleaderboardsupportedmode() {
  if(level.hardcoremode) {
    var_0 = "hc_";
  } else {
    var_0 = "";
  }

  var_0 += scripts\mp\utility\game::getgametype();

  switch (var_0) {
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
    case "dd":
    case "ctf":
    case "cyber":
    case "siege":
    case "sr":
    case "sd":
    case "dom":
    case "infect":
    case "arena":
    case "br":
    case "arm":
      return true;
    default:
      return false;
  }

  return false;
}

function generate_randomized_primary_weapon_objs(var_0) {
  return isDefined(var_0) && (var_0 == "dmz" || var_0 == "rat_race" || var_0 == "risk" || var_0 == "kingslayer" || var_0 == "rumble" || var_0 == "payload" || var_0 == "carpoc" || var_0 == "gold_war");
}

function ref_14008() {
  var_0 = undefined;

  if(level.hardcoremode) {
    var_0 = "hc_";
  } else {
    var_0 = "";
  }

  var_0 += scripts\mp\utility\game::getgametype();

  if(getdvarint("scr_ignore_player_leaderboard_stats", 0)) {
    return;
  }

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.name)) {
    switch (level.disable_super_in_turret.name) {
      case "rebirth":
      case "mini":
      case "sandbox":
      case "evac":
      case "extract":
      case "payload":
      case "kingslayer":
      case "rat_race":
      case "dmz":
        var_0 += "_" + level.disable_super_in_turret.name;
        break;
      case "gold_war":
        var_0 += "_dmz";
        break;
      case "olaride":
      case "rebirth_dbd_reverse":
      case "rebirth_dbd":
      case "rebirth_reverse":
        var_0 += "_rebirth";
        break;
      case "mmp":
      case "respect":
      case "vov":
      case "mendota":
      case "tdbd":
      case "dbd":
      case "brz":
      case "":
        break;
      default:
        return;
    }
  }

  var_1 = scripts\engine\utility::ter_op(level.teambased, self.score, self.watchvehicleingas["gamemodeScore"]);
  incrementleaderboardstat("score", var_0, var_1);
  var_2 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  incrementleaderboardstat("timePlayed", var_0, var_2);
  incrementleaderboardstat("kills", var_0, self.watchvehicleingas["kills"]);
  incrementleaderboardstat("deaths", var_0, self.watchvehicleingas["deaths"]);

  switch (scripts\mp\utility\game::getgametype()) {
    case "war":
      incrementleaderboardstat("assists", var_0, self.watchvehicleingas["assists"]);
      break;
    case "arena":
      incrementleaderboardstat("damage", var_0, self.watchvehicleingas["damage"]);
      incrementleaderboardstat("assists", var_0, self.watchvehicleingas["assists"]);
      break;
    case "arm":
      incrementleaderboardstat("captures", var_0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var_0, self.watchvehicleingas["defends"]);
      break;
    case "cyber":
      incrementleaderboardstat("revives", var_0, self.watchvehicleingas["rescues"]);
      incrementleaderboardstat("plants", var_0, self.watchvehicleingas["plants"]);
      break;
    case "dm":
      updateleaderboardstatmaximum("streak", var_0, self.watchvehicleingas["killChains"]);
      break;
    case "dom":
      incrementleaderboardstat("captures", var_0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var_0, self.watchvehicleingas["defends"]);
      break;
    case "sd":
      incrementleaderboardstat("plants", var_0, self.watchvehicleingas["plants"]);
      incrementleaderboardstat("defuses", var_0, self.watchvehicleingas["defuses"]);
      break;
    case "conf":
      incrementleaderboardstat("confirms", var_0, self.watchvehicleingas["confirmed"]);
      incrementleaderboardstat("denies", var_0, self.watchvehicleingas["denied"]);
      break;
    case "hq":
      incrementleaderboardstat("captures", var_0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var_0, self.watchvehicleingas["defends"]);
      break;
    case "koth":
      incrementleaderboardstat("objTime", var_0, self.watchvehicleingas["objTime"]);
      incrementleaderboardstat("defends", var_0, self.watchvehicleingas["defends"]);
      break;
    case "ctf":
      incrementleaderboardstat("captures", var_0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("returns", var_0, self.watchvehicleingas["returns"]);
      break;
    case "sr":
      incrementleaderboardstat("plants", var_0, self.watchvehicleingas["plants"]);
      incrementleaderboardstat("rescues", var_0, self.watchvehicleingas["rescues"]);
      break;
    case "siege":
      incrementleaderboardstat("captures", var_0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("revives", var_0, self.watchvehicleingas["rescues"]);
      break;
    case "grind":
      incrementleaderboardstat("banks", var_0, self.watchvehicleingas["confirmed"]);
      incrementleaderboardstat("denies", var_0, self.watchvehicleingas["denied"]);
      break;
    case "infect":
      incrementleaderboardstat("time", var_0, scripts\mp\utility\stats::getpersstat("extrascore0"));
      incrementleaderboardstat("infected", var_0, self.watchvehicleingas["killsAsInfected"]);
      break;
    case "gun":
      incrementleaderboardstat("stabs", var_0, self.watchvehicleingas["stabs"]);
      incrementleaderboardstat("setBacks", var_0, self.watchvehicleingas["setbacks"]);
      break;
    case "grnd":
      incrementleaderboardstat("objTime", var_0, self.watchvehicleingas["objTime"]);
      incrementleaderboardstat("defends", var_0, self.watchvehicleingas["defends"]);
      break;
    case "cmd":
      incrementleaderboardstat("assists", var_0, self.watchvehicleingas["assists"]);
      incrementleaderboardstat("captures", var_0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var_0, self.watchvehicleingas["defends"]);
      break;
    case "pill":
      incrementleaderboardstat("banks", var_0, self.watchvehicleingas["confirmed"]);
      incrementleaderboardstat("denies", var_0, self.watchvehicleingas["denied"]);
      break;
    case "br":
      incrementleaderboardstat("downs", var_0, self.watchvehicleingas["downs"]);
      incrementleaderboardstat("contracts", var_0, self.watchvehicleingas["contracts"]);
      incrementleaderboardstat("wins", var_0, self.watchvehicleingas["wins"]);
      incrementleaderboardstat("topFive", var_0, self.watchvehicleingas["topFive"]);
      incrementleaderboardstat("topTen", var_0, self.watchvehicleingas["topTen"]);
      incrementleaderboardstat("topTwentyFive", var_0, self.watchvehicleingas["topTwentyFive"]);
      incrementleaderboardstat("gamesPlayed", var_0, self.watchvehicleingas["gamesPlayed"]);
      incrementleaderboardstat("revives", var_0, self.watchvehicleingas["rescues"]);
      incrementleaderboardstat("cash", var_0, self.watchvehicleingas["cash"]);
      incrementleaderboardstat("objTime", var_0, self.watchvehicleingas["objTime"]);
      break;
  }
}

function incrementleaderboardstat(var_0, var_1, var_2) {
  if(!isDefined(self.leaderboardstartvalues)) {
    self.leaderboardstartvalues = [];
  }

  if(!isDefined(self.leaderboardstartvalues[var_0])) {
    self.leaderboardstartvalues[var_0] = self getplayerdata("mp", "playerStats", "modeStats", var_1, var_0);
  }

  var_3 = int(max(self.leaderboardstartvalues[var_0] + var_2, self.leaderboardstartvalues[var_0]));
  self setplayerdata("mp", "playerStats", "modeStats", var_1, var_0, var_3);
}

function updateleaderboardstatmaximum(var_0, var_1, var_2) {
  var_3 = self getplayerdata("mp", "playerStats", "modeStats", var_1, var_0);

  if(var_2 > var_3) {
    self setplayerdata("mp", "playerStats", "modeStats", var_1, var_0, var_2);
    return;
  }
}

function getmatchspm(var_0) {
  var_1 = scripts\engine\utility::ter_op(level.teambased, var_0.score, var_0.pers["gamemodeScore"]);
  var_2 = var_0 scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

  if(isDefined(var_2) && var_2 > 0) {
    var_3 = var_2 / 60;
    var_1 /= var_3;
  }

  return var_1;
}

function isvalidbestweapon(var_0) {
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  return isDefined(var_0) && var_0 != "" && !scripts\mp\utility\weapon::iskillstreakweapon(var_0) && var_1 != "killstreak" && var_1 != "other";
}

function checkforbestweapon() {
  var_0 = scripts\common\utility::ref_13e0a(level.ref_11b23);
  var_1 = "";
  var_2 = -1;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_4);

    if(isvalidbestweapon(var_4)) {
      if(!isenumvaluevalid("mp", "WeaponStats", var_4)) {
        continue;
      }

      var_5 = self getplayerdata("mp", "playerStats", "weaponStats", var_4, "kills");

      if(var_5 > var_2) {
        var_1 = var_4;
        var_2 = var_5;
      }
    }
  }

  var_6 = self getplayerdata("mp", "playerStats", "weaponStats", var_1, "shots");
  var_7 = self getplayerdata("mp", "playerStats", "weaponStats", var_1, "headShots");
  var_8 = self getplayerdata("mp", "playerStats", "weaponStats", var_1, "hits");
  var_9 = self getplayerdata("mp", "playerStats", "weaponStats", var_1, "deaths");
  var_10 = 0;
  self setplayerdata("mp", "bestWeapon", "kills", var_2);
  self setplayerdata("mp", "bestWeapon", "shots", var_6);
  self setplayerdata("mp", "bestWeapon", "headShots", var_7);
  self setplayerdata("mp", "bestWeapon", "hits", var_8);
  self setplayerdata("mp", "bestWeapon", "deaths", var_9);
  self setplayerdata("mp", "bestWeaponXP", var_10);
  var_11 = int(tablelookup("mp/statstable.csv", 4, var_1, 0));
  self setplayerdata("mp", "bestWeaponIndex", var_11);
}

function allow_weapon_mp(var_0) {
  self notify("allow_weapon_mp()");

  if(var_0) {
    if(isDefined(self.allowweaponcache) && !self hasweapon(self.allowweaponcache) && !scripts\mp\utility\killstreak::isjuggernaut()) {
      scripts\mp\utility\inventory::switchtolastweapon();
    }

    self.allowweaponcache = undefined;
    return;
  }

  self.allowweaponcache = self.lastnormalweaponobj;
  thread watchinvalidweaponswitchduringdisableweapon();
}

function allow_weapon_mp_init() {
  level.allow_weapon_mp = &allow_weapon_mp;
}

function watchinvalidweaponswitchduringdisableweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("allow_weapon_mp()");

  for(;;) {
    self waittill("weapon_switch_invalid", var_0);
    self.allowweaponcache = var_0;
  }
}

function ismp_init() {
  level.ismp = 1;
}

function ref_144bf(var_0) {
  if(!istrue(level.ref_11a5d)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level endon("start_prematch");
  var_1 = getdvarint("live_lobby_consider_loading_clients", 1);
  var_2 = -1;
  var_3 = gettime();

  for(;;) {
    var_4 = getdvarint("live_lobby_lowpop_min", 50);
    var_5 = getdvarfloat("live_lobby_lowpop_time", 300) * 1000;
    var_6 = scripts\engine\utility::ter_op(var_0, getactiveclientcount(var_1), level.players.size);

    if(var_2 >= 0) {
      var_7 = var_2 + var_5;

      if(var_6 >= var_4 && gettime() >= var_7 && !istrue(level.devoverridematchstart)) {
        break;
      }
    } else if(var_6 >= var_4) {
      var_2 = gettime();
    }

    waitframe();
  }

  var_8 = getdvarint("live_lobby_lowpop_max", 100);
  var_6 = scripts\engine\utility::ter_op(var_0, getactiveclientcount(var_1), level.players.size);

  if(var_6 <= var_8) {
    level.ref_11a5e = 1;
    var_9 = gettime() - var_3;
    var_10 = getdvarfloat("live_lobby_lowpop_time", 300);
    getentitylessscriptablearray("dlog_event_low_pop_start", ["start_players", var_6, "wait_time_ms", var_9, "active_client_count", var_0, "lowpop_min", var_4, "lowpop_max", var_8, "lowpop_time", var_10]);

    if(isDefined(level.ref_12056)) {
      [[level.ref_12056]]();
    }
  }

  level notify("start_prematch");
}

function watchforminplayersmatchstart() {
  level endon("start_prematch");
  var_0 = getdvarint("live_lobby_consider_loading_clients", 1);
  var_1 = gettime();
  var_2 = var_1;
  var_3 = getdvarint("live_lobby_minplayers_start");

  if(var_3 != 0) {
    for(;;) {
      if(istrue(level.devoverridematchstart)) {
        break;
      }

      var_4 = (var_2 - var_1) / 1000;
      var_5 = getdvarint("live_lobby_max_time", 300);

      if(var_5 > 0 && var_4 >= var_5) {
        break;
      }

      if(var_4 <= getdvarint("live_lobby_grace_period", 15)) {
        if(getactiveclientcount(0) >= getdvarint("live_lobby_minplayers_start")) {
          break;
        }
      } else if(getactiveclientcount(var_0) >= getdvarint("live_lobby_minplayers_start")) {
        break;
      }

      waitframe();
      var_2 = gettime();
    }
  }

  level notify("start_prematch");
}

function enemy_move_up_and_ignore() {
  level endon("start_prematch");

  while(level.players.size < getdvarint("br_minplayers") || istrue(level.devoverridematchstart)) {
    waitframe();
  }

  level notify("start_prematch");
}

function watchdevoverridematchstart() {
  level.startbuttons = [];
  var_0 = getEntArray("start_lobby_trigger", "targetname");
  thread waitforoverridematchstartdvar();
  thread waitforoverridematchstartnotify();

  if(var_0.size == 0) {
    thread waitforinitialplayerloadspawnflag();
    return;
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_3 = getEnt(var_2.target, "targetname");
    } else {
      var_3 = spawn("script_model", var_2.origin);
      var_3[0].angles = var_2.angles;
    }

    var_4 = scripts\mp\gameobjects::createuseobject("neutral", var_2, var_3, (0, 0, 64), undefined, 1);
    var_4 scripts\mp\gameobjects::allowuse("any");
    var_4.id = "use";
    var_4.trigger setuseprioritymax();
    var_4 scripts\mp\gameobjects::setusetime(3);
    var_4 scripts\mp\gameobjects::setusehinttext(&"MP_INGAME_ONLY/HOLD_TO_START_GAME");
    var_4.onuse = &startbutton_onuse;
    level.startbuttons[level.startbuttons.size] = var_4;
  }
}

function waitforinitialplayerloadspawnflag() {
  level endon("game_ended");
  level endon("start_prematch");
  level waittill("connected", var_0);
  var_0 waittill("giveLoadout");
  waitframe();
  GscBinSkip1(0x45, 0, spawn("script_model", var_0.origin));
}

function waitforoverridematchstartdvar() {
  level endon("game_ended");
  level endon("dev_force_start_completed");

  for(;;) {
    if(getdvarint("scr_br_devstartoverride", 0)) {
      dev_forcelivelobbystart();
      break;
    }

    wait 0.5;
  }
}

function waitforoverridematchstartnotify() {
  level endon("game_ended");
  level endon("dev_force_start_completed");
  level waittill("forcematchstart");
  dev_forcelivelobbystart();
}

function startbutton_onuse(var_0) {
  var_0 setclientomnvar("ui_securing", 0);
  dev_forcelivelobbystart();
}

function dev_forcelivelobbystart() {
  level thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\print::teamhudtutorialmessage("MP_INGAME_ONLY/GAME_FORCE_STARTED", var_1, 10);
  }

  setDvar("br_minplayers", 1);
  setDvar("live_lobby_minplayers_start", 1);
  level notify("start_prematch");

  foreach(var_4 in level.startbuttons) {
    var_4 scripts\mp\gameobjects::allowuse("none");
    var_4.trigger = undefined;
    var_4.visibleteam = "none";
    var_4.flagmodel delete();
    var_4 notify("deleted");
  }

  level notify("dev_force_start_completed");
}

function livelobbyroundendwait(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  wait var_0;
  level notify("round_end_finished");
}

function livelobbymatchstarttimer(var_0, var_1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_2 = int(var_1);

  if(var_2 >= 2) {
    setomnvar("ui_match_start_text", var_0);
    var_3 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";
    matchstarttimerperplayer_internal(var_2, var_3);
  }

  visionsetnaked("", 0);
}

function clearmatchhasmorethan1playervariablesonroundend() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

function updatematchhasmorethan1playeromnvaronplayersfirstspawn() {
  var_0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1) {
      game["matchHasMoreThan1Player"] = 1;
    }
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++) {
        level.players[var_1] setclientomnvar("match_has_more_than_1_player", 1);
      }

      return;
    }

    self setclientomnvar("match_has_more_than_1_player", 1);
    return;
  }
}

function updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  var_0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]--;

  if(game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] <= 1) {
      game["matchHasMoreThan1Player"] = 0;
    }
  }

  if(!game["matchHasMoreThan1Player"]) {
    if(var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++) {
        level.players[var_1] setclientomnvar("match_has_more_than_1_player", 0);
      }

      return;
    }

    return;
  }
}

function ref_12c14() {
  wait 10;
  var_0 = [];
  GscBinSkip0(0x2e, 1, "tactical_ladder_col");
}

function reinforcement_icon_objective_id() {
  return 9;
}

function getintorzero() {
  level.allowsupers = getdvarint("scr_" + scripts\mp\utility\game::round_vehicle_logic() + "_allowSupers", level.allowsupers);
}

function ref_119ae() {
  foreach(var_1 in level.players) {
    if(isPlayer(var_1)) {
      scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_1, "damageDone", var_1 scripts\mp\utility\stats::getpersstat("damage"));
    }
  }
}

function ref_119af(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.team)) {
    return;
  }

  if(!istrue(level.teambased) || istrue(level.multiteambased)) {
    return;
  }

  var_1 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2 = var_0.team;
  var_3 = level.teamnamelist[0];

  if(var_2 == var_3) {
    var_3 = level.teamnamelist[1];
  }

  var_4 = getteamscore(var_2);
  var_5 = getteamscore(var_3);
  var_6 = 0;

  if(isDefined(var_0.isbecomingzombie)) {
    var_6 = var_0.isbecomingzombie;
  }

  var_0 dlog_recordplayerevent("dlog_event_end_of_round", ["time_from_match_start", var_1, "player_team_name", var_2, "enemy_team_name", var_3, "player_team_score", var_4, "enemy_team_score", var_5, "damage_this_round", var_6]);
}

function ref_12465() {
  self setclientomnvar("ui_br_end_game_splash_type", 0);
  self setclientomnvar("ui_br_squad_eliminated_active", 0);
  thread scripts\mp\gametypes\br_gulag::gulagfadetoblack(1);
  wait 1;
  self.multieventdisabled = 1;
  ref_12767(level.multieventdebug.ref_142af, level.multieventdebug.ref_142ae, level.multieventdebug.unmarkplayeraseliminated);
  self.multieventdisabled = undefined;
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("post_game_state", 14);
}

function ref_12767(var_0, var_1, var_2) {
  self setclientomnvar("ui_br_bink_overlay_state", 12);
  self setsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
  scripts\mp\utility\player::_freezecontrols(1);
  self setclientdvar("LQKPQMPRQN", 0);
  var_3 = getDvar("LKTPRPKPMR");
  var_4 = getDvar("LOSOOOTNMS");
  var_5 = getDvar("NNMLSMNTOQ");
  setDvar("LKTPRPKPMR", 1);
  setDvar("LOSOOOTNMS", 1);
  setDvar("NNMLSMNTOQ", -1);
  self preloadcinematicforplayer(var_0, 1, var_2);
  var_6 = gettime();
  ref_133dd(var_6, var_1 * 1000);
  self skydive_cutparachuteoff();
  scripts\mp\utility\player::restorebasevisionset(0);
  self setclientdvar("LQKPQMPRQN", scripts\mp\utility\game::updatetextongamepadchange());
  setDvar("voiceProximityTeam", var_3);
  setDvar("voiceProximityEnemy", var_4);
  setDvar("voiceProximityRadius", var_5);
  scripts\mp\utility\player::_freezecontrols(0);
  self setclientomnvar("ui_br_bink_overlay_state", 0);
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
}

function ref_133dd(var_0, var_1) {
  self endon("disconnect");
  wait 2;
  var_2 = gettime();
  var_3 = 0;

  while(gettime() - var_0 < var_1 && gettime() - var_2 < 1000) {
    waitframe();

    if(self useButtonPressed()) {
      if(!var_3) {
        var_3 = 1;
      }

      continue;
    }

    var_3 = 0;
    var_2 = gettime();
  }
}