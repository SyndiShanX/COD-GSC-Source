/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_usa_chloe_cc_cin.gsc
********************************************/

main() {
  self setmodel("c_usa_chloe_cc_body");
  self.headmodel = "c_usa_chloe_cc_head_cin";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_usa_chloe_cc_body");
  precachemodel("c_usa_chloe_cc_head_cin");
}