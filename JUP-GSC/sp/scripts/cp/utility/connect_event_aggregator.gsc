/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\utility\connect_event_aggregator.gsc
**************************************************************/

#namespace connect_event_aggregator;

function init() {
  level thread onplayerconnect();
}

function onplayerconnect() {
  if(!isDefined(level.onplayerconnectcallbacks)) {
    level.onplayerconnectcallbacks = [];
  }

  for(;;) {
    level waittill("connected", player);
    player thread onplayerconnected();
  }
}

function registeronconnectcallback(callback) {
  if(!isDefined(level.onplayerconnectcallbacks)) {
    level.onplayerconnectcallbacks = [];
  }

  level.onplayerconnectcallbacks[level.onplayerconnectcallbacks.size] = callback;
}

function onplayerconnected() {
  self endon("disconnect");

  foreach(callback in level.onplayerconnectcallbacks) {
    self[[callback]]();
  }
}