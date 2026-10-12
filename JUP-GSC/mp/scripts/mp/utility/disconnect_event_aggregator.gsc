/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\disconnect_event_aggregator.gsc
**************************************************************/

#namespace disconnect_event_aggregator;

function rundisconnectcallbacks(player) {
  if(!isDefined(level.ondisconnecteventcallbacks)) {
    level.ondisconnecteventcallbacks = [];
  }

  foreach(callback in level.ondisconnecteventcallbacks) {
    level thread[[callback]](player);
  }
}

function function_fab0966a8fb0e314(player) {
  if(!isDefined(level.var_2f907afe1ed3f832)) {
    level.var_2f907afe1ed3f832 = [];
  }

  foreach(callback in level.var_2f907afe1ed3f832) {
    level thread[[callback]](player);
  }
}

function function_7104b549684a0447(player) {
  if(!isDefined(level.var_37e3bc2c588941bb)) {
    level.var_37e3bc2c588941bb = [];
  }

  foreach(callback in level.var_37e3bc2c588941bb) {
    level[[callback]](player);
  }
}

function registerondisconnecteventcallback(callback) {
  if(!isDefined(level.ondisconnecteventcallbacks)) {
    level.ondisconnecteventcallbacks = [];
  }

  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = callback;
}

function function_18819785bafad430(callback) {
  if(!isDefined(level.var_2f907afe1ed3f832)) {
    level.var_2f907afe1ed3f832 = [];
  }

  level.var_2f907afe1ed3f832[level.var_2f907afe1ed3f832.size] = callback;
}

function function_5b91df923c38392b(callback) {
  if(!isDefined(level.var_37e3bc2c588941bb)) {
    level.var_37e3bc2c588941bb = [];
  }

  level.var_37e3bc2c588941bb[level.var_37e3bc2c588941bb.size] = callback;
}