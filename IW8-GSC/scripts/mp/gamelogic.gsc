/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gamelogic.gsc
***********************************************/

function onforfeit(var0) {
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
  var1 = 20;
  matchforfeittimer(var1);
  var2 = &"";

  if(!isDefined(var0)) {
    var2 = game["end_reason"]["players_forfeited"];
    var3 = level.players[0];
  } else {
    if(var1 == "allies") {
      var3 = game["end_reason"]["spetsnaz_forfeited"];
    } else {
      var3 = game["end_reason"]["marines_forfeited"];
    }

    var3 = var1;
  }

  level.forcedend = 1;

  if(isPlayer(var3)) {
    logstring("[KEY_MOMENT] forfeit, win: " + var3 getxuid() + "(" + var3.name + ")");
  } else {
    logstring("[KEY_MOMENT] forfeit, win: " + var3);
  }

  thread endgame(var3, var3);
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

  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_match_start_countdown", 0);
    var1 setclientomnvar("ui_match_in_progress", 1);
  }
}

function matchforfeittimer_internal(var0) {
  waittillframeend();
  level endon("match_forfeit_timer_beginning");

  while(var0 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod) {
    foreach(var2 in level.players) {
      var2 setclientomnvar("ui_match_start_countdown", var0);
      var2 setclientomnvar("ui_match_in_progress", 0);
    }

    var0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_match_start_countdown", 0);
    var2 setclientomnvar("ui_match_in_progress", 1);
  }
}

function matchforfeittimer(var0) {
  level notify("match_forfeit_timer_beginning");
  var1 = int(var0);
  setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  matchforfeittimer_internal(var1);
}

function default_ondeadevent(var0) {
  logstring("team eliminated: " + var0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    foreach(var2 in scripts\mp\utility\teams::getteamdata(var0, "players")) {
      var3 = undefined;

      if(istrue(var2.pers["hasDoneAnyCombat"]) || istrue(var2.pers["participation"])) {
        var3 = "eliminated";
      }

      var2 scripts\cp_mp\utility\game_utility::stopkeyearning(var3);
    }
  }

  if(var0 == "all") {
    logstring("[KEY_MOMENT] tie");

    if(level.teambased) {
      thread endgame("tie", game["end_reason"]["tie"]);
      return;
    }

    thread endgame(undefined, game["end_reason"]["tie"]);
    return;
  }

  var8 = scripts\mp\utility\teams::getenemyteams(var0);
  var9 = [];

  foreach(var6 in var8) {
    var9 = 0;
  }

  if(!istrue(level.disablespawning)) {
    foreach(var6 in var8) {
      foreach(var2 in scripts\mp\utility\teams::getteamdata(var6, "players")) {
        if(!istrue(var2.hasspawned)) {
          continue;
        }

        var9 = var9[var6] + var2.pers["lives"];
      }
    }
  }

  var16 = [];

  foreach(var6 in var8) {
    if(scripts\mp\utility\teams::getteamdata(var6, "aliveCount") || var9[var6]) {
      var16 = var6;
    }
  }

  if(var16.size == 1) {
    thread endgame(var16[0], game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
    return;
  }
}

function default_ononeleftevent(var0) {
  if(level.teambased) {
    var1 = scripts\mp\utility\game::getlastlivingplayer(var0);

    if(isDefined(var1)) {
      thread givelastonteamwarning();
    }
  } else {
    var1 = scripts\mp\utility\game::getlastlivingplayer();
    logstring("[KEY_MOMENT] last one alive, win: " + var1.name);
    thread endgame(var1, game["end_reason"]["enemies_eliminated"]);
  }

  return true;
}

function roundend_checkscorelimit(var0, var1) {
  checkteamscorelimitsoon(var0);

  if(istrue(var1)) {
    level notify("roundEnd_CheckScoreLimit");
    level endon("roundEnd_CheckScoreLimit");
    waitframe();
  }

  var2 = scripts\mp\utility\game::getwingamebytype();

  if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
    if(scripts\mp\utility\game::istimetobeatrulegametype()) {
      if(scripts\mp\utility\game::settimetobeat(var0)) {
        foreach(var4 in level.players) {
          var4 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var4.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var4 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var4.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        thread endgame(var0, game["end_reason"]["score_limit_reached"]);
        return;
      }

      return;
    }

    if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
      return;
    }

    thread endgame(var3, game["end_reason"]["score_limit_reached"]);
    return;
  }

  if(level.roundscorelimit > 0) {
    var6 = [];

    foreach(var8 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var8)) {
        continue;
      }

      if(game["teamScores"][var8] >= level.roundscorelimit) {
        var6 = var8;
      }
    }

    if(var6.size > 0) {
      if(var6.size > 1) {
        var10 = 0;
        var11 = undefined;
        var12 = 0;

        foreach(var8 in var6) {
          var14 = game["teamScores"][var8];

          if(!isDefined(var11)) {
            var10 = var14;
            var11 = var8;
            var12 = 0;
            continue;
          }

          if(var14 > var10) {
            var10 = var14;
            var11 = var8;
            var12 = 0;
            continue;
          }

          if(var14 == var10) {
            var12 = 1;
          }
        }

        if(var12) {
          thread endgame("tie", game["end_reason"]["score_limit_reached"]);
          return;
        }

        thread endgame(var11, game["end_reason"]["score_limit_reached"]);
        return;
      }

      thread endgame(var6[0], game["end_reason"]["score_limit_reached"]);
      return;
    }

    return;
  }
}

function default_ontimelimit() {
  var0 = "tie";

  if(level.teambased) {
    if(scripts\mp\utility\game::inovertime() || scripts\mp\utility\game::intimetobeat()) {
      if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        var1 = game["overtimeProgress"] + game["overtimeProgressFrac"];
        var0 = scripts\mp\utility\game::setscoretobeat(game["attackers"], var1 * 60);
      } else if(scripts\mp\utility\game::istimetobeatvalid()) {
        var0 = game["timeToBeatTeam"];
      }
    } else {
      var0 = scripts\mp\gamescore::gethighestscoringteam();
    }

    logstring("[KEY_MOMENT] time limit, win: " + var0);
  } else {
    var0 = scripts\mp\gamescore::gethighestscoringplayer();

    if(scripts\mp\gamescore::ishighestscoringplayertied()) {
      var0 = "tie";
    }

    if(isDefined(var0) && isPlayer(var0)) {
      logstring("[KEY_MOMENT] time limit, win: " + var0.name);
    } else {
      logstring("[KEY_MOMENT] time limit, tie");
    }
  }

  thread endgame(var0, game["end_reason"]["time_limit_reached"]);
}

function default_onhalftime() {
  var0 = undefined;
  thread endgame("halftime", game["end_reason"]["time_limit_reached"]);
}

function forceend(var0) {
  if(level.hostforcedend || level.forcedend) {
    return;
  }

  scripts\mp\gamescore::updateplacement();

  if(level.teambased) {
    foreach(var2 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var2)) {
        continue;
      }

      scripts\mp\gamescore::updatetotalteamscore(var2);
    }
  }

  var4 = undefined;

  if(level.teambased) {
    var4 = scripts\mp\gamescore::gethighestscoringteam();
    logstring("[KEY_MOMENT] host ended game, win: " + var4);
  } else {
    var4 = scripts\mp\gamescore::gethighestscoringplayer();

    if(isDefined(var4)) {
      logstring("[KEY_MOMENT] host ended game, win: " + var4.name);
    } else {
      logstring("[KEY_MOMENT] host ended game, tie");
    }
  }

  level.forcedend = 1;
  level.hostforcedend = 1;

  if(level.splitscreen) {
    var7 = game["end_reason"]["ended_game"];
  } else {
    var7 = game["end_reason"]["host_ended_game"];
  }

  if(isDefined(var4) && var4 == 2) {
    if(level.teambased) {
      if(var7 == "allies") {
        var8 = game["end_reason"]["spetsnaz_forfeited"];
      } else {
        var8 = game["end_reason"]["marines_forfeited"];
      }
    } else {
      var8 = game["end_reason"]["players_forfeited"];
    }
  }

  level notify("force_end");
  thread endgame(var8, var8);
}

function onscorelimit(var0) {
  var1 = game["end_reason"]["score_limit_reached"];
  var2 = "tie";

  if(level.teambased) {
    var2 = scripts\mp\gamescore::freight_lift_door_switch();

    if(var2 == "none") {
      var2 = "tie";
    }

    logstring("[KEY_MOMENT] scorelimit, win: " + var2);
  } else {
    var2 = scripts\mp\gamescore::gethighestscoringplayer();

    if(istrue(var0) && scripts\mp\gamescore::ishighestscoringplayertied()) {
      var2 = "tie";
    }

    if(isDefined(var2) && isPlayer(var2)) {
      logstring("[KEY_MOMENT] scorelimit, win: " + var2.name);
    } else {
      logstring("[KEY_MOMENT] scorelimit, tie");
    }

    var6 = var2 scripts\mp\killstreaks\killstreaks::calcstreakcost("nuke");

    if(scripts\mp\utility\game::getscorelimit() == var6 && var2.pers["cur_kill_streak"] == var6) {
      level.ref_11c81 = var2;
      level.starttime = gettime();
      level.discardtime = 0;
      level.timerpausetime = 0;
      var7 = "scr_" + scripts\mp\utility\game::getgametype() + "_timelimit";
      level.watchdvars[var7].value = 30;
      level.overridewatchdvars[var7] = 30;
      level.dontendonscore = 1;
      return;
    }
  }

  thread endgame(var6, var2);
  return 1;
}

function updategameevents() {
  var0 = 0;
  level.teamswithplayers = [];

  foreach(var2 in level.teamnamelist) {
    var3 = scripts\mp\utility\teams::getteamdata(var2, "teamCount");
    var0 += var3;

    if(var3) {
      level.teamswithplayers[level.teamswithplayers.size] = var2;
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
      var5 = 0;

      foreach(var7 in level.teamnamelist) {
        var5 += scripts\mp\utility\teams::getteamdata(var7, "teamCount");
      }

      if(var5 == 1 && level.maxplayercount > 1) {
        thread onforfeit();
        return;
      }

      if(var5 > 1) {
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
    var9 = [];

    foreach(var7 in level.teamnamelist) {
      var9 = 0;
    }

    foreach(var13 in level.players) {
      if(!istrue(var13.hasspawned) || var13.team == "spectator" || var13.team == "follower" || var13.team == "free") {
        continue;
      }

      var9 = var9[var13.team] + var13.pers["lives"];
    }

    if(istrue(level.disablespawning)) {
      foreach(var7 in level.teamnamelist) {
        var9 = 0;
      }
    }

    var17 = 0;

    foreach(var7 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var7, "aliveCount")) {
        var17 = 1;
        break;
      }
    }

    var20 = 0;

    foreach(var22 in var9) {
      if(var22) {
        var20 = 1;
        break;
      }
    }

    if(!var17 && !var20) {
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

    foreach(var7 in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(var7, "aliveCount") && !var9[var7]) {
        if(istrue(level.postgameexfil) && level.gameended) {
          level notify("exfil_continue_game_end");
        }

        if(!istrue(level.skipondeadevent)) {
          if(istrue(level.nukeincoming)) {
            return;
          }

          if(level.multiteambased) {
            if(!scripts\mp\utility\teams::getteamdata(var7, "deathEvent") && scripts\mp\utility\teams::getteamdata(var7, "hasSpawned")) {
              if(ref_1330a() && game["roundsPlayed"] == 0) {
                logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry MultiteamBased");
              }

              scripts\mp\utility\teams::setteamdata(var7, "deathEvent", 1);
              [[level.ondeadevent]](var7);
            }

            continue;
          }

          if(ref_1330a() && game["roundsPlayed"] == 0) {
            logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry Team based");
          }

          return [[level.ondeadevent]](var7);
        }
      }
    }

    foreach(var7 in level.teamnamelist) {
      var27 = scripts\mp\utility\teams::getteamdata(var7, "aliveCount");

      if(var27 == 1 || var27 == 2) {
        var28 = 0;
        var29 = undefined;
        var30 = scripts\mp\utility\teams::getteamdata(var7, "players");
        var31 = [];

        foreach(var13 in var30) {
          if(!isalive(var13)) {
            var28 += var13.pers["lives"];
            continue;
          }

          var31 = var13;
        }

        if(var27 != 1) {
          scripts\mp\utility\teams::setteamdata(var7, "oneLeft", 0);
        }

        if(var28 == 0) {
          if(var27 == 1 && !scripts\mp\utility\teams::getteamdata(var7, "oneLeft") && gettime() > scripts\mp\utility\teams::getteamdata(var7, "oneLeftTime") + 5000) {
            scripts\mp\utility\teams::setteamdata(var7, "oneLeftTime", gettime());
            scripts\mp\utility\teams::setteamdata(var7, "oneLeft", 1);

            if(var30.size > 1) {
              [[level.ononeleftevent]](var7);
            }
          } else if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "kingslayer" && getDvar("scr_br_gametype", "") != "rumble" && getDvar("scr_br_gametype", "") != "gold_war" && var27 == 2 && var30.size > 2) {
            var34 = scripts\engine\utility::random(var31);
            level thread scripts\mp\battlechatter_mp::trysaylocalsound(var34, "inform_last_two");
          }
        }

        continue;
      }

      scripts\mp\utility\teams::setteamdata(var7, "oneLeft", 0);
    }

    return;
  }

  var9 = 0;

  foreach(var13 in level.players) {
    if(var13.team == "spectator" || var13.team == "follower") {
      continue;
    }

    var9 += var13.pers["lives"];
  }

  var38 = 0;

  foreach(var7 in level.teamnamelist) {
    var38 += scripts\mp\utility\teams::getteamdata(var7, "aliveCount");
  }

  if(!var38 && !var9) {
    if(istrue(level.nukeincoming)) {
      return;
    }

    return [[level.ondeadevent]]("all");
  }

  var41 = scripts\mp\utility\game::getpotentiallivingplayers();

  if(var41.size == 1) {
    return [[level.ononeleftevent]]("all");
  }
}

function timelimitclock_intermission(var0) {
  setgameendtime(gettime() + int(var0 * 1000));
  var1 = spawn("script_origin", (0, 0, 0));
  var1 hide();

  if(var0 >= 10) {
    wait var0 - 10;
  }

  for(;;) {
    var1 playSound("ui_mp_timer_countdown");
    wait 1;
  }
}

function waitforplayers(var0) {
  var1 = gettime();

  if(istrue(game["isLaunchChunk"])) {
    var2 = 0;
  } else if(var1 > 5) {
    var2 = gettime() + getdvarint("MSKKKKOPKS") * 1000;
  } else {
    var2 = 0;
  }

  var3 = max(1, level.connectingplayers / 2);
  scripts\mp\flags::gameflagwait("infil_setup_complete");
  var4 = 0;
  var5 = 0;

  for(;;) {
    if(istrue(game["roundsPlayed"])) {
      break;
    }

    var6 = level.maxplayercount;
    var7 = round_spawn_vehicles();

    if(!var4) {
      if(var7 > 0) {
        var2 = gettime();
        var4 = 1;
      } else {
        waitframe();
        continue;
      }
    }

    var8 = gettime();
    var9 = var6 >= var3;
    var10 = var7 >= var3;

    if(var10) {
      foreach(var12 in level.teamnamelist) {
        if(!checkrequiredteamcount(var12)) {
          var9 = 0;
          break;
        }
      }
    }

    foreach(var12 in level.teamnamelist) {
      if(!getquestxprewardinstance(var12)) {
        if(level.gametype == "arena" && !var5) {
          setomnvar("ui_match_start_text", "waiting_for_teams");
        }

        var10 = 0;
        break;
      }
    }

    var16 = var2 + level.prematchperiod * 1000 - 200;

    if(scripts\mp\flags::gameflag("infil_will_run")) {
      if(var10 && var8 > var2 || var8 > var16) {
        break;
      }
    } else if(var10 && var9 && var8 > var2 || var8 > var16) {
      break;
    }

    waitframe();
  }
}

function round_spawn_vehicles() {
  var0 = 0;

  foreach(var2 in level.players) {
    if(istrue(var2.pers["streamSyncComplete"])) {
      var0++;
    }
  }

  return var0;
}

function checkrequiredteamcount(var0) {
  return scripts\mp\utility\teams::getteamdata(var0, "hasSpawned") >= level.requiredplayercount[var0];
}

function getquestxprewardinstance(var0) {
  var1 = 0;

  foreach(var3 in level.players) {
    if(isDefined(var3.team) && var3.team == var0 && istrue(var3.pers["streamSyncComplete"])) {
      var1++;
    }
  }

  return var1 >= level.requiredplayercount[var0];
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
    var0 = 30;

    if(scripts\mp\utility\game::getgametype() == "br") {
      var0 = getdvarint("scr_br_match_timer", 60);
    }

    if(scripts\mp\utility\game::getgametype() == "br" && istrue(level.infilcanusemap)) {
      var0 = getdvarint("scr_br_match_timer", 25);
    }

    level.allowprematchdamage = 0;

    if(scripts\mp\utility\game::getgametype() == "br") {
      level.allowprematchdamage = 1;
      level thread scripts\mp\gametypes\br_public::defend_wave_1();

      if(scripts\mp\gametypes\br_public::isusinginfilselection()) {
        scripts\mp\gametypes\br_public::handleinfilspawnselectstart();
      }
    }

    livelobbymatchstarttimer(level, "match_starting_in", var0);

    if(scripts\mp\utility\game::getgametype() == "br") {
      if(scripts\mp\gametypes\br_public::isusinginfilselection()) {
        scripts\mp\gametypes\br_public::handleinfilspawnselectend();
      }

      var2 = 0;
      var3 = 0;
      var4 = 0;

      foreach(var6 in level.players) {
        if(isbot(var6) || initmaxspeedforpathlengthtable(var6)) {
          var3 += 1;
          continue;
        }

        if(var6 calloutmarkerping_getEnt()) {
          var4 += 1;
          continue;
        }

        var2 += 1;
        LOC_000001b5:
      }

      logstring("[KEY_MOMENT] Prematch");
      logstring("=============================================");
      logstring("matchDelay = " + var0);
      logstring("bots = " + var3);
      logstring("headless = " + var4);
      logstring("humans = " + var2);
      logstring("=============================================");
    }

    level notify("start_prematch");
    level.prematchperiod = 0;

    if(!istrue(level.brkillchainchance)) {
      game["blockJIP"] = 1;
    }
  } else if(!istrue(level.ref_133e0)) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var8 = getdvarint("br_minplayers");

      if(var8 != 0) {
        thread ref_144bf();
        thread enemy_move_up_and_ignore();
        level waittill("start_prematch");
      }

      var0 = 15;

      if(scripts\mp\gametypes\br_public::isusinginfilselection()) {
        scripts\mp\gametypes\br_public::handleinfilspawnselectstart();
      }

      level.allowprematchdamage = 0;

      if(scripts\mp\utility\game::getgametype() == "br") {
        level.allowprematchdamage = 1;

        if(istrue(level.infilcanusemap)) {
          var0 = getdvarint("scr_br_match_timer", 25);
        }
      }

      livelobbymatchstarttimer(level, "match_starting_in", var0);

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
    foreach(var1 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var1)) {
        var1[[level.parachuterestoreweaponscb]]();
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
    var0 = level.players;

    for(var1 = 0; var1 < var0.size; var1++) {
      var2 = var0[var1];

      if(!var2.hasspawned && var2.sessionteam != "spectator" && !isalive(var2)) {
        var2.statusicon = "hud_status_dead";
      }
    }
  }

  level thread[[level.updategameevents]]();
}

function sethasdonecombat(var0, var1) {
  if(var1 && !istrue(var0.hasdonecombat)) {
    scripts\mp\class::disableclassswapallowed();
  }

  var0.hasdonecombat = var1;

  if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(var1 && !istrue(var0.pers["hasDoneAnyCombat"])) {
    var0.pers["hasDoneAnyCombat"] = 1;

    if(scripts\mp\utility\game::getgametype() == "br") {
      var0 scripts\mp\utility\stats::incpersstat("gamesPlayed", 1);
    }

    if(isDefined(var0.pers["hasMatchLoss"]) && var0.pers["hasMatchLoss"]) {
      return;
    }

    updatelossstats(var0);
    return;
  }
}

function updatewinstats(var0) {
  if(!var0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(!istrue(var0.pers["hasDoneAnyCombat"])) {
    return;
  }

  if(istrue(var0.pers["recordedLoss"])) {
    var0 scripts\mp\playerstats_interface::addtoplayerstat(-1, "matchStats", "losses");
  }

  var0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "wins");
  var0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "currentWinStreak");
  var0 scripts\mp\playerstats_interface::addtoplayerstat(1, "modeRecords", scripts\mp\utility\game::getgametype());
  var1 = var0 scripts\mp\playerstats_interface::getplayerstat("matchStats", "currentWinStreak");

  if(var1 > var0 scripts\mp\playerstats_interface::getplayerstat("bestStats", "longestWinStreak")) {
    var0 scripts\mp\playerstats_interface::setplayerstat(var1, "bestStats", "longestWinStreak");
  }

  var0 scripts\mp\persistence::statsetchild("round", "win", 1);
  var0 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

function updatelossstats(var0) {
  if(!var0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(!istrue(var0.pers["hasDoneAnyCombat"])) {
    return;
  }

  var0.pers["hasMatchLoss"] = 1;

  if(!istrue(self.joinedinprogress)) {
    var0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "losses");
    var0.pers["recordedLoss"] = 1;
  }

  var0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "gamesPlayed");
  var0 scripts\mp\persistence::statsetchild("round", "loss", 1);
}

function updatetiestats(var0) {
  if(!var0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(!istrue(var0.pers["hasDoneAnyCombat"])) {
    return;
  }

  if(istrue(var0.pers["recordedLoss"])) {
    var0 scripts\mp\playerstats_interface::addtoplayerstat(-1, "matchStats", "losses");
    var0 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
  }

  var0 scripts\mp\playerstats_interface::addtoplayerstat(1, "matchStats", "ties");
  var0 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

function updatewinlossstats(var0) {
  if(scripts\mp\utility\game::privatematch()) {
    return;
  }

  if(!scripts\mp\utility\game::waslastround()) {
    return;
  }

  level.processedwinloss = 1;
  var1 = level.players;
  updateplayercombatstatus();

  if(!isDefined(var0) || isDefined(var0) && isstring(var0) && var0 == "tie") {
    foreach(var3 in level.players) {
      if(isDefined(var3.connectedpostgame)) {
        continue;
      }

      if(level.hostforcedend && var3 ishost()) {
        var3 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      updatetiestats(var3);
    }
  } else if(isPlayer(var0)) {
    if(level.hostforcedend && var0 ishost()) {
      var0 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
      return;
    }

    if(isDefined(level.lastplayerwins)) {
      updatewinstats(level.placement["all"][0]);
    } else {
      for(var5 = 0; var5 < min(level.placement["all"].size, 3); var5++) {
        updatewinstats(level.placement["all"][var5]);
      }
    }
  } else if(isstring(var0)) {
    foreach(var3 in level.players) {
      if(isDefined(var3.connectedpostgame)) {
        continue;
      }

      if(level.hostforcedend && var3 ishost()) {
        var3 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      if(var0 == "tie") {
        updatetiestats(var3);
        continue;
      }

      if(var3.pers["team"] == var0) {
        updatewinstats(var3);
        continue;
      }

      if(istrue(var3.pers["recordedLoss"])) {
        var3 scripts\mp\playerstats_interface::setplayerstat(0, "matchStats", "currentWinStreak");
      }
    }
  }

  foreach(var3 in level.players) {
    if(!isDefined(var3) || !var3 scripts\mp\utility\game::onlinestatsenabled()) {
      continue;
    }

    if(isai(var3)) {
      continue;
    }

    var9 = var3 scripts\mp\playerstats_interface::getplayerstat("matchStats", "wins");

    if(var9 >= 5) {
      var3 giveachievement("MP_ACHIEVEMENT_1");
    }
  }
}

function updateplayercombatstatus() {
  if(scripts\mp\utility\game::getgametype() != "infect") {
    return;
  }

  foreach(var1 in level.players) {
    if(var1.sessionstate == "spectator" && !var1.spectatekillcam) {
      continue;
    }

    if(istrue(var1.pers["hasDoneAnyCombat"])) {
      continue;
    }

    if(var1.team == "axis") {
      continue;
    }

    sethasdonecombat(var1, var1, 1);
  }
}

function freezeplayerforroundend(var0) {
  self endon("disconnect");
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\lower_message::clearlowermessages();

  if(!isDefined(var0)) {
    var0 = level.framedurationseconds;
  }

  wait var0;
  scripts\mp\playeractions::allowactionset("gameEndFreeze", 0);

  if(self isonground() || self isonladder()) {
    self allowmovement(0);
    return;
  }

  thread playerzombiesupersprint();
}

function playerzombiesupersprint() {
  self endon("disconnect");
  var0 = 0;

  while(var0 < 1) {
    if(!isDefined(self)) {
      return;
    }

    if(!self isonground()) {
      var0 += level.framedurationseconds;
    } else {
      self allowmovement(0);
      break;
    }

    wait level.framedurationseconds;
  }

  self allowmovement(0);
}

function updatematchbonusscores(var0) {
  if(!game["timePassed"]) {
    return;
  }

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  if(!scripts\mp\utility\game::gettimelimit() || level.forcedend) {
    var1 = scripts\mp\utility\game::gettimepassed() / 1000;
    var1 = min(var1, 1200);
  } else {
    var1 = scripts\mp\utility\game::gettimelimit();
  }

  jumpiffalse(level.teambased) LOC_000001e0;
  jumpiffalse(var1 != "tie") LOC_0000005b;
  setwinningteam(var1);

  foreach(var3 in level.players) {
    if(isDefined(var3.connectedpostgame)) {
      continue;
    }

    if(!var3 scripts\mp\utility\game::rankingenabled()) {
      continue;
    }

    if(var3.timeplayed["total"] < 1 || var3.pers["participation"] < 1) {
      continue;
    }

    if(level.hostforcedend && var3 ishost()) {
      continue;
    }

    if(!istrue(var3.pers["hasDoneAnyCombat"])) {
      continue;
    }

    if(var1 == "tie") {
      var4 = calculatematchbonus(var3, "tie", var1);
      thread givematchbonus(var3, "tie");
      var3.matchbonus = var4;
    } else if(isDefined(var3.pers["team"]) && var3.pers["team"] == var1) {
      var4 = calculatematchbonus(var3, "win", var1);
      thread givematchbonus(var3, "win");
      var3.matchbonus = var4;
    } else if(isDefined(var3.pers["team"]) && scripts\mp\utility\teams::isgameplayteam(var3.pers["team"]) && var3.pers["team"] != var1) {
      var4 = calculatematchbonus(var3, "loss", var1);
      thread givematchbonus(var3, "loss");
      var3.matchbonus = var4;
    }

    freight_lift_button_activation(var3, var1);
  }

  return;
}

function calculatematchbonus(var0, var1) {
  var2 = getdvarint("scr_xp_matchBonusBaseline", 250);
  var3 = var1 / 60;
  var4 = scripts\mp\rank::getscoreinfovalue(var0);
  var5 = self.timeplayed["total"] / var1;
  var6 = scripts\mp\rank::getgametypexpmultiplier();
  var7 = int(var2 * var4 * var3 * var5 * var6);
  var7 = int(min(var7, 16384));
  return var7;
}

function givematchbonus(var0, var1) {
  self endon("disconnect");

  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
    return;
  }

  level waittill("give_match_bonus");
  scripts\mp\rank::giverankxp(var0, var1, undefined, 1, 1);

  if(var0 == "win") {
    thread scripts\mp\awards::givemidmatchaward("match_complete_win");
    return;
  }

  thread scripts\mp\awards::givemidmatchaward("match_complete");
}

function freight_lift_button_activation(var0) {
  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }

  var1 = scripts\mp\weaponrank::reload_handle_hintstring() / 60;
  var2 = var0 / 60;
  var3 = int(var1 * var2);
  var4 = int(50);
  var5 = self.timeplayed["total"] / var0;
  var6 = var4 * var5;
  var7 = int(var3 * var6);
  var7 -= int(self.pers["weaponMatchBonusKills"] * var6);

  if(var7 <= 0) {
    return;
  }

  var8 = 0;

  foreach(var10 in self.pers["killsPerWeapon"]) {
    var8 += var3 - var10.killcount;
  }

  if(var8 <= 0) {
    return;
  }

  foreach(var10 in self.pers["killsPerWeapon"]) {
    var13 = (var3 - var10.killcount) / var8;
    var14 = int(var7 * var13);
    scripts\mp\rank::incrankxp(0, var10, var14, "WeaponMatchBonus");

    foreach(var16 in self.pers["matchdataWeaponStats"]) {
      if(issubstr(var18, var19)) {
        if(isDefined(var16.stats["kills"]) && var10.killcount > 0) {
          var17 = var13 * var16.stats["kills"] / var10.killcount;
          var14 = int(var7 * var17);

          if(isDefined(var16.stats["xp_earned"])) {
            var16.stats["xp_earned"] = var16.stats["xp_earned"] + var14;
          } else {
            var16.stats["xp_earned"] = var14;
          }
        }
      }
    }
  }
}

function setxenonranks(var0) {
  var1 = level.players;

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(!isDefined(var3.score) || !isDefined(var3.pers["team"])) {}
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];
    ammobox_onplayerholduse(var3);
  }
}

function ammobox_onplayerholduse(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(istrue(var0.pers["xenonRankSet"])) {
    return;
  }

  if(!isDefined(var0.kills) || !isDefined(var0.deaths)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(1 > var0.timeplayed["total"]) {
      return;
    }

    if(!isDefined(var0.arenadamage)) {
      return;
    }

    var2 = var0.arenadamage;
    setplayerteamrank(var0, var0.clientid, var2);
    var0.pers["xenonRankSet"] = 1;
    return;
  }

  if(scripts\mp\utility\game::validate_track()) {
    var3 = 1000 - var1;
    setplayerteamrank(var0, var0.clientid, var3);
    var0.pers["xenonRankSet"] = 1;
    return;
  }

  if(120 > var0.timeplayed["total"]) {
    return;
  }

  var4 = 0;

  if(getdvarint("scr_game_subtract_suicides_from_rank") == 1) {
    var4 = var0 scripts\mp\utility\stats::getpersstat("suicides");
  }

  var5 = (var0.kills - var0.deaths - var4) / var0.timeplayed["total"] / 60;
  setplayerteamrank(var0, var0.clientid, var5);
  var0.pers["xenonRankSet"] = 1;
}

function checktimelimit(var0) {
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

  var1 = gettimeremaining();
  setgameendtime(gettime() + int(var1));
  var2 = istrue(level.ontimelimitgraceperiod);

  if(var1 > 0 && !isDefined(level.playerplaygestureweaponanim)) {
    if(var2) {
      if(istrue(level.ref_13124)) {
        setomnvarforallclients("ui_overtime_timer_show", 0);
        return;
      }

      setomnvar("ui_overtime_timer_show", 0);
    }

    return;
  }

  if(var2) {
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

    var3 = clamp(1 - level.currenttimelimitdelay / level.ontimelimitgraceperiod, 0, 1);

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      if(istrue(level.ref_13124)) {
        if(!isDefined(level.playerparachutedetachresetomnvars)) {
          setomnvarforallclients("ui_overtime_timer_show", 1);
        }

        setomnvarforallclients("ui_overtime_timer", var3);
      } else {
        setomnvar("ui_overtime_timer_show", 1);
        setomnvar("ui_overtime_timer", var3);
      }

      setomnvar("ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000);
    } else {
      if(istrue(level.ref_13124)) {
        setomnvarforallclients("ui_overtime_timer_show", 0);
        setomnvarforallclients("ui_overtime_timer", var3);
      } else {
        setomnvar("ui_overtime_timer_show", 0);
        setomnvar("ui_overtime_timer", var3);
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
          var0 = checkdomjiprules();
          break;
        case "cyber":
        case "siege":
        case "sr":
        case "sd":
        case "arena":
          var0 = checksdjiprules();
          break;
        case "ctf":
          var0 = checkctfjiprules();
          break;
        case "ball":
          var0 = checkballjiprules();
          break;
        case "dd":
          var0 = checkddjiprules();
          break;
        case "br":
          var0 = getfilterformodifier();
          break;
        default:
          var0 = checkdefaultjiprules();
          break;
      }

      if(var0) {
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
    foreach(var1 in level.teamnamelist) {
      if(getteamscoreint(var1) > 150) {
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
  var0 = 3;

  switch (scripts\mp\utility\game::getgametype()) {
    case "sr":
    case "sd":
      var0 = 3;
      break;
    case "siege":
      var0 = 2;
      break;
    case "cyber":
      var0 = 2;
      break;
    case "arena":
      var0 = 3;
      break;
    default:
      var0 = 3;
      break;
  }

  if(scripts\mp\utility\game::isanymlgmatch()) {
    var0 = 5;
  }

  foreach(var2 in level.teamnamelist) {
    if(scripts\mp\utility\game::getroundswon(var2) >= var0) {
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

  var0 = undefined;
  var1 = undefined;

  foreach(var3 in level.teamnamelist) {
    var4 = getteamscoreint(var3);

    if(!isDefined(var0) || var4 < var0) {
      var0 = var4;
    }

    if(!isDefined(var1) || var4 > var1) {
      var1 = var4;
    }
  }

  var6 = abs(var1 - var0);

  if(var6 > 10) {
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

  var0 = undefined;
  var1 = undefined;

  foreach(var3 in level.teamnamelist) {
    var4 = getteamscoreint(var3);

    if(!isDefined(var0) || var4 < var0) {
      var0 = var4;
    }

    if(!isDefined(var1) || var4 > var1) {
      var1 = var4;
    }
  }

  var6 = abs(var1 - var0);

  if(var6 > 15) {
    return true;
  }

  return false;
}

function checkddjiprules() {
  var0 = 0;

  foreach(var2 in level.teamnamelist) {
    var0 += scripts\mp\utility\game::getroundswon(var2);
  }

  if(var0 >= 2) {
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

function getteamscoreint(var0) {
  return int(game["teamScores"][var0]);
}

function gettimeremaining() {
  return scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();
}

function gettimeremainingpercentage() {
  var0 = scripts\mp\utility\game::gettimelimit() * 1000;
  return (var0 - scripts\mp\utility\game::gettimepassed()) / var0;
}

function checkteamscorelimitsoon(var0) {
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

  var1 = 0;

  if(ref_132ed()) {
    var1 = closetoscorelimit(var0);
  } else if(scripts\mp\utility\game::getgametype() == "arm") {
    var2 = closetoscorelimit(var0);
    var3 = gettimeremaining() < scripts\mp\utility\game::gettimelimit() * 0.075;
    var1 = var2 || var3;
  } else if(scripts\mp\utility\game::gettimepassed() > 45000) {
    var1 = estimatedtimetillscorelimit(var0) < 0.5;
  }

  if(!isDefined(level.playedmatchendingsoon)) {
    level.playedmatchendingsoon = 0;
  }

  if(!level.playedmatchendingsoon && var1) {
    level.playedmatchendingsoon = 1;
    level notify("match_ending_soon", "score");
  }

  if(!level.playedmatchendingsoon && scripts\mp\utility\game::canplayhalfwayvo()) {
    if(getteamscore(var0) >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      scripts\mp\utility\dialog::leaderdialog("halfway_friendly_score", var0, "status");
      thread scripts\mp\music_and_dialog::ref_11bdd(var0);
      var4 = scripts\mp\utility\teams::getenemyteams(var0);

      foreach(var6 in var4) {
        scripts\mp\utility\dialog::leaderdialog("halfway_enemy_score", var6, "status");
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

  var0 = estimatedtimetillscorelimit();

  if(var0 < 2) {
    level notify("match_ending_soon", "score");
    return;
  }
}

function checkscorelimit(var0) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill()) {
    var0 = 1;
  }

  if(istrue(var0)) {
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
    var1 = 0;

    for(var2 = 0; var2 < level.teamnamelist.size; var2++) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(level.teamnamelist[var2])) {
        continue;
      }

      if(game["teamScores"][level.teamnamelist[var2]] >= level.roundscorelimit) {
        var1 = 1;
      }
    }

    if(!var1) {
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
    return onscorelimit(var0);
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
    var0 = level.prematchperiodend;
    level notify("match_start_real_countdown", var0);

    if(!scripts\mp\flags::gameflag("infil_will_run") && game["roundsPlayed"] == 0 && !scripts\cp_mp\utility\game_utility::isarenamap()) {
      thread ref_1335d();
    }

    thread matchstarttimer("match_starting_in", var0);
    thread prematchcountdownnotify(var0);
    level waittill("matchStartTimer_done");
    return;
  }
}

function ref_1335d() {
  setomnvar("ui_in_infil", 1);
  level scripts\engine\utility::waittill_notify_or_timeout("matchStartTimer_done", 8);
  setomnvar("ui_in_infil", -1);
}

function prematchcountdownnotify(var0) {
  level notify("prematchCountdownNotify");
  level endon("prematchCountdownNotify");

  if(isDefined(var0)) {
    wait max(var0 - 5, 0);
  } else {
    wait max(level.prematchperiod + level.prematchperiodend - 5, 0);
  }

  scripts\mp\flags::gameflagset("prematch_countdown");
}

function startmodeobjidnotify(var0) {
  self notify("startOBJID");
  self endon("startOBJID");

  if(scripts\mp\utility\game::getgametype() == "sd") {
    var1 = 6;
  } else {
    var1 = 5;
  }

  if(var1 > var1) {
    var1 -= var1;
    max(var1, 0);
    wait var1;
  } else {
    wait 0.5;
  }

  level notify("start_mode_setup");
}

function matchstarttimer(var0, var1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var2 = int(var1);
  thread startmodeobjidnotify(level);

  if(var2 >= 2) {
    setomnvar("ui_match_start_text", var0);
    var3 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";
    matchstarttimerperplayer_internal(var2, var3);
  }

  visionsetnaked("", 0);
  level notify("matchStartTimer_done");

  if(scripts\cp_mp\utility\game_utility::isrealismenabled() || istrue(level.testrandomrealismclients)) {
    foreach(var5 in level.players) {
      if(istrue(level.testrandomrealismclients)) {
        if(!isDefined(var5.isrealismenabled)) {
          if(scripts\engine\utility::cointoss()) {
            var5 setclientomnvar("ui_realism_hud", 0);
            var5 setclientomnvar("ui_realism_hud", 1);
            var5.isrealismenabled = 1;
          }
        }

        continue;
      }

      var5 setclientomnvar("ui_realism_hud", 0);
      var5 setclientomnvar("ui_realism_hud", 1);
    }

    return;
  }
}

function matchstarttimerperplayer_internal(var0, var1) {
  waittillframeend();
  level endon("match_start_timer_beginning");
  var1 = istrue(var1);
  var2 = int(var0);

  if(var1) {
    GscBinSkip4(0x35, var2);
  }

  var3 = level.teamnamelist;
  var5 = getfirstarraykey(var3);

  if(isDefined(var5)) {
    var4 = var3[var5];
    GscBinSkip4(0x35, var4, var2, var1);
  }

  var3 = undefined;
  var5 = undefined;
  var6 = ["spectator", "follower"];
  var7 = var6;
  var8 = getfirstarraykey(var7);

  if(isDefined(var8)) {
    var4 = var7[var8];
    GscBinSkip4(0x35, var4, var2, var1);
  }

  var7 = undefined;
  var8 = undefined;
  GscBinSkip4(0x35, var2);
}

function ref_11b42(var0) {
  level endon("match_start_timer_beginning");

  if(!isDefined(level.heli_arrived)) {
    level.heli_arrived = spawn("script_origin", (0, 0, 0));
    level.heli_arrived hide();
  }

  level.matchcountdowntime = var0;

  while(var0 > 0 && !level.gameended) {
    if(var0 < 6) {
      var1 = scripts\engine\utility::ter_op(var0 < 4, "match_start_tick_in3", "match_start_tick_in5");
      level.heli_arrived playSound(var1);
    }

    level.matchcountdowntime = var0;
    var0--;
    wait 1;
  }

  level.matchcountdowntime = undefined;
  level.heli_arrived delete();
}

function teamstarttimer(var0, var1, var2) {
  level endon("match_start_timer_beginning");
  var3 = !istrue(var2);
  var4 = undefined;

  if(var3) {
    var4 = spawn("script_origin", (0, 0, 0));
    var4 hide();
    level.matchcountdowntime = var1;
  }

  if(!level.gameended) {
    jumpiffalse(scripts\mp\utility\game::getgametype() == "br") LOC_00000062;
    thread scripts\mp\gametypes\br_public::ref_1285e(var0);
    thread scripts\mp\gametypes\br_public::ref_12854(var0);
    thread scripts\mp\gametypes\br_public::calculateeventstarttime();

    while(var1 > 0 && !level.gameended) {
      if(var3 && var1 < 6) {
        if(var1 < 4) {
          var4 playSound("match_start_tick_in3");
        } else {
          var4 playSound("match_start_tick_in5");
        }
      }

      var5 = scripts\mp\utility\teams::getteamdata(var0, "players");

      foreach(var7 in var5) {
        if(var1 <= 80) {
          var7 setclientomnvar("ui_match_start_countdown", var1);
          var7 setclientomnvar("ui_match_in_progress", 0);
        }
      }

      var1--;

      if(var3) {
        level.matchcountdowntime = var1;
      }

      wait 1;
    }

    if(var3) {
      level.matchcountdowntime = undefined;
      var4 delete();
    }

    if(getdvarint("scr_game_updated_prematch_allows", 1) == 0) {
      var5 = scripts\mp\utility\teams::getteamdata(var0, "players");

      foreach(var7 in var5) {
        scripts\mp\playerlogic::clearprematchlook(var7);
        var7 scripts\mp\utility\player::_freezecontrols(0, 1);
        var7 setclientomnvar("ui_match_start_countdown", -1);
        var7 setclientomnvar("ui_match_in_progress", 1);
      }

      return;
    }

    return;
  }
}

function clearvisionsettimer(var0) {
  while(var0 > 0 && !level.gameended) {
    var0--;
    wait 1;
  }

  visionsetnaked("", 0);
}

function matchstarttimerskip() {
  visionsetnaked("", 0);
}

function onroundswitch(var0) {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(var0) {
    level.halftimetype = "overtime";

    if(scripts\mp\utility\game::islastwinbytwo()) {
      var1 = getbetterteam();

      if(var1 != game["defenders"]) {
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
    var1 = getbetterteam();

    if(var1 != game["defenders"]) {
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

function checkroundswitch(var0) {
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
  } else if(game["roundsPlayed"] % level.roundswitch == 0 || var0) {
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
    var0 = (gettime() - level.gameendtime) / 1000;
    var1 = level.postroundtime - var0;

    if(var1 < 0) {
      return 0;
    }

    return var1;
  }

  if(scripts\mp\utility\game::gettimelimit() <= 0) {
    return undefined;
  }

  if(!isDefined(level.starttime)) {
    return undefined;
  }

  var2 = scripts\mp\utility\game::gettimelimit();
  var0 = (gettime() - level.starttime) / 1000;
  var1 = level.discardtime / 1000 + scripts\mp\utility\game::gettimelimit() - var0;

  if(isDefined(level.timepaused)) {
    var1 += level.timepaused;
  }

  return var1 + level.postroundtime;
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
  var0 = getEntArray("player", "classname");

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1] ishost()) {
      return var0[var1];
    }
  }
}

function hostidledout() {
  var0 = gethostplayer();

  if(isDefined(var0) && !var0.hasspawned && !isDefined(var0.selectedclass)) {
    return true;
  }

  return false;
}

function roundendwait(var0, var1) {
  if(isDefined(level.ref_12db7)) {
    level[[level.ref_12db7]](var0, var1);
    return;
  }

  if(!level.doeomcombat) {
    wait level.ref_127fe + 0.1;
    setomnvarforallclients("post_game_state", 2);
  }

  foreach(var3 in level.players) {
    var3 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  if(!var1) {
    wait var0;
  } else {
    wait var0 / 2;
    level notify("give_match_bonus");
    wait var0 / 2;
  }

  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

function roundenddof(var0) {
  scripts\mp\utility\player::setdof_spectator();
}

function setwaypointiconinfo(var0, var1, var2, var3, var4, var5) {
  level.waypointcolors[var0] = var2;
  level.waypointbgtype[var0] = var1;
  level.waypointstring[var0] = var3;
  level.waypointshader[var0] = var4;
  level.waypointpulses[var0] = var5;
}

function initwaypointbackgrounds() {
  var0 = 0;

  switch (scripts\mp\utility\game::getgametype()) {
    case "trial":
    case "pill":
    case "mtmc":
    case "siege":
    case "dom":
    case "arm":
      setwaypointiconinfo("icon_waypoint_dom_a", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("icon_waypoint_dom_b", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("icon_waypoint_dom_c", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("icon_waypoint_dom_d", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("icon_waypoint_dom_e", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_taking_a", var0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_taking_b", var0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_taking_c", var0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_taking_d", var0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_taking_e", var0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_capture_a", var0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_capture_b", var0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_capture_c", var0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_capture_d", var0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_capture_e", var0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_defend_a", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_defend_b", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_defend_c", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_defend_d", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_defend_e", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_defending_a", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_defending_b", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_defending_c", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_defending_d", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_defending_e", var0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_blocking_a", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_blocking_b", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_blocking_c", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_blocking_d", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_blocking_e", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_blocked_a", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_blocked_b", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_blocked_c", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_blocked_d", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_blocked_e", var0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_losing_a", var0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_losing_b", var0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_losing_c", var0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_losing_d", var0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_losing_e", var0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_captureneutral_a", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_captureneutral_b", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_captureneutral_c", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_captureneutral_d", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_captureneutral_e", var0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
      setwaypointiconinfo("waypoint_contested_a", var0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
      setwaypointiconinfo("waypoint_contested_b", var0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
      setwaypointiconinfo("waypoint_contested_c", var0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1);
      setwaypointiconinfo("waypoint_contested_d", var0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1);
      setwaypointiconinfo("waypoint_contested_e", var0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1);
      setwaypointiconinfo("waypoint_dom_target_a", var0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0);
      setwaypointiconinfo("waypoint_dom_target_b", var0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0);
      setwaypointiconinfo("waypoint_dom_target_c", var0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0);
      setwaypointiconinfo("waypoint_dom_target_d", var0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0);
      setwaypointiconinfo("waypoint_dom_target_e", var0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0);
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

function ref_12443(var0) {
  if(isDefined(var0)) {
    foreach(var2 in level.players) {
      if(!isDefined(var2)) {
        continue;
      }

      var3 = var2 getentitynumber();

      if(var3 == var0) {
        if(scripts\mp\utility\game::getgametype() == "br") {
          var4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var2.team, var2.squadindex);
        } else {
          var4 = scripts\mp\utility\teams::getteamdata(var3.team, "players");
        }

        if(isDefined(var3.ref_12444)) {
          var3.ref_12444 = !var3.ref_12444;
        } else {
          var3.ref_12444 = 1;
        }

        foreach(var6 in var4) {
          if(isDefined(var6)) {
            var6 setclientomnvar("ui_br_rocket_ammo", var1);
            waitframe();
          }
        }

        if(istrue(scripts\mp\utility\game::matchmakinggame())) {
          if(isDefined(var3) && var3 isfireteamleader()) {
            var8 = var3 getfireteammembers();

            foreach(var10 in var8) {
              if(!isDefined(var10)) {
                continue;
              }

              var11 = var10 getentitynumber();

              if(var11 != var15) {
                if(isDefined(var10.ref_12444)) {
                  var10.ref_12444 = !var10.ref_12444;
                } else {
                  var10.ref_12444 = 1;
                }

                foreach(var6 in var4) {
                  if(isDefined(var6)) {
                    var6 setclientomnvar("ui_br_rocket_ammo", var11);
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

    var2 = undefined;
    var4 = undefined;
  }
}

function setupelevatordoor() {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(!scripts\mp\utility\game::privatematch() && !scripts\mp\gametypes\br_public::tutorial_playSound()) {
      var0 = [];

      foreach(var2 in level.players) {
        if(!isDefined(var2)) {
          continue;
        }

        if(isDefined(var2.ref_12444) && var2.ref_12444) {
          var3 = var2.team;
          var4 = 0;
          var5 = var0.size;

          for(var6 = 0; var6 < var5; var6++) {
            if(var0[var6] == var3) {
              var4 = 1;
            }
          }

          if(!var4) {
            var0 = var3;
            var7 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var2.team, var2.squadindex);
            var8 = [];

            foreach(var2 in var7) {
              if(!isDefined(var2)) {
                continue;
              }

              if(isDefined(var2.ref_12444) && var2.ref_12444) {
                var8 = var2;
              }
            }

            function_0427(var8);
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
  var0 = scripts\mp\utility\game::getgametype();
  level.radarhideshots = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + var0 + "_radarHidePings", "scr_game_radarHidePings");
  setomnvar("ui_compass_hide_weapon_pings_minimap", level.radarhideshots);
  level.navbarhideshots = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + var0 + "_navBarHidePings", "scr_game_navBarHidePings");
  setomnvar("ui_compass_hide_weapon_pings_navbar", level.navbarhideshots);
  level.navbarhideenemies = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + var0 + "_navBarHideEnemy", "scr_game_navBarHideEnemy");
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
    foreach(var2 in level.teamnamelist) {
      if(!isDefined(game["roundsWon"][var2])) {
        game["roundsWon"][var2] = 0;
      }

      if(!isDefined(game["teamScores"][var2])) {
        game["teamScores"][var2] = 0;
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

  foreach(var5 in level.teamnamelist) {
    level.wavedelay[var5] = 0;
    level.lastwave[var5] = 0;
    level.waveplayerspawnindex[var5] = 0;
    level.aliveplayers[var5] = [];

    if(!istrue(level.ref_12c49)) {
      level.requiredplayercount[var5] = 0;
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
    foreach(var5 in level.teamnamelist) {
      scripts\mp\gamescore::updateteamscore(var5);
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

function updatewavespawndelay(var0, var1) {
  if(isDefined(var0)) {
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay", var0);
  }

  if(isDefined(var1)) {
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay_alt", var1);
  }

  var2 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay");
  var3 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay_alt");

  if(var2) {
    foreach(var5 in level.teamnamelist) {
      level.wavedelay[var5] = var2;
      level.lastwave[var5] = 0;
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
  var0 = scripts\mp\utility\game::gettimepassed();

  while(game["state"] == "playing") {
    waittillframeend();
    thread checktimelimit(var0);
    var0 = scripts\mp\utility\game::gettimepassed();

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
        foreach(var1 in level.players) {
          var1 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var1.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var1 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var1.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {
        foreach(var1 in level.players) {
          var1 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var1.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var1 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var1.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::iswinbytworulegametype()) {
        var5 = game["roundsWon"][game["defenders"]];
        var6 = game["roundsWon"][game["attackers"]];
        var7 = 0;

        if(var5 == var6) {
          var7 = var5 + 2;
        } else if(var5 > var6) {
          var7 = var5 + 1;
        } else {
          var7 = var6 + 1;
        }

        setomnvar("ui_scorelimit", var7);
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
  var0 = level.bombtimer;

  for(;;) {
    self playSound("ui_mp_suitcasebomb_timer");

    if(var0 > 5) {
      var0 -= 1;
      wait 1;
    } else {
      var0 -= 0.5;
      wait 0.5;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function stoptickingsound() {
  self notify("stop_ticking");
}

function relic_bang_and_boom_dropfunc(var0) {
  if(var0 > 20) {
    return "ui_mp_timer_countdown";
  }

  if(var0 > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(var0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(var0 > 1.5) {
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

  var0 = spawn("script_origin", (0, 0, 0));
  var0 hide();
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["state"] == "playing") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit() && !istrue(level.bombsplanted)) {
      var5 = gettimeremaining() / 1000;
      var6 = int(var5 + 0.5);
      var7 = 0;

      if(var4 == 2 && var6 % 2 == 1) {
        var7 = 1;
      }

      if(!var1 && (var7 == 1 && var6 == 61 || var7 == 0 && var6 == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_sixty");
        level notify("match_ending_soon", "time");
        var1 = 1;
      } else if(!var2 && (var7 == 1 && var6 == 31 || var7 == 0 && var6 == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_thirty");
        var3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
        level notify("match_ending_soon", "time");
        var2 = 1;
      } else if(!var1 && !var2 && !var3 && var6 >= 30 && var6 <= 45) {
        var3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
        level notify("match_ending_soon", "time");
      }

      if(var6 <= 10 || var6 <= 30 && var6 % var4 == var7) {
        if(!var3 && var6 <= 10) {
          var3 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup", var6);
        }

        level notify("match_ending_very_soon");
        var8 = 1;

        if(var6 == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < var5) {
          var7 = 0;
        }

        if(var7) {
          var9 = relic_bang_and_boom_dropfunc(var4); <
          error > playSound(var9);
        }
      }

      if(var4 - floor(var4) >= 0.05) {
        wait var4 - floor(var4);
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

  var0 = gettime();

  while(game["state"] == "playing") {
    if(!level.timerstopped) {
      game["timePassed"] = game["timePassed"] + gettime() - var0;
    }

    var0 = gettime();
    wait 1;
  }
}

function updatetimerpausedness(var0) {
  var1 = level.timerstoppedforgamemode || isDefined(level.hostmigrationtimer);

  if(!level.timerstopped && var1) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
    var2 = gettimeremaining();

    if(isDefined(var0)) {
      setgameendtime(var0);
    } else {
      setgameendtime(gettime() + int(var2));
    }

    setomnvar("ui_match_timer_stopped", 1);
    return;
  }

  if(level.timerstopped && !var1) {
    level.timerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
    var2 = gettimeremaining();

    if(isDefined(var0)) {
      setgameendtime(var0);
    } else {
      setgameendtime(gettime() + int(var2));
    }

    setomnvar("ui_match_timer_stopped", 0);
    return;
  }
}

function pausetimer(var0) {
  if(!level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 1;
    updatetimerpausedness(var0);
    return;
  }
}

function resumetimer(var0) {
  if(level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 0;
    updatetimerpausedness(var0);
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
    foreach(var1 in level.players) {
      scripts\mp\playerlogic::clearprematchlook(var1);
      var1 scripts\mp\utility\player::_freezecontrols(0, 1);
      var1 setclientomnvar("ui_match_start_countdown", -1);
      var1 setclientomnvar("ui_match_in_progress", 1);
      var1 setmoverantilagged();

      if(scripts\mp\utility\game::getgametype() == "br") {
        var1 scripts\mp\persistence::touchedmovingplatform();
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
  var3 = scripts\mp\utility\game::gettimelimit();

  if(var3 > 0) {
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
  var0 = [];
  GscBinSkip0(0x2e, 0, getEnt("clip32x32x8", "targetname"));
}

function ref_12c4c(var0) {
  if(istrue(level.ref_121f1)) {
    return;
  }

  if(!isDefined(level.ref_121f2)) {
    level.ref_121f2 = [];
  }

  level.ref_121f2[var0] = 1;
}

function wavespawntimer() {
  level endon("game_ended");
  level notify("waveSpawnTimer");
  level endon("waveSpawnTimer");
  jumpiffalse(isDefined(level.tacopssublevel)) LOC_00000026;
  thread wavetimerwatcher();

  while(game["state"] == "playing") {
    var0 = gettime();

    foreach(var2 in level.teamnamelist) {
      if(var0 - level.lastwave[var2] > level.wavedelay[var2] * 1000) {
        level notify("wave_respawn_" + var2);
        level.lastwave[var2] = var0;
        level.waveplayerspawnindex[var2] = 0;
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
  var0 = [];
  var1 = [];

  foreach(var3 in level.teamnamelist) {
    var0 = 0;
    var1 = 0;
  }

  foreach(var6 in level.players) {
    var7 = var6.pers["team"];

    if(isDefined(var7) && scripts\mp\utility\teams::isgameplayteam(var7)) {
      var0 = var0[var7] + var6.kills;
      var1 = var1[var7] + var6.deaths;
    }
  }

  var9 = undefined;
  var10 = undefined;
  var11 = 0;
  var12 = undefined;
  var13 = undefined;
  var14 = 0;

  foreach(var3 in level.teamnamelist) {
    var16 = var0[var3];

    if(!isDefined(var9) || var16 > var9) {
      var9 = var16;
      var10 = var3;
      var11 = 0;
    } else if(var9 == var16) {
      var11 = 1;
    }

    var17 = var1[var3];

    if(!isDefined(var12) || var17 < var12) {
      var12 = var17;
      var13 = var3;
      var14 = 0;
      continue;
    }

    if(var12 == var17) {
      var14 = 1;
    }
  }

  if(!var11) {
    return var10;
  }

  if(!var14) {
    return var13;
  }

  var19 = randomint(level.teamnamelist.size);
  return level.teamnamelist[var19];
}

function rankedmatchupdates(var0) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    setxenonranks();

    if(hostidledout()) {
      level.hostforcedend = 1;
      logstring("host idled out");
      endlobby();
    }

    updatematchbonusscores(var0);
  }

  updatewinlossstats(var0);
}

function displayroundend(var0, var1, var2) {
  thread scripts\mp\music_and_dialog::round_end_music(var0, var1, var2);

  if(!level.doeomcombat && scripts\mp\utility\game::ismoddedroundgame() && game["finalRound"] == 0) {
    var0 = "roundend";
  }

  level.roundendextramessage = 0;

  if(!scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::getgametype() == "arena" && !istrue(game["practiceRound"])) {
    if(checkroundswitch(level.playovertime)) {
      level.roundendextramessage = game["round_end_exmsg"]["switching_sides"];
    }
  }

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::ref_1332b()) {
    var0 = "tie";
    var1 = game["end_reason"]["win_by_two_tie"];
    var2 = game["end_reason"]["win_by_two_tie"];
  }

  foreach(var4 in level.players) {
    if(level.teambased) {
      var4 thread scripts\mp\hud_message::teamoutcomenotify(var0, 1, var1, var2, level.roundendextramessage);
      continue;
    }

    var4 thread scripts\mp\hud_message::outcomenotify(var0, var1, var2);
  }
}

function displaygameend(var0, var1, var2) {
  setomnvar("ui_match_over", 1);

  if(scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::iswinbytworulegametype() && scripts\mp\utility\game::ref_1332b()) {
    var0 = "tie";
    var1 = game["end_reason"]["win_by_two_tie"];
    var2 = game["end_reason"]["win_by_two_tie"];
  }

  foreach(var4 in level.players) {
    if(level.teambased) {
      var4 thread scripts\mp\hud_message::teamoutcomenotify(var0, 0, var1, var2);
      continue;
    }

    var4 thread scripts\mp\hud_message::outcomenotify(var0, var1, var2);
  }
}

function displayroundswitch() {
  level notify("spawning_intermission");

  if(isDefined(level.ref_11c68)) {
    [[level.ref_11c68]]();
  }

  var0 = remove_player_from_focus_fire_attacker_list();

  foreach(var2 in level.players) {
    var2 thread scripts\mp\playerlogic::spawnintermission(var0);
  }

  var4 = level.halftimetype;

  if(var4 == "halftime") {
    if(level.roundlimit) {
      if(game["roundsPlayed"] * 2 == level.roundlimit) {
        var4 = "halftime";
      } else {
        var4 = "intermission";
      }
    } else {
      var4 = "intermission";
    }
  }

  level notify("round_switch", var4);
  var5 = 0;

  if(game["finalRound"] == 1) {
    var4 = "final_round";
  } else if(game["matchPoint"] == 1) {
    var4 = "match_point";

    if(scripts\mp\utility\game::iswinbytworulegametype() && game["roundsWon"]["allies"] == game["roundsWon"]["axis"]) {
      var4 = "win_by_two";
    }
  }

  if(isDefined(level.switchedsides)) {
    var5 = game["end_reason"]["switching_sides"];
    level.roundendextramessage = 0;

    if(var4 != "final_round" && var4 != "match_point") {
      var4 = "switching_sides";
    }
  }

  foreach(var2 in level.players) {
    var2 thread scripts\mp\hud_message::teamoutcomenotify(var4, 1, var5, var5, level.roundendextramessage);
  }

  roundendwait(level.halftimeroundenddelay, 0);
}

function freezeallplayers(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(var0 > 0 && var3) {
    thread slowmotionendofgame(var0);
  }

  thread sendgameendedfrozennotify(var0);
  var4 = scripts\mp\utility\game::updatetextongamepadchange();

  foreach(var6 in level.players) {
    var6 enableplayerbreathsystem(0);
    thread freezeplayerforroundend(var6);
    thread roundenddof(var6);
    freegameplayhudelems(var6);
    var6 setclientdvars("LQKPQMPRQN", var4, "cg_drawSpectatorMessages", 0);

    if(isDefined(var1) && isDefined(var2)) {
      if(var1 == "NSSLSNKPN" && var6 issplitscreenplayer()) {
        var6 setclientdvars(var1, 0.75);
      }

      var6 setclientdvars(var1, var2);
    }
  }

  if(isDefined(level.agentarray)) {
    foreach(var9 in level.agentarray) {
      var9 scripts\mp\utility\player::_freezecontrols(1, undefined, "freezeAllPlayers");
    }

    return;
  }
}

function endofroundvisionset(var0) {
  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  visionsetfadetoblack("bw", 0.75);
}

function slowmotionendofgame(var0) {
  setslowmotion(1, 0.4, var0);
  setendofroundsoundtimescalefactor();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
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

function sendgameendedfrozennotify(var0) {
  wait var0;
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

function endgame(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var1)) {
    logstring("[KEY_MOMENT] EndGame " + var1);
  } else {
    logstring("[KEY_MOMENT] EndGame");
  }

  if(isDefined(level.ref_11c81)) {
    var0 = level.ref_11c81;
  }

  if(isDefined(level.endgame)) {
    [[level.endgame]](var0, var1, undefined, var5);
    return;
  }

  endgame_regularmp(var0, var1, var2, var3, var4);
}

function endgame_regularmp(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(scripts\mp\utility\game::getgametype() != "br" && level.gameended) {
    return;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundEndTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  scripts\common\utility::ref_13e0a(level.ref_11b34);
  var5 = 0;

  if(level.hostforcedend || level.forcedend) {
    var5 = 1;
  }

  if(scripts\mp\utility\game::inovertime()) {
    if(game["overtimeRoundsPlayed"] == 0) {
      setmatchdata("firstOvertimeRoundIndex", game["roundsPlayed"]);
    }

    if(!var5) {
      game["overtimeRoundsPlayed"]++;
    }
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(var0)) {
      if(!var5) {
        if(isDefined(var4)) {
          game["roundsWon"][var0] = game["roundsWon"][var0] + var4;
        } else {
          game["roundsWon"][var0]++;
        }
      }

      if(!isDefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = var0;
      }
    } else {
      if(isDefined(var0) && var0 == "tie" && shouldmodescoreonties()) {
        foreach(var7 in level.teamnamelist) {
          game["roundsWon"][var7]++;
        }
      }

      if(!isDefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = "none";
      }
    }

    if(!istrue(game["practiceRound"])) {
      foreach(var7 in level.teamnamelist) {
        scripts\mp\gamescore::updateteamscore(var7);
      }

      if(scripts\mp\utility\game::isroundbased() && game["roundsPlayed"] < 24 && scripts\mp\utility\game::getgametype() != "koth") {
        setmatchdata("alliesRoundScore", game["roundsPlayed"], getteamscore("allies"));
        setmatchdata("axisRoundScore", game["roundsPlayed"], getteamscore("axis"));
      }
    }
  } else {
    if(isDefined(var0) && isPlayer(var0) && !var5) {
      game["roundsWon"][var0.guid]++;
    }

    if(!isDefined(level.finalkillcam_winner)) {
      if(!isDefined(var0) || isstring(var0) && var0 == "tie") {
        level.finalkillcam_winner = "none";
      } else {
        level.finalkillcam_winner = var0.guid;
      }
    }
  }

  scripts\mp\gamescore::updateplacement();

  if(!var5) {
    game["roundsPlayed"]++;
  }

  level.playovertime = scripts\mp\utility\game::shouldplayovertime();

  if(scripts\mp\utility\game::nextroundisfinalround()) {
    game["finalRound"] = 1;
  } else if(scripts\mp\utility\game::nextroundismatchpoint()) {
    game["matchPoint"] = 1;
  }

  if(isDefined(var0) && scripts\mp\utility\game::waslastround()) {
    var0 = checkmodeoverridetie(var0);
  }

  level.initcircuitbreakers = istrue(var3) && scripts\mp\utility\game::getgametype() == "ctf";

  if(isDefined(var0) && level.initcircuitbreakers) {
    var11 = scripts\engine\utility::ter_op(var0 == "allies", "axis", "allies");
    game["roundsWon"][var0] = 1;
    game["roundsWon"][var11] = 0;
    game["teamScores"][var0] = 1;
    game["teamScores"][var11] = 0;
    setteamscore(var0, 1);
    setteamscore(var11, 0);
  }

  var12 = endgame_endround(var0, var1, var2, var3);

  foreach(var14 in level.players) {
    if(!isbot(var14) && isDefined(var14.team) && var14.team != "spectator" && var14.team != "follower") {
      ref_119af(var14);
    }
  }

  if(var12 && scripts\mp\utility\game::waslastround()) {
    endgame_endgame(var0, var1, var2, var3);
    return;
  }
}

function shouldmodescoreonties() {
  return istrue(game["canScoreOnTie"]);
}

function checkmodeoverridetie(var0) {
  var1 = shouldmodescoreonties() && var0 == "tie";
  var2 = scripts\mp\utility\game::getgametype() == "ctf" && var0 == "tie" && !level.winrule;

  if(var1 || var2) {
    scripts\mp\gamescore::updatetotalteamscore("axis");
    scripts\mp\gamescore::updatetotalteamscore("allies");
    var3 = getteamscore("allies");
    var4 = getteamscore("axis");

    if(var3 != var4) {
      var0 = scripts\engine\utility::ter_op(var3 > var4, "allies", "axis");
    }
  }

  return var0;
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
    var0 = 0;

    if(isDefined(level.finalkillcam_winner)) {
      var0 = 1;
    }

    if(var0) {
      var0 = level scripts\mp\final_killcam::dofinalkillcam();
    }

    if(isDefined(var0) && !var0) {
      postroundfadenokillcam();
      return;
    }

    return;
  }

  if(level.potgenabled) {
    var1 = scripts\mp\potg::getcurpotgscene();

    if(isDefined(var1.primaryentity)) {
      level scripts\mp\final_killcam::dopotgkillcam();
      return;
    }

    level.finalkillcamenabled = 1;
    var0 = level scripts\mp\final_killcam::dofinalkillcam();

    if(isDefined(var0) && !var0) {
      postroundfadenokillcam();
      return;
    }

    return;
  }
}

function postroundfadenokillcam() {
  foreach(var1 in level.players) {
    if(isbot(var1)) {
      continue;
    }

    var1 thread scripts\mp\utility\game::setuipostgamefade(1, 0.1);

    if(level.gametype == "arena") {
      var1 setclientomnvar("post_game_state", 1);
    } else {
      var1 setclientomnvar("post_game_state", 2);
    }

    thread ref_1284e();
  }

  wait 0.5;
}

function ref_1284e() {
  self endon("disconnect");
  var0 = scripts\mp\playerlogic::getspectatepoint();
  self predictstreampos(var0.origin, 1);

  while(self.sessionstate != "intermission") {
    waitframe();
  }

  waitframe();
  self clearpredictedstreampos();
}

function ref_13153(var0) {
  game["state"] = "postgame";
  level notify("game_ended", var0);
  scripts\mp\flags::levelflagset("game_over");
  scripts\mp\flags::levelflagset("block_notifies");
}

function mp_vacant_patch_thread(var0) {
  if(isDefined(var0)) {
    if(var0 == 1 || var0 == 2) {
      level.apc_rus_monitordriverturretreload = 0;
      level.allow_momentum = var0;
      level notify("madeLUIDecision");
      return;
    }

    return;
  }
}

function endgame_endround(var0, var1, var2, var3) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;

  if(!isDefined(var0)) {
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
  thread scripts\mp\potg::onroundended(var0);
  thread scripts\mp\final_killcam::preloadfinalkillcam();
  level notify("cancel_announcer_dialog");

  if(scripts\mp\utility\game::isteamreviveenabled()) {
    thread scripts\mp\teamrevive::cleanuprevivetriggericons();
  }

  if(scripts\mp\utility\game::waslastround()) {
    if(scripts\mp\utility\game::getgametype() == "arena") {
      if(scripts\mp\utility\teams::isgameplayteam(var0)) {
        var4 = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var0, "players"), &compare_player_score);
      } else {
        var4 = level.placement["all"];
      }

      var5 = int(min(3, var4.size));

      foreach(var7 in level.players) {
        var8 = 0;

        for(var9 = 0; var9 < var5; var9++) {
          if(var7 == var4[var9]) {
            var8 = 1;
          }
        }

        if(var8) {
          if(var7 == var4[0]) {
            var7 scripts\cp_mp\pet_watch::bhasthermitestucktoshield();
          }
        }
      }
    }

    level notify("start_game_win_audio", var1);

    if(istrue(level.postgameexfil) && !level.forcedend) {
      if(var1 != "tie") {
        level waittill("exfil_continue_game_end");
      }
    }
  } else {
    level notify("round_end_music", var1);
  }

  if(level.doeomcombat) {
    if(istrue(level.docmdoutro)) {
      thread waitforhitmarkerspostgame();
      ref_13153(var1);
      level waittill("cmd_continue_game_end");
      setomnvarforallclients("post_game_state", 2);

      foreach(var7 in level.players) {
        if(level.teambased) {
          var7 thread scripts\mp\hud_message::teamoutcomenotify(var1, 0, var2, var3);
          continue;
        }

        var7 thread scripts\mp\hud_message::outcomenotify(var1, var2, var3);
      }

      freezeallplayers(3, "NSSLSNKPN", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
      goto LOC_000002c1;
    }

    if(level.gametype == "br") {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(var1, var2, var3);
      game["state"] = "postgame";
      level notify("game_ended", var1);
      scripts\mp\flags::levelflagset("game_over");
      scripts\mp\flags::levelflagset("block_notifies");
      waitframe();
      goto LOC_000002c1;
    }

    jumpiftrue(level.gametype == "tac_ops" && isDefined(level.tacopssublevel)) LOC_000002c1;
    thread eomcombatwaitforhitmarkersanddelaystartpostgameui(var1, var2, var3);
    freezeallplayers(2.5, "NSSLSNKPN", 1, 1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
    ref_13153(var1);
    waitframe();

    foreach(var7 in level.players) {
      var7 setclientdvar("MQNNLTKNTS", 1);

      if(scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) {
        var7 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        var7 scripts\mp\bounty::playerresetbountystreak();
      }

      var7 setclientomnvar("ui_match_in_progress", 0);
    }
  } else {
    if(!(level.gametype == "tac_ops" && isDefined(level.tacopssublevel)) && scripts\mp\utility\game::getgametype() != "br") {
      thread waitforhitmarkerspostgame();
      ref_13153(var2);
    }

    waitframe();

    foreach(var7 in level.players) {
      var7 setclientdvar("MQNNLTKNTS", 1);

      if((scripts\mp\utility\game::wasonlyround() || scripts\mp\utility\game::waslastround()) && !istrue(game["isLaunchChunk"])) {
        var7 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        var7 scripts\mp\bounty::playerresetbountystreak();
      }

      var7 setclientomnvar("ui_match_in_progress", 0);
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

  rankedmatchupdates(var2);
  setDvar("SLLNLPRON", scripts\mp\utility\game::updatetextongamepadchange());
  setDvar("ui_allow_teamchange", 0);
  setDvar("MPOKQNLPRM", 0);

  foreach(var7 in level.players) {
    var7 scripts\mp\class::loadout_clearperks();
  }

  if(istrue(game["practiceRound"]) && !istrue(level.forcedend)) {
    game["roundsPlayed"] = 0;

    foreach(var20 in level.teamnamelist) {
      game["roundsWon"][var20] = 0;
      game["teamScores"][var20] = 0;
    }

    var2 = "tie";
    var3 = game["end_reason"]["practice_round_over"];
  }

  displayroundend(var2, var3, var4);
  thread endofroundvisionset(level);

  if(!scripts\mp\utility\game::waslastround()) {
    level notify("round_win", var2);
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
      foreach(var7 in level.players) {
        var7 scripts\mp\supers::clearsuper();
        var7 scripts\mp\perks\perkpackage::perkpackage_reset();
      }
    }

    scripts\mp\flags::levelflagclear("block_notifies");
    restart();
    return false;
  } else {
    if(level.teambased) {
      foreach(var25 in level.teamnamelist) {
        scripts\mp\gamescore::updatetotalteamscore(var25);
        LOC_000005d4:
      }
    }

    if(!scripts\mp\utility\game::wasonlyround()) {
      if(!scripts\mp\utility\game::waslastround()) {
        if(level.playovertime) {
          var2 = "overtime";
          game["status"] = "overtime";
        }

        scripts\mp\flags::levelflagclear("block_notifies");
        var27 = checkroundswitch(level.playovertime);

        if(var27) {
          onroundswitch(level.playovertime);
        }

        if(var27 || game["finalRound"] == 1 || game["matchPoint"] == 1) {
          var28 = 1;

          if(scripts\mp\utility\game::getgametype() == "arena") {
            if(game["matchPoint"] == 1 && !istrue(game["displayedMatchPoint"])) {
              game["displayedMatchPoint"] = 1;
            } else if(game["finalRound"] != 1) {
              var28 = 0;
              LOC_000006a4:
            }
            LOC_000006a4:
          }

          LOC_000006a4:
            if(var28) {
              displayroundswitch();
            }
        }

        foreach(var7 in level.players) {
          var7.pers["stats"] = var7.stats;

          if(isalive(var7) && isDefined(var7.matchdatalifeindex)) {
            var7 scripts\common\utility::ref_13e0a(level.ref_11b2d, var7.matchdatalifeindex, undefined, undefined, "MOD_ROUND_ENDED", "none", undefined, undefined, undefined);
          }
        }

        restart();
        return false;
      }

      if(!level.forcedend) {
        var7 = updateroundendreasontext(var7);
      }
    }
  }

  return true;
}

function tacopsroundendwait(var0, var1) {
  var2 = 0;

  while(!var2) {
    var3 = level.players;
    var2 = 1;

    foreach(var5 in var3) {
      if(!var5 scripts\mp\hud_message::isdoingsplash()) {
        continue;
      }

      var2 = 0;
    }

    wait 0.5;
  }

  foreach(var5 in level.players) {
    var5 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  wait var0;
  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

function compare_player_score(var0, var1) {
  return var0.score >= var1.score;
}

function endgame_endgame(var0, var1, var2, var3) {
  spawnscriptable();
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.music_timer_10seconds = var0;

  if(scripts\mp\gametypes\br_public::tutorial_playSound() && !level.forcedend) {
    level.apc_rus_monitordriverturretreload = 1;
    level scripts\common\ui::lui_registercallback("exit_squad_eliminated", &mp_vacant_patch_thread);
  }

  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level.ref_132fe) && [[level.ref_132fe]]()) {
    createnavobstaclebyshape();
  }

  if(!istrue(level.processedwinloss) && (istrue(level.forfeitinprogress) || level.forcedend)) {
    updatewinlossstats(var0);
  }

  scripts\cp\vehicles\vehicle_compass_cp::roundend(var0);
  checkforpersonalbests();
  updatespmstats();
  scripts\mp\persistence::writebestscores();
  level notify("stop_leaderboard_stats");
  updateleaderboardstats();
  level scripts\mp\accolades::obj_riverbed();
  level.doingbroshot = scripts\mp\broshot::initbroshot(var0);
  var4 = scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("endGameIntermission");

  if(!level.doingbroshot && istrue(var4)) {
    level notify("spawning_intermission");
    var5 = remove_player_from_focus_fire_attacker_list();

    foreach(var7 in level.players) {
      var7 thread scripts\mp\utility\game::setuipostgamefade(0);

      if(!isDefined(level.ref_11c85) || !var7[[level.ref_11c85]]()) {
        var7 thread scripts\mp\playerlogic::spawnintermission(var5);
      }
    }
  }

  if(istrue(var3) && !istrue(level.nukecancel)) {
    scripts\mp\utility\player::_visionsetnaked(level.nukevisionset, 0);
    visionsetfadetoblack("", 0.75);
  } else {
    scripts\mp\utility\player::_visionsetnaked("", 0);
    visionsetfadetoblack("", 0.75);
  }

  displaygameend(var0, var1, var2);
  scripts\mp\flags::levelflagclear("block_notifies");
  level.intermission = 1;

  if(!level.doingbroshot) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();

      if(isDefined(level.multieventdebug)) {
        foreach(var7 in level.players) {
          if(!isDefined(var7)) {
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
    scripts\mp\broshot::startbroshot(var0);
    level waittill("taunts_timed_out");
    scripts\mp\broshot::endbroshot();
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(var0)) {
      setmatchdata("victor", var0);
      var11 = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata(var0, "players"), &compare_player_score);
    } else {
      setmatchdata("victor", "none");
      var11 = level.placement["all"];
    }

    setmatchdata("alliesScore", getteamscore("allies"));
    setmatchdata("axisScore", getteamscore("axis"));
  } else {
    setmatchdata("victor", "none");
    var11 = level.placement["all"];
  }

  foreach(var7 in level.players) {
    var7 setplayerdata("common", "round", "endReasonTextIndex", var3);
    var7 scripts\cp_mp\utility\game_utility::stopkeyearning(var2);

    if(isalive(var7) && isDefined(var7.matchdatalifeindex)) {
      var7 scripts\common\utility::ref_13e0a(level.ref_11b2d, var7.matchdatalifeindex, undefined, undefined, "MOD_GAME_ENDED", "none", undefined, undefined, undefined);
    }

    var13 = int(min(3, var11.size));
    var14 = 0;

    for(var15 = 0; var15 < var13; var15++) {
      if(var7 == var11[var15]) {
        var14 = 1;
      }
    }

    if(var14) {
      var7 scripts\cp_mp\pet_watch::addwatchchargewintop3();
    }

    if(level.teambased) {
      if(scripts\mp\utility\teams::isgameplayteam(var2)) {
        if(isDefined(var7.team)) {
          if(var7.team == var2) {
            var7 logplayerendmatchdatamatchresult(var7.clientid, "win");
            var7 scripts\cp_mp\pet_watch::addwatchchargewin();
          } else {
            var7 logplayerendmatchdatamatchresult(var7.clientid, "loss");
          }
        } else {
          var7 logplayerendmatchdatamatchresult(var7.clientid, "none");
        }
      } else if(scripts\mp\utility\game::allteamstied()) {
        var7 logplayerendmatchdatamatchresult(var7.clientid, "draw");
      } else {
        var7 logplayerendmatchdatamatchresult(var7.clientid, "none");
      }
    } else if(isPlayer(var2) && var2.clientid == var7.clientid) {
      var7 logplayerendmatchdatamatchresult(var7.clientid, "win");
      var7 scripts\cp_mp\pet_watch::addwatchchargewin();
    } else {
      var7 logplayerendmatchdatamatchresult(var7.clientid, "loss");
    }

    var7 scripts\common\utility::ref_13e0a(level.ref_11b2c);
  }

  scripts\common\utility::ref_13e0a(level.ref_11b35);

  if(getdvarint("TLRPKRKMS") != 0) {
    if(isgamebattlematch()) {
      foreach(var7 in level.players) {
        var18 = var7 getxuid();
        var19 = var7.team;
        var20 = var7 scripts\mp\utility\stats::getpersstat("score");
        setgamebattlematchstats(var18, var19, var20);
      }

      var22 = level.mapname;
      var23 = scripts\mp\utility\game::getgametype();
      var24 = getmatchdata("victor");
      var25 = getteamscore("allies");
      var26 = getteamscore("axis");
      var27 = scripts\mp\matchdata::getmatchstarttimeutc();
      var28 = scripts\mp\matchdata::getmatchendtimeutc();
      requestgamelobbyremainintact(var22, var23, var24, var25, var26, var27, var28);
    }
  }

  ref_1301f();
  function_042a();

  foreach(var7 in level.players) {
    var7.pers["stats"] = var7.stats;
  }

  if(getdvarint("post_game_play_again_enabled", 1) == 0) {
    wait 1;
  } else if(istrue(game["isLaunchChunk"])) {
    wait 1;
  } else if(!var11 && !level.postgamenotifies) {
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

  settournamentwinner(var2);
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

    foreach(var19 in level.teamnamelist) {
      game["roundsWon"][var19] = 0;
      game["teamScores"][var19] = 0;
      setteamscore(var19, int(0));
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

function settournamentwinner(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!level.teambased) {
    logtournamentdeath(var0);
    return;
  } else if(var0 != "allies" && var0 != "axis") {
    var1 = scripts\mp\utility\teams::getteamdata("allies", "players");
    var2 = scripts\mp\utility\teams::getteamdata("axis", "players");

    if(var1.size == 0) {
      var0 = "axis";
    } else if(var2.size == 0) {
      var0 = "allies";
    } else {
      var0 = getbetterteam();
    }
  }

  logtournamentdeath(var0);
}

function waitforhitmarkerspostgame() {
  wait level.ref_127fe;
  level notify("post_game_ui_start");
  setomnvarforallclients("post_game_state", 1);
}

function eomcombatwaitforhitmarkersanddelaystartpostgameui(var0, var1, var2) {
  wait level.ref_127fe;
  level notify("post_game_ui_start");

  if(scripts\mp\utility\game::getgametype() != "br") {
    setomnvarforallclients("post_game_state", 2);
  }

  foreach(var4 in level.players) {
    if(level.teambased) {
      var4 thread scripts\mp\hud_message::teamoutcomenotify(var0, 0, var1, var2);
      continue;
    }

    var4 thread scripts\mp\hud_message::outcomenotify(var0, var1, var2);
  }
}

function remove_player_from_focus_fire_attacker_list() {
  var0 = undefined;

  switch (level.mapname) {
    case "mp_village2":
      var0 = spawnStruct();
      var0.origin = (1478, -3039, 981);
      var0.angles = (388.74, 144.97, 0);
      break;
    case "mp_backlot2":
      var0 = spawnStruct();
      var0.origin = (1835, 1347, 749);
      var0.angles = (361, 224, 0);
      break;
    case "mp_hideout":
      var0 = spawnStruct();
      var0.origin = (-871, -1578, 458);
      var0.angles = (6, 65, 0);
      break;
  }

  if(scripts\mp\utility\game::getgametype() == "brtdm") {
    var0 = spawnStruct();
    var0.origin = level.endsuperdisableweaponbr.ref_136dc.origin;
    var0.angles = level.endsuperdisableweaponbr.ref_136dc.angles;
  }

  return var0;
}

function eomcamerapullout(var0) {
  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  foreach(var2 in level.players) {
    if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var2 scripts\common\utility::allow_ads(0);
    var3 = var2 getEye() + (0, 0, 100) + anglesToForward(var2.angles) * -100;
    var4 = spawn("script_model", var3);
    var4 setModel("tag_origin");
    var4.angles = var2.angles;
    var2.spawncameraent = var4;
    var5 = var2 getEye();
    var6 = var2.angles;
    var7 = var3 + (0, 0, 5000);
    var7 += anglesToForward(var6) * -100;
    var2 cameralinkTo(var2.spawncameraent, "tag_origin", 1, 1);
    var2.spawncameraent moveTo(var7, 5, 4, 0.1);
    var8 = vectorNormalize(var5 - var4.origin);
    var9 = scripts\mp\utility\script::vectortoanglessafe(var8, (0, 0, 1));
    var2.spawncameraent.angles = var9;
    thread lookatplayerupdate(var2);
    wait 2;
    var2 visionsetnakedforplayer("respawn_camera", 2);
  }
}

function lookatplayerupdate(var0) {
  self endon("disconnect");
  self endon("lookAtPlayerUpdate_stop");

  for(;;) {
    var1 = self getEye();
    var2 = vectorNormalize(var1 - self.spawncameraent.origin);
    var3 = scripts\mp\utility\script::vectortoanglessafe(var2, (0, 0, 1));
    self.spawncameraent rotateTo(var3, 0.75);
    waitframe();
  }
}

function updateroundendreasontext(var0) {
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

function estimatedtimetillscorelimit(var0) {
  if(!scripts\mp\utility\game::ismoddedroundgame()) {
    var1 = getscoreperminute(var0);
    var2 = getscoreremaining(var0);
    var3 = 999999;

    if(var1) {
      var3 = var2 / var1;
    }

    return var3;
  }

  var1 = getscoreperminute(var3);
  var2 = getscoreperminute(var3);
  var3 = 999999;

  if(var1) {
    var3 = var2 / var1;
  }

  return var3;
}

function closetoscorelimit(var0) {
  var1 = 10;
  var2 = 20;
  var3 = level.roundscorelimit;

  switch (scripts\mp\utility\game::getgametype()) {
    case "tdef":
    case "dom":
      var2 = 20;
      break;
    case "conf":
      var2 = 10;
    case "arm":
      var2 = var3 * 0.1;
      break;
    default:
      break;
  }

  var4 = getteamscore(var0);
  var5 = var3 - var4;

  if(var5 <= scripts\engine\utility::ter_op(istrue(game["finalRound"]), var2, var1)) {
    return true;
  }

  return false;
}

function getscoreperminute(var0) {
  var1 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;

  if(isPlayer(self)) {
    var2 = self.score / var1;
  } else {
    var2 = getteamscore(var1) / var2;
  }

  return var2;
}

function getscoreremaining(var0) {
  var1 = level.roundscorelimit;

  if(isPlayer(self)) {
    var2 = var1 - self.score;
  } else {
    var2 -= getteamscore(var1);
  }

  return var2;
}

function getscoreperminuteroundbased(var0) {
  var1 = level.roundscorelimit;

  if(!game["switchedsides"]) {
    var1 /= 2;
    var2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var3 = getteamscore(var0) / var2;
  } else {
    var3 = int(var3 / 2);
    var2 = scripts\mp\utility\game::gettimepassed() / 60000 + 0.0001;
    var4 = getteamscore(var2);

    if(var4 >= var3) {
      var3 = (var4 - var3) / var2;
    } else {
      return 0;
    }
  }

  return var3;
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "inform_last_one");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);

  foreach(var1 in level.teamnamelist) {
    if(self.pers["team"] != var1) {
      thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var1);
    }
  }

  level notify("last_alive", self);
}

function processlobbydata() {
  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    ref_128af(var1);
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

function cargo_truck_mg_explode(var0) {
  if(isDefined(var0) && !isDefined(var0.clientmatchdataid)) {
    var0.clientmatchdataid = level.initship;
    level.initship++;
    return;
  }
}

function ref_128af(var0) {
  if(istrue(var0.ref_128af)) {
    return;
  }

  var0.ref_128af = 1;
  cargo_truck_mg_explode(var0);
  var1 = var0.name;

  if(getdvarint("MTKSQRQLKN") != 0) {
    setclientmatchdata("players", var0.clientmatchdataid, "clanTag", var0 getclantag());
    setclientmatchdata("players", var0.clientmatchdataid, "xuidHigh", var0 getxuidhigh());
    setclientmatchdata("players", var0.clientmatchdataid, "xuidLow", var0 getxuidlow());
    setclientmatchdata("players", var0.clientmatchdataid, "isBot", isbot(var0));
    setclientmatchdata("players", var0.clientmatchdataid, "uniqueClientId", var0.clientid);
    setclientmatchdata("players", var0.clientmatchdataid, "username", var1);
    setclientmatchdata("players", var0.clientmatchdataid, "nameSuffix", var0 method_87d2());

    if(var0 isps4player()) {
      setclientmatchdata("players", var0.clientmatchdataid, "platform", "ps4");
    } else if(var0 isxb3player()) {
      setclientmatchdata("players", var0.clientmatchdataid, "platform", "xb3");
    } else if(var0 ispcplayer()) {
      setclientmatchdata("players", var0.clientmatchdataid, "platform", "bnet");
    } else {
      setclientmatchdata("players", var0.clientmatchdataid, "platform", "none");
    }
  }

  var0 setplayerdata("common", "round", "clientMatchIndex", var0.clientmatchdataid);
  var0 scripts\mp\scoreboard::setplayerscoreboardinfo();
  var2 = tolower(getDvar("mapname"));
  var0 setplayerdata("common", "round", "gameMode", scripts\mp\utility\game::getgametype());
  var0 setplayerdata("common", "round", "map", var2);
  scripts\mp\matchdata::ref_13154(var0);
}

function trackleaderboarddeathstats(var0, var1, var2, var3) {
  thread threadedsetweaponstatbyname(var1, var2, 1);
  thread threadedsetweaponstatbyname(var1, var2, distancesquared(var0.origin, var1.origin));
}

function trackattackerleaderboarddeathstats(var0, var1, var2, var3) {
  if(isDefined(var0) && isPlayer(var0)) {
    if(var3 != "MOD_FALLING") {
      if(var3 == "MOD_MELEE" && issubstr(var2, "tactical")) {
        var0 scripts\common\utility::ref_13e0a(level.ref_11b25, "tactical", "kills", 1, var2);
        var0 scripts\common\utility::ref_13e0a(level.ref_11b25, "tactical", "hits", 1, var2);
        var0 scripts\mp\persistence::incrementattachmentstat("tactical", "kills", 1, var2);
        var0 scripts\mp\persistence::incrementattachmentstat("tactical", "hits", 1, var2);
        return;
      }

      if(var3 == "MOD_MELEE" && !scripts\mp\riotshield::isriotshield(var2) && !scripts\mp\utility\weapon::isknifeonly(var2) && !scripts\mp\utility\weapon::turret_aimed_at_last_known(var2) && !scripts\mp\utility\weapon::isaxeweapon(var2)) {
        var0 scripts\common\utility::ref_13e0a(level.ref_11b25, "none", "kills", 1, var2);
        var0 scripts\common\utility::ref_13e0a(level.ref_11b25, "none", "hits", 1, var2);
        var0 scripts\mp\persistence::incrementattachmentstat("none", "kills", 1, var2);
        var0 scripts\mp\persistence::incrementattachmentstat("none", "hits", 1, var2);
        return;
      }

      thread threadedsetweaponstatbyname(var0, var2, 1);
      thread threadedsetweaponstatbyname(var0, var2, distancesquared(var0.origin, var1.origin));
    }

    if(var3 == "MOD_HEAD_SHOT") {
      thread threadedsetweaponstatbyname(var0, var2, 1);
      return;
    }

    return;
  }
}

function setweaponstat(var0, var1, var2) {
  if(!var1) {
    return;
  }

  var3 = undefined;

  if(issameweapon(var0)) {
    var3 = var0;
  } else {
    var3 = asmdevgetallstates(var0);
  }

  if(isDefined(var3.ref_121d9)) {
    var3 = var3.ref_121d9;
  }

  if(!isDefined(level.get_audio_approved_length_extender_for_non_english_vo)) {
    level.get_audio_approved_length_extender_for_non_english_vo = scripts\mp\utility\game::getgametype() == "br" && getdvarint("scr_track_picked_up_weapon_stats", 1) == 1;
  }

  if(scripts\mp\utility\weapon::ispickedupweapon(var3) && !istrue(level.get_audio_approved_length_extender_for_non_english_vo)) {
    return;
  }

  var4 = var3.basename;
  var5 = scripts\mp\utility\weapon::getweapongroup(var3);
  var6 = getweaponvariantindex(var3);

  if(var5 == "super") {
    var7 = scripts\mp\supers::shouldtracksuperweaponstats(var3);

    if(isDefined(var7) && !var7) {
      return;
    }
  }

  if(var5 == "killstreak" || var5 == "other" && var4 != "trophy_mp" || var5 == "other" && var4 != "player_trophy_system_mp" || var5 == "other" && var4 != "super_trophy_mp") {
    return;
  }

  if(scripts\mp\utility\weapon::isenvironmentweapon(var3)) {
    return;
  }

  if(var5 == "weapon_grenade" || var5 == "weapon_explosive" || var4 == "trophy_mp" || var4 == "forcepush_mp") {
    var4 = scripts\mp\utility\script::strip_suffix(var4, "_mp");
    scripts\mp\persistence::incrementweaponstat(var4, var2, var1);
    scripts\common\utility::ref_13e0a(level.ref_11b31, var4, var2, var1, var6, var3);
    return;
  }

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = var3;
  }

  if(var3 != self.trackingweapon) {
    scripts\mp\persistence::updateweaponbufferedstats(var3);
    self.trackingweapon = var3;
  }

  switch (var2) {
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

  if(var2 == "deaths") {
    var8 = undefined;
    var9 = scripts\mp\utility\weapon::getweaponrootname(var3);

    if(!scripts\mp\utility\weapon::iscacprimaryweapon(var9) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var9)) {
      return;
    }

    var10 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var3);
    scripts\mp\persistence::incrementweaponstat(var9, var2, var1);
    scripts\common\utility::ref_13e0a(level.ref_11b31, var9, "deaths", var1, var6, var3);

    foreach(var12 in var10) {
      scripts\mp\persistence::incrementattachmentstat(var12, var2, var1, var3);
      scripts\common\utility::ref_13e0a(level.ref_11b25, var12, var2, var1, var3);
    }

    return;
  }
}

function setinflictorstat(var0, var1, var2) {
  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(var0)) {
    setweaponstat(var1, var2, 1, "hits");
    return;
  }

  if(!isDefined(var0.playeraffectedarray)) {
    var0.playeraffectedarray = [];
  }

  var3 = 1;

  for(var4 = 0; var4 < var0.playeraffectedarray.size; var4++) {
    if(var0.playeraffectedarray[var4] == self) {
      var3 = 0;
      break;
    }
  }

  if(var3) {
    var0.playeraffectedarray[var0.playeraffectedarray.size] = self;
    setweaponstat(var1, var2, 1, "hits");
    return;
  }
}

function threadedsetweaponstatbyname(var0, var1, var2) {
  self endon("disconnect");

  if(!isPlayer(self) && !isagent(self)) {
    return;
  }

  waittillframeend();
  setweaponstat(var0, var1, var2);
}

function updatespmstats() {
  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    if(var1 scripts\mp\utility\game::onlinestatsenabled()) {
      var2 = getmatchspm(var1);
      var3 = scripts\engine\utility::ter_op(level.teambased, var1.score, var1.pers["gamemodeScore"]);
      var4 = var1 getplayerdata("mp", "globalSPM");
      var5 = var1 scripts\mp\playerstats_interface::getplayerstat("matchStats", "gamesPlayed");
      var4 *= var5 - 1;
      var6 = var2;

      if(var5 > 0) {
        var6 = (var4 + var2) / var5;
      }

      var1 setplayerdata("mp", "globalSPM", int(var6));
      var7 = getgametypeindex(scripts\mp\utility\game::getgametype());
      var8 = 5;
      var9 = 32;

      if(var7 >= 0 && var7 < var9) {
        for(var10 = 0; var10 < 4; var10++) {
          var11 = var1 getplayerdata("mp", "gameModeHistory", var10 + 1);
          var1 setplayerdata("mp", "gameModeHistory", var10, var11);
        }

        var1 setplayerdata("mp", "gameModeHistory", 4, scripts\mp\utility\game::getgametype());
        var12 = var1 getplayerdata("mp", "gameModeScoreHistory", var7, "index");
        var1 setplayerdata("mp", "gameModeScoreHistory", var7, "scores", var12, int(var2));
        var1 setplayerdata("mp", "gameModeScoreHistory", var7, "actualScores", var12, int(var3));
        var1 setplayerdata("mp", "gameModeScoreHistory", var7, "gameMode", scripts\mp\utility\game::getgametype());
        var12 = (var12 + 1) % var8;
        var1 setplayerdata("mp", "gameModeScoreHistory", var7, "index", var12);
      }
    }
  }
}

function checkforpersonalbests() {
  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    if(var1 scripts\mp\utility\game::onlinestatsenabled()) {
      var2 = var1 getplayerdata("common", "round", "kills");
      var3 = var1 getplayerdata("common", "round", "deaths");
      var4 = var1.pers["summary"]["xp"];
      var5 = var1 scripts\mp\playerstats_interface::getplayerstat("bestStats", "killsInAMatch");
      var6 = var1 scripts\mp\playerstats_interface::getplayerstat("bestStats", "deathsInAMatch");
      var7 = var1 scripts\mp\playerstats_interface::getplayerstat("bestStats", "xpInAMatch");
      var8 = var1 getplayerdata("mp", "bestSPM", "score");
      var9 = var1 getplayerdata("mp", "bestKD", "score");

      if(var2 > var5) {
        var1 scripts\mp\playerstats_interface::setplayerstat(var2, "bestStats", "killsInAMatch");
      }

      if(var4 > var7) {
        var1 scripts\mp\playerstats_interface::setplayerstat(var4, "bestStats", "xpInAMatch");
      }

      if(var3 > var6) {
        var1 scripts\mp\playerstats_interface::setplayerstat(var3, "bestStats", "deathsInAMatch");
      }

      var10 = var2;

      if(var3 > 1) {
        var10 /= var3;
      }

      var10 = int(var10 * 1000);

      if(var10 > var9) {
        var1 setplayerdata("mp", "bestKD", "score", var10);
        var1 setplayerdata("mp", "bestKD", "time", getsystemtime());
      }

      var11 = getmatchspm(var1);

      if(var11 > var8) {
        var1 setplayerdata("mp", "bestSPM", "score", int(var11));
        var1 setplayerdata("mp", "bestSPM", "time", getsystemtime());
      }

      checkforbestweapon(var1);
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

  for(var0 = 0;; var0++) {
    while(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
    }

    if(var0 >= level.players.size) {
      var0 = 0;
    }

    var1 = level.players[var0];

    if(!isDefined(var1) || isai(var1)) {
      waitframe();
      continue;
    }

    ref_14008(var1);
    wait 0.1;
  }
}

function updateleaderboardstats() {
  if(!brking_addtoc130infil()) {
    return;
  }

  foreach(var1 in level.players) {
    if(!isDefined(var1) || isai(var1)) {
      continue;
    }

    ref_14008(var1);
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
    var0 = "hc_";
  } else {
    var0 = "";
  }

  var0 += scripts\mp\utility\game::getgametype();

  switch (var0) {
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

function generate_randomized_primary_weapon_objs(var0) {
  return isDefined(var0) && (var0 == "dmz" || var0 == "rat_race" || var0 == "risk" || var0 == "kingslayer" || var0 == "rumble" || var0 == "payload" || var0 == "carpoc" || var0 == "gold_war");
}

function ref_14008() {
  var0 = undefined;

  if(level.hardcoremode) {
    var0 = "hc_";
  } else {
    var0 = "";
  }

  var0 += scripts\mp\utility\game::getgametype();

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
        var0 += "_" + level.disable_super_in_turret.name;
        break;
      case "gold_war":
        var0 += "_dmz";
        break;
      case "olaride":
      case "rebirth_dbd_reverse":
      case "rebirth_dbd":
      case "rebirth_reverse":
        var0 += "_rebirth";
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

  var1 = scripts\engine\utility::ter_op(level.teambased, self.score, self.watchvehicleingas["gamemodeScore"]);
  incrementleaderboardstat("score", var0, var1);
  var2 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  incrementleaderboardstat("timePlayed", var0, var2);
  incrementleaderboardstat("kills", var0, self.watchvehicleingas["kills"]);
  incrementleaderboardstat("deaths", var0, self.watchvehicleingas["deaths"]);

  switch (scripts\mp\utility\game::getgametype()) {
    case "war":
      incrementleaderboardstat("assists", var0, self.watchvehicleingas["assists"]);
      break;
    case "arena":
      incrementleaderboardstat("damage", var0, self.watchvehicleingas["damage"]);
      incrementleaderboardstat("assists", var0, self.watchvehicleingas["assists"]);
      break;
    case "arm":
      incrementleaderboardstat("captures", var0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var0, self.watchvehicleingas["defends"]);
      break;
    case "cyber":
      incrementleaderboardstat("revives", var0, self.watchvehicleingas["rescues"]);
      incrementleaderboardstat("plants", var0, self.watchvehicleingas["plants"]);
      break;
    case "dm":
      updateleaderboardstatmaximum("streak", var0, self.watchvehicleingas["killChains"]);
      break;
    case "dom":
      incrementleaderboardstat("captures", var0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var0, self.watchvehicleingas["defends"]);
      break;
    case "sd":
      incrementleaderboardstat("plants", var0, self.watchvehicleingas["plants"]);
      incrementleaderboardstat("defuses", var0, self.watchvehicleingas["defuses"]);
      break;
    case "conf":
      incrementleaderboardstat("confirms", var0, self.watchvehicleingas["confirmed"]);
      incrementleaderboardstat("denies", var0, self.watchvehicleingas["denied"]);
      break;
    case "hq":
      incrementleaderboardstat("captures", var0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var0, self.watchvehicleingas["defends"]);
      break;
    case "koth":
      incrementleaderboardstat("objTime", var0, self.watchvehicleingas["objTime"]);
      incrementleaderboardstat("defends", var0, self.watchvehicleingas["defends"]);
      break;
    case "ctf":
      incrementleaderboardstat("captures", var0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("returns", var0, self.watchvehicleingas["returns"]);
      break;
    case "sr":
      incrementleaderboardstat("plants", var0, self.watchvehicleingas["plants"]);
      incrementleaderboardstat("rescues", var0, self.watchvehicleingas["rescues"]);
      break;
    case "siege":
      incrementleaderboardstat("captures", var0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("revives", var0, self.watchvehicleingas["rescues"]);
      break;
    case "grind":
      incrementleaderboardstat("banks", var0, self.watchvehicleingas["confirmed"]);
      incrementleaderboardstat("denies", var0, self.watchvehicleingas["denied"]);
      break;
    case "infect":
      incrementleaderboardstat("time", var0, scripts\mp\utility\stats::getpersstat("extrascore0"));
      incrementleaderboardstat("infected", var0, self.watchvehicleingas["killsAsInfected"]);
      break;
    case "gun":
      incrementleaderboardstat("stabs", var0, self.watchvehicleingas["stabs"]);
      incrementleaderboardstat("setBacks", var0, self.watchvehicleingas["setbacks"]);
      break;
    case "grnd":
      incrementleaderboardstat("objTime", var0, self.watchvehicleingas["objTime"]);
      incrementleaderboardstat("defends", var0, self.watchvehicleingas["defends"]);
      break;
    case "cmd":
      incrementleaderboardstat("assists", var0, self.watchvehicleingas["assists"]);
      incrementleaderboardstat("captures", var0, self.watchvehicleingas["captures"]);
      incrementleaderboardstat("defends", var0, self.watchvehicleingas["defends"]);
      break;
    case "pill":
      incrementleaderboardstat("banks", var0, self.watchvehicleingas["confirmed"]);
      incrementleaderboardstat("denies", var0, self.watchvehicleingas["denied"]);
      break;
    case "br":
      incrementleaderboardstat("downs", var0, self.watchvehicleingas["downs"]);
      incrementleaderboardstat("contracts", var0, self.watchvehicleingas["contracts"]);
      incrementleaderboardstat("wins", var0, self.watchvehicleingas["wins"]);
      incrementleaderboardstat("topFive", var0, self.watchvehicleingas["topFive"]);
      incrementleaderboardstat("topTen", var0, self.watchvehicleingas["topTen"]);
      incrementleaderboardstat("topTwentyFive", var0, self.watchvehicleingas["topTwentyFive"]);
      incrementleaderboardstat("gamesPlayed", var0, self.watchvehicleingas["gamesPlayed"]);
      incrementleaderboardstat("revives", var0, self.watchvehicleingas["rescues"]);
      incrementleaderboardstat("cash", var0, self.watchvehicleingas["cash"]);
      incrementleaderboardstat("objTime", var0, self.watchvehicleingas["objTime"]);
      break;
  }
}

function incrementleaderboardstat(var0, var1, var2) {
  if(!isDefined(self.leaderboardstartvalues)) {
    self.leaderboardstartvalues = [];
  }

  if(!isDefined(self.leaderboardstartvalues[var0])) {
    self.leaderboardstartvalues[var0] = self getplayerdata("mp", "playerStats", "modeStats", var1, var0);
  }

  var3 = int(max(self.leaderboardstartvalues[var0] + var2, self.leaderboardstartvalues[var0]));
  self setplayerdata("mp", "playerStats", "modeStats", var1, var0, var3);
}

function updateleaderboardstatmaximum(var0, var1, var2) {
  var3 = self getplayerdata("mp", "playerStats", "modeStats", var1, var0);

  if(var2 > var3) {
    self setplayerdata("mp", "playerStats", "modeStats", var1, var0, var2);
    return;
  }
}

function getmatchspm(var0) {
  var1 = scripts\engine\utility::ter_op(level.teambased, var0.score, var0.pers["gamemodeScore"]);
  var2 = var0 scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

  if(isDefined(var2) && var2 > 0) {
    var3 = var2 / 60;
    var1 /= var3;
  }

  return var1;
}

function isvalidbestweapon(var0) {
  var1 = scripts\mp\utility\weapon::getweapongroup(var0);
  return isDefined(var0) && var0 != "" && !scripts\mp\utility\weapon::iskillstreakweapon(var0) && var1 != "killstreak" && var1 != "other";
}

function checkforbestweapon() {
  var0 = scripts\common\utility::ref_13e0a(level.ref_11b23);
  var1 = "";
  var2 = -1;

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];
    var4 = scripts\mp\utility\weapon::getweaponrootname(var4);

    if(isvalidbestweapon(var4)) {
      if(!isenumvaluevalid("mp", "WeaponStats", var4)) {
        continue;
      }

      var5 = self getplayerdata("mp", "playerStats", "weaponStats", var4, "kills");

      if(var5 > var2) {
        var1 = var4;
        var2 = var5;
      }
    }
  }

  var6 = self getplayerdata("mp", "playerStats", "weaponStats", var1, "shots");
  var7 = self getplayerdata("mp", "playerStats", "weaponStats", var1, "headShots");
  var8 = self getplayerdata("mp", "playerStats", "weaponStats", var1, "hits");
  var9 = self getplayerdata("mp", "playerStats", "weaponStats", var1, "deaths");
  var10 = 0;
  self setplayerdata("mp", "bestWeapon", "kills", var2);
  self setplayerdata("mp", "bestWeapon", "shots", var6);
  self setplayerdata("mp", "bestWeapon", "headShots", var7);
  self setplayerdata("mp", "bestWeapon", "hits", var8);
  self setplayerdata("mp", "bestWeapon", "deaths", var9);
  self setplayerdata("mp", "bestWeaponXP", var10);
  var11 = int(tablelookup("mp/statstable.csv", 4, var1, 0));
  self setplayerdata("mp", "bestWeaponIndex", var11);
}

function allow_weapon_mp(var0) {
  self notify("allow_weapon_mp()");

  if(var0) {
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
    self waittill("weapon_switch_invalid", var0);
    self.allowweaponcache = var0;
  }
}

function ismp_init() {
  level.ismp = 1;
}

function ref_144bf(var0) {
  if(!istrue(level.ref_11a5d)) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  level endon("start_prematch");
  var1 = getdvarint("live_lobby_consider_loading_clients", 1);
  var2 = -1;
  var3 = gettime();

  for(;;) {
    var4 = getdvarint("live_lobby_lowpop_min", 50);
    var5 = getdvarfloat("live_lobby_lowpop_time", 300) * 1000;
    var6 = scripts\engine\utility::ter_op(var0, getactiveclientcount(var1), level.players.size);

    if(var2 >= 0) {
      var7 = var2 + var5;

      if(var6 >= var4 && gettime() >= var7 && !istrue(level.devoverridematchstart)) {
        break;
      }
    } else if(var6 >= var4) {
      var2 = gettime();
    }

    waitframe();
  }

  var8 = getdvarint("live_lobby_lowpop_max", 100);
  var6 = scripts\engine\utility::ter_op(var0, getactiveclientcount(var1), level.players.size);

  if(var6 <= var8) {
    level.ref_11a5e = 1;
    var9 = gettime() - var3;
    var10 = getdvarfloat("live_lobby_lowpop_time", 300);
    getentitylessscriptablearray("dlog_event_low_pop_start", ["start_players", var6, "wait_time_ms", var9, "active_client_count", var0, "lowpop_min", var4, "lowpop_max", var8, "lowpop_time", var10]);

    if(isDefined(level.ref_12056)) {
      [[level.ref_12056]]();
    }
  }

  level notify("start_prematch");
}

function watchforminplayersmatchstart() {
  level endon("start_prematch");
  var0 = getdvarint("live_lobby_consider_loading_clients", 1);
  var1 = gettime();
  var2 = var1;
  var3 = getdvarint("live_lobby_minplayers_start");

  if(var3 != 0) {
    for(;;) {
      if(istrue(level.devoverridematchstart)) {
        break;
      }

      var4 = (var2 - var1) / 1000;
      var5 = getdvarint("live_lobby_max_time", 300);

      if(var5 > 0 && var4 >= var5) {
        break;
      }

      if(var4 <= getdvarint("live_lobby_grace_period", 15)) {
        if(getactiveclientcount(0) >= getdvarint("live_lobby_minplayers_start")) {
          break;
        }
      } else if(getactiveclientcount(var0) >= getdvarint("live_lobby_minplayers_start")) {
        break;
      }

      waitframe();
      var2 = gettime();
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
  var0 = getEntArray("start_lobby_trigger", "targetname");
  thread waitforoverridematchstartdvar();
  thread waitforoverridematchstartnotify();

  if(var0.size == 0) {
    thread waitforinitialplayerloadspawnflag();
    return;
  }

  foreach(var2 in var0) {
    if(isDefined(var2.target)) {
      var3 = getEnt(var2.target, "targetname");
    } else {
      var3 = spawn("script_model", var2.origin);
      var3[0].angles = var2.angles;
    }

    var4 = scripts\mp\gameobjects::createuseobject("neutral", var2, var3, (0, 0, 64), undefined, 1);
    var4 scripts\mp\gameobjects::allowuse("any");
    var4.id = "use";
    var4.trigger setuseprioritymax();
    var4 scripts\mp\gameobjects::setusetime(3);
    var4 scripts\mp\gameobjects::setusehinttext(&"MP_INGAME_ONLY/HOLD_TO_START_GAME");
    var4.onuse = &startbutton_onuse;
    level.startbuttons[level.startbuttons.size] = var4;
  }
}

function waitforinitialplayerloadspawnflag() {
  level endon("game_ended");
  level endon("start_prematch");
  level waittill("connected", var0);
  var0 waittill("giveLoadout");
  waitframe();
  GscBinSkip1(0x45, 0, spawn("script_model", var0.origin));
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

function startbutton_onuse(var0) {
  var0 setclientomnvar("ui_securing", 0);
  dev_forcelivelobbystart();
}

function dev_forcelivelobbystart() {
  level thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured");

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\print::teamhudtutorialmessage("MP_INGAME_ONLY/GAME_FORCE_STARTED", var1, 10);
  }

  setDvar("br_minplayers", 1);
  setDvar("live_lobby_minplayers_start", 1);
  level notify("start_prematch");

  foreach(var4 in level.startbuttons) {
    var4 scripts\mp\gameobjects::allowuse("none");
    var4.trigger = undefined;
    var4.visibleteam = "none";
    var4.flagmodel delete();
    var4 notify("deleted");
  }

  level notify("dev_force_start_completed");
}

function livelobbyroundendwait(var0, var1) {
  foreach(var3 in level.players) {
    var3 thread scripts\mp\utility\game::setuipostgamefade(0);
  }

  wait var0;
  level notify("round_end_finished");
}

function livelobbymatchstarttimer(var0, var1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var2 = int(var1);

  if(var2 >= 2) {
    setomnvar("ui_match_start_text", var0);
    var3 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";
    matchstarttimerperplayer_internal(var2, var3);
  }

  visionsetnaked("", 0);
}

function clearmatchhasmorethan1playervariablesonroundend() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

function updatematchhasmorethan1playeromnvaronplayersfirstspawn() {
  var0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1) {
      game["matchHasMoreThan1Player"] = 1;
    }
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!var0) {
      for(var1 = 0; var1 < level.players.size; var1++) {
        level.players[var1] setclientomnvar("match_has_more_than_1_player", 1);
      }

      return;
    }

    self setclientomnvar("match_has_more_than_1_player", 1);
    return;
  }
}

function updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  var0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]--;

  if(game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] <= 1) {
      game["matchHasMoreThan1Player"] = 0;
    }
  }

  if(!game["matchHasMoreThan1Player"]) {
    if(var0) {
      for(var1 = 0; var1 < level.players.size; var1++) {
        level.players[var1] setclientomnvar("match_has_more_than_1_player", 0);
      }

      return;
    }

    return;
  }
}

function ref_12c14() {
  wait 10;
  var0 = [];
  GscBinSkip0(0x2e, 1, "tactical_ladder_col");
}

function reinforcement_icon_objective_id() {
  return 9;
}

function getintorzero() {
  level.allowsupers = getdvarint("scr_" + scripts\mp\utility\game::round_vehicle_logic() + "_allowSupers", level.allowsupers);
}

function ref_119ae() {
  foreach(var1 in level.players) {
    if(isPlayer(var1)) {
      scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var1, "damageDone", var1 scripts\mp\utility\stats::getpersstat("damage"));
    }
  }
}

function ref_119af(var0) {
  if(!isDefined(var0) || !isDefined(var0.team)) {
    return;
  }

  if(!istrue(level.teambased) || istrue(level.multiteambased)) {
    return;
  }

  var1 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var2 = var0.team;
  var3 = level.teamnamelist[0];

  if(var2 == var3) {
    var3 = level.teamnamelist[1];
  }

  var4 = getteamscore(var2);
  var5 = getteamscore(var3);
  var6 = 0;

  if(isDefined(var0.isbecomingzombie)) {
    var6 = var0.isbecomingzombie;
  }

  var0 dlog_recordplayerevent("dlog_event_end_of_round", ["time_from_match_start", var1, "player_team_name", var2, "enemy_team_name", var3, "player_team_score", var4, "enemy_team_score", var5, "damage_this_round", var6]);
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

function ref_12767(var0, var1, var2) {
  self setclientomnvar("ui_br_bink_overlay_state", 12);
  self setsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
  scripts\mp\utility\player::_freezecontrols(1);
  self setclientdvar("LQKPQMPRQN", 0);
  var3 = getDvar("LKTPRPKPMR");
  var4 = getDvar("LOSOOOTNMS");
  var5 = getDvar("NNMLSMNTOQ");
  setDvar("LKTPRPKPMR", 1);
  setDvar("LOSOOOTNMS", 1);
  setDvar("NNMLSMNTOQ", -1);
  self preloadcinematicforplayer(var0, 1, var2);
  var6 = gettime();
  ref_133dd(var6, var1 * 1000);
  self skydive_cutparachuteoff();
  scripts\mp\utility\player::restorebasevisionset(0);
  self setclientdvar("LQKPQMPRQN", scripts\mp\utility\game::updatetextongamepadchange());
  setDvar("voiceProximityTeam", var3);
  setDvar("voiceProximityEnemy", var4);
  setDvar("voiceProximityRadius", var5);
  scripts\mp\utility\player::_freezecontrols(0);
  self setclientomnvar("ui_br_bink_overlay_state", 0);
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted3", 0.5);
}

function ref_133dd(var0, var1) {
  self endon("disconnect");
  wait 2;
  var2 = gettime();
  var3 = 0;

  while(gettime() - var0 < var1 && gettime() - var2 < 1000) {
    waitframe();

    if(self useButtonPressed()) {
      if(!var3) {
        var3 = 1;
      }

      continue;
    }

    var3 = 0;
    var2 = gettime();
  }
}