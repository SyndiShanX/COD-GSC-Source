/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_442583ab11971049.gsc
*************************************************/

#using script_676956d6d2c96670;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_2b41877fba503170;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_4d995a7477947381");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = nullweapon();
  self.sidearm = makeweapon("jup_cp24_pi_glima21_sp");
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "sniper";
  self.weapon = makeweapon("iw9_sn_alpha50_notherm_sp");
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
    default:
      return namespace_748156c90ce875f8::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  namespace_748156c90ce875f8::precache_sp();
  precacheitem("iw9_sn_alpha50_notherm_sp");
  precacheitem("jup_cp24_pi_glima21_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}