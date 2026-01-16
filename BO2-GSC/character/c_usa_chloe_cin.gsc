/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_chloe_cin.gsc
*****************************************/

main() {
  self setmodel("c_usa_chloe_karma_body");
  self.headmodel = "c_usa_chloe_head_cin";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_chloe_karma_body");
  precachemodel("c_usa_chloe_head_cin");
}