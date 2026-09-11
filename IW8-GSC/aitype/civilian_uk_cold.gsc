/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\civilian_uk_cold.gsc
***********************************************/

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
  var0 = [0.063, 0.125, 0.188, 0.25, 0.313, 0.375, 0.438, 0.5, 0.75, 1];
  var1 = ["civ_london_female_02_skintone_light", "civ_london_female_02_skintone_med", "civ_london_female_02_skintone_dark", "civ_london_female_03_skintone_light", "civ_london_female_03_skintone_med", "civ_london_female_03_skintone_dark", "civ_london_female_skintone_light", "civ_london_female_skintone_med", "civ_london_male_skintone_light", "civ_london_male_skintone_med"];

  switch (scripts\code\character::get_random_character(10, var0, var1)) {
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
      character\civ_london_female_03_skintone_light::main();
      break;
    case 4:
      character\civ_london_female_03_skintone_med::main();
      break;
    case 5:
      character\civ_london_female_03_skintone_dark::main();
      break;
    case 6:
      character\civ_london_female_skintone_light::main();
      break;
    case 7:
      character\civ_london_female_skintone_med::main();
      break;
    case 8:
      character\civ_london_male_skintone_light::main();
      break;
    case 9:
      character\civ_london_male_skintone_med::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(var0) {
  character\civ_london_female_02_skintone_light::precache();
  character\civ_london_female_02_skintone_med::precache();
  character\civ_london_female_02_skintone_dark::precache();
  character\civ_london_female_03_skintone_light::precache();
  character\civ_london_female_03_skintone_med::precache();
  character\civ_london_female_03_skintone_dark::precache();
  character\civ_london_female_skintone_light::precache();
  character\civ_london_female_skintone_med::precache();
  character\civ_london_male_skintone_light::precache();
  character\civ_london_male_skintone_med::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
  behaviortree\civilian::registerbehaviortree();
  aiasm\civilian_sp::asm_register();
}