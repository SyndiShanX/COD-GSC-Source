/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_28bfe6df1650ab79.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\trials\zm_trial_disable_upgraded_weapons;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_e01afe67;

autoexec __init__system__() {
  system::register(#"hash_993ee8bedbddc19", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_27897abffa9137fc", &on_begin, &on_end);
}

private on_begin() {
  zm::register_actor_damage_callback(&height_check);
  callback::on_ai_spawned(&on_ai_spawned);
  level.var_8c018a0e = 1;
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
  callback::remove_on_ai_spawned(&on_ai_spawned);
  level.var_8c018a0e = undefined;

  if(isinarray(level.actor_damage_callbacks, &height_check)) {
    arrayremovevalue(level.actor_damage_callbacks, &height_check, 0);
  }

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
  challenge = zm_trial::function_a36e8c38(#"hash_27897abffa9137fc");
  return isDefined(challenge);
}

private height_check(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(attacker.origin) && isDefined(self.origin) && attacker.origin[2] > self.origin[2] + 40) {
    return damage;
  }

  return 0;
}

private on_ai_spawned() {
  self.ignore_nuke = 1;
  self.no_gib = 1;
}

private function_33f0ddd3(eventstruct) {
  self function_6a8979c9();
}

private function_6a8979c9() {
  assert(isDefined(level.var_3e2ac3b6));

  foreach(weapon in self getweaponslist(1)) {
    if(zm_loadout::is_hero_weapon(weapon) || isDefined(weapon.isriotshield) && weapon.isriotshield) {
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