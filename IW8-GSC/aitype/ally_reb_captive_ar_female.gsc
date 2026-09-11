/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_reb_captive_ar_female.gsc
*************************************************/

function main() {
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 0;
  self.secondaryweapon = isundefinedweapon();
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
  self.weapon = getcompleteweaponname("iw8_ar_akilo47");
  var0 = undefined;
  var1 = ["character_iw8_sla_rebels_female_prisoner_1", "character_iw8_sla_rebels_female_prisoner_2", "character_iw8_sla_rebels_female_prisoner_3", "character_iw8_sla_rebels_female_prisoner_4", "character_iw8_sla_rebels_female_prisoner_5"];

  switch (scripts\code\character::get_random_character(5, var0, var1)) {
    case 0:
      character\character_iw8_sla_rebels_female_prisoner_1::main();
      break;
    case 1:
      character\character_iw8_sla_rebels_female_prisoner_2::main();
      break;
    case 2:
      character\character_iw8_sla_rebels_female_prisoner_3::main();
      break;
    case 3:
      character\character_iw8_sla_rebels_female_prisoner_4::main();
      break;
    case 4:
      character\character_iw8_sla_rebels_female_prisoner_5::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(var0) {
  character\character_iw8_sla_rebels_female_prisoner_1::precache();
  character\character_iw8_sla_rebels_female_prisoner_2::precache();
  character\character_iw8_sla_rebels_female_prisoner_3::precache();
  character\character_iw8_sla_rebels_female_prisoner_4::precache();
  character\character_iw8_sla_rebels_female_prisoner_5::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_ar_akilo47");
  precacheitem("frag");
}