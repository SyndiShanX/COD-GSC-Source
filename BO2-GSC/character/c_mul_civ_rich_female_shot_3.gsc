/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_rich_female_shot_3.gsc
*******************************************************/

#include codescripts\character;
#include xmodelalias\c_mul_civ_rich_female_shot_clothes_als;

main() {
  self setmodel("c_mul_civ_rich_female_shot_body1_3");
  self.headmodel = "c_mul_civ_rich_female_shot_head3";
  self attach(self.headmodel, "", 1);
  self.hatmodel = codescripts\character::randomelement(xmodelalias\c_mul_civ_rich_female_shot_clothes_als::main());
  self attach(self.hatmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_civ_rich_female_shot_body1_3");
  precachemodel("c_mul_civ_rich_female_shot_head3");
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_rich_female_shot_clothes_als::main());
}