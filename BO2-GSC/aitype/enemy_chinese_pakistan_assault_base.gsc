/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_chinese_pakistan_assault_base.gsc
***************************************************************/

#include character\c_chn_pla_nogib;

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
  self.grenadeammo = 2;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "fnp45_sp";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "human";
  self.weapon = "tar21_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_chn_pla_nogib::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_chn_pla_nogib::precache();
  precacheitem("tar21_sp");
  precacheitem("fnp45_sp");
  precacheitem("frag_grenade_sp");
}