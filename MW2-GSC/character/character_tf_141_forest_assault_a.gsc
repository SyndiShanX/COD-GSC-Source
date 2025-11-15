/***********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_tf_141_forest_assault_a.gsc
***********************************************************/

main() {
  self setModel("body_forest_tf141_assault_a");
  codescripts\character::attachHead("alias_tf141_heads_forest", xmodelalias\alias_tf141_heads_forest::main());
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_forest_tf141_assault_a");
  codescripts\character::precacheModelArray(xmodelalias\alias_tf141_heads_forest::main());
}