/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_barechest.gsc
*****************************************/

main() {
  self setModel("c_zom_barechest_body");
  self.headModel = codescripts\character::randomElement(xmodelalias\c_zom_head_alias::main());
  self attach(self.headModel, "", true);
  self.hatModel = codescripts\character::randomElement(xmodelalias\c_zom_beanie_alias::main());
  self attach(self.hatModel, "", true);
  self.voice = "american";
  self.skeleton = "base";
  self.torsoDmg1 = "c_zom_barechest_body_g_upclean";
  self.torsoDmg2 = "c_zom_barechest_body_g_rarmoff";
  self.torsoDmg3 = "c_zom_barechest_body_g_larmoff";
  self.torsoDmg4 = "c_zom_barechest_body_g_torso";
  self.torsoDmg5 = "c_zom_barechest_body_g_behead";
  self.legDmg1 = "c_zom_barechest_body_g_lowclean";
  self.legDmg2 = "c_zom_barechest_body_g_rlegoff";
  self.legDmg3 = "c_zom_barechest_body_g_llegoff";
  self.legDmg4 = "c_zom_barechest_body_g_legsoff";
  self.gibSpawn1 = "c_zom_barechest_body_g_rarmspawn";
  self.gibSpawnTag1 = "J_Elbow_RI";
  self.gibSpawn2 = "c_zom_barechest_body_g_larmspawn";
  self.gibSpawnTag2 = "J_Elbow_LE";
  self.gibSpawn3 = "c_zom_barechest_body_g_rlegspawn";
  self.gibSpawnTag3 = "J_Knee_RI";
  self.gibSpawn4 = "c_zom_barechest_body_g_llegspawn";
  self.gibSpawnTag4 = "J_Knee_LE";
}
precache() {
  precacheModel("c_zom_barechest_body");
  codescripts\character::precacheModelArray(xmodelalias\c_zom_head_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_zom_beanie_alias::main());
  precacheModel("c_zom_barechest_body_g_upclean");
  precacheModel("c_zom_barechest_body_g_rarmoff");
  precacheModel("c_zom_barechest_body_g_larmoff");
  precacheModel("c_zom_barechest_body_g_torso");
  precacheModel("c_zom_barechest_body_g_behead");
  precacheModel("c_zom_barechest_body_g_lowclean");
  precacheModel("c_zom_barechest_body_g_rlegoff");
  precacheModel("c_zom_barechest_body_g_llegoff");
  precacheModel("c_zom_barechest_body_g_legsoff");
  precacheModel("c_zom_barechest_body_g_rarmspawn");
  precacheModel("c_zom_barechest_body_g_larmspawn");
  precacheModel("c_zom_barechest_body_g_rlegspawn");
  precacheModel("c_zom_barechest_body_g_llegspawn");
  precacheModel("c_zom_barechest_body_g_upclean");
  precacheModel("c_zom_barechest_body_g_rarmoff");
  precacheModel("c_zom_barechest_body_g_larmoff");
  precacheModel("c_zom_barechest_body_g_torso");
  precacheModel("c_zom_barechest_body_g_behead");
  precacheModel("c_zom_barechest_body_g_lowclean");
  precacheModel("c_zom_barechest_body_g_rlegoff");
  precacheModel("c_zom_barechest_body_g_llegoff");
  precacheModel("c_zom_barechest_body_g_legsoff");
  precacheModel("c_zom_barechest_body_g_rarmspawn");
  precacheModel("c_zom_barechest_body_g_larmspawn");
  precacheModel("c_zom_barechest_body_g_rlegspawn");
  precacheModel("c_zom_barechest_body_g_llegspawn");
}