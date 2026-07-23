/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_composite_lmg.gsc
********************************************************/

main() {
  self setModel("mp_body_opforce_arab_lmg_a");
  codescripts\character::attachHead("alias_opforce_arab_heads", xmodelalias\alias_opforce_arab_heads::main());
  self setViewmodel("viewhands_militia");
  self.voice = "arab";
}

precache() {
  precacheModel("mp_body_opforce_arab_lmg_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_arab_heads::main());
  precacheModel("viewhands_militia");
}