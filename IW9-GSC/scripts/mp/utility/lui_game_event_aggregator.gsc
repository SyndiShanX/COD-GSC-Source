/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\lui_game_event_aggregator.gsc
************************************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  level.onluieventcallbacks = [];
  level notify("lui_game_event_aggregator_initialized");

  for(;;) {
    level waittill("connected", player);
    player thread onplayerconnected();
  }
}

registeronluieventcallback(callback) {
  level.onluieventcallbacks[level.onluieventcallbacks.size] = callback;
}

_id_89376739FB493757(callback) {
  level.onluieventcallbacks = scripts\engine\utility::array_remove(level.onluieventcallbacks, callback);
}

onplayerconnected() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, val);

    foreach(callback in level.onluieventcallbacks)
    self[[callback]](_id_7148C1A6F25491F8, val);
  }
}