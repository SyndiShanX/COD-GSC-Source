/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_stoker.gsc
***********************************************/

#include scripts\core_common\ai\archetype_stoker_interface;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\spawner_shared;

#namespace archetype_stoker;

autoexec init_shared() {
  if(isDefined(level.stokerinit)) {
    return;
  }

  level.stokerinit = 1;
  function_3f70d4b7();
  spawner::add_archetype_spawn_function(#"stoker", &function_d30d1f3);
  stokerinterface::registerstokerinterfaceattributes();
}

private function_3f70d4b7() {}

private function_d30d1f3() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_236d6de;
}

private function_236d6de(entity) {
  entity.__blackboard = undefined;
  entity function_d30d1f3();
}

function_e4ef4e27(entity, attribute, oldvalue, value) {
  if(isDefined(entity.var_80cf70fb)) {
    entity[[entity.var_80cf70fb]](entity, attribute, oldvalue, value);
  }
}