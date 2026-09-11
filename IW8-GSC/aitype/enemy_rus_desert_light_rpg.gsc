/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_rus_desert_light_rpg.gsc
*************************************************/

function main() {
  self.additionalassets = "ai\\iw8_la_rpapa7_ai.csv";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = getcompleteweaponname("iw8_pi_golf21");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(768, 512);
    self setengagementmaxdist(1024, 1500);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = getcompleteweaponname("iw8_la_rpapa7_ai");
  var_0 = undefined;
  var_1 = ["character_iw8_russian_army_1_safehouse_finale", "character_iw8_russian_army_2_hood_safehouse_finale"];

  switch (scripts\code\character::get_random_character(2, var_0, var_1)) {
    case 0:
      character\character_iw8_russian_army_1_safehouse_finale::main();
      break;
    case 1:
      character\character_iw8_russian_army_2_hood_safehouse_finale::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var_0) {
  character\character_iw8_russian_army_1_safehouse_finale::precache();
  character\character_iw8_russian_army_2_hood_safehouse_finale::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_la_rpapa7_ai");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}