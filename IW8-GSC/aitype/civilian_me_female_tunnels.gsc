/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\civilian_me_female_tunnels.gsc
*************************************************/

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
  var1 = ["civ_syrkistan_female_scarf_green", "civ_syrkistan_female_scarf_long_blue", "civ_syrkistan_female_scarf_dress_pink", "civ_syrkistan_female_scarf_dress_blue", "civ_syrkistan_female_scarf_dress_orange", "civ_syrkistan_female_scarf_long_brown"];

  switch (scripts\code\character::get_random_character(6, var0, var1)) {
    case 0:
      character\civ_syrkistan_female_scarf_green::main();
      break;
    case 1:
      character\civ_syrkistan_female_scarf_long_blue::main();
      break;
    case 2:
      character\civ_syrkistan_female_scarf_dress_pink::main();
      break;
    case 3:
      character\civ_syrkistan_female_scarf_dress_blue::main();
      break;
    case 4:
      character\civ_syrkistan_female_scarf_dress_orange::main();
      break;
    case 5:
      character\civ_syrkistan_female_scarf_long_brown::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(var0) {
  character\civ_syrkistan_female_scarf_green::precache();
  character\civ_syrkistan_female_scarf_long_blue::precache();
  character\civ_syrkistan_female_scarf_dress_pink::precache();
  character\civ_syrkistan_female_scarf_dress_blue::precache();
  character\civ_syrkistan_female_scarf_dress_orange::precache();
  character\civ_syrkistan_female_scarf_long_brown::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
  behaviortree\civilian::registerbehaviortree();
  aiasm\civilian_sp::asm_register();
}