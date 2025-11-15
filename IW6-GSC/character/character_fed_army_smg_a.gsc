/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_army_smg_a.gsc
**************************************************/

main() {
  self setModel("body_fed_army_smg_a");
  codescripts\character::attachhead("alias_fed_army_heads_a", xmodelalias\alias_fed_army_heads_a::main());
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_fed_army_smg_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_army_heads_a::main());
}