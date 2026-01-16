/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_navy_wounded_1.gsc
**********************************************/

main() {
  self setmodel("c_usa_navy_body_wnded_blk");
  self.headmodel = "c_usa_navy_head1";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_navy_body_wnded_blk");
  precachemodel("c_usa_navy_head1");
}