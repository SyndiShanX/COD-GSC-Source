/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_hero_hadir_prisoner.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = isundefinedweapon();
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(128, 0);
    self setengagementmaxdist(512, 768);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "smg";
  self.weapon = isundefinedweapon();
  character\character_hero_hadir_prisoner::main();
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(var0) {
  character\character_hero_hadir_prisoner::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
}