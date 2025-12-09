/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_342e0d1a78771d3f.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace remote_missile_target_lockon;

class cremote_missile_target_lockon: cluielem {
  var var_57a3d576;

  function set_target_locked(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "target_locked", value);
  }

  function set_clientnum(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "clientnum", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "remote_missile_target_lockon", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("clientnum", 1, 6, "int");
    cluielem::add_clientfield("target_locked", 1, 1, "int");
  }

}

register(uid) {
  elem = new cremote_missile_target_lockon();
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

set_clientnum(player, value) {
  [[self]] - > set_clientnum(player, value);
}

set_target_locked(player, value) {
  [[self]] - > set_target_locked(player, value);
}