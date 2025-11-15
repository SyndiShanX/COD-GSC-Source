/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_space_int_c.gsc
**************************************************/

main() {
  self setModel("body_us_space_int_c");
  codescripts\character::attachhead("alias_us_space_int_heads", xmodelalias\alias_us_space_int_heads::main());
  self.voice = "american";
  self setclothtype("cloth");
}

precache() {
  precachemodel("body_us_space_int_c");
  codescripts\character::precachemodelarray(xmodelalias\alias_us_space_int_heads::main());
}