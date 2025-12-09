/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_5afbda9de6000ad9.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace remote_missile_targets;

class cremote_missile_targets: cluielem {
  var var_57a3d576;

  function set_extra_target_3(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "extra_target_3", value);
  }

  function set_extra_target_2(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "extra_target_2", value);
  }

  function set_extra_target_1(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "extra_target_1", value);
  }

  function set_player_target_active(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "player_target_active", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "remote_missile_targets", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("player_target_active", 1, 16, "int");
    cluielem::add_clientfield("extra_target_1", 1, 10, "int");
    cluielem::add_clientfield("extra_target_2", 1, 10, "int");
    cluielem::add_clientfield("extra_target_3", 1, 10, "int");
  }

}

register(uid) {
  elem = new cremote_missile_targets();
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

set_player_target_active(player, value) {
  [[self]] - > set_player_target_active(player, value);
}

set_extra_target_1(player, value) {
  [[self]] - > set_extra_target_1(player, value);
}

set_extra_target_2(player, value) {
  [[self]] - > set_extra_target_2(player, value);
}

set_extra_target_3(player, value) {
  [[self]] - > set_extra_target_3(player, value);
}