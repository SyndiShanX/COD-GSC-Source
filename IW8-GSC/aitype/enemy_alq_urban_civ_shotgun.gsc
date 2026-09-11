/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_alq_urban_civ_shotgun.gsc
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
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_mike1911", "sidearm");
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
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_sh_romeo870", "iw8_sh_charlie725"]);
  var0 = undefined;
  var1 = ["character_al_qatala_urban_civ_1", "character_al_qatala_urban_civ_2", "character_al_qatala_urban_civ_3", "character_al_qatala_urban_civ_4", "character_al_qatala_urban_civ_5", "character_al_qatala_urban_civ_6", "character_al_qatala_urban_civ_7", "character_al_qatala_urban_civ_8", "character_al_qatala_urban_civ_9"];

  switch (scripts\code\character::get_random_character(9, var0, var1)) {
    case 0:
      character\character_al_qatala_urban_civ_1::main();
      break;
    case 1:
      character\character_al_qatala_urban_civ_2::main();
      break;
    case 2:
      character\character_al_qatala_urban_civ_3::main();
      break;
    case 3:
      character\character_al_qatala_urban_civ_4::main();
      break;
    case 4:
      character\character_al_qatala_urban_civ_5::main();
      break;
    case 5:
      character\character_al_qatala_urban_civ_6::main();
      break;
    case 6:
      character\character_al_qatala_urban_civ_7::main();
      break;
    case 7:
      character\character_al_qatala_urban_civ_8::main();
      break;
    case 8:
      character\character_al_qatala_urban_civ_9::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_al_qatala_urban_civ_1::precache();
  character\character_al_qatala_urban_civ_2::precache();
  character\character_al_qatala_urban_civ_3::precache();
  character\character_al_qatala_urban_civ_4::precache();
  character\character_al_qatala_urban_civ_5::precache();
  character\character_al_qatala_urban_civ_6::precache();
  character\character_al_qatala_urban_civ_7::precache();
  character\character_al_qatala_urban_civ_8::precache();
  character\character_al_qatala_urban_civ_9::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sh_romeo870");
  precacheitem("iw8_sh_charlie725");
  precacheitem("iw8_pi_mike1911");
  precacheitem("frag");
}