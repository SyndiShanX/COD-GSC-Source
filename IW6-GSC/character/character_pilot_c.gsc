/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_pilot_c.gsc
*******************************************/

main() {
  self setModel("body_pilot_c");
  codescripts\character::attachhead("alias_pilot_heads_yellow", xmodelalias\alias_pilot_heads_yellow::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_pilot_c");
  codescripts\character::precachemodelarray(xmodelalias\alias_pilot_heads_yellow::main());
}