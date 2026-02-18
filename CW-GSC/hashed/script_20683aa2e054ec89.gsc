/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_20683aa2e054ec89.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_roots_health_bar;
class class_f91fc158: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function function_74adcd8a(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "armor_vis", value);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("zm_roots_health_bar");
    cluielem::add_clientfield("health", 4000, 7, "float");
    cluielem::add_clientfield("armor", 4000, 7, "float");
    cluielem::add_clientfield("armor_vis", 4000, 1, "int");
  }

  function set_armor(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "armor", value);
  }

  function set_health(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "health", value);
  }
}

function register() {
  elem = new class_f91fc158();
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

function set_health(player, value) {
  [[self]] - > set_health(player, value);
}

function set_armor(player, value) {
  [[self]] - > set_armor(player, value);
}

function function_74adcd8a(player, value) {
  [[self]] - > function_74adcd8a(player, value);
}