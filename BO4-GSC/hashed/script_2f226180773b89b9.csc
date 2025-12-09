/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_2f226180773b89b9.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace self_revive_visuals_rush;

class cself_revive_visuals_rush: cluielem {
  function set_revive_time(localclientnum, value) {
    set_data(localclientnum, "revive_time", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "self_revive_visuals_rush");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "revive_time", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_92d5f7cf) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("revive_time", 1, 4, "int", var_92d5f7cf);
  }

}

register(uid, var_92d5f7cf) {
  elem = new cself_revive_visuals_rush();
  [[elem]] - > setup_clientfields(uid, var_92d5f7cf);
  return elem;
}

register_clientside(uid) {
  elem = new cself_revive_visuals_rush();
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

set_revive_time(localclientnum, value) {
  [[self]] - > set_revive_time(localclientnum, value);
}