/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_farid_cc.gsc
****************************************/

main() {
  self setmodel("c_mul_farid_cc_fb");
  self.headmodel = "c_mul_farid_cc_shirt";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_farid_cc_fb");
  precachemodel("c_mul_farid_cc_shirt");
}