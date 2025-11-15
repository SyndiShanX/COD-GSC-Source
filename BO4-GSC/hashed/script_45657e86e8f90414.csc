/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_45657e86e8f90414.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_fcd611c3;

autoexec __init__system__() {
  system::register(#"hash_281322718ac3cd88", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_64d77357e69aee75", &on_begin, &on_end);
}

private on_begin(localclientnum, a_params) {
  level.var_e91491fb = isDefined(a_params[0]) ? a_params[0] : "movement";
}

private on_end(round_reset) {
  level.var_e91491fb = undefined;
}

is_active() {
  s_challenge = zm_trial::function_a36e8c38(#"hash_64d77357e69aee75");
  return isDefined(s_challenge);
}

function_26f124d8() {
  if(!isDefined(level.var_e91491fb)) {
    return true;
  }

  switch (level.var_e91491fb) {
    case #"ads":
      if(self isplayerads()) {
        return true;
      }

      return false;
    case #"jump":
      if(self isplayerjumping()) {
        return true;
      }

      return false;
    case #"slide":
      if(self isplayersliding()) {
        return true;
      }

      return false;
    case #"hash_6c6c8f6b349b8751":
      if(self isplayerjumping() || self isplayersliding()) {
        return true;
      }

      return false;
    case #"crouch":
      if(self getstance() === "crouch") {
        return true;
      }

      return false;
    case #"prone":
      if(self getstance() === "prone") {
        return true;
      }

      return false;
    case #"movement":
    default:
      v_velocity = self getvelocity();

      if(length(v_velocity) != 0) {
        return true;
      }

      return false;
  }
}