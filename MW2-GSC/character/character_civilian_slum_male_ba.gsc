/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_slum_male_ba.gsc
*********************************************************/

main() {
  self setModel("body_slum_civ_male_ba");
  codescripts\character::attachHead("alias_civilian_slum_heads", xmodelalias\alias_civilian_slum_heads::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_slum_civ_male_ba");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_slum_heads::main());
}