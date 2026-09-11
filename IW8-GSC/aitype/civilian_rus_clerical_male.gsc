/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\civilian_rus_clerical_male.gsc
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
  var1 = ["character_civ_male_rus_clerical_1", "character_civ_male_rus_clerical_2", "character_civ_male_rus_clerical_3"];

  switch (scripts\code\character::get_random_character(3, var0, var1)) {
    case 0:
      character\character_civ_male_rus_clerical_1::main();
      break;
    case 1:
      character\character_civ_male_rus_clerical_2::main();
      break;
    case 2:
      character\character_civ_male_rus_clerical_3::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(var0) {
  character\character_civ_male_rus_clerical_1::precache();
  character\character_civ_male_rus_clerical_2::precache();
  character\character_civ_male_rus_clerical_3::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
  behaviortree\civilian::registerbehaviortree();
  aiasm\civilian_sp::asm_register();
}