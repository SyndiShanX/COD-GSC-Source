/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_6d7d84509b62f422.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_location;

class czm_location: cluielem {
  var var_57a3d576;

  function set_location_name(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "location_name", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_location", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("string", "location_name", 1);
  }

}

register(uid) {
  elem = new czm_location();
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

set_location_name(player, value) {
  [[self]] - > set_location_name(player, value);
}