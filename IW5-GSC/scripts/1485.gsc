/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1485.gsc
**************************************/

main() {
  self setModel("body_chemwar_russian_assault_b");
  codescripts\character::attachhead("alias_chemwar_russian_heads_masked", _id_05CB::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_chemwar_russian_assault_b");
  codescripts\character::precachemodelarray(_id_05CB::main());
}