/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\so_ally_assault_base.gsc
*******************************************/

#include character\c_usa_seal6;

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
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "kard_sp";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "xm8_rts_sp";
  self setengagementmindist(300.0, 200.0);
  self setengagementmaxdist(512.0, 768.0);
  character\c_usa_seal6::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_seal6::precache();
  precacheitem("xm8_rts_sp");
  precacheitem("kard_sp");
  precacheitem("emp_grenade_sp");
}