/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4de882d990af7b1c.gsc
*************************************************/

#using script_1de2f51a016b4302;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace namespace_7799accbf0dcd94d;

function main() {
  self.aitypeid = function_2336488258354fbc(#"aitype", %"hash_4a355425053f684");
  self.subclass_scriptbundle = getscriptbundle(%"hash_7029173c2b262984");
  self.subclass = self.subclass_scriptbundle.name;
  self.grenadeweapon = makeweapon("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = makeweapon("iw9_me_riotshield_sp");
  self.sidearm = makeweapon("jup_cp24_pi_glima21_sp");
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
  return namespace_ad9bb639b9f6ef08::main();
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(classname) {
  namespace_ad9bb639b9f6ef08::precache_sp();
  precacheitem("iw9_sm_mpapa5_sp");
  precacheitem("iw9_me_riotshield_sp");
  precacheitem("jup_cp24_pi_glima21_sp");
  precacheitem("frag");
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
}