/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_7dd3fdbd09d5b252.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace death_zone;

class cdeath_zone: cluielem {
  function set_shutdown_sec(localclientnum, value) {
    set_data(localclientnum, "shutdown_sec", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "death_zone");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "shutdown_sec", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_730d2848) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("shutdown_sec", 1, 9, "int", var_730d2848);
  }

}

register(uid, var_730d2848) {
  elem = new cdeath_zone();
  [[elem]] - > setup_clientfields(uid, var_730d2848);
  return elem;
}

register_clientside(uid) {
  elem = new cdeath_zone();
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

set_shutdown_sec(localclientnum, value) {
  [[self]] - > set_shutdown_sec(localclientnum, value);
}