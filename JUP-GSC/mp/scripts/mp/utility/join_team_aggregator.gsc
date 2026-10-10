/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\join_team_aggregator.gsc
**********************************************************/

#namespace join_team_aggregator;

function onplayerjointeam(player) {
  thread onplayerjointeamnospectator(player);

  if(isDefined(level.onjointeamcallbacks)) {
    foreach(callback in level.onjointeamcallbacks) {
      self[[callback]](player);
    }
  }
}

function registeronplayerjointeamcallback(callback) {
  if(!isDefined(level.onjointeamcallbacks)) {
    level.onjointeamcallbacks = [];
  }

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = callback;
}

function onplayerjointeamnospectator(player) {
  player notify("onPlayerJoinTeamNoSpectator");

  if(player.sessionstate == "spectator") {
    player endon("death_or_disconnect");
    player endon("onPlayerJoinTeamNoSpectator");

    while(player.sessionstate == "spectator") {
      waitframe();
    }
  }

  if(isDefined(level.onjointeamnospectatorcallbacks)) {
    foreach(callback in level.onjointeamnospectatorcallbacks) {
      self[[callback]](player);
    }
  }
}

function registeronplayerjointeamnospectatorcallback(callback) {
  if(!isDefined(level.onjointeamnospectatorcallbacks)) {
    level.onjointeamnospectatorcallbacks = [];
  }

  level.onjointeamnospectatorcallbacks[level.onjointeamnospectatorcallbacks.size] = callback;
}