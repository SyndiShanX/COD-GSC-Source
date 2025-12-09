/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_272c2c9da7e6858.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace lower_message;

class clower_message: cluielem {
  var var_57a3d576;

  function set_countdowntimeseconds(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "countdownTimeSeconds", value);
  }

  function set_message(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "message", value);
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
    if(#"hash_45bfcb1cd8c9b50a" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 2);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "lower_message", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 2, "int");
    cluielem::function_52818084("string", "message", 1);
    cluielem::add_clientfield("countdownTimeSeconds", 1, 5, "int");
  }

}

register(uid) {
  elem = new clower_message();
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

set_message(player, value) {
  [[self]] - > set_message(player, value);
}

set_countdowntimeseconds(player, value) {
  [[self]] - > set_countdowntimeseconds(player, value);
}