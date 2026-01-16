/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_specialops.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_load;

main() {
  if(issplitscreen())
    set_splitscreen_fog(350, 2986.33, 10000, -480, 0.805, 0.715, 0.61, 0.0, 10000);

  maps\_load::main();
  setdvar("ui_specops", 1);
  level.is_specops_level = 1;
}

for_each(array, functor, unary_predicate, predicate_argument) {
  if(isDefined(functor)) {
    for(i = 0; i < array.size; i++) {
      if(isDefined(array[i])) {
        if(!isDefined(unary_predicate) || isDefined(unary_predicate) && (isDefined(predicate_argument) && array[i][
            [unary_predicate]
          ](predicate_argument) || !isDefined(predicate_argument) && array[i][
            [unary_predicate]
          ]()))
          array[i][
            [functor]
          ]();
      }
    }
  }
}

type_so() {
  if(isDefined(self) && isDefined(self.classname) && isDefined(self.script_specialops) && self.script_specialops == 1)
    return true;
  else
    return false;
}

type_reg() {
  return !self type_so();
}

type_spawners() {
  return isDefined(self.classname) && issubstr(self.classname, "actor_");
}

type_so_spawners() {
  return self type_so() && self type_spawners();
}

type_reg_spawners() {
  return self type_reg() && self type_spawners();
}

type_vehicle() {
  return isDefined(self.classname) && issubstr(self.classname, "script_vehicle");
}

type_so_vehicle() {
  return self type_so() && self type_vehicle();
}

type_reg_vehicle() {
  return self type_reg() && self type_vehicle();
}

type_spawn_trigger() {
  if(!isDefined(self.classname))
    return false;

  if(self.classname == "trigger_multiple_spawn")
    return true;

  if(self.classname == "trigger_multiple_spawn_reinforcement")
    return true;

  if(self.classname == "trigger_multiple_friendly_respawn")
    return true;

  if(isDefined(self.targetname) && self.targetname == "flood_spawner")
    return true;

  if(isDefined(self.targetname) && self.targetname == "friendly_respawn_trigger")
    return true;

  if(isDefined(self.spawnflags) && self.spawnflags & 32)
    return true;

  return false;
}

type_so_spawn_trigger() {
  return self type_so() && self type_so_spawn_trigger();
}

type_reg_spawn_trigger() {
  return self type_reg() && self type_so_spawn_trigger();
}

type_trigger() {
  array = [];
  array["trigger_multiple"] = 1;
  array["trigger_once"] = 1;
  array["trigger_use"] = 1;
  array["trigger_radius"] = 1;
  array["trigger_lookat"] = 1;
  array["trigger_disk"] = 1;
  array["trigger_damage"] = 1;
  return isDefined(self.classname) && isDefined(array[self.classname]);
}

type_so_trigger() {
  return self type_so() && self type_so_trigger();
}

type_reg_trigger() {
  return self type_reg() && self type_so_trigger();
}

type_flag_trigger() {
  array = [];
  array["trigger_multiple_flag_set"] = 1;
  array["trigger_multiple_flag_set_touching"] = 1;
  array["trigger_multiple_flag_clear"] = 1;
  array["trigger_multiple_flag_looking"] = 1;
  array["trigger_multiple_flag_lookat"] = 1;
  return isDefined(self.classname) && isDefined(array[self.classname]);
}

type_so_flag_trigger() {
  return self type_so() && self type_flag_trigger();
}

type_reg_flag_trigger() {
  return self type_reg() && self type_flag_trigger();
}

type_killspawner_trigger() {
  return self type_trigger() && isDefined(self.script_killspawner);
}

type_so_killspawner_trigger() {
  return self type_so() && self type_killspawner_trigger();
}

type_reg_killspawner_trigger() {
  return self type_reg() && self type_killspawner_trigger();
}

type_goalvolume() {
  return isDefined(self.classname) && self.classname == "info_volume" && isDefined(self.script_goalvolume);
}

type_so_goalvolume() {
  return self type_so() && self type_goalvolume();
}

type_reg_goalvolume() {
  return self type_reg() && self type_goalvolume();
}

delete_ent() {
  self delete();
}

delete_by_type(type_predicate) {
  for_each(getentarray(), ::delete_ent, type_predicate);
}

noteworthy_check(value) {
  if(isDefined(self) && isDefined(self.classname) && self.classname == "script_origin")
    return false;
  else if(isDefined(self) && isDefined(self.script_noteworthy) && self.script_noteworthy != value)
    return true;
  else if(isDefined(self) && isDefined(self.script_gameobjectname))
    return true;
  else
    return false;
}

delete_by_noteworthy(level_name) {
  for_each(getentarray(), ::delete_ent, ::noteworthy_check, level_name);
}