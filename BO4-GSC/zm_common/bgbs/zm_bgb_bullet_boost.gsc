/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_bullet_boost.gsc
**************************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_bgb_bullet_boost;

autoexec __init__system__() {
  system::register(#"zm_bgb_bullet_boost", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_bullet_boost", "activated", 1, undefined, undefined, &validation, &activation);
  bgb::function_e1f37ce7(#"zm_bgb_bullet_boost");
}

validation() {
  current_weapon = self getcurrentweapon();

  if(!zm_weapons::is_weapon_or_base_included(current_weapon) || !self zm_magicbox::can_buy_weapon() || self laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission || self isthrowinggrenade() || self isswitchingweapons() || !zm_weapons::weapon_supports_aat(current_weapon)) {
    return false;
  }

  return true;
}

activation() {
  self endon(#"death");
  self playsoundtoplayer(#"zmb_bgb_bullet_boost", self);
  current_weapon = self getcurrentweapon();
  current_weapon = self zm_weapons::switch_from_alt_weapon(current_weapon);
  var_9a9544b8 = self aat::getaatonweapon(current_weapon, 1);
  self aat::acquire(current_weapon, undefined, var_9a9544b8);
}