/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\spawn_event_aggregator.gsc
************************************************************/

init() {
  if(!isDefined(level.onplayerspawncallbacks))
    level.onplayerspawncallbacks = [];

  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onplayerspawned();
  }
}

registeronplayerspawncallback(callback) {
  if(!isDefined(level.onplayerspawncallbacks))
    level.onplayerspawncallbacks = [];

  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = callback;
}

_id_DE35280460AE9411(_id_99B0CBEEC73DD75D) {
  _id_6D906809844C7CB1 = [];

  foreach(callback in level.onplayerspawncallbacks) {
    if(_id_99B0CBEEC73DD75D != callback)
      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = callback;
  }

  level.onplayerspawncallbacks = _id_6D906809844C7CB1;
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    foreach(callback in level.onplayerspawncallbacks)
    self[[callback]]();
  }
}