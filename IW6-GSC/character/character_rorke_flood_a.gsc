/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_rorke_flood_a.gsc
*************************************************/

main() {
  self setModel("body_gs_flood_smg_b");
  self attach("head_gs_flood_smg_b", "", 1);
  self.headmodel = "head_gs_flood_smg_b";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_gs_flood_smg_b");
  precachemodel("head_gs_flood_smg_b");
}