/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_alq_desert_bomber.gsc
***********************************************/

function main() {
  self.additionalassets = "suicide_bomber.csv";
  self.team = "axis";
  self.type = "human";
  self.unittype = "suicidebomber";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 600;
  self.grenadeweapon = getcompleteweaponname("suicide_vest");
  self.grenadeammo = 2;
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = getcompleteweaponname("iw8_pi_mike1911");
  self.behaviortreeasset = "suicidebomber";
  self.asmasset = "suicidebomber";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(256, 0);
    self setengagementmaxdist(768, 1024);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = isundefinedweapon();
  var0 = undefined;
  var1 = ["test_character_crew_male_vest_picc_01"];

  switch (scripts\code\character::get_random_character(1, var0, var1)) {
    case 0:
      character\test_character_crew_male_vest_picc_01::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\test_character_crew_male_vest_picc_01::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::suicidebomber();
  behaviortree\suicidebomber::registerbehaviortree();
  aiasm\suicidebomber_sp::asm_register();
  precacheitem("iw8_pi_mike1911");
  precacheitem("suicide_vest");
}