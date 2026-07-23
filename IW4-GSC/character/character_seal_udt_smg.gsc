/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_seal_udt_smg.gsc
********************************************************/

main() {
  self setModel("body_seal_udt_smg");
  codescripts\character::attachHead("alias_seal_udt_heads", xmodelalias\alias_seal_udt_heads::main());
  self.voice = "seal";
}

precache() {
  precacheModel("body_seal_udt_smg");
  codescripts\character::precacheModelArray(xmodelalias\alias_seal_udt_heads::main());
}