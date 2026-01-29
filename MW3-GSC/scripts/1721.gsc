/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1721.gsc
**************************************/

main() {
  self setModel("body_delta_elite_assault_bb");
  codescripts\character::attachhead("alias_delta_elite_heads_longsleeves", xmodelalias\alias_delta_elite_heads_longsleeves::main());
  self.voice = "delta";
}

precache() {
  precachemodel("body_delta_elite_assault_bb");
  codescripts\character::precachemodelarray(xmodelalias\alias_delta_elite_heads_longsleeves::main());
}