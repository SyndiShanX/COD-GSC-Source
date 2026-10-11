/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3e7c520d4bbc46a4.gsc
*************************************************/

#using script_1ec34b7d5bbf4b33;
#using script_250459fe0ba514b5;
#using script_2f1d631b52319156;
#using script_3204b767b1313d68;
#using script_39ed2c8264bccc26;
#using script_b42520228d91bb3;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp\cp_weapon;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_enemy_cp_shotgun_tier1_security;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_enemy_cp_shotgun_tier1_security");
  self.subclass_scriptbundle = getscriptbundle(%"hash_d4c1780d6bc141a");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 150;
  self.maxhealth = 150;
  self.behaviortreeasset = "soldier_agent";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  primaryweaponhash = "iw9_sh_mbravo_mp, [ none, none, none, none, none, none ], none, none";
  self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  sidearmweaponhash = "jup_cp24_pi_glima21_mp, [ none, none, none, none, none, none ], none, none";
  self.sidearm = level.var_67b54180a55f70e1[sidearmweaponhash];
  grenadeweaponhash = "frag_grenade_mp";
  self.grenadeweapon = level.var_67b54180a55f70e1[grenadeweaponhash];
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
  characterlistname = isDefined(self.characterlistname) ? self.characterlistname : "default";

  switch (characterlistname) {
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
      return namespace_29da5af630d3613::main();
    case 1:
      return namespace_cde9d2b6d60ebcb6::main();
    case 2:
      return namespace_29da6af630d3846::main();
    case 3:
      return namespace_cdedbab6d6127dc5::main();
    case 4:
      return namespace_29da7af630d3a79::main();
    case 5:
      return namespace_cdf1deb6d616c2c8::main();
  }
}

function precache() {
  agent_type = "actor_jup_enemy_cp_shotgun_tier1_security";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_d4c1780d6bc141a");
    namespace_29da5af630d3613::precache_cpmp();
    namespace_cde9d2b6d60ebcb6::precache_cpmp();
    namespace_29da6af630d3846::precache_cpmp();
    namespace_cdedbab6d6127dc5::precache_cpmp();
    namespace_29da7af630d3a79::precache_cpmp();
    namespace_cdf1deb6d616c2c8::precache_cpmp();
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

  primaryweaponhash = "iw9_sh_mbravo_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_sh_mbravo_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  sidearmweaponhash = "jup_cp24_pi_glima21_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[sidearmweaponhash])) {
    level.var_67b54180a55f70e1[sidearmweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("jup_cp24_pi_glima21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  grenadeweaponhash = "frag_grenade_mp";

  if(!isDefined(level.var_67b54180a55f70e1[grenadeweaponhash])) {
    level.var_67b54180a55f70e1[grenadeweaponhash] = makeweapon("frag_grenade_mp");
  }
}