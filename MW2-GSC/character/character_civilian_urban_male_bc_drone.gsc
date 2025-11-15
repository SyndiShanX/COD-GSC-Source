/****************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_civilian_urban_male_bc_drone.gsc
****************************************************************/

main() {
  self setModel("body_urban_civ_male_bc_drone");
  codescripts\character::attachHead("alias_civilian_urban_heads_wht_drone", xmodelalias\alias_civilian_urban_heads_wht_drone::main());
  self.voice = "russian";
}

precache() {
  precacheModel("body_urban_civ_male_bc_drone");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_urban_heads_wht_drone::main());
}