/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_ajax_wood_shotgun_injured.gsc
*************************************************************/

main() {
  self setModel("body_ajax_wood_shotgun_a_injured");
  self attach("head_ajax_wood_head_a_injured", "", 1);
  self.headmodel = "head_ajax_wood_head_a_injured";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_ajax_wood_shotgun_a_injured");
  precachemodel("head_ajax_wood_head_a_injured");
}