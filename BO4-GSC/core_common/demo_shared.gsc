/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\demo_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\system_shared;

#namespace demo;

autoexec __init__system__() {
  system::register(#"demo", &__init__, undefined, undefined);
}

__init__() {
  game.var_e9714926 = #"demo";
  callback::on_start_gametype(&init);
  level thread watch_actor_bookmarks();
}

private init() {
  potm::function_d71338e4();
}

private add_bookmark(bookmark, overrideentitycamera) {
  if(!isDefined(bookmark)) {
    return;
  }

  if(!isDefined(overrideentitycamera)) {
    overrideentitycamera = 0;
  }

  adddemobookmark(bookmark.var_900768bc.id, bookmark.time, bookmark.mainclientnum, bookmark.otherclientnum, bookmark.scoreeventpriority, bookmark.inflictorentnum, bookmark.inflictorenttype, bookmark.var_5f0256c4, overrideentitycamera);
}

kill_bookmark(var_81538b15, var_f28fb772, einflictor, var_50d1e41a, overrideentitycamera) {
  bookmark = potm::function_5b1e9ed4(game.var_e9714926, #"kill", gettime(), var_81538b15, var_f28fb772, 0, einflictor, var_50d1e41a, overrideentitycamera);
  add_bookmark(bookmark, overrideentitycamera);
}

function_651a5f4(var_81538b15, einflictor) {
  bookmark = potm::function_5b1e9ed4(game.var_e9714926, #"object_destroy", gettime(), var_81538b15, undefined, 0, einflictor);
  add_bookmark(bookmark);
}

event_bookmark(bookmarkname, time, var_81538b15, scoreeventpriority, eventdata) {
  bookmark = potm::function_5b1e9ed4(game.var_e9714926, bookmarkname, time, var_81538b15, undefined, scoreeventpriority, undefined, undefined, 0, eventdata);
  add_bookmark(bookmark);
}

bookmark(bookmarkname, time, var_81538b15, var_f28fb772, scoreeventpriority) {
  bookmark = potm::function_5b1e9ed4(game.var_e9714926, bookmarkname, time, var_81538b15, var_f28fb772, scoreeventpriority);
  add_bookmark(bookmark);
}

function_c6ae5fd6(bookmarkname, winningteamindex, losingteamindex) {
  bookmark = potm::function_5b1e9ed4(game.var_e9714926, bookmarkname, gettime(), undefined, undefined, 0);

  if(!isDefined(bookmark)) {
    println("<dev string:x38>" + bookmarkname + "<dev string:x5a>");
    return;
  }

  if(isDefined(winningteamindex)) {
    bookmark.mainclientnum = winningteamindex;
  }

  if(isDefined(losingteamindex)) {
    bookmark.otherclientnum = losingteamindex;
  }

  add_bookmark(bookmark);
}

initactorbookmarkparams(killtimescount, killtimemsec, killtimedelay) {
  level.actor_bookmark_kill_times_count = killtimescount;
  level.actor_bookmark_kill_times_msec = killtimemsec;
  level.actor_bookmark_kill_times_delay = killtimedelay;
  level.actorbookmarkparamsinitialized = 1;
}

reset_actor_bookmark_kill_times() {
  if(!isDefined(level.actorbookmarkparamsinitialized)) {
    return;
  }

  if(!isDefined(self.actor_bookmark_kill_times)) {
    self.actor_bookmark_kill_times = [];
    self.ignore_actor_kill_times = 0;
  }

  for(i = 0; i < level.actor_bookmark_kill_times_count; i++) {
    self.actor_bookmark_kill_times[i] = 0;
  }
}

add_actor_bookmark_kill_time() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(level.actorbookmarkparamsinitialized)) {
    return;
  }

  if(!isDefined(self.ignore_actor_kill_times)) {
    self reset_actor_bookmark_kill_times();
  }

  now = gettime();

  if(now <= self.ignore_actor_kill_times) {
    return;
  }

  oldest_index = 0;
  oldest_time = now + 1;

  for(i = 0; i < level.actor_bookmark_kill_times_count; i++) {
    if(!self.actor_bookmark_kill_times[i]) {
      oldest_index = i;
      break;
    }

    if(oldest_time > self.actor_bookmark_kill_times[i]) {
      oldest_index = i;
      oldest_time = self.actor_bookmark_kill_times[i];
    }
  }

  self.actor_bookmark_kill_times[oldest_index] = now;
}

watch_actor_bookmarks() {
  while(true) {
    if(!isDefined(level.actorbookmarkparamsinitialized)) {
      wait 0.5;
      continue;
    }

    waitframe(1);
    waittillframeend();
    now = gettime();
    oldest_allowed = now - level.actor_bookmark_kill_times_msec;
    players = getplayers();

    for(player_index = 0; player_index < players.size; player_index++) {
      player = players[player_index];

      if(isbot(player)) {
        continue;
      }

      for(time_index = 0; time_index < level.actor_bookmark_kill_times_count; time_index++) {
        if(!isDefined(player.actor_bookmark_kill_times) || !player.actor_bookmark_kill_times[time_index]) {
          break;
        }

        if(oldest_allowed > player.actor_bookmark_kill_times[time_index]) {
          player.actor_bookmark_kill_times[time_index] = 0;
          break;
        }
      }

      if(time_index >= level.actor_bookmark_kill_times_count) {
        bookmark(#"actor_kill", gettime(), player);
        potm::bookmark(#"actor_kill", gettime(), player);
        player reset_actor_bookmark_kill_times();
        player.ignore_actor_kill_times = now + level.actor_bookmark_kill_times_delay;
      }
    }
  }
}