/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_591b348001300408.gsc
*************************************************/

#using character\c_jup_sp_enemy_pmc_juggernaut_02;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp\cp_weapon;
#using scripts\cp_mp\agents\agent_init;
#namespace jup_enemy_cp_jugg_rus_pmc;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_enemy_cp_jugg_rus_pmc");
  self.subclass_scriptbundle = getscriptbundle(%"hash_5dfdbb9fba045d33");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 3000;
  self.maxhealth = 3000;
  self.behaviortreeasset = "juggernaut_agent";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  primaryweaponhash = "iw9_lm_dblmg_mp, [ none, none, none, none, none, none ], none, none";
  self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  grenadeweaponhash = "frag";
  self.grenadeweapon = level.var_67b54180a55f70e1[grenadeweaponhash];
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
  return character\c_jup_sp_enemy_pmc_juggernaut_02::main();
}

function precache() {
  agent_type = "actor_jup_enemy_cp_jugg_rus_pmc";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_5dfdbb9fba045d33");
    character\c_jup_sp_enemy_pmc_juggernaut_02::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::juggernaut();
  thread setup_weapons();
}

function setup_weapons() {
  while(!isDefined(level.weaponmapdata)) {
    waitframe();
  }

  if(!isDefined(level.var_67b54180a55f70e1)) {
    level.var_67b54180a55f70e1 = [];
  }

  primaryweaponhash = "iw9_lm_dblmg_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_lm_dblmg_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  grenadeweaponhash = "frag";

  if(!isDefined(level.var_67b54180a55f70e1[grenadeweaponhash])) {
    level.var_67b54180a55f70e1[grenadeweaponhash] = makeweapon("frag");
  }
}