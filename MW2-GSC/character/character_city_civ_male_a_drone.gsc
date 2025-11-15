/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_city_civ_male_a_drone.gsc
*********************************************************/

main() {
  self setModel("body_city_civ_male_a_drone");
  codescripts\character::attachHead("alias_civilian_urban_heads_wht_drone", xmodelalias\alias_civilian_urban_heads_wht_drone::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_city_civ_male_a_drone");
  codescripts\character::precacheModelArray(xmodelalias\alias_civilian_urban_heads_wht_drone::main());
}