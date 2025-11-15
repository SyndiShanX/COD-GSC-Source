/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_hostage_ab.gsc
***************************************************/

main() {
  self setModel("body_hesh_hostage_ab");
  self attach("head_hesh_hostage_x", "", 1);
  self.headmodel = "head_hesh_hostage_x";
  self.voice = "american";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_hesh_hostage_ab");
  precachemodel("head_hesh_hostage_x");
}