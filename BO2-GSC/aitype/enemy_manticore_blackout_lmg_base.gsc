/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_manticore_blackout_lmg_base.gsc
***********************************************************/

#include character\c_mul_pmc_1;

main() {
  self.accuracy = 0.5;
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
  self.grenadeammo = 1;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "fiveseven_sp";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "human";
  self.weapon = "hk416_sp";
  self setengagementmindist(500.0, 400.0);
  self setengagementmaxdist(1000.0, 1200.0);
  character\c_mul_pmc_1::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_mul_pmc_1::precache();
  precacheitem("hk416_sp");
  precacheitem("fiveseven_sp");
  precacheitem("frag_grenade_sp");
}