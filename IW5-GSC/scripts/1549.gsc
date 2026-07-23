/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1549.gsc
**************************************/

main() {
  self setModel("body_delta_elite_assault_ba");
  codescripts\character::attachhead("alias_delta_elite_heads", xmodelalias\alias_delta_elite_heads::main());
  self.voice = "delta";
}

precache() {
  precachemodel("body_delta_elite_assault_ba");
  codescripts\character::precachemodelarray(xmodelalias\alias_delta_elite_heads::main());
}