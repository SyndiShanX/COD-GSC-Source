/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_army_assault_a_elite.gsc
************************************************************/

main() {
  self setModel("body_fed_army_assault_a_elite");
  codescripts\character::attachhead("alias_fed_army_heads_a_urban", xmodelalias\alias_fed_army_heads_a_urban::main());
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_fed_army_assault_a_elite");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_army_heads_a_urban::main());
}