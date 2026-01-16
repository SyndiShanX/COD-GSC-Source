/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\demo_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#namespace demo;

function autoexec __init__sytem__() {
  system::register("demo", & __init__, undefined, undefined);
}

function __init__() {
  level thread watch_actor_bookmarks();
}

function initactorbookmarkparams(killtimescount, killtimemsec, killtimedelay) {
  level.actor_bookmark_kill_times_count = killtimescount;
  level.actor_bookmark_kill_times_msec = killtimemsec;
  level.actor_bookmark_kill_times_delay = killtimedelay;
  level.actorbookmarkparamsinitialized = 1;
}

function bookmark(type, time, mainclientent, otherclientent, eventpriority, inflictorent, overrideentitycamera, actorent) {
  mainclientnum = -1;
  otherclientnum = -1;
  inflictorentnum = -1;
  inflictorenttype = 0;
  inflictorbirthtime = 0;
  actorentnum = undefined;
  scoreeventpriority = 0;
  if(isdefined(mainclientent)) {
    mainclientnum = mainclientent getentitynumber();
  }
  if(isdefined(otherclientent)) {
    otherclientnum = otherclientent getentitynumber();
  }
  if(isdefined(eventpriority)) {
    scoreeventpriority = eventpriority;
  }
  if(isdefined(inflictorent)) {
    inflictorentnum = inflictorent getentitynumber();
    inflictorenttype = inflictorent getentitytype();
    if(isdefined(inflictorent.birthtime)) {
      inflictorbirthtime = inflictorent.birthtime;
    }
  }
  if(!isdefined(overrideentitycamera)) {
    overrideentitycamera = 0;
  }
  if(isdefined(actorent)) {
    actorentnum = actorent getentitynumber();
  }
  adddemobookmark(type, time, mainclientnum, otherclientnum, scoreeventpriority, inflictorentnum, inflictorenttype, inflictorbirthtime, overrideentitycamera, actorentnum);
}

function gameresultbookmark(type, winningteamindex, losingteamindex) {
  mainclientnum = -1;
  otherclientnum = -1;
  scoreeventpriority = 0;
  inflictorentnum = -1;
  inflictorenttype = 0;
  inflictorbirthtime = 0;
  overrideentitycamera = 0;
  actorentnum = undefined;
  if(isdefined(winningteamindex)) {
    mainclientnum = winningteamindex;
  }
  if(isdefined(losingteamindex)) {
    otherclientnum = losingteamindex;
  }
  adddemobookmark(type, gettime(), mainclientnum, otherclientnum, scoreeventpriority, inflictorentnum, inflictorenttype, inflictorbirthtime, overrideentitycamera, actorentnum);
}

function reset_actor_bookmark_kill_times() {
  if(!isdefined(level.actorbookmarkparamsinitialized)) {
    return;
  }
  if(!isdefined(self.actor_bookmark_kill_times)) {
    self.actor_bookmark_kill_times = [];
    self.ignore_actor_kill_times = 0;
  }
  for (i = 0; i < level.actor_bookmark_kill_times_count; i++) {
    self.actor_bookmark_kill_times[i] = 0;
  }
}

function add_actor_bookmark_kill_time() {
  if(!isdefined(level.actorbookmarkparamsinitialized)) {
    return;
  }
  now = gettime();
  if(now <= self.ignore_actor_kill_times) {
    return;
  }
  oldest_index = 0;
  oldest_time = now + 1;
  for (i = 0; i < level.actor_bookmark_kill_times_count; i++) {
    if(!self.actor_bookmark_kill_times[i]) {
      oldest_index = i;
      break;
      continue;
    }
    if(oldest_time > self.actor_bookmark_kill_times[i]) {
      oldest_index = i;
      oldest_time = self.actor_bookmark_kill_times[i];
    }
  }
  self.actor_bookmark_kill_times[oldest_index] = now;
}

function watch_actor_bookmarks() {
  while (true) {
    if(!isdefined(level.actorbookmarkparamsinitialized)) {
      wait(0.5);
      continue;
    }
    wait(0.05);
    waittillframeend();
    now = gettime();
    oldest_allowed = now - level.actor_bookmark_kill_times_msec;
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
      player = players[player_index];
      if(isdefined(player.pers[""]) && player.pers[""]) {
        continue;
      }
      for (time_index = 0; time_index < level.actor_bookmark_kill_times_count; time_index++) {
        if(!isdefined(player.actor_bookmark_kill_times) || !player.actor_bookmark_kill_times[time_index]) {
          break;
          continue;
        }
        if(oldest_allowed > player.actor_bookmark_kill_times[time_index]) {
          player.actor_bookmark_kill_times[time_index] = 0;
          break;
        }
      }
      if(time_index >= level.actor_bookmark_kill_times_count) {
        bookmark("actor_kill", gettime(), player);
        player reset_actor_bookmark_kill_times();
        player.ignore_actor_kill_times = now + level.actor_bookmark_kill_times_delay;
      }
    }
  }
}