/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_navy_blackout_pistol_base.gsc
*****************************************************/

#include codescripts\character;
#include character\c_usa_navy_1;
#include character\c_usa_navy_2;
#include character\c_usa_navy_3;
#include character\c_usa_navy_4;

main() {
  self.accuracy = 1;
  self.animstatedef = "";
  self.animtree = "";
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
  self.sidearm = "";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "fiveseven_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  randchar = codescripts\character::get_random_character(4);

  switch (randchar) {
    case 0:
      character\c_usa_navy_1::main();
      break;
    case 1:
      character\c_usa_navy_2::main();
      break;
    case 2:
      character\c_usa_navy_3::main();
      break;
    case 3:
      character\c_usa_navy_4::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_navy_1::precache();
  character\c_usa_navy_2::precache();
  character\c_usa_navy_3::precache();
  character\c_usa_navy_4::precache();
  precacheitem("fiveseven_sp");
  precacheitem("frag_grenade_sp");
}