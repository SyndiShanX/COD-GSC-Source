/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_cb847e6c2204e74.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace self_revive_visuals;

class cself_revive_visuals: cluielem {
  function set_revive_progress(localclientnum, value) {
    set_data(localclientnum, "revive_progress", value);
  }

  function set_self_revive_progress_bar_fill(localclientnum, value) {
    set_data(localclientnum, "self_revive_progress_bar_fill", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "self_revive_visuals");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "self_revive_progress_bar_fill", 0);
    set_data(localclientnum, "revive_progress", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_2d1c5d08, var_f45e8d0d) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("self_revive_progress_bar_fill", 1, 5, "float", var_2d1c5d08);
    cluielem::add_clientfield("revive_progress", 1, 5, "float", var_f45e8d0d);
  }

}

register(uid, var_2d1c5d08, var_f45e8d0d) {
  elem = new cself_revive_visuals();
  [[elem]] - > setup_clientfields(uid, var_2d1c5d08, var_f45e8d0d);
  return elem;
}

register_clientside(uid) {
  elem = new cself_revive_visuals();
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

set_self_revive_progress_bar_fill(localclientnum, value) {
  [[self]] - > set_self_revive_progress_bar_fill(localclientnum, value);
}

set_revive_progress(localclientnum, value) {
  [[self]] - > set_revive_progress(localclientnum, value);
}