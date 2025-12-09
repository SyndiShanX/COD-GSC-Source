/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_3a2fac1479c56997.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_build_progress;

class czm_build_progress: cluielem {
  function set_progress(localclientnum, value) {
    set_data(localclientnum, "progress", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_build_progress");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "progress", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, progresscallback) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("progress", 1, 6, "float", progresscallback);
  }

}

register(uid, progresscallback) {
  elem = new czm_build_progress();
  [[elem]] - > setup_clientfields(uid, progresscallback);
  return elem;
}

register_clientside(uid) {
  elem = new czm_build_progress();
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

set_progress(localclientnum, value) {
  [[self]] - > set_progress(localclientnum, value);
}