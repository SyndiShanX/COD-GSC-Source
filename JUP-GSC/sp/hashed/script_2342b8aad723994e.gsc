/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2342b8aad723994e.gsc
*************************************************/

#namespace join_squad_aggregator;

function onplayerjoinsquad(player) {
  if(!isDefined(level.onjoinsquadcallbacks)) {
    level.onjoinsquadcallbacks = [];
  }

  foreach(callback in level.onjoinsquadcallbacks) {
    self[[callback]](player);
  }
}

function registeronplayerjoinsquadcallback(callback) {
  if(!isDefined(level.onjoinsquadcallbacks)) {
    level.onjoinsquadcallbacks = [];
  }

  level.onjoinsquadcallbacks[level.onjoinsquadcallbacks.size] = callback;
}

function function_2a1e4811621fdcde(player) {
  if(!isDefined(level.var_dfe31f42a61aed79)) {
    level.var_dfe31f42a61aed79 = [];
  }

  foreach(callback in level.var_dfe31f42a61aed79) {
    self[[callback]](player);
  }
}

function function_a99987c7bf114da4(callback) {
  if(!isDefined(level.var_dfe31f42a61aed79)) {
    level.var_dfe31f42a61aed79 = [];
  }

  level.var_dfe31f42a61aed79[level.var_dfe31f42a61aed79.size] = callback;
}