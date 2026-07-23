/**************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_urban_male_ac_wht.gsc
**************************************************************/

main() {
  self setModel("body_urban_civ_male_ac");
  codescripts\character::attachHead("alias_civilian_urban_heads_wht", xmodelalias\alias_civilian_urban_heads_wht::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_urban_civ_male_ac");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_urban_heads_wht::main());
}