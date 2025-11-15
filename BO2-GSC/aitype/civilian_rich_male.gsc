/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_rich_male.gsc
*****************************************/

#include codescripts\character;
#include character\c_mul_civ_rich_male_1;
#include character\c_mul_civ_rich_male_1_2;
#include character\c_mul_civ_rich_male_2;
#include character\c_mul_civ_rich_male_2_2;
#include character\c_mul_civ_rich_male_3;
#include character\c_mul_civ_rich_male_3_2;

main() {
  self.accuracy = 0.2;
  self.animstatedef = "";
  self.animtree = "generic_human.atr";
  self.csvinclude = "common_civilians.csv";
  self.demolockonhighlightdistance = 100;
  self.demolockonviewheightoffset1 = 8;
  self.demolockonviewheightoffset2 = 8;
  self.demolockonviewpitchmax1 = 60;
  self.demolockonviewpitchmax2 = 60;
  self.demolockonviewpitchmin1 = 0;
  self.demolockonviewpitchmin2 = 0;
  self.footstepfxtable = "";
  self.footstepprepend = "fly_step_civm";
  self.footstepscriptcallback = 0;
  self.grenadeammo = 0;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.subclass = "regular";
  self.team = "neutral";
  self.type = "human";
  self.weapon = "";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  randchar = codescripts\character::get_random_character(6);

  switch (randchar) {
    case 0:
      character\c_mul_civ_rich_male_1::main();
      break;
    case 1:
      character\c_mul_civ_rich_male_1_2::main();
      break;
    case 2:
      character\c_mul_civ_rich_male_2::main();
      break;
    case 3:
      character\c_mul_civ_rich_male_2_2::main();
      break;
    case 4:
      character\c_mul_civ_rich_male_3::main();
      break;
    case 5:
      character\c_mul_civ_rich_male_3_2::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("neutral");
}

precache(ai_index) {
  character\c_mul_civ_rich_male_1::precache();
  character\c_mul_civ_rich_male_1_2::precache();
  character\c_mul_civ_rich_male_2::precache();
  character\c_mul_civ_rich_male_2_2::precache();
  character\c_mul_civ_rich_male_3::precache();
  character\c_mul_civ_rich_male_3_2::precache();
  precacheitem("frag_grenade_sp");
}