/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_close_quarters.gsc
********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_weapons;
#namespace zm_trial_close_quarters;

function private autoexec __init__system__() {
  system::register(#"zm_trial_close_quarters", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"close_quarters", &on_begin, &on_end);
}

function private on_begin() {
  zm::register_actor_damage_callback(&range_check);
}

function private on_end(round_reset) {
  if(isinarray(level.actor_damage_callbacks, &range_check)) {
    arrayremovevalue(level.actor_damage_callbacks, &range_check, 0);
  }
}

function is_active() {
  challenge = zm_trial::function_a36e8c38(#"close_quarters");
  return isDefined(challenge);
}

function private range_check(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(!isPlayer(boneindex) && !isPlayer(psoffsettime)) {
    return -1;
  }

  if(is_true(self.aat_turned)) {
    return surfacetype;
  }

  if(isDefined(boneindex.origin) && isDefined(self.origin) && distance2dsquared(boneindex.origin, self.origin) <= 122500) {
    return surfacetype;
  }

  return 0;
}

function function_23d15bf3(var_f85889ce) {
  if(isPlayer(var_f85889ce) && distance2dsquared(var_f85889ce.origin, self.origin) <= 122500) {
    return true;
  }

  return false;
}