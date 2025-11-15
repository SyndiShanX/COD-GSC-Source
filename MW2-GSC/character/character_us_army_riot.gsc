/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_us_army_riot.gsc
********************************************************/

main() {
  self setModel("body_us_army_riot");
  codescripts\character::attachHead("alias_us_army_riot", xmodelalias\alias_us_army_riot::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_us_army_riot");
  codescripts\character::precacheModelArray(xmodelalias\alias_us_army_riot::main());
}