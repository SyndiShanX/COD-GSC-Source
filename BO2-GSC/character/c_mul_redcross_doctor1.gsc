/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_redcross_doctor1.gsc
************************************************/

main() {
  self setmodel("c_mul_redcross_doctor_body");
  self.headmodel = "c_mul_redcross_doctor_head1";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_redcross_doctor_body");
  precachemodel("c_mul_redcross_doctor_head1");
}