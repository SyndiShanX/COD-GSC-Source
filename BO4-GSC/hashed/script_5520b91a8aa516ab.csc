/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_5520b91a8aa516ab.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace remote_missile_target_lockon;

class cremote_missile_target_lockon: cluielem {
  function set_target_locked(localclientnum, value) {
    set_data(localclientnum, "target_locked", value);
  }

  function set_clientnum(localclientnum, value) {
    set_data(localclientnum, "clientnum", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "remote_missile_target_lockon");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "clientnum", 0);
    set_data(localclientnum, "target_locked", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_13af07a1, var_8f126a66) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("clientnum", 1, 6, "int", var_13af07a1);
    cluielem::add_clientfield("target_locked", 1, 1, "int", var_8f126a66);
  }

}

register(uid, var_13af07a1, var_8f126a66) {
  elem = new cremote_missile_target_lockon();
  [[elem]] - > setup_clientfields(uid, var_13af07a1, var_8f126a66);
  return elem;
}

register_clientside(uid) {
  elem = new cremote_missile_target_lockon();
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

set_clientnum(localclientnum, value) {
  [[self]] - > set_clientnum(localclientnum, value);
}

set_target_locked(localclientnum, value) {
  [[self]] - > set_target_locked(localclientnum, value);
}