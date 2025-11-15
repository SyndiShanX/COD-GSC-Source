/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_us_rangers_assault_a.gsc
********************************************************/

main() {
  self setModel("body_us_rangers_assault_a");
  codescripts\character::attachhead("alias_us_rangers_heads_a", xmodelalias\alias_us_rangers_heads_a::main());
  self.voice = "american";
  self setclothtype("vestheavy");
}

precache() {
  precachemodel("body_us_rangers_assault_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_us_rangers_heads_a::main());
}