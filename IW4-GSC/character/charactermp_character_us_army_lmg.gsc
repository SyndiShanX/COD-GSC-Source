/***********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\charactermp_character_us_army_lmg.gsc
***********************************************************/

main() {
  self setModel("mp_body_us_army_lmg");
  codescripts\character::attachHead("alias_us_army_heads", xmodelalias\alias_us_army_heads::main());
  self setViewmodel("viewhands_us_army");
  self.voice = "american";
}

precache() {
  precacheModel("mp_body_us_army_lmg");
  codescripts\character::precacheModelArray(xmodelalias\alias_us_army_heads::main());
  precacheModel("viewhands_us_army");
}