/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_mason_nicaragua.gsc
*******************************************/

#include character\c_usa_nicaragua_mason;

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
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "uzi_sp";
  self.sidearm = "";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "ak47_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_usa_nicaragua_mason::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_nicaragua_mason::precache();
  precacheitem("ak47_sp");
  precacheitem("uzi_sp");
  precacheitem("frag_grenade_sp");
}