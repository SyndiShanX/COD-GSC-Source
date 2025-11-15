/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_pilot_c_red.gsc
***********************************************/

main() {
  self setModel("body_pilot_c_red");
  codescripts\character::attachhead("alias_pilot_heads_red", xmodelalias\alias_pilot_heads_red::main());
  self.voice = "american";
  self setclothtype("vestlight");
}

precache() {
  precachemodel("body_pilot_c_red");
  codescripts\character::precachemodelarray(xmodelalias\alias_pilot_heads_red::main());
}