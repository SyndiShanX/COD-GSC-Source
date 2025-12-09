/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_50d17c15c0bd32e0.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace player_insertion_choice;

class cplayer_insertion_choice: cluielem {
  var var_57a3d576;

  function set_state(player, state_name) {
    if(#"defaultstate" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
      return;
    }
    if(#"groundvehicle" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
      return;
    }
    if(#"halojump" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 2);
      return;
    }
    if(#"heli" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 3);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "player_insertion_choice", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 2, "int");
  }

}

register(uid) {
  elem = new cplayer_insertion_choice();
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