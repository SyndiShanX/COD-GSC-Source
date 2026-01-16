/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_afr_mpla_1.gsc
**************************************/

#include codescripts\character;
#include xmodelalias\c_afr_mpla_head_als;
#include xmodelalias\c_afr_mpla_headgear_als;
#include xmodelalias\c_afr_mpla_body1_gear_als;

main() {
  self setmodel("c_afr_mpla_body1");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_afr_mpla_head_als::main());
  self attach(self.headmodel, "", 1);
  self.hatmodel = codescripts\character::randomelement(xmodelalias\c_afr_mpla_headgear_als::main());
  self attach(self.hatmodel, "", 1);
  self.gearmodel = codescripts\character::randomelement(xmodelalias\c_afr_mpla_body1_gear_als::main());
  self attach(self.gearmodel, "", 1);
  self.voice = "unita";
  self.skeleton = "base";
  self.torsodmg1 = "c_afr_mpla_body1_g_upclean";
  self.torsodmg2 = "c_afr_mpla_body1_g_rarmoff";
  self.torsodmg3 = "c_afr_mpla_body1_g_larmoff";
  self.torsodmg5 = "c_afr_mpla_body1_g_behead";
  self.legdmg1 = "c_afr_mpla_body1_g_lowclean";
  self.legdmg2 = "c_afr_mpla_body_g_rlegoff";
  self.legdmg3 = "c_afr_mpla_body_g_llegoff";
  self.legdmg4 = "c_afr_mpla_body_g_legsoff";
  self.gibspawn1 = "c_afr_mpla_spawn_rarm";
  self.gibspawntag1 = "J_Elbow_RI";
  self.gibspawn2 = "c_afr_mpla_spawn_larm";
  self.gibspawntag2 = "J_Elbow_LE";
  self.gibspawn3 = "c_afr_mpla_spawn_rleg";
  self.gibspawntag3 = "J_Knee_RI";
  self.gibspawn4 = "c_afr_mpla_spawn_lleg";
  self.gibspawntag4 = "J_Knee_LE";
  self.gibspawn5 = "c_afr_mpla_spawn_head2";
  self.gibspawntag5 = "J_Neck";
}

precache() {
  precachemodel("c_afr_mpla_body1");
  codescripts\character::precachemodelarray(xmodelalias\c_afr_mpla_head_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_afr_mpla_headgear_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_afr_mpla_body1_gear_als::main());
  precachemodel("c_afr_mpla_body1_g_upclean");
  precachemodel("c_afr_mpla_body1_g_rarmoff");
  precachemodel("c_afr_mpla_body1_g_larmoff");
  precachemodel("c_afr_mpla_body1_g_behead");
  precachemodel("c_afr_mpla_body1_g_lowclean");
  precachemodel("c_afr_mpla_body_g_rlegoff");
  precachemodel("c_afr_mpla_body_g_llegoff");
  precachemodel("c_afr_mpla_body_g_legsoff");
  precachemodel("c_afr_mpla_spawn_rarm");
  precachemodel("c_afr_mpla_spawn_larm");
  precachemodel("c_afr_mpla_spawn_rleg");
  precachemodel("c_afr_mpla_spawn_lleg");
  precachemodel("c_afr_mpla_spawn_head2");
}