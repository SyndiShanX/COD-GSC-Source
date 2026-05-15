/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_music_and_dialog.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  game["music"]["spawn_allies"] = "mus_us_spawn";
  game["music"]["defeat_allies"] = "mus_us_defeat";
  game["music"]["victory_allies"] = "mus_us_victory";
  game["music"]["winning_allies"] = "mus_us_winning";
  game["music"]["losing_allies"] = "mus_us_losing";
  game["voice"]["allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "1mc_";
  game["music"]["allies_used_nuke"] = "mus_us_nuke_fired";
  game["music"]["allies_hit_by_nuke"] = "mus_us_nuke_hit";
  game["music"]["draw_allies"] = "mus_us_draw";

  game["music"]["spawn_axis"] = "mus_fd_spawn";
  game["music"]["defeat_axis"] = "mus_fd_defeat";
  game["music"]["victory_axis"] = "mus_fd_victory";
  game["music"]["winning_axis"] = "mus_fd_winning";
  game["music"]["losing_axis"] = "mus_fd_losing";
  game["voice"]["axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "1mc_";
  game["music"]["axis_used_nuke"] = "mus_fd_nuke_fired";
  game["music"]["axis_hit_by_nuke"] = "mus_fd_nuke_hit";
  game["music"]["draw_axis"] = "mus_fd_draw";

  game["music"]["losing_time"] = "mp_time_running_out_losing";

  game["music"]["allies_suspense"] = [];
  game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_01";
  game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_02";
  game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_03";
  game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_04";
  game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_05";
  game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_06";

  game["music"]["axis_suspense"] = [];
  game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_01";
  game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_02";
  game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_03";
  game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_04";
  game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_05";
  game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_06";

  game["dialog"]["mission_success"] = "mission_success";
  game["dialog"]["mission_failure"] = "mission_fail";
  game["dialog"]["mission_draw"] = "draw";

  game["dialog"]["round_success"] = "encourage_win";
  game["dialog"]["round_failure"] = "encourage_lost";
  game["dialog"]["round_draw"] = "draw";

  game["dialog"]["timesup"] = "timesup";
  game["dialog"]["winning_time"] = "winning";
  game["dialog"]["losing_time"] = "losing";
  game["dialog"]["winning_score"] = "winning_fight";
  game["dialog"]["losing_score"] = "losing_fight";
  game["dialog"]["lead_lost"] = "lead_lost";
  game["dialog"]["lead_tied"] = "tied";
  game["dialog"]["lead_taken"] = "lead_taken";
  game["dialog"]["last_alive"] = "lastalive";

  game["dialog"]["boost"] = "boost";

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
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["bomb_defused_axis"] = "bomb_defused_axis";
  game["dialog"]["bomb_defused_allies"] = "bomb_defused_allies";
  game["dialog"]["bomb_planted"] = "bomb_planted";

  game["dialog"]["obj_taken"] = "securedobj";
  game["dialog"]["obj_lost"] = "lostobj";

  game["dialog"]["obj_defend"] = "obj_defend";
  game["dialog"]["obj_destroy"] = "obj_destroy";
  game["dialog"]["obj_capture"] = "capture_obj";
  game["dialog"]["objs_capture"] = "capture_objs";

  game["dialog"]["hq_located"] = "hq_located";
  game["dialog"]["hq_enemy_captured"] = "hq_captured";
  game["dialog"]["hq_enemy_destroyed"] = "hq_destroyed";
  game["dialog"]["hq_secured"] = "hq_secured";
  game["dialog"]["hq_offline"] = "hq_offline";
  game["dialog"]["hq_online"] = "hq_online";

  game["dialog"]["move_to_new"] = "new_positions";

  game["dialog"]["push_forward"] = "pushforward";

  game["dialog"]["attack"] = "attack";
  game["dialog"]["defend"] = "defend";
  game["dialog"]["offense"] = "offense";
  game["dialog"]["defense"] = "defense";

  game["dialog"]["halftime"] = "halftime";
  game["dialog"]["overtime"] = "overtime";
  game["dialog"]["side_switch"] = "switching";

  game["dialog"]["flag_taken"] = "ourflag";
  game["dialog"]["flag_dropped"] = "ourflag_drop";
  game["dialog"]["flag_returned"] = "ourflag_return";
  game["dialog"]["flag_captured"] = "ourflag_capt";
  game["dialog"]["flag_getback"] = "getback_ourflag";
  game["dialog"]["enemy_flag_bringhome"] = "enemyflag_tobase";
  game["dialog"]["enemy_flag_taken"] = "enemyflag";
  game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
  game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
  game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";

  game["dialog"]["got_flag"] = "achieve_flag";
  game["dialog"]["dropped_flag"] = "lost_flag";
  game["dialog"]["enemy_got_flag"] = "enemy_has_flag";
  game["dialog"]["enemy_dropped_flag"] = "enemy_dropped_flag";

  game["dialog"]["capturing_a"] = "capturing_a";
  game["dialog"]["capturing_b"] = "capturing_b";
  game["dialog"]["capturing_c"] = "capturing_c";
  game["dialog"]["captured_a"] = "capture_a";
  game["dialog"]["captured_b"] = "capture_c";
  game["dialog"]["captured_c"] = "capture_b";

  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["secured_a"] = "secure_a";
  game["dialog"]["secured_b"] = "secure_b";
  game["dialog"]["secured_c"] = "secure_c";

  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";

  game["dialog"]["enemy_taking_a"] = "enemy_take_a";
  game["dialog"]["enemy_taking_b"] = "enemy_take_b";
  game["dialog"]["enemy_taking_c"] = "enemy_take_c";
  game["dialog"]["enemy_has_a"] = "enemy_has_a";
  game["dialog"]["enemy_has_b"] = "enemy_has_b";
  game["dialog"]["enemy_has_c"] = "enemy_has_c";

  game["dialog"]["lost_all"] = "take_positions";
  game["dialog"]["secure_all"] = "positions_lock";

  game["dialog"]["losing_target"] = "enemy_capture";
  game["dialog"]["lost_target"] = "lost_target";
  game["dialog"]["taking_target"] = "capturing_target";
  game["dialog"]["took_target"] = "achieve_target";
  game["dialog"]["defcon_raised"] = "defcon_raised";
  game["dialog"]["defcon_lowered"] = "defcon_lowered";
  game["dialog"]["one_minute_left"] = "one_minute";
  game["dialog"]["thirty_seconds_left"] = "thirty_seconds";

  game["music"]["nuke_music"] = "nuke_music";

  game["dialog"]["sentry_destroyed"] = "sentry_destroyed";
  game["dialog"]["sentry_gone"] = "sentry_gone";

  game["dialog"]["ti_destroyed"] = "ti_blocked";
  game["dialog"]["ti_gone"] = "ti_cancelled";

  game["dialog"]["ims_destroyed"] = "ims_destroyed";

  game["dialog"]["satcom_destroyed"] = "satcom_destroyed";

  game["dialog"]["ballistic_vest_destroyed"] = "ballistic_vest_destroyed";

  game["dialog"]["ammocrate_destroyed"] = "ammocrate_destroyed";
  game["dialog"]["ammocrate_gone"] = "ammocrate_gone";

  game["dialog"]["achieve_carepackage"] = "achieve_carepackage";

  game["dialog"]["gryphon_destroyed"] = "gryphon_destroyed";
  game["dialog"]["gryphon_gone"] = "gryphon_gone";

  game["dialog"]["vulture_destroyed"] = "vulture_destroyed";
  game["dialog"]["vulture_gone"] = "vulture_gone";

  game["dialog"]["nowl_destroyed"] = "nowl_destroyed";
  game["dialog"]["nowl_gone"] = "nowl_gone";

  game["dialog"]["oracle_gone"] = "oracle_gone";

  game["dialog"]["dog_gone"] = "dog_gone";
  game["dialog"]["dog_killed"] = "dog_killed";

  game["dialog"]["squad_gone"] = "squad_gone";
  game["dialog"]["squad_killed"] = "squad_killed";

  game["dialog"]["odin_gone"] = "odin_gone";
  game["dialog"]["odin_carepackage"] = "odin_carepackage";
  game["dialog"]["odin_marking"] = "odin_marking";
  game["dialog"]["odin_marked"] = "odin_marked";
  game["dialog"]["odin_m_marked"] = "odin_m_marked";
  game["dialog"]["odin_smoke"] = "odin_smoke";
  game["dialog"]["odin_moving"] = "odin_moving";

  game["dialog"]["loki_gone"] = "loki_gone";
  game["dialog"]["odin_target_killed"] = "odin_target_killed";
  game["dialog"]["odin_targets_killed"] = "odin_targets_killed";

  game["dialog"]["claymore_destroyed"] = "null";
  game["dialog"]["mine_destroyed"] = "null";

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
    player thread watchHostMigration();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  if(!isAI(self)) {
    self waittill("spawned_player");
    self thread doIntro();
  }
}

doIntro() {
  level endon("host_migration_begin");

  if(!level.splitscreen || level.splitscreen && !isDefined(level.playedStartingMusic)) {
    if(!self isSplitscreenPlayer() || self isSplitscreenPlayerPrimary()) {
      self playLocalSound(game["music"]["spawn_" + self.team]);
    }

    if(level.splitscreen) {
      level.playedStartingMusic = true;
    }
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

  if(!isDefined(self)) {
    return;
  }
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

watchHostMigration() {
  self endon("disconnect");
  level endon("grace_period_ending");

  while(true) {
    level waittill("host_migration_begin");
    was_in_grace_period = level.inGracePeriod;
    level waittill("host_migration_end");
    if(was_in_grace_period) {
      self thread doIntro();
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
        playSoundOnPlayers(game["music"]["draw_axis"], "axis");
        playSoundOnPlayers(game["music"]["draw_allies"], "allies");
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
  if(winner == "allies") {
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
  if(winner == "allies") {
    leaderDialog("mission_success", "allies");
    leaderDialog("mission_failure", "axis");
  } else if(winner == "axis") {
    leaderDialog("mission_success", "axis");
    leaderDialog("mission_failure", "allies");
  } else {
    leaderDialog("mission_draw");
  }
}

musicController() {
  level endon("game_ended");

  level.musicEnabled = 1;

  thread suspenseMusic();

  level waittill("match_ending_soon", reason);
  assert(isDefined(reason));

  if(getWatchedDvar("roundlimit") == 1 || game["roundsPlayed"] == (getWatchedDvar("roundlimit") - 1) || isModdedRoundGame()) {
    if(!level.splitScreen) {
      if(reason == "time") {
        if(level.teamBased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(isMusicEnabled()) {
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
          if(isMusicEnabled()) {
            playSoundOnPlayers(game["music"]["losing_time"]);
          }

          leaderDialog("timesup");
        }
      } else if(reason == "score") {
        if(level.teamBased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(isMusicEnabled()) {
              playSoundOnPlayers(game["music"]["winning_allies"], "allies");
              playSoundOnPlayers(game["music"]["losing_axis"], "axis");
            }

            leaderDialog("winning_score", "allies");
            leaderDialog("losing_score", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(isMusicEnabled()) {
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

          if(isMusicEnabled()) {
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

suspenseMusic(skipInitialDelay) {
  if(!isMusicEnabled()) {
    return;
  }
  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("stop_suspense_music");

  if(isDefined(level.noSuspenseMusic) && level.noSuspenseMusic) {
    return;
  }
  allies_numTracks = game["music"]["allies_suspense"].size;
  axis_numTracks = game["music"]["axis_suspense"].size;
  level.curSuspsenseTrack = [];

  if(isDefined(skipInitialDelay) && skipInitialDelay) {
    wait(120);
  }

  for(;;) {
    wait(randomFloatRange(60, 120));

    level.curSuspsenseTrack["allies"] = RandomInt(allies_numTracks);
    playSoundOnPlayers(game["music"]["allies_suspense"][level.curSuspsenseTrack["allies"]], "allies");

    level.curSuspsenseTrack["axis"] = RandomInt(axis_numTracks);
    playSoundOnPlayers(game["music"]["axis_suspense"][level.curSuspsenseTrack["axis"]], "axis");
  }
}

stopSuspenseMusic() {
  level notify("stop_suspense_music");

  if(isDefined(level.curSuspsenseTrack) && level.curSuspsenseTrack.size == 2) {
    foreach(player in level.players) {
      team = player.team;

      player StopLocalSound(game["music"][team + "_suspense"][level.curSuspsenseTrack[team]]);
    }
  }
}

finalKillcamMusic() {
  self waittill("showing_final_killcam");
}

enableMusic() {
  if(level.musicEnabled == 0) {
    thread suspenseMusic();
  }

  level.musicEnabled++;
}

disableMusic() {
  if(level.musicEnabled > 0) {
    level.musicEnabled--;

    if(level.musicEnabled == 0) {
      stopSuspenseMusic();
    }
  } else {
    AssertMsg("Trying to disable music when already disabled!");
  }
}

isMusicEnabled() {
  return (!level.hardcoreMode && level.musicEnabled > 0);
}