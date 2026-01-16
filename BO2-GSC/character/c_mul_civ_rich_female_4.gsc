/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_rich_female_4.gsc
*************************************************/

#include codescripts\character;
#include xmodelalias\c_mul_civ_rich_female_clothes_als;

main() {
  self setmodel("c_mul_civ_rich_female_body1_4");
  self.headmodel = "c_mul_civ_rich_female_head4";
  self attach(self.headmodel, "", 1);
  self.hatmodel = codescripts\character::randomelement(xmodelalias\c_mul_civ_rich_female_clothes_als::main());
  self attach(self.hatmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_civ_rich_female_body1_4");
  precachemodel("c_mul_civ_rich_female_head4");
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_rich_female_clothes_als::main());
}