/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_army_assault_b_nohelmet.gsc
***************************************************************/

main() {
  self setModel("body_fed_army_assault_b");
  codescripts\character::attachhead("alias_fed_army_heads_a_NoFaceShield", xmodelalias\alias_fed_army_heads_a_nofaceshield::main());
  self.voice = "russian";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_fed_army_assault_b");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_army_heads_a_nofaceshield::main());
}