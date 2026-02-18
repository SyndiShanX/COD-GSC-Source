/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_531a6d61ee606513.gsc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_gold_align_satellite_hud;
class class_eaf2482a: cluielem {
  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("zm_gold_align_satellite_hud");
  }
}

function register() {
  elem = new class_eaf2482a();
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