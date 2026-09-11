/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\join_team_aggregator.gsc
*******************************************************/

function onplayerjointeam(var0) {
  thread ref_1206f(var0);

  if(isDefined(level.onjointeamcallbacks)) {
    foreach(var2 in level.onjointeamcallbacks) {
      self[[var2]](var0);
    }

    return;
  }
}

function registeronplayerjointeamcallback(var0) {
  if(!isDefined(level.onjointeamcallbacks)) {
    level.onjointeamcallbacks = [];
  }

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = var0;
}

function ref_1206f(var0) {
  var0 notify("onPlayerJoinTeamNoSpectator");

  if(var0.sessionstate == "spectator") {
    var0 endon("death_or_disconnect");
    var0 endon("onPlayerJoinTeamNoSpectator");

    while(var0.sessionstate == "spectator") {
      waitframe();
    }
  }

  if(isDefined(level.ref_12045)) {
    foreach(var2 in level.ref_12045) {
      self[[var2]](var0);
    }

    return;
  }
}

function ref_12b2f(var0) {
  if(!isDefined(level.ref_12045)) {
    level.ref_12045 = [];
  }

  level.ref_12045[level.ref_12045.size] = var0;
}