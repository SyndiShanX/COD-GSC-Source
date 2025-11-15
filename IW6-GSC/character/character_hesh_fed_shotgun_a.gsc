/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hesh_fed_shotgun_a.gsc
******************************************************/

main() {
  self setModel("body_hesh_fed_shotgun_a_duffle");
  self attach("head_hesh_fed_head_a", "", 1);
  self.headmodel = "head_hesh_fed_head_a";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_hesh_fed_shotgun_a_duffle");
  precachemodel("head_hesh_fed_head_a");
}