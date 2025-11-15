/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_space_collins.gsc
****************************************************/

main() {
  self setModel("us_space_assault_b_body");
  self attach("head_us_space_collins", "", 1);
  self.headmodel = "head_us_space_collins";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("us_space_assault_b_body");
  precachemodel("head_us_space_collins");
}