/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1be4ea1c9a31affb.gsc
*************************************************/

#using script_154c8e0f0c53a024;
#using script_51850e194d55b71a;
#using script_60697709c8bd04cb;
#using script_617a12fe4e2213f0;
#using script_65e7570ed0fea149;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_civilian_cp_male;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_civilian_cp_male");
  self.health = 30;
  self.maxhealth = 30;
  self.behaviortreeasset = "civilian_livingworld";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "civilian_react";
  self.weapon = nullweapon();
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
  setup_model();
  assert(isscriptedagent(self));
  assert(isDefined(self.behaviortreeasset));
  assert(isDefined(self.asmasset));
  self.defaultasm = self.asmasset;
  self.a = spawnStruct();
  scripts\asm\asm::asm_init_blackboard();
  scripts\aitypes\bt_util::bt_init();
  scripts\asm\asm_mp::asm_init(self.asmasset, self.animationarchetype);
  scripts\common\ai::ai_init();
}

function setup_model() {
  var_42e5c77b1d7fe6e7 = isDefined(self.var_42e5c77b1d7fe6e7) ? self.var_42e5c77b1d7fe6e7 : "default";

  switch (var_42e5c77b1d7fe6e7) {
    case #"hash_7038dec66d8275be":
    default:
      function_9ac26a51c94ccf52();
      break;
  }
}

function function_9ac26a51c94ccf52() {
  assertex(isDefined(self.var_e2682e6f1838391e), "self.characterSelectionIndex has not been set, it should have been set in Agent_spawn() for mp and Initspawn() in SP in code");

  switch (self.var_e2682e6f1838391e) {
    case 0:
      return namespace_e0af609dc8acb230::main();
    case 1:
      return namespace_e0af639dc8acb8c9::main();
    case 2:
      return namespace_e0af629dc8acb696::main();
    case 3:
      return namespace_e0af659dc8acbd2f::main();
    case 4:
      return namespace_e0af649dc8acbafc::main();
  }
}

function precache() {
  agent_type = "actor_jup_civilian_cp_male";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "neutral";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    namespace_e0af609dc8acb230::precache_cpmp();
    namespace_e0af639dc8acb8c9::precache_cpmp();
    namespace_e0af629dc8acb696::precache_cpmp();
    namespace_e0af659dc8acbd2f::precache_cpmp();
    namespace_e0af649dc8acbafc::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}