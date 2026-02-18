/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7d6dc1eb458198d1.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_control_point_hud;
class class_a0b518ca: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_338d48a0(localclientnum, value) {
    set_data(localclientnum, "hasDamage", value);
  }

  function register_clientside() {
    cluielem::register_clientside("zm_control_point_hud");
  }

  function function_62264c81(localclientnum, value) {
    set_data(localclientnum, "chargePct", value);
  }

  function function_751f7270(localclientnum, value) {
    set_data(localclientnum, "hasCharge", value);
  }

  function setup_clientfields(var_4bf38eea, var_7cc0b11d, var_14431277, var_db1c4294, var_87048abd, var_dd55685a) {
    cluielem::setup_clientfields("zm_control_point_hud");
    cluielem::add_clientfield("chargePct", 8000, 7, "float", var_4bf38eea);
    cluielem::add_clientfield("damagePct", 8000, 7, "float", var_7cc0b11d);
    cluielem::add_clientfield("ordaHealthPct", 16000, 7, "float", var_14431277);
    cluielem::add_clientfield("hasOrda", 16000, 1, "int", var_db1c4294);
    cluielem::add_clientfield("hasCharge", 16000, 1, "int", var_87048abd);
    cluielem::add_clientfield("hasDamage", 16000, 1, "int", var_dd55685a);
  }

  function function_a04ff29a(localclientnum, value) {
    set_data(localclientnum, "damagePct", value);
  }

  function function_a59aefa6(localclientnum, value) {
    set_data(localclientnum, "ordaHealthPct", value);
  }

  function function_a95c34f3(localclientnum, value) {
    set_data(localclientnum, "hasOrda", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "chargePct", 0);
    set_data(localclientnum, "damagePct", 0);
    set_data(localclientnum, "ordaHealthPct", 0);
    set_data(localclientnum, "hasOrda", 0);
    set_data(localclientnum, "hasCharge", 0);
    set_data(localclientnum, "hasDamage", 0);
  }
}

function register(var_4bf38eea, var_7cc0b11d, var_14431277, var_db1c4294, var_87048abd, var_dd55685a) {
  elem = new class_a0b518ca();
  [[elem]] - > setup_clientfields(var_4bf38eea, var_7cc0b11d, var_14431277, var_db1c4294, var_87048abd, var_dd55685a);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "zm_control_point_hud"])) {
    level.var_ae746e8f[# "zm_control_point_hud"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "zm_control_point_hud"])) {
    level.var_ae746e8f[# "zm_control_point_hud"] = [];
  } else if(!isarray(level.var_ae746e8f[# "zm_control_point_hud"])) {
    level.var_ae746e8f[# "zm_control_point_hud"] = array(level.var_ae746e8f[# "zm_control_point_hud"]);
  }

  level.var_ae746e8f[# "zm_control_point_hud"][level.var_ae746e8f[# "zm_control_point_hud"].size] = elem;
}

function register_clientside() {
  elem = new class_a0b518ca();
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

function function_62264c81(localclientnum, value) {
  [[self]] - > function_62264c81(localclientnum, value);
}

function function_a04ff29a(localclientnum, value) {
  [[self]] - > function_a04ff29a(localclientnum, value);
}

function function_a59aefa6(localclientnum, value) {
  [[self]] - > function_a59aefa6(localclientnum, value);
}

function function_a95c34f3(localclientnum, value) {
  [[self]] - > function_a95c34f3(localclientnum, value);
}

function function_751f7270(localclientnum, value) {
  [[self]] - > function_751f7270(localclientnum, value);
}

function function_338d48a0(localclientnum, value) {
  [[self]] - > function_338d48a0(localclientnum, value);
}