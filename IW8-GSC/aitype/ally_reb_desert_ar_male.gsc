/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_reb_desert_ar_male.gsc
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
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_ar_akilo47", "iw8_ar_falpha"]);
  var_0 = undefined;
  var_1 = ["character_sla_rebels_male_ar", "character_sla_rebels_male_ar_2_1", "character_sla_rebels_male_cqb", "character_sla_rebels_male_cqb_2_1", "character_sla_rebels_male_lmg", "character_sla_rebels_male_lmg_2_1"];

  switch (scripts\code\character::get_random_character(6, var_0, var_1)) {
    case 0:
      character\character_sla_rebels_male_ar::main();
      break;
    case 1:
      character\character_sla_rebels_male_ar_2_1::main();
      break;
    case 2:
      character\character_sla_rebels_male_cqb::main();
      break;
    case 3:
      character\character_sla_rebels_male_cqb_2_1::main();
      break;
    case 4:
      character\character_sla_rebels_male_lmg::main();
      break;
    case 5:
      character\character_sla_rebels_male_lmg_2_1::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(var_0) {
  character\character_sla_rebels_male_ar::precache();
  character\character_sla_rebels_male_ar_2_1::precache();
  character\character_sla_rebels_male_cqb::precache();
  character\character_sla_rebels_male_cqb_2_1::precache();
  character\character_sla_rebels_male_lmg::precache();
  character\character_sla_rebels_male_lmg_2_1::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_ar_akilo47");
  precacheitem("iw8_ar_falpha");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}