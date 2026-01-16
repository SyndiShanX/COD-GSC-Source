/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_yem_repguard_1.gsc
******************************************/

#include codescripts\character;
#include xmodelalias\c_yem_repguard_head_als;

main() {
  self setmodel("c_yem_repguard_body");
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_yem_repguard_head_als::main());
  self attach(self.headmodel, "", 1);
  self.gearmodel = "c_yem_repguard_gear1";
  self attach(self.gearmodel, "", 1);
  self.voice = "yemeni";
  self.skeleton = "base";
  self.torsodmg1 = "c_yem_repguard_body_g_upclean";
  self.torsodmg2 = "c_yem_repguard_body_g_rarmoff";
  self.torsodmg3 = "c_yem_repguard_body_g_larmoff";
  self.torsodmg5 = "c_yem_repguard_body_g_behead";
  self.legdmg1 = "c_yem_repguard_body_g_lowclean";
  self.legdmg2 = "c_yem_repguard_body_g_rlegoff";
  self.legdmg3 = "c_yem_repguard_body_g_llegoff";
  self.legdmg4 = "c_yem_repguard_body_g_legsoff";
  self.gibspawn1 = "c_yem_repguard_g_spawn_rarm";
  self.gibspawntag1 = "J_Elbow_RI";
  self.gibspawn2 = "c_yem_repguard_g_spawn_larm";
  self.gibspawntag2 = "J_Elbow_LE";
  self.gibspawn3 = "c_yem_repguard_g_spawn_rleg";
  self.gibspawntag3 = "J_Knee_RI";
  self.gibspawn4 = "c_yem_repguard_g_spawn_lleg";
  self.gibspawntag4 = "J_Knee_LE";
  self.gibspawn5 = "c_yem_repguard_g_headspawn";
  self.gibspawntag5 = "J_Neck";
}

precache() {
  precachemodel("c_yem_repguard_body");
  codescripts\character::precachemodelarray(xmodelalias\c_yem_repguard_head_als::main());
  precachemodel("c_yem_repguard_gear1");
  precachemodel("c_yem_repguard_body_g_upclean");
  precachemodel("c_yem_repguard_body_g_rarmoff");
  precachemodel("c_yem_repguard_body_g_larmoff");
  precachemodel("c_yem_repguard_body_g_behead");
  precachemodel("c_yem_repguard_body_g_lowclean");
  precachemodel("c_yem_repguard_body_g_rlegoff");
  precachemodel("c_yem_repguard_body_g_llegoff");
  precachemodel("c_yem_repguard_body_g_legsoff");
  precachemodel("c_yem_repguard_g_spawn_rarm");
  precachemodel("c_yem_repguard_g_spawn_larm");
  precachemodel("c_yem_repguard_g_spawn_rleg");
  precachemodel("c_yem_repguard_g_spawn_lleg");
  precachemodel("c_yem_repguard_g_headspawn");
}