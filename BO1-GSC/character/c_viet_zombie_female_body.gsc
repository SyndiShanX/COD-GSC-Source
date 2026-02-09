/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_viet_zombie_female_body.gsc
***************************************************/

main() {
  self setModel("c_viet_zombie_female");
  self.headModel = "c_viet_zombie_female_head";
  self attach(self.headModel, "", true);
  self.voice = "vietnamese";
  self.skeleton = "base";
  self.torsoDmg1 = "c_viet_zombie_female_g_upclean";
  self.torsoDmg2 = "c_viet_zombie_female_g_rarmoff";
  self.torsoDmg3 = "c_viet_zombie_female_g_larmoff";
  self.torsoDmg4 = "c_viet_zombie_female_g_rarmoff";
  self.torsoDmg5 = "c_viet_zombie_female_g_headoff";
  self.legDmg1 = "c_viet_zombie_female_g_lowclean";
  self.legDmg2 = "c_viet_zombie_female_g_rlegoff";
  self.legDmg3 = "c_viet_zombie_female_g_llegoff";
  self.legDmg4 = "c_viet_zombie_female_g_legsoff";
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
  precacheModel("c_viet_zombie_female");
  precacheModel("c_viet_zombie_female_head");
  precacheModel("c_viet_zombie_female_g_upclean");
  precacheModel("c_viet_zombie_female_g_rarmoff");
  precacheModel("c_viet_zombie_female_g_larmoff");
  precacheModel("c_viet_zombie_female_g_rarmoff");
  precacheModel("c_viet_zombie_female_g_headoff");
  precacheModel("c_viet_zombie_female_g_lowclean");
  precacheModel("c_viet_zombie_female_g_rlegoff");
  precacheModel("c_viet_zombie_female_g_llegoff");
  precacheModel("c_viet_zombie_female_g_legsoff");
  precacheModel("c_viet_zombie_vc_rarmspawn");
  precacheModel("c_viet_zombie_vc_larmspawn");
  precacheModel("c_viet_zombie_vc_rlegspawn");
  precacheModel("c_viet_zombie_vc_llegspawn");
  precacheModel("c_viet_zombie_female_g_upclean");
  precacheModel("c_viet_zombie_female_g_rarmoff");
  precacheModel("c_viet_zombie_female_g_larmoff");
  precacheModel("c_viet_zombie_female_g_rarmoff");
  precacheModel("c_viet_zombie_female_g_headoff");
  precacheModel("c_viet_zombie_female_g_lowclean");
  precacheModel("c_viet_zombie_female_g_rlegoff");
  precacheModel("c_viet_zombie_female_g_llegoff");
  precacheModel("c_viet_zombie_female_g_legsoff");
  precacheModel("c_viet_zombie_vc_rarmspawn");
  precacheModel("c_viet_zombie_vc_larmspawn");
  precacheModel("c_viet_zombie_vc_rlegspawn");
  precacheModel("c_viet_zombie_vc_llegspawn");
}