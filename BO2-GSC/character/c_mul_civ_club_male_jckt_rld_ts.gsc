/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_club_male_jckt_rld_ts.gsc
*************************************************************/

#include codescripts\character;
#include xmodelalias\c_mul_civ_club_male_jckt_rld_ts_als;
#include xmodelalias\c_mul_civ_club_male_head_als;

main() {
  codescripts\character::setmodelfromarray(xmodelalias\c_mul_civ_club_male_jckt_rld_ts_als::main());
  self.headmodel = codescripts\character::randomelement(xmodelalias\c_mul_civ_club_male_head_als::main());
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_club_male_jckt_rld_ts_als::main());
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_club_male_head_als::main());
}