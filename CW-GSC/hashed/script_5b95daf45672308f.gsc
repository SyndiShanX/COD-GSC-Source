/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5b95daf45672308f.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace sr_orda_health_bar;
class class_90c2e4ec: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("sr_orda_health_bar");
    cluielem::add_clientfield("health", 4000, 7, "float");
    cluielem::add_clientfield("is_beast", 4000, 1, "int");
  }

  function function_dff51e54(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "is_beast", value);
  }

  function set_health(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "health", value);
  }
}

function register() {
  elem = new class_90c2e4ec();
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

function function_dff51e54(player, value) {
  [[self]] - > function_dff51e54(player, value);
}