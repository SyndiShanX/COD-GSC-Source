/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_events.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\shared\util_shared;
#namespace events;

function add_timed_event(seconds, notify_string, client_notify_string) {
  assert(seconds >= 0);
  if(level.timelimit > 0) {
    level thread timed_event_monitor(seconds, notify_string, client_notify_string);
  }
}

function timed_event_monitor(seconds, notify_string, client_notify_string) {
  for(;;) {
    wait(0.5);
    if(!isDefined(level.starttime)) {
      continue;
    }
    millisecs_remaining = globallogic_utils::gettimeremaining();
    seconds_remaining = millisecs_remaining / 1000;
    if(seconds_remaining <= seconds) {
      event_notify(notify_string, client_notify_string);
      return;
    }
  }
}

function add_score_event(score, notify_string, client_notify_string) {
  assert(score >= 0);
  if(level.scorelimit > 0) {
    if(level.teambased) {
      level thread score_team_event_monitor(score, notify_string, client_notify_string);
    } else {
      level thread score_event_monitor(score, notify_string, client_notify_string);
    }
  }
}

function add_round_score_event(score, notify_string, client_notify_string) {
  assert(score >= 0);
  if(level.roundscorelimit > 0) {
    roundscoretobeat = (level.roundscorelimit * game["roundsplayed"]) + score;
    if(level.teambased) {
      level thread score_team_event_monitor(roundscoretobeat, notify_string, client_notify_string);
    } else {
      level thread score_event_monitor(roundscoretobeat, notify_string, client_notify_string);
    }
  }
}

function any_team_reach_score(score) {
  foreach(team in level.teams) {
    if(game["teamScores"][team] >= score) {
      return true;
    }
  }
  return false;
}

function score_team_event_monitor(score, notify_string, client_notify_string) {
  for(;;) {
    wait(0.5);
    if(any_team_reach_score(score)) {
      event_notify(notify_string, client_notify_string);
      return;
    }
  }
}

function score_event_monitor(score, notify_string, client_notify_string) {
  for(;;) {
    wait(0.5);
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].score) && players[i].score >= score) {
        event_notify(notify_string, client_notify_string);
        return;
      }
    }
  }
}

function event_notify(notify_string, client_notify_string) {
  if(isDefined(notify_string)) {
    level notify(notify_string);
  }
  if(isDefined(client_notify_string)) {
    util::clientnotify(client_notify_string);
  }
}