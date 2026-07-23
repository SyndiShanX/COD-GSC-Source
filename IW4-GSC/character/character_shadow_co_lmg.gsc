/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_shadow_co_lmg.gsc
********************************************************/

main() {
  self setModel("body_shadow_co_lmg");
  codescripts\character::attachHead("alias_shad_co_heads", xmodelalias\alias_shad_co_heads::main());
  self.voice = "shadowcompany";
}

precache() {
  precacheModel("body_shadow_co_lmg");
  codescripts\character::precacheModelArray(xmodelalias\alias_shad_co_heads::main());
}