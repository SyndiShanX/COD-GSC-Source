/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_civ_female_yb_a.gsc
******************************************************/

main() {
  self setModel("body_us_civ_female_a");
  self attach("head_us_civ_female_d", "", 1);
  self.headmodel = "head_us_civ_female_d";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_us_civ_female_a");
  precachemodel("head_us_civ_female_d");
}