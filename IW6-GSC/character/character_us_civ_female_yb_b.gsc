/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_civ_female_yb_b.gsc
******************************************************/

main() {
  self setModel("body_us_civ_female_c");
  self attach("head_us_civ_female_c", "", 1);
  self.headmodel = "head_us_civ_female_c";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_us_civ_female_c");
  precachemodel("head_us_civ_female_c");
}