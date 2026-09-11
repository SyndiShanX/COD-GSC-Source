/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\disconnect_event_aggregator.gsc
**************************************************************/

function init() {
  level.ondisconnecteventcallbacks = [];
}

function rundisconnectcallbacks(var0) {
  foreach(var2 in level.ondisconnecteventcallbacks) {
    level[[var2]](var0);
  }
}

function registerondisconnecteventcallback(var0) {
  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = var0;
}