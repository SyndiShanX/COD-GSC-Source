/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_1714a05732f8e2c.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_towers_crowd;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_8a476bc7;

autoexec __init__system__() {
  system::register(#"hash_48f50c5660fa9f4c", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_1fd6f58939deba71", &on_begin, &on_end);
}

private on_begin() {}

private on_end(round_reset) {
  if(!round_reset) {
    var_acba5af0 = array();

    foreach(e_player in level.players) {
      if(!e_player zm_towers_crowd::function_aa0b6eb()) {
        if(!isDefined(var_acba5af0)) {
          var_acba5af0 = [];
        } else if(!isarray(var_acba5af0)) {
          var_acba5af0 = array(var_acba5af0);
        }

        if(!isinarray(var_acba5af0, e_player)) {
          var_acba5af0[var_acba5af0.size] = e_player;
        }
      }
    }

    if(var_acba5af0.size) {
      zm_trial::fail(#"hash_746c876308278b16", var_acba5af0);
    }
  }
}