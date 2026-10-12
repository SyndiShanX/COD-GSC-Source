/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\join_team_aggregator.gsc
*******************************************************/



#namespace join_team_aggregator;

function onplayerjointeam(player) {
  foreach(callback in level.onjointeamcallbacks) {
    self[[callback]](player);
  }
}

function registeronplayerjointeamcallback(callback) {
  if(!isDefined(level.onjointeamcallbacks)) {
    level.onjointeamcallbacks = [];
  }

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = callback;
}