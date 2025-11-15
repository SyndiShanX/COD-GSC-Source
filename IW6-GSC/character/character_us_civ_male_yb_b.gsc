/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_civ_male_yb_b.gsc
****************************************************/

main() {
  self setModel("body_us_civ_male_b");
  self attach("head_us_civ_male_b", "", 1);
  self.headmodel = "head_us_civ_male_b";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_us_civ_male_b");
  precachemodel("head_us_civ_male_b");
}