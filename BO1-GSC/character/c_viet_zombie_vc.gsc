/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_viet_zombie_vc.gsc
******************************************/

main() {
  codescripts\character::setModelFromArray(xmodelalias\c_viet_zombie_vc_body_alias::main());
  self.headModel = "c_viet_zombie_vc_grunt_head";
  self attach(self.headModel, "", true);
  self.voice = "vietnamese";
  self.skeleton = "base";
  self.torsoDmg1 = "c_viet_zombie_vc_grunt_g_upclean";
  self.torsoDmg2 = codescripts\character::randomElement(xmodelalias\c_viet_zombie_vc_g_rarmoff_alias::main());
  self.torsoDmg3 = codescripts\character::randomElement(xmodelalias\c_viet_zombie_vc_g_larmoff_alias::main());
  self.torsoDmg4 = codescripts\character::randomElement(xmodelalias\c_viet_zombie_vc_g_rarmoff_alias::main());
  self.torsoDmg5 = "c_viet_zombie_vc_grunt_g_headoff";
  self.legDmg1 = "c_viet_zombie_vc_grunt_g_lowclean";
  self.legDmg2 = codescripts\character::randomElement(xmodelalias\c_viet_zombie_vc_g_rlegoff_alias::main());
  self.legDmg3 = codescripts\character::randomElement(xmodelalias\c_viet_zombie_vc_g_llegoff_alias::main());
  self.legDmg4 = codescripts\character::randomElement(xmodelalias\c_viet_zombie_vc_g_legsoff_alias::main());
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
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_body_alias::main());
  precacheModel("c_viet_zombie_vc_grunt_head");
  precacheModel("c_viet_zombie_vc_grunt_g_upclean");
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_rarmoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_larmoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_rarmoff_alias::main());
  precacheModel("c_viet_zombie_vc_grunt_g_headoff");
  precacheModel("c_viet_zombie_vc_grunt_g_lowclean");
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_rlegoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_llegoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_legsoff_alias::main());
  precacheModel("c_viet_zombie_vc_rarmspawn");
  precacheModel("c_viet_zombie_vc_larmspawn");
  precacheModel("c_viet_zombie_vc_rlegspawn");
  precacheModel("c_viet_zombie_vc_llegspawn");
  precacheModel("c_viet_zombie_vc_grunt_g_upclean");
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_rarmoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_larmoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_rarmoff_alias::main());
  precacheModel("c_viet_zombie_vc_grunt_g_headoff");
  precacheModel("c_viet_zombie_vc_grunt_g_lowclean");
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_rlegoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_llegoff_alias::main());
  codescripts\character::precacheModelArray(xmodelalias\c_viet_zombie_vc_g_legsoff_alias::main());
  precacheModel("c_viet_zombie_vc_rarmspawn");
  precacheModel("c_viet_zombie_vc_larmspawn");
  precacheModel("c_viet_zombie_vc_rlegspawn");
  precacheModel("c_viet_zombie_vc_llegspawn");
}