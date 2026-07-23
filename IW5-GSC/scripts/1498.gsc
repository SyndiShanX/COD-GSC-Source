/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1498.gsc
**************************************/

main() {
  self setModel("body_chemwar_russian_assault_d");
  codescripts\character::attachhead("alias_chemwar_russian_heads_so", _id_05D9::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_chemwar_russian_assault_d");
  codescripts\character::precachemodelarray(_id_05D9::main());
}