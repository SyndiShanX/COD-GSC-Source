/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\civilian_uk_cold_male.gsc
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
  var0 = undefined;
  var1 = ["civ_london_male_skintone_light", "civ_london_male_skintone_med"];

  switch (scripts\code\character::get_random_character(2, var0, var1)) {
    case 0:
      character\civ_london_male_skintone_light::main();
      break;
    case 1:
      character\civ_london_male_skintone_med::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(var0) {
  character\civ_london_male_skintone_light::precache();
  character\civ_london_male_skintone_med::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
  behaviortree\civilian::registerbehaviortree();
  aiasm\civilian_sp::asm_register();
}