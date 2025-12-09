/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_2595527427ea71eb.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_trial_timer;

class czm_trial_timer: cluielem {
  var var_57a3d576;

  function set_timer_text(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "timer_text", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_trial_timer", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("string", "timer_text", 1);
  }

}

register(uid) {
  elem = new czm_trial_timer();
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

set_timer_text(player, value) {
  [[self]] - > set_timer_text(player, value);
}