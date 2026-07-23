/***************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_opforce_arctic_assault_c.gsc
***************************************************************/

main() {
  self setModel("mp_body_opforce_arctic_assault_c");
  codescripts\character::attachHead("alias_opforce_arctic_heads", xmodelalias\alias_opforce_arctic_heads::main());
  self setViewmodel("viewhands_arctic_opforce");
  self.voice = "russian";
}

precache() {
  precacheModel("mp_body_opforce_arctic_assault_c");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_arctic_heads::main());
  precacheModel("viewhands_arctic_opforce");
}