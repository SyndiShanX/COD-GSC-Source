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
    level waittill("connected", var0);
    thread onplayerspawned();
  }
}

function registeronplayerspawncallback(var0) {
  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = var0;
}

function onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    foreach(var1 in level.onplayerspawncallbacks) {
      self[[var1]]();
    }
  }
}