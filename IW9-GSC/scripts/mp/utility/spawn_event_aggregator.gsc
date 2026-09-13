/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\spawn_event_aggregator.gsc
*********************************************************/

init() {
  if(!isDefined(level.onplayerspawncallbacks))
    level.onplayerspawncallbacks = [];

  level thread onplayerconnect();
}

onplayerconnect() {
  self notify("spawn_aggregator_onPlayerConnect_singleton");
  self endon("spawn_aggregator_onPlayerConnect_singleton");

  for(;;) {
    level waittill("connected", player);
    player thread onplayerspawned();
  }
}

registeronplayerspawncallback(callback) {
  if(!isDefined(level.onplayerspawncallbacks))
    init();

  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = callback;
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    foreach(callback in level.onplayerspawncallbacks)
    self[[callback]]();
  }
}