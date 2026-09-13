/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\join_team_aggregator.gsc
*******************************************************/

onplayerjointeam(player) {
  foreach(callback in level.onjointeamcallbacks)
  self[[callback]](player);
}

registeronplayerjointeamcallback(callback) {
  if(!isDefined(level.onjointeamcallbacks))
    level.onjointeamcallbacks = [];

  level.onjointeamcallbacks[level.onjointeamcallbacks.size] = callback;
}