/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_panama_female.gsc
*********************************************/

#include codescripts\character;
#include character\c_pan_civ_female_1;
#include character\c_pan_civ_female_2;

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
  self.sidearm = "m1911_sp";
  self.subclass = "regular";
  self.team = "neutral";
  self.type = "human";
  self.weapon = "ak47_sp";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  randchar = codescripts\character::get_random_character(2);

  switch (randchar) {
    case 0:
      character\c_pan_civ_female_1::main();
      break;
    case 1:
      character\c_pan_civ_female_2::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("neutral");
}

precache(ai_index) {
  character\c_pan_civ_female_1::precache();
  character\c_pan_civ_female_2::precache();
  precacheitem("ak47_sp");
  precacheitem("m1911_sp");
  precacheitem("frag_grenade_sp");
}