/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_menendez_panama.gsc
*******************************************/

#include character\c_mul_menendez_drugged;

main() {
  self.accuracy = 1;
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
  self.grenadeweapon = "flash_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "m1911_sp";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "human";
  self.weapon = "spas_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_mul_menendez_drugged::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_mul_menendez_drugged::precache();
  precacheitem("spas_sp");
  precacheitem("m1911_sp");
  precacheitem("flash_grenade_sp");
}