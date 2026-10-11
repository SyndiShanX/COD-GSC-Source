/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3ecf59b1617a1a43.gsc
*************************************************/

#using script_1806380fbf0cfc4a;
#using script_2818f6d127263a2e;
#using script_2e2c6c1e4d162d35;
#using script_348a9cda3e6db136;
#using script_3e13f80382492ef7;
#using script_3e988d7a91a0264e;
#using script_42ccbbf7643e4f54;
#using script_43e1df2a76ff47f9;
#using script_4b2ea88fe9be8400;
#using script_4eea852b7e47f853;
#using script_5f2b4d1352300441;
#using script_72ef7a4e50a56ecb;
#using script_995218a55dbb757;
#using script_cfcd57998bbed90;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_16f7cab814ce1c2;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_43de986cbfe80cb5");
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
      return namespace_728534d72cdd0bfa::main();
    case 1:
      return namespace_9ad82f9fcc42321a::main();
    case 2:
      return namespace_9ad8309fcc42344d::main();
    case 3:
      return namespace_ca9c730a9bcc6ad3::main();
    case 4:
      return namespace_84d4b419f12c82c1::main();
    case 5:
      return namespace_84d4b119f12c7c28::main();
    case 6:
      return namespace_56dcad19ce94bf1c::main();
    case 7:
      return namespace_56dcb019ce94c5b5::main();
    case 8:
      return namespace_4d12fac695bdda3::main();
    case 9:
      return namespace_29ad99355926eabb::main();
    case 10:
      return namespace_762ff6fc3a5bdeed::main();
    case 11:
      return namespace_15e6ae29bf09d3ec::main();
    case 12:
      return namespace_8fa6faeaa05e6346::main();
    case 13:
      return namespace_4e1476a12f608f24::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  namespace_728534d72cdd0bfa::precache_sp();
  namespace_9ad82f9fcc42321a::precache_sp();
  namespace_9ad8309fcc42344d::precache_sp();
  namespace_ca9c730a9bcc6ad3::precache_sp();
  namespace_84d4b419f12c82c1::precache_sp();
  namespace_84d4b119f12c7c28::precache_sp();
  namespace_56dcad19ce94bf1c::precache_sp();
  namespace_56dcb019ce94c5b5::precache_sp();
  namespace_4d12fac695bdda3::precache_sp();
  namespace_29ad99355926eabb::precache_sp();
  namespace_762ff6fc3a5bdeed::precache_sp();
  namespace_15e6ae29bf09d3ec::precache_sp();
  namespace_8fa6faeaa05e6346::precache_sp();
  namespace_4e1476a12f608f24::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}