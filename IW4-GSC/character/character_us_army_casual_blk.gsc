/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_us_army_casual_blk.gsc
********************************************************/

main() {
  self setModel("body_us_army_casual_a_blk");
  codescripts\character::attachHead("alias_us_army_heads_casual_blk", xmodelalias\alias_us_army_heads_casual_blk::main());
  self.voice = "american";
}

precache() {
  precacheModel("body_us_army_casual_a_blk");
  codescripts\character::precacheModelArray(xmodelalias\alias_us_army_heads_casual_blk::main());
}