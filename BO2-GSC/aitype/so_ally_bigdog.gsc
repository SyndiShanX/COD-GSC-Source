/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\so_ally_bigdog.gsc
**************************************/

#include character\c_t6_claw_mk2;
#include animscripts\aitype\aitype_bigdog;

main() {
  self.accuracy = 1;
  self.animstatedef = "";
  self.animtree = "\\bigdog.atr";
  self.csvinclude = "char_bigdog.csv";
  self.demolockonhighlightdistance = 100;
  self.demolockonviewheightoffset1 = 8;
  self.demolockonviewheightoffset2 = 8;
  self.demolockonviewpitchmax1 = 60;
  self.demolockonviewpitchmax2 = 60;
  self.demolockonviewpitchmin1 = 0;
  self.demolockonviewpitchmin2 = 0;
  self.footstepfxtable = "";
  self.footstepprepend = "";
  self.footstepscriptcallback = 1;
  self.grenadeammo = 0;
  self.grenadeweapon = "claw_grenade_sp";
  self.health = 2000;
  self.precachescript = "aitype_bigdog.gsc";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "bigdog";
  self.weapon = "";
  self setengagementmindist(500.0, 300.0);
  self setengagementmaxdist(800.0, 1200.0);
  character\c_t6_claw_mk2::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_t6_claw_mk2::precache();
  precacheitem("claw_grenade_sp");
  animscripts\aitype\aitype_bigdog::precache();
}