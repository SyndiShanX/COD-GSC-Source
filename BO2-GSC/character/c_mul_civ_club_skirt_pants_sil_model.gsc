/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_club_skirt_pants_sil_model.gsc
***********************************************************************/

main() {
  self setmodel("c_mul_civ_club_skirt_pants_1_sil");
  self.headmodel = "c_mul_civ_club_female_head1_sil";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_civ_club_skirt_pants_1_sil");
  precachemodel("c_mul_civ_club_female_head1_sil");
}