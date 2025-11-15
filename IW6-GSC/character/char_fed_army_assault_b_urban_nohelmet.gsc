/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\char_fed_army_assault_b_urban_nohelmet.gsc
****************************************************************/

main() {
  self setModel("body_fed_army_assault_b_urban");
  codescripts\character::attachhead("alias_fed_army_heads_a_urban_NoShield", xmodelalias\alias_fed_army_heads_a_urban_noshield::main());
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_fed_army_assault_b_urban");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_army_heads_a_urban_noshield::main());
}