/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_57491143f0b931b5.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace seeker_mine_prompt;

class cseeker_mine_prompt: cluielem {
  var var_57a3d576;

  function set_promptstate(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "promptState", value);
  }

  function set_progress(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "progress", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "seeker_mine_prompt", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("progress", 1, 5, "float");
    cluielem::add_clientfield("promptState", 1, 2, "int");
  }

}

register(uid) {
  elem = new cseeker_mine_prompt();
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

set_progress(player, value) {
  [[self]] - > set_progress(player, value);
}

set_promptstate(player, value) {
  [[self]] - > set_promptstate(player, value);
}