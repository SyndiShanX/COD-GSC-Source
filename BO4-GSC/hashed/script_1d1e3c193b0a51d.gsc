/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_1d1e3c193b0a51d.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;
#namespace zm_trial_damage_during_movement;

autoexec __init__system__() {
  system::register(#"zm_trial_damage_during_movement", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"damage_during_movement", &on_begin, &on_end);
}

on_begin(var_c8a36f90, var_16e6b8ea) {
  level.var_a96e21f8 = isDefined(var_c8a36f90) ? var_c8a36f90 : "movement";
  var_16e6b8ea = zm_trial::function_5769f26a(var_16e6b8ea);

  foreach(player in getplayers()) {
    player thread function_1633056a(var_16e6b8ea);
  }
}

on_end(round_reset) {
  level.var_a96e21f8 = undefined;
}

function_1633056a(var_16e6b8ea = 10) {
  self endon(#"disconnect");
  level endon(#"trial_round_end");

  while(true) {
    if(isalive(self) && !self laststand::player_is_in_laststand() && self function_c81cdba2()) {
      self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
      self dodamage(var_16e6b8ea, self.origin);
      wait 1;
    }

    waitframe(1);
  }
}

function_c81cdba2() {
  switch (level.var_a96e21f8) {
    case #"ads":
      var_389b3ef1 = self playerads();

      if(self adsButtonPressed() && var_389b3ef1 > 0) {
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
    case #"crouch":
      if(self getstance() === "crouch") {
        return true;
      }

      return false;
    case #"sprint":
      if(self issprinting()) {
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