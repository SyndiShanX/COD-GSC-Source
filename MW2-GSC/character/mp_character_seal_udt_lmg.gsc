/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_seal_udt_lmg.gsc
********************************************************/

main() {
  self setModel("mp_body_seal_udt_lmg");
  codescripts\character::attachHead("alias_seal_udt_heads", xmodelalias\alias_seal_udt_heads::main());
  self setViewmodel("viewhands_udt");
  self.voice = "seal";
}

precache() {
  precacheModel("mp_body_seal_udt_lmg");
  codescripts\character::precacheModelArray(xmodelalias\alias_seal_udt_heads::main());
  precacheModel("viewhands_udt");
}