/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_alq_desert_embassy_ar.gsc
**************************************************/

function main() {
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = getcompleteweaponname("iw8_pi_mike1911");
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
  self.weapon = getcompleteweaponname("iw8_ar_akilo47");
  var_0 = undefined;
  var_1 = ["test_character_alq_embassy"];

  switch (scripts\code\character::get_random_character(1, var_0, var_1)) {
    case 0:
      character\test_character_alq_embassy::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var_0) {
  character\test_character_alq_embassy::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_ar_akilo47");
  precacheitem("iw8_pi_mike1911");
  precacheitem("frag");
}