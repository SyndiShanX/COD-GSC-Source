/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_club_male_jckt_drsh_h2.gsc
***************************************************************/

#include codescripts\character;
#include xmodelalias\c_mul_civ_club_male_jckt_drsh_als;

main() {
  codescripts\character::setmodelfromarray(xmodelalias\c_mul_civ_club_male_jckt_drsh_als::main());
  self.headmodel = "c_mul_civ_club_male_head5";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\c_mul_civ_club_male_jckt_drsh_als::main());
  precachemodel("c_mul_civ_club_male_head5");
}