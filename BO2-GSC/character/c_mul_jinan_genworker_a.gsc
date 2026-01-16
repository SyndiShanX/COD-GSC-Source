/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_jinan_genworker_a.gsc
*************************************************/

main() {
  self setmodel("c_mul_al_jinan_bellhop_body");
  self.headmodel = "c_mul_jinan_genworker_head2";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_al_jinan_bellhop_body");
  precachemodel("c_mul_jinan_genworker_head2");
}