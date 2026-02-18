/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_brutus.gsc
***********************************************/

#using scripts\core_common\ai\archetype_brutus_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\spawner_shared;
#namespace archetypebrutus;

function autoexec init() {
  brutusinterface::registerbrutusinterfaceattributes();
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"brutus", &function_517fd069);
}

function private function_651f04c3() {
  assert(isDefined(self.ai));
}

function private function_517fd069() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_666b2409;
  self.___archetypeonbehavecallback = &function_3cdbfffd;
}

function private function_3cdbfffd(entity) {}

function private function_666b2409(entity) {
  self.__blackboard = undefined;
  self function_517fd069();
}

function private registerbehaviorscriptfunctions() {}

function private function_f9f08bb1(message) {
  if(getdvarint(#"scr_brutusdebug", 0)) {
    println("<dev string:x38>" + message);
  }
}

function function_f8aa76ea(entity, attribute, oldvalue, value) {
  if(value) {
    oldvalue function_d4c687c9();
  }
}