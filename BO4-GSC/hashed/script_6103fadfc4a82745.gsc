/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_6103fadfc4a82745.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace scavenger_icon;

class cscavenger_icon: cluielem {
  var var_57a3d576;

  function increment_pulse(player) {
    player clientfield::function_9d68ee55(var_57a3d576, "pulse");
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "scavenger_icon", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("pulse", 1, 1, "counter");
  }

}

register(uid) {
  elem = new cscavenger_icon();
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

increment_pulse(player) {
  [[self]] - > increment_pulse(player);
}