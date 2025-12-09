/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_13ba67412d79c7f.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_trial_timer;

class czm_trial_timer: cluielem {
  function set_timer_text(localclientnum, value) {
    set_data(localclientnum, "timer_text", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_trial_timer");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "timer_text", # "");
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_252d747f) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("string", "timer_text", 1);
  }

}

register(uid, var_252d747f) {
  elem = new czm_trial_timer();
  [[elem]] - > setup_clientfields(uid, var_252d747f);
  return elem;
}

register_clientside(uid) {
  elem = new czm_trial_timer();
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

set_timer_text(localclientnum, value) {
  [[self]] - > set_timer_text(localclientnum, value);
}