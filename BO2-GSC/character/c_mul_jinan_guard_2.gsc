/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_jinan_guard_2.gsc
*********************************************/

main() {
  self setmodel("c_mul_jinan_guard_body");
  self.headmodel = "c_mul_jinan_guard_head2";
  self attach(self.headmodel, "", 1);
  self.voice = "terrorist";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_jinan_guard_body");
  precachemodel("c_mul_jinan_guard_head2");
}