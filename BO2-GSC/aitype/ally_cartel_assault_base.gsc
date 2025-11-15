/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_cartel_assault_base.gsc
***********************************************/

#include codescripts\character;
#include character\c_mul_cartel1_1_char;
#include character\c_mul_cartel1_2_char;
#include character\c_mul_cartel1_3_char;

main() {
  self.accuracy = 1;
  self.animstatedef = "";
  self.animtree = "";
  self.csvinclude = "subclass_militia";
  self.demolockonhighlightdistance = 100;
  self.demolockonviewheightoffset1 = 8;
  self.demolockonviewheightoffset2 = 8;
  self.demolockonviewpitchmax1 = 60;
  self.demolockonviewpitchmax2 = 60;
  self.demolockonviewpitchmin1 = 0;
  self.demolockonviewpitchmin2 = 0;
  self.footstepfxtable = "";
  self.footstepprepend = "";
  self.footstepscriptcallback = 0;
  self.grenadeammo = 2;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "browninghp_sp";
  self.subclass = "militia";
  self.team = "allies";
  self.type = "human";
  self.weapon = "ak47_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  randchar = codescripts\character::get_random_character(3);

  switch (randchar) {
    case 0:
      character\c_mul_cartel1_1_char::main();
      break;
    case 1:
      character\c_mul_cartel1_2_char::main();
      break;
    case 2:
      character\c_mul_cartel1_3_char::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_mul_cartel1_1_char::precache();
  character\c_mul_cartel1_2_char::precache();
  character\c_mul_cartel1_3_char::precache();
  precacheitem("ak47_sp");
  precacheitem("browninghp_sp");
  precacheitem("frag_grenade_sp");
}