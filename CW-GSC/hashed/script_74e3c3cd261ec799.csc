/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_74e3c3cd261ec799.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace sr_objective_timer;
class class_b5586f52: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("sr_objective_timer");
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("sr_objective_timer");
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
  }
}

function register() {
  elem = new class_b5586f52();
  [[elem]] - > setup_clientfields();

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "sr_objective_timer"])) {
    level.var_ae746e8f[# "sr_objective_timer"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "sr_objective_timer"])) {
    level.var_ae746e8f[# "sr_objective_timer"] = [];
  } else if(!isarray(level.var_ae746e8f[# "sr_objective_timer"])) {
    level.var_ae746e8f[# "sr_objective_timer"] = array(level.var_ae746e8f[# "sr_objective_timer"]);
  }

  level.var_ae746e8f[# "sr_objective_timer"][level.var_ae746e8f[# "sr_objective_timer"].size] = elem;
}

function register_clientside() {
  elem = new class_b5586f52();
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