/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_blight_father.gsc
******************************************************/

#include scripts\core_common\ai\archetype_blight_father_interface;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\spawner_shared;

#namespace archetypeblightfather;

autoexec main() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"blight_father", &function_a27b7fcf);
  blightfatherinterface::registerblightfatherinterfaceattributes();
}

private function_a27b7fcf() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_aefef9ae;
}

private function_aefef9ae(entity) {
  entity.__blackboard = undefined;
  entity function_a27b7fcf();

  if(isDefined(entity.var_506922ab)) {
    foreach(callback in entity.var_506922ab) {
      [
        [callback]
      ](entity);
    }
  }
}

private registerbehaviorscriptfunctions() {}

spawnblightfather(spawner, location) {
  spawner.script_forcespawn = 1;
  entity = zombie_utility::spawn_zombie(spawner, undefined, location);

  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(location.angles)) {
    angles = (0, 0, 0);
  } else {
    angles = location.angles;
  }

  entity forceteleport(location.origin, angles);
  return entity;
}

private function_ac921de9(entity) {
  entity melee();
}

function_3e8300e9(entity, attribute, oldvalue, value) {
  if(isDefined(entity.var_80cf70fb)) {
    entity[[entity.var_80cf70fb]](entity, attribute, oldvalue, value);
  }
}

function_b95978a7(entity, attribute, oldvalue, value) {
  if(isDefined(entity.var_11a49434)) {
    entity[[entity.var_11a49434]](entity, attribute, oldvalue, value);
  }
}