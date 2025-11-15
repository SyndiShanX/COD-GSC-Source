/**************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_urban_fem_a_drone.gsc
**************************************************************/

main() {
  self setModel("body_urban_civ_female_a_drone");
  codescripts\character::attachHead("alias_civilian_urban_heads_fem_drone", xmodelalias\alias_civilian_urban_heads_fem_drone::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_urban_civ_female_a_drone");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_urban_heads_fem_drone::main());
}