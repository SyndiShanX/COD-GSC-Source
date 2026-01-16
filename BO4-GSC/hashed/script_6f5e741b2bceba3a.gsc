/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_6f5e741b2bceba3a.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_white_toast;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_d9987f47;

autoexec __init__system__() {
  system::register(#"hash_638b17bfdc64795a", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_168c1517a89a7cd", &on_begin, &on_end);
}

private on_begin(var_b3d469ae, var_5cd0152f) {
  level.var_21c2f32a = zm_trial::function_5769f26a(var_b3d469ae);
  n_cost = zm_trial::function_5769f26a(var_5cd0152f);
  level.var_943b6e2b = array();

  foreach(s_wallbuy in level._spawned_wallbuys) {
    s_wallbuy.trigger_stub zm_white_toast::function_641f4ec(&zm_white_toast::function_91256361, &zm_white_toast::function_c6c9b014, n_cost, "discharge_wallbuy");
  }

  foreach(player in getplayers()) {
    player zm_trial_util::function_c2cd0cba(level.var_21c2f32a);
    player zm_trial_util::function_2190356a(0);
    level.var_943b6e2b[player.clientid] = array();
  }

  level thread wallbuy_watcher();
}

private on_end(round_reset) {
  if(!round_reset) {
    var_696c3b4 = array();

    foreach(player in getplayers()) {
      if(level.var_943b6e2b[player.clientid].size < level.var_21c2f32a) {
        if(!isDefined(var_696c3b4)) {
          var_696c3b4 = [];
        } else if(!isarray(var_696c3b4)) {
          var_696c3b4 = array(var_696c3b4);
        }

        var_696c3b4[var_696c3b4.size] = player;
      }
    }

    if(var_696c3b4.size == 1) {
      zm_trial::fail(#"hash_75977ef6e92a8fb9", var_696c3b4);
    } else if(var_696c3b4.size > 1) {
      zm_trial::fail(#"hash_b877496afcd42c8", var_696c3b4);
    }
  }

  level.var_21c2f32a = undefined;
  level.var_943b6e2b = undefined;
  level notify(#"hash_31c14df051f6c165");

  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
  }

  foreach(s_wallbuy in level._spawned_wallbuys) {
    s_wallbuy.trigger_stub zm_white_toast::function_cf62f3c7();
  }
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_168c1517a89a7cd");
  return isDefined(challenge);
}

private wallbuy_watcher() {
  level endon(#"hash_31c14df051f6c165", #"game_ended");

  while(true) {
    s_notify = level waittill(#"weapon_bought");
    e_player = s_notify.player;

    if(!isinarray(level.var_943b6e2b[e_player.clientid], s_notify.weapon)) {
      if(!isDefined(level.var_943b6e2b[e_player.clientid])) {
        level.var_943b6e2b[e_player.clientid] = [];
      } else if(!isarray(level.var_943b6e2b[e_player.clientid])) {
        level.var_943b6e2b[e_player.clientid] = array(level.var_943b6e2b[e_player.clientid]);
      }

      level.var_943b6e2b[e_player.clientid][level.var_943b6e2b[e_player.clientid].size] = s_notify.weapon;
    }

    if(level.var_943b6e2b[e_player.clientid].size < level.var_21c2f32a) {
      e_player zm_trial_util::function_2190356a(level.var_943b6e2b[e_player.clientid].size);
    }

    if(self.var_943b6e2b[e_player.clientid].size >= level.var_21c2f32a) {
      e_player zm_trial_util::function_63060af4(1);
    }
  }
}