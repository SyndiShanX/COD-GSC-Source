/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_537b0d808c4cac25.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace self_revive_visuals_rush;

class cself_revive_visuals_rush: cluielem {
  var var_57a3d576;

  function set_revive_time(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "revive_time", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "self_revive_visuals_rush", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("revive_time", 1, 4, "int");
  }

}

register(uid) {
  elem = new cself_revive_visuals_rush();
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

set_revive_time(player, value) {
  [[self]] - > set_revive_time(player, value);
}