/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_43b44860638c5bad.gsc
*************************************************/

#using character\c_jup_sp_civ_guard_01;
#using character\c_jup_sp_civ_guard_01a;
#using character\c_jup_sp_civ_guard_02;
#using character\c_jup_sp_civ_guard_02a;
#using character\c_jup_sp_civ_guard_03;
#using character\c_jup_sp_civ_guard_03a;
#using character\c_jup_sp_civ_guard_04;
#using character\c_jup_sp_civ_guard_04a;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;
#namespace namespace_85bdf62ad738a05c;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_39fbf814c45fba5f");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "pistol";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw9_pi_papa220_sp"]);
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
      return character\c_jup_sp_civ_guard_01::main();
    case 1:
      return character\c_jup_sp_civ_guard_01a::main();
    case 2:
      return character\c_jup_sp_civ_guard_04::main();
    case 3:
      return character\c_jup_sp_civ_guard_04a::main();
    case 4:
      return character\c_jup_sp_civ_guard_02::main();
    case 5:
      return character\c_jup_sp_civ_guard_02a::main();
    case 6:
      return character\c_jup_sp_civ_guard_03::main();
    case 7:
      return character\c_jup_sp_civ_guard_03a::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  character\c_jup_sp_civ_guard_01::precache_sp();
  character\c_jup_sp_civ_guard_01a::precache_sp();
  character\c_jup_sp_civ_guard_04::precache_sp();
  character\c_jup_sp_civ_guard_04a::precache_sp();
  character\c_jup_sp_civ_guard_02::precache_sp();
  character\c_jup_sp_civ_guard_02a::precache_sp();
  character\c_jup_sp_civ_guard_03::precache_sp();
  character\c_jup_sp_civ_guard_03a::precache_sp();
  precacheitem("iw9_pi_papa220_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}