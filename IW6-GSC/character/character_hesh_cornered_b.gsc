/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_cornered_b.gsc
***************************************************/

main() {
  self setModel("body_hesh_cornered_b");
  self attach("head_hesh_cornered_xb", "", 1);
  self.headmodel = "head_hesh_cornered_xb";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_hesh_cornered_b");
  precachemodel("head_hesh_cornered_xb");
}