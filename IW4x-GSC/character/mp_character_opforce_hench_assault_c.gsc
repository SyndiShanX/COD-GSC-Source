/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_opforce_hench_assault_c.gsc
**************************************************************/

main() {
  self setModel("mp_body_henchmen_assault_c");
  codescripts\character::attachhead("alias_henchmen_heads_mp", xmodelalias\alias_henchmen_heads_mp::main());
  self setviewmodel("viewhands_henchmen");
  self.voice = "russian";
}

precache() {
  precachemodel("mp_body_henchmen_assault_c");
  codescripts\character::precachemodelarray(xmodelalias\alias_henchmen_heads_mp::main());
  precachemodel("viewhands_henchmen");
}