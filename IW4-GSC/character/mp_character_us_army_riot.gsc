/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_us_army_riot.gsc
********************************************************/

main() {
  self setModel("mp_body_us_army_riot");
  codescripts\character::attachHead("alias_us_army_riot", xmodelalias\alias_us_army_riot::main());
  self setViewmodel("viewhands_us_army");
  self.voice = "american";
}

precache() {
  precacheModel("mp_body_us_army_riot");
  codescripts\character::precacheModelArray(xmodelalias\alias_us_army_riot::main());
  precacheModel("viewhands_us_army");
}