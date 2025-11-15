/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_assault_c.gsc
*****************************************************/

main() {
  self setModel("body_merrick_assault_a");
  self attach("head_merrick_assault_c", "", 1);
  self.headmodel = "head_merrick_assault_c";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_merrick_assault_a");
  precachemodel("head_merrick_assault_c");
}