/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_20993f30be151804.gsc
*************************************************/

#using character\c_jup_sp_civ_prisoner_01;
#using character\c_jup_sp_civ_prisoner_01_a;
#using character\c_jup_sp_civ_prisoner_01_b;
#using character\c_jup_sp_civ_prisoner_02;
#using character\c_jup_sp_civ_prisoner_02_a;
#using character\c_jup_sp_civ_prisoner_02_b;
#using character\c_jup_sp_civ_prisoner_03;
#using character\c_jup_sp_civ_prisoner_03_a;
#using character\c_jup_sp_civ_prisoner_03_b;
#using character\c_jup_sp_civ_prisoner_04;
#using character\c_jup_sp_civ_prisoner_04_a;
#using character\c_jup_sp_civ_prisoner_04_b;
#using character\c_jup_sp_civ_prisoner_05;
#using character\c_jup_sp_civ_prisoner_05_a;
#using character\c_jup_sp_civ_prisoner_05_b;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_9df46892e6e480f5;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_4ba5d173ab6148f4");
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
      return character\c_jup_sp_civ_prisoner_03_b::main();
    case 1:
      return character\c_jup_sp_civ_prisoner_04::main();
    case 2:
      return character\c_jup_sp_civ_prisoner_04_a::main();
    case 3:
      return character\c_jup_sp_civ_prisoner_04_b::main();
    case 4:
      return character\c_jup_sp_civ_prisoner_05::main();
    case 5:
      return character\c_jup_sp_civ_prisoner_05_a::main();
    case 6:
      return character\c_jup_sp_civ_prisoner_05_b::main();
    case 7:
      return character\c_jup_sp_civ_prisoner_01::main();
    case 8:
      return character\c_jup_sp_civ_prisoner_01_a::main();
    case 9:
      return character\c_jup_sp_civ_prisoner_01_b::main();
    case 10:
      return character\c_jup_sp_civ_prisoner_02::main();
    case 11:
      return character\c_jup_sp_civ_prisoner_02_a::main();
    case 12:
      return character\c_jup_sp_civ_prisoner_02_b::main();
    case 13:
      return character\c_jup_sp_civ_prisoner_03::main();
    case 14:
      return character\c_jup_sp_civ_prisoner_03_a::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  character\c_jup_sp_civ_prisoner_03_b::precache_sp();
  character\c_jup_sp_civ_prisoner_04::precache_sp();
  character\c_jup_sp_civ_prisoner_04_a::precache_sp();
  character\c_jup_sp_civ_prisoner_04_b::precache_sp();
  character\c_jup_sp_civ_prisoner_05::precache_sp();
  character\c_jup_sp_civ_prisoner_05_a::precache_sp();
  character\c_jup_sp_civ_prisoner_05_b::precache_sp();
  character\c_jup_sp_civ_prisoner_01::precache_sp();
  character\c_jup_sp_civ_prisoner_01_a::precache_sp();
  character\c_jup_sp_civ_prisoner_01_b::precache_sp();
  character\c_jup_sp_civ_prisoner_02::precache_sp();
  character\c_jup_sp_civ_prisoner_02_a::precache_sp();
  character\c_jup_sp_civ_prisoner_02_b::precache_sp();
  character\c_jup_sp_civ_prisoner_03::precache_sp();
  character\c_jup_sp_civ_prisoner_03_a::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}