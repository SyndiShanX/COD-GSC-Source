/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_24c15fbbb838c794.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace interactive_shot;

class cinteractive_shot: cluielem {
  var var_57a3d576;

  function set_text(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "text", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "interactive_shot", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("string", "text", 1);
  }

}

register(uid) {
  elem = new cinteractive_shot();
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

set_text(player, value) {
  [[self]] - > set_text(player, value);
}