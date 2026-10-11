/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_68f2d58de6098dcf.gsc
*************************************************/

#using character\c_jup_sp_enemy_kastovsoldier_01;
#using character\c_jup_sp_enemy_kastovsoldier_04;
#using script_7bb0b5b316a6e416;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_2537f1750841efc6;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_57b469500f75a049");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = nullweapon();
  self.sidearm = nullweapon();
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "pistol";
  self.weapon = makeweapon("iw9_pi_papa220_sp");
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
      return character\c_jup_sp_enemy_kastovsoldier_04::main();
    case 1:
      return character\c_jup_sp_enemy_kastovsoldier_01::main();
    case 2:
      return namespace_340b358275ffbc2c::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  character\c_jup_sp_enemy_kastovsoldier_04::precache_sp();
  character\c_jup_sp_enemy_kastovsoldier_01::precache_sp();
  namespace_340b358275ffbc2c::precache_sp();
  precacheitem("iw9_pi_papa220_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}