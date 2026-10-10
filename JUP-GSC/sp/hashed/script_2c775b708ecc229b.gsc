/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2c775b708ecc229b.gsc
*************************************************/

#using script_53fe46890cfd66c2;
#using script_65e48a6348283a58;
#using script_68ce8f7e9104d5d1;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;
#namespace jup_enemy_paramedic_ar;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"jup_enemy_paramedic_ar");
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw9_pi_papa220_sp", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.var_6cb8f78a7c37e43b = "ai_shoot_styles_default";
  self.asmasset = "soldier";
  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "ar";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw9_ar_akilo105_sp", "iw9_ar_akilo74_sp"]);
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
      return namespace_a8782e63605d16e2::main();
    case 1:
      return namespace_a8782d63605d14af::main();
    case 2:
      return namespace_a8782c63605d127c::main();
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(classname) {
  namespace_a8782e63605d16e2::precache_sp();
  namespace_a8782d63605d14af::precache_sp();
  namespace_a8782c63605d127c::precache_sp();
  precacheitem("iw9_ar_akilo105_sp");
  precacheitem("iw9_ar_akilo74_sp");
  precacheitem("iw9_pi_papa220_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}