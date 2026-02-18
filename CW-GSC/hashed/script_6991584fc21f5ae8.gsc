/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6991584fc21f5ae8.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace doa_keytrade;
class class_fd95a9c: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_3ae8b40f(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "confirmBtn", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function function_8a6595db(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "textBoxHint", value);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("DOA_KeyTrade");
    cluielem::function_dcb34c80("string", "textBoxHint", 1);
    cluielem::function_dcb34c80("string", "confirmBtn", 1);
  }
}

function register() {
  elem = new class_fd95a9c();
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

function function_8a6595db(player, value) {
  [[self]] - > function_8a6595db(player, value);
}

function function_3ae8b40f(player, value) {
  [[self]] - > function_3ae8b40f(player, value);
}