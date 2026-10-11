/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_35a26597736ebcb0.gsc
*************************************************/

#using script_215fca4861459153;
#using script_237703888a7f0623;
#using script_29dd4ac50b1402a3;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_spawner_zombie_entity_rr;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_spawner_zombie_entity_rr");
  self.subclass_scriptbundle = getscriptbundle(%"hash_275f30cf9ec5110a");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 900;
  self.maxhealth = 900;
  self.behaviortreeasset = "zombie_entity";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "zombie_entity";
  self.ai_eventlist = % "hash_3664c8ba706ec788";
  self.zombieaisetting = "settings_zombie_entity_rr";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_zombie_entity");
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
  characterlistname = isDefined(self.characterlistname) ? self.characterlistname : "default";

  switch (characterlistname) {
    case #"hash_7038dec66d8275be":
    default:
      function_9ac26a51c94ccf52();
      break;
  }
}

function function_9ac26a51c94ccf52() {
  return namespace_cfa3fb38eb4bf04f::main();
}

function precache() {
  agent_type = "actor_jup_spawner_zombie_entity_rr";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_275f30cf9ec5110a");
    namespace_cfa3fb38eb4bf04f::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::zombie();
  params = spawnStruct();
  params.aisettingsbundle = "aisettings_zombie_entity";
  params.zombieaisetting = "settings_zombie_entity_rr";
  namespace_39c7d29122ccedd3::precache(params);
  namespace_52a1f7dbceafbc17::function_5d77186204f35fd5();
}