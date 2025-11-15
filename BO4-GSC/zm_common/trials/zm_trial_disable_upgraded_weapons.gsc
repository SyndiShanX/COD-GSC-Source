/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_upgraded_weapons.gsc
******************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\trials\zm_trial_disable_hero_weapons;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_upgraded_weapons;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_upgraded_weapons", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_upgraded_weapons", &on_begin, &on_end);
}

private on_begin() {
  assert(isDefined(level.zombie_weapons_upgraded));
  level.var_af806901 = [];

  foreach(upgraded_weapon in getarraykeys(level.zombie_weapons_upgraded)) {
    level.var_af806901[upgraded_weapon.name] = upgraded_weapon;
  }

  foreach(player in getplayers()) {
    player function_6a8979c9();
    player callback::function_33f0ddd3(&function_33f0ddd3);
    player zm_trial_util::function_7dbb1712(1);
    player callback::on_weapon_change(&zm_trial_util::function_79518194);
  }

  zm_trial_util::function_eea26e56();
  level zm_trial::function_8e2a923(1);
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player callback::function_824d206(&function_33f0ddd3);
    player callback::remove_on_weapon_change(&zm_trial_util::function_79518194);

    foreach(weapon in player getweaponslist(1)) {
      player unlockweapon(weapon);

      if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
        player unlockweapon(weapon.dualwieldweapon);
      }
    }

    player zm_trial_util::function_7dbb1712(1);
  }

  level.var_af806901 = undefined;
  zm_trial_util::function_ef1fce77();
  level zm_trial::function_8e2a923(0);
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"disable_upgraded_weapons");
  return isDefined(challenge);
}

private function_33f0ddd3(eventstruct) {
  self function_6a8979c9();
}

private function_6a8979c9() {
  assert(isDefined(level.var_af806901));

  foreach(weapon in self getweaponslist(1)) {
    if(isDefined(level.var_af806901[weapon.name])) {
      self lockweapon(weapon);
    } else if(!zm_trial_disable_hero_weapons::is_active() || !isarray(level.var_3e2ac3b6) || !isDefined(level.var_3e2ac3b6[weapon.name])) {
      self unlockweapon(weapon);
    }

    if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
      if(self isweaponlocked(weapon)) {
        self lockweapon(weapon.dualwieldweapon);
        continue;
      }

      self unlockweapon(weapon.dualwieldweapon);
    }
  }
}