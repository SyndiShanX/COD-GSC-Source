/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\so_ally_heavy_base.gsc
*****************************************/

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
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "kard_sp";
  self.subclass = "regular";
  self.team = "allies";
  self.type = "human";
  self.weapon = "mk48_reflex_sp";
  self setengagementmindist(500.0, 300.0);
  self setengagementmaxdist(600.0, 800.0);
  character\c_usa_seal6::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("allies");
}

precache(ai_index) {
  character\c_usa_seal6::precache();
  precacheitem("mk48_reflex_sp");
  precacheitem("kard_sp");
  precacheitem("frag_grenade_sp");
}