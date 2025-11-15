/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_venezuela_army_assault_a.gsc
************************************************************/

main() {
  self setModel("body_venezuela_army_assault_a");
  codescripts\character::attachhead("alias_venezuela_army_heads", xmodelalias\alias_venezuela_army_heads::main());
  self.voice = "shadowcompany";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_venezuela_army_assault_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_venezuela_army_heads::main());
}