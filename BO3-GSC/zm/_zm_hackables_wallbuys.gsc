/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_hackables_wallbuys.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_equip_hacker;
#namespace zm_hackables_wallbuys;

function hack_wallbuys() {
  weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
  for (i = 0; i < weapon_spawns.size; i++) {
    if(weapon_spawns[i].weapon.type == "grenade") {
      continue;
    }
    if(weapon_spawns[i].weapon.type == "melee") {
      continue;
    }
    if(weapon_spawns[i].weapon.type == "mine") {
      continue;
    }
    if(weapon_spawns[i].weapon.type == "bomb") {
      continue;
    }
    struct = spawnstruct();
    struct.origin = weapon_spawns[i].origin;
    struct.radius = 48;
    struct.height = 48;
    struct.script_float = 2;
    struct.script_int = 3000;
    struct.wallbuy = weapon_spawns[i];
    zm_equip_hacker::register_pooled_hackable_struct(struct, & wallbuy_hack);
  }
  bowie_triggers = getentarray("bowie_upgrade", "targetname");
  array::thread_all(bowie_triggers, & zm_equip_hacker::hide_hint_when_hackers_active);
}

function wallbuy_hack(hacker) {
  self.wallbuy.trigger_stub.hacked = 1;
  self.clientfieldname = (self.wallbuy.zombie_weapon_upgrade + "_") + self.origin;
  level clientfield::set(self.clientfieldname, 2);
  zm_equip_hacker::deregister_hackable_struct(self);
}