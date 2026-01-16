/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_navy_3_cin.gsc
******************************************/

main() {
  self setmodel("c_usa_navy_body_brn");
  self.headmodel = "c_usa_navy_head3_cin";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_navy_body_brn");
  precachemodel("c_usa_navy_head3_cin");
}