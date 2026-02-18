/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7c08efb29ca7f7c1.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace stealth_meter_display;
class class_d4941e5e: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_18066380(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "direction", value);
  }

  function function_4d628707(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "awarenessState", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function function_7425637b(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "awarenessProgress", value);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("stealth_meter_display");
    cluielem::add_clientfield("entNum", 1, 10, "int");
    cluielem::add_clientfield("awarenessState", 1, 4, "int");
    cluielem::add_clientfield("awarenessProgress", 1, 4, "float");
    cluielem::add_clientfield("direction", 1, 4, "float");
    cluielem::add_clientfield("clamped", 1, 1, "int");
  }

  function set_entnum(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entNum", value);
  }

  function function_fae2a569(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "clamped", value);
  }
}

function register() {
  elem = new class_d4941e5e();
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

function set_entnum(player, value) {
  [[self]] - > set_entnum(player, value);
}

function function_4d628707(player, value) {
  [[self]] - > function_4d628707(player, value);
}

function function_7425637b(player, value) {
  [[self]] - > function_7425637b(player, value);
}

function function_18066380(player, value) {
  [[self]] - > function_18066380(player, value);
}

function function_fae2a569(player, value) {
  [[self]] - > function_fae2a569(player, value);
}