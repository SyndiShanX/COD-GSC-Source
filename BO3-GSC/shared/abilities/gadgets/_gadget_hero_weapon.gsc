/************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_hero_weapon.gsc
************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_hero_weapon;

function autoexec __init__sytem__() {
  system::register("gadget_hero_weapon", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(14, & gadget_hero_weapon_on_activate, & gadget_hero_weapon_on_off);
  ability_player::register_gadget_possession_callbacks(14, & gadget_hero_weapon_on_give, & gadget_hero_weapon_on_take);
  ability_player::register_gadget_flicker_callbacks(14, & gadget_hero_weapon_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(14, & gadget_hero_weapon_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(14, & gadget_hero_weapon_is_flickering);
  ability_player::register_gadget_ready_callbacks(14, & gadget_hero_weapon_ready);
}

function gadget_hero_weapon_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_hero_weapon_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_hero_weapon_on_flicker(slot, weapon) {}

function gadget_hero_weapon_on_give(slot, weapon) {
  if(!isDefined(self.pers["held_hero_weapon_ammo_count"])) {
    self.pers["held_hero_weapon_ammo_count"] = [];
  }
  if(weapon.gadget_power_consume_on_ammo_use || !isDefined(self.pers["held_hero_weapon_ammo_count"][weapon])) {
    self.pers["held_hero_weapon_ammo_count"][weapon] = 0;
  }
  self setweaponammoclip(weapon, self.pers["held_hero_weapon_ammo_count"][weapon]);
  n_ammo = self getammocount(weapon);
  if(n_ammo > 0) {
    stock = self.pers["held_hero_weapon_ammo_count"][weapon] - n_ammo;
    if(stock > 0 && !weapon.iscliponly) {
      self setweaponammostock(weapon, stock);
    }
    self hero_handle_ammo_save(slot, weapon);
  } else {
    self gadgetcharging(slot, 1);
  }
}

function gadget_hero_weapon_on_take(slot, weapon) {}

function gadget_hero_weapon_on_connect() {}

function gadget_hero_weapon_on_spawn() {}

function gadget_hero_weapon_on_activate(slot, weapon) {
  self.heroweaponkillcount = 0;
  self.heroweaponshots = 0;
  self.heroweaponhits = 0;
  if(!weapon.gadget_power_consume_on_ammo_use) {
    self hero_give_ammo(slot, weapon);
    self hero_handle_ammo_save(slot, weapon);
  }
}

function gadget_hero_weapon_on_off(slot, weapon) {
  if(weapon.gadget_power_consume_on_ammo_use) {
    self setweaponammoclip(weapon, 0);
  }
}

function gadget_hero_weapon_ready(slot, weapon) {
  if(weapon.gadget_power_consume_on_ammo_use) {
    hero_give_ammo(slot, weapon);
  }
}

function hero_give_ammo(slot, weapon) {
  self givemaxammo(weapon);
  self setweaponammoclip(weapon, weapon.clipsize);
}

function hero_handle_ammo_save(slot, weapon) {
  self thread hero_wait_for_out_of_ammo(slot, weapon);
  self thread hero_wait_for_game_end(slot, weapon);
  self thread hero_wait_for_death(slot, weapon);
}

function hero_wait_for_game_end(slot, weapon) {
  self endon("disconnect");
  self notify("hero_ongameend");
  self endon("hero_ongameend");
  level waittill("game_ended");
  if(isalive(self)) {
    self hero_save_ammo(slot, weapon);
  }
}

function hero_wait_for_death(slot, weapon) {
  self endon("disconnect");
  self notify("hero_ondeath");
  self endon("hero_ondeath");
  self waittill("death");
  self hero_save_ammo(slot, weapon);
}

function hero_save_ammo(slot, weapon) {
  self.pers["held_hero_weapon_ammo_count"][weapon] = self getammocount(weapon);
}

function hero_wait_for_out_of_ammo(slot, weapon) {
  self endon("disconnect");
  self endon("death");
  self notify("hero_noammo");
  self endon("hero_noammo");
  while(true) {
    wait(0.1);
    n_ammo = self getammocount(weapon);
    if(n_ammo == 0) {
      break;
    }
  }
  self gadgetpowerreset(slot);
  self gadgetcharging(slot, 1);
}

function set_gadget_hero_weapon_status(weapon, status, time) {
  timestr = "";
  if(isDefined(time)) {
    timestr = (("^3") + ", time: ") + time;
  }
  if(getdvarint("scr_cpower_debug_prints") > 0) {
    self iprintlnbold(((("Hero Weapon " + weapon.name) + ": ") + status) + timestr);
  }
}