/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_nova_crawler.gsc
*****************************************************/

#include scripts\core_common\ai\archetype_nova_crawler_interface;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\spawner_shared;

#namespace archetypenovacrawler;

autoexec init() {
  novacrawlerinterface::registernovacrawlerinterfaceattributes();
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"nova_crawler", &function_ea4610a7);
}

private function_32107b12() {
  assert(isDefined(self.ai));
}

private function_ea4610a7() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_80f18700;
  self.___archetypeonbehavecallback = &function_b11c2bcd;
}

private function_b11c2bcd(entity) {}

private function_80f18700(entity) {
  self.__blackboard = undefined;
  self function_ea4610a7();
}

private registerbehaviorscriptfunctions() {}

private function_3d50e4d0(message) {
  if(getdvarint(#"hash_35bebcc5f50d2641", 0)) {
    println("<dev string:x38>" + message);
  }
}

