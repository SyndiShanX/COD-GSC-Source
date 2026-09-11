/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\spawn_event_aggregator.gsc
*********************************************************/

function init() {
  thread onplayerconnect();
}

function onplayerconnect() {
  level.onplayerspawncallbacks = [];

  for(;;) {
    level waittill("connected", var_0);
    thread onplayerspawned();
  }
}

function registeronplayerspawncallback(var_0) {
  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = var_0;
}

function onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    foreach(var_1 in level.onplayerspawncallbacks) {
      self[[var_1]]();
    }
  }
}