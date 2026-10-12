/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\lui_game_event_aggregator.gsc
************************************************************/



#namespace lui_game_event_aggregator;

function init() {
  level thread onplayerconnect();
}

function onplayerconnect() {
  level.onluieventcallbacks = [];

  for(;;) {
    level waittill("connected", player);
    player thread onplayerconnected();
  }
}

function registeronluieventcallback(callback) {
  level.onluieventcallbacks[level.onluieventcallbacks.size] = callback;
}

function onplayerconnected() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", channel, val);

    foreach(callback in level.onluieventcallbacks) {
      self[[callback]](channel, val);
    }
  }
}