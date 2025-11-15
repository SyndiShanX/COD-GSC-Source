/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_basic_smg_a.gsc
***************************************************/

main() {
  self setModel("body_fed_basic_smg_a");
  codescripts\character::attachhead("alias_fed_basic_heads", xmodelalias\alias_fed_basic_heads::main());
  self.voice = "shadowcompany";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_fed_basic_smg_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_basic_heads::main());
}