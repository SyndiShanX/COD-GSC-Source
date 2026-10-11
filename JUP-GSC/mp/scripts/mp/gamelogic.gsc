/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gamelogic.gsc
***********************************************/

#using script_1070be3357c9454c;
#using script_15de7dc4d21f1da3;
#using script_15eddb0fac236a22;
#using script_180407b61054c278;
#using script_404f1aef8aea990;
#using script_436add9de781cdfb;
#using script_44b8991c2b01716a;
#using script_45f403e1732217d3;
#using script_4a6760982b403bad;
#using script_4bac13d511590220;
#using script_4cdabcd91a92977;
#using script_509d466932bca53e;
#using script_548072087c9fd504;
#using script_697b7ae06ba9b28c;
#using script_6981400abfcd765c;
#using script_6a522b6159eb03da;
#using script_6ad351ebd5a33280;
#using script_cbb0697de4c5728;
#using scripts\common\callbacks;
#using scripts\common\dof;
#using scripts\common\elevators;
#using scripts\common\feature_init;
#using scripts\common\shellshock_utility;
#using scripts\common\telemetry;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\auto_ascender;
#using scripts\cp_mp\auto_ascender_solo;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\killstreaks\init;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\team_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\accolades;
#using scripts\mp\ammorestock;
#using scripts\mp\analyticslog;
#using scripts\mp\arbitrary_up;
#using scripts\mp\archetypes\archcommon;
#using scripts\mp\awards;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\bounty;
#using scripts\mp\brclientmatchdata;
#using scripts\mp\brmatchdata;
#using scripts\mp\callouts;
#using scripts\mp\class;
#using scripts\mp\clientmatchdata;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\damage;
#using scripts\mp\deathicons;
#using scripts\mp\door;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\final_killcam;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\focus;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gamestaterestore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\control;
#using scripts\mp\gametypes\war;
#using scripts\mp\gametypes\wm_ending;
#using scripts\mp\gestures_mp;
#using scripts\mp\hostmigration;
#using scripts\mp\hud;
#using scripts\mp\hud_message;
#using scripts\mp\hud_popup;
#using scripts\mp\hud_util;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\juggernaut;
#using scripts\mp\killcam;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\laststand;
#using scripts\mp\leagueplay;
#using scripts\mp\lightarmor;
#using scripts\mp\load;
#using scripts\mp\loot;
#using scripts\mp\matchdata;
#using scripts\mp\matchstats;
#using scripts\mp\meatshield;
#using scripts\mp\menus;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\online_event;
#using scripts\mp\outline;
#using scripts\mp\outofbounds;
#using scripts\mp\passives;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\persistence;
#using scripts\mp\playercards;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats;
#using scripts\mp\playerstats_interface;
#using scripts\mp\potg;
#using scripts\mp\rank;
#using scripts\mp\scoreboard;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\serversettings;
#using scripts\mp\shellshock;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;
#using scripts\mp\teams;
#using scripts\mp\turret;
#using scripts\mp\tweakables;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\player_frame_update_aggregator;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;
#using scripts\mp\utility\weapon;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;
#using scripts\mp\whizby;
#namespace gamelogic;

function onforfeit(team) {
  if(isDefined(level.forfeitinprogress)) {
    return;
  }

  level endon("abort_forfeit");
  level thread forfeitwaitforabort();
  level.forfeitinprogress = 1;
  level.canprocessot = 0;

  if(!level.teambased && level.players.size > 1) {
    wait 10;
  } else {
    wait 1.05;
  }

  level.forfeit_aborted = 0;
  forfeit_delay = 20;
  matchforfeittimer(forfeit_delay);
  endreason = &"";

  if(!isDefined(team)) {
    endreason = game["end_reason"]["players_forfeited"];
    winner = level.players[0];
  } else {
    forfeitteam = ter_op(team == "allies", "axis", "allies");
    var_e1d3d0b9f06bb6a4 = scripts\mp\utility\teams::getfaction(forfeitteam);
    endreason = game["end_reason"][tolower(var_e1d3d0b9f06bb6a4) + "_forfeited"];
    winner = team;

    if(istrue(level.leagueplaymatch)) {
      game["roundsWon"][winner] = ter_op(isroundbased(), getscorelimit(), 1);
      game["roundsWon"][forfeitteam] = 0;
      game["teamScores"][winner] = getscorelimit();
      game["teamScores"][forfeitteam] = 0;
      setteamscore(winner, 1);
      setteamscore(forfeitteam, 0);
    }
  }

  level.forcedend = 1;

  if(isDefined(winner)) {
    if(isPlayer(winner)) {
      logstring("forfeit, win: " + winner getxuid() + "(" + winner.name + ")");
    } else {
      logstring("forfeit, win: " + winner);

      foreach(entry in level.teamnamelist) {
        logstring(entry + ":" + game["teamScores"][entry]);
      }
    }
  }

  thread endgame(winner, endreason);
}

function forfeitwaitforabort() {
  level endon("game_ended");

  if(getdvarfloat(@ "hash_739bbd49f9779978") == 1) {
    level.disableforfeit = 1;
    level notify("abort_forfeit");
  } else {
    level waittill("abort_forfeit");
  }

  level.forfeit_aborted = 1;
  level.canprocessot = 1;

  foreach(p in level.players) {
    p setclientomnvar("ui_match_start_countdown", 0);
    p setclientomnvar("ui_match_in_progress", 1);
  }
}

function matchforfeittimer_internal(counttime) {
  waittillframeend();
  level endon("match_forfeit_timer_beginning");

  while(counttime > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod) {
    foreach(p in level.players) {
      p setclientomnvar("ui_match_start_countdown", counttime);
      p setclientomnvar("ui_match_in_progress", 0);
    }

    counttime--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  foreach(p in level.players) {
    p setclientomnvar("ui_match_start_countdown", 0);
    p setclientomnvar("ui_match_in_progress", 1);
  }
}

function matchforfeittimer(duration) {
  level notify("match_forfeit_timer_beginning");
  counttime = int(duration);
  setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  matchforfeittimer_internal(counttime);
}

function default_ondeadevent(team) {
  logstring("team eliminated: " + team);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    foreach(player in getteamdata(team, "players")) {
      result = undefined;

      if(istrue(player scripts\mp\utility\stats::getpersstat("hasDoneAnyCombat")) || istrue(player scripts\mp\utility\stats::getpersstat("participation"))) {
        result = "eliminated";
      }

      player scripts\cp_mp\utility\game_utility::stopkeyearning(result);
    }

    playerendmatch();
    function_53f71c9dbfe19ce9(team);
  }

  if(team == "all" && getgametype() == "warrior") {
    return;
  }

  if(team == "all") {
    logstring("tie");

    foreach(entry in level.teamnamelist) {
      logstring(entry + ": " + game["teamScores"][entry]);
    }

    if(level.teambased) {
      thread endgame("tie", game["end_reason"]["tie"]);
    } else {
      thread endgame(undefined, game["end_reason"]["tie"]);
    }

    return;
  }

  enemyteams = getenemyteams(team);
  livescount = [];

  foreach(entry in enemyteams) {
    livescount[entry] = 0;
  }

  if(!istrue(level.disablespawning)) {
    foreach(entry in enemyteams) {
      foreach(player in getteamdata(entry, "players")) {
        if(!istrue(player.hasspawned)) {
          continue;
        }

        livescount[entry] += player scripts\mp\utility\stats::getpersstat("lives");
      }
    }
  }

  remainingteams = [];

  foreach(entry in enemyteams) {
    alivecount = getteamdata(entry, "aliveCount");
    assert(alivecount >= 0);
    uibotcount = 0;

    if(isDefined(level.var_7b37b2193f163b9b)) {
      uibotcount = getteamdata(entry, "UIBotCount");
      assert(uibotcount >= 0);
    }

    if(alivecount > 0 || uibotcount > 0 || livescount[entry]) {
      remainingteams[remainingteams.size] = entry;
    }
  }

  var_947925f5fc6939a3 = 1;

  if(isDefined(level.var_947925f5fc6939a3)) {
    var_947925f5fc6939a3 = [[level.var_947925f5fc6939a3]]();
  }

  if(remainingteams.size == 1 && !scripts\mp\gametypes\br::function_a587b0b0998c6d13() && var_947925f5fc6939a3) {
    thread endgame(remainingteams[0], game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
  }
}

function default_ononeleftevent(team) {
  if(level.teambased) {
    assert(array_contains(level.teamnamelist, team));
    lastplayer = getlastlivingplayer(team);

    if(isDefined(lastplayer)) {
      lastplayer thread givelastonteamwarning();
    }
  } else {
    lastplayer = getlastlivingplayer();
    logstring("last one alive, win: " + lastplayer.name);
    thread endgame(lastplayer, game["end_reason"]["enemies_eliminated"]);
  }

  return true;
}

function roundend_checkscorelimit(team, allowtie) {
  checkteamscorelimitsoon(team);
  scorelimittext = "score_limit_reached";

  if(isDefined(level.var_4817bac75a8b9eff)) {
    scorelimittext = level.var_4817bac75a8b9eff;
  }

  if(istrue(allowtie)) {
    level notify("roundEnd_CheckScoreLimit");
    level endon("roundEnd_CheckScoreLimit");
    waitframe();
  }

  wingamebytype = getwingamebytype();

  if(inovertime() || intimetobeat()) {
    if(istimetobeatrulegametype()) {
      if(settimetobeat(team)) {
        foreach(player in level.players) {
          player setclientomnvar("ui_friendly_time_to_beat", ter_op(player.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          player setclientomnvar("ui_enemy_time_to_beat", ter_op(player.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        thread endgame(team, game["end_reason"][scorelimittext]);
      }
    } else if(isscoretobeatrulegametype()) {} else {
      thread endgame(team, game["end_reason"][scorelimittext]);
    }
  } else if(level.roundscorelimit > 0) {
    var_fd63d90025d110ed = [];

    if(getgametype() == "ballmode") {
      var_fd63d90025d110ed[0] = team;
    } else {
      foreach(entry in level.teamnamelist) {
        if(game["teamScores"][entry] >= level.roundscorelimit) {
          var_fd63d90025d110ed[var_fd63d90025d110ed.size] = entry;
        }
      }
    }

    if(var_fd63d90025d110ed.size > 0) {
      if(var_fd63d90025d110ed.size > 1) {
        highestscore = 0;
        highestteam = undefined;
        var_ca17acb9ea3fa61d = 0;

        foreach(entry in var_fd63d90025d110ed) {
          teamscore = game["teamScores"][entry];

          if(!isDefined(highestteam)) {
            highestscore = teamscore;
            highestteam = entry;
            var_ca17acb9ea3fa61d = 0;
            continue;
          }

          if(teamscore > highestscore) {
            highestscore = teamscore;
            highestteam = entry;
            var_ca17acb9ea3fa61d = 0;
            continue;
          }

          if(teamscore == highestscore) {
            var_ca17acb9ea3fa61d = 1;
          }
        }

        if(var_ca17acb9ea3fa61d) {
          if(isDefined(level.onscorelimit)) {
            [[level.onscorelimit]]("tie");
          }

          thread endgame("tie", game["end_reason"][scorelimittext]);
        } else {
          if(isDefined(level.onscorelimit)) {
            [[level.onscorelimit]](highestteam);
          }

          thread endgame(highestteam, game["end_reason"][scorelimittext]);
        }
      } else {
        if(isDefined(level.onscorelimit)) {
          [[level.onscorelimit]](var_fd63d90025d110ed[0]);
        }

        thread endgame(var_fd63d90025d110ed[0], game["end_reason"][scorelimittext]);
      }
    }
  }

  level notify("roundEnd_CheckScoreLimit_finished");
}

function default_ontimelimit() {
  winner = "tie";

  if(level.teambased) {
    if(inovertime() || intimetobeat()) {
      if(isscoretobeatrulegametype()) {
        score = game["overtimeProgress"] + game["overtimeProgressFrac"];
        winner = setscoretobeat(game["attackers"], score * 60);
      } else if(istimetobeatvalid()) {
        winner = game["timeToBeatTeam"];
      }
    } else if(getgametype() == "warrior") {
      winner = "tie";
    } else {
      winner = scripts\mp\gamescore::gethighestscoringteam();
    }

    logstring("time limit, win: " + winner);

    foreach(entry in level.teamnamelist) {
      logstring(entry + ":" + game["teamScores"][entry]);
    }
  } else {
    winner = scripts\mp\gamescore::gethighestscoringplayer();

    if(scripts\mp\gamescore::ishighestscoringplayertied()) {
      winner = "tie";
    }

    if(isDefined(winner) && isPlayer(winner)) {
      logstring("time limit, win: " + winner.name);
    } else {
      logstring("time limit, tie");
    }
  }

  thread endgame(winner, game["end_reason"]["time_limit_reached"]);
}

function default_onhalftime() {
  winner = undefined;
  thread endgame("halftime", game["end_reason"]["time_limit_reached"]);
}

function forceend(reason) {
  if(level.hostforcedend || level.forcedend) {
    return;
  }

  scripts\mp\gamescore::updateplacement();

  if(level.teambased) {
    foreach(entry in level.teamnamelist) {
      scripts\mp\gamescore::updatetotalteamscore(entry);
    }
  }

  winner = undefined;

  if(level.teambased) {
    winner = scripts\mp\gamescore::gethighestscoringteam();
    logstring("host ended game, win: " + winner);

    foreach(entry in level.teamnamelist) {
      logstring(entry + ":" + game["teamScores"][entry]);
    }
  } else {
    winner = scripts\mp\gamescore::gethighestscoringplayer();

    if(isDefined(winner)) {
      logstring("host ended game, win: " + winner.name);
    } else {
      logstring("host ended game, tie");
    }
  }

  level.forcedend = 1;
  level.hostforcedend = 1;

  if(level.splitscreen) {
    endstring = game["end_reason"]["ended_game"];
  } else {
    endstring = game["end_reason"]["host_ended_game"];
  }

  if(isDefined(reason) && reason == 2) {
    if(level.teambased) {
      if(winner == "allies") {
        endreason = game["end_reason"]["spetsnaz_forfeited"];
      } else {
        endreason = game["end_reason"]["marines_forfeited"];
      }
    } else {
      endreason = game["end_reason"]["players_forfeited"];
    }
  } else if(istrue(level.leagueplaymatch) && istrue(level.leagueplaymatchcancelled)) {
    winner = "tie";
    endstring = game["end_reason"]["lp_match_cancelled"];
  }

  level notify("force_end");
  thread endgame(winner, endstring);
}

function onscorelimit(allowtie) {
  scoretext = game["end_reason"]["score_limit_reached"];
  winner = "tie";

  if(level.teambased) {
    winner = scripts\mp\gamescore::calculatewinningteam();

    if(winner == "none") {
      winner = "tie";
    }

    logstring("scorelimit, win: " + winner);

    foreach(entry in level.teamnamelist) {
      logstring(entry + ":" + game["teamScores"][entry]);
    }
  } else {
    winner = scripts\mp\gamescore::gethighestscoringplayer();

    if(istrue(allowtie) && scripts\mp\gamescore::ishighestscoringplayertied()) {
      winner = "tie";
    }

    if(isDefined(winner) && isPlayer(winner)) {
      logstring("scorelimit, win: " + winner.name);
    } else {
      logstring("scorelimit, tie");
    }

    nukecost = winner scripts\mp\killstreaks\killstreaks::calcstreakcost("nuke");

    if(getscorelimit() == nukecost && winner.pers["cur_kill_streak"] == nukecost) {
      level.modescorewinner = winner;
      dvarhash = function_3514ae5d09f47ed2("timeLimit");
      level.starttime = gettime();
      level.discardtime = 0;
      level.timerpausetime = 0;
      level.watchdvars[dvarhash].value = 30;
      level.overridewatchdvars[dvarhash] = 30;
      level.dontendonscore = 1;
      return;
    }
  }

  if(isDefined(level.onscorelimit)) {
    [[level.onscorelimit]](winner);
  }

  thread endgame(winner, scoretext);
  return 1;
}

function updategameevents() {
  totalplayers = 0;
  level.teamswithplayers = [];

  foreach(team in level.teamnamelist) {
    teamcount = getteamdata(team, "teamCount");
    totalplayers += teamcount;

    if(teamcount) {
      level.teamswithplayers[level.teamswithplayers.size] = team;
    }
  }

  if(matchmakinggame() && !gameflag("prematch_done")) {
    return;
  }

  if(matchmakinggame() && !level.ingraceperiod && (!isDefined(level.disableforfeit) || !level.disableforfeit)) {
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
      playercount = 0;

      foreach(entry in level.teamnamelist) {
        playercount += getteamdata(entry, "teamCount");
      }

      if(playercount == 1 && level.maxplayercount > 1) {
        thread onforfeit();
        return;
      }

      if(playercount > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(level.teamswithplayers.size == 1 && (istrue(level.br_debugsolotest) || !scripts\cp_mp\utility\game_utility::isbrstylegametype())) {
    return;
  }

  if(!getgametypenumlives() && (!isDefined(level.disablespawning) || !level.disablespawning)) {
    return;
  }

  if(!gamehasstarted()) {
    return;
  }

  if(level.ingraceperiod && !isDefined(level.overrideingraceperiod)) {
    return;
  }

  if(level.teambased) {
    livescount = [];

    foreach(entry in level.teamnamelist) {
      livescount[entry] = 0;
    }

    foreach(player in level.players) {
      if(!istrue(player.hasspawned) || player.team == "spectator" || player.team == "codcaster" || player.team == "free") {
        continue;
      }

      livescount[player.team] += player scripts\mp\utility\stats::getpersstat("lives");
    }

    if(istrue(level.disablespawning)) {
      foreach(entry in level.teamnamelist) {
        livescount[entry] = 0;
      }
    }

    var_4351d3695cbe4fd7 = 0;

    foreach(entry in level.teamnamelist) {
      if(getteamdata(entry, "aliveCount")) {
        var_4351d3695cbe4fd7 = 1;
        break;
      }
    }

    haslivescount = 0;

    foreach(count in livescount) {
      if(count) {
        haslivescount = 1;
        break;
      }
    }

    if(!var_4351d3695cbe4fd7 && !haslivescount) {
      if(istrue(level.postgameexfil) && level.gameended) {
        level notify("exfil_continue_game_end");
      }

      if(istrue(level.nukeinfo.incoming)) {
        return;
      }

      if(shouldmodelognotify() && game["roundsPlayed"] == 0) {
        logstring("IWH-315293: GIBBERFISH: onDeadEvent - all");
      }

      return [[level.ondeadevent]]("all");
    }

    foreach(entry in level.teamnamelist) {
      if(!getteamdata(entry, "aliveCount") && !livescount[entry]) {
        if(istrue(level.postgameexfil) && level.gameended) {
          level notify("exfil_continue_game_end");
        }

        if(!istrue(level.skipondeadevent)) {
          if(istrue(level.nukeinfo.incoming)) {
            return;
          }

          if(level.multiteambased) {
            if(!getteamdata(entry, "deathEvent") && getteamdata(entry, "hasSpawned")) {
              if(shouldmodelognotify() && game["roundsPlayed"] == 0) {
                logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry MultiteamBased");
              }

              setteamdata(entry, "deathEvent", 1);
              [[level.ondeadevent]](entry);
            }

            continue;
          }

          if(shouldmodelognotify() && game["roundsPlayed"] == 0) {
            logstring("IWH-315293: GIBBERFISH: onDeadEvent - entry Team based");
          }

          return [[level.ondeadevent]](entry);
        }
      }
    }

    foreach(entry in level.teamnamelist) {
      var_a27052041bc3242b = getteamdata(entry, "aliveCount");

      if(var_a27052041bc3242b == 1 || var_a27052041bc3242b == 2 || getbasegametype() == "control") {
        teammatelives = 0;
        return_val = undefined;
        players = getteamdata(entry, "players");
        aliveplayers = [];

        foreach(player in players) {
          if(!isalive(player)) {
            teammatelives += player scripts\mp\utility\stats::getpersstat("lives");
            continue;
          }

          aliveplayers[aliveplayers.size] = player;
        }

        if(var_a27052041bc3242b != 1) {
          setteamdata(entry, "oneLeft", 0);
        }

        var_129ccb16298ea627 = 0;

        if(getbasegametype() == "control") {
          livescount = getteamdata(entry, "livesCount");
          alivecount = getteamdata(entry, "aliveCount");
          total_lives = livescount + alivecount;

          if(total_lives == 1 && level.numteamlives != 0) {
            var_129ccb16298ea627 = 1;
          }
        } else if(teammatelives == 0) {
          var_129ccb16298ea627 = 1;
        }

        if(var_129ccb16298ea627) {
          if(var_a27052041bc3242b == 1 && !getteamdata(entry, "oneLeft") && gettime() > getteamdata(entry, "oneLeftTime") + 5000) {
            setteamdata(entry, "oneLeftTime", gettime());
            setteamdata(entry, "oneLeft", 1);

            if(players.size > 1) {
              [[level.ononeleftevent]](entry);
            }
          }
        }

        continue;
      }

      setteamdata(entry, "oneLeft", 0);
    }

    return;
  }

  livescount = 0;

  foreach(player in level.players) {
    if(player.team == "spectator" || player.team == "codcaster") {
      continue;
    }

    livescount += player scripts\mp\utility\stats::getpersstat("lives");
  }

  alivecounttotal = 0;

  foreach(entry in level.teamnamelist) {
    alivecounttotal += getteamdata(entry, "aliveCount");
  }

  if(!alivecounttotal && !livescount) {
    if(istrue(level.nukeinfo.incoming)) {
      return;
    }

    return [[level.ondeadevent]]("all");
  }

  liveplayers = getpotentiallivingplayers();

  if(liveplayers.size == 1) {
    return [[level.ononeleftevent]]("all");
  }
}

function timelimitclock_intermission(waittime) {
  setgameendtime(gettime() + int(waittime * 1000));
  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();

  if(waittime >= 10) {
    wait waittime - 10;
  }

  for(;;) {
    clockobject playSound("ui_mp_timer_countdown");
    wait 1;
  }
}

function waitforplayers(maxtime, var_c8c8535645d45985, var_4670fd6135253c34) {
  starttime = gettime();

  if(istrue(game["isLaunchChunk"])) {
    mintime = 0;
  } else if(maxtime > 5) {
    mintime = gettime() + getdvarint(@ "hash_4e2f47a7b2856857") * 1000;
  } else {
    mintime = 0;
  }

  if(var_4670fd6135253c34) {
    var_26cd2fe9d9c7396a = max(1, level.connectingplayers);
  } else {
    var_26cd2fe9d9c7396a = max(1, level.connectingplayers / 2);
  }

  if(getsubgametype() == "dmz" || getsubgametype() == "exgm" || getsubgametype() == "ob") {
    var_26cd2fe9d9c7396a = level.connectingplayers;
  }

  scripts\mp\flags::gameflagwait("infil_setup_complete");
  var_7d3c76f0163532bd = 0;
  var_dc74b0012af15741 = 0;

  while(true) {
    if(istrue(game["roundsPlayed"]) && !scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
      break;
    }

    var_d2a0f17e8e173e01 = level.maxplayercount;
    var_b7652eea48ae3d62 = getstreamedinplayercount();

    if(!var_7d3c76f0163532bd) {
      if(var_b7652eea48ae3d62 > 0) {
        starttime = gettime();
        var_7d3c76f0163532bd = 1;
      } else {
        waitframe();
        continue;
      }
    }

    curtime = gettime();
    var_54ab13ac8f1a59cd = var_d2a0f17e8e173e01 >= var_26cd2fe9d9c7396a;
    var_fd915e8bd20b6d09 = 0;

    if(isDefined(level.var_fd915e8bd20b6d09)) {
      var_fd915e8bd20b6d09 = [[level.var_fd915e8bd20b6d09]]();
    } else {
      var_fd915e8bd20b6d09 = var_b7652eea48ae3d62 >= var_26cd2fe9d9c7396a;
    }

    if(var_fd915e8bd20b6d09) {
      foreach(entry in level.teamnamelist) {
        if(!checkrequiredteamcount(entry)) {
          var_54ab13ac8f1a59cd = 0;
          break;
        }
      }
    }

    foreach(entry in level.teamnamelist) {
      if(!checkrequiredteamstreamcount(entry)) {
        if(getgametype() == "arena" && !var_dc74b0012af15741) {
          setomnvar("ui_match_start_text", "waiting_for_teams");
        }

        var_fd915e8bd20b6d09 = 0;
        break;
      }
    }

    endtime = starttime + level.prematchperiod * 1000 - 200;

    if(scripts\mp\flags::gameflag("infil_will_run") || istrue(var_c8c8535645d45985)) {
      if(var_fd915e8bd20b6d09 && curtime > mintime || curtime > endtime) {
        break;
      }
    } else if(var_fd915e8bd20b6d09 && var_54ab13ac8f1a59cd && curtime > mintime || curtime > endtime) {
      break;
    }

    waitframe();
  }

  totaltime = gettime() - starttime;
  println("<dev string:x1c>" + totaltime + "<dev string:x38>");
}

function function_d084af239c9a23c(duration, var_c8c8535645d45985) {
  if(istrue(game["roundsPlayed"])) {
    return;
  }

  starttime = gettime();
  endtime = starttime + duration * 1000;
  mintime = gettime() + getdvarint(@ "hash_4e2f47a7b2856857") * 1000;
  var_26cd2fe9d9c7396a = level.requiredplayercount["allies"] + level.requiredplayercount["axis"];
  var_7d3c76f0163532bd = 0;
  cancelmatch = 0;
  loadoutsforced = 0;
  lastprinttime = 0;

  if(getdvarint(@ "hash_e7fd1773dcd3056b", 0) && var_c8c8535645d45985) {
    var_26cd2fe9d9c7396a -= getdvarint(@ "hash_e7fd1773dcd3056b", 0);
  }

  while(true) {
    curtime = gettime();
    var_d2a0f17e8e173e01 = level.maxplayercount;
    var_b7652eea48ae3d62 = getstreamedinplayercount();

    if(!var_7d3c76f0163532bd) {
      if(var_b7652eea48ae3d62 > 0) {
        starttime = gettime();
        var_7d3c76f0163532bd = 1;

        if(getdvarint(@ "hash_5886df61b04d3129", 0)) {
          break;
        }
      } else {
        if(curtime - lastprinttime > 3000) {
          println("<dev string:x52>" + var_b7652eea48ae3d62 + "<dev string:x70>");
          lastprinttime = curtime;
        }

        waitframe();
        continue;
      }
    }

    var_54ab13ac8f1a59cd = var_d2a0f17e8e173e01 >= var_26cd2fe9d9c7396a;
    var_93e3fe0e5693889b = var_b7652eea48ae3d62 >= var_26cd2fe9d9c7396a;

    if(curtime - lastprinttime > 3000) {
      alliescount = 0;
      axiscount = 0;
      undefinedcount = 0;

      foreach(player in level.players) {
        if(!isDefined(player.team)) {
          undefinedcount++;
          continue;
        }

        if(player.team == "<dev string:x8f>") {
          alliescount++;
          continue;
        }

        if(player.team == "<dev string:x99>") {
          axiscount++;
        }
      }

      println("<dev string:x52>" + alliescount + "<dev string:xa1>");
      println("<dev string:x52>" + axiscount + "<dev string:xbc>");
      println("<dev string:x52>" + undefinedcount + "<dev string:xd5>");
    }

    if(var_93e3fe0e5693889b) {
      foreach(entry in level.teamnamelist) {
        if(!checkrequiredteamcount(entry)) {
          var_54ab13ac8f1a59cd = 0;
          break;
        }
      }
    }

    if(istrue(var_c8c8535645d45985) && var_93e3fe0e5693889b && curtime > mintime) {
      break;
    } else if(var_54ab13ac8f1a59cd && curtime > mintime) {
      break;
    }

    if(!var_c8c8535645d45985 && getdvarint(@ "hash_5886df61b04d3129", 0) == 0 && !istrue(level.var_60f7d8bd0181980f) && getactiveclientcount(1) < var_26cd2fe9d9c7396a) {
      level.var_60f7d8bd0181980f = 1;
      setomnvarforallclients("ui_leagueplay_allow_quit", 1);
      thread function_46eb417b582d5179(endtime - curtime);
    }

    if(curtime > endtime) {
      cancelmatch = 1;
      println("<dev string:xf3>" + level.var_c8001f5313a05589 + "<dev string:x11f>");
      break;
    }

    if(!var_c8c8535645d45985 && !loadoutsforced && curtime + level.prematchperiodend * 1000 > endtime) {
      foreach(player in level.players) {
        if(istrue(player.waitingtoselectclass)) {
          var_ed6036c19a695cd2 = player getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
          loadout_index = ter_op(isDefined(var_ed6036c19a695cd2), var_ed6036c19a695cd2, 0);
          player notify("loadout_class_selected", loadout_index);
          player setclientomnvar("ui_options_menu", 0);
        }
      }

      loadoutsforced = 1;
    }

    if(curtime - lastprinttime > 3000) {
      println("<dev string:x52>" + var_b7652eea48ae3d62 + "<dev string:x70>");
      println("<dev string:x52>" + var_d2a0f17e8e173e01 + "<dev string:x149>");
      lastprinttime = curtime;
    }

    waitframe();
  }

  totaltime = gettime() - starttime;
  println("<dev string:x162>" + totaltime + "<dev string:x38>");

  if(getdvarint(@ "hash_c03a546c561f9ef", 0) || var_c8c8535645d45985) {
    return;
  }

  if(cancelmatch) {
    scripts\mp\leagueplay::cancel_match();
  }
}

function getstreamedinplayercount() {
  count = 0;

  foreach(player in level.players) {
    if(istrue(player scripts\mp\utility\stats::getpersstat("streamSyncComplete"))) {
      count++;
    }
  }

  return count;
}

function checkrequiredteamcount(team) {
  return getteamdata(team, "hasSpawned") >= level.requiredplayercount[team];
}

function checkrequiredteamstreamcount(team) {
  count = 0;

  foreach(player in level.players) {
    if(isDefined(player.team) && player.team == team && istrue(player scripts\mp\utility\stats::getpersstat("streamSyncComplete"))) {
      count++;
    }
  }

  return count >= level.requiredplayercount[team];
}

function prematchperiod() {
  level endon("game_ended");
  level.connectingplayers = getdvarint(@ "hash_6317f96738d7a501");

  if(getdvarint(@ "scr_live_lobby", 0) == 1 && !istrue(level.skipprematch)) {
    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      assertmsg("<dev string:x189>" + "<dev string:x1a1>" + getgametype() + "<dev string:x1ae>");
    }

    game["inLiveLobby"] = 1;

    if(getdvarint(@ "scr_enable_dev_livelobby_overrides", 0) == 1) {
      level thread watchdevoverridematchstart();
    }

    level thread watchforlowpopmatchstart(1);
    level thread watchforminplayersmatchstart();
    level thread function_d8801225da86a2c1();
    level waittill("start_prematch");

    if(level.var_77907d733abe8b63) {
      level thread namespace_2c7976a64ea24d6a::function_562f080949959cfc();
      level thread namespace_2c7976a64ea24d6a::function_d794d8a20e142efa();
    }

    setDvar(@ "scr_live_lobby", 0);
    game["inLiveLobby"] = 0;
    game["liveLobbyCompleted"] = 1;
    matchdelay = 30;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      matchdelay = getmatchrulesdata("brData", "preMatchStartTimer");
    }

    if(getdvarfloat(@ "hash_7a1447160ba151fe", 0) > 0) {
      matchdelay = getdvarfloat(@ "hash_7a1447160ba151fe", 0);
    }

    if(getdvarfloat(@ "hash_1c528462a5c6a55d", 0) > 0) {
      spawnselectdelay = getdvarfloat(@ "hash_1c528462a5c6a55d", 0);
    }

    level.allowprematchdamage = 0;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(!istrue(level.var_78db23c4f4816114)) {
        level.allowprematchdamage = 1;
      }

      level thread scripts\mp\gametypes\br_public::br_delaynojip();
    }

    level livelobbymatchstarttimer("match_starting_in", matchdelay);
    level notify("start_prematch");
    level.prematchperiod = 0;
    game["blockJIP"] = 1;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      level thread namespace_8885c19c053dcb46::function_c24d9aca5f9eba35();
    }

    if(!privatematch()) {
      if(getdvarint(@ "hash_22eddf44003baf9", 0) != 0 && function_7eda3128313bb227()) {
        println("<dev string:x1cf>");
        setDvar(@ "hash_925f7dceb8e6205e", 1);
        namespace_bf9ffd2b22c7d819::function_c5728699e6b79552(1);
      } else {
        println("<dev string:x20b>");
        setDvar(@ "hash_925f7dceb8e6205e", 0);
      }
    } else if(getdvarint(@ "hash_22eddf44003baf9", 0) != 0 && getdvarint(@ "online_privatematch_rejoin_allowed", 0) != 0) {
      println("<dev string:x248>");
      setDvar(@ "hash_15dc0d6798e4bdd8", 1);
      setDvar(@ "hash_925f7dceb8e6205e", 1);
      namespace_bf9ffd2b22c7d819::function_c5728699e6b79552(1);
    }
  } else if(!istrue(level.skipprematch)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm") {
      minplayers = getdvarint(@ "br_minplayers");

      if(minplayers != 0) {
        level thread watchforlowpopmatchstart();
        level thread brwatchforminplayersmatchstart();
        level waittill("start_prematch");

        if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
          level thread namespace_8885c19c053dcb46::function_c24d9aca5f9eba35();
        }

        if(level.var_77907d733abe8b63) {
          level thread namespace_2c7976a64ea24d6a::function_562f080949959cfc();
          level thread namespace_2c7976a64ea24d6a::function_d794d8a20e142efa();
        }

        var_98c4343376bcedb9 = 0;

        while(istrue(level.var_9bb484946bcc49b2)) {
          var_98c4343376bcedb9 = 1;
          waitframe();
        }

        foreach(player in level.players) {
          if(!isDefined(player)) {
            continue;
          }

          if(isbot(player) || istestclient(player)) {
            while(isDefined(player) && !player.hasspawned) {
              waitframe();
            }
          }
        }

        if(var_98c4343376bcedb9) {
          wait 1;
        }
      }

      matchdelay = 15;

      if(getdvarfloat(@ "hash_7a1447160ba151fe", 0) > 0) {
        matchdelay = getdvarfloat(@ "hash_7a1447160ba151fe", 0);
      }

      level.allowprematchdamage = 0;

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz") {
        level.allowprematchdamage = 1;
      }

      level livelobbymatchstarttimer("match_starting_in", matchdelay);
    }
  }

  if(level.mapname == "<dev string:x2b8>" && !isprophuntgametype() && getdvarint(@ "hash_ff65c25889692db8", 0) != 1) {
    level thread givebmodevloadouts();
  }

  if(istrue(level.skipprematch)) {
    while(!level.players.size) {
      waitframe();
    }

    if(matchmakinggame() && scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      var_1580cb21313fb11c = 2000;
      untiltime = gettime() + var_1580cb21313fb11c;
      var_458c943d98a7ed1a = function_fe94aaedd1047d50();
      assert(var_458c943d98a7ed1a > 0);

      while(gettime() < untiltime && function_e48deb3d75ab2e92() < var_458c943d98a7ed1a) {
        waitframe();
      }
    }

    level.prematchperiodend = getdvarint(@ "hash_befab5d3b543da43", level.prematchperiodend);
  }

  if(istrue(game["matchStartRequiresInput"])) {
    level waittill("pressToStartMatch");
  }

  if(istrue(game["blockJIP"])) {
    setnojipscore(1, 1);
    setnojiptime(1, 1);
    level.nojip = 1;
  }

  if(istrue(level.leagueplaymatchcancelled)) {
    return;
  }

  level notify("prematch_started");

  if(istrue(level.var_66113aa6fc12be57)) {
    level.parachuterestoreweaponscb = &scripts\mp\gametypes\br::nakeddrop;
  }

  if(shouldmodelognotify() && game["roundsPlayed"] == 0) {
    logstring("IWH-315293: CEPHALOPOD: prematch_started notified");
  }

  updatetournamentroundtime(gettimeremaining(), 2);
  level.prematchstarted = 1;

  if(level.prematchperiodend > 0) {
    matchstarttimerwaitforplayers();
  } else {
    matchstarttimerskip();
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();
  updatetournamentroundtime(gettimeremaining(), 0);

  if(game["state"] != "playing") {
    return;
  }
}

function inprematch() {
  return !istrue(level.skipprematch) && !scripts\mp\flags::gameflag("prematch_done");
}

function givebmodevloadouts() {
  wait 3;

  if(isDefined(level.parachuterestoreweaponscb)) {
    foreach(player in level.players) {
      if(isreallyalive(player)) {
        player[[level.parachuterestoreweaponscb]]();
      }
    }
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
    if(shouldmodelognotify() && game["roundsPlayed"] == 0) {
      logstring("IWH-315293: FROGFISH: game[ state ] != playing");
    }

    return;
  }

  if(getgametypenumlives()) {
    players = level.players;

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!player.hasspawned && player.sessionteam != "spectator" && !isalive(player)) {
        player.statusicon = "hud_status_dead";
      }
    }
  }

  level thread[[level.updategameevents]]();
}

function sethasdonecombat(player, newhasdonecombat) {
  if(!isDefined(player.hasdoneanycombat)) {
    player.hasdoneanycombat = player scripts\mp\utility\stats::getpersstat("hasDoneAnyCombat");
  }

  if(newhasdonecombat) {
    scripts\mp\class::disableclassswapallowed();
    scripts\mp\class::function_bc75edb1c34af80e();
  }

  player.hasdonecombat = newhasdonecombat;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(newhasdonecombat && !istrue(player.hasdoneanycombat)) {
    player.pers["hasDoneAnyCombat"] = 1;
    player.hasdoneanycombat = 1;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      player scripts\mp\utility\stats::incpersstat("gamesPlayed", 1);
    }

    if(isDefined(player scripts\mp\utility\stats::getpersstat("hasMatchLoss")) && player scripts\mp\utility\stats::getpersstat("hasMatchLoss")) {
      return;
    }

    scripts\mp\gamelogic::updatelossstats(player);
  }
}

function updatewinstats(winner) {
  println("<dev string:x2cb>" + winner getentitynumber());

  if(!winner onlinestatsenabled()) {
    println("<dev string:x2ea>");
    return;
  }

  if(!istrue(winner scripts\mp\utility\stats::getpersstat("hasDoneAnyCombat"))) {
    println("<dev string:x319>");
    return;
  }

  if(istrue(winner scripts\mp\utility\stats::getpersstat("recordedLoss"))) {
    winner addtoplayerstat(-1, "matchStats", "losses");
  }

  println("<dev string:x34c>" + winner getplayerstat("<dev string:x360>", "<dev string:x36e>"));
  println("<dev string:x376>" + winner getplayerstat("<dev string:x360>", "<dev string:x36e>"));
  println("<dev string:x391>");

  winner addtoplayerstat(1, "matchStats", "wins");
  println("<dev string:x376>" + winner getplayerstat("<dev string:x360>", "<dev string:x36e>"));
  winner addtoplayerstat(1, "matchStats", "currentWinStreak");
  winner addtoplayerstat(1, "modeRecords", getbasegametype());
  cur_win_streak = winner getplayerstat("matchStats", "currentWinStreak");

  if(cur_win_streak > winner getplayerstat("bestStats", "longestWinStreak")) {
    winner setplayerstat(cur_win_streak, "bestStats", "longestWinStreak");
  }

  winner scripts\mp\persistence::statsetchild("round", "win", 1);
  winner scripts\mp\persistence::statsetchild("round", "loss", 0);
}

function updatelossstats(loser) {
  if(!loser onlinestatsenabled()) {
    return;
  }

  if(!istrue(loser scripts\mp\utility\stats::getpersstat("hasDoneAnyCombat"))) {
    return;
  }

  loser.pers["hasMatchLoss"] = 1;

  if(!istrue(self.joinedinprogress)) {
    loser addtoplayerstat(1, "matchStats", "losses");
    loser.pers["recordedLoss"] = 1;
  }

  loser addtoplayerstat(1, "matchStats", "gamesPlayed");
  loser scripts\mp\persistence::statsetchild("round", "loss", 1);
}

function updatetiestats(loser) {
  if(!loser onlinestatsenabled()) {
    return;
  }

  if(!istrue(loser scripts\mp\utility\stats::getpersstat("hasDoneAnyCombat"))) {
    return;
  }

  if(istrue(loser scripts\mp\utility\stats::getpersstat("recordedLoss"))) {
    loser addtoplayerstat(-1, "matchStats", "losses");
    loser setplayerstat(0, "matchStats", "currentWinStreak");
  }

  loser addtoplayerstat(1, "matchStats", "ties");
  loser scripts\mp\persistence::statsetchild("round", "loss", 0);
}

function updatewinlossstats(winner) {
  println("<dev string:x3b8>");

  if(privatematch()) {
    println("<dev string:x3d5>");
    return;
  }

  if(!waslastround()) {
    println("<dev string:x406>");
    return;
  }

  level.processedwinloss = 1;
  players = level.players;
  updateplayercombatstatus();

  if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie") {
    println("<dev string:x434>");

    foreach(player in level.players) {
      if(isDefined(player.connectedpostgame)) {
        continue;
      }

      if(level.hostforcedend && player ishost()) {
        player setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      updatetiestats(player);
    }

    return;
  }

  if(isPlayer(winner)) {
    println("<dev string:x468>");

    if(level.hostforcedend && winner ishost()) {
      winner setplayerstat(0, "matchStats", "currentWinStreak");
      return;
    }

    if(isDefined(level.lastplayerwins) || players.size <= 3) {
      updatewinstats(level.placement["all"][0]);
    } else {
      for(pidx = 0; pidx < min(level.placement["all"].size, 3); pidx++) {
        updatewinstats(level.placement["all"][pidx]);
      }
    }

    return;
  }

  if(isstring(winner)) {
    println("<dev string:x490>" + winner + "<dev string:x4ba>");

    foreach(player in level.players) {
      println("<dev string:x4bf>" + player getentitynumber() + "<dev string:x4e0>" + player.name + "<dev string:x4e6>");

      if(isDefined(player.connectedpostgame)) {
        println("<dev string:x4eb>");
        continue;
      }

      if(level.hostforcedend && player ishost()) {
        println("<dev string:x527>");
        player setplayerstat(0, "matchStats", "currentWinStreak");
        continue;
      }

      if(winner == "tie") {
        println("<dev string:x580>");
        updatetiestats(player);
        continue;
      }

      if(player.pers["team"] == winner) {
        println("<dev string:x5b2>");
        updatewinstats(player);
        continue;
      }

      println("<dev string:x5f1>");

      if(istrue(player.pers["recordedLoss"])) {
        println("<dev string:x629>");
        player setplayerstat(0, "matchStats", "currentWinStreak");
      }
    }
  }
}

function updateplayercombatstatus() {
  if(!scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
    return;
  }

  foreach(player in level.players) {
    if(player.sessionstate == "spectator" && !player.spectatekillcam) {
      continue;
    }

    if(istrue(player.pers["hasDoneAnyCombat"])) {
      continue;
    }

    if(player.team == "axis") {
      continue;
    }

    player sethasdonecombat(player, 1);
  }
}

function freezeplayerforroundend(delay) {
  self endon("disconnect");
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\utility\lower_message::clearlowermessages();

  if(!isDefined(delay)) {
    delay = level.framedurationseconds;
  }

  wait delay;
  val::group_set("gameEndFreeze", 0);

  if(self isonground() || self isonladder()) {
    self allowmovement(0);
    return;
  }

  thread gameendfreezemovement();
}

function gameendfreezemovement() {
  self endon("disconnect");
  timecheck = 0;

  while(timecheck < 1) {
    if(!self isonground()) {
      timecheck += level.framedurationseconds;
    } else {
      self allowmovement(0);
      break;
    }

    wait level.framedurationseconds;
  }

  self allowmovement(0);
}

function updatematchbonusscores(winner) {
  if(!game["timePassed"]) {
    return;
  }

  if(!matchmakinggame()) {
    return;
  }

  if(!gettimelimit() || level.forcedend) {
    gamelength = gettimepassed() / 1000;
    gamelength = min(gamelength, 1200);
  } else {
    gamelength = int(floor(scripts\mp\utility\game::getroundlength() / 1000));
  }

  if(level.teambased) {
    if(isDefined(winner) && isgameplayteam(winner) && winner != "tie") {
      setwinningteam(winner);
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "kingslayer" && getsubgametype() != "rumble_mgl") {
      return;
    }

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.connectedpostgame)) {
        continue;
      }

      if(!player rankingenabled()) {
        continue;
      }

      if(player.timeplayed["total"] < 1 || player scripts\mp\utility\stats::getpersstat("participation") < 1) {
        continue;
      }

      if(level.hostforcedend && player ishost()) {
        continue;
      }

      if(!istrue(player scripts\mp\utility\stats::getpersstat("hasDoneAnyCombat"))) {
        continue;
      }

      playerteam = player scripts\mp\utility\stats::getpersstat("team");

      if(winner == "tie") {
        playerscore = player calculatematchbonus("tie", gamelength);
        player givematchbonus("tie", playerscore);
        player.matchbonus = playerscore;
      } else if(isDefined(playerteam) && playerteam == winner) {
        playerscore = player calculatematchbonus("win", gamelength);
        player givematchbonus("win", playerscore);
        player.matchbonus = playerscore;
      } else if(isDefined(playerteam) && isgameplayteam(playerteam) && playerteam != winner) {
        playerscore = player calculatematchbonus("loss", gamelength);
        player givematchbonus("loss", playerscore);
        player.matchbonus = playerscore;
      }

      player calculateweaponmatchbonus(gamelength);
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "kingslayer" && getsubgametype() != "rumble_mgl") {
      return;
    }

    winnerresult = "win";
    loserresult = "loss";

    if(!isDefined(winner)) {
      winnerresult = "tie";
      loserresult = "tie";
    }

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.connectedpostgame)) {
        continue;
      }

      if(player.timeplayed["total"] < 1 || player scripts\mp\utility\stats::getpersstat("participation") < 1) {
        continue;
      }

      if(!istrue(player scripts\mp\utility\stats::getpersstat("hasDoneAnyCombat"))) {
        continue;
      }

      iswinner = 0;

      for(pidx = 0; pidx < min(level.placement["all"].size, 3); pidx++) {
        if(level.placement["all"][pidx] != player) {
          continue;
        }

        iswinner = 1;
      }

      if(iswinner) {
        playerscore = player calculatematchbonus(winnerresult, gamelength);
        player givematchbonus("win", playerscore);
        player.matchbonus = playerscore;
      } else {
        playerscore = player calculatematchbonus(loserresult, gamelength);
        player givematchbonus("loss", playerscore);
        player.matchbonus = playerscore;
      }

      player calculateweaponmatchbonus(gamelength);
    }
  }

  level notify("give_match_bonus");
}

function calculatematchbonus(matchresult, gamelength) {
  matchbonusbaseline = getdvarint(hashcat(@ "scr_", getgametype(), "_matchbonus_baseline"), 250);
  var_f5c150745db5bf66 = gamelength / 60;
  var_30fb07c2ca202ff = scripts\mp\rank::function_6d17f84162f0d8f0(matchresult);
  participationpercent = self.timeplayed["total"] / gamelength;
  modescalar = scripts\mp\rank::getgametypexpmultiplier();
  matchbonus = int(matchbonusbaseline * var_30fb07c2ca202ff * var_f5c150745db5bf66 * participationpercent * modescalar);
  matchbonus = int(min(matchbonus, 16384));
  return matchbonus;
}

function givematchbonus(scoretype, score) {
  if(getdvarint(@ "hash_1f9e52c91272c80d", 1) == 0) {
    return;
  }

  thread scripts\mp\rank::giverankxp(getxhash(scoretype), score, undefined, 1, 1, 1);

  if(scoretype == "win") {
    thread scripts\mp\utility\points::doscoreevent(#"hash_fe606101a22e3e79", undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined, undefined, undefined, 1);
    return;
  }

  assertex(scoretype == "<dev string:x651>" || scoretype == "<dev string:x658>", "<dev string:x660>" + scoretype + "<dev string:x690>");
  thread scripts\mp\utility\points::doscoreevent(#"match_complete", undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined, undefined, undefined, 1);
}

function calculateweaponmatchbonus(gamelength) {
  if(getdvarint(@ "hash_f80c5403193b015f", 1) == 0) {
    return;
  }

  if(istrue(scripts\mp\utility\stats::getpersstat("ignoreWeaponMatchBonus")) || !isDefined(scripts\mp\utility\stats::getpersstat("killsPerWeapon"))) {
    return;
  }

  var_11865501de9083d = scripts\mp\weaponrank::getgametypekillsperhouravg() / 60;
  var_f5c150745db5bf66 = gamelength / 60;
  var_162a122a3e3cce1a = int(var_11865501de9083d * var_f5c150745db5bf66);
  killincrement = int(50);
  participationpercent = self.timeplayed["total"] / gamelength;
  var_9bf173c2aa7eb966 = killincrement * participationpercent;
  var_4b7cf89acaabdcac = int(var_162a122a3e3cce1a * var_9bf173c2aa7eb966);
  var_4b7cf89acaabdcac -= int(scripts\mp\utility\stats::getpersstat("weaponMatchBonusKills") * var_9bf173c2aa7eb966);

  if(var_4b7cf89acaabdcac <= 0) {
    return;
  }

  totaldiff = 0;

  foreach(data in scripts\mp\utility\stats::getpersstat("killsPerWeapon")) {
    totaldiff += var_162a122a3e3cce1a - data.killcount;
  }

  if(totaldiff <= 0) {
    return;
  }

  foreach(weaponkey, data in scripts\mp\utility\stats::getpersstat("killsPerWeapon")) {
    ratio = (var_162a122a3e3cce1a - data.killcount) / totaldiff;
    xpgain = int(var_4b7cf89acaabdcac * ratio);
    scripts\mp\rank::incrankxp(0, data, xpgain, getxhash("WeaponMatchBonus"));

    foreach(var_10ca4bf7aa9c3ed2, datastruct in scripts\mp\utility\stats::getpersstat("weaponStats")) {
      if(issubstr(var_10ca4bf7aa9c3ed2, weaponkey)) {
        if(isDefined(datastruct.stats["kills"]) && data.killcount > 0) {
          specificratio = ratio * datastruct.stats["kills"] / data.killcount;
          xpgain = int(var_4b7cf89acaabdcac * specificratio);

          if(isDefined(datastruct.stats["xp_earned"])) {
            datastruct.stats["xp_earned"] = datastruct.stats["xp_earned"] + xpgain;
            continue;
          }

          datastruct.stats["xp_earned"] = xpgain;
        }
      }
    }
  }
}

function setxenonranks(winner) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player.score) || !isDefined(player.pers["team"])) {}
  }

  for(i = 0; i < players.size; i++) {
    player = players[i];
    _setplayerteamrank(player);
  }
}

function _setplayerteamrank(player, teamplacement) {
  if(!isDefined(player)) {
    return;
  }

  if(istrue(player.pers["xenonRankSet"])) {
    return;
  }

  if(!isDefined(player.kills) || !isDefined(player.deaths)) {
    println("<dev string:x695>");
    return;
  }

  if(getgametype() == "arena") {
    if(1 > player.timeplayed["total"]) {
      return;
    }

    if(!isDefined(player.arenadamage)) {
      return;
    }

    damage = player.arenadamage;
    println("<dev string:x6bf>" + damage);
    setplayerteamrank(player, player.clientid, damage);
    player.pers["xenonRankSet"] = 1;
    return;
  }

  if(isteamplacementsbmmmode()) {
    if(!isDefined(teamplacement)) {
      teamplacement = default_to(player.teamplacement, 0);
    }

    playerscore = 1000 - teamplacement;
    setplayerteamrank(player, player.clientid, playerscore);
    player.pers["xenonRankSet"] = 1;
    return;
  }

  if(istrue(level.var_b9c6856f5ab5f70f)) {
    operatorkills = default_to(player.kills, 0);
    agentkills = default_to(player.agentkills, 0);
    downs = default_to(player.pers["downs"], 0);
    deaths = default_to(player.deaths, 0);
    suicides = default_to(player getpersstat("suicides"), 0);
    var_8d738248e5c26cf9 = default_to(player scripts\mp\teams::function_19300abfbb10928b() / 60, 1);

    if(var_8d738248e5c26cf9 == 0) {
      var_8d738248e5c26cf9 = 1;
    }

    operatorkd = (operatorkills - downs + deaths - suicides) / var_8d738248e5c26cf9;
    agentkd = (agentkills - downs + deaths - suicides) / var_8d738248e5c26cf9;
    operatorweight = getdvarfloat(@ "hash_9cdadf8cf57f485e", 0.75);
    agentweight = getdvarfloat(@ "hash_f4a4d4df91cf9f67", 0.25);
    rank = operatorkd * operatorweight + agentkd * agentweight;
    println("<dev string:x6ca>" + rank);
    println("<dev string:x6d5>" + operatorweight + "<dev string:x721>" + operatorkills + "<dev string:x737>" + downs + "<dev string:x73d>" + deaths + "<dev string:x742>" + suicides + "<dev string:x747>" + var_8d738248e5c26cf9 + "<dev string:x74e>");
    println("<dev string:x753>" + agentweight + "<dev string:x79c>" + agentkills + "<dev string:x737>" + downs + "<dev string:x73d>" + deaths + "<dev string:x742>" + suicides + "<dev string:x747>" + var_8d738248e5c26cf9 + "<dev string:x74e>");
    setplayerteamrank(player, player.clientid, rank);
    player.pers["xenonRankSet"] = 1;
    return;
  }

  if(120 > player.timeplayed["total"]) {
    return;
  }

  suicides = 0;

  if(getdvarint(@ "hash_8613ee8086b0e0f6") == 1) {
    suicides = player getpersstat("suicides");
  }

  kd = (player.kills - player.deaths - suicides) / player.timeplayed["total"] / 60;
  println("<dev string:x7ae>" + player.kills + "<dev string:x7ef>" + player.deaths + "<dev string:x7f8>" + suicides + "<dev string:x7ff>" + player.timeplayed["<dev string:x808>"] / 60 + "<dev string:x811>" + kd);
  setplayerteamrank(player, player.clientid, kd);

  if(isDefined(player.var_445c8714ee8588d5)) {
    meleekills = player.var_445c8714ee8588d5["melee"];
    sniperkills = player.var_445c8714ee8588d5["sniper"];
    dmrkills = player.var_445c8714ee8588d5["dmr"];
    shotgunkills = player.var_445c8714ee8588d5["shotgun"];
    smgkills = player.var_445c8714ee8588d5["smg"];
    arkills = player.var_445c8714ee8588d5["ar"];
    var_95166a1d5e14ffb2 = player.var_445c8714ee8588d5["br"];
    pistolkills = player.var_445c8714ee8588d5["pistol"];
    lmgkills = player.var_445c8714ee8588d5["lmg"];
    launcherkills = player.var_445c8714ee8588d5["launcher"];
    var_1cfe2d91282ed3a2 = player.var_445c8714ee8588d5["other"];
    var_a838fae0613a5274 = meleekills + sniperkills + dmrkills + shotgunkills + smgkills + arkills + var_95166a1d5e14ffb2 + pistolkills + lmgkills + launcherkills + var_1cfe2d91282ed3a2;

    if(var_a838fae0613a5274 != player.kills) {
      assertmsg("<dev string:x818>" + var_a838fae0613a5274 + "<dev string:x860>" + player.kills + "<dev string:x883>");
    } else {
      meleekills *= 1.33;
      sniperkills *= 1;
      dmrkills *= 1;
      shotgunkills *= 1;
      smgkills *= 1;
      arkills *= 1;
      var_95166a1d5e14ffb2 *= 1;
      pistolkills *= 1;
      lmgkills *= 1;
      launcherkills *= 1;
      var_8d6971919ca70503 = meleekills + sniperkills + dmrkills + shotgunkills + smgkills + arkills + var_95166a1d5e14ffb2 + pistolkills + lmgkills + launcherkills + var_1cfe2d91282ed3a2;
      var_3e5bb1c760eb8211 = (var_8d6971919ca70503 - player.deaths - suicides) / player.timeplayed["total"] / 60;
      function_17c90f3144cd4a59(player, player.clientid, var_3e5bb1c760eb8211);
    }
  } else if(player.kills <= 0) {
    function_17c90f3144cd4a59(player, player.clientid, kd);
  }

  player.pers["xenonRankSet"] = 1;
}

function checktimelimit(prevtimepassed) {
  if(isDefined(level.timelimitoverride) && level.timelimitoverride) {
    return;
  }

  if(game["state"] != "playing") {
    setgameendtime(0);
    return;
  }

  runjiprules();

  if(gettimelimit() <= 0) {
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

  timeleft = gettimeremaining();
  setgameendtime(gettime() + int(timeleft));
  var_83af6c8b7cee31c8 = istrue(level.ontimelimitgraceperiod);

  if(timeleft > 0 && !isDefined(level.forceotlogictorun)) {
    if(var_83af6c8b7cee31c8) {
      if(scripts\mp\flags::levelflag("over_time_entered")) {
        scripts\mp\flags::levelflagclear("over_time_entered");
      }

      if(istrue(level.setallclientomnvarot)) {
        setomnvarforallclients("ui_overtime_timer_show", 0);
      } else {
        setomnvar("ui_overtime_timer_show", 0);
      }
    }

    if(!isDefined(level.var_5821aa8d232fffa1) && isDefined(level.initialtimelimit) && level.initialtimelimit > 180 && int(timeleft / 1000) < int(level.initialtimelimit / 2)) {
      level.var_5821aa8d232fffa1 = 1;
      level thread function_f08a48e620ec4480();
    }

    return;
  } else if(getgametype() == "wm" && timeleft <= 0 && !scripts\mp\flags::levelflag("over_time_entered")) {
    hud_util::showsplashtoall("wm_last_chance");
    scripts\mp\flags::levelflagset("over_time_entered");
  }

  if(var_83af6c8b7cee31c8) {
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

    progress = clamp(1 - level.currenttimelimitdelay / level.ontimelimitgraceperiod, 0, 1);

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      if(istrue(level.setallclientomnvarot)) {
        if(!isDefined(level.forcehideottimer)) {
          setomnvarforallclients("ui_overtime_timer_show", 1);
        }

        setomnvarforallclients("ui_overtime_timer", progress);
      } else {
        setomnvar("ui_overtime_timer_show", 1);
        setomnvar("ui_overtime_timer", progress);
      }

      if(getsubgametype() == "champion") {
        setomnvar("ui_overtime_time", gettime() + (level.ontimelimitgraceperiod - level.currenttimelimitdelay) * 1000);
      } else {
        setomnvar("ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000);
      }
    } else {
      if(istrue(level.setallclientomnvarot)) {
        setomnvarforallclients("ui_overtime_timer_show", 0);
        setomnvarforallclients("ui_overtime_timer", progress);
      } else {
        setomnvar("ui_overtime_timer_show", 0);
        setomnvar("ui_overtime_timer", progress);
      }

      if(getsubgametype() == "champion") {
        setomnvar("ui_overtime_time", gettime());
      } else {
        setomnvar("ui_overtime_time", gettime() + level.ontimelimitgraceperiod * 1000);
      }
    }

    if(level.currenttimelimitdelay < level.ontimelimitgraceperiod) {
      return;
    }
  }

  [[level.ontimelimit]]();
}

function function_f08a48e620ec4480() {
  if(level.teambased) {
    if(inovertime() || intimetobeat()) {
      if(isscoretobeatrulegametype()) {
        score = game["overtimeProgress"] + game["overtimeProgressFrac"];
        winner = setscoretobeat(game["attackers"], score * 60);
      } else if(istimetobeatvalid()) {
        winner = game["timeToBeatTeam"];
      }
    } else {
      winner = scripts\mp\gamescore::gethighestscoringteam();
    }

    if(winner != "tie") {
      level thread function_af05f2d3b126a9d0(winner);
    }

    return;
  }

  winningplayer = scripts\mp\gamescore::gethighestscoringplayer();
  level thread function_af05f2d3b126a9d0(winningplayer);
}

function function_af05f2d3b126a9d0(winner) {
  if(!isDefined(winner)) {
    return;
  }

  if(!isPlayer(winner)) {
    scripts\mp\utility\dialog::leaderdialog("halfway_friendly_time", winner, "status");
    scripts\mp\utility\dialog::leaderdialog("halfway_enemy_time", getotherteam(winner)[0], "status");
    return;
  }

  if(isDefined(winner)) {
    winner thread scripts\mp\utility\dialog::leaderdialogonplayer("halfway_friendly_time");
  }

  losingplayers = scripts\mp\gamescore::getlosingplayers();

  foreach(player in losingplayers) {
    if(is_equal(player, winner)) {
      continue;
    }

    player thread scripts\mp\utility\dialog::leaderdialogonplayer("halfway_enemy_time");
  }
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
    if(isroundbased() && !level.nojip) {
      switch (getgametype()) {
        case #"hash_4b8799075d3a89b8":
        case #"hash_f4a9126c03d3385b":
          var_310caaf87186cd6 = checkdomjiprules();
          break;
        case #"hash_53825b446469ac4c":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_aac44b0b52bacb8e":
        case #"hash_e2e043391c7c9074":
        case #"hash_eb5e5f470e0c1dc2":
        case #"hash_fa37b7f6bd6f6cbf":
        case #"hash_fa50b0f6bd82e972":
        case #"hash_fa50baf6bd82f930":
          var_310caaf87186cd6 = function_8e22bfd7b2fc9dda();
          break;
        case #"hash_1a5d186c17c00d3c":
          var_310caaf87186cd6 = checkctfjiprules();
          break;
        case #"hash_51347b2eb89b24c4":
          var_310caaf87186cd6 = checkballjiprules();
          break;
        case #"hash_fa0ed2f6bd4f4395":
          var_310caaf87186cd6 = checkddjiprules();
          break;
        default:
          var_310caaf87186cd6 = checkdefaultjiprules();
          break;
      }

      if(var_310caaf87186cd6) {
        setnojipscore(1, 1);
        setnojiptime(1, 1);
        level.nojip = 1;
      }

      return;
    }

    if(gettimepassedpercentage() > level.timepercentagecutoff) {
      setnojiptime(1, 1);
      level.nojip = 1;
    }
  }
}

function checkdomjiprules() {
  if(!isfirstround()) {
    foreach(entry in level.teamnamelist) {
      if(getteamscoreint(entry) > 150) {
        return true;
      }
    }

    if(gettimepassedpercentage() > 75) {
      return true;
    }
  }

  return false;
}

function function_8e22bfd7b2fc9dda() {
  var_bdb5de4f9346b298 = 3;

  switch (getgametype()) {
    case #"hash_aac44b0b52bacb8e":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      var_bdb5de4f9346b298 = 3;
      break;
    case #"hash_53825b446469ac4c":
      var_bdb5de4f9346b298 = 2;
      break;
    case #"hash_eb5e5f470e0c1dc2":
      var_bdb5de4f9346b298 = 3;
      break;
    case #"hash_5ff8e011d5b9d1c8":
      var_bdb5de4f9346b298 = 3;
      break;
    case #"hash_fa37b7f6bd6f6cbf":
      var_bdb5de4f9346b298 = 3;
      break;
    case #"hash_e2e043391c7c9074":
      var_bdb5de4f9346b298 = 2;
      break;
    default:
      var_bdb5de4f9346b298 = 3;
      break;
  }

  if(isanymlgmatch()) {
    var_bdb5de4f9346b298 = 5;
  }

  foreach(entry in level.teamnamelist) {
    if(getroundswon(entry) >= var_bdb5de4f9346b298) {
      return true;
    }
  }

  return false;
}

function checkctfjiprules() {
  if(!isfirstround()) {
    if(gettimepassedpercentage() > level.timepercentagecutoff) {
      return true;
    }
  }

  lowestscore = undefined;
  highestscore = undefined;

  foreach(entry in level.teamnamelist) {
    teamscore = getteamscoreint(entry);

    if(!isDefined(lowestscore) || teamscore < lowestscore) {
      lowestscore = teamscore;
    }

    if(!isDefined(highestscore) || teamscore > highestscore) {
      highestscore = teamscore;
    }
  }

  delta = abs(highestscore - lowestscore);

  if(delta > 10) {
    return true;
  }

  return false;
}

function checkballjiprules() {
  if(!isfirstround()) {
    if(gettimepassedpercentage() > level.timepercentagecutoff) {
      return true;
    }
  }

  lowestscore = undefined;
  highestscore = undefined;

  foreach(entry in level.teamnamelist) {
    teamscore = getteamscoreint(entry);

    if(!isDefined(lowestscore) || teamscore < lowestscore) {
      lowestscore = teamscore;
    }

    if(!isDefined(highestscore) || teamscore > highestscore) {
      highestscore = teamscore;
    }
  }

  delta = abs(highestscore - lowestscore);

  if(delta > 15) {
    return true;
  }

  return false;
}

function checkddjiprules() {
  var_743180d464fc06d1 = 0;

  foreach(entry in level.teamnamelist) {
    var_743180d464fc06d1 += getroundswon(entry);
  }

  if(var_743180d464fc06d1 >= 2) {
    return true;
  }

  return false;
}

function checkdefaultjiprules() {
  if(nextroundisfinalround()) {
    if(gettimepassedpercentage() > level.timepercentagecutoff) {
      return true;
    }
  }

  return false;
}

function getteamscoreint(team) {
  return int(game["teamScores"][team]);
}

function gettimeremaining() {
  var_cc683b074a559f27 = 0;

  if(isDefined(level.var_cc683b074a559f27)) {
    var_cc683b074a559f27 = level.var_cc683b074a559f27;
  }

  return gettimelimit() * 1000 - gettimepassed() - var_cc683b074a559f27;
}

function gettimeremainingpercentage() {
  timelimit = gettimelimit() * 1000;
  return (timelimit - gettimepassed()) / timelimit;
}

function checkteamscorelimitsoon(team) {
  assert(isDefined(team));

  if(level.roundscorelimit <= 0 || isobjectivebased()) {
    return;
  }

  if(isDefined(level.scorelimitoverride) && level.scorelimitoverride) {
    return;
  }

  if(getgametype() == "jugg") {
    return;
  }

  if(!level.teambased) {
    return;
  }

  shouldnotify = 0;

  if(shouldcheckcustomclosetoscorelimit()) {
    shouldnotify = closetoscorelimit(team);
  } else if(getgametype() == "arm" || getgametype() == "conflict") {
    closetoscore = closetoscorelimit(team);
    var_77c63f5cd9656bdb = gettimeremaining() < gettimelimit() * 0.075;
    shouldnotify = closetoscore || var_77c63f5cd9656bdb;
  } else if(gettimepassed() > 45000) {
    shouldnotify = estimatedtimetillscorelimit(team) < 0.5;
  }

  if(!isDefined(level.playedmatchendingsoon)) {
    level.playedmatchendingsoon = 0;
  }

  if(!level.playedmatchendingsoon && shouldnotify) {
    level.playedmatchendingsoon = 1;
    level notify("match_ending_soon", "score");
  }

  if(!level.playedmatchendingsoon && canplayhalfwayvo()) {
    if(getteamscore(team) >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      scripts\mp\utility\dialog::leaderdialog("halfway_friendly_score", team, "status");
      thread scripts\mp\music_and_dialog::midpoint_music(team);
      enemyteams = getenemyteams(team);

      foreach(entry in enemyteams) {
        scripts\mp\utility\dialog::leaderdialog("halfway_enemy_score", entry, "status");
      }

      level.didhalfscorevoboost = 1;
    }
  }
}

function shouldcheckcustomclosetoscorelimit() {
  switch (getgametype()) {
    case #"hash_ca6516c10db2c95":
    case #"hash_3a17de6e294210d2":
    case #"hash_7f9c384a34cc392f":
    case #"hash_e9037b8a10fb8a14":
    case #"hash_ea061d29bbd1f237":
    case #"hash_f4a9126c03d3385b":
      return 1;
    default:
      return 0;
  }
}

function checkplayerscorelimitsoon() {
  if(level.roundscorelimit <= 0 || isobjectivebased()) {
    return;
  }

  if(level.teambased) {
    return;
  }

  if(gettimepassed() < 60000) {
    return;
  }

  scripts\mp\gamescore::checkffascorejip();

  if(getgametype() == "gun") {
    if(self.score == 14) {
      level notify("match_ending_soon", "score");
    }

    return;
  }

  timeleft = estimatedtimetillscorelimit();

  if(timeleft < 2) {
    level notify("match_ending_soon", "score");
  }
}

function checkscorelimit(allowtie) {
  if(cantiebysimultaneouskill()) {
    allowtie = 1;
  }

  if(istrue(allowtie)) {
    if(isPlayer(self) && !level.teambased && self.score >= level.roundscorelimit) {
      level.scorelimitreached = 1;
    }

    level notify("checkScoreLimit");
    level endon("checkScoreLimit");
    waitframe();
  }

  if(isobjectivebased()) {
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
    limitreached = 0;

    for(i = 0; i < level.teamnamelist.size; i++) {
      if(game["teamScores"][level.teamnamelist[i]] >= level.roundscorelimit) {
        limitreached = 1;
      }
    }

    if(!limitreached) {
      return 0;
    }
  } else {
    if(!isPlayer(self)) {
      return 0;
    }

    if(self.score < level.roundscorelimit && !istrue(level.scorelimitreached)) {
      return 0;
    }
  }

  if(!istrue(level.dontendonscore)) {
    return onscorelimit(allowtie);
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
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("infilSequence")) {
    if(!istrue(level.var_72e1667d06ab98db)) {
      setomnvar("ui_in_infil", 3);
    }
  }

  if(istrue(level.leagueplaymatch)) {
    function_d084af239c9a23c(level.var_c8001f5313a05589, 1);
    level thread prematchcountdownnotify();
  } else {
    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      thread matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);
    }

    level thread prematchcountdownnotify();
    waitforplayers(level.prematchperiod, 0, istrue(level.var_d0074a54d755766b));
  }

  if(level.prematchperiodend > 0 && !isDefined(level.hostmigrationtimer)) {
    adjusted_time = level.prematchperiodend;
    level notify("match_start_real_countdown", adjusted_time);

    if(istrue(level.leagueplaymatch)) {
      var_3b0d320c2be79893 = level.prematchperiod * 2 + adjusted_time;
      level.leagueplayloadingcomplete = 1;
      level notify("leaguePlayLoadingComplete");
      setomnvar("ui_mp_extended_load_screen", 0);
      setomnvar("ui_match_start_text", "waiting_for_players");
      function_d084af239c9a23c(var_3b0d320c2be79893, 0);
      level.var_60f7d8bd0181980f = 0;
    }

    if(!gameflag("infil_will_run") && game["roundsPlayed"] == 0 && !scripts\cp_mp\utility\game_utility::isarenamap() && getsubgametype() != "dmz" && getsubgametype() != "exgm") {
      level thread showmapchyron();
    }

    thread matchstarttimer("match_starting_in", adjusted_time);
    thread prematchcountdownnotify(adjusted_time);
    level waittill("matchStartTimer_done");
  }
}

function showmapchyron() {
  if(istrue(level.var_4df4777277c281ff)) {
    return;
  }

  setomnvar("ui_in_infil", 1);
  level waittill_notify_or_timeout("matchStartTimer_done", 8);
  setomnvar("ui_in_infil", -1);
}

function prematchcountdownnotify(timeoverride) {
  level notify("prematchCountdownNotify");
  level endon("prematchCountdownNotify");

  if(isDefined(timeoverride)) {
    wait max(timeoverride - 5, 0);
  } else {
    wait max(level.prematchperiod + level.prematchperiodend - 5, 0);
  }

  scripts\mp\flags::gameflagset("prematch_countdown");
}

function startmodeobjidnotify(time) {
  self notify("startOBJID");
  self endon("startOBJID");

  if(getbasegametype() == "sd") {
    notifytime = 6;
  } else {
    notifytime = 5;
  }

  if(time > notifytime) {
    time -= notifytime;
    max(time, 0);
    wait time;
  } else {
    wait 0.5;
  }

  level notify("start_mode_setup");
}

function matchstarttimer(type, duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  counttime = int(duration);
  level thread startmodeobjidnotify(counttime);

  if(counttime >= 2) {
    setomnvar("ui_match_start_text", type);
    matchstarttimerperplayer_internal(counttime);
  }

  visionsetnaked("", 0);
  level notify("matchStartTimer_done");

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() || istrue(level.testrandomrealismclients)) {
    foreach(player in level.players) {
      if(istrue(level.testrandomrealismclients)) {
        if(!isDefined(player.isrealismenabled)) {
          if(cointoss()) {
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

function matchstarttimerperplayer_internal(counttime) {
  waittillframeend();
  level endon("match_start_timer_beginning");
  level endon("match_cancel_timer_beginning");
  mincounttime = int(counttime);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm") {
    thread scripts\mp\gametypes\br_public::applyprematchplotarmor(mincounttime);
  }

  foreach(entry in level.teamnamelist) {
    childthread teamstarttimer(entry, mincounttime);
  }

  extrateams = ["spectator", "codcaster"];

  foreach(entry in extrateams) {
    childthread teamstarttimer(entry, mincounttime);
  }

  childthread clearvisionsettimer(mincounttime);
  wait mincounttime;
}

function teamstarttimer(team, counttime) {
  level endon("match_start_timer_beginning");
  level endon("match_cancel_timer_beginning");
  level.matchcountdowntime = ter_op(isDefined(level.var_c8761d87ed1399df), level.var_c8761d87ed1399df, counttime);

  if(!level.gameended) {
    var_fdd4cb56c3b978a3 = scripts\cp_mp\utility\game_utility::isbrstylegametype();

    if(var_fdd4cb56c3b978a3) {
      thread scripts\mp\gametypes\br_public::prematchmusic(team);
      thread scripts\mp\gametypes\br_public::prematchdialog(team);
    }

    var_92d0054b383f50d5 = !var_fdd4cb56c3b978a3 && level.teambased && team != "spectator" && team != "codcaster" && getdvarint(@ "hash_be73a4d94209c1e6") == 0;

    if(var_92d0054b383f50d5) {
      var_c6b6dab35a7bf3b3 = 5;
    }

    while(counttime > 0 && !level.gameended) {
      teamarray = getteamdata(team, "players");

      if(var_92d0054b383f50d5) {
        var_75acdb03f713b07d = counttime <= 8 && counttime >= var_c6b6dab35a7bf3b3;
      }

      foreach(player in teamarray) {
        if(counttime <= 80 && !istrue(player.var_f4bb3d8522246fdc)) {
          if(var_92d0054b383f50d5) {
            player setclientomnvar("ui_show_subfaction_splash", var_75acdb03f713b07d);
          }

          player setclientomnvar("ui_match_start_countdown", counttime);
          player setclientomnvar("ui_match_in_progress", 0);
        }
      }

      counttime--;
      level.matchcountdowntime = counttime;

      if(counttime <= 4 && !isDefined(level.playedstartingmusic)) {
        level notify("prematch_music");
      }

      wait 1;
      newcounttime = namespace_f5675568ccc8acc6::function_6fc852802774b304(1, counttime * 1000);

      if(newcounttime > 0 && counttime <= 10) {
        if(!gameflag("prematch_done")) {
          newcounttime = 10;
        }

        counttime = newcounttime;
      }
    }

    namespace_f5675568ccc8acc6::esportsresumetimer();
    level.matchcountdowntime = undefined;
    teamarray = getteamdata(team, "players");

    foreach(player in teamarray) {
      scripts\mp\playerlogic::clearprematchlook(player);
      player _freezecontrols(0, 1);
      player setclientomnvar("ui_match_start_countdown", -1);
      player setclientomnvar("ui_match_in_progress", 1);
    }

    scripts\mp\flags::gameflagset("prematch_values_reset");
  }
}

function function_46eb417b582d5179(timems, stringoverride) {
  level notify("match_cancel_timer_beginning");
  level endon("match_cancel_timer_beginning");
  timerstring = "match_cancelling_in";

  if(isDefined(stringoverride)) {
    timerstring = stringoverride;
  }

  setomnvar("ui_match_start_text", timerstring);
  counttime = int(timems / 1000);
  waittillframeend();

  while(counttime > 0 && level.var_60f7d8bd0181980f) {
    foreach(p in level.players) {
      p setclientomnvar("ui_match_start_countdown", counttime);
      p setclientomnvar("ui_match_in_progress", 0);
    }

    counttime--;
    wait 1;
  }
}

function clearvisionsettimer(counttime) {
  while(counttime > 0 && !level.gameended) {
    counttime--;
    wait 1;
  }

  visionsetnaked("", 0);
}

function matchstarttimerskip() {
  visionsetnaked("", 0);
  level notify("match_start_timer_skip");
}

function onroundswitch(overtime) {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(overtime) {
    level.halftimetype = "overtime";

    if(islastwinbytwo()) {
      aheadteam = getbetterteam();

      if(aheadteam != game["defenders"]) {
        game["switchedsides"] = !game["switchedsides"];
        level.switchedsides = 1;
      } else {
        level.switchedsides = undefined;
      }
    } else {
      game["switchedsides"] = !game["switchedsides"];
      level.switchedsides = 1;
    }

    return;
  }

  if(istrue(level.skipdefendersadvantage)) {
    game["switchedsides"] = !game["switchedsides"];
    level.switchedsides = 1;
    return;
  }

  if(shouldgivedefendersadvantage()) {
    aheadteam = getbetterteam();

    if(aheadteam != game["defenders"]) {
      game["switchedsides"] = !game["switchedsides"];
      level.switchedsides = 1;
    } else {
      level.switchedsides = undefined;
    }

    return;
  }

  level.halftimetype = "halftime";
  game["switchedsides"] = !game["switchedsides"];
  level.switchedsides = 1;
}

function shouldgivedefendersadvantage() {
  return game["roundsWon"]["allies"] == getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == getwatcheddvar("winlimit") - 1;
}

function checkroundswitch(overtime) {
  if(!level.teambased) {
    return false;
  }

  if(!isDefined(level.roundswitch) || !level.roundswitch) {
    return false;
  }

  assert(game["<dev string:x8a0>"] > 0);

  if(function_ac027009283233c6()) {
    if(function_e3058efbdb62a578()) {
      return true;
    }
  } else if(game["roundsPlayed"] % level.roundswitch == 0 || overtime) {
    return true;
  }

  return false;
}

function function_ac027009283233c6() {
  switch (level.gametype) {
    case #"hash_5ff8e011d5b9d1c8":
      if(level.roundswitch == 2 && getdvarint(@ "hash_b2d6a287c0521607", 2) == 2) {
        return 1;
      }

      return 0;
    default:
      return 0;
  }
}

function function_e3058efbdb62a578() {
  switch (level.gametype) {
    case #"hash_5ff8e011d5b9d1c8":
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
    timepassed = (gettime() - level.gameendtime) / 1000;
    timeremaining = level.postroundtime - timepassed;

    if(timeremaining < 0) {
      return 0;
    }

    return timeremaining;
  }

  if(gettimelimit() <= 0) {
    return undefined;
  }

  if(!isDefined(level.starttime)) {
    return undefined;
  }

  tl = gettimelimit();
  timepassed = (gettime() - level.starttime) / 1000;
  timeremaining = level.discardtime / 1000 + gettimelimit() - timepassed;

  if(isDefined(level.timepaused)) {
    timeremaining += level.timepaused;
  }

  return timeremaining + level.postroundtime;
}

function freegameplayhudelems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] destroyelem();
      self.perkname[0] destroyelem();
    }

    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] destroyelem();
      self.perkname[1] destroyelem();
    }

    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] destroyelem();
      self.perkname[2] destroyelem();
    }
  }

  self notify("perks_hidden");

  if(!level.doeomcombat) {
    self.lowermessage destroyelem();
    self.lowertimer destroyelem();
  }

  if(isDefined(self.proxbar)) {
    self.proxbar destroyelem();
  }

  if(isDefined(self.proxbartext)) {
    self.proxbartext destroyelem();
  }
}

function gethostplayer() {
  players = getEntArray("player", "classname");

  for(index = 0; index < players.size; index++) {
    if(players[index] ishost()) {
      return players[index];
    }
  }
}

function function_8464fd951b451534(ignoreplayer) {
  foreach(player in level.players) {
    if(!isbot(player)) {
      if(isDefined(ignoreplayer) && ignoreplayer != player) {
        return true;
      }
    }
  }

  return false;
}

function hostidledout() {
  hostplayer = gethostplayer();

  if(isDefined(hostplayer) && !hostplayer.hasspawned && !isDefined(hostplayer.selectedclass)) {
    return true;
  }

  return false;
}

function roundendwait(defaultdelay) {
  if(!level.doeomcombat) {
    wait level.postgamehitmarkerwaittime + 0.1;
    setomnvarforallclients("post_game_state", 2);
  }

  var_8d539c1577794d34 = 0;

  foreach(player in level.players) {
    player thread setuipostgamefade(0);

    if(player iscodcaster()) {
      var_8d539c1577794d34 = level.var_7210bb7b0bfbcfdb;
    }
  }

  wait defaultdelay;
  wait var_8d539c1577794d34;
  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

function roundenddof(time) {
  setdof_spectator();
}

function setwaypointiconinfo(name, bgtype, teamrelative, string, icon, pulses, iconid) {
  level.waypointcolors[name] = teamrelative;
  level.waypointbgtype[name] = bgtype;
  level.waypointstring[name] = string;
  level.waypointshader[name] = icon;
  level.waypointpulses[name] = pulses;
  level.var_ed9acfb4a79fb6be[name] = iconid;
}

function initwaypointbackgrounds() {
  var_a443300a7cc92ef0 = 0;

  switch (getgametype()) {
    case #"hash_1e4846dca3ccf38":
    case #"hash_4cb5825e78aaa8c":
    case #"hash_ca6516c10db2c95":
    case #"hash_1b1eecd3863a50cf":
    case #"hash_2f5af599c5c220d3":
    case #"hash_3ae8dcf2840c03a0":
    case #"hash_53825b446469ac4c":
    case #"hash_63fb0ba698c46db3":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8c758b84936e8d42":
    case #"hash_99a69534b169e838":
    case #"hash_9ccabb62c3d37fb0":
    case #"hash_a1313b745c17c07e":
    case #"hash_d82d642e83fb9772":
    case #"hash_f25c018be2dd3f5f":
    case #"hash_f4a9126c03d3385b":
    case #"hash_fa44d9f6bd7a2fa1":
      setwaypointiconinfo("icon_waypoint_dom_a", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("icon_waypoint_dom_b", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("icon_waypoint_dom_c", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("icon_waypoint_dom_d", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_e", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_f", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_g", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_h", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_i", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_taking_a", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_taking_b", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_taking_c", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_taking_d", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_taking_e", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_taking_f", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_taking_g", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_taking_h", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_taking_i", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_capture_a", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_capture_b", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_capture_c", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_capture_d", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_capture_e", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_capture_f", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_capture_g", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_capture_h", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_capture_i", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_defend_a", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defend_b", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defend_c", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defend_d", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defend_e", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defend_f", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defend_g", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_defend_h", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_defend_i", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_defending_a", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defending_b", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defending_c", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defending_d", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defending_e", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defending_f", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defending_g", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_defending_h", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_defending_i", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_blocking_a", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_blocking_b", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_blocking_c", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_blocking_d", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_e", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_f", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_g", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_h", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_i", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_a", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_blocked_b", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_blocked_c", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_blocked_d", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_e", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_f", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_g", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_h", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_i", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_losing_a", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_losing_b", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_losing_c", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_losing_d", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_losing_e", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_losing_f", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_losing_g", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_losing_h", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_losing_i", var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_captureneutral_a", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_captureneutral_b", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_captureneutral_c", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_captureneutral_d", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_e", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_f", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_g", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_h", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_i", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_contested_a", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_contested_b", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_contested_c", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_contested_d", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_contested_e", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_contested_f", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_contested_g", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_contested_h", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_contested_i", var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_dom_target_a", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_dom_target_b", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_dom_target_c", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_dom_target_d", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_e", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_f", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_g", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_h", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_i", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_clearing_a", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_clearing_b", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_clearing_c", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_clearing_d", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_e", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_f", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_g", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_h", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_i", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_a", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_reinforcing_b", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_reinforcing_c", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_reinforcing_d", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_e", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_f", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_g", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_h", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_i", var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_locked_a", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 3);
      setwaypointiconinfo("waypoint_locked_b", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 5);
      setwaypointiconinfo("waypoint_locked_c", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 7);
      setwaypointiconinfo("waypoint_locked_d", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_e", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_f", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_g", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_h", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_i", var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_captured", var_a443300a7cc92ef0, "codcaster", "", "esports_codcaster_minimap_checkmark", 0, 11);
      break;
    case #"hash_514cd9d568e312b0":
    case #"hash_aac44b0b52bacb8e":
    case #"hash_dd217fc2f74cbcdd":
    case #"hash_fa0ed2f6bd4f4395":
    case #"hash_fa50b0f6bd82e972":
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
    case #"hash_9a6f07d0214a87db":
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
    case #"hash_214e6c6c1b43ae4a":
    case #"hash_aada280b52cbdd96":
    case #"hash_c7f4420f385eeb3d":
    case #"hash_fa34c5f6bd6d4432":
      setwaypointiconinfo("hq_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_DESTROY_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2);
      setwaypointiconinfo("hq_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_hq", 0, 1);
    case #"hash_c065cef60f38490a":
      setwaypointiconinfo("carepackage_incoming", 1, "neutral", "MP_INGAME_ONLY/INCOMING_OBJ_CAPS", "hud_icon_killstreak_carepackage", 0, undefined);
      setwaypointiconinfo("carepackage", 1, "neutral", "", "hud_icon_killstreak_carepackage", 0, undefined);
      break;
    default:
      break;
  }

  if(getgametype() == "conf_v") {
    setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_vial", 0, 15);
    setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_vial", 0, 15);
  } else {
    setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_misc_dog_tag", 0, 15);
    setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_misc_dog_tag", 0, 15);
  }

  setwaypointiconinfo("icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, undefined);
  setwaypointiconinfo("waypoint_capture_kill", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined);
  setwaypointiconinfo("waypoint_escort", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort", 0, undefined);
}

function function_1765528a2562ebf8(clientnumvalue) {
  println("<dev string:x8b0>");

  if(isDefined(clientnumvalue)) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      playerclientnum = player getentitynumber();
      selectedplayer = player;

      if(playerclientnum == clientnumvalue) {
        println("<dev string:x8f1>" + clientnumvalue + "<dev string:x927>" + playerclientnum + "<dev string:x947>" + player.name);
        playerarray = getteamdata(player.team, "players");

        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          selectedplayer = player getothersplitscreenplayer();
        }

        if(isDefined(selectedplayer.var_a111e3eabe27d512)) {
          selectedplayer.var_a111e3eabe27d512 = !selectedplayer.var_a111e3eabe27d512;
        } else {
          selectedplayer.var_a111e3eabe27d512 = 1;
        }

        hostxuid = getteamdata(player.team, "playagainHostXuid");
        playerxuid = selectedplayer getxuid();

        if(selectedplayer.var_a111e3eabe27d512) {
          if(hostxuid == "0") {
            println("<dev string:x961>" + clientnumvalue + "<dev string:x947>" + player.name + "<dev string:x990>" + playerxuid);
            setteamdata(player.team, "playagainHostXuid", playerxuid);
          }
        } else if(hostxuid == playerxuid) {
          println("<dev string:x961>" + clientnumvalue + "<dev string:x947>" + player.name + "<dev string:x9c1>");
          var_f7795a328ac962d5 = "0";

          foreach(teammate in playerarray) {
            if(isDefined(teammate) && !isbot(teammate) && teammate issplitscreenplayerprimary()) {
              var_f7795a328ac962d5 = teammate getxuid();
              break;
            }
          }

          setteamdata(player.team, "playagainHostXuid", var_f7795a328ac962d5);
        }

        if(istrue(matchmakinggame())) {
          if(isDefined(player) && player isfireteamleader()) {
            var_8015767bddc80d67 = player getfireteammembers();

            foreach(member in var_8015767bddc80d67) {
              if(!isDefined(member)) {
                continue;
              }

              memberclientnum = member getentitynumber();

              if(memberclientnum != playerclientnum) {
                if(isDefined(member.var_a111e3eabe27d512)) {
                  member.var_a111e3eabe27d512 = !member.var_a111e3eabe27d512;
                } else {
                  member.var_a111e3eabe27d512 = 1;
                }

                foreach(teammate in playerarray) {
                  if(isDefined(teammate)) {}
                }
              }
            }
          }
        }

        break;
      }
    }
  }
}

function function_c3365e6cf89ada44() {
  println("<dev string:xa08>");
  hostidx = 0;

  if(!privatematch() && !scripts\mp\gametypes\br_public::isbrpracticemode()) {
    var_2fd13845453e50e8 = [];

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.var_a111e3eabe27d512) && player.var_a111e3eabe27d512) {
        playerteam = player.team;
        playerteamchecked = 0;
        var_da0aca95052ad7d2 = var_2fd13845453e50e8.size;

        for(index = 0; index < var_da0aca95052ad7d2; index++) {
          if(var_2fd13845453e50e8[index] == playerteam) {
            playerteamchecked = 1;
          }
        }

        if(!playerteamchecked) {
          var_2fd13845453e50e8[var_da0aca95052ad7d2] = playerteam;
          teamarray = getteamdata(playerteam, "players");
          var_6d13f1bf72d13931 = [];
          playagainhostxuid = getteamdata(playerteam, "playagainHostXuid");

          foreach(player in teamarray) {
            if(!isDefined(player)) {
              continue;
            }

            println("<dev string:xa33>" + player.name + "<dev string:xa5b>" + player.team);

            if(isDefined(player.var_a111e3eabe27d512) && player.var_a111e3eabe27d512) {
              println("<dev string:xa73>" + player.name + "<dev string:xa5b>" + player.team + "<dev string:xaae>" + playagainhostxuid);
              var_6d13f1bf72d13931[var_6d13f1bf72d13931.size] = player;
            }
          }

          playagain(var_6d13f1bf72d13931, playagainhostxuid);
          waitframe();
        }
      }
    }
  }
}

function function_b782e1ea0877f735() {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  playerposition = 0;

  while(true) {
    endgamesplash = getdvarint(@ "hash_4f6750c34be606ee");

    if(isDefined(level.players[0])) {
      playerposition = level.players[0] getclientomnvar("ui_br_player_position");
    }

    switch (endgamesplash) {
      case 1:
        if(playerposition != 1) {
          level.players[0] setclientomnvar("ui_br_player_position", 1);
          wait 8;
          level.players[0] setclientomnvar("ui_br_player_position", 150);
        }

        break;
      case 2:
        if(playerposition != 4) {
          level.players[0] setclientomnvar("ui_br_player_position", 4);
          wait 8;
          level.players[0] setclientomnvar("ui_br_player_position", 5);
        }

        break;
      case 3:
        if(playerposition != 22) {
          level.players[0] setclientomnvar("ui_br_player_position", 22);
          wait 8;
          level.players[0] setclientomnvar("ui_br_player_position", 150);
        }

        break;
      case 4:
        if(playerposition != 15) {
          level.players[0] setclientomnvar("ui_br_player_position", 15);
          wait 8;
          level.players[0] setclientomnvar("ui_br_player_position", 150);
        }

        break;
      default:
        break;
    }

    waitframe();
  }
}

function callback_startgametype() {
  scripts\mp\load::main();

  if(!isDefined(game["roundsPlayed"])) {
    if(analyticsstreamerislogfilestreamingenabled()) {
      analyticsstreamerlogfilestartstream();
    }

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
  flags::levelflaginit("over_time_entered", 0);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
  level.postgamenotifies = 0;
  level.intermission = 0;
  level.var_7210bb7b0bfbcfdb = getdvarfloat(@ "hash_cba7d6083c9553b8");
  setDvar(@ "hash_8ed4dff39f3251f5", getdvarint(@ "scr_game_forceuav") == 1);
  setDvar(@ "hash_ed150ed3d105dab0", istrue(level.noweaponfalloff));
  setomnvar("ui_round_winner", 0);

  if(getdvarint(@ "scr_player_allowarmor", 0) == 1) {
    if(!isDefined(level.armoronweaponswitchlongpress)) {
      level.armoronweaponswitchlongpress = 1;
    }
  }

  setDvar(@ "bg_piggybackarmoronnvg", istrue(level.armoronweaponswitchlongpress));

  if(matchmakinggame()) {
    setDvar(@ "hash_ccf9753c4ee466cc", 1);
  } else {
    setDvar(@ "hash_ccf9753c4ee466cc", 0);
  }

  level thread initwaypointbackgrounds();

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    game["truncated_killcams"] = 0;
    game["life_count"] = 0;

    if(!isDefined(game["attackers"]) || !isDefined(game["defenders"])) {
      thread error("No attackers or defenders team defined in level .gsc.");
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
    game["strings"]["down_give_up"] = &"MP/DOWN_GIVE_UP";
    level scripts\mp\utility\lower_message::function_5a98c45a6252b4a();
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
    setdvarifuninitialized(@ "hash_4e2f47a7b2856857", 5);

    if(!level.splitscreen) {
      level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
      level.prematchperiodend = getdvarint(@ "scr_game_matchstarttime", 15);

      level.prematchperiodend = getdvarint(@ "scr_game_matchstarttime", 0);
      level.prematchperiodend = getdvarint(@ "scr_dev_matchstarttime", level.prematchperiodend);
    }

    if(function_1eb7d2791d3c536f()) {
      setnojipscore(1, 1);
      setnojiptime(1, 1);
    } else {
      setnojipscore(0, 1);
      setnojiptime(0, 1);
    }
  } else {
    setdvarifuninitialized(@ "hash_4e2f47a7b2856857", 5);

    if(!level.splitscreen) {
      scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
      level.prematchperiodend = getdvarint(@ "hash_da33635b62d4e5b3", 5);
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
    game["team_four"] = "ZVIR";
  }

  if(!isDefined(game["team_five"])) {
    game["team_five"] = "ICORPS";
  }

  if(!isDefined(game["team_six"])) {
    game["team_six"] = "GRP9";
  }

  if(!isDefined(game["status"])) {
    game["status"] = "normal";
  }

  setDvar(@ "ui_overtime", inovertime());

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

  level.currentclientmatchdataid = 0;
  level.gameended = 0;
  level.forcedend = 0;
  level.hostforcedend = 0;
  setdvarifuninitialized(@ "debug_stopafkcheck", 0);

  setDvar(@ "debug_stopafkcheck", 0);

  setdvarifuninitialized(@ "hash_e32ebdbb97a1ec4e", 0);
  level.disablepersonalnuke = isanymlgmatch();

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    logstring("game modifier: tier 1 mode");
  } else if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    logstring("game modifier: hardcore mode");
  }

  level.thirdpersonmode = getdvarint(@ "scr_thirdperson");
  level.diehardmode = getdvarint(@ "hash_4a2b3d01a81655a6");
  level.casualscorestreaks = getdvarint(@ "scr_game_casualscorestreaks");
  level.wrapkillstreaks = getdvarint(@ "scr_game_wrapkillstreaks");

  if(!isDefined(level.crankedbombtimer)) {
    level.crankedbombtimer = getdvarint(hashcat(@ "scr_", getgametype(), "_crankedBombTimer"), 0);
  }

  level.supportcranked = ter_op(getdvarint(hashcat(@ "scr_", getgametype(), "_crankedBombTimer")) > 0, 1, 0);

  if(!level.teambased) {
    level.diehardmode = 0;
  }

  if(level.diehardmode) {
    logstring("game mode: diehard");
  }

  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_vampirism"), @ "hash_b5e336c86438398c");

  if(level.matchrules_vampirism) {
    level.modifyplayerdamage = &scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  level.finalkillcamtype = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_killcamType"), @ "hash_769d7362e31fdf55");

  if(level.finalkillcamtype == 2) {
    level.skipfinalkillcam = 1;
  }

  if(level.finalkillcamtype == 1 && getdvarint(@ "hash_6625c2cb0de90a41", 0) == 0) {
    level.finalkillcamtype = 0;
  }

  level.allowkillstreaks = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_allowKillstreaks"), @ "scr_game_allowkillstreaks");
  level.roundretainstreaks = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_roundRetainStreaks"), @ "hash_29a0f7140921aa26");
  level.roundretainstreakprog = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_roundRetainStreakProg"), @ "hash_3aff5631b3f222a9");
  level.deathretainstreaks = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_deathRetainStreaks"), @ "hash_30e6d371dab88960");
  level.allowperks = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_allowPerks"), @ "scr_game_allowperks");
  level.allowsupers = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_allowSupers"), @ "scr_game_allowsupers");
  level.superfastchargerate = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_superFastChargeRate"), @ "scr_game_superfastchargerate");
  level.superpointsmod = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_superPointsMod"), @ "scr_game_superpointsmod");
  level.spawnprotectiontimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_spawnProtectionTimer"), @ "hash_fbc77dbb0cf44cc7");
  level.lethaldelay = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lethalDelay"), @ "scr_game_lethaldelay");
  level.equipmentmatchstartshieldms = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_equipmentMSProtect"), @ "hash_9072002890a9a121") * 1000;
  level.magcount = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_magcount"), @ "scr_game_magcount");

  if(!isDefined(level.practiceround)) {
    level.practiceround = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_practiceRound"), @ "hash_3672666b944c115");
  }

  level.postgameexfil = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_postGameExfil"), @ "hash_d2de59939486bd5a");
  level.exfilactivetimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_exfilActiveTimer"), @ "hash_645019bc959ffaf9");
  level.exfilextracttimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_exfilExtractTimer"), @ "hash_96dd663f32dba868");
  level.useammorestocklocs = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_useAmmoRestockLocs"), @ "hash_d7c8c17cb33a48f7");
  level.agentskillstreakcount = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_agent_kills_killstreak_count"), @ "hash_46eaad837c804540");

  if(isDefined(level.var_5622bf44905e2b1a)) {
    [[level.var_5622bf44905e2b1a]]();
  }

  level.spectate3rdallowed = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_allow3rdspectate"), @ "scr_game_allow3rdspectate");
  setDvar(@ "hash_4871f220778a4649", level.spectate3rdallowed);
  level.var_7ebad80a50484a39 = getdvarint(@ "hash_8d427bce0148af0e", 0) || getgametype() == "conf_v";
  scripts\mp\teamrevive::init();

  if(issubgametype()) {
    checkforsubgametypeoverrides();
  }

  level.minimaponbydefault = (getdvarint(@ "scr_game_enableminimap") != 0 || getdvarint(@ "hash_bc802deb1ff2a842") != 0) && !istrue(game["isLaunchChunk"]) && !scripts\cp_mp\utility\game_utility::function_21322da268e71c19();
  currentgametype = getgametype();
  level.radarhideshots = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", currentgametype, "_radarHidePings"), @ "scr_game_radarhidepings");
  setomnvar("ui_compass_hide_weapon_pings_minimap", level.radarhideshots);
  level.navbarhideshots = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", currentgametype, "_navBarHidePings"), @ "scr_game_navbarhidepings");
  setomnvar("ui_compass_hide_weapon_pings_navbar", level.navbarhideshots);
  level.navbarhideenemies = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", currentgametype, "_navBarHideEnemy"), @ "scr_game_navbarhideenemy");
  setomnvar("ui_compass_hide_enemy_navbar", level.navbarhideenemies);
  level.disablesupersprint = getdvarint(@ "scr_player_disablesupersprint");
  level.disablemount = getdvarint(@ "hash_215eb9aef94dd47e");
  level.disablebattlechatter = getdvarint(@ "hash_b8a0aa5681c2aa39");
  level.disableannouncer = getdvarint(@ "hash_94af58bec500b3b9");
  level.scoremod = [];
  level.scoremod["kill"] = getdvarint(hashcat(@ "scr_", getgametype(), "_pointsPerKill"));
  level.scoremod["death"] = getdvarint(hashcat(@ "scr_", getgametype(), "_pointsPerDeath"));
  level.scoremod["headshot"] = getdvarint(hashcat(@ "scr_", getgametype(), "_pointsHeadshotBonus"));
  level.scoremod["kskill"] = getdvarint(hashcat(@ "scr_", getgametype(), "_pointsPerKSKill"));

  if(level.practiceround && !isDefined(game["practiceRound"])) {
    game["practiceRound"] = 1;
    level.roundretainstreaks = 0;
    level.roundretainstreakprog = 0;
    level.ignorescoring = 1;
    game["dialog"]["offense_obj"] = "gamestate_practice";
    game["dialog"]["defense_obj"] = "gamestate_practice";
  }

  if(!isDefined(game["gameLength"])) {
    game["gameLength"] = 0;
  }

  if(getdvarint(@ "hash_ac31997b109b6bc5", 0) == 1) {
    game["attackers"] = "axis";
    game["defenders"] = "allies";
  }

  setomnvar("ui_match_timer_hidden", 1);
  isarenamap = scripts\cp_mp\utility\game_utility::isarenamap();

  if(isarenamap && getgametype() != "warrior" || function_4ef12b6ed882dc9b()) {
    level.allowkillstreaks = 0;
    level.allowsupers = 0;
    setomnvar("ui_disable_killstreaks", 1);
    setomnvar("ui_disable_fieldupgrades", 1);
  } else if(level.headhunterenabled) {
    level.allowkillstreaks = 0;
    setomnvar("ui_disable_killstreaks", 1);
    setomnvar("ui_disable_fieldupgrades", 0);
  } else {
    setomnvar("ui_disable_killstreaks", 0);
    setomnvar("ui_disable_fieldupgrades", 0);
  }

  level.disablecopycatloadout = 1;
  setomnvar("ui_killcam_copycat", 0);
  scripts\cp_mp\utility\game_utility::getlocaleid();

  println("<dev string:xabe>");
  println("<dev string:xace>");
  println("<dev string:xaf7>" + level.script);
  println("<dev string:xb11>" + getgametype());
  println("<dev string:xb2b>" + scripts\cp_mp\utility\game_utility::function_21322da268e71c19());
  println("<dev string:xb45>" + scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924());
  println("<dev string:xb5f>" + level.diehardmode);
  println("<dev string:xb74>" + getdvarint(@ "scr_thirdperson"));
  println("<dev string:xb89>" + getdvarint(@ "camera_thirdperson"));
  println("<dev string:xba3>" + game["<dev string:x8a0>"]);
  println("<dev string:xbb8>" + getgametype() + "<dev string:xbc2>" + getDvar(hashcat(@ "scr_", getgametype(), "<dev string:xbd2>")));
  println("<dev string:xbb8>" + getgametype() + "<dev string:xbe1>" + getDvar(hashcat(@ "scr_", getgametype(), "<dev string:xbf1>")));
  println("<dev string:xbb8>" + getgametype() + "<dev string:xc00>" + getDvar(hashcat(@ "scr_", getgametype(), "<dev string:xc0e>")));
  println("<dev string:xbb8>" + getgametype() + "<dev string:xc1b>" + getDvar(hashcat(@ "scr_", getgametype(), "<dev string:xc2a>")));
  println("<dev string:xbb8>" + getgametype() + "<dev string:xc38>" + getDvar(hashcat(@ "scr_", getgametype(), "<dev string:xc46>")));
  println("<dev string:xbb8>" + getgametype() + "<dev string:xc53>" + getDvar(hashcat(@ "scr_", getgametype(), "<dev string:xc61>")));
  println("<dev string:xbb8>" + getgametype() + "<dev string:xc6e>" + getDvar(hashcat(@ "scr_", getgametype(), "<dev string:xc7f>")));
  println("<dev string:xace>");

  level.usestartspawns = 1;
  level thread scripts\mp\infilexfil\infilexfil::infil_init();
  scripts\mp\utility\spawn_event_aggregator::init();
  scripts\mp\utility\lui_game_event_aggregator::init();
  scripts\mp\utility\connect_event_aggregator::init();
  scripts\mp\utility\player_frame_update_aggregator::init();
  namespace_d9d9691c846bdad7::init();
  namespace_a2c409363d7f24e7::init();
  scripts\cp_mp\ent_manager::init();
  scripts\mp\playerlogic::init();
  scripts\cp_mp\utility\game_utility::initchallengeandeventglobals();
  gametype = getgametype();
  level.var_6706aad138cbc31d = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_ffPunishDamageLimit"), @ "hash_3b51bf9adf9c599");
  level.var_843399bee19793fe = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_ffKickDamageLimit"), @ "hash_bd496f8d66908cb0");
  level.maxallowedteamkills = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_ffPunishLimit"), @ "hash_46055360c134e4f6");
  thread namespace_1bb1b009684a30dc::init();
  thread scripts\mp\teams::init();
  scripts\cp_mp\utility\team_utility::function_a92ed2f4c44e5ffa();
  scripts\cp_mp\squads::init();
  scripts\cp_mp\utility\player_utility::initdismembermentlist();
  scripts\cp_mp\utility\game_utility::values_init();
  thread scripts\common\shellshock_utility::init();
  thread scripts\cp_mp\utility\game_utility::game_utility_init();
  thread scripts\mp\playerhealth::init();
  thread scripts\cp_mp\challenges::init();
  level.var_c36a65204e26168e = 1;
  level.var_1fa9e6ecce90d2c2 = 0;

  if(issharedfuncdefined("display_transition", "using_new_transitions")) {
    level.var_1fa9e6ecce90d2c2 = [[getsharedfunc("display_transition", "using_new_transitions")]]();
  }

  thread scripts\mp\killcam::init();
  thread scripts\mp\final_killcam::initfinalkillcam();
  namespace_46e942396566f2da::function_3b59b4d385a202e6();
  scripts\mp\utility\dialog::initstatusdialog();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread scripts\mp\battlechatter_mp::init();
  } else if(!runleanthreadmode()) {
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
  thread scripts\cp_mp\damagefeedback::damagefeedback_init();
  thread scripts\mp\lightarmor::init();
  thread scripts\mp\gameobjects::init();
  thread scripts\mp\spectating::init();
  thread scripts\mp\spawnlogic::init();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread scripts\mp\brmatchdata::init();
    thread scripts\mp\brclientmatchdata::init();
  } else {
    thread scripts\mp\matchdata::init();
    thread scripts\mp\clientmatchdata::init();
  }

  thread scripts\mp\awards::init();
  thread scripts\mp\utility\points::initpoints();
  thread scripts\mp\playerlogic::initsegmentstats();

  if(!runleanthreadmode()) {
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&scripts\cp_mp\utility\player_utility::updateinputtypewatcher);
  }

  scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&scripts\mp\weapons::grenadehealthatdeathframeupdatecallback);
  namespace_bf9ffd2b22c7d819::main();
  thread namespace_8885c19c053dcb46::init();

  if(level.leagueplaymatch) {
    scripts\mp\leagueplay::init();
  }

  if(level.var_77907d733abe8b63) {
    namespace_2c7976a64ea24d6a::init();
  }

  thread scripts\mp\passives::init();
  thread scripts\mp\perks\perks::init();
  feature_init::function_a114d6863af2f149();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
    thread namespace_9246f10206f50768::function_7dcad89b9c0264a6();
    thread scripts\cp_mp\killstreaks\init::init();
    thread scripts\mp\perks\perks::initspecialistkillstreaks();
  }

  if(!istrue(level.disablescoreevents)) {
    thread scripts\mp\events::events_init();
  }

  thread scripts\mp\archetypes\archcommon::init();

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    scripts\mp\online_event::init();
  }

  if(!runleanthreadmode()) {
    thread scripts\mp\whizby::init();
  }

  thread scripts\common\telemetry::init();
  thread scripts\mp\analyticslog::init();
  thread namespace_e77194a0203f683::init();
  thread namespace_30dbbb8647994e6e::init();
  thread namespace_d564b97030b0868::init();
  level scripts\cp_mp\armor::init();

  if(!istrue(game["isLaunchChunk"])) {
    if(istrue(level.droparmorondeath)) {
      thread scripts\cp_mp\utility\loot::init();
    }

    thread scripts\mp\loot::init();
    thread scripts\mp\supers::init();
    thread scripts\mp\supers::watchsuperdelay();
  }

  thread scripts\mp\callouts::init();
  thread scripts\mp\bounty::init();
  thread allow_weapon_mp_init();
  thread ismp_init();
  level.players thread function_b782e1ea0877f735();
  thread scripts\cp_mp\gestures::init();
  thread scripts\mp\gestures_mp::init_mp();
  thread scripts\cp_mp\execution::execution_init();
  thread scripts\mp\sentientpoolmanager::init();
  thread scripts\mp\objidpoolmanager::init();
  thread scripts\mp\arbitrary_up::initarbitraryuptriggers();
  thread namespace_f77f8b2f20f85e34::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\mp\turret::init();
  }

  thread scripts\cp_mp\laststand::init();
  thread scripts\mp\laststand::init();
  thread scripts\mp\equipment::init();
  thread scripts\mp\matchstats::init();
  thread scripts\mp\playerstats::init();

  if(getdvarint(@ "hash_81a618a6e6973ed3", 0) == 1) {
    thread namespace_144a3b0d146004de::init();
  }

  thread scripts\mp\focus::init();

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
    thread scripts\common\elevators::initelevators();
  }

  thread scripts\mp\hud_message::init();
  thread scripts\mp\hud_popup::init();
  level.allowreviveweapons = getdvarint(@ "hash_df1ae5a11f519ab5", 0);
  val::group_register("reviveShoot", ["weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload"]);
  val::group_register("gameEndFreeze", ["usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "stance_change", "melee"]);
  thread scripts\mp\accolades::init();
  thread scripts\mp\ammorestock::init();
  thread scripts\mp\meatshield::init();

  if(getdvarint(@ "scr_game_allow_loot") == 1) {
    scripts\mp\gametypes\br_pickups::br_pickups_init();
    scripts\mp\gametypes\br_plunder::init();
  }

  level scripts\cp_mp\overlord::init();
  level scripts\mp\bots\bots_loadout::init();
  level namespace_2db04a57a1b9bf62::init();
  level thread scripts\mp\utility\trigger::function_d7f524cd920e0c79();

  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(!isDefined(game["roundsWon"][team])) {
        game["roundsWon"][team] = 0;
      }

      if(!isDefined(game["teamScores"][team])) {
        game["teamScores"][team] = 0;
      }
    }
  }

  if(game["status"] != "overtime" && game["status"] != "halftime") {
    if(!(game["roundsPlayed"] > 0 && ismoddedroundgame()) && resetscoreonroundstart()) {
      game["teamScores"]["allies"] = 0;
      game["teamScores"]["axis"] = 0;
    }
  }

  setomnvar("ui_in_overtime_round", game["status"] == "overtime");
  game["gamestarted"] = 1;
  level.currentround = game["roundsPlayed"] + 1;
  level.maxplayercount = 0;
  level.activeplayers = [];

  foreach(entry in level.teamnamelist) {
    level.wavedelay[entry] = 0;
    level.lastwave[entry] = 0;
    level.waveplayerspawnindex[entry] = 0;
    level.aliveplayers[entry] = [];

    if(!istrue(level.requiredplayercountoveride)) {
      level.requiredplayercount[entry] = 0;
    }
  }

  setomnvar("ui_scorelimit", 0);
  setDvar(@ "ui_allow_teamchange", 1);

  if(!istrue(game["isLaunchChunk"])) {
    setomnvar("ui_round_hint_override_attackers", 0);
    setomnvar("ui_round_hint_override_defenders", 0);
  }

  if(getgametypenumlives()) {
    setDvar(@ "g_deadchat", 0);
  } else {
    setDvar(@ "g_deadchat", 1);
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
  level.postgamehitmarkerwaittime = 0.25;
  level.scorelimit = getwatcheddvar("scorelimit");
  level.roundlimit = getwatcheddvar("roundlimit");
  level.winlimit = getwatcheddvar("winlimit");

  if(istrue(game["isLaunchChunk"])) {
    setomnvar("ui_current_round", level.currentround);
  } else if(level.roundlimit != 1) {
    setomnvar("ui_current_round", level.currentround);
  }

  if(getgametype() == "warrior") {
    level.roundscorelimit = level.scorelimit;
    level.totalscorelimit = level.scorelimit * level.roundlimit;
  } else if(isDefined(level.var_abaccd362e5a9da1) && level.var_abaccd362e5a9da1) {
    level.roundscorelimit = level.scorelimit * (game["roundsPlayed"] + 1);
    level.totalscorelimit = level.scorelimit * int(ceil(level.roundlimit / 2));
  } else if(level.scorelimit == 1) {
    level.roundscorelimit = 1;
    level.totalscorelimit = level.winlimit;
  } else {
    level.roundscorelimit = level.scorelimit * (game["roundsPlayed"] + 1);
    level.totalscorelimit = level.scorelimit * level.roundlimit;
  }

  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 1) {
    scripts\mp\gamestaterestore::restoreteamscores();
  }

  if(resetscoreonroundstart()) {
    level.roundscorelimit = level.scorelimit;
    level.totalscorelimit = level.scorelimit;
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
  }

  if(isovertimesupportedgametype() && inovertime()) {
    scripts\mp\gamescore::updateovertimescore();
  }

  if(level.teambased) {
    foreach(entry in level.teamnamelist) {
      scripts\mp\gamescore::updateteamscore(entry);
    }
  }

  thread updateuiscorelimit();
  level notify("update_scorelimit");

  if(isDefined(level.matchrecording_init)) {
    level thread[[level.matchrecording_init]]();
  }

  if(getdvarint(@ "scr_allow_custom_loadouts", 0) == 0 || function_1e098780c33853f2() && !function_f24e99a2f548d0b8() && !ismutationgamemode() && !scripts\mp\gametypes\war::function_2898a9c3d425a919() || isjuggermoshgamemode()) {
    setomnvar("ui_only_default_loadouts", 1);
  }

  scripts\mp\gametypes\common::commononstartgametype();
  [[level.onstartgametype]]();
  level scripts\engine\utility::flag_set("onStartGameTypeFinished");

  if(isDefined(level.var_952bd6e10104d8a)) {
    if(getdvarint(@ "hash_7a6c6ee4d8db3bbd", 0) == 0) {
      [[level.var_952bd6e10104d8a]]();
    }
  }

  setattackingteam();
  level thread scripts\mp\gametypes\common::onplayerconnectcommon();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&scripts\mp\gametypes\common::onplayerdisconnectcommon);
  level.scorepercentagecutoff = getdvarint(hashcat(@ "scr_", getgametype(), "_score_percentage_cut_off"), 70);
  level.timepercentagecutoff = getdvarint(hashcat(@ "scr_", getgametype(), "_time_percentage_cut_off"), 70);

  setdvarifuninitialized(@ "hash_ff657c87711b0cd6", 1);

  if(getdvarint(@ "hash_ff657c87711b0cd6", 1)) {
    level.scorepercentagecutoff = 100;
    level.timepercentagecutoff = 100;
  }

  if(getbuildversion() != "SHIP") {
    thread[[level.devinit]]();
  }

  level thread scripts\common\dof::function_9030ff462f3daa1a();

  if(getDvar(@ "dedicated") == "dedicated LAN server" || getDvar(@ "dedicated") == "dedicated internet server") {
    thread verifydedicatedconfiguration();
  }

  namespace_f5675568ccc8acc6::function_6fc852802774b304(0, 0);
  thread startgame();
  level thread updatewatcheddvars();

  if(!istrue(level.istacops)) {
    level thread timelimitthread();
  }

  level thread updateleaderboardstatscontinuous();
  level thread removepatchablecollision_delayed();
  level scripts\engine\utility::flag_set("StartGameTypeCallbackFinished");

  if(isfirstround()) {
    level thread callbackserverstart();
  }
}

function callbackserverstart() {
  if(getdvarint(@ "hash_830d682c147b23bb", 0) > 0) {
    level waittill("telemetry_init");
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_server_start");
}

function updatewavespawndelay(newwavedelay, var_ab1e2d0bc30658b0) {
  if(isDefined(newwavedelay)) {
    setdynamicdvar(hashcat(@ "scr_", getgametype(), "_waverespawndelay"), newwavedelay);
  }

  if(isDefined(var_ab1e2d0bc30658b0)) {
    setdynamicdvar(hashcat(@ "scr_", getgametype(), "_waverespawndelay_alt"), var_ab1e2d0bc30658b0);
  }

  wavedelay = getdvarint(hashcat(@ "scr_", getgametype(), "_waverespawndelay"));
  wavedelay_alt = getdvarint(hashcat(@ "scr_", getgametype(), "_waverespawndelay_alt"));
  var_26eec74e639ec81d = isDefined(level.respawndelaytype) && level.respawndelaytype == 1;

  if(wavedelay || var_26eec74e639ec81d) {
    if(!var_26eec74e639ec81d) {
      foreach(entry in level.teamnamelist) {
        level.wavedelay[entry] = wavedelay;
        level.lastwave[entry] = 0;
      }
    } else {
      if(!istrue(game["switchedsides"])) {
        level.wavedelay[game["attackers"]] = level.attackersrespawndelay;
        level.wavedelay[game["defenders"]] = level.defendersrespawndelay;
      } else {
        level.wavedelay[game["attackers"]] = level.defendersrespawndelay;
        level.wavedelay[game["defenders"]] = level.attackersrespawndelay;
      }

      level.lastwave[game["attackers"]] = 0;
      level.lastwave[game["defenders"]] = 0;
    }

    level thread scripts\mp\gamelogic::wavespawntimer();
  }
}

function verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!getdvarint(@ "xblive_privatematch")) {
      exitlevel(0);
    }

    if(getDvar(@ "dedicated") != "dedicated LAN server" && getDvar(@ "dedicated") != "dedicated internet server") {
      exitlevel(0);
    }

    wait 5;
  }
}

function timelimitthread() {
  level endon("game_ended");
  prevtimepassed = gettimepassed();

  while(game["state"] == "playing") {
    waittillframeend();
    thread checktimelimit(prevtimepassed);
    prevtimepassed = gettimepassed();

    if(isDefined(level.starttime)) {
      if(gettimeremaining() < 3000 || istrue(level.forceotlogictorun)) {
        waitframe();
        continue;
      }
    }

    wait 1;
  }
}

function updateuiscorelimit() {
  for(;;) {
    level waittill_either("update_scorelimit", "update_winlimit");

    if(inovertime() || intimetobeat()) {
      if(istimetobeatrulegametype()) {
        foreach(player in level.players) {
          player setclientomnvar("ui_friendly_time_to_beat", ter_op(player.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          player setclientomnvar("ui_enemy_time_to_beat", ter_op(player.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", ter_op(istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(isscoretobeatrulegametype()) {
        foreach(player in level.players) {
          player setclientomnvar("ui_friendly_time_to_beat", ter_op(player.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          player setclientomnvar("ui_enemy_time_to_beat", ter_op(player.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", ter_op(istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(iswinbytworulegametype()) {
        defenderscore = game["roundsWon"][game["defenders"]];
        attackerscore = game["roundsWon"][game["attackers"]];
        targetscore = 0;

        if(defenderscore == attackerscore) {
          targetscore = defenderscore + 2;
        } else if(defenderscore > attackerscore) {
          targetscore = defenderscore + 1;
        } else {
          targetscore = attackerscore + 1;
        }

        setomnvar("ui_scorelimit", targetscore);
      } else {
        usenormalscorelimit();
      }

      continue;
    }

    usenormalscorelimit();
  }
}

function usenormalscorelimit() {
  if((!isroundbased() || !isobjectivebased() || ismoddedroundgame()) && getgametype() != "rescue" && getgametype() != "ballmode") {
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
  time = level.bombtimer;

  if(isDefined(level.defusetime)) {
    var_e5c7562119f14dc3 = level.defusetime + 1;
  } else {
    var_e5c7562119f14dc3 = 6;
  }

  while(true) {
    if(time > 15) {
      self playSound("ui_mp_suitcasebomb_timer");
      time -= 1;
      wait 1;
    } else if(time > var_e5c7562119f14dc3) {
      self playSound("ui_mp_suitcasebomb_timer_urgent");
      time -= 1;
      wait 1;
    } else {
      self playSound("ui_mp_timer_countdown_half_sec");
      time -= 0.5;
      wait 0.5;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function stoptickingsound() {
  self notify("stop_ticking");
}

function getclocksoundaliasfortimeleft(timeleft) {
  if(timeleft > 20) {
    return "ui_mp_timer_countdown";
  }

  if(timeleft > 10) {
    return "ui_mp_timer_countdown_10";
  }

  if(timeleft > 5) {
    return "ui_mp_timer_countdown_half_sec";
  }

  if(timeleft > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  }

  return "ui_mp_timer_countdown_1";
}

function timelimitclock() {
  level endon("cancel_announcer_dialog");
  waitframe();

  if(gettimelimit() == 0) {
    return;
  }

  if(istrue(level.var_92b187a00d3dd091)) {
    return;
  }

  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();
  var_98f7893e84443025 = 0;
  playedthirty = 0;
  var_dd0b8fe8f045aa9f = 0;

  if(scripts\cp_mp\utility\game_utility::function_a3a69db84e39e0b8() || getgametype() == "defuse" || getgametype() == "hc_defuse") {
    var_98f7893e84443025 = 1;
  }

  var_70e5d40612c9c78a = ter_op(isanymlgmatch(), 5, 2);

  while(game["state"] == "playing") {
    if(function_2e64aabc2f3d800b()) {
      timeleft = gettimeremaining() / 1000;
      timeleftint = int(timeleft + 0.5);
      var_a8088865fd3efd6d = 0;

      if(var_70e5d40612c9c78a == 2 && timeleftint % 2 == 1) {
        var_a8088865fd3efd6d = 1;
      }

      if(!var_98f7893e84443025 && (var_a8088865fd3efd6d == 1 && timeleftint == 61 || var_a8088865fd3efd6d == 0 && timeleftint == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_sixty");
        level notify("match_ending_soon", "time");
        var_98f7893e84443025 = 1;
      } else if(!playedthirty && (var_a8088865fd3efd6d == 1 && timeleftint == 31 || var_a8088865fd3efd6d == 0 && timeleftint == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_thirty");
        level notify("match_ending_soon", "time");
        playedthirty = 1;
      } else if(!var_dd0b8fe8f045aa9f) {
        if(var_a8088865fd3efd6d == 1 && timeleftint == 11 || var_a8088865fd3efd6d == 0 && timeleftint == 10) {
          level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_ten");
          var_dd0b8fe8f045aa9f = 1;
        } else if(var_a8088865fd3efd6d == 1 && timeleftint <= 2 || var_a8088865fd3efd6d == 0 && timeleftint <= 1) {
          level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
          var_dd0b8fe8f045aa9f = 1;
        }
      }

      if(timeleftint <= 10 || timeleftint <= 30 && timeleftint % var_70e5d40612c9c78a == var_a8088865fd3efd6d) {
        level notify("match_ending_very_soon");

        if(timeleftint == 0) {
          break;
        }

        if(!isDefined(level.overridetimelimitclock) || level.overridetimelimitclock >= timeleftint) {
          if(getgametype() != "defuse" && getgametype() != "hc_defuse") {
            clocksoundalias = getclocksoundaliasfortimeleft(timeleft);
            clockobject playSound(clocksoundalias);
          }
        }
      }

      if(timeleft - floor(timeleft) >= 0.05) {
        wait timeleft - floor(timeleft);
        continue;
      }
    }

    wait 1;
  }
}

function function_2e64aabc2f3d800b() {
  if(getgametype() == "defuse" || getgametype() == "hc_defuse") {
    return (!level.timerstopped && gettimelimit() && !istrue(level.var_423b7147b1256abd) && !istrue(level.var_d50739af5c160f54));
  }

  return !level.timerstopped && gettimelimit() && !istrue(level.bombsplanted) && !istrue(level.var_423b7147b1256abd) && !istrue(level.var_d50739af5c160f54);
}

function shouldmodelognotify() {
  switch (getgametype()) {
    case #"hash_5ff8e011d5b9d1c8":
    case #"hash_eb5e5f470e0c1dc2":
    case #"hash_fa50b0f6bd82e972":
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

  if(function_3b6961b424a382f() && getdvarint(@ "hash_49bbeacaa2e89deb", 0) != 0) {
    level.discardtime = 0;
  }

  level waittill("prematch_over");
  level.starttime = gettime();
  level.discardtime = 0;
  level.overtimetotal = 0;

  if(!isDefined(game["startTimeFromMatchStart"])) {
    game["startTimeFromMatchStart"] = gettime();
    level.starttimefrommatchstart = gettime();
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_match_start");
  }

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime -= game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundStartTimeSeconds", game["roundsPlayed"], getsystemtime());

    if(scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
      setomnvar("ui_round_start_time", getsystemtime());
    }
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_round_start");

  if(namespace_de6e6777b0937bd7::function_9ce94b15ee6758ee("callback_player_round_start")) {
    foreach(player in level.players) {
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_round_start", player);
    }
  }

  prevtime = gettime();

  while(game["state"] == "playing") {
    if(!level.timerstopped) {
      game["timePassed"] = game["timePassed"] + gettime() - prevtime;
    }

    prevtime = gettime();
    wait 1;
  }
}

function updatetimerpausedness(var_5a6706a7ded54bda) {
  shouldbestopped = level.timerstoppedforgamemode || isDefined(level.hostmigrationtimer);

  if(!level.timerstopped && shouldbestopped) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
    timeleft = gettimeremaining();

    if(isDefined(var_5a6706a7ded54bda)) {
      setgameendtime(int(var_5a6706a7ded54bda));
    } else {
      setgameendtime(gettime() + int(timeleft));
    }

    setomnvar("ui_match_timer_stop_time", level.timerpausetime);
    setomnvar("ui_match_timer_stopped", 1);
    return;
  }

  if(level.timerstopped && !shouldbestopped) {
    level.timerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
    timeleft = gettimeremaining();

    if(isDefined(var_5a6706a7ded54bda)) {
      setgameendtime(int(var_5a6706a7ded54bda));
    } else {
      setgameendtime(gettime() + int(timeleft));
    }

    setomnvar("ui_match_timer_stopped", 0);
  }
}

function pausetimer(gameovertime) {
  if(!level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 1;
    updatetimerpausedness(gameovertime);
  }
}

function resumetimer(gameovertime) {
  if(level.timerstoppedforgamemode) {
    level.timerstoppedforgamemode = 0;
    updatetimerpausedness(gameovertime);
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
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_prematch_over");
  scripts\mp\flags::gameflagset("prematch_done");
  level notify("prematch_over");
  setomnvar("ui_prematch_period", 0);
  level.var_5fbdcf40b68612a5 = gettime();

  foreach(player in level.players) {
    player scripts\mp\damage::resetattackerlist();
  }

  if(shouldmodelognotify() && game["roundsPlayed"] == 0) {
    logstring("IWH-315293: ELECTRICEEL: Prematch done");
  }

  updatetimerpausedness();
  timelimit = gettimelimit();

  if(timelimit > 0 && !scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    level thread waitthenshowtimer();
  } else {
    setomnvar("ui_match_timer_hidden", 1);
  }

  cleanpatchablecollision();
  thread timelimitclock();
  thread graceperiod();
  thread scripts\cp_mp\challenges::roundbegin();

  if(getdvarint(@ "party_maxplayers", 0) > 30) {
    setDvar(@ "hash_a85ba82ffd9faefe", 1);
  }

  thread scripts\mp\analyticslog::recordbreadcrumbdata();

  if(getdvarint(@ "hash_2745598e35a47913") == 1) {
    thread namespace_f5675568ccc8acc6::function_b6fd5f72a2973c10();
  }
}

function waitthenshowtimer() {
  setomnvar("ui_match_timer_hidden", 1);
  wait 0.25;
  setomnvar("ui_match_timer_hidden", 0);
}

function cleanpatchablecollision() {
  patch = [];
  patch[0] = getEnt("clip32x32x8", "targetname");
  patch[1] = getEnt("clip32x32x128", "targetname");
  patch[2] = getEnt("clip64x64x256", "targetname");
  patch[3] = getEnt("clip32x32x32", "targetname");
  patch[4] = getEnt("clip64x64x128", "targetname");
  patch[5] = getEnt("clip64x64x64", "targetname");
  patch[6] = getEnt("clip64x64x8", "targetname");
  patch[7] = getEnt("clip128x128x256", "targetname");
  patch[8] = getEnt("clip128x128x128", "targetname");
  patch[9] = getEnt("clip128x128x8", "targetname");
  patch[10] = getEnt("clip256x256x256", "targetname");
  patch[11] = getEnt("clip256x256x128", "targetname");
  patch[12] = getEnt("clip256x256x8", "targetname");
  patch[13] = getEnt("clip512x512x8", "targetname");
  patch[14] = getEnt("clip32x32x256", "targetname");
  patch[15] = getEnt("player32x32x8", "targetname");
  patch[16] = getEnt("player32x32x32", "targetname");
  patch[17] = getEnt("player32x32x128", "targetname");
  patch[18] = getEnt("player32x32x256", "targetname");
  patch[19] = getEnt("player64x64x256", "targetname");
  patch[20] = getEnt("player64x64x128", "targetname");
  patch[21] = getEnt("player64x64x64", "targetname");
  patch[22] = getEnt("player64x64x8", "targetname");
  patch[23] = getEnt("player128x128x256", "targetname");
  patch[24] = getEnt("player128x128x128", "targetname");
  patch[25] = getEnt("player128x128x8", "targetname");
  patch[26] = getEnt("player256x256x256", "targetname");
  patch[27] = getEnt("player256x256x128", "targetname");
  patch[28] = getEnt("player256x256x8", "targetname");
  patch[29] = getEnt("player512x512x8", "targetname");

  foreach(p in patch) {
    if(isDefined(p)) {
      p delete();
    }
  }
}

function wavespawntimer() {
  level endon("game_ended");
  level notify("waveSpawnTimer");
  level endon("waveSpawnTimer");

  while(game["state"] == "playing") {
    time = gettime();

    foreach(entry in level.teamnamelist) {
      if(time - level.lastwave[entry] > level.wavedelay[entry] * 1000) {
        level notify("wave_respawn_" + entry);
        level.lastwave[entry] = time;
        level.waveplayerspawnindex[entry] = 0;
      }
    }

    waitframe();
  }
}

function wavetimerwatcher() {
  level endon("waveSpawnTimer");

  while(true) {
    waittill_any_2("wave_respawn_allies", "wave_respawn_axis");
    setomnvar("ui_hardpoint_timer", gettime() + 1000 * level.wavedelay["allies"]);
  }
}

function getbetterteam() {
  kills = [];
  deaths = [];

  foreach(entry in level.teamnamelist) {
    kills[entry] = 0;
    deaths[entry] = 0;
  }

  foreach(player in level.players) {
    team = player scripts\mp\utility\stats::getpersstat("team");

    if(isDefined(team) && isgameplayteam(team)) {
      kills[team] += player.kills;
      deaths[team] += player.deaths;
    }
  }

  highestkillcount = undefined;
  var_26dab44600e577c2 = undefined;
  var_eef1f945d8b0c9fd = 0;
  lowestdeathcount = undefined;
  var_8637b9eeda41c9a = undefined;
  var_b788609f6e686a95 = 0;

  foreach(entry in level.teamnamelist) {
    killcount = kills[entry];

    if(!isDefined(highestkillcount) || killcount > highestkillcount) {
      highestkillcount = killcount;
      var_26dab44600e577c2 = entry;
      var_eef1f945d8b0c9fd = 0;
    } else if(highestkillcount == killcount) {
      var_eef1f945d8b0c9fd = 1;
    }

    deathcount = deaths[entry];

    if(!isDefined(lowestdeathcount) || deathcount < lowestdeathcount) {
      lowestdeathcount = deathcount;
      var_8637b9eeda41c9a = entry;
      var_b788609f6e686a95 = 0;
      continue;
    }

    if(lowestdeathcount == deathcount) {
      var_b788609f6e686a95 = 1;
    }
  }

  if(!var_eef1f945d8b0c9fd) {
    return var_26dab44600e577c2;
  }

  if(!var_b788609f6e686a95) {
    return var_8637b9eeda41c9a;
  }

  randomidx = randomint(level.teamnamelist.size);
  return level.teamnamelist[randomidx];
}

function rankedmatchupdates(winner) {
  if(matchmakinggame()) {
    setxenonranks();

    if(hostidledout()) {
      level.hostforcedend = 1;
      logstring("host idled out");
      endlobby();
    }
  }

  updatewinlossstats(winner);
}

function displayroundend(winner, endreasontext, endreasontextloss) {
  thread scripts\mp\music_and_dialog::round_end_music(winner, endreasontext, endreasontextloss);

  if(istrue(level.var_ee656bfaf5da1c13)) {
    thread function_90b7bf366e1e6be9(winner);
  }

  if(!level.doeomcombat && ismoddedroundgame() && game["finalRound"] == 0) {
    winner = "roundend";
  }

  level.roundendextramessage = 0;

  if(!waslastround() && getgametype() == "arena" && !istrue(game["practiceRound"])) {
    if(checkroundswitch(level.playovertime)) {
      level.roundendextramessage = game["round_end_exmsg"]["switching_sides"];
    }
  }

  if(waslastround() && iswinbytworulegametype() && function_2f1b2a4a64257bea()) {
    winner = "tie";
    endreasontext = game["end_reason"]["win_by_two_tie"];
    endreasontextloss = game["end_reason"]["win_by_two_tie"];
  }

  foreach(player in level.players) {
    if(isalive(player)) {
      player thread scripts\mp\weapons::savealtstates();
    }

    if(level.teambased) {
      player thread scripts\mp\hud_message::teamoutcomenotify(winner, 1, endreasontext, endreasontextloss, level.roundendextramessage);
      continue;
    }

    player thread scripts\mp\hud_message::outcomenotify(winner, endreasontext, endreasontextloss);
  }
}

function displaygameend(winner, endreasontext, endreasontextloss) {
  setomnvar("ui_match_over", 1);

  if(waslastround() && iswinbytworulegametype() && function_2f1b2a4a64257bea()) {
    winner = "tie";
    endreasontext = game["end_reason"]["win_by_two_tie"];
    endreasontextloss = game["end_reason"]["win_by_two_tie"];
  }

  foreach(player in level.players) {
    if(level.teambased) {
      player thread scripts\mp\hud_message::teamoutcomenotify(winner, 0, endreasontext, endreasontextloss);
      continue;
    }

    player thread scripts\mp\hud_message::outcomenotify(winner, endreasontext, endreasontextloss);
  }
}

function function_90b7bf366e1e6be9(winner) {
  if(winner == game["attackers"] && isDefined(level.var_fcb88e09334f2385)) {
    scripts\cp_mp\utility\audio_utility::snd_transient_load(level.var_fcb88e09334f2385);
    wait 45;
    scripts\cp_mp\utility\audio_utility::snd_transient_unload(level.var_fcb88e09334f2385);
    return;
  }

  if(winner == game["defenders"] && isDefined(level.var_587955703c59a8a5)) {
    scripts\cp_mp\utility\audio_utility::snd_transient_load(level.var_587955703c59a8a5);
    wait 45;
    scripts\cp_mp\utility\audio_utility::snd_transient_unload(level.var_587955703c59a8a5);
    return;
  }

  if(isDefined(level.var_fcb88e09334f2385)) {
    scripts\cp_mp\utility\audio_utility::snd_transient_load(level.var_fcb88e09334f2385);
    wait 45;
    scripts\cp_mp\utility\audio_utility::snd_transient_unload(level.var_fcb88e09334f2385);
  }
}

function displayroundswitch() {
  level notify("spawning_intermission");
  intermissionspawnpointoverride = getintermissionspawnpointoverride();

  foreach(player in level.players) {
    player thread scripts\mp\playerlogic::spawnintermission(intermissionspawnpointoverride);
  }

  switchtype = level.halftimetype;

  if(switchtype == "halftime") {
    if(level.roundlimit) {
      if(game["roundsPlayed"] * 2 == level.roundlimit) {
        switchtype = "halftime";
      } else {
        switchtype = "intermission";
      }
    } else {
      switchtype = "intermission";
    }
  }

  level notify("round_switch", switchtype);
  endreason = 0;

  if(game["finalRound"] == 1) {
    switchtype = "final_round";
  } else if(game["matchPoint"] == 1) {
    switchtype = "match_point";

    if(iswinbytworulegametype() && game["roundsWon"]["allies"] == game["roundsWon"]["axis"]) {
      switchtype = "win_by_two";
    }
  }

  if(isDefined(level.switchedsides)) {
    endreason = game["end_reason"]["switching_sides"];
    level.roundendextramessage = 0;

    if(switchtype != "final_round" && switchtype != "match_point") {
      switchtype = "switching_sides";
    }
  }

  foreach(player in level.players) {
    player thread scripts\mp\hud_message::teamoutcomenotify(switchtype, 1, endreason, endreason, level.roundendextramessage);
  }

  if(switchtype == "final_round" && getbasegametype() == "control") {
    roundendwait(level.roundenddelay);
    wait level.postgamehitmarkerwaittime;
    [defendingteam, reason] = scripts\mp\gametypes\control::function_287623bbb15154be();
    axisdefending = ter_op(defendingteam == "axis", 1, 0);
    setomnvar("ui_control_axis_defending", axisdefending);
    game["axis_defending"] = axisdefending;

    foreach(player in level.players) {
      player thread scripts\mp\hud_message::teamoutcomenotify("switching_sides", 1, reason, reason, 0);
    }
  }

  roundendwait(level.halftimeroundenddelay);
}

function freezeallplayers(delay, var_8c7ca5de1b4ed9a8, var_7e99ec33d27a716e, slowmotion) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  if(!isDefined(slowmotion)) {
    slowmotion = 0;
  }

  if(delay > 0 && slowmotion) {
    thread slowmotionendofgame(delay);
  }

  thread sendgameendedfrozennotify(delay);

  foreach(player in level.players) {
    player enableplayerbreathsystem(0);
    player thread freezeplayerforroundend(delay);
    player thread roundenddof(4);
    player freegameplayhudelems();
    player setclientdvars(@ "cg_everyonehearseveryone", 1, @ "cg_drawspectatormessages", 0);

    if(isDefined(var_8c7ca5de1b4ed9a8) && isDefined(var_7e99ec33d27a716e)) {
      if(var_8c7ca5de1b4ed9a8 == @ "hash_682a9bc40f96ca4a" && player issplitscreenplayer()) {
        player setclientdvars(var_8c7ca5de1b4ed9a8, 0.75);
      }

      player setclientdvars(var_8c7ca5de1b4ed9a8, var_7e99ec33d27a716e);
    }
  }

  if(isDefined(level.agentarray)) {
    foreach(agent in level.agentarray) {
      agent _freezecontrols(1, undefined, "freezeAllPlayers");
    }
  }
}

function endofroundvisionset(delay) {
  if(isDefined(delay) && delay > 0) {
    wait delay;
  }

  visionsetfadetoblack("bw", 0.75);
}

function slowmotionendofgame(delay) {
  setslowmotion(1, 0.4, delay);
  setendofroundsoundtimescalefactor();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(delay);
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();
}

function setendofroundsoundtimescalefactor() {
  if(!isDefined(level.endround_timescalefactor)) {
    soundsettimescalefactorfromtable("end_of_round");
    level.endround_timescalefactor = 1;
    level.reset_timescalefactor = undefined;
  }
}

function resetsoundtimescalefactor() {
  if(!isDefined(level.reset_timescalefactor)) {
    soundsettimescalefactorfromtable("reset");
    level.endround_timescalefactor = undefined;
    level.nukeinfo.timescalefactor = undefined;
    level.reset_timescalefactor = 1;
  }
}

function sendgameendedfrozennotify(delay) {
  wait delay;
  level notify("game_ended_frozen");
}

function restart() {
  foreach(player in level.players) {
    player thread setuipostgamefade(1);
  }

  wait 0.5;

  if(isDefined(level.onmaprestart)) {
    [[level.onmaprestart]]();
  }

  level notify("restarting");
  game["state"] = "playing";
  map_restart(1);
}

function function_52dde37b8fcf63ff() {
  if(!function_6b9f8406e6153597()) {
    return;
  }

  summary = spawnStruct();
  summary.matchlength = gettimepassed();
  function_7a37f9bab9677061(summary);

  foreach(player in level.players) {
    if(!isPlayer(player) || isbot(player)) {
      continue;
    }

    playerstats = scripts\mp\playerlogic::function_358a3ae71b7d1935(player);

    if(!isDefined(playerstats)) {
      continue;
    }

    player function_fe84f716b4611373(playerstats);
  }
}

function endgame(winner, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b) {
  if(isDefined(level.var_dbf03354f99ebab2)) {
    shouldskip = [[level.var_dbf03354f99ebab2]]();

    if(istrue(shouldskip)) {
      return;
    }
  }

  if(ismutationgamemode() && game["roundsPlayed"] < 1) {
    winner = "halftime";
  }

  level notify("start_game_ended");
  level.endgamewinner = winner;

  if(isDefined(level.modescorewinner)) {
    winner = level.modescorewinner;
  }

  if(isDefined(level.endgame)) {
    [[level.endgame]](winner, endreasontext, nukedetonated);
    return;
  }

  endgame_regularmp(winner, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b);
}

function endgame_regularmp(winner, endreasontext, endreasontextloss, nukedetonated, var_8e4a26ed257a393b, var_2f96189808d67a6b) {
  if(!isDefined(nukedetonated)) {
    nukedetonated = 0;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && level.gameended) {
    return;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundEndTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  if(scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
    setomnvar("ui_round_end_time", getsystemtime());
  }

  utility::trycall(level.matchdata_onroundend);
  level.var_cc2c79de99db62c = 1;
  skipscoring = 0;

  if(level.hostforcedend || level.forcedend) {
    skipscoring = 1;
  }

  if(inovertime()) {
    if(game["overtimeRoundsPlayed"] == 0) {
      setmatchdata("firstOvertimeRoundIndex", game["roundsPlayed"]);
    }

    if(!skipscoring) {
      game["overtimeRoundsPlayed"]++;
    }
  }

  if(level.teambased) {
    if(isgameplayteam(winner)) {
      if(!skipscoring) {
        if(isDefined(var_8e4a26ed257a393b)) {
          game["roundsWon"][winner] = game["roundsWon"][winner] + var_8e4a26ed257a393b;
        } else {
          game["roundsWon"][winner]++;
        }
      }

      if(!isDefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = winner;
      }
    } else {
      if(!skipscoring && isDefined(winner) && winner == "tie" && shouldmodescoreonties()) {
        foreach(entry in level.teamnamelist) {
          if(isDefined(var_2f96189808d67a6b) && isarray(var_2f96189808d67a6b) && isDefined(var_2f96189808d67a6b[entry])) {
            game["roundsWon"][entry] = game["roundsWon"][entry] + var_2f96189808d67a6b[entry];
            continue;
          }

          game["roundsWon"][entry]++;
        }
      }

      if(!isDefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = "none";
      }
    }

    if(!istrue(game["practiceRound"])) {
      foreach(entry in level.teamnamelist) {
        scripts\mp\gamescore::updateteamscore(entry);
      }

      if(isroundbased() && game["roundsPlayed"] < 24 && getbasegametype() != "koth") {
        setmatchdata("alliesRoundScore", game["roundsPlayed"], getteamscore("allies"));
        setmatchdata("axisRoundScore", game["roundsPlayed"], getteamscore("axis"));
      }
    }
  } else {
    if(isDefined(winner) && isPlayer(winner) && !skipscoring) {
      game["roundsWon"][winner.guid]++;
    }

    if(!isDefined(level.finalkillcam_winner)) {
      if(!isDefined(winner) || isstring(winner) && (winner == "tie" || winner == "none")) {
        level.finalkillcam_winner = "none";
      } else {
        level.finalkillcam_winner = winner.guid;
      }
    }
  }

  scripts\mp\gamescore::updateplacement();

  if(!skipscoring) {
    game["roundsPlayed"]++;
  }

  level.playovertime = shouldplayovertime();

  if(nextroundisfinalround()) {
    game["finalRound"] = 1;
  } else if(nextroundismatchpoint()) {
    game["matchPoint"] = 1;
  }

  if(isDefined(winner) && waslastround()) {
    winner = checkmodeoverridetie(winner);
  }

  level.ctfnukeended = istrue(nukedetonated) && getgametype() == "ctf";

  if(isDefined(winner) && level.ctfnukeended) {
    otherteam = ter_op(winner == "allies", "axis", "allies");
    game["roundsWon"][winner] = 1;
    game["roundsWon"][otherteam] = 0;
    game["teamScores"][winner] = 1;
    game["teamScores"][otherteam] = 0;
    setteamscore(winner, 1);
    setteamscore(otherteam, 0);
  }

  updatematchbonusscores(winner);

  if(wasonlyround() || waslastround()) {
    foreach(player in level.players) {
      player namespace_6b49ddb858f34366::function_adcb155953291ec7(undefined, 1);
      player scripts\cp_mp\utility\game_utility::stopkeyearning(winner);
    }
  }

  if(level.var_1fa9e6ecce90d2c2) {
    processgameend = endgame_endround(winner, endreasontext, endreasontextloss, nukedetonated);
  } else {
    processgameend = function_968a297e2b343c7c(winner, endreasontext, endreasontextloss, nukedetonated);
  }

  foreach(player in level.players) {
    if(!isbot(player) && isDefined(player.team) && player.team != "spectator" && player.team != "codcaster") {
      logendofround(player);
    }
  }

  if(processgameend && waslastround()) {
    function_8abcf76787cc51aa();
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_countdown_eom");
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_altered_strain_eom");
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_countdown_eom_match");
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_altered_strain_eom_match");
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_trt_eom_player");
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_trt_eom_match");
    function_cdec77cc82bc1dec();

    if(issharedfuncdefined("seasonalevents", "getFeaturedLootEventActive")) {
      if(callsharedfunc("seasonalevents", "getFeaturedLootEventActive")) {
        function_72e691e92ef3f4c0();
      }
    }

    if(level.var_1fa9e6ecce90d2c2) {
      endgame_endgame(winner, endreasontext, endreasontextloss, nukedetonated);
      return;
    }

    function_7d6052ee2ccb8d2(winner, endreasontext, endreasontextloss, nukedetonated);
  }
}

function shouldmodescoreonties() {
  return istrue(game["canScoreOnTie"]);
}

function checkmodeoverridetie(winner) {
  cybertie = shouldmodescoreonties() && winner == "tie";
  ctftie = getgametype() == "ctf" && winner == "tie" && !level.winrule;

  if(cybertie || ctftie) {
    scripts\mp\gamescore::updatetotalteamscore("axis");
    scripts\mp\gamescore::updatetotalteamscore("allies");
    alliesscore = getteamscore("allies");
    axisscore = getteamscore("axis");

    if(alliesscore != axisscore) {
      winner = ter_op(alliesscore > axisscore, "allies", "axis");
    }
  }

  return winner;
}

function endgame_showkillcam() {
  if(istrue(level.nukeinfo.detonated)) {
    return;
  }

  if(istrue(level.brdisablefinalkillcam)) {
    return;
  }

  if(istrue(level.var_ee656bfaf5da1c13)) {
    return;
  }

  if(getdvarint(@ "hash_166b51bf7450fc22", 0) == 1) {
    return;
  }

  if(istrue(level.skipfinalkillcam)) {
    return;
  }

  scripts\mp\flags::levelflagwait("final_killcam_preloaded");

  if(level.finalkillcamenabled) {
    doingkillcam = 0;

    if(isDefined(level.finalkillcam_winner)) {
      doingkillcam = 1;
    }

    if(doingkillcam) {
      doingkillcam = level scripts\mp\final_killcam::dofinalkillcam();
    }

    if(isDefined(doingkillcam) && !doingkillcam) {
      postroundfadenokillcam();
    }

    return;
  }

  if(level.potgenabled) {
    function_a310b626ca04b8c2();
    return;
  }

  assertmsg("<dev string:xc8f>");
}

function function_a310b626ca04b8c2() {
  potgscene = scripts\mp\potg::getcurpotgscene();

  if(isDefined(potgscene.primaryentity)) {
    level scripts\mp\final_killcam::dopotgkillcam();
    return;
  }

  level.finalkillcamenabled = 1;
  doingkillcam = level scripts\mp\final_killcam::dofinalkillcam();

  if(isDefined(doingkillcam) && !doingkillcam) {
    postroundfadenokillcam();
  }
}

function postroundfadenokillcam() {
  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }

    if(level.gametype == "ballmode") {
      if(waslastround()) {
        player setclientomnvar("post_game_state", 2);
      }
    } else if(level.gametype == "arena") {
      player setclientomnvar("post_game_state", 1);
    } else {
      player setclientomnvar("post_game_state", 2);
    }

    player thread predictandclearintermissionstreaming();
  }

  wait 0.5;
}

function predictandclearintermissionstreaming() {
  self endon("disconnect");
  intermissionloc = scripts\mp\playerlogic::getspectatepoint();
  self predictstreamposuntilcleared(intermissionloc.origin);

  while(self.sessionstate != "intermission") {
    waitframe();
  }

  waitframe();
  self clearpredictedstreampos();
}

function setgameendflagsandnotifies(winner) {
  game["state"] = "postgame";
  level notify("game_ended", winner);
  scripts\mp\flags::levelflagset("game_over");
  scripts\mp\flags::levelflagset("block_notifies");
}

function endgame_luidecisionreceived(value) {
  if(isDefined(value)) {
    if(value == 1 || value == 2) {
      level._waitforlui = 0;
      level._luidecision = value;
      level notify("madeLUIDecision");
    }
  }
}

function function_968a297e2b343c7c(winner, endreasontext, endreasontextloss, nukedetonated) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;

  if(!isDefined(winner)) {
    if(isroundbased()) {
      logstring("IWH-315293: HALIBUT: winner undefined, related to CL 7682409 where wasLastRound() would not be set in round based mode");
      level.forcedend = 1;
    }

    return true;
  }

  scripts\cp_mp\talking_gun::function_27fe46449778a3e3(winner);

  if(getdvarint(@ "scr_eom_combat")) {
    if(getgametype() == "ballmode" || waslastround() && getgametype() != "arena") {
      level.doeomcombat = 1;
    }
  }

  updateleaderboardstats();
  waitframe();
  scripts\mp\gamescore::updateplacement();
  level.recordfinalkillcam = 0;
  level.ignorescoring = 1;
  thread scripts\mp\potg::onroundended(winner);
  thread scripts\mp\final_killcam::preloadfinalkillcam();
  level notify("cancel_announcer_dialog");

  if(isteamreviveenabled()) {
    thread scripts\mp\teamrevive::cleanuprevivetriggericons();
  }

  level.var_84c0c9d11311a95d = 0;

  if(waslastround()) {
    if(matchmakinggame()) {
      if(getdvarint(@ "hash_d9b8563acb5ea299", 0) != 0) {
        if(getdvarint(@ "hash_8465b31049c6168d", 0) == 1) {
          requestgamelobbyremainintact();
        } else if(getdvarint(@ "hash_8465b31049c6168d", 0) == 2) {
          function_3b58dc117cebc002();
        } else if(getdvarint(@ "hash_8465b31049c6168d", 0) == 3) {
          level.var_84c0c9d11311a95d = requestgamelobbyremainintact();
        } else if(getdvarint(@ "hash_8465b31049c6168d", 0) == 4) {
          level.var_84c0c9d11311a95d = function_3b58dc117cebc002();
        }

        function_c924fac2b85ae1bf(level.var_84c0c9d11311a95d);
      }
    }

    if(getgametype() == "arena") {
      if(isgameplayteam(winner)) {
        topplayers = array_sort_with_func(getteamdata(winner, "players"), &compare_player_score);
      } else {
        topplayers = level.placement["all"];
      }

      topplayercount = int(min(3, topplayers.size));

      foreach(player in level.players) {
        topplayerstatus = 0;

        for(i = 0; i < topplayercount; i++) {
          if(player == topplayers[i]) {
            topplayerstatus = 1;
          }
        }

        if(topplayerstatus) {
          if(player == topplayers[0]) {
            player scripts\cp_mp\pet_watch::addwatch2v2topscore();
          }
        }
      }
    }

    level notify("start_game_win_audio", winner);

    if(istrue(level.postgameexfil) && !level.forcedend) {
      if(winner != "tie") {
        level waittill("exfil_continue_game_end");
      }
    }
  } else {
    level notify("round_end_music", winner);
  }

  if(level.doeomcombat) {
    if(istrue(level.docmdoutro)) {
      thread waitforhitmarkerspostgame();
      setgameendflagsandnotifies(winner);
      level waittill("cmd_continue_game_end");
      setomnvarforallclients("post_game_state", 2);

      foreach(player in level.players) {
        if(level.teambased) {
          player thread scripts\mp\hud_message::teamoutcomenotify(winner, 0, endreasontext, endreasontextloss);
          continue;
        }

        player thread scripts\mp\hud_message::outcomenotify(winner, endreasontext, endreasontextloss);
      }

      freezeallplayers(3, @ "hash_682a9bc40f96ca4a", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
    } else if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, endreasontext, endreasontextloss);
      game["state"] = "postgame";
      level notify("game_ended", winner);
      scripts\mp\flags::levelflagset("game_over");
      scripts\mp\flags::levelflagset("block_notifies");
      waitframe();
    } else if(getgametype() == "ballmode") {
      level notify("game_ended", winner);

      if(waslastround() || level.playovertime) {
        if(level.playovertime) {
          winner = "overtime";
        }

        thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, endreasontext, endreasontextloss);
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      setgameendflagsandnotifies(winner);
      waitframe();
    } else {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, endreasontext, endreasontextloss);
      freezeallplayers(2.5, @ "hash_682a9bc40f96ca4a", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      setgameendflagsandnotifies(winner);
      waitframe();
    }

    foreach(player in level.players) {
      player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);

      if(wasonlyround() || waslastround()) {
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
      player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);

      if((wasonlyround() || waslastround()) && !istrue(game["isLaunchChunk"])) {
        player scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        player scripts\mp\bounty::playerresetbountystreak();
      }

      player setclientomnvar("ui_match_in_progress", 0);
    }

    freezeallplayers(1, @ "hash_682a9bc40f96ca4a", 1, 0);
  }

  setgameendtime(0);
  game["gameLength"] = game["gameLength"] + scripts\mp\utility\game::getroundlength();
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled()) {
    scripts\mp\analyticslog::analyticsstorespawndata();
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.end_reason = endreasontext;
  var_7e2c53b0bcf117d9.winner = winner;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_round_end", var_7e2c53b0bcf117d9);

  if(namespace_de6e6777b0937bd7::function_9ce94b15ee6758ee("callback_player_round_end")) {
    foreach(player in level.players) {
      var_7e2c53b0bcf117d9 = spawnStruct();
      var_7e2c53b0bcf117d9.player = player;
      var_7e2c53b0bcf117d9.winner = winner;
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_round_end", var_7e2c53b0bcf117d9);
    }
  }

  clearmatchhasmorethan1playervariablesonroundend();

  if(isDefined(level.matchrecording_dump)) {
    [[level.matchrecording_dump]]();
  }

  rankedmatchupdates(winner);
  setDvar(@ "g_deadchat", 1);
  setDvar(@ "ui_allow_teamchange", 0);
  setDvar(@ "hash_8ed4dff39f3251f5", 0);

  sendscriptusageanalysisdata(1, 1);

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
    endreasontext = game["end_reason"]["practice_round_over"];
  }

  var_c58f71396bb03715 = 1;

  if(getgametype() == "ballmode") {
    var_c58f71396bb03715 = waslastround() || level.playovertime;
  }

  if(var_c58f71396bb03715) {
    displayroundend(winner, endreasontext, endreasontextloss);
    level thread endofroundvisionset(level.roundenddelay - 1);
  }

  if(isDefined(winner)) {
    winningteamindex = isstring(winner) ? scripts\engine\utility::array_find(level.allteamnamelist, winner) : undefined;

    if(isDefined(winningteamindex)) {
      setomnvar("ui_round_winner", winningteamindex);
    }
  }

  if(!waslastround()) {
    level notify("round_win", winner);
    roundendwait(level.roundenddelay);
  } else {
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.winner = winner;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_match_end", var_7e2c53b0bcf117d9);
    roundendwait(level.roundenddelay);
  }

  level notify("game_cleanup");
  endgame_showkillcam();

  if(istrue(level.var_ee656bfaf5da1c13)) {
    function_cc892bd20a432474(winner);
  }

  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();

  if(istrue(game["practiceRound"]) && !istrue(level.forcedend)) {
    game["practiceRound"] = 0;

    if(level.allowsupers && !runleanthreadmode()) {
      foreach(player in level.players) {
        player scripts\mp\supers::clearsuper();
        player scripts\mp\perks\perkpackage::perkpackage_reset();
      }
    }

    scripts\mp\flags::levelflagclear("block_notifies");
    restart();
    return false;
  } else {
    if(level.teambased) {
      foreach(entry in level.teamnamelist) {
        scripts\mp\gamescore::updatetotalteamscore(entry);
      }
    }

    if(!wasonlyround()) {
      if(!waslastround()) {
        if(level.playovertime) {
          winner = "overtime";
          game["status"] = "overtime";
        }

        scripts\mp\flags::levelflagclear("block_notifies");
        shouldswitchsides = checkroundswitch(level.playovertime);

        if(shouldswitchsides) {
          onroundswitch(level.playovertime);
        }

        if(shouldswitchsides || game["finalRound"] == 1 || game["matchPoint"] == 1) {
          shoulddisplayroundswitch = 1;

          if(getgametype() == "arena") {
            if(shouldplaywinbytwo()) {} else if(game["matchPoint"] == 1 && !istrue(game["displayedMatchPoint"])) {
              game["displayedMatchPoint"] = 1;
            } else if(game["finalRound"] != 1) {
              shoulddisplayroundswitch = 0;
            }
          } else if(getgametype() == "ballmode" || getgametype() == "warrior") {
            shoulddisplayroundswitch = 0;
          }

          if(shoulddisplayroundswitch) {
            displayroundswitch();
          }
        }

        foreach(player in level.players) {
          player.pers["stats"] = player.stats;

          if(scripts\mp\utility\player::isreallyalive(player) && isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life.life_index)) {
            deathdata = spawnStruct();
            deathdata.victim = player;
            deathdata.attacker = undefined;
            deathdata.meansofdeath = "MOD_ROUND_ENDED";
            deathdata.weaponfullstring = "none";
            namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_death", deathdata);
          }
        }

        restart();
        return false;
      }

      if(!level.forcedend) {
        endreasontext = updateroundendreasontext(winner);
      }
    }
  }

  return true;
}

function endgame_endround(winner, endreasontext, endreasontextloss, nukedetonated) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;

  if(!isDefined(winner)) {
    if(isroundbased()) {
      logstring("IWH-315293: HALIBUT: winner undefined, related to CL 7682409 where wasLastRound() would not be set in round based mode");
      level.forcedend = 1;
    }

    return true;
  }

  if(getdvarint(@ "scr_eom_combat")) {
    if(getgametype() == "ballmode" || waslastround() && getgametype() != "arena") {
      level.doeomcombat = 1;
    }
  }

  updateleaderboardstats();
  waitframe();
  scripts\mp\gamescore::updateplacement();
  level.recordfinalkillcam = 0;
  level.ignorescoring = 1;
  thread scripts\mp\potg::onroundended(winner);
  thread scripts\mp\final_killcam::preloadfinalkillcam();
  level notify("cancel_announcer_dialog");

  if(isteamreviveenabled()) {
    thread scripts\mp\teamrevive::cleanuprevivetriggericons();
  }

  level.var_84c0c9d11311a95d = 0;

  if(waslastround()) {
    if(matchmakinggame()) {
      if(getdvarint(@ "hash_d9b8563acb5ea299", 0) != 0) {
        if(getdvarint(@ "hash_8465b31049c6168d", 0) == 1) {
          requestgamelobbyremainintact();
        } else if(getdvarint(@ "hash_8465b31049c6168d", 0) == 2) {
          function_3b58dc117cebc002();
        } else if(getdvarint(@ "hash_8465b31049c6168d", 0) == 3) {
          level.var_84c0c9d11311a95d = requestgamelobbyremainintact();
        } else if(getdvarint(@ "hash_8465b31049c6168d", 0) == 4) {
          level.var_84c0c9d11311a95d = function_3b58dc117cebc002();
        }

        function_c924fac2b85ae1bf(level.var_84c0c9d11311a95d);
      }
    }

    if(getgametype() == "arena") {
      if(isgameplayteam(winner)) {
        topplayers = array_sort_with_func(getteamdata(winner, "players"), &compare_player_score);
      } else {
        topplayers = level.placement["all"];
      }

      topplayercount = int(min(3, topplayers.size));

      foreach(player in level.players) {
        topplayerstatus = 0;

        for(i = 0; i < topplayercount; i++) {
          if(player == topplayers[i]) {
            topplayerstatus = 1;
          }
        }

        if(topplayerstatus) {
          if(player == topplayers[0]) {
            player scripts\cp_mp\pet_watch::addwatch2v2topscore();
          }
        }
      }
    }

    level notify("start_game_win_audio", winner);

    if(istrue(level.postgameexfil) && !level.forcedend) {
      if(winner != "tie") {
        level waittill("exfil_continue_game_end");
      }
    }
  } else {
    level notify("round_end_music", winner);
  }

  if(level.doeomcombat) {
    if(istrue(level.docmdoutro)) {
      thread waitforhitmarkerspostgame();
      setgameendflagsandnotifies(winner);
      level waittill("cmd_continue_game_end");
      setomnvarforallclients("post_game_state", 2);

      foreach(player in level.players) {
        if(level.teambased) {
          player thread scripts\mp\hud_message::teamoutcomenotify(winner, 0, endreasontext, endreasontextloss);
          continue;
        }

        player thread scripts\mp\hud_message::outcomenotify(winner, endreasontext, endreasontextloss);
      }

      freezeallplayers(3, @ "hash_682a9bc40f96ca4a", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
    } else if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, endreasontext, endreasontextloss);
      game["state"] = "postgame";
      level notify("game_ended", winner);
      scripts\mp\flags::levelflagset("game_over");
      scripts\mp\flags::levelflagset("block_notifies");
      waitframe();
    } else if(getgametype() == "ballmode") {
      level notify("game_ended", winner);

      if(waslastround() || level.playovertime) {
        if(level.playovertime) {
          winner = "overtime";
        }

        thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, endreasontext, endreasontextloss);
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      setgameendflagsandnotifies(winner);
      waitframe();
    } else {
      thread eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, endreasontext, endreasontextloss);
      freezeallplayers(2.5, @ "hash_682a9bc40f96ca4a", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      setgameendflagsandnotifies(winner);
      waitframe();
    }

    foreach(player in level.players) {
      player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);

      if(wasonlyround() || waslastround()) {
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
      player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);

      if((wasonlyround() || waslastround()) && !istrue(game["isLaunchChunk"])) {
        player scripts\mp\killstreaks\killstreaks::clearkillstreaks();
        player scripts\mp\bounty::playerresetbountystreak();
      }

      player setclientomnvar("ui_match_in_progress", 0);
    }

    freezeallplayers(1, @ "hash_682a9bc40f96ca4a", 1, 0);
  }

  setgameendtime(0);
  game["gameLength"] = game["gameLength"] + scripts\mp\utility\game::getroundlength();
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled()) {
    scripts\mp\analyticslog::analyticsstorespawndata();
  }

  if(waslastround()) {
    level scripts\common\callbacks::callback("game_ended");
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.end_reason = endreasontext;
  var_7e2c53b0bcf117d9.winner = winner;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_round_end", var_7e2c53b0bcf117d9);

  if(namespace_de6e6777b0937bd7::function_9ce94b15ee6758ee("callback_player_round_end")) {
    foreach(player in level.players) {
      var_7e2c53b0bcf117d9 = spawnStruct();
      var_7e2c53b0bcf117d9.player = player;
      var_7e2c53b0bcf117d9.winner = winner;
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_round_end", var_7e2c53b0bcf117d9);
    }
  }

  clearmatchhasmorethan1playervariablesonroundend();

  if(isDefined(level.matchrecording_dump)) {
    [[level.matchrecording_dump]]();
  }

  rankedmatchupdates(winner);
  setDvar(@ "g_deadchat", 1);
  setDvar(@ "ui_allow_teamchange", 0);
  setDvar(@ "hash_8ed4dff39f3251f5", 0);

  sendscriptusageanalysisdata(1, 1);

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
    endreasontext = game["end_reason"]["practice_round_over"];
  }

  if(issharedfuncdefined("display_transition", "display_round_end")) {
    outcome = spawnStruct();
    outcome.winner = winner;
    outcome.end_reason = endreasontext;
    [[getsharedfunc("display_transition", "display_round_end")]](outcome);
  }

  var_c58f71396bb03715 = 1;

  if(getgametype() == "ballmode") {
    var_c58f71396bb03715 = waslastround() || level.playovertime;
  }

  if(var_c58f71396bb03715) {
    displayroundend(winner, endreasontext, endreasontextloss);
    level thread endofroundvisionset(level.roundenddelay - 1);
  }

  if(!waslastround()) {
    level notify("round_win", winner);
    roundendwait(level.roundenddelay);
  } else {
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.winner = winner;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_match_end", var_7e2c53b0bcf117d9);
    roundendwait(level.roundenddelay);
  }

  level notify("game_cleanup");

  if(istrue(game["practiceRound"]) && !istrue(level.forcedend)) {
    game["practiceRound"] = 0;

    if(level.allowsupers && !runleanthreadmode()) {
      foreach(player in level.players) {
        player scripts\mp\supers::clearsuper();
        player scripts\mp\perks\perkpackage::perkpackage_reset();
      }
    }

    scripts\mp\flags::levelflagclear("block_notifies");
    restart();
    return false;
  } else {
    if(level.teambased) {
      foreach(entry in level.teamnamelist) {
        scripts\mp\gamescore::updatetotalteamscore(entry);
      }
    }

    if(!wasonlyround()) {
      if(!waslastround()) {
        if(level.playovertime) {
          winner = "overtime";
          game["status"] = "overtime";
        }

        scripts\mp\flags::levelflagclear("block_notifies");
        shouldswitchsides = checkroundswitch(level.playovertime);

        if(shouldswitchsides) {
          onroundswitch(level.playovertime);
        }

        if(scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
          game["shouldDisplayRoundSwitch"] = shouldswitchsides;
        }

        if(shouldswitchsides || game["finalRound"] == 1 || game["matchPoint"] == 1) {
          shoulddisplayroundswitch = 1;

          if(getgametype() == "arena") {
            if(game["matchPoint"] == 1 && !istrue(game["displayedMatchPoint"])) {
              game["displayedMatchPoint"] = 1;
            } else if(game["finalRound"] != 1) {
              shoulddisplayroundswitch = 0;
            }
          } else if(getgametype() == "ballmode" || getgametype() == "warrior") {
            shoulddisplayroundswitch = 0;
          }

          if(shoulddisplayroundswitch) {
            displayroundswitch();
          }
        }

        foreach(player in level.players) {
          player.pers["stats"] = player.stats;

          if(scripts\mp\utility\player::isreallyalive(player) && isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life.life_index)) {
            deathdata = spawnStruct();
            deathdata.victim = player;
            deathdata.attacker = undefined;
            deathdata.meansofdeath = "MOD_ROUND_ENDED";
            deathdata.weaponfullstring = "none";
            namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_death", deathdata);
          }
        }

        restart();
        return false;
      }

      if(!level.forcedend) {
        endreasontext = updateroundendreasontext(winner);
      }
    }
  }

  return true;
}

function tacopsroundendwait(defaultdelay) {
  notifiesdone = 0;

  while(!notifiesdone) {
    players = level.players;
    notifiesdone = 1;

    foreach(player in players) {
      if(!player scripts\mp\hud_message::isdoingsplash()) {
        continue;
      }

      notifiesdone = 0;
    }

    wait 0.5;
  }

  var_8d539c1577794d34 = 0;

  foreach(player in level.players) {
    player thread setuipostgamefade(0);

    if(player iscodcaster()) {
      var_8d539c1577794d34 = level.var_7210bb7b0bfbcfdb;
    }
  }

  wait defaultdelay + var_8d539c1577794d34;
  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

function compare_player_score(left, right) {
  return left.score >= right.score;
}

function function_7d6052ee2ccb8d2(winner, endreasontext, endreasontextloss, nukedetonated) {
  canceljoins();
  setnojipscore(1, 1);
  setnojiptime(1, 1);

  if(scripts\mp\gametypes\br_public::isbrpracticemode() && !level.forcedend) {
    level._waitforlui = 1;
    level scripts\common\ui::lui_registercallback("exit_squad_eliminated", &endgame_luidecisionreceived);
  }

  if(!istrue(level.processedwinloss) && (istrue(level.forfeitinprogress) || level.forcedend)) {
    updatewinlossstats(winner);
  }

  scripts\cp_mp\challenges::roundend(winner);
  checkforpersonalbests();
  updatespmstats();
  scripts\mp\persistence::writebestscores();
  level notify("stop_leaderboard_stats");
  updateleaderboardstats();
  level scripts\mp\accolades::evaluateallaccolades();

  if(isDefined(level.winners_circle)) {
    level.var_286c2c7b34d03b04 = [[level.winners_circle.init]](winner);
  } else {
    level.var_286c2c7b34d03b04 = 0;
  }

  if(!level.var_286c2c7b34d03b04) {
    level notify("spawning_intermission");
    intermissionspawnpointoverride = getintermissionspawnpointoverride();

    foreach(player in level.players) {
      player thread setuipostgamefade(0);

      if(!isDefined(level.modespawnendofgame) || !player[[level.modespawnendofgame]]()) {
        player thread scripts\mp\playerlogic::spawnintermission(intermissionspawnpointoverride);
      }
    }
  }

  if(istrue(nukedetonated) && isDefined(level.nukeinfo.visionset) && !istrue(level.nukeinfo.cancelled)) {
    _visionsetnaked(level.nukeinfo.visionset, 0);
    visionsetfadetoblack("", 0.75);
  } else {
    _visionsetnaked("", 0);
    visionsetfadetoblack("", 0.75);
  }

  displaygameend(winner, endreasontext, endreasontextloss);
  scripts\mp\flags::levelflagclear("block_notifies");
  namespace_bf9ffd2b22c7d819::function_4064a2271de12b97();

  if(level.leagueplaymatch) {
    scripts\mp\leagueplay::match_end(winner);
  }

  level.intermission = 1;

  if(!level.var_286c2c7b34d03b04) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      scripts\mp\gametypes\br_circle::hidedangercircle();
      setomnvarforallclients("ui_br_transition_type", 0);

      if(function_7c386b2db63d6fb6()) {
        setomnvarforallclients("post_game_state", 14);
      }

      if(!scripts\mp\gametypes\br_public::isbrpracticemode()) {
        wait_time = getdvarint(@ "hash_54481201f477f78f", 120);

        if(getdvarint(@ "lui_ingame_play_again_enabled") == 1) {
          wait 25;
        } else if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
          wait wait_time;
        } else if(getdvarfloat(@ "hash_e94e38873c94b670", 0) > 0) {
          waitframe();
        } else if(!function_d75b73c443421047()) {
          wait 25;
        }
      } else {
        if(istrue(level._waitforlui)) {
          level waittill("madeLUIDecision");
        }

        level.postroundtime = 0;
      }
    }

    if(level.gametype != "arena" && function_9243d6bcfd2f6b49()) {
      setomnvarforallclients("post_game_state", 5);
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      roundendwait(level.postroundtime);
    }

    if(level.gametype == "arena" && function_9243d6bcfd2f6b49()) {
      setomnvarforallclients("post_game_state", 5);
    }
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() || getsubgametype() == "dmz" || getsubgametype() == "exgm" || getsubgametype() == "plunder" || getsubgametype() == "risk" || getsubgametype() == "kingslayer" || isprophuntgametype() || getsubgametype() == "rumble_mgl") {
    processlobbydata();
  }

  if(level.var_286c2c7b34d03b04) {
    setomnvarforallclients("post_game_state", 6);
    wait 0.1;
    [[level.winners_circle.start]](winner);
    level waittill("taunts_timed_out");
    [[level.winners_circle.end]]();
  }

  if(level.teambased) {
    if(isgameplayteam(winner)) {
      setmatchdata("victor", winner);
      topplayers = array_sort_with_func(getteamdata(winner, "players"), &compare_player_score);
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

  if(getdvarint(@ "hash_7d55907df966fbb0")) {
    setomnvarforallclients("post_game_state", 6);
  }

  playerendmatch();

  foreach(player in level.players) {
    if(!isDefined(endreasontext)) {
      iprintlnbold("<dev string:xcec>");

      endreasontext = game["end_reason"]["objective_completed"];
    }

    player setplayerdata("common", "round", "endReasonTextIndex", endreasontext);

    if(isalive(player) && isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life.life_index)) {
      deathdata = spawnStruct();
      deathdata.victim = player;
      deathdata.attacker = undefined;
      deathdata.meansofdeath = "MOD_GAME_ENDED";
      deathdata.weaponfullstring = "none";
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_death", deathdata);
    }

    topplayercount = int(min(3, topplayers.size));
    topplayerstatus = 0;

    for(i = 0; i < topplayercount; i++) {
      if(player == topplayers[i]) {
        topplayerstatus = 1;
      }
    }

    if(topplayerstatus) {
      player scripts\cp_mp\pet_watch::addwatchchargewintop3();
    }

    if(level.teambased) {
      if(isgameplayteam(winner)) {
        if(isDefined(player.team)) {
          if(player.team == winner) {
            player scripts\cp_mp\pet_watch::addwatchchargewin();
            player.pers["match_outcome"] = "win";
          } else {
            player.pers["match_outcome"] = "loss";
          }
        }
      } else if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie") {
        player.pers["match_outcome"] = "tie";
      }
    } else if(isPlayer(winner)) {
      if(isDefined(level.lastplayerwins)) {
        if(player == level.placement["all"][0]) {
          player scripts\cp_mp\pet_watch::addwatchchargewin();
          player.pers["match_outcome"] = "win";
        } else {
          player.pers["match_outcome"] = "loss";
        }
      } else if(topplayerstatus) {
        player scripts\cp_mp\pet_watch::addwatchchargewin();
        player.pers["match_outcome"] = "win";
      } else {
        player.pers["match_outcome"] = "loss";
      }
    } else if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie") {
      player.pers["match_outcome"] = "tie";
    }

    if(player onlinestatsenabled()) {
      player setplayerdata(level.progressiongroup, "playerStats", "comparisonSeason", getdvarint(@ "current_season"));
      elapsedtime = int(getsecondspassed());

      foreach(scope in ["lifetimeStats", "seasonalStats"]) {
        oldval = 0;

        if(player hasplayerdata(level.progressiongroup, "playerStats", scope, function_f6bad1d33ad22078(), "timeSpent")) {
          oldval = player getplayerdata(level.progressiongroup, "playerStats", scope, function_f6bad1d33ad22078(), "timeSpent");
        }

        player setplayerdata(level.progressiongroup, "playerStats", scope, function_f6bad1d33ad22078(), "timeSpent", oldval + elapsedtime);
      }
    }

    player utility::trycall(level.matchdata_logplayerdata);
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_server_exit_level");
  utility::trycall(level.matchdata_recordrecentlyplayeddata);
  onmatchend();
  sendendofmatchdata();
  function_85f0e7abca18ad51();

  foreach(player in level.players) {
    player.pers["stats"] = player.stats;
  }

  function_52dde37b8fcf63ff();

  if(istrue(game["isLaunchChunk"])) {
    wait 1;
  } else if(!nukedetonated && !level.postgamenotifies) {
    if(!level.var_286c2c7b34d03b04) {
      if(!wasonlyround()) {
        wait 6;
      } else if(getdvarfloat(@ "hash_e94e38873c94b670", 0) > 0) {
        wait 1;
      } else if(!istrue(scripts\cp_mp\utility\game_utility::isbrstylegametype()) && level.matchmakingmatch && !level.leagueplaymatch && !level.var_77907d733abe8b63 && !istrue(scripts\cp_mp\utility\game_utility::function_22cd3d64fdb05892())) {
        wait min(10, 5 + level.postgamenotifies);
      } else {
        wait min(5, 4 + level.postgamenotifies);
      }
    }
  } else {
    wait min(10, 4 + level.postgamenotifies);
  }

  function_a30e6bfa5c581e40();
  settournamentwinner(winner);

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    setomnvarforallclients("post_game_state", 15);
    var_53804dbeed3da40 = getdvarint(@ "hash_b6ae6a9d61d4326a", 0);
    wait var_53804dbeed3da40;
  }

  wait 1;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_server_post_exit_level");
  function_a30e6bfa5c581e40();
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

    foreach(team in level.teamnamelist) {
      game["roundsWon"][team] = 0;
      game["teamScores"][team] = 0;
      setteamscore(team, int(0));
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

  if(scripts\mp\gametypes\br_public::isbrpracticemode() && isDefined(level._luidecision) && level._luidecision == 2) {
    scripts\mp\bots\bots::drop_bots(1, level.player.team);
    scripts\mp\gamelogic::restart();
    return;
  }

  exitlevel(0);
}

function spawnintermission_default(isendgame) {
  level notify("spawning_intermission");
  intermissionspawnpointoverride = getintermissionspawnpointoverride();

  foreach(player in level.players) {
    player thread setuipostgamefade(0);

    if(!isDefined(level.modespawnendofgame) || !player[[level.modespawnendofgame]]()) {
      player thread scripts\mp\playerlogic::spawnintermission(intermissionspawnpointoverride);
    }
  }
}

function endgame_endgame(winner, endreasontext, endreasontextloss, nukedetonated) {
  canceljoins();
  setnojipscore(1, 1);
  setnojiptime(1, 1);

  if(scripts\mp\gametypes\br_public::isbrpracticemode() && !level.forcedend) {
    level._waitforlui = 1;
    level scripts\common\ui::lui_registercallback("exit_squad_eliminated", &endgame_luidecisionreceived);
  }

  if(!istrue(level.processedwinloss) && (istrue(level.forfeitinprogress) || level.forcedend)) {
    updatewinlossstats(winner);
  }

  scripts\cp_mp\challenges::roundend(winner);
  checkforpersonalbests();
  updatespmstats();
  scripts\mp\persistence::writebestscores();
  level notify("stop_leaderboard_stats");
  updateleaderboardstats();
  level scripts\mp\accolades::evaluateallaccolades();

  if(issharedfuncdefined("display_transition", "display_match_end")) {
    outcome = spawnStruct();
    outcome.winner = winner;
    outcome.end_reason = endreasontext;
    outcome.var_84d0ba6d7bfaca5f = endreasontextloss;
    [[getsharedfunc("display_transition", "display_match_end")]](outcome);
  }

  if(!istrue(level.var_286c2c7b34d03b04)) {
    [[level.spawnintermission]](1);
  }

  if(istrue(nukedetonated) && isDefined(level.nukeinfo.visionset) && !istrue(level.nukeinfo.cancelled)) {
    _visionsetnaked(level.nukeinfo.visionset, 0);
    visionsetfadetoblack("", 0.75);
  } else {
    _visionsetnaked("", 0);
    visionsetfadetoblack("", 0.75);
  }

  displaygameend(winner, endreasontext, endreasontextloss);
  scripts\mp\flags::levelflagclear("block_notifies");
  namespace_bf9ffd2b22c7d819::function_4064a2271de12b97();

  if(level.leagueplaymatch) {
    scripts\mp\leagueplay::match_end(winner);
  }

  level.intermission = 1;

  if(!istrue(level.var_286c2c7b34d03b04)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      scripts\mp\gametypes\br_circle::hidedangercircle();
      setomnvarforallclients("ui_br_transition_type", 0);

      if(function_7c386b2db63d6fb6()) {
        setomnvarforallclients("post_game_state", 14);
      }

      if(!scripts\mp\gametypes\br_public::isbrpracticemode()) {
        if(getdvarint(@ "lui_ingame_play_again_enabled") == 1) {
          wait 25;
        } else {
          wait 25;
        }
      } else {
        if(istrue(level._waitforlui)) {
          level waittill("madeLUIDecision");
        }

        level.postroundtime = 0;
      }
    }

    if(function_9243d6bcfd2f6b49()) {
      setomnvarforallclients("post_game_state", 5);
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      roundendwait(level.postroundtime);
    }
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() || getsubgametype() == "dmz" || getsubgametype() == "exgm" || getsubgametype() == "plunder" || getsubgametype() == "risk" || getsubgametype() == "kingslayer" || isprophuntgametype() || getsubgametype() == "rumble_mgl") {
    processlobbydata();
  }

  if(level.teambased) {
    if(isgameplayteam(winner)) {
      setmatchdata("victor", winner);
      topplayers = array_sort_with_func(getteamdata(winner, "players"), &compare_player_score);
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

  playerendmatch();

  foreach(player in level.players) {
    player setplayerdata("common", "round", "endReasonTextIndex", endreasontext);

    if(isalive(player) && isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life.life_index)) {
      deathdata = spawnStruct();
      deathdata.victim = player;
      deathdata.attacker = undefined;
      deathdata.meansofdeath = "MOD_GAME_ENDED";
      deathdata.weaponfullstring = "none";
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_death", deathdata);
    }

    topplayercount = int(min(3, topplayers.size));
    topplayerstatus = 0;

    for(i = 0; i < topplayercount; i++) {
      if(player == topplayers[i]) {
        topplayerstatus = 1;
      }
    }

    if(topplayerstatus) {
      player scripts\cp_mp\pet_watch::addwatchchargewintop3();
    }

    if(level.teambased) {
      if(isgameplayteam(winner)) {
        if(isDefined(player.team)) {
          if(player.team == winner) {
            player scripts\cp_mp\pet_watch::addwatchchargewin();
            player.pers["match_outcome"] = "win";
          } else {
            player.pers["match_outcome"] = "loss";
          }
        }
      } else if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie") {
        player.pers["match_outcome"] = "tie";
      }
    } else if(isPlayer(winner)) {
      if(isDefined(level.lastplayerwins)) {
        if(player == level.placement["all"][0]) {
          player scripts\cp_mp\pet_watch::addwatchchargewin();
          player.pers["match_outcome"] = "win";
        } else {
          player.pers["match_outcome"] = "loss";
        }
      } else if(topplayerstatus) {
        player scripts\cp_mp\pet_watch::addwatchchargewin();
        player.pers["match_outcome"] = "win";
      } else {
        player.pers["match_outcome"] = "loss";
      }
    } else if(!isDefined(winner) || isDefined(winner) && isstring(winner) && winner == "tie") {
      player.pers["match_outcome"] = "tie";
    }

    if(player onlinestatsenabled()) {
      player setplayerdata(level.progressiongroup, "playerStats", "comparisonSeason", getdvarint(@ "current_season"));
      elapsedtime = int(getsecondspassed());

      foreach(scope in ["lifetimeStats", "seasonalStats"]) {
        oldval = 0;

        if(player hasplayerdata(level.progressiongroup, "playerStats", scope, function_f6bad1d33ad22078(), "timeSpent")) {
          oldval = player getplayerdata(level.progressiongroup, "playerStats", scope, function_f6bad1d33ad22078(), "timeSpent");
        }

        player setplayerdata(level.progressiongroup, "playerStats", scope, function_f6bad1d33ad22078(), "timeSpent", oldval + elapsedtime);
      }
    }

    player utility::trycall(level.matchdata_logplayerdata);
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_server_exit_level");
  utility::trycall(level.matchdata_recordrecentlyplayeddata);
  onmatchend();
  sendendofmatchdata();
  function_a30e6bfa5c581e40();
  function_85f0e7abca18ad51();

  foreach(player in level.players) {
    player.pers["stats"] = player.stats;
  }

  function_52dde37b8fcf63ff();

  if(istrue(game["isLaunchChunk"])) {
    wait 1;
  } else if(!nukedetonated && !level.postgamenotifies) {
    if(!istrue(level.var_286c2c7b34d03b04)) {
      if(!wasonlyround()) {
        wait 6;
      } else {
        wait min(5, 4 + level.postgamenotifies);
      }
    }
  } else {
    wait min(10, 4 + level.postgamenotifies);
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_server_post_exit_level");
  settournamentwinner(winner);
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

    foreach(team in level.teamnamelist) {
      game["roundsWon"][team] = 0;
      game["teamScores"][team] = 0;
      setteamscore(team, int(0));
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

  if(scripts\mp\gametypes\br_public::isbrpracticemode() && isDefined(level._luidecision) && level._luidecision == 2) {
    scripts\mp\bots\bots::drop_bots(1, level.player.team);
    scripts\mp\gamelogic::restart();
    return;
  }

  exitlevel(0);
}

function function_7c386b2db63d6fb6() {
  return !function_52a79582296d478f() || !function_e2dbe7460083c35();
}

function function_9243d6bcfd2f6b49() {
  return !istrue(level.var_c94add55a8ad5938) && (!function_52a79582296d478f() || !function_e2dbe7460083c35());
}

function function_52a79582296d478f() {
  return namespace_b97271dc63a81cc0::function_94b952789d039abb();
}

function function_e2dbe7460083c35() {
  return getDvar(@ "hash_12e53040d5281856", "") == "scripted";
}

function sendendofmatchdata() {
  if(!isDefined(level.endofmatchdatasent)) {
    if(getdvarint(@ "online_matchdata_enabled") != 0) {
      setmatchdata("host", level.hostname);

      if(matchmakinggame()) {
        setmatchdata("playlistVersion", getplaylistversion());
        setmatchdata("playlistID", getplaylistid());
        setmatchdata("playlist_name", getplaylistname());
        setmatchdata("isDedicated", isdedicatedserver());
        setmatchdata("party_maxplayers", getdvarint(@ "party_maxplayers", 0));
      }

      function_9d1e19c311cbe199();
      sendmatchdata();
    }
  }

  level.endofmatchdatasent = 1;
}

function settournamentwinner(winner) {
  if(!isDefined(winner)) {
    return;
  }

  if(!level.teambased) {
    dotournamentendgame(winner);
    return;
  } else if(winner != "allies" && winner != "axis") {
    numallies = getteamdata("allies", "players");
    numaxis = getteamdata("axis", "players");

    if(numallies.size == 0) {
      winner = "axis";
    } else if(numaxis.size == 0) {
      winner = "allies";
    } else {
      winner = getbetterteam();
    }
  }

  dotournamentendgame(winner);
}

function waitforhitmarkerspostgame() {
  wait level.postgamehitmarkerwaittime;
  level notify("post_game_ui_start");
  setomnvarforallclients("post_game_state", 1);
}

function eomcombatwaitforhitmarkersanddelaystartpostgameui(winner, endreasontext, endreasontextloss) {
  wait level.postgamehitmarkerwaittime;
  level notify("post_game_ui_start");

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "ob") {
    setomnvarforallclients("post_game_state", 2);
  }

  foreach(player in level.players) {
    if(level.teambased) {
      player thread scripts\mp\hud_message::teamoutcomenotify(winner, 0, endreasontext, endreasontextloss);
      continue;
    }

    player thread scripts\mp\hud_message::outcomenotify(winner, endreasontext, endreasontextloss);
  }
}

function getintermissionspawnpointoverride() {
  spawnpoint = undefined;

  switch (level.mapname) {
    case #"hash_a62df42a13dad323":
      spawnpoint = spawnStruct();
      spawnpoint.origin = (1478, -3039, 981);
      spawnpoint.angles = (388.74, 144.97, 0);
      break;
    case #"hash_81c63d549bea3339":
      spawnpoint = spawnStruct();
      spawnpoint.origin = (1835, 1347, 749);
      spawnpoint.angles = (361, 224, 0);
      break;
    case #"hash_8eb456b9e1d842c7":
      spawnpoint = spawnStruct();
      spawnpoint.origin = (-871, -1578, 458);
      spawnpoint.angles = (6, 65, 0);
      break;
  }

  if(getgametype() == "brtdm" || getgametype() == "brtdm_mgl") {
    spawnpoint = spawnStruct();
    spawnpoint.origin = level.brtdm_config.spectatepoint.origin;
    spawnpoint.angles = level.brtdm_config.spectatepoint.angles;
  }

  return spawnpoint;
}

function eomcamerapullout(delay) {
  if(isDefined(delay) && delay > 0) {
    wait delay;
  }

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    player val::set("eomCameraPullOut", "ads", 0);
    startpos = player getEye() + (0, 0, 1) * 100 + anglesToForward(player.angles) * -100;
    cameraent = spawn("script_model", startpos);
    cameraent setModel("tag_origin");
    cameraent.angles = player.angles;
    player.spawncameraent = cameraent;
    targetpos = player getEye();
    targetangles = player.angles;
    var_4158f3e6af3fc2e7 = startpos + (0, 0, 5000);
    var_4158f3e6af3fc2e7 += anglesToForward(targetangles) * -100;
    player cameralinkTo(player.spawncameraent, "tag_origin", 1, 1);
    player.spawncameraent moveTo(var_4158f3e6af3fc2e7, 5, 4, 0.1);
    fwd = vectorNormalize(targetpos - cameraent.origin);
    goalangles = vectortoanglessafe(fwd, (0, 0, 1));
    player.spawncameraent.angles = goalangles;
    player thread lookatplayerupdate(targetangles);
    wait 2;
    player visionsetnakedforplayer("respawn_camera", 2);
  }
}

function lookatplayerupdate(var_fe0c08ddc602e96) {
  self endon("disconnect");
  self endon("lookAtPlayerUpdate_stop");

  while(true) {
    targetpos = self getEye();
    fwd = vectorNormalize(targetpos - self.spawncameraent.origin);
    goalangles = vectortoanglessafe(fwd, (0, 0, 1));
    self.spawncameraent rotateTo(goalangles, 0.75);
    waitframe();
  }
}

function updateroundendreasontext(winner) {
  if(!level.teambased) {
    return 1;
  }

  if(ismoddedroundgame()) {
    if(hitscorelimit()) {
      return game["end_reason"]["score_limit_reached"];
    }

    if(hittimelimit()) {
      return game["end_reason"]["time_limit_reached"];
    }
  } else if(hitroundlimit()) {
    return game["end_reason"]["round_limit_reached"];
  }

  if(hitwinlimit()) {
    return game["end_reason"]["score_limit_reached"];
  }

  return game["end_reason"]["objective_completed"];
}

function estimatedtimetillscorelimit(team) {
  assert(isPlayer(self) || isDefined(team));

  if(!ismoddedroundgame()) {
    scoreperminute = getscoreperminute(team);
    scoreremaining = getscoreremaining(team);
    var_e415364de8d3892d = 999999;

    if(scoreperminute) {
      var_e415364de8d3892d = scoreremaining / scoreperminute;
    }

    return var_e415364de8d3892d;
  }

  scoreperminute = getscoreperminute(team);
  scoreremaining = getscoreperminute(team);
  var_e415364de8d3892d = 999999;

  if(scoreperminute) {
    var_e415364de8d3892d = scoreremaining / scoreperminute;
  }

  return var_e415364de8d3892d;
}

function closetoscorelimit(team) {
  assert(isPlayer(self) || isDefined(team));
  checkroundlimit = 10;
  var_616beac13fedff48 = 20;
  scorelimit = level.roundscorelimit;

  switch (getgametype()) {
    case #"hash_3a17de6e294210d2":
    case #"hash_f4a9126c03d3385b":
      var_616beac13fedff48 = 20;
      break;
    case #"hash_ea061d29bbd1f237":
      var_616beac13fedff48 = 10;
    case #"hash_ca6516c10db2c95":
    case #"hash_7f9c384a34cc392f":
      var_616beac13fedff48 = scorelimit * 0.1;
      break;
    case #"hash_e9037b8a10fb8a14":
      checkroundlimit = scorelimit * 0.1;
      break;
    default:
      break;
  }

  teamscore = getteamscore(team);
  var_6d82488e12c4b8b0 = scorelimit - teamscore;

  if(var_6d82488e12c4b8b0 <= ter_op(istrue(game["finalRound"]), var_616beac13fedff48, checkroundlimit)) {
    return true;
  }

  return false;
}

function getscoreperminute(team) {
  assert(isPlayer(self) || isDefined(team));
  minutespassed = gettimepassed() / 60000 + 0.0001;

  if(isPlayer(self)) {
    scoreperminute = self.score / minutespassed;
  } else {
    scoreperminute = getteamscore(team) / minutespassed;
  }

  return scoreperminute;
}

function getscoreremaining(team) {
  assert(isPlayer(self) || isDefined(team));
  scorelimit = level.roundscorelimit;

  if(isPlayer(self)) {
    scoreremaining = scorelimit - self.score;
  } else {
    scoreremaining = scorelimit - getteamscore(team);
  }

  return scoreremaining;
}

function getscoreperminuteroundbased(team) {
  scorelimit = level.roundscorelimit;

  if(!game["switchedsides"]) {
    scorelimit /= 2;
    minutespassed = gettimepassed() / 60000 + 0.0001;
    scoreperminute = getteamscore(team) / minutespassed;
  } else {
    scorelimit = int(scorelimit / 2);
    minutespassed = gettimepassed() / 60000 + 0.0001;
    teamscore = getteamscore(team);

    if(teamscore >= scorelimit) {
      scoreperminute = (teamscore - scorelimit) / minutespassed;
    } else {
      return 0;
    }
  }

  return scoreperminute;
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_inform_last_one");
  thread teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);

  foreach(teamname in level.teamnamelist) {
    if(self.pers["team"] != teamname) {
      thread teamplayercardsplash("callout_lastenemyalive", self, teamname);
    }
  }

  level notify("last_alive", self);
}

function processlobbydata() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    processlobbydataforclient(player);
  }

  if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
    if(matchmakinggame() && !privatematch()) {
      setclientmatchdata("isPublicMatch", 1);
    } else {
      setclientmatchdata("isPublicMatch", 0);
    }
  }

  scripts\mp\scoreboard::processlobbyscoreboards();

  if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
    sendclientmatchdata();
  }
}

function assignclientmatchdataid(player) {
  if(isDefined(player) && !isDefined(player.clientmatchdataid)) {
    player.clientmatchdataid = level.currentclientmatchdataid;
    level.currentclientmatchdataid++;
  }
}

function processlobbydataforclient(player) {
  if(istrue(player.processlobbydataforclient)) {
    return;
  }

  player.processlobbydataforclient = 1;
  assignclientmatchdataid(player);
  playername = player.name;

  if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
    setclientmatchdata("players", player.clientmatchdataid, "clanTag", player getclantag());
    setclientmatchdata("players", player.clientmatchdataid, "xuidHigh", player getxuidhigh());
    setclientmatchdata("players", player.clientmatchdataid, "xuidLow", player getxuidlow());
    setclientmatchdata("players", player.clientmatchdataid, "isBot", isbot(player));
    setclientmatchdata("players", player.clientmatchdataid, "uniqueClientId", player.clientid);
    setclientmatchdata("players", player.clientmatchdataid, "username", playername);

    if(player isps4player()) {
      setclientmatchdata("players", player.clientmatchdataid, "platform", "ps4");
    } else if(player isxb3player()) {
      setclientmatchdata("players", player.clientmatchdataid, "platform", "xb3");
    } else if(player ispcplayer()) {
      setclientmatchdata("players", player.clientmatchdataid, "platform", "bnet");
    } else {
      setclientmatchdata("players", player.clientmatchdataid, "platform", "none");
    }
  }

  player setplayerdata("common", "round", "clientMatchIndex", player.clientmatchdataid);
  player scripts\mp\scoreboard::setplayerscoreboardinfo();
}

function trackleaderboarddeathstats(attacker, victim, sweapon, smeansofdeath) {
  if(isDefined(victim.var_f08da114ffd85042) && victim.var_f08da114ffd85042 == victim.lifeid) {
    return;
  }

  victim thread threadedsetweaponstatbyname(sweapon, 1, "deaths", attacker);
  victim thread threadedsetweaponstatbyname(sweapon, distancesquared(attacker.origin, victim.origin), "cumulative_death_distance_sq");
}

function trackattackerleaderboarddeathstats(attacker, victim, sweapon, smeansofdeath) {
  if(isDefined(attacker) && isPlayer(attacker)) {
    if(isDefined(smeansofdeath) && smeansofdeath.size > 0) {
      if(isDefined(sweapon) && sweapon.size > 0) {
        if(isDefined(victim)) {
          if(isDefined(attacker)) {
            if(smeansofdeath != "MOD_FALLING") {
              if(istrue(attacker.modifiers["ads"])) {
                attacker thread threadedsetweaponstatbyname(sweapon, 1, "ads_kills", victim);
              }

              attacker thread threadedsetweaponstatbyname(sweapon, 1, "kills");
              attacker thread threadedsetweaponstatbyname(sweapon, distancesquared(attacker.origin, victim.origin), "cumulative_kill_distance_sq");
            }

            if(smeansofdeath == "MOD_HEAD_SHOT") {
              attacker thread threadedsetweaponstatbyname(sweapon, 1, "headShots", victim);
            }
          } else {
            assertex(isDefined(victim), "<dev string:xd2b>");
          }
        } else {
          assertex(isDefined(victim), "<dev string:xd84>");
        }
      } else {
        assertex(smeansofdeath.size > 0, "<dev string:xddb>");
      }

      return;
    }

    assertex(smeansofdeath.size > 0, "<dev string:xe46>");
  }
}

function setweaponstat(weapon, incvalue, statname, otherent) {
  if(!incvalue) {
    return;
  }

  if(getdvarint(@ "hash_1b5abaf35dfdb4e4", 1) == 1 && istrue(game["inLiveLobby"])) {
    return;
  }

  objweapon = undefined;

  if(isweapon(weapon)) {
    objweapon = weapon;
  } else {
    objweapon = makeweaponfromstring(weapon);
  }

  objweapon = function_1e3102980c3a4cc1(objweapon);

  if(!isDefined(objweapon)) {
    return;
  }

  weaponname = objweapon.basename;
  weapongroup = getweapongroup(objweapon);
  variantid = getweaponvariantindex(objweapon);
  equipmenttype = getequipmenttype(weapon);

  if(isDefined(equipmenttype) && equipmenttype == "lethal") {
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname(objweapon);
    var_7e2c53b0bcf117d9.statname = statname;
    var_7e2c53b0bcf117d9.incvalue = incvalue;
    var_7e2c53b0bcf117d9.variantid = variantid;
    var_7e2c53b0bcf117d9.weaponobj = objweapon;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
    return;
  }

  if(weapongroup == "super") {
    shouldtracksuperweaponstats = scripts\mp\supers::shouldtracksuperweaponstats(objweapon);

    if(isDefined(shouldtracksuperweaponstats) && !shouldtracksuperweaponstats) {
      return;
    }
  }

  if(weapongroup == "killstreak" || weapongroup == "other" && weaponname != "trophy_mp" || weapongroup == "other" && weaponname != "player_trophy_system_mp" || weapongroup == "other" && weaponname != "super_trophy_mp") {
    return;
  }

  if(isenvironmentweapon(objweapon)) {
    return;
  }

  if(weapongroup == "weapon_grenade" || weapongroup == "weapon_explosive" || weaponname == "trophy_mp" || weaponname == "forcepush_mp") {
    weaponname = strip_suffix(weaponname, "_mp");
    scripts\mp\persistence::incrementweaponstat(weaponname, statname, incvalue);
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname(objweapon);
    var_7e2c53b0bcf117d9.statname = statname;
    var_7e2c53b0bcf117d9.incvalue = incvalue;
    var_7e2c53b0bcf117d9.variantid = variantid;
    var_7e2c53b0bcf117d9.weaponobj = objweapon;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
    return;
  }

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = objweapon;
  }

  if(objweapon != self.trackingweapon) {
    scripts\mp\persistence::updateweaponbufferedstats();
    self.trackingweapon = objweapon;
  }

  switch (statname) {
    case #"hash_1f658b3efcf092d2":
      if(!isDefined(self.trackingweaponshots)) {
        self.trackingweaponshots = 0;
      }

      self.trackingweaponshots += incvalue;
      break;
    case #"hash_7b99e54a94aa5fb":
      if(!isDefined(self.trackingweaponhits)) {
        self.trackingweaponhits = 0;
      }

      self.trackingweaponhits += incvalue;
      break;
    case #"hash_dae69d0191cb02b2":
      if(!isDefined(self.var_a00eddcf879bdbc3)) {
        self.var_a00eddcf879bdbc3 = 0;
      }

      self.var_a00eddcf879bdbc3 += incvalue;
      break;
    case #"hash_f75b5b7a407db7e3":
      if(!isDefined(self.var_ca6e0d389c0ca0a7)) {
        self.var_ca6e0d389c0ca0a7 = 0;
      }

      self.var_ca6e0d389c0ca0a7 += incvalue;
      break;
    case #"hash_297da132d2f8bf70":
      if(!isDefined(self.trackingweaponheadshots)) {
        self.trackingweaponheadshots = 0;
      }

      self.trackingweaponheadshots += incvalue;

      if(function_2e31277709b9f493(otherent)) {
        if(!isDefined(self.var_5fac5778fe3fdc1c)) {
          self.var_5fac5778fe3fdc1c = 0;
        }

        self.var_5fac5778fe3fdc1c += incvalue;
      }

      break;
    case #"hash_abcbd371534e7e1b":
      if(!isDefined(self.var_9a2fd6f8771f2e58)) {
        self.var_9a2fd6f8771f2e58 = 0;
      }

      self.var_9a2fd6f8771f2e58 += incvalue;
      break;
    case #"hash_14c0eea23e1cfd58":
      if(!isDefined(self.var_5fac5778fe3fdc1c)) {
        self.var_5fac5778fe3fdc1c = 0;
      }

      self.var_5fac5778fe3fdc1c += incvalue;
      break;
    case #"hash_f459561578093b3e":
      if(!isDefined(self.trackingweaponkills)) {
        self.trackingweaponkills = 0;
      }

      self.trackingweaponkills += incvalue;
      break;
    case #"hash_406d7407b0a31c77":
      if(!isDefined(self.var_e16d751a51153a7b)) {
        self.var_e16d751a51153a7b = 0;
      }

      self.var_e16d751a51153a7b += incvalue;

      if(function_2e31277709b9f493(otherent)) {
        if(!isDefined(self.var_1fe884779e5f4dbe)) {
          self.var_1fe884779e5f4dbe = 0;
        }

        self.var_1fe884779e5f4dbe += incvalue;
      }

      break;
    case #"hash_9c5319f6e55cbcfc":
      if(!isDefined(self.var_2bf7b072e416002a)) {
        self.var_2bf7b072e416002a = 0;
      }

      self.var_2bf7b072e416002a += incvalue;
      break;
    case #"hash_72d0fd0488636e3f":
      if(!isDefined(self.var_1fe884779e5f4dbe)) {
        self.var_1fe884779e5f4dbe = 0;
      }

      self.var_1fe884779e5f4dbe += incvalue;
      break;
    case #"hash_88d1683fbcbbc7fa":
      if(function_2b8d709c5b78bbef(otherent)) {
        if(!isDefined(self.var_f00517aa8f668932)) {
          self.var_f00517aa8f668932 = 0;
        }

        self.var_f00517aa8f668932 += incvalue;
      } else if(function_2e31277709b9f493(otherent)) {
        if(!isDefined(self.var_14cec2ba65099256)) {
          self.var_14cec2ba65099256 = 0;
        }

        self.var_14cec2ba65099256 += incvalue;
      }

      break;
    case #"hash_1cc8a923a608c2a0":
      if(!isDefined(self.var_883957b1c1ef6745)) {
        self.var_883957b1c1ef6745 = 0;
      }

      self.var_883957b1c1ef6745 += incvalue;

      if(function_2b8d709c5b78bbef(otherent)) {
        if(!isDefined(self.var_7b522bf6f7aeca98)) {
          self.var_7b522bf6f7aeca98 = 0;
        }

        self.var_7b522bf6f7aeca98 += incvalue;
      } else if(function_2e31277709b9f493(otherent)) {
        if(!isDefined(self.var_bf617879def40524)) {
          self.var_bf617879def40524 = 0;
        }

        self.var_bf617879def40524 += incvalue;
      }

      break;
  }

  if(statname == "deaths") {
    if(getdvarint(@ "g_debugdamage")) {
      println("<dev string:xeb7>");
    }

    var_efd23879ffb610bd = undefined;
    weaponrootname = getweaponrootname(objweapon);

    if(!iscacprimaryweapon(weaponrootname) && !iscacsecondaryweapon(weaponrootname)) {
      return;
    }

    attachments = getweaponattachments(objweapon);
    scripts\mp\persistence::incrementweaponstat(weaponrootname, statname, incvalue);
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.weaponname = weaponrootname;
    var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname(objweapon);
    var_7e2c53b0bcf117d9.statname = "deaths";
    var_7e2c53b0bcf117d9.incvalue = incvalue;
    var_7e2c53b0bcf117d9.variantid = variantid;
    var_7e2c53b0bcf117d9.weaponobj = objweapon;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);

    foreach(attachment in attachments) {
      scripts\mp\persistence::incrementattachmentstat(attachment, statname, incvalue, objweapon);
      utility::trycall(level.matchdata_logattachmentstat, attachment, statname, incvalue, objweapon);
    }
  }
}

function setinflictorstat(einflictor, eattacker, sweapon) {
  if(!isDefined(eattacker)) {
    return;
  }

  if(!isDefined(einflictor)) {
    eattacker setweaponstat(sweapon, 1, "hits");
    return;
  }

  if(!isDefined(einflictor.playeraffectedarray)) {
    einflictor.playeraffectedarray = [];
  }

  foundnewplayer = 1;

  for(i = 0; i < einflictor.playeraffectedarray.size; i++) {
    if(einflictor.playeraffectedarray[i] == self) {
      foundnewplayer = 0;
      break;
    }
  }

  if(foundnewplayer) {
    einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
    eattacker setweaponstat(sweapon, 1, "hits");
  }
}

function threadedsetweaponstatbyname(name, incvalue, statname, otherent) {
  self endon("disconnect");
  waittillframeend();
  setweaponstat(name, incvalue, statname, otherent);
}

function function_a3f0b7aba215ef11(otherent) {
  if(!isDefined(otherent)) {
    return 0;
  }

  if(isagent(otherent)) {
    return 2;
  } else if(isPlayer(otherent)) {
    return 1;
  }

  return 0;
}

function function_2b8d709c5b78bbef(ent) {
  type = function_a3f0b7aba215ef11(ent);
  return isDefined(type) && type == 2;
}

function function_2e31277709b9f493(ent) {
  type = function_a3f0b7aba215ef11(ent);
  return isDefined(type) && type == 1;
}

function updatespmstats() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player onlinestatsenabled()) {
      spm = getmatchspm(player);
      actualscore = ter_op(level.teambased, player.score, player scripts\mp\utility\stats::getpersstat("gamemodeScore"));
      globalspm = player getplayerdata(level.progressiongroup, "globalSPM");
      gamesplayed = player getplayerstat("matchStats", "gamesPlayed");
      globalspm *= gamesplayed - 1;
      var_cff58b2c41422f10 = spm;

      if(gamesplayed > 0) {
        var_cff58b2c41422f10 = (globalspm + spm) / gamesplayed;
      }

      player setplayerdata(level.progressiongroup, "globalSPM", int(var_cff58b2c41422f10));
      gametypeindex = getgametypeindex(getgametype());
      maxgamemodescorehistory = 5;
      maxgamemodes = 32;

      if(gametypeindex >= 0 && gametypeindex < maxgamemodes) {
        for(i = 0; i < 4; i++) {
          prev = player getplayerdata(level.progressiongroup, "gameModeHistory", i + 1);
          player setplayerdata(level.progressiongroup, "gameModeHistory", i, prev);
        }

        player setplayerdata(level.progressiongroup, "gameModeHistory", 4, getbasegametype());
        scoreindex = player getplayerdata(level.progressiongroup, "gameModeScoreHistory", gametypeindex, "index");
        player setplayerdata(level.progressiongroup, "gameModeScoreHistory", gametypeindex, "scores", scoreindex, int(spm));
        player setplayerdata(level.progressiongroup, "gameModeScoreHistory", gametypeindex, "actualScores", scoreindex, int(actualscore));
        player setplayerdata(level.progressiongroup, "gameModeScoreHistory", gametypeindex, "gameMode", getbasegametype());
        scoreindex = (scoreindex + 1) % maxgamemodescorehistory;
        player setplayerdata(level.progressiongroup, "gameModeScoreHistory", gametypeindex, "index", scoreindex);
      }
    }
  }
}

function checkforpersonalbests() {
  var_46cb15851fd25568 = undefined;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player onlinestatsenabled()) {
      roundkills = player getplayerdata("common", "round", "kills");
      rounddeaths = player getplayerdata("common", "round", "deaths");
      roundxp = player scripts\mp\utility\stats::getpersstat("summary")["xp"];
      bestkills = player getplayerstat("bestStats", "killsInAMatch");
      mostdeaths = player getplayerstat("bestStats", "deathsInAMatch");
      mostxp = player getplayerstat("bestStats", "xpInAMatch");
      bestspm = player getplayerdata(level.progressiongroup, "bestSPM", "score");
      bestkd = player getplayerdata(level.progressiongroup, "bestKD", "score");

      if(roundkills > bestkills) {
        player setplayerstat(roundkills, "bestStats", "killsInAMatch");
      }

      if(roundxp > mostxp) {
        player setplayerstat(roundxp, "bestStats", "xpInAMatch");
      }

      if(rounddeaths > mostdeaths) {
        player setplayerstat(rounddeaths, "bestStats", "deathsInAMatch");
      }

      kd = roundkills;

      if(rounddeaths > 1) {
        kd /= rounddeaths;
      }

      kd = int(kd * 1000);

      if(kd > bestkd) {
        player setplayerdata(level.progressiongroup, "bestKD", "score", kd);
        player setplayerdata(level.progressiongroup, "bestKD", "time", getsystemtime());
      }

      spm = getmatchspm(player);

      if(spm > bestspm) {
        player setplayerdata(level.progressiongroup, "bestSPM", "score", int(spm));
        player setplayerdata(level.progressiongroup, "bestSPM", "time", getsystemtime());
      }

      if(!isDefined(var_46cb15851fd25568)) {
        var_46cb15851fd25568 = function_9f76a26987e2aa4e();
      }

      player checkforbestweapon(var_46cb15851fd25568);
    }
  }
}

function allowleaderboardstatsupdates() {
  return level.onlinestatsenabled && isleaderboardsupportedmode();
}

function updateleaderboardstatscontinuous() {
  level endon("game_ended");
  level endon("stop_leaderboard_stats");

  if(!allowleaderboardstatsupdates()) {
    return;
  }

  for(playerindex = 0; true; playerindex++) {
    while(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
    }

    if(playerindex >= level.players.size) {
      playerindex = 0;
    }

    player = level.players[playerindex];

    if(!isDefined(player) || isai(player)) {
      waitframe();
      continue;
    }

    player updateplayerleaderboardstatsinternal();
    wait 0.1;
  }
}

function updateleaderboardstats() {
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

function updateplayerleaderboardstats() {
  if(!allowleaderboardstatsupdates()) {
    return;
  }

  if(!isDefined(self) || isai(self)) {
    return;
  }

  updateplayerleaderboardstatsinternal();
}

function isleaderboardsupportedmode() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return true;
  }

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    modestring = "hc_";
  } else {
    modestring = "";
  }

  modestring += getgametype();

  switch (modestring) {
    case #"hash_7e89154a96f625d":
    case #"hash_ca6516c10db2c95":
    case #"hash_1a5d186c17c00d3c":
    case #"hash_1aac086c17fe5ccb":
    case #"hash_1b1eecd3863a50cf":
    case #"hash_2946b34dbd2b86c6":
    case #"hash_53825b446469ac4c":
    case #"hash_5ff8e011d5b9d1c8":
    case #"hash_61ac7a98039e2d86":
    case #"hash_6efb0f59a62300fb":
    case #"hash_7485fa6c474ec865":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8c758b84936e8d42":
    case #"hash_9424bbb71eb7d064":
    case #"hash_a93dacd349d98a99":
    case #"hash_aac44b0b52bacb8e":
    case #"hash_aada280b52cbdd96":
    case #"hash_ab00240b52e9ec5e":
    case #"hash_b9458959b10637f8":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ea061d29bbd1f237":
    case #"hash_eb5e5f470e0c1dc2":
    case #"hash_ec24570718a340f5":
    case #"hash_ec72fd25bbbac99e":
    case #"hash_f4a9126c03d3385b":
    case #"hash_f55ec3d372444a79":
    case #"hash_fa0ed2f6bd4f4395":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fa2ae2f6bd652314":
    case #"hash_fa34c5f6bd6d4432":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
    case #"hash_fa7b69e7b63430d3":
    case #"hash_fb5b5e6c07253005":
      return true;
    default:
      return false;
  }

  return false;
}

function function_20fcd7762daec487() {
  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    return true;
  }

  return getdvarint(@ "hash_352e55529cbf4dae", 1) == 1;
}

function updateplayerleaderboardstatsinternal() {
  modestring = undefined;

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    modestring = "hc_";
  } else {
    modestring = "";
  }

  modestring += getgametype();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    brsubgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

    switch (brsubgametype) {
      case #"hash_a3f25a001a121f":
      case #"hash_59b8e9d05b31ff9":
      case #"hash_16dd223e5a8b22c8":
      case #"hash_343d3f3f77c83350":
      case #"hash_5e0a8ff36bce5106":
      case #"hash_8299694594ab149d":
      case #"hash_bfabc434c59611fa":
      case #"":
      case #"hash_cfb0c3041d1bdc10":
      case #"hash_dddecc2751311914":
      case #"hash_f4afff6c03d92aa0":
      case #"hash_fa21c4f6bd5e3815":
        break;
      case #"hash_3c1c1566d7b3b870":
        break;
      default:
        return;
    }
  }

  modescore = ter_op(level.teambased, self.score, self.leaderboarddata["gamemodeScore"]);
  incrementleaderboardstat("score", modestring, modescore);
  timeplayed = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  incrementleaderboardstat("timePlayed", modestring, timeplayed);
  incrementleaderboardstat("kills", modestring, self.leaderboarddata["kills"]);
  incrementleaderboardstat("deaths", modestring, self.leaderboarddata["deaths"]);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    incrementleaderboardstat("downs", modestring, self.leaderboarddata["downs"]);
    incrementleaderboardstat("contracts", modestring, self.leaderboarddata["contracts"]);
    incrementleaderboardstat("wins", modestring, self.leaderboarddata["wins"]);
    incrementleaderboardstat("topFive", modestring, self.leaderboarddata["topFive"]);
    incrementleaderboardstat("topTen", modestring, self.leaderboarddata["topTen"]);
    incrementleaderboardstat("topTwentyFive", modestring, self.leaderboarddata["topTwentyFive"]);
    incrementleaderboardstat("gamesPlayed", modestring, self.leaderboarddata["gamesPlayed"]);
    incrementleaderboardstat("revives", modestring, self.leaderboarddata["rescues"]);
    incrementleaderboardstat("cash", modestring, self.leaderboarddata["cash"]);
    incrementleaderboardstat("eliteStarted", modestring, self.leaderboarddata["eliteStarted"]);
    incrementleaderboardstat("eliteCompleted", modestring, self.leaderboarddata["eliteCompleted"]);
    incrementleaderboardstat("eliteBlocked", modestring, self.leaderboarddata["eliteBlocked"]);
    incrementleaderboardstat("secondaryVictories", modestring, self.leaderboarddata["secondaryVictories"]);
    incrementleaderboardstat("weaponCaseExfils", modestring, self.leaderboarddata["weaponCaseExfils"]);
    incrementleaderboardstat("weaponCaseWins", modestring, self.leaderboarddata["weaponCaseWins"]);
    return;
  }

  switch (getgametype()) {
    case #"hash_7485fa6c474ec865":
      incrementleaderboardstat("assists", modestring, self.leaderboarddata["assists"]);
      break;
    case #"hash_5ff8e011d5b9d1c8":
      incrementleaderboardstat("damage", modestring, self.leaderboarddata["damage"]);
      incrementleaderboardstat("assists", modestring, self.leaderboarddata["assists"]);
      break;
    case #"hash_973d1db8b6644466":
      incrementleaderboardstat("assists", modestring, self.leaderboarddata["assists"]);
      incrementleaderboardstat("hvtKills", modestring, self.leaderboarddata["hvtKills"]);
    case #"hash_ca6516c10db2c95":
    case #"hash_7f9c384a34cc392f":
      incrementleaderboardstat("captures", modestring, self.leaderboarddata["captures"]);
      incrementleaderboardstat("defends", modestring, self.leaderboarddata["defends"]);
      break;
    case #"hash_eb5e5f470e0c1dc2":
      incrementleaderboardstat("revives", modestring, self.leaderboarddata["rescues"]);
      incrementleaderboardstat("plants", modestring, self.leaderboarddata["plants"]);
      break;
    case #"hash_7e89154a96f625d":
    case #"hash_fa0ed9f6bd4f4e9a":
      updateleaderboardstatmaximum("streak", modestring, self.leaderboarddata["killChains"]);
      break;
    case #"hash_f4a9126c03d3385b":
      incrementleaderboardstat("captures", modestring, self.leaderboarddata["captures"]);
      incrementleaderboardstat("defends", modestring, self.leaderboarddata["defends"]);
      break;
    case #"hash_fa50b0f6bd82e972":
      incrementleaderboardstat("plants", modestring, self.leaderboarddata["plants"]);
      incrementleaderboardstat("defuses", modestring, self.leaderboarddata["defuses"]);
      break;
    case #"hash_1570945487ef127":
      incrementleaderboardstat("defuses", modestring, self.leaderboarddata["defuses"]);
      break;
    case #"hash_ea061d29bbd1f237":
      incrementleaderboardstat("confirms", modestring, self.leaderboarddata["confirmed"]);
      incrementleaderboardstat("denies", modestring, self.leaderboarddata["denied"]);
      break;
    case #"hash_fa34c5f6bd6d4432":
      incrementleaderboardstat("captures", modestring, self.leaderboarddata["captures"]);
      incrementleaderboardstat("defends", modestring, self.leaderboarddata["defends"]);
      break;
    case #"hash_6efb0f59a62300fb":
    case #"hash_ec72fd25bbbac99e":
      incrementleaderboardstat("objTime", modestring, self.leaderboarddata["objTime"]);
      incrementleaderboardstat("defends", modestring, self.leaderboarddata["defends"]);
      break;
    case #"hash_1a5d186c17c00d3c":
      incrementleaderboardstat("captures", modestring, self.leaderboarddata["captures"]);
      incrementleaderboardstat("returns", modestring, self.leaderboarddata["returns"]);
      break;
    case #"hash_fa50baf6bd82f930":
      incrementleaderboardstat("plants", modestring, self.leaderboarddata["plants"]);
      incrementleaderboardstat("rescues", modestring, self.leaderboarddata["rescues"]);
      break;
    case #"hash_53825b446469ac4c":
      incrementleaderboardstat("captures", modestring, self.leaderboarddata["captures"]);
      incrementleaderboardstat("revives", modestring, self.leaderboarddata["rescues"]);
      break;
    case #"hash_ec24570718a340f5":
      incrementleaderboardstat("banks", modestring, self.leaderboarddata["confirmed"]);
      incrementleaderboardstat("denies", modestring, self.leaderboarddata["denied"]);
      break;
    case #"hash_b9458959b10637f8":
      incrementleaderboardstat("time", modestring, getpersstat("extrascore0"));
      incrementleaderboardstat("infected", modestring, self.leaderboarddata["killsAsInfected"]);
      break;
    case #"hash_fb5b5e6c07253005":
      incrementleaderboardstat("stabs", modestring, self.leaderboarddata["stabs"]);
      incrementleaderboardstat("setBacks", modestring, self.leaderboarddata["setbacks"]);
      break;
    case #"hash_dd5b900f435d3f36":
      incrementleaderboardstat("objTime", modestring, self.leaderboarddata["objTime"]);
      incrementleaderboardstat("defends", modestring, self.leaderboarddata["defends"]);
      break;
    case #"hash_1aac086c17fe5ccb":
      incrementleaderboardstat("assists", modestring, self.leaderboarddata["assists"]);
      incrementleaderboardstat("captures", modestring, self.leaderboarddata["captures"]);
      incrementleaderboardstat("defends", modestring, self.leaderboarddata["defends"]);
      break;
    case #"hash_8c758b84936e8d42":
      incrementleaderboardstat("banks", modestring, self.leaderboarddata["confirmed"]);
      incrementleaderboardstat("denies", modestring, self.leaderboarddata["denied"]);
      break;
  }
}

function incrementleaderboardstat(stat, modestring, matchvalue) {
  if(!isDefined(self.leaderboardstartvalues)) {
    self.leaderboardstartvalues = [];
  }

  if(!isDefined(self.leaderboardstartvalues[stat])) {
    self.leaderboardstartvalues[stat] = self getplayerdata(level.progressiongroup, "playerStats", "modeStats", modestring, stat);
  }

  var_d1044cf8ef47f871 = int(max(self.leaderboardstartvalues[stat] + matchvalue, self.leaderboardstartvalues[stat]));
  self setplayerdata(level.progressiongroup, "playerStats", "modeStats", modestring, stat, var_d1044cf8ef47f871);
}

function updateleaderboardstatmaximum(stat, modestring, var_a775792b5f1aa47c) {
  var_afdfad231e44e710 = self getplayerdata(level.progressiongroup, "playerStats", "modeStats", modestring, stat);

  if(var_a775792b5f1aa47c > var_afdfad231e44e710) {
    self setplayerdata(level.progressiongroup, "playerStats", "modeStats", modestring, stat, var_a775792b5f1aa47c);
  }
}

function getmatchspm(player) {
  spm = ter_op(level.teambased, player.score, player scripts\mp\utility\stats::getpersstat("gamemodeScore"));
  seconds = player scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

  if(isDefined(seconds) && seconds > 0) {
    minutes = seconds / 60;
    spm /= minutes;
  }

  return spm;
}

function isvalidbestweapon(rootname) {
  group = getweapongroup(rootname);
  return isDefined(rootname) && rootname != "" && !iskillstreakweapon(rootname) && group != "killstreak" && group != "other";
}

function function_9f76a26987e2aa4e() {
  rootweaponlist = utility::trycall(level.matchdata_buildweaponrootlist);
  assert(isDefined(rootweaponlist));
  result = [];

  for(i = 0; i < rootweaponlist.size; i++) {
    weaponname = rootweaponlist[i];
    weaponname = getweaponrootname(weaponname);

    if(isvalidbestweapon(weaponname)) {
      if(!isenumvaluevalid(level.progressiongroup, "WeaponStats", weaponname)) {
        assertmsg("<dev string:xec7>" + weaponname);
        continue;
      }

      result[result.size] = weaponname;
    }
  }

  return result;
}

function checkforbestweapon(var_46cb15851fd25568) {
  bestweaponname = "";
  bestweaponkills = -1;

  for(i = 0; i < var_46cb15851fd25568.size; i++) {
    weaponname = var_46cb15851fd25568[i];
    weaponkills = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", weaponname, "kills");

    if(weaponkills > bestweaponkills) {
      bestweaponname = weaponname;
      bestweaponkills = weaponkills;
    }
  }

  weaponshots = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", bestweaponname, "shots");
  weaponheadshots = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", bestweaponname, "headShots");
  weaponhits = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", bestweaponname, "hits");
  weapondeaths = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", bestweaponname, "deaths");
  weaponxp = 0;
  self setplayerdata(level.progressiongroup, "bestWeapon", "kills", bestweaponkills);
  self setplayerdata(level.progressiongroup, "bestWeapon", "shots", weaponshots);
  self setplayerdata(level.progressiongroup, "bestWeapon", "headShots", weaponheadshots);
  self setplayerdata(level.progressiongroup, "bestWeapon", "hits", weaponhits);
  self setplayerdata(level.progressiongroup, "bestWeapon", "deaths", weapondeaths);
  self setplayerdata(level.progressiongroup, "bestWeaponXP", weaponxp);
}

function allow_weapon_mp(bool) {
  self notify("allow_weapon_mp()");

  if(bool) {
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

  while(true) {
    self waittill("weapon_switch_invalid", invalidweapon);
    self.allowweaponcache = invalidweapon;
  }
}

function ismp_init() {
  level.ismp = 1;
}

function watchforlowpopmatchstart(var_eb2b338ec4671678) {
  if(!istrue(level.lowpopcheck)) {
    return;
  }

  if(!isDefined(var_eb2b338ec4671678)) {
    var_eb2b338ec4671678 = 0;
  }

  level endon("start_prematch");
  var_80593585eb825ba2 = getdvarint(@ "hash_5e1370f70979f8b", 1);
  var_b81adef81193b335 = -1;
  starttime = gettime();

  while(true) {
    var_490292acb7f40a1e = getdvarint(@ "hash_40d1fe46f9d6f48e", 50);
    var_5f5b788d766145c0 = getdvarfloat(@ "hash_6ef3783f07957a9b", 300) * 1000;
    playercount = ter_op(var_eb2b338ec4671678, getactiveclientcount(var_80593585eb825ba2), level.players.size);

    if(var_b81adef81193b335 >= 0) {
      var_a28594c1b7cc010c = var_b81adef81193b335 + var_5f5b788d766145c0;

      if(playercount >= var_490292acb7f40a1e && gettime() >= var_a28594c1b7cc010c && !istrue(level.devoverridematchstart)) {
        break;
      }
    } else if(playercount >= var_490292acb7f40a1e) {
      var_b81adef81193b335 = gettime();
    }

    waitframe();
  }

  var_5ddc7308babf9834 = getdvarint(@ "hash_40aef046f9b08e0c", 100);
  playercount = ter_op(var_eb2b338ec4671678, getactiveclientcount(var_80593585eb825ba2), level.players.size);

  if(playercount <= var_5ddc7308babf9834) {
    level.lowpopstart = 1;
    waittime = gettime() - starttime;
    var_2aacacc9b90e191d = getdvarfloat(@ "hash_6ef3783f07957a9b", 300);
    dlog_recordevent("dlog_event_low_pop_start", ["start_players", playercount, "wait_time_ms", waittime, "active_client_count", var_eb2b338ec4671678, "lowpop_min", var_490292acb7f40a1e, "lowpop_max", var_5ddc7308babf9834, "lowpop_time", var_2aacacc9b90e191d]);

    if(isDefined(level.onlowpopstart)) {
      [[level.onlowpopstart]]();
    }
  }

  waitframe();
  level notify("start_prematch");
}

function function_8396da2a86270f7d(maxplayers) {
  minplayers = getdvarint(@ "live_lobby_minplayers_start");

  if(minplayers > maxplayers) {
    println("<dev string:xeff>" + minplayers + "<dev string:xf31>" + maxplayers);
    setDvar(@ "live_lobby_minplayers_start", maxplayers);
    minplayers = maxplayers;
  }

  return minplayers;
}

function function_d8801225da86a2c1() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  prematchdone();
}

function watchforminplayersmatchstart() {
  level endon("start_prematch");
  var_80593585eb825ba2 = getdvarint(@ "hash_5e1370f70979f8b", 1);
  lobbystarttime = gettime();
  lobbycurrtime = lobbystarttime;
  maxplayers = getdvarint(@ "party_maxplayers");
  minplayers = function_8396da2a86270f7d(maxplayers);
  var_7cc9d575418d740e = getdvarint(@ "hash_961774a7c9cf5b66", 0);

  if(var_7cc9d575418d740e > maxplayers) {
    println("<dev string:xf39>" + var_7cc9d575418d740e + "<dev string:xf75>" + maxplayers + "<dev string:x74e>");
    var_7cc9d575418d740e = maxplayers;
  }

  if(minplayers != 0) {
    while(true) {
      if(istrue(level.devoverridematchstart)) {
        break;
      }

      if(getdvarint(@ "hash_51aa9c88bb0c1224", 1) == 1 && level.var_77907d733abe8b63) {
        level waittill("leagueplay_br_backfill_closed");
        break;
      }

      var_ac0f8be89fa21057 = (lobbycurrtime - lobbystarttime) / 1000;
      var_a37e3649cfb19f73 = getdvarint(@ "live_lobby_max_time", 300);

      if(var_a37e3649cfb19f73 > 0 && var_ac0f8be89fa21057 >= var_a37e3649cfb19f73) {
        if(var_7cc9d575418d740e == 0 || var_7cc9d575418d740e <= getactiveclientcount(var_80593585eb825ba2)) {
          break;
        }
      }

      if(var_ac0f8be89fa21057 <= getdvarint(@ "hash_738a4f27bfac1d24", 15)) {
        if(getactiveclientcount(0) >= function_8396da2a86270f7d(maxplayers)) {
          break;
        }
      } else if(getactiveclientcount(var_80593585eb825ba2) >= function_8396da2a86270f7d(maxplayers)) {
        break;
      }

      if(isDefined(level.var_cb87db3f189cf3f1)) {
        [[level.var_cb87db3f189cf3f1]](var_a37e3649cfb19f73, var_ac0f8be89fa21057);
      }

      waitframe();
      lobbycurrtime = gettime();
    }
  }

  waitframe();
  level notify("start_prematch");
}

function brwatchforminplayersmatchstart() {
  level endon("start_prematch");

  while(level.players.size < getdvarint(@ "br_minplayers") || istrue(level.devoverridematchstart)) {
    waitframe();
  }

  waitframe();
  level notify("start_prematch");
}

function watchdevoverridematchstart() {
  level.startbuttons = [];
  starttriggers = getEntArray("start_lobby_trigger", "targetname");
  level thread waitforoverridematchstartdvar();
  level thread waitforoverridematchstartnotify();

  if(starttriggers.size == 0) {
    level thread waitforinitialplayerloadspawnflag();
    return;
  }

  foreach(trigger in starttriggers) {
    if(isDefined(trigger.target)) {
      visuals[0] = getEnt(trigger.target, "targetname");
    } else {
      visuals[0] = spawn("script_model", trigger.origin);
      visuals[0].angles = trigger.angles;
    }

    startbutton = scripts\mp\gameobjects::createuseobject("neutral", trigger, visuals, (0, 0, 64), undefined, 1);
    startbutton scripts\mp\gameobjects::allowuse("any");
    startbutton.id = "use";
    startbutton.trigger setuseprioritymax();
    startbutton scripts\mp\gameobjects::setusetime(3);
    startbutton scripts\mp\gameobjects::setusehinttext(&"MP_INGAME_ONLY/HOLD_TO_START_GAME");
    startbutton.onuse = &startbutton_onuse;
    level.startbuttons[level.startbuttons.size] = startbutton;
  }
}

function waitforinitialplayerloadspawnflag() {
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
  level.startbuttons[0].onuse = &startbutton_onuse;
  level.startbuttons[0].flagmodel = spawn("script_model", org);
  level.startbuttons[0].flagmodel setModel("prop_flag_neutral");
  level.startbuttons[0].usabilitytrigger = spawn("trigger_radius", org, 0, 32, 128);
  level.startbuttons[0] scripts\mp\gameobjects::setusetime(usetime);
}

function waitforoverridematchstartdvar() {
  level endon("game_ended");
  level endon("dev_force_start_completed");

  setdevdvarifuninitialized(@ "hash_a2aaa37f176aa49", 0);

  while(true) {
    if(getdvarint(@ "hash_a2aaa37f176aa49", 0)) {
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

function startbutton_onuse(player) {
  player setclientomnvar("ui_securing", 0);
  dev_forcelivelobbystart();
}

function dev_forcelivelobbystart() {
  level thread scripts\mp\utility\sound::playsoundonplayers("mp_dom_flag_captured");

  foreach(team in level.teamnamelist) {
    scripts\mp\utility\print::teamhudtutorialmessage("MP_INGAME_ONLY/GAME_FORCE_STARTED", team, 10);
  }

  setDvar(@ "br_minplayers", 1);
  setDvar(@ "live_lobby_minplayers_start", 1);
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

function livelobbyrestart() {
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

  if(scripts\mp\analyticslog::analyticsspawnlogenabled()) {
    scripts\mp\analyticslog::analyticsstorespawndata();
  }

  if(isDefined(level.matchrecording_dump)) {
    [[level.matchrecording_dump]]();
  }

  setDvar(@ "g_deadchat", 1);
  setDvar(@ "ui_allow_teamchange", 0);
  setDvar(@ "hash_8ed4dff39f3251f5", 0);

  sendscriptusageanalysisdata(1, 1);

  livelobbyroundendwait(1);
  level notify("game_cleanup");
  setslowmotion(1, 0.4, 3);
  resetsoundtimescalefactor();
  scripts\mp\flags::levelflagclear("block_notifies");
  restart();
}

function livelobbyroundendwait(defaultdelay) {
  var_8d539c1577794d34 = 0;

  foreach(player in level.players) {
    player thread setuipostgamefade(0);

    if(player iscodcaster()) {
      var_8d539c1577794d34 = level.var_7210bb7b0bfbcfdb;
    }
  }

  wait defaultdelay + var_8d539c1577794d34;
  level notify("round_end_finished");
}

function livelobbymatchstarttimer(type, duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level endon("match_cancel_timer_beginning");
  level notify("match_start_timer_beginning");

  if(istrue(level.var_60f7d8bd0181980f)) {
    return;
  }

  counttime = int(duration);

  if(counttime >= 2) {
    setomnvar("ui_match_start_text", type);
    matchstarttimerperplayer_internal(counttime);
  }

  visionsetnaked("", 0);
}

function clearmatchhasmorethan1playervariablesonroundend() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

function updatematchhasmorethan1playeromnvaronplayersfirstspawn() {
  var_2d9482a14615cc39 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1) {
      game["matchHasMoreThan1Player"] = 1;
    }
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!var_2d9482a14615cc39) {
      for(i = 0; i < level.players.size; i++) {
        level.players[i] setclientomnvar("match_has_more_than_1_player", 1);
      }

      return;
    }

    self setclientomnvar("match_has_more_than_1_player", 1);
  }
}

function updatematchhasmorethan1playeromnvaronplayerdisconnect() {
  var_2d9482a14615cc39 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]--;

  if(game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] <= 1) {
      game["matchHasMoreThan1Player"] = 0;
    }
  }

  if(!game["matchHasMoreThan1Player"]) {
    if(var_2d9482a14615cc39) {
      for(i = 0; i < level.players.size; i++) {
        level.players[i] setclientomnvar("match_has_more_than_1_player", 0);
      }
    }
  }
}

function removepatchablecollision_delayed() {
  wait 10;
  var_5c2c9d034ebe9dcd = [];
  var_5c2c9d034ebe9dcd[1] = "tactical_ladder_col";
  var_5c2c9d034ebe9dcd[2] = "clip8x8x256";
  var_5c2c9d034ebe9dcd[3] = "player8x8x256";
  var_5c2c9d034ebe9dcd[4] = "ladderMetal264";
  var_5c2c9d034ebe9dcd[5] = "ladderWood192";
  var_5c2c9d034ebe9dcd[6] = "ladderMetal192";
  var_5c2c9d034ebe9dcd[7] = "mount128";
  var_5c2c9d034ebe9dcd[8] = "mount64";
  var_5c2c9d034ebe9dcd[9] = "mount32";
  var_5c2c9d034ebe9dcd[10] = "mount256";
  var_5c2c9d034ebe9dcd[11] = "ladderWood264";
  var_5c2c9d034ebe9dcd[12] = "nosight256x256x8";
  var_5c2c9d034ebe9dcd[13] = "nosight128x128x8";
  var_5c2c9d034ebe9dcd[14] = "mountCorner128";
  var_5c2c9d034ebe9dcd[15] = "mantle256";
  var_5c2c9d034ebe9dcd[16] = "mantle128";
  var_5c2c9d034ebe9dcd[17] = "mantle64";
  var_5c2c9d034ebe9dcd[18] = "mantle32";
  var_5c2c9d034ebe9dcd[19] = "stairsHalfFlight128";
  var_5c2c9d034ebe9dcd[20] = "stairsFullFlight128";

  foreach(name in var_5c2c9d034ebe9dcd) {
    scripts\cp_mp\utility\game_utility::removematchingents_bykey(name, "targetname");
  }
}

function getbrendsplashpostgamestate() {
  return 8;
}

function checkforsubgametypeoverrides() {
  level.allowsupers = getdvarint(hashcat(@ "scr_", getsubgametype(), "_allowSupers"), level.allowsupers);
}

function logendofround(player) {
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }

  if(!istrue(level.teambased) || istrue(level.multiteambased)) {
    return;
  }

  time_from_match_start = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  playerteam = player.team;
  enemyteam = level.teamnamelist[0];

  if(playerteam == enemyteam) {
    enemyteam = level.teamnamelist[1];
  }

  playerteamscore = getteamscore(playerteam);
  enemyteamscore = getteamscore(enemyteam);
  rounddamage = 0;

  if(isDefined(player.damagethisround)) {
    rounddamage = player.damagethisround;
  }

  player dlog_recordplayerevent("dlog_event_end_of_round", ["time_from_match_start", time_from_match_start, "player_team_name", playerteam, "enemy_team_name", enemyteam, "player_team_score", playerteamscore, "enemy_team_score", enemyteamscore, "damage_this_round", rounddamage]);
}

function function_fe94aaedd1047d50() {
  humancount = 0;
  partymembers = getpartyinfo();

  foreach(memberinfo in partymembers) {
    if(!memberinfo.isai) {
      humancount++;
    }
  }

  return humancount;
}

function function_e48deb3d75ab2e92() {
  humancount = 0;

  foreach(player in level.players) {
    if(!isai(player)) {
      humancount++;
    }
  }

  return humancount;
}

function setattackingteam() {
  if(!isDefined(game["attackers"])) {
    setomnvar("ui_attacking_team", 0);
  }

  if(game["attackers"] == "axis") {
    setomnvar("ui_attacking_team", 1);
    return;
  }

  if(game["attackers"] == "allies") {
    setomnvar("ui_attacking_team", 2);
    return;
  }

  setomnvar("ui_attacking_team", 0);
}

function function_72e691e92ef3f4c0() {
  foreach(player in level.players) {
    player.featured_operator_skin_equipped = 0;

    if(issharedfuncdefined("seasonalevents", "hasFeaturedOperatorSkinEquipped")) {
      if(player callsharedfunc("seasonalevents", "hasFeaturedOperatorSkinEquipped")) {
        player.featured_operator_skin_equipped = 1;
      }
    }

    player.featured_operator_skin_bonus_active = 0;
    player.field_rep_xp_combat = 0;
    player.field_rep_xp_recon = 0;
    player.field_rep_xp_strategy = 0;
    player.field_rep_xp_support = 0;
    player.field_rep_xp_logistics = 0;
    player.field_rep_xp_featured_operator_skin_bonus = 0;
    player.player_match_time = 0;
    mode = undefined;
    sub_mode = undefined;
  }

  if(level callsharedfunc("seasonalevents", "getFeaturedLootEventActive")) {
    var_11696eac76a08878 = level callsharedfunc("seasonalevents", "getFeaturedLootEventBonus");

    if(isdvardefined(@ "hash_4906b1516f388c3b")) {
      var_3e0d9ec3b338973 = getdvarint(@ "hash_4906b1516f388c3b");
    } else {
      var_3e0d9ec3b338973 = 240;
    }

    if(issharedfuncdefined("game_utility", "getTimeSinceGameStart")) {
      timesincestart = int(level callsharedfunc("game_utility", "getTimeSinceGameStart") / 1000) - 15;
    }

    if(timesincestart < var_3e0d9ec3b338973) {
      var_3e0d9ec3b338973 = timesincestart;
    }

    var_9301e90474add74a = 0;

    if(issharedfuncdefined("seasonalevents", "featuredLootEventIsFieldRep")) {
      var_9301e90474add74a = level callsharedfunc("seasonalevents", "featuredLootEventIsFieldRep");
    }

    foreach(player in level.players) {
      timeplayed = player scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

      if(player callsharedfunc("seasonalevents", "hasFeaturedOperatorSkinEquipped") && timeplayed >= var_3e0d9ec3b338973) {
        function_6bfc8696f5c6daee(player, var_11696eac76a08878);
      }
    }

    if(!var_9301e90474add74a) {
      return;
    }
  }

  mode = getgametype();
  sub_mode = getsubgametype();

  foreach(player in level.players) {
    var_d51a5d00a613b0e8 = player scripts\mp\utility\stats::getpersstat("aarData");

    if(isDefined(var_d51a5d00a613b0e8["combat_xp"])) {
      player.field_rep_xp_combat = var_d51a5d00a613b0e8["combat_xp"];
    }

    if(isDefined(var_d51a5d00a613b0e8["recon_xp"])) {
      player.field_rep_xp_recon = var_d51a5d00a613b0e8["recon_xp"];
    }

    if(isDefined(var_d51a5d00a613b0e8["strategy_xp"])) {
      player.field_rep_xp_strategy = var_d51a5d00a613b0e8["strategy_xp"];
    }

    if(isDefined(var_d51a5d00a613b0e8["support_xp"])) {
      player.field_rep_xp_support = var_d51a5d00a613b0e8["support_xp"];
    }

    if(isDefined(var_d51a5d00a613b0e8["logistics_xp"])) {
      player.field_rep_xp_logistics = var_d51a5d00a613b0e8["logistics_xp"];
    }

    player.player_match_time = player scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
    player dlog_recordplayerevent("dlog_event_player_field_rep_eom_report", ["featured_operator_skin_equipped", player.featured_operator_skin_equipped, "featured_operator_skin_bonus_active", player.featured_operator_skin_bonus_active, "field_rep_xp_combat", player.field_rep_xp_combat, "field_rep_xp_recon", player.field_rep_xp_recon, "field_rep_xp_strategy", player.field_rep_xp_strategy, "field_rep_xp_support", player.field_rep_xp_support, "field_rep_xp_logistics", player.field_rep_xp_logistics, "field_rep_xp_featured_operator_skin_bonus", player.field_rep_xp_featured_operator_skin_bonus, "player_match_time", player.player_match_time, "mode", mode, "sub_mode", sub_mode]);
  }
}

function function_af5ab021b625cdf8(inplayer) {
  var_11696eac76a08878 = level callsharedfunc("seasonalevents", "getFeaturedLootEventBonus");
  var_3e0d9ec3b338973 = getdvarint(@ "hash_4906b1516f388c3b", 240);

  if(!isDefined(inplayer) || isbot(inplayer) || istestclient(inplayer)) {
    return;
  }

  if(!game["timePassed"]) {
    return;
  }

  if(!(matchmakinggame() || getdvarint(@ "force_challenges"))) {
    return;
  }

  if(isDefined(level.startofxptime)) {
    timeplayed = (gettime() - level.startofxptime) / 1000;
  } else {
    timeplayed = inplayer scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  }

  if(inplayer callsharedfunc("seasonalevents", "hasFeaturedOperatorSkinEquipped") && timeplayed >= var_3e0d9ec3b338973) {
    function_6bfc8696f5c6daee(inplayer, var_11696eac76a08878);
  }
}

function function_6bfc8696f5c6daee(player, var_11696eac76a08878) {
  if(issharedfuncdefined("rank", "giveRankXP") && issharedfuncdefined("seasonalevents", "featuredLootEventIsFieldRep") && !istrue(player.var_257849caa1d5e3f4)) {
    scoreevent = level callsharedfunc("seasonalevents", "featuredLootEventIsFieldRep") ? #"hash_494bf50723a4f1e6" : #"hash_454caaf2539b75e4";
    player[[getsharedfunc("rank", "giveRankXP")]](scoreevent, var_11696eac76a08878, undefined, 1, 1, 1);
    player.pers["aarData"]["use_featured_operator_skin_xp"] = var_11696eac76a08878;
    player.featured_operator_skin_bonus_active = 1;
    player.field_rep_xp_featured_operator_skin_bonus = var_11696eac76a08878;
    player.var_257849caa1d5e3f4 = 1;
  }

  if(level callsharedfunc("seasonalevents", "featuredLootEventIsHunt")) {
    if(level callsharedfunc("seasonalevents", "isEventDvarNameEqualTo", "jup_s6_trt") && !istrue(player.var_1b0b7a88f1b6b4cd)) {
      player.var_1b0b7a88f1b6b4cd = 1;
      player scripts\cp_mp\challenges::function_8359cadd253f9604(player, "event_trt_candy", var_11696eac76a08878);
    }
  }
}

function function_8abcf76787cc51aa(player) {
  gametype = getgametype();

  if(isDefined(gametype) && (gametype == "koth_horde" || gametype == "br" || gametype == "ob")) {
    if(isDefined(player) && isPlayer(player)) {
      player function_3fec3b7eff58e283(gametype);
      return;
    }

    utility::array_thread(level.players, &function_3fec3b7eff58e283, gametype);
  }
}

function function_3fec3b7eff58e283(gametype) {
  player = self;

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && istrue(player scripts\mp\utility\stats::getpersstat("telemetry").var_5340761ae0b3ecee)) {
    return;
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = undefined;
  var_7e2c53b0bcf117d9.playlistid = -1;
  var_7e2c53b0bcf117d9.mode = "undefined";
  var_7e2c53b0bcf117d9.sub_mode = "undefined";
  var_7e2c53b0bcf117d9.bones_zombies = 0;
  var_7e2c53b0bcf117d9.skulls_armored_zombies = 0;
  var_7e2c53b0bcf117d9.skulls_hellhounds = 0;
  var_7e2c53b0bcf117d9.skulls_mimics = 0;
  var_7e2c53b0bcf117d9.player = player;
  var_7e2c53b0bcf117d9.playlistid = getplaylistid();
  var_7e2c53b0bcf117d9.mode = gametype;
  var_7e2c53b0bcf117d9.sub_mode = getsubgametype();

  if(isDefined(player.bone_count)) {
    var_7e2c53b0bcf117d9.bones_zombies = player.bone_count;
  }

  if(isDefined(player.var_d0b217f00fef3917)) {
    var_7e2c53b0bcf117d9.skulls_armored_zombies = player.var_d0b217f00fef3917;
  }

  if(isDefined(player.var_d848e2025d8597d2)) {
    var_7e2c53b0bcf117d9.skulls_hellhounds = player.var_d848e2025d8597d2;
  }

  if(isDefined(player.var_92e210c188ad9778)) {
    var_7e2c53b0bcf117d9.skulls_mimics = player.var_92e210c188ad9778;
  }

  player.pers["telemetry"].var_5340761ae0b3ecee = 1;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_the_hunt_eom", var_7e2c53b0bcf117d9);
}

function function_cdec77cc82bc1dec() {
  foreach(player in level.players) {
    if(!isbot(player) && isDefined(player.team) && player.team != "spectator" && player.team != "codcaster") {
      player.logplayerxp = ter_op(isDefined(player.logplayerxp), player.logplayerxp, 0);
      player.var_6839d4c49d4311cc = ter_op(isDefined(player.var_6839d4c49d4311cc), player.var_6839d4c49d4311cc, 0);
      player.var_5f7f0514bd751748 = ter_op(isDefined(player.var_5f7f0514bd751748), player.var_5f7f0514bd751748, 0);
      player.var_ec2db7afa79d6329 = ter_op(isDefined(player.var_ec2db7afa79d6329), player.var_ec2db7afa79d6329, 0);
      player.var_87cced5af3fe8585 = ter_op(isDefined(player.var_87cced5af3fe8585), player.var_87cced5af3fe8585, 0);
      player.var_946e67a854e36f91 = ter_op(isDefined(player.var_946e67a854e36f91), player.var_946e67a854e36f91, 0);
      player.var_f28d6120a5ec7857 = ter_op(isDefined(player.var_f28d6120a5ec7857), player.var_f28d6120a5ec7857, 0);
      player.var_34337227f7ad5ac3 = ter_op(isDefined(player.var_34337227f7ad5ac3), player.var_34337227f7ad5ac3, 0);
      player.var_5a7aef9c8dd06cdf = ter_op(isDefined(player.var_5a7aef9c8dd06cdf), player.var_5a7aef9c8dd06cdf, 0);
      player.var_ac7bacff44259d9 = ter_op(isDefined(player.var_ac7bacff44259d9), player.var_ac7bacff44259d9, 0);
      player.var_768319c29f83fe5c = ter_op(isDefined(player.var_768319c29f83fe5c), player.var_768319c29f83fe5c, 0);

      if(isDefined(player.var_24475874b6697c12)) {
        player.var_774225f630d95336 = ter_op(isDefined(player.var_24475874b6697c12.var_774225f630d95336), player.var_24475874b6697c12.var_774225f630d95336, 0);
        player.var_48c6afe9d308416c = ter_op(isDefined(player.var_24475874b6697c12.var_48c6afe9d308416c), player.var_24475874b6697c12.var_48c6afe9d308416c, 0);
        player.var_1c6922a7d061f276 = ter_op(isDefined(player.var_24475874b6697c12.var_1c6922a7d061f276), player.var_24475874b6697c12.var_1c6922a7d061f276, 0);
        logstring("[PARTY XP BONUSES][PARTY SKIN DATA] Name : " + player.name + " | GUID: " + player.guid + " | UNO ID: " + player getplayerunoid() + " -- Party Skin Data Log:" + "\n inGameSkinLootID: " + player.var_774225f630d95336 + "\n skinLootIDWest: " + player.var_48c6afe9d308416c + "\n skinLootIDEast: " + player.var_1c6922a7d061f276);
      }

      logstring("[PARTY XP BONUSES][BONUSES LOG] Name : " + player.name + " | GUID: " + player.guid + " | UNO ID: " + player getplayerunoid() + " -- Party Bonuses Log:" + "\n logPlayerXP: " + player.logplayerxp + "\n partyUpBonusPlayerXP: " + player.var_6839d4c49d4311cc + "\n partySkinBonusPlayerXP: " + player.var_5f7f0514bd751748 + "\n logWeaponXP: " + player.var_ec2db7afa79d6329 + "\n partyUpBonusWeaponXP: " + player.var_87cced5af3fe8585 + "\n partySkinBonusPlayerXP: " + player.var_5f7f0514bd751748 + "\n logBPXP: " + player.var_f28d6120a5ec7857 + "\n partyUpBonusBPXP: " + player.var_34337227f7ad5ac3 + "\n partySkinBonusBPXP: " + player.var_5a7aef9c8dd06cdf + "\n highest partyUpPartySize: " + player.var_ac7bacff44259d9 + "\n highest partySkinParticipantCount: " + player.var_768319c29f83fe5c);
    }
  }
}