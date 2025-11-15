/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_civ_male_yb_c.gsc
****************************************************/

main() {
  self setModel("body_us_civ_male_e");
  self attach("head_us_civ_male_e", "", 1);
  self.headmodel = "head_us_civ_male_e";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_us_civ_male_e");
  precachemodel("head_us_civ_male_e");
}