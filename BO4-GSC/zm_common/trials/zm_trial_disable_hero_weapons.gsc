/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_hero_weapons.gsc
**************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\trials\zm_trial_disable_upgraded_weapons;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_hero_weapons;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_hero_weapons", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_hero_weapons", &on_begin, &on_end);
}

private on_begin() {
  weapon_names = array(#"hero_chakram_lv1", #"hero_chakram_lv2", #"hero_chakram_lv3", #"hero_chakram_lh_lv1", #"hero_chakram_lh_lv2", #"hero_chakram_lh_lv3", #"hero_hammer_lv1", #"hero_hammer_lv2", #"hero_hammer_lv3", #"hero_katana_t8_lv1", #"hero_katana_t8_lv2", #"hero_katana_t8_lv3", #"hero_scepter_lv1", #"hero_scepter_lv2", #"hero_scepter_lv3", #"hero_sword_pistol_lv1", #"hero_sword_pistol_lv2", #"hero_sword_pistol_lv3", #"hero_sword_pistol_lh_lv1", #"hero_sword_pistol_lh_lv2", #"hero_sword_pistol_lh_lv3");
  level.var_3e2ac3b6 = [];

  foreach(weapon_name in weapon_names) {
    weapon = getweapon(weapon_name);

    if(isDefined(weapon) && weapon != level.weaponnone) {
      level.var_3e2ac3b6[weapon.name] = weapon;
    }
  }

  foreach(player in getplayers()) {
    player function_6a8979c9();
    player callback::function_33f0ddd3(&function_33f0ddd3);
    player zm_trial_util::function_9bf8e274();
  }

  level zm_trial::function_44200d07(1);
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player callback::function_824d206(&function_33f0ddd3);

    foreach(weapon in player getweaponslist(1)) {
      player unlockweapon(weapon);

      if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone) {
        player unlockweapon(weapon.dualwieldweapon);
      }
    }

    player zm_trial_util::function_73ff0096();
  }

  level.var_3e2ac3b6 = undefined;
  level zm_trial::function_44200d07(0);
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"disable_hero_weapons");
  return isDefined(challenge);
}

private function_33f0ddd3(eventstruct) {
  self function_6a8979c9();
}

private function_6a8979c9() {
  assert(isDefined(level.var_3e2ac3b6));

  foreach(weapon in self getweaponslist(1)) {
    if(isDefined(level.var_3e2ac3b6[weapon.name])) {
      self lockweapon(weapon);
    } else if(!zm_trial_disable_upgraded_weapons::is_active() || !isarray(level.var_af806901) || !isDefined(level.var_af806901[weapon.name])) {
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