/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\utility\spawn_event_aggregator.gsc
*********************************************************/

#namespace spawn_event_aggregator;

function init() {
  if(!isDefined(level.onplayerspawncallbacks)) {
    level.onplayerspawncallbacks = [];
  }

  level thread onplayerconnect();
}

function onplayerconnect() {
  self notify("\x940\xa0!\x10cq\x14M$?ds\x19\x1cE\r\x8d/L\xcc\x87\xd8\xf9^u\x97?\xd5e;@\xdc\xf7\xc9\xcdYE\xdc\xd9\x8a\x19");
  self endon("\x940\xa0!\x10cq\x14M$?ds\x19\x1cE\r\x8d/L\xcc\x87\xd8\xf9^u\x97?\xd5e;@\xdc\xf7\xc9\xcdYE\xdc\xd9\x8a\x19");

  for(;;) {
    level waittill("Z\xc4\x9eQ\xd37_m%", player);
    player thread onplayerspawned();
  }
}

function registeronplayerspawncallback(callback) {
  if(!isDefined(level.onplayerspawncallbacks)) {
    init();
  }

  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = callback;
}

function onplayerspawned() {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  for(;;) {
    self waittill("N\xf8\xfc\xc5\x90A\xa3\t\x06d\b\x9d\x94\xd1");

    foreach(callback in level.onplayerspawncallbacks) {
      self[[callback]]();
    }
  }
}