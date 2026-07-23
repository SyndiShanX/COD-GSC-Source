/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1585.gsc
**************************************/

main() {
  self setModel("body_russian_military_assault_a");
  codescripts\character::attachhead("alias_russian_military_manhattan_heads", xmodelalias/alias_russian_military_manhattan_heads::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_russian_military_assault_a");
  codescripts\character::precachemodelarray(xmodelalias/alias_russian_military_manhattan_heads::main());
}