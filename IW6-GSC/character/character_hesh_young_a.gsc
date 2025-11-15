/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_young_a.gsc
************************************************/

main() {
  self setModel("body_hesh_young_a");
  self attach("head_hesh_young_x", "", 1);
  self.headmodel = "head_hesh_young_x";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_hesh_young_a");
  precachemodel("head_hesh_young_x");
}