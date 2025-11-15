/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elias_c.gsc
*******************************************/

main() {
  self setModel("body_elias_c");
  self attach("head_elias_xb", "", 1);
  self.headmodel = "head_elias_xb";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_elias_c");
  precachemodel("head_elias_xb");
}