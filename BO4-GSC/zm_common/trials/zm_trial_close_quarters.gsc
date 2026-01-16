/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_close_quarters.gsc
********************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_close_quarters;

autoexec __init__system__() {
  system::register(#"zm_trial_close_quarters", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"close_quarters", &on_begin, &on_end);
}

private on_begin() {
  zm::register_actor_damage_callback(&range_check);
}

private on_end(round_reset) {
  if(isinarray(level.actor_damage_callbacks, &range_check)) {
    arrayremovevalue(level.actor_damage_callbacks, &range_check, 0);
  }
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"close_quarters");
  return isDefined(challenge);
}

private range_check(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isplayer(attacker) && !isplayer(inflictor)) {
    return -1;
  }

  if(isDefined(self.aat_turned) && self.aat_turned) {
    return damage;
  }

  if(isDefined(attacker.origin) && isDefined(self.origin) && distance2dsquared(attacker.origin, self.origin) <= 122500) {
    return damage;
  }

  return 0;
}

function_23d15bf3(var_f85889ce) {
  if(isplayer(var_f85889ce) && distance2dsquared(var_f85889ce.origin, self.origin) <= 122500) {
    return true;
  }

  return false;
}