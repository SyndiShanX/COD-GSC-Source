/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_media_udt_dive.gsc
********************************************************/

main() {
  self setModel("body_seal_udt_dive_a");
  codescripts\character::attachHead("alias_seal_udt_heads_dive", xmodelalias\alias_seal_udt_heads_dive::main());
  self.voice = "seal";
}

precache() {
  precacheModel("body_seal_udt_dive_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_seal_udt_heads_dive::main());
}