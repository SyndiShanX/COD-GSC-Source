/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1491.gsc
**************************************/

main() {
  self setModel("body_chemwar_russian_assault_cc");
  codescripts\character::attachhead("alias_chemwar_russian_heads_masked", _id_05CB::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_chemwar_russian_assault_cc");
  codescripts\character::precachemodelarray(_id_05CB::main());
}