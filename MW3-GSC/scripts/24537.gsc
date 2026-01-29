/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\24537.gsc
**************************************/

main() {
  self setModel("body_henchmen_assault_c");
  codescripts\character::attachhead("alias_henchmen_heads", xmodelalias\alias_henchmen_heads::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_henchmen_assault_c");
  codescripts\character::precachemodelarray(xmodelalias\alias_henchmen_heads::main());
}