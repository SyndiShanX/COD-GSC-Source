/*************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_militia_shotgun_aa_wht.gsc
*************************************************************/

main() {
  self setModel("mp_body_militia_smg_aa_wht");
  codescripts\character::attachHead("alias_opforce_militia_heads_wht", xmodelalias\alias_opforce_militia_heads_wht::main());
  self setViewmodel("viewhands_militia");
  self.voice = "portuguese";
}

precache() {
  precacheModel("mp_body_militia_smg_aa_wht");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_militia_heads_wht::main());
  precacheModel("viewhands_militia");
}