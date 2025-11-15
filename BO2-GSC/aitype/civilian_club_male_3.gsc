/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_club_male_3.gsc
*******************************************/

#include character\c_mul_civ_club_male_jckt_ts;

main() {
  self.accuracy = 0.2;
  self.animstatedef = "";
  self.animtree = "generic_human.atr";
  self.csvinclude = "common_civilians.csv";
  self.demolockonhighlightdistance = 100;
  self.demolockonviewheightoffset1 = 8;
  self.demolockonviewheightoffset2 = 8;
  self.demolockonviewpitchmax1 = 60;
  self.demolockonviewpitchmax2 = 60;
  self.demolockonviewpitchmin1 = 0;
  self.demolockonviewpitchmin2 = 0;
  self.footstepfxtable = "";
  self.footstepprepend = "fly_step_civm";
  self.footstepscriptcallback = 0;
  self.grenadeammo = 0;
  self.grenadeweapon = "frag_grenade_sp";
  self.health = 100;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.subclass = "regular";
  self.team = "neutral";
  self.type = "human";
  self.weapon = "";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  character\c_mul_civ_club_male_jckt_ts::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("neutral");
}

precache(ai_index) {
  character\c_mul_civ_club_male_jckt_ts::precache();
  precacheitem("frag_grenade_sp");
}