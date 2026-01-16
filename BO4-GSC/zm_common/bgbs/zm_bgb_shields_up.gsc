/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_shields_up.gsc
************************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_weapons;

#namespace zm_bgb_shields_up;

autoexec __init__system__() {
  system::register(#"zm_bgb_shields_up", &__init__, undefined, "bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_shields_up", "activated", 1, undefined, undefined, &validation, &activation);
}

activation() {
  self give_shield();
}

validation() {
  if(isDefined(self.weaponriotshield) && self.weaponriotshield != level.weaponnone) {
    w_shield = self.weaponriotshield;
    n_health_max = int(w_shield.weaponstarthitpoints);
    var_9428def3 = self damageriotshield(0);

    if(var_9428def3 < n_health_max) {
      return true;
    }

    return false;
  }

  if(isDefined(level.var_b115fab2)) {
    return true;
  }

  return false;
}

give_shield() {
  if(!(isDefined(self.hasriotshield) && self.hasriotshield)) {
    if(isDefined(self.var_5ba94c1e) && self.var_5ba94c1e && isDefined(level.var_70f7eb75)) {
      self zm_weapons::weapon_give(level.var_70f7eb75);
      self zm_weapons::ammo_give(level.var_70f7eb75, 0);
    } else if(!self hasweapon(level.var_b115fab2)) {
      self zm_weapons::weapon_give(level.var_b115fab2);
      self zm_weapons::ammo_give(level.var_b115fab2, 0);
    }

    return;
  }

  if(isDefined(self.hasriotshield) && self.hasriotshield && isDefined(self.player_shield_reset_health)) {
    self[[self.player_shield_reset_health]]();
    self zm_weapons::ammo_give(self.weaponriotshield, 0);
  }
}