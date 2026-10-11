/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1ed565d621b3f26d.gsc
*************************************************/

#using script_2df302b7064d5409;
#using script_338b783adb363592;
#using script_35f5fdc97903689b;
#using script_38d309c0e137dfd0;
#using script_51ac36b086c678db;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_b3361ae7eb31d3ec;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_4258266cef2ab497");
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
      return namespace_fcec5c8f971576df::main();
    case 1:
      return namespace_15a84aeb132e7df::main();
    case 2:
      return namespace_f35b9aebb1dcf2e::main();
    case 3:
      return namespace_205dd2aec8aa3129::main();
    case 4:
      return namespace_2c0607aed02a03f8::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  namespace_fcec5c8f971576df::precache_sp();
  namespace_15a84aeb132e7df::precache_sp();
  namespace_f35b9aebb1dcf2e::precache_sp();
  namespace_205dd2aec8aa3129::precache_sp();
  namespace_2c0607aed02a03f8::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}