/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_702b73ee97d18efe.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\lui_shared;

#namespace bountyhunterbuy;

class cbountyhunterbuy: cluielem {

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "BountyHunterBuy", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
  }

}

register(uid) {
  elem = new cbountyhunterbuy();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

open(player, persistent = 0) {
  [[self]] - > open(player, persistent);
}

close(player) {
  [[self]] - > close(player);
}

is_open(player) {
  return [[self]] - > function_7bfd10e6(player);
}