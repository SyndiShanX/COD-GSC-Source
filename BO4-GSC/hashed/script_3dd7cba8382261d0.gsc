/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_3dd7cba8382261d0.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_arcade_keys;

class czm_arcade_keys: cluielem {
  var var_57a3d576;

  function set_key_count(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "key_count", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_arcade_keys", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("key_count", 1, 4, "int");
  }

}

register(uid) {
  elem = new czm_arcade_keys();
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

set_key_count(player, value) {
  [[self]] - > set_key_count(player, value);
}