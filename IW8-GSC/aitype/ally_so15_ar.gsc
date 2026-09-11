/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_so15_ar.gsc
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
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_papa320", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(256, 0);
    self setengagementmaxdist(768, 1024);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "ar";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_ar_mike4"]);
  var_0 = undefined;
  var_1 = ["character_ally_so15_1", "character_ally_so15_2", "character_ally_so15_3"];

  switch (scripts\code\character::get_random_character(3, var_0, var_1)) {
    case 0:
      character\character_ally_so15_1::main();
      break;
    case 1:
      character\character_ally_so15_2::main();
      break;
    case 2:
      character\character_ally_so15_3::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(var_0) {
  character\character_ally_so15_1::precache();
  character\character_ally_so15_2::precache();
  character\character_ally_so15_3::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_ar_mike4");
  precacheitem("iw8_pi_papa320");
  precacheitem("frag");
}