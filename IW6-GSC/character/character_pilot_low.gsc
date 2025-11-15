/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_pilot_low.gsc
*********************************************/

main() {
  self setModel("body_pilot_low");
  codescripts\character::attachhead("alias_pilot_heads", xmodelalias\alias_pilot_heads::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_pilot_low");
  codescripts\character::precachemodelarray(xmodelalias\alias_pilot_heads::main());
}