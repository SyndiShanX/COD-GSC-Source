/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_sco_haiti_lmg_base.gsc
**********************************************/

#include character\c_chn_pla_assault;

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
  self.grenadeweapon = "emp_grenade_sp";
  self.health = 150;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "kard_sp";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "qbb95_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_chn_pla_assault::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_chn_pla_assault::precache();
  precacheitem("qbb95_sp");
  precacheitem("kard_sp");
  precacheitem("emp_grenade_sp");
}