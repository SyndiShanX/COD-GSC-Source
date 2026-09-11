/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_rus_pmc_pistol.gsc
***********************************************/

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
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(0, 0);
    self setengagementmaxdist(280, 400);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "pistol";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_pi_golf21"]);
  var0 = undefined;
  var1 = ["character_iw8_russian_weapon_smugglers_1", "character_iw8_russian_weapon_smugglers_2", "character_iw8_russian_weapon_smugglers_3", "character_iw8_russian_weapon_smugglers_4", "character_iw8_russian_weapon_smugglers_5"];

  switch (scripts\code\character::get_random_character(5, var0, var1)) {
    case 0:
      character\character_iw8_russian_weapon_smugglers_1::main();
      break;
    case 1:
      character\character_iw8_russian_weapon_smugglers_2::main();
      break;
    case 2:
      character\character_iw8_russian_weapon_smugglers_3::main();
      break;
    case 3:
      character\character_iw8_russian_weapon_smugglers_4::main();
      break;
    case 4:
      character\character_iw8_russian_weapon_smugglers_5::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_iw8_russian_weapon_smugglers_1::precache();
  character\character_iw8_russian_weapon_smugglers_2::precache();
  character\character_iw8_russian_weapon_smugglers_3::precache();
  character\character_iw8_russian_weapon_smugglers_4::precache();
  character\character_iw8_russian_weapon_smugglers_5::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}