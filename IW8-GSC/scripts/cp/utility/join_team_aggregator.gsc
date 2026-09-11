/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\join_team_aggregator.gsc
*******************************************************/

function onplayerjointeam(var_0) {
  foreach(var_2 in level.onjointeamcallbacks) {
    self[[var_2]](var_0);
  }
}

function registeronplayerjointeamcallback(var_0) {
  if(!isDefined(level.onjointeamcallbacks)) {
    level.onjointeamcallbacks = [];
  }

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = var_0;
}