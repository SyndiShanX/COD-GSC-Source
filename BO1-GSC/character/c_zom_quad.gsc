/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_quad.gsc
**************************************/

main() {
  self setModel("c_zom_quad_body");
  self.headModel = "c_zom_quad_head";
  self attach(self.headModel, "", true);
  self.voice = "american";
  self.skeleton = "base";
  self.torsoDmg1 = "c_zom_quad_g_upclean";
  self.torsoDmg4 = "c_zom_quad_g_larmoff";
  self.torsoDmg5 = "c_zom_quad_g_behead";
  self.legDmg1 = "c_zom_quad_g_lowclean";
  self.legDmg2 = "c_zom_quad_g_rlegoff";
  self.legDmg3 = "c_zom_quad_g_llegoff";
  self.legDmg4 = "c_zom_quad_g_legsoff";
  self.gibSpawn3 = "c_zom_quad_g_rlegspawn";
  self.gibSpawnTag3 = "J_Knee_RI";
  self.gibSpawn4 = "c_zom_quad_g_llegspawn";
  self.gibSpawnTag4 = "J_Knee_LE";
}
precache() {
  precacheModel("c_zom_quad_body");
  precacheModel("c_zom_quad_head");
  precacheModel("c_zom_quad_g_upclean");
  precacheModel("c_zom_quad_g_larmoff");
  precacheModel("c_zom_quad_g_behead");
  precacheModel("c_zom_quad_g_lowclean");
  precacheModel("c_zom_quad_g_rlegoff");
  precacheModel("c_zom_quad_g_llegoff");
  precacheModel("c_zom_quad_g_legsoff");
  precacheModel("c_zom_quad_g_rlegspawn");
  precacheModel("c_zom_quad_g_llegspawn");
  precacheModel("c_zom_quad_g_upclean");
  precacheModel("c_zom_quad_g_larmoff");
  precacheModel("c_zom_quad_g_behead");
  precacheModel("c_zom_quad_g_lowclean");
  precacheModel("c_zom_quad_g_rlegoff");
  precacheModel("c_zom_quad_g_llegoff");
  precacheModel("c_zom_quad_g_legsoff");
  precacheModel("c_zom_quad_g_rlegspawn");
  precacheModel("c_zom_quad_g_llegspawn");
}