/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\civilian_uk_office_worker_male.gsc
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
  var0 = undefined;
  var1 = ["civ_embassy_office_worker_male_1_1", "civ_embassy_office_worker_male_1_2", "civ_embassy_office_worker_male_1_3", "civ_embassy_office_worker_male_2_1", "civ_embassy_office_worker_male_2_2", "civ_embassy_office_worker_male_2_3", "civ_embassy_office_worker_male_2_4", "civ_embassy_office_worker_male_2_3", "civ_embassy_office_worker_male_2_4"];

  switch (scripts\code\character::get_random_character(9, var0, var1)) {
    case 0:
      character\civ_embassy_office_worker_male_1_1::main();
      break;
    case 1:
      character\civ_embassy_office_worker_male_1_2::main();
      break;
    case 2:
      character\civ_embassy_office_worker_male_1_3::main();
      break;
    case 3:
      character\civ_embassy_office_worker_male_2_1::main();
      break;
    case 4:
      character\civ_embassy_office_worker_male_2_2::main();
      break;
    case 5:
      character\civ_embassy_office_worker_male_2_3::main();
      break;
    case 6:
      character\civ_embassy_office_worker_male_2_4::main();
      break;
    case 7:
      character\civ_embassy_office_worker_male_2_3::main();
      break;
    case 8:
      character\civ_embassy_office_worker_male_2_4::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("neutral");
}

function precache(var0) {
  character\civ_embassy_office_worker_male_1_1::precache();
  character\civ_embassy_office_worker_male_1_2::precache();
  character\civ_embassy_office_worker_male_1_3::precache();
  character\civ_embassy_office_worker_male_2_1::precache();
  character\civ_embassy_office_worker_male_2_2::precache();
  character\civ_embassy_office_worker_male_2_3::precache();
  character\civ_embassy_office_worker_male_2_4::precache();
  character\civ_embassy_office_worker_male_2_3::precache();
  character\civ_embassy_office_worker_male_2_4::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::civilian();
  behaviortree\civilian::registerbehaviortree();
  aiasm\civilian_sp::asm_register();
}