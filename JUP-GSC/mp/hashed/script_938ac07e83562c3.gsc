/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_938ac07e83562c3.gsc
************************************************/

#using script_23e4bed47408a4d;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;
#namespace jup_ob_enemy_specialist_shielded;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_enemy_specialist_shielded");
  self.var_534e788bc498be9f = getscriptbundle(%"hash_e5c359d7fd97ec3");
  self.subclass = self.var_534e788bc498be9f.name;
  self.health = 300;
  self.maxhealth = 300;
  self.behaviortreeasset = "riotshield_jup_ob";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_soldier_base_ob");

  switch (scripts\code\character::get_random_weapon(2)) {
    case 0:
      primaryweaponhash = "jup_jp14_pi_rsierra12, [ jup_jp14_pi_rsierra12_speedloader_5_12, jup_minireddot01_pstl ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 1:
      primaryweaponhash = "iw9_pi_swhiskey, [ speedloader_hvy_p26, iw9_minireddot01 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 2;
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
  return namespace_2cd996856f5e777::main();
}

function precache() {
  agent_type = "actor_jup_ob_enemy_specialist_shielded";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_e5c359d7fd97ec3");
    namespace_2cd996856f5e777::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  thread setup_weapons();
}

function setup_weapons() {
  while(!isDefined(level.weaponmapdata)) {
    waitframe();
  }

  if(!isDefined(level.var_67b54180a55f70e1)) {
    level.var_67b54180a55f70e1 = [];
  }

  var_5576d3be590a9a64 = "jup_jp14_pi_rsierra12, [ jup_jp14_pi_rsierra12_speedloader_5_12, jup_minireddot01_pstl ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d3be590a9a64])) {
    level.var_67b54180a55f70e1[var_5576d3be590a9a64] = scripts\mp\class::function_e83615f8a92e4378("jup_jp14_pi_rsierra12", ["jup_jp14_pi_rsierra12_speedloader_5_12", "jup_minireddot01_pstl"], "none", "none");
  }

  var_5576d6be590aa0fd = "iw9_pi_swhiskey, [ speedloader_hvy_p26, iw9_minireddot01 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d6be590aa0fd])) {
    level.var_67b54180a55f70e1[var_5576d6be590aa0fd] = scripts\mp\class::function_e83615f8a92e4378("iw9_pi_swhiskey", ["speedloader_hvy_p26", "iw9_minireddot01"], "none", "none");
  }
}