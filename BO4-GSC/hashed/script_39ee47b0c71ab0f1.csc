/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_39ee47b0c71ab0f1.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_trial_weapon_locked;

class czm_trial_weapon_locked: cluielem {
  function function_74b3c310(localclientnum) {
    current_val = get_data(localclientnum, "show_icon");
    new_val = (current_val + 1) % 2;
    set_data(localclientnum, "show_icon", new_val);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "zm_trial_weapon_locked");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "show_icon", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_fea97e1b) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("show_icon", 1, 1, "counter", var_fea97e1b);
  }

}

register(uid, var_fea97e1b) {
  elem = new czm_trial_weapon_locked();
  [[elem]] - > setup_clientfields(uid, var_fea97e1b);
  return elem;
}

register_clientside(uid) {
  elem = new czm_trial_weapon_locked();
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

function_74b3c310(localclientnum) {
  [[self]] - > function_74b3c310(localclientnum);
}