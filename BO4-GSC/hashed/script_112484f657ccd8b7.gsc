/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_112484f657ccd8b7.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace namespace_ab88201b;

autoexec __init__system__() {
  system::register(#"hash_77812dea54caab85", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_6840f605489bddc2", &on_begin, &on_end);
}

private on_begin(var_c8a36f90) {
  level.var_2bd4c60 = isDefined(var_c8a36f90) ? var_c8a36f90 : "movement";

  foreach(player in getplayers()) {
    player thread function_1633056a();
  }
}

private on_end(round_reset) {
  level.var_2bd4c60 = undefined;

  foreach(player in getplayers()) {
    player val::reset(#"hash_10a425ccc9bbccad", "health_regen");
  }
}

private function_1633056a() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");

  while(true) {
    if(self function_26f124d8() && !self.heal.enabled) {
      self val::reset(#"hash_10a425ccc9bbccad", "health_regen");
    } else if(!self function_26f124d8() && self.heal.enabled) {
      self val::set(#"hash_10a425ccc9bbccad", "health_regen", 0);
    }

    waitframe(1);
  }
}

private function_26f124d8() {
  switch (level.var_2bd4c60) {
    case #"ads":
      if(self playerads() == 1) {
        return true;
      }

      return false;
    case #"jump":
      if(self zm_utility::is_jumping()) {
        return true;
      }

      return false;
    case #"slide":
      if(self issliding()) {
        return true;
      }

      return false;
    case #"hash_6c6c8f6b349b8751":
      if(self zm_utility::is_jumping() || self issliding()) {
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