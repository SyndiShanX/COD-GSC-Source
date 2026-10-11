/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7b44d9353e41133a.gsc
*************************************************/

#using script_22046726288e720;
#using script_41717273993f125d;
#using script_4ef07b90e2aeb7fe;
#using script_542eea78f24270bb;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_ff4465fe736ea63b;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_ab85c4c41aadcac");
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = nullweapon();
  self.sidearm = nullweapon();
  self.behaviortreeasset = "civilian_livingworld";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "civilian_react";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = nullweapon();
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
  characterlistname = isDefined(self.characterlistname) ? self.characterlistname : "default";

  switch (characterlistname) {
    case #"hash_7038dec66d8275be":
    default:
      return function_9ac26a51c94ccf52();
  }
}

function function_9ac26a51c94ccf52() {
  assertex(isDefined(self.var_e2682e6f1838391e), "self.characterSelectionIndex has not been set, it should have been set in Agent_spawn() for mp and Initspawn() in SP in code");

  switch (self.var_e2682e6f1838391e) {
    case 0:
      return namespace_b17c80085b328f1::main();
    case 1:
      return namespace_b17c50085b32258::main();
    case 2:
      return namespace_b17c60085b3248b::main();
    case 3:
      return namespace_b17cb0085b32f8a::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  namespace_b17c80085b328f1::precache_sp();
  namespace_b17c50085b32258::precache_sp();
  namespace_b17c60085b3248b::precache_sp();
  namespace_b17cb0085b32f8a::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}