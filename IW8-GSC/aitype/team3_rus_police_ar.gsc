/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\team3_rus_police_ar.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.team = "team3";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 0;
  self.secondaryweapon = getcompleteweaponname("iw8_pi_golf21");
  self.sidearm = isundefinedweapon();
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(256, 0);
    self setengagementmaxdist(768, 1024);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = getcompleteweaponname("iw8_ar_asierra12");
  character\character_civ_russian_police_officer::main();
}

function spawner() {
  self setspawnerteam("team3");
}

function precache(var0) {
  character\character_civ_russian_police_officer::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_ar_asierra12");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}