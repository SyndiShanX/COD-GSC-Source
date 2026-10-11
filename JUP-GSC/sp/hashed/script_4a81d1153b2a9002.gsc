/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4a81d1153b2a9002.gsc
*************************************************/

#using script_17c1a9a711e9953;
#using script_1ccc5c4e16b6741;
#using script_1d874c3df1fd514d;
#using script_221f5ecaa8ea0040;
#using script_452c67fa453359ed;
#using script_7bdb2baeb276b0f6;
#using script_a0472acef0e042c;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_cc4be9d037f97f0b;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_4af246381a68467c");
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
      return namespace_30f412333bb69ba3::main();
    case 1:
      return namespace_8e394d93f190d294::main();
    case 2:
      return namespace_b1c72fc9ddcfe1cf::main();
    case 3:
      return namespace_5579395db6a5d327::main();
    case 4:
      return namespace_8546bf0cd85297f8::main();
    case 5:
      return namespace_8546c20cd8529e91::main();
    case 6:
      return namespace_8546c10cd8529c5e::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  namespace_30f412333bb69ba3::precache_sp();
  namespace_8e394d93f190d294::precache_sp();
  namespace_b1c72fc9ddcfe1cf::precache_sp();
  namespace_5579395db6a5d327::precache_sp();
  namespace_8546bf0cd85297f8::precache_sp();
  namespace_8546c20cd8529e91::precache_sp();
  namespace_8546c10cd8529c5e::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}