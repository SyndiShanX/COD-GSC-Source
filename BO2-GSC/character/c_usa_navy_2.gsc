/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_navy_2.gsc
**************************************/

main() {
  self setmodel("c_usa_navy_body");
  self.headmodel = "c_usa_navy_head2";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_navy_body");
  precachemodel("c_usa_navy_head2");
}