/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_2cb831533cab2794.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_hint_text;

class czm_hint_text: cluielem {
  var var_57a3d576;

  function set_text(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "text", value);
  }

  function set_state(player, state_name) {
    if(#"defaultstate" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
      return;
    }
    if(#"visible" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_hint_text", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 1, "int");
    cluielem::function_52818084("string", "text", 1);
  }

}

register(uid) {
  elem = new czm_hint_text();
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

set_state(player, state_name) {
  [[self]] - > set_state(player, state_name);
}

set_text(player, value) {
  [[self]] - > set_text(player, value);
}