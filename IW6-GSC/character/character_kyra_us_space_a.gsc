/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_kyra_us_space_a.gsc
***************************************************/

main() {
  self setModel("us_space_a_body");
  self attach("head_kyra_space_a", "", 1);
  self.headmodel = "head_kyra_space_a";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("us_space_a_body");
  precachemodel("head_kyra_space_a");
}