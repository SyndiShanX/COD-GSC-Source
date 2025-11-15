/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_attackables.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\table_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_attackables;

autoexec __init__system__() {
  system::register(#"zm_attackables", &__init__, &__main__, undefined);
}

__init__() {
  level.attackablecallback = &attackable_callback;
  level.attackables = struct::get_array("scriptbundle_attackables", "classname");

  foreach(attackable in level.attackables) {
    attackable.bundle = struct::get_script_bundle("attackables", attackable.scriptbundlename);

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

__main__() {}

get_attackable() {
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

    if(getdvarint(#"zm_attackables", 0) > 1) {
      if(attackable get_attackable_slot(self)) {
        return attackable;
      }
    }

  }

  return undefined;
}

get_attackable_slot(entity) {
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

private clear_slots() {
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

activate() {
  self.is_active = 1;

  if(self.health <= 0) {
    self.health = self.bundle.max_health;
  }
}

deactivate() {
  self.is_active = 0;
}

do_damage(damage) {
  self.health -= damage;
  self notify(#"attackable_damaged");

  if(self.health <= 0) {
    self notify(#"attackable_deactivated");

    if(!(isDefined(self.b_deferred_deactivation) && self.b_deferred_deactivation)) {
      self deactivate();
    }
  }
}

attackable_callback(entity) {
  if(entity.archetype === "thrasher" && (self.scriptbundlename === "zm_island_trap_plant_attackable" || self.scriptbundlename === "zm_island_trap_plant_upgraded_attackable")) {
    self do_damage(self.health);
    return;
  }

  self do_damage(entity.meleeweapon.meleedamage);
}