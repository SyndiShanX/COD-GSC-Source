/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3f960271e3ea05fc.gsc
*************************************************/

#using character\c_jup_sp_enemy_pmc_jumper_01;
#using character\c_jup_sp_enemy_pmc_jumper_02;
#using character\c_jup_sp_enemy_pmc_jumper_03;
#using script_2c51510e7ad08abd;
#using script_41b8c4e8b8f5a09b;
#using script_4bb6de05ff6b70b4;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\cp\cp_weapon;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_enemy_cp_ar_tier3_rus_pmc_konni_elite;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_enemy_cp_ar_tier3_rus_pmc_konni_elite");
  self.var_534e788bc498be9f = getscriptbundle(%"hash_d4c1580d6bc10b4");
  self.subclass = self.var_534e788bc498be9f.name;
  self.health = 150;
  self.maxhealth = 150;
  self.behaviortreeasset = "soldier_agent";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "soldier";

  switch (scripts\code\character::get_random_weapon(5)) {
    case 0:
      primaryweaponhash = "iw9_ar_akilo105_mp, [ reflex06_tall, bar_ar_hvyshort_p04_akilo105, comp_ar_01 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 1:
      primaryweaponhash = "jup_jp01_ar_golf36_mp, [ jup_twofivex_golf36, jup_jp01_ar_golf36_mag_40_556n, jup_jp01_ar_golf36_stock_tac ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 2:
      primaryweaponhash = "iw9_ar_akilo105_mp, [ reflex03_tall, mag_ar_lgtlarge_p04_akilo105, stock_ar_light_p04_akilo105 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 3:
      primaryweaponhash = "iw9_ar_akilo_mp, [ iw9_minireddot04_tall, grip_angled01, stock_ar_tactical_p04_akilo ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 4:
      primaryweaponhash = "iw9_ar_akilo105_mp, [ iw9_minireddot02_tall, mag_ar_lgtlarge_p04_akilo105, bar_ar_heavy_p04_akilo105 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  var_4f04b9c326eb7400 = "jup_cp24_pi_glima21_mp, [ none, none, none, none, none, none ], none, none";
  self.sidearm = level.var_67b54180a55f70e1[var_4f04b9c326eb7400];
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
      return namespace_6356fae00c955ca3::main();
    case 1:
      return namespace_6356fbe00c955ed6::main();
    case 2:
      return character\c_jup_sp_enemy_pmc_jumper_01::main();
    case 3:
      return character\c_jup_sp_enemy_pmc_jumper_02::main();
    case 4:
      return namespace_6356fce00c956109::main();
    case 5:
      return character\c_jup_sp_enemy_pmc_jumper_03::main();
  }
}

function precache() {
  agent_type = "actor_jup_enemy_cp_ar_tier3_rus_pmc_konni_elite";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_d4c1580d6bc10b4");
    namespace_6356fae00c955ca3::precache_cpmp();
    namespace_6356fbe00c955ed6::precache_cpmp();
    character\c_jup_sp_enemy_pmc_jumper_01::precache_cpmp();
    character\c_jup_sp_enemy_pmc_jumper_02::precache_cpmp();
    namespace_6356fce00c956109::precache_cpmp();
    character\c_jup_sp_enemy_pmc_jumper_03::precache_cpmp();
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

  var_5576d3be590a9a64 = "iw9_ar_akilo105_mp, [ reflex06_tall, bar_ar_hvyshort_p04_akilo105, comp_ar_01 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d3be590a9a64])) {
    level.var_67b54180a55f70e1[var_5576d3be590a9a64] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_ar_akilo105_mp", ["reflex06_tall", "bar_ar_hvyshort_p04_akilo105", "comp_ar_01"], "none", "none");
  }

  var_5576d6be590aa0fd = "jup_jp01_ar_golf36_mp, [ jup_twofivex_golf36, jup_jp01_ar_golf36_mag_40_556n, jup_jp01_ar_golf36_stock_tac ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d6be590aa0fd])) {
    level.var_67b54180a55f70e1[var_5576d6be590aa0fd] = scripts\cp\cp_weapon::function_e83615f8a92e4378("jup_jp01_ar_golf36_mp", ["jup_twofivex_golf36", "jup_jp01_ar_golf36_mag_40_556n", "jup_jp01_ar_golf36_stock_tac"], "none", "none");
  }

  var_5576d5be590a9eca = "iw9_ar_akilo105_mp, [ reflex03_tall, mag_ar_lgtlarge_p04_akilo105, stock_ar_light_p04_akilo105 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d5be590a9eca])) {
    level.var_67b54180a55f70e1[var_5576d5be590a9eca] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_ar_akilo105_mp", ["reflex03_tall", "mag_ar_lgtlarge_p04_akilo105", "stock_ar_light_p04_akilo105"], "none", "none");
  }

  var_5576d0be590a93cb = "iw9_ar_akilo_mp, [ iw9_minireddot04_tall, grip_angled01, stock_ar_tactical_p04_akilo ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d0be590a93cb])) {
    level.var_67b54180a55f70e1[var_5576d0be590a93cb] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_ar_akilo_mp", ["iw9_minireddot04_tall", "grip_angled01", "stock_ar_tactical_p04_akilo"], "none", "none");
  }

  var_5576cfbe590a9198 = "iw9_ar_akilo105_mp, [ iw9_minireddot02_tall, mag_ar_lgtlarge_p04_akilo105, bar_ar_heavy_p04_akilo105 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576cfbe590a9198])) {
    level.var_67b54180a55f70e1[var_5576cfbe590a9198] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_ar_akilo105_mp", ["iw9_minireddot02_tall", "mag_ar_lgtlarge_p04_akilo105", "bar_ar_heavy_p04_akilo105"], "none", "none");
  }

  var_4f04b9c326eb7400 = "jup_cp24_pi_glima21_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_4f04b9c326eb7400])) {
    level.var_67b54180a55f70e1[var_4f04b9c326eb7400] = scripts\cp\cp_weapon::function_e83615f8a92e4378("jup_cp24_pi_glima21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  grenadeweaponhash = "frag_grenade_mp";

  if(!isDefined(level.var_67b54180a55f70e1[grenadeweaponhash])) {
    level.var_67b54180a55f70e1[grenadeweaponhash] = makeweapon("frag_grenade_mp");
  }
}