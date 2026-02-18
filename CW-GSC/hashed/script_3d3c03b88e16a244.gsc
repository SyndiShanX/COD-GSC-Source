/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3d3c03b88e16a244.gsc
***********************************************/

#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\spawner_shared;
#namespace namespace_baa4b777;

function autoexec init() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_f9fa2bbb);
}

function private function_acf96b05() {
  assert(isDefined(self.ai));
}

function private function_f9fa2bbb() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_b8053d02;
  self.___archetypeonbehavecallback = &function_2c84ab00;
  self.var_7401c936 = &function_580889d1;
}

function private function_580889d1(entity) {
  function_fa765ef3();
}

function private function_2c84ab00(entity) {
  function_fa765ef3();
}

function private function_b8053d02(entity) {
  self.__blackboard = undefined;
  self function_f9fa2bbb();
}

function private registerbehaviorscriptfunctions() {}

function private function_fa765ef3() {
  if(is_true(self.is_companion)) {
    self.pushable = 0;
  }
}

function private function_ee21651d(message) {
  if(getdvarint(#"hash_71bbda417e2a07e9", 0)) {
    println("<dev string:x38>" + message);
  }
}