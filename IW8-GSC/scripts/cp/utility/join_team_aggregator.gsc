/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\join_team_aggregator.gsc
*******************************************************/

function onplayerjointeam(var0) {
  foreach(var2 in level.onjointeamcallbacks) {
    self[[var2]](var0);
  }
}

function registeronplayerjointeamcallback(var0) {
  if(!isDefined(level.onjointeamcallbacks)) {
    level.onjointeamcallbacks = [];
  }

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = var0;
}