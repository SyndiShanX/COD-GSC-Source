init() {
  replacefunc(maps\mp\gametypes\_gamelogic::endgame, ::endgame_stub);
  replacefunc(maps\mp\gametypes\_gamescore::giveplayerscore, ::giveplayerscore_stub);
  replacefunc(maps\mp\gametypes\_gamescore::_setteamscore, ::_setteamscore_stub);
  replacefunc(maps\mp\gametypes\_gamescore::giveteamscoreforobjective, ::giveteamscoreforobjective_stub);
}

endgame_stub(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 0;

  if(game["state"] == "postgame" || level.gameended || (isDefined(level.nukeIncoming) && !var_2) && (!isDefined(level.gtnw) || !level.gtnw)) {
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
  var_3 = maps\mp\gametypes\_gamelogic::getgameduration();
  setomnvar("ui_game_duration", var_3 * 1000);
  maps\mp\_utility::setgameplayactive(0);
  waitframe();
  setgameendtime(0);
  setmatchdata("gameLengthSeconds", var_3);
  setmatchdata("endTimeUTC", getsystemtime());
  maps\mp\gametypes\_gamelogic::checkgameendchallenges();

  if(isdefined(var_0) && isstring(var_0) && maps\mp\_utility::isovertimetext(var_0)) {
    level.finalkillcam_winner = "none";
    level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
    maps\mp\gametypes\_gamelogic::endgameovertime(var_0, var_1);
    return;
  }

  if(isdefined(var_0) && isstring(var_0) && var_0 == "halftime") {
    level.finalkillcam_winner = "none";
    level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
    maps\mp\gametypes\_gamelogic::endgamehalftime(var_1);
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
  maps\mp\gametypes\_gamelogic::rankedmatchupdates(var_0);
  maps\mp\gametypes\_gamelogic::handlekillstreaksonroundswitch(1);

  setdvar("g_deadChat", 1);
  setdvar("ui_allow_teamchange", 0);
  setdvar("bg_compassShowEnemies", 0);
  maps\mp\gametypes\_gamelogic::freezeallplayers(1.0, 1);
  var_7 = game["switchedsides"];

  if(!maps\mp\_utility::wasonlyround() && !var_2) {
    maps\mp\gametypes\_gamelogic::displayroundend(var_0, var_1);

    if(isdefined(level.finalkillcam_winner)) {
      foreach(var_5 in level.players)
      var_5 notify("reset_outcome");

      level notify("game_cleanup");
      maps\mp\gametypes\_gamelogic::waittillfinalkillcamdone();
    }

    if(!maps\mp\_utility::waslastround()) {
      maps\mp\_utility::levelflagclear("block_notifies");

      if(maps\mp\gametypes\_gamelogic::checkroundswitch())
        maps\mp\gametypes\_gamelogic::displayroundswitch(var_7);

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
      var_1 = maps\mp\gametypes\_gamelogic::updateendreasontext(var_0);
  }

  if(!isdefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp/clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
  }

  maps\mp\gametypes\_missions::roundend(var_0);
  var_0 = maps\mp\gametypes\_gamelogic::getgamewinner(var_0, 1);

  if(level.teambased) {
    setomnvar("ui_game_victor", 0);

    if(var_0 == "allies")
      setomnvar("ui_game_victor", 2);
    else if(var_0 == "axis")
      setomnvar("ui_game_victor", 1);
  }

  maps\mp\gametypes\_gamelogic::displaygameend(var_0, var_1);
  var_12 = gettime();

  if(isdefined(level.finalkillcam_winner) && maps\mp\_utility::wasonlyround()) {
    foreach(var_5 in level.players)
    var_5 notify("reset_outcome");

    level notify("game_cleanup");
    maps\mp\gametypes\_gamelogic::waittillfinalkillcamdone();
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

  maps\mp\gametypes\_gamelogic::processlobbydata();
  maps\mp\_skill::process();
  wait 1.0;
  maps\mp\gametypes\_gamelogic::checkforpersonalbests();
  maps\mp\gametypes\_gamelogic::updatecombatrecord();

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
  maps\mp\gametypes\_gamelogic::recordendgamecomscoreevent(var_19);

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

giveplayerscore_stub(var_0, var_1, var_2) {
  if(isDefined(level.nukeIncoming)) {
    return;
  }
  if(isdefined(var_1.owner))
    var_1 = var_1.owner;

  if(!isplayer(var_1)) {
    return;
  }
  var_1 maps\mp\gametypes\_gamescore::displaypoints(var_0);
  var_3 = var_1.pers["score"];
  maps\mp\gametypes\_gamescore::onplayerscore(var_0, var_1, var_2);
  var_4 = var_1.pers["score"] - var_3;

  if(var_4 == 0) {
    return;
  }
  if(var_1.pers["score"] < 65535)
    var_1.score = var_1.pers["score"];

  if(level.teambased) {
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "score", var_1.score);
    var_1 maps\mp\gametypes\_persistence::statadd("score", var_4);
  }

  if(!level.teambased) {
    level thread maps\mp\gametypes\_gamescore::sendupdateddmscores();
    var_1 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
  }

  var_1 maps\mp\gametypes\_gamelogic::checkscorelimit();
}

_setteamscore_stub(var_0, var_1) {
  if(isDefined(level.nukeIncoming)) {
    return;
  }
  if(var_1 == game["teamScores"][var_0]) {
    return;
  }
  game["teamScores"][var_0] = var_1;
  maps\mp\gametypes\_gamescore::updateteamscore(var_0);

  if(maps\mp\_utility::inovertime() && !isdefined(level.overtimescorewinoverride) || isdefined(level.overtimescorewinoverride) && !level.overtimescorewinoverride)
    thread maps\mp\gametypes\_gamelogic::onscorelimit();
  else {
    thread maps\mp\gametypes\_gamelogic::checkteamscorelimitsoon(var_0);
    thread maps\mp\gametypes\_gamelogic::checkscorelimit();
  }
}

giveteamscoreforobjective_stub(var_0, var_1) {
  if(isDefined(level.nukeIncoming)) {
    return;
  }
  var_1 *= level.objectivepointsmod;
  maps\mp\gametypes\_gamescore::_setteamscore(var_0, maps\mp\gametypes\_gamescore::_getteamscore(var_0) + var_1);
  level notify("update_team_score", var_0, maps\mp\gametypes\_gamescore::_getteamscore(var_0));
  thread maps\mp\gametypes\_gamescore::giveteamscoreforobjectiveendofframe();
}