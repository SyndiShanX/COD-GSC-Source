/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_rus_desert_light_shotgun.gsc
*****************************************************/

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
    self setengagementmindist(0, 0);
    self setengagementmaxdist(280, 400);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "shotgun";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_sh_romeo870", "iw8_sh_oscar12"]);
  var0 = undefined;
  var1 = ["character_iw8_russian_army_1_safehouse_finale", "character_iw8_russian_army_2_hood_safehouse_finale"];

  switch (scripts\code\character::get_random_character(2, var0, var1)) {
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

function precache(var0) {
  character\character_iw8_russian_army_1_safehouse_finale::precache();
  character\character_iw8_russian_army_2_hood_safehouse_finale::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sh_romeo870");
  precacheitem("iw8_sh_oscar12");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}