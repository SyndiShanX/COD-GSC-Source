/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_77a720f9c1c9fe01.gsc
*************************************************/

#using script_461ed75f5eedbdf3;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;
#namespace jup_ob_warlord_maestro;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_warlord_maestro");
  self.subclass_scriptbundle = getscriptbundle(%"hash_48b9aea3f0fc9faa");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 2880;
  self.maxhealth = 2880;
  self.behaviortreeasset = "soldier_agent";
  self.aishootstyle = "ai_shoot_styles_single";
  self.asmasset = "soldier";
  self.zombieaisetting = "settings_warlord_maestro";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_warlord_base");
  primaryweaponhash = "jup_jp02_br_bromeo2, [ holotherm01, jup_jp02_br_bromeo2_bar_heavy_long, jup_jp02_br_bromeo2_stock_heavy ], none, none";
  self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  secondaryweaponhash = "jup_jp13_dm_svictork, [ none, none, none, none, none, none ], none, none";
  self.secondaryweapon = level.var_67b54180a55f70e1[secondaryweaponhash];
  sidearmweaponhash = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";
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
  return namespace_aff6b15a4e71a8d7::main();
}

function precache() {
  agent_type = "actor_jup_ob_warlord_maestro";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_48b9aea3f0fc9faa");
    namespace_aff6b15a4e71a8d7::precache_cpmp();
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

  primaryweaponhash = "jup_jp02_br_bromeo2, [ holotherm01, jup_jp02_br_bromeo2_bar_heavy_long, jup_jp02_br_bromeo2_stock_heavy ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\mp\class::function_e83615f8a92e4378("jup_jp02_br_bromeo2", ["holotherm01", "jup_jp02_br_bromeo2_bar_heavy_long", "jup_jp02_br_bromeo2_stock_heavy"], "none", "none");
  }

  secondaryweaponhash = "jup_jp13_dm_svictork, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[secondaryweaponhash])) {
    level.var_67b54180a55f70e1[secondaryweaponhash] = scripts\mp\class::function_e83615f8a92e4378("jup_jp13_dm_svictork", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  sidearmweaponhash = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[sidearmweaponhash])) {
    level.var_67b54180a55f70e1[sidearmweaponhash] = scripts\mp\class::function_e83615f8a92e4378("iw9_pi_papa220", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }
}