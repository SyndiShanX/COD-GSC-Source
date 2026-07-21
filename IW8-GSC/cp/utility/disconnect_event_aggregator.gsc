/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\disconnect_event_aggregator.gsc
******************************************************/

init() {
  level.ondisconnecteventcallbacks = [];
}

rundisconnectcallbacks(var_0) {
  foreach(var_2 in level.ondisconnecteventcallbacks)
  level[[var_2]](var_0);
}

registerondisconnecteventcallback(var_0) {
  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = var_0;
}