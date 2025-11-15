/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_digbat_assault_tackler.gsc
***************************************************/

#include character\c_pan_dingbats_hero;

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
  self.grenadeweapon = "molotov_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "browninghp_sp";
  self.subclass = "militia";
  self.team = "axis";
  self.type = "human";
  self.weapon = "ak47_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_pan_dingbats_hero::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_pan_dingbats_hero::precache();
  precacheitem("ak47_sp");
  precacheitem("browninghp_sp");
  precacheitem("molotov_sp");
}