/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_ajax_wood_shotgun_a.gsc
*******************************************************/

main() {
  self setModel("body_ajax_wood_shotgun_a");
  self attach("head_ajax_wood_head_a", "", 1);
  self.headmodel = "head_ajax_wood_head_a";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ajax_wood_shotgun_a");
  precachemodel("head_ajax_wood_head_a");
}