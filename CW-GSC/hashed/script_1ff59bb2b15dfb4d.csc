/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1ff59bb2b15dfb4d.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace stealth_meter_display;
class class_d4941e5e: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_18066380(localclientnum, value) {
    set_data(localclientnum, "direction", value);
  }

  function function_4d628707(localclientnum, value) {
    set_data(localclientnum, "awarenessState", value);
  }

  function register_clientside() {
    cluielem::register_clientside("stealth_meter_display");
  }

  function function_7425637b(localclientnum, value) {
    set_data(localclientnum, "awarenessProgress", value);
  }

  function setup_clientfields(var_5a7b4b38, var_579b061b, var_f10a04a3, var_f228b5fa, var_bda3bf84) {
    cluielem::setup_clientfields("stealth_meter_display");
    cluielem::add_clientfield("entNum", 1, 10, "int", var_5a7b4b38);
    cluielem::add_clientfield("awarenessState", 1, 4, "int", var_579b061b);
    cluielem::add_clientfield("awarenessProgress", 1, 4, "float", var_f10a04a3);
    cluielem::add_clientfield("direction", 1, 4, "float", var_f228b5fa);
    cluielem::add_clientfield("clamped", 1, 1, "int", var_bda3bf84);
  }

  function set_entnum(localclientnum, value) {
    set_data(localclientnum, "entNum", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "entNum", 0);
    set_data(localclientnum, "awarenessState", 0);
    set_data(localclientnum, "awarenessProgress", 0);
    set_data(localclientnum, "direction", 0);
    set_data(localclientnum, "clamped", 0);
  }

  function function_fae2a569(localclientnum, value) {
    set_data(localclientnum, "clamped", value);
  }
}

function register(var_5a7b4b38, var_579b061b, var_f10a04a3, var_f228b5fa, var_bda3bf84) {
  elem = new class_d4941e5e();
  [[elem]] - > setup_clientfields(var_5a7b4b38, var_579b061b, var_f10a04a3, var_f228b5fa, var_bda3bf84);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"stealth_meter_display"])) {
    level.var_ae746e8f[#"stealth_meter_display"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"stealth_meter_display"])) {
    level.var_ae746e8f[#"stealth_meter_display"] = [];
  } else if(!isarray(level.var_ae746e8f[#"stealth_meter_display"])) {
    level.var_ae746e8f[#"stealth_meter_display"] = array(level.var_ae746e8f[#"stealth_meter_display"]);
  }

  level.var_ae746e8f[#"stealth_meter_display"][level.var_ae746e8f[#"stealth_meter_display"].size] = elem;
}

function register_clientside() {
  elem = new class_d4941e5e();
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

function set_entnum(localclientnum, value) {
  [[self]] - > set_entnum(localclientnum, value);
}

function function_4d628707(localclientnum, value) {
  [[self]] - > function_4d628707(localclientnum, value);
}

function function_7425637b(localclientnum, value) {
  [[self]] - > function_7425637b(localclientnum, value);
}

function function_18066380(localclientnum, value) {
  [[self]] - > function_18066380(localclientnum, value);
}

function function_fae2a569(localclientnum, value) {
  [[self]] - > function_fae2a569(localclientnum, value);
}