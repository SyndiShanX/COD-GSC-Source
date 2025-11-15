/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elias_a.gsc
*******************************************/

main() {
  self setModel("body_elias_a");
  self attach("head_elias_x", "", 1);
  self.headmodel = "head_elias_x";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_elias_a");
  precachemodel("head_elias_x");
}