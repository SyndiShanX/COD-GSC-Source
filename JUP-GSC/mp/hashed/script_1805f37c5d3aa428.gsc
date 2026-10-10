/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1805f37c5d3aa428.gsc
*************************************************/

#using script_550dd7ffd47d264c;
#using script_6a1593331aebf847;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_spawner_zombie_abom_s3_rr_unlock;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_spawner_zombie_abom_s3_rr_unlock");
  self.var_534e788bc498be9f = getscriptbundle(%"hash_1b4e3639bb9eee21");
  self.subclass = self.var_534e788bc498be9f.name;
  self.health = 1000;
  self.maxhealth = 1000;
  self.behaviortreeasset = "zombie_abom";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "zombie_abom";
  self.ai_eventlist = % "hash_3664c8ba706ec788";
  self.zombieaisetting = "settings_zombie_abom_mega";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_zombie_abom_mega");
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
  return namespace_f14ed9739ed41d26::main();
}

function precache() {
  agent_type = "actor_jup_spawner_zombie_abom_s3_rr_unlock";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_1b4e3639bb9eee21");
    namespace_f14ed9739ed41d26::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::zombie();
  params = spawnStruct();
  params.aisettingsbundle = "aisettings_zombie_abom_mega";
  params.zombieaisetting = "settings_zombie_abom_mega";
  namespace_d2273ed91d2b732b::precache(params);
}