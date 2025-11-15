/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_pmc_monsoon_smg_camo_base_w.gsc
***********************************************************/

#include character\c_mul_pmc_cloak_wt;

main() {
  self.accuracy = 0.5;
  self.animstatedef = "";
  self.animtree = "";
  self.csvinclude = "char_spetsnaz.csv";
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
  self.grenadeweapon = "emp_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "beretta93r_sp";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "human";
  self.weapon = "evoskorpion_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_mul_pmc_cloak_wt::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_mul_pmc_cloak_wt::precache();
  precacheitem("evoskorpion_sp");
  precacheitem("beretta93r_sp");
  precacheitem("emp_grenade_sp");
}