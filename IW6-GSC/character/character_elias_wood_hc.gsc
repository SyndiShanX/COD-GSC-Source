/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elias_wood_hc.gsc
*************************************************/

main() {
  self setModel("body_elias_wood_shotgun_a");
  self attach("elias_stealth_head_mask", "", 1);
  self.headmodel = "elias_stealth_head_mask";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_elias_wood_shotgun_a");
  precachemodel("elias_stealth_head_mask");
}