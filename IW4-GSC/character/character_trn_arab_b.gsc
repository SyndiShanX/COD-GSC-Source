/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_trn_arab_b.gsc
********************************************************/

main() {
  self setModel("body_ally_arab_trn_smg_a");
  codescripts\character::attachHead("alias_trn_arab_heads", xmodelalias\alias_trn_arab_heads::main());
  self.voice = "arab";
}

precache() {
  precacheModel("body_ally_arab_trn_smg_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_trn_arab_heads::main());
}