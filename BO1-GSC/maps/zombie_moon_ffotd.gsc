/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_moon_ffotd.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

main_start() {
  SetSavedDvar("sm_sunShadowSmallScriptPS3OnlyEnable", true);
}
main_end() {
  if(level.pistol_values[level.pistol_values.size - 1] != "microwavegundw_upgraded_zm") {
    level.pistol_values[level.pistol_values.size] = "microwavegundw_zm";
    level.pistol_values[level.pistol_values.size] = "microwavegundw_upgraded_zm";
  }
  level.zombie_last_stand = ::last_stand_pistol_swap;
}
last_stand_pistol_swap() {
  if(self has_powerup_weapon()) {
    self.lastActiveWeapon = "none";
  }
  if(!self HasWeapon(self.laststandpistol)) {
    self GiveWeapon(self.laststandpistol);
  }
  ammoclip = WeaponClipSize(self.laststandpistol);
  doubleclip = ammoclip * 2;
  if(is_true(self._special_solo_pistol_swap) || (self.laststandpistol == "m1911_upgraded_zm" && !self.hadpistol)) {
    self._special_solo_pistol_swap = 0;
    self.hadpistol = false;
    self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
  } else if(flag("solo_game") && self.laststandpistol == "m1911_upgraded_zm") {
    self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
  } else if(self.laststandpistol == "m1911_zm") {
    self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
  } else if(self.laststandpistol == "ray_gun_zm" || self.laststandpistol == "ray_gun_upgraded_zm") {
    if(self.stored_weapon_info[self.laststandpistol].total_amt >= ammoclip) {
      self SetWeaponAmmoClip(self.laststandpistol, ammoclip);
      self.stored_weapon_info[self.laststandpistol].given_amt = ammoclip;
    } else {
      self SetWeaponAmmoClip(self.laststandpistol, self.stored_weapon_info[self.laststandpistol].total_amt);
      self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
    }
    self SetWeaponAmmoStock(self.laststandpistol, 0);
  } else {
    if(self.stored_weapon_info[self.laststandpistol].stock_amt >= doubleclip) {
      self SetWeaponAmmoStock(self.laststandpistol, doubleclip);
      self.stored_weapon_info[self.laststandpistol].given_amt = doubleclip + self.stored_weapon_info[self.laststandpistol].clip_amt + self.stored_weapon_info[self.laststandpistol].left_clip_amt;
    } else {
      self SetWeaponAmmoStock(self.laststandpistol, self.stored_weapon_info[self.laststandpistol].stock_amt);
      self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
    }
  }
  self SwitchToWeapon(self.laststandpistol);
}