/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_airborne_assault_b.gsc
*********************************************************/

main() {
  self setModel("mp_body_airborne_assault_b");
  codescripts\character::attachHead("alias_airborne_heads", xmodelalias\alias_airborne_heads::main());
  self setViewmodel("viewhands_russian_airborne");
  self.voice = "russian";
}

precache() {
  precacheModel("mp_body_airborne_assault_b");
  codescripts\character::precacheModelArray(xmodelalias\alias_airborne_heads::main());
  precacheModel("viewhands_russian_airborne");
}