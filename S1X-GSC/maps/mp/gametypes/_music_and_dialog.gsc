/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_music_and_dialog.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  checkName = "";
  checkName = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "anr0_";
  assert(checkName.size == 8);

  checkName = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "anr0_";
  assert(checkName.size == 8);

  if(level.multiTeamBased) {
    for(i = 0; i < level.teamNameList.size; i++) {
      str_spawn_team = "spawn_" + level.teamNameList[i];
      str_defeat_team = "defeat_" + level.teamNameList[i];
      str_victory_team = "victory_" + level.teamNameList[i];
      str_winning_team = "winning_" + level.teamNameList[i];
      str_losing_team = "losing_" + level.teamNameList[i];

      game["music"][str_spawn_team] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "spawn_music";
      game["music"][str_defeat_team] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "defeat_music";
      game["music"][str_victory_team] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "victory_music";
      game["music"][str_winning_team] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "winning_music";
      game["music"][str_losing_team] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "losing_music";
      game["voice"][level.teamNameList[i]] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "anr0_";
    }
  } else {
    game["music"]["spawn_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "spawn_music";
    game["music"]["defeat_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "defeat_music";
    game["music"]["victory_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "victory_music";
    game["music"]["winning_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "winning_music";
    game["music"]["losing_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "losing_music";
    game["voice"]["allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "anr0_";

    game["music"]["spawn_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "spawn_music";
    game["music"]["defeat_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "defeat_music";
    game["music"]["victory_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "victory_music";
    game["music"]["winning_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "winning_music";
    game["music"]["losing_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "losing_music";
    game["voice"]["axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "anr0_";
  }

  game["music"]["losing_time"] = "null";

  game["music"]["suspense"] = [];
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";

  game["dialog"]["mission_success"] = "gbl_win";
  game["dialog"]["mission_failure"] = "gbl_lost";
  game["dialog"]["mission_draw"] = "gbl_draw";

  game["dialog"]["round_success"] = "encourage_win";
  game["dialog"]["round_failure"] = "encourage_lost";
  game["dialog"]["round_draw"] = "draw";

  game["dialog"]["timesup"] = "timesup";
  game["dialog"]["winning_time"] = "gbl_winning";
  game["dialog"]["losing_time"] = "gbl_losing";
  game["dialog"]["winning_score"] = "gbl_winning";
  game["dialog"]["losing_score"] = "gbl_losing";
  game["dialog"]["lead_lost"] = "gbl_lead_lost";
  game["dialog"]["lead_tied"] = "tied";
  game["dialog"]["lead_taken"] = "gbl_lead_taken";
  game["dialog"]["last_alive"] = "gbl_lastman";

  game["dialog"]["boost"] = "gbl_start";

  if(!isDefined(game["dialog"]["offense_obj"])) {
    game["dialog"]["offense_obj"] = "boost";
  }
  if(!isDefined(game["dialog"]["defense_obj"])) {
    game["dialog"]["defense_obj"] = "boost";
  }

  game["dialog"]["hardcore"] = "hardcore";
  game["dialog"]["highspeed"] = "highspeed";
  game["dialog"]["tactical"] = "tactical";

  game["dialog"]["challenge"] = "challengecomplete";
  game["dialog"]["promotion"] = "promotion";

  game["dialog"]["bomb_taken"] = "acheive_bomb";
  game["dialog"]["bomb_lost"] = "bomb_taken";
  game["dialog"]["bomb_defused_attackers"] = "sd_enemydefused";
  game["dialog"]["bomb_defused_defenders"] = "sd_allydefused";
  game["dialog"]["bomb_planted"] = "sd_bombplanted";

  game["dialog"]["obj_taken"] = "securedobj";
  game["dialog"]["obj_lost"] = "lostobj";

  game["dialog"]["obj_defend"] = "gbl_defendobj";
  game["dialog"]["obj_destroy"] = "gbl_destroyobj";
  game["dialog"]["obj_capture"] = "gbl_secureobj";
  game["dialog"]["objs_capture"] = "gbl_secureobjs";

  game["dialog"]["move_to_new"] = "new_positions";

  game["dialog"]["push_forward"] = "gbl_rally";

  game["dialog"]["attack"] = "attack";
  game["dialog"]["defend"] = "defend";
  game["dialog"]["offense"] = "offense";
  game["dialog"]["defense"] = "defense";

  game["dialog"]["halftime"] = "gbl_halftime";
  game["dialog"]["overtime"] = "gbl_overtime";
  game["dialog"]["side_switch"] = "gbl_switchingsides";

  game["dialog"]["flag_taken"] = "ctf_retrieveflagally";
  game["dialog"]["enemy_flag_taken"] = "ctf_enemyflagacquired";
  game["dialog"]["flag_dropped"] = "ctf_enemydropflag";
  game["dialog"]["enemy_flag_dropped"] = "ctf_allydropflag";
  game["dialog"]["flag_returned"] = "ctf_allyflagback";
  game["dialog"]["enemy_flag_returned"] = "ctf_enemyflagback";
  game["dialog"]["flag_captured"] = "ctf_enemycapflag";
  game["dialog"]["enemy_flag_captured"] = "ctf_allycapflag";
  game["dialog"]["flag_getback"] = "ctf_retrieveflagally";
  game["dialog"]["enemy_flag_bringhome"] = "ctf_bringhomeflag";

  game["dialog"]["hp_online"] = "hpt_identified";
  game["dialog"]["hp_lost"] = "hpt_enemycap";
  game["dialog"]["hp_contested"] = "hpt_contested";
  game["dialog"]["hp_secured"] = "hpt_allyown";

  game["dialog"]["capturing_a"] = "dom_capa";
  game["dialog"]["capturing_b"] = "dom_capb";
  game["dialog"]["capturing_c"] = "dom_capc";
  game["dialog"]["captured_a"] = "dom_owna";
  game["dialog"]["captured_b"] = "dom_ownb";
  game["dialog"]["captured_c"] = "dom_ownc";

  game["dialog"]["securing_a"] = "dom_securinga";
  game["dialog"]["securing_b"] = "dom_securingb";
  game["dialog"]["securing_c"] = "dom_securingc";
  game["dialog"]["secured_a"] = "dom_secure_a";
  game["dialog"]["secured_b"] = "dom_secure_b";
  game["dialog"]["secured_c"] = "dom_secure_c";

  game["dialog"]["losing_a"] = "dom_enemycapa";
  game["dialog"]["losing_b"] = "dom_enemycapb";
  game["dialog"]["losing_c"] = "dom_enemycapc";
  game["dialog"]["lost_a"] = "dom_losta";
  game["dialog"]["lost_b"] = "dom_lostb";
  game["dialog"]["lost_c"] = "dom_lostc";

  game["dialog"]["enemy_taking_a"] = "dom_enemycapa";
  game["dialog"]["enemy_taking_b"] = "dom_enemycapb";
  game["dialog"]["enemy_taking_c"] = "dom_enemycapc";
  game["dialog"]["enemy_has_a"] = "dom_enemyowna";
  game["dialog"]["enemy_has_b"] = "dom_enemyownb";
  game["dialog"]["enemy_has_c"] = "dom_enemyownc";

  game["dialog"]["lost_all"] = "dom_enemyownall";
  game["dialog"]["secure_all"] = "dom_ownall";

  game["dialog"]["destroy_sentry"] = "ks_sentrygun_destroyed";
  game["music"]["nuke_music"] = "nuke_music";

  game["dialog"]["sentry_gone"] = "sentry_gone";
  game["dialog"]["sentry_destroyed"] = "sentry_destroyed";
  game["dialog"]["ti_gone"] = "ti_cancelled";
  game["dialog"]["ti_destroyed"] = "ti_blocked";

  game["dialog"]["ims_destroyed"] = "ims_destroyed";
  game["dialog"]["lbguard_destroyed"] = "lbguard_destroyed";
  game["dialog"]["ballistic_vest_destroyed"] = "ballistic_vest_destroyed";
  game["dialog"]["remote_sentry_destroyed"] = "remote_sentry_destroyed";
  game["dialog"]["sam_destroyed"] = "sam_destroyed";
  game["dialog"]["sam_gone"] = "sam_gone";

  game["dialog"]["claymore_destroyed"] = "null";
  game["dialog"]["mine_destroyed"] = "null";
  game["dialog"]["ti_destroyed"] = "gbl_tactinsertlost";

  game["dialog"]["lockouts"] = [];
  game["dialog"]["lockouts"]["ks_uav_allyuse"] = 6;

  level thread onPlayerConnect();
  level thread onLastAlive();
  level thread musicController();
  level thread onGameEnded();
  level thread onRoundSwitch();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onPlayerSpawned();
    player thread finalKillcamMusic();
  }
}

playPracticeRoundMusicForActiveClients() {
  if(!isDefined(level.practiceRoundMusicEnt)) {
    return;
  }

  level.practiceRoundMusicEnt Hide();
  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    if(!isDefined(player.practiceRoundMusicPlaying) || !player.practiceRoundMusicPlaying) {
      continue;
    }

    if(IsAIGameParticipant(player)) {
      continue;
    }

    level.practiceRoundMusicEnt ShowToPlayer(player);
  }
}

practiceRoundMusic() {
  self endon("disconnect");

  if(IsAIGameParticipant(self)) {
    return;
  }

  Assert(practiceRoundGame());

  if(isDefined(level.practiceRoundMusicEnding) && level.practiceRoundMusicEnding) {
    return;
  }

  if(isDefined(self.practiceRoundMusicStarted) && self.practiceRoundMusicStarted) {
    return;
  } else {
    self.practiceRoundMusicStarted = true;
  }

  if(!isDefined(level.practiceRoundMusicEnt)) {
    if(!SoundExists("mus_practice_round_backing_track")) {
      println("Warning: practiceRoundMusic() alias doesn't exist: mus_practice_round_backing_track");
      return;
    }

    level.practiceRoundMusicEnt = spawn("script_origin", (0, 0, 0));
    level.practiceRoundMusicEnt endon("death");
    level endon("practiceRoundMusicEnding");
    level thread endPracticeRoundMusic();

    level.practiceRoundMusicEnt Hide();
    wait 12;
    self.practiceRoundMusicPlaying = true;
    level.practiceRoundMusicEnt playLoopSound("mus_practice_round_backing_track");

    self playPracticeRoundMusicForActiveClients();
    level.practiceRoundMusicEnt ShowToPlayer(self);
    level.practiceRoundMusicEnt ScaleVolume(0, 0.05);
    wait(0.8);
    level.practiceRoundMusicEnt ScaleVolume(0.8, 2.5);
  } else {
    self playPracticeRoundMusicForActiveClients();

    level.practiceRoundMusicEnt endon("death");
    level endon("practiceRoundMusicEnding");
    wait 12;
    self.practiceRoundMusicPlaying = true;
    level.practiceRoundMusicEnt ShowToPlayer(self);
  }
}

endPracticeRoundMusic() {
  level.practiceRoundMusicEnt endon("death");

  while(game["state"] == "playing") {
    if(!level.timerStopped && getTimeLimit()) {
      timeLeft = maps\mp\gametypes\_gamelogic::getTimeRemaining() / 1000;
      timeLeftInt = int(timeLeft + 0.5);

      if(timeLeftInt <= 10) {
        break;
      }

      if(timeLeft - floor(timeLeft) >= .05) {
        wait timeLeft - floor(timeLeft);
      }
    }

    wait 1.0;
  }

  level notify("practiceRoundMusicEnding");
  level.practiceRoundMusicEnding = true;

  level.practiceRoundMusicEnt ScaleVolume(0, 5);
  wait(5.5);
  level.practiceRoundMusicEnt StopSounds();
  level.practiceRoundMusicEnt Delete();
}

onPlayerSpawned() {
  self endon("disconnect");

  self waittill("spawned_player");

  if(getDvar("virtuallobbyactive") == "0") {
    if(!level.splitscreen || level.splitscreen && !isDefined(level.playedStartingMusic)) {
      if(!self isSplitscreenPlayer() || self isSplitscreenPlayerPrimary()) {
        self playLocalSound(game["music"]["spawn_" + self.team]);
      }

      if(level.splitscreen) {
        level.playedStartingMusic = true;
      }
    }

    if(practiceRoundGame()) {
      self thread practiceRoundMusic();
    }

    if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
      if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies") {
        self leaderDialogOnPlayer("allies_gametype");
      } else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis") {
        self leaderDialogOnPlayer("axis_gametype");
      } else if(!self isSplitscreenPlayer() || self isSplitscreenPlayerPrimary()) {
        self leaderDialogOnPlayer("gametype");
      }
    }

    gameFlagWait("prematch_done");

    if(self.team == game["attackers"]) {
      if(!self isSplitscreenPlayer() || self isSplitscreenPlayerPrimary()) {
        self leaderDialogOnPlayer("offense_obj", "introboost");
      }
    } else {
      if(!self isSplitscreenPlayer() || self isSplitscreenPlayerPrimary()) {
        self leaderDialogOnPlayer("defense_obj", "introboost");
      }
    }
  }
}

onLastAlive() {
  level endon("game_ended");

  level waittill("last_alive", player);

  if(!isAlive(player)) {
    return;
  }

  player leaderDialogOnPlayer("last_alive");
}

onRoundSwitch() {
  level waittill("round_switch", switchType);

  switch (switchType) {
    case "halftime":
      foreach(player in level.players) {
        if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
          continue;
        }

        player leaderDialogOnPlayer("halftime");
      }
      break;
    case "overtime":
      foreach(player in level.players) {
        if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
          continue;
        }

        player leaderDialogOnPlayer("overtime");
      }
      break;
    default:
      foreach(player in level.players) {
        if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
          continue;
        }

        player leaderDialogOnPlayer("side_switch");
      }
      break;
  }
}

onGameEnded() {
  level thread roundWinnerDialog();
  level thread gameWinnerDialog();

  level waittill("game_win", winner);

  if(level.teamBased) {
    if(level.splitscreen) {
      if(winner == "allies") {
        playSoundOnPlayers(game["music"]["victory_allies"], "allies");
      } else if(winner == "axis") {
        playSoundOnPlayers(game["music"]["victory_axis"], "axis");
      } else {
        playSoundOnPlayers(game["music"]["nuke_music"]);
      }
    } else {
      if(winner == "allies") {
        playSoundOnPlayers(game["music"]["victory_allies"], "allies");
        playSoundOnPlayers(game["music"]["defeat_axis"], "axis");
      } else if(winner == "axis") {
        playSoundOnPlayers(game["music"]["victory_axis"], "axis");
        playSoundOnPlayers(game["music"]["defeat_allies"], "allies");
      } else {
        playSoundOnPlayers(game["music"]["nuke_music"]);
      }
    }
  } else {
    foreach(player in level.players) {
      if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
        continue;
      }

      if(player.pers["team"] != "allies" && player.pers["team"] != "axis") {
        player playLocalSound(game["music"]["nuke_music"]);
      } else if(isDefined(winner) && isPlayer(winner) && player == winner) {
        player playLocalSound(game["music"]["victory_" + player.pers["team"]]);
      } else if(!level.splitScreen) {
        player playLocalSound(game["music"]["defeat_" + player.pers["team"]]);
      }
    }
  }
}

roundWinnerDialog() {
  level waittill("round_win", winner);

  delay = level.roundEndDelay / 4;
  if(delay > 0) {
    wait(delay);
  }

  if(!isDefined(winner) || isPlayer(winner)) {
    return;
  }

  if(practiceRoundGame()) {} else if(winner == "allies") {
    leaderDialog("round_success", "allies");
    leaderDialog("round_failure", "axis");
  } else if(winner == "axis") {
    leaderDialog("round_success", "axis");
    leaderDialog("round_failure", "allies");
  }
}

gameWinnerDialog() {
  level waittill("game_win", winner);

  delay = level.postRoundTime / 2;
  if(delay > 0) {
    wait(delay);
  }

  if(!isDefined(winner) || isPlayer(winner)) {
    return;
  }

  if(practiceRoundGame()) {} else if(winner == "allies") {
    leaderDialog("mission_success", "allies");
    leaderDialog("mission_failure", "axis");
  } else if(winner == "axis") {
    if(isDefined(level.isHorde)) {
      [[level.hordeVOMissionFail]]();
    } else {
      leaderDialog("mission_success", "axis");
      leaderDialog("mission_failure", "allies");
    }
  } else {
    leaderDialog("mission_draw");
  }
}

musicController() {
  level endon("game_ended");

  if(!level.hardcoreMode && (getDvar("virtualLobbyActive") == "0")) {
    thread suspenseMusic();
  }

  level waittill("match_ending_soon", reason);
  assert(isDefined(reason));

  if(getWatchedDvar("roundlimit") == 1 || game["roundsPlayed"] == (getWatchedDvar("roundlimit") - 1)) {
    if(!level.splitScreen) {
      if(reason == "time") {
        if(level.teamBased) {
          if(practiceRoundGame()) {
            playSoundOnPlayers(game["music"]["winning_allies"]);
            leaderDialog("winning_time");
          } else if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(!level.hardcoreMode) {
              playSoundOnPlayers(game["music"]["winning_allies"], "allies");
              playSoundOnPlayers(game["music"]["losing_axis"], "axis");
            }

            leaderDialog("winning_time", "allies");
            leaderDialog("losing_time", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(!level.hardcoreMode) {
              playSoundOnPlayers(game["music"]["winning_axis"], "axis");
              playSoundOnPlayers(game["music"]["losing_allies"], "allies");
            }

            leaderDialog("winning_time", "axis");
            leaderDialog("losing_time", "allies");
          }
        } else {
          if(!level.hardcoreMode) {
            playSoundOnPlayers(game["music"]["losing_time"]);
          }

          leaderDialog("timesup");
        }
      } else if(reason == "score") {
        if(level.teamBased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(!level.hardcoreMode) {
              playSoundOnPlayers(game["music"]["winning_allies"], "allies");
              playSoundOnPlayers(game["music"]["losing_axis"], "axis");
            }

            leaderDialog("winning_score", "allies");
            leaderDialog("losing_score", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(!level.hardcoreMode) {
              playSoundOnPlayers(game["music"]["winning_axis"], "axis");
              playSoundOnPlayers(game["music"]["losing_allies"], "allies");
            }

            leaderDialog("winning_score", "axis");
            leaderDialog("losing_score", "allies");
          }
        } else {
          winningPlayer = maps\mp\gametypes\_gamescore::getHighestScoringPlayer();
          losingPlayers = maps\mp\gametypes\_gamescore::getLosingPlayers();
          excludeList[0] = winningPlayer;

          if(!level.hardcoreMode) {
            winningPlayer playLocalSound(game["music"]["winning_" + winningPlayer.pers["team"]]);

            foreach(otherPlayer in level.players) {
              if(otherPlayer == winningPlayer) {
                continue;
              }

              otherPlayer playLocalSound(game["music"]["losing_" + otherPlayer.pers["team"]]);
            }
          }

          winningPlayer leaderDialogOnPlayer("winning_score");
          leaderDialogOnPlayers("losing_score", losingPlayers);
        }
      }

      level waittill("match_ending_very_soon");
      leaderDialog("timesup");
    }
  } else {
    if(!level.hardcoreMode) {
      playSoundOnPlayers(game["music"]["losing_allies"]);
    }

    leaderDialog("timesup");
  }
}

suspenseMusic() {
  level endon("game_ended");
  level endon("match_ending_soon");

  numTracks = game["music"]["suspense"].size;
  wait(120);

  for(;;) {
    wait(randomFloatRange(60, 120));

    playSoundOnPlayers(game["music"]["suspense"][randomInt(numTracks)]);
  }
}

finalKillcamMusic() {
  self waittill("showing_final_killcam");
}