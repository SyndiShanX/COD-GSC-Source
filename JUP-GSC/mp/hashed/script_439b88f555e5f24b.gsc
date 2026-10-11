/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_439b88f555e5f24b.gsc
*************************************************/

#using script_6c63dbe7d4c85e19;
#using script_73e0386c8c940bfb;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_spawner_zombie_deathworm_quest_s1;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_spawner_zombie_deathworm_quest_s1");
  self.subclass_scriptbundle = getscriptbundle(%"hash_796e15528ece3777");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 1000;
  self.maxhealth = 1000;
  self.behaviortreeasset = "zombie_deathworm";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "zombie_deathworm";
  self.ai_eventlist = % "hash_3664c8ba706ec788";
  self.zombieaisetting = "settings_zombie_deathworm_quest_s1";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_zombie_deathworm");
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
  return namespace_8f265b90abfeff0d::main();
}

function precache() {
  agent_type = "actor_jup_spawner_zombie_deathworm_quest_s1";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_796e15528ece3777");
    namespace_8f265b90abfeff0d::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::zombie();
  params = spawnStruct();
  params.aisettingsbundle = "aisettings_zombie_deathworm";
  params.zombieaisetting = "settings_zombie_deathworm_quest_s1";
  namespace_d4f42bca9e290185::precache(params);
}