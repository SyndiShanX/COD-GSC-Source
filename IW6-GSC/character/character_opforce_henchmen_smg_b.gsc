/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_opforce_henchmen_smg_b.gsc
**********************************************************/

main() {
  self setModel("body_henchmen_smg_b");
  codescripts\character::attachhead("alias_henchmen_heads", xmodelalias\alias_henchmen_heads::main());
  self.voice = "russian";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_henchmen_smg_b");
  codescripts\character::precachemodelarray(xmodelalias\alias_henchmen_heads::main());
}