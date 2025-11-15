/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_army_lmg_a_arctic.gsc
*********************************************************/

main() {
  self setModel("body_fed_army_lmg_a_arctic");
  codescripts\character::attachhead("alias_fed_army_heads_a_arctic_NoShield", xmodelalias\alias_fed_army_heads_a_arctic_noshield::main());
  self.voice = "russian";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_fed_army_lmg_a_arctic");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_army_heads_a_arctic_noshield::main());
}