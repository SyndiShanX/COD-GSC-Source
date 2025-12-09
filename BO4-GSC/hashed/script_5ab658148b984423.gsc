/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_5ab658148b984423.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_build_progress;

class czm_build_progress: cluielem {
  var var_57a3d576;

  function set_progress(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "progress", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_build_progress", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("progress", 1, 6, "float");
  }

}

register(uid) {
  elem = new czm_build_progress();
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

set_progress(player, value) {
  [[self]] - > set_progress(player, value);
}