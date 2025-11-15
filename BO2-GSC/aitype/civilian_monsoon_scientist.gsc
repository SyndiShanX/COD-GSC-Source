/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_monsoon_scientist.gsc
*************************************************/

#include codescripts\character;
#include character\c_mul_scientists_1;
#include character\c_mul_scientists_2;
#include character\c_mul_scientists_3;
#include character\c_mul_scientists_4;

main() {
  self.accuracy = 0.2;
  self.animstatedef = "";
  self.animtree = "generic_human.atr";
  self.csvinclude = "";
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
  self.grenadeammo = 0;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "beretta93r_sp";
  self.subclass = "regular";
  self.team = "neutral";
  self.type = "human";
  self.weapon = "an94_sp";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  randchar = codescripts\character::get_random_character(4);

  switch (randchar) {
    case 0:
      character\c_mul_scientists_1::main();
      break;
    case 1:
      character\c_mul_scientists_2::main();
      break;
    case 2:
      character\c_mul_scientists_3::main();
      break;
    case 3:
      character\c_mul_scientists_4::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("neutral");
}

precache(ai_index) {
  character\c_mul_scientists_1::precache();
  character\c_mul_scientists_2::precache();
  character\c_mul_scientists_3::precache();
  character\c_mul_scientists_4::precache();
  precacheitem("an94_sp");
  precacheitem("beretta93r_sp");
  precacheitem("frag_grenade_sp");
}