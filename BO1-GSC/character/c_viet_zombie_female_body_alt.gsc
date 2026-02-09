/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_viet_zombie_female_body_alt.gsc
*******************************************************/

main() {
  self setModel("c_viet_zombie_female_alt");
  self.headModel = "c_viet_zombie_female_head";
  self attach(self.headModel, "", true);
  self.voice = "vietnamese";
  self.skeleton = "base";
  self.torsoDmg1 = "c_viet_zombie_female_g_upclean_alt";
  self.torsoDmg2 = "c_viet_zombie_female_g_rarmoff_alt";
  self.torsoDmg3 = "c_viet_zombie_female_g_larmoff_alt";
  self.torsoDmg4 = "c_viet_zombie_female_g_rarmoff_alt";
  self.torsoDmg5 = "c_viet_zombie_female_g_headoff";
  self.legDmg1 = "c_viet_zombie_female_g_lowclean_alt";
  self.legDmg2 = "c_viet_zombie_female_g_rlegoff_alt";
  self.legDmg3 = "c_viet_zombie_female_g_llegoff_alt";
  self.legDmg4 = "c_viet_zombie_female_g_legsoff_alt";
  self.gibSpawn1 = "c_viet_zombie_vc_rarmspawn";
  self.gibSpawnTag1 = "J_Elbow_RI";
  self.gibSpawn2 = "c_viet_zombie_vc_larmspawn";
  self.gibSpawnTag2 = "J_Elbow_LE";
  self.gibSpawn3 = "c_viet_zombie_vc_rlegspawn";
  self.gibSpawnTag3 = "J_Knee_RI";
  self.gibSpawn4 = "c_viet_zombie_vc_llegspawn";
  self.gibSpawnTag4 = "J_Knee_LE";
}
precache() {
  precacheModel("c_viet_zombie_female_alt");
  precacheModel("c_viet_zombie_female_head");
  precacheModel("c_viet_zombie_female_g_upclean_alt");
  precacheModel("c_viet_zombie_female_g_rarmoff_alt");
  precacheModel("c_viet_zombie_female_g_larmoff_alt");
  precacheModel("c_viet_zombie_female_g_rarmoff_alt");
  precacheModel("c_viet_zombie_female_g_headoff");
  precacheModel("c_viet_zombie_female_g_lowclean_alt");
  precacheModel("c_viet_zombie_female_g_rlegoff_alt");
  precacheModel("c_viet_zombie_female_g_llegoff_alt");
  precacheModel("c_viet_zombie_female_g_legsoff_alt");
  precacheModel("c_viet_zombie_vc_rarmspawn");
  precacheModel("c_viet_zombie_vc_larmspawn");
  precacheModel("c_viet_zombie_vc_rlegspawn");
  precacheModel("c_viet_zombie_vc_llegspawn");
  precacheModel("c_viet_zombie_female_g_upclean_alt");
  precacheModel("c_viet_zombie_female_g_rarmoff_alt");
  precacheModel("c_viet_zombie_female_g_larmoff_alt");
  precacheModel("c_viet_zombie_female_g_rarmoff_alt");
  precacheModel("c_viet_zombie_female_g_headoff");
  precacheModel("c_viet_zombie_female_g_lowclean_alt");
  precacheModel("c_viet_zombie_female_g_rlegoff_alt");
  precacheModel("c_viet_zombie_female_g_llegoff_alt");
  precacheModel("c_viet_zombie_female_g_legsoff_alt");
  precacheModel("c_viet_zombie_vc_rarmspawn");
  precacheModel("c_viet_zombie_vc_larmspawn");
  precacheModel("c_viet_zombie_vc_rlegspawn");
  precacheModel("c_viet_zombie_vc_llegspawn");
}