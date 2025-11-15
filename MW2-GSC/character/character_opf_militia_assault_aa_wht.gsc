/**************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_opf_militia_assault_aa_wht.gsc
**************************************************************/

main() {
  self setModel("body_militia_assault_aa_wht");
  codescripts\character::attachHead("alias_opforce_militia_heads_wht", xmodelalias\alias_opforce_militia_heads_wht::main());
  self.voice = "portuguese";
}

precache() {
  precacheModel("body_militia_assault_aa_wht");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_militia_heads_wht::main());
}