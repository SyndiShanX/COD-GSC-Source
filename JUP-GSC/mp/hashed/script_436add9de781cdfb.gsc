/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_436add9de781cdfb.gsc
*************************************************/

#namespace namespace_9cede1970b303649;

function init() {
  if(!isDefined(level.var_cbf08f5916cab0b0)) {
    level.var_cbf08f5916cab0b0 = [];
  }

  level thread function_5b1d60872d5f7d1f();
}

function function_5b1d60872d5f7d1f() {
  for(;;) {
    level waittill("connected", player);
    player thread function_30ae32f045a9401();
  }
}

function function_3a363ae38f309166(callback) {
  if(!isDefined(level.var_cbf08f5916cab0b0)) {
    level.var_cbf08f5916cab0b0 = [];
  }

  level.var_cbf08f5916cab0b0[level.var_cbf08f5916cab0b0.size] = callback;
}

function function_c954b1a939feae65(removecallback) {
  temparray = [];

  foreach(callback in level.var_cbf08f5916cab0b0) {
    if(removecallback != callback) {
      temparray[temparray.size] = callback;
    }
  }

  level.var_cbf08f5916cab0b0 = temparray;
}

function function_30ae32f045a9401() {
  self endon("disconnect");

  for(;;) {
    self waittill("reload_start");

    foreach(callback in level.var_cbf08f5916cab0b0) {
      self[[callback]]();
    }
  }
}