/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_civ_generic_female_sil.gsc
*******************************************************/

main() {
  self setmodel("c_mul_jinan_gogo_body");
  self.headmodel = "c_mul_jinan_gogo_head1";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_jinan_gogo_body");
  precachemodel("c_mul_jinan_gogo_head1");
}