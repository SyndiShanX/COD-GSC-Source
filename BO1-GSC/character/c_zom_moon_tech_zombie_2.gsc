/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_moon_tech_zombie_2.gsc
**************************************************/

main() {
  self setModel("c_zom_moon_tech_body_shirtguts_1");
  self.headModel = codescripts\character::randomElement(xmodelalias\c_zom_moon_heads_alias::main());
  self attach(self.headModel, "", true);
  self.hatModel = codescripts\character::randomElement(xmodelalias\c_zom_moon_tech_caps1_alias::main());
  self attach(self.hatModel, "", true);
  self.voice = "american";
  self.skeleton = "base";
  self.torsoDmg1 = "c_zom_moon_tech_body_sg_g_upclean_1";
  self.torsoDmg2 = "c_zom_moon_tech_body_sg_g_rarmoff_1";
  self.torsoDmg3 = "c_zom_moon_tech_body_sg_g_larmoff_1";
  self.torsoDmg5 = "c_zom_moon_tech_body_sg_g_behead";
  self.legDmg1 = "c_zom_moon_tech_body_g_lowclean_1";
  self.legDmg2 = "c_zom_moon_tech_body_g_rlegoff_1";
  self.legDmg3 = "c_zom_moon_tech_body_g_llegoff_1";
  self.legDmg4 = "c_zom_moon_tech_body_g_legsoff_1";
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
  precacheModel("c_zom_moon_tech_body_shirtguts_1");
  codescripts\character::precacheModelArray(xmodelalias\c_zom_moon_heads_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_zom_moon_tech_caps1_alias::main());
  precacheModel("c_zom_moon_tech_body_sg_g_upclean_1");
  precacheModel("c_zom_moon_tech_body_sg_g_rarmoff_1");
  precacheModel("c_zom_moon_tech_body_sg_g_larmoff_1");
  precacheModel("c_zom_moon_tech_body_sg_g_behead");
  precacheModel("c_zom_moon_tech_body_g_lowclean_1");
  precacheModel("c_zom_moon_tech_body_g_rlegoff_1");
  precacheModel("c_zom_moon_tech_body_g_llegoff_1");
  precacheModel("c_zom_moon_tech_body_g_legsoff_1");
  precacheModel("c_zom_moon_tech_body_g_rarmspawn");
  precacheModel("c_zom_moon_tech_body_g_larmspawn");
  precacheModel("c_zom_moon_tech_body_g_rlegspawn");
  precacheModel("c_zom_moon_tech_body_g_llegspawn");
  precacheModel("c_zom_moon_tech_body_sg_g_upclean_1");
  precacheModel("c_zom_moon_tech_body_sg_g_rarmoff_1");
  precacheModel("c_zom_moon_tech_body_sg_g_larmoff_1");
  precacheModel("c_zom_moon_tech_body_sg_g_behead");
  precacheModel("c_zom_moon_tech_body_g_lowclean_1");
  precacheModel("c_zom_moon_tech_body_g_rlegoff_1");
  precacheModel("c_zom_moon_tech_body_g_llegoff_1");
  precacheModel("c_zom_moon_tech_body_g_legsoff_1");
  precacheModel("c_zom_moon_tech_body_g_rarmspawn");
  precacheModel("c_zom_moon_tech_body_g_larmspawn");
  precacheModel("c_zom_moon_tech_body_g_rlegspawn");
  precacheModel("c_zom_moon_tech_body_g_llegspawn");
}