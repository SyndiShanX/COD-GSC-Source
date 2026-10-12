/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\disconnect_event_aggregator.gsc
**************************************************************/



#namespace disconnect_event_aggregator;

function init() {
  level.ondisconnecteventcallbacks = [];
}

function rundisconnectcallbacks(player) {
  foreach(callback in level.ondisconnecteventcallbacks) {
    level[[callback]](player);
  }
}

function registerondisconnecteventcallback(callback) {
  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = callback;
}