/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\disconnect_event_aggregator.gsc
**************************************************************/

function init() {
  if(!isDefined(level.ondisconnecteventcallbacks)) {
    level.ondisconnecteventcallbacks = [];
    return;
  }
}

function rundisconnectcallbacks(var0) {
  foreach(var2 in level.ondisconnecteventcallbacks) {
    level[[var2]](var0);
  }
}

function registerondisconnecteventcallback(var0) {
  if(!isDefined(level.ondisconnecteventcallbacks)) {
    level.ondisconnecteventcallbacks = [];
  }

  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = var0;
}