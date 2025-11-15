/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_africa_militia_sniper.gsc
************************************************************/

main() {
  self setModel("mp_body_opforce_africa_militia_sniper");
  self attach("head_opforce_africa_sniper", "", 1);
  self.headmodel = "head_opforce_africa_sniper";
  self setviewmodel("viewhands_african_militia");
  self.voice = "african";
}

precache() {
  precachemodel("mp_body_opforce_africa_militia_sniper");
  precachemodel("head_opforce_africa_sniper");
  precachemodel("viewhands_african_militia");
}