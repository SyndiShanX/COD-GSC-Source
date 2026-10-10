/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_lock_door.gsc
***********************************************/

#using script_3a8f9ace195c9da9;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\utility;
#namespace cp_lock_door;

function function_5e512a9e89597b21() {
  flag_wait("dungeon_load_finished");
  flag_wait("scriptables_ready");
  var_8def23560c2362bb = getStructArray("cp_lock_door", "targetname");

  foreach(locker in var_8def23560c2362bb) {
    if(isDefined(locker.target)) {
      doors = getentitylessscriptablearray(locker.target, "targetname");
      door = getclosest(locker.origin, doors);
    }

    if(!isDefined(door)) {
      doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(locker.origin, float(locker.radius), float(locker.radius));
      door = getclosest(locker.origin, doors);
    }

    if(isDefined(door)) {
      door function_79a4d351eac40e17();

      if(!isDefined(locker.remove_prompt) || istrue(int(locker.remove_prompt))) {
        door scriptabledoorfreeze(1);
      }

      if(!isDefined(locker.var_cd11c31526523a63) || istrue(int(locker.var_cd11c31526523a63))) {
        locker thread function_c2d0f610d609e57d(door);
      }
    }
  }
}

function function_c2d0f610d609e57d(door) {
  if(!isDefined(door)) {
    return;
  }

  level endon("game_ended");
  self notify("closet_opener_start");
  self endon("closet_opener_start");

  while(isDefined(door)) {
    var_623a48a3acd836c7 = getaiarrayinradius(self.origin, self.radius, "axis");

    foreach(ai in var_623a48a3acd836c7) {
      door scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_freeze_open(1);
      return;
    }

    wait 0.25;
  }
}