/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_space_assault_a.gsc
******************************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias\alias_us_space_assault_bodies::main());
  codescripts\character::attachhead("alias_us_space_assault_heads", xmodelalias\alias_us_space_assault_heads::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias\alias_us_space_assault_bodies::main());
  codescripts\character::precachemodelarray(xmodelalias\alias_us_space_assault_heads::main());
}