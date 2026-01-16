/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_free_fire.gsc
***********************************************/

#include scripts\core_common\perks;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_weapons;

#namespace zm_bgb_free_fire;

autoexec __init__system__() {
  system::register(#"zm_bgb_free_fire", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_free_fire", "time", 30, &enable, &disable, &validation, undefined);
}

enable() {
  self thread function_1ff1beff();
  w_current = self getcurrentweapon();
  self function_9d347621(w_current);
}

disable() {
  self endon(#"disconnect");
  self notify(#"hash_1b878c77be2d017b");
  wait 0.1;

  if(self hasperk("specialty_freefire")) {
    self perks::perk_unsetperk("specialty_freefire");
  }
}

validation() {
  w_current = self getcurrentweapon();

  if(isDefined(w_current.isheroweapon) && w_current.isheroweapon || zm_weapons::is_wonder_weapon(w_current)) {
    return false;
  }

  return true;
}

function_1ff1beff() {
  self endon(#"disconnect", #"player_downed", #"hash_1b878c77be2d017b");
  w_current = self getcurrentweapon();

  if(!(isDefined(w_current.isheroweapon) && w_current.isheroweapon) && !zm_weapons::is_wonder_weapon(w_current)) {
    self perks::perk_setperk("specialty_freefire");
  }

  while(true) {
    s_notify = self waittill(#"weapon_change");
    w_check = s_notify.weapon;

    if(isDefined(w_check.isheroweapon) && w_check.isheroweapon || zm_weapons::is_wonder_weapon(w_check)) {
      if(self hasperk("specialty_freefire")) {
        self perks::perk_unsetperk("specialty_freefire");
      }

      continue;
    }

    if(!self hasperk("specialty_freefire")) {
      self perks::perk_setperk("specialty_freefire");
    }

    self function_9d347621(w_check);
  }
}

function_9d347621(w_check) {
  n_ammo_total = 0;
  n_ammo_stock = self getweaponammostock(w_check);
  n_ammo_clip = self getweaponammoclip(w_check);
  n_ammo_total += n_ammo_stock + n_ammo_clip;

  if(n_ammo_total == 0) {
    self setweaponammoclip(w_check, 1);
  }
}