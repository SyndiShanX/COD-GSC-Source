/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_delta_elite_sniper.gsc
*********************************************************/

main() {
  self setModel("mp_body_ally_delta_sniper");
  self attach("head_ally_delta_sniper", "", 1);
  self.headmodel = "head_ally_delta_sniper";
  self setviewmodel("viewhands_delta");
  self.voice = "delta";
}

precache() {
  precachemodel("mp_body_ally_delta_sniper");
  precachemodel("head_ally_delta_sniper");
  precachemodel("viewhands_delta");
}