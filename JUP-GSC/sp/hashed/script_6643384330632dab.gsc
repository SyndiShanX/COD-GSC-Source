/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6643384330632dab.gsc
*************************************************/

#using script_15db8f5bd2eed8c5;
#using script_2065d6673a0b3166;
#using script_342e1b4c3e17f5dc;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace jup_civilian_uk_male_surge;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_78b70280ba5d3935");
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
      return namespace_3f4f5b0442e09c22::main();
    case 1:
      return namespace_3f4f5a0442e099ef::main();
    case 2:
      return namespace_3f4f590442e097bc::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  namespace_3f4f5b0442e09c22::precache_sp();
  namespace_3f4f5a0442e099ef::precache_sp();
  namespace_3f4f590442e097bc::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}