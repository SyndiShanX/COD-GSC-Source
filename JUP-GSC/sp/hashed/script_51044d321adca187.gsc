/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_51044d321adca187.gsc
*************************************************/

#using character\character_hero_price_urban;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_d02bc340297d6756;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_54082080c723ba13");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = nullweapon();
  self.sidearm = makeweapon("t10_pi_p13_usugar9_sp");
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = makeweapon("t10_ar_p01_coslo723_sp");
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
  return character\character_hero_price_urban::main();
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(classname) {
  character\character_hero_price_urban::precache_sp();
  precacheitem("t10_ar_p01_coslo723_sp");
  precacheitem("t10_pi_p13_usugar9_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}