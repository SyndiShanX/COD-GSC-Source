/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f0ca2f3ed054b8c.gsc
*************************************************/

#using script_6c6bd2de46dc565a;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\aitypes\zombie_mangler\zombie_mangler;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_spawner_zombie_mangler_s3_rr;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_spawner_zombie_mangler_s3_rr");
  self.subclass_scriptbundle = getscriptbundle(%"hash_37858f22db3f89aa");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 2750;
  self.maxhealth = 2750;
  self.behaviortreeasset = "zombie_mangler";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "zombie_mangler";
  self.ai_eventlist = % "hash_3664c8ba706ec788";
  self.zombieaisetting = "settings_zombie_mangler_s3_rr";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_zombie_mangler");
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
  return namespace_52869a5b5415a5a8::main();
}

function precache() {
  agent_type = "actor_jup_spawner_zombie_mangler_s3_rr";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_37858f22db3f89aa");
    namespace_52869a5b5415a5a8::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::zombie();
  params = spawnStruct();
  params.aisettingsbundle = "aisettings_zombie_mangler";
  params.zombieaisetting = "settings_zombie_mangler_s3_rr";
  scripts\aitypes\zombie_mangler\zombie_mangler::precache(params);
}