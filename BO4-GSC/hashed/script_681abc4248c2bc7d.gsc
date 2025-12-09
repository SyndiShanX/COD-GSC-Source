/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_681abc4248c2bc7d.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_zod_wonderweapon_quest;

class czm_zod_wonderweapon_quest: cluielem {
  var var_57a3d576;

  function set_decay(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "decay", value);
  }

  function set_purity(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "purity", value);
  }

  function set_plasma(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "plasma", value);
  }

  function set_radiance(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "radiance", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_zod_wonderweapon_quest", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("radiance", 1, 1, "int");
    cluielem::add_clientfield("plasma", 1, 1, "int");
    cluielem::add_clientfield("purity", 1, 1, "int");
    cluielem::add_clientfield("decay", 1, 1, "int");
  }

}

register(uid) {
  elem = new czm_zod_wonderweapon_quest();
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

set_radiance(player, value) {
  [[self]] - > set_radiance(player, value);
}

set_plasma(player, value) {
  [[self]] - > set_plasma(player, value);
}

set_purity(player, value) {
  [[self]] - > set_purity(player, value);
}

set_decay(player, value) {
  [[self]] - > set_decay(player, value);
}