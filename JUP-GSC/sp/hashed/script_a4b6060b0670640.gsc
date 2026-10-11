/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_a4b6060b0670640.gsc
************************************************/

#using script_607f838a6ace3940;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_c5a92997ba1f6429;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_2869dd1fd8674ff6");
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = nullweapon();
  self.sidearm = nullweapon();
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
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
  return namespace_b04683cefb6213a4::main();
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  namespace_b04683cefb6213a4::precache_sp();
  precacheitem("iw9_pi_papa220_sp");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}