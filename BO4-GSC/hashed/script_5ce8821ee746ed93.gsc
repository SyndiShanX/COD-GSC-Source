/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_5ce8821ee746ed93.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace success_screen;

class csuccess_screen: cluielem {
  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "success_screen", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
  }

}

register(uid) {
  elem = new csuccess_screen();
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
  return [[self]] - > function_76692f88(player);
}