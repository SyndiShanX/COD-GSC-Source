/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_alq_desert_unarmed.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = isundefinedweapon();
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
  self.weapon = isundefinedweapon();
  var_0 = undefined;
  var_1 = ["character_al_qatala_desert_ar", "character_al_qatala_desert_ar_2", "character_al_qatala_desert_ar_3", "character_al_qatala_desert_ar_4", "character_al_qatala_desert_cqc", "character_al_qatala_desert_lmg"];

  switch (scripts\code\character::get_random_character(6, var_0, var_1)) {
    case 0:
      character\character_al_qatala_desert_ar::main();
      break;
    case 1:
      character\character_al_qatala_desert_ar_2::main();
      break;
    case 2:
      character\character_al_qatala_desert_ar_3::main();
      break;
    case 3:
      character\character_al_qatala_desert_ar_4::main();
      break;
    case 4:
      character\character_al_qatala_desert_cqc::main();
      break;
    case 5:
      character\character_al_qatala_desert_lmg::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var_0) {
  character\character_al_qatala_desert_ar::precache();
  character\character_al_qatala_desert_ar_2::precache();
  character\character_al_qatala_desert_ar_3::precache();
  character\character_al_qatala_desert_ar_4::precache();
  character\character_al_qatala_desert_cqc::precache();
  character\character_al_qatala_desert_lmg::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
}