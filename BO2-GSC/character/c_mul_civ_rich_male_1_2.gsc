/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_rich_male_1_2.gsc
*************************************************/

#include codescripts\character;
#include xmodelalias\c_mul_civ_rich_male_upper2_als;
#include xmodelalias\c_mul_civ_rich_male_head_als;
#include xmodelalias\c_mul_civ_rich_male_lower_als;

main() {
  codescripts\character::setmodelfromarray(xmodelalias\c_mul_civ_rich_male_upper2_als::main());
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_mul_civ_rich_male_head_als::main());
  self attach(self.headmodel, "", 1);
  self.hatmodel = codescripts\character::randomelement(xmodelalias\c_mul_civ_rich_male_lower_als::main());
  self attach(self.hatmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_rich_male_upper2_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_rich_male_head_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_rich_male_lower_als::main());
}