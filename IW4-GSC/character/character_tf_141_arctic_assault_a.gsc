/***********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_tf_141_arctic_assault_a.gsc
***********************************************************/

main() {
  self setModel("body_tf141_assault_a");
  codescripts\character::attachHead("alias_tf141_heads_arctic", xmodelalias\alias_tf141_heads_arctic::main());
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_tf141_assault_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_tf141_heads_arctic::main());
}