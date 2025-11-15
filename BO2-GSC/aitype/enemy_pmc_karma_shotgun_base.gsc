/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_pmc_karma_shotgun_base.gsc
***************************************************/

#include character\c_mul_pmc_1_ol;

main() {
  self.accuracy = 0.2;
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
  self.grenadeammo = 2;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "fiveseven_sp";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "human";
  self.weapon = "ksg_sp";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  character\c_mul_pmc_1_ol::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_mul_pmc_1_ol::precache();
  precacheitem("ksg_sp");
  precacheitem("fiveseven_sp");
  precacheitem("frag_grenade_sp");
}