/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6456347835dc8d57.gsc
*************************************************/

#using character\c_jup_sp_enemy_pmc_capt_01;
#using character\c_jup_sp_enemy_pmc_capt_02;
#using character\c_jup_sp_enemy_pmc_hvytac_01;
#using character\c_jup_sp_enemy_pmc_hvytac_02;
#using character\c_jup_sp_enemy_pmc_spforce_01;
#using character\c_jup_sp_enemy_pmc_spforce_02;
#using character\c_jup_sp_enemy_pmc_spforce_03;
#using character\c_jup_sp_enemy_pmc_spforce_04;
#using script_403097a9b8da5e0b;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp\cp_weapon;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_enemy_cp_shotgun_tier3_rus_pmc;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_enemy_cp_shotgun_tier3_rus_pmc");
  self.subclass_scriptbundle = getscriptbundle(%"hash_d4c1580d6bc10b4");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 150;
  self.maxhealth = 150;
  self.behaviortreeasset = "soldier_agent";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  primaryweaponhash = "iw9_sh_mike1014_mp, [ bar_sh_heavy_p12, stock_sh_light_p12, flash_sh_01 ], none, none";
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
      return character\c_jup_sp_enemy_pmc_hvytac_01::main();
    case 1:
      return character\c_jup_sp_enemy_pmc_hvytac_02::main();
    case 2:
      return character\c_jup_sp_enemy_pmc_capt_01::main();
    case 3:
      return character\c_jup_sp_enemy_pmc_capt_02::main();
    case 4:
      return character\c_jup_sp_enemy_pmc_spforce_01::main();
    case 5:
      return character\c_jup_sp_enemy_pmc_spforce_02::main();
    case 6:
      return character\c_jup_sp_enemy_pmc_spforce_03::main();
    case 7:
      return character\c_jup_sp_enemy_pmc_spforce_04::main();
    case 8:
      return namespace_dcd14716d043ae51::main();
  }
}

function precache() {
  agent_type = "actor_jup_enemy_cp_shotgun_tier3_rus_pmc";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_d4c1580d6bc10b4");
    character\c_jup_sp_enemy_pmc_hvytac_01::precache_cpmp();
    character\c_jup_sp_enemy_pmc_hvytac_02::precache_cpmp();
    character\c_jup_sp_enemy_pmc_capt_01::precache_cpmp();
    character\c_jup_sp_enemy_pmc_capt_02::precache_cpmp();
    character\c_jup_sp_enemy_pmc_spforce_01::precache_cpmp();
    character\c_jup_sp_enemy_pmc_spforce_02::precache_cpmp();
    character\c_jup_sp_enemy_pmc_spforce_03::precache_cpmp();
    character\c_jup_sp_enemy_pmc_spforce_04::precache_cpmp();
    namespace_dcd14716d043ae51::precache_cpmp();
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

  primaryweaponhash = "iw9_sh_mike1014_mp, [ bar_sh_heavy_p12, stock_sh_light_p12, flash_sh_01 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_sh_mike1014_mp", ["bar_sh_heavy_p12", "stock_sh_light_p12", "flash_sh_01"], "none", "none");
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