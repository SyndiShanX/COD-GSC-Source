/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_attackables.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\table_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_attackables;

function autoexec __init__sytem__() {
  system::register("zm_attackables", &__init__, &__main__, undefined);
}

function __init__() {
  level.attackablecallback = &attackable_callback;
  level.attackables = struct::get_array("scriptbundle_attackables", "classname");
  foreach(attackable in level.attackables) {
    attackable.bundle = struct::get_script_bundle("attackables", attackable.scriptbundlename);
    if(isDefined(attackable.target)) {
      attackable.slot = struct::get_array(attackable.target, "targetname");
    }
    attackable.is_active = 0;
    attackable.health = attackable.bundle.max_health;
    if(getdvarint("zm_attackables") > 0) {
      attackable.is_active = 1;
      attackable.health = 1000;
    }
  }
}

function __main__() {}

function get_attackable() {
  foreach(attackable in level.attackables) {
    if(!(isDefined(attackable.is_active) && attackable.is_active)) {
      continue;
    }
    dist = distance(self.origin, attackable.origin);
    if(dist < attackable.bundle.aggro_distance) {
      if(attackable get_attackable_slot(self)) {
        return attackable;
      }
    }
    if(getdvarint("") > 1) {
      if(attackable get_attackable_slot(self)) {
        return attackable;
      }
    }
  }
  return undefined;
}

function get_attackable_slot(entity) {
  self clear_slots();
  foreach(slot in self.slot) {
    if(!isDefined(slot.entity)) {
      slot.entity = entity;
      entity.attackable_slot = slot;
      return true;
    }
  }
  return false;
}

function private clear_slots() {
  foreach(slot in self.slot) {
    if(!isalive(slot.entity)) {
      slot.entity = undefined;
      continue;
    }
    if(isDefined(slot.entity.missinglegs) && slot.entity.missinglegs) {
      slot.entity = undefined;
    }
  }
}

function activate() {
  self.is_active = 1;
  if(self.health <= 0) {
    self.health = self.bundle.max_health;
  }
}

function deactivate() {
  self.is_active = 0;
}

function do_damage(damage) {
  self.health = self.health - damage;
  self notify("attackable_damaged");
  if(self.health <= 0) {
    self notify("attackable_deactivated");
    if(!(isDefined(self.b_deferred_deactivation) && self.b_deferred_deactivation)) {
      self deactivate();
    }
  }
}

function attackable_callback(entity) {
  if(entity.archetype === "thrasher" && (self.scriptbundlename === "zm_island_trap_plant_attackable" || self.scriptbundlename === "zm_island_trap_plant_upgraded_attackable")) {
    self do_damage(self.health);
  } else {
    self do_damage(entity.meleeweapon.meleedamage);
  }
}