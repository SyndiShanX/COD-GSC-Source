/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_rus_juggernaut.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "juggernaut";
  self.subclass = "juggernaut";
  self.accuracy = 0.2;
  self.health = 3000;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 0;
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = getcompleteweaponname("iw8_pi_golf21");
  self.behaviortreeasset = "juggernaut";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(128, 0);
    self setengagementmaxdist(256, 1024);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = getcompleteweaponname("iw8_lm_pkilo");
  character\character_opforce_juggernaut::main();
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_opforce_juggernaut::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::juggernaut();
  behaviortree\juggernaut::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_lm_pkilo");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}