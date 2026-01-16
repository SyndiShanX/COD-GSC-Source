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

#namespace namespace_c1466447;

autoexec __init__system__() {
  system::register(#"hash_2f326252a6b5175", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_322751dde777c910", &on_begin, &on_end);
}

private on_begin(var_c8a36f90, var_16e6b8ea) {
  level.var_a96e21f8 = isDefined(var_c8a36f90) ? var_c8a36f90 : "movement";
  var_16e6b8ea = zm_trial::function_5769f26a(var_16e6b8ea);

  foreach(player in getplayers()) {
    player thread function_1633056a(var_16e6b8ea);
  }
}

private on_end(round_reset) {
  level.var_a96e21f8 = undefined;
}

private function_1633056a(var_16e6b8ea = 10) {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");

  while(true) {
    if(isalive(self) && !self laststand::player_is_in_laststand() && self function_c81cdba2()) {
      self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
      self dodamage(var_16e6b8ea, self.origin);
      wait 1;
    }

    waitframe(1);
  }
}

private function_c81cdba2() {
  switch (level.var_a96e21f8) {
    case #"ads":
      var_389b3ef1 = self playerads();

      if(self adsbuttonpressed() && var_389b3ef1 > 0) {
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