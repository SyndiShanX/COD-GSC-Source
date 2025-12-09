/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_48f7c4ab73137f8.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_laststand_client;

class czm_laststand_client: cluielem {
  var var_57a3d576;

  function set_revive_progress(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "revive_progress", value);
  }

  function set_bleedout_progress(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "bleedout_progress", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_laststand_client", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("bleedout_progress", 1, 6, "float");
    cluielem::add_clientfield("revive_progress", 1, 5, "float");
  }

}

register(uid) {
  elem = new czm_laststand_client();
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

set_bleedout_progress(player, value) {
  [[self]] - > set_bleedout_progress(player, value);
}

set_revive_progress(player, value) {
  [[self]] - > set_revive_progress(player, value);
}