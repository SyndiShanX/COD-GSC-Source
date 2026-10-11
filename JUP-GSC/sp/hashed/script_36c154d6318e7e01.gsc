/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_36c154d6318e7e01.gsc
*************************************************/

#using script_33384ccdade0dfd6;
#using script_6e42cc63d3c6ae91;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_aaf83fff4bd0ecc0;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_bd68f7ff3436453");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = makeweapon("iw9_me_riotshield_sp");
  self.sidearm = makeweapon("jup_jp12_pi_mike93_sp");
  self.behaviortreeasset = "riotshield_sp";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = makeweapon("iw9_sm_mpapa5_sp");
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
      return namespace_76215cc2b0590dd4::main();
    case 1:
      return namespace_70d1c1b097a8bd29::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  namespace_76215cc2b0590dd4::precache_sp();
  namespace_70d1c1b097a8bd29::precache_sp();
  precacheitem("iw9_sm_mpapa5_sp");
  precacheitem("iw9_me_riotshield_sp");
  precacheitem("jup_jp12_pi_mike93_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}