/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\24482.gsc
**************************************/

main() {
  self setModel("body_delta_elite_assault_bb");
  self attach("head_hero_grinch_delta", "", 1);
  self.headmodel = "head_hero_grinch_delta";
  self.voice = "delta";
}

precache() {
  precachemodel("body_delta_elite_assault_bb");
  precachemodel("head_hero_grinch_delta");
}