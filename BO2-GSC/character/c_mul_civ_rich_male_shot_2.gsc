/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_rich_male_shot_2.gsc
****************************************************/

#include codescripts\character;
#include xmodelalias\c_mul_civ_rich_male_shot_asn_up_als;
#include xmodelalias\c_mul_civ_rich_male_shot_lower_als;

main() {
  codescripts\character::setmodelfromarray(xmodelalias\c_mul_civ_rich_male_shot_asn_up_als::main());
  self.headmodel = "c_mul_civ_club_male_shot_head5";
  self attach(self.headmodel, "", 1);
  self.hatmodel = codescripts\character::randomelement(xmodelalias\c_mul_civ_rich_male_shot_lower_als::main());
  self attach(self.hatmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_rich_male_shot_asn_up_als::main());
  precachemodel("c_mul_civ_club_male_shot_head5");
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_rich_male_shot_lower_als::main());
}