/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_hero_weapon.gsc
****************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace hero_weapon;

autoexec __init__system__() {
  system::register(#"gadget_hero_weapon", &__init__, undefined, undefined);
}

__init__() {
  ability_player::register_gadget_activation_callbacks(11, &gadget_hero_weapon_on_activate, &gadget_hero_weapon_on_off);
  ability_player::register_gadget_possession_callbacks(11, &gadget_hero_weapon_on_give, &gadget_hero_weapon_on_take);
  ability_player::register_gadget_is_inuse_callbacks(11, &gadget_hero_weapon_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(11, &gadget_hero_weapon_is_flickering);
  ability_player::register_gadget_ready_callbacks(11, &gadget_hero_weapon_ready);
}

gadget_hero_weapon_is_inuse(slot) {
  return self gadgetisactive(slot);
}

gadget_hero_weapon_is_flickering(slot) {
  return self gadgetflickering(slot);
}

gadget_hero_weapon_on_give(slot, weapon) {
  if(!isDefined(self.pers[#"held_hero_weapon_ammo_count"])) {
    self.pers[#"held_hero_weapon_ammo_count"] = [];
  }

  if(weapon.gadget_power_consume_on_ammo_use || weapon.var_bec5136b || !isDefined(self.pers[#"held_hero_weapon_ammo_count"][weapon])) {
    self.pers[#"held_hero_weapon_ammo_count"][weapon] = 0;
  }

  self setweaponammoclip(weapon, self.pers[#"held_hero_weapon_ammo_count"][weapon]);
  n_ammo = self getammocount(weapon);

  if(n_ammo > 0) {
    stock = self.pers[#"held_hero_weapon_ammo_count"][weapon] - n_ammo;

    if(stock > 0 && !weapon.iscliponly) {
      self setweaponammostock(weapon, stock);
    }

    self hero_handle_ammo_save(slot, weapon);
    return;
  }

  self gadgetcharging(slot, 1);
}

gadget_hero_weapon_on_take(slot, weapon) {}

gadget_hero_weapon_on_activate(slot, weapon) {
  self.heavyweaponkillcount = 0;
  self.heavyweaponshots = 0;
  self.heavyweaponhits = 0;
  self notify(#"hero_weapon_active");

  if(function_de324246(slot, weapon)) {
    self hero_give_ammo(slot, weapon);
    self hero_handle_ammo_save(slot, weapon);
  }
}

gadget_hero_weapon_on_off(slot, weapon) {
  self setweaponammoclip(weapon, 0);

  if(isalive(self) && isDefined(level.playgadgetoff)) {
    self[[level.playgadgetoff]](weapon);
  }
}

gadget_hero_weapon_ready(slot, weapon) {
  if(function_98056dc4(slot, weapon)) {
    hero_give_ammo(slot, weapon);
  }
}

function_de324246(slot, weapon) {
  return false;
}

function_98056dc4(slot, weapon) {
  return weapon.gadget_power_consume_on_ammo_use || weapon.var_bec5136b;
}

hero_give_ammo(slot, weapon) {
  self givemaxammo(weapon);
  self setweaponammoclip(weapon, weapon.clipsize);
}

hero_handle_ammo_save(slot, weapon) {
  self thread hero_wait_for_out_of_ammo(slot, weapon);
  self thread hero_wait_for_death(slot, weapon);
  self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
}

on_end_game(slot, weapon) {
  if(isalive(self)) {
    self hero_save_ammo(slot, weapon);
  }
}

hero_wait_for_death(slot, weapon) {
  self endon(#"disconnect");
  self endon(#"give_map");
  self notify(#"hero_ondeath");
  self endon(#"hero_ondeath");
  self waittill(#"death");
  gadgetslot = self gadgetgetslot(weapon);

  if(gadgetslot != slot) {
    return;
  }

  self hero_save_ammo(slot, weapon);
}

hero_save_ammo(slot, weapon) {
  if(isDefined(weapon)) {
    self.pers[#"held_hero_weapon_ammo_count"][weapon] = self getammocount(weapon);
  }
}

hero_wait_for_out_of_ammo(slot, weapon) {
  self endon(#"disconnect");
  self endon(#"death");
  self endon(#"give_map");
  self notify(#"hero_noammo");
  self endon(#"hero_noammo");

  while(true) {
    wait 0.1;
    gadgetslot = self gadgetgetslot(weapon);

    if(gadgetslot != slot) {
      return;
    }

    n_ammo = self getammocount(weapon);

    if(n_ammo == 0) {
      break;
    }
  }

  self gadgetpowerreset(slot);
  self gadgetcharging(slot, 1);
}

set_gadget_hero_weapon_status(weapon, status, time) {
  timestr = "";

  if(isDefined(time)) {
    timestr = "^3" + ", time: " + time;
  }

  if(getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
    self iprintlnbold("Hero Weapon " + weapon.name + ": " + status + timestr);
  }
}