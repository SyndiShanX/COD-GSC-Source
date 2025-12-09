/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_71f2f8a6fc184b69.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace insertion_passenger_count;

class cinsertion_passenger_count: cluielem {
  function set_count(localclientnum, value) {
    set_data(localclientnum, "count", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "insertion_passenger_count");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "count", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_1b98496b) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("count", 1, 6, "int", var_1b98496b);
  }

}

register(uid, var_1b98496b) {
  elem = new cinsertion_passenger_count();
  [[elem]] - > setup_clientfields(uid, var_1b98496b);
  return elem;
}

register_clientside(uid) {
  elem = new cinsertion_passenger_count();
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

set_count(localclientnum, value) {
  [[self]] - > set_count(localclientnum, value);
}