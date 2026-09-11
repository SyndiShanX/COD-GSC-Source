/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_usmc_desert_smg.gsc
***********************************************/

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
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_mike1911", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(128, 0);
    self setengagementmaxdist(512, 768);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "smg";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_sm_mpapa5"]);
  var0 = undefined;
  var1 = ["character_usmc_basic_ar_1", "character_usmc_basic_ar_2", "character_usmc_basic_ar_3", "character_usmc_basic_ar_4", "character_usmc_basic_lmg"];

  switch (scripts\code\character::get_random_character(5, var0, var1)) {
    case 0:
      character\character_usmc_basic_ar_1::main();
      break;
    case 1:
      character\character_usmc_basic_ar_2::main();
      break;
    case 2:
      character\character_usmc_basic_ar_3::main();
      break;
    case 3:
      character\character_usmc_basic_ar_4::main();
      break;
    case 4:
      character\character_usmc_basic_lmg::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(var0) {
  character\character_usmc_basic_ar_1::precache();
  character\character_usmc_basic_ar_2::precache();
  character\character_usmc_basic_ar_3::precache();
  character\character_usmc_basic_ar_4::precache();
  character\character_usmc_basic_lmg::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sm_mpapa5");
  precacheitem("iw8_pi_mike1911");
  precacheitem("frag");
}