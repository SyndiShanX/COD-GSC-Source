/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_26cd04df32f6537a.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#namespace namespace_5df129e7;

function autoexec init() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"tormentor", &function_d0439ae2);
  spawner::add_archetype_spawn_function(#"tormentor", &zombie_utility::zombiespawnsetup);
  spawner::function_89a2cd87(#"tormentor", &function_bac4724a);
}

function private function_d0439ae2() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_71825c43;
  self.zombie_think_done = 1;
}

function private function_71825c43(entity) {
  entity.__blackboard = undefined;
  entity function_d0439ae2();
}

function function_9668f61f() {
  self.stumble = 0;
  self.var_b1c7a59d = gettime();
  self.var_eabe8c08 = gettime();
  self.var_4db55459 = 0;
  self.var_8198a38c = 30;
  self.var_b91eb4e5 = 15;
}

function function_bac4724a() {
  function_9668f61f();
  namespace_81245006::initweakpoints(self);
  self callback::function_d8abfc3d(#"on_ai_killed", &function_c24ab28e);
  self.should_zigzag = 0;
}

function private function_c24ab28e(params) {
  self.takedamage = 0;
}

function private registerbehaviorscriptfunctions() {}