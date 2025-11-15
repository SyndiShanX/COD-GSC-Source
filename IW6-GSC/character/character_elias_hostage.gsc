/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elias_hostage.gsc
*************************************************/

main() {
  self setModel("body_elias_hostage");
  self attach("head_elias_hostage_x", "", 1);
  self.headmodel = "head_elias_hostage_x";
  self.voice = "american";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_elias_hostage");
  precachemodel("head_elias_hostage_x");
}