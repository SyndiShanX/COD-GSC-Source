/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_pdf_shotgun_base.gsc
*********************************************/

#include codescripts\character;
#include character\c_pan_pdf_heavy_panama_char;
#include character\c_pan_pdf_light_panama_char;
#include character\c_pan_pdf_medium_panama_char;

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
  self.sidearm = "browninghp_sp";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "human";
  self.weapon = "spas_sp";
  self setengagementmindist(250.0, 0.0);
  self setengagementmaxdist(700.0, 1000.0);
  randchar = codescripts\character::get_random_character(3);

  switch (randchar) {
    case 0:
      character\c_pan_pdf_heavy_panama_char::main();
      break;
    case 1:
      character\c_pan_pdf_light_panama_char::main();
      break;
    case 2:
      character\c_pan_pdf_medium_panama_char::main();
      break;
  }

  self setcharacterindex(randchar);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\c_pan_pdf_heavy_panama_char::precache();
  character\c_pan_pdf_light_panama_char::precache();
  character\c_pan_pdf_medium_panama_char::precache();
  precacheitem("spas_sp");
  precacheitem("browninghp_sp");
  precacheitem("frag_grenade_sp");
}