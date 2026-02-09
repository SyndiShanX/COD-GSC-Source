/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_moon_tech_zombie_1_3.gsc
****************************************************/

main() {
  self setModel("c_zom_moon_tech_body_noshirtguts_3");
  self.headModel = codescripts\character::randomElement(xmodelalias\c_zom_moon_heads_alias::main());
  self attach(self.headModel, "", true);
  self.voice = "american";
  self.skeleton = "base";
  self.torsoDmg1 = "c_zom_moon_tech_body_n_g_upclean_3";
  self.torsoDmg2 = "c_zom_moon_tech_body_n_g_rarmoff_3";
  self.torsoDmg3 = "c_zom_moon_tech_body_n_g_larmoff_3";
  self.torsoDmg5 = "c_zom_moon_tech_body_n_g_behead";
  self.legDmg1 = "c_zom_moon_tech_body_g_lowclean_3";
  self.legDmg2 = "c_zom_moon_tech_body_g_rlegoff_3";
  self.legDmg3 = "c_zom_moon_tech_body_g_llegoff_3";
  self.legDmg4 = "c_zom_moon_tech_body_g_legsoff_3";
  self.gibSpawn1 = "c_zom_moon_tech_body_g_rarmspawn";
  self.gibSpawnTag1 = "J_Elbow_RI";
  self.gibSpawn2 = "c_zom_moon_tech_body_g_larmspawn";
  self.gibSpawnTag2 = "J_Elbow_LE";
  self.gibSpawn3 = "c_zom_moon_tech_body_g_rlegspawn";
  self.gibSpawnTag3 = "J_Knee_RI";
  self.gibSpawn4 = "c_zom_moon_tech_body_g_llegspawn";
  self.gibSpawnTag4 = "J_Knee_LE";
}
precache() {
  precacheModel("c_zom_moon_tech_body_noshirtguts_3");
  codescripts\character::precacheModelArray(xmodelalias\c_zom_moon_heads_alias::main());
  precacheModel("c_zom_moon_tech_body_n_g_upclean_3");
  precacheModel("c_zom_moon_tech_body_n_g_rarmoff_3");
  precacheModel("c_zom_moon_tech_body_n_g_larmoff_3");
  precacheModel("c_zom_moon_tech_body_n_g_behead");
  precacheModel("c_zom_moon_tech_body_g_lowclean_3");
  precacheModel("c_zom_moon_tech_body_g_rlegoff_3");
  precacheModel("c_zom_moon_tech_body_g_llegoff_3");
  precacheModel("c_zom_moon_tech_body_g_legsoff_3");
  precacheModel("c_zom_moon_tech_body_g_rarmspawn");
  precacheModel("c_zom_moon_tech_body_g_larmspawn");
  precacheModel("c_zom_moon_tech_body_g_rlegspawn");
  precacheModel("c_zom_moon_tech_body_g_llegspawn");
  precacheModel("c_zom_moon_tech_body_n_g_upclean_3");
  precacheModel("c_zom_moon_tech_body_n_g_rarmoff_3");
  precacheModel("c_zom_moon_tech_body_n_g_larmoff_3");
  precacheModel("c_zom_moon_tech_body_n_g_behead");
  precacheModel("c_zom_moon_tech_body_g_lowclean_3");
  precacheModel("c_zom_moon_tech_body_g_rlegoff_3");
  precacheModel("c_zom_moon_tech_body_g_llegoff_3");
  precacheModel("c_zom_moon_tech_body_g_legsoff_3");
  precacheModel("c_zom_moon_tech_body_g_rarmspawn");
  precacheModel("c_zom_moon_tech_body_g_larmspawn");
  precacheModel("c_zom_moon_tech_body_g_rlegspawn");
  precacheModel("c_zom_moon_tech_body_g_llegspawn");
}