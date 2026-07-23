/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1486.gsc
**************************************/

main() {
  self setModel("body_chemwar_russian_assault_c");
  codescripts\character::attachhead("alias_chemwar_russian_heads_masked", xmodelalias/alias_chemwar_russian_heads_masked::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_chemwar_russian_assault_c");
  codescripts\character::precachemodelarray(xmodelalias/alias_chemwar_russian_heads_masked::main());
}