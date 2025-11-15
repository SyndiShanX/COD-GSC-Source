/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_mp_opforce_sniper.gsc
*****************************************************/

main() {
  self setModel("body_mp_opforce_sniper");
  self attach("head_mp_opforce_ghillie", "", true);
  self.headModel = "head_mp_opforce_ghillie";
  self setViewmodel("viewhands_marine_sniper");
  self.voice = "russian";
}

precache() {
  precacheModel("body_mp_opforce_sniper");
  precacheModel("head_mp_opforce_ghillie");
  precacheModel("viewhands_marine_sniper");
}