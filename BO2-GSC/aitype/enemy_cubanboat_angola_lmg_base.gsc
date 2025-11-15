/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_cubanboat_angola_lmg_base.gsc
*******************************************************/

#include codescripts\character;
#include character\c_afr_mpla_1;
#include character\c_afr_mpla_2;

main() {
  self.accuracy = 1;
  self.animstatedef = "";
  self.animtree = "";
  self.csvinclude = "subclass_militia.csv";
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
  self.team = "axis";
  self.type = "human";
  self.weapon = "rpd_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  randchar = codescripts\character::get_random_character(2);

  switch (randchar) {
    case 0:
      character\c_afr_mpla_1::main();
      break;
    case 1:
      character\c_afr_mpla_2::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_afr_mpla_1::precache();
  character\c_afr_mpla_2::precache();
  precacheitem("rpd_sp");
  precacheitem("browninghp_sp");
  precacheitem("frag_grenade_sp");
}