/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_37541a2ad2fc593f.gsc
*************************************************/

#using character\character_usmc_basic_ar_1;
#using character\character_usmc_basic_ar_2;
#using character\character_usmc_basic_ar_3;
#using character\character_usmc_basic_ar_4;
#using character\character_usmc_basic_lmg;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\character;
#using scripts\common\ai;
#namespace namespace_9cb5c5bb4cfb857e;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_3e04ce7132152c1");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = nullweapon();
  self.sidearm = makeweapon("iw9_pi_papa220_sp");
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      self.weapon = makeweapon("iw9_ar_mike4_sp");
      break;
    case 1:
      self.weapon = makeweapon("iw9_ar_scharlie_sp");
      break;
    case 2:
      self.weapon = makeweapon("iw9_ar_scharlie_sp");
      break;
  }

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
      return character\character_usmc_basic_ar_1::main();
    case 1:
      return character\character_usmc_basic_ar_2::main();
    case 2:
      return character\character_usmc_basic_ar_3::main();
    case 3:
      return character\character_usmc_basic_ar_4::main();
    case 4:
      return character\character_usmc_basic_lmg::main();
  }
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(classname) {
  character\character_usmc_basic_ar_1::precache_sp();
  character\character_usmc_basic_ar_2::precache_sp();
  character\character_usmc_basic_ar_3::precache_sp();
  character\character_usmc_basic_ar_4::precache_sp();
  character\character_usmc_basic_lmg::precache_sp();
  precacheitem("iw9_ar_mike4_sp");
  precacheitem("iw9_ar_scharlie_sp");
  precacheitem("iw9_ar_scharlie_sp");
  precacheitem("iw9_pi_papa220_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}