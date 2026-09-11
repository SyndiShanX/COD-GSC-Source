/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\join_squad_aggregator.gsc
********************************************************/

function onplayerjoinsquad(var0) {
  foreach(var2 in level.onjoinsquadcallbacks) {
    self[[var2]](var0);
  }
}

function registeronplayerjoinsquadcallback(var0) {
  if(!isDefined(level.onjoinsquadcallbacks)) {
    level.onjoinsquadcallbacks = [];
  }

  level.onjoinsquadcallbacks[level.onjoinsquadcallbacks.size] = var0;
}