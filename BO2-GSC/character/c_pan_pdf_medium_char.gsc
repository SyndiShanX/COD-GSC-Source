/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_pan_pdf_medium_char.gsc
***********************************************/

#include codescripts\character;
#include xmodelalias\c_pan_pdf_gear_char_als;

main() {
  self setmodel("c_pan_pdf_body1_char");
  self.headmodel = "c_pan_pdf_head2_char";
  self attach(self.headmodel, "", 1);
  self.gearmodel = codescripts\character::randomelement(xmodelalias\c_pan_pdf_gear_char_als::main());
  self attach(self.gearmodel, "", 1);
  self.voice = "pdf";
  self.skeleton = "base";
  self.torsodmg1 = "c_pan_pdf_body1_ch_g_upclean";
  self.torsodmg2 = "c_pan_pdf_body1_ch_g_rarmoff";
  self.torsodmg3 = "c_pan_pdf_body1_ch_g_larmoff";
  self.torsodmg5 = "c_pan_pdf_body1_ch_g_behead";
  self.legdmg1 = "c_pan_pdf_body1_ch_g_lowclean";
  self.legdmg2 = "c_pan_pdf_body1_ch_g_rlegoff";
  self.legdmg3 = "c_pan_pdf_body1_ch_g_llegoff";
  self.legdmg4 = "c_pan_pdf_body1_ch_g_legsoff";
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
  precachemodel("c_pan_pdf_body1_char");
  precachemodel("c_pan_pdf_head2_char");
  codescripts\character::precachemodelarray(xmodelalias\c_pan_pdf_gear_char_als::main());
  precachemodel("c_pan_pdf_body1_ch_g_upclean");
  precachemodel("c_pan_pdf_body1_ch_g_rarmoff");
  precachemodel("c_pan_pdf_body1_ch_g_larmoff");
  precachemodel("c_pan_pdf_body1_ch_g_behead");
  precachemodel("c_pan_pdf_body1_ch_g_lowclean");
  precachemodel("c_pan_pdf_body1_ch_g_rlegoff");
  precachemodel("c_pan_pdf_body1_ch_g_llegoff");
  precachemodel("c_pan_pdf_body1_ch_g_legsoff");
  precachemodel("c_pan_pdf_g_rarmspawn");
  precachemodel("c_pan_pdf_g_larmspawn");
  precachemodel("c_afr_mpla_spawn_rleg");
  precachemodel("c_afr_mpla_spawn_lleg");
  precachemodel("c_pan_pdf_g_headspawn");
}