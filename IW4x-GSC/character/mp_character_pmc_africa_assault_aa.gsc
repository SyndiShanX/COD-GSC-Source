/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_pmc_africa_assault_aa.gsc
************************************************************/

main() {
  self setModel("mp_body_pmc_africa_assault_aa");
  codescripts\character::attachhead("alias_pmc_africa_heads", xmodelalias\alias_pmc_africa_heads::main());
  self setviewmodel("viewhands_pmc");
  self.voice = "russian";
}

precache() {
  precachemodel("mp_body_pmc_africa_assault_aa");
  codescripts\character::precachemodelarray(xmodelalias\alias_pmc_africa_heads::main());
  precachemodel("viewhands_pmc");
}