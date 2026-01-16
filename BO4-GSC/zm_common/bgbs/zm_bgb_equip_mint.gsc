/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_equip_mint.gsc
************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_equip_mint;

autoexec __init__system__() {
  system::register(#"zm_bgb_equip_mint", &__init__, undefined, "bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_equip_mint", "activated", 1, undefined, undefined, &validation, &activation);
}

activation() {
  w_lethal = self zm_loadout::get_player_lethal_grenade();

  if(w_lethal.isgadget) {
    n_slot = self gadgetgetslot(w_lethal);

    if(w_lethal == getweapon(#"tomahawk_t8") || w_lethal == getweapon(#"tomahawk_t8_upgraded")) {
      self notify(#"hash_3d73720d4588203c");
      self gadgetpowerset(n_slot, 100);
    } else {
      self gadgetpowerreset(n_slot, 0);
    }
  }

  self zm_stats::increment_challenge_stat(#"hash_47646e52fcbb190e");
}

validation() {
  w_lethal = self zm_loadout::get_player_lethal_grenade();
  n_stock_size = self getweaponammostock(w_lethal);
  n_clip_size = self getweaponammoclipsize(w_lethal);
  n_slot = self gadgetgetslot(w_lethal);
  n_power = self gadgetpowerget(n_slot);

  if((w_lethal == getweapon(#"tomahawk_t8") || w_lethal == getweapon(#"tomahawk_t8_upgraded")) && self function_36dfc05f(n_slot)) {
    return false;
  }

  if(n_stock_size < n_clip_size || n_power < 100) {
    return true;
  }

  return false;
}