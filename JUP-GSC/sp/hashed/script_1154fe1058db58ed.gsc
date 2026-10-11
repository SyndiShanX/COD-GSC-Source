/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1154fe1058db58ed.gsc
*************************************************/

#using character\c_jup_sp_enemy_pmc_cmdr_01;
#using character\c_jup_sp_enemy_pmc_cmdr_02;
#using character\c_jup_sp_enemy_pmc_soldier_01;
#using script_399cf54386d2a876;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;
#namespace namespace_a719254c7593473c;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_3923aa76117f9429");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("jup_cp24_pi_glima21_sp", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.aishootstyle = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "shotgun";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw9_sh_mike1014_sp"]);
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
      return character\c_jup_sp_enemy_pmc_soldier_01::main();
    case 1:
      return namespace_de46640c92fc8aac::main();
    case 2:
      return character\c_jup_sp_enemy_pmc_cmdr_01::main();
    case 3:
      return character\c_jup_sp_enemy_pmc_cmdr_02::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  character\c_jup_sp_enemy_pmc_soldier_01::precache_sp();
  namespace_de46640c92fc8aac::precache_sp();
  character\c_jup_sp_enemy_pmc_cmdr_01::precache_sp();
  character\c_jup_sp_enemy_pmc_cmdr_02::precache_sp();
  precacheitem("iw9_sh_mike1014_sp");
  precacheitem("jup_cp24_pi_glima21_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}