/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3cf007608b681c76.gsc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace doa_textbubble;
class class_b20c2804: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_4f6e830d(player, value) {
    player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 4, value, 0);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function function_61312692(player, value) {
    player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 3, value, 0);
  }

  function function_7ddfdfef(player, value) {
    player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 5, value, 0);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("DOA_TextBubble");
  }

  function set_entnum(player, value) {
    player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 0);
  }

  function set_text(player, value) {
    player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, function_f2d511a6("string", value), 0);
  }
}

function register() {
  elem = new class_b20c2804();
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

function set_text(player, value) {
  [[self]] - > set_text(player, value);
}

function function_61312692(player, value) {
  [[self]] - > function_61312692(player, value);
}

function function_4f6e830d(player, value) {
  [[self]] - > function_4f6e830d(player, value);
}

function function_7ddfdfef(player, value) {
  [[self]] - > function_7ddfdfef(player, value);
}