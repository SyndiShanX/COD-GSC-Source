/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_alq_urban_lmg.gsc
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
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_mike1911", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(512, 400);
    self setengagementmaxdist(1024, 1250);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "lmg";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_lm_pkilo", "iw8_lm_mgolf34"]);
  var0 = undefined;
  var1 = ["character_iw8_al_qatala_urban_01", "character_iw8_al_qatala_urban_02", "character_iw8_al_qatala_urban_03", "character_iw8_al_qatala_urban_04", "character_iw8_al_qatala_urban_05", "character_iw8_al_qatala_urban_06", "character_iw8_al_qatala_urban_07", "character_iw8_al_qatala_urban_08_long_jacket"];

  switch (scripts\code\character::get_random_character(8, var0, var1)) {
    case 0:
      character\character_iw8_al_qatala_urban_01::main();
      break;
    case 1:
      character\character_iw8_al_qatala_urban_02::main();
      break;
    case 2:
      character\character_iw8_al_qatala_urban_03::main();
      break;
    case 3:
      character\character_iw8_al_qatala_urban_04::main();
      break;
    case 4:
      character\character_iw8_al_qatala_urban_05::main();
      break;
    case 5:
      character\character_iw8_al_qatala_urban_06::main();
      break;
    case 6:
      character\character_iw8_al_qatala_urban_07::main();
      break;
    case 7:
      character\character_iw8_al_qatala_urban_08_long_jacket::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_iw8_al_qatala_urban_01::precache();
  character\character_iw8_al_qatala_urban_02::precache();
  character\character_iw8_al_qatala_urban_03::precache();
  character\character_iw8_al_qatala_urban_04::precache();
  character\character_iw8_al_qatala_urban_05::precache();
  character\character_iw8_al_qatala_urban_06::precache();
  character\character_iw8_al_qatala_urban_07::precache();
  character\character_iw8_al_qatala_urban_08_long_jacket::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_lm_pkilo");
  precacheitem("iw8_lm_mgolf34");
  precacheitem("iw8_pi_mike1911");
  precacheitem("frag");
}