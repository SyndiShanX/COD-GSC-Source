/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\mp_character_opforce_hench_lmg_a.gsc
**********************************************************/

main() {
  self setModel("mp_body_henchmen_lmg_a");
  codescripts\character::attachhead("alias_henchmen_heads_mp", xmodelalias\alias_henchmen_heads_mp::main());
  self setviewmodel("viewhands_henchmen");
  self.voice = "russian";
}

precache() {
  precachemodel("mp_body_henchmen_lmg_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_henchmen_heads_mp::main());
  precachemodel("viewhands_henchmen");
}