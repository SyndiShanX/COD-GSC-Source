/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_pmc_haiti_drone_rigid.gsc
**************************************************/

#include character\c_mul_pmc_rigid_drone_1;

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
  self.sidearm = "kard_sp";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "human";
  self.weapon = "an94_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_mul_pmc_rigid_drone_1::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_mul_pmc_rigid_drone_1::precache();
  precacheitem("an94_sp");
  precacheitem("kard_sp");
  precacheitem("frag_grenade_sp");
}