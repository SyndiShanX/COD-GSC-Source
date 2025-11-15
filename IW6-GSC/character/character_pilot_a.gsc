/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_pilot_a.gsc
*******************************************/

main() {
  self setModel("body_pilot_a");
  codescripts\character::attachhead("alias_pilot_heads", xmodelalias\alias_pilot_heads::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_pilot_a");
  codescripts\character::precachemodelarray(xmodelalias\alias_pilot_heads::main());
}