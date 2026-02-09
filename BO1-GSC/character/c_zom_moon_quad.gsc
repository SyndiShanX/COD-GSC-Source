/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_zom_moon_quad.gsc
*****************************************/

main() {
  self setModel("c_zom_quad_body_bloat");
  self.headModel = "c_zom_quad_head_bloat";
  self attach(self.headModel, "", true);
  self.voice = "american";
  self.skeleton = "base";
}
precache() {
  precacheModel("c_zom_quad_body_bloat");
  precacheModel("c_zom_quad_head_bloat");
}