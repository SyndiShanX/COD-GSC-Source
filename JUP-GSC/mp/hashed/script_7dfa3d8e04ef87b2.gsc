/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7dfa3d8e04ef87b2.gsc
*************************************************/

#using script_b2b16bdc717885e;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;
#namespace jup_ob_enemy_specialist_rook;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_enemy_specialist_rook");
  self.subclass_scriptbundle = getscriptbundle(%"hash_76c13a964f5f670");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 600;
  self.maxhealth = 600;
  self.behaviortreeasset = "soldier_jup_ob";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_soldier_base_ob");

  switch (scripts\code\character::get_random_weapon(2)) {
    case 0:
      primaryweaponhash = "iw9_sn_mromeo, [ stock_sn_tactical_p21, laserbox_hip01 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 1:
      primaryweaponhash = "iw9_dm_xmike2010, [ bar_sn_heavy_p20_xmike2010, laserbox_hip03 ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  sidearmweaponhash = "iw9_pi_swhiskey, [ none, none, none, none, none, none ], none, none";
  self.sidearm = level.var_67b54180a55f70e1[sidearmweaponhash];
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
  return namespace_f327d0081e3ab180::main();
}

function precache() {
  agent_type = "actor_jup_ob_enemy_specialist_rook";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_76c13a964f5f670");
    namespace_f327d0081e3ab180::precache_cpmp();
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

  var_5576d3be590a9a64 = "iw9_sn_mromeo, [ stock_sn_tactical_p21, laserbox_hip01 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d3be590a9a64])) {
    level.var_67b54180a55f70e1[var_5576d3be590a9a64] = scripts\mp\class::function_e83615f8a92e4378("iw9_sn_mromeo", ["stock_sn_tactical_p21", "laserbox_hip01"], "none", "none");
  }

  var_5576d6be590aa0fd = "iw9_dm_xmike2010, [ bar_sn_heavy_p20_xmike2010, laserbox_hip03 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d6be590aa0fd])) {
    level.var_67b54180a55f70e1[var_5576d6be590aa0fd] = scripts\mp\class::function_e83615f8a92e4378("iw9_dm_xmike2010", ["bar_sn_heavy_p20_xmike2010", "laserbox_hip03"], "none", "none");
  }

  sidearmweaponhash = "iw9_pi_swhiskey, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[sidearmweaponhash])) {
    level.var_67b54180a55f70e1[sidearmweaponhash] = scripts\mp\class::function_e83615f8a92e4378("iw9_pi_swhiskey", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }
}