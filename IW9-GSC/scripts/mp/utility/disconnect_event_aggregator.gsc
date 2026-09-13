/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\disconnect_event_aggregator.gsc
**************************************************************/

rundisconnectcallbacks(player) {
  if(!isDefined(level.ondisconnecteventcallbacks))
    level.ondisconnecteventcallbacks = [];

  foreach(callback in level.ondisconnecteventcallbacks)
  level thread[[callback]](player);
}

_id_7104B549684A0447(player) {
  if(!isDefined(level._id_37E3BC2C588941BB))
    level._id_37E3BC2C588941BB = [];

  foreach(callback in level._id_37E3BC2C588941BB)
  level[[callback]](player);
}

registerondisconnecteventcallback(callback) {
  if(!isDefined(level.ondisconnecteventcallbacks))
    level.ondisconnecteventcallbacks = [];

  level.ondisconnecteventcallbacks[level.ondisconnecteventcallbacks.size] = callback;
}

_id_5B91DF923C38392B(callback) {
  if(!isDefined(level._id_37E3BC2C588941BB))
    level._id_37E3BC2C588941BB = [];

  level._id_37E3BC2C588941BB[level._id_37E3BC2C588941BB.size] = callback;
}