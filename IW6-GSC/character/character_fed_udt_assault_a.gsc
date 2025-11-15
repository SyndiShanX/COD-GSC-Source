/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_udt_assault_a.gsc
*****************************************************/

main() {
  self setModel("body_fed_udt_assault_a");
  codescripts\character::attachhead("alias_fed_udt_heads", xmodelalias\alias_fed_udt_heads::main());
  self.voice = "russian";
  self setclothtype("nylon");
}

precache() {
  precachemodel("body_fed_udt_assault_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_udt_heads::main());
}