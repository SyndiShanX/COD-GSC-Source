/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\disconnect_event_aggregator.gsc
******************************************************/

init() {
  if(!isDefined(level.ondisconnecteventcallbacks))
    level.ondisconnecteventcallbacks = [];
}

rundisconnectcallbacks(var_0) {
  foreach(var_2 in level.ondisconnecteventcallbacks)
  level[[var_2]](var_0);
}

registerondisconnecteventcallback(var_0) {
  if(!isDefined(level.ondisconnecteventcallbacks))
    level.ondisconnecteventcallbacks = [];

  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = var_0;
}