/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_chemwar_russian_assault_ee.gsc
**************************************************************/

main() {
  self setModel("body_chemwar_russian_assault_ee");
  codescripts\character::attachhead("alias_chemwar_russian_heads", xmodelalias\alias_chemwar_russian_heads::main());
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_chemwar_russian_assault_ee");
  codescripts\character::precachemodelarray(xmodelalias\alias_chemwar_russian_heads::main());
}