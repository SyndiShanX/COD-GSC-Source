/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\civilian_uk_cold_female_nohood.gsc
*****************************************************/

function main() {
  self.additionalassets = "";
  self.team = "neutral";
  self.type = "human";
  self.unittype = "civilian";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 30;
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = isundefinedweapon();
  self.behaviortreeasset = "civilian";
  self.asmasset = "civilian";
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
  var_1 = ["civ_london_female_02_skintone_light", "civ_london_female_02_skintone_med", "civ_london_female_02_skintone_dark", "civ_london_female_skintone_light", "civ_london_female_skintone_med", "civ_london_female_skintone_light_anim_safe", "civ_london_female_skintone_med_anim_safe"];

  switch (scripts\code\character::get_random_character(7, var_0, var_1)) {
    case 0:
      character\civ_london_female_02_skintone_light::main();
      break;
    case 1:
      character\civ_london_female_02_skintone_med::main();
      break;
    case 2:
      character\civ_london_female_02_skintone_dark::main();
      break;
    case 3:
      character\civ_london_female_skintone_light::main();
      break;
    case 4:
      character\civ_london_female_skintone_med::main();
      break;
    case 5:
      character\civ_london_female_skintone_light_anim_safe::main();
      break;
    case 6:
      character\civ_london_female_skintone_med_anim_safe::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(var_0) {
  character\civ_london_female_02_skintone_light::precache();
  character\civ_london_female_02_skintone_med::precache();
  character\civ_london_female_02_skintone_dark::precache();
  character\civ_london_female_skintone_light::precache();
  character\civ_london_female_skintone_med::precache();
  character\civ_london_female_skintone_light_anim_safe::precache();
  character\civ_london_female_skintone_med_anim_safe::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
  behaviortree\civilian::registerbehaviortree();
  aiasm\civilian_sp::asm_register();
}