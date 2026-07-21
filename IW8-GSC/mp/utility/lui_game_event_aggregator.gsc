/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\lui_game_event_aggregator.gsc
****************************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  level.onluieventcallbacks = [];

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread onplayerconnected();
  }
}

registeronluieventcallback(var_0) {
  level.onluieventcallbacks[level.onluieventcallbacks.size] = var_0;
}

onplayerconnected() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    foreach(var_3 in level.onluieventcallbacks)
    self[[var_3]](var_0, var_1);
  }
}