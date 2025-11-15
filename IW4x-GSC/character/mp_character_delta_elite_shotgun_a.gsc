/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_delta_elite_shotgun_a.gsc
************************************************************/

main() {
  self setModel("mp_body_delta_elite_shotgun_a");
  codescripts\character::attachhead("alias_delta_elite_heads_longsleeves", xmodelalias\alias_delta_elite_heads_longsleeves::main());
  self setviewmodel("viewhands_delta");
  self.voice = "delta";
}

precache() {
  precachemodel("mp_body_delta_elite_shotgun_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_delta_elite_heads_longsleeves::main());
  precachemodel("viewhands_delta");
}