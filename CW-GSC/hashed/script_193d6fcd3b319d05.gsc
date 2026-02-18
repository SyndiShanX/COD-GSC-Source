/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_193d6fcd3b319d05.gsc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace sr_objective_timer;
class class_b5586f52: cluielem {
  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("sr_objective_timer");
  }
}

function register() {
  elem = new class_b5586f52();
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