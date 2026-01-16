/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_mul_vtol_pilot2.gsc
*******************************************/

main() {
  self setmodel("c_mul_vtol_pilot_body_blk");
  self.headmodel = "c_mul_vtol_pilot_head2";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_mul_vtol_pilot_body_blk");
  precachemodel("c_mul_vtol_pilot_head2");
}