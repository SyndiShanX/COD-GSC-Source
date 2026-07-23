/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_airborne_assault_c.gsc
********************************************************/

main() {
  self setModel("body_airborne_assault_c");
  codescripts\character::attachHead("alias_airborne_heads", xmodelalias\alias_airborne_heads::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_airborne_assault_c");
  codescripts\character::precacheModelArray(xmodelalias\alias_airborne_heads::main());
}