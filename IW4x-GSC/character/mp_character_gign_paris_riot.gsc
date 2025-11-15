/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_gign_paris_riot.gsc
******************************************************/

main() {
  self setModel("mp_body_gign_paris_lmg");
  self attach("head_gign_a", "", 1);
  self.headmodel = "head_gign_a";
  self setviewmodel("viewhands_sas");
  self.voice = "french";
}

precache() {
  precachemodel("mp_body_gign_paris_lmg");
  precachemodel("head_gign_a");
  precachemodel("viewhands_sas");
}