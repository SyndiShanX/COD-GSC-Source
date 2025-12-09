/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_6334bf874cddcc13.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_towers_crowd_meter;

class czm_towers_crowd_meter: cluielem {
  var var_57a3d576;

  function set_visible(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "visible", value);
  }

  function set_state(player, state_name) {
    if(#"defaultstate" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
      return;
    }
    if(#"crowd_loathes" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
      return;
    }
    if(#"crowd_hates" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 2);
      return;
    }
    if(#"crowd_no_love" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 3);
      return;
    }
    if(#"crowd_warm_up" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 4);
      return;
    }
    if(#"crowd_likes" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 5);
      return;
    }
    if(#"crowd_loves" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 6);
      return;
    }
    if(#"crowd_power_up_available_good" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 7);
      return;
    }
    if(#"crowd_power_up_available_bad" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 8);
      return;
    }
    if(#"crowd_power_up_available_good_partial" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 9);
      return;
    }
    if(#"crowd_power_up_available_bad_partial" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 10);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_towers_crowd_meter", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 4, "int");
    cluielem::add_clientfield("visible", 1, 1, "int");
  }

}

register(uid) {
  elem = new czm_towers_crowd_meter();
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

set_visible(player, value) {
  [[self]] - > set_visible(player, value);
}