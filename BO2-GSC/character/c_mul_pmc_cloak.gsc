/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_pmc_cloak.gsc
*****************************************/

main() {
  self setmodel("c_mul_pmc_body_1_1_cl");
  self.headmodel = "c_mul_pmc_head_3_1_cl";
  self attach(self.headmodel, "", 1);
  self.hatmodel = "c_mul_pmc_gear_datapad_cl";
  self attach(self.hatmodel);
  self.gearmodel = "c_mul_pmc_gear_3_1_cl";
  self attach(self.gearmodel, "", 1);
  self.voice = "pmc";
  self.skeleton = "base";
  self.torsodmg1 = "c_mul_pmc_body_1_1_cl_g_upclean";
  self.torsodmg2 = "c_mul_pmc_body_1_1_cl_g_rarmoff";
  self.torsodmg3 = "c_mul_pmc_body_1_1_cl_g_larmoff";
  self.legdmg1 = "c_mul_pmc_body_1_1_cl_g_lowclean";
  self.legdmg2 = "c_mul_pmc_body_1_1_cl_g_rlegoff";
  self.legdmg3 = "c_mul_pmc_body_1_1_cl_g_llegoff";
  self.legdmg4 = "c_mul_pmc_body_1_1_cl_g_legsoff";
  self.gibspawn1 = "c_mul_pmc_body_1_1_g_spawn_rarm";
  self.gibspawntag1 = "J_Elbow_RI";
  self.gibspawn2 = "c_mul_pmc_body_1_1_g_spawn_larm";
  self.gibspawntag2 = "J_Elbow_LE";
  self.gibspawn3 = "c_mul_pmc_body_1_1_g_spawn_rleg";
  self.gibspawntag3 = "J_Knee_RI";
  self.gibspawn4 = "c_mul_pmc_body_1_1_g_spawn_lleg";
  self.gibspawntag4 = "J_Knee_LE";
}

precache() {
  precachemodel("c_mul_pmc_body_1_1_cl");
  precachemodel("c_mul_pmc_head_3_1_cl");
  precachemodel("c_mul_pmc_gear_datapad_cl");
  precachemodel("c_mul_pmc_gear_3_1_cl");
  precachemodel("c_mul_pmc_body_1_1_cl_g_upclean");
  precachemodel("c_mul_pmc_body_1_1_cl_g_rarmoff");
  precachemodel("c_mul_pmc_body_1_1_cl_g_larmoff");
  precachemodel("c_mul_pmc_body_1_1_cl_g_lowclean");
  precachemodel("c_mul_pmc_body_1_1_cl_g_rlegoff");
  precachemodel("c_mul_pmc_body_1_1_cl_g_llegoff");
  precachemodel("c_mul_pmc_body_1_1_cl_g_legsoff");
  precachemodel("c_mul_pmc_body_1_1_g_spawn_rarm");
  precachemodel("c_mul_pmc_body_1_1_g_spawn_larm");
  precachemodel("c_mul_pmc_body_1_1_g_spawn_rleg");
  precachemodel("c_mul_pmc_body_1_1_g_spawn_lleg");
}