/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4d4af1928bf710a3.gsc
*************************************************/

#using script_30a7bba69ce5f369;
#using script_515285d5287575ff;
#using script_54275a8be95c832;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;
#namespace jup_spawner_zombie_mimic_hvt_spatial;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_spawner_zombie_mimic_hvt_spatial");
  self.subclass_scriptbundle = getscriptbundle(%"hash_79078c489b5dc6ce");
  self.subclass = self.subclass_scriptbundle.name;
  self.nameindex = randomintrange(1, 2);
  self.health = 8775;
  self.maxhealth = 8775;
  self.behaviortreeasset = "zombie_mimic";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "zombie_mimic";
  self.ai_eventlist = % "hash_3664c8ba706ec788";
  self.zombieaisetting = "settings_zombie_mimic_hvt";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_zombie_mimic_hvt");
  primaryweaponhash = "jup_me_zombie_mimic, [ none, none, none, none, none, none ], none, none";
  self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  grenadeweaponhash = "jup_zombie_mimic_ranged_attack_mp";
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
  return namespace_95d5cbb54220c81c::main();
}

function precache() {
  agent_type = "actor_jup_spawner_zombie_mimic_hvt_spatial";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_79078c489b5dc6ce");
    namespace_95d5cbb54220c81c::precache_cpmp();
  }

  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::zombie();
  params = spawnStruct();
  params.aisettingsbundle = "aisettings_zombie_mimic_hvt";
  params.zombieaisetting = "settings_zombie_mimic_hvt";
  namespace_99e25c27505b58fd::precache(params);
  namespace_d7b9f3d899c5a909::function_6c78c4cdcb9d493();
  thread setup_weapons();
}

function setup_weapons() {
  while(!isDefined(level.weaponmapdata)) {
    waitframe();
  }

  if(!isDefined(level.var_67b54180a55f70e1)) {
    level.var_67b54180a55f70e1 = [];
  }

  primaryweaponhash = "jup_me_zombie_mimic, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\mp\class::function_e83615f8a92e4378("jup_me_zombie_mimic", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  grenadeweaponhash = "jup_zombie_mimic_ranged_attack_mp";

  if(!isDefined(level.var_67b54180a55f70e1[grenadeweaponhash])) {
    level.var_67b54180a55f70e1[grenadeweaponhash] = makeweapon("jup_zombie_mimic_ranged_attack_mp");
  }
}