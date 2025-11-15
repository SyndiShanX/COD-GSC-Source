/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_ajax_flood_a.gsc
************************************************/

main() {
  self setModel("body_gs_flood_shotg_a");
  self attach("head_gs_flood_shotg_a", "", 1);
  self.headmodel = "head_gs_flood_shotg_a";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_gs_flood_shotg_a");
  precachemodel("head_gs_flood_shotg_a");
}