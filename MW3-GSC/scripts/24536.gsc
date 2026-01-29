/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\24536.gsc
**************************************/

main() {
  self setModel("body_henchmen_assault_b");
  codescripts\character::attachhead("alias_henchmen_heads", xmodelalias\alias_henchmen_heads::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_henchmen_assault_b");
  codescripts\character::precachemodelarray(xmodelalias\alias_henchmen_heads::main());
}