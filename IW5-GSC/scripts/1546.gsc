/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1546.gsc
**************************************/

main() {
  self setModel("body_gign_paris_assault");
  codescripts\character::attachhead("alias_gign_heads", xmodelalias\alias_gign_heads::main());
  self.voice = "french";
}

precache() {
  precachemodel("body_gign_paris_assault");
  codescripts\character::precachemodelarray(xmodelalias\alias_gign_heads::main());
}