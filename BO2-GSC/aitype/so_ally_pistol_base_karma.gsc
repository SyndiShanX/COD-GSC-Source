/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\so_ally_pistol_base_karma.gsc
************************************************/

#include character\c_usa_chloe_strikef;
#include animscripts\aitype\aitype_pistol;

main() {
  self.accuracy = 0.2;
  self.animstatedef = "";
  self.animtree = "";
  self.csvinclude = "ai_anims_pistol.csv";
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
  self.precachescript = "aitype_pistol.gsc";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "m1911_sp";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  character\c_usa_chloe_strikef::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_chloe_strikef::precache();
  precacheitem("m1911_sp");
  precacheitem("frag_grenade_sp");
  animscripts\aitype\aitype_pistol::precache();
}