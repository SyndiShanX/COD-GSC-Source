/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_keegan_assault_a.gsc
****************************************************/

main() {
  self setModel("body_keegan_assault_a");
  self attach("head_keegan_assault_a", "", 1);
  self.headmodel = "head_keegan_assault_a";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_keegan_assault_a");
  precachemodel("head_keegan_assault_a");
}