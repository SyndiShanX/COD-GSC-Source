/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_opforce_arab_unarmed_a.gsc
**********************************************************/

main() {
  self setModel("body_opforce_arab_unarmed_a");
  codescripts\character::attachHead("alias_opforce_arab_heads", xmodelalias\alias_opforce_arab_heads::main());
  self.voice = "arab";
}

precache() {
  precacheModel("body_opforce_arab_unarmed_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_arab_heads::main());
}