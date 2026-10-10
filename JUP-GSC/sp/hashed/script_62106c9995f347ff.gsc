/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_62106c9995f347ff.gsc
*************************************************/

#using script_17801b9c23e54742;
#using script_3634e49ce0284977;
#using script_424f1f62d8aaefdd;
#using script_df7ff89554add19;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\character;
#using scripts\common\ai;
#namespace namespace_2440da9fc12714d6;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_332c0ce5b5555165");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = nullweapon();
  self.sidearm = makeweapon("iw9_pi_papa220_sp");
  self.behaviortreeasset = "enemy_combatant";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";

  switch (scripts\code\character::get_random_weapon(2)) {
    case 0:
      self.weapon = makeweapon("iw9_ar_mike4_sp");
      break;
    case 1:
      self.weapon = makeweapon("iw9_ar_scharlie_sp");
      break;
  }

  setup_model();
  scripts\anim\init::firstinit();
  self.a = spawnStruct();
  scripts\asm\asm::asm_init_blackboard();
  scripts\aitypes\bt_util::bt_init();
  assertex(isDefined(self.animationarchetype) && self.animationarchetype != "", "Aitype " + self.classname + " does not have the animation archetype defined on the asset.");
  assertex(isDefined(self.asmasset) && self.asmasset != "", "Aitype " + self.classname + " does not have the animation state machine defined on the asset.");
  self.defaultasm = self.asmasset;
  scripts\asm\asm_sp::asm_init(self.asmasset, self.animationarchetype);
  scripts\common\ai::ai_init();
}

function setup_model() {
  var_42e5c77b1d7fe6e7 = isDefined(self.var_42e5c77b1d7fe6e7) ? self.var_42e5c77b1d7fe6e7 : "default";

  switch (var_42e5c77b1d7fe6e7) {
    case #"hash_7038dec66d8275be":
    default:
      return function_9ac26a51c94ccf52();
  }
}

function function_9ac26a51c94ccf52() {
  assertex(isDefined(self.var_e2682e6f1838391e), "self.characterSelectionIndex has not been set, it should have been set in Agent_spawn() for mp and Initspawn() in SP in code");

  switch (self.var_e2682e6f1838391e) {
    case 0:
      return namespace_46e4c0a4fc0d8815::main();
    case 1:
      return namespace_457e544f5f4efc4b::main();
    case 2:
      return namespace_7e2fdc4d18670b43::main();
    case 3:
      return namespace_7047164fe71483e6::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  namespace_46e4c0a4fc0d8815::precache_sp();
  namespace_457e544f5f4efc4b::precache_sp();
  namespace_7e2fdc4d18670b43::precache_sp();
  namespace_7047164fe71483e6::precache_sp();
  precacheitem("iw9_ar_mike4_sp");
  precacheitem("iw9_ar_scharlie_sp");
  precacheitem("iw9_pi_papa220_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}