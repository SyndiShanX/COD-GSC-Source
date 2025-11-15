/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_karma_blackout.gsc
******************************************/

#include character\c_usa_chloe_cc_cin;

main() {
  self.accuracy = 0.2;
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
  self.secondaryweapon = "";
  self.sidearm = "fiveseven_sp";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "xm8_extclip_sp";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  character\c_usa_chloe_cc_cin::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_chloe_cc_cin::precache();
  precacheitem("xm8_extclip_sp");
  precacheitem("fiveseven_sp");
  precacheitem("frag_grenade_sp");
}