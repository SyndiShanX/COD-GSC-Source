/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_keegan_assault_b.gsc
****************************************************/

main() {
  self setModel("body_keegan_assault_a");
  self attach("head_keegan_assault_a_skull", "", 1);
  self.headmodel = "head_keegan_assault_a_skull";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_keegan_assault_a");
  precachemodel("head_keegan_assault_a_skull");
}