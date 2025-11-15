/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_civ_male_yb_d.gsc
****************************************************/

main() {
  self setModel("body_us_civ_male_i");
  self attach("head_us_civ_male_i", "", 1);
  self.headmodel = "head_us_civ_male_i";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_us_civ_male_i");
  precachemodel("head_us_civ_male_i");
}