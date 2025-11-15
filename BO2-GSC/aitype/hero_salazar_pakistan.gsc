/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_salazar_pakistan.gsc
********************************************/

#include character\c_usa_cia_combat_salazar_wt;

main() {
  self.accuracy = 1;
  self.animstatedef = "";
  self.animtree = "";
  self.csvinclude = "ai_anims_elite.csv";
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
  self.sidearm = "fnp45_sp";
  self.subclass = "elite";
  self.team = "allies";
  self.type = "human";
  self.weapon = "hk416_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  character\c_usa_cia_combat_salazar_wt::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_cia_combat_salazar_wt::precache();
  precacheitem("hk416_sp");
  precacheitem("fnp45_sp");
  precacheitem("frag_grenade_sp");
}