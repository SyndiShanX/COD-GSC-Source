/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_us_army_assault_a.gsc
********************************************************/

main() {
  self setModel("body_us_army_assault_a");
  codescripts\character::attachHead("alias_us_army_heads", xmodelalias\alias_us_army_heads::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_us_army_assault_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_us_army_heads::main());
}