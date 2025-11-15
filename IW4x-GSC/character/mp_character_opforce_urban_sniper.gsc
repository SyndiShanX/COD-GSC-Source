/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_opforce_urban_sniper.gsc
***********************************************************/

main() {
  self setModel("mp_body_opforce_russian_urban_sniper");
  self attach("head_opforce_russian_urban_sniper", "", 1);
  self.headmodel = "head_opforce_russian_urban_sniper";
  self setviewmodel("viewhands_russian_a");
  self.voice = "russian";
}

precache() {
  precachemodel("mp_body_opforce_russian_urban_sniper");
  precachemodel("head_opforce_russian_urban_sniper");
  precachemodel("viewhands_russian_a");
}