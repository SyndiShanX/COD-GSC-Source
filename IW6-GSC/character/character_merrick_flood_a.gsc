/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_flood_a.gsc
***************************************************/

main() {
  self setModel("body_gs_flood_assault_c");
  self attach("head_gs_flood_assault_cc", "", 1);
  self.headmodel = "head_gs_flood_assault_cc";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_gs_flood_assault_c");
  precachemodel("head_gs_flood_assault_cc");
}