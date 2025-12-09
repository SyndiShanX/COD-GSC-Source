/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_190d6b82bcca0908.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_game_over;

class czm_game_over: cluielem {
  var var_57a3d576;

  function set_rounds(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "rounds", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_game_over", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("rounds", 1, 8, "int");
  }

}

register(uid) {
  elem = new czm_game_over();
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

set_rounds(player, value) {
  [[self]] - > set_rounds(player, value);
}