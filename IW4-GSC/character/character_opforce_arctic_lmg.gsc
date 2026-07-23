/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_opforce_arctic_lmg.gsc
********************************************************/

main() {
  self setModel("body_opforce_arctic_lmg");
  codescripts\character::attachHead("alias_opforce_arctic_heads", xmodelalias\alias_opforce_arctic_heads::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_opforce_arctic_lmg");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_arctic_heads::main());
}