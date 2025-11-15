/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_mpla_lmg_base_angola1.gsc
**************************************************/

#include character\c_afr_mpla_2;

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
  self setengagementmindist(500.0, 400.0);
  self setengagementmaxdist(1000.0, 1200.0);
  character\c_afr_mpla_2::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_afr_mpla_2::precache();
  precacheitem("rpd_sp");
  precacheitem("browninghp_sp");
  precacheitem("frag_grenade_sp");
}