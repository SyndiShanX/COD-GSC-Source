/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\c_pan_noriega_military.gsc
************************************************/

main() {
  self setmodel("c_pan_noriega_military_body");
  self.headmodel = "c_pan_noriega_military_head";
  self attach(self.headmodel, "", 1);
  self.voice = "american";
  self.skeleton = "base";
}

precache() {
  precachemodel("c_pan_noriega_military_body");
  precachemodel("c_pan_noriega_military_head");
}