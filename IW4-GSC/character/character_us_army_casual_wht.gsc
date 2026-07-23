/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_us_army_casual_wht.gsc
********************************************************/

main() {
  self setModel("body_us_army_casual_a_wht");
  codescripts\character::attachHead("alias_us_army_heads_casual_wht", xmodelalias\alias_us_army_heads_casual_wht::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_us_army_casual_a_wht");
  codescripts\character::precacheModelArray(xmodelalias\alias_us_army_heads_casual_wht::main());
}