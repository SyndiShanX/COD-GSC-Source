/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elias_e.gsc
*******************************************/

main() {
  self setModel("body_elias_e");
  self attach("head_elias_x", "", 1);
  self.headmodel = "head_elias_x";
  self.voice = "american";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_elias_e");
  precachemodel("head_elias_x");
}