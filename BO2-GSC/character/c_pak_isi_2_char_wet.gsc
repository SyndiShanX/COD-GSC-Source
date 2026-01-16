/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_pak_isi_2_char_wet.gsc
**********************************************/

#include codescripts\character;
#include xmodelalias\c_pak_isi_head_char_wet_als;

main() {
  self setmodel("c_pak_isi_body_char_wet");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_pak_isi_head_char_wet_als::main());
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_pak_isi_gear2_char_wet";
  self attach(self.gearmodel, "", 1);
  self.voice = "isi";
  self.skeleton = "base";
  self.torsodmg1 = "c_pak_isi_body_ch_wt_g_upclean";
  self.torsodmg2 = "c_pak_isi_body_ch_wt_g_rarmoff";
  self.torsodmg3 = "c_pak_isi_body_ch_wt_g_larmoff";
  self.legdmg1 = "c_pak_isi_body_ch_wt_g_lowclean";
  self.legdmg2 = "c_pak_isi_body_ch_wt_g_rlegoff";
  self.legdmg3 = "c_pak_isi_body_ch_wt_g_llegoff";
  self.legdmg4 = "c_pak_isi_body_ch_wt_g_legsoff";
  self.gibspawn1 = "c_pak_isi_body_g_spawn_rarm";
  self.gibspawntag1 = "J_Elbow_RI";
  self.gibspawn2 = "c_pak_isi_body_g_spawn_larm";
  self.gibspawntag2 = "J_Elbow_LE";
  self.gibspawn3 = "c_pak_isi_body_g_spawn_rleg";
  self.gibspawntag3 = "J_Knee_RI";
  self.gibspawn4 = "c_pak_isi_body_g_spawn_lleg";
  self.gibspawntag4 = "J_Knee_LE";
}

precache() {
  precachemodel("c_pak_isi_body_char_wet");
  codescripts\character::precachemodelarray(xmodelalias\c_pak_isi_head_char_wet_als::main());
  precachemodel("c_pak_isi_gear2_char_wet");
  precachemodel("c_pak_isi_body_ch_wt_g_upclean");
  precachemodel("c_pak_isi_body_ch_wt_g_rarmoff");
  precachemodel("c_pak_isi_body_ch_wt_g_larmoff");
  precachemodel("c_pak_isi_body_ch_wt_g_lowclean");
  precachemodel("c_pak_isi_body_ch_wt_g_rlegoff");
  precachemodel("c_pak_isi_body_ch_wt_g_llegoff");
  precachemodel("c_pak_isi_body_ch_wt_g_legsoff");
  precachemodel("c_pak_isi_body_g_spawn_rarm");
  precachemodel("c_pak_isi_body_g_spawn_larm");
  precachemodel("c_pak_isi_body_g_spawn_rleg");
  precachemodel("c_pak_isi_body_g_spawn_lleg");
}