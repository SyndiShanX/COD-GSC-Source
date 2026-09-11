/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\join_squad_aggregator.gsc
********************************************************/

function onplayerjoinsquad(var_0) {
  foreach(var_2 in level.onjoinsquadcallbacks) {
    self[[var_2]](var_0);
  }
}

function registeronplayerjoinsquadcallback(var_0) {
  if(!isDefined(level.onjoinsquadcallbacks)) {
    level.onjoinsquadcallbacks = [];
  }

  level.onjoinsquadcallbacks[level.onjoinsquadcallbacks.size] = var_0;
}