/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\join_team_aggregator.gsc
*******************************************************/

function onplayerjointeam(var_0) {
  thread ref_1206F(var_0);

  if(isDefined(level.onjointeamcallbacks)) {
    foreach(var_2 in level.onjointeamcallbacks) {
      self[[var_2]](var_0);
    }

    return;
  }
}

function registeronplayerjointeamcallback(var_0) {
  if(!isDefined(level.onjointeamcallbacks)) {
    level.onjointeamcallbacks = [];
  }

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = var_0;
}

function ref_1206F(var_0) {
  var_0 notify("onPlayerJoinTeamNoSpectator");

  if(var_0.sessionstate == "spectator") {
    var_0 endon("death_or_disconnect");
    var_0 endon("onPlayerJoinTeamNoSpectator");

    while(var_0.sessionstate == "spectator") {
      waitframe();
    }
  }

  if(isDefined(level.ref_12045)) {
    foreach(var_2 in level.ref_12045) {
      self[[var_2]](var_0);
    }

    return;
  }
}

function ref_12B2F(var_0) {
  if(!isDefined(level.ref_12045)) {
    level.ref_12045 = [];
  }

  level.ref_12045[level.ref_12045.size] = var_0;
}