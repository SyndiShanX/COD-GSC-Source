/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\lui_game_event_aggregator.gsc
***************************************************************/

#using scripts\engine\utility;
#namespace lui_game_event_aggregator;

function init() {
  level thread onplayerconnect();
}

function onplayerconnect() {
  level.onluieventcallbacks = [];
  level notify("lui_game_event_aggregator_initialized");

  for(;;) {
    level waittill("connected", player);
    player thread onplayerconnected();
  }
}

function registeronluieventcallback(callback) {
  level.onluieventcallbacks[level.onluieventcallbacks.size] = callback;
}

function function_89376739fb493757(callback) {
  level.onluieventcallbacks = scripts\engine\utility::array_remove(level.onluieventcallbacks, callback);
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