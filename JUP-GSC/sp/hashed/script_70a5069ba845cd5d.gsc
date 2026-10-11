/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_70a5069ba845cd5d.gsc
*************************************************/

#using script_25a007fae78eef2;
#using script_2c63aa5f7eff8081;
#using script_35484f5dcd8dbf4e;
#using script_5c8dffc7cb6bb727;
#using script_64ce2c842e6c326f;
#using script_7043fbd52673908a;
#using script_77662994e4fdc9cd;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_d2f1aa8d53c2d5ec;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_37da9d0979d95a15");
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = nullweapon();
  self.sidearm = nullweapon();
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = makeweapon("iw9_ar_akilo74_sp");
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
      return namespace_bb12c1dae0477cee::main();
    case 1:
      return namespace_1b75c5e434e3153d::main();
    case 2:
      return namespace_cb47939f64246447::main();
    case 3:
      return namespace_d55df257a8ef9b66::main();
    case 4:
      return namespace_3d75fce771ae4adb::main();
    case 5:
      return namespace_7de30195e3c90e86::main();
    case 6:
      return namespace_c98a5724f41e32a1::main();
  }
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(classname) {
  namespace_bb12c1dae0477cee::precache_sp();
  namespace_1b75c5e434e3153d::precache_sp();
  namespace_cb47939f64246447::precache_sp();
  namespace_d55df257a8ef9b66::precache_sp();
  namespace_3d75fce771ae4adb::precache_sp();
  namespace_7de30195e3c90e86::precache_sp();
  namespace_c98a5724f41e32a1::precache_sp();
  precacheitem("iw9_ar_akilo74_sp");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}