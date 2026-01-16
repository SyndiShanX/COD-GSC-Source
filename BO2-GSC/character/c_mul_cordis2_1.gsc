/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_cordis2_1.gsc
*****************************************/

#include codescripts\character;
#include xmodelalias\c_mul_cordis_head_als;

main() {
  self setmodel("c_mul_cordis_body2_1");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_mul_cordis_head_als::main());
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_mul_cordis_body2_gear1";
  self attach(self.gearmodel, "", 1);
  self.voice = "terrorist";
  self.skeleton = "base";
  self.torsodmg1 = "c_mul_cordis_body2_1_g_upclean";
  self.torsodmg2 = "c_mul_cordis_body2_1_g_rarmoff";
  self.torsodmg3 = "c_mul_cordis_body2_1_g_larmoff";
  self.torsodmg5 = "c_mul_cordis_body2_1_g_behead";
  self.legdmg1 = "c_mul_cordis_body1_g_lowclean";
  self.legdmg2 = "c_mul_cordis_body1_g_rlegoff";
  self.legdmg3 = "c_mul_cordis_body1_g_llegoff";
  self.legdmg4 = "c_mul_cordis_body1_g_legsoff";
  self.gibspawn1 = "c_mul_cordis_body_g_rarmspawn";
  self.gibspawntag1 = "J_Elbow_RI";
  self.gibspawn2 = "c_mul_cordis_body_g_larmspawn";
  self.gibspawntag2 = "J_Elbow_LE";
  self.gibspawn3 = "c_mul_cordis_body_g_rlegspawn";
  self.gibspawntag3 = "J_Knee_RI";
  self.gibspawn4 = "c_mul_cordis_body_g_llegspawn";
  self.gibspawntag4 = "J_Knee_LE";
  self.gibspawn5 = "c_mul_cordis_g_headspawn";
  self.gibspawntag5 = "J_Neck";
}

precache() {
  precachemodel("c_mul_cordis_body2_1");
  codescripts\character::precachemodelarray(xmodelalias\c_mul_cordis_head_als::main());
  precachemodel("c_mul_cordis_body2_gear1");
  precachemodel("c_mul_cordis_body2_1_g_upclean");
  precachemodel("c_mul_cordis_body2_1_g_rarmoff");
  precachemodel("c_mul_cordis_body2_1_g_larmoff");
  precachemodel("c_mul_cordis_body2_1_g_behead");
  precachemodel("c_mul_cordis_body1_g_lowclean");
  precachemodel("c_mul_cordis_body1_g_rlegoff");
  precachemodel("c_mul_cordis_body1_g_llegoff");
  precachemodel("c_mul_cordis_body1_g_legsoff");
  precachemodel("c_mul_cordis_body_g_rarmspawn");
  precachemodel("c_mul_cordis_body_g_larmspawn");
  precachemodel("c_mul_cordis_body_g_rlegspawn");
  precachemodel("c_mul_cordis_body_g_llegspawn");
  precachemodel("c_mul_cordis_g_headspawn");
}