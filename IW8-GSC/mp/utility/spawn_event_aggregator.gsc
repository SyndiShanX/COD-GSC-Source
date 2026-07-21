/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\spawn_event_aggregator.gsc
*************************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  level.onplayerspawncallbacks = [];

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread onplayerspawned();
  }
}

registeronplayerspawncallback(var_0) {
  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = var_0;
}

onplayerspawned() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    foreach(var_1 in level.onplayerspawncallbacks)
    self[[var_1]]();
  }
}