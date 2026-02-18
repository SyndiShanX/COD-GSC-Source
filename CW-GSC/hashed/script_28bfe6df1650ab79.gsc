/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_28bfe6df1650ab79.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#namespace namespace_e01afe67;

function private autoexec __init__system__() {
  system::register(#"hash_993ee8bedbddc19", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_27897abffa9137fc", &on_begin, &on_end);
}

function private on_begin() {
  zm::register_actor_damage_callback(&height_check);
}

function private on_end(round_reset) {
  if(isinarray(level.actor_damage_callbacks, &height_check)) {
    arrayremovevalue(level.actor_damage_callbacks, &height_check, 0);
  }
}

function is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_27897abffa9137fc");
  return isDefined(challenge);
}

function private height_check(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(boneindex.origin) && isDefined(self.origin) && boneindex.origin[2] > self.origin[2] + 40) {
    return surfacetype;
  }

  return 0;
}