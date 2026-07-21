/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\join_squad_aggregator.gsc
************************************************/

onplayerjoinsquad(var_0) {
  foreach(var_2 in level.onjoinsquadcallbacks)
  self[[var_2]](var_0);
}

registeronplayerjoinsquadcallback(var_0) {
  if(!isDefined(level.onjoinsquadcallbacks))
    level.onjoinsquadcallbacks = [];

  level.onjoinsquadcallbacks[level.onjoinsquadcallbacks.size] = var_0;
}