/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_yemen_defalco.gsc
*********************************************/

main() {
  self setmodel("c_mul_yemen_defalco_body");
  self.headmodel = "c_mul_yemen_defalco_head";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_yemen_defalco_body");
  precachemodel("c_mul_yemen_defalco_head");
}