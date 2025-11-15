/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_elite_pmc_assault_b_elite.gsc
*************************************************************/

main() {
  self setModel("body_elite_pmc_assault_b_elite");
  codescripts\character::attachhead("alias_elite_pmc_heads", xmodelalias\alias_elite_pmc_heads::main());
  self.voice = "russian";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_elite_pmc_assault_b_elite");
  codescripts\character::precachemodelarray(xmodelalias\alias_elite_pmc_heads::main());
}