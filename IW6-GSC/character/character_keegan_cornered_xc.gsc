/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_keegan_cornered_xc.gsc
******************************************************/

main() {
  self setModel("body_keegan_cornered_a");
  self attach("head_keegan_cornered_xz", "", 1);
  self.headmodel = "head_keegan_cornered_xz";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_keegan_cornered_a");
  precachemodel("head_keegan_cornered_xz");
}