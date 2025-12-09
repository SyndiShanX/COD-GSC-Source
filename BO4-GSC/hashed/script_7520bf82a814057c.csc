/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_7520bf82a814057c.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_game_over;

class czm_game_over: cluielem {
  function set_rounds(localclientnum, value) {
    set_data(localclientnum, "rounds", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_game_over");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "rounds", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_34600867) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("rounds", 1, 8, "int", var_34600867);
  }

}

register(uid, var_34600867) {
  elem = new czm_game_over();
  [[elem]] - > setup_clientfields(uid, var_34600867);
  return elem;
}

register_clientside(uid) {
  elem = new czm_game_over();
  [[elem]] - > register_clientside(uid);
  return elem;
}

open(player) {
  [[self]] - > open(player);
}

close(player) {
  [[self]] - > close(player);
}

is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

set_rounds(localclientnum, value) {
  [[self]] - > set_rounds(localclientnum, value);
}