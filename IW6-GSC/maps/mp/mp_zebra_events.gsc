/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zebra_events.gsc
***************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#using_animtree("animated_props");

wait_game_percent_complete(time_percent, score_percent) {
  if(!isDefined(score_percent)) {
    score_percent = time_percent;
  }

  gameFlagWait("prematch_done");

  score_limit = getScoreLimit();
  time_limit = getTimeLimit() * 60;

  ignore_score = false;
  ignore_time = false;

  if((score_limit <= 0) && (time_limit <= 0)) {
    ignore_score = true;
    time_limit = 10 * 60;
  } else if(score_limit <= 0) {
    ignore_score = true;
  } else if(time_limit <= 0) {
    ignore_time = true;
  }

  time_threshold = time_percent * time_limit;
  score_threshold = score_percent * score_limit;

  higher_score = get_highest_score();
  timePassed = (getTime() - level.startTime) / 1000;

  if(ignore_score) {
    while(timePassed < time_threshold) {
      wait(0.5);
      timePassed = (getTime() - level.startTime) / 1000;
    }
  } else if(ignore_time) {
    while(higher_score < score_threshold) {
      wait(0.5);
      higher_score = get_highest_score();
    }
  } else {
    while((timePassed < time_threshold) && (higher_score < score_threshold)) {
      wait(0.5);
      higher_score = get_highest_score();
      timePassed = (getTime() - level.startTime) / 1000;
    }
  }
}

get_highest_score() {
  highestScore = 0;
  if(level.teamBased) {
    if(isDefined(game["teamScores"])) {
      highestScore = game["teamScores"]["allies"];
      if(game["teamScores"]["axis"] > highestScore) {
        highestScore = game["teamScores"]["axis"];
      }
    }
  } else {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(isDefined(player.score) && player.score > highestScore) {
          highestScore = player.score;
        }
      }
    }
  }
  return highestScore;
}

is_ai_sight_line() {
  return isDefined(self.spawnflags) && self.spawnflags & 2;
}

is_dynamic_path() {
  return isDefined(self.spawnflags) && self.spawnflags & 1;
}