/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1df36deb5752c05d.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_control_point_hud;
class class_a0b518ca: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_338d48a0(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "hasDamage", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function function_62264c81(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "chargePct", value);
  }

  function function_751f7270(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "hasCharge", value);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("zm_control_point_hud");
    cluielem::add_clientfield("chargePct", 8000, 7, "float");
    cluielem::add_clientfield("damagePct", 8000, 7, "float");
    cluielem::add_clientfield("ordaHealthPct", 16000, 7, "float");
    cluielem::add_clientfield("hasOrda", 16000, 1, "int");
    cluielem::add_clientfield("hasCharge", 16000, 1, "int");
    cluielem::add_clientfield("hasDamage", 16000, 1, "int");
  }

  function function_a04ff29a(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "damagePct", value);
  }

  function function_a59aefa6(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "ordaHealthPct", value);
  }

  function function_a95c34f3(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "hasOrda", value);
  }
}

function register() {
  elem = new class_a0b518ca();
  [[elem]] - > setup_clientfields();
  return elem;
}

function open(player, flags = 0) {
  [[self]] - > open(player, flags);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(player) {
  return [[self]] - > function_7bfd10e6(player);
}

function function_62264c81(player, value) {
  [[self]] - > function_62264c81(player, value);
}

function function_a04ff29a(player, value) {
  [[self]] - > function_a04ff29a(player, value);
}

function function_a59aefa6(player, value) {
  [[self]] - > function_a59aefa6(player, value);
}

function function_a95c34f3(player, value) {
  [[self]] - > function_a95c34f3(player, value);
}

function function_751f7270(player, value) {
  [[self]] - > function_751f7270(player, value);
}

function function_338d48a0(player, value) {
  [[self]] - > function_338d48a0(player, value);
}