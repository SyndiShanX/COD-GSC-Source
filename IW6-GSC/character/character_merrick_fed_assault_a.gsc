/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_fed_assault_a.gsc
*********************************************************/

main() {
  self setModel("body_merrick_fed_assault_a_duffle");
  self attach("head_merrick_fed_head_a", "", 1);
  self.headmodel = "head_merrick_fed_head_a";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_merrick_fed_assault_a_duffle");
  precachemodel("head_merrick_fed_head_a");
}