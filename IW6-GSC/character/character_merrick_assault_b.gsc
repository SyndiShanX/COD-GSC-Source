/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_assault_b.gsc
*****************************************************/

main() {
  self setModel("body_merrick_assault_a");
  self attach("head_merrick_assault_b", "", 1);
  self.headmodel = "head_merrick_assault_b";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_merrick_assault_a");
  precachemodel("head_merrick_assault_b");
}