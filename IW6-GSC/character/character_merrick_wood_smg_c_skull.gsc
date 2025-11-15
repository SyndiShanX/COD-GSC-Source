/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_merrick_wood_smg_c_skull.gsc
************************************************************/

main() {
  self setModel("body_merrick_wood_smg_a");
  self attach("head_merrick_wood_head_c_skull", "", 1);
  self.headmodel = "head_merrick_wood_head_c_skull";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_merrick_wood_smg_a");
  precachemodel("head_merrick_wood_head_c_skull");
}