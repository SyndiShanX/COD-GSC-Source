/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_isaac_monsoon.gsc
*****************************************/

#include character\c_mul_scientist_issac;

main() {
  self.accuracy = 0.2;
  self.animstatedef = "";
  self.animtree = "generic_human.atr";
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
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "beretta93r_sp";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "scar_sp";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  character\c_mul_scientist_issac::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_mul_scientist_issac::precache();
  precacheitem("scar_sp");
  precacheitem("beretta93r_sp");
  precacheitem("frag_grenade_sp");
}