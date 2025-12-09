/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_1de6f3c239229d19.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_game_timer;

class czm_game_timer: cluielem {
  var var_57a3d576;

  function set_showzero(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "showzero", value);
  }

  function set_minutes(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "minutes", value);
  }

  function set_seconds(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "seconds", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_game_timer", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("seconds", 1, 6, "int");
    cluielem::add_clientfield("minutes", 1, 9, "int");
    cluielem::add_clientfield("showzero", 1, 1, "int");
  }

}

register(uid) {
  elem = new czm_game_timer();
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

set_seconds(player, value) {
  [[self]] - > set_seconds(player, value);
}

set_minutes(player, value) {
  [[self]] - > set_minutes(player, value);
}

set_showzero(player, value) {
  [[self]] - > set_showzero(player, value);
}