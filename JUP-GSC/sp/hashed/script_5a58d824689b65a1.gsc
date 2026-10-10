/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5a58d824689b65a1.gsc
*************************************************/

#using script_38d9ec25b87966eb;
#using script_4956c9a0c48908c6;
#using script_56fbf22650ac23cd;
#using script_67ea661a92044ecb;
#using script_6dc211c9b6675ac9;
#using script_6e08d36153359e5e;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_86462d70f29dcd30;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_2a42cf014f5390ab");
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = nullweapon();
  self.sidearm = nullweapon();
  self.behaviortreeasset = "civilian_livingworld";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
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
      return namespace_e47e09e6045629a7::main();
    case 1:
      return namespace_c5906bbbc0d9f717::main();
    case 2:
      return namespace_ec8296d67a7b0662::main();
    case 3:
      return namespace_b1b2c2ab63a9a4ca::main();
    case 4:
      return namespace_b725e006142b5031::main();
    case 5:
      return namespace_5590ba0f823b82bd::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  namespace_e47e09e6045629a7::precache_sp();
  namespace_c5906bbbc0d9f717::precache_sp();
  namespace_ec8296d67a7b0662::precache_sp();
  namespace_b1b2c2ab63a9a4ca::precache_sp();
  namespace_b725e006142b5031::precache_sp();
  namespace_5590ba0f823b82bd::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}