/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5547077fffd9c53b.gsc
*************************************************/

#using script_139d738b88f9b548;
#using script_1c4979cefe3fbe9e;
#using script_2186e8b70dd1c45b;
#using script_2b3173a0a4b03027;
#using script_3135f3ae1ce6163a;
#using script_42c2a5ca589e14e4;
#using script_432caa676ff6f3a5;
#using script_5ed53a82f5fe593c;
#using script_605a7025b3443aeb;
#using script_60ff8ec02a27588b;
#using script_660a74d7ea912c7d;
#using script_68a5d7921b3adc43;
#using script_691d7b45e4a09fbe;
#using script_6d7db6900a6781c1;
#using script_6e5aea2df432a57b;
#using script_77a99ae72773152d;
#using script_e82fad9e5eb9b2;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;
#namespace jup_ob_enemy_basic_grunt_long;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_enemy_basic_grunt_long");
  self.subclass_scriptbundle = getscriptbundle(%"hash_579d39f2f40c41bf");
  self.subclass = self.subclass_scriptbundle.name;
  self.health = 180;
  self.maxhealth = 180;
  self.behaviortreeasset = "soldier_jup_ob";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  scripts\common\ai_settings::function_7b25d1c42e7f75be("aisettings_soldier_base_ob");

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      primaryweaponhash = "iw9_ar_kilo53, [ none, none, none, none, none, none ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 1:
      primaryweaponhash = "iw9_ar_mcharlie, [ none, none, none, none, none, none ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
    case 2:
      primaryweaponhash = "iw9_ar_golf3, [ none, none, none, none, none, none ], none, none";
      self.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
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
    case #"hash_f19a3ecfe8b35af9":
      function_efa2a2a09745fbd();
      break;
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
      return namespace_7d3b12eaf52e5063::main();
    case 1:
      return namespace_9c005241e2d2ce27::main();
    case 2:
      return namespace_9c005341e2d2d05a::main();
    case 3:
      return namespace_9c005441e2d2d28d::main();
    case 4:
      return namespace_489304c6fe3a495b::main();
    case 5:
      return namespace_489305c6fe3a4b8e::main();
    case 6:
      return namespace_5cfc4ed0ea7654ff::main();
    case 7:
      return namespace_5cfc4fd0ea765732::main();
    case 8:
      return namespace_ffc709ab88f6587f::main();
    case 9:
      return namespace_ffc70aab88f65ab2::main();
    case 10:
      return namespace_ffc70bab88f65ce5::main();
    case 11:
      return namespace_474abb8d4fd3a643::main();
    case 12:
      return namespace_474abc8d4fd3a876::main();
  }
}

function function_efa2a2a09745fbd() {
  assertex(isDefined(self.var_e2682e6f1838391e), "<dev string:x1c>");

  switch (self.var_e2682e6f1838391e) {
    case 0:
      return namespace_385f3646395c9f26::main();
    case 1:
      return namespace_385f3546395c9cf3::main();
    case 2:
      return namespace_385f3446395c9ac0::main();
    case 3:
      return namespace_385f3b46395caa25::main();
  }
}

function precache() {
  agent_type = "actor_jup_ob_enemy_basic_grunt_long";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = &main;
    level.agent_definition[agent_type]["setup_model_func"] = &setup_model;
    level.agent_definition[agent_type]["subclass"] = getscriptbundle(%"hash_579d39f2f40c41bf");
    namespace_7d3b12eaf52e5063::precache_cpmp();
    namespace_9c005241e2d2ce27::precache_cpmp();
    namespace_9c005341e2d2d05a::precache_cpmp();
    namespace_9c005441e2d2d28d::precache_cpmp();
    namespace_489304c6fe3a495b::precache_cpmp();
    namespace_489305c6fe3a4b8e::precache_cpmp();
    namespace_5cfc4ed0ea7654ff::precache_cpmp();
    namespace_5cfc4fd0ea765732::precache_cpmp();
    namespace_ffc709ab88f6587f::precache_cpmp();
    namespace_ffc70aab88f65ab2::precache_cpmp();
    namespace_ffc70bab88f65ce5::precache_cpmp();
    namespace_474abb8d4fd3a643::precache_cpmp();
    namespace_474abc8d4fd3a876::precache_cpmp();
    namespace_385f3646395c9f26::precache_cpmp();
    namespace_385f3546395c9cf3::precache_cpmp();
    namespace_385f3446395c9ac0::precache_cpmp();
    namespace_385f3b46395caa25::precache_cpmp();
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

  var_5576d3be590a9a64 = "iw9_ar_kilo53, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d3be590a9a64])) {
    level.var_67b54180a55f70e1[var_5576d3be590a9a64] = scripts\mp\class::function_e83615f8a92e4378("iw9_ar_kilo53", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  var_5576d6be590aa0fd = "iw9_ar_mcharlie, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d6be590aa0fd])) {
    level.var_67b54180a55f70e1[var_5576d6be590aa0fd] = scripts\mp\class::function_e83615f8a92e4378("iw9_ar_mcharlie", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  var_5576d5be590a9eca = "iw9_ar_golf3, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[var_5576d5be590a9eca])) {
    level.var_67b54180a55f70e1[var_5576d5be590a9eca] = scripts\mp\class::function_e83615f8a92e4378("iw9_ar_golf3", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }
}