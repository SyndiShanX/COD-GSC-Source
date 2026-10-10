/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4d2f13658fecc045.gsc
*************************************************/

#using character\c_jup_sp_civ_prisoner_01_b_riot;
#using character\c_jup_sp_civ_prisoner_02_b_riot;
#using character\c_jup_sp_civ_prisoner_03_b_riot;
#using character\c_jup_sp_civ_prisoner_04_b_riot;
#using character\c_jup_sp_civ_prisoner_05_b;
#using character\c_jup_sp_civ_prisoner_05_b_riot;
#using script_183b8850aac75430;
#using script_6a80506405ef95b7;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_d9d4c5e5415d02f4;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_554be2ec879f9abb");
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
      return character\c_jup_sp_civ_prisoner_05_b::main();
    case 1:
      return namespace_1a817f9c254350d3::main();
    case 2:
      return character\c_jup_sp_civ_prisoner_01_b_riot::main();
    case 3:
      return character\c_jup_sp_civ_prisoner_02_b_riot::main();
    case 4:
      return namespace_b76f7b946febd424::main();
    case 5:
      return character\c_jup_sp_civ_prisoner_03_b_riot::main();
    case 6:
      return character\c_jup_sp_civ_prisoner_04_b_riot::main();
    case 7:
      return character\c_jup_sp_civ_prisoner_05_b_riot::main();
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(classname) {
  character\c_jup_sp_civ_prisoner_05_b::precache_sp();
  namespace_1a817f9c254350d3::precache_sp();
  character\c_jup_sp_civ_prisoner_01_b_riot::precache_sp();
  character\c_jup_sp_civ_prisoner_02_b_riot::precache_sp();
  namespace_b76f7b946febd424::precache_sp();
  character\c_jup_sp_civ_prisoner_03_b_riot::precache_sp();
  character\c_jup_sp_civ_prisoner_04_b_riot::precache_sp();
  character\c_jup_sp_civ_prisoner_05_b_riot::precache_sp();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
}