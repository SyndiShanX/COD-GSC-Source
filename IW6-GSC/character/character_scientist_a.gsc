/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_scientist_a.gsc
***********************************************/

main() {
  self setModel("body_scientist_a");
  codescripts\character::attachhead("alias_scientist_heads", xmodelalias\alias_scientist_heads::main());
  self.voice = "russian";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_scientist_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_scientist_heads::main());
}