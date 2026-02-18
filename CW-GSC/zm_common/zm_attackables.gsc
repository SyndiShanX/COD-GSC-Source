/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_attackables.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\table_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_attackables;

function private autoexec __init__system__() {
  system::register(#"zm_attackables", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level.attackablecallback = &attackable_callback;
  level.attackables = struct::get_array("scriptbundle_attackables", "classname");

  foreach(attackable in level.attackables) {
    attackable.bundle = getscriptbundle(attackable.scriptbundlename);

    if(isDefined(attackable.target)) {
      attackable.slot = struct::get_array(attackable.target, "targetname");
    }

    attackable.is_active = 0;
    attackable.health = attackable.bundle.max_health;

    if(getdvarint(#"zm_attackables", 0) > 0) {
      attackable.is_active = 1;
      attackable.health = 1000;
    }
  }
}

function private postinit() {}

function get_attackable() {
  foreach(attackable in level.attackables) {
    if(!is_true(attackable.is_active)) {
      continue;
    }

    dist = distance(self.origin, attackable.origin);

    if(dist < attackable.bundle.aggro_distance) {
      if(attackable get_attackable_slot(self)) {
        return attackable;
      }
    }

    if(getdvarint(#"zm_attackables", 0) > 1) {
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

    if(is_true(slot.entity.missinglegs)) {
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
  self.health -= damage;
  self notify(#"attackable_damaged");

  if(self.health <= 0) {
    self notify(#"attackable_deactivated");

    if(!is_true(self.b_deferred_deactivation)) {
      self deactivate();
    }
  }
}

function attackable_callback(entity) {
  if(entity.archetype === "thrasher" && (self.scriptbundlename === "zm_island_trap_plant_attackable" || self.scriptbundlename === "zm_island_trap_plant_upgraded_attackable")) {
    self do_damage(self.health);
    return;
  }

  self do_damage(entity.meleeweapon.meleedamage);
}