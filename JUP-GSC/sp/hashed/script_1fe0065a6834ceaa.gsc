/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1fe0065a6834ceaa.gsc
*************************************************/

#using script_4d7871af27cfac06;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp\cp_weapon;
#using scripts\cp_mp\agents\agent_init;
#namespace namespace_9f888aacaf04f603;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ally_hero_soap_diver_land_cp");
  self.health = 150;
  self.maxhealth = 150;
  self.behaviortreeasset = "soldier_agent";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  primaryweaponhash = "iw9_dm_mike14_mp, [ none, none, none, none, none, none ], none, none";
  self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  sidearmweaponhash = "iw9_pi_golf17_mp, [ none, none, none, none, none, none ], none, none";
  self.sidearm = level.var_67b54180a55f70e1[sidearmweaponhash];
  grenadeweaponhash = "frag";
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
  return namespace_3fbb743aaeba28f2::main();
}

function precache() {
  agent_type = "actor_jup_ally_hero_soap_diver_land_cp";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "allies";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    namespace_3fbb743aaeba28f2::precache_cpmp();
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

  primaryweaponhash = "iw9_dm_mike14_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_dm_mike14_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  sidearmweaponhash = "iw9_pi_golf17_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[sidearmweaponhash])) {
    level.var_67b54180a55f70e1[sidearmweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_pi_golf17_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  grenadeweaponhash = "frag";

  if(!isDefined(level.var_67b54180a55f70e1[grenadeweaponhash])) {
    level.var_67b54180a55f70e1[grenadeweaponhash] = makeweapon("frag");
  }
}