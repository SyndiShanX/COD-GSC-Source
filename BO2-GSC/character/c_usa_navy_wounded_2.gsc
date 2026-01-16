/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_navy_wounded_2.gsc
**********************************************/

main() {
  self setmodel("c_usa_navy_body_wnded");
  self.headmodel = "c_usa_navy_head2";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_navy_body_wnded");
  precachemodel("c_usa_navy_head2");
}