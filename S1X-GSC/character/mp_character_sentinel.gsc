/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: character\mp_character_sentinel.gsc
***************************************************/

main() {
  self setModel("mp_sentinel_body_nojet_b");
  codescripts\character::attachHead("alias_mp_sentinel_heads", xmodelalias\alias_mp_sentinel_heads::main());
  self setViewmodel("viewhands_s1_pmc");
  self.voice = "american";
  self SetClothType("vestlight");
}

precache() {
  precacheModel("mp_sentinel_body_nojet_b");
  codescripts\character::precacheModelArray(xmodelalias\alias_mp_sentinel_heads::main());
  precacheModel("viewhands_s1_pmc");
}