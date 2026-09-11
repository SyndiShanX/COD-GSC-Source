/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\disconnect_event_aggregator.gsc
**************************************************************/

function init() {
  level.ondisconnecteventcallbacks = [];
}

function rundisconnectcallbacks(var_0) {
  foreach(var_2 in level.ondisconnecteventcallbacks) {
    level[[var_2]](var_0);
  }
}

function registerondisconnecteventcallback(var_0) {
  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = var_0;
}