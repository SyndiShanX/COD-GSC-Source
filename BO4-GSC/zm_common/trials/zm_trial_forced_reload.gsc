/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_forced_reload.gsc
*******************************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_forced_reload;

autoexec __init__system__() {
  system::register(#"zm_trial_forced_reload", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"forced_reload", &on_begin, &on_end);
}

private on_begin() {
  callback::on_weapon_fired(&on_weapon_fired);
  callback::function_33f0ddd3(&function_33f0ddd3);
  callback::on_weapon_change(&zm_trial_util::function_79518194);

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_bf710271(1, 1, 1, 0, 1);
    player thread zm_trial_util::function_dc9ab223(1, 1);
  }

  level zm_trial::function_25ee130(1);
}

private on_end(round_reset) {
  callback::remove_on_weapon_fired(&on_weapon_fired);
  callback::function_824d206(&function_33f0ddd3);
  callback::remove_on_weapon_change(&zm_trial_util::function_79518194);

  foreach(player in getplayers()) {
    player notify(#"hash_1fbfdb0105f48f89");
    player thread zm_trial_util::function_dc0859e();
  }

  level zm_trial::function_25ee130(0);
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "give_weapon") {
    if(zm_loadout::is_melee_weapon(s_event.weapon) || zm_loadout::is_lethal_grenade(s_event.weapon) || zm_loadout::is_tactical_grenade(s_event.weapon, 1)) {
      self lockweapon(s_event.weapon, 1, 1);

      if(s_event.weapon.dualwieldweapon != level.weaponnone) {
        self lockweapon(s_event.weapon.dualwieldweapon, 1, 1);
      }

      if(s_event.weapon.altweapon != level.weaponnone) {
        self lockweapon(s_event.weapon.altweapon, 1, 1);
      }
    }
  }
}

private on_weapon_fired(params) {
  self notify("3a8478a97b3babfa");
  self endon("3a8478a97b3babfa");
  self endon(#"disconnect", #"hash_1fbfdb0105f48f89");
  n_clip_size = self getweaponammoclipsize(params.weapon);
  var_2cf11630 = self getweaponammoclip(params.weapon);

  if(n_clip_size > 1 && var_2cf11630 < n_clip_size) {
    if(params.weapon.isburstfire) {
      while(self isfiring()) {
        waitframe(1);
      }
    }

    self thread function_29ee24dd(params.weapon);
  }
}

private function_29ee24dd(weapon) {
  self endon(#"disconnect");
  self lockweapon(weapon, 1, 1);
  self zm_trial_util::function_7dbb1712();
  n_clip_ammo = self getweaponammoclip(weapon);
  n_stock_ammo = self getweaponammostock(weapon);

  if(n_stock_ammo > 0) {
    while(true) {
      s_waitresult = self waittill(#"reload", #"zmb_max_ammo", #"hash_278526d0bbdb4ce7", #"hash_1fbfdb0105f48f89", #"player_downed", #"death");
      w_current = self getcurrentweapon();

      if(s_waitresult._notify == "reload" && weapon != w_current) {
        continue;
      }

      break;
    }
  }

  if(isDefined(self)) {
    self unlockweapon(weapon);
    self zm_trial_util::function_7dbb1712(1);
  }
}