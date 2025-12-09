/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_1d511fa8264f8744.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_arcade_keys;

class czm_arcade_keys: cluielem {
  function set_key_count(localclientnum, value) {
    set_data(localclientnum, "key_count", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_arcade_keys");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "key_count", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_68328047) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("key_count", 1, 4, "int", var_68328047);
  }

}

register(uid, var_68328047) {
  elem = new czm_arcade_keys();
  [[elem]] - > setup_clientfields(uid, var_68328047);
  return elem;
}

register_clientside(uid) {
  elem = new czm_arcade_keys();
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

set_key_count(localclientnum, value) {
  [[self]] - > set_key_count(localclientnum, value);
}