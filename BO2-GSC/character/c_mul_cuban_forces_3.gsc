/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_cuban_forces_3.gsc
**********************************************/

#include codescripts\character;
#include xmodelalias\c_mul_cuban_forces_gear_als;

main() {
  self setmodel("c_mul_cuban_forces_body1");
  self.headmodel = "c_mul_cuban_forces_head3";
  self attach(self.headmodel, "", 1);
  self.gearmodel = codescripts\character::randomelement(xmodelalias\c_mul_cuban_forces_gear_als::main());
  self attach(self.gearmodel, "", 1);
  self.voice = "cuban";
  self.skeleton = "base";
  self.torsodmg1 = "c_mul_cuban_forces_body_g_upclean";
  self.torsodmg2 = "c_mul_cuban_forces_body_g_ramoff";
  self.torsodmg3 = "c_mul_cuban_forces_body_g_larmoff";
  self.torsodmg5 = "c_mul_cuban_forces_body_g_behead";
  self.legdmg1 = "c_mul_cuban_forces_body_g_lowclean";
  self.legdmg2 = "c_mul_cuban_forces_body_g_rlegoff";
  self.legdmg3 = "c_mul_cuban_forces_body_g_llegoff";
  self.legdmg4 = "c_mul_cuban_forces_body_g_legsoff";
  self.gibspawn1 = "c_pan_pdf_g_rarmspawn";
  self.gibspawntag1 = "J_Elbow_RI";
  self.gibspawn2 = "c_pan_pdf_g_larmspawn";
  self.gibspawntag2 = "J_Elbow_LE";
  self.gibspawn3 = "c_afr_mpla_spawn_rleg";
  self.gibspawntag3 = "J_Knee_RI";
  self.gibspawn4 = "c_afr_mpla_spawn_lleg";
  self.gibspawntag4 = "J_Knee_LE";
  self.gibspawn5 = "c_pan_pdf_g_headspawn";
  self.gibspawntag5 = "J_Neck";
}

precache() {
  precachemodel("c_mul_cuban_forces_body1");
  precachemodel("c_mul_cuban_forces_head3");
  codescripts\character::precachemodelarray(xmodelalias\c_mul_cuban_forces_gear_als::main());
  precachemodel("c_mul_cuban_forces_body_g_upclean");
  precachemodel("c_mul_cuban_forces_body_g_ramoff");
  precachemodel("c_mul_cuban_forces_body_g_larmoff");
  precachemodel("c_mul_cuban_forces_body_g_behead");
  precachemodel("c_mul_cuban_forces_body_g_lowclean");
  precachemodel("c_mul_cuban_forces_body_g_rlegoff");
  precachemodel("c_mul_cuban_forces_body_g_llegoff");
  precachemodel("c_mul_cuban_forces_body_g_legsoff");
  precachemodel("c_pan_pdf_g_rarmspawn");
  precachemodel("c_pan_pdf_g_larmspawn");
  precachemodel("c_afr_mpla_spawn_rleg");
  precachemodel("c_afr_mpla_spawn_lleg");
  precachemodel("c_pan_pdf_g_headspawn");
}