/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_keegan_end_smg_a.gsc
****************************************************/

main() {
  self setModel("body_keegan_end_smg_a");
  self attach("head_keegan_end_head_a", "", 1);
  self.headmodel = "head_keegan_end_head_a";
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_keegan_end_smg_a");
  precachemodel("head_keegan_end_head_a");
}