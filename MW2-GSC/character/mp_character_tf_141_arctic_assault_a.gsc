/**************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\mp_character_tf_141_arctic_assault_a.gsc
**************************************************************/

main() {
  self setModel("mp_body_tf141_assault_a");
  codescripts\character::attachHead("alias_tf141_heads_arctic", xmodelalias\alias_tf141_heads_arctic::main());
  self setViewmodel("viewhands_tf141");
  self.voice = "taskforce";
}

precache() {
  precacheModel("mp_body_tf141_assault_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_tf141_heads_arctic::main());
  precacheModel("viewhands_tf141");
}