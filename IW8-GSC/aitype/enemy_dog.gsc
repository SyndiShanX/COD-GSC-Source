/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_dog.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "dog";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 75;
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = isundefinedweapon();
  self.behaviortreeasset = "dog";
  self.asmasset = "dog";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(256, 0);
    self setengagementmaxdist(768, 1024);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = isundefinedweapon();
  character\test_character_dog::main();
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\test_character_dog::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::dog();
  behaviortree\dog::registerbehaviortree();
  aiasm\dog_sp::asm_register();
}