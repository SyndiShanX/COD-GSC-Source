/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elite_pmc_assault_b_elite_lw.gsc
****************************************************************/

main() {
  self setModel("body_elite_pmc_assault_b_elite_low");
  codescripts\character::attachhead("alias_elite_pmc_heads_low", xmodelalias\alias_elite_pmc_heads_low::main());
  self.voice = "russian";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_elite_pmc_assault_b_elite_low");
  codescripts\character::precachemodelarray(xmodelalias\alias_elite_pmc_heads_low::main());
}