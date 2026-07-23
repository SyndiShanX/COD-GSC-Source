/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_airborne_assault_a.gsc
********************************************************/

main() {
  self setModel("body_airborne_assault_a");
  codescripts\character::attachHead("alias_airborne_heads", xmodelalias\alias_airborne_heads::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_airborne_assault_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_airborne_heads::main());
}