/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4a1e83805671ae57.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace stim_count;
class class_44eccfcc: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function function_6eef7f4f(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "stim_count", value);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("stim_count");
    cluielem::add_clientfield("stim_count", 1, 4, "int", 0);
  }
}

function register() {
  elem = new class_44eccfcc();
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

function function_6eef7f4f(player, value) {
  [[self]] - > function_6eef7f4f(player, value);
}