/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_29666e24a02b3f4a.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_towers_challenges_hud;

class czm_towers_challenges_hud: cluielem {
  var var_57a3d576;

  function set_required_goal(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "required_goal", value);
  }

  function set_challenge_text(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "challenge_text", value);
  }

  function set_progress(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "progress", value);
  }

  function set_state(player, state_name) {
    if(#"defaultstate" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
      return;
    }
    if(#"hidden" == state_name) {
      player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
      return;
    }
    assertmsg("<dev string:x30>");
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_towers_challenges_hud", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("_state", 1, 1, "int");
    cluielem::add_clientfield("progress", 1, 7, "int");
    cluielem::function_52818084("string", "challenge_text", 1);
    cluielem::add_clientfield("required_goal", 1, 7, "int");
  }

}

set_challenge_progress(player, value) {
  value = int(value * 100);
  [[self]] - > set_progress(player, value);
}

register(uid) {
  elem = new czm_towers_challenges_hud();
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

set_progress(player, value) {
  [[self]] - > set_progress(player, value);
}

set_challenge_text(player, value) {
  [[self]] - > set_challenge_text(player, value);
}

set_required_goal(player, value) {
  [[self]] - > set_required_goal(player, value);
}