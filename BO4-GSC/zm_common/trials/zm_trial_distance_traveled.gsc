/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_distance_traveled.gsc
***********************************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_distance_traveled;

autoexec __init__system__() {
  system::register(#"zm_trial_distance_traveled", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"distance_traveled", &on_begin, &on_end);
}

private on_begin(var_38282db8) {
  var_38282db8 = zm_trial::function_5769f26a(var_38282db8);

  foreach(player in getplayers()) {
    player thread function_ed4d5d4(var_38282db8);
  }

  level.var_4220f02a = array(getweapon(#"launcher_standard_t8"), getweapon(#"ww_random_ray_gun1"), getweapon(#"ww_random_ray_gun2"), getweapon(#"ww_random_ray_gun2_charged"), getweapon(#"ww_random_ray_gun3"), getweapon(#"ww_random_ray_gun3_charged"));
}

private on_end(round_reset) {
  level.var_4220f02a = undefined;
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"distance_traveled");
  return isDefined(challenge);
}

function_ed4d5d4(var_38282db8) {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656", #"end_game", #"end_distance_traveled");
  n_distance_traveled = 0;
  self zm_trial_util::function_2190356a(int(n_distance_traveled), 1);
  self zm_trial_util::function_c2cd0cba(var_38282db8);
  wait 12;
  var_31409e15 = self.origin;

  while(true) {
    var_abf38d09 = distance(self.origin, var_31409e15) * 0.0254;

    if(isalive(self)) {
      if(self function_e7985d50()) {
        while(self function_e7985d50()) {
          var_31409e15 = self.origin;
          waitframe(1);
        }
      } else {
        n_distance_traveled += var_abf38d09;
      }
    }

    if(n_distance_traveled < var_38282db8) {
      self zm_trial_util::function_2190356a(int(n_distance_traveled), 1);
      self zm_trial_util::function_c2cd0cba(var_38282db8);
    } else {
      self zm_trial_util::function_2190356a(var_38282db8);
      self zm_trial_util::function_c2cd0cba(var_38282db8);
      zm_trial::fail(#"hash_1ab078fa9460e7c9", array(self));
      level notify(#"end_distance_traveled");
      return;
    }

    var_31409e15 = self.origin;
    waitframe(1);
  }
}

function_e7985d50() {
  if(isDefined(self.var_16735873) && self.var_16735873 || self util::function_88c74107() || isDefined(self.var_ffe2c4d7) && self.var_ffe2c4d7 || isDefined(self.var_25c3de32) && self.var_25c3de32) {
    return true;
  }

  w_weapon = self getcurrentweapon();
  w_weapon = zm_weapons::get_base_weapon(w_weapon);
  var_f77522bb = self getnormalizedmovement();

  if(isarray(level.var_4220f02a) && self isfiring() && isinarray(level.var_4220f02a, w_weapon) && var_f77522bb == (0, 0, 0)) {
    return true;
  }

  return false;
}