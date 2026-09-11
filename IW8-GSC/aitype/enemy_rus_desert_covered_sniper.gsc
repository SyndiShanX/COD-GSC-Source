/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_rus_desert_covered_sniper.gsc
******************************************************/

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
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_golf21", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(1250, 1024);
    self setengagementmaxdist(1600, 2400);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "sniper";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_sn_delta"]);
  var_0 = undefined;
  var_1 = ["character_iw8_russian_army_1_safehouse", "character_iw8_russian_army_2_hood_safehouse"];

  switch (scripts\code\character::get_random_character(2, var_0, var_1)) {
    case 0:
      character\character_iw8_russian_army_1_safehouse::main();
      break;
    case 1:
      character\character_iw8_russian_army_2_hood_safehouse::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var_0) {
  character\character_iw8_russian_army_1_safehouse::precache();
  character\character_iw8_russian_army_2_hood_safehouse::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sn_delta");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}