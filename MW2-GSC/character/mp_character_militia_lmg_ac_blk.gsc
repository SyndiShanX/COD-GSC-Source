/*********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_militia_lmg_ac_blk.gsc
*********************************************************/

main() {
  self setModel("mp_body_militia_lmg_ac_blk");
  codescripts\character::attachHead("alias_opforce_militia_heads_blk", xmodelalias\alias_opforce_militia_heads_blk::main());
  self setViewmodel("viewhands_militia");
  self.voice = "portuguese";
}

precache() {
  precacheModel("mp_body_militia_lmg_ac_blk");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_militia_heads_blk::main());
  precacheModel("viewhands_militia");
}