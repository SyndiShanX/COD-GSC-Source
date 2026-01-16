/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_menendez_old_captured.gsc
*****************************************************/

main() {
  self setmodel("c_mul_menendez_old_captured_body");
  self.headmodel = "c_mul_menendez_old_captured_head";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_menendez_old_captured_body");
  precachemodel("c_mul_menendez_old_captured_head");
}