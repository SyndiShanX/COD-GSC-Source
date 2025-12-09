/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_164ba4a711296dd5.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace insertion_passenger_count;

class cinsertion_passenger_count: cluielem {
  var var_57a3d576;

  function set_count(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "count", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "insertion_passenger_count", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("count", 1, 6, "int");
  }

}

register(uid) {
  elem = new cinsertion_passenger_count();
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

set_count(player, value) {
  [[self]] - > set_count(player, value);
}