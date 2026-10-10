/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\utility\spawn_event_aggregator.gsc
***************************************************************/

#namespace spawn_event_aggregator;

function init() {
  if(!isDefined(level.onplayerspawncallbacks)) {
    level.onplayerspawncallbacks = [];
  }

  level thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onplayerspawned();
  }
}

function registeronplayerspawncallback(callback) {
  if(!isDefined(level.onplayerspawncallbacks)) {
    level.onplayerspawncallbacks = [];
  }

  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = callback;
}

function function_de35280460ae9411(remove_callback) {
  temp_array = [];

  foreach(callback in level.onplayerspawncallbacks) {
    if(remove_callback != callback) {
      temp_array[temp_array.size] = callback;
    }
  }

  level.onplayerspawncallbacks = temp_array;
}

function onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    foreach(callback in level.onplayerspawncallbacks) {
      self[[callback]]();
    }
  }
}