/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_mpla_launcher_base_angola1.gsc
*********************************************************/

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
  self.weapon = "rpg_sp_angola";
  self setengagementmindist(700.0, 500.0);
  self setengagementmaxdist(1000.0, 1500.0);
  character\c_afr_mpla_2::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_afr_mpla_2::precache();
  precacheitem("rpg_sp_angola");
  precacheitem("browninghp_sp");
  precacheitem("frag_grenade_sp");
}