/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_limited_hits.gsc
******************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_limited_hits;

autoexec __init__system__() {
  system::register(#"zm_trial_limited_hits", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"limited_hits", &on_begin, &on_end);
}

private on_begin(var_85af3be4, var_752d90ad) {
  if(getplayers().size == 1) {
    level.var_b529249b = zm_trial::function_5769f26a(var_752d90ad);
  } else {
    level.var_b529249b = zm_trial::function_5769f26a(var_85af3be4);
  }

  level.var_4b9163d5 = 0;
  zm_trial_util::function_2976fa44(level.var_b529249b);
  zm_trial_util::function_dace284(level.var_b529249b, 1);
  callback::on_player_damage(&on_player_damage);
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();
  level.var_b529249b = undefined;
  level.var_4b9163d5 = undefined;
  callback::remove_on_player_damage(&on_player_damage);
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"limited_hits");
  return isDefined(challenge);
}

private on_player_damage(params) {
  if(params.idamage >= 0) {
    level.var_4b9163d5++;
    zm_trial_util::function_dace284(level.var_b529249b - level.var_4b9163d5);

    if(level.var_4b9163d5 >= level.var_b529249b) {
      zm_trial::fail(#"hash_404865fbf8dd5cc2", array(self));
    }
  }
}