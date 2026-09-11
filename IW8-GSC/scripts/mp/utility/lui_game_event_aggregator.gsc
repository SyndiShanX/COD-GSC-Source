/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\lui_game_event_aggregator.gsc
************************************************************/

function init() {
  thread onplayerconnect();
}

function onplayerconnect() {
  level.onluieventcallbacks = [];

  for(;;) {
    level waittill("connected", var_0);
    thread onplayerconnected();
  }
}

function registeronluieventcallback(var_0) {
  level.onluieventcallbacks[level.onluieventcallbacks.size] = var_0;
}

function onplayerconnected() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    foreach(var_3 in level.onluieventcallbacks) {
      self[[var_3]](var_0, var_1);
    }
  }
}