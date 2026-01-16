/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_al_jinan_receptionist1.gsc
*******************************************************/

main() {
  self setmodel("c_mul_al_jinan_receptionist_body");
  self.headmodel = "c_mul_civ_club_female_head1";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_al_jinan_receptionist_body");
  precachemodel("c_mul_civ_club_female_head1");
}