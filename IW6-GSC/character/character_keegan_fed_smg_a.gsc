/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_keegan_fed_smg_a.gsc
****************************************************/

main() {
  self setModel("body_keegan_fed_smg_a_duffle");
  self attach("head_keegan_fed_head_a", "", 1);
  self.headmodel = "head_keegan_fed_head_a";
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_keegan_fed_smg_a_duffle");
  precachemodel("head_keegan_fed_head_a");
}