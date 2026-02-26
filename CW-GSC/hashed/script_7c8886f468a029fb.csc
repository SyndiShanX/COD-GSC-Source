/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7c8886f468a029fb.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace sr_orda_health_bar;
class class_90c2e4ec: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("sr_orda_health_bar");
  }

  function setup_clientfields(healthcallback, var_d79cca54) {
    cluielem::setup_clientfields("sr_orda_health_bar");
    cluielem::add_clientfield("health", 4000, 7, "float", healthcallback);
    cluielem::add_clientfield("is_beast", 4000, 1, "int", var_d79cca54);
  }

  function function_dff51e54(localclientnum, value) {
    set_data(localclientnum, "is_beast", value);
  }

  function set_health(localclientnum, value) {
    set_data(localclientnum, "health", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "health", 0);
    set_data(localclientnum, "is_beast", 0);
  }
}

function register(healthcallback, var_d79cca54) {
  elem = new class_90c2e4ec();
  [[elem]] - > setup_clientfields(healthcallback, var_d79cca54);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"sr_orda_health_bar"])) {
    level.var_ae746e8f[#"sr_orda_health_bar"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"sr_orda_health_bar"])) {
    level.var_ae746e8f[#"sr_orda_health_bar"] = [];
  } else if(!isarray(level.var_ae746e8f[#"sr_orda_health_bar"])) {
    level.var_ae746e8f[#"sr_orda_health_bar"] = array(level.var_ae746e8f[#"sr_orda_health_bar"]);
  }

  level.var_ae746e8f[#"sr_orda_health_bar"][level.var_ae746e8f[#"sr_orda_health_bar"].size] = elem;
}

function register_clientside() {
  elem = new class_90c2e4ec();
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

function set_health(localclientnum, value) {
  [[self]] - > set_health(localclientnum, value);
}

function function_dff51e54(localclientnum, value) {
  [[self]] - > function_dff51e54(localclientnum, value);
}