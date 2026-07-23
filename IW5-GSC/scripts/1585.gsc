/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1585.gsc
**************************************/

main() {
  self setModel("body_russian_military_assault_a");
  codescripts\character::attachhead("alias_russian_military_manhattan_heads", _id_0630::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_russian_military_assault_a");
  codescripts\character::precachemodelarray(_id_0630::main());
}