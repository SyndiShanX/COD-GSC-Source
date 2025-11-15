/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_seal_haiti_wingsuit.gsc
***********************************************/

#include character\c_usa_seal6_wingsuit_helm;

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
  self.grenadeammo = 0;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 150;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "fnp45_sp";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "xm8_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_usa_seal6_wingsuit_helm::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_seal6_wingsuit_helm::precache();
  precacheitem("xm8_sp");
  precacheitem("fnp45_sp");
  precacheitem("frag_grenade_sp");
}