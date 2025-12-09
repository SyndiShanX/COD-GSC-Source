/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_59e751bcf51faec6.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace death_zone;

class cdeath_zone: cluielem {
  var var_57a3d576;

  function set_shutdown_sec(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "shutdown_sec", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "death_zone", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("shutdown_sec", 1, 9, "int");
  }

}

register(uid) {
  elem = new cdeath_zone();
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

set_shutdown_sec(player, value) {
  [[self]] - > set_shutdown_sec(player, value);
}