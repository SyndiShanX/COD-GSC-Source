/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_opforce_woods_sniper.gsc
***********************************************************/

main() {
  self setModel("mp_body_opforce_russian_woodland_sniper");
  self attach("head_opforce_russian_woodland_sniper", "", 1);
  self.headmodel = "head_opforce_russian_woodland_sniper";
  self setviewmodel("viewhands_russian_c");
  self.voice = "russian";
}

precache() {
  precachemodel("mp_body_opforce_russian_woodland_sniper");
  precachemodel("head_opforce_russian_woodland_sniper");
  precachemodel("viewhands_russian_c");
}