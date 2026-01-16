/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_navy_wounded_3.gsc
**********************************************/

main() {
  self setmodel("c_usa_navy_body_wnded_brn");
  self.headmodel = "c_usa_navy_head3";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_navy_body_wnded_brn");
  precachemodel("c_usa_navy_head3");
}