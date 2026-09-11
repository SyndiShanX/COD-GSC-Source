/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\lui_game_event_aggregator.gsc
************************************************************/

function init() {
  thread onplayerconnect();
}

function onplayerconnect() {
  level.onluieventcallbacks = [];

  for(;;) {
    level waittill("connected", var0);
    thread onplayerconnected();
  }
}

function registeronluieventcallback(var0) {
  level.onluieventcallbacks[level.onluieventcallbacks.size] = var0;
}

function onplayerconnected() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    foreach(var3 in level.onluieventcallbacks) {
      self[[var3]](var0, var1);
    }
  }
}