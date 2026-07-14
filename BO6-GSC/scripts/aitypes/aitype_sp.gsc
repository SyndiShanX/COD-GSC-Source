/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitypes\aitype_sp.gsc
*****************************************/

#using scripts\aitypes\aitype;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#namespace aitype_sp;

function main(aitype, selectedcharacter, weaponstruct) {
  aitypescriptbundle = getaitypescriptbundle(aitype);
  assert(isDefined(aitypescriptbundle));
  aitype::main(aitype, aitypescriptbundle, selectedcharacter, weaponstruct);

  if(aitypescriptbundle.damagefiltering || aitypescriptbundle.staggerthreshold > 0) {
    self.damagefiltering = spawnStruct();

    if(aitypescriptbundle.damagefiltering) {
      self.damagefiltering.filteringenabled = 1;
    }

    if(aitypescriptbundle.staggerthreshold > 0) {
      self.damagefiltering.staggerthreshold = aitypescriptbundle.staggerthreshold;
      self.damagefiltering.staggerdecay = aitypescriptbundle.staggerdecay;
    }
  }

  if(istrue(aitypescriptbundle.usescriptedweapon)) {
    self.usescriptedweapon = 1;
    self.scriptedweaponclassprimary = aitypescriptbundle.scriptedweaponclassprimary;
  }

  init::firstinit();
  self.a = spawnStruct();
  asm::asm_init_blackboard();
  bt_util::bt_init();
  assert(isDefined(self.animationarchetype) && self.animationarchetype != "<dev string:x24>", "<dev string:x28>" + self.classname + "<dev string:x33>");
  assert(isDefined(self.asmasset) && self.asmasset != "<dev string:x24>", "<dev string:x28>" + self.classname + "<dev string:x73>");
  self.defaultasm = self.asmasset;
  asm_sp::asm_init(self.asmasset, self.animationarchetype);
  ai::ai_init();
  self notify("w\x90\xea\xf0\xf7\xef\x9fQn\x8d");
}

function precache(aitype, weaponstruct) {
  aitypescriptbundle = getaitypescriptbundle(aitype);
  assert(isDefined(aitypescriptbundle));
  aitype::precache(aitype, aitypescriptbundle, weaponstruct);
  bt_util::init();
}