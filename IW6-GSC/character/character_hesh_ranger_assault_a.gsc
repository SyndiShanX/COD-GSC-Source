/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_ranger_assault_a.gsc
*********************************************************/

main() {
  self setModel("body_hesh_ranger_assault_ax");
  self attach("head_hesh_ranger_head_x", "", 1);
  self.headmodel = "head_hesh_ranger_head_x";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_hesh_ranger_assault_ax");
  precachemodel("head_hesh_ranger_head_x");
}