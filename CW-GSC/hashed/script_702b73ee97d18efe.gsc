/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_702b73ee97d18efe.gsc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace bountyhunterbuy;
class cbountyhunterbuy: cluielem {
  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("BountyHunterBuy");
  }
}

function register() {
  elem = new cbountyhunterbuy();
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