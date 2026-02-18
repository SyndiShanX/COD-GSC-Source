/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6e0a2f806b25fee3.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace stim_count;
class class_44eccfcc: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("stim_count");
  }

  function function_6eef7f4f(localclientnum, value) {
    set_data(localclientnum, "stim_count", value);
  }

  function setup_clientfields(var_ce21941e) {
    cluielem::setup_clientfields("stim_count");
    cluielem::add_clientfield("stim_count", 1, 4, "int", var_ce21941e);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "stim_count", 0);
  }
}

function register(var_ce21941e) {
  elem = new class_44eccfcc();
  [[elem]] - > setup_clientfields(var_ce21941e);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "stim_count"])) {
    level.var_ae746e8f[# "stim_count"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "stim_count"])) {
    level.var_ae746e8f[# "stim_count"] = [];
  } else if(!isarray(level.var_ae746e8f[# "stim_count"])) {
    level.var_ae746e8f[# "stim_count"] = array(level.var_ae746e8f[# "stim_count"]);
  }

  level.var_ae746e8f[# "stim_count"][level.var_ae746e8f[# "stim_count"].size] = elem;
}

function register_clientside() {
  elem = new class_44eccfcc();
  [[elem]] - > register_clientside();
  return elem;
}

function open(player) {
  [[self]] - > open(player);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

function function_6eef7f4f(localclientnum, value) {
  [[self]] - > function_6eef7f4f(localclientnum, value);
}