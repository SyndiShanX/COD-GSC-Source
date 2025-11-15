/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_army_assault_b_arctic.gsc
*************************************************************/

main() {
  self setModel("body_fed_army_assault_b_arctic");
  codescripts\character::attachhead("alias_fed_army_heads_a_arctic_indoor", xmodelalias\alias_fed_army_heads_a_arctic_indoor::main());
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_fed_army_assault_b_arctic");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_army_heads_a_arctic_indoor::main());
}