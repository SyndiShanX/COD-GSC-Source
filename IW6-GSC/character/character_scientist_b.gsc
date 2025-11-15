/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_scientist_b.gsc
***********************************************/

main() {
  self setModel("body_scientist_b");
  codescripts\character::attachhead("alias_scientist_heads", xmodelalias\alias_scientist_heads::main());
  self.voice = "russian";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_scientist_b");
  codescripts\character::precachemodelarray(xmodelalias\alias_scientist_heads::main());
}