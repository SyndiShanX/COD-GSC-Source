/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\disconnect_event_aggregator.gsc
**************************************************************/

init() {
  level.ondisconnecteventcallbacks = [];
}

rundisconnectcallbacks(player) {
  foreach(callback in level.ondisconnecteventcallbacks)
  level[[callback]](player);
}

registerondisconnecteventcallback(callback) {
  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = callback;
}