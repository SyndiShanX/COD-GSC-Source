/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_rus_1999_balaclava_ar.gsc
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
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_golf21", "sidearm");
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
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_ar_akilo47"]);
  var0 = undefined;
  var1 = ["character_iw8_russian_army_ar_1_balaclava", "character_iw8_russian_army_ar_2_balaclava"];

  switch (scripts\code\character::get_random_character(2, var0, var1)) {
    case 0:
      character\character_iw8_russian_army_ar_1_balaclava::main();
      break;
    case 1:
      character\character_iw8_russian_army_ar_2_balaclava::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_iw8_russian_army_ar_1_balaclava::precache();
  character\character_iw8_russian_army_ar_2_balaclava::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_ar_akilo47");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}