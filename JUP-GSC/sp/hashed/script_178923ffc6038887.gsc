/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_178923ffc6038887.gsc
*************************************************/

#using character\c_jup_sp_enemy_pmc_grunt_03_winter;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;
#namespace namespace_486bb56a9471e3de;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_153eede18585d54b");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("jup_cp24_pi_glima21_sp", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "ar";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw9_ar_akilo105_sp", "jup_jp01_ar_golf36_sp", "iw9_ar_akilo_sp"]);
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
      return character\c_jup_sp_enemy_pmc_grunt_03_winter::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  character\c_jup_sp_enemy_pmc_grunt_03_winter::precache_sp();
  precacheitem("iw9_ar_akilo105_sp");
  precacheitem("jup_jp01_ar_golf36_sp");
  precacheitem("iw9_ar_akilo_sp");
  precacheitem("jup_cp24_pi_glima21_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}