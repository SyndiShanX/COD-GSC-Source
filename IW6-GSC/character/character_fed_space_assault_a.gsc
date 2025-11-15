/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_fed_space_assault_a.gsc
*******************************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias\alias_fed_space_assualt_bodies::main());
  codescripts\character::attachhead("alias_fed_space_assault_heads", xmodelalias\alias_fed_space_assault_heads::main());
  self.voice = "russian";
  self setclothtype("vestlight");
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_space_assualt_bodies::main());
  codescripts\character::precachemodelarray(xmodelalias\alias_fed_space_assault_heads::main());
}