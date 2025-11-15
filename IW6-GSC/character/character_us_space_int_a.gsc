/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_space_int_a.gsc
**************************************************/

main() {
  self setModel("body_us_space_int_a");
  codescripts\character::attachhead("alias_us_space_int_heads", xmodelalias\alias_us_space_int_heads::main());
  self.voice = "american";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_us_space_int_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_us_space_int_heads::main());
}