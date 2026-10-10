/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_63af4e34e2e48043.gsc
*************************************************/

#using character\c_jup_sp_enemy_pmc_soldier_05_alt1;
#using character\c_jup_sp_enemy_pmc_soldier_05_alt2;
#using character\c_jup_sp_enemy_pmc_soldier_05_alt3;
#using character\c_jup_sp_enemy_pmc_soldier_05_masked;
#using script_7d70015cd886923;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;
#namespace jup_ob_enemy_basic_soldier_short;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_enemy_basic_soldier_short");
  self.var_534e788bc498be9f = getscriptbundle(%"hash_42cf9952fc9aab5b");
  self.subclass = self.var_534e788bc498be9f.name;
  self.health = 300;
  self.maxhealth = 300;
  self.behaviortreeasset = "soldier_jup_ob";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_soldier_base_ob");

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      primaryweaponhash = "jup_cp01_sm_coscar635, [ jup_comp_sm_08 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 1:
      primaryweaponhash = "iw9_sm_apapa, [ iw9_minireddot06_tall ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 2:
      primaryweaponhash = "iw9_sh_mviktor, [ grip_angled02 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  grenadeweaponhash = "jup_frag_grenade_ob";
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
  var_42e5c77b1d7fe6e7 = isDefined(self.var_42e5c77b1d7fe6e7) ? self.var_42e5c77b1d7fe6e7 : "default";

  switch (var_42e5c77b1d7fe6e7) {
    case #"hash_7038dec66d8275be":
    default:
      function_9ac26a51c94ccf52();
      break;
  }
}

function function_9ac26a51c94ccf52() {
  assertex(isDefined(self.var_e2682e6f1838391e), "<dev string:x1c>");

  switch (self.var_e2682e6f1838391e) {
    case 0:
      return namespace_d1e0edf5961faf67::main();
    case 1:
      return character\c_jup_sp_enemy_pmc_soldier_05_alt1::main();
    case 2:
      return character\c_jup_sp_enemy_pmc_soldier_05_alt2::main();
    case 3:
      return character\c_jup_sp_enemy_pmc_soldier_05_alt3::main();
    case 4:
      return character\c_jup_sp_enemy_pmc_soldier_05_masked::main();
  }
}

function precache() {
  agent_type = "actor_jup_ob_enemy_basic_soldier_short";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_42cf9952fc9aab5b");
    namespace_d1e0edf5961faf67::precache_cpmp();
    character\c_jup_sp_enemy_pmc_soldier_05_alt1::precache_cpmp();
    character\c_jup_sp_enemy_pmc_soldier_05_alt2::precache_cpmp();
    character\c_jup_sp_enemy_pmc_soldier_05_alt3::precache_cpmp();
    character\c_jup_sp_enemy_pmc_soldier_05_masked::precache_cpmp();
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

  var_5576d3be590a9a64 = "jup_cp01_sm_coscar635, [ jup_comp_sm_08 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d3be590a9a64])) {
    level.var_67b54180a55f70e1[var_5576d3be590a9a64] = scripts\mp\class::function_e83615f8a92e4378("jup_cp01_sm_coscar635", ["jup_comp_sm_08"], "none", "none");
  }

  var_5576d6be590aa0fd = "iw9_sm_apapa, [ iw9_minireddot06_tall ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d6be590aa0fd])) {
    level.var_67b54180a55f70e1[var_5576d6be590aa0fd] = scripts\mp\class::function_e83615f8a92e4378("iw9_sm_apapa", ["iw9_minireddot06_tall"], "none", "none");
  }

  var_5576d5be590a9eca = "iw9_sh_mviktor, [ grip_angled02 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d5be590a9eca])) {
    level.var_67b54180a55f70e1[var_5576d5be590a9eca] = scripts\mp\class::function_e83615f8a92e4378("iw9_sh_mviktor", ["grip_angled02"], "none", "none");
  }

  grenadeweaponhash = "jup_frag_grenade_ob";

  if(!isDefined(level.var_67b54180a55f70e1[grenadeweaponhash])) {
    level.var_67b54180a55f70e1[grenadeweaponhash] = makeweapon("jup_frag_grenade_ob");
  }
}