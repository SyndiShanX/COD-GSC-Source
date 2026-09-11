/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_reb_desert_lmg.gsc
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
    self setengagementmindist(512, 400);
    self setengagementmaxdist(1024, 1250);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "lmg";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_lm_mgolf34"]);
  var0 = undefined;
  var1 = ["character_sla_rebels_male_ar", "character_sla_rebels_male_ar_2_1", "character_sla_rebels_male_cqb", "character_sla_rebels_male_cqb_2_1", "character_sla_rebels_male_lmg", "character_sla_rebels_male_lmg_2_1", "character_iw8_sla_rebel_female_1_1", "character_iw8_sla_rebel_female_2_1", "character_iw8_sla_rebel_female_3_1", "character_iw8_sla_rebel_female_4_1", "character_iw8_sla_rebel_female_5_1", "character_iw8_sla_rebel_female_6_1"];

  switch (scripts\code\character::get_random_character(12, var0, var1)) {
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
    case 6:
      character\character_iw8_sla_rebel_female_1_1::main();
      break;
    case 7:
      character\character_iw8_sla_rebel_female_2_1::main();
      break;
    case 8:
      character\character_iw8_sla_rebel_female_3_1::main();
      break;
    case 9:
      character\character_iw8_sla_rebel_female_4_1::main();
      break;
    case 10:
      character\character_iw8_sla_rebel_female_5_1::main();
      break;
    case 11:
      character\character_iw8_sla_rebel_female_6_1::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(var0) {
  character\character_sla_rebels_male_ar::precache();
  character\character_sla_rebels_male_ar_2_1::precache();
  character\character_sla_rebels_male_cqb::precache();
  character\character_sla_rebels_male_cqb_2_1::precache();
  character\character_sla_rebels_male_lmg::precache();
  character\character_sla_rebels_male_lmg_2_1::precache();
  character\character_iw8_sla_rebel_female_1_1::precache();
  character\character_iw8_sla_rebel_female_2_1::precache();
  character\character_iw8_sla_rebel_female_3_1::precache();
  character\character_iw8_sla_rebel_female_4_1::precache();
  character\character_iw8_sla_rebel_female_5_1::precache();
  character\character_iw8_sla_rebel_female_6_1::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_lm_mgolf34");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}