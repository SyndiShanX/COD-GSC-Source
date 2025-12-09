/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_5dd9f3b0dbcf017d.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_trial_weapon_locked;

class czm_trial_weapon_locked: cluielem {
  var var_57a3d576;

  function function_74b3c310(player) {
    player clientfield::function_9d68ee55(var_57a3d576, "show_icon");
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_trial_weapon_locked", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("show_icon", 1, 1, "counter");
  }

}

register(uid) {
  elem = new czm_trial_weapon_locked();
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

function_74b3c310(player) {
  [[self]] - > function_74b3c310(player);
}