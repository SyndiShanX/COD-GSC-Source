/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_use_pack_a_punch.gsc
**********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_use_pack_a_punch;

autoexec __init__system__() {
  system::register(#"zm_trial_use_pack_a_punch", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"use_pack_a_punch", &on_begin, &on_end);
}

private on_begin(n_count) {
  callback::function_aebeafc0(&function_aebeafc0);
  level.var_195590fb = zm_trial::function_5769f26a(n_count);

  foreach(player in getplayers()) {
    player.var_92cd5237 = [];
    player zm_trial_util::function_c2cd0cba(level.var_195590fb);
    player zm_trial_util::function_2190356a(0);
  }
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
  }

  if(!round_reset) {
    var_57807cdc = [];

    foreach(player in getplayers()) {
      if(player.var_92cd5237.size < level.var_195590fb) {
        array::add(var_57807cdc, player, 0);
      }

      player.var_f8c35ed5 = undefined;
    }

    if(var_57807cdc.size == 1) {
      zm_trial::fail(#"hash_6dbd3c476c903f66", var_57807cdc);
    } else if(var_57807cdc.size > 1) {
      zm_trial::fail(#"hash_59d734dda39935cf", var_57807cdc);
    }
  }

  level.var_195590fb = undefined;
  callback::function_3e2ed898(&function_aebeafc0);
}

private function_aebeafc0(upgraded_weapon) {
  w_base = zm_weapons::get_base_weapon(upgraded_weapon);

  if(!isDefined(self.var_92cd5237)) {
    self.var_92cd5237 = [];
  } else if(!isarray(self.var_92cd5237)) {
    self.var_92cd5237 = array(self.var_92cd5237);
  }

  if(!isinarray(self.var_92cd5237, w_base)) {
    self.var_92cd5237[self.var_92cd5237.size] = w_base;
  }

  if(self.var_92cd5237.size <= level.var_195590fb) {
    zm_trial_util::function_2190356a(self.var_92cd5237.size);
  }
}