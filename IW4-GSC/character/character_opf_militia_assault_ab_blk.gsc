/**************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_opf_militia_assault_ab_blk.gsc
**************************************************************/

main() {
  self setModel("body_militia_assault_ab_blk");
  codescripts\character::attachHead("alias_opforce_militia_heads_blk", xmodelalias\alias_opforce_militia_heads_blk::main());
  if(issubstr(self.headModel, "hat")) {
    self.hatModel = "hat_militia_bb_blk";
    self attach(self.hatModel);
  }
  self.voice = "portuguese";
}

precache() {
  precacheModel("body_militia_assault_ab_blk");
  codescripts\character::precacheModelArray(xmodelalias\alias_opforce_militia_heads_blk::main());
  precacheModel("hat_militia_bb_blk");
}