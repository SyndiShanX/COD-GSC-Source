/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_city_civ_male_a.gsc
********************************************************/

main() {
  self setModel("body_city_civ_male_a");
  codescripts\character::attachHead("alias_city_civ_male_heads", xmodelalias\alias_city_civ_male_heads::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_city_civ_male_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_city_civ_male_heads::main());
}