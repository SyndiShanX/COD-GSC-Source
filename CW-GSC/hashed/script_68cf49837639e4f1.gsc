/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_68cf49837639e4f1.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#namespace namespace_e7fb1aea;

function private autoexec __init__system__() {
  system::register(#"hash_6e4fd4c82cd73524", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_6e4fd4c82cd73524", &on_begin, &on_end);
}

function private on_begin(n_kill_count) {
  level.var_f7e95a13 = zm_trial::function_5769f26a(n_kill_count);

  foreach(player in getplayers()) {
    player.var_76bb4a3e = 0;
    player zm_trial_util::function_c2cd0cba(level.var_f7e95a13);
    player zm_trial_util::function_2190356a(player.var_76bb4a3e);
    player callback::on_death(&on_death);
  }

  callback::on_ai_killed(&on_ai_killed);
}

function private on_end(round_reset) {
  var_7df0eb27 = level.var_f7e95a13;
  level.var_f7e95a13 = undefined;

  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
    player callback::remove_on_death(&on_death);
  }

  callback::remove_on_ai_killed(&on_ai_killed);

  if(!round_reset) {
    var_acba5af0 = [];

    foreach(player in getplayers()) {
      if(isDefined(player.var_76bb4a3e) && player.var_76bb4a3e < var_7df0eb27) {
        if(!isDefined(var_acba5af0)) {
          var_acba5af0 = [];
        } else if(!isarray(var_acba5af0)) {
          var_acba5af0 = array(var_acba5af0);
        }

        if(!isinarray(var_acba5af0, player)) {
          var_acba5af0[var_acba5af0.size] = player;
        }
      }
    }

    if(var_acba5af0.size == 1) {
      zm_trial::fail(#"hash_18fa90427a117729", var_acba5af0);
      function_d99b4aa5();
    } else if(var_acba5af0.size > 1) {
      zm_trial::fail(#"hash_68076ef1f7244678", var_acba5af0);
      function_d99b4aa5();
    }
  } else {
    function_d99b4aa5();
  }

  foreach(player in getplayers()) {
    player.var_76bb4a3e = undefined;
  }
}

function private on_ai_killed(params) {
  e_attacker = params.eattacker;

  if(!isPlayer(e_attacker)) {
    e_attacker = params.einflictor;
  }
}

function private function_d99b4aa5() {
  foreach(e_player in getplayers()) {
    e_player gadgetpowerset(level.var_a53a05b5, 100);
  }
}

function private on_death(params) {
  if(isDefined(self.var_76bb4a3e) && self.var_76bb4a3e < level.var_f7e95a13) {
    zm_trial::fail(#"hash_18fa90427a117729", array(self));
  }
}