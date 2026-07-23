/***********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_urban_female_b.gsc
***********************************************************/

main() {
  self setModel("body_urban_civ_female_b");
  codescripts\character::attachHead("alias_civilian_urban_heads_female", xmodelalias\alias_civilian_urban_heads_female::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_urban_civ_female_b");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_urban_heads_female::main());
}