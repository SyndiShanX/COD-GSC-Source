/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_dynamic_events.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;

DEFAULT_START_PERCENTAGE = .5;
SD_WAIT_TIME = 10;

DynamicEvent(dynamicEventStartFunc, dynamicEventResetFunc, dynamicEventEndFunc) {
  if(getdvarint("r_reflectionProbeGenerate")) {
    return;
  }

  if(isDefined(level.dynamicEventsType)) {
    if(level.dynamicEventsType == 1) {
      return;
    }

    if(level.dynamicEventsType == 2) {
      if(isDefined(dynamicEventEndFunc)) {
        level[[dynamicEventEndFunc]]();
      }
      return;
    }
  }

  SetDvarIfUninitialized("scr_dynamic_event_state", "on");
  if(getdvar("scr_dynamic_event_state", "on") == "off") {
    return;
  } else if(getdvar("scr_dynamic_event_state", "on") == "endstate") {
    if(isDefined(dynamicEventEndFunc)) {
      level[[dynamicEventEndFunc]]();
    }
    return;
  }

  SetDvarIfUninitialized("scr_dynamic_event_start_perc", DEFAULT_START_PERCENTAGE);
  SetDvarIfUninitialized("scr_dynamic_event_start_now", 0);

  if(!isDefined(level.DynamicEvent)) {
    level.DynamicEvent = [];
  }

  if(level.gametype == "sd" || level.gametype == "sr") {
    level thread handle_sd_dynamicEvent(dynamicEventStartFunc, dynamicEventEndFunc);
  } else {
    level thread handle_dynamicEvent(dynamicEventStartFunc, dynamicEventResetFunc, false);
  }

  level thread logDynamicEventStartTime();
}

logDynamicEventStartTime() {
  level endon("game_ended");
  level waittill("dynamic_event_starting");

  currentDeciSeconds = getTimePassedDeciSecondsIncludingRounds();
  setMatchData("dynamicEventTimeDeciSecondsFromMatchStart", clampToShort(currentDeciSeconds));
}

handle_sd_dynamicEvent(dynamicEventStartFunc, dynamicEventEndFunc) {
  if(!isDefined(game["dynamicEvent_isInOvertime"])) {
    game["dynamicEvent_isInOvertime"] = false;
  }

  if(!isDefined(game["dynamicEvent_hasSwitchedSides"])) {
    game["dynamicEvent_hasSwitchedSides"] = false;
  }

  if(!isDefined(game["dynamicEvent_Overtime"])) {
    game["dynamicEvent_Overtime"] = false;
  }

  if(!isDefined(game["dynamicEvent_sd_round_counter"])) {
    game["dynamicEvent_sd_round_counter"] = 0;
  } else {
    game["dynamicEvent_sd_round_counter"]++;
  }

  /#level thread debug_watch_dynamicEvent_start_now( dynamicEventStartFunc );

  if(!game["dynamicEvent_isInOvertime"] && game["dynamicEvent_Overtime"]) {
    game["dynamicEvent_sd_round_counter"] = 0;
    game["dynamicEvent_isInOvertime"] = true;
    game["dynamicEvent_hasSwitchedSides"] = false;
  }

  if(isDefined(game["switchedsides"]) && game["switchedsides"] && !game["dynamicEvent_hasSwitchedSides"] && !game["dynamicEvent_isInOvertime"]) {
    game["dynamicEvent_sd_round_counter"] = 0;
    game["dynamicEvent_hasSwitchedSides"] = true;
  } else if(game["dynamicEvent_sd_round_counter"] == 1) {
    wait(SD_WAIT_TIME);
    level notify("dynamic_event_starting");
    if(isDefined(dynamicEventStartFunc) && isDefined(dynamicEventEndFunc)) {
      level[[dynamicEventStartFunc]]();
    }
  } else if(game["dynamicEvent_sd_round_counter"] > 1) {
    if(isDefined(dynamicEventStartFunc) && isDefined(dynamicEventEndFunc)) {
      level[[dynamicEventEndFunc]]();
    }
  }
}

debug_watch_dynamicEvent_start_now(dynamicEventStartFunc) {
  level endon("game_ended");
  level notify("waching_dynamicevent_dvar");
  level endon("waching_dynamicevent_dvar");

  if(GetDvarInt("scr_dynamic_event_start_now") == 1) {
    setDvar("scr_dynamic_event_start_now", 0);
  }

  while(true) {
    if(GetDvarInt("scr_dynamic_event_start_now") == 1 && game["dynamicEvent_sd_round_counter"] == 0) {
      level notify("dynamic_event_starting");
      if(isDefined(dynamicEventStartFunc)) {
        level[[dynamicEventStartFunc]]();
      }
      game["dynamicEvent_sd_round_counter"] = 1;
      while(GetDvarInt("scr_dynamic_event_start_now", 1) == 1) {
        wait(1);
      }
    }
    wait(1);
  }
}

handle_dynamicEvent(dynamicEventStartFunc, dynamicEventResetFunc, doScoreCheck) {
  time_limit = getDynamicEventTimeLimit();
  start_time = getDynamicEventStartTime();

  score = undefined;
  score_limit = getScoreLimit();
  if(!isDefined(doScoreCheck)) {
    doScoreCheck = true;
  }

  while(time_limit > start_time && (!doScoreCheck || (!isDefined(score) || score <= score_limit * level.DynamicEvent["start_percent"]))) {
    start_percent = GetDvarfloat("scr_dynamic_event_start_perc", level.DynamicEvent["start_percent"]);
    if(start_percent != level.DynamicEvent["start_percent"]) {
      setDynamicEventStartPercent(start_percent);
      start_time = getDynamicEventStartTime();
    }

    if(GetDvarInt("scr_dynamic_event_start_now") == 1) {
      time_limit = start_time;
    }

    wait(1);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    time_limit = time_limit - 1;
    score = GetDynamicEventHighestScore();
  }

  level notify("dynamic_event_starting");

  if(isDefined(dynamicEventStartFunc)) {
    level[[dynamicEventStartFunc]]();
  }

  while(isDefined(dynamicEventResetFunc)) {
    SetDvar("scr_dynamic_event_start_now", 0);
    while(!GetDvarInt("scr_dynamic_event_start_now", 0)) {
      waitframe();
    }

    level notify("dynamic_event_reset");
    level[[dynamicEventResetFunc]]();

    SetDvar("scr_dynamic_event_start_now", 0);
    while(!GetDvarInt("scr_dynamic_event_start_now", 0)) {
      waitframe();
    }

    level notify("dynamic_event_starting");

    if(isDefined(dynamicEventStartFunc)) {
      level[[dynamicEventStartFunc]]();
    }
  }

}

setDynamicEventStartPercent(percent) {
  if(!isDefined(percent)) {
    percent = DEFAULT_START_PERCENTAGE;
  }

  if(percent < 0 || percent > 1) {
    AssertMsg("expecting a percent between 0 and 1");
  }

  level.DynamicEvent["start_percent"] = percent;
}

getDynamicEventStartTime() {
  if(!isDefined(level.DynamicEvent["start_percent"])) {
    setDynamicEventStartPercent();
  }

  time_limit = getDynamicEventTimeLimit();

  start_time = time_limit - (time_limit * level.DynamicEvent["start_percent"]);

  return start_time;
}

GetDynamicEventHighestScore() {
  score = undefined;
  if(level.teamBased) {
    team = maps\mp\gametypes\_gamescore::getWinningTeam();
    if(isDefined(team) && team == "none" && isDefined(level.teamNameList)) {
      score = maps\mp\gametypes\_gamescore::_getTeamScore(level.teamNameList[0]);
    } else if(isDefined(team)) {
      score = maps\mp\gametypes\_gamescore::_getTeamScore(team);
    }
  } else {
    player = maps\mp\gametypes\_gamescore::getHighestScoringPlayer();
    if(!isDefined(player) && isDefined(level.players) && level.players.size > 0) {
      score = maps\mp\gametypes\_gamescore::_getPlayerScore(level.players[0]);
    } else if(isDefined(player)) {
      score = maps\mp\gametypes\_gamescore::_getPlayerScore(player);
    }
  }

  return score;
}

getDynamicEventTimeLimit() {
  time_limit = getTimeLimit();
  if(time_limit == 0) {
    time_limit = 10 * 60;
  } else {
    time_limit = time_limit * 60;
  }

  has_half_time = getHalfTime();
  if(isDefined(has_half_time) && has_half_time) {
    time_limit = time_limit / 2;
  }

  return time_limit;
}